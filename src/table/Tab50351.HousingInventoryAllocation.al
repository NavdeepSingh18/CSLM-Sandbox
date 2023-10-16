table 50351 "Housing Inventory Allocation"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Inventory Allocation';

    fields
    {
        field(1; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hostel ID';
            Editable = false;
        }
        field(2; "Item Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Code';
            TableRelation = "Housing Inventory Master"."Item Code";
            trigger OnValidate()
            begin
                IF HousingInventoryMasterRec.Get("Item Code") then
                    "Item Name" := HousingInventoryMasterRec."Item Description"
                else
                    "Item Name" := '';
            end;

        }
        field(3; "Item Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
            Editable = false;

        }
        field(4; Qunatity; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            MinValue = 0;

        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(9; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(10; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(11; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(12; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = False;

        }
        Field(13; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = False;

        }
        field(14; "Room No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption='Apartment No.';
        }
        Field(15; "Inventory Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Apartment Wise","Room Wise";
            OptionCaption = ' ,Apartment Wise,Room Wise';


        }
    }

    keys
    {
        key(Key1; "Housing ID", "Item Code", "Room No.")
        {
            Clustered = true;
        }
    }

    var
        HousingInventoryMasterRec: Record "Housing Inventory Master";

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := WORKDATE();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := WORKDATE();
        Updated := true;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}