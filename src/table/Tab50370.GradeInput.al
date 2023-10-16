table 50370 "Grade Input"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(5; "Admitted Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Admitted Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(10; Semester; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
        }
        field(15; "Exam Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Exam Code';
            TableRelation = "Course Wise Subject Line-CS"."Subject Code" where("Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Academic Year" = field("Academic Year"), Semester = field(Semester));
            //TableRelation = "Course Wise Subject Line-CS"."Subject Code" where("Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Academic Year" = field("Academic Year"), Semester = field(Semester), "Level Description" = filter("External Examination" | "Internal Exam Component"));
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Exam Description" := '';
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Exam Code");
                if SubjectMaster.FindFirst() then
                    "Exam Description" := SubjectMaster.Description;
            end;
        }
        field(16; "Exam Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Exam Description';
            Editable = false;
        }
        field(20; "Type of Input"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type of Input';
            OptionMembers = " ","Best","Model","Original";
            OptionCaption = ' ,Best,Model,Original';
        }
        field(25; "Input Sequence"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Input Sequence';
            MinValue = 0;
        }
        field(30; Points; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Points';
        }
    }

    keys
    {
        key(PK; "Global Dimension 1 Code", "Academic Year", "Admitted Year", Semester, "Exam Code", "Type of Input", "Input Sequence")
        {
            Clustered = true;
        }
        key(Sort; "Global Dimension 1 Code", "Academic Year", "Admitted Year", Semester, "Type of Input", "Input Sequence")
        {
            Clustered = false;
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