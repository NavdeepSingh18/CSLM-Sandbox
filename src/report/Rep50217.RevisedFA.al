report 50217 "Revised FA Report"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Caption = 'Revised FA Report';

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = where("Course Code" = Filter('AUACOM | AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|SEMCOM|SEMCOM2|STDPROG|TRICOM'), Status = filter('<>DCL' & '<>DEF' & '<>GRAD'));
            RequestFilterFields = "Course Code", Semester, "Academic Year", Status;
            trigger OnPreDataItem()
            var
            begin
                SetCurrentKey("Original Student No.", "Enrollment Order");
                Ascending(False);

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn('Student Number', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LastName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('School Status', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Semester', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Registered', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Intent To Pay', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Received FAFSA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('In SFP', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Last Date of SAFI sent', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('AR Balance', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Award #1 Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Award #2 Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Award #3 Amount', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Previous FA Pmts', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CourseID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Course', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Start Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('End Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LDA', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Current FA Pmts', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                totalcount := "Student Master-CS".Count();
                if GuiAllowed then
                    WindowDialog.Open('Fetching Data....\' + Text001Lbl);
            end;

            trigger OnAfterGetRecord()
            var
                StudentSubjectExam: Record "Student Subject Exam";
                StudentSubjectExam1: Record "Student Subject Exam";
                RecCustPostGroup: Record "Customer Posting Group";
                StudentSubj: record "Main Student Subject-CS";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                CourseSemMasterCs: Record "Course Sem. Master-CS";
                CustLedgerEntry1: Record "Cust. Ledger Entry";
                Customer_lRec: Record Customer;
                CustomerPostingGroup: Record "Customer Posting Group";
                GLEntry_lRec: Record "G/L Entry";
                SemesterMasterCS1: Record "Semester Master-CS";
                CourseMasterCs: Record "Course Master-CS";
                StudentMaster_lRec: Record "Student Master-CS";
                SourceScholarShip: Record "Source Scholarship-CS";
                i: Integer;
                ArAmount: Decimal;
                CurrBilAmt: Decimal;
                ScholarAmt: Decimal;
                GrantAmt: array[50] of Decimal;
                OriginalStudentID: Code[20];
                Amt_lDec: array[50] of Decimal;
                PrevAcademicYear: Code[20];
                PrevAcademicYearInt: Integer;
                PrevTerm: Option FALL,SPRING,SUMMER;
                FASEmester: Text;
                EnrollmentNoFilter: Text;
                CourseFilter: Text;
                ScholarShipFilter: Text;
                GrandCodeFilter: Text;
                GrandCodeFilter1: Text;
                IntentToPay: Text;

            begin
                If ORiginalStudentNo <> "Student Master-CS"."Original Student No." then begin
                    CourseFilter := '';
                    CourseFilter := 'AUACOM | AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|SEMCOM|SEMCOM2|STDPROG|TRICOM';
                    EnrollmentNoFilter := '';
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetCurrentKey("Enrollment Order");
                    StudentMaster_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMaster_lRec.SetFilter("Course Code", CourseFilter);
                    IF StudentMaster_lRec.FindSet() then begin
                        repeat
                            If EnrollmentNoFilter = '' then
                                EnrollmentNoFilter := StudentMaster_lRec."Enrollment No."
                            Else
                                EnrollmentNoFilter += '|' + StudentMaster_lRec."Enrollment No.";
                        until StudentMaster_lRec.Next() = 0;
                    end;

                    ScholarShipFilter := '';
                    SourceScholarShip.Reset();
                    SourceScholarShip.SetRange("Discount Type", SourceScholarShip."Discount Type"::Scholarship);
                    SourceScholarShip.SetRange("Global Dimension 1 Code", '9000');
                    If SourceScholarShip.FindSet() then begin
                        repeat
                            If ScholarShipFilter = '' then
                                ScholarShipFilter := SourceScholarShip.Code
                            Else
                                ScholarShipFilter += '|' + SourceScholarShip.Code;
                        until SourceScholarShip.Next() = 0;
                    end;

                    GrandCodeFilter := '';
                    SourceScholarShip.Reset();
                    SourceScholarShip.SetRange("Discount Type", SourceScholarShip."Discount Type"::Grant);
                    SourceScholarShip.SetRange("Global Dimension 1 Code", '9000');
                    If SourceScholarShip.FindSet() then begin
                        repeat
                            If GrandCodeFilter = '' then
                                GrandCodeFilter := SourceScholarShip.Code
                            Else
                                GrandCodeFilter += '|' + SourceScholarShip.Code;
                        until SourceScholarShip.Next() = 0;
                    end;

                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."Last Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."First Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."On Ground Check-In Complete On", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::date);

                    IntentToPay := '';
                    If "Student Master-CS"."Payment Plan Applied" then
                        IntentToPay := "Student Master-CS".FieldCaption("Payment Plan Applied");
                    IF "Student Master-CS"."Financial Aid Approved" then
                        IntentToPay += ', ' + "Student Master-CS".FieldCaption("Financial Aid Approved");
                    If "Student Master-CS"."Applied For Scholarship" then
                        IntentToPay += ', ' + "Student Master-CS".FieldCaption("Applied For Scholarship");
                    If "Student Master-CS"."Self-Pay Applied" then
                        IntentToPay += ', ' + "Student Master-CS".FieldCaption("Self-Pay Applied");
                    If "Student Master-CS"."VA Benefit" then
                        IntentToPay += ', ' + "Student Master-CS".FieldCaption("VA Benefit");
                    TempExcelBuffer.AddColumn(IntentToPay, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    TempExcelBuffer.AddColumn("Student Master-CS"."FAFSA Received", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    IF "Student Master-CS"."Student SFP Initiation" = 0 Then
                        TempExcelBuffer.AddColumn(FALSE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                    ELSE
                        TempExcelBuffer.AddColumn(TRUE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Student Master-CS"."Safi Sent", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);

                    Customer_lRec.Reset();
                    If Customer_lRec.get("Student Master-CS"."Original Student No.") then;
                    CustomerPostingGroup.Reset();
                    CustomerPostingGroup.SetRange(Code, Customer_lRec."Customer Posting Group");
                    If CustomerPostingGroup.FindFirst() then;

                    ArAmount := 0;
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Global Dimension 2 Code", Reversed, "Posting Date", "G/L Account No.");
                    // GLEntry_lRec.SetRange("Student No.", "Student Master-CS"."No.");
                    GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Global Dimension 2 Code", '');
                    GLEntry_lRec.SetRange(Reversed, false);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.Setrange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    GLEntry_lRec.CalcSums(Amount);
                    ArAmount := GLEntry_lRec.Amount;
                    TempExcelBuffer.AddColumn(ArAmount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

                    //AwardAmount #1
                    ScholarAmt := 0;
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Posting Date", "Waiver/Scholar/Grant Code");
                    // GLEntry_lRec.SetRange(GLEntry_lRec."Student No.", "No.");
                    GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.Setfilter("Waiver/Scholar/Grant Code", ScholarShipFilter);
                    GLEntry_lRec.SetRange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    GLEntry_lRec.CalcSums(Amount);
                    ScholarAmt := GLEntry_lRec.Amount;
                    TempExcelBuffer.AddColumn(FormaT(ScholarAmt), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);


                    Clear(GrantAmt);
                    GLEntry_lRec.Reset();
                    GLEntry_lRec.SetCurrentKey("Enrollment No.", "Posting Date", "Waiver/Scholar/Grant Code");
                    // GLEntry_lRec.SetRange(GLEntry_lRec."Student No.", "No.");
                    GLEntry_lRec.Setfilter("Enrollment No.", EnrollmentNoFilter);
                    GLEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry_lRec.SetFilter("Waiver/Scholar/Grant Code", GrandCodeFilter);
                    GLEntry_lRec.SetRange("G/L Account No.", CustomerPostingGroup."Receivables Account");
                    IF GLEntry_lRec.FindSet() then begin
                        repeat
                            i += 1;
                            If i <= 2 then
                                GrantAmt[i] := GLEntry_lRec.Amount;
                        Until GLEntry_lRec.Next() = 0;
                    end;

                    TempExcelBuffer.AddColumn(FormaT(GrantAmt[1]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(FormaT(GrantAmt[2]), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);


                    SemesterMasterCS1.Reset();
                    SemesterMasterCS1.SetRange(SemesterMasterCS1.Code, "Student Master-CS".Semester);
                    IF SemesterMasterCS1.FindFirst() then begin
                        CourseSemMasterCs.Reset();
                        CourseSemMasterCs.SetRange(CourseSemMasterCs."Course Code", "Student Master-CS"."Course Code");
                        CourseSemMasterCs.SetRange(CourseSemMasterCs."Sequence No", SemesterMasterCS1.Sequence - 1);
                        IF CourseSemMasterCs.FindFirst() then begin
                            CustLedgerEntry1.Reset();
                            CustLedgerEntry1.SetRange("Customer No.", "Student Master-CS"."Original Student No.");
                            CustLedgerEntry1.SetRange(Semester, CourseSemMasterCs."Semester Code");
                            IF CustLedgerEntry1.FindFirst() then begin
                                IF CustLedgerEntry1."Fund Type" <> CustLedgerEntry1."Fund Type"::" " then
                                    TempExcelBuffer.AddColumn(True, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                                else
                                    TempExcelBuffer.AddColumn(False, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                            end;
                            IF Not CustLedgerEntry1.FindFirst() then
                                TempExcelBuffer.AddColumn(False, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        end;
                        IF Not CourseSemMasterCs.FindFirst() then
                            TempExcelBuffer.AddColumn(False, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                        StudentSubj.Reset();
                        StudentSubj.SetRange("Student No.", "Student Master-CS"."No.");
                        StudentSubj.SetRange(Semester, "Student Master-CS".Semester);
                        StudentSubj.SetRange("Academic Year", "Student Master-CS"."Academic Year");
                        StudentSubj.SetRange(Term, "Student Master-CS".Term);
                        IF StudentSubj.FindFirst() THEN begin
                            TempExcelBuffer.AddColumn(StudentSubj."Subject Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(StudentSubj.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(StudentSubj."Start Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn(StudentSubj."End Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        end;
                        If not StudentSubj.FindFirst() then begin
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        end;
                        TempExcelBuffer.AddColumn("Student Master-CS".LDA, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                        CustLedgerEntry.SetRange(Semester, "Student Master-CS".Semester);
                        IF CustLedgerEntry.FindFirst() then begin
                            IF CustLedgerEntry."Fund Type" <> CustLedgerEntry."Fund Type"::" " then
                                TempExcelBuffer.AddColumn(True, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                            else
                                TempExcelBuffer.AddColumn(false, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                        end;
                        IF not CustLedgerEntry.FindFirst() then
                            TempExcelBuffer.AddColumn(False, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    end;
                    If Not SemesterMasterCS1.FindFirst() then begin
                        TempExcelBuffer.AddColumn(False, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn("Student Master-CS".LDA, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(False, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    end;
                    ORiginalStudentNo := "Student Master-CS"."Original Student No.";
                    counter += 1;
                    if GuiAllowed then
                        WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(counter) + ' of ' + format(totalcount));

                End;
            end;

            trigger OnPostDataItem()
            begin
                IF GuiAllowed then
                    WindowDialog.Close();
                TempExcelBuffer.CreateNewBook(StudentList);
                TempExcelBuffer.WriteSheet(StudentList, CompanyName, UserId);
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
                TempExcelBuffer.OpenExcel();
            end;
        }

    }



    requestpage
    {
        // SaveValues = true;

        layout
        {

            area(content)
            {
                group(Option)
                {

                    field("Start Date"; StartDate)
                    {

                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date may have a value';
                    }
                    field("End Date"; EndDate)
                    {

                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date may have a value';
                    }
                }
            }
        }

    }
    var
        StudentSubExam: Record "Student Subject Exam";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ScoreType: Option " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK";
        AcademicYear: code[20];

        StudentList: Label 'FA Report';
        ExcelFileName: Label 'FA_Report_%1_%2';
        Terms: Code[20];
        StartDate: Date;
        EndDate: Date;
        counter: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        totalcount: Integer;
        ORiginalStudentNo: Code[20];

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if StartDate = 0D then
            ERROR('Start Date must have a value');
        if EndDate = 0D then
            ERROR('End Date must have a value');
    end;
}
