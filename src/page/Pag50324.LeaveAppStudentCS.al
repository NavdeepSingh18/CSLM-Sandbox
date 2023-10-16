page 50324 "Leave App. Student-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      <Action1102155034> - OnAction()            Code added for Leave Sanction.
    // 02    CSPL-00059   07/02/2019      <Action1102155035> - OnAction()            Code added for Leave Cancel.

    Caption = 'Leave App. Student';
    PageType = Card;
    SourceTable = "Leave Application-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = all;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = all;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = all;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field("No. Of Days"; Rec."No. Of Days")
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = all;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = all;
                }
                field("Leave Taken"; Rec."Leave Taken")
                {
                    ApplicationArea = all;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = all;
                }
                field("Applicant E-Mail ID"; Rec."Applicant E-Mail ID")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Leave")
            {
                Caption = '&Leave';

                action(Sanction)
                {
                    Caption = 'Sanction';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Leave Sanction::CSPL-00059::07022019: Start
                        AttendanceActionCS.ApplicationApprovedOrRejcet(TRUE, Rec."No.");
                        CurrPage.Update();
                        //Code added for Leave Sanction::CSPL-00059::07022019: End
                    end;
                }
                action(Cancel)
                {
                    Caption = 'Cancel';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Leave Cancel::CSPL-00059::07022019: Start
                        AttendanceActionCS.ApplicationApprovedOrRejcet(FALSE, Rec."No.");
                        CurrPage.Update();
                        //Code added for Leave Cancel::CSPL-00059::07022019: End
                    end;
                }
            }
        }
    }

    var
        AttendanceActionCS: Codeunit "Attendance Action-CS";
}