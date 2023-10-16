page 50463 "Subject Category Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Subject Category Master";

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;

                }
                field("Category Description"; Rec."Category Description")
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



    var

}