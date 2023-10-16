table 50326 "Faculty Feedback-CS"
{
    // version V.001-CS
Caption='Faculty Feedback';

    fields
    {
        field(1; SNo; Integer)
        {
            Caption = 'SNo';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            begin
                if StudentMasterRec.Get("Student No.") then
                    "Student Name" := StudentMasterRec."Student Name"
                else
                    "Student Name" := '';
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; FeedbackFor; Text[50])
        {
            Caption = 'FeedbackFor';
            DataClassification = CustomerContent;
        }
        field(5; "Question Description"; Text[250])
        {
            Caption = 'Question Description';
            DataClassification = CustomerContent;
        }
        field(6; Type; Text[20])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(7; Rate; Integer)
        {
            Caption = 'Rate';
            DataClassification = CustomerContent;
        }
        field(8; Course; Code[10])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(9; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(14; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(15; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(16; "Remarks By Student"; Text[100])
        {
            Caption = 'Remarks By Student';
            DataClassification = CustomerContent;
        }
        field(17; "Question Id"; Integer)
        {
            Caption = 'Question Id';
            DataClassification = CustomerContent;
        }
        field(18; "All Save"; Boolean)
        {
            Caption = 'All Save';
            DataClassification = CustomerContent;
        }
        field(19; Graduation; Code[10])
        {
            FieldClass = FlowField;
            Caption = 'Graduation';
            CalcFormula = Lookup ("Course Master-CS".Graduation WHERE(Code = FIELD(Course)));

        }
        field(20; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Type of Evaluation"; Option)
        {

            DataClassification = CustomerContent;
            OptionCaption = 'Constructive Evaluation, Faculty Evaluation, Course/Subject Evaluation';
            OptionMembers = "Constructive Evaluation","Faculty Evaluation","Course/Subject Evaluation";
            Editable = false;
        }
        field(22; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }

    }

    keys
    {
        key(Key1; SNo)
        {
        }
        key(Key2; "Subject Code", Section, "Faculty Code", "Student No.")
        {
        }
    }

    fieldgroups
    {
    }
    var
        StudentMasterRec: Record "Student Master-CS";
}

