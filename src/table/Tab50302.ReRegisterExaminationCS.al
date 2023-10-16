table 50302 "Re-Register Examination-CS"
{
    // version V.001-CS

    Caption = 'Re-Register Examination-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Course Sem. Master-CS"."Semester Code" WHERE("Course Code" = FIELD("Course Code"));
        }
        field(3; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(7; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Course Section Master-CS".Year WHERE("Course Code" = FIELD("Course Code"),
                                                                   Semester = FIELD(Semester));
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(11; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(12; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(13; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Regular,Re-Registration,Makeup';
            OptionMembers = " ",Regular,"Re-Registration",Makeup;
        }
        field(50000; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
            TableRelation = "Student Master-CS";
        }
        field(50001; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
        }
        field(50020; "Previous Semester"; Code[10])
        {
            Caption = 'Previous Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
            TableRelation = "Semester Master-CS";
        }
        field(50021; "Previous Year"; Code[20])
        {
            Caption = 'Previous Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
            TableRelation = "Year Master-CS";
        }
        field(50022; "Previous Academic Year"; Code[10])
        {
            Caption = 'Previous Academic Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50023; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27082019';
        }
    }

    keys
    {
        key(Key1; "Course Code", Semester, "Subject Type", "Subject Code", "Academic Year", "Staff Code", Section, "Global Dimension 1 Code", "Global Dimension 2 Code", "Type Of Course", Year, "Document Type", "Exam Type", "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
}

