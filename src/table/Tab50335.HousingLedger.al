table 50335 "Housing Ledger"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Ledger';
    LookupPageId = "Housing Ledger";
    DrillDownPageId = "Housing Ledger";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';

        }
        field(2; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';

        }
        field(3; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = ' ,Assigned,UnAssigned';
            OptionMembers = " ",Assigned,UnAssigned;

        }
        field(4; "Housing ID"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';

        }
        field(5; "Room Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';
            TableRelation = "Room Category Master";

        }
        field(6; "Room No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment No.';
            TableRelation = "Room Master";

        }
        field(7; "Bed No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Room No.';

        }
        field(8; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";

        }
        field(9; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrolment No.';

        }
        field(10; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";

        }
        field(11; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";

        }
        field(12; "Room Assignment"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Assignment';

        }
        field(13; "Housing Allotted Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Allotted Start Date';

        }
        field(14; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';

        }
        field(15; "Housing Alloted End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Alloted End Date';

        }
        field(16; "Inventory Verified"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Verified';

        }
        field(17; "Housing Vacated On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Vacated On';

        }
        field(18; "Housing Changed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Changed On';

        }
        field(19; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';

        }
        field(20; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';

        }
        field(21; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';

        }
        field(22; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';

        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(25; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(26; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(27; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Vacate,Change Request,Renew';
            OptionMembers = " ",Vacate,"Change Request",Renew;
            Caption = 'Type';
            Editable = false;

        }
        field(28; "Original Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Original Application No.';
        }
        field(29; "Contract No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract No.';
        }
        field(30; "Housing Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Group';
        }
        field(31; "Housing Name"; Text[100])
        {
            Caption = 'Housing Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Housing Master"."Housing Name" where("Housing ID" = Field("Housing ID")));
        }
        field(32; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(33; "Term"; Option)
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(34; "With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'With Spouse';
        }
        field(35; "Spouse Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Spouse Entry';
        }
        field(36; "Housing Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(37; "Room Mate Name Pref"; Text[50])
        {
            Caption = 'Apartment Mate Name Pref';
            DataClassification = CustomerContent;
        }
        field(38; "Room Mate Email Pref"; Text[80])
        {
            Caption = 'Apartment Mate Email Pref';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(39; "Bed Size"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Room Size';
        }
        Field(40; "1st Time Island"; Boolean)
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var


    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        Updated := true;
    end;

}