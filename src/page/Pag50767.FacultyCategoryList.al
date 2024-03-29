page 50767 "Faculty Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Faculty Category";
    Caption = 'Faculty Category List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Category Code';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    Caption = 'Category Description';
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