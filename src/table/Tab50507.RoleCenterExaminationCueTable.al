table 50507 RoleCenterExaminationCueTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;

        }
        field(2; "PREMED 1 Student"; Integer)
        {
            Caption = 'PREMED 1 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('PREMED1')));
            Editable = False;


        }
        field(3; "PREMED 2 Student"; Integer)
        {
            Caption = 'PREMED 2 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('PREMED2')));
            Editable = false;

        }
        field(4; "PREMED 3 Student"; Integer)
        {
            Caption = 'PREMED 3 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('PREMED3')));
            Editable = false;

        }
        field(5; "PREMED 4 Student"; Integer)
        {
            Caption = 'PREMED 4 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('PREMED4')));
            Editable = false;

        }
        field(6; "Exam Room"; Integer)
        {
            Caption = 'Exam Room';
            FieldClass = FlowField;
            CalcFormula = count("Rooms-CS" where("Global Dimension 1 Code" = field("Institute Code")));
            Editable = false;
        }
        field(7; "Institute Code"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //DataClassification = CustomerContent;
            FieldClass = FlowFilter;
        }
        field(8; "Course Subject"; Integer)
        {
            Caption = 'Course Subject';
            FieldClass = FlowField;
            CalcFormula = count("Course Wise Subject Head-CS" where("Global Dimension 1 Code" = field("Institute Code")));
            Editable = false;
        }
        field(9; "MED 1 Student"; Integer)
        {
            Caption = 'MED 1 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('MED1')));
            Editable = False;


        }
        field(10; "MED 2 Student"; Integer)
        {
            Caption = 'MED 2 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('MED2')));
            Editable = false;

        }
        field(11; "MED 3 Student"; Integer)
        {
            Caption = 'MED 3 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('MED3')));
            Editable = false;

        }
        field(12; "MED 4 Student"; Integer)
        {
            Caption = 'MED 4 Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('MED4')));
            Editable = false;

        }
        field(13; "BSIC Student"; Integer)
        {
            Caption = 'BSIC Student';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code"), Semester = const('BSIC')));
            Editable = false;

        }
        field(14; "Total Students"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" where("Global Dimension 1 Code" = field("Institute Code")));
        }
        field(15; "Total Courses"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Course Master-CS" where("Global Dimension 1 Code" = field("Institute Code")));
        }
        field(16; "Published Internal Exams"; Integer)
        {
            caption = 'Internal Exams';
            FieldClass = FlowField;
            CalcFormula = count("Internal Exam Header-CS" where(Status = filter(Published)));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(17; "Published External Exams"; Integer)
        {
            caption = 'External Exams';
            FieldClass = FlowField;
            CalcFormula = count("External Exam Header-CS" where(Status = filter(Published)));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(18; "Academic Year Filter"; Code[20])
        {
            Caption = 'Academic Year Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}