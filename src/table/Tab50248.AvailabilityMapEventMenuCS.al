table 50248 "Availability Map EventMenu-CS"
{
    // version V.001-CS

    Caption = 'Availability Map EventMenu-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
            TableRelation = "Education Event-CS"."Event Code";
        }
        field(3; "Menu Name"; Text[50])
        {
            Caption = 'Menu Name"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

