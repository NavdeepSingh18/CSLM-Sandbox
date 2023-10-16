pageextension 50472 "Requisition Doc" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
                Caption = 'Requisition No.';
                ToolTip = 'Requisition No. required number series code';
            }

        }

    }
}