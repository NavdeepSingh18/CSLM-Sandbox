table 50450 "Inference Master"
{
    DataClassification = CustomerContent;
    // LookupPageId = Inference;
    // DrillDownPageId = Inference;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(4; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(6; "Inserted By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(7; "Inserted On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(8; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(9; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(10; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        Inserted := true;
        "Inserted By" := UserId();
        "Inserted On" := Today();
    end;

    trigger OnModify()
    begin
        Updated := true;
        "Updated By" := UserId();
        "Updated On" := Today();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}