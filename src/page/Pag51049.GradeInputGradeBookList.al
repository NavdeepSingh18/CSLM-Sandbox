page 51049 "Grade Input Grade Book List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Grade Input Grade-Book List';
    UsageCategory = Lists;
    SourceTable = "Marks Weightage Grade Book";
    SourceTableView = sorting("Global Dimension 1 Code", "Academic Year", "Admitted Year", "Course Code", Semester, "Type of Input", "Input Sequence");
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Entry)
            {
                field("Grade Book No."; Rec."Grade Book No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exam Description"; Rec."Exam Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Type of Input";Rec."Type of Input")
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
                // field("Input Sequence";Rec."Input Sequence")
                // {
                //     ApplicationArea = All;
                // }
                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}