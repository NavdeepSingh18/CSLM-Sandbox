table 50274 "Stage1 Selection Detail2-CS"
{
    Caption = 'Stage1 Selection Detail2-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "Application-CS";
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; "Application Selection"; Boolean)
        {
            Caption = 'Application Selection';
            DataClassification = CustomerContent;
        }
        field(5; "Eligibility Percertage"; Decimal)
        {
            Caption = 'Eligibility Percertage';
            DataClassification = CustomerContent;
        }
        field(6; "Eligibility Rank"; Integer)
        {
            Caption = 'Eligibility Rank';
            DataClassification = CustomerContent;
        }
        field(7; "Selection List No."; Integer)
        {
            Caption = 'Selection List No.';
            DataClassification = CustomerContent;
        }
        field(8; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(9; "Applicant Name"; Text[30])
        {
            Caption = 'Applicant Name';
            DataClassification = CustomerContent;
        }
        field(10; Quota; Code[20])
        {
            Caption = 'Quota';
            DataClassification = CustomerContent;
            TableRelation = "Quota-CS";
        }
        field(11; "Eligibility Quota"; Code[20])
        {
            Caption = 'Eligibility Quota';
            DataClassification = CustomerContent;
        }
        field(12; "Eligibility Quota Rank"; Integer)
        {
            Caption = 'Eligibility Quota Rank';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
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

