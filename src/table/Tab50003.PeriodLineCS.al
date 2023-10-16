table 50003 "Period Line-CS"
{
    // version V.001-CS

    Caption = 'Period Line-CS';
    //LookupPageID = 33049479;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;

        }
        field(2; "Period Time"; Time)
        {
            Caption = 'Period Time';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Period; Text[30])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;
        }
        field(5; "Interval Check"; Boolean)
        {
            Caption = 'Interval Check';
            DataClassification = CustomerContent;
        }
        field(6; "Lab Start Hour"; Boolean)
        {
            Caption = 'Lab Start Hour';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
        }
        key(Key2; "Period Time")
        {
        }
        key(Key3; "Code", "Lab Start Hour")
        {
        }
    }


}

