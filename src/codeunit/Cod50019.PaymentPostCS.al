codeunit 50019 "Payment Post -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   18/02/2019     OnRun()-Function                Code added for online voucher posting.


    trigger OnRun()
    begin
        //Code added for online voucher posting::CSPL-00059::18022019: Start

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'ATOM');
        IF GenJournalLine.FINDFIRST() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
        MESSAGE('Posted!!');
        //Code added for online voucher posting::CSPL-00059::18022019: End
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
}

