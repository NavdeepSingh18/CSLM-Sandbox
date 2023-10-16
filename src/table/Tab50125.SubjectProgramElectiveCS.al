table 50125 "Subject Program Elective-CS"
{
    // version V.001-CS

    Caption = 'Subject Program Elective-CS';

    fields
    {
        field(1; "Course Code"; Code[10])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(2; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(4; "Core Subject Code"; Code[10])
        {
            Caption = 'Core Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(5; " Core Subject Name"; Text[60])
        {
            Caption = 'Core Subject Name';
            DataClassification = CustomerContent;
        }
        field(6; "Pro. Elec. Subject Code"; Code[10])
        {
            Caption = 'Pro.Elec.Subject Code';
            DataClassification = CustomerContent;
        }
        field(7; "Pro. Elec. Subject Name"; Text[30])
        {
            Caption = 'Pro. Elec. Subject Name';
            DataClassification = CustomerContent;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Course Code", Semester, "Core Subject Code", "Pro. Elec. Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

