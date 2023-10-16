report 50220 StandardTranscriptMail
{
    //Caption = 'Standard Transcript';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AUACOMStandardTranscriptMail.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    //ApplicationArea = All;
    //UseRequestPage = false;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") order(ascending);
            column(Filter_Caption1; GETFILTERS())
            {

            }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column("Institute_Name"; Uppercase(RecEduSetup."Institute Name"))
            {

            }
            column(CollegeName; CollegeName)
            { }
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
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            Column(Country_Code; RecEduSetup."Institute Country Code")
            { }

            column(Student_Name; "Student Name")
            {

            }
            column(No_; "Original Student No.")
            {

            }
            column(Status; Status_gTxt)
            {

            }
            column(UnofficialTranscript; UnofficialTranscript)
            {

            }

            Column(NSLDS_Withdrawal_Date; StatusDate)
            {

            }
            Column(Course_Logo; CourseMaster_gRec2."Logo Image")
            { }

            column(Course_Code; "Course Code")
            { }
            Column(GD; GD)
            { }
            Column(GFPKey; GFPKey)
            { }

            Column(TranscriptTxt; TranscriptTxt)
            { }

            trigger OnAfterGetRecord()
            Var
                StatusChangeLogEntry: Record "Status Change Log entry";
                ReasonCode: Record "Reason Code";
            begin

                //Message("Student Master-CS"."Global Dimension 1 Code");
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

                    AUAGHT := False;
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

                    StudentMaster_gRec.Reset();
                    StudentMaster_gRec.Setrange("Original Student No.", "Student Master-CS"."Original Student No.");
                    StudentMaster_gRec.SetFilter("Course Code", '%1|%2|%3', 'AUA-GHT', 'FIU - AUA CLINICAL', 'FIUGLOBAL');
                    IF StudentMaster_gRec.Findfirst() then
                        AUAGHT := True;

                    EntryNo := 0;
                    Temprecord1.Reset();
                    IF Temprecord1.Findlast() then
                        EntryNo := Temprecord1."Entry No" + 1
                    Else
                        EntryNo := 0;


                    SqNo := 0;
                    GrandGPA := 0;

                    TermGPA_gDec := 0;
                    Term_gTxt := 0;
                    CreditConsider := 0;
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
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    MainStudentSubject.SetRange(Level, 1);
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.SetRange("Category-Course Description", 'BASIC SCIENCE');
                    // If not AUAGHT then
                    //     MainStudentSubject.SetFilter(Semester, '<>%1', 'BSIC');
                    If MainStudentSubject.FindSet() then begin
                        repeat
                            TranscriptDataFilter1 := false;
                            CourseMaster_gRec1.Reset();
                            CourseMaster_gRec1.SetRange(Code, MainStudentSubject.Course);
                            IF CourseMaster_gRec1.FindFirst() then
                                IF CourseMaster_gRec1."Transcript Data Filter" then
                                    TranscriptDataFilter1 := true;

                            IF TranscriptDataFilter1 <> TranscriptDataFilter then
                                CurrReport.Skip();

                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin
                                IF (MainStudentSubject.Course IN ['AUA-GHT', 'FIU - AUA CLINICAL', 'FIUGLOBAL']) then begin
                                    //IF AUAGHTBanner <> MainStudentSubject.Course then begin
                                    IF AUAGHTBanner <> 'AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL' then begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field55 := 'Global Health Track';
                                        TempRecord1.Field31 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field61 := 1;
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        TempRecord1."Line Spacing 5" := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        AUAGHTBanner := 'AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL';
                                    end;
                                End;
                                IF (MainStudentSubject.Course IN ['STDPROG', 'SEMCOM', 'SEMCOM2', 'AUACOM', 'TRICOM']) then begin
                                    //IF AUAGHTBanner <> MainStudentSubject.Course then begin
                                    IF AUAGHTBanner <> 'STDPROG|SEMCOM|SEMCOM2|AUACOM|TRICOM' then begin
                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        SubjectCategory_gRec.Reset();
                                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                                        If SubjectCategory_gRec.FindFirst() then
                                            IF UnofficialTranscript = true then
                                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                                            else
                                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                                        TempRecord1."Line Spacing 5" := 1;
                                        TempRecord1.Field31 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field61 := 1;
                                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        AUAGHTBanner := 'STDPROG|SEMCOM|SEMCOM2|AUACOM|TRICOM';
                                    end;
                                end;
                                MainStudentSubject_gRec1.Reset();
                                MainStudentSubject_gRec1.SetRange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec1.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                MainStudentSubject_gRec1.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                If not TranscriptDataFilter then begin
                                    MainStudentSubject_gRec1.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                                    MainStudentSubject_gRec1.Setrange(Course, "Student Master-CS"."Course Code");
                                end;
                                If TranscriptDataFilter then
                                    MainStudentSubject_gRec1.SetFilter(Course, CourseFilter);
                                MainStudentSubject_gRec1.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                                MainStudentSubject_gRec1.SetRange(Level, 1);
                                MainStudentSubject_gRec1.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                                MainStudentSubject_gRec1.SetRange(TC, false);
                                MainStudentSubject_gRec1.SetRange("Category-Course Description", 'BASIC SCIENCE');
                                IF MainStudentSubject_gRec1.FindSet() then begin
                                    repeat
                                        IF (AcademicYear_gTxt1 <> MainStudentSubject_gRec1."Academic Year") or (Term_gTxt1 <> MainStudentSubject_gRec1."Term Sequence") then Begin

                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1."Entry No" := EntryNo;
                                            TempRecord1.Field34 := 1;
                                            CountNum := CountNum + 1;
                                            TempRecord1.Field45 := 1;
                                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                            TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                            TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();

                                            InsertedEntry := 0;
                                            InsertedEntry := EntryNo;
                                            GroupCount := 0;
                                            MainStudentSubject_gRec.Reset();
                                            MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject_gRec1."Student No.");
                                            MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject_gRec1."Academic Year");
                                            MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject_gRec1."Term Sequence");
                                            GroupCount := MainStudentSubject_gRec.Count();
                                            GroupCount += 4;

                                            If (InsertedEntry + GroupCount) > 45 then begin
                                                For int := 1 to (45 - InsertedEntry) do begin
                                                    TempRecord1.Init();
                                                    EntryNo := EntryNo + 1;
                                                    TempRecord1."Entry No" := EntryNo;
                                                    TempRecord1.Field34 := 1;
                                                    CountNum := CountNum + 1;
                                                    TempRecord1.Field45 := 1;
                                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                                    TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                                    TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                                    TempRecord1."Unique ID" := UserId();
                                                    TempRecord1.Insert();
                                                    InsertedEntry += 1;
                                                end;

                                            end;

                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1."Entry No" := EntryNo;

                                            IF "Student Master-CS"."KMC ID" <> '' then
                                                TempRecord1.Field54 := Format(MainStudentSubject_gRec1.Term) + '-' + MainStudentSubject_gRec1."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                            Else Begin
                                                IF MainStudentSubject_gRec1."Semester Break" <> '' then
                                                    TempRecord1.Field54 := MainStudentSubject_gRec1."Semester Break" + ' - ' + Format(MainStudentSubject_gRec1.Term) + '-' + MainStudentSubject_gRec1."Academic Year"
                                                Else Begin
                                                    IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                                        TempRecord1.Field54 := Format(MainStudentSubject_gRec1.Term) + '-' + MainStudentSubject_gRec1."Academic Year"
                                                    Else begin
                                                        IF not AUAGHT then
                                                            TempRecord1.Field54 := Format(MainStudentSubject_gRec1.Term) + '-' + MainStudentSubject_gRec1."Academic Year"
                                                        else
                                                            TempRecord1.Field54 := Format(MainStudentSubject_gRec1.Term) + '-' + MainStudentSubject_gRec1."Academic Year";
                                                    end;
                                                end;
                                            end;


                                            TempRecord1.Field32 := 1;
                                            TempRecord1.Field37 := 1;
                                            TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                            TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                            CountNum := CountNum + 1;
                                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();

                                            TempRecord1.Init();
                                            EntryNo := EntryNo + 1;
                                            TempRecord1."Entry No" := EntryNo;
                                            TempRecord1.Field34 := 1;
                                            CountNum := CountNum + 1;
                                            TempRecord1."Line Spacing 1" := 1;
                                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                            TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                            TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                            TempRecord1."Unique ID" := UserId();
                                            TempRecord1.Insert();
                                        end;

                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field2 := MainStudentSubject_gRec1."Subject Code";
                                        TempRecord1.Field11 := MainStudentSubject_gRec1.Description;
                                        TempRecord1.Field12 := Format(MainStudentSubject_gRec1."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                        //TempRecord1.Field3 := MainStudentSubject_gRec1.Grade;
                                        TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                        TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                        QualityPoints_gDec := 0;
                                        PassingGrade_gRec.Reset();
                                        PassingGrade_gRec.SetRange(Code, MainStudentSubject_gRec1.Grade);
                                        PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject_gRec1."Global Dimension 1 Code");
                                        If PassingGrade_gRec.FindFirst() then begin
                                            QualityPoints_gDec := MainStudentSubject_gRec1."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                            If PassingGrade_gRec."Consider for GPA" then
                                                CreditConsider += MainStudentSubject_gRec1."Credits Attempt";

                                            CourseMaster_gRec.Reset();
                                            CourseMaster_gRec.SetRange(Code, MainStudentSubject_gRec1.Course);
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
                                        CreditEarned += MainStudentSubject_gRec1."Credit Earned";

                                        TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                        TempRecord1.Field32 := 0;
                                        //Total
                                        TotalCredit := TotalCredit + MainStudentSubject_gRec1."Credits Attempt";
                                        TotalPoint := TotalPoint + QualityPoints_gDec;



                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();

                                        SqNo := MainStudentSubject_gRec1.Sequence;
                                        AcademicYear_gTxt1 := MainStudentSubject_gRec1."Academic Year";
                                        Term_gTxt1 := MainStudentSubject_gRec1."Term Sequence";
                                    until MainStudentSubject_gRec1.Next() = 0;
                                end;

                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    GrandGPA += CreditConsider;
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1."Line Spacing 2" := 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field65 := Format(MainStudentSubject_gRec1.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject_gRec1.Sequence);
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    //TempRecord1.Insert();
                                    CreditEarned := 0;
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditConsider := 0;
                                end;
                                SqNo := MainStudentSubject.Sequence;
                                Term_gTxt := MainStudentSubject."Term Sequence";
                                AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            end;
                        until MainStudentSubject.Next() = 0;


                        // IF SqNo <> 0 then begin
                        //     TempRecord1.Init();
                        //     EntryNo := EntryNo + 1;
                        //     TempRecord1."Entry No" := EntryNo;
                        //     TempRecord1.Field11 := ' ';
                        //     TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        //     TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        //     TempRecord1.Field32 := 1;
                        //     CountNum := CountNum + 1;
                        //     TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        //     TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        //     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        //     TempRecord1."Unique ID" := UserId();
                        //     TempRecord1.Insert();
                        //     GrandCredit := GrandCredit + TotalCredit;
                        //     GrandPoint := GrandPoint + TotalPoint;
                        //     If CreditConsider <> 0 then
                        //         TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                        //     GrandGPA += CreditConsider;


                        //     TempRecord1.Init();
                        //     EntryNo := EntryNo + 1;
                        //     TempRecord1."Entry No" := EntryNo;
                        //     TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        //     TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        //     IF SqNo = 1 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 2 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 3 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 4 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 5 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 6 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 7 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 8 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     IF SqNo = 9 then
                        //         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                        //             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //         Else
                        //             if (CreditConsider = 0) and (GrandGPA <> 0) then
                        //                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                        //             Else
                        //                 If (CreditConsider = 0) and (GrandGPA = 0) then
                        //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                        //     TempRecord1.Field32 := 1;
                        //     CountNum := CountNum + 1;
                        //     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                        //     TempRecord1."Unique ID" := UserId();
                        //     TempRecord1.Insert();
                        //     TotalCredit := 0;
                        //     TotalPoint := 0;
                        //     CreditEarned := 0;
                        //     CreditConsider := 0;

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field34 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1."Line Spacing 2" := 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        //end;
                        CollegeName := 'College of Medicine';
                    End;

                    // SqNo := 0;
                    // TermGPA_gDec := 0;
                    // Term_gTxt := 0;
                    // AcademicYear_gTxt := '';
                    // IF not AUAGHT then begin
                    //     MainStudentSubject.Reset();
                    //     MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    //     //MainStudentSubject.Ascending(false);
                    //     MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    //     If not TranscriptDataFilter then begin
                    //         MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                    //         MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    //     end;
                    //     If TranscriptDataFilter then
                    //         MainStudentSubject.SetFilter(Course, CourseFilter);
                    //     MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    //     //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");-
                    //     MainStudentSubject.SetRange(Level, 1);
                    //     //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    //     MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    //     MainStudentSubject.SetRange(TC, false);
                    //     MainStudentSubject.SetRange("Category-Course Description", 'BASIC SCIENCE');
                    //     IF Not AUAGHT then
                    //         MainStudentSubject.SETRANGE(Semester, 'BSIC');
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
                    //         TempRecord1."Entry No" := EntryNo;
                    //         SubjectCategory_gRec.Reset();
                    //         SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                    //         If SubjectCategory_gRec.FindFirst() then
                    //             IF UnofficialTranscript = true then
                    //                 TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                    //             else
                    //                 TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                    //         TempRecord1.Field31 := 1;
                    //         TempRecord1.Field32 := 1;
                    //         TempRecord1."Line Spacing 5" := 1;
                    //         TempRecord1.Field61 := 1;
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
                    //                     TempRecord1."Entry No" := EntryNo;
                    //                     TempRecord1.Field11 := ' ';
                    //                     TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //                     TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //                     TempRecord1.Field32 := 1;
                    //                     TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                     TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                     CountNum := CountNum + 1;
                    //                     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                     TempRecord1."Unique ID" := UserId();
                    //                     TempRecord1.Insert();
                    //                     GrandCredit := GrandCredit + TotalCredit;
                    //                     GrandPoint := GrandPoint + TotalPoint;
                    //                     GrandGPA += CreditConsider;
                    //                     If CreditConsider <> 0 then
                    //                         TermGPA_gDec += (Round((TotalPoint / CreditConsider)));


                    //                     TempRecord1.Init();
                    //                     EntryNo := EntryNo + 1;
                    //                     TempRecord1."Entry No" := EntryNo;
                    //                     TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                     TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                     IF SqNo = 1 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 2 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 3 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 4 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 5 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 6 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 7 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 8 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     IF SqNo = 9 then
                    //                         If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                         Else
                    //                             if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                                 TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                             Else
                    //                                 If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //                     TempRecord1.Field32 := 1;
                    //                     CountNum := CountNum + 1;
                    //                     TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                     TempRecord1."Unique ID" := UserId();
                    //                     TempRecord1.Insert();

                    //                     // TempRecord1.Init();
                    //                     // EntryNo := EntryNo + 1;
                    //                     // TempRecord1."Entry No" := EntryNo;
                    //                     // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                     // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                     // CountNum := CountNum + 1;
                    //                     // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                     // TempRecord1."Unique ID" := UserId();
                    //                     //TempRecord1.Insert();
                    //                     CreditEarned := 0;
                    //                     TotalCredit := 0;
                    //                     TotalPoint := 0;
                    //                     CreditConsider := 0;
                    //                 end;
                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
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

                    //                 If (InsertedEntry + GroupCount) > 45 then begin
                    //                     For int := 1 to (45 - InsertedEntry) do begin
                    //                         TempRecord1.Init();
                    //                         EntryNo := EntryNo + 1;
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
                    //                 TempRecord1."Entry No" := EntryNo;
                    //                 IF "Student Master-CS"."KMC ID" <> '' then
                    //                     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                    //                 Else
                    //                     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                    //                 TempRecord1.Field32 := 1;
                    //                 TempRecord1.Field37 := 1;
                    //                 TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //                 TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //                 CountNum := CountNum + 1;
                    //                 TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //                 TempRecord1."Unique ID" := UserId();
                    //                 TempRecord1.Insert();

                    //                 TempRecord1.Init();
                    //                 EntryNo := EntryNo + 1;
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
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field2 := MainStudentSubject."Subject Code";
                    //             TempRecord1.Field11 := MainStudentSubject.Description;
                    //             TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             //TempRecord1.Field3 := MainStudentSubject.Grade;
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             QualityPoints_gDec := 0;
                    //             PassingGrade_gRec.Reset();
                    //             PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                    //             PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                    //             If PassingGrade_gRec.FindFirst() then begin
                    //                 QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                    //                 If PassingGrade_gRec."Consider for GPA" then
                    //                     CreditConsider += MainStudentSubject."Credits Attempt";
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
                    //             CreditEarned += MainStudentSubject."Credit Earned";

                    //             TempRecord1.Field13 := Format(QualityPoints_gDec, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             TempRecord1.Field32 := 0;
                    //             //Total
                    //             TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                    //             TotalPoint := TotalPoint + QualityPoints_gDec;



                    //             CountNum := CountNum + 1;
                    //             TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();

                    //             SqNo := MainStudentSubject.Sequence;
                    //             Term_gTxt := MainStudentSubject."Term Sequence";
                    //             AcademicYear_gTxt := MainStudentSubject."Academic Year";
                    //         until MainStudentSubject.Next() = 0;


                    //         IF SqNo <> 0 then begin
                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field11 := ' ';
                    //             TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //             TempRecord1.Field32 := 1;
                    //             CountNum := CountNum + 1;
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();
                    //             GrandCredit := GrandCredit + TotalCredit;
                    //             GrandPoint := GrandPoint + TotalPoint;
                    //             If CreditConsider <> 0 then
                    //                 TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                    //             GrandGPA += CreditConsider;


                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             IF SqNo = 1 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 2 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 3 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 4 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 5 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 6 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 7 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 8 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             IF SqNo = 9 then
                    //                 If (CreditConsider <> 0) and (GrandGPA <> 0) then
                    //                     TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                 Else
                    //                     if (CreditConsider = 0) and (GrandGPA <> 0) then
                    //                         TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                    //                     Else
                    //                         If (CreditConsider = 0) and (GrandGPA = 0) then
                    //                             TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                    //             TempRecord1.Field32 := 1;
                    //             CountNum := CountNum + 1;
                    //             TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();
                    //             TotalCredit := 0;
                    //             TotalPoint := 0;
                    //             CreditEarned := 0;
                    //             CreditConsider := 0;

                    //             TempRecord1.Init();
                    //             EntryNo := EntryNo + 1;
                    //             TempRecord1."Entry No" := EntryNo;
                    //             TempRecord1.Field34 := 1;
                    //             CountNum := CountNum + 1;
                    //             TempRecord1."Line Spacing 2" := 1;
                    //             TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    //             TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    //             TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    //             TempRecord1."Unique ID" := UserId();
                    //             TempRecord1.Insert();

                    //         end;
                    //         CollegeName := 'College of Medicine';
                    //     End;
                    // end;

                    SqNo := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    //MainStudentSubject.Ascending(false);
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");-
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.SetRange("Category-Course Description", 'BRIDGE TO AICASA');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field61 := 1;
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
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    GrandGPA += CreditConsider;
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    CreditEarned := 0;
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditConsider := 0;
                                end;

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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else
                                If MainStudentSubject."Semester Break" <> '' then
                                    TempRecord1.Field54 := MainStudentSubject."Semester Break" + ' ' + Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                Else
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
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
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            CreditEarned += MainStudentSubject."Credit Earned";
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandGPA += CreditConsider;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := 'College of Medicine';
                    End;

                    SqNo := 0;
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
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");-
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.SetRange("Category-Course Description", 'PHYSICIAN ASSISANT');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field61 := 1;
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
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    GrandCredit := GrandCredit + TotalCredit;
                                    GrandPoint := GrandPoint + TotalPoint;
                                    GrandGPA += CreditConsider;
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    CreditEarned := 0;
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditConsider := 0;
                                end;

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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else
                                If MainStudentSubject."Semester Break" <> '' then
                                    TempRecord1.Field54 := MainStudentSubject."Semester Break" + ' ' + Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                Else
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
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
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                If PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            CreditEarned += MainStudentSubject."Credit Earned";

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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            GrandCredit := GrandCredit + TotalCredit;
                            GrandPoint := GrandPoint + TotalPoint;
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandGPA += CreditConsider;


                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRightBasic(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := 'College of Medicine';
                    End;



                    SqNo := 0;
                    AcademicYear_gTxt := '';
                    Term_gTxt := 0;
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
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.Setfilter(Course, '<>%1', 'BSEP');
                    MainStudentSubject.SetRange("Category-Course Description", 'ASHS');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");

                        TempRecord1.Field31 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                            IF (Term_gTxt <> MainStudentSubject."Term Sequence") OR (AcademicYear_gTxt <> MainStudentSubject."Academic Year") then begin
                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                    GrandCredit1 := GrandCredit1 + TotalCredit;
                                    GrandPoint1 := GrandPoint1 + TotalPoint;
                                    GrandGPA += CreditConsider;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field34 := 1;
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                    CreditConsider := 0;
                                end;

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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else
                                //TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                IF MainStudentSubject.Course = 'APC' then
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' APC'
                                Else
                                    If MainStudentSubject.Course = 'PPP' then
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' PPP'
                                    Else begin
                                        If MainStudentSubject."Semester Break" <> '' then
                                            TempRecord1.Field54 := MainStudentSubject."Semester Break" + ' ' + Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                        Else
                                            TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                    end;
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                //TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                If PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            CreditEarned += MainStudentSubject."Credit Earned";

                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            SqNo := MainStudentSubject.Sequence;
                            Term_gTxt := MainStudentSubject."Term Sequence";
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                        until MainStudentSubject.Next() = 0;

                        IF SqNo <> 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            GrandGPA += CreditConsider;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := '';
                    end;

                    SqNo := 0;
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
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.Setfilter(Course, '<>%1', 'BSEP');
                    MainStudentSubject.SetRange("Category-Course Description", 'PREMED COURSES');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");

                        TempRecord1.Field31 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                    GrandCredit1 := GrandCredit1 + TotalCredit;
                                    GrandPoint1 := GrandPoint1 + TotalPoint;
                                    GrandGPA += CreditConsider;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);

                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();


                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                    Creditconsider := 0;
                                end;

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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else begin
                                IF MainStudentSubject.Course = 'APC' then
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' APC'
                                Else
                                    If MainStudentSubject.Course = 'PPP' then
                                        TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' PPP'
                                    Else begin
                                        If MainStudentSubject."Semester Break" <> '' then
                                            TempRecord1.Field54 := MainStudentSubject."Semester Break" + ' ' + Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                        Else
                                            TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                    end;
                                //end;

                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                //TempRecord1.Field34 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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


                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CreditEarned += MainStudentSubject."Credit Earned";

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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            GrandGPA += CreditConsider;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;

                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := '';
                    end;

                    SqNo := 0;
                    Term_gTxt := 0;
                    AcademicYear_gTxt := '';
                    MainStudentSubject.Reset();
                    //MainStudentSubject.SetCurrentKey("Academic Year", Sequence, "Term Sequence");
                    MainStudentSubject.SetCurrentKey("Academic Year", "Term Sequence");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.SetRange("Category-Course Description", 'GFP');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 0;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field55 := 'College of Graduate Studies'
                            Else
                                TempRecord1.Field55 := 'College of Graduate Studies';
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        IF SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field54 := (SubjectCategory_gRec."Category Description")
                            Else
                                TempRecord1.Field54 := (SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                        TempRecord1."Unique ID" := UserId();
                        TempRecord1.Insert();

                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
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
                            //IF SqNo <> MainStudentSubject.Sequence then begin

                            //IF (SqNo <> MainStudentSubject.Sequence) or (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin
                            IF (AcademicYear_gTxt <> MainStudentSubject."Academic Year") or (Term_gTxt <> MainStudentSubject."Term Sequence") then begin
                                IF SqNo <> 0 then begin
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field11 := ' ';
                                    TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                    GrandCredit1 := GrandCredit1 + TotalCredit;
                                    GrandPoint1 := GrandPoint1 + TotalPoint;
                                    GrandGPA += CreditConsider;


                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field34 := 1;
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                    CreditConsider := 0;


                                end;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                If MainStudentSubject."Semester Break" <> '' then
                                    TempRecord1.Field54 := MainStudentSubject."Semester Break" + ' ' + Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                Else
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + ' - ' + Format(MainStudentSubject."Academic Year");
                                TempRecord1.Field31 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
                                TempRecord1.Field61 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1."Line Spacing 1" := 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                // TempRecord1.Init();
                                // EntryNo := EntryNo + 1;
                                // TempRecord1."Entry No" := EntryNo;
                                // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                // TempRecord1.Field54 := 'Graduate Fellowship Program';//Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                // TempRecord1.Field32 := 1;
                                // TempRecord1.Field37 := 1;
                                // //TempRecord1.Field34 := 1;
                                // CountNum := CountNum + 1;
                                // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                // TempRecord1."Unique ID" := UserId();
                                // TempRecord1.Insert();
                            end;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
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
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := 0;
                                IF PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += 0;
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
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CreditEarned += MainStudentSubject."Credit Earned";

                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();

                            // TempRecord1.Init();
                            // EntryNo := EntryNo + 1;
                            // TempRecord1."Entry No" := EntryNo;
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
                            // TempRecord1.Field14 := Format(MainStudentSubject."Start Date", 0, '<Month,2>/<Day,2>/<Year4>') + ' to ' + Format(MainStudentSubject."End Date", 0, '<Month,2>/<Day,2>/<Year4>');
                            // CountNum := CountNum + 1;
                            // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            // TempRecord1."Unique ID" := UserId();
                            // TempRecord1.Insert();


                            SqNo := MainStudentSubject.Sequence;
                            AcademicYear_gTxt := MainStudentSubject."Academic Year";
                            Term_gTxt := MainStudentSubject."Term Sequence";
                        until MainStudentSubject.Next() = 0;

                        sqNo := 0;
                        IF SqNo = 0 then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            GrandGPA += CreditConsider;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 0 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00)
                                        else
                                            IF (TotalCredit <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / TotalCredit)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round((0)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');

                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := 'College of Graduate Studies';
                        GFPKey := true;
                    end;

                    SqNo := 0;
                    AcademicYear_gTxt := '';
                    Term_gTxt := 0;
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
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    //MainStudentSubject.SetRange("Category-Course Description", 'BSEP');
                    MainStudentSubject.SetRange(Course, 'BSEP');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1."Line Spacing 5" := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        // SubjectCategory_gRec.Reset();
                        // SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        // If SubjectCategory_gRec.FindFirst() then
                        //     If UnofficialTranscript then
                        //         TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                        //     else
                        TempRecord1.Field55 := ('BSEP Courses');
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                    GrandCredit1 := GrandCredit1 + TotalCredit;
                                    GrandPoint1 := GrandPoint1 + TotalPoint;
                                    GrandGPA += CreditConsider;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field34 := 1;
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                    CreditConsider := 0;
                                end;



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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else
                                If MainStudentSubject."Semester Break" <> '' then
                                    TempRecord1.Field54 := MainStudentSubject."Semester Break" + ' ' + Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year"
                                Else
                                    TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                //TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                If PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CreditEarned += MainStudentSubject."Credit Earned";

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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            GrandGPA += CreditConsider;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := '';
                    end;

                    SqNo := 0;
                    AcademicYear_gTxt := '';
                    Term_gTxt := 0;
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
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.SetRange("Category-Course Description", 'NURSING');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                    GrandCredit1 := GrandCredit1 + TotalCredit;
                                    GrandPoint1 := GrandPoint1 + TotalPoint;
                                    GrandGPA += CreditConsider;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field34 := 1;
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                    CreditConsider := 0;
                                end;

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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else

                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                //TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                If PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CreditEarned += MainStudentSubject."Credit Earned";

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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            GrandGPA += CreditConsider;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := 'School of Nursing';
                    end;

                    SqNo := 0;
                    AcademicYear_gTxt := '';
                    Term_gTxt := 0;
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
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 1);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    MainStudentSubject.SetRange("Category-Course Description", 'NURSING COURSES');
                    If MainStudentSubject.FindSet() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            If UnofficialTranscript then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                    TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    If CreditConsider <> 0 then
                                        TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                    GrandCredit1 := GrandCredit1 + TotalCredit;
                                    GrandPoint1 := GrandPoint1 + TotalPoint;
                                    GrandGPA += CreditConsider;

                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    IF SqNo = 1 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 2 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 3 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 4 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 5 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 6 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 7 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 8 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    IF SqNo = 9 then
                                        If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                        Else
                                            if (CreditConsider = 0) and (GrandGPA <> 0) then
                                                TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                            Else
                                                If (CreditConsider = 0) and (GrandGPA = 0) then
                                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();

                                    // TempRecord1.Init();
                                    // EntryNo := EntryNo + 1;
                                    // TempRecord1."Entry No" := EntryNo;
                                    // TempRecord1.Field34 := 1;
                                    // CountNum := CountNum + 1;
                                    // TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                    // TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                    // TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    // TempRecord1."Unique ID" := UserId();
                                    // TempRecord1.Insert();
                                    TotalCredit := 0;
                                    TotalPoint := 0;
                                    CreditEarned := 0;
                                    CreditConsider := 0;
                                end;

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

                                InsertedEntry := 0;
                                InsertedEntry := EntryNo;
                                GroupCount := 0;
                                MainStudentSubject_gRec.Reset();
                                MainStudentSubject_gRec.Setrange("Student No.", MainStudentSubject."Student No.");
                                MainStudentSubject_gRec.Setrange("Academic Year", MainStudentSubject."Academic Year");
                                MainStudentSubject_gRec.SetRange("Term Sequence", MainStudentSubject."Term Sequence");
                                GroupCount := MainStudentSubject_gRec.Count();
                                GroupCount += 4;

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
                                // IF "Student Master-CS"."KMC ID" <> '' then
                                //     TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year" + ' ' + 'through KMCIC Twinning Program'
                                // Else
                                TempRecord1.Field54 := Format(MainStudentSubject.Term) + '-' + MainStudentSubject."Academic Year";
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field37 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                //TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field2 := MainStudentSubject."Subject Code";
                            TempRecord1.Field11 := MainStudentSubject.Description;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            //TempRecord1.Field3 := MainStudentSubject.Grade;
                            QualityPoints_gDec := 0;
                            PassingGrade_gRec.Reset();
                            PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                            PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            If PassingGrade_gRec.FindFirst() then begin
                                QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                If PassingGrade_gRec."Consider for GPA" then
                                    CreditConsider += MainStudentSubject."Credits Attempt";
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
                            //Total
                            TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                            TotalPoint := TotalPoint + QualityPoints_gDec;
                            CreditEarned += MainStudentSubject."Credit Earned";

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
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field11 := ' ';
                            TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            If CreditConsider <> 0 then
                                TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                            GrandCredit1 := GrandCredit1 + TotalCredit;
                            GrandPoint1 := GrandPoint1 + TotalPoint;
                            GrandGPA += CreditConsider;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            IF SqNo = 1 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 2 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 3 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 4 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 5 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 6 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 7 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 8 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            IF SqNo = 9 then
                                If (CreditConsider <> 0) and (GrandGPA <> 0) then
                                    TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                Else
                                    if (CreditConsider = 0) and (GrandGPA <> 0) then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        If (CreditConsider = 0) and (GrandGPA = 0) then
                                            TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                            TotalCredit := 0;
                            TotalPoint := 0;
                            CreditEarned := 0;
                            CreditConsider := 0;

                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
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
                        CollegeName := 'School of Nursing';
                    end;

                    //CountNum := 0;
                    SqNo := 0;
                    TermGPA_gDec := 0;
                    StartDate := 0D;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Start Date");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 2);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    // MainStudentSubject.SetFilter("Credits Attempt", '<>%1', 0);
                    MainStudentSubject.SetRange("Category-Course Description", 'CLINICAL CLERKSHIP');
                    If MainStudentSubject.FindSet() then begin
                        InsertedEntry := 0;
                        InsertedEntry := EntryNo;
                        If EntryNo >= 88 then begin
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
                        IF (EntryNo >= 43) and (EntryNo <= 45) then begin
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
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        TempRecord1."Line Spacing 5" := 1;
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field61 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1.Field2 := MainStudentSubject."Subject Code";
                                TempRecord1.Field11 := MainStudentSubject.Description;
                                TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                //TempRecord1.Field3 := MainStudentSubject.Grade;
                                QualityPoints_gDec := 0;
                                PassingGrade_gRec.Reset();
                                PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                                PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                                If PassingGrade_gRec.FindFirst() then begin
                                    QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                    IF PassingGrade_gRec."Consider for GPA" then
                                        CreditConsider += MainStudentSubject."Credits Attempt";
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
                                CreditEarned += MainStudentSubject."Credit Earned";
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
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


                        InProgressClinical := '';
                        // RosterLedgerEntry.Reset();
                        // RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                        // // RosterLedgerEntry.SetRange("Academic Year", MainStudentSubject."Academic Year");
                        // // RosterLedgerEntry.SetRange(Semester, MainStudentSubject.Semester);
                        // RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                        // IF RosterLedgerEntry.FindLast() then
                        //     IF RosterLedgerEntry."End Date" > Today() then
                        //         InprogressClinical := 'In Progress';

                        If InprogressClinical <> '' then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);

                            TempRecord1.Field14 := InProgressClinical;
                            TempRecord1.Field72 := 1;
                            TempRecord1.Field32 := 0;
                            TempRecord1.Field34 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;

                        If InProgressClinical = '' then begin
                            IF SqNo = 0 then begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field11 := ' ';
                                TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                If CreditConsider <> 0 then
                                    TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                GrandCredit1 := GrandCredit1 + TotalCredit;
                                GrandPoint1 := GrandPoint1 + TotalPoint;
                                GrandGPA += CreditConsider;


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                IF SqNo = 0 then
                                    If CreditConsider <> 0 then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);

                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TotalCredit := 0;
                                TotalPoint := 0;
                                CreditEarned := 0;
                                CreditConsider := 0;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                        end;
                        CollegeName := 'College of Medicine';
                    end;

                    SqNo := 0;
                    TermGPA_gDec := 0;
                    StartDate := 0D;
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetCurrentKey("Start Date");
                    MainStudentSubject.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange("Global Dimension 1 Code", "Student Master-CS"."Global Dimension 1 Code");
                    If not TranscriptDataFilter then begin
                        MainStudentSubject.SetRange("Enrollment No", "Student Master-CS"."Enrollment No.");
                        MainStudentSubject.Setrange(Course, "Student Master-CS"."Course Code");
                    end;
                    If TranscriptDataFilter then
                        MainStudentSubject.SetFilter(Course, CourseFilter);
                    //MainStudentSubject.SetRange("Student No.", "Student Master-CS"."Original Student No.");
                    MainStudentSubject.SetRange(Level, 2);
                    //MainStudentSubject.SetFilter(Grade, '<>%1', '');
                    MainStudentSubject.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    MainStudentSubject.SetRange(TC, false);
                    // MainStudentSubject.SetFilter("Credits Attempt", '<>%1', 0);
                    MainStudentSubject.SetRange("Category-Course Description", 'CLINICAL SCIENCE');
                    If MainStudentSubject.FindSet() then begin

                        InsertedEntry := 0;
                        InsertedEntry := EntryNo;
                        If EntryNo >= 88 then begin
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
                        IF (EntryNo >= 42) and (EntryNo <= 45) then begin
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
                        TempRecord1."Line Spacing 5" := 1;
                        SubjectCategory_gRec.Reset();
                        SubjectCategory_gRec.SetRange("Category Code", MainStudentSubject."Category-Course Description");
                        If SubjectCategory_gRec.FindFirst() then
                            IF UnofficialTranscript = true then
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description")
                            else
                                TempRecord1.Field55 := (SubjectCategory_gRec."Category Description");
                        TempRecord1.Field31 := 1;
                        TempRecord1.Field32 := 1;
                        TempRecord1.Field34 := 1;
                        TempRecord1.Field65 := Format(MainStudentSubject.Level);
                        TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                        TempRecord1.Field61 := 1;
                        CountNum := CountNum + 1;
                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
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
                                If (EntryNo >= 89) and (EntryNo <= 90) then begin
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
                                IF (EntryNo >= 44) and (EntryNo <= 45) then begin
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
                                TempRecord1.Field2 := MainStudentSubject."Subject Code";
                                TempRecord1.Field11 := MainStudentSubject.Description;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1.Field12 := Format(MainStudentSubject."Credits Attempt", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                //TempRecord1.Field3 := MainStudentSubject.Grade;
                                QualityPoints_gDec := 0;
                                PassingGrade_gRec.Reset();
                                PassingGrade_gRec.SetRange(Code, MainStudentSubject.Grade);
                                PassingGrade_gRec.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                                If PassingGrade_gRec.FindFirst() then begin
                                    QualityPoints_gDec := MainStudentSubject."Credits Attempt" * PassingGrade_gRec."Grade Points";
                                    If PassingGrade_gRec."Consider for GPA" then
                                        CreditConsider += MainStudentSubject."Credits Attempt";
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
                                TotalCredit := TotalCredit + MainStudentSubject."Credits Attempt";
                                TotalPoint := TotalPoint + QualityPoints_gDec;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
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

                        InProgressClinical := '';
                        // RosterLedgerEntry.Reset();
                        // RosterLedgerEntry.SetRange("Student ID", MainStudentSubject."Student No.");
                        // // RosterLedgerEntry.SetRange("Academic Year", MainStudentSubject."Academic Year");
                        // // RosterLedgerEntry.SetRange(Semester, MainStudentSubject.Semester);
                        // RosterLedgerEntry.SetRange("Course Code", MainStudentSubject."Subject Code");
                        // IF RosterLedgerEntry.FindLast() then
                        //     IF RosterLedgerEntry."End Date" > Today() then
                        //         InProgressClinical := 'In Progress';

                        IF InProgressClinical <> '' then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field14 := 'In Progress';
                            TempRecord1.Field72 := 1;
                            TempRecord1.Field32 := 0;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field65 := Format(MainStudentSubject.Level);
                            TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;

                        If InprogressClinical = '' then begin
                            IF SqNo = 0 then begin
                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;
                                TempRecord1.Field11 := ' ';
                                TempRecord1.Field12 := Format(TotalCredit, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field13 := Format(TotalPoint, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();
                                If CreditConsider <> 0 then
                                    TermGPA_gDec += (Round((TotalPoint / CreditConsider)));
                                GrandCredit1 := GrandCredit1 + TotalCredit;
                                GrandPoint1 := GrandPoint1 + TotalPoint;
                                GrandGPA += CreditConsider;


                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
                                TempRecord1."Entry No" := EntryNo;

                                TempRecord1.Field65 := Format(MainStudentSubject.Level);
                                TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                                IF SqNo = 0 then
                                    If CreditConsider <> 0 then
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(Round((TotalPoint / CreditConsider)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>') + '     ' + 'CUM GPA :' + ' ' + Format(Round(((GrandPoint + GrandPoint1) / GrandGPA)), 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>')
                                    Else
                                        TempRecord1.Field51 := 'Term GPA :' + ' ' + Format(0.00) + '     ' + 'CUM GPA :' + ' ' + Format(0.00);
                                TempRecord1.Field32 := 1;
                                TempRecord1.Field34 := 1;
                                CountNum := CountNum + 1;
                                TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                TempRecord1."Unique ID" := UserId();
                                TempRecord1.Insert();

                                TotalCredit := 0;
                                TotalPoint := 0;
                                CreditConsider := 0;

                                TempRecord1.Init();
                                EntryNo := EntryNo + 1;
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
                        end;
                        CollegeName := 'College of Medicine';
                    end;

                    InsertedEntry := 0;
                    InsertedEntry := EntryNo;
                    If EntryNo >= 88 then begin
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
                    IF (EntryNo >= 43) and (EntryNo <= 45) then begin
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
                    TempRecord1.Field65 := '3';
                    TempRecord1.Field66 := '0';
                    TempRecord1.Field64 := 'Attempted Credits:';
                    TempRecord1.Field40 := 'GPA Credits:';
                    TempRecord1.Field21 := GrandCredit + GrandCredit1;
                    TempRecord1.Field22 := GrandGPA;
                    TempRecord1.Field32 := 1;
                    TempRecord1.Field33 := 1;
                    TempRecord1.Field34 := 1;
                    TempRecord1.Field62 := 1;
                    TempRecord1."Enrollment No." := '1';
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field65 := '3';
                    TempRecord1.Field66 := '0';

                    TempRecord1.Field64 := 'GPA QPTs:';
                    TempRecord1.Field40 := 'GPA :';
                    TempRecord1.Field21 := GrandPoint + GrandPoint1;
                    IF GrandGPA <> 0 then
                        TempRecord1.Field22 := Round(((GrandPoint + GrandPoint1) / GrandGPA))
                    Else
                        TempRecord1.Field22 := 0;
                    TempRecord1.Field32 := 0;

                    TempRecord1.Field34 := 1;
                    TempRecord1.Field62 := 1;
                    TempRecord1."Enrollment No." := '2';
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field34 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1."Line Spacing 4" := 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1.Field65 := Format(MainStudentSubject.Level);
                    TempRecord1.Field66 := Format(MainStudentSubject.Sequence);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();

                    GPA_gDec := 0;
                    IF GrandGPA <> 0 then
                        GPA_gDec := Round(((GrandPoint + GrandPoint1) / GrandGPA))
                    Else
                        GPA_gDec := 0;

                    HonorsFinds := false;
                    RecStudentHonor.Reset();
                    RecStudentHonor.SetRange("Student No.", "Student Master-CS"."No.");
                    RecStudentHonor.SetFilter("Min. Range", '<=%1', GPA_gDec);
                    RecStudentHonor.SetFilter("Max. Range", '>=%1', GPA_gDec);
                    IF RecStudentHonor.FindFirst() then
                        HonorsFinds := true;

                    DegreeFinds := false;
                    StudentMaster_gRec.Reset();
                    StudentMaster_gRec.SetRange("Global Dimension 1 Code", GD);
                    IF not TranscriptDataFilter then
                        StudentMaster_gRec.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                    StudentMaster_gRec.SEtrange("Original Student No.", "Student Master-CS"."Original Student No.");
                    IF CourseFilter <> '' then
                        StudentMaster_gRec.SetFilter("Course Code", CourseFilter)
                    Else
                        StudentMaster_gRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                    IF StudentMaster_gRec.FindSet() then begin
                        repeat
                            RecStudentDegree.Reset();
                            RecStudentDegree.SetRange("Student No.", StudentMaster_gRec."No.");
                            IF not TranscriptDataFilter then
                                RecStudentDegree.SetRange("Enrollment No.", StudentMaster_gRec."Enrollment No.");
                            RecStudentDegree.Setrange("Global Dimension 1 Code", GD);
                            //RecStudentDegree.SetRange("Degree Code", 'ASN');
                            IF RecStudentDegree.Findset() then begin
                                repeat
                                    DegreeFinds := true;
                                until RecStudentDegree.Next() = 0;
                            end;
                        until StudentMaster_gRec.Next() = 0;
                    end;

                    If (HonorsFinds = True) OR (DegreeFinds = True) then begin

                        InsertedEntry := 0;
                        InsertedEntry := EntryNo;
                        If EntryNo >= 83 then begin
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
                        IF (EntryNo >= 38) and (EntryNo <= 45) then begin
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
                    end;
                    RecStudentHonor.Reset();
                    RecStudentHonor.SetRange("Student No.", "Student Master-CS"."No.");
                    RecStudentHonor.SetFilter("Min. Range", '<=%1', GPA_gDec);
                    RecStudentHonor.SetFilter("Max. Range", '>=%1', GPA_gDec);
                    IF RecStudentHonor.FindFirst() then begin
                        TempRecord1.Init();
                        EntryNo := EntryNo + 1;
                        TempRecord1."Entry No" := EntryNo;
                        TempRecord1.Field65 := '3';
                        TempRecord1.Field66 := '0';
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
                    StudentMaster_gRec.SEtrange("Original Student No.", "Student Master-CS"."Original Student No.");
                    IF TranscriptDataFilter then begin
                        IF CourseFilter <> '' then
                            StudentMaster_gRec.SetFilter("Course Code", CourseFilter);
                    end Else
                        StudentMaster_gRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                    IF StudentMaster_gRec.FindSet() then begin

                        repeat

                            RecStudentDegree.Reset();
                            RecStudentDegree.SetRange("Student No.", StudentMaster_gRec."No.");
                            IF not TranscriptDataFilter then
                                RecStudentDegree.SetRange("Enrollment No.", StudentMaster_gRec."Enrollment No.");
                            RecStudentDegree.Setrange("Global Dimension 1 Code", GD);
                            //RecStudentDegree.SetRange("Degree Code", 'ASN');
                            IF RecStudentDegree.Findset() then begin

                                repeat

                                    IF SqNo = 0 then begin
                                        If (HonorsFinds = False) OR (DegreeFinds = False) then begin
                                            InsertedEntry := 0;
                                            InsertedEntry := EntryNo;
                                            If EntryNo >= 83 then begin
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
                                            IF (EntryNo >= 38) and (EntryNo <= 45) then begin
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
                                        end;

                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field65 := '3';
                                        TempRecord1.Field66 := '0';
                                        //TempRecord1.Field11 := 'AWARDED';
                                        TempRecord1.field48 := 'Awarded';
                                        TempRecord1.Field34 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field33 := 1;
                                        TempRecord1.Field35 := 1;
                                        TempRecord1."Enrollment No." := '3';
                                        TempRecord1.Field53 := 1;//left-right border
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();

                                        TempRecord1.Init();
                                        EntryNo := EntryNo + 1;
                                        TempRecord1."Entry No" := EntryNo;
                                        TempRecord1.Field65 := '3';
                                        TempRecord1.Field66 := '0';
                                        //TempRecord1.Field3 := 'DATE AWARDED';
                                        TempRecord1.field49 := 'Date Awarded';
                                        TempRecord1.Field53 := 1;//left-right border
                                                                 //TempRecord1.Field50 := 1;
                                        TempRecord1.Field32 := 1;
                                        TempRecord1.Field35 := 1;
                                        TempRecord1."Enrollment No." := '4';
                                        TempRecord1.Field36 := 1;
                                        TempRecord1.Field34 := 1;
                                        CountNum := CountNum + 1;
                                        TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                        TempRecord1."Unique ID" := UserId();
                                        TempRecord1.Insert();
                                        SqNo := 1;
                                    end;
                                    TempRecord1.Init();
                                    EntryNo := EntryNo + 1;
                                    TempRecord1."Entry No" := EntryNo;
                                    TempRecord1.Field65 := '3';
                                    TempRecord1.Field66 := '0';
                                    // TempRecord1.Field11 := RecStudentDegree."Degree Name";
                                    // TempRecord1.Field3 := FORMAT(RecStudentDegree.DateAwarded);
                                    TempRecord1.Field58 := RecStudentDegree."Degree Name";
                                    TempRecord1.Field59 := FORMAT(RecStudentDegree.DateAwarded, 0, '<Month,2>/<Day,2>/<Year4>');
                                    TempRecord1.Field53 := 1;//left-right border
                                    TempRecord1.Field32 := 1;
                                    TempRecord1.Field34 := 1;
                                    TempRecord1.Field35 := 1;//borderstyle
                                    TempRecord1.Field36 := 1;
                                    CountNum := CountNum + 1;
                                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                                    TempRecord1."Unique ID" := UserId();
                                    TempRecord1.Insert();
                                    PrintBorderLine := True;
                                until RecStudentDegree.Next() = 0;
                            end;
                        until StudentMaster_gRec.Next() = 0;
                        IF PrintBorderLine then begin
                            TempRecord1.Init();
                            EntryNo := EntryNo + 1;
                            TempRecord1."Entry No" := EntryNo;
                            TempRecord1.Field65 := '3';
                            TempRecord1.Field66 := '0';
                            TempRecord1."Enrollment No." := '5';
                            TempRecord1.Field32 := 1;
                            TempRecord1.Field34 := 1;
                            TempRecord1.Field33 := 1;
                            TempRecord1.Field56 := 1;
                            CountNum := CountNum + 1;
                            TempRecord1.Field41 := CalculateLeftRight(CountNum);
                            TempRecord1."Unique ID" := UserId();
                            TempRecord1.Insert();
                        end;

                    end;

                    TempRecord1.Init();
                    EntryNo := EntryNo + 1;
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
                    TempRecord1."Entry No" := EntryNo;
                    TempRecord1.Field65 := '3';
                    TempRecord1.Field66 := '0';
                    TempRecord1."Transcript End" := '*** End of Transcript ***';
                    //TempRecord1.Field31 := 1;
                    TempRecord1.Field32 := 1;
                    TempRecord1.Field33 := 1;
                    TempRecord1.Field34 := 1;
                    TempRecord1.Field61 := 1;
                    TempRecord1.Field67 := 1;
                    CountNum := CountNum + 1;
                    TempRecord1.Field41 := CalculateLeftRight(CountNum);
                    TempRecord1."Unique ID" := UserId();
                    TempRecord1.Insert();
                End;
                StudentNo_gTxt := "Student Master-CS"."Original Student No.";
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
        dataitem(TempRecord; "Temp Record")
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
            column(Field4; Field34)
            {

            }
            column(Field61; Field61)
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
            column(Field62; Field62)
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
            column(Field72; Field72)
            { }
            column(CountNum; CountNum)
            { }
            column(Field21; Field21)
            { }
            Column(Field58; Field58)
            { }
            column(Field59; Field59)
            { }
            column(Field22; Field22)
            { }
            column(Enrollment_No_; "Enrollment No.")
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
                    //     TableRelation = "Student Master-CS"."Enrollment No.";
                    //     /*trigger OnLookup(var Text: Text): Boolean
                    //     begin
                    //         StudentMasterCS.Reset();
                    //         StudentMasterCS.findset();
                    //         IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                    //             EnrollmentNo := StudentMasterCS."Enrollment No.";
                    //     end;*/
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
        //IF EnrollmentNo = '' THEN
        //    ERROR('Enrollment No must have a value in it');
    End;


    trigger OnPostReport()
    begin
        Temprecord1.Reset();
        TempRecord1.setrange("Unique ID", UserId());
        TempRecord1.DeleteAll();

    end;

    var
        RecEduSetup: Record "Education Setup-CS";

        StudentMaster_gRec: Record "Student Master-CS";
        CourseMaster_gRec: Record "Course Master-CS";
        CourseMaster_gRec1: Record "Course Master-CS";
        CourseMaster_gRec2: Record "Course Master-CS";
        UserSetupRec: Record "User Setup";
        StudentStatus_gRec: Record "Student Status";
        TempRecord1: Record "Temp Record";
        TempRecordTemp: Record "Temp Record";
        MainStudentSubject: Record "Main Student Subject-CS";
        MainStudentSubject_gRec: Record "Main Student Subject-CS";
        usersetupapprover: Record "Document Approver Users";
        StudentMasterCS: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        RecStudentHonor: Record "Student Honors";
        RecStudentDegree: Record "Student Degree";
        PassingGrade_gRec: Record "Grade Master-CS";
        SubjectCategory_gRec: Record "Subject Category Master";
        MainStudentSubject_gRec1: Record "Main Student Subject-CS";
        StudentStatusMangement: Codeunit "Student Status Mangement";
        EnrollmentNo: Code[20];
        StartDate: Date;
        SqNo: Integer;
        EntryNo: Integer;
        TotalPoint: Decimal;
        TotalCredit: Decimal;
        GrandCredit: Decimal;
        GrandPoint: Decimal;
        GrandCredit1: Decimal;
        GrandPoint1: Decimal;
        UnofficialTranscript: Boolean;
        CreditConsider: Decimal;
        PrintBorderLine: Boolean;
        CountNum: Integer;
        CollegeName: Text[250];
        ShowPrintIfEmailIsMissing: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        QualityPoints_gDec: Decimal;
        TermGPA_gDec: Decimal;
        GrandGPA: Decimal;
        Status_gTxt: Text;
        RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold";
        Term_gTxt: Integer;
        AcademicYear_gTxt: Text;

        StudentNo_gTxt: Text;

        CreditEarned: Decimal;
        GPA_gDec: Decimal;
        OriginalStudentNo: Text;
        TranscriptDataFilter: Boolean;
        GD: Code[20];
        TranscriptDataFilter1: Boolean;
        CourseFilter: Text;
        GroupCount: Integer;
        int: Integer;
        InsertedEntry: Integer;
        InProgressClinical: Text;
        AUAGHT: Boolean;
        GFPKey: Boolean;
        TranscriptTxt: Text;
        GradeConfirmed: Boolean;
        HonorsFinds: Boolean;
        DegreeFinds: Boolean;
        CourseCodeFilter: Code[20];
        RosterFound: Boolean;
        RosterFound1: Boolean;
        RosterFound2: Boolean;
        BasicScienceBanner: Text;
        AUAGHTBanner: Text;
        Term_gTxt1: Integer;
        AcademicYear_gTxt1: Text;
        StatusDate: Text;

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