report 50144 "Bank to Gl entryCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Bank to Gl entryCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {

            trigger OnAfterGetRecord()
            begin
                BankAccountLedgerEntry.Reset();
                BankAccountLedgerEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");

                IF BankAccountLedgerEntry.findset() THEN
                    REPEAT
                        // "G/L Entry"."Cheque Date" := BankAccountLedgerEntry."Cheque Date";
                        // "G/L Entry"."Cheque No." := BankAccountLedgerEntry."Cheque No.";
                        "G/L Entry".Modify();
                    UNTIL BankAccountLedgerEntry.NEXT() = 0;
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
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
}

