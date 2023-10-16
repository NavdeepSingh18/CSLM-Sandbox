table 50219 "Elective Group Master-CS"
{
    // version V.001-CS

    Caption = 'Elective Group Master-CS';
    // DrillDownPageID = 50128;
    // LookupPageID = 50128;

    fields
    {
        field(1; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
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
        key(Key1; "Group Code")
        {
        }
    }

    fieldgroups
    {
    }
}

