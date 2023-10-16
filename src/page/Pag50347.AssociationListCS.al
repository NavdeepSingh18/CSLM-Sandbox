page 50347 "Association List-CS"
{
    // version V.001-CS

    Caption = 'Association List';
    Editable = false;
    PageType = Card;
    SourceTable = "Community-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

