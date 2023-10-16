report 50058 "Payment Notify To PurchCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Payment Notify To PurchCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = WHERE("Document Type" = FILTER('Payment' | ' '));
            column(CompName; CompanyInformation.Name)
            {
            }
            column(EntryNo; "Vendor Ledger Entry"."Entry No.")
            {
            }
            column(VendorNo; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(DocType; "Vendor Ledger Entry"."Document Type")
            {
            }
            column(DocNo; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(Amount; "Vendor Ledger Entry".Amount)
            {
            }
            column(VendorName; Vendor.Name)
            {
            }
            column(RemainingAmt; "Vendor Ledger Entry"."Remaining Amount")
            {
            }
            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                DataItemTableView = WHERE("Entry Type" = FILTER('Application'));
                column(VendLedgerEntryNo; "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.")
                {
                }
                column(EntryType; "Detailed Vendor Ledg. Entry"."Entry Type")
                {
                }
                column(DocType2; "Detailed Vendor Ledg. Entry"."Document Type")
                {
                }
                column(DocNo2; "Detailed Vendor Ledg. Entry"."Document No.")
                {
                }
                column(AppliedAmt; ABS("Detailed Vendor Ledg. Entry".Amount))
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF Vendor.GET("Vendor No.") THEN;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1', (System.WorkDate()));
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
        CompanyInformation.GET();
    end;

    var
        Vendor: Record "Vendor";
        CompanyInformation: Record "Company Information";
}

