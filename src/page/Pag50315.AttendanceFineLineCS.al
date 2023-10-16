page 50315 "Attendance (Fine) Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Attendance (Fine) Line-CS';
    Editable = false;
    PageType = CardPart;
    SourceTable = "Fine Attendance Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Course Code"; Rec."Course Code")
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
                field("Fine Amount"; Rec."Fine Amount")
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

