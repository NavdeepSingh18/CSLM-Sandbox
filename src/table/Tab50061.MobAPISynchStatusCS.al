table 50061 "Mob. API Synch Status-CS"
{
    // version V.001-CS

    Caption = 'Mob. API Synch Status-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(3; "Even_Odd Semester"; Option)
        {
            Caption = 'Even_Odd Semester';
            DataClassification = CustomerContent;
            OptionCaption = 'Even Semester,Odd Semester';
            OptionMembers = "Even Semester","Odd Semester";
        }
        field(4; "End Semester Marks Published"; Boolean)
        {
            Caption = 'End Semester Marks Published';
            DataClassification = CustomerContent;
        }
        field(5; "Regular Exam Grade Published"; Boolean)
        {
            Caption = 'Regular Exam Grade Published';
            DataClassification = CustomerContent;
        }
        field(6; "Makeup Exam Grade Published"; Boolean)
        {
            Caption = 'Makeup Exam Grade Published';
            DataClassification = CustomerContent;
        }
        field(7; "Special Exam Grade published"; Boolean)
        {
            Caption = 'Special Exam Grade published';
            DataClassification = CustomerContent;
        }
        field(8; "Rev_ 1  Exam Grade Published"; Boolean)
        {
            Caption = 'Rev_ 1  Exam Grade Published';
            DataClassification = CustomerContent;
        }
        field(9; "Rev_ 2  Exam Grade Published"; Boolean)
        {
            Caption = 'Rev_ 2  Exam Grade Published';
            DataClassification = CustomerContent;
        }
        field(10; "GPA & CGPA Generated"; Boolean)
        {
            Caption = 'GPA & CGPA Generated';
            DataClassification = CustomerContent;
        }
        field(11; LastTimeTableSerialNo; Integer)
        {
            Caption = 'LastTimeTableSerialNo';
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
        }
        field(14; "Internal Marks Published"; Boolean)
        {
            Caption = 'Internal Marks Published"';
            DataClassification = CustomerContent;
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

