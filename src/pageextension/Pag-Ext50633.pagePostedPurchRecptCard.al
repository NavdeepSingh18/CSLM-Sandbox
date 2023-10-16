pageextension 50633 PostedPurchRecptCardExt extends "Posted Purchase Receipt"
{
    //CSPL-00307
    layout
    {
        addlast(General)
        {

            field("Requisition Type"; Rec."Requisition Type")
            {
                ToolTip = 'Specifies the value of the Requisition Type field.';
                ApplicationArea = All;
                Editable = false;
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