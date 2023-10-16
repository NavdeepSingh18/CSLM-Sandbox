table 50063 "Mobile API Response"
{
    // version V.001-CS

    Caption = 'Mobile API Response';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; Url; Text[250])
        {
            Caption = 'Url';
            DataClassification = CustomerContent;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; Operation; Text[10])
        {
            Caption = 'Operation';
            DataClassification = CustomerContent;
        }
        field(5; "Fail Response Message"; Text[250])
        {
            Caption = 'Fail Response Message';
            DataClassification = CustomerContent;
        }
        field(6; "Request Method"; Text[30])
        {
            Caption = 'Request Method';
            DataClassification = CustomerContent;
        }
        field(7; Category; Text[150])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(8; "Synch Value"; Text[200])
        {
            Caption = 'Synch Value';
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

