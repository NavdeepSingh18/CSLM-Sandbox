page 50177 "Event Menu-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Availability Map EventMenu-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                }
                field("Menu Name"; Rec."Menu Name")
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

