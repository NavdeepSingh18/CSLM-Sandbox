table 50124 "Subject Open Elective-CS"
{
    // version V.001-CS

    Caption = 'Subject Open Elective-CS';

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
        field(4; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(5; "Subject Name"; Text[60])
        {
            Caption = 'Subject Name';
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Course Code", Semester, "Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

