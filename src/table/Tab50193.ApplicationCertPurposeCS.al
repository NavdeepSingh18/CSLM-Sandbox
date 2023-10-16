table 50193 "Application Cert Purpose-CS"
{
    // version V.001-CS

    Caption = 'Application Cert Purpose-CS';

    fields
    {
        field(1; "Code"; Code[20])
        {
            caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            caption = 'Description';
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

