table 50458 "Honors"
{
    Caption = 'Honors';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
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
        field(7; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Updated By"; Text[50])
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
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        Field(12; "Min. Range"; Decimal)
        {
            Caption = 'Min. Range';
            DataClassification = CustomerContent;
        }
        field(13; "Max. Range"; Decimal)
        {
            Caption = 'Max. Range';
            DataClassification = CustomerContent;

        }
        field(14; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; Code, "Effective Date")
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "User ID" := FORMAT(UserId());
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());
    end;

    trigger OnModify()
    begin
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());
    end;
}