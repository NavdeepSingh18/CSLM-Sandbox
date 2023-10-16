table 50427 "Marks Weightage Grade Book"
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
        field(3; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(4; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
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
            Trigger OnValidate()
            var
                GradeBook: Record "Grade Book";
            Begin
                GradeBook.Reset();
                GradeBook.SetRange("Grade Book No.", Rec."Grade Book No.");
                GradeBook.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                GradeBook.SetRange(Course, Rec."Course Code");
                GradeBook.SetRange(Semester, Rec.Semester);
                GradeBook.SetRange("Academic Year", Rec."Academic Year");
                GradeBook.SetRange(Term, Rec.Term);
                GradeBook.SetRange("Exam Code", Rec."Exam Code");
                IF GradeBook.FindSet() then begin
                    repeat
                        GradeBook."Available Points" := Rec.Points;
                        GradeBook.Modify();
                    until GradeBook.Next() = 0;
                end;
            End;
        }
        field(31; "Entry No. PK"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(33; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        Field(34; "Cohort"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(35; "Consider for Marks Weightage"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Entry No. PK")
        {
            Clustered = true;
        }
        key(Key2; "Global Dimension 1 Code", "Academic Year", "Admitted Year", "Course Code", Semester, "Exam Code", "Type of Input", "Input Sequence")
        {
            Clustered = false;
        }
        key(Sort; "Global Dimension 1 Code", "Academic Year", "Admitted Year", "Course Code", Semester, "Type of Input", "Input Sequence")
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