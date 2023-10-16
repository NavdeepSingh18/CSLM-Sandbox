pageextension 50624 "Purchase Order SubformExt" extends "Purchase Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = all;
                Editable = false;
                trigger OnDrillDown()
                var
                    REquisitionHdr: Record "Requisition Header";
                begin
                    REquisitionHdr.Reset();
                    REquisitionHdr.SetRange("No.", Rec."Requisition No.");
                    Page.Run(51036, REquisitionHdr);
                end;

            }
            field("Requisition Line No."; Rec."Requisition Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            Field("Budget Code"; Rec."Budget Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Requisition Type"; Rec."Requisition Type")
            {
                //CSPL-00307
                ToolTip = 'Specifies the value of the Requisition Type field.';
                ApplicationArea = All;
                Caption = 'Order type';
            }
            field(Remark; Rec.Remark)
            {
                ToolTip = 'Specifies the value of the Remark field.';
                ApplicationArea = All;
            }
            field(ModifiedBy; Rec.ModifiedBy)
            {
                ToolTip = 'Specifies the value of the ModifiedBy field.';
                ApplicationArea = All;
                Editable = False;
            }
            field(ModifiedOn; Rec.ModifiedOn)
            {
                ToolTip = 'Specifies the value of the ModifiedOn field.';
                ApplicationArea = All;
                Editable = False;
            }

        }

        modify(Quantity)
        {
            Editable = REc."Quantity Bool";
        }

    }

    trigger OnDeleteRecord(): Boolean
    var
        ReqLine: record "Requisition Line_";
    begin
        //CSPL-00307---Moved This Code to table Trigger---13-10-21
        // ReqLine.reset();
        // ReqLine.SetRange("Document No.", rec."Requisition No.");
        // ReqLine.SetRange("Line No.", rec."Requisition Line No.");
        // ReqLine.SetRange("Document Type", ReqLine."Document Type"::Requisition);
        // if ReqLine.FindFirst() then begin
        //     ReqLine."PO No." := '';
        //     ReqLine.Modify();
        // end;
        //CSPL-00307---Moved This Code to table Trigger---13-10-21
    end;
}
