table 50021 "Student Class Assignment-CS"
{
    // version V.001-CS

    Caption = 'Student Class Assignment-CS';
    fields
    {
        field(1; "Order"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Order';
            CalcFormula = Count ("Student Header Marks-CS" WHERE(Semester = FIELD(Semester),
                                                  "Student No." = FIELD("Student No.")));

        }
        field(2; Course; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(8; Session; Code[20])
        {
            caption = '';
            DataClassification = CustomerContent;

            TableRelation = Session;
        }
        field(11; Subject; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Generated Time Table-CS";
        }
        field(12; "Student No."; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
            TableRelation = "Internal Attendance Header-CS";
        }
        field(13; "Assignment No."; Code[20])
        {
            Caption = '';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Assignment No.", Semester, "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    var

}

