table 50312 "Exam Time Table History-CS"
{
    // version V.001-CS

    Caption = 'Exam Time Table History-CS';

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(6; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS";
        }
        field(7; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(8; "Hall Code"; Code[20])
        {
            Caption = 'Hall Code';
            DataClassification = CustomerContent;
            TableRelation = "Confrance Hall-CS";
        }
        field(9; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(10; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
        }
        field(11; "Exam Method"; Code[20])
        {
            Caption = 'Exam Method';
            DataClassification = CustomerContent;
        }
        field(12; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            DataClassification = CustomerContent;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(14; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Exam Date", "Exam Slot", "Hall Code")
        {
        }
        key(Key3; "Hall Code", "Exam Slot", "Exam Date")
        {
        }
        key(Key4; "Exam Slot", "Exam Date", "Hall Code")
        {
        }
    }

    fieldgroups
    {
    }
}

