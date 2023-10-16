page 50311 "Stage1 Student Att Pr Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019   Generate Att. Eligibility - Action()   Code added to calculate atten. Percentage

    Caption = 'Stage1 Student Att Pr Hdr';
    PageType = Card;
    SourceTable = "Attend Percentage Head-CS";
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
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ToolTip = 'Subject Type';
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Section';
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ToolTip = 'Subject Code';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
            }
            part("Student Att Percen Line - COL"; 50312)
            {
                ToolTip = 'Student Att Percen Line';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Fu&nction';

                action("Generate Att. Eligibility")
                {
                    ToolTip = 'Generate Att. Eligibility';
                    Caption = '&Generate Eligibility';
                    ApplicationArea = All;
                    // trigger OnAction()
                    // var
                    //     AttendanceActionCS: Codeunit "Attendance Action-CS";
                    // begin
                    //     //Code added to calculate atten. Percentage::CSPL-00059::07022019: Start
                    //     AttendanceActionCS.CalculateAttendancePerc(Rec."No.");
                    //     //Code added to calculate atten. Percentage::CSPL-00059::07022019: End
                    // end;
                }
            }
        }
    }
}