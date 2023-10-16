report 50008 AICASAEMTTranscript2
{
    Caption = 'AICASA EMT Transcript';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AICASAEMTTranscript2.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") Order(ascending);
            column(Filter_Caption1; GETFILTERS())
            {

            }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column("Institute_Name"; Uppercase(RecEduSetup."Institute Name"))
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }

            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup.url)
            {

            }
            column(Country_Code1; RecEduSetup."Institute Country Code")
            { }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }

            column(Student_Name; "Student Name")
            {

            }
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
            column(Estimated_Graduation_Date; "Estimated Graduation Date")
            { }
            column("DegreeAwarded"; "Course Name")
            { }
            column(Status; Status)
            { }
            column(UnofficialTranscript; UnofficialTranscript)
            { }
            column(Date_Awarded; "Date Awarded")
            { }

            Column(Course_Logo; CourseMaster_gRec2."Logo Image")
            { }

            Column(GD; GD)
            { }
            trigger OnAfterGetRecord()
            var
                AdvanceCourseCheck: Boolean;
            begin
                //UnofficialTranscript := True;

                If StudentNo_gTxt <> "Student Master-CS"."Original Student No." then begin

                    GradeConfirmed := false;
                    CourseMaster_gRec2.Reset();
                    CourseMaster_gRec2.SetRange(Code, "Student Master-CS"."Course Code");
                    IF CourseMaster_gRec2.FindFirst() then
                        CourseMaster_gRec2.CalcFields("Logo Image");

                    EMTAdvanced := False;
                    EMTBasic := False;
                    RecEduSetup.Reset();
                    RecEduSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF RecEduSetup.FindFirst() then
                        RecEduSetup.CALCFIELDS("Logo Image");

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
                    CourseMaster_gRec1.SetRange("EMT Transcript", true);
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
                    Term_gTxt := 0;
                    CreditEarned := 0;
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
                    MainStudentSubject.SetRange("Category-Course Description", 'EMT-BASIC');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field54 := UpperCase(SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field54 := UpperCase(SubjectCategory_gRec."Category Description");
                        TempRecord1.Field53 := 1;//Integer
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            AdvanceCourseCheck := False;
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then begin
                                IF CourseMaster_gRec1."EMT Transcript" then
                                    TranscriptDataFilter1 := true;
                                If CourseMaster_gRec1."Advance Course(EMT)" then
                                    AdvanceCourseCheck := true;
                            end;

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
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field39 := 'Attempted Credits: ';// + '' + Format(TotalCredit) + '  ' + 'GPA Credits:' + '' + Format(CreditEarned);
                                    TempRecord1.Field40 := 'GPA Credits: ';
                                    TempRecord1.Field23 := TotalCredit;
                                    TempRecord1.Field24 := CreditEarned;
                                    TempRecord1."Enrollment No." := '1';
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field33 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1.Field50 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;

                                    TempRecord1.Field39 := 'GPA QPTs: ';// + '' + Format(TotalPoint) + '  ' + 'GPA :' + '' + Format(Round(TotalPoint / CreditEarned))
                                    TempRecord1.Field40 := 'GPA :';
                                    TempRecord1.Field23 := TotalPoint;
                                    If CreditEarned <> 0 then
                                        TempRecord1.Field24 := Round(TotalPoint / CreditEarned)
                                    Else
                                        TempRecord1.Field24 := 0;
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1."Enrollment No." := '2';
                                    //TempRecord1.field50 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
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

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field55 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
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
                            //TempRecord1.Field3 := MainStudentSubject.Grade;

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
                                            TempRecord1.Field3 := PassingGrade_gRec.Description
                                        Else
                                            TempRecord1.Field3 := PassingGrade_gRec.Code;
                                    end Else
                                        TempRecord1.Field3 := PassingGrade_gRec.Code;
                                end;
                            end;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
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
                            Term_gTxt := MainStudentSubject."Term Sequence";
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                        until MainStudentSubject.Next() = 0;


                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            If CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;
                            // TotalCredit := 0;
                            //TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field56 := 1;//Integer
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field39 := 'Attempted Credits: ';// + '' + Format(TotalCredit) + '  ' + 'GPA Credits:' + '' + Format(CreditEarned);
                            TempRecord1.Field40 := 'GPA Credits: ';
                            TempRecord1.Field23 := TotalCredit;
                            TempRecord1.Field24 := CreditEarned;
                            TempRecord1.Field32 := 1;
                            TempRecord1."Enrollment No." := '1';
                            TempRecord1.Field33 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field50 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;

                            TempRecord1.Field39 := 'GPA QPTs: ';// + '' + Format(TotalPoint) + '  ' + 'GPA :' + '' + Format(Round(TotalPoint / CreditEarned))
                            TempRecord1.Field40 := 'GPA :';
                            TempRecord1.Field23 := TotalPoint;
                            If CreditEarned <> 0 then
                                TempRecord1.Field24 := Round((TotalPoint) / CreditEarned)
                            Else
                                TempRecord1.Field24 := 0;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            //TempRecord1.field50 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1."Enrollment No." := '2';
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                            TempRecord1."Line Spacing 2" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                        EMTBasic := True;
                    End;

                    //CountNum := 0;
                    SqNo := 0;
                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    GrandPoint := 0;
                    GrandPoint1 := 0;
                    GrandGPA := 0;
                    GrandCredit := 0;
                    GrandCredit1 := 0;
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
                    MainStudentSubject.SetRange("Category-Course Description", 'EMT-ADV');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field54 := UpperCase(SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field54 := UpperCase(SubjectCategory_gRec."Category Description");

                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            AdvanceCourseCheck := False;
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then begin
                                IF CourseMaster_gRec1."EMT Transcript" then
                                    TranscriptDataFilter1 := true;
                                If CourseMaster_gRec1."Advance Course(EMT)" then
                                    AdvanceCourseCheck := true;
                            end;

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
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field39 := 'Attempted Credits: ';// + '' + Format(TotalCredit) + '  ' + 'GPA Credits:' + '' + Format(CreditEarned);
                                    TempRecord1.Field40 := 'GPA Credits: ';
                                    TempRecord1.Field23 := TotalCredit;
                                    TempRecord1.Field24 := CreditEarned;
                                    TempRecord1."Enrollment No." := '1';
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field33 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1.Field50 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;

                                    TempRecord1.Field39 := 'GPA QPTs: ';// + '' + Format(TotalPoint) + '  ' + 'GPA :' + '' + Format(Round(TotalPoint / CreditEarned))
                                    TempRecord1.Field40 := 'GPA: ';
                                    TempRecord1.Field23 := TotalPoint;
                                    IF CreditEarned <> 0 then
                                        TempRecord1.Field24 := TotalPoint
                                    Else
                                        TempRecord1.field24 := Round(TotalPoint / CreditEarned);
                                    TempRecord1."Enrollment No." := '2';
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    //TempRecord1.field50 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
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

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                IF Not AdvanceCourseCheck then
                                    TempRecord1.Field55 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                Else
                                    TempRecord1.Field55 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'EMT';
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
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
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            TempRecord1.Field34 := 1;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            If CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;
                            //CreditEarned := 0;
                            //TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field39 := 'Attempted Credits: ';// + '' + Format(TotalCredit) + '  ' + 'GPA Credits:' + '' + Format(CreditEarned);
                            TempRecord1.Field40 := 'GPA Credits: ';
                            TempRecord1.Field23 := TotalCredit;
                            TempRecord1.Field24 := CreditEarned;
                            TempRecord1."Enrollment No." := '1';
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field33 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field50 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;

                            TempRecord1.Field39 := 'GPA QPTs:'; //+ '' + Format(TotalPoint) + '  ' + 'GPA :' + '' + Format(Round(TotalPoint / CreditEarned))
                            TempRecord1.Field40 := 'GPA: ';
                            TempRecord1.Field23 := (TotalPoint);
                            IF CreditEarned <> 0 then
                                TempRecord1.Field24 := Round((TotalPoint) / CreditEarned)
                            Else
                                TempRecord1.Field24 := 0;
                            TempRecord1."Enrollment No." := '2';
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            //TempRecord1.field50 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                            TempRecord1."Line Spacing 2" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                        end;
                        EMTAdvanced := True;
                    end;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    GrandCredit := 0;
                    GrandCredit1 := 0;
                    GrandGPA := 0;
                    GrandPoint := 0;
                    GrandPoint1 := 0;
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
                    MainStudentSubject.SetRange("Category-Course Description", 'EMERGENCY TECHNICIAN');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field54 := UpperCase(SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field54 := UpperCase(SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                        repeat
                            AdvanceCourseCheck := False;
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then begin
                                IF CourseMaster_gRec1."EMT Transcript" then
                                    TranscriptDataFilter1 := true;
                                If CourseMaster_gRec1."Advance Course(EMT)" then
                                    AdvanceCourseCheck := true;
                            end;

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
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                    IF SqNo = 1 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditEarned = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditEarned = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field39 := 'Attempted Credits: '; //+ '' + Format(CreditEarned) + '  ' + 'GPA Credits:' + '' + Format(CreditEarned);
                                    TempRecord1.Field40 := 'GPA Credits: ';
                                    TempRecord1.Field23 := TotalCredit;
                                    TempRecord1.Field24 := CreditEarned;
                                    TempRecord1."Enrollment No." := '1';
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field33 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1.Field50 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1.Code := Format(EntryNo);
                                    TempRecord1."Entry No" := EntryNo;

                                    TempRecord1.Field39 := 'GPA QPTs: ';// + '' + Format(TotalPoint) + '  ' + 'GPA :' + '' + Format(Round(TotalPoint / CreditEarned))
                                    TempRecord1.Field40 := 'GPA: ';
                                    TempRecord1.Field23 := TotalPoint;
                                    IF CreditEarned <> 0 then
                                        TempRecord1.Field24 := Round(TotalPoint / CreditEarned)
                                    Else
                                        TempRecord1.Field24 := 0;
                                    TempRecord1."Enrollment No." := '2';
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    //TempRecord1.field50 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
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

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                If AdvanceCourseCheck then
                                    TempRecord1.Field55 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'EMT'
                                Else
                                    TempRecord1.Field55 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
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

                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 0;
                            TempRecord1.Field34 := 1;
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            If CreditEarned <> 0 then
                                TermGPA_gDec += (Round(TotalPoint / CreditEarned));

                            GrandGPA += CreditEarned;
                            //CreditEarned := 0;
                            //TotalPoint := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            IF SqNo = 1 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditEarned <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditEarned = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round((TotalPoint / CreditEarned)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditEarned = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field52 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field57 := 1;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field39 := 'Attempted Credits: ';// + '' + Format(TotalCredit) + '  ' + 'GPA Credits:' + '' + Format(CreditEarned);
                            TempRecord1.Field40 := 'GPA Credits: ';
                            TempRecord1.Field23 := TotalCredit;
                            TempRecord1.Field24 := CreditEarned;
                            TempRecord1."Enrollment No." := '1';
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field33 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field50 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1.Code := Format(EntryNo);
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field39 := 'GPA QPTs: ';// + '' + Format(TotalPoint) + '  ' + 'GPA :' + '' + Format(Round(TotalPoint / CreditEarned))
                            TempRecord1.Field40 := 'GPA: ';
                            TempRecord1.Field23 := (TotalPoint);
                            If CreditEarned <> 0 then
                                TempRecord1.Field24 := Round((TotalPoint) / CreditEarned)
                            Else
                                TempRecord1.Field24 := 0;
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1."Enrollment No." := '2';
                            //TempRecord1.field50 := 1;
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
                            TempRecord1."Line Spacing 2" := 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;
                        EMTAdvanced := True;
                        EMTBasic := True;
                    end;
                    GPA_gDec := 0;
                    IF CreditEarned <> 0 then
                        GPA_gDec := Round(TotalPoint / CreditEarned)
                    Else
                        GPA_gDec := 0;

                    // TempRecord1.Init();
                    // EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    // TempRecord1."Entry No" := EntryNo;
                    // TempRecord1.Field32 := 0;
                    // //TempRecord1.Field35 := 1;
                    // TempRecord1.Field36 := 1;
                    // TempRecord1.Field34 := 1;
                    // CountNum := CountNum + 1;
                    // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    // TempRecord1."Unique ID" := UserId();
                    // TempRecord1.Insert();//Space

                    RecStudentHonor.Reset();
                    RecStudentHonor.SetRange("Student No.", "Student Master-CS"."No.");
                    // RecStudentHonor.SetFilter("Min. Range", '<=%1', GPA_gDec);
                    // RecStudentHonor.SetFilter("Max. Range", '>=%1', GPA_gDec);
                    IF RecStudentHonor.FindFirst() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1.Code := Format(EntryNo);
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field58 := 'Honors:' + '  ' + RecStudentHonor."Honors Name";
                        TempRecord1.Field32 := 1;
                        //TempRecord1.Field33 := 1;
                        TempRecord1.Field34 := 1;

                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();
                    end;


                    SqNo := 0;
                    IF EMTBasic = TRUE then begin
                        StudentMaster_gRec.Reset();
                        StudentMaster_gRec.SetRange("Global Dimension 1 Code", GD);
                        IF not TranscriptDataFilter then begin
                            StudentMaster_gRec.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                            StudentMaster_gRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                        end Else
                            StudentMaster_gRec.SetFilter("Course Code", CourseFilter);
                        StudentMaster_gRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                        // IF CourseFilter <> '' then
                        //     StudentMaster_gRec.SetFilter("Course Code", CourseFilter)
                        // Else

                        IF StudentMaster_gRec.FindSet() then begin

                            repeat

                                RecStudentDegree.Reset();
                                RecStudentDegree.SetRange("Student No.", StudentMaster_gRec."No.");
                                RecStudentDegree.SetFilter("Degree Code", '=%1|=%2|=%3|=%4', 'EMTBL', 'EMTFR', 'EMTPA', 'EMTPD');
                                IF Not TranscriptDataFilter then
                                    RecStudentDegree.SetRange("Enrollment No.", StudentMaster_gRec."Enrollment No.");
                                RecStudentDegree.Setrange("Global Dimension 1 Code", GD);
                                IF RecStudentDegree.FindFirst() then begin


                                    repeat
                                        IF SqNo = 0 then begin
                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1.Code := Format(EntryNo);
                                            TempRecord1."Entry No" := EntryNo;
                                            TempRecord1.Field64 := 'Awarded';
                                            TempRecord1.Field32 := 1;
                                            TempRecord1.Field33 := 1;
                                            TempRecord1.Field34 := 1;
                                            //TempRecord1.Field35 := 1;
                                            // TempRecord1.Field61 := 1;
                                            TempRecord1.Field63 := 1;
                                            TempRecord1.Field69 := 1;
                                            TempRecord1."Enrollment No." := '6';
                                            CountNum := CountNum + 1;
                                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();

                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1.Code := Format(EntryNo);
                                            TempRecord1."Entry No" := EntryNo;
                                            TempRecord1.Field65 := 'Date Awarded';
                                            TempRecord1.Field32 := 0;
                                            TempRecord1.Field35 := 1;
                                            TempRecord1.Field36 := 1;
                                            TempRecord1.Field34 := 1;
                                            // TempRecord1.Field61 := 1;
                                            TempRecord1.Field63 := 1;
                                            CountNum := CountNum + 1;
                                            TempRecord1.Field69 := 1;
                                            TempRecord1."Enrollment No." := '7';
                                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();
                                            SqNo := 1;
                                        end;
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field47 := RecStudentDegree."Degree Name";//'EMT - BASIC LEVEL'
                                        TempRecord1.Field48 := FORMAT(RecStudentDegree.DateAwarded, 0, '<Month,2>/<Day,2>/<Year4>');
                                        //TempRecord1.Field61 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field34 := 1;
                                        TempRecord1.Field35 := 1;//borderstyle
                                        TempRecord1.Field36 := 1;

                                        TempRecord1.Field63 := 1;
                                        TempRecord1.Field69 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        PrintBorder1 := True;
                                    until RecStudentDegree.Next() = 0;
                                end;
                            until StudentMaster_gRec.Next() = 0;
                            If PrintBorder1 then begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field33 := 1;
                                TempRecord1.Field67 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Enrollment No." := '8';
                                TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;
                        end;

                    end;

                    InsertedEntry := 0;
                    InsertedEntry := EntryNo;
                    IF (EntryNo >= 34) and (EntryNo <= 36) then begin
                        For int := 1 to (36 - InsertedEntry) do begin
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
                    SqNo := 0;
                    IF EMTAdvanced = True then begin
                        StudentMaster_gRec.Reset();
                        StudentMaster_gRec.SetRange("Global Dimension 1 Code", GD);
                        IF not TranscriptDataFilter then begin
                            StudentMaster_gRec.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                            StudentMaster_gRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                        end Else
                            StudentMaster_gRec.SetFilter("Course Code", CourseFilter);
                        StudentMaster_gRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                        // IF CourseFilter <> '' then
                        //     StudentMaster_gRec.SetFilter("Course Code", CourseFilter)
                        // Else

                        IF StudentMaster_gRec.FindSet() then begin

                            repeat
                                RecStudentDegree.Reset();
                                RecStudentDegree.SetRange("Student No.", StudentMaster_gRec."No.");
                                RecStudentDegree.SetFilter("Degree Code", '=%1|=%2', 'EMTAL', 'EMTALREC');
                                IF Not TranscriptDataFilter then
                                    RecStudentDegree.SetRange("Enrollment No.", StudentMaster_gRec."Enrollment No.");
                                RecStudentDegree.Setrange("Global Dimension 1 Code", GD);
                                IF RecStudentDegree.FindFirst() then begin

                                    repeat
                                        If SQNo = 0 then begin
                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1.Code := Format(EntryNo);
                                            TempRecord1."Entry No" := EntryNo;
                                            TempRecord1.Field59 := 'Awarded';
                                            TempRecord1.Field32 := 1;
                                            TempRecord1.Field33 := 1;
                                            TempRecord1.Field34 := 1;
                                            TempRecord1.Field35 := 1;
                                            CountNum := CountNum + 1;
                                            TempRecord1."Enrollment No." := '3';
                                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                            TempRecord1.Field61 := 1;
                                            TempRecord1.Field69 := 1;
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();
                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1.Code := Format(EntryNo);
                                            TempRecord1."Entry No" := EntryNo;
                                            TempRecord1.Field60 := 'Date Awarded';
                                            TempRecord1.Field32 := 0;
                                            TempRecord1."Enrollment No." := '4';
                                            TempRecord1.Field35 := 1;
                                            TempRecord1.Field36 := 1;
                                            TempRecord1.Field34 := 1;
                                            TempRecord1.Field61 := 1;
                                            TempRecord1.Field69 := 1;
                                            CountNum := CountNum + 1;
                                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();
                                            SqNo := 1;
                                        end;
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1.Code := Format(EntryNo);
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field38 := RecStudentDegree."Degree Name"; //;'EMT - ADVANCED LEVEL'
                                        TempRecord1.Field44 := FORMAT(RecStudentDegree.DateAwarded, 0, '<Month,2>/<Day,2>/<Year4>');
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field34 := 1;
                                        TempRecord1.Field35 := 1;//borderstyle
                                        TempRecord1.Field36 := 1;
                                        TempRecord1.Field61 := 1;
                                        TempRecord1.Field69 := 1;
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
                                TempRecord1.Code := Format(EntryNo);
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field33 := 1;
                                TempRecord1.field56 := 1;
                                TempRecord1.field68 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field69 := 1;
                                TempRecord1."Enrollment No." := '5';
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;
                        end;

                    end;

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

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1.Code := Format(EntryNo);
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1."Transcript End" := '*** End of Transcript ***';
                    TempRecord1.Field70 := 1;
                    TempRecord1.Field32 := 1;
                    TempRecord1.Field33 := 1;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    StudentNo_gTxt := "Student Master-CS"."Original Student No.";

                End;
            end;

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
        dataitem(TempRecord; "Quota-CS")
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
            {

            }
            column(Field13; Field13)
            {

            }
            column(Field14; Field14)
            {

            }
            column(Field41; Field41)
            {

            }
            column(Field35; Field35)
            {

            }
            column(Field36; Field36)
            {

            }
            column(Field4; Field34)
            {

            }
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
            column(Field59; Field59)
            { }
            column(Field60; Field60)
            { }
            column(Field61; Field61)
            { }
            column(Field62; Field62)
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
            column(Field69; Field69)
            { }
            column(Field70; Field70)
            { }
            column(CountNum; CountNum)
            {

            }
            column(Field23; Field23)
            { }
            column(Field24; Field24)
            { }
            column(Enrollment_No_; "Enrollment No.")
            { }
            Column(Line_Spacing_1; "Line Spacing 1")
            { }
            column(Line_Spacing_2; "Line Spacing 2")
            { }
            Column(Line_Spacing_3; "Line Spacing 3")
            { }
            Column(Line_Spacing_4; "Line Spacing 4")
            { }
            column(Line_Spacing_5; "Line Spacing 5")
            { }
            column(Transcript_End; "Transcript End")
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
    }
    trigger OnPreReport()
    var
        MainStudentSubject: Record "Main Student Subject-CS";
    begin
        MainStudentSubject.Reset();
        MainStudentSubject.Setfilter(Course, 'EMT*');
        MainStudentSubject.SetFilter("Category-Course Description", '<>%1', 'EMERGENCY TECHNICIAN');
        MainStudentSubject.ModifyAll("Category-Course Description", 'EMERGENCY TECHNICIAN');
        // IF EnrollmentNo = '' THEN
        //     ERROR('Enrollment No must have a value in it');
    End;

    trigger OnPostReport()
    begin
        // TempRecord1.Reset();
        // TempRecord1.SetRange("Unique ID", UserId());
        // TempRecord1.DeleteAll();
    end;

    var
        RecEduSetup: Record "Education Setup-CS";
        CourseMaster_gRec: Record "Course Master-CS";
        CourseMaster_gRec1: Record "Course Master-CS";
        CourseMaster_gRec2: Record "Course Master-CS";
        TempRecord1: Record "Quota-CS";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
        usersetupapprover: Record "Document Approver Users";
        RecStudentHonor: Record "Student Honors";
        StudentMaster_gRec: Record "Student Master-CS";
        RecStudentDegree: Record "Student Degree";
        PassingGrade_gRec: Record "Grade Master-CS";
        SubjectCategory_gRec: Record "Subject Category Master";
        UserSetupRec: Record "User Setup";
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
        EMTAdvanced: Boolean;
        EMTBasic: Boolean;
        ShowPrintIfEmailIsMissing: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold";
        TermGPA_gDec: Decimal;
        QualityPoints_gDec: Decimal;
        CreditEarned: Decimal;
        AcademicYear_gTxt: Text;
        Term_gTxt: Integer;
        StudentNo_gTxt: Text;
        InsertedEntry: Integer;
        Int: Integer;

        GrandGPA: Decimal;
        GPA_gDec: Decimal;
        OriginalStudentNo: Text;
        TranscriptDataFilter: Boolean;
        GD: Code[20];
        TranscriptDataFilter1: Boolean;
        PrintBorder: Boolean;
        PrintBorder1: Boolean;
        CourseFilter: Text;
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

    procedure CalculateLeftRight(CountNo: Integer) Side: Option " ",Left,Right;
    begin
        IF (CountNum > 0) AND (CountNum <= 36) then
            Side := Side::Left;
        IF (CountNum > 36) AND (CountNum <= 72) then
            Side := Side::Right;
        IF (CountNum > 72) AND (CountNum <= 108) then
            Side := Side::Left;
        IF (CountNum > 108) AND (CountNum <= 144) then
            Side := Side::Right;
        IF (CountNum > 144) AND (CountNum <= 180) then
            Side := Side::Left;
        IF (CountNum > 180) AND (CountNum <= 216) then
            Side := Side::Right;
        IF (CountNum > 216) AND (CountNum <= 252) then
            Side := Side::Left;
        IF (CountNum > 252) AND (CountNum <= 288) then
            Side := Side::Right;
        IF (CountNum > 288) AND (CountNum <= 324) then
            Side := Side::Left;
        IF (CountNum > 324) AND (CountNum <= 360) then
            Side := Side::Right;
    End;


    procedure CalculateLeftRightBasic(CountNo: Integer) Side: Option " ",Left,Right;
    begin
        IF (CountNum > 0) AND (CountNum <= 36) then
            Side := Side::Left;
        IF (CountNum > 36) AND (CountNum <= 72) then
            Side := Side::Right;
        IF (CountNum > 72) AND (CountNum <= 108) then
            Side := Side::Left;
        IF (CountNum > 108) AND (CountNum <= 144) then
            Side := Side::Right;
        IF (CountNum > 144) AND (CountNum <= 180) then
            Side := Side::Left;
        IF (CountNum > 180) AND (CountNum <= 216) then
            Side := Side::Right;
        IF (CountNum > 216) AND (CountNum <= 252) then
            Side := Side::Left;
        IF (CountNum > 252) AND (CountNum <= 288) then
            Side := Side::Right;
        IF (CountNum > 288) AND (CountNum <= 324) then
            Side := Side::Left;
        IF (CountNum > 324) AND (CountNum <= 360) then
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