pageextension 50628 PurchaseQuoteExt extends "Purchase Quote"
{
    layout
    {
        modify("Buy-from Address")
        {
            Editable = false;
        }
        modify("Buy-from Address 2")
        {
            Editable = false;
        }
        modify("Buy-from Post Code")
        {
            Editable = false;
        }
        modify("Buy-from City")
        {
            Editable = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Editable = false;
        }
        modify("Buy-from Contact No.")
        {
            Editable = false;
        }
        modify("Buy-from Contact")
        {
            Editable = false;
        }
        modify("Assigned User ID")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                RecDimValue: Record "Dimension Value";
                FilterCode: Text;
            begin
                //CSPL-00307 Starts
                FilterCode := '@' + CopyStr(Rec."Shortcut Dimension 1 Code", 1, 2) + '*';
                RecDimValue.Reset();
                RecDimValue.SetRange("Global Dimension No.", 2);
                RecDimValue.SetRange("Dimension Value Type", RecDimValue."Dimension Value Type"::Standard);
                RecDimValue.SetFilter(Code, FilterCode);
                IF Page.RunModal(537, RecDimValue) = ACTION::LookupOK Then;
                Rec.Validate("Shortcut Dimension 2 Code", RecDimValue.Code);
                //CSPL-00307 Ends
            end;
        }

        addafter("Order Date")
        {
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
        moveafter("Requisition Type"; "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code")

    }

    actions
    {
        addafter(Print)
        {
            action("Purchase Quotation")
            {
                ApplicationArea = All;
                Image = Print;
                PromotedCategory = Report;
                Promoted = true;
                trigger OnAction()
                Var
                    PurchaseHdr: Record "Purchase Header";
                    PurchaseORderRequest: Report "Purchase Order Request";
                Begin
                    Clear(PurchaseORderRequest);
                    PurchaseHdr.Reset();
                    PurchaseHdr.SetRange("No.", Rec."No.");
                    PurchaseORderRequest.SetTableView(PurchaseHdr);
                    PurchaseORderRequest.Run();
                End;
            }
        }
        addbefore(CopyDocument)
        {

            action("Insert Requisition")
            {
                ApplicationArea = All;
                Image = Insert;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                // trigger OnAction()
                // var
                //     ReqLine_LRec: record "Requisition Line_";
                //     ReqLine_LRec2: Record "Requisition Line_";
                //     purchline: Record "Purchase Line";
                //     ApprovedRequisition: Page "Approved Requisition";
                // begin
                //     if Rec."Document Type" = Rec."Document Type"::Quote then begin
                //         Rec.testfield("No.");
                //         Rec.testfield("Location Code");
                //         ReqLine_LRec.Reset();
                //         ReqLine_LRec.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                //         ReqLine_LRec.SetRange("Location Code", Rec."Location Code");
                //         ApprovedRequisition.SetSelectionLine();
                //         ApprovedRequisition.SetTableView(ReqLine_LRec);
                //         ApprovedRequisition.LookupMode(true);
                //         if ApprovedRequisition.RunModal() = Action::LookupOK then begin
                //             ApprovedRequisition.SetSelectionFilter(ReqLine_LRec);
                //             if ReqLine_LRec.FindSet() then begin
                //                 repeat
                //                     Rec."Requisition Type" := ReqLine_LRec."Requisition Type";//CSPL-00307 -- 18-10-21
                //                     purchline.Init();
                //                     purchline."Line No." := GetEntryNo();
                //                     // purchline."Requisition No." := ReqLine_LRec."Document No.";
                //                     purchline."Document Type" := purchline."Document Type"::Quote;
                //                     purchline."Document No." := Rec."No.";
                //                     purchline.Type := purchline.type::Item;
                //                     purchline.validate("No.", ReqLine_LRec."Item Code");
                //                     //purchline.Description := ReqLine_LRec.Description;
                //                     purchline."Requisition Line No." := ReqLine_LRec."Line No.";
                //                     purchline."Location Code" := ReqLine_LRec."Location Code";
                //                     purchline.validate(Quantity, ReqLine_LRec."Purchase Quantity");
                //                     purchline.Validate("Requisition No.", ReqLine_LRec."Document No.");
                //                     purchline."Budget Code" := ReqLine_LRec."Budget Code";
                //                     purchline."Requisition Type" := ReqLine_LRec."Requisition Type";//CSPL-00307 18-10-21
                //                     purchline.Validate("Budget Code", ReqLine_LRec."Purchase Budget");//CSPL-00307 17-11-21
                //                     purchline.Remark := ReqLine_LRec.Remarks;
                //                     //purchline."Unit of Measure Code" := ReqLine_LRec."Unit of Measure Code";
                //                     purchline.insert();
                //                 // ReqLine_LRec."PO No." := purchline."Document No.";
                //                 // ReqLine_LRec.Modify();
                //                 until ReqLine_LRec.Next() = 0;
                //             end;
                //         end;
                //     end;
                // end;
            }
        }
    }

    var
        myInt: Integer;

    procedure GetEntryNo(): Integer
    Var
        purchLinelrec: Record "Purchase Line";
        Purchaseheader: Record "Purchase Header";
        EntryNo: Integer;
    Begin
        purchLinelrec.reset();
        purchLinelrec.setrange("Document Type", purchLinelrec."Document Type"::Quote);
        purchLinelrec.setrange("Document No.", Rec."No.");
        If purchLinelrec.FindLast() then
            EntryNo := purchLinelrec."Line No." + 10000
        else
            EntryNo := 10000;
        exit(EntryNo);
    end;

}