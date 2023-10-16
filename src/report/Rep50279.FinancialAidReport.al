report 50279 "Financial Aid Reports"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Student GPA Calculation';
    ApplicationArea = All;
    // RDLCLayout = './src/reportrdlc/FinancialAidReport.rdl';
    // DefaultLayout = RDLC;
    // PreviewMode = PrintLayout;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")

        {
            RequestFilterFields = "Original Student No.";
            DataItemTableView = sorting("Original Student No.") order(ascending) Where("Original Student No." = filter(<> ''), "Global dimension 1 code" = const('9000'));

            DataItem("Main Student Subject-CS"; "Main Student Subject-CS")
            {
                DataItemTableView = Where(Grade = filter(<> '' & <> 'X' & <> 'M' & <> 'UC' & <> 'SC'), "Category-Course Description" = filter(<> ''));
                DataItemLink = "Original Student No." = Field("Original Student No."), "Global Dimension 1 Code" = field("Global Dimension 1 Code");
                trigger OnPreDataItem()
                begin
                    IF TranscriptFilter then begin
                        "Main Student Subject-CS".SetFilter(Course, CourseFilter);
                    end else begin
                        "Main Student Subject-CS".SetRange(Course, "Student Master-CS"."Course Code");
                    end;
                    CreditAttempt_gDec := 0;
                    QualityPoints_gDec := 0;
                    GPACredits_gDec := 0;
                    GPA_gDec := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    GradeMaster_gRec.Reset();
                    GradeMaster_gRec.SetRange(Code, "Main Student Subject-CS".Grade);
                    GradeMaster_gRec.SetRange("Global Dimension 1 Code", "Main Student Subject-CS"."Global Dimension 1 Code");
                    If GradeMaster_gRec.FindFirst() then begin
                        if GradeMaster_gRec."Grade Points" <> 0 then begin
                            QualityPoints_gDec += "Main Student Subject-CS"."Credits Attempt" * GradeMaster_gRec."Grade Points";
                        end;
                        IF (GradeMaster_gRec."Consider for GPA") and ("Main Student Subject-CS".TC = false) then begin
                            GPACredits_gDec += "Main Student Subject-CS"."Credits Attempt";
                        end;
                    end;
                    CreditAttempt_gDec += "Main Student Subject-CS"."Credits Attempt";
                end;

                trigger OnPostDataItem()
                begin
                    if OriginalStudentNo <> "Student Master-CS"."Original Student No." then begin
                        TempTable_gRec.Reset();
                        IF TempTable_gRec.FindLast() then
                            EntryNo := TempTable_gRec."Entry No" + 1
                        Else
                            EntryNo := 1;

                        TempTable_gRec.Init();
                        TempTable_gRec."Entry No" := EntryNo;
                        TempTable_gRec."Student ID" := "Student Master-CS"."Original Student No.";
                        TempTable_gRec.Field11 := "Student Master-CS"."Student Name";
                        TempTable_gRec.Field12 := "Student Master-CS"."E-Mail Address";
                        TempTable_gRec.Field21 := CreditAttempt_gDec;
                        TempTable_gRec.Field22 := GPACredits_gDec;
                        IF GPACredits_gDec <> 0 then
                            TempTable_gRec.Field23 := Round(QualityPoints_gDec / GPACredits_gDec)
                        else
                            TempTable_gRec.Field23 := 0;
                        TempTable_gRec.Field24 := QualityPoints_gDec;
                        TempTable_gRec."Unique ID" := UserId();
                        TempTable_gRec."Institute Code" := "Student Master-CS"."Global Dimension 1 Code";
                        TempTable_gRec."Bill Discription" := format("Student Master-CS".Term);
                        TempTable_gRec."Doc. No." := "Student Master-CS"."Academic Year";
                        TempTable_gRec.Semester := "Student Master-CS".Semester;
                        TempTable_gRec.Insert();
                    end;
                    OriginalStudentNo := "Student Master-CS"."Original Student No.";

                end;
            }
            trigger OnPreDataItem()
            begin
                TotCtr := "Student Master-CS".Count();
                OriginalStudentNo := '';
            end;

            trigger OnAfterGetRecord()
            begin
                studentmaster.reset();
                studentmaster.setrange("Enrollment No.", "Enrollment No.");
                studentmaster.setfilter(Status, '%1|%2|%3', 'BP', 'DEF', 'DCL');
                if studentmaster.FindFirst() then
                    CurrReport.Skip();

                TranscriptFilter := false;
                studentmaster.reset();
                studentmaster.setrange("Original Student No.", "Original Student No.");
                studentmaster.setfilter("Course Code", CourseFilter);
                if studentmaster.FindFirst() then
                    TranscriptFilter := true
                else
                    CurrReport.Skip();

                // TranscriptFilter := false;
                // CourseMaster_gRec.Reset();
                // CourseMaster_gRec.SetRange(Code, "Student Master-CS"."Course Code");
                // IF CourseMaster_gRec.FindFirst() then
                //     IF CourseMaster_gRec."Financial AID Applicable" then
                //        TranscriptFilter := true;

                Ctr += 1;
                WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr) + ' of ' + format(TotCtr));
            end;

            trigger OnPostDataItem()
            begin

            end;
        }

    }
    var
        CourseMaster_gRec: Record "Course Master-CS";
        StudentSubject_gRec: Record "Main Student Subject-CS";
        GradeMaster_gRec: Record "Grade Master-CS";
        studentmaster: Record "Student Master-CS";

        TempTable_gRec: Record "Temp Record" temporary;
        Grade_gTxt: Text;
        CreditAttempt_gDec: Decimal;
        GPACredits_gDec: Decimal;
        GPA_gDec: Decimal;
        TranscriptFilter: Boolean;
        TranscriptFilter1: Boolean;
        CourseFilter: Text;
        OriginalStudentNo: Text;
        GD: Text;
        QualityPoints_gDec: Decimal;
        EntryNo: Integer;

        TotCtr: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        Ctr: Integer;

    trigger OnPreReport()
    begin
        TempTable_gRec.Reset();
        TempTable_gRec.DeleteAll();

        WindowDialog.Open('Fetching Data....\' + Text001Lbl);

        CourseFilter := '';
        CourseMaster_gRec.Reset();
        CourseMaster_gRec.SetRange("Financial AID Applicable", true);
        IF CourseMaster_gRec.FindSet() then begin
            repeat
                IF CourseFilter = '' then
                    CourseFilter := CourseMaster_gRec.Code
                Else
                    CourseFilter += '|' + CourseMaster_gRec.Code;
            until CourseMaster_gRec.Next() = 0;
        end;
    end;

    trigger OnPostReport()
    begin
        WindowDialog.Close();
        TempTable_gRec.Reset();
        TempTable_gRec.SetRange("Unique ID", UserId());
        if TempTable_gRec.FindFirst() then
            page.Run(61004, TempTable_gRec);

    end;

}