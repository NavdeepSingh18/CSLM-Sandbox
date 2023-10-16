table 50235 "Main Batch Update-CS"
{
    // version V.001-CS

    Caption = 'Main Batch Update-CS';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;
        }
        field(4; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS".Code;
        }
        field(5; "Roll No"; Code[10])
        {
            Caption = 'Roll No';
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(7; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(8; Batch; Code[20])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
            TableRelation = "Batch-CS".Code;
        }
        field(9; "Not Updated"; Boolean)
        {
            Caption = 'Not Updated';
            DataClassification = CustomerContent;
        }
        field(10; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Course Code", Semester, Section, "Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        IF xRec."Not Updated" = Rec."Not Updated" THEN
            "Not Updated" := FALSE;
    end;
}

