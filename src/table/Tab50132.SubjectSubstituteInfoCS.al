table 50132 "Subject Substitute Info-CS"
{
    // version V.001-CS


    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(3; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(4; "Course Code"; Code[10])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(6; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Actual Subject Code"; Code[10])
        {
            Caption = 'Actual Subject Code';
            DataClassification = CustomerContent;
        }
        field(9; "Actual Description"; Text[100])
        {
            Caption = 'Actual Description';
            DataClassification = CustomerContent;
        }
        field(10; Grade; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(11; "S No."; Integer)
        {
            Caption = 'S. No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(12; Updated; Boolean)
        {
            Caption = 'Update';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "S No.")
        {
        }
    }

    fieldgroups
    {
    }
}

