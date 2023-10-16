table 50396 Goal
{
    DataClassification = CustomerContent;
    Caption = 'Goal';

    fields
    {
        field(1; "Goal Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Goal Code';
        }
        field(2; "Goal Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Goal Description';
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

    }

    keys
    {
        key(PK; "Goal Code")
        {
            Clustered = true;
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