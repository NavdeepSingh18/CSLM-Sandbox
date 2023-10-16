table 50226 "Fine Attendance Line-CS"
{
    // version V.001-CS

    Caption = 'Fine Attendance Line-CS';
    //DrillDownPageID = 33049454;
    //LookupPageID = 33049454;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
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
            TableRelation = "Student Master-CS";
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(6; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(9; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(10; "Fine Amount"; Decimal)
        {
            Caption = 'Fine Amount';
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            caption = 'Type Of Course"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Document No.", "Student No.")
        {
            SumIndexFields = "Fine Amount";
        }
    }

    fieldgroups
    {
    }
}

