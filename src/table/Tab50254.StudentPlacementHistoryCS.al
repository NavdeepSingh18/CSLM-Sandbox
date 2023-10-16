table 50254 "Student Placement History-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   09/05/2019       OnInsert()                                 Get "No Series","Academic Year" & "User Id" Values
    // 02    CSPL-00114   09/05/2019       Placement ID - OnValidate()                Code add for No Series Generation
    // 03    CSPL-00114   09/05/2019       Registration ID - OnValidate()             Code add for Placement register Information
    // 04    CSPL-00114   09/05/2019       Company Id - OnValidate()                  Code add for Company Name from Placement Company table
    // 05    CSPL-00114   09/05/2019       Schedule ID - OnValidate()                 Code add for Company related information from placement Schedule
    // 06    CSPL-00114   09/05/2019       Placed - OnValidate()                      Code add for placement Status Modified
    // 07    CSPL-00114   09/05/2019       Assistedit() -Function                     Code add for No Series Generation

    Caption = 'Student Placement History-CS';
    DrillDownPageID = "Stud Placement History-CS";
    LookupPageID = "Stud Placement History-CS";

    fields
    {
        field(1; "Placement ID"; Code[20])
        {
            Caption = 'Placement ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code add for No Series Generation::CSPL-00114::09052019: Start
                IF "Placement ID" <> xRec."Placement ID" THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Placement History No.");
                    "No.Series" := '';
                END;
                //Code add for No Series Generation::CSPL-00114::09052019: End
            end;
        }
        field(2; "Registration ID"; Code[20])
        {
            Caption = 'Registration ID';
            DataClassification = CustomerContent;

            TableRelation = "Student Placement Reg-CS";

            trigger OnValidate()
            begin
                //Code add for Placement register Information::CSPL-00114::09052019: Start
                StudentPlacementHistoryCS.Reset();
                StudentPlacementHistoryCS.SETFILTER("Schedule ID", "Schedule ID");
                StudentPlacementHistoryCS.SETFILTER("Registration ID", "Registration ID");
                IF StudentPlacementHistoryCS.FINDFIRST() THEN
                    ERROR(Text000Lbl);

                StudentPlacementRegCS.Reset();
                StudentPlacementRegCS.SETRANGE(StudentPlacementRegCS."Register No.", "Registration ID");
                IF StudentPlacementRegCS.FindFirst() THEN BEGIN
                    "Student ID" := StudentPlacementRegCS."Student No.";
                    "Student Name" := StudentPlacementRegCS."Student Name";
                    "Academic Year" := StudentPlacementRegCS."Academic year";
                END;
                //Code add for Placement register Information::CSPL-00114::09052019: End
            end;
        }
        field(3; "Student ID"; Code[20])
        {
            Caption = 'Student ID';
            DataClassification = CustomerContent;

            TableRelation = "Subject Master-CS";
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;

        }
        field(5; "Company Id"; Code[20])
        {
            Caption = 'Company Id';
            DataClassification = CustomerContent;

            TableRelation = "Stud Placement Company-CS";

            trigger OnValidate()
            begin
                //Code add for Company Name from Placement Company table::CSPL-00114::09052019: Start
                StudPlacementCompanyCS.Reset();
                StudPlacementCompanyCS.SETRANGE("Company Code", "Company Id");
                IF StudPlacementCompanyCS.FINDFIRST() THEN
                    "Company Name" := StudPlacementCompanyCS."Company Name";
                //Code add for Company Name from Placement Company table::CSPL-00114::09052019: End
            end;
        }
        field(6; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(7; "Campus Date"; Date)
        {
            Caption = 'Campus Date';
            DataClassification = CustomerContent;
        }
        field(9; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(10; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(11; "Schedule ID"; Code[20])
        {
            Caption = 'Schedule ID';
            DataClassification = CustomerContent;

            TableRelation = "Stud Placement Schedule-CS";

            trigger OnValidate()
            begin
                //Code add for Company related information from placement Schedule::CSPL-00114::09052019: End
                StudPlacementScheduleCS.Reset();
                StudPlacementScheduleCS.SETRANGE(StudPlacementScheduleCS."Schedule No.", "Schedule ID");
                IF StudPlacementScheduleCS.FINDFIRST() THEN BEGIN
                    "Company Id" := StudPlacementScheduleCS."Company Code";
                    "Company Name" := StudPlacementScheduleCS."Company Name";
                    "Campus Date" := StudPlacementScheduleCS."From Date";
                END;
                //Code add for Company related information from placement Schedule::CSPL-00114::09052019: End
            end;
        }
        field(13; "Exam Clear"; Boolean)
        {
            Caption = 'Exam Clear';
            DataClassification = CustomerContent;
        }
        field(14; "Technical Clear"; Boolean)
        {
            Caption = 'Technical Clear';
            DataClassification = CustomerContent;
        }
        field(15; "HR Clear"; Boolean)
        {
            Caption = 'HR Clear';
            DataClassification = CustomerContent;
        }
        field(16; Placed; Boolean)
        {
            Caption = 'Placed';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code add for placement Status Modified::CSPL-00114::09052019: Start
                IF Placed THEN BEGIN
                    StudentPlacementRegCS.Reset();
                    StudentPlacementRegCS.SETRANGE("Student No.", "Student ID");
                    IF StudentPlacementRegCS.FINDFIRST() THEN BEGIN
                        StudentPlacementRegCS.Placed := TRUE;
                        StudentPlacementRegCS.Modify();
                    END;
                END;
                //Code add for placement Status Modified::CSPL-00114::09052019: End
            end;
        }
        field(17; "Offer Letter"; Boolean)
        {
            Caption = 'Offer Letter';
            DataClassification = CustomerContent;
        }
        field(18; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;

            TableRelation = "Academic Year Master-CS";
        }
        field(19; LOI; Boolean)
        {
            Caption = 'LOI';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09052019';
        }
    }

    keys
    {
        key(Key1; "Registration ID", "Schedule ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series","Academic Year","User Id" Values::CSPL-00114::09052019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        IF "Placement ID" = '' THEN BEGIN
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement History No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Placement History No.", xRec."No.Series", 0D, "Placement ID", "No.Series");
        END;
        //Get "No Series","Academic Year","User Id" Values::CSPL-00114::09052019: End
    end;

    var

        AcademicsSetupCS: Record "Academics Setup-CS";
        StudentPlacementRegCS: Record "Student Placement Reg-CS";
        StudPlacementScheduleCS: Record "Stud Placement Schedule-CS";
        StudentPlacementHistoryCS: Record "Student Placement History-CS";
        StudPlacementCompanyCS: Record "Stud Placement Company-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text000Lbl: Label 'This Student Already Exist \please Select Someother Student';

    procedure Assistedit(OldStudentPlacementHistoryCS: Record "Student Placement History-CS"): Boolean
    begin
        //Code add for No Series Generation::CSPL-00114::09052019: Start
        WITH StudentPlacementHistoryCS DO BEGIN
            StudentPlacementHistoryCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Placement History No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Placement History No.", OldStudentPlacementHistoryCS."No.Series", "No.Series") THEN BEGIN
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement History No.");
                NoSeriesMgt.SetSeries("Placement ID");
                Rec := StudentPlacementHistoryCS;
                EXIT(TRUE);
            END;
        END;
        //Code add for No Series Generation::CSPL-00114::09052019: End
    end;
}

