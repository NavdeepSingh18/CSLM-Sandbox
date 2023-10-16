page 50330 "Mix Class -CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Mix Class';
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Job Queue Mail IDs-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field("Primary Key"; Rec."Primary Key")
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

