table 50253 "Stud Placement Schedule-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   05/05/2019       OnInsert()                                 Get "No Series","Academic Year","User Id" Values
    // 02    CSPL-00114   05/05/2019       Schedule No. - OnValidate()                Code added for Get No Series
    // 03    CSPL-00114   05/05/2019       Company Code - OnValidate()                Code added for Company name Value from Student Placement
    // 04    CSPL-00114   05/05/2019       Assistedit() - Function                    Code added for No series Generation auto

    Caption = 'Stud Placement Schedule-CS';
    DrillDownPageID = 50142;
    LookupPageID = 50142;

    fields
    {
        field(1; "Schedule No."; Code[20])
        {
            Caption = 'Schedule No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get No Series::CSPL-00114::05052019: Start
                IF "Schedule No." <> xRec."Schedule No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Placement Schedule No.");
                    "No.Series" := '';
                END;
                //Code added for Get No Series::CSPL-00114::05052019: End
            end;
        }
        field(2; "Company Code"; Code[20])
        {
            Caption = 'Company Code';
            DataClassification = CustomerContent;
            TableRelation = "Stud Placement Company-CS";

            trigger OnValidate()
            begin
                //Code added for Company name Value from Student Placement::CSPL-00114::05052019: Start
                StudPlacementCompanyCS.Reset();
                StudPlacementCompanyCS.SETRANGE("Company Code", "Company Code");
                IF StudPlacementCompanyCS.FINDFIRST() THEN
                    "Company Name" := StudPlacementCompanyCS."Company Name";
                //Code added for Company name Value from Student Placement::CSPL-00114::05052019: End
            end;
        }
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(6; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(8; "No of openings"; Integer)
        {
            Caption = 'No of openings';
            DataClassification = CustomerContent;
        }
        field(9; "From Time"; Time)
        {
            Caption = 'From Time';
            DataClassification = CustomerContent;
        }
        field(10; "To Time"; Time)
        {
            Caption = 'To Time';
            DataClassification = CustomerContent;
        }
        field(11; "Schedule Close"; Boolean)
        {
            Caption = 'Schedule Close';
            DataClassification = CustomerContent;
        }
        field(12; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(17; "Job description"; Text[80])
        {
            Caption = 'Job description';
            DataClassification = CustomerContent;
        }
        field(18; "Salary Package"; Decimal)
        {
            Caption = 'Salary Package';
            DataClassification = CustomerContent;
        }
        field(19; Eligibilty; Code[20])
        {
            Caption = 'Eligibilty';
            DataClassification = CustomerContent;
        }
        field(20; "Date Of Drive"; Date)
        {
            Caption = 'Date Of Drive';
            DataClassification = CustomerContent;
        }
        field(21; Designation; Code[20])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(23; Link; Text[250])
        {
            Caption = 'Link';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(24; Status; Boolean)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(25; Bond; Text[50])
        {
            Caption = 'Bond';
            DataClassification = CustomerContent;
        }
        field(26; "Job Location"; Code[20])
        {
            Caption = 'Job Location';
            DataClassification = CustomerContent;
        }
        field(27; "Date of Registration"; Date)
        {
            Caption = 'Date of Registration';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05052019';
        }
    }

    keys
    {
        key(Key1; "Schedule No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series","Academic Year","User Id" Values ::CSPL-00114::05052019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        IF "Schedule No." = '' THEN BEGIN
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Schedule No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Placement Schedule No.", xRec."No.Series", 0D, "Schedule No.", "No.Series");
        END
        //Get "No Series","Academic Year","User Id" Values ::CSPL-00114::05052019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        StudPlacementScheduleCS: Record "Stud Placement Schedule-CS";
        StudPlacementCompanyCS: Record "Stud Placement Company-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";

        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure Assistedit(OldStudPlacementSchedCS: Record "Stud Placement Schedule-CS"): Boolean
    begin
        //Code added for No Series Generation::CSPL-00114::05052019: Start
        WITH StudPlacementScheduleCS DO BEGIN
            StudPlacementScheduleCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Schedule No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Placement Schedule No.", OldStudPlacementSchedCS."No.Series", "No.Series") THEN BEGIN
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Schedule No.");
                NoSeriesMgt.SetSeries("Schedule No.");
                Rec := StudPlacementScheduleCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No Series Generation::CSPL-00114::05052019: End
    end;
}

