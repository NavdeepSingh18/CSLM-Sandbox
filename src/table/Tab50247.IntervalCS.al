table 50247 "Interval-CS"
{
    // version V.001-CS

    Caption = 'Interval-CS';
    // DrillDownPageID = 50018;
    // LookupPageID = 50018;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

