table 50183 "Application Cert. Cate-CS"
{
    // version V.001-CS
    Caption = 'Application Cert. Cate-CS';

    fields
    {
        field(1; "Application Category Code"; Code[20])
        {
            Caption = 'Application Category Code';
            DataClassification = CustomerContent;
        }
        field(2; "App Category Classification"; Text[50])
        {
            Caption = 'App Category Classification';
            DataClassification = CustomerContent;
        }
        field(3; "Payment Required"; Boolean)
        {
            Caption = 'Payment Require';
            DataClassification = CustomerContent;
        }
        field(4; "Fee Code"; Code[10])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
        }
        field(5; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Application Category Code")
        {
        }
    }

    fieldgroups
    {
    }
}

