report 50140 "CLE CheckCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Invoice),
                                      "Remaining Amount" = FILTER(<> 0),
                                      Description = FILTER('COURSE FEES'));

            trigger OnAfterGetRecord()
            begin
                CustLedgerEntry.Reset();
                CustLedgerEntry.SETRANGE("Customer No.", "Cust. Ledger Entry"."Customer No.");
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
                CustLedgerEntry.SETRANGE(Description, 'STUDENT: SCHOLARSHIPS');
                IF CustLedgerEntry.findfirst() THEN BEGIN
                    CustLedgerEntryRec.Reset();
                    CustLedgerEntryRec.SETRANGE("Customer No.", "Cust. Ledger Entry"."Customer No.");
                    CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                    CustLedgerEntryRec.SETRANGE(Description, 'STUDENT: SCHOLARSHIPS');
                    IF CustLedgerEntry.findfirst() THEN BEGIN

                        CustLedgerEntry."Record To Show" := TRUE;
                        CustLedgerEntry.Modify();
                        "Cust. Ledger Entry"."Record To Show" := TRUE;
                        "Cust. Ledger Entry".Modify();
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CLE.Reset();
                CLE.MODIFYALL("Record To Show", FALSE);
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
        CLE: Record "Cust. Ledger Entry";
        CustLedgerEntryRec: Record "Cust. Ledger Entry";
}

