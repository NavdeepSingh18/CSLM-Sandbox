table 50100 "Attend Percentage Line-CS"
{
    // version V.001-CS

    Caption = 'Attendance Percentage Line-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(3; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = "Subject Master-CS";
            DataClassification = CustomerContent;
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Internal Attendance Header-CS";
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(6; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(7; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type-CS";
            DataClassification = CustomerContent;
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(11; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
        }
        field(12; "Date Till"; Date)
        {
            Caption = 'Date Till';
            DataClassification = CustomerContent;
        }
        field(13; "Maximum Hours"; Integer)
        {
            Caption = 'Maximum Hours';
            DataClassification = CustomerContent;
        }
        field(14; "Attended Hours"; Integer)
        {
            Caption = 'Attended Hours';
            DataClassification = CustomerContent;
        }
        field(15; "Eligible For Exam"; Boolean)
        {
            Caption = 'Eligible For Exam';
            DataClassification = CustomerContent;
        }
        field(16; "Attendance Fine Amount"; Decimal)
        {
            Caption = 'Attendance Fine Amount';
            DataClassification = CustomerContent;
        }
        field(17; "Result Generated"; Boolean)
        {
            Caption = 'Result Generated';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 20-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 20-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 20-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 20-04-2019';
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code")
        {
        }
        key(Key3; "Document No.", "Student No.")
        {
        }
        key(Key4; "Student No.", Semester, Section, "Subject Code", "Eligible For Exam")
        {
        }
        key(Key5; "Student No.", Semester, "Subject Code", "Eligible For Exam")
        {
        }
        key(Key6; "Course Code", Semester, Section, "Academic Year", "Eligible For Exam")
        {
        }
    }

    fieldgroups
    {
    }
}