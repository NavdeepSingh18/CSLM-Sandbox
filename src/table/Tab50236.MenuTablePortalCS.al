table 50236 "Menu Table Portal-CS"
{
    // version V.001-CS

    Caption = 'Menu Table Portal-CS';

    fields
    {
        field(1; MENU_NAME; Text[150])
        {
            Caption = 'MENU_NAME';
            DataClassification = CustomerContent;
        }
        field(2; PRIORITY; Integer)
        {
            Caption = 'PRIORITY';
            DataClassification = CustomerContent;
        }
        field(3; PARENT_ID; Text[30])
        {
            Caption = 'PARENT_ID';
            DataClassification = CustomerContent;
        }
        field(4; LINK; Text[150])
        {
            Caption = 'LINK';
            DataClassification = CustomerContent;
        }
        field(5; Parent_IntId; Integer)
        {
            Caption = 'Parent_IntId';
            DataClassification = CustomerContent;
        }
        field(6; id; Integer)
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(7; Availability; Integer)
        {
            Caption = 'Availability';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; MENU_NAME)
        {
        }
    }

    fieldgroups
    {
    }
}

