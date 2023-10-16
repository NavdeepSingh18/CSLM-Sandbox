page 50511 "Grade Input List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Marks Weightage";
    SourceTableView = sorting("Global Dimension 1 Code", "Academic Year", "Admitted Year", "Course Code", Semester, "Type of Input", "Input Sequence");
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(Entry)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ToolTip = 'Specifies the value of the Term field.';
                    ApplicationArea = All;
                }
                Field(Cohort; Rec.Cohort)
                {
                    ApplicationArea = All;
                }
                Field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Description"; Rec."Exam Description")
                {
                    ApplicationArea = All;
                }
                // field("Type of Input"; Rec."Type of Input")
                // {
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     var
                //         GradeInput: Record "Grade Input";
                //     begin
                //         GradeInput.Reset();
                //         GradeInput.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                //         GradeInput.SetRange("Academic Year", "Academic Year");
                //         GradeInput.SetRange("Admitted Year", "Admitted Year");
                //         GradeInput.SetRange(Semester, Semester);
                //         GradeInput.SetRange("Exam Code", "Exam Code");
                //         GradeInput.SetRange("Type of Input", "Type of Input");
                //         if GradeInput.FindFirst() then
                //             "Input Sequence" := GradeInput."Input Sequence" + 1;
                //     end;
                // }
                // field("Input Sequence"; Rec."Input Sequence")
                // {
                //     ApplicationArea = All;
                // }
                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                }
                field("Exam Selection"; Rec."Exam Selection")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}