table 50171 "SLcm Portal Roles-CS"
{
    // version V.001-CS

    Caption = 'SLcm Portal Roles-CS';

    fields
    {
        field(1; "Role Code"; Code[20])
        {
            Caption = 'Role Code';
            DataClassification = CustomerContent;
        }
        field(2; "Role Name"; Text[50])
        {
            Caption = 'Role Name';
            DataClassification = CustomerContent;
        }
        field(3; Type; Text[50])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Role Code", "Role Name")
        {
        }
    }

    fieldgroups
    {
    }
}

