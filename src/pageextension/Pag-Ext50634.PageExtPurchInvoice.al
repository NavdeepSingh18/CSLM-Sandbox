pageextension 50634 PurchInvoiceExt extends "Purchase Invoice"
{
    //CSPL-00307
    layout
    {
        addlast(General)
        {

            field("Requisition Type"; Rec."Requisition Type")
            {
                Caption = 'Invoice type';//CSPL-00307-26-10-21
                ToolTip = 'Specifies the value of the Requisition Type field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}