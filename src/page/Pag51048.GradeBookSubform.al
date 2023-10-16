page 51048 GradeBookSubform
{
    SourceTable = "Grade Book";
    UsageCategory = Administration;
    ApplicationArea = All;
    PageType = ListPart;
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
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                }

                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                }
                field("Exam Description"; Rec."Exam Description")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                }
                // field("Type of Input"; Rec."Type of Input")
                // {
                //     ApplicationArea = All;
                //     Style = Strong;

                // }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                    // HideValue = Hide2;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;

                    // HideValue = Hide2;
                }
                field("Earned Points"; Rec."Earned Points")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                    // HideValue = Hide1;
                }
                field("Available Points"; Rec."Available Points")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                    // HideValue = Hide1;
                }
                Field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = GradeFieldColorB;
                }

                // field("% Range"; Rec."% Range")
                // {
                //     ApplicationArea = All;
                //     Style = Unfavorable;
                //     StyleExpr = GradeFieldColorB;
                //     // HideValue = Hide1;
                // }

                // field(Recommendation; Rec.Recommendation)
                // {
                //     ApplicationArea = All;
                //     Style = Unfavorable;
                //     StyleExpr = GradeFieldColorB;
                //     // HideValue = Hide1;
                // }
                // field("Quality Point"; Rec."Quality Point")
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                //     // HideValue = Hide1;
                // }
                // field(Credit; Rec.Credit)
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                //     // HideValue = Hide1;
                // }
                // field("Credit Earned"; Rec."Credit Earned")
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                //     // HideValue = Hide1;
                // }
            }
        }


    }



    actions
    {
        area(Processing)
        {
            group("L&ine")
            {
                action("Student Subject")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        StudSub: Record "Main Student Subject-CS";
                        StudSubPg: Page "Subject Student-CS";
                        SubMaster: Record "Subject Master-CS";
                        SubCode: Code[20];
                    begin
                        SubMaster.Reset();
                        SubMaster.SetRange(Code, Rec."Exam Code");
                        SubMaster.FindFirst();
                        SubCode := SubMaster."Subject Group";

                        If Rec.Level = 3 then begin
                            SubMaster.Reset();
                            SubMaster.SetRange(Code, SubCode);
                            SubMaster.FindFirst();
                            SubCode := SubMaster."Subject Group";
                        end;


                        StudSub.Reset();
                        StudSub.SetRange("Student No.", Rec."Student No.");
                        StudSub.SetRange(Semester, Rec.Semester);
                        StudSub.SetRange("Academic Year", Rec."Academic Year");
                        StudSub.SetRange(Term, Rec.Term);
                        StudSub.SetRange("Subject Code", SubCode);
                        // StudSub.SetRange("Grade Book No.","Grade Book No.");
                        StudSub.FindLast();
                        clear(StudSubPg);
                        StudSubPg.SetTableView(StudSub);
                        StudSubPg.Editable := false;
                        StudSubPg.Run();
                    end;
                }
                action("Student Exam")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        StudExam: Record "Student Subject Exam";
                        StudExamPg: Page "Student Subject Exam List";
                        SubMaster: Record "Subject Master-CS";
                        SubCode: Code[20];
                    begin
                        StudExam.Reset();
                        StudExam.SetRange("Student No.", Rec."Student No.");
                        StudExam.SetRange("Grade Book No.", Rec."Grade Book No.");
                        StudExam.FindSet();

                        clear(StudExamPg);
                        StudExamPg.SetTableView(StudExam);
                        StudExamPg.Editable := false;
                        StudExamPg.Run();
                    end;
                }
                action("Student Grade Book")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        GradeBook: Record "Grade Book";
                        GradeBookListPg: Page "Grade Book List";
                    begin
                        GradeBook.Reset();
                        GradeBook.SetRange("Student No.", Rec."Student No.");
                        GradeBook.SetRange(Status, GradeBook.Status::Approved);
                        GradeBook.FindSet();

                        clear(GradeBookListPg);
                        GradeBookListPg.SetTableView(GradeBook);
                        GradeBookListPg.Editable := false;
                        GradeBookListPg.Run();
                    end;
                }
            }
        }
    }
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

    trigger OnAfterGetRecord()
    begin
        // NameIndent := 0;
        // FormatLine();
        // IF "Exam Code" <> '' THEN begin
        //     Hide1 := TRUE;
        //     Hide2 := false;
        // End ELSE begin
        //     Hide1 := FALSE;
        //     Hide2 := true;
        // end;
        if Rec.Grade = 'F' then
            // GradeFieldColor := '5'
            GradeFieldColorB := true
        else
            // GradeFieldColor := '0';
            GradeFieldColorB := false;
    End;

    var
        Hide1: Boolean;
        Hide2: Boolean;
        NameIndent: Integer;
        // GradeFieldColor: Text;
        GradeFieldColorB: Boolean;


    // procedure FormatLine()
    // begin
    //     NameIndent := Indentation;
    // end;
}
