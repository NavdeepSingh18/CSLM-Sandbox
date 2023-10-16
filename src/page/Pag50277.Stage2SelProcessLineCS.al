page 50277 "Stage2 Sel Process Line-CS"
{
    // version V.001-CS
    AutoSplitKey = true;
    Caption = 'Stage2 Sel Process Line-CS';
    PageType = ListPart;
    SourceTable = "Sel Process Stage L2-CS";

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

