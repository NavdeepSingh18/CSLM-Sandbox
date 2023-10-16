codeunit 50012 "Management Fee -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   18/02/2019     FeeProcessFunction()-Function               Code added for create fee and post.
    // 02    CSPL-00059   18/02/2019     CheckDuplicationFunction()-Function         Code added for validation.
    // 03    CSPL-00059   18/02/2019     ProcessCopyFees()-Function                  Code added for copy document.
    // 04    CSPL-00059   18/02/2019     PostSalesProcess()-Function                 Code added for posting.


    trigger OnRun()
    begin
    end;

    var
        Text000Lbl: Label 'Fee Copied';

    procedure FeeProcessFunction(StudID: Code[20]; FeeCod: Code[10]; DecAmount: Decimal)
    var
        FeeCodeSetupCS: Record "Fee Code Setup-CS";

        GenJournalLine: Record "Gen. Journal Line";

        FeeComponentMasterCS: Record "Fee Component Master-CS";
        StudentMasterNewCS: Record "Student Master New-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];

    begin
        //Code added for create fee and post::CSPL-00059::18022019: Start

        CLEAR(NoSeries);
        FeeCodeSetupCS.GET();
        FeeCodeSetupCS.TESTFIELD("Journal Template Name");
        FeeCodeSetupCS.TESTFIELD("Journal Batch Name");
        //FeeCodeSetupCS.GET(FeeCod);

        StudentMasterNewCS.GET(StudID);
        "TempDocNo." := NoSeries.GetNextNo(FeeCodeSetupCS."Fee Number", 0D, TRUE);
        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeCodeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeCodeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine."Journal Template Name" := FeeCodeSetupCS."Journal Template Name";
        GenJournalLine."Journal Batch Name" := FeeCodeSetupCS."Journal Batch Name";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        IF DecAmount > 0 THEN
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice
        ELSE
            IF DecAmount < 0 THEN
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account No." := StudID;
        GenJournalLine.VALIDATE("Account No.");
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := FeeComponentMasterCS."G/L Account";
        GenJournalLine.Description := FeeComponentMasterCS.Description;
        GenJournalLine."Posting Date" := TODAY();
        GenJournalLine."Debit Amount" := DecAmount;
        GenJournalLine.VALIDATE("Debit Amount");
        GenJournalLine."Document No." := "TempDocNo.";
        GenJournalLine.Class := StudentMasterNewCS.Class;
        GenJournalLine.Section := StudentMasterNewCS.Section;
        GenJournalLine."Academic Year" := StudentMasterNewCS."Academic Year";
        GenJournalLine."Fee Code" := FeeCod;
        GenJournalLine.INSERT(TRUE);
        //Code added for create fee and post::CSPL-00059::18022019: End
    end;

    procedure CheckDuplicationFunction(StdID: Code[20]; FeeCodec: Code[20]; Prog: Code[20]; Semes: Code[10]; Seesion: Code[20]): Boolean
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        //Code added for validation::CSPL-00059::18022019: Start
        CLE.Reset();
        CLE.SETCURRENTKEY("Customer No.", "Fee Code", "Course Code", Semester, "Academic Year");
        CLE.SETRANGE("Customer No.", StdID);
        CLE.SETRANGE("Fee Code", FeeCodec);
        CLE.SETRANGE("Course Code", Prog);
        CLE.SETRANGE(Semester, Semes);
        CLE.SETRANGE("Academic Year", Seesion);
        IF CLE.ISEMPTY() then
            EXIT(TRUE)
        ELSE
            EXIT(FALSE)
        //Code added for validation::CSPL-00059::18022019: End
    end;

    procedure ProcessCopyFees(Fcode: Code[20]; ProgFeeN: Code[20])
    var
        FeeCourseLineCS: Record "Fee Course Line-CS";
        FeeCourseLineCS1: Record "Fee Course Line-CS";
    begin
        //Code added copy document::CSPL-00059::18022019: Start
        FeeCourseLineCS.Reset();
        FeeCourseLineCS.SETRANGE("Document No.", Fcode);
        IF FeeCourseLineCS.FINDSET() THEN
            REPEAT
                FeeCourseLineCS1.INIT();
                FeeCourseLineCS1.TRANSFERFIELDS(FeeCourseLineCS);
                FeeCourseLineCS1."Document No." := ProgFeeN;
                FeeCourseLineCS1.INSERT();
            UNTIL FeeCourseLineCS.NEXT() = 0;
        MESSAGE(Text000Lbl);
        //Code added for copy document::CSPL-00059::18022019: End
    end;

    procedure PostSalesProcess(StdId: Code[20]; Feecode: Code[20]; DecAmt: Decimal): Code[20]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        SalesHeader1: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";

    begin
        //Code added for Posting data::CSPL-00059::18022019: Start
        FeeComponentMasterCS.GET(Feecode);
        FeeComponentMasterCS.TESTFIELD("G/L Account");
        StudentMasterCS.GET(StdId);
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", StudentMasterCS."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then;
        SalesHeader.Reset();
        SalesHeader.INIT();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."Sell-to Customer No." := StdId;
        SalesHeader."Posting Date" := TODAY();
        SalesHeader."Shipment Date" := TODAY();
        SalesHeader."Document Date" := TODAY();
        SalesHeader.VALIDATE("Sell-to Customer No.");
        SalesHeader."Payment Method Code" := 'CASH';
        SalesHeader."Payment Terms Code" := '0d';
        SalesHeader.VALIDATE("Payment Terms Code");
        SalesHeader.Ship := TRUE;
        SalesHeader.Invoice := TRUE;
        SalesHeader."Fee Code" := Feecode;
        SalesHeader.Section := StudentMasterCS.Section;
        SalesHeader."Academic Year" := EducationSetupCS."Academic Year";
        SalesHeader.INSERT(TRUE);

        SalesLine.INIT();
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := 10000;
        SalesLine.Type := SalesLine.Type::"G/L Account";
        SalesLine.VALIDATE(Type);
        SalesLine."No." := FeeComponentMasterCS."G/L Account";
        SalesLine.VALIDATE("No.");
        SalesLine.Quantity := 1;
        SalesLine.VALIDATE(Quantity);
        SalesLine."Unit Price" := DecAmt;
        SalesLine.VALIDATE("Unit Price");
        SalesLine.INSERT(TRUE);

        IF SalesHeader1.GET(SalesHeader."Document Type"::Order, SalesHeader."No.") THEN BEGIN
            CLEAR(SalesPost);
            //SalesPost.SetPostingDate(FALSE, FALSE, SalesHeader1."Posting Date");
            SalesPost.RUN(SalesHeader1);

            SalesInvoiceHeader.Reset();
            SalesInvoiceHeader.SETRANGE("Order No.", SalesHeader."No.");
            IF SalesInvoiceHeader.FINDFIRST() THEN
                EXIT(SalesInvoiceHeader."No.");
        END;
        //Code added for Posting data::CSPL-00059::18022019: END
    end;
}

