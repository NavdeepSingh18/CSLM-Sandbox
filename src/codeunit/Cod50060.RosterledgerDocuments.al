codeunit 50060 "Create Roster Ledger Documents"
{
    trigger OnRun()
    begin
        educatiosetup.Reset();
        educatiosetup.SetRange("Global Dimension 1 Code", '9000');
        if educatiosetup.FindFirst() then
            educatiosetup.TestField("KK Report Data From Date");

        newdate := CalcDate('<20Y>', educatiosetup."KK Report Data From Date");

        rosterledgerdocuments.Reset();
        rosterledgerdocuments.SetRange("Rotation Date", educatiosetup."KK Report Data From Date", newdate);
        if rosterledgerdocuments.FindFirst() then
            rosterledgerdocuments.DeleteAll();

        rosterledgerentry.Reset();
        rosterledgerentry.SetRange("Start Date", educatiosetup."KK Report Data From Date", newdate);
        if rosterledgerentry.FindFirst() then
            repeat
                rosterledgerdocuments.Init();
                rosterledgerdocuments."Entry No." := rosterledgerentry."Entry No.";

                ClerkshipPaymentLedgerEntry.Reset();
                ClerkshipPaymentLedgerEntry.SetRange("Rotation Entry No.", rosterledgerentry."Entry No.");
                ClerkshipPaymentLedgerEntry.SetRange("Student ID", rosterledgerentry."Student ID");
                ClerkshipPaymentLedgerEntry.SetRange("Course Code", rosterledgerentry."Course Code");
                ClerkshipPaymentLedgerEntry.setrange("Entry Type", ClerkshipPaymentLedgerEntry."Entry Type"::"Invoice Reversal");
                if ClerkshipPaymentLedgerEntry.FindLast() then begin
                    rosterledgerdocuments."Invoice Nos." := '';
                end else begin
                    counter := 0;
                    ClerkshipPaymentLedgerEntry.Reset();
                    ClerkshipPaymentLedgerEntry.SetRange("Rotation Entry No.", rosterledgerentry."Entry No.");
                    ClerkshipPaymentLedgerEntry.SetRange("Entry Type", ClerkshipPaymentLedgerEntry."Entry Type"::Invoice);
                    ClerkshipPaymentLedgerEntry.SetFilter("Invoice No.", '<>%1', '');
                    if ClerkshipPaymentLedgerEntry.findset() then begin
                        repeat
                            counter += 1;
                            if counter = 1 then begin
                                rosterledgerdocuments."Invoice Nos." := ClerkshipPaymentLedgerEntry."Invoice No.";
                            end else begin
                                rosterledgerdocuments."Invoice Nos." += '|' + ClerkshipPaymentLedgerEntry."Invoice No.";
                            end;
                        until ClerkshipPaymentLedgerEntry.Next() = 0;
                    end;
                end;

                ClerkshipPaymentLedgerEntry.Reset();
                ClerkshipPaymentLedgerEntry.SetRange("Rotation Entry No.", rosterledgerentry."Entry No.");
                ClerkshipPaymentLedgerEntry.SetRange("Student ID", rosterledgerentry."Student ID");
                ClerkshipPaymentLedgerEntry.SetRange("Course Code", rosterledgerentry."Course Code");
                ClerkshipPaymentLedgerEntry.setrange("Entry Type", ClerkshipPaymentLedgerEntry."Entry Type"::"Payment Reversal");
                if ClerkshipPaymentLedgerEntry.FindLast() then begin
                    rosterledgerdocuments."Cheque Dates" := '';
                    rosterledgerdocuments."Cheque Nos." := '';
                end else begin
                    Counter1 := 0;
                    ClerkshipPaymentLedgerEntry.Reset();
                    ClerkshipPaymentLedgerEntry.SetRange("Rotation Entry No.", rosterledgerentry."Entry No.");
                    ClerkshipPaymentLedgerEntry.SetRange("Entry Type", ClerkshipPaymentLedgerEntry."Entry Type"::Payment);
                    ClerkshipPaymentLedgerEntry.SetFilter("Check No.", '<>%1', '');
                    if ClerkshipPaymentLedgerEntry.findset() then
                        repeat
                            Counter1 += 1;
                            if Counter1 = 1 then begin
                                rosterledgerdocuments."Cheque Dates" := Format(ClerkshipPaymentLedgerEntry."Check Date");
                                rosterledgerdocuments."Cheque Nos." := ClerkshipPaymentLedgerEntry."Check No.";
                            end else begin
                                rosterledgerdocuments."Cheque Dates" += '|' + Format(ClerkshipPaymentLedgerEntry."Check Date");
                                rosterledgerdocuments."Cheque Nos." += '|' + ClerkshipPaymentLedgerEntry."Check No.";
                            end;
                        until ClerkshipPaymentLedgerEntry.Next() = 0;
                end;
                rosterledgerdocuments."Rotation Date" := rosterledgerentry."Start Date";
                rosterledgerdocuments.Insert();
            until rosterledgerentry.Next() = 0;
    end;

    var
        educatiosetup: Record "Education Setup-CS";
        rosterledgerentry: Record "Roster Ledger Entry";
        ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
        rosterledgerdocuments: record "Roster Ledger Documents";
        counter: integer;
        Counter1: Integer;
        newdate: Date;
}