table 50240 "Synch Error Log SFAS-CS"
{
    // version V.001-CS

    Caption = 'Synch Error Log SFAS-CS';
    DrillDownPageID = 50342;
    LookupPageID = 50342;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; Error; Text[250])
        {
            Caption = 'Error';
            DataClassification = CustomerContent;
        }
        field(4; "Error Date"; DateTime)
        {
            Caption = 'Error Date';
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

