table 50525 "Student Subject Exam Log-CS"
{
    // version V.001-CS

    Caption = 'Student Subject Exam Log';

    fields
    {
        field(1; "Student No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Enrollment No."; Code[20])
        {
        }
        field(4; "Student Name"; Text[100])
        {
        }
        field(5; "Document Type"; Text[30])
        {
        }
        field(6; "Table Type"; Option)
        {
            OptionMembers = ,"Student Subject","Student Optional Subject","Student Subject Exam";
        }
        field(7; "Old Value"; Code[20])
        {
        }
        field(8; "New Value"; Code[20])
        {
        }
        field(11; "Modified By"; Text[100])
        {
        }
        field(12; "Modified On"; Date)
        {
            Caption = 'Effective Date';
        }
        field(13; "Grade Change Type"; Option)
        {
            OptionCaption = ' ,Revaluation,MakeUp';
            OptionMembers = " ",Revaluation,MakeUp;
        }
        field(14; "Subject Code"; Code[20])
        {
        }

        field(15; "Stud. No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;
        }

        field(16; Semester; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;


        }
        field(17; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';

            DataClassification = CustomerContent;
        }
        field(18; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }

        field(19; Course; Code[20])
        {
            Caption = 'Course';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
        }
        field(20; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;

        }

        field(21; "Start Date"; date)
        {
            Description = 'CS Field Added 13-01-2021';
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(22; "Score Type"; Option)
        {
            Caption = 'Score Type';
            OptionMembers = " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK";
            OptionCaption = ' ,CBSE,CCSE,CCSSE,STEP 1,STEP 2 CS, STEP 2 CK';
        }
        field(23; Marks; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

