table 50031 "User Group-CS"
{
    // version V.001-CS

    Caption = 'User Group-CS';
    DataPerCompany = false;
    DrillDownPageID = "User Group Detail-CS";
    LookupPageID = "User Group Detail-CS";

    fields
    {
        field(1; "User Group"; Code[20])
        {
            Caption = 'User Group';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; SID; Text[120])
        {
            Caption = 'SID';
            DataClassification = CustomerContent;
        }
        field(4; "Windows Login"; Text[150])
        {
            Caption = 'Windows Login';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50003; "Faculty Role"; Boolean)
        {
            Description = 'CS Field Added 06-05-2019';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "User Group")
        {
        }
    }

    fieldgroups
    {
    }
}

