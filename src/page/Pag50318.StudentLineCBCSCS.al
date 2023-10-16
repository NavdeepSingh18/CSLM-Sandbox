page 50318 "Student Line(CBCS)-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Student Line(CBCS)-CS';
    PageType = CardPart;
    SourceTable = "CBCS Student Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Specilization; Rec.Specilization)
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("CBCS Status"; Rec."CBCS Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

