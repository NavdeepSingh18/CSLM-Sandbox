page 50631 "Goal List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Goal;
    Caption = 'Goal List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Goal Code"; Rec."Goal Code")
                {
                    ApplicationArea = All;
                    Caption = 'Goal Code';
                }
                field("Goal Description"; Rec."Goal Description")
                {
                    ApplicationArea = All;
                    Caption = 'Goal Description';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Subject Wise Goal List")
            {
                Caption = '&Subject Wise Goal List';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                RunObject = Page "Subject Goal List";
                RunPageLink = "Goal Code" = FIELD("Goal Code");

            }
        }
    }

}