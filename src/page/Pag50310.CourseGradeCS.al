page 50310 "Course Grade -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Update Grade - OnAction()                Code added for Grades.

    Caption = 'Course Grade';
    PageType = Card;
    SourceTable = "External Exam Line-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            // repeater(Group)
            Group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("External Mark"; Rec."External Mark")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Grade")
            {
                Caption = '&Update Grade';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Grades ::CSPL-00059::07022019: Start
                    AcademicsStageCS.CopyGradesCreate();
                    //Code added for Grades ::CSPL-00059::07022019: End;
                end;
            }
        }
    }

    var
        AcademicsStageCS: Codeunit "Academics Stage-CS";
}