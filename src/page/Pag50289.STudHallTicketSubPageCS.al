page 50289 "STud Hall Ticket SubPage-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'STud Hall Ticket SubPage-CS';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Admit Card Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    Visible = false;
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
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Apply Type"; Rec."Apply Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Actual Per%"; Rec."Actual Per%")
                {
                    ApplicationArea = All;
                }
                field("Applicable Per %"; Rec."Applicable Per %")
                {
                    ApplicationArea = All;
                }
                field("Time Slot"; Rec."Time Slot")
                {
                    ApplicationArea = All;
                }
                field("<Detained>"; Rec.Detained)
                {
                    Caption = 'Detained';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

