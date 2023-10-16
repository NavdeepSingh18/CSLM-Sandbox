codeunit 50040 "Event Subscribe Living Exps"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", 'OnBeforePostApplyCustLedgEntry', '', false, false)]
    Local procedure AssignValueGenJnlLine(Var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: record "Cust. Ledger Entry"; GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        IF CustLedgerEntry."Living Exps. Document No." <> '' then begin
            GenJournalLine."Living Exps. Document No." := CustLedgerEntry."Living Exps. Document No.";
            GenJournalLine."Living Exps. Entry No." := CustLedgerEntry."Living Exps. Entry No.";
            GenJournalLine."Living Exps. INV Entry No." := CustLedgerEntry."Living Exps. INV Entry No.";
            GenJournalLine."Living Exps. RCPT Entry No." := CustLedgerEntry."Living Exps. RCPT Entry No.";
            GenJournalLine."Financial Aid Approved" := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    Local procedure AssignValueDtldCustLedgerEntryTbl(Var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        LED: Record "Living Expense Line";
    begin
        if GenJournalLine."Living Exps. Document No." <> '' then begin
            DtldCustLedgEntry."Living Exps. Document No." := GenJournalLine."Living Exps. Document No.";
            DtldCustLedgEntry."Living Exps. Entry No." := GenJournalLine."Living Exps. Entry No.";
            if DtldCustLedgEntry.Amount < 0 then
                DtldCustLedgEntry."Living Exps. Applied Entry No." := GenJournalLine."Living Exps. INV Entry No."
            else
                DtldCustLedgEntry."Living Exps. Applied Entry No." := GenJournalLine."Living Exps. RCPT Entry No.";
            LED.Reset();
            if LED.Get(DtldCustLedgEntry."Customer No.", GenJournalLine."Living Exps. Document No.", GenJournalLine."Living Exps. Entry No.") then begin
                LED.Status := LED.Status::Approved;

                if DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::Application then begin
                    LED."Entry Document No." := DtldCustLedgEntry."Document No.";
                    LED."Posted Amount" := LED."Posted Amount" + LED."Posting Amount";
                    LED."Posting Amount" := LED.Amount - LED."Posted Amount";
                end;
                LED.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure AssignLivingExpsValuesToGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        //PaymentJournalToGL
        GLEntry."Living Exps. Document No." := GenJournalLine."Living Exps. Document No.";
        GLEntry."Living Exps. Entry No." := GenJournalLine."Living Exps. Entry No.";
        GLEntry."Living Exps. Entry Type" := GenJournalLine."Living Exps. Entry Type";
    end;
}