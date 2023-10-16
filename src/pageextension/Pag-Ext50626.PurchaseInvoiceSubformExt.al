pageextension 50626 "Purchase invoice SubformExt" extends "Purch. Invoice Subform"
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
                Caption = 'Invoice type';//CSPL-00307-26-10-21
            }
            field("Budget Code"; Rec."Budget Code")
            {
                ToolTip = 'Specifies the value of the Budget Code field.';
                ApplicationArea = All;
            }
            field(Remark; Rec.Remark)
            {
                ToolTip = 'Specifies the value of the Remark field.';
                ApplicationArea = All;
            }

        }

        modify(Quantity)
        {
            Editable = Rec."Quantity Bool";
        }

    }
}
