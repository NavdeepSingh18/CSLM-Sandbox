table 50014 "Job Queue Mail IDs-CS"
{
    // version V.001-CS


    Caption = 'Job Queue Mail IDs-CS';
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Email-To"; Text[150])
        {
            Caption = 'Email-To';
            DataClassification = CustomerContent;
        }
        field(3; "Email-Cc 1"; Text[150])
        {
            Caption = 'Email-Cc 1';
            DataClassification = CustomerContent;
        }
        field(4; "Email-Cc 2"; Text[150])
        {
            Caption = 'Email-Cc 2';
            DataClassification = CustomerContent;
        }
        field(5; "Email-Cc 3"; Text[150])
        {
            Caption = 'Email-Cc 3';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

