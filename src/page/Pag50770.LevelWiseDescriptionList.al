page 50770 "Level Wise Description List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Level Wise Description";
    Caption = 'Level Wise Description List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Level Code"; Rec."Level Code")
                {
                    ApplicationArea = All;
                }

                field("Level Description"; Rec."Level Description")
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
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


}