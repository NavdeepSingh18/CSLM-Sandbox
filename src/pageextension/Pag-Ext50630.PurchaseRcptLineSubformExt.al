pageextension 50630 "Purchase RcptLine SubformExt" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Requisition Line No."; Rec."Requisition Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            Field("Final Quotation"; Rec."Final Quotation")
            {
                ApplicationArea = All;
            }
            field("Requisition Type"; Rec."Requisition Type")
            {
                //CSPL-00307
                Editable = false;
                ToolTip = 'Specifies the value of the Requisition Type field.';
                ApplicationArea = All;
            }
            field("Budget Code"; Rec."Budget Code")
            {
                ToolTip = 'Specifies the value of the Budget Code field.';
                ApplicationArea = All;
            }

        }

        modify(Quantity)
        {
            Editable = Rec."Quantity Bool";
        }

    }
}
