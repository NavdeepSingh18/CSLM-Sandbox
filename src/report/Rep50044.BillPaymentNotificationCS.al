report 50044 "Bill Payment NotificationCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Bill Payment NotificationCS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Vendor No.", "Document Type", Open)
                                WHERE(Open = FILTER(false),
                                      "Document Type" = FILTER('Invoice'));
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(VendorNo; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(VendorName; VendorRec.Name)
            {
            }
            column(PostingDate; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(AmountLCY; "Vendor Ledger Entry"."Amount (LCY)")
            {
            }
            column(RemainingAmtLCY; "Vendor Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(DueDate; "Vendor Ledger Entry"."Due Date")
            {
            }
            column(INvDocumentNo; "Vendor Ledger Entry"."Document No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF VendorRec.GET("Vendor No.") THEN;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Due Date", '>=%1', TODAY());
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        VendorRec: Record "Vendor";
}

