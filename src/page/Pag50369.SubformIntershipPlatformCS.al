page 50369 "Subform Intership Platform-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Student Intership Line-CS";

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
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}