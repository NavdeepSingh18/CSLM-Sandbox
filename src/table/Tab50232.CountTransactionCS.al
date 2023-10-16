table 50232 "Count Transaction-CS"
{
    // version V.001-CS

    Caption = 'Count Transaction-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "Number of Transaction"; Integer)
        {
            Caption = 'Number of Transaction';
            DataClassification = CustomerContent;
        }
        field(4; "Transaction Type"; Text[200])
        {
            Caption = 'Transaction Type';
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

