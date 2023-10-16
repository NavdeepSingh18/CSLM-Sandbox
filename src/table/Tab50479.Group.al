table 50479 "Group"
{
    Caption = 'Group';
    // LookupPageId = Groups;
    // DrillDownPageId = Groups

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[60])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(11; "Group Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Clinical;
        }
    }

    keys
    {
        key(Key1; Code)
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;
}