table 50337 "Housing Inventory Master"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Inventory Master';
    LookupPageId = "Housing Inventory List";
    DrillDownPageId = "Housing Inventory List";
    DataCaptionFields = "Item Code", "Item Description";

    fields
    {
        field(1; "Item Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Code';

        }
        field(2; "Item Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description';

        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(4; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(5; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(6; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(7; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = False;

        }
        Field(8; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = False;

        }


    }

    keys
    {
        key(PK; "Item Code")
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