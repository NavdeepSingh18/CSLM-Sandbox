table 50191 "Main Sub Batch UP log-CS"
{
    // version V.001-CS

    Caption = 'Main Sub Batch UP log-CS';

    fields
    {
        field(1; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(5; "Course Code"; Code[10])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(7; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(8; "Roll No."; Code[10])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
        }
        field(9; "Student Group"; Code[20])
        {
            Caption = 'Student Group';
            DataClassification = CustomerContent;
        }
        field(10; "Student Batch"; Code[10])
        {
            Caption = 'Student Batch';
            DataClassification = CustomerContent;
        }
        field(11; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(12; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Enrollment No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

