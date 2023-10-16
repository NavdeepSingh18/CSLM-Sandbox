table 50184 "Application Cert. Option-CS"
{
    // version V.001-CS

    Caption = 'Application Cert. Option-CS';

    fields
    {
        field(1; "Application Number"; Code[20])
        {
            Caption = 'Application Number';
            DataClassification = CustomerContent;
        }
        field(2; "App Option Code"; Code[20])
        {
            Caption = 'App Option Code';
            DataClassification = CustomerContent;
            TableRelation = "Application Option Master-CS".Code;
        }
        field(3; "Sequence No"; Integer)
        {
            Caption = 'Sequence No';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sequence No")
        {
        }
    }

    fieldgroups
    {
    }
}

