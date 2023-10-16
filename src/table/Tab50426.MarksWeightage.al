table 50426 "Marks Weightage"
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
            TableRelation = "Course Wise Subject Line-CS"."Subject Code" where("Global Dimension 1 Code" = field("Global Dimension 1 Code"), Semester = field(Semester));

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
            // trigger OnValidate()
            // var
            //     Sem: Record "Semester Master-CS";
            //     MarksWt: Record "Marks Weightage";
            //     SubMaster: Record "Subject Master-CS";
            //     SubMaster2: Record "Subject Master-CS";
            //     TotWt: Decimal;
            // begin
            //     SubMaster.Reset();
            //     SubMaster.SetRange(Code, "Exam Code");
            //     SubMaster.FindFirst();
            //     MarksWt.Reset();
            //     MarksWt.SetRange("Course Code", "Course Code");
            //     MarksWt.SetRange(Semester, Semester);
            //     if MarksWt.FindSet() then
            //         repeat
            //             if SubMaster.Level = 2 then begin
            //                 SubMaster2.Reset();
            //                 SubMaster2.SetRange(Code, MarksWt."Exam Code");
            //                 SubMaster2.SetRange(Level, SubMaster.Level);
            //                 SubMaster2.SetRange("Level Code", SubMaster."Level Code");
            //                 SubMaster2.FindFirst();
            //                 // if SubMaster2.Level = SubMaster.Level then
            //                 TotWt += MarksWt.Points;
            //             end;

            //         until MarksWt.Next() = 0;
            // end;


        }

        Field(31; "Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(33; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        Field(34; Cohort; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(35; "Exam Selection"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code" where(Type = Filter("External Exam" | "Internal Exam"));
        }
    }

    keys
    {
        key(PK; "Entry No.")
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