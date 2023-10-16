page 51072 "Internal Exam Line Ledgers"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Internal Exam Line Ledger';
    DelayedInsert = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Internal Exam Line Ledger";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Select To Perform"; Rec."Select To Perform")
                {
                    ApplicationArea = all;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    // Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Editable = false;
                }
                field("Attendance Type"; Rec."Attendance Type")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = Emphasize;
                }


                field("Obtained Internal Marks"; Rec."Obtained Internal Marks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;

                }
                field("Maximum Internal  Marks"; Rec."Maximum Internal  Marks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Editable = BoolEditable;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Editable = BoolEditable;
                }
                field("Obtained Weightage"; Rec."Obtained Weightage")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Editable = BoolEditable;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    Editable = BoolEditable;
                }

            }
        }
    }



    actions
    {
        area(processing)
        {
            group("L&ine")
            {
                action("Select All")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    Caption = 'Select All';
                    Image = Select;

                    trigger OnAction()
                    var
                        ExamTimeLine: Record "Internal Exam Line-CS";
                    begin
                        if Rec."Document No." <> '' then begin
                            ExamTimeLine.Reset();
                            ExamTimeLine.SetRange("Document No.", Rec."Document No.");
                            ExamTimeLine.FindSet();
                            ExamTimeLine.ModifyAll(ExamTimeLine."Select To Perform", false);

                            ExamTimeLine.Reset();
                            ExamTimeLine.SetRange("Document No.", Rec."Document No.");
                            ExamTimeLine.SetRange(Status, ExamTimeLine.Status::Released);
                            ExamTimeLine.FindSet();
                            ExamTimeLine.ModifyAll(ExamTimeLine."Select To Perform", true);
                        end;
                    end;
                }
                action("Deselect All")
                {
                    ApplicationArea = all;
                    Caption = 'Deselect All';
                    Image = RemoveLine;

                    trigger OnAction()
                    var
                        ExamTimeLine: Record "Internal Exam Line-CS";
                    begin
                        if Rec."Document No." <> '' then begin
                            ExamTimeLine.Reset();
                            ExamTimeLine.SetRange("Document No.", Rec."Document No.");
                            ExamTimeLine.FindSet();
                            ExamTimeLine.ModifyAll(ExamTimeLine."Select To Perform", false);
                        end;
                    end;
                }
            }
        }

    }
    var
        StudentInternalHeader: Record "Internal Exam Header-CS";
        Emphasize: Boolean;
        BoolEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        StudentInternalHeader.RESET();
        StudentInternalHeader.SETRANGE("No.", Rec."Document No.");
        IF StudentInternalHeader.FINDFIRST() THEN begin
            Emphasize := Rec."Subject Code" = StudentInternalHeader."Subject Code";
            BoolEditable := Rec."Subject Code" <> StudentInternalHeader."Subject Code";
        end;
    end;
}