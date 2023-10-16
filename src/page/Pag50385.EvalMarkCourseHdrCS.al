page 50385 "Eval. Mark Course Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Get Applicants Evaluation - OnAction()      Code added for Get Applicants Evaluation.
    // 02    CSPL-00059   07/02/2019       Chenge Mark - OnAction()                    Code added for chenge marks.

    Caption = 'Eval. Mark Course Hdr';
    PageType = Card;
    SourceTable = "Evaluation Course Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;
                }
                field("Stage1 Selection List No."; Rec."Stage1 Selection List No.")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'F&unction';
                action("Get Applicants Evaluation")
                {
                    Caption = 'Get &Applicants Evaluation';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for Get Applicants Evaluation::CSPL-00059::07022019: Start
                        EvaluationActionCS.ValidGetApplicantsforEvaluation(Rec."Course Code", Rec."Evaluation Method Code", Rec."Academic Year",
                          Rec."Stage1 Selection List No.");
                        //Code added for Get Applicants Evaluation::CSPL-00059::07022019: End
                    end;
                }
                action("Chenge Mark")
                {
                    Caption = '&Chenge Mark';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for chenge mark::CSPL-00059::07022019: Start
                        EvaluationActionCS.ValidUpdateEvaluationMark(Rec."Course Code", Rec."Evaluation Method Code", Rec."Academic Year", Rec."Stage1 Selection List No.");
                        //Code added for chenge mark::CSPL-00059::07022019: End
                    end;
                }
            }
        }
    }

    var
        EvaluationActionCS: Codeunit "Evaluation Action-CS";
}