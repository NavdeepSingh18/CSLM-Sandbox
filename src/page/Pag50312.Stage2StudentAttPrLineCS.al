page 50312 "Stage2 Student Att Pr Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Stage2 Student Att Pr Line-CS';
    Editable = false;
    PageType = CardPart;
    SourceTable = "Attend Percentage Line-CS";

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
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Eligible For Exam"; Rec."Eligible For Exam")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

