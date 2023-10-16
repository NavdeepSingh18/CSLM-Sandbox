page 50314 "Attendance (Fine) Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Pay Fine - OnAction()                Code added for fine.
    // 02    CSPL-00059   07/02/2019       Generated Subject - OnAction()       Code added for subject wise att. .

    Caption = 'Attendance (Fine) Hdr';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Fine Attendance Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Name';
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
                field("Fine Amount"; Rec."Fine Amount")
                {
                    ToolTip = 'Fine Amount';
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Receipt No.';
                    ApplicationArea = All;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ToolTip = 'Academic year';
                    ApplicationArea = All;
                }
            }
            part("Attendance Line Subform"; 50315)
            {
                ToolTip = 'Attendance Line Subform';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Attendance Fine")
            {
                Caption = '&Attendance Fine';
                action("Pay Fine")
                {
                    Caption = '&Pay Fine';
                    ApplicationArea = All;
                    ToolTip = 'Pay Fine';
                    // trigger OnAction()
                    // begin
                    //     //Code added for fine::CSPL-00059::07022019: Start
                    //     FineAttendanceActionCS.PayFineAmount(Rec."No.");
                    //     //Code added for fine::CSPL-00059::07022019: End
                    // end;
                }
                // action("Generated Subject")
                // {
                //     ToolTip = 'Generated Subject';
                //     ApplicationArea = All;
                //     trigger OnAction()
                //     begin
                //         //Code added for subject wise att::CSPL-00059::07022019: Start
                //         FineAttendanceActionCS.GenerateSubjectsDetail(Rec."Course Code", Rec.Semester, Rec.Section, Rec."Academic year");
                //         //Code added for subject wise::CSPL-00059::07022019: End
                //     end;
                // }
            }
        }
    }

    // var
    //     FineAttendanceActionCS: Codeunit "Fine Attendance Action-CS";
}

