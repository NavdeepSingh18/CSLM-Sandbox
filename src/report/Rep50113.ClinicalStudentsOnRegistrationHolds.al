report 50113 ClinicalStudentsOnRegHolds
{
    Caption = 'Clinical Students On Registration Holds';
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './src/reportrdlc/Clinical Students On Registration Holds.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        // dataitem("Student Master-CS"; "Student Master-CS")
        // {
        //     DataItemTableView = sorting("No.") where(Status = filter('ATT' | 'DEF' | 'PROB' | 'REENTRY' | 'RADM' | 'TEMP' | 'NDSSUS' | 'CLOA' | 'EXTLOA' | 'SLOA' | 'BP' | 'PGR' | 'NDSRC'));

        dataitem("Hold Status Ledger"; "Hold Status Ledger")
        {
            // DataItemLink = "Student No." = field("No.");
            DataItemTableView = sorting("Entry No.") where("Semester" = filter('CLN5' | 'CLN6' | 'CLN7' | 'CLN8'));

            column(Filter_Caption1; AllFilters)
            {

            }

            column(Student_No_; "Student No.")
            {

            }
            column(LastName; StudentList."Last Name")
            {

            }
            column(FirstName; StudentList."First Name")
            {

            }
            column(Email; StudentList."E-Mail Address")
            {

            }
            column(Semester; Semester)
            {

            }
            column(SchoolStatus; StudentList.Status)
            {

            }
            column(StudentGroup; GroupRec.Description)
            {

            }
            column(DateOn; "Entry Date")
            {

            }
            column(UserOn; "User ID")
            {

            }
            column(DateOff; HoldStatusLedger."Entry Date")
            {

            }
            column(UserOff; HoldStatusLedger."User ID")
            {

            }
            column(InstituteName; EducationSetup."Institute Name")
            {

            }
            column(logoImage; EducationSetup."Clinical Science Logo")
            {

            }
            column(Hold; Hold)
            {

            }
            Column("Institute_Name"; EducationSetup."Institute Name")
            {

            }
            Column("Institute_Address"; EducationSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; EducationSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; EducationSetup."Institute City")
            {

            }
            Column("Institute_PostCode"; EducationSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; EducationSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; EducationSetup."Institute E-Mail")
            {

            }
            Column("Institute_FaxNo"; EducationSetup."Institute Fax No.")
            {

            }
            column(LastEntryNo; GroupOn)
            {

            }
            column(Entry_No_; "Entry No.")
            {

            }
            trigger OnPreDataItem()
            begin
                Clear(NotFound);
                SetRange(Status, Status::Enable);

                SetFilter("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN begin
                    StudentList.Reset();
                    StudentList.SetRange("Enrollment No.", EnrollmentNo);
                    if StudentList.FindFirst() then
                        SetFilter("Hold Status Ledger"."Student No.", StudentList."No.");
                end;
                if StudentNo <> '' then
                    SetFilter("Student No.", StudentNo);

                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);

                UserSetupRec.Get(UserId);
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then
                    EducationSetup.CalcFields("Clinical Science Logo");

                if EducationSetup."FM1/IM1 Semester Filter" <> '' then
                    ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

                if EducationSetup."Clerkship Semester Filter" <> '' then
                    ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

                if Semester1 = '' then
                    Semester1 := ClinicalSemester;

                SetFilter(Semester, Semester1);

                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + InstituteCode;
                IF EnrollmentNo <> '' then
                    EnrollmentFilter := ', Enrollment No.:' + EnrollmentNo;
                if StudentNo <> '' then
                    StudentNoFilter := ', Student No.:' + "Student No.";
                if Semester1 <> '' then
                    SemesterFilter := ', Semester:' + Semester;
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";

                AllFilters := InstituteCodeFilter + EnrollmentFilter + StudentNoFilter + SemesterFilter + AcademicYearFilter;


            end;


            trigger OnAfterGetRecord()
            begin

                StudentList.Reset();
                if StudentList.Get("Student No.") then;
                if not (StudentList.Status in ['ATT', 'DEF', 'PROB', 'REENTRY', 'RADM', 'TEMP', 'NDSSUS', 'CLOA', 'EXTLOA', 'SLOA', 'BP', 'PGR', 'NDSRC']) then
                    CurrReport.Skip();

                NotFound += 1;
                LastEntryNo := 0;
                HoldStatusLedger1.Reset();
                HoldStatusLedger1.SetRange("Student No.", "Student No.");
                HoldStatusLedger1.SetRange("Entry Date", "Entry Date");
                HoldStatusLedger1.SetRange(Status, HoldStatusLedger1.Status::Enable);
                if HoldStatusLedger1.FindLast() then
                    LastEntryNo := HoldStatusLedger1."Entry No.";

                GroupOn := '';
                if "Entry No." = LastEntryNo then
                    GroupOn := '1';


                HoldStatusLedger.Reset();
                HoldStatusLedger.SetRange("Student No.", "Student No.");
                HoldStatusLedger.SetRange("Hold Type", "Hold Type");
                HoldStatusLedger.SetRange(Status, HoldStatusLedger.Status::Disable);
                HoldStatusLedger.SetFilter("Entry No.", '>%1', LastEntryNo);
                if HoldStatusLedger.FindLast() then
                    CurrReport.Skip();

                Hold := 'adRegister';

                if GroupRec.Get("Group Code") then;


            end;

            // trigger OnPostDataItem()
            // begin
            //     if NotFound = 0 then
            //         Message('There is no record with in the given filter(s).');

            // end;
        }
    }
    // }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field("Institute Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Institude Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                        // trigger OnValidate()
                        // begin

                        // end;
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
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
                    }
                    field("Semester"; Semester1)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester';
                        TableRelation = "Semester Master-CS".Code where(Year = filter(3 | 4));
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

        trigger OnOpenPage()
        begin
            if UserSetupRec.Get(UserId) then
                InstituteCode := UserSetupRec."Global Dimension 1 Code";
        end;
    }
    trigger OnInitReport()
    begin
        // CompInfo.GET();
    end;

    trigger OnPreReport()
    begin
        // if UserSetupRec.Get(UserId) then
        //     InstituteCode := UserSetupRec."Global Dimension 1 Code";
    end;

    trigger OnPostReport()
    begin
        if NotFound = 0 then
            Message('There is no record with in the given filter(s).');
    end;

    var
        StudentList: Record "Student Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        HoldStatusLedger: Record "Hold Status Ledger";
        EducationSetup: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        GroupRec: Record Group;
        HoldStatusLedger1: Record "Hold Status Ledger";
        Hold: Text;
        Semester1: Code[100];
        StudentNo: Code[2048];
        AllFilters: Text;
        ClinicalSemester: Code[1024];
        SemesterFilter: Code[1024];
        StudentNoFilter: Code[2048];
        InstituteCode: Code[2048];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[2048];
        InstituteCodeFilter: Code[2048];
        AcademicYearFilter: Text;
        EnrollmentFilter: Code[2048];
        LastEntryNo: Integer;
        GroupOn: Text;
        NotFound: Integer;
}