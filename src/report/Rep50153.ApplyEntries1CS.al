report 50153 "Apply Entries1CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Apply Entries1CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Payment));

            trigger OnAfterGetRecord()
            begin
                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Customer No.", "Bal. Account No.");
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETFILTER("Remaining Amount", '>%1', 0);
                CustLedgerEntry.SETFILTER("Amount to Apply", '%1', 0);
                IF CustLedgerEntry.findfirst() THEN BEGIN
                    CustLedgerEntry."Amount to Apply" := CustLedgerEntry."Remaining Amount";
                    CustLedgerEntry.Modify();
                    VALIDATE("Applies-to Doc. No.", CustLedgerEntry."Document No.");
                    Modify();
                END;
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

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
}

