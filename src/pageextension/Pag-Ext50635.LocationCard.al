pageextension 50635 LocationCardExt extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ToolTip = 'Specifies the value of the Global Dimension 1 Code.';
                ApplicationArea = All;
            }
            field("Requisition Type"; Rec."Requisition Type")
            {
                ToolTip = 'Specifies the value of the Requisition Type field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {

    }

    var
    // myInt: Integer;
}