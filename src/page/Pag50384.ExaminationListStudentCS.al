page 50384 "Examination List Student-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       <Action1000000009> - OnAction()      Code added for report run
    // 02    CSPL-00059   07/02/2019       <Action1000000008> - OnAction()      Code added for report run

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Student Exam History-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption='Examination List Student';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Examination Roll No."; Rec."Examination Roll No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Apply)
            {
                Caption = 'Apply';
                action("Admit Card")
                {
                    Caption = 'Admit Card';
                    Image = Find;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // StudentExternalHeader: Record "External Exam Header-CS";
                    // StudentExternalLine: Record "External Exam Line-CS";
                    begin
                        //Code added for report run::CSPL-00059::07022019: Start
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(StudentMasterCS."No.", Rec."Student No.");
                        IF StudentMasterCS.FindFirst() THEN
                            REPORT.RUNMODAL(REPORT::"Student Subject UpdateNew CS", TRUE, TRUE, StudentMasterCS);
                        //Code added for report run::CSPL-00059::07022019: End
                    end;
                }
                action("Tabulation Sheet")
                {
                    Caption = 'Tabulation Sheet';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for report run::CSPL-00059::07022019: Start
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", Rec."Student No.");
                        IF StudentMasterCS.FindFirst() THEN
                            REPORT.RUNMODAL(REPORT::"Fee Generation - College1 CS", TRUE, TRUE, StudentMasterCS);
                        //Code added for report run::CSPL-00059::07022019: End
                    end;
                }
            }
        }
    }

    var
        StudentMasterCS: Record "Student Master-CS";
}