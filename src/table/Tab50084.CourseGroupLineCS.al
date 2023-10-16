table 50084 "Course Group Line-CS"
{
    // version V.001-CS

    Caption = 'Course Group Line-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; "Group Code"; Code[10])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Group-CS";
        }
        field(3; "Prequalification Subject Code"; Code[20])
        {
            Caption = 'Prequalification Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Class Assignment Header-CS";
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Class Assignment Header-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Course Code", "Group Code", "Prequalification Subject Code")
        {
        }
    }

    fieldgroups
    {
    }
}

