table 50262 "Product Group-CS"
{
    // version V.001-CS

    Caption = 'Product Group-CS';

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
        }
        field(2; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item Category Code", "Product Group Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

