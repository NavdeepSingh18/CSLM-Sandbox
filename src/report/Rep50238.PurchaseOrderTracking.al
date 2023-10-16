report 50238 "Purchase Order Tracking"
{
    ApplicationArea = All;
    Caption = 'Purchase Order Tracking Summary Report';
    UsageCategory = Lists;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Posting Date";
            DataItemTableView = where("Document Type" = filter(Order));
            RequestFilterHeading = 'Purchase Order';

            dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
            {
                DataItemLink = "Order No." = field("No.");
                trigger OnAfterGetRecord()
                var
                begin
                    CreateBookRcpt("Purchase Header", "Purch. Rcpt. Header");

                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchRcptLines: Record "Purch. Rcpt. Line";
                PurchaseLines: Record "Purchase Line";
                PurchRcptHeader: Record "Purch. Rcpt. Header";
            begin
                PurchRcptHeader.reset();
                PurchRcptHeader.SetRange("Order No.", "Purchase Header"."No.");
                if Not PurchRcptHeader.FindFirst() then begin
                    PurchaseLines.Reset();
                    PurchaseLines.SetRange("Document No.", "Purchase Header"."No.");
                    PurchaseLines.CalcSums(Quantity, "Amount Including VAT");
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Purchase Header"."Order Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Purchase Header"."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Purchase Header"."Pay-to Vendor No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Purchase Header"."Pay-to Name", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Purchase Header".Status, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchaseLines."Location Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchaseLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(PurchaseLines."Amount Including VAT", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::text);
                    ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                end;
            end;
        }

    }



    trigger OnPreReport()

    begin
        ExcelBuffer.DeleteAll();
        MakeHeader();
        // ExcelBuffer.AddInfoColumn('Company Name', False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    trigger OnPostReport()

    begin
        ExcelBuffer.SetUseInfoSheet();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddInfoColumn('Purchase Order Tracking Summary Report', False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddInfoColumn('', False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddInfoColumn('Date and Time:', False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddInfoColumn(CurrentDateTime, False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddInfoColumn('Date Filter :', False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddInfoColumn("Purchase Header".GetFilter("Posting Date"), False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddInfoColumn('User Id : ', False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddInfoColumn(UserId, False, true, false, false, '', ExcelBuffer."Cell Type"::Text);
        CreateExcelBook();
    end;

    local procedure CreateExcelBook()
    begin
        ExcelBuffer.CreateNewBook('Data');
        ExcelBuffer.WriteSheet('Data', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
        //ERROR('');
    end;

    local procedure MakeHeader()
    begin

        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Status', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order Qty', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order Value', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MRN No', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MRN Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MRN Qty', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice No', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Qty', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice value', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateBookRcpt(PurchHeader: Record "Purchase Header"; PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        PurchRcptLines: Record "Purch. Rcpt. Line";
        PurchaseLines: Record "Purchase Line";
        ValueEntry: Record "Value Entry";
        ValueEntry1: Record "Value Entry";
        ItemLedgerEntries: Record "Item Ledger Entry";
        PurchaseInvoice: Record "Purch. Inv. Header";
        PurchInvoiceLines: Record "Purch. Inv. Line";
    begin
        PurchRcptLines.Reset();
        PurchRcptLines.SetRange("Document No.", PurchRcptHeader."No.");
        PurchRcptLines.CalcSums(Quantity);
        PurchaseLines.Reset();
        PurchaseLines.SetRange("Document No.", PurchHeader."No.");
        PurchaseLines.CalcSums(Quantity, "Amount Including VAT");
        ValueEntry.Reset();
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Purchase Receipt");
        ValueEntry.SetRange("Document No.", PurchRcptHeader."No.");
        If ValueEntry.FindSet() then begin
            repeat
                if ItemLedgerEntries.Get(ValueEntry."Item Ledger Entry No.") then begin
                    ValueEntry1.Reset();
                    ValueEntry1.SetRange("Document Type", ValueEntry1."Document Type"::"Purchase Invoice");
                    ValueEntry1.SetRange("Item Ledger Entry No.", ItemLedgerEntries."Entry No.");
                    ValueEntry1.SetFilter("Invoiced Quantity", '<>%1', 0);
                    if ValueEntry1.FindSet() then begin
                        repeat
                            PurchaseInvoice.Reset();
                            PurchaseInvoice.SetRange("No.", ValueEntry1."Document No.");
                            if PurchaseInvoice.FindSet() then begin
                                PurchInvoiceLines.Reset();
                                PurchInvoiceLines.SetRange("Document No.", PurchaseInvoice."No.");
                                PurchInvoiceLines.CalcSums(Quantity, "Amount Including VAT");
                                ExcelBuffer.NewRow();
                                ExcelBuffer.AddColumn(PurchHeader."Order Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchHeader."Pay-to Vendor No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchHeader."Pay-to Name", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchHeader.Status, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchaseLines."Location Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchaseLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseLines."Amount Including VAT", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchRcptHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchRcptHeader."Posting Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchRcptLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseInvoice."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchaseInvoice."Posting Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchInvoiceLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvoiceLines."Amount Including VAT", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                            end;
                        until ValueEntry1.Next() = 0;
                    end else begin
                        ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn(PurchHeader."Order Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(PurchHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(PurchHeader."Pay-to Vendor No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(PurchHeader."Pay-to Name", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(PurchHeader.Status, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(PurchaseLines."Location Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(PurchaseLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(PurchaseLines."Amount Including VAT", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(PurchRcptHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Posting Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(PurchRcptLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::text);
                        ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    end;
                End Else begin
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(PurchHeader."Order Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn(PurchHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchHeader."Pay-to Vendor No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchHeader."Pay-to Name", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchHeader.Status, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchaseLines."Location Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchaseLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(PurchaseLines."Amount Including VAT", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(PurchRcptHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(PurchRcptHeader."Posting Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn(PurchRcptLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::text);
                    ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
                end;
            until ValueEntry.Next() = 0;
        end else begin
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn(PurchHeader."Order Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
            ExcelBuffer.AddColumn(PurchHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(PurchHeader."Pay-to Vendor No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(PurchHeader."Pay-to Name", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(PurchHeader.Status, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(PurchaseLines."Location Code", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(PurchaseLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(PurchaseLines."Amount Including VAT", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(PurchRcptHeader."No.", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(PurchRcptHeader."Posting Date", false, '', false, false, true, '', ExcelBuffer."Cell Type"::Date);
            ExcelBuffer.AddColumn(PurchRcptLines.Quantity, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', false, '', false, false, true, '', ExcelBuffer."Cell Type"::text);
            ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(0, false, '', false, false, true, '', ExcelBuffer."Cell Type"::Number);
        end;
    end;

    local procedure CreateBookInvoice()
    var
    begin
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        IsFirstOrder: Integer;
        IsFirstRcpt: Integer;

    //106049
}

