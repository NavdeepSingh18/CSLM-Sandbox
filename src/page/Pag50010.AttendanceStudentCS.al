page 50010 "Attendance Student-CS"
{
    // version V.001-CS

    Caption = 'Attendance Student';
    CardPageID = "Attendance Student Hdr-CS";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Class Attendance Header-CS";
    SourceTableView = sorting("Time Table Doc. No.") order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Field("Time Table Doc. No."; Rec."Time Table Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field("Attendance By Name"; Rec."Attendance By Name")
                {
                    ApplicationArea = All;
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field("Time Slot"; Rec."Time Slot")
                {
                    ApplicationArea = All;
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                }
                field("Attendance Marked"; Rec."Attendance Marked")
                {
                    ApplicationArea = All;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = All;
                }
                field("Time Table No"; Rec."Time Table No")
                {
                    ApplicationArea = All;
                }
                Field("Time Table Date"; Rec."Time Table Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }
}

