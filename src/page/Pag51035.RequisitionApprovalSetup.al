page 51035 "Requisition Approval Setups"
{

    ApplicationArea = All;
    Caption = 'Requisition Minimum Stock Setup';
    PageType = List;
    SourceTable = "Requisition Approval Setups";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Code"; Rec."Global Dimension Code 2")//Use as item no.
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Stock Qty"; Rec."Minimum Stock Qty")
                {
                    ToolTip = 'Specifies the value of the Minimum Stock Qty field.';
                    ApplicationArea = All;
                }

            }
        }
    }

}
