table 50329 "Housing Group"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Group';
    LookupPageId = "Housing Group List";
    DrillDownPageId = "Housing Group List";
    DataCaptionFields = "Group Code", "Group Name";

    fields
    {
        field(1; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Group Code';

        }
        field(2; "Group Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Group Name';

        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(5; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(6; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(7; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(8; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(9; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(10; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(11; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(13; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(14; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Group Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Group Code", "Group Name", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
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