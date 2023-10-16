page 50561 "Requisition Purchase Card"
{
    PageType = Document;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Requisition Header";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                    Editable = false;
                    //Editable = FieldEdiable_bool;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    // Editable = FieldEdiable_bool;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = FieldEdiable_bool;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = FieldEdiable_bool;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = FieldEdiable_bool;

                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = all;
                    Editable = false;

                }

                field("1st Level Approval"; Rec."1st Level Approval")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = Status_bool;

                }
                field("1st Level Approved Date"; Rec."1st Level Approved Date")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("1st Level Approver ID"; Rec."1st Level Approver ID")
                {
                    ApplicationArea = all;
                    Editable = false;

                }

                field("2nd Level Approval"; Rec."2nd Level Approval")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = Status_bool;
                }

                field("2nd Level Approver Date"; Rec."2nd Level Approved Date")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("2nd Level Approver ID"; Rec."2nd Level Approver ID")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("3rd Level Approval"; Rec."3rd Level Approval")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("3rd Level Approver Date"; Rec."3rd Level Approved Date")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("3rd Level Approver ID"; Rec."3rd Level Approver ID")
                {
                    ApplicationArea = all;
                    Editable = false;

                }


            }
            part("Requisition Purchase Subpage"; "Requisition Purchase Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Purchase Order")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = NewOrder;
                //  Visible = Boolean_gBool2;
                trigger OnAction()
                var

                    purchaseheader: Record "Purchase Header";
                    purchaseline: Record "Purchase Line";
                    RequestionLine: Record "Requisition Line_";
                    //RequestionLine1: Record "Requisition Line_";
                    purchasesetup: Record "Purchases & Payables Setup";
                    noseriesmgt: Codeunit NoSeriesManagement;
                    vendorno: Code[20];
                    Text0001Lbl: Label 'Do you want to process Requistion for order.';
                    i: Integer;
                //TextVariable: Text[2048];
                begin
                    Rec.TestField("Approval Status", Rec."Approval Status"::Approved);
                    // RequestionLine1.Reset();
                    // RequestionLine1.SetRange("Document Type", "Document Type");
                    // RequestionLine1.SetRange("Document No.", "No.");
                    // IF RequestionLine1.FindSet() then begin
                    //     repeat
                    //         RequestionLine1.CalcFields("Stock In Hand");
                    //         If RequestionLine1."Stock In Hand" < RequestionLine1."Requested Quantity" then begin
                    //             TextVariable += RequestionLine1."Item Code" + '|';
                    //         end;
                    //     until RequestionLine1.next() = 0;
                    //     Error('"Stock In Hand" must be equal or greater to "Requested Quantity" for Items Code: %1', TextVariable);
                    // END;
                    i := 0;
                    if Confirm(Text0001Lbl, false) then begin
                        vendorno := '';
                        RequestionLine.reset();
                        RequestionLine.SetCurrentKey("Document Type", "Document No.", "Supplier's Code");
                        RequestionLine.Setrange("Document Type", Rec."Document Type");
                        RequestionLine.SetRange("Document No.", Rec."No.");
                        if RequestionLine.FindFirst() then begin
                            repeat
                                purchasesetup.get();
                                //if (RequestionLine."Supplier's Code" = '') or (RequestionLine."Purchase Order No." <> '') or (RequestionLine."Purchase Quantity" = 0) then
                                // exit;
                                if (RequestionLine."Remaining Purchase Quantity" = 0) or (RequestionLine."Purchase Quantity" = 0) then
                                    exit;
                                if vendorno <> RequestionLine."Supplier's Code" then begin
                                    i += 1;
                                    purchaseheader.Init();
                                    purchaseheader."Document Type" := purchaseheader."Document Type"::Order;
                                    purchaseheader."No." := noseriesmgt.GetNextNo(purchasesetup."Order Nos.", WorkDate(), true);
                                    purchaseheader.Insert(true);

                                    purchaseheader.Validate("Buy-from Vendor No.", RequestionLine."Supplier's Code");
                                    purchaseheader.Validate("Location Code", Rec."Location Code");
                                    purchaseheader.Validate("Shortcut Dimension 1 Code", Rec."Global Dimension 1 Code");
                                    purchaseheader.Validate("Shortcut Dimension 2 Code", Rec."Global Dimension 2 Code");
                                    purchaseheader."Requisition No." := Rec."No.";
                                    purchaseheader.Modify(true);
                                end;

                                purchaseline.Init();
                                purchaseline."Document Type" := purchaseline."Document Type"::Order;
                                purchaseline."Document No." := purchaseheader."No.";
                                purchaseline."Line No." := RequestionLine."Line No.";
                                purchaseline.Type := purchaseline.Type::Item;
                                purchaseline.Validate("No.", RequestionLine."Item Code");
                                //purchaseline.Validate(Quantity, RequestionLine."Requested Quantity");
                                purchaseline.Validate(Quantity, RequestionLine."Purchase Quantity");
                                purchaseline."Requisition No." := RequestionLine."Document No.";
                                purchaseline."Requisition Line No." := RequestionLine."Line No.";
                                purchaseline.insert(true);

                                vendorno := RequestionLine."Supplier's Code";
                                RequestionLine."Purchase Order No." := purchaseline."Document No.";
                                RequestionLine."Purchase Line No." := purchaseline."Line No.";
                                RequestionLine."Purchased Order Quantity" += RequestionLine."Purchase Quantity";
                                RequestionLine."Remaining Purchase Quantity" := RequestionLine."Remaining Purchase Quantity" - RequestionLine."Purchase Quantity";
                                RequestionLine.Modify();

                            until RequestionLine.next() = 0;
                        end;
                        RequestionLine.reset();
                        RequestionLine.SetCurrentKey("Document Type", "Document No.", "Supplier's Code");
                        RequestionLine.Setrange("Document Type", Rec."Document Type");
                        RequestionLine.SetRange("Document No.", Rec."No.");
                        if RequestionLine.FindFirst() then begin
                            repeat
                                RequestionLine."Purchase Quantity" := 0;
                                RequestionLine."Supplier's Code" := '';
                                RequestionLine."Supplier's Name" := '';
                                RequestionLine.Modify();
                            until RequestionLine.next() = 0;
                        end;
                        Message(StrSubstNo('No. of Orders Created %1.', i));
                        //CurrPage.update();
                    end;
                end;

            }
            action("Send To Store")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = NewOrder;
                trigger OnAction()
                Var
                    RequisionLine: Record "Requisition Line_";
                    TextVariable: Text[2048];
                    Char13: Char;
                    Char10: Char;
                begin
                    Rec.TestField("Approval Status", Rec."Approval Status"::Approved);
                    Char13 := 13;
                    Char10 := 10;
                    RequisionLine.Reset();
                    RequisionLine.SetRange("Document Type", Rec."Document Type");
                    RequisionLine.SetRange("Document No.", Rec."No.");
                    IF RequisionLine.FindSet() then begin
                        repeat
                            RequisionLine.CalcFields("Stock In Hand");
                            If RequisionLine."Stock In Hand" < RequisionLine."Requested Quantity" then begin
                                TextVariable := TextVariable + (RequisionLine."Item Code" + '-' + RequisionLine.Description + '-' + 'Requested Quantity:' + FORMAT(RequisionLine."Requested Quantity") + '-' + 'Stock:' + FORMAT(RequisionLine."Stock In Hand")
                                + FORMAT(Char13) + Format(Char10));
                            end;
                        until RequisionLine.next() = 0;
                        IF TextVariable <> '' THEN
                            Error('Stock for the following items is not sufficient as per the Requested Quantity: %1', FORMAT(Char13) + Format(Char10) + TextVariable);
                    END;

                    if Confirm('Do you want to send requisition to Store?', false) then begin
                        Rec."Responsible Department" := Rec."Responsible Department"::Store;
                        Rec.Posted := False;
                        Rec.Modify();
                        MESSAGE('Requisition Send to Store');
                    end;
                END;

            }
            action("Purchase Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageMode = View;
                trigger OnAction()
                Var
                    PurchHeader: Record "Purchase Header";
                    PurchPage: Page "Purchase Order List";
                begin
                    PurchHeader.Reset();
                    PurchHeader.setrange("Requisition No.", Rec."No.");
                    PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
                    PurchPage.SETTABLEVIEW(PurchHeader);
                    PurchPage.RUN();
                end;
            }



        }
        area(Reporting)
        {
            action("Requisition Report")
            {
                ApplicationArea = all;
                Image = Report;

                trigger OnAction()
                begin
                    RecReqHeader.RESET();
                    RecReqHeader.SETRANGE(RecReqHeader."Document Type", Rec."Document Type");
                    RecReqHeader.SETRANGE(RecReqHeader."No.", Rec."No.");
                    IF RecReqHeader.FIND('-') THEN
                        REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
                end;
            }
        }
    }
    var
        RecReqHeader: record "Requisition Header";
}