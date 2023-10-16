page 50333 "Calendar Led. Entry-CS"
{
    // version V.001-CS

    Caption = 'Calendar Led. Entry';
    PageType = Card;
    SourceTable = "Time Table Ledger-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = ALl;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = ALl;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = ALl;
                }
                field("Day No"; Rec."Day No")
                {
                    ApplicationArea = ALl;
                }
                field("Hour No"; Rec."Hour No")
                {
                    ApplicationArea = ALl;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = ALl;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = ALl;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = ALl;
                }
                field("Time Table Date"; Rec."Time Table Date")
                {
                    ApplicationArea = ALl;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = ALl;
                }
                field("Actual Employee Code"; Rec."Actual Employee Code")
                {
                    ApplicationArea = ALl;
                }
                field("Actual Subject Code"; Rec."Actual Subject Code")
                {
                    ApplicationArea = ALl;
                }
                field("Time Table Status"; Rec."Time Table Status")
                {
                    ApplicationArea = ALl;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = ALl;
                }
                field("Attendance Code"; Rec."Attendance Code")
                {
                    ApplicationArea = ALl;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = ALl;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = ALl;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = ALl;
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = ALl;
                }
                field("Exam Description"; Rec."Exam Description")
                {
                    ApplicationArea = ALl;
                }
                field("Exam Status"; Rec."Exam Status")
                {
                    ApplicationArea = ALl;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = ALl;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = ALl;
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = ALl;
                }
                field("Internal Exam Code"; Rec."Internal Exam Code")
                {
                    ApplicationArea = ALl;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = ALl;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = ALl;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = ALl;
                }
                field("Final Years Course"; Rec."Final Years Course")
                {
                    ApplicationArea = ALl;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;

                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = ALl;
                }
            }
        }
    }

    actions
    {
    }
}

