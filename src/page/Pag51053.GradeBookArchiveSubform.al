page 51053 GradeBookArchiveSubform
{
    SourceTable = "Grade Book Archive";
    UsageCategory = Administration;
    ApplicationArea = All;
    PageType = ListPart;
    Editable = false;
    // SourceTableView = Sorting("Student No.", Semester, "Academic Year", "Exam Code") ORDER(Ascending) where("Type of Input" = filter('Best' | " "));
    SourceTableView = Sorting("Student No.", Semester, "Academic Year", "Exam Code");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                // IndentationColumn = NameIndent;
                // IndentationControls = "Student No.", "Student Name";
                // ShowAsTree = true;
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Exam Description"; Rec."Exam Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                // field("Type of Input"; "Type of Input")
                // {
                //     ApplicationArea = All;
                //     Style = Strong;

                // }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide2;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide2;
                }
                field("Earned Points"; Rec."Earned Points")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide1;
                }
                field("Available Points"; Rec."Available Points")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide1;
                }
                field("Earned Points Percentage"; Rec."Earned Points Percentage")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide1;
                }
                field("% Range"; Rec."% Range")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide1;
                }
                field("Grade Result"; Rec."Grade Result")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide1;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    // HideValue = Hide1;
                }
                // field("Quality Point"; "Quality Point")
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                //     // HideValue = Hide1;
                // }
                // field(Credit; Credit)
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                //     // HideValue = Hide1;
                // }
                // field("Credit Earned"; "Credit Earned")
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                //     // HideValue = Hide1;
                // }
            }
        }
    }
    // actions
    // {
    //     area(Navigation)
    //     {
    //         action("Grade Book Breakup Details")
    //         {
    //             Caption = 'Grade Book Breakup Details';
    //             ApplicationArea = All;
    //             RunObject = Page "Grade Book Breakup List";
    //             RunPageLink = "Exam Code" = FIELD("Exam Code"), "Student No." = field("Student No."), Semester = field(Semester), "Academic Year" = field("Academic Year");

    //         }
    //         action("Passing Grade")
    //         {
    //             Caption = 'Passing Grade';
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 GradeListEdit: Page "Grade List-CS";
    //             begin
    //                 Clear(GradeListEdit);
    //                 GradeListEdit.Editable := false;
    //                 GradeListEdit.Run();
    //             end;
    //         }
    //         action("Grade Input List")
    //         {
    //             Caption = 'Grade Input List';
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 GradeInputEdit: Page "Grade Input List";
    //             begin
    //                 Clear(GradeInputEdit);
    //                 GradeInputEdit.Editable := false;
    //                 GradeInputEdit.Run();
    //             end;
    //         }
    //         action("Recommendation List")
    //         {
    //             Caption = 'Recommendation List';
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 RecommendationListEdit: Page "Recommendation List";
    //             begin
    //                 Clear(RecommendationListEdit);
    //                 RecommendationListEdit.Editable := false;
    //                 RecommendationListEdit.Run();
    //             end;
    //         }
    //         action("Student List")
    //         {
    //             Caption = 'Student List';
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 StudentMaster: Record "Student Master-CS";
    //                 StudentListEdit: Page "Student Detail Card-CS";
    //             begin
    //                 StudentMaster.Reset();
    //                 StudentMaster.SetRange("No.", "Student No.");
    //                 If StudentMaster.FindFirst() then begin
    //                     Clear(StudentListEdit);
    //                     StudentListEdit.SetTableView(StudentMaster);
    //                     StudentListEdit.Editable := false;
    //                     StudentListEdit.Run();
    //                 end;

    //             end;
    //         }
    //     }
    // }

    // trigger OnAfterGetRecord()
    // begin
    //     NameIndent := 0;
    //     FormatLine();
    //     IF "Exam Code" <> '' THEN begin
    //         Hide1 := TRUE;
    //         Hide2 := false;
    //     End ELSE begin
    //         Hide1 := FALSE;
    //         Hide2 := true;
    //     end;
    // End;

    var
        Hide1: Boolean;
        Hide2: Boolean;
        NameIndent: Integer;


    // procedure FormatLine()
    // begin
    //     NameIndent := Indentation;
    // end;
}
