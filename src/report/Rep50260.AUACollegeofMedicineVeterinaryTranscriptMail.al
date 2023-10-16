report 50260 AUAMVeterinaryTranscriptMail
{
    Caption = 'AUA College of Medicine Official Transcript (Transfer Credit, Legacy Data) Veterinary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AUAMVeterinaryTranscriptMail.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    //ApplicationArea = All;

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
            Column("Institute_City"; RecEduSetup."Institute City")
            { }
            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            { }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            { }
            Column("Institute_Email"; RecEduSetup.url)
            { }
            column(Country_Code1; RecEduSetup."Institute Country Code")
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
            column(City; City + ', ' + State + ' ' + "Post Code")
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
                IF StudentNo_gTxt <> "Student Master-CS"."Original Student No." then begin
                    GradeConfirmed := false;

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
                    CourseMaster_gRec1.SetRange("Transcript Data Filter", True);
                    IF CourseMaster_gRec1.FindSet() then begin
                        repeat
                            If CourseFilter = '' then
                                CourseFilter := CourseMaster_gRec1.Code
                            Else
                                CourseFilter += '|' + CourseMaster_gRec1.Code;
                        until CourseMaster_gRec1.Next() = 0;
                    end;


                    SqNo := 0;
                    TermGPA_gDec := 0;
                    AcademicYear_gTxt := '';
                    CreditEarned := 0;
                    Term_gTxt := 0;
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
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'VETERINARY');
                    MainStudentSubject.SetRange(TC, true);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field55 := 'Transfer Credit';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field58 := 'Credit';
                        TempRecord1.Field31 := 1;
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
                            IF AcademicYear_gTxt <> MainStudentSubject."School ID" then begin
                                IF SqNo = 0 then begin


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    // SubjectCategory_gRec.Reset();
                                    // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    // IF SubjectCategory_gRec.FindFirst() then
                                    //     TempRecord1.Field54 := SubjectCategory_gRec."Category Description";
                                    TempRecord1.Field54 := 'Veterinary';
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field37 := 1;
                                    //TempRecord1.Field61 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1."Line Spacing 1" := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                end;

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
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."School ID";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'Veterinary Transfer Credits:';
                            //TempRecord1.Field12 := Format(TotalCredit);
                            // TempRecord1.Field13 := Format(TotalPoint);
                            // TempRecord1.Field14 := FORMAT("Student Master-CS"."Net Semester CGPA");
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field70 := 1;
                            TempRecord1.Field67 := 1;
                            TempRecord1.Field63 := 1;
                            TempRecord1.Field68 := 0;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            //GrandPoint := GrandPoint + TotalPoint;
                            TotalCredit := 0;
                            //TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1."Line Spacing 2" := 1;
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Field63 := 0;
                            TempRecord1.Field68 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1.Insert();
                        end;
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := 'Total Transfer Credits:';
                        TempRecord1.Field12 := FORMAT(GrandCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field70 := 1;
                        TempRecord1.Field67 := 1;
                        TempRecord1.Field63 := 1;
                        TempRecord1.Field68 := 0;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field45 := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                    End;


                    SqNo := 0;
                    TermGPA_gDec := 0;
                    GrandGPA := 0;
                    AcademicYear_gTxt := '';
                    Term_gTxt := 0;
                    CreditEarned := 0;
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
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange("Category-Course Description", 'VETERINARY');
                    MainStudentSubject.SetRange(TC, false);
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;

                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then begin
                            If UnofficialTranscript then
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description" + ' ' + 'Courses'
                            Else
                                TempRecord1.Field55 := SubjectCategory_gRec."Category Description" + ' ' + 'Courses';
                        end;
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field57 := 1;//Integer
                        TempRecord1.Field32 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field11 := 'A';
                        TempRecord1.Field52 := 'Grade';
                        TempRecord1.Field12 := 'Credit';
                        TempRecord1.Field13 := 'QP';
                        TempRecord1.Field14 := 'GPA';
                        TempRecord1.Field31 := 0;
                        TempRecord1.Field62 := 1;
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
                                    TempRecord1.Field11 := 'A';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    IF CreditEarned <> 0 then
                                        TempRecord1.Field14 := FORMAT(Round(TotalPoint / CreditEarned), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        TempRecord1.Field14 := Format(0.00);
                                    TempRecord1.Field31 := 1;
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field63 := 1;
                                    TempRecord1.Field68 := 0;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    If CreditEarned <> 0 then
                                        TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                                    GrandGPA += CreditEarned;
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;


                                end;

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 3;


                                If ((InsertedEntry + GroupCount) > 45) and (EntryNo <= 45) then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
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

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;

                                    SubjectCategory_gRec.Reset();
                                    SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                    IF SubjectCategory_gRec.FindFirst() then begin
                                        If UnofficialTranscript then
                                            TempRecord1.Field55 := SubjectCategory_gRec."Category Description" + ' ' + 'Courses'
                                        Else
                                            TempRecord1.Field55 := SubjectCategory_gRec."Category Description" + ' ' + 'Courses';
                                    end;
                                    TempRecord1.Field31 := 1;
                                    TempRecord1.Field57 := 1;//Integer
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1."Line Spacing 5" := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := 'A';
                                    TempRecord1.Field52 := 'Grade';
                                    TempRecord1.Field12 := 'Credit';
                                    TempRecord1.Field13 := 'QP';
                                    TempRecord1.Field14 := 'GPA';
                                    TempRecord1.Field62 := 1;
                                    TempRecord1.Field31 := 0;
                                    TempRecord1.Field57 := 1;//Integer
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                end;

                                // If (InsertedEntry + GroupCount) > 80 then begin
                                //     For int := 1 to (80 - InsertedEntry) do begin
                                //         TempRecord1.Init();
                                //         EntryNo := EntryNo + 1;
                                //         TempRecord1."Entry No" := EntryNo;
                                //         TempRecord1.Field34 := 1;
                                //         CountNum := CountNum + 1;
                                //         TempRecord1.Field45 := 1;
                                //         TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                //         TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                //         TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                //         TempRecord1."Unique ID" := UserId();
                                //         TempRecord1.Insert();
                                //         InsertedEntry += 1;
                                //     end;

                                //     TempRecord1.Init();
                                //     EntryNo := EntryNo + 1;
                                //     TempRecord1."Entry No" := EntryNo;

                                //     SubjectCategory_gRec.Reset();
                                //     SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                //     IF SubjectCategory_gRec.FindFirst() then begin
                                //         If UnofficialTranscript then
                                //             TempRecord1.Field55 := SubjectCategory_gRec."Category Description" + ' ' + 'Courses'
                                //         Else
                                //             TempRecord1.Field55 := SubjectCategory_gRec."Category Description" + ' ' + 'Courses';
                                //     end;
                                //     TempRecord1.Field31 := 1;
                                //     TempRecord1.Field57 := 1;//Integer
                                //     TempRecord1.Field32 := 1;
                                //     CountNum := CountNum + 1;
                                //     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                //     TempRecord1."Unique ID" := UserId();
                                //     TempRecord1.Insert();

                                //     TempRecord1.Init();
                                //     EntryNo := EntryNo + 1;
                                //     TempRecord1."Entry No" := EntryNo;
                                //     TempRecord1.Field11 := 'A';
                                //     TempRecord1.Field52 := 'Grade';
                                //     TempRecord1.Field12 := 'Credit';
                                //     TempRecord1.Field13 := 'QP';
                                //     TempRecord1.Field14 := 'GPA';
                                //     TempRecord1.Field62 := 1;
                                //     TempRecord1.Field31 := 0;
                                //     TempRecord1.Field57 := 1;//Integer
                                //     TempRecord1.Field32 := 1;
                                //     CountNum := CountNum + 1;
                                //     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                //     TempRecord1."Unique ID" := UserId();
                                //     TempRecord1.Insert();

                                // end;

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 3;

                                If (InsertedEntry + GroupCount) > 45 then begin
                                    For int := 1 to (45 - InsertedEntry) do begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
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
                                TempRecord1."Line Spacing 1" := 1;
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
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field52 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                If PassingGrade_gRec."Consider for GPA" then
                                    CreditEarned += MainStudentSubject."Credits Attempt";
                                CourseMaster_gRec.Reset();
                                CourseMaster_gRec.SetRange(Code, MainStudentSubject.Course);
                                IF CourseMaster_gRec.FindFirst() then begin
                                    IF CourseMaster_gRec."Show Grade Description" then begin
                                        IF PassingGrade_gRec."Show Grade Description" then
                                            TempRecord1.Field52 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field52 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field52 := PassingGrade_gRec.Code;
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := 'A';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            If CreditEarned <> 0 then
                                TempRecord1.Field14 := FORMAT((Round(TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                            Else
                                TempRecord1.Field14 := Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field31 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field63 := 1;
                            TempRecord1.Field68 := 0;
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
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                IF GrandGPA <> 0 then
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(Round((GrandPoint + GrandPoint1) / GrandGPA), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    TempRecord1.Field51 := 'Veterinary Cumulative GPA:' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                        end;
                    End;

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1."Line Spacing 4" := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field45 := 1;//Top Border
                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();


                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;

                    // TempRecord1.Field11 := 'Attempted Credits:' + ' ' + Format(GrandCredit + GrandCredit1) + '  ' + 'GPA Credits:' + ' ' + Format(GPACredits());
                    //TempRecord1.Field3 := 'GPA CREDITS';
                    TempRecord1.field38 := 'Attempted Credits';
                    TempRecord1.Field39 := 'GPA Credits';
                    TempRecord1.Field40 := 'GPA QPts';
                    TempRecord1.Field44 := 'Final GPA';
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
                    //TempRecord1.Field11 := 'GPA QPTs:' + ' ' + Format(GrandPoint + GrandPoint1) + '  ' + 'Final GPA :' + ' ' + Format("Student Master-CS"."Net Semester CGPA");
                    //TempRecord1.Field3 := Format(GPACredits());
                    //TempRecord1.Field12 := Format(GrandPoint + GrandPoint1);
                    //TempRecord1.Field13 := Format("Student Master-CS"."Net Semester CGPA");
                    TempRecord1.field38 := Format(GrandCredit + GrandCredit1, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');

                    TempRecord1.Field39 := FORMAT(GrandGPA, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');

                    TempRecord1.Field40 := Format(GrandPoint + GrandPoint1, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    If (GrandGPA) <> 0 then
                        TempRecord1.Field44 := FORMAT(Round((GrandPoint + GrandPoint1) / (GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    Else
                        TempRecord1.Field44 := FORMAT(0.00);

                    GPA_gDec := 0;
                    IF GrandGPA <> 0 then
                        GPA_gDec := Round((GrandPoint + GrandPoint1) / GrandGPA);
                    TempRecord1.Field45 := 0;
                    //TempRecord1.Field32 := 1;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();



                    InsertedEntry := 0;
                    InsertedEntry := EntryNo;
                    If EntryNo >= 85 then begin
                        For int := 1 to (90 - InsertedEntry) do begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                    RecStudentHonor.Reset();
                    RecStudentHonor.SetRange("Student No.", "No.");
                    // RecStudentHonor.SetFilter("Min. Range", '<=%1', GPA_gDec);
                    // RecStudentHonor.SetFilter("Max. Range", '>=%1', GPA_gDec);
                    IF RecStudentHonor.FindFirst() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        //TempRecord1.Field11 := 'Honors:' + '  ' + RecStudentHonor."Honors Name";
                        TempRecord1.Field46 := 'Honors:';
                        TempRecord1.field47 := RecStudentHonor."Honors Name";
                        TempRecord1.field50 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                    end;

                    SqNo := 0;
                    StudentMaster_gRec.Reset();
                    StudentMaster_gRec.SetRange("Global Dimension 1 Code", GD);
                    IF not TranscriptDataFilter then
                        StudentMaster_gRec.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                    StudentMaster_gRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    // IF CourseFilter <> '' then
                    //     StudentMaster_gRec.SetFilter("Course Code", CourseFilter)
                    // Else
                    StudentMaster_gRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                    IF StudentMaster_gRec.FindSet() then begin
                        repeat


                            RecStudentDegree.Reset();
                            RecStudentDegree.SetRange("Student No.", StudentMaster_gRec."No.");
                            RecStudentDegree.SetRange("Global Dimension 1 Code", GD);
                            If not TranscriptDataFilter then
                                RecStudentDegree.SetRange("Enrollment No.", StudentMaster_gRec."Enrollment No.");
                            //RecStudentDegree.SetRange("Degree Code", 'ASN');
                            IF RecStudentDegree.Findset() then begin

                                repeat
                                    IF SqNo = 0 then begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        //TempRecord1.Field11 := 'AWARDED';
                                        TempRecord1.field48 := 'Awarded';
                                        TempRecord1.Field34 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field33 := 1;
                                        TempRecord1.Field35 := 1;
                                        TempRecord1."Enrollment No." := '1';
                                        TempRecord1.Field53 := 1;//left-right border
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();

                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        //TempRecord1.Field3 := 'DATE AWARDED';
                                        TempRecord1.field49 := 'Date Awarded';
                                        TempRecord1.Field53 := 1;//left-right border
                                                                 //TempRecord1.Field50 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field35 := 1;
                                        TempRecord1.Field36 := 1;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1."Enrollment No." := '2';
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        SqNo := 1;
                                    end;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field11 := RecStudentDegree."Degree Name";
                                    // TempRecord1.Field3 := FORMAT(RecStudentDegree.DateAwarded);
                                    TempRecord1.Field60 := RecStudentDegree."Degree Name";
                                    TempRecord1.Field64 := FORMAT(RecStudentDegree.DateAwarded);
                                    TempRecord1.Field53 := 1;//left-right border
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1.Field35 := 1;//borderstyle
                                    TempRecord1.Field36 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    PrintBorder := true;
                                until RecStudentDegree.Next() = 0;
                            end;
                        until StudentMaster_gRec.Next() = 0;
                        IF PrintBorder then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field33 := 1;
                            TempRecord1.Field56 := 1;
                            TempRecord1."Enrollment No." := '3';
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;

                    end;

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
            column(Field3; Field52)
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
            column(Field58; Field58)
            { }
            column(Field61; Field61)
            { }
            column(Field62; Field62)
            { }
            column(Field63; Field63)
            { }

            column(Field64; Field64)
            { }
            Column(Field60; Field60)
            { }
            column(Enrollment_No_; "Enrollment No.")
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
        StudentMaster_gRec: Record "Student Master-CS";
        TempRecord1: Record "Temp Record";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        RecStudentHonor: Record "Student Honors";
        RecStudentDegree: Record "Student Degree";
        CourseMaster_gRec: Record "Course Master-CS";
        CourseMaster_gRec1: Record "Course Master-CS";
        CourseMaster_gRec2: Record "Course Master-CS";
        PassingGrade_gRec: Record "Grade Master-CS";
        usersetupapprover: Record "Document Approver Users";
        SchoolMaster_gRec: Record School;
        SubjectCategory_gRec: Record "Subject Category Master";
        UserSetupRec: Record "User Setup";
        MainStudentSubject_gRec: Record "Main Student Subject-CS";
        StudentStatusMangement: Codeunit "Student Status Mangement";
        EnrollmentNo: Code[20];
        SqNo: Integer;
        EntryNo: Integer;
        PrintBorder: Boolean;

        TotalPoint: Decimal;
        TotalCredit: Decimal;
        GrandCredit: Decimal;
        GrandPoint: Decimal;
        GrandCredit1: Decimal;
        GrandPoint1: Decimal;
        UnofficialTranscript: Boolean;
        CountNum: Integer;
        AttemptedCreditTxt: Text[100];
        ShowPrintIfEmailIsMissing: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        QualityPoints_gDec: Decimal;
        TermGPA_gDec: Decimal;
        GrandGPA: Decimal;

        RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold";
        CreditEarned: Decimal;
        AcademicYear_gTxt: Text;
        Term_gTxt: Integer;
        OriginalStudentNo: Text;
        TranscriptDataFilter: Boolean;
        GD: Code[20];
        TranscriptDataFilter1: Boolean;
        StudentNo_gTxt: Text;
        GPA_gDec: Decimal;
        CourseFilter: Text;
        GroupCount: Integer;
        int: Integer;
        InsertedEntry: Integer;
        ShowBold: Boolean;
        ShowBold1: Boolean;
        GFPKey: Boolean;
        GradeConfirmed: Boolean;
        CourseCodeFilter: Code[20];
        TranscriptTxt: Text;

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