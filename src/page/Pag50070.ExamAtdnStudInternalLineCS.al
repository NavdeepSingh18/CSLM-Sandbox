page 50070 "Exam AtdnStud Internal Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Internal Attendance Line-CS";

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
                field("Attendance %"; Rec."Attendance %")
                {
                    ApplicationArea = All;
                }
                field("Applicable for Re-Sessional"; Rec."Applicable for Re-Sessional")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}