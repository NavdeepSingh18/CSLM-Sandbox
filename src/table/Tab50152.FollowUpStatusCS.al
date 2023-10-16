table 50152 "Follow Up Status-CS"
{
    // version V.001-CS

    //DrillDownPageID = 33049802;
    //LookupPageID = 33049802;
    Caption = 'Follow Up Status-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {

            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Follow Up Status"; Option)
        {

            caption = 'Follow Up Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Hot,Warm,Cold';
            OptionMembers = " ",Hot,Warm,Cold;
        }
        field(4; "Next Follow Up Date"; Date)
        {
            caption = 'Next Follow Up Date';
            DataClassification = CustomerContent;
        }
        field(5; Remarks; Text[150])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "No.", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

