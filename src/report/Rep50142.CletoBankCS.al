report 50142 "Cle to BankCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Cle to BankCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Document No.", "Bank Account Ledger Entry"."Document No.");
                IF CustLedgerEntry.findfirst() THEN
                    REPEAT
                        "Bank Account Ledger Entry"."Customer Bank Code" := CustLedgerEntry."Customer Bank Code";
                        "Bank Account Ledger Entry"."Customer Bank Branch Code" := CustLedgerEntry."Customer Bank Branch Code";
                        "Bank Account Ledger Entry".Modify();
                    UNTIL CustLedgerEntry.NEXT() = 0;
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

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
}

