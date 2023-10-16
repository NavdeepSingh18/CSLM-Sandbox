page 50434 "Housing Inventory Allocation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Housing Inventory Allocation";

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
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;

                }
                Field("Inventory Category"; Rec."Inventory Category")
                {
                    ApplicationArea = All;
                }
                field(Qunatity; Rec.Qunatity)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }



    var

}