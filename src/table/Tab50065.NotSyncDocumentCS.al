table 50065 "Not Sync Document-CS"
{
    // version V.001-CS

    Caption = 'Not Sync Document-CS';

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = CustomerContent;

        }
        field(2; "Enrollment No."; Code[10])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
        }
    }

    fieldgroups
    {
    }
}

