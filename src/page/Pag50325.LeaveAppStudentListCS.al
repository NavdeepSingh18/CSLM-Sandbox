page 50325 "Leave App. Student List-CS"
{
    // version V.001-CS

    Caption = 'Leave App. Student List';
    CardPageID = "Leave App. Student-CS";
    Editable = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Application-CS";

    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
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
                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = all;
                }
                field("Leave Taken"; Rec."Leave Taken")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}