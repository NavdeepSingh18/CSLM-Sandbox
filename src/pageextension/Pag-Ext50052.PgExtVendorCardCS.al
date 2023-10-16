pageextension 50052 "PgExtVendorCard" extends "Vendor Card"
{
    layout
    {
        addafter("Search Name")
        {
            field("Vendor Sub Type"; Rec."Vendor Sub Type")
            {
                ToolTip = 'Vendor Sub Type';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}