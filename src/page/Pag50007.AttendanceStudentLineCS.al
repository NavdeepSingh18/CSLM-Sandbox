page 50007 "Attendance Student Line-CS"
{
    // version V.001-CS

    Caption = 'Attendance Student Line';
    PageType = ListPart;
    SourceTable = "Class Attendance Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Attendance Type"; Rec."Attendance Type")
                {
                    ApplicationArea = All;
                }
                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Attendance Generated"; Rec."Attendance Generated")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action("Student Wise Goal")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                // RunObject = Page "Student Wise Goal List";
                // RunPageLink = "Student No." = Field("Student No."), "Time Table Doc No." = Field("Time Table Doc No.");
            }
        }
    }
}