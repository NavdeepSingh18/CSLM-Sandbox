page 50102 "External Student Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'External Examination SubPage';
    InsertAllowed = true;
    PageType = ListPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "External Exam Line-CS";

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
                    // Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Group"; Rec."Student Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Attendance Type"; Rec."Attendance Type")
                {
                    ApplicationArea = all;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = all;
                }

                field("External Mark"; Rec."External Mark")
                {
                    ApplicationArea = All;
                    Caption = 'Obtained External Marks';
                }

                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = all;
                    Caption = 'Maximum External Marks';
                }

                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Obtained Weightage"; Rec."Obtained Weightage")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("CBSE Version"; Rec."CBSE Version")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Published Document No."; Rec."Published Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                        ExamTimeLine: Record "External Exam Line-CS";
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
                        ExamTimeLine: Record "External Exam Line-CS";
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
}

