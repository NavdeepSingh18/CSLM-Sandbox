report 50163 "ICM Scores"
{
    Caption = 'Student ICM Marks';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/ICMScores.rdl';
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            //PrintOnlyIfDetail = true;
            DataItemTableView = SORTING("No.") order(ascending) where("Semester" = filter('MED1' | 'MED2' | 'MED3' | 'MED4'));
            column(Filter_Caption1; AllFilters)
            { }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column("Institute_Name"; RecEduSetup."Institute Name")
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
            Column("Institute_Email"; RecEduSetup."Institute E-Mail")
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(Enrollment_No_; "Enrollment No.")
            {

            }
            column(StudentNumber; "No.")
            { }
            column(Last_Name; "Last Name")
            { }
            column(First_Name; "First Name")
            { }
            column(Semester; Semester)
            { }
            column(CompInfo; CompInfo.Name)
            { }
            column(ImageAUA; RecEduSetupAUA."Logo Image")
            {
            }
            column(ImageAICASA; RecEduSetupAICASA."Logo Image")
            {
            }
            column(WCSL; WCSL)
            {

            }
            column(WHarvey; WHarvey)
            {

            }
            column(WICM; WICM)
            {

            }
            column(WOSCE; WOSCE)
            {

            }
            column(WWrite_Up; WWrite_Up)
            {

            }
            column(MCSL; MCSL)
            {

            }
            column(MHarvey; MHarvey)
            {

            }
            column(MOSCE; MOSCE)
            {

            }
            column(MWrite_Up; MWrite_Up)
            {

            }
            column(MICM; MICM)
            {

            }
            column(Point1; Point1)
            {

            }

            trigger OnPreDataItem()
            begin
                if InstituteCode <> '' then
                    SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                if Semester1 <> '' then
                    "Student Master-CS".SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
            end;

            trigger OnAfterGetRecord()
            begin

                SemesterFilter := '';
                AllFilters := '';
                InstituteCodeFilter := '';
                EnrollmentFilter := '';
                AcademicYearFilter := '';


                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                IF EnrollmentNo <> '' then
                    EnrollmentFilter := ', Enrollment No.:' + "Enrollment No.";
                if Semester1 <> '' then
                    SemesterFilter := ', Semester:' + Semester;
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";


                AllFilters := InstituteCodeFilter + EnrollmentFilter + SemesterFilter + AcademicYearFilter;

                RecEduSetupAUA.Reset();
                RecEduSetupAUA.SetRange("Global Dimension 1 Code", '9000');
                IF RecEduSetupAUA.FindFirst() then
                    RecEduSetupAUA.CALCFIELDS("Logo Image");

                RecEduSetupAICASA.Reset();
                RecEduSetupAICASA.SetRange("Global Dimension 1 Code", '9100');
                IF RecEduSetupAICASA.FindFirst() then
                    RecEduSetupAICASA.CALCFIELDS("Logo Image");

                //Code1 := 'CS';
                /*
                if ("Student Master-CS".Semester <> 'MED1') or ("Student Master-CS".Semester <> 'MED2') or
                ("Student Master-CS".Semester <> 'MED3') or ("Student Master-CS".Semester <> 'MED4') then
                    CurrReport.Skip();
                */
                Clear(WOSCE);
                Clear(MOSCE);
                Clear(MaxOSCE);
                Clear(POSCE);

                Clear(WHarvey);
                Clear(MHarvey);
                Clear(MaxHarvey);
                Clear(PHarvey);

                Clear(WWrite_Up);
                Clear(MWrite_Up);
                Clear(MaxWrite_Up);
                Clear(PWrite_Up);

                Clear(WCSL);
                Clear(MCSL);
                Clear(MaxCSL);
                Clear(PCSL);

                Clear(MaxICM);
                Clear(MICM);
                Clear(WICM);
                Clear(PICM);
                Clear(Point1);

                MainStudentSubject.Reset();
                MainStudentSubject.SetFilter("Student No.", "Student Master-CS"."No.");
                MainStudentSubject.SetFilter("Enrollment No", "Student Master-CS"."Enrollment No.");
                MainStudentSubject.SetFilter(Course, "Student Master-CS"."Course Code");
                MainStudentSubject.SetFilter(Semester, "Student Master-CS".Semester);
                if PublishedDocumentNo <> '' then
                    MainStudentSubject.SetFilter("Published Document No.", PublishedDocumentNo);
                if MainStudentSubject.FindSet() then begin
                    repeat
                        if "Student Master-CS".Semester = 'MED1' then begin
                            if MainStudentSubject."Subject Code" = '51156OSCE' then begin //OSCE
                                MaxOSCE := MainStudentSubject."Maximum Mark";
                                MOSCE := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '5116CSL' then begin //CSL
                                MaxCSL := MainStudentSubject."Maximum Mark";
                                MCSL := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '5116ICM1' then begin //ICM
                                MaxICM := MainStudentSubject."Maximum Mark";
                                MICM := MainStudentSubject."Internal Mark";
                            end;
                            GradeInput.Reset();
                            GradeInput.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            GradeInput.SetRange("Academic Year", MainStudentSubject."Academic Year");
                            GradeInput.SetRange(Semester, MainStudentSubject.Semester);
                            if GradeInput.FindSet() then begin
                                repeat
                                    if GradeInput."Exam Code" = '51156OSCE' then begin //OSCE
                                        POSCE := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '5116CSL' then begin //CSL
                                        PCSL := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '5116ICM1' then begin //ICM
                                        PICM := GradeInput.Points;
                                    end;

                                until GradeInput.Next() = 0;
                            end;
                            if MaxOSCE <> 0 then
                                WOSCE := (MOSCE / MaxOSCE) * POSCE;
                            if MaxICM <> 0 then
                                WICM := (MICM / MaxICM) * PICM;
                            if MaxCSL <> 0 then
                                WCSL := (MCSL / MaxCSL) * PCSL;
                            Point1 := WCSL + WICM + WOSCE + MCSL + MICM + MOSCE;

                        end;

                        if "Student Master-CS".Semester = 'MED2' then begin
                            if MainStudentSubject."Subject Code" = '5216CLS' then begin //CSL
                                MaxCSL := MainStudentSubject."Maximum Mark";
                                MCSL := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '5216OSCE' then begin //OSCE
                                MaxOSCE := MainStudentSubject."Maximum Mark";
                                MOSCE := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '5216ICM2' then begin //ICM
                                MaxCSL := MainStudentSubject."Maximum Mark";
                                MCSL := MainStudentSubject."Internal Mark";
                            end;
                            GradeInput.Reset();
                            GradeInput.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            GradeInput.SetRange("Academic Year", MainStudentSubject."Academic Year");
                            GradeInput.SetRange(Semester, MainStudentSubject.Semester);
                            if GradeInput.FindSet() then begin
                                repeat
                                    if GradeInput."Exam Code" = '5216OSCE' then begin //OSCE
                                        POSCE := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '5216CLS' then begin //CSL
                                        PCSL := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '5216ICM2' then begin //ICM
                                        PICM := GradeInput.Points;
                                    end;

                                until GradeInput.Next() = 0;
                            end;
                            if MaxOSCE <> 0 then
                                WOSCE := (MOSCE / MaxOSCE) * POSCE;
                            if MaxICM <> 0 then
                                WICM := (MICM / MaxICM) * PICM;
                            if MaxCSL <> 0 then
                                WCSL := (MCSL / MaxCSL) * PCSL;
                            Point1 := WCSL + WICM + WOSCE + MOSCE + MICM + MCSL;
                        end;
                        if "Student Master-CS".Semester = 'MED3' then begin
                            if MainStudentSubject."Subject Code" = '6326CSL' then begin //CSL
                                MaxCSL := MainStudentSubject."Maximum Mark";
                                MCSL := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '6326OSCE' then begin //OSCE
                                MaxOSCE := MainStudentSubject."Maximum Mark";
                                MOSCE := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '6326WRITE-UP' then begin //Write-Up
                                MaxWrite_Up := MainStudentSubject."Maximum Mark";
                                MWrite_Up := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '6326ICM3' then begin //ICM
                                MaxCSL := MainStudentSubject."Maximum Mark";
                                MCSL := MainStudentSubject."Internal Mark";
                            end;

                            GradeInput.Reset();
                            GradeInput.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            GradeInput.SetRange("Academic Year", MainStudentSubject."Academic Year");
                            GradeInput.SetRange(Semester, MainStudentSubject.Semester);
                            if GradeInput.FindSet() then begin
                                repeat
                                    if GradeInput."Exam Code" = '6326OSCE' then begin //OSCE
                                        POSCE := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '6326CSL' then begin //CSL
                                        PCSL := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '6326ICM3' then begin //ICM
                                        PICM := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '6326WRITE-UP' then begin //Write-Up
                                        PWrite_Up := GradeInput.Points;
                                    end;

                                until GradeInput.Next() = 0;
                            end;
                            if MaxOSCE <> 0 then
                                WOSCE := (MOSCE / MaxOSCE) * POSCE;
                            if MaxICM <> 0 then
                                WICM := (MICM / MaxICM) * PICM;
                            if MaxCSL <> 0 then
                                WCSL := (MCSL / MaxCSL) * PCSL;
                            if MaxWrite_Up <> 0 then
                                WWrite_Up := (MWrite_Up / MaxWrite_Up) * PWrite_Up;
                            Point1 := WOSCE + WICM + WCSL + WWrite_Up + MOSCE + MICM + MCSL + MWrite_Up;
                        end;

                        if "Student Master-CS".Semester = 'MED4' then begin
                            if MainStudentSubject."Subject Code" = '6426CSL' then begin //CSL
                                MaxCSL := MainStudentSubject."Maximum Mark";
                                MCSL := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '6426OSCEWU' then begin //OSCE+Write-Up
                                MaxOSCE := MainStudentSubject."Maximum Mark";
                                MOSCE := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '6426ICM4' then begin //ICM
                                MaxICM := MainStudentSubject."Maximum Mark";
                                MICM := MainStudentSubject."Internal Mark";
                            end;
                            if MainStudentSubject."Subject Code" = '6426HARVEY' then begin //Harvey
                                MaxHarvey := MainStudentSubject."Maximum Mark";
                                MHarvey := MainStudentSubject."Internal Mark";
                            end;
                            GradeInput.Reset();
                            GradeInput.SetRange("Global Dimension 1 Code", MainStudentSubject."Global Dimension 1 Code");
                            GradeInput.SetRange("Academic Year", MainStudentSubject."Academic Year");
                            GradeInput.SetRange(Semester, MainStudentSubject.Semester);
                            if GradeInput.FindSet() then begin
                                repeat
                                    if GradeInput."Exam Code" = '6426OSCEWU' then begin //OSCE
                                        POSCE := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '6426CSL' then begin //CSL
                                        PCSL := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '6426ICM4' then begin //ICM
                                        PICM := GradeInput.Points;
                                    end;
                                    if GradeInput."Exam Code" = '6426HARVEY' then begin //Harvey
                                        PHarvey := GradeInput.Points;
                                    end;

                                until GradeInput.Next() = 0;
                            end;
                            if MaxOSCE <> 0 then
                                WOSCE := (MOSCE / MaxOSCE) * POSCE;
                            if MaxICM <> 0 then
                                WICM := (MICM / MaxICM) * PICM;
                            if MaxCSL <> 0 then
                                WCSL := (MCSL / MaxCSL) * PCSL;
                            if MaxHarvey <> 0 then
                                WHarvey := (MHarvey / MaxHarvey) * PHarvey;
                            Point1 := WOSCE + WICM + WCSL + WHarvey + MOSCE + MICM + MCSL + MHarvey;
                        end;

                    until MainStudentSubject.Next() = 0;
                end;


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
                    field("Institute Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Institude Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field("Enrollment No"; EnrollmentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Enrollment No.';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            StudentMasterCS.Reset();
                            StudentMasterCS.findset();
                            IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                                EnrollmentNo := StudentMasterCS."Enrollment No.";
                        end;
                    }
                    /*
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
                    }
                    */
                    field("Semester"; Semester1)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester';
                        TableRelation = "Semester Master-CS";
                    }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        TableRelation = "Academic Year Master-CS";
                    }

                }

            }
        }

    }

    trigger OnInitReport()
    begin
        CompInfo.GET();
    end;

    trigger OnPreReport()
    begin
        // if (EnrollmentNo = '') and (Semester1 = '') then
        //     Error('Enrollment No. or Semenst must have a value in it.');

        //IF InstituteCode = '' THEN
        //  ERROR('Institute Code must have a value in it');

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", '9000');
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");
    end;

    var
        CompInfo: Record "Company Information";
        RecEduSetupAUA: Record "Education Setup-CS";
        RecEduSetupAICASA: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        Semester1: Code[100];
        StudentNo: Code[2048];
        Code1: Text[50];
        AllFilters: Text;
        SemesterFilter: Code[100];
        StudentNoFilter: Code[2048];
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];

        PublishedDocumentNo: Code[20];
        AcademicYear: Code[20];
        InstituteCodeFilter: Code[20];
        AcademicYearFilter: Text;
        EnrollmentFilter: Code[2048];

        GradeInput: Record "Grade Input";

        Point1: Decimal;
        MainStudentSubject: Record "Student Subject Exam";

        WICM: Decimal;
        MICM: Decimal;
        PICM: Decimal;

        MaxICM: Decimal;
        WOSCE: Decimal;
        MaxOSCE: Decimal;

        MOSCE: Decimal;
        POSCE: Decimal;

        WHarvey: Decimal;
        MHarvey: Decimal;
        PHarvey: Decimal;
        MaxHarvey: Decimal;

        WWrite_Up: Decimal;
        MWrite_Up: Decimal;
        MaxWrite_Up: Decimal;
        PWrite_Up: Decimal;
        WCSL: Decimal;
        MCSL: Decimal;
        MaxCSL: Decimal;
        PCSL: Decimal;

    procedure Reportvariable(EnrollNo: Code[2048]; PublishedDocNo: Code[20])
    begin
        EnrollmentNo := EnrollNo;
        PublishedDocumentNo := PublishedDocNo;
    end;

}