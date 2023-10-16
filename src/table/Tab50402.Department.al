table 50402 Department
{
    DataClassification = CustomerContent;
    Caption = 'Department';
    DataCaptionFields = "Department Code", "Department Name";
    LookupPageId = "Academic Department List";

    fields
    {
        field(1; "Department Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Department Code';
        }
        field(2; "Department Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Department Name';
        }

        field(3; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(5; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Department Email"; Text[100])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Department Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(Dropdown; "Department Code", "Department Name")
        {
        }
    }

    var

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        Updated := true;
    end;

}