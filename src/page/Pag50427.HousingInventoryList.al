page 50427 "Housing Inventory List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Housing Inventory Master";

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;

                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;

                }

            }
        }
    }



    var

}