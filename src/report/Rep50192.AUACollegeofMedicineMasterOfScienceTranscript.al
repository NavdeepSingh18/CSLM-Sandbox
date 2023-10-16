report 50192 "AUA Col Of Medicine MS"
{
    Caption = 'AUA College of Medicine Official Transcript (Transfer Credit, Legacy Data) Master Of Science';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AUA College of Medicine Master Of Science Transcript.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") Order(ascending);

            column(Filter_Caption1; GETFILTERS())
            { }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            { }
            Column("Institute_Name"; UpperCase(RecEduSetup."Institute Name"))
            { }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            { }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            { }
            column(Country_Code1; RecEduSetup."Institute Country Code")
            { }
            Column("Institute_City"; RecEduSetup."Institute City")
            { }
            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            { }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            { }
            Column("Institute_Email"; RecEduSetup."Institute E-Mail")
            { }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            { }
            column(Student_Name; "Last Name" + ', ' + "First Name" + ' ' + Format(Title))
            { }
            column(Addressee; Addressee)
            { }
            column(Address1; Address1)
            { }
            column(Address2; Address2)
            { }
            column(City; City + ' ' + "Post Code")
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
            column("DegreeAwarded"; RecStudentDegree."Degree Name")
            { }
            column(Status; Status)
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
            Column(Course_Logo; CourseMaster_gRec2."Logo Image")
            { }
            Column(GD; GD)
            { }
            Column(GFPKey; GFPKey)
            { }


            trigger OnAfterGetRecord()
            begin
                GFPKey := false;
                If StudentNo_gTxt <> "Student Master-CS"."Original Student No." then begin
                    GradeConfirmed := false;

                    RecStudentDegree.Reset();
                    RecStudentDegree.SetRange("Student No.", "Student Master-CS"."No.");
                    IF RecStudentDegree.FindFirst() then;

                    CourseMaster_gRec2.Reset();
                    CourseMaster_gRec2.SetRange(Code, "Student Master-CS"."Course Code");
                    IF CourseMaster_gRec2.FindFirst() then
                        CourseMaster_gRec2.CalcFields("Logo Image");

                    RecEduSetup.Reset();
                    RecEduSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF RecEduSetup.FindFirst() then
                        RecEduSetup.CALCFIELDS("Logo Image");

                    IF not UnofficialTranscript then begin
                        UserSetupRec.Reset();
                        UserSetupRec.SetRange("User ID", UserId());
                        IF UserSetupRec.FindFirst() then
                            If not UserSetupRec."Transcript Hold Allowed" then
                                StudentStatusMangement.StudentGroupWiseRestriction("No.", RestrictionType::"Transcript Hold");
                    end;

                    Temprecord1.Reset();
                    TempRecord1.setrange("Unique ID", UserId());
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

                    PrintBorder := false;
                    CountNum := 0;
                    SqNo := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    TermGPA_gDec := 0;
                    TotalCreditAttempt := 0;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("School ID");
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
                    MainStudentSubject.SetRange(Term, MainStudentSubject.Term::" ");
                    If MainStudentSubject.FindSet() then begin
                        // TempRecord1.Init();
                        // EntryNo := EntryNo + 1;
                        // TempRecord1."Entry No" := EntryNo;
                        // TempRecord1.Field55 := 'College of Graduate Studies';
                        // TempRecord1."Line Spacing 5" := 0;
                        // TempRecord1.Field31 := 1;
                        // TempRecord1.Field57 := 1;//Integer
                        // TempRecord1.Field32 := 1;
                        // TempRecord1.Field63 := 0;
                        // CountNum := CountNum + 1;
                        // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        // TempRecord1."Unique ID" := UserId();
                        // TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 6" := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field37 := 1;
                        TempRecord1.Field63 := 0;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credits';
                        TempRecord1."Line Spacing 5" := 1;
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field63 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        PrintBorder := true;
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
                            IF SqNo = 0 then begin

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field52 := 'Credit';
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
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field54 := 'Basic Science';
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
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field50 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            IF AcademicYear_gTxt <> MainStudentSubject."School ID" then begin

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                            end;




                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field14 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;

                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";

                            //04-04-2023---------------Navdeep only for MHS course
                            PassingGrade.Reset();
                            PassingGrade.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            IF PassingGrade.FindFirst() then
                                If PassingGrade."Consider for GPA (MHS)" then
                                    TotalCreditAttempt += MainStudentSubject."Credits Attempt";

                            //04-04-2023---------------Navdeep

                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1."Line Spacing 1" := 1;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field37 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                        until MainStudentSubject.Next() = 0;

                        SqNo := 0;
                        IF SqNo = 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Basic Science Transfer Credits:';
                            TempRecord1.Field14 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field67 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;

                            TotalCredit := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1."Line Spacing 2" := 1;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field37 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;


                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := 'Total Transfer Credits:';
                        TempRecord1.Field14 := FORMAT(GrandCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field70 := 1;
                        TempRecord1.Field67 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 3" := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field37 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                    End;


                    SqNo := 0;
                    AcademicYear_gTxt := '';
                    Term_gTxt := 0;
                    TermGPA_gDec := 0;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetFilter(Term, '<>%1', MainStudentSubject.Term::" ");
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    // MainStudentSubject.SetRange("Category-Course Description", 'MS');
                    // MainStudentSubject.SetRange(TC, false);
                    If MainStudentSubject.FindSet() then begin
                        If not PrintBorder then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field55 := 'College of Graduate Studies';
                            TempRecord1."Line Spacing 5" := 0;
                            TempRecord1.Field31 := 1;
                            TempRecord1.Field57 := 1;//Integer
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field63 := 0;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1."Line Spacing 6" := 1;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field37 := 1;
                            TempRecord1.Field63 := 0;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        // IF UnofficialTranscript = true then
                        //     TempRecord1.Field55 := MainStudentSubject."Category-Course Description"
                        // else
                        TempRecord1.Field55 := 'Master''s of Science Division';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field63 := 1;
                        TempRecord1."Line Spacing 5" := 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        // IF UnofficialTranscript = true then
                        TempRecord1.Field11 := 'MS';
                        // else
                        TempRecord1.Field58 := 'Grade';
                        TempRecord1.Field14 := 'Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field36 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
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
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');

                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;

                                    TotalCredit := 0;

                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field50 := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1."Line Spacing 4" := 1;
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();


                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field14 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field58 := MainStudentSubject.Grade;

                            TempRecord1.Field32 := 0;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";

                            //04-04-2023---------------Navdeep only for MHS course
                            PassingGrade.Reset();
                            PassingGrade.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            IF PassingGrade.FindFirst() then
                                If PassingGrade."Consider for GPA (MHS)" then
                                    TotalCreditAttempt += MainStudentSubject."Credits Attempt";

                            //04-04-2023---------------Navdeep
                            //TotalPoint := TotalPoint + MainStudentSubject."Credit Grade Points Earned";
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field14 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');

                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;

                            TotalCredit := 0;
                            TotalPoint := 0;


                        end;
                    End;
                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1."Line Spacing 7" := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field45 := 1;//Top Border
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();//Space

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;

                    TempRecord1.field38 := 'Attempted Credits';
                    TempRecord1.Field44 := 'Total Credits';
                    TempRecord1.Field45 := 1;//Top Border
                    TempRecord1.Field32 := 1;
                    TempRecord1.Field33 := 1;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.field38 := Format(GrandCredit + GrandCredit1, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    TempRecord1.Field44 := Format(TotalCreditAttempt, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    TempRecord1.Field45 := 0;

                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    StudentNo_gTxt := "Student Master-CS"."Original Student No.";
                end;





            End;

            trigger OnPreDataItem()
            begin
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
        dataitem("Student Honors"; "Student Honors")
        {

            DataItemLinkReference = "Student Master-CS";
            DataItemLink = "Student No." = FIELD("No.");
            column(Honors_Code; "Honors Code")
            { }
            column(Honors_Name; "Honors Name")
            { }

        }
        dataitem("Student Degree"; "Student Degree")
        {
            DataItemTableView = sorting("Degree Code");
            DataItemLinkReference = "Student Master-CS";
            DataItemLink = "Student No." = FIELD("No.");
            column(Degree_Code; "Degree Code")
            { }
            column(Degree_Name; "Degree Name")
            { }
            column(DateAwarded; DateAwarded)
            { }
        }
        dataitem(TempRecord; "Temp Record")
        {
            DataItemTableView = sorting("Entry No");

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
            column(Field3; Field58)
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
            column(Field63; Field63)
            { }
            column(Field64; Field64)
            { }
            column(Field65; Field65)
            { }
            column(Field66; Field66)
            { }
            column(Field67; Field67)
            { }
            column(Field68; Field68)
            { }
            column(Field71; Field71)
            { }
            column(Field70; Field70)
            { }
            column(CountNum; CountNum)
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
            column(Line_Spacing_6; "Line Spacing 6")
            { }
            column(Line_Spacing_7; "Line Spacing 7")
            { }

            trigger OnPreDataItem()
            begin
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

    trigger OnPostReport()
    begin
        TempRecord1.Reset();
        TempRecord1.SetRange("Unique ID", UserId());
        TempRecord1.DeleteAll();
    end;

    var
        RecEduSetup: Record "Education Setup-CS";
        SubjectCategory_gRec: Record "Subject Category Master";
        CourseMaster_gRec: Record "Course Master-CS";
        CourseMaster_gRec1: Record "Course Master-CS";
        SchoolMaster_gRec: Record School;
        TempRecord1: Record "Temp Record";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        RecStudentHonor: Record "Student Honors";
        RecStudentDegree: Record "Student Degree";
        UserSetupRec: Record "User Setup";
        usersetupapprover: Record "Document Approver Users";
        CourseMaster_gRec2: Record "Course Master-CS";
        PassingGrade: Record "Grade Master-CS";
        StudentStatusMangement: Codeunit "Student Status Mangement";

        EnrollmentNo: Code[20];
        SqNo: Integer;
        EntryNo: Integer;
        TotalPoint: Integer;
        TotalCredit: Decimal;
        GrandCredit: Decimal;
        GrandPoint: Integer;
        GrandCredit1: Decimal;
        GrandPoint1: Integer;
        UnofficialTranscript: Boolean;
        CountNum: Integer;
        AttemptedCreditTxt: Text[100];
        ShowPrintIfEmailIsMissing: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold";

        CreditEarned: Decimal;
        AcademicYear_gTxt: Text;
        Term_gTxt: Integer;
        StudentNo_gTxt: Text;

        GrandGPA: Decimal;
        TermGPA_gDec: Decimal;
        QualityPoints_gDec: Decimal;
        OriginalStudentNo: Text;
        TranscriptDataFilter: Boolean;
        GD: Code[20];
        CourseFilter: Text;
        TranscriptDataFilter1: Boolean;
        GPA_gDec: Decimal;
        PrintBorder: Boolean;
        GFPKey: Boolean;
        GradeConfirmed: Boolean;
        CourseCodeFilter: Code[20];
        TranscriptTxt: Text;
        TotalCreditAttempt: Decimal;


    procedure CumGPACalculation(SQNum: Integer) CUMGPA: Decimal;
    begin
        IF SQNum = 1 then
            CUMGPA := "Student Master-CS"."Semester I GPA";

        IF SQNum = 2 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA") / SQNum;

        IF SQNum = 3 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA") / SQNum;

        IF SQNum = 4 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA") / SQNum;

        IF SQNum = 5 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
            "Student Master-CS"."Semester V GPA") / SQNum;

        IF SQNum = 6 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
            "Student Master-CS"."Semester V GPA" + "Student Master-CS"."Semester VI GPA") / SQNum;

        IF SQNum = 7 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
            "Student Master-CS"."Semester V GPA" + "Student Master-CS"."Semester VI GPA" + "Student Master-CS"."Semester VII GPA") / SQNum;

        IF SQNum = 8 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
            "Student Master-CS"."Semester V GPA" + "Student Master-CS"."Semester VI GPA" + "Student Master-CS"."Semester VII GPA" + "Student Master-CS"."Semester VIII GPA") / SQNum;

        IF SQNum = 9 then
            CUMGPA := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
            "Student Master-CS"."Semester V GPA" + "Student Master-CS"."Semester VI GPA" + "Student Master-CS"."Semester VII GPA" + "Student Master-CS"."Semester VIII GPA" + "Student Master-CS"."Semester VIII GPA") / SQNum;
    end;

    procedure GPACredits() GPACrd: Decimal;
    begin
        GPACrd := ("Student Master-CS"."Semester I GPA" + "Student Master-CS"."Semester II GPA" + "Student Master-CS"."Semester III GPA" + "Student Master-CS"."Semester IV GPA" +
                    "Student Master-CS"."Semester V GPA" + "Student Master-CS"."Semester VI GPA" + "Student Master-CS"."Semester VII GPA" + "Student Master-CS"."Semester VIII GPA" + "Student Master-CS"."Semester IX GPA");
    end;

    // procedure CalculateLeftRight(CountNo: Integer) Side: Option " ",Left,Right;
    // begin
    //     IF (CountNum > 0) AND (CountNum <= 20) then
    //         Side := Side::Left;
    //     IF (CountNum > 20) AND (CountNum <= 40) then
    //         Side := Side::Right;
    //     IF (CountNum > 40) AND (CountNum <= 60) then
    //         Side := Side::Left;
    //     IF (CountNum > 60) AND (CountNum <= 80) then
    //         Side := Side::Right;
    //     IF (CountNum > 80) AND (CountNum <= 100) then
    //         Side := Side::Left;
    //     IF (CountNum > 100) AND (CountNum <= 120) then
    //         Side := Side::Right;
    //     IF (CountNum > 120) AND (CountNum <= 140) then
    //         Side := Side::Left;
    //     IF (CountNum > 140) AND (CountNum <= 160) then
    //         Side := Side::Right;
    //     IF (CountNum > 160) AND (CountNum <= 180) then
    //         Side := Side::Left;
    //     IF (CountNum > 180) AND (CountNum <= 200) then
    //         Side := Side::Right;
    //     IF (CountNum > 200) AND (CountNum <= 220) then
    //         Side := Side::Left;
    //     IF (CountNum > 220) AND (CountNum <= 240) then
    //         Side := Side::Right;
    //     IF (CountNum > 240) AND (CountNum <= 260) then
    //         Side := Side::Left;
    // End;
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


    // procedure CalculateLeftRightBasic(CountNo: Integer) Side: Option " ",Left,Right;
    // begin
    //     IF (CountNum > 0) AND (CountNum <= 28) then
    //         Side := Side::Left;
    //     IF (CountNum > 28) AND (CountNum <= 56) then
    //         Side := Side::Right;
    //     IF (CountNum > 56) AND (CountNum <= 84) then
    //         Side := Side::Left;
    //     IF (CountNum > 84) AND (CountNum <= 112) then
    //         Side := Side::Right;
    //     IF (CountNum > 112) AND (CountNum <= 140) then
    //         Side := Side::Left;
    //     IF (CountNum > 140) AND (CountNum <= 168) then
    //         Side := Side::Right;
    //     IF (CountNum > 168) AND (CountNum <= 196) then
    //         Side := Side::Left;
    //     IF (CountNum > 196) AND (CountNum <= 224) then
    //         Side := Side::Right;
    //     IF (CountNum > 224) AND (CountNum <= 252) then
    //         Side := Side::Left;
    //     IF (CountNum > 252) AND (CountNum <= 280) then
    //         Side := Side::Right;
    // End;
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