codeunit 50032 "Managements Fee -CS"
{
    // version V.001-CS

    // Sr.No.Emp Id        Date   Trigger                        Remark
    // 1      CSPL-00067    21-02-19FeeProcessCS                  Code Added for Fee Process
    // 2      CSPL-00067    21-02-19CheckDuplicationCS            Code Added for Check Duplication
    // 3      CSPL-00067    21-02-19Post SalesCS                  Code Added for Post Sales
    // 4      CSPL-00067    21-02-19FeeProcessNewCS                Code Added for Fee Process New
    // 5      CSPL-00067    21-02-19CheckDuplicationYRCS          Code Added for Check Duplication YR
    // 6      CSPL-00067    21-02-19CopyFeesCS                    Code Added for Copy Fees
    // 7      CSPL-00067    21-02-19FeeNewProcessCS                Code Added for Fee New Process
    // 8      CSPL-00067    21-02-19FeeProcessDisnNewCS            Code Added for Fee Process Disn New
    // 9      CSPL-00067    21-02-19FeeDiscountCalcCS              Code Added for Fee Discount Calc
    // 10    CSPL-00067    21-02-19CustomerInsertCS              Code Added for Customer Insert
    // 11    CSPL-00067    21-02-19FeeProcessDisCS                Code Added for Fee Process Dis
    // 12    CSPL-00067    21-02-19FineGenerationProcessCS        Code Added for Fine Generation Process
    // 13    CSPL-00067    21-02-19ScholarshipGenration1stYearCS  Code Added for Scholarship Genration 1st Year
    // 14    CSPL-00067    21-02-19ScholarshipGenrationRestYearsCSCode Added for Scholar ship Genration Rest Years
    // 15    CSPL-00067    21-02-19OtherFeeGenerationCS          Code Added for Other Fee Generation
    // 16    CSPL-00067    21-02-19CustomerCautionInsertCS        Code Added for Customer Caution Insert


    trigger OnRun()
    begin
    end;

    var

        Text006Lbl: Label 'Fee Copied';
        RemainingAmt: Decimal;

    procedure FeeProcessCS("StudNo.": Code[20]; FeeCode: Code[20]; Amount: Decimal)
    var
        FeeSetupCS: Record "Fee Setup-CS";

        GenJournalLine: Record "Gen. Journal Line";

        FeeComponentMasterCS: Record "Fee Component Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];


    begin
        //Code Added for Fee Process::CSPL-00067::210219:Start

        CLEAR(NoSeriesManagement);
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeSetupCS.TESTFIELD("Fee Invoice No.");


        FeeComponentMasterCS.GET(FeeCode);
        StudentMasterCS.GET("StudNo.");
        "TempDocNo." := NoSeriesManagement.GetNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");


        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine."Journal Template Name" := FeeSetupCS."Journal Template Name";
        GenJournalLine."Journal Batch Name" := FeeSetupCS."Journal Batch Name";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        IF Amount > 0 THEN
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice
        ELSE
            IF Amount < 0 THEN
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account No." := "StudNo.";
        GenJournalLine.VALIDATE("Account No.");


        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := FeeComponentMasterCS."G/L Account";
        GenJournalLine."Posting Date" := TODAY();
        GenJournalLine."Debit Amount" := Amount;
        GenJournalLine.VALIDATE("Debit Amount");
        GenJournalLine."Document No." := "TempDocNo.";
        GenJournalLine.Description := FeeComponentMasterCS.Description;
        GenJournalLine."Fee Code" := FeeCode;
        GenJournalLine.Course := StudentMasterCS."Course Code";
        GenJournalLine.Semester := StudentMasterCS.Semester;
        GenJournalLine."Academic Year" := StudentMasterCS."Academic Year";
        GenJournalLine.INSERT(TRUE);
        //Code Added for Fee Process::CSPL-00067::210219:End
    end;

    procedure CheckDuplicationCS("StudNo.": Code[20]; FeeCode: Code[20]; Course: Code[20]; Sem: Code[10]; Accyear: Code[20]): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //Code Added for Check Duplication::CSPL-00067::200219:Start
        CustLedgerEntry.Reset();
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Fee Code", "Course Code", Semester, "Academic Year");
        CustLedgerEntry.SETRANGE("Customer No.", "StudNo.");
        CustLedgerEntry.SETRANGE("Fee Code", FeeCode);
        CustLedgerEntry.SETRANGE("Course Code", Course);
        CustLedgerEntry.SETRANGE(Semester, Sem);
        CustLedgerEntry.SETRANGE("Academic Year", Accyear);
        IF CustLedgerEntry.ISEMPTY() then
            EXIT(TRUE)
        ELSE
            EXIT(FALSE)
        //Code Added for Check Duplication::CSPL-00067::210219:END
    end;

    procedure "Post SalesCS"("getStudentNo.": Code[20]; getFeeCode: Code[20]; getAmount: Decimal): Code[20]
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
        //Code Added for Post Sales::CSPL-00067::210219:Start

        FeeComponentMasterCS.GET(getFeeCode);
        FeeComponentMasterCS.TESTFIELD("G/L Account");
        StudentMasterCS.GET("getStudentNo.");
        EducationSetupCS.GET();
        SalesHeader.Reset();
        SalesHeader.INIT();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."Sell-to Customer No." := "getStudentNo.";
        SalesHeader."Posting Date" := TODAY();
        SalesHeader."Shipment Date" := TODAY();
        SalesHeader."Document Date" := TODAY();
        SalesHeader.VALIDATE("Sell-to Customer No.");
        SalesHeader."Payment Method Code" := 'CASH';
        SalesHeader."Payment Terms Code" := '0D';
        SalesHeader.VALIDATE("Payment Terms Code");
        SalesHeader.Ship := TRUE;
        SalesHeader.Invoice := TRUE;
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
        SalesLine."Unit Price" := getAmount;
        SalesLine.VALIDATE("Unit Price");
        SalesLine.INSERT(TRUE);

        SalesHeader1.Reset();
        IF SalesHeader1.GET(SalesHeader."Document Type"::Order, SalesHeader."No.") THEN BEGIN
            CLEAR(SalesPost);
            //SalesPost.SetPostingDate(FALSE, FALSE, SalesHeader1."Posting Date");
            SalesPost.RUN(SalesHeader1);
            SalesInvoiceHeader.Reset();
            SalesInvoiceHeader.SETRANGE("Order No.", SalesHeader."No.");
            IF SalesInvoiceHeader.FINDFIRST() THEN
                EXIT(SalesInvoiceHeader."No.");
        END;
        //Code Added for Post Sales::CSPL-00067::210219:End
    end;

    procedure FeeProcessNewCS(StudNo: Code[20]; FeeCode1: Code[20]; Amount: Decimal; Customer: Record "Customer"; YearPart: Option " ","1st","2nd"; TempDocNo: Code[20]; CurrencyCode: Code[10]; DueDate: Date)
    var
        FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";

        // GenJournalBatch: Record "Gen. Journal Batch";
        // Genjourrec: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        //NoSeries: Codeunit "NoSeriesManagsement";
        NoSeries: Codeunit NoSeriesManagement;
        // FeeCourseHeadCS: Record "Fee Course Head-CS";
        //StudentMasterCS: Record "Student Master-CS";
        // FeeDiscountLineCS: Record "Fee Discount Line-CS";

        // "TempDocNo.": Code[20];
        //CheckBool: Boolean;

        // DiscountAmount: Decimal;
        // LineNo: Integer;
        // "TempDocNo.1": Code[20];
        TempDocNo1: Code[20];

    begin
        //Code Added for Fee Process New::CSPL-00067::210219:Start
        CLEAR(NoSeries);
        TempDocNo1 := TempDocNo;
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        // GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine.VALIDATE("Account No.", FeeComponentMasterCS."G/L Account");
        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Posting Date", WORKDATE());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Credit Amount", Amount);
        GenJournalLine.VALIDATE("Document No.", TempDocNo1);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine."Enrollment No." := Customer."Enrollment No.";
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE("Source Code", 'COURSE FEE');
        GenJournalLine.VALIDATE("Source Code");
        GenJournalLine.VALIDATE("Due Date", DueDate);
        GenJournalLine.INSERT(TRUE);
        //Code Added for Fee Process New::CSPL-00067::210219:End
    end;

    procedure CheckDuplicationYRCS("StudNo.": Code[20]; FeeCode: Code[20]; Course: Code[20]; Yr: Code[20]; Accyear: Code[20]; YearPart: Code[10]): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        // CustAmount: Decimal;
        Flag: Boolean;
    begin
        //Code Added for Check Duplication YR::CSPL-00067::210219:Start
        Flag := FALSE;

        CustLedgerEntry.Reset();
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Fee Code", "Course Code", Year, "Academic Year");
        CustLedgerEntry.SETRANGE("Customer No.", "StudNo.");
        CustLedgerEntry.SETRANGE("Fee Code", FeeCode);
        CustLedgerEntry.SETRANGE("Course Code", Course);
        CustLedgerEntry.SETRANGE(Year, Yr);
        CustLedgerEntry.SETRANGE("Academic Year", Accyear);
        IF CustLedgerEntry.FINDSET() THEN
            REPEAT
                IF CustLedgerEntry.Reversed THEN
                    Flag := TRUE
            UNTIL CustLedgerEntry.NEXT() = 0
        ELSE
            EXIT(TRUE);

        IF Flag THEN
            EXIT(TRUE);

        EXIT(FALSE);
        //Code Added for Check Duplication YR::CSPL-00067::210219:End
    end;

    procedure CopyFeesCS(feecode: Code[20]; CourseFeeNo: Code[20])
    var
        FeeCourseLineCS: Record "Fee Course Line-CS";
        FeeCourseLineCS1: Record "Fee Course Line-CS";
    begin
        //Code Added for Copy Fees::CSPL-00067::210219:Start
        FeeCourseLineCS.Reset();
        FeeCourseLineCS.SETRANGE("Document No.", feecode);
        IF FeeCourseLineCS.FINDSET() THEN
            REPEAT
                FeeCourseLineCS1.INIT();
                FeeCourseLineCS1.TRANSFERFIELDS(FeeCourseLineCS);
                FeeCourseLineCS1."Document No." := CourseFeeNo;
                FeeCourseLineCS1.INSERT();
            UNTIL FeeCourseLineCS.NEXT() = 0;
        MESSAGE(Text006Lbl);
        //Code Added for Copy Fees::CSPL-00067::210219:End
    end;

    procedure FeeNewProcessCS(StudNo: Code[20]; FeeCode1: Code[10]; Amount: Decimal; VarFeetype: Code[50]; FeeType: Code[10])
    var
        FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";
        //GenJournalBatch: Record "Gen. Journal Batch";
        //Genjourrec: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        Customer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
    //CheckBool: Boolean;
    // LineNo: Integer;
    //"TempDocNo.1": Code[20];

    begin
        //Code Added for Fee New Process::CSPL-00067::210219:Start
        CLEAR(NoSeries);
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);
        CLEAR("TempDocNo.");
        "TempDocNo." := NoSeries.GetNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine."Journal Template Name" := FeeSetupCS."Journal Template Name";
        GenJournalLine."Journal Batch Name" := FeeSetupCS."Journal Batch Name";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        IF Amount > 0 THEN
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice
        ELSE
            IF Amount < 0 THEN
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account No." := StudNo;
        GenJournalLine.VALIDATE("Account No.");
        IF (Customer."Pay Type" <> Customer."Pay Type"::Unpaid) THEN BEGIN
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
            GenJournalLine."Bal. Account No." := FeeComponentMasterCS."G/L Account";
        END
        ELSE BEGIN
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
            GenJournalLine."Bal. Account No." := '143000080';
            GenJournalLine.Comment := 'SAMAJ KALYAN SCHOLARSHIP REFUNDABLE';
        END;

        IF Customer."Type Of Course" = Customer."Type Of Course"::Year THEN
            GenJournalLine.Year := Customer.Year;


        GenJournalLine.Description := FeeComponentMasterCS.Description;
        GenJournalLine."Posting Date" := TODAY();
        GenJournalLine."Debit Amount" := Amount;
        GenJournalLine.VALIDATE("Debit Amount");
        GenJournalLine."Document No." := "TempDocNo.";
        GenJournalLine.Course := Customer."Course Code";
        GenJournalLine.Semester := Customer.Semester;
        GenJournalLine.Year := Customer.Year;
        GenJournalLine."Academic Year" := Customer."Academic Year";
        GenJournalLine.Validate("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE("Currency Code");
        GenJournalLine."Source Code" := 'FEE';
        GenJournalLine."Shortcut Dimension 1 Code" := Customer."Global Dimension 1 Code";//MOH190516
        GenJournalLine.Course := Customer."Course Code";//MOH190516
        GenJournalLine.VALIDATE("Source Code");
        GenJournalLine.INSERT(TRUE);
        //Code Added for Fee New Process::CSPL-00067::210219:End
    end;

    procedure FeeProcessDisnNewCS(StudNo: Code[20]; FeeCode1: Code[10]; Amount: Decimal; VarFeetype: Code[50]; FeeType: Code[10]; FeePart: Option " ","1st","2nd")
    var
        FeeSetupCS: Record "Fee Setup-CS";
        //GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";
        // GenJournalBatch: Record "Gen. Journal Batch";
        // Genjourrec: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        Customer: Record "Customer";
        // FeeDiscountLineCS: Record "Fee Discount Line-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
    /* CheckBool: Boolean;
     DiscountAmount: Decimal;
     LineNo: Integer;
     "TempDocNo.1": Code[20];*/
    begin
        //Code Added for Fee Process Disn New::CSPL-00067::210219:Start
        CLEAR(NoSeries);
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);
        "TempDocNo." := NoSeries.GetNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);
        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine."Journal Template Name" := FeeSetupCS."Journal Template Name";
        GenJournalLine."Journal Batch Name" := FeeSetupCS."Journal Batch Name";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        IF Amount > 0 THEN
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice
        ELSE
            IF Amount < 0 THEN
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account No." := StudNo;
        GenJournalLine.VALIDATE("Account No.");
        IF (Customer."Pay Type" <> Customer."Pay Type"::Unpaid) THEN BEGIN
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
            GenJournalLine."Bal. Account No." := FeeComponentMasterCS."G/L Account";
        END
        ELSE BEGIN
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
            GenJournalLine."Bal. Account No." := '143000080';
            GenJournalLine.Comment := 'Fee';
        END;
        GenJournalLine.Description := FeeComponentMasterCS.Description;
        GenJournalLine."Posting Date" := TODAY();
        GenJournalLine."Due Date" := WORKDATE();
        GenJournalLine."Debit Amount" := Amount;
        GenJournalLine.VALIDATE("Debit Amount");
        GenJournalLine."Document No." := "TempDocNo.";
        GenJournalLine.Course := Customer."Course Code";
        GenJournalLine.Semester := Customer.Semester;
        GenJournalLine.Year := Customer.Year;
        GenJournalLine."Academic Year" := Customer."Academic Year";
        GenJournalLine.Validate("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE("Currency Code");
        GenJournalLine."Source Code" := 'FEE';
        GenJournalLine."Shortcut Dimension 1 Code" := Customer."Global Dimension 1 Code";
        GenJournalLine.Course := Customer."Course Code";
        GenJournalLine.VALIDATE("Source Code");
        GenJournalLine.INSERT(TRUE);
        //Code Added for Fee Process Disn New::CSPL-00067::210219:End
    end;

    procedure FeeDiscountCalcCS(CustNo: Code[20]; Amount: Decimal; BalAccountNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine1: Record "Gen. Journal Line";

        FeeSetupCS: Record "Fee Setup-CS";
        CustRec: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        LineNo: Integer;
        DocumentNo: Code[20];
    begin
        //Code Added for Fee Discount Calc::CSPL-00067::210219:Start
        CustRec.GET(CustNo);
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD(FeeSetupCS."Journal Template Name");
        FeeSetupCS.TESTFIELD(FeeSetupCS."Journal Batch Name");
        DocumentNo := NoSeries.GetNextNo(FeeSetupCS."Fee Discount No.", 0D, TRUE);

        LineNo := 0;
        GenJournalLine1.Reset();
        GenJournalLine1.SETRANGE(GenJournalLine1."Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine1.SETRANGE(GenJournalLine1."Journal Batch Name", 'SCHLR GEN');
        IF GenJournalLine1.FINDLAST() THEN
            LineNo := GenJournalLine1."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", 'SCHLR GEN');
        GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo);
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date", WORKDATE());
        GenJournalLine.VALIDATE(GenJournalLine."Document Type", GenJournalLine."Document Type"::"Credit Memo");
        GenJournalLine.VALIDATE(GenJournalLine."Document No.", DocumentNo);
        GenJournalLine.VALIDATE(GenJournalLine."Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE(GenJournalLine."Account No.", BalAccountNo);
        GenJournalLine.VALIDATE(GenJournalLine."Debit Amount", Amount);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", CustRec."No.");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code", CustRec."Global Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code", CustRec."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code", CustRec."Currency Code");
        GenJournalLine.VALIDATE(GenJournalLine.Year, CustRec.Year);
        GenJournalLine.VALIDATE(GenJournalLine.Course, CustRec."Course Code");
        GenJournalLine.VALIDATE(GenJournalLine."Academic Year", CustRec."Academic Year");
        GenJournalLine.VALIDATE(GenJournalLine.Category, CustRec.Category);
        GenJournalLine.VALIDATE("Source Code", 'SCHOLAR');
        GenJournalLine.INSERT(TRUE);
        //Code Added for Fee Discount Calc::CSPL-00067::210219:End
    end;

    procedure CustomerInsertCS(StudNo: Code[20]; FeeCode1: Code[20]; Amount: Decimal; Customer: Record "Customer"; YearPart: Option " ","1st","2nd"; TempDocNo: Code[20]; LateFee: Decimal; CurrencyCode: Code[10]; DueDate: Date)
    var
        FeeSetupCS: Record "Fee Setup-CS";

        GenJournalLine: Record "Gen. Journal Line";


        // Genjourrec: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        //StudentMasterCS: Record "Student Master-CS";
        //FeeDiscountLineCS: Record "Fee Discount Line-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        /*"TempDocNo.": Code[20];
        CheckBool: Boolean;
        DiscountAmount: Decimal;
        LineNo: Integer;
        "TempDocNo.1": Code[20];*/
        TempDocNo1: Code[20];
    begin
        //Code Added for Customer Insert::CSPL-00067::210219:Start
        CLEAR(NoSeries);
        TempDocNo1 := TempDocNo;
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");

        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        IF Amount > 0 THEN
            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
        ELSE
            IF Amount < 0 THEN
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");


        GenJournalLine.VALIDATE(Description, 'Course Fees');
        GenJournalLine.VALIDATE("Posting Date", WORKDATE());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Debit Amount", Amount);
        GenJournalLine.VALIDATE("Document No.", TempDocNo1);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine."Enrollment No." := Customer."Enrollment No.";
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE("Late Fee %", LateFee);
        GenJournalLine.VALIDATE("Source Code", 'COURSE FEE');
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Source Code");
        GenJournalLine.VALIDATE("Due Date", DueDate);
        GenJournalLine.INSERT(TRUE);
        //Code Added for Customer Insert::CSPL-00067::210219:End
    end;

    procedure FeeProcessDisCS(StudNo: Code[20]; Amount: Decimal; VarFeetype: Code[50]; Customer: Record "Customer"; YearPart: Option " ","1st","2nd")
    var
        FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";

        // GenJournalBatch: Record "Gen. Journal Batch";
        // Genjourrec: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        // StudentMasterCS: Record "Student Master-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
    // CheckBool: Boolean;
    // LineNo: Integer;
    // "TempDocNo.1": Code[20];
    begin
        //Code Added for Fee Process Dis::CSPL-00067::210219:Start
        CLEAR(NoSeries);
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeComponentMasterCS.GET(VarFeetype);
        "TempDocNo." := NoSeries.GetNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        IF Amount > 0 THEN
            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
        ELSE
            IF Amount < 0 THEN
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Bal. Account No.", FeeComponentMasterCS."G/L Account");
        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE("Debit Amount", Amount);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Fee Code", VarFeetype);
        GenJournalLine.VALIDATE("Currency Code");
        GenJournalLine.VALIDATE("Source Code", 'COURSE FEE');
        GenJournalLine.VALIDATE("Source Code");
        GenJournalLine.INSERT(TRUE);
        //Code Added for Fee Process Dis::CSPL-00067::210219:End
    end;

    procedure FineGenerationProcessCS(StudNo: Code[20]; PostingDate: Date; TemplateName: Code[20]; BatchName: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        CustRec: Record "Customer";
        GenJournalLine1: Record "Gen. Journal Line";
        FeeSetupCS: Record "Fee Setup-CS";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        // GenJournalBatch: Record "Gen. Journal Batch";
        // Customer: Record "Customer";
        // FeeClassificationMasterCS: Record "Fee Classification Master-CS";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        NoSeriesLine: Record "No. Series Line";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationCalendarCS: Record "Education Calendar-CS";
        //NoSeriesManagement: Codeunit "NoSeriesManagement";
        //"TempDocNo.": Code[20];
        NooFDays: Integer;
        FineAmount: Decimal;
        LineNo: Integer;
        DocNO: Code[20];
        Bool: Boolean;
        PDate: Date;
        FineAmount1: Decimal;
    begin
        //Code Added for Fine Generation Process::CSPL-00067::210219:Start
        FeeSetupCS.GET();
        CustRec.GET(StudNo);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Source Code", 'LATE FEES');
        GenJournalLine.SETRANGE("Account No.", StudNo);
        IF GenJournalLine.FINDFIRST() THEN
            ERROR('Late Fine is Already Generated !!');

        CustLedgerEntry.Reset();
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Customer No.", StudNo);
        CustLedgerEntry.SETFILTER(Description, 'COURSE FEES');
        IF CustLedgerEntry.FINDFIRST() THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Remaining Amount");
            RemainingAmt := CustLedgerEntry."Remaining Amount";
        END;

        DetailedCustLedgEntry.Reset();
        DetailedCustLedgEntry.SETRANGE("Customer No.", StudNo);
        DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        IF DetailedCustLedgEntry.FINDLAST() THEN BEGIN
            PDate := DetailedCustLedgEntry."Posting Date";
            Bool := TRUE
        END ELSE
            Bool := FALSE;

        IF Bool = FALSE THEN BEGIN
            FeeCourseHeadCS.Reset();
            FeeCourseHeadCS.SETRANGE("Course Code", CustRec."Course Code");
            FeeCourseHeadCS.SETRANGE(Year, CustRec.Year);
            FeeCourseHeadCS.SETRANGE("Academic Year", CustRec."Academic Year");
            FeeCourseHeadCS.SETRANGE("Admitted Year", CustRec."Admitted Year");
            FeeCourseHeadCS.SETRANGE("Fee Classification Code", CustRec."Fee Classification Code");
            FeeCourseHeadCS.SETRANGE("Global Dimension 1 Code", CustRec."Global Dimension 1 Code");
            IF FeeCourseHeadCS.FINDFIRST() THEN
                IF FeeCourseHeadCS."Late Fine %" = 0 THEN
                    ERROR('Late Fine % does not have value to calculate the fine !!');
            FeeCourseLineCS.Reset();
            FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
            IF FeeCourseLineCS.FINDFIRST() THEN
                EducationCalendarCS.Reset();
            EducationCalendarCS.SETRANGE(Code, 'FEE PAYMENT');
            EducationCalendarCS.SETRANGE("Academic Year", CustRec."Academic Year");
            IF EducationCalendarCS.FINDFIRST() THEN
                EducationMultiEventCalCS.Reset();
            EducationMultiEventCalCS.SETRANGE(Code, EducationCalendarCS.Code);
            EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
            IF EducationMultiEventCalCS.FINDFIRST() THEN
                IF PostingDate > EducationMultiEventCalCS."End Date" THEN BEGIN
                    NooFDays := (PostingDate - EducationMultiEventCalCS."End Date");
                    FineAmount := ((NooFDays - 1) * FeeCourseHeadCS."Late Fine %" * RemainingAmt) / (365 * 100);
                    FineAmount1 := ROUND(FineAmount, 1);
                END ELSE
                    IF PostingDate <= EducationMultiEventCalCS."End Date" THEN
                        FineAmount := 0;

            IF FineAmount <> 0 THEN BEGIN
                GenJournalLine1.Reset();
                GenJournalLine1.SETRANGE("Journal Template Name", TemplateName);
                GenJournalLine1.SETRANGE("Journal Batch Name", BatchName);
                IF GenJournalLine1.FINDLAST() THEN
                    LineNo := GenJournalLine1."Line No." + 10000
                ELSE
                    LineNo := 10000;
                NoSeriesLine.Reset();
                NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", FeeSetupCS."Fee Invoice No.");
                IF NoSeriesLine.FINDFIRST() THEN
                    IF NoSeriesLine."Last No. Used" <> '' THEN
                        DocNO := INCSTR(NoSeriesLine."Last No. Used")
                    ELSE
                        DocNO := INCSTR(NoSeriesLine."Starting No.");

                GenJournalLine.INIT();
                GenJournalLine.VALIDATE("Journal Template Name", TemplateName);
                GenJournalLine.VALIDATE("Journal Batch Name", BatchName);
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.VALIDATE("Posting Date", PostingDate);
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                GenJournalLine.VALIDATE("Document No.", DocNO);
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                GenJournalLine.VALIDATE("Account No.", CustRec."No.");
                GenJournalLine.VALIDATE(Amount, FineAmount1);
                GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Bal. Account No.", FeeCourseHeadCS."G/L Account for fine");
                GenJournalLine.VALIDATE("Fee Code", 'LF');
                GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", CustRec."Global Dimension 1 Code");
                GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", CustRec."Global Dimension 2 Code");
                GenJournalLine.VALIDATE(Course, CustRec."Course Code");
                GenJournalLine.Description := 'Late Fees';
                GenJournalLine.VALIDATE("Academic Year", CustRec."Academic Year");
                GenJournalLine.VALIDATE(Semester, CustRec.Semester);
                GenJournalLine.VALIDATE("Currency Code");
                GenJournalLine.VALIDATE("Source Code", 'LATE FEES');
                GenJournalLine.VALIDATE("Source Code");
                GenJournalLine.INSERT();

                NoSeriesLine.Reset();
                NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", FeeSetupCS."Fee Invoice No.");
                IF NoSeriesLine.FINDFIRST() THEN BEGIN
                    NoSeriesLine."Last No. Used" := DocNO;
                    NoSeriesLine.Modify();
                END;

                MESSAGE('Late Fine is Calucated please check General Journal(FEE GENER) for it !!');
            END ELSE
                MESSAGE('Late Fine not Applicable !!');

        END ELSE BEGIN
            FeeCourseHeadCS.Reset();
            FeeCourseHeadCS.SETRANGE("Course Code", CustRec."Course Code");
            FeeCourseHeadCS.SETRANGE(Year, CustRec.Year);
            FeeCourseHeadCS.SETRANGE("Academic Year", CustRec."Academic Year");
            FeeCourseHeadCS.SETRANGE("Admitted Year", CustRec."Admitted Year");
            FeeCourseHeadCS.SETRANGE("Fee Classification Code", CustRec."Fee Classification Code");
            FeeCourseHeadCS.SETRANGE("Global Dimension 1 Code", CustRec."Global Dimension 1 Code");
            IF FeeCourseHeadCS.FINDFIRST() THEN
                IF FeeCourseHeadCS."Late Fine %" = 0 THEN
                    ERROR('Late Fine % does not have value to calculate the fine !!');
            FeeCourseLineCS.Reset();
            FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
            IF FeeCourseLineCS.FINDFIRST() THEN
                EducationCalendarCS.Reset();
            EducationCalendarCS.SETRANGE(Code, 'FEE PAYMENT');
            EducationCalendarCS.SETRANGE("Academic Year", CustRec."Academic Year");
            IF EducationCalendarCS.FINDFIRST() THEN
                EducationMultiEventCalCS.Reset();
            EducationMultiEventCalCS.SETRANGE(Code, EducationCalendarCS.Code);
            EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
            IF EducationMultiEventCalCS.FINDFIRST() THEN
                IF (PostingDate > EducationMultiEventCalCS."End Date") AND (PDate < EducationMultiEventCalCS."End Date") THEN BEGIN
                    NooFDays := (PostingDate - EducationMultiEventCalCS."End Date");
                    FineAmount := ((NooFDays - 1) * FeeCourseHeadCS."Late Fine %" * RemainingAmt) / (365 * 100);
                END ELSE
                    IF PostingDate > EducationMultiEventCalCS."End Date" THEN BEGIN
                        NooFDays := (PostingDate - PDate);
                        FineAmount := ((NooFDays - 1) * FeeCourseHeadCS."Late Fine %" * RemainingAmt) / (365 * 100);
                    END;
            IF FineAmount <> 0 THEN BEGIN
                GenJournalLine1.Reset();
                GenJournalLine1.SETRANGE("Journal Template Name", TemplateName);
                GenJournalLine1.SETRANGE("Journal Batch Name", BatchName);
                IF GenJournalLine1.FINDLAST() THEN
                    LineNo := GenJournalLine1."Line No." + 10000
                ELSE
                    LineNo := 10000;
                NoSeriesLine.Reset();
                NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", FeeSetupCS."Fee Invoice No.");
                IF NoSeriesLine.FINDFIRST() THEN
                    IF NoSeriesLine."Last No. Used" <> '' THEN
                        DocNO := INCSTR(NoSeriesLine."Last No. Used")
                    ELSE
                        DocNO := INCSTR(NoSeriesLine."Starting No.");

                GenJournalLine.INIT();
                GenJournalLine.VALIDATE("Journal Template Name", TemplateName);
                GenJournalLine.VALIDATE("Journal Batch Name", BatchName);
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.VALIDATE("Posting Date", PostingDate);
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                GenJournalLine.VALIDATE("Document No.", DocNO);
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                GenJournalLine.VALIDATE("Account No.", CustRec."No.");
                GenJournalLine.VALIDATE(Amount, FineAmount);
                GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Bal. Account No.", FeeCourseHeadCS."G/L Account for fine");
                GenJournalLine.VALIDATE("Fee Code", 'LF');
                GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", CustRec."Global Dimension 1 Code");
                GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", CustRec."Global Dimension 2 Code");
                GenJournalLine.VALIDATE(Course, CustRec."Course Code");
                GenJournalLine.VALIDATE("Academic Year", CustRec."Academic Year");
                GenJournalLine.Description := 'Late Fees';
                GenJournalLine.VALIDATE(Semester, CustRec.Semester);
                GenJournalLine.VALIDATE("Currency Code");
                GenJournalLine.VALIDATE("Source Code", 'LATE FEES');
                GenJournalLine.VALIDATE("Source Code");
                GenJournalLine.INSERT();

                NoSeriesLine.Reset();
                NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", FeeSetupCS."Fee Invoice No.");
                IF NoSeriesLine.FINDFIRST() THEN BEGIN
                    NoSeriesLine."Last No. Used" := DocNO;
                    NoSeriesLine.Modify();
                END;
                MESSAGE('Late Fine is Calucated please check General Journal(FEE GENER) for it !!');
            END ELSE
                MESSAGE('Late Fine not Applicable !!');
        END;
        //Code Added for Fine Generation Process::CSPL-00067::210219:End
    end;

    procedure ScholarshipGenration1stYearCS(CustNo: Code[20])
    var
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        GenJournalLine: Record "Gen. Journal Line";
        FeeSetupCS: Record "Fee Setup-CS";
        CLE: Record "Cust. Ledger Entry";
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        ScholarshipLineCS: Record "Scholarship Line-CS";
        StudRankHeaderCS: Record "Stud. Rank Header-CS";
        StudRankLineCS: Record "Stud. Rank Line-CS";

        ScholarshipHeaderCS1: Record "Scholarship Header-CS";
        ScholarshipLineCS1: Record "Scholarship Line-CS";
        ScholarshipHeaderCS2: Record "Scholarship Header-CS";
        ScholarshipLineCS2: Record "Scholarship Line-CS";
        ScholarshipHeaderCS3: Record "Scholarship Header-CS";
        ScholarshipLineCS3: Record "Scholarship Line-CS";
        ScholarshipHeaderCS4: Record "Scholarship Header-CS";
        ScholarshipLineCS4: Record "Scholarship Line-CS";
        Customer: Record "Customer";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        DisAmount: Decimal;
        ParentAmount: Decimal;
        CourseAmount: Decimal;
        DiscountAmount: Decimal;

    begin
        //Code Added for Scholarship Genration 1st Year::CSPL-00067::210219:Start
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD(FeeSetupCS."Journal Template Name");
        FeeSetupCS.TESTFIELD(FeeSetupCS."Journal Batch Name");
        Customer.GET(CustNo);

        IF (Customer.Year = '1ST') OR ((Customer."Lateral Student" = TRUE) AND (Customer.Year = '2ND')) THEN BEGIN
            CLE.Reset();
            CLE.SETRANGE(CLE."Customer No.", Customer."No.");
            CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::Invoice);
            CLE.SETRANGE(CLE."Academic Year", Customer."Academic Year");
            CLE.SETRANGE(CLE.Year, Customer.Year);
            CLE.SETRANGE(CLE."Reversal New", FALSE);
            IF NOT CLE.FINDFIRST() THEN
                ERROR('Fee Not Genrated !!')
            ELSE BEGIN
                CLE.Reset();
                CLE.SETRANGE(CLE."Customer No.", Customer."No.");
                CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
                CLE.SETRANGE(CLE."Academic Year", Customer."Academic Year");
                CLE.SETRANGE(CLE.Year, Customer.Year);
                CLE.SETRANGE("Source Code", 'SCHOLAR');
                CLE.SETRANGE(CLE."Reversal New", FALSE);
                IF CLE.FINDFIRST() THEN
                    ERROR('Scholarship Already Posted !!')
                ELSE BEGIN
                    GenJournalLine.Reset();
                    GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::"Credit Memo");
                    GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.SETRANGE("Bal. Account No.", Customer."No.");
                    IF GenJournalLine.FINDFIRST() THEN
                        ERROR('Scholarship Already Generated !!')
                    ELSE
                        IF Customer."Check Manually" = FALSE THEN BEGIN
                            FeeCourseHeadCS.Reset();
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", Customer."Course Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Fee Classification Code", Customer."Fee Classification Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 2 Code", Customer."Global Dimension 2 Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Academic Year", Customer."Academic Year");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", Customer."Admitted Year");
                            FeeCourseHeadCS.SETRANGE(Year, Customer.Year);
                            FeeCourseHeadCS.SETRANGE("Other Fees", FALSE);
                            IF FeeCourseHeadCS.FINDFIRST() THEN BEGIN
                                FeeCourseLineCS.Reset();
                                FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                                FeeCourseLineCS.SETRANGE("Fee Code", 'TF_GEN');
                                IF FeeCourseLineCS.FINDFIRST() THEN BEGIN
                                    IF (Customer.Category = 'SG') OR (Customer.Category = 'TMAG') OR (Customer.Category = 'BLAT') OR
                                       (Customer.Category = 'INSUB') THEN BEGIN
                                        ScholarshipHeaderCS.Reset();
                                        ScholarshipHeaderCS.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                        ScholarshipHeaderCS.SETRANGE("Scholarship Code", Customer.Category);
                                        ScholarshipHeaderCS.SETRANGE("Source Code", Customer."Scholarship Source");
                                        ScholarshipHeaderCS.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                        ScholarshipHeaderCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                                        ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                        IF ScholarshipHeaderCS.FINDFIRST() THEN BEGIN
                                            ScholarshipLineCS.Reset();
                                            ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                                            ScholarshipLineCS.SETRANGE("Scholarship Code", ScholarshipHeaderCS."Scholarship Code");
                                            ScholarshipLineCS.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                                            ScholarshipLineCS.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                                            IF ScholarshipLineCS.FINDFIRST() THEN
                                                IF (ScholarshipLineCS."Percentage To Pay" <> 0) OR ((Customer.Category = 'SFC') AND (Customer."Certification Course" = TRUE)) THEN BEGIN
                                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                    ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS."Percentage To Pay";
                                                    CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS."Percentage To Pay";
                                                    IF ParentAmount > CourseAmount THEN BEGIN
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") -
                                                                     (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Percentage To Pay");
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");

                                                    END ELSE
                                                        IF CourseAmount > ParentAmount THEN BEGIN
                                                            DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") -
                                                                         (Customer."Parents Income" / 100) * (ScholarshipLineCS."Percentage To Pay");
                                                            IF DisAmount <> 0 THEN
                                                                ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                                        END;
                                                END ELSE
                                                    IF ScholarshipLineCS."Amount To Pay" <> 0 THEN BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DiscountAmount := FeeCourseHeadCS."Total Amount" - (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %");
                                                        IF DiscountAmount > ScholarshipLineCS."Amount To Pay" THEN
                                                            DisAmount := FeeCourseHeadCS."Total Amount" - DiscountAmount
                                                        ELSE
                                                            IF DiscountAmount < ScholarshipLineCS."Amount To Pay" THEN
                                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") - ScholarshipLineCS."Amount To Pay";
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                                    END ELSE BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") - ScholarshipLineCS."Amount To Pay";
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                                    END;

                                        END;
                                    END ELSE
                                        IF Customer.Category = 'MCM' THEN BEGIN
                                            StudRankHeaderCS.Reset();
                                            StudRankHeaderCS.SETCURRENTKEY("Source Code", "Fee Classification Code", "Admitted Year");
                                            StudRankHeaderCS.SETRANGE("Source Code", Customer."Scholarship Source");
                                            StudRankHeaderCS.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                            StudRankHeaderCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                                            StudRankHeaderCS.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                            IF StudRankHeaderCS.FINDFIRST() THEN BEGIN
                                                StudRankLineCS.Reset();
                                                StudRankLineCS.SETRANGE("Document No.", StudRankHeaderCS."No.");
                                                StudRankLineCS.SETRANGE("Scholarship Code", StudRankHeaderCS."Scholarship Code");
                                                StudRankLineCS.SETFILTER("Min Rank", '<=%1', Customer."Entrance Test Rank");
                                                StudRankLineCS.SETFILTER("Max Rank", '>=%1', Customer."Entrance Test Rank");
                                                IF StudRankLineCS.FINDFIRST() THEN
                                                    IF StudRankLineCS."Discount %" <> 0 THEN BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (StudRankLineCS."Discount %");
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, StudRankHeaderCS."G/L Account No.");
                                                    END
                                                    ELSE BEGIN
                                                        ScholarshipHeaderCS1.Reset();
                                                        ScholarshipHeaderCS1.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                                        ScholarshipHeaderCS1.SETRANGE("Scholarship Code", Customer.Category);
                                                        ScholarshipHeaderCS1.SETRANGE("Source Code", Customer."Scholarship Source");
                                                        ScholarshipHeaderCS1.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                                        ScholarshipHeaderCS1.SETRANGE("Admitted Year", Customer."Admitted Year");
                                                        ScholarshipHeaderCS1.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                                        IF ScholarshipHeaderCS1.FINDFIRST() THEN BEGIN
                                                            ScholarshipLineCS1.Reset();
                                                            ScholarshipLineCS1.SETRANGE(ScholarshipLineCS1."Document No.", ScholarshipHeaderCS1."No.");
                                                            ScholarshipLineCS1.SETRANGE("Scholarship Code", ScholarshipHeaderCS1."Scholarship Code");
                                                            ScholarshipLineCS1.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                                                            ScholarshipLineCS1.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                                                            IF ScholarshipLineCS1.FINDFIRST() THEN BEGIN
                                                                IF ScholarshipLineCS1."Percentage To Pay" <> 0 THEN
                                                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS1."Percentage To Pay";
                                                                CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS1."Percentage To Pay";
                                                                IF ParentAmount > CourseAmount THEN BEGIN
                                                                    DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Discount %") -
                                                                                 (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Percentage To Pay");
                                                                    IF DisAmount <> 0 THEN
                                                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS1."G/L Account No.");

                                                                END ELSE
                                                                    IF CourseAmount > ParentAmount THEN BEGIN
                                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Discount %") -
                                                                                     (Customer."Parents Income" / 100) * (ScholarshipLineCS1."Percentage To Pay");
                                                                        IF DisAmount <> 0 THEN
                                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS1."G/L Account No.");
                                                                    END;

                                                            END ELSE BEGIN
                                                                FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Discount %") - ScholarshipLineCS1."Amount To Pay";
                                                                IF DisAmount <> 0 THEN
                                                                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS1."G/L Account No.");
                                                            END;
                                                        END;
                                                    END;
                                            END;
                                        END;
                                    // END;


                                END ELSE
                                    IF (Customer.Category = 'KONKANI') OR (Customer.Category = 'AGE') THEN BEGIN
                                        ScholarshipHeaderCS2.Reset();
                                        ScholarshipHeaderCS2.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                        ScholarshipHeaderCS2.SETRANGE("Scholarship Code", Customer.Category);
                                        ScholarshipHeaderCS2.SETRANGE("Source Code", Customer."Scholarship Source");
                                        ScholarshipHeaderCS2.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                        ScholarshipHeaderCS2.SETRANGE("Admitted Year", Customer."Admitted Year");
                                        ScholarshipHeaderCS2.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                        IF ScholarshipHeaderCS2.FINDFIRST() THEN BEGIN
                                            ScholarshipLineCS2.Reset();
                                            ScholarshipLineCS2.SETRANGE(ScholarshipLineCS2."Document No.", ScholarshipHeaderCS2."No.");
                                            ScholarshipLineCS2.SETRANGE("Scholarship Code", ScholarshipHeaderCS2."Scholarship Code");
                                            IF ScholarshipLineCS2.FINDFIRST() THEN BEGIN
                                                FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS2."Discount %");
                                                IF DisAmount <> 0 THEN
                                                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS2."G/L Account No.");
                                            END;
                                        END;

                                    END ELSE
                                        IF Customer.Category = 'AI' THEN BEGIN
                                            ScholarshipHeaderCS3.Reset();
                                            ScholarshipHeaderCS3.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                            ScholarshipHeaderCS3.SETRANGE("Scholarship Code", Customer.Category);
                                            ScholarshipHeaderCS3.SETRANGE("Source Code", Customer."Scholarship Source");
                                            ScholarshipHeaderCS3.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                            ScholarshipHeaderCS3.SETRANGE("Admitted Year", Customer."Admitted Year");
                                            ScholarshipHeaderCS3.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                            IF ScholarshipHeaderCS3.FINDFIRST() THEN BEGIN
                                                ScholarshipLineCS3.Reset();
                                                ScholarshipLineCS3.SETRANGE(ScholarshipLineCS3."Document No.", ScholarshipHeaderCS3."No.");
                                                ScholarshipLineCS3.SETRANGE("Scholarship Code", ScholarshipHeaderCS3."Scholarship Code");
                                                IF ScholarshipLineCS3.FINDFIRST() THEN
                                                    IF Customer."Parents Income" < ScholarshipLineCS3."Max Parent Income" THEN
                                                        DisAmount := (FeeCourseLineCS.Amount / 100) * (ScholarshipLineCS3."Discount %");
                                                IF DisAmount <> 0 THEN
                                                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS3."G/L Account No.");
                                            END;

                                        END ELSE
                                            IF Customer.Category = 'SFC' THEN BEGIN
                                                ScholarshipHeaderCS4.Reset();
                                                ScholarshipHeaderCS4.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                                ScholarshipHeaderCS4.SETRANGE("Scholarship Code", Customer.Category);
                                                ScholarshipHeaderCS4.SETRANGE("Source Code", Customer."Scholarship Source");
                                                ScholarshipHeaderCS4.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                                ScholarshipHeaderCS4.SETRANGE("Admitted Year", Customer."Admitted Year");
                                                ScholarshipHeaderCS4.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                                IF ScholarshipHeaderCS4.FINDFIRST() THEN BEGIN
                                                    ScholarshipLineCS4.Reset();
                                                    ScholarshipLineCS4.SETRANGE(ScholarshipLineCS4."Document No.", ScholarshipHeaderCS4."No.");
                                                    ScholarshipLineCS4.SETRANGE("Scholarship Code", ScholarshipHeaderCS4."Scholarship Code");
                                                    ScholarshipLineCS4.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                                                    ScholarshipLineCS4.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                                                    IF ScholarshipLineCS4.FINDFIRST() THEN
                                                        IF (Customer."Certification Course" = TRUE) THEN BEGIN
                                                            FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                            ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS4."Percentage To Pay";
                                                            CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS4."Percentage To Pay";
                                                            IF ParentAmount > CourseAmount THEN BEGIN
                                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") -
                                                                             (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Percentage To Pay");
                                                                IF DisAmount <> 0 THEN
                                                                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");

                                                            END ELSE
                                                                IF CourseAmount > ParentAmount THEN BEGIN
                                                                    DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") -
                                                                                 (Customer."Parents Income" / 100) * (ScholarshipLineCS4."Percentage To Pay");
                                                                    IF DisAmount <> 0 THEN
                                                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");
                                                                END;

                                                        END ELSE
                                                            IF ScholarshipLineCS4."Amount To Pay" <> 0 THEN BEGIN
                                                                FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                DiscountAmount := FeeCourseHeadCS."Total Amount" - (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %");
                                                                IF DiscountAmount > ScholarshipLineCS4."Amount To Pay" THEN
                                                                    DisAmount := FeeCourseHeadCS."Total Amount" - DiscountAmount
                                                                ELSE
                                                                    IF DiscountAmount < ScholarshipLineCS4."Amount To Pay" THEN
                                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") - ScholarshipLineCS4."Amount To Pay";
                                                                IF DisAmount <> 0 THEN
                                                                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");
                                                            END ELSE BEGIN
                                                                FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") - ScholarshipLineCS4."Amount To Pay";
                                                                IF DisAmount <> 0 THEN
                                                                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");
                                                            END;




                                                END;
                                            END;
                            END;

                        END;

                END;
            END;
        END;
    END;
    //Code Added for Scholarship Genration 1st Year::CSPL-00067::210219:End


    procedure ScholarshipGenrationRestYearsCS(CustNo: Code[20])
    var
        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";



        GenJournalLine: Record "Gen. Journal Line";
        FeeSetupCS: Record "Fee Setup-CS";
        CLE: Record "Cust. Ledger Entry";
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        ScholarshipLineCS: Record "Scholarship Line-CS";
        StudRankHeaderCS: Record "Stud. Rank Header-CS";
        StudRankLineCS: Record "Stud. Rank Line-CS";
        ScholarshipHeaderCS1: Record "Scholarship Header-CS";
        ScholarshipLineCS1: Record "Scholarship Line-CS";
        ScholarshipHeaderCS2: Record "Scholarship Header-CS";
        ScholarshipLineCS2: Record "Scholarship Line-CS";
        ScholarshipHeaderCS3: Record "Scholarship Header-CS";
        ScholarshipLineCS3: Record "Scholarship Line-CS";
        ScholarshipHeaderCS4: Record "Scholarship Header-CS";
        ScholarshipLineCS4: Record "Scholarship Line-CS";
        Customer: Record "Customer";
        StudentMasterCS: Record "Student Master-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        DisAmount: Decimal;
        ParentAmount: Decimal;
        DiscountAmount: Decimal;
        CourseAmount: Decimal;
    begin
        //Code Added for Scholar ship Genration Rest Years::CSPL-00067::210219:Start
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD(FeeSetupCS."Journal Template Name");
        FeeSetupCS.TESTFIELD(FeeSetupCS."Journal Batch Name");
        Customer.GET(CustNo);

        StudentMasterCS.GET(CustNo);


        CLE.Reset();
        CLE.SETRANGE(CLE."Customer No.", Customer."No.");
        CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::Invoice);
        CLE.SETRANGE(Description, 'COURSE FEES');
        CLE.SETRANGE(CLE."Academic Year", Customer."Academic Year");
        CLE.SETRANGE(CLE.Year, Customer.Year);
        CLE.SETRANGE(CLE."Reversal New", FALSE);
        IF NOT CLE.FINDFIRST() THEN
            ERROR('Fee Not Genrated !!')
        ELSE BEGIN
            CLE.Reset();
            CLE.SETRANGE(CLE."Customer No.", Customer."No.");
            CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
            CLE.SETRANGE(CLE."Academic Year", Customer."Academic Year");
            CLE.SETRANGE("Source Code", 'SCHOLAR');
            CLE.SETRANGE(CLE.Year, Customer.Year);
            CLE.SETRANGE(CLE."Reversal New", FALSE);
            IF CLE.FINDFIRST() THEN
                ERROR('Scholarship Already Posted !!')
            ELSE BEGIN
                GenJournalLine.Reset();
                GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::"Credit Memo");
                GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.SETRANGE("Bal. Account No.", Customer."No.");
                IF GenJournalLine.FINDFIRST() THEN
                    ERROR('Scholarship Already Generated !!')
                ELSE BEGIN
                    IF Customer.Year <> '1ST' THEN BEGIN
                        IF Customer."Check Manually" = FALSE THEN BEGIN
                            FeeCourseHeadCS.Reset();
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", Customer."Course Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Fee Classification Code", Customer."Fee Classification Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 2 Code", Customer."Global Dimension 2 Code");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Academic Year", Customer."Academic Year");
                            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", Customer."Admitted Year");
                            FeeCourseHeadCS.SETRANGE(Year, Customer.Year);
                            FeeCourseHeadCS.SETRANGE("Other Fees", FALSE);
                            IF FeeCourseHeadCS.FINDFIRST() THEN BEGIN
                                FeeCourseLineCS.Reset();
                                FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                                FeeCourseLineCS.SETRANGE("Fee Code", 'TF_GEN');
                                IF FeeCourseLineCS.FINDFIRST() THEN BEGIN
                                    IF (Customer.Category = 'SG') OR (Customer.Category = 'TMAG') OR (Customer.Category = 'BLAT') OR
                                       (Customer.Category = 'INSUB') THEN BEGIN
                                        ScholarshipHeaderCS.Reset();
                                        ScholarshipHeaderCS.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                        ScholarshipHeaderCS.SETRANGE("Scholarship Code", Customer.Category);
                                        ScholarshipHeaderCS.SETRANGE("Source Code", Customer."Scholarship Source");
                                        ScholarshipHeaderCS.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                        ScholarshipHeaderCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                                        ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                        IF ScholarshipHeaderCS.FINDFIRST() THEN BEGIN
                                            ScholarshipLineCS.Reset();
                                            ScholarshipLineCS.SETRANGE(ScholarshipLineCS."Document No.", ScholarshipHeaderCS."No.");
                                            ScholarshipLineCS.SETRANGE("Scholarship Code", ScholarshipHeaderCS."Scholarship Code");
                                            ScholarshipLineCS.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                                            ScholarshipLineCS.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                                            IF ScholarshipLineCS.FINDFIRST() THEN BEGIN
                                                IF (ScholarshipLineCS."Percentage To Pay" <> 0) OR ((Customer.Category = 'SFC') AND (Customer."Certification Course" = TRUE)) THEN BEGIN
                                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                    ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS."Percentage To Pay";
                                                    CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS."Percentage To Pay";
                                                    IF ParentAmount > CourseAmount THEN BEGIN
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") -
                                                                     (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Percentage To Pay");
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");

                                                    END ELSE
                                                        IF CourseAmount > ParentAmount THEN BEGIN
                                                            DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") -
                                                                         (Customer."Parents Income" / 100) * (ScholarshipLineCS."Percentage To Pay");
                                                            IF DisAmount <> 0 THEN
                                                                ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                                        END;

                                                END ELSE BEGIN
                                                    IF ScholarshipLineCS."Amount To Pay" <> 0 THEN BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DiscountAmount := FeeCourseHeadCS."Total Amount" - (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %");
                                                        IF DiscountAmount > ScholarshipLineCS."Amount To Pay" THEN
                                                            DisAmount := FeeCourseHeadCS."Total Amount" - DiscountAmount
                                                        ELSE
                                                            IF DiscountAmount < ScholarshipLineCS."Amount To Pay" THEN
                                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") - ScholarshipLineCS."Amount To Pay";
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                                    END ELSE BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS."Discount %") - ScholarshipLineCS."Amount To Pay";
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS."G/L Account No.");
                                                    END;
                                                END;

                                            END;
                                        END;
                                    END ELSE
                                        IF Customer.Category = 'MCM' THEN BEGIN
                                            StudRankHeaderCS.Reset();
                                            StudRankHeaderCS.SETCURRENTKEY("Source Code", "Fee Classification Code", "Admitted Year");
                                            StudRankHeaderCS.SETRANGE("Source Code", Customer."Scholarship Source");
                                            StudRankHeaderCS.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                            StudRankHeaderCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                                            StudRankHeaderCS.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                            IF StudRankHeaderCS.FINDFIRST() THEN BEGIN
                                                StudRankLineCS.Reset();
                                                StudRankLineCS.SETRANGE("Document No.", StudRankHeaderCS."No.");
                                                StudRankLineCS.SETRANGE("Scholarship Code", StudRankHeaderCS."Scholarship Code");
                                                StudRankLineCS.SETFILTER("Min Rank", '<=%1', Customer."Entrance Test Rank");
                                                StudRankLineCS.SETFILTER("Max Rank", '>=%1', Customer."Entrance Test Rank");
                                                IF StudRankLineCS.FINDFIRST() THEN BEGIN
                                                    IF StudRankLineCS."Discount %" <> 0 THEN BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (StudRankLineCS."Discount %");
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, StudRankHeaderCS."G/L Account No.");
                                                    END
                                                    ELSE BEGIN
                                                        ScholarshipHeaderCS1.Reset();
                                                        ScholarshipHeaderCS1.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                                        ScholarshipHeaderCS1.SETRANGE("Scholarship Code", Customer.Category);
                                                        ScholarshipHeaderCS1.SETRANGE("Source Code", Customer."Scholarship Source");
                                                        ScholarshipHeaderCS1.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                                        ScholarshipHeaderCS1.SETRANGE("Admitted Year", Customer."Admitted Year");
                                                        ScholarshipHeaderCS1.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                                        IF ScholarshipHeaderCS1.FINDFIRST() THEN BEGIN
                                                            ScholarshipLineCS1.Reset();
                                                            ScholarshipLineCS1.SETRANGE(ScholarshipLineCS1."Document No.", ScholarshipHeaderCS1."No.");
                                                            ScholarshipLineCS1.SETRANGE("Scholarship Code", ScholarshipHeaderCS1."Scholarship Code");
                                                            ScholarshipLineCS1.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                                                            ScholarshipLineCS1.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                                                            IF ScholarshipLineCS1.FINDFIRST() THEN BEGIN
                                                                IF ScholarshipLineCS1."Percentage To Pay" <> 0 THEN BEGIN
                                                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                    ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS1."Percentage To Pay";
                                                                    CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS1."Percentage To Pay";
                                                                    IF ParentAmount > CourseAmount THEN BEGIN
                                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Discount %") -
                                                                                     (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Percentage To Pay");
                                                                        IF DisAmount <> 0 THEN
                                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS1."G/L Account No.");

                                                                    END ELSE
                                                                        IF CourseAmount > ParentAmount THEN BEGIN
                                                                            DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Discount %") -
                                                                                         (Customer."Parents Income" / 100) * (ScholarshipLineCS1."Percentage To Pay");
                                                                            IF DisAmount <> 0 THEN
                                                                                ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS1."G/L Account No.");
                                                                        END;

                                                                END ELSE BEGIN
                                                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                    DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS1."Discount %") - ScholarshipLineCS1."Amount To Pay";
                                                                    IF DisAmount <> 0 THEN
                                                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS1."G/L Account No.");
                                                                END;
                                                            END;
                                                        END;
                                                    END;
                                                END;
                                            END;


                                        END ELSE
                                            IF (Customer.Category = 'KONKANI') OR (Customer.Category = 'AGE') THEN BEGIN
                                                ScholarshipHeaderCS2.Reset();
                                                ScholarshipHeaderCS2.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                                ScholarshipHeaderCS2.SETRANGE("Scholarship Code", Customer.Category);
                                                ScholarshipHeaderCS2.SETRANGE("Source Code", Customer."Scholarship Source");
                                                ScholarshipHeaderCS2.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                                ScholarshipHeaderCS2.SETRANGE("Admitted Year", Customer."Admitted Year");
                                                ScholarshipHeaderCS2.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                                IF ScholarshipHeaderCS2.FINDFIRST() THEN BEGIN
                                                    ScholarshipLineCS2.Reset();
                                                    ScholarshipLineCS2.SETRANGE(ScholarshipLineCS2."Document No.", ScholarshipHeaderCS2."No.");
                                                    ScholarshipLineCS2.SETRANGE("Scholarship Code", ScholarshipHeaderCS2."Scholarship Code");
                                                    IF ScholarshipLineCS2.FINDFIRST() THEN BEGIN
                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS2."Discount %");
                                                        IF DisAmount <> 0 THEN
                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS2."G/L Account No.");
                                                    END;
                                                END;

                                            END ELSE
                                                IF Customer.Category = 'AI' THEN BEGIN
                                                    IF Customer."Branch Transfer" = FALSE THEN BEGIN
                                                        ScholarshipHeaderCS3.Reset();
                                                        ScholarshipHeaderCS3.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                                        ScholarshipHeaderCS3.SETRANGE("Scholarship Code", Customer.Category);
                                                        ScholarshipHeaderCS3.SETRANGE("Source Code", Customer."Scholarship Source");
                                                        ScholarshipHeaderCS3.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                                        ScholarshipHeaderCS3.SETRANGE("Admitted Year", Customer."Admitted Year");
                                                        ScholarshipHeaderCS3.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                                        IF ScholarshipHeaderCS3.FINDFIRST() THEN BEGIN
                                                            ScholarshipLineCS3.Reset();
                                                            ScholarshipLineCS3.SETRANGE(ScholarshipLineCS3."Document No.", ScholarshipHeaderCS3."No.");
                                                            ScholarshipLineCS3.SETRANGE("Scholarship Code", ScholarshipHeaderCS3."Scholarship Code");
                                                            IF ScholarshipLineCS3.FINDFIRST() THEN BEGIN
                                                                IF Customer."Parents Income" < ScholarshipLineCS3."Max Parent Income" THEN BEGIN
                                                                    DisAmount := (FeeCourseLineCS.Amount / 100) * (ScholarshipLineCS3."Discount %");
                                                                    IF DisAmount <> 0 THEN
                                                                        ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS3."G/L Account No.");
                                                                END;
                                                            END;
                                                        END;
                                                    END;



                                                END ELSE
                                                    IF Customer.Category = 'SFC' THEN BEGIN
                                                        ScholarshipHeaderCS4.Reset();
                                                        ScholarshipHeaderCS4.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                                                        ScholarshipHeaderCS4.SETRANGE("Scholarship Code", Customer.Category);
                                                        ScholarshipHeaderCS4.SETRANGE("Source Code", Customer."Scholarship Source");
                                                        ScholarshipHeaderCS4.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                                                        ScholarshipHeaderCS4.SETRANGE("Admitted Year", Customer."Admitted Year");
                                                        ScholarshipHeaderCS4.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                                                        IF ScholarshipHeaderCS4.FINDFIRST() THEN BEGIN
                                                            ScholarshipLineCS4.Reset();
                                                            ScholarshipLineCS4.SETRANGE(ScholarshipLineCS4."Document No.", ScholarshipHeaderCS4."No.");
                                                            ScholarshipLineCS4.SETRANGE("Scholarship Code", ScholarshipHeaderCS4."Scholarship Code");
                                                            ScholarshipLineCS4.SETFILTER("Min Parent Income", '<=%1', Customer."Parents Income");
                                                            ScholarshipLineCS4.SETFILTER("Max Parent Income", '>=%1', Customer."Parents Income");
                                                            IF ScholarshipLineCS4.FINDFIRST() THEN BEGIN
                                                                IF (Customer."Certification Course" = TRUE) THEN BEGIN
                                                                    FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                    ParentAmount := (Customer."Parents Income" / 100) * ScholarshipLineCS4."Percentage To Pay";
                                                                    CourseAmount := (FeeCourseHeadCS."Total Amount" / 100) * ScholarshipLineCS4."Percentage To Pay";
                                                                    IF ParentAmount > CourseAmount THEN BEGIN
                                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") -
                                                                                     (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Percentage To Pay");
                                                                        IF DisAmount <> 0 THEN
                                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");

                                                                    END ELSE
                                                                        IF CourseAmount > ParentAmount THEN BEGIN
                                                                            DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") -
                                                                                         (Customer."Parents Income" / 100) * (ScholarshipLineCS4."Percentage To Pay");
                                                                            IF DisAmount <> 0 THEN
                                                                                ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");
                                                                        END;

                                                                END ELSE BEGIN
                                                                    IF ScholarshipLineCS4."Amount To Pay" <> 0 THEN BEGIN
                                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                        DiscountAmount := FeeCourseHeadCS."Total Amount" - (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %");
                                                                        IF DiscountAmount > ScholarshipLineCS4."Amount To Pay" THEN
                                                                            DisAmount := FeeCourseHeadCS."Total Amount" - DiscountAmount
                                                                        ELSE
                                                                            IF DiscountAmount < ScholarshipLineCS4."Amount To Pay" THEN
                                                                                DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") - ScholarshipLineCS4."Amount To Pay";
                                                                        IF DisAmount <> 0 THEN
                                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");
                                                                    END ELSE BEGIN
                                                                        FeeCourseHeadCS.CALCFIELDS(FeeCourseHeadCS."Total Amount");
                                                                        DisAmount := (FeeCourseHeadCS."Total Amount" / 100) * (ScholarshipLineCS4."Discount %") - ScholarshipLineCS4."Amount To Pay";
                                                                        IF DisAmount <> 0 THEN
                                                                            ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", DisAmount, ScholarshipHeaderCS4."G/L Account No.");
                                                                    END;
                                                                END;
                                                            END;


                                                        END;
                                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
            END;
        END;
        //Code Added for Scholar ship Genration Rest Years::CSPL-00067::210219:End
    end;

    procedure OtherFeeGenerationCS(StudNo: Code[20]; Amount: Decimal; FeeType: Code[50])
    var
        FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";

        // GenJournalBatch: Record "Gen. Journal Batch";
        // Genjourrec: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        //StudentMasterCS: Record "Student Master-CS";
        Customer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
    //CheckBool: Boolean;
    // LineNo: Integer;
    // "TempDocNo.1": Code[20];

    begin
        //Code Added for Other Fee Generation::CSPL-00067::210219:Start
        Customer.GET(StudNo);

        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");

        FeeComponentMasterCS.GET(FeeType);

        "TempDocNo." := NoSeries.GetNextNo(FeeSetupCS."Other Fee No.", 0D, TRUE);

        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Bal. Account No.", FeeComponentMasterCS."G/L Account");
        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Fee Code", FeeType);
        GenJournalLine.VALIDATE("Currency Code", Customer."Currency Code");
        GenJournalLine.VALIDATE("Source Code", 'OTHER FEES');
        GenJournalLine.INSERT(TRUE);
        //Code Added for Other Fee Generation::CSPL-00067::210219:End
    end;

    procedure CustomerCautionInsertCS(StudNo: Code[20]; FeeCode1: Code[20]; Amount: Decimal; Customer: Record "Customer"; YearPart: Option " ","1st","2nd"; TempDocNo: Code[20]; LateFee: Decimal; CurrencyCode: Code[10]; DueDate: Date)
    var
        FeeSetupCS: Record "Fee Setup-CS";
        GenJournalLine: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        TempDocNo1: Code[20];
    begin
        //Code Added for Customer Caution Insert::CSPL-00067::210219:Start
        CLEAR(NoSeries);
        TempDocNo1 := TempDocNo;
        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");
        FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);


        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");

        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        IF Amount > 0 THEN
            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice)
        ELSE
            IF Amount < 0 THEN
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");



        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Posting Date", WORKDATE());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Debit Amount", Amount);
        GenJournalLine.VALIDATE("Document No.", TempDocNo1);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE("Late Fee %", LateFee);
        GenJournalLine.VALIDATE("Source Code", 'COURSE FEE');
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Source Code");
        GenJournalLine.VALIDATE("Due Date", DueDate);
        GenJournalLine.INSERT(TRUE);
        //Code Added for Customer Caution Insert::CSPL-00067::210219:End
    end;
}

