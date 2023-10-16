table 50187 "Course Wise Subj L-Copy-CS"
{
    // version V.001-CS

    Caption = 'Course Wise Subj L-Copy-CS';
    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code WHERE("Course Closed" = FILTER(false));
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code WHERE("Subject Closed" = FILTER(false));
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Course Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

