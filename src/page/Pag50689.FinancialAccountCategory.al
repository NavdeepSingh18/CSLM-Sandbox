page 50689 "Financial Account Category"
{

    PageType = List;
    SourceTable = "Financial Account Category";
    Caption = 'Financial Account Category List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                }

                field("Fee Component Code"; Rec."Fee Component Code")
                {
                    ApplicationArea = All;
                }
                field("Fee Component Description"; Rec."Fee Component Description")
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
                field("Department Descritpion"; Rec."Department Descritpion")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
