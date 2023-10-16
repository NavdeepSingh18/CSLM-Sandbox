table 50252 "Stud Placement Company-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   24/05/2019       OnInsert()                                 Get "No Series","Academic Year","User Id" Values
    // 02    CSPL-00114   24/05/2019       Company Code - OnValidate()                Code added for Get No Series.
    // 03    CSPL-00114   24/05/2019       Assistedit() - Function                    Code added for No series Generation auto

    Caption = 'Stud Placement Company-CS';
    DrillDownPageID = 50148;
    LookupPageID = 50148;

    fields
    {
        field(1; "Company Code"; Code[20])
        {
            Caption = 'Company Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get No Series::CSPL-00114::24052019: Start
                IF "Company Code" <> xRec."Company Code" THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Placement Company No.");
                    "No.Series" := '';
                END;
                //Code added for Get No Series.::CSPL-00114::24052019: End
            end;
        }
        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(3; "Company Address"; Text[150])
        {
            Caption = 'Company Address';
            DataClassification = CustomerContent;
        }
        field(4; "Company Phone"; Code[20])
        {
            Caption = 'Company Phone';
            DataClassification = CustomerContent;
        }
        field(5; "Company Website"; Text[30])
        {
            Caption = 'Company Website';
            DataClassification = CustomerContent;
        }
        field(6; "Contact Person"; Text[30])
        {
            Caption = 'Contact Person';
            DataClassification = CustomerContent;
        }
        field(7; "Contact person Designation"; Text[30])
        {
            Caption = 'Contact person Designation';
            DataClassification = CustomerContent;
        }
        field(8; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(9; "Company Address1"; Text[150])
        {
            Caption = 'Company Address1';
            DataClassification = CustomerContent;
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(11; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            //     TableRelation = "Post Code".Code;
        }
        field(12; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(15; State; Text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            //TableRelation = State.Code;
        }
        field(16; Country; Text[30])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region"."Code";
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 24052019';
        }
    }

    keys
    {
        key(Key1; "Company Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series","Academic Year","User Id" Values::CSPL-00114::24052019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();

        IF "Company Code" = '' THEN BEGIN
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Company No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Placement Company No.", xRec."No.Series", 0D, "Company Code", "No.Series");
        END;
        //Get "No Series","Academic Year","User Id" Values::CSPL-00114::24052019: End
    END;


    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";

        //CS-BLOCKEDPostCode: Record "225";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure Assistedit(StudPlacementCompanyCS: Record "Stud Placement Company-CS"): Boolean
    begin
        //Code added for No series Generation auto::CSPL-00114::24052019: Start
        WITH StudPlacementCompanyCS DO BEGIN
            StudPlacementCompanyCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Company No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Placement Company No.", StudPlacementCompanyCS."No.Series", "No.Series") THEN BEGIN
                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Placement Company No.");
                NoSeriesMgt.SetSeries("Company Code");
                Rec := StudPlacementCompanyCS;
                EXIT(TRUE);
            END;

            //Code added for No series Generation auto::CSPL-00114::24052019: End
        end;
    END;
}

