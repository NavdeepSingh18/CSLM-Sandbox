table 50283 "Internal Marks Upload-CS"
{
    // version V.001-CS

    Caption = 'Internal Marks Upload-CS';

    fields
    {
        field(1; "Student Id"; Code[20])
        {
            Caption = 'Student Id';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code WHERE("Academic Year" = FIELD("Academic Year"));
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Internal Marks"; Decimal)
        {
            Caption = 'Internal Marks';
            DataClassification = CustomerContent;
        }
        field(9; "External Marks"; Decimal)
        {
            Caption = 'External Marks';
            DataClassification = CustomerContent;
        }
        field(10; "Credit Marks"; Decimal)
        {
            Caption = 'Credit Marks';
            DataClassification = CustomerContent;
        }
        field(11; "Student Name"; Text[80])
        {
            FieldClass = FlowField;
            Caption = 'Student Name';
            CalcFormula = Lookup ("Student Master-CS"."Student Name" WHERE("No." = FIELD("Student Id")));
            Editable = false;

        }
    }

    keys
    {
        key(Key1; "Student Id", "Course Code", Semester, "Subject Type", "Subject Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }
}

