table 50181 "Institute Role-CS"
{
    // version V.001-CS

    Caption = 'Institute Role-CS';
    DrillDownPageID = 50178;
    LookupPageID = 50178;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; "Role Code"; Code[20])
        {
            Caption = 'Role Code';
            DataClassification = CustomerContent;
        }
        field(3; "Role Name"; Text[250])
        {
            Caption = 'Role Name';
            DataClassification = CustomerContent;
        }
        field(4; Type; Text[100])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(5; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
        }
        field(6; Status; Boolean)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(7; "Create By"; Text[200])
        {
            Caption = 'Create By';
            DataClassification = CustomerContent;
        }
        field(8; "Create On"; Date)
        {
            Caption = 'Create On';
            DataClassification = CustomerContent;
        }
        field(9; "Modify By"; Text[200])
        {
            Caption = 'Modify By';
            DataClassification = CustomerContent;
        }
        field(10; "Modify On"; Date)
        {
            Caption = 'Modify On';
            DataClassification = CustomerContent;
        }
        field(11; "Created From"; Text[50])
        {
            Caption = 'Created From';
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Role Code")
        {
        }
    }

    fieldgroups
    {
    }
}

