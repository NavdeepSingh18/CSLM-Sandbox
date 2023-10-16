page 50279 "Stage1 Sel Process Line-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Sel Process Stage1 Line';
    PageType = CardPart;
    SourceTable = "Sel Process Stage L1-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quota Code"; Rec."Quota Code")
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field(Selected; Rec.Selected)
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

