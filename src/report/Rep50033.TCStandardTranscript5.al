report 50033 TCStandardTranscript5
{
    Caption = 'Standard Transfer Credit Transcript';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/TCStandardTranscript5.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") order(ascending);

            column(Filter_Caption1; GETFILTERS())
            { }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            { }
            Column("Institute_Name"; UpperCase(RecEduSetup."Institute Name"))
            { }
            column(CollegeName; CollegeName)
            { }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            { }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            { }
            Column("Institute_City"; RecEduSetup."Institute City")
            { }
            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            { }
            Column(Country_Code1; RecEduSetup."Institute Country Code")
            { }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            { }
            Column("Institute_Email"; RecEduSetup.url)
            { }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            { }
            column(Student_Name; "Student Name")
            { }
            column(Addressee; Addressee)
            { }
            column(Address1; Address1)
            { }
            column(Address2; Address2)
            { }
            column(City; City)
            { }
            Column(State; State)
            { }
            Column(Country_Code; "Country Code")
            { }
            Column(Post_Code; "Post Code")
            { }
            column(No_; "Original Student No.")
            { }
            column(Estimated_Graduation_Date; RecStudentDegree.DateAwarded)
            { }
            column("DegreeAwarded"; "Course Name")
            { }
            column(Status; Status_gTxt)
            { }
            column(UnofficialTranscript; UnofficialTranscript)
            { }
            column(AttemptedCreditTxt; AttemptedCreditTxt)
            { }
            Column(AttemptedCredit; Format(GrandCredit + GrandCredit1))
            { }
            Column(GPACredits; GPACredits())
            { }
            Column(GPAQPts; Format(GrandPoint + Grandpoint1))
            { }
            Column(FinalGPA; Format("Student Master-CS"."Net Semester CGPA"))
            { }

            Column(NSLDS_Withdrawal_Date; StatusDate)
            { }
            Column(Course_Logo; CourseMaster_gRec2."Logo Image")
            { }
            Column(GD; GD)
            { }
            Column(GFPKey; GFPKey)
            { }

            trigger OnAfterGetRecord()
            Var
                StatusChangeLogEntry: Record "Status Change Log entry";
                ReasonCode: Record "Reason Code";
                MainStudentSubject_lRec: Record "Main Student Subject-CS";
                DeanHonorRoll: Boolean;
            begin

                If StudentNo_gTxt <> "Student Master-CS"."Original Student No." then begin
                    GradeConfirmed := false;

                    CourseMaster_gRec2.Reset();
                    CourseMaster_gRec2.SetRange(Code, "Student Master-CS"."Course Code");
                    IF CourseMaster_gRec2.FindFirst() then
                        CourseMaster_gRec2.CalcFields("Logo Image");

                    Status_gTxt := '';
                    StatusDate := '';
                    StudentStatus_gRec.Reset();
                    StudentStatus_gRec.SetRange(Code, "Student Master-CS".Status);
                    StudentStatus_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    If StudentStatus_gRec.FindFirst() then
                        If StudentStatus_gRec.Status IN [StudentStatus_gRec.Status::Dismissed, StudentStatus_gRec.Status::Withdrawn, StudentStatus_gRec.Status::ADWD] then begin
                            IF StudentStatus_gRec.Status = StudentStatus_gRec.Status::Dismissed then begin
                                StatusDate := 'Dismissal Date : ' + Format("Student Master-CS"."Dismissal Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                StatusChangeLogEntry.Reset();
                                StatusChangeLogEntry.SetRange("Student No.", "Student Master-CS"."No.");
                                StatusChangeLogEntry.SetRange("Status change to", 'DIS');
                                IF StatusChangeLogEntry.FindLast() then begin
                                    ReasonCode.Reset();
                                    ReasonCode.SetRange(Code, StatusChangeLogEntry."Reason Code");
                                    IF ReasonCode.FindFirst() then
                                        If ReasonCode."Show Description" then
                                            Status_gTxt := StudentStatus_gRec.Description + ' - ' + ReasonCode.Description
                                        Else
                                            Status_gTxt := StudentStatus_gRec.Description;

                                end;
                            end;
                            IF (StudentStatus_gRec.Status = StudentStatus_gRec.Status::Withdrawn) or (StudentStatus_gRec.Status = StudentStatus_gRec.Status::ADWD) then begin
                                StatusDate := 'Withdrawal Date : ' + Format("Student Master-CS"."NSLDS Withdrawal Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                Status_gTxt := StudentStatus_gRec.Description;
                            end;
                        end;

                    RecEduSetup.Reset();
                    RecEduSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF RecEduSetup.FindFirst() then
                        RecEduSetup.CALCFIELDS("Logo Image");

                    CollegeName := '';

                    If not UnofficialTranscript then begin
                        UserSetupRec.Reset();
                        UserSetupRec.SetRange("User ID", UserId());
                        IF UserSetupRec.FindFirst() then
                            If not UserSetupRec."Transcript Hold Allowed" then
                                StudentStatusMangement.StudentGroupWiseRestriction("No.", RestrictionType::"Transcript Hold");
                    end;


                    Temprecord1.Reset();
                    //TempRecord1.setrange("Unique ID", UserId());
                    TempRecord1.DeleteAll();


                    TranscriptTxt := '';
                    If UnofficialTranscript then
                        TranscriptTxt := 'Unofficial Transcript'
                    Else
                        TranscriptTxt := 'Official Transcript';

                    EntryNo := 0;
                    Temprecord1.Reset();
                    IF Temprecord1.Findlast() then
                        EntryNo := Temprecord1."Entry No" + 1
                    Else
                        EntryNo := 0;

                    CourseFilter := '';
                    CourseMaster_gRec1.Reset();
                    CourseMaster_gRec1.Setrange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    CourseMaster_gRec1.SetRange("Transcript Data Filter", True);
                    IF CourseMaster_gRec1.FindSet() then begin
                        repeat
                            If CourseFilter = '' then
                                CourseFilter := CourseMaster_gRec1.Code
                            Else
                                CourseFilter += '|' + CourseMaster_gRec1.Code;
                        until CourseMaster_gRec1.Next() = 0;
                    end;

                    AUAGHT := false;
                    StudentMaster_gRec.Reset();
                    StudentMaster_gRec.Setrange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMaster_gRec.SetFilter("Course Code", '%1|%2|%3', 'AUA-GHT', 'FIU - AUA CLINICAL', 'FIUGLOBAL');
                    IF StudentMaster_gRec.Findfirst() then
                        AUAGHT := True;


                    //Trnasfer Credit

                    CountNum := 0;
                    GrandCredit := 0;
                    GrandCredit1 := 0;
                    GrandPoint := 0;
                    GrandPoint1 := 0;
                    SqNo := 0;
                    TermGPA_gDec := 0;
                    GrandGPA := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'BASIC SCIENCE');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin


                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit
                                    Temprecord1.Field54 := 'Basic Science';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();



                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();


                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Basic Science Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    GrandGPA := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'BSIC');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit
                                    Temprecord1.Field54 := 'BSIC';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'BSIC Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    GrandGPA := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'BRIDGE TO AICASA');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit
                                    TempRecord1.Field54 := 'Bridge to AICASA';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Bridge to AICASA Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'GFP');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit
                                    TempRecord1.Field54 := 'GFP';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;

                        SqNo := 0;
                        IF SqNo = 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'GFP Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                        GFPKey := true;
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'PHYSICIAN ASSISANT');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit
                                    TempRecord1.Field54 := 'Physician Assisant';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();



                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Physician Assisant Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                    End;



                    SqNo := 0;
                    TermGPA_gDec := 0;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.Setfilter(Course, '<>%1', 'BSEP');
                    MainStudentSubject.SetRange("Category-Course Description", 'PREMED COURSES');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit

                                    TempRecord1.Field54 := 'Premed Courses';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Premed Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetRange("Category-Course Description", 'PREMED COURSES');
                    MainStudentSubject.Setrange(Course, 'BSEP');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    TempRecord1.Field54 := 'BSEP Courses';//Transfer Credit

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();




                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'BSEP Courses Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.Setfilter(Course, '<>%1', 'BSEP');
                    MainStudentSubject.SetRange("Category-Course Description", 'ASHS');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit
                                    TempRecord1.Field54 := 'ASHS Courses';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();



                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'ASHS Transfer Credits:';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'NURSING');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //Message('Grade must be confirmed for Subject Code %1', MainStudentSubject."Subject Code");
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit

                                    TempRecord1.Field54 := 'Nursing';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();



                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        // IF SqNo <> 0 then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := 'Nursing Transfer Credits';
                        TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        // TempRecord1.Field13 := Format(TotalPoint);
                        //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field70 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field67 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        GrandCredit := GrandCredit + TotalCredit;
                        // GrandPoint := GrandPoint + TotalPoint;
                        TotalCredit := 0;
                        TotalPoint := 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 3" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();


                        // end;
                        CollegeName := ' College of Nursing';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;

                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", Sequence);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetRange("Category-Course Description", 'NURSING  COURSES');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> Format(MainStudentSubject.Term)) then begin
                            If AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := Format(SubjectCategory_gRec."Category Description");//Transfer Credit

                                    TempRecord1.Field54 := 'Nursing';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();




                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."School ID" <> '' then begin
                                    SchoolMaster_gRec.Reset();
                                    SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                    IF SchoolMaster_gRec.Findfirst() then
                                        TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                end Else
                                    TempRecord1.Field54 := '';

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);


                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 2" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field3 := 'TC';

                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            //GrandCredit += TotalCredit;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                            Term_gTxt := MainStudentSubject."Term Sequence";

                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Nursing Transfer Credits';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // TempRecord1.Field13 := Format(TotalPoint);
                            //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            // GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();


                        end;
                        CollegeName := ' College of Nursing';
                    End;



                    // CountNum := 0;
                    //Transfer Credit
                    SqNo := 0;
                    TermGPA_gDec := 0;
                    StartDate := 0D;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", "Subject Code");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 2);
                    MainStudentSubject.SetRange("Category-Course Description", 'CLINICAL CLERKSHIP');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin
                        // TempRecord1.Init();
                        // EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        // TempRecord1."Entry No" := EntryNo;
                        // SubjectCategory_gRec.Reset();
                        // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        // If SubjectCategory_gRec.FindFirst() then
                        //     IF UnofficialTranscript = true then
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                        //     else
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        // TempRecord1.Field31 := 1;
                        // TempRecord1.Field57 := 1;//Integer
                        // TempRecord1.Field32 := 1;
                        // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        // CountNum := CountNum + 1;
                        // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        // TempRecord1."Unique ID" := UserId();
                        // TempRecord1.Insert();

                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            If (AcademicYear_gTxt <> MainStudentSubject."School ID") or (SubjectCode <> MainStudentSubject."Subject Code") then begin

                                If SqNo = 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field54 := 'Clinical';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1."Line Spacing 1" := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    If MainStudentSubject."School ID" <> '' then begin
                                        SchoolMaster_gRec.Reset();
                                        SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                        IF SchoolMaster_gRec.Findfirst() then
                                            TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                    end Else
                                        TempRecord1.Field54 := '';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1."Line Spacing 2" := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field2 := MainStudentSubject."Subject Code";
                                TempRecord1.Field11 := MainStudentSubject.Description;

                                // RosterLedgerEntry.Reset();
                                // RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                // RosterLedgerEntry.SetRange("Academic Year", MainStudentSubject."Academic Year");
                                // RosterLedgerEntry.SetRange(Semester, MainStudentSubject.Semester);
                                // RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                // IF RosterLedgerEntry.FindLast() then
                                //     TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + Format(RosterLedgerEntry."Start Date") + ' to ' + Format(RosterLedgerEntry."End Date")
                                // else
                                //     TempRecord1.Field14 := 'Northside Medical Center 4/18/2016 to 5/27/2016';
                                TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field3 := 'TC';

                                TempRecord1.Field32 := 0;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field68 := 1;
                                //Total
                                TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                AcademicYear_gTxt := MainStudentSubject."School ID";
                                SubjectCode := MainStudentSubject."Subject Code";
                                SqNo := 1;
                            end;
                        until MainStudentSubject.Next() = 0;


                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := 'Clinical Transfer Credits:';
                        TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        //TempRecord1.Field13 := Format(TotalPoint);
                        //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field70 := 1;
                        TempRecord1.Field67 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        GrandCredit1 := GrandCredit1 + TotalCredit;
                        TotalCredit := 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 3" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                    end;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    StartDate := 0D;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID", "Subject Code");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 2);
                    MainStudentSubject.SetRange("Category-Course Description", 'CLINICAL SCIENCE');
                    MainStudentSubject.SetRange(TC, True);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    If MainStudentSubject.FindSet() then begin

                        // TempRecord1.Init();
                        // EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        // TempRecord1."Entry No" := EntryNo;
                        // SubjectCategory_gRec.Reset();
                        // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        // If SubjectCategory_gRec.FindFirst() then
                        //     IF UnofficialTranscript = true then
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                        //     else
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        // TempRecord1.Field31 := 1;
                        // TempRecord1.Field57 := 1;//Integer
                        // TempRecord1.Field32 := 1;
                        // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        // CountNum := CountNum + 1;
                        // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        // TempRecord1."Unique ID" := UserId();
                        // TempRecord1.Insert();

                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."School ID") or (SubjectCode <> MainStudentSubject."Subject Code") then begin

                                If SqNo = 0 then begin

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field45 := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field54 := 'Clinical';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1."Line Spacing 1" := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();



                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    If MainStudentSubject."School ID" <> '' then begin
                                        SchoolMaster_gRec.Reset();
                                        SchoolMaster_gRec.SetRange("School ID", MainStudentSubject."School ID");
                                        IF SchoolMaster_gRec.Findfirst() then
                                            TempRecord1.Field54 := SchoolMaster_gRec.Name;
                                    end Else
                                        TempRecord1.Field54 := '';

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1."Line Spacing 2" := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field2 := MainStudentSubject."Subject Code";
                                TempRecord1.Field11 := MainStudentSubject.Description;

                                // RosterLedgerEntry.Reset();
                                // RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                // RosterLedgerEntry.SetRange("Academic Year", MainStudentSubject."Academic Year");
                                // RosterLedgerEntry.SetRange(Semester, MainStudentSubject.Semester);
                                // RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                // IF RosterLedgerEntry.FindLast() then
                                //     TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + Format(RosterLedgerEntry."Start Date") + ' to ' + Format(RosterLedgerEntry."End Date")
                                // else
                                //     TempRecord1.Field14 := 'Northside Medical Center 4/18/2016 to 5/27/2016';
                                TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field3 := 'TC';

                                TempRecord1.Field32 := 0;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field68 := 1;
                                //Total
                                TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                AcademicYear_gTxt := MainStudentSubject."School ID";
                                SubjectCode := MainStudentSubject."Subject Code";
                                SqNo := 1;
                            end;
                        until MainStudentSubject.Next() = 0;


                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := 'Clinical Transfer Credits:';
                        TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        //TempRecord1.Field13 := Format(TotalPoint);
                        //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field70 := 1;
                        TempRecord1.Field67 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        GrandCredit1 := GrandCredit1 + TotalCredit;
                        TotalCredit := 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 3" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                    end;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    DeanHonorRoll := False;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'BASIC SCIENCE');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    // IF Not AUAGHT then
                    //     MainStudentSubject.SetFilter(Semester, '<>%1', 'BSIC');
                    If MainStudentSubject.FindSet() then begin
                        If not AUAGHT then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            SubjectCategory_gRec.Reset();
                            SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                            IF SubjectCategory_gRec.FindFirst() then
                                IF UnofficialTranscript = true then
                                    TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                                else
                                    TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                            TempRecord1.Field31 := 1;
                            TempRecord1.Field57 := 1;//Integer
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end ELSE begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field55 := 'Global Health Track';
                            TempRecord1.Field31 := 1;
                            TempRecord1.Field57 := 1;//Integer
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            DeanHonorRoll := False;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    DeanHonorRoll := false;
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;

                                    MainStudentSubject_lRec.Reset();
                                    MainStudentSubject_lRec.SetCurrentKey("Academic Year", "Term Sequence");
                                    MainStudentSubject_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                    If not TranscriptDataFilter then begin
                                        MainStudentSubject_lRec.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                                        MainStudentSubject_lRec.Setrange(Course, "Student Master-CS"."Course Code");
                                    end;
                                    If TranscriptDataFilter then
                                        MainStudentSubject_lRec.SetFilter(Course, CourseFilter);
                                    MainStudentSubject_lRec.SetRange(Level, 1);
                                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                                    MainStudentSubject_lRec.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                                    MainStudentSubject_lRec.SetRange("Category-Course Description", 'BASIC SCIENCE');
                                    MainStudentSubject_lRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                                    MainStudentSubject_lRec.SetRange(TC, False);
                                    // IF Not AUAGHT then
                                    //     MainStudentSubject_lRec.SetFilter(Semester, '<>%1', 'BSIC');
                                    MainStudentSubject_lRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                    MainStudentSubject_lRec.Setrange(Term, MainStudentSubject.Term);
                                    MainStudentSubject_lRec.Setrange("Dean's Honor Roll", True);
                                    If MainStudentSubject_lRec.Findfirst() then
                                        DeanHonorRoll := True;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        End Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 2 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 3 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 4 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 5 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 6 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 7 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 8 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    IF SqNo = 9 then
                                        If DeanHonorRoll then begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                        end Else begin
                                            If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                                Else
                                                    If (CreditEarned = 0) and (GrandGPA = 0) then
                                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                        end;
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                IF "Student Master-CS"."KMC ID" <> '' then
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                Else Begin
                                    IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                    Else begin
                                        IF not AUAGHT then
                                            TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                        else
                                            TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                    end;
                                end;

                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                If PassingGrade_gRec."BSIC Grading Calc." then              //CSPL-00116
                                    TotalCreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;

                        DeanHonorRoll := False;
                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;

                            MainStudentSubject_lRec.Reset();
                            MainStudentSubject_lRec.SetCurrentKey("Academic Year", "Term Sequence");
                            MainStudentSubject_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                            If not TranscriptDataFilter then begin
                                MainStudentSubject_lRec.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                                MainStudentSubject_lRec.Setrange(Course, "Student Master-CS"."Course Code");
                            end;
                            If TranscriptDataFilter then
                                MainStudentSubject_lRec.SetFilter(Course, CourseFilter);
                            MainStudentSubject_lRec.SetRange(Level, 1);
                            //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                            MainStudentSubject_lRec.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                            MainStudentSubject_lRec.SetRange("Category-Course Description", 'BASIC SCIENCE');
                            MainStudentSubject_lRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            MainStudentSubject_lRec.SetRange(TC, False);
                            // IF Not AUAGHT then
                            //     MainStudentSubject_lRec.SetFilter(Semester, '<>%1', 'BSIC');
                            MainStudentSubject_lRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                            MainStudentSubject_lRec.Setrange(Term, MainStudentSubject.Term);
                            MainStudentSubject_lRec.Setrange("Dean's Honor Roll", True);
                            If MainStudentSubject_lRec.Findfirst() then
                                DeanHonorRoll := True;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 2 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 3 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 4 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 5 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 6 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 7 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 8 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            IF SqNo = 9 then
                                If DeanHonorRoll then begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll")
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00) + '   ' + TempRecord1.FieldCaption("Dean's Honor Roll");
                                end Else begin
                                    If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        if (CreditEarned = 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            If (CreditEarned = 0) and (GrandGPA = 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                end;
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    // SqNo := 0;
                    // TermGPA_gDec := 0;
                    // Term_gTxt := 0;
                    // AcademicYear_gTxt := '';
                    // IF Not AUAGHT then begin
                    //     MainStudentSubject.Reset();
                    //     MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    //     MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    //     If not TranscriptDataFilter then begin
                    //         MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                    //         MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    //     end;
                    //     If TranscriptDataFilter then
                    //         MainStudentSubject.SetFilter(Course, CourseFilter);
                    //     MainStudentSubject.SetRange(Level, 1);
                    //     //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    //     MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    //     MainStudentSubject.SetRange("Category-Course Description", 'BASIC SCIENCE');
                    //     MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    //     MainStudentSubject.SetRange(TC, False);
                    //     IF not AUAGHT then
                    //         MainStudentSubject.SetRange(Semester, 'BSIC');
                    //     If MainStudentSubject.FindSet() then begin
                    //         InsertedEntry := 0;
                    //         InsertedEntry := EntryNo;

                    //         GroupCount := 0;
                    //         MainStudentSubject_gRec.Reset();
                    //         MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                    //         MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                    //         MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                    //         GroupCount := MainStudentSubject_gRec.Count();
                    //         GroupCount += 6;

                    //         If EntryNo >= 88 then begin
                    //             For int := 1 to (90 - InsertedEntry) do begin
                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                 TempRecord1."Entry No" := EntryNo;
                    //                 TempRecord1.Field34 := 1;
                    //                 CountNum := CountNum + 1;
                    //                 TempRecord1.Field45 := 1;
                    //                 TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //                 TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                 TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                 TempRecord1."Unique ID" := UserId();
                    //                 TempRecord1.Insert();
                    //                 InsertedEntry += 1;
                    //             end;
                    //         end;
                    //         IF ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                    //             For int := 1 to (45 - InsertedEntry) do begin
                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                 TempRecord1."Entry No" := EntryNo;
                    //                 TempRecord1.Field34 := 1;
                    //                 CountNum := CountNum + 1;
                    //                 TempRecord1.Field45 := 1;
                    //                 TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //                 TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                 TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                 TempRecord1."Unique ID" := UserId();
                    //                 TempRecord1.Insert();
                    //                 InsertedEntry += 1;
                    //             end;
                    //         end;


                    //         TempRecord1.Init();
                    //         EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //         TempRecord1."Entry No" := EntryNo;
                    //         SubjectCategory_gRec.Reset();
                    //         SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                    //         IF SubjectCategory_gRec.FindFirst() then
                    //             IF UnofficialTranscript = true then
                    //                 TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                    //             else
                    //                 TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                    //         TempRecord1.Field31 := 1;
                    //         TempRecord1.Field57 := 1;//Integer
                    //         TempRecord1.Field32 := 1;
                    //         TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //         TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //         CountNum := CountNum + 1;
                    //         TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //         TempRecord1."Unique ID" := UserId();
                    //         TempRecord1.Insert();

                    //         repeat
                    //             TranscriptDataFilter1 := false;
                    //             CourseMaster_gRec1.Reset();
                    //             CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                    //             IF CourseMaster_gRec1.FindFirst() then
                    //                 IF CourseMaster_gRec1."Transcript Data Filter" then
                    //                     TranscriptDataFilter1 := true;

                    //             IF TranscriptDataFilter1 <> TranscriptDataFilter then
                    //                 CurrReport.Skip();
                    //             // IF Not GradeConfirmed then
                    //             //     IF not MainStudentSubject."Grade Confirmed" then begin
                    //             //         Message('Please Confirm all the Grades!');
                    //             //         GradeConfirmed := true;
                    //             //     end;
                    //             IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                    //                 IF SqNo <> 0 then begin
                    //                     TempRecord1.Init();
                    //                     EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                     TempRecord1."Entry No" := EntryNo;
                    //                     TempRecord1.Field11 := ' ';
                    //                     TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //                     TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //                     TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                     TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                     //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                    //                     TempRecord1.Field32 := 1;
                    //                     TempRecord1.Field70 := 1;
                    //                     CountNum := CountNum + 1;
                    //                     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                     TempRecord1."Unique ID" := UserId();
                    //                     TempRecord1.Insert();
                    //                     GrandCredit := GrandCredit + TotalCredit;
                    //                     GrandPoint := GrandPoint + TotalPoint;
                    //                     If CreditEarned <> 0 then
                    //                         TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                    //                     GrandGPA += CreditEarned;

                    //                     TempRecord1.Init();
                    //                     EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                     TempRecord1."Entry No" := EntryNo;
                    //                     IF SqNo = 1 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 2 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 3 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 4 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 5 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 6 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 7 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 8 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 9 then
                    //                         If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     TempRecord1.Field57 := 1;
                    //                     //    TempRecord1.Field32 := 1;
                    //                     TempRecord1.Field34 := 1;
                    //                     CountNum := CountNum + 1;
                    //                     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                     TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                     TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                     TempRecord1."Unique ID" := UserId();
                    //                     TempRecord1.Insert();
                    //                     TotalCredit := 0;
                    //                     TotalPoint := 0;
                    //                     CreditEarned := 0;

                    //                 end;

                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                 TempRecord1."Entry No" := EntryNo;
                    //                 TempRecord1.Field34 := 1;
                    //                 CountNum := CountNum + 1;
                    //                 TempRecord1.Field45 := 1;
                    //                 TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //                 TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                 TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                 TempRecord1."Unique ID" := UserId();
                    //                 TempRecord1.Insert();

                    //                 InsertedEntry := 0;
                    //                 InsertedEntry := EntryNo;
                    //                 GroupCount := 0;
                    //                 MainStudentSubject_gRec.Reset();
                    //                 MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                    //                 MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                    //                 MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                    //                 GroupCount := MainStudentSubject_gRec.Count();
                    //                 GroupCount += 4;

                    //                 If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                    //                     For int := 1 to (45 - InsertedEntry) do begin
                    //                         TempRecord1.Init();
                    //                         EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                         TempRecord1."Entry No" := EntryNo;
                    //                         TempRecord1.Field34 := 1;
                    //                         CountNum := CountNum + 1;
                    //                         TempRecord1.Field45 := 1;
                    //                         TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //                         TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                         TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                         TempRecord1."Unique ID" := UserId();
                    //                         TempRecord1.Insert();
                    //                         InsertedEntry += 1;
                    //                     end;

                    //                 end;

                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                 TempRecord1."Entry No" := EntryNo;
                    //                 TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                    //                 TempRecord1.Field32 := 1;
                    //                 TempRecord1.Field37 := 1;
                    //                 TempRecord1.Field61 := 1;
                    //                 CountNum := CountNum + 1;
                    //                 TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                 TempRecord1."Unique ID" := UserId();
                    //                 TempRecord1.Insert();

                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //                 TempRecord1."Entry No" := EntryNo;
                    //                 TempRecord1.Field34 := 1;
                    //                 CountNum := CountNum + 1;
                    //                 TempRecord1."Line Spacing 1" := 1;
                    //                 TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //                 TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                 TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                 TempRecord1."Unique ID" := UserId();
                    //                 TempRecord1.Insert();
                    //             end;

                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field2 := MainStudentSubject."Subject Code";
                    //             TempRecord1.Field11 := MainStudentSubject.Description;
                    //             TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             //TempRecord1.Field3 := MainStudentSubject.Grade;
                    //             QualityPoints_gDec := 0;
                    //             PassingGrade_gRec.Reset();
                    //             PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                    //             PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    //             If PassingGrade_gRec.FindFirst() then begin
                    //                 QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                    //                 IF PassingGrade_gRec."Consider for GPA" then
                    //                     CreditEarned += MainStudentSubject."Credits Attempt";
                    //                 CourseMaster_gRec.Reset();
                    //                 CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                    //                 IF CourseMaster_gRec.FindFirst() then begin
                    //                     IF CourseMaster_gRec."Show Grade Description" then begin
                    //                         IF PassingGrade_gRec."Show Grade Description" then
                    //                             TempRecord1.Field3 := PassingGrade_gRec.Description
                    //                         Else
                    //                             TempRecord1.Field3 := PassingGrade_gRec.Code;
                    //                     end Else
                    //                         TempRecord1.Field3 := PassingGrade_gRec.Code;
                    //                 end;
                    //             end;

                    //             TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             TempRecord1.Field32 := 0;
                    //             //Total
                    //             TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                    //             TotalPoint := TotalPoint + QualityPoints_gDec;

                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             CountNum := CountNum + 1;
                    //             TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();

                    //             SqNo := MainStudentSubject.Sequence;
                    //             AcademicYear_gTxt := MainStudentSubject."Academic Year";
                    //             Term_gTxt := MainStudentSubject."Term Sequence";
                    //         until MainStudentSubject.Next() = 0;


                    //         IF SqNo <> 0 then begin
                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field11 := ' ';
                    //             TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             // If CreditEarned <> 0 then
                    //             //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //             // Else
                    //             //     TempRecord1.Field14 := Format(0.00);
                    //             TempRecord1.Field32 := 1;
                    //             TempRecord1.Field70 := 1;
                    //             CountNum := CountNum + 1;
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();
                    //             GrandCredit := GrandCredit + TotalCredit;
                    //             GrandPoint := GrandPoint + TotalPoint;
                    //             IF CreditEarned <> 0 then
                    //                 TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                    //             GrandGPA += CreditEarned;


                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //             TempRecord1."Entry No" := EntryNo;
                    //             IF SqNo = 1 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 2 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 3 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 4 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 5 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 6 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 7 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 8 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 9 then
                    //                 If (CreditEarned <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditEarned = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditEarned = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             TempRecord1.Field57 := 1;
                    //             //    TempRecord1.Field32 := 1;
                    //             TempRecord1.Field34 := 1;
                    //             CountNum := CountNum + 1;
                    //             TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();
                    //             TotalCredit := 0;
                    //             TotalPoint := 0;
                    //             CreditEarned := 0;

                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field34 := 1;
                    //             CountNum := CountNum + 1;
                    //             TempRecord1."Line Spacing 3" := 1;
                    //             TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();

                    //         end;
                    //         CollegeName := ' College of Medicine';
                    //     End;
                    // end;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'BSIC');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    //TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'PREMED COURSES');
                    MainStudentSubject.Setfilter(Course, '<>%1', 'BSEP');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                IF MainStudentSubject.Course = 'APC' then
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' APC'
                                Else
                                    If MainStudentSubject.Course = 'PPP' then
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' PPP'
                                    Else
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // IF MainStudentSubject.Course IN ['APC', 'PPP'] then begin
                            //     IF MainStudentSubject.Grade = 'P' then
                            //         TempRecord1.Field3 := 'PASS';
                            //     IF MainStudentSubject.Grade = 'F' then
                            //         TempRecord1.Field3 := 'FAIL';
                            //     If Not (MainStudentSubject.Grade In ['P', 'F']) then
                            //         TempRecord1.Field3 := MainStudentSubject.Grade;
                            // end Else
                            //     TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    //TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    //MainStudentSubject.SetRange("Category-Course Description", 'PREMED COURSES');
                    MainStudentSubject.Setrange(Course, 'BSEP');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        // SubjectCategory_gRec.Reset();
                        // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        // IF SubjectCategory_gRec.FindFirst() then
                        //     IF UnofficialTranscript = true then
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                        //     else
                        TempRecord1.Field55 := 'BSEP Courses';

                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    //TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'ASHS');
                    MainStudentSubject.Setfilter(Course, '<>%1', 'BSEP');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                //TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                IF MainStudentSubject.Course = 'APC' then
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' APC'
                                Else
                                    If MainStudentSubject.Course = 'PPP' then
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' PPP'
                                    Else
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;



                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    //TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'PHYSICIAN ASSISANT');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        Temprecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;



                    SqNo := 0;
                    //TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'NURSING');
                    MainStudentSubject.SetRange(TC, false);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then begin
                            IF UnofficialTranscript then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        end;

                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                //TempRecord1.Field11 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;
                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            If CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                        CollegeName := ' School of Nursing';
                    End;

                    SqNo := 0;
                    //TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'NURSING COURSES');
                    MainStudentSubject.SetRange(TC, false);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then begin
                            IF UnofficialTranscript then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        end;

                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                //TempRecord1.Field11 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then Begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;

                            end;
                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            If CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                        CollegeName := ' School of Nursing';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", Sequence, "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'BRIDGE TO AICASA');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := ' College of Medicine';
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    //MainStudentSubject.SetCurrentKey("Academic Year", Sequence, "Term Sequence");
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'GFP');
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(TC, False);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        // SubjectCategory_gRec.Reset();
                        // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        // IF SubjectCategory_gRec.FindFirst() then
                        //     IF UnofficialTranscript = true then
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                        //     else
                        //         TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field55 := 'College of Graduate Studies';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field45 := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();


                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field54 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field54 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field70 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field57 := 1;
                                    //    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // IF MainStudentSubject.Course IN ['GFP'] then begin
                            //     IF MainStudentSubject.Grade = 'P' then
                            //         TempRecord1.Field3 := 'PASS';
                            //     IF MainStudentSubject.Grade = 'F' then
                            //         TempRecord1.Field3 := 'FAIL';
                            //     If Not (MainStudentSubject.Grade In ['P', 'F']) then
                            //         TempRecord1.Field3 := MainStudentSubject.Grade;
                            // end;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := 0;
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += 0;
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;

                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            // If RosterFound then begin
                            //     RosterLedgerEntry.Reset();
                            //     RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                            //     RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                            //     RosterLedgerEntry.setrange("Start Date", MainStudentSubject."Start Date");
                            //     IF RosterLedgerEntry.FindLast() then
                            //         TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            //     IF not RosterLedgerEntry.FindLast() then
                            //         TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            // end;
                            // If RosterFound1 then begin
                            //     RosterLedgerEntry.Reset();
                            //     RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                            //     RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Completed);
                            //     RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                            //     RosterLedgerEntry.setrange("Rotation Grade", MainStudentSubject.Grade);
                            //     IF RosterLedgerEntry.FindLast() then
                            //         TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            //     IF not RosterLedgerEntry.FindLast() then
                            //         TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            // end;
                            // If RosterFound2 then begin
                            //     RosterLedgerEntry.Reset();
                            //     RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                            //     RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                            //     IF RosterLedgerEntry.FindLast() then
                            //         TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            //     IF not RosterLedgerEntry.FindLast() then
                            //         TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            // end;
                            // IF (RosterFound = false) And (RosterFound1 = false) and (RosterFound2 = false) then
                            TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;

                        SqNo := 0;
                        IF SqNo = 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            // If CreditEarned <> 0 then
                            //     TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            // Else
                            //     TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            IF CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 0 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00)
                                        Else
                                            IF (TotalCredit <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / TotalCredit)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((0)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');

                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            //    TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Line Spacing 3" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        CollegeName := 'College of Graduate Studies';
                        GFPKey := true;
                    End;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    StartDate := 0D;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Start Date");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 2);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    // MainStudentSubject.SetFilter("Credits Attempt", '<>%1', 0);
                    MainStudentSubject.SetRange("Category-Course Description", 'CLINICAL CLERKSHIP');
                    MainStudentSubject.SetRange(TC, false);
                    If MainStudentSubject.FindSet() then begin
                        InsertedEntry := 0;
                        InsertedEntry := EntryNo;
                        If EntryNo >= 85 then begin
                            For int := 1 to (90 - InsertedEntry) do begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;

                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                InsertedEntry += 1;
                            end;
                        end;
                        IF (EntryNo >= 40) and (EntryNo <= 45) then begin
                            For int := 1 to (45 - InsertedEntry) do begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                InsertedEntry += 1;
                            end;
                        end;
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF StartDate <> MainStudentSubject."Start Date" then begin

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                If EntryNo >= 89 then begin
                                    For int := 1 to (90 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;

                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;
                                end;
                                IF (EntryNo >= 44) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;
                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field2 := MainStudentSubject."Subject Code";
                                TempRecord1.Field11 := MainStudentSubject.Description;
                                TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                //TempRecord1.Field3 := MainStudentSubject.Grade;
                                QualityPoints_gDec := 0;
                                PassingGrade_gRec.Reset();
                                PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                                PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                                If PassingGrade_gRec.FindFirst() then begin
                                    QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                    IF PassingGrade_gRec."Consider for GPA" then
                                        CreditEarned += MainStudentSubject."Credits Attempt";

                                    If PassingGrade_gRec."BSIC Grading Calc." then              //CSPL-00116
                                        TotalCreditEarned += MainStudentSubject."Credits Attempt";
                                    CourseMaster_gRec.Reset();
                                    CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                    IF CourseMaster_gRec.FindFirst() then begin
                                        IF CourseMaster_gRec."Show Grade Description" then begin
                                            IF PassingGrade_gRec."Show Grade Description" then
                                                TempRecord1.Field3 := PassingGrade_gRec.Description
                                            Else
                                                TempRecord1.Field3 := PassingGrade_gRec.Code;
                                        end Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end;
                                end;
                                TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field32 := 0;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field68 := 1;
                                //Total
                                TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                                TotalPoint := TotalPoint + QualityPoints_gDec;

                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                RosterFound := false;
                                RosterFound1 := false;
                                RosterFound2 := false;
                                RosterLedgerEntry.Reset();
                                RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                RosterLedgerEntry.SetRange("Start Date", MainStudentSubject."Start Date");
                                RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                IF RosterLedgerEntry.FindLast() then
                                    RosterFound := true;

                                If RosterFound = false then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Rotation Grade", MainStudentSubject.Grade);
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Completed);
                                    IF RosterLedgerEntry.FindLast() then
                                        RosterFound1 := true;
                                end;

                                If (RosterFound = False) and (RosterFound1 = false) then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                    IF RosterLedgerEntry.FindLast() then
                                        RosterFound2 := true;
                                end;


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If RosterFound then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.setrange("Start Date", MainStudentSubject."Start Date");
                                    RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                    IF RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                    IF not RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                end;
                                If RosterFound1 then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Completed);
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.setrange("Rotation Grade", MainStudentSubject.Grade);
                                    IF RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                    IF not RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                end;
                                If RosterFound2 then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                    IF RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                    IF not RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                end;
                                IF (RosterFound = false) And (RosterFound1 = false) and (RosterFound2 = false) then
                                    TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                StartDate := MainStudentSubject."Start Date";
                            end;
                        until MainStudentSubject.Next() = 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := ' ';
                        TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        GrandCredit1 := GrandCredit1 + TotalCredit;
                        GrandPoint1 := GrandPoint1 + TotalPoint;

                        If CreditEarned <> 0 then
                            TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                        GrandGPA += CreditEarned;


                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        IF SqNo = 0 then
                            If CreditEarned <> 0 then
                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            Else
                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);

                        TempRecord1.Field57 := 1;
                        TempRecord1.Field69 := 1;
                        //TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TotalCredit := 0;
                        TotalPoint := 0;
                        CreditEarned := 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 3" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                    end;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    StartDate := 0D;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Start Date");
                    MainStudentSubject.SetRange("Original Student No.", "Original Student No.");
                    If not TranscriptDataFilter then
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                    MainStudentSubject.SetRange(Level, 2);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    // MainStudentSubject.SetFilter("Credits Attempt", '<>%1', 0);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange("Category-Course Description", 'CLINICAL SCIENCE');
                    MainStudentSubject.SetRange(TC, false);
                    If MainStudentSubject.FindSet() then begin
                        InsertedEntry := 0;
                        InsertedEntry := EntryNo;
                        If EntryNo >= 85 then begin
                            For int := 1 to (90 - InsertedEntry) do begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;

                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                InsertedEntry += 1;
                            end;
                        end;
                        IF (EntryNo >= 40) and (EntryNo <= 45) then begin
                            For int := 1 to (45 - InsertedEntry) do begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                InsertedEntry += 1;
                            end;
                        end;
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description"
                            else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description";
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 1" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();
                            // IF Not GradeConfirmed then
                            //     IF not MainStudentSubject."Grade Confirmed" then begin
                            //         Message('Please Confirm all the Grades!');
                            //         GradeConfirmed := true;
                            //     end;
                            IF StartDate <> MainStudentSubject."Start Date" then begin

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                If EntryNo >= 89 then begin
                                    For int := 1 to (90 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;

                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;
                                end;
                                IF (EntryNo >= 44) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field45 := 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        InsertedEntry += 1;
                                    end;
                                end;


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field2 := MainStudentSubject."Subject Code";
                                TempRecord1.Field11 := MainStudentSubject.Description;


                                TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                //TempRecord1.Field3 := MainStudentSubject.Grade;
                                QualityPoints_gDec := 0;
                                PassingGrade_gRec.Reset();
                                PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                                PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                                If PassingGrade_gRec.FindFirst() then begin
                                    QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                    IF PassingGrade_gRec."Consider for GPA" then
                                        CreditEarned += MainStudentSubject."Credits Attempt";
                                    If PassingGrade_gRec."BSIC Grading Calc." then              //CSPL-00116
                                        TotalCreditEarned += MainStudentSubject."Credits Attempt";
                                    CourseMaster_gRec.Reset();
                                    CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                    IF CourseMaster_gRec.FindFirst() then begin
                                        IF CourseMaster_gRec."Show Grade Description" then begin
                                            IF PassingGrade_gRec."Show Grade Description" then
                                                TempRecord1.Field3 := PassingGrade_gRec.Description
                                            Else
                                                TempRecord1.Field3 := PassingGrade_gRec.Code;
                                        end Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end;
                                end;
                                TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field32 := 0;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field68 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                //Total

                                TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                                TotalPoint := TotalPoint + QualityPoints_gDec;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                RosterFound := false;
                                RosterFound1 := false;
                                RosterFound2 := false;
                                RosterLedgerEntry.Reset();
                                RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                RosterLedgerEntry.SetRange("Start Date", MainStudentSubject."Start Date");
                                RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                IF RosterLedgerEntry.FindLast() then
                                    RosterFound := true;

                                If RosterFound = false then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Rotation Grade", MainStudentSubject.Grade);
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Completed);
                                    IF RosterLedgerEntry.FindLast() then
                                        RosterFound1 := true;
                                end;

                                If (RosterFound = False) and (RosterFound1 = false) then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                    IF RosterLedgerEntry.FindLast() then
                                        RosterFound2 := true;
                                end;


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If RosterFound then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.setrange("Start Date", MainStudentSubject."Start Date");
                                    RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                    IF RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                    IF not RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                end;
                                If RosterFound1 then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange(Status, RosterLedgerEntry.Status::Completed);
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.setrange("Rotation Grade", MainStudentSubject.Grade);
                                    IF RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                    IF not RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                end;
                                If RosterFound2 then begin
                                    RosterLedgerEntry.Reset();
                                    RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                                    RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                                    RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
                                    IF RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := RosterLedgerEntry."Hospital Name" + ' ' + Format(RosterLedgerEntry."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(RosterLedgerEntry."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                    IF not RosterLedgerEntry.FindLast() then
                                        TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                end;
                                IF (RosterFound = false) And (RosterFound1 = false) and (RosterFound2 = false) then
                                    TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                StartDate := MainStudentSubject."Start Date";
                            end;
                        until MainStudentSubject.Next() = 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := ' ';
                        TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        //TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        GrandCredit1 := GrandCredit1 + TotalCredit;
                        GrandPoint1 := GrandPoint1 + TotalPoint;
                        If CreditEarned <> 0 then
                            TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                        GrandGPA += CreditEarned;


                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        IF SqNo = 0 then
                            If CreditEarned <> 0 then
                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            Else
                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);

                        TempRecord1.Field57 := 1;
                        TempRecord1.Field69 := 1;
                        //TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TotalCredit := 0;
                        TotalPoint := 0;
                        CreditEarned := 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 3" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                    end;

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;

                    TempRecord1.Field38 := 'Attempted Credits: ';// + ' ' + Format(GrandCredit + GrandCredit1) + '  ' + 'GPA Credits:' + ' ' + Format(Round(GrandGPA));
                    TempRecord1.Field39 := 'GPA Credits: ';
                    TempRecord1.Field23 := GrandCredit + GrandCredit1;
                    TempRecord1.Field24 := GrandGPA;
                    TempRecord1."Enrollment No." := '1';
                    //TempRecord1.Field45 := 1;//Top Border
                    TempRecord1.Field32 := 1;
                    // TempRecord1.Field33 := 1;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field38 := 'GPA QPTs: ';// + ' ' + Format(GrandPoint + GrandPoint1) + '  ' + 'Final GPA :' + ' ' + Format(Round((GrandPoint + GrandPoint1) / (GrandGPA)))
                    TempRecord1.Field39 := 'Final GPA: ';
                    TempRecord1.Field23 := GrandPoint + GrandPoint1;
                    IF GrandGPA <> 0 then
                        TempRecord1.Field24 := Round((GrandPoint + GrandPoint1) / GrandGPA)
                    Else
                        TempRecord1.Field24 := 0;
                    TempRecord1."Enrollment No." := '2';
                    //TempRecord1.Field45 := 0;

                    GPA_gDec := 0;
                    IF GrandGPA <> 0 then
                        GPA_gDec := Round((GrandPoint + GrandPoint1) / GrandGPA)
                    Else
                        GPA_gDec := 0;
                    //TempRecord1.Field32 := 1;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    TempRecord1.Init();         //CSPL-00116
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field65 := '3';
                    TempRecord1.Field66 := '0';

                    TempRecord1.Field64 := 'Earned Credits:';
                    TempRecord1.Field21 := TotalCreditEarned;
                    // IF GrandGPA <> 0 then
                    //     TempRecord1.Field22 := Round(((GrandPoint + GrandPoint1) / GrandGPA))
                    // Else
                    //     TempRecord1.Field22 := 0;
                    TempRecord1.Field32 := 0;

                    TempRecord1.Field34 := 1;
                    TempRecord1.Field62 := 1;
                    TempRecord1."Enrollment No." := '10';
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();


                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1."Line Spacing 5" := 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    HonorsFinds := false;
                    RecStudentHonor.Reset();
                    RecStudentHonor.SetRange("Student No.", "Student Master-CS"."No.");
                    RecStudentHonor.SetFilter("Min. Range", '<=%1', GPA_gDec);
                    RecStudentHonor.SetFilter("Max. Range", '>=%1', GPA_gDec);
                    IF RecStudentHonor.FindFirst() then
                        HonorsFinds := true;

                    DegreeFinds := false;
                    StudentMasterCS.Reset();
                    StudentMasterCS.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMasterCS.SetRange("Global Dimension 1 Code", GD);
                    IF not TranscriptDataFilter then
                        StudentMasterCS.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                    If CourseFilter <> '' then
                        StudentMasterCS.SetFilter("Course Code", CourseFilter)
                    ELse
                        StudentMasterCS.SetRange("Course Code", "Student Master-CS"."Course Code");
                    If StudentMasterCS.FindSet() then begin
                        repeat
                            RecStudentDegree.Reset();
                            RecStudentDegree.SetRange("Student No.", StudentMasterCS."No.");
                            RecStudentDegree.SEtrange("Global Dimension 1 Code", GD);
                            IF not TranscriptDataFilter then
                                RecStudentDegree.SetRange("Enrollment No.", StudentMasterCS."Enrollment No.");
                            //RecStudentDegree.SetRange("Degree Code", 'ASN');
                            IF RecStudentDegree.Findset() then begin
                                repeat
                                    DegreeFinds := true;
                                Until RecStudentDegree.Next() = 0;
                            end;
                        until StudentMasterCS.Next() = 0;
                    end;

                    If (HonorsFinds = True) or (DegreeFinds = True) then begin
                        InsertedEntry := 0;
                        InsertedEntry := EntryNo;
                        If EntryNo >= 85 then begin
                            For int := 1 to (90 - InsertedEntry) do begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                InsertedEntry += 1;
                            end;
                        end;
                        IF (EntryNo >= 40) and (EntryNo <= 45) then begin
                            For int := 1 to (45 - InsertedEntry) do begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field45 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                InsertedEntry += 1;
                            end;
                        end;
                    end;


                    RecStudentHonor.Reset();
                    RecStudentHonor.SetRange("Student No.", "Student Master-CS"."No.");
                    RecStudentHonor.SetFilter("Min. Range", '<=%1', GPA_gDec);
                    RecStudentHonor.SetFilter("Max. Range", '>=%1', GPA_gDec);
                    IF RecStudentHonor.FindFirst() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        //TempRecord1.Field11 := 'Honors:' + '  ' + RecStudentHonor."Honors Name";
                        TempRecord1.Field46 := 'Honors:';
                        TempRecord1.field47 := RecStudentHonor."Honors Name";
                        TempRecord1.field50 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                    end;

                    SqNo := 0;
                    StudentMasterCS.Reset();
                    StudentMasterCS.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMasterCS.SetRange("Global Dimension 1 Code", GD);
                    IF not TranscriptDataFilter then
                        StudentMasterCS.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                    If TranscriptDataFilter then begin
                        If CourseFilter <> '' then
                            StudentMasterCS.SetFilter("Course Code", CourseFilter);
                    end ELse
                        StudentMasterCS.SetRange("Course Code", "Student Master-CS"."Course Code");
                    If StudentMasterCS.FindSet() then begin
                        repeat

                            RecStudentDegree.Reset();
                            RecStudentDegree.SetRange("Student No.", StudentMasterCS."No.");
                            RecStudentDegree.SEtrange("Global Dimension 1 Code", GD);
                            IF not TranscriptDataFilter then
                                RecStudentDegree.SetRange("Enrollment No.", StudentMasterCS."Enrollment No.");
                            //RecStudentDegree.SetRange("Degree Code", 'ASN');
                            IF RecStudentDegree.Findset() then begin

                                repeat
                                    IF SQno = 0 then begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        //TempRecord1.Field11 := 'AWARDED';
                                        TempRecord1.field48 := 'Awarded';
                                        TempRecord1.Field34 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field33 := 1;
                                        TempRecord1."Enrollment No." := '3';
                                        TempRecord1.Field35 := 1;
                                        TempRecord1.Field53 := 1;//left-right border
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();

                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        //TempRecord1.Field3 := 'DATE AWARDED';
                                        TempRecord1.field49 := 'Date Awarded';
                                        TempRecord1.Field53 := 1;//left-right border
                                                                 //TempRecord1.Field50 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field35 := 1;
                                        TempRecord1.Field36 := 1;
                                        TempRecord1.Field34 := 1;
                                        TempRecord1."Enrollment No." := '4';
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        SqNo := 1;
                                    end;
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field11 := RecStudentDegree."Degree Name";
                                    // TempRecord1.Field3 := FORMAT(RecStudentDegree.DateAwarded);
                                    TempRecord1.Field60 := RecStudentDegree."Degree Name";
                                    TempRecord1.Field64 := FORMAT(RecStudentDegree.DateAwarded, 0, '<Month,2>/<Day,2>/<Year4>');
                                    TempRecord1.Field53 := 1;//left-right border
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1.Field35 := 1;//borderstyle
                                    TempRecord1.Field36 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    PrintBorder := true;
                                until RecStudentDegree.Next() = 0;
                            end;
                        until StudentMasterCS.Next() = 0;
                        IF PrintBorder then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field33 := 1;
                            TempRecord1.Field56 := 1;
                            TempRecord1."Enrollment No." := '5';
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                    end;
                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1."Line Spacing 4" := 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1."Transcript End" := '*** End of Transcript ***';
                    TempRecord1.Field70 := 1;
                    TempRecord1.Field72 := 1;
                    TempRecord1.Field32 := 1;
                    TempRecord1.Field33 := 1;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();
                    StudentNo_gTxt := "Student Master-CS"."Original Student No.";
                End;
            end;

            trigger OnPreDataItem()
            begin
                "Student Master-CS".SetCurrentKey("Enrollment Order");
                "Student Master-CS".Ascending(False);
                IF not TranscriptDataFilter then
                    IF EnrollmentNo <> '' then
                        "Student Master-CS".SetRange("Enrollment No.", EnrollmentNo);
                If OriginalStudentNo <> '' then
                    "Student Master-CS".SetRange("Original Student No.", OriginalStudentNo);

                IF GD <> '' then
                    "Student Master-CS".SetRange("Global Dimension 1 Code", GD);

                If CourseCodeFilter <> '' then
                    "Student Master-CS".SetRange("Course Code", CourseCodeFilter);
            end;

            Trigger OnPostDataItem()
            var
                StudentTimeLineRec: Record "Student Time Line";
            begin
                // usersetupapprover.reset();
                // usersetupapprover.SetRange("User ID", userid());
                // usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1|%2', usersetupapprover."Department Approver Type"::"Registrar Department",
                //                             usersetupapprover."Department Approver Type"::" ");
                // if not usersetupapprover.FindFirst() then begin
                //     If not CurrReport.Preview then
                //         Error('Printing Button is Disabled');
                // end;

                //Timeline Code Added === 01-09-2021

                StudentTimeLineRec.InsertRecordFun("Student Master-CS"."Original Student No.", "Student Master-CS"."Student Name", TranscriptTxt + ' for ' + CourseCodeFilter, UserId(), Today());
                //Timeline Code Added === 01-09-2021

                UserSetupRec.Reset();
                UserSetupRec.SetRange("User ID", UserId());
                IF UserSetupRec.FindFirst() then
                    IF not UserSetupRec."Transcript Print Allowed" then
                        IF not CurrReport.Preview then
                            Error('Printing is not allowed');


            end;
        }

        dataitem(TempRecord; "Lesson Master-CS")
        {


            column(Entry_No; "Entry No")
            {

            }
            column(Field31; Field31)
            {

            }
            column(Field32; Field32)
            {

            }
            column(Field33; Field33)
            {

            }
            column(Field35; Field35)
            { }
            column(Field36; Field36)
            { }
            column(Field2; Field2)
            {

            }
            column(Field11; Field11)
            {

            }

            column(Field12; Field12)
            {

            }
            column(Field3; Field3)
            { }
            column(Field13; Field13)
            { }
            column(Field14; Field14)
            { }
            column(Field41; Field41)
            { }
            column(Field37; Field37)
            { }
            column(Field4; Field34)
            { }
            column(Field38; Field38)
            { }
            column(Field39; Field39)
            { }
            column(Field40; Field40)
            { }
            column(Field44; Field44)
            { }
            Column(Field45; Field45)
            { }
            column(Field46; Field46)
            { }
            column(Field47; Field47)
            { }
            column(Field48; Field48)
            { }
            column(Field49; Field49)
            { }
            Column(Field50; Field50)
            { }
            column(Field51; Field51)
            { }
            column(Field52; Field52)
            { }
            column(Field53; Field53)
            { }
            column(Field54; Field54)
            { }
            column(Field55; Field55)
            { }
            column(Field56; Field56)
            { }
            column(Field57; Field57)
            { }
            column(Field61; Field61)
            { }
            column(Field64; Field64)
            { }
            column(Field60; Field60)
            { }
            column(Field65; Field65)
            { }
            column(Field66; Field66)
            { }
            column(Field67; Field67)
            { }
            column(Field68; Field68)
            { }
            column(Field69; Field69)
            { }
            column(Field71; Field71)
            { }
            column(Field70; Field70)
            { }
            column(Field72; Field72)
            { }
            column(CountNum; CountNum)
            { }
            column(Enrollment_No_; "Enrollment No.")
            { }
            column(Field23; Field23)
            { }
            column(Field24; Field24)
            { }

            Column(Line_Spacing_1; "Line Spacing 1")
            { }
            column(Line_Spacing_2; "Line Spacing 2")
            { }
            column(Line_Spacing_3; "Line Spacing 3")
            { }
            column(Line_Spacing_4; "Line Spacing 4")
            { }
            Column(Line_Spacing_5; "Line Spacing 5")
            { }
            Column(Transcript_End; "Transcript End")
            { }

            trigger OnPreDataItem()
            begin
                // TempRecord.SetCurrentKey(Field65, Field66);
                TempRecord.SetCurrentKey("Entry No");
                TempRecord.SetRange("Unique ID", UserId());
            end;
        }

    }
    requestpage
    {

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field("Enrollment No"; EnrollmentNo)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Enrollment No.';
                    //     trigger OnLookup(var Text: Text): Boolean
                    //     begin
                    //         StudentMasterCS.Reset();
                    //         StudentMasterCS.findset();
                    //         IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                    //             EnrollmentNo := StudentMasterCS."Enrollment No.";
                    //     end;
                    // }
                    field("Unofficial Transcript"; UnofficialTranscript)
                    {
                        ApplicationArea = All;
                        Caption = 'Unofficial Transcript';
                        Visible = False;
                    }
                }
                group(OutputOptions)
                {
                    Caption = 'Output Options';
                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;

                        Caption = 'Report Output';
                        ToolTip = 'Specifies the output of the scheduled report, such as PDF or Word.';

                        trigger OnValidate()
                        begin
                            MapOutputMethod;
                        end;
                    }
                    field(OutputMethod; ChosenOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            MapOutputMethod();
            ChosenOutputMethod := SupportedOutputMethod::PDF;

        end;
    }
    trigger OnPreReport()
    begin
        // IF EnrollmentNo = '' THEN
        //     ERROR('Enrollment No must have a value in it');
    End;

    Trigger OnPostReport()
    Begin
        TempRecord1.Reset();
        TempRecord1.SetRange("Unique ID", UserId());
        TempRecord1.DeleteAll();
    End;


    var
        RecEduSetup: Record "Education Setup-CS";
        usersetupapprover: Record "Document Approver Users";
        CourseMaster_gRec: Record "Course Master-CS";
        CourseMaster_gRec1: Record "Course Master-CS";
        CourseMaster_gRec2: Record "Course Master-CS";
        TempRecord1: Record "Lesson Master-CS";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentStatus_gRec: Record "Student Status";
        StudentMasterCS: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        RecStudentHonor: Record "Student Honors";
        RecStudentDegree: Record "Student Degree";
        MainStudentSubject_gRec: Record "Main Student Subject-CS";
        SubjectCategory_gRec: Record "Subject Category Master";
        PassingGrade_gRec: Record "Grade Master-CS";
        SchoolMaster_gRec: Record School;
        UserSetupRec: Record "User Setup";
        StudentMaster_gRec: Record "Student Master-CS";
        StudentStatusMangement: Codeunit "Student Status Mangement";
        EnrollmentNo: Code[20];
        SqNo: Integer;
        EntryNo: Integer;
        TotalPoint: Decimal;
        TotalCredit: Decimal;
        GrandCredit: Decimal;
        GrandPoint: Decimal;
        GrandCredit1: Decimal;
        GrandPoint1: Decimal;
        UnofficialTranscript: Boolean;
        CountNum: Integer;
        AttemptedCreditTxt: Text[100];
        CollegeName: Text[250];
        ShowPrintIfEmailIsMissing: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        QualityPoints_gDec: Decimal;
        TermGPA_gDec: Decimal;
        GrandGPA: Decimal;
        StartDate: Date;

        Status_gTxt: Text;

        RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold";

        Term_gTxt: Integer;
        AcademicYear_gTxt: Text;
        TranscriptTxt: Text;

        StudentNo_gTxt: Text;

        CreditEarned: Decimal;
        OriginalStudentNo: Text;
        TranscriptDataFilter: Boolean;
        GD: Code[20];
        TranscriptDataFilter1: Boolean;

        GPA_gDec: Decimal;
        PrintBorder: Boolean;
        CourseFilter: Text;
        GroupCount: Integer;
        int: Integer;
        InsertedEntry: Integer;
        InProgressClinical: Text;
        AUAGHT: Boolean;
        GFPKey: Boolean;
        GradeConfirmed: Boolean;
        HonorsFinds: Boolean;
        DegreeFinds: Boolean;
        CourseCodeFilter: Code[20];
        RosterFound: Boolean;
        RosterFound1: Boolean;
        RosterFound2: Boolean;
        StatusDate: Text;
        SubjectCode: Text;
        TotalCreditEarned: Decimal;             //CSPL-00116

    procedure CumGPACalculation(SQNum: Integer; TermGPA: Decimal) CUMGPA: Decimal;
    begin
        IF SQNum = 1 then
            CUMGPA := TermGPA / SQNum;
        IF SQNum = 2 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 3 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 4 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 5 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 6 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 7 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 8 then
            CUMGPA := TermGPA / SQNum;

        IF SQNum = 9 then
            CUMGPA := TermGPA / SQNum;
    end;

    procedure GPACredits() GPACrd: Decimal;
    begin
        GPACrd := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
                    "Student Master-CS"."Semester V GPA" + "Student Master-CS"."Semester VI GPA" + "Student Master-CS"."Semester VII GPA" + "Student Master-CS"."Semester VIII GPA" + "Student Master-CS"."Semester IX GPA");
    end;


    procedure CalculateLeftRight(CountNo: Integer) Side: Option " ",Left,Right;
    begin
        IF (CountNum > 0) AND (CountNum <= 45) then
            Side := Side::Left;
        IF (CountNum > 45) AND (CountNum <= 90) then
            Side := Side::Right;
        IF (CountNum > 90) AND (CountNum <= 135) then
            Side := Side::Left;
        IF (CountNum > 135) AND (CountNum <= 180) then
            Side := Side::Right;
        IF (CountNum > 180) AND (CountNum <= 225) then
            Side := Side::Left;
        IF (CountNum > 225) AND (CountNum <= 270) then
            Side := Side::Right;
        IF (CountNum > 270) AND (CountNum <= 315) then
            Side := Side::Left;
        IF (CountNum > 315) AND (CountNum <= 360) then
            Side := Side::Right;
        IF (CountNum > 360) AND (CountNum <= 405) then
            Side := Side::Left;
        IF (CountNum > 405) AND (CountNum <= 450) then
            Side := Side::Right;
    End;

    procedure CalculateLeftRightBasic(CountNo: Integer) Side: Option " ",Left,Right;
    begin
        IF (CountNum > 0) AND (CountNum <= 45) then
            Side := Side::Left;
        IF (CountNum > 45) AND (CountNum <= 90) then
            Side := Side::Right;
        IF (CountNum > 90) AND (CountNum <= 135) then
            Side := Side::Left;
        IF (CountNum > 135) AND (CountNum <= 180) then
            Side := Side::Right;
        IF (CountNum > 180) AND (CountNum <= 225) then
            Side := Side::Left;
        IF (CountNum > 225) AND (CountNum <= 270) then
            Side := Side::Right;
        IF (CountNum > 270) AND (CountNum <= 315) then
            Side := Side::Left;
        IF (CountNum > 315) AND (CountNum <= 360) then
            Side := Side::Right;
        IF (CountNum > 360) AND (CountNum <= 405) then
            Side := Side::Left;
        IF (CountNum > 405) AND (CountNum <= 450) then
            Side := Side::Right;
    End;

    procedure Unofficialvariable(EnrollNo: Code[20]; _OriginalStudentNo: Code[20]; Unofficial: Boolean)
    begin
        UnofficialTranscript := Unofficial;
        EnrollmentNo := EnrollNo;
        OriginalStudentNo := _OriginalStudentNo;
    end;

    procedure Unofficialvariable1(EnrollNo: Code[20]; _OriginalStudentNo: Code[20]; GD1: Code[20]; _CourseCodeFilter: Code[20]; Unofficial: Boolean; TranscriptFilter: Boolean)
    begin
        UnofficialTranscript := Unofficial;
        EnrollmentNo := EnrollNo;
        OriginalStudentNo := _OriginalStudentNo;
        TranscriptDataFilter := TranscriptFilter;
        CourseCodeFilter := _CourseCodeFilter;
        GD := GD1;
    end;

    local procedure MapOutputMethod()
    var
        CustomLayoutReporting: Codeunit "Custom Layout Reporting";
    begin
        ShowPrintIfEmailIsMissing := (SupportedOutputMethod = SupportedOutputMethod::Email);
        // Map the supported option (shown on the page) to the list of supported output methods
        // Most output methods map directly - Word/XML do not, however.
        case SupportedOutputMethod of
            SupportedOutputMethod::XML:
                ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
            else
                ChosenOutputMethod := SupportedOutputMethod;
        end;
    end;
}