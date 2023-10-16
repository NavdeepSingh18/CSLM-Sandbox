codeunit 50009 "Gen. Web  Journal -CS"
{
    // version V.001-CS

    // Sr.   NoEmp.ID   Date     Trigger                                       Remark
    // 1    CSPL-00059   19-02-19CSInsertEntry                              Code added for insert entry.
    // 2    CSPL-00059   19-02-19CSCustBankAccNo                            Code added for bank account.
    // 3    CSPL-00059   19-02-19CSGetNextNoold                            Code added for next old no.
    // 4    CSPL-00059   19-02-19CSHostalInfo                              Code added for hostal info.
    // 5    CSPL-00059   19-02-19CSInsertCustomerInvoice                    Code added for insert customer invoice.
    // 6    CSPL-00059   19-02-19CSInsertCustomerPayment                    Code added for insert customer payment
    // 7    CSPL-00059   19-02-19CSPostCustomerEntry                        Code added for Post customer entry.
    // 8    CSPL-00059   19-02-19CSLastDocumentNo                          Code added for last document no.
    // 9    CSPL-00059   19-02-19CSInsertCustomerPaymentNew                Code added for insert customer payment entry
    // 10  CSPL-00059   19-02-19CSInsertCustomerPaymentRTGS/NEFT          Code added for insert customer payment RTGS/NEFT
    // 11  CSPL-00059   19-02-19CSInsertCustomerPaymentDoc                Code added for insert customer payment document
    // 12  CSPL-00059   19-02-19CSPostCustomerEntryDocumentWise            Code added for posting customer entry
    // 13  CSPL-00059   19-02-19CSInsertCustomerInvoiceCustomerPostingDate  Code added for insert customer invoice posting date
    // 14  CSPL-00059   19-02-19CSInsertCustomerPaymentCustomerPostingDate  Code added for insert customer Payment posting date
    // 15  CSPL-00059   19-02-19OnRun()                                   Code added for posting entry


    trigger OnRun()
    begin
        //Code added for posting entry::CSPL-00059::20022019: Start
        GenJournalLine.RESET();
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'APPAY');
        IF GenJournalLine.FINDFIRST() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
        MESSAGE('Posted!!');
        //Code added for posting entry::CSPL-00059::20022019: End
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";

    procedure CSInsertEntry(TamplateName: Code[10]; BatchName: Code[10]; DocumentType: Option; AccountType: Option; AccountNo: Code[20]; BalAccountType: Option; BalAccountNo: Code[20]; Amount: Decimal; StudentNo: Code[20]; Transaction: Option; UTRNo: Code[20]; UTRDate: Date; CurrencyCode: Code[10]; CurrencyFactor: Decimal): Text
    var
        GenJournalCopyCS: Record "Gen Journal Copy-CS";
        GenJournalCopyCS1: Record "Gen Journal Copy-CS";

        GenJournalLine1: Record "Gen. Journal Line";
        CustRec: Record "Customer";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        LineNo: Integer;
        // SourceCode: Code[10];
        // SourceType: Option;
        // SourceNo: Code[10];
        //PostingNoSeries: Code[10];
        //Comment: Text;
        TempLineNo: Integer;
        NextNo: Code[20];
    begin
        //Code added for insert entry.::CSPL-00059::19022019: Start

        CustRec.GET(StudentNo);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            NextNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TODAY(), TRUE);


        GenJournalCopyCS1.RESET();
        GenJournalCopyCS1.SETRANGE("Document No.", NextNo);
        IF GenJournalCopyCS1.FINDLAST() THEN
            TempLineNo := GenJournalCopyCS1."Line No." + 10000
        ELSE
            TempLineNo := 10000;

        GenJournalCopyCS.INIT();
        GenJournalCopyCS."Document No." := NextNo;
        GenJournalCopyCS.TESTFIELD("Document No.");
        GenJournalCopyCS."Line No." := TempLineNo;
        GenJournalCopyCS."Document Type" := DocumentType;
        GenJournalCopyCS.TESTFIELD("Document Type");
        GenJournalCopyCS."Account type" := AccountType;
        GenJournalCopyCS."Account No." := AccountNo;
        GenJournalCopyCS.TESTFIELD("Account No.");
        GenJournalCopyCS."Bal. Account Type" := BalAccountType;
        GenJournalCopyCS."Bal. Account No." := BalAccountNo;

        GenJournalCopyCS.Amount := Amount;

        GenJournalCopyCS."Student No" := StudentNo;
        GenJournalCopyCS.TESTFIELD("Student No");
        GenJournalCopyCS.Transaction := Transaction;
        GenJournalCopyCS.TESTFIELD(Transaction);
        GenJournalCopyCS."Posting Date" := TODAY();
        GenJournalCopyCS.TESTFIELD("Posting Date");
        GenJournalCopyCS."UTR No." := UTRNo;
        GenJournalCopyCS."UTR Date" := UTRDate;
        IF GenJournalCopyCS.INSERT() THEN BEGIN
            GenJournalLine.INIT();
            GenJournalLine."Journal Template Name" := TamplateName;
            GenJournalLine."Journal Batch Name" := BatchName;

            LineNo := 0;
            GenJournalLine1.RESET();
            GenJournalLine1.SETRANGE(GenJournalLine1."Journal Template Name", TamplateName);
            GenJournalLine1.SETRANGE(GenJournalLine1."Journal Batch Name", BatchName);
            IF GenJournalLine1.FINDLAST() THEN
                LineNo := GenJournalLine1."Line No." + 10000
            ELSE
                LineNo := 10000;

            GenJournalLine."Line No." := LineNo;
            GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo);
            GenJournalLine.VALIDATE("Document No.", NextNo);
            GenJournalLine.VALIDATE("Document Type", DocumentType);
            GenJournalLine.VALIDATE("Account Type", AccountType);
            GenJournalLine.VALIDATE("Account No.", AccountNo);
            GenJournalLine.VALIDATE("Posting Date", TODAY());
            GenJournalLine.VALIDATE("Bal. Account Type", BalAccountType);
            GenJournalLine.VALIDATE("Bal. Account No.", BalAccountNo);
            GenJournalLine.VALIDATE(Amount, Amount);
            GenJournalLine.VALIDATE("Pmt. Discount Date", WORKDATE());
            GenJournalLine.VALIDATE("Expiration Date", WORKDATE());
            GenJournalLine.VALIDATE("Document Date", WORKDATE());
            //GenJournalLine.VALIDATE("RG/Service Tax Set Off Date", WORKDATE());
            //GenJournalLine.VALIDATE("PLA Set Off Date", WORKDATE());
            GenJournalLine.VALIDATE("Created By", UserId());
            GenJournalLine.VALIDATE(Transaction, Transaction);
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", CustRec."Global Dimension 1 Code");
            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", CustRec."Global Dimension 2 Code");
            GenJournalLine.VALIDATE("Posting Date", TODAY());
            GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
            GenJournalLine.VALIDATE(Semester, CustRec.Semester);
            GenJournalLine.VALIDATE(Year, CustRec.Year);
            IF GenJournalLine.INSERT(true) THEN BEGIN
                GenJournalCopyCS."Sync." := TRUE;
                GenJournalCopyCS.MODIFY();
            END;
        END;
        EXIT('Entry Generated !!');


        //Code added for insert entry.::CSPL-00059::19022019: End
    end;

    procedure CSCustBankAccNo(EnrollmentNo: Code[20]; var CustomerNo: Code[20]; var BankAccountNo: Code[20]) Return: Code[20]
    var
        CustRec: Record "Customer";
        //CustRec1: Record "Customer";
        FeeClassificationMasterCS: Record "Fee Classification Master-CS";
    //CustNo: Code[20];
    //BankAccNo: Code[20];

    begin
        // Code added for bank account.::CSPL-00059::19022019: Start
        CustRec.RESET();
        CustRec.SETCURRENTKEY("Enrollment No.");
        CustRec.SETRANGE("Enrollment No.", EnrollmentNo);
        IF CustRec.FINDFIRST() THEN
            CustomerNo := CustRec."No.";


        FeeClassificationMasterCS.GET(CustRec."Fee Classification Code");
        BankAccountNo := FeeClassificationMasterCS."Credit Card Bank Account No.";
        // Code added for bank account.::CSPL-00059::19022019: End
    end;

    procedure CSGetNextNoold(TamplateName: Code[10]; BatchName: Code[10]): Code[20]
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        NextNo: Code[20];
    begin
        //Code added for next old no.::CSPL-00059::19022019: Start
        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            NextNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TODAY(), FALSE);
        //Code added for next old no.::CSPL-00059::19022019: End
    end;



    procedure CSHostalInfo(StudentNo: Code[20]; HostelBlock: Text[30]; HostelRoomNo: Text[30]; HostelAllotedDate: Date; HostelVacatedDate: Date; RoomType: Text[40]) Return: Text
    var
        StudentHostelCS: Record "Student Hostel-CS";
        StudentHostelCS1: Record "Student Hostel-CS";
        StudentMasterCS: Record "Student Master-CS";
    begin
        //Code added for hostal info.::CSPL-00059::19022019: Start
        IF NOT StudentMasterCS.GET(StudentNo) THEN
            ERROR('StudentNo Is Not Registered')
        ELSE BEGIN
            StudentHostelCS1.RESET();
            StudentHostelCS1.SETRANGE("Student No.", StudentNo);
            IF NOT StudentHostelCS1.FINDFIRST() THEN BEGIN
                StudentHostelCS.INIT();
                StudentHostelCS."Student No." := StudentNo;
                StudentHostelCS."Hostel Block" := HostelBlock;
                StudentHostelCS."Hostel Room No." := HostelRoomNo;
                StudentHostelCS."Hostel Allotted On" := HostelAllotedDate;
                StudentHostelCS."Hostel Vacated On" := HostelVacatedDate;
                StudentHostelCS."Type of Room" := RoomType;
                StudentHostelCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                StudentHostelCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                StudentHostelCS.INSERT();
            END ELSE BEGIN
                StudentHostelCS."Student No." := StudentNo;
                StudentHostelCS."Hostel Block" := HostelBlock;
                StudentHostelCS."Hostel Room No." := HostelRoomNo;
                StudentHostelCS."Hostel Allotted On" := HostelAllotedDate;
                StudentHostelCS."Hostel Vacated On" := HostelVacatedDate;
                StudentHostelCS."Type of Room" := RoomType;
                StudentHostelCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                StudentHostelCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                StudentHostelCS.Updated := TRUE;
                StudentHostelCS.Modify();
            END;
        END;

        EXIT('Entry Inserted !!');

        //Code added for hostal info.::CSPL-00059::19022019: End
    end;

    procedure CSInsertCustomerInvoice(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BalAccountNo: Code[20]; var DocumentNo: Code[20]; FeeCode1: Code[20]) Return: Code[20]
    var

        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Customer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        //  LineNo: Integer;
        "TempDocNo.": Code[20];
        DueDate: Date;
    begin
        //Code added for insert customer invoice.::CSPL-00059::19022019: Start
        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";


        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);
        DocumentNo := "TempDocNo.";


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", BalAccountNo);
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE("Bal. Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Enrollment No.", Customer."Enrollment No.");
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Source Code", 'OTHER FEES');
        GenJournalLine.VALIDATE("Due Date", DueDate);

        // GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');
        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');


        //Code added for insert customer invoice.::CSPL-00059::19022019: End
    end;

    procedure CSInsertCustomerPayment(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BankAccountNo: Code[20]; ApplytoDocNo: Code[20]; FeeCode1: Code[20]; Description: Text[100]; TransectionNumber: Code[20]; ReceiptNo: Code[20]) Return: Code[10]
    var
        // FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";

        //GenJournalLine1: Record "Gen. Journal Line";

        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";

        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Customer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        DueDate: Date;
        "TempDocNo.": Code[20];
    // LineNo: Integer;
    begin
        //Code added for insert customer payment::CSPL-00059::19022019: Start

        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            IF FeeCode1 <> '' THEN
                FeeComponentMasterCS.GET(FeeCode1);

        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";

        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Bal. Account No.", BankAccountNo);
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
        GenJournalLine."Applies-to Doc. No." := ApplytoDocNo;
        // GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.Validate("Fee Code", FeeCode1);
        IF FeeCode1 <> '' THEN
            GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description)
        ELSE
            GenJournalLine.VALIDATE(Description, Description);
        GenJournalLine.VALIDATE("Source Code", 'GENJNL');
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);
        // GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');
        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');

        //Code added for insert customer payment::CSPL-00059::19022019: End
    end;

    procedure CSPostCustomerEntry(TamplateName: Code[10]; BatchName: Code[10]) Return: Text
    var


        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //Code added for Post customer entry.::CSPL-00059::19022019: Start
        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            GenJournalLine.RESET();
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDFIRST() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
        EXIT('Posted!!');
        //Code added for Post customer entry.::CSPL-00059::19022019: End
    end;

    procedure CSLastDocumentNo(TamplateName: Code[20]; BatchName: Code[20]; var LastDocNo: Code[20])
    var
        NoSeriesLine: Record "No. Series Line";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        //Code added for last document no.::CSPL-00059::19022019: Start
        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN BEGIN
            NoSeriesLine.RESET();
            NoSeriesLine.SETRANGE("Series Code", GenJournalBatch."Pay No.Series");
            IF NoSeriesLine.FINDFIRST() THEN
                LastDocNo := NoSeriesLine."Last No. Used";
        END;

        //Code added for last document no.::CSPL-00059::19022019: End
    end;

    procedure CSInsertCustomerPaymentNew(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BankAccountNo: Code[20]; FeeCode1: Code[20]; Description: Text[100]; TransectionNumber: Code[20]; ReceiptNo: Code[20]; var LastDocNo: Code[20]) Return: Code[10]
    var
        // FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";
        Customer: Record "Customer";
        // GenJournalLine1: Record "Gen. Journal Line";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";

        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";

        NoSeries: Codeunit "NoSeriesManagement";
        // LineNo: Integer;
        "TempDocNo.": Code[20];


        DueDate: Date;
    begin
        // Code added for insert customer payment entry::CSPL-00059::19022019: Start
        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            IF FeeCode1 <> '' THEN
                FeeComponentMasterCS.GET(FeeCode1);

        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";

        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);
        LastDocNo := "TempDocNo.";

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Bal. Account No.", BankAccountNo);
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        IF FeeCode1 <> '' THEN
            GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description)
        ELSE
            GenJournalLine.VALIDATE(Description, Description);
        GenJournalLine.VALIDATE("Source Code", 'BANKRCPTV');
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);

        GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');
        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');

        // Code added for insert customer payment entry::CSPL-00059::19022019: End
    end;

    procedure "CSInsertCustomerPaymentRTGS/NEFT"(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BankAccountNo: Code[20]; FeeCode1: Code[20]; Description: Text[100]; TransectionNumber: Code[20]; ReceiptNo: Code[20]; var LastDocNo: Code[20]; InstrumentNo: Code[30]; InstrumentDate: Date) Return: Code[10]
    var
        // FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";

        // GenJournalLine1: Record "Gen. Journal Line";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Customer: Record "Customer";
        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
        //LineNo: Integer;

        DueDate: Date;
    begin
        //Code added for insert customer payment RTGS/NEFT::CSPL-00059::19022019: Start
        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            IF FeeCode1 <> '' THEN
                FeeComponentMasterCS.GET(FeeCode1);

        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";

        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);
        LastDocNo := "TempDocNo.";


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);

        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Bal. Account No.", BankAccountNo);
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        IF FeeCode1 <> '' THEN
            GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description)
        ELSE
            GenJournalLine.VALIDATE(Description, Description);
        GenJournalLine.VALIDATE("Source Code", 'BANKRCPTV');
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);
        GenJournalLine."Instrument Type" := GenJournalLine."Instrument Type"::RT;
        //GenJournalLine."Cheque Date" := InstrumentDate;
        //GenJournalLine."Cheque No." := InstrumentNo;
        GenJournalLine."Customer Bank Code" := 'ICIC';
        GenJournalLine."Customer Bank Branch Code" := 'MANIP';

        GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');

        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');

        //Code added for insert customer payment RTGS/NEFT::CSPL-00059::19022019: End
    end;

    procedure CSInsertCustomerPaymentDoc(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BankAccountNo: Code[20]; ApplytoDocNo: Code[20]; FeeCode1: Code[20]; Description: Text[100]; TransectionNumber: Code[20]; ReceiptNo: Code[20]; var DocumentNo: Code[20]) Return: Code[10]
    var
        //  FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";

        // GenJournalLine1: Record "Gen. Journal Line";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        Customer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
        // LineNo: Integer;


        DueDate: Date;
    begin
        //Code added for insert customer payment document::CSPL-00059::19022019: Start
        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            IF FeeCode1 <> '' THEN
                FeeComponentMasterCS.GET(FeeCode1);

        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";

        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);
        DocumentNo := "TempDocNo.";

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();



        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);

        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Bal. Account No.", BankAccountNo);
        GenJournalLine.VALIDATE("Posting Date", TODAY());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
        GenJournalLine."Applies-to Doc. No." := ApplytoDocNo;
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        IF FeeCode1 <> '' THEN
            GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description)
        ELSE
            GenJournalLine.VALIDATE(Description, Description);
        GenJournalLine.VALIDATE("Source Code", 'BANKRCPTV');
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);

        GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');
        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');
        //Code added for insert customer payment document::CSPL-00059::19022019: End
    end;

    procedure CSPostCustomerEntryDocumentWise(TamplateName: Code[10]; BatchName: Code[10]; DocumentNo: Code[20]) Return: Text
    var
        //FeeSetup: Record "Fee Setup-CS";

        GenJournalBatch: Record "Gen. Journal Batch";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //Code added for posting customer entry::CSPL-00059::19022019: Start
        CustLedgerEntry.RESET();
        CustLedgerEntry.SETRANGE("Document No.", DocumentNo);
        IF CustLedgerEntry.FINDFIRST() THEN
            ERROR('Document No. %1 Already Exist !!', DocumentNo);


        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            GenJournalLine.RESET();
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.SETRANGE("Document No.", DocumentNo);
        IF GenJournalLine.FINDFIRST() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
        EXIT('Posted!!');

        //Code added for posting customer entry::CSPL-00059::19022019: End
    end;

    procedure CSInsertCustomerInvoiceCustomerPostingDate(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BalAccountNo: Code[20]; var DocumentNo: Code[20]; FeeCode1: Code[10]; PostingDate: Date) Return: Code[20]
    var
        //FeeSetupCS: Record "Fee Setup-CS";
        //GenJournalTemplate: Record "Gen. Journal Template";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Customer: Record "Customer";

        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        //ssssssLineNo: Integer;

        "TempDocNo.": Code[20];
        DueDate: Date;
    begin
        //Code added for insert customer invoice posting date::CSPL-00059::19022019: Start


        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            FeeComponentMasterCS.GET(FeeCode1);
        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";


        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);
        DocumentNo := "TempDocNo.";

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", BalAccountNo);
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE("Bal. Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Posting Date", PostingDate);
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE("Enrollment No.", Customer."Enrollment No.");
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Source Code", 'OTHER FEES');
        GenJournalLine.VALIDATE("Due Date", DueDate);

        GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');
        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');

        //Code added for insert customer invoice posting date::CSPL-00059::19022019: End
    end;

    procedure CSInsertCustomerPaymentCustomerPostingDate(TamplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BankAccountNo: Code[20]; ApplytoDocNo: Code[20]; FeeCode1: Code[20]; Description: Text[100]; TransectionNumber: Code[20]; ReceiptNo: Code[20]; var DocumentNo: Code[20]; PostingDate: Date) Return: Code[10]
    var
        //FeeSetupCS: Record "Fee Setup-CS";
        // GenJournalTemplate: Record "Gen. Journal Template";

        //GenJournalLine1: Record "Gen. Journal Line";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        Customer: Record "Customer";
        GenJournalBatch: Record "Gen. Journal Batch";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        "TempDocNo.": Code[20];
        //LineNo: Integer;

        DueDate: Date;
    begin
        //Code added for insert customer Payment posting date::CSPL-00059::19022019: Start
        CLEAR(NoSeries);

        GenJournalBatch.RESET();
        GenJournalBatch.SETRANGE("Journal Template Name", TamplateName);
        GenJournalBatch.SETRANGE(Name, BatchName);
        IF GenJournalBatch.FINDFIRST() THEN
            IF FeeCode1 <> '' THEN
                FeeComponentMasterCS.GET(FeeCode1);

        Customer.GET(StudNo);

        EducationMultiEventCalCS.RESET();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", Customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date";

        "TempDocNo." := NoSeries.GetNextNo(GenJournalBatch."Pay No.Series", 0D, TRUE);
        DocumentNo := "TempDocNo.";

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'ATOM');
        GenJournalLine.SETRANGE("Bal. Account No.", '');
        GenJournalLine.SETRANGE("Account No.", '');
        IF GenJournalLine.FINDFIRST() THEN
            GenJournalLine.DELETEALL();


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", "TempDocNo.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.VALIDATE("Account No.", Customer."No.");
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Bal. Account No.", BankAccountNo);
        GenJournalLine.VALIDATE("Posting Date", PostingDate);
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, Customer."Course Code");
        GenJournalLine.VALIDATE(Semester, Customer.Semester);
        GenJournalLine.VALIDATE(Year, Customer.Year);
        GenJournalLine.VALIDATE("Academic Year", Customer."Academic Year");
        GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
        GenJournalLine."Applies-to Doc. No." := ApplytoDocNo;
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        IF FeeCode1 <> '' THEN
            GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description)
        ELSE
            GenJournalLine.VALIDATE(Description, Description);
        GenJournalLine.VALIDATE("Source Code", 'BANKRCPTV');
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);

        GenJournalLine.VALIDATE(GenJournalLine."ShortCut Dimension Code 3", 'MISC162');
        IF GenJournalLine.INSERT(TRUE) THEN
            EXIT('1')
        ELSE
            EXIT('0');

        //Code added for insert customer Payment posting date::CSPL-00059::19022019: End
    end;

    //CSPL-00067::26-03-2020::START
    procedure WebAPIApprovalCreditTransfer(No: Code[20]; CreditStudent: Integer; Remarks: Text[40]; UpdatedBy: Text[30]): Text[50]
    var
        RecStudentMasterCS: Record "Student Master-CS";
        RecAttachmentWiseStudentCS: Record "Attachment Wise Student-CS";
        RecStudentMasterCS1: Record "Student Master-CS";

    begin
        IF CreditStudent = 2 THEN BEGIN
            RecStudentMasterCS.RESET();
            RecStudentMasterCS.SETRANGE("No.", No);
            IF RecStudentMasterCS.FINDFIRST() THEN BEGIN
                RecStudentMasterCS.Validate("Student Status", RecStudentMasterCS."Student Status"::Student);
                RecStudentMasterCS.Validate("Credit Student", RecStudentMasterCS."Credit Student"::Approved);
                RecStudentMasterCS."Remark" := Remarks;
                RecStudentMasterCS."Updated On" := TODAY();
                RecStudentMasterCS."Updated By" := UpdatedBy;
                IF RecStudentMasterCS.MODIFY() THEN
                    EXIT('Success' + ' ' + No)
                ELSE
                    EXIT('Failed' + ' ' + No);
            END;

            RecAttachmentWiseStudentCS.RESET();
            RecAttachmentWiseStudentCS.SETRANGE("Student No.", No);
            IF RecAttachmentWiseStudentCS.FINDFIRST() THEN
                REPEAT
                    RecAttachmentWiseStudentCS."Approved" := True;
                    RecAttachmentWiseStudentCS.Modify();
                UNTIL RecAttachmentWiseStudentCS.NEXT() = 0;
        END;

        IF CreditStudent = 3 THEN BEGIN
            RecStudentMasterCS1.RESET();
            RecStudentMasterCS1.SETRANGE("No.", No);
            IF RecStudentMasterCS1.FINDFIRST() THEN BEGIN
                RecStudentMasterCS1.Validate("Student Status", RecStudentMasterCS1."Student Status"::"Withdrawl/Discontinue");
                RecStudentMasterCS1.Validate("Credit Student", RecStudentMasterCS1."Credit Student"::Rejected);
                RecStudentMasterCS1."Updated On" := TODAY();
                RecStudentMasterCS1."Remark" := Remarks;
                RecStudentMasterCS1."Updated By" := UpdatedBy;
                IF RecStudentMasterCS1.MODIFY() THEN
                    EXIT('Success' + ' ' + No)
                ELSE
                    EXIT('Failed' + ' ' + No);
            END;
        END;
    end;

    procedure WebAPIInsertDataBranchTransferStudentApply(No: Code[20]): text[50]
    var
        RecStudentMasterCS: Record "Student Master-CS";

    begin
        RecStudentMasterCS.RESET();
        RecStudentMasterCS.SETRANGE("No.", No);
        IF RecStudentMasterCS.FINDFIRST() THEN BEGIN
            RecStudentMasterCS.Validate("Student Status", RecStudentMasterCS."Student Status"::"Student Transfer-In-Process");
            IF RecStudentMasterCS.MODIFY() THEN
                EXIT('Success' + ' ' + No)
            ELSE
                EXIT('Failed' + ' ' + No);
        END;
    end;



    procedure WebAPIInsertOtherAttachmentFile(FacultyCode: Code[20]; FileName: Text[200]; FileExtension: Text[30]; FilePath: Text[250];
     SubjectCode: Code[20]; DocumentType: Code[20]; StartDateTxt: Text; EndDateTxt: Text; Description: Text[250]; Attachment: BigText; Important: Boolean
    ; TransactionNo: code[30]; DocumentCategory: Text[50]; StudentNo: Code[20]): Text[100]
    var
        RecDifferentAttachmentCS: Record "Different Attachment-CS";
        SNo: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        RecDifferentAttachmentCS.Reset();
        If RecDifferentAttachmentCS.FindLast() then
            SNo := RecDifferentAttachmentCS."S.No." + 1
        Else
            SNo := 1;

        RecDifferentAttachmentCS.INIT();
        RecDifferentAttachmentCS.Validate("S.No.", Sno);
        RecDifferentAttachmentCS.Validate("Faculty Code", FacultyCode);
        RecDifferentAttachmentCS.Validate("File Name", FileName);
        RecDifferentAttachmentCS.Validate("File Extension", FileExtension);
        RecDifferentAttachmentCS.Validate("File Path", FilePath);
        RecDifferentAttachmentCS.Validate("Subject Code", SubjectCode);
        RecDifferentAttachmentCS.Validate("Document Type", DocumentType);
        If StartDateTxt <> '' then begin
            Evaluate(StartDate, StartDateTxt);
            RecDifferentAttachmentCS."Start Date" := StartDate;
        end;
        IF EndDateTxt <> '' then begin
            Evaluate(EndDate, EndDateTxt);
            RecDifferentAttachmentCS."End Date" := EndDate;
        End;

        RecDifferentAttachmentCS.Description := Description;
        //RecDifferentAttachmentCS.Attachment := Attachment;
        RecDifferentAttachmentCS.Important := Important;
        RecDifferentAttachmentCS."Transaction No." := TransactionNo;
        RecDifferentAttachmentCS."Document Category" := DocumentCategory;
        RecDifferentAttachmentCS."Student No." := StudentNo;
        IF RecDifferentAttachmentCS.INSERT() then
            exit('Success ' + Format(RecDifferentAttachmentCS."S.No."))
        Else
            Exit('Failed ');
    end;

    Procedure WebAPIProblemSolutionforAttachmentWiseStudentCS(StudentNo: Code[20]; LineNo: Integer; DocumentType: code[20]; FileName: Text[250]; FileExtension: Text[250]; Approved: Boolean; ApprovedBy: Text[50];
 AttachmentNo: Integer; DocumentDescription: Text[80]; TransactionNo: Code[30]; DocumentCategory: text[50]; Status: Integer; RejectReason: Code[20]; AttachmentEntryNo: Integer): Text[100]
    var
        AdvisingRequest_lRec: Record "Advising Request";
        AttachmentWiseStudentCS: Record "Attachment Wise Student-CS";
        StudentMasterCS: Record "Student Master-CS";
        LineNoInt: Integer;
    Begin
        AttachmentWiseStudentCS.Reset();
        AttachmentWiseStudentCS.Setrange("Student No.", StudentNo);
        If AttachmentWiseStudentCS.FindlAst() then
            LineNoInt := AttachmentWiseStudentCS."Line No." + 10000
        else
            LineNoInt := 10000;


        IF StudentNo = '' then
            Error('Student No must not be blank.');

        StudentMasterCS.Reset();
        StudentMasterCS.SetRange("No.", StudentNo);
        StudentMasterCS.FindFirst();

        IF LineNo = 0 then begin
            AttachmentWiseStudentCS.Init();
            AttachmentWiseStudentCS.Validate("Student No.", StudentNo);
            AttachmentWiseStudentCS."Line No." := LineNoInt;
            AttachmentWiseStudentCS."Student Name" := StudentMasterCS."Student Name";
            AttachmentWiseStudentCS."Enrollment No." := StudentMasterCS."Enrollment No.";
            AttachmentWiseStudentCS."Document Type" := DocumentType;
            AttachmentWiseStudentCS."File Name" := FileName;
            AttachmentWiseStudentCS."File Extension" := FileExtension;
            AttachmentWiseStudentCS."Created By" := UserId;
            AttachmentWiseStudentCS."Created On" := Today;
            AttachmentWiseStudentCS."Updated By" := UserId;
            AttachmentWiseStudentCS."Updated On" := Today;
            AttachmentWiseStudentCS."Updated By Name" := UserId;
            AttachmentWiseStudentCS."Created By Name" := UserId;
            AttachmentWiseStudentCS.Approved := Approved;
            AttachmentWiseStudentCS."Approved By" := ApprovedBy;
            AttachmentWiseStudentCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
            AttachmentWiseStudentCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
            AttachmentWiseStudentCS."Attachment No." := AttachmentNo;
            AttachmentWiseStudentCS."Document Description" := DocumentDescription;
            AttachmentWiseStudentCS."Transaction No." := TransactionNo;
            AttachmentWiseStudentCS."Document Category" := DocumentCategory;
            AttachmentWiseStudentCS.Status := Status;
            AttachmentWiseStudentCS.Validate("Reject Reason", RejectReason);
            AttachmentWiseStudentCS."Attachment Entry No." := AttachmentEntryNo;
            If AttachmentWiseStudentCS.Insert() then
                exit('Success ' + AttachmentWiseStudentCS."Student No." + ' ' + Format(AttachmentWiseStudentCS."Line No."))
            Else
                exit('Failed ');
        end Else begin
            AttachmentWiseStudentCS.Reset();
            AttachmentWiseStudentCS.SetRange("Student No.", StudentNo);
            AttachmentWiseStudentCS.SetRange("Line No.", LineNo);
            IF AttachmentWiseStudentCS.FindFirst() then begin
                If DocumentType <> '' then
                    AttachmentWiseStudentCS."Document Type" := DocumentType;
                If FileName <> '' then
                    AttachmentWiseStudentCS."File Name" := FileName;
                If FileExtension <> '' then
                    AttachmentWiseStudentCS."File Extension" := FileExtension;
                AttachmentWiseStudentCS."Updated By" := UserId();
                AttachmentWiseStudentCS."Updated On" := Today();
                AttachmentWiseStudentCS."Updated By Name" := UserId();
                AttachmentWiseStudentCS."Created By Name" := UserId();

                //AttachmentWiseStudentCS.Approved := Approved;
                IF ApprovedBy <> '' then
                    AttachmentWiseStudentCS."Approved By" := ApprovedBy;
                If AttachmentNo <> 0 then
                    AttachmentWiseStudentCS."Attachment No." := AttachmentNo;
                IF DocumentDescription <> '' then
                    AttachmentWiseStudentCS."Document Description" := DocumentDescription;
                If TransactionNo <> '' then
                    AttachmentWiseStudentCS."Transaction No." := TransactionNo;
                If DocumentCategory <> '' then
                    AttachmentWiseStudentCS."Document Category" := DocumentCategory;

                AttachmentWiseStudentCS.Status := Status;
                IF RejectReason <> '' then
                    AttachmentWiseStudentCS.Validate("Reject Reason", RejectReason);
                IF AttachmentEntryNo <> 0 then
                    AttachmentWiseStudentCS."Attachment Entry No." := AttachmentEntryNo;
                If AttachmentWiseStudentCS.Modify() then
                    exit('Success ' + AttachmentWiseStudentCS."Student No." + ' ' + Format(AttachmentWiseStudentCS."Line No."))
                Else
                    exit('Failed ' + AttachmentWiseStudentCS."Student No." + ' ' + Format(AttachmentWiseStudentCS."Line No."));
            end;
        end;
    End;



    procedure WebAPIInsertWithdrawlInNav(
    StudentNo: Code[20];
    Course: Code[20];
    Semester: Code[10];
    Section: Code[10];
    AcademicYear: Code[10];
    Withdrawaldate: Date;
    TCIssued: Boolean;
    ReasonforLeaving: Text[100];
    GlobalDimension1Code: Code[20];
    GlobalDimension2Code: Code[20];
    TypeOfCourse: Option;
    FinalYearsCourse: Code[10];
    ApprovedBy: Text[50];
    ApprovedOn: DateTime;
    RejectedBy: Text[50];
    RejectedOn: DateTime;
    WithdrawalStatus: Option;
    CourseName: Text[100];
    Updated: Boolean;
    UserID: Code[30];
    PortalID: Code[20]
    ): Text[50]
    var
        RecWithdrawalStudentCS: Record "Withdrawal Student-CS";
        AcademicSetupRec: Record "Academics Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        AcademicSetupRec.Get();
        RecWithdrawalStudentCS.INIT();
        RecWithdrawalStudentCS."No." := NoSeriesMgt.GetNextNo(AcademicSetupRec."Withdrawal No.", 0D, TRUE);
        RecWithdrawalStudentCS.Validate("Student No.", StudentNo);
        RecWithdrawalStudentCS.Course := Course;
        RecWithdrawalStudentCS.Semester := Semester;
        RecWithdrawalStudentCS.Section := Section;
        RecWithdrawalStudentCS."Academic Year" := AcademicYear;
        RecWithdrawalStudentCS."Withdrawal date" := Withdrawaldate;
        RecWithdrawalStudentCS."TC Issued" := TCIssued;
        RecWithdrawalStudentCS."Reason for Leaving" := ReasonforLeaving;
        RecWithdrawalStudentCS."Global Dimension 1 Code" := GlobalDimension1Code;
        RecWithdrawalStudentCS."Global Dimension 2 Code" := GlobalDimension2Code;
        RecWithdrawalStudentCS."Type Of Course" := TypeOfCourse;
        RecWithdrawalStudentCS."Final Years Course" := FinalYearsCourse;
        //RecWithdrawalStudentCS."Approved By" := ApprovedBy;
        //RecWithdrawalStudentCS."Approved Date Time" := ApprovedOn;
        //RecWithdrawalStudentCS.Validate("Rejected By", RejectedBy);
        //RecWithdrawalStudentCS.Validate("Rejected Date Time", RejectedOn);
        RecWithdrawalStudentCS.Validate("Withdrawal Status", WithdrawalStatus);
        RecWithdrawalStudentCS."Course Name" := CourseName;
        RecWithdrawalStudentCS.Updated := Updated;
        RecWithdrawalStudentCS."User ID" := FORMAT(UserId());
        RecWithdrawalStudentCS.Validate("Portal ID", PortalID);
        IF RecWithdrawalStudentCS.INSERT() then
            EXIT('Success' + ' ' + Format(RecWithdrawalStudentCS."No."))
        ELSE
            EXIT('Failed' + ' ' + Format(RecWithdrawalStudentCS."No."));

    end;

    procedure WebAPIBranchTransferAllotment(StudentNo: Code[20]; AcademicYear: Code[20]; GlobD1: Code[20]; Graduation: Code[20]; StutentStatus: Option): Text[50]
    var
        RecBranchInformationStudCS: Record "Branch Information Stud-CS";
        RecStudentMasterCS: Record "Student Master-CS";

    begin
        IF StutentStatus = 2 THEN BEGIN
            RecBranchInformationStudCS.INIT();
            RecBranchInformationStudCS.Validate("Student No.", StudentNo);
            RecBranchInformationStudCS.Validate("Academic Year", AcademicYear);
            RecBranchInformationStudCS."Creation Date" := TODAY();
            IF RecBranchInformationStudCS.INSERT() then
                EXIT('Success' + ' ' + StudentNo)
            ELSE
                EXIT('Failed' + ' ' + StudentNo);
        END;
        IF StutentStatus = 1 THEN BEGIN
            RecStudentMasterCS.RESET();
            RecStudentMasterCS.SETRANGE("No.", StudentNo);
            IF RecStudentMasterCS.FINDFIRST() THEN BEGIN
                RecStudentMasterCS.Validate("Student Status", StutentStatus);
                RecStudentMasterCS.Validate("Global Dimension 1 Code", GlobD1);
                RecStudentMasterCS.Validate(Graduation, Graduation);
                IF RecStudentMasterCS.MODIFY() THEN
                    EXIT('Success' + ' ' + StudentNo)
                ELSE
                    EXIT('Failed' + ' ' + StudentNo);
            END;
        END;
    end;

    procedure WebAPIInsertClassAttendanceLine(
    CompanyName: Text[50];
    CollegeCode: Code[20];
    DepartmentCode: Code[20];
    StudentNo: Code[20];
    StudentName: Text[100];
    Remark: Text[100];
    Reason: Code[20];
    Attendancetype: Option;
    coursecode: Code[20];
    semester: Code[10];
    Subject: Code[20];
    Subjecttype: Code[20];
    Section: Code[10];
    LinNo: Integer;
    AcadmicYear: Code[20];
    facultycode: Code[20];
    Rollno: Code[10];
    date: Date;
    Batch: Code[20];
    SrNo: Integer;
    Document: Code[20]
    ): Text[50]
    var
        RecClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        RecClassAttendanceLineCS: Record "Class Attendance Line-CS";
        RecClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        TimeTableLedger: Record "Time Table Ledger-CS";
        EntryNo: Integer;
    begin
        RecClassAttendanceHeaderCS.RESET();
        RecClassAttendanceHeaderCS.SETRANGE("Time Table No", SrNo);
        If RecClassAttendanceHeaderCS.FINDFIRST() Then Begin
            RecClassAttendanceLineCS1.Reset();
            RecClassAttendanceLineCS1.SetRange("Document No.", Document);
            RecClassAttendanceLineCS1.SetRange("Student No.", StudentNo);
            IF Not RecClassAttendanceLineCS1.FindFirst() then begin
                RecClassAttendanceLineCS.Init();
                RecClassAttendanceLineCS."Document No." := Document;
                RecClassAttendanceLineCS."Course Code" := coursecode;
                RecClassAttendanceLineCS.Semester := semester;
                RecClassAttendanceLineCS."Subject Code" := Subject;
                RecClassAttendanceLineCS.validate(Date, date);
                RecClassAttendanceLineCS."Student No." := StudentNo;
                RecClassAttendanceLineCS."Attendance Type" := Attendancetype;
                RecClassAttendanceLineCS."Academic Year" := AcadmicYear;
                RecClassAttendanceLineCS."Student Name" := StudentName;
                RecClassAttendanceLineCS."Subject Type" := Subjecttype;
                RecClassAttendanceLineCS."Line No." := LinNo;
                RecClassAttendanceLineCS.Section := Section;
                RecClassAttendanceLineCS."Global Dimension 1 Code" := CollegeCode;
                RecClassAttendanceLineCS."Global Dimension 2 Code" := DepartmentCode;
                RecClassAttendanceLineCS."Batch Code" := Batch;
                RecClassAttendanceLineCS."Staff Code" := facultycode;
                RecClassAttendanceLineCS."Roll No." := Rollno;
                RecClassAttendanceLineCS."Reason Code" := Reason;
                RecClassAttendanceLineCS.validate(Remark, Remark);
                IF RecClassAttendanceLineCS.INSERT() then
                    EXIT('Success' + ' ' + RecClassAttendanceLineCS."Document No.")
                ELSE
                    EXIT('Failed' + ' ' + RecClassAttendanceLineCS."Document No.");
            End Else
                EXIT('Duplicate' + ' ' + StudentNo);
        End;
    end;

    procedure WebAPIInsertClassAttendanceLineNonQuery(
     CollegeCode: Code[20];
     DepartmentCode: Code[20];
     StudentNo: Code[20];
     StudentName: Text[100];
     Remark: Text;
     Reason: Text;
     Attendancetype: Option;
     LinNo: Integer;
     AcadmicYear: Code[10];
     facultycode: Code[20];
     Rollno: Code[10];
     SrNo: Integer;
     Document: Code[20]
     ): Text[50]
    var
        RecClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        RecClassAttendanceLineCS: Record "Class Attendance Line-CS";
        RecClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        TimeTableLedger: Record "Time Table Ledger-CS";
        EntryNo: Integer;
    begin
        RecClassAttendanceHeaderCS.RESET();
        RecClassAttendanceHeaderCS.SETRANGE("Time Table No", SrNo);
        If RecClassAttendanceHeaderCS.FINDFIRST() Then Begin
            RecClassAttendanceLineCS1.Reset();
            RecClassAttendanceLineCS1.SetRange("Document No.", Document);
            RecClassAttendanceLineCS1.SetRange("Student No.", StudentNo);
            IF Not RecClassAttendanceLineCS1.FindFirst() then begin
                RecClassAttendanceLineCS."Document No." := Document;
                RecClassAttendanceLineCS."Student No." := StudentNo;
                RecClassAttendanceLineCS."Attendance Type" := Attendancetype;
                RecClassAttendanceLineCS."Academic Year" := AcadmicYear;
                RecClassAttendanceLineCS."Student Name" := StudentName;
                RecClassAttendanceLineCS."Line No." := LinNo;
                RecClassAttendanceLineCS."Global Dimension 1 Code" := CollegeCode;
                RecClassAttendanceLineCS."Global Dimension 2 Code" := DepartmentCode;
                RecClassAttendanceLineCS."Staff Code" := facultycode;
                RecClassAttendanceLineCS."Roll No." := Rollno;
                RecClassAttendanceLineCS."Reason Code" := FORMAT(Reason);
                RecClassAttendanceLineCS.validate(Remark, Remark);
                IF RecClassAttendanceLineCS.INSERT() then
                    EXIT('Success' + ' ' + RecClassAttendanceHeaderCS."No.")
                ELSE
                    EXIT('Failed' + ' ' + RecClassAttendanceHeaderCS."No.");
            End Else
                EXIT('Duplicate' + ' ' + StudentNo);
        End;
    end;
    /*
        procedure WebAPIInsertIntoMudevelopmentRegistration(
        StudentNo: Code[20];
        Course: Text[100];
        Semester: Code[10];
        acadmicyear: Code[10];
        subjectcode: Code[20];
        Section: Code[10];
        Description: Text[50];
        subjecttype: Code[20];
        studentname: Text[100];
        Globaldimension1: Code[20];
        Globaldimension2: Code[20];
        Year: Code[10];
        EnrollmentNo: Code[20];
        RollNo: Code[10];
        Createdby: Text[30];
        coursecode: Code[20]
        ): Text[50]
        var
            RecStudentRegistrationCS: Record "Student Registration-CS";
            RecStudentRegistrationCS1: Record "Student Registration-CS";
            RecNoSeriesLine: Record "No. Series Line";
            LineNo1: Integer;
        begin
            RecStudentRegistrationCS1.Reset();
            if RecStudentRegistrationCS1.FindLast() then
                LineNo1 := RecStudentRegistrationCS1."Line No." + 10000
            else
                LineNo1 := 10000;

            RecStudentRegistrationCS.Init();
            RecStudentRegistrationCS.Validate("Student No", StudentNo);
            RecStudentRegistrationCS."Line No." := LineNo1;
            RecStudentRegistrationCS.Validate(Course, Course);
            RecStudentRegistrationCS.Validate(Semester, Semester);
            RecStudentRegistrationCS.Validate("Academic Year", acadmicyear);
            //RecStudentRegistrationCS.Validate("Subject Code", subjectcode);
           // RecStudentRegistrationCS.Validate(Section, Section);
           // RecStudentRegistrationCS.Validate(Description, Description);
          //  RecStudentRegistrationCS.Validate("Subject Type", subjecttype);
            RecStudentRegistrationCS.Validate("Student Name", studentname);
            RecStudentRegistrationCS.Validate("Global Dimension 1 Code", Globaldimension1);
            RecStudentRegistrationCS.Validate("Global Dimension 2 Code", Globaldimension2);
            RecStudentRegistrationCS.Validate(Year, Year);
            RecStudentRegistrationCS.Validate("Enrollment No", EnrollmentNo);
           // RecStudentRegistrationCS.Validate("Roll No", RollNo);
            RecStudentRegistrationCS.Validate("Course Code", coursecode);
            RecStudentRegistrationCS."Created On" := TODAY();
            RecStudentRegistrationCS."Created By" := Createdby;
            IF RecStudentRegistrationCS.INSERT() then
                EXIT('Success' + ' ' + FORMAT(LineNo1))
            ELSE
                EXIT('Failed' + ' ' + FORMAT(LineNo1));

            RecNoSeriesLine.Reset();
            RecNoSeriesLine.SetRange("Series Code", 'LINENO');
            IF RecNoSeriesLine.FindFirst() then begin
                RecNoSeriesLine."Last No. Used" := FORMAT(LineNo1);
                RecNoSeriesLine.Modify();
            end;

        end;
    */
    procedure WebAPIInsertRTGSHeader(StudentNo: Code[20]; PaymentDate: Text;
    RequestedBy: Text[50]; RequestedOn: Text; UtrNo: Code[35]; FeeAmount: Decimal; EmailId: Text[80];
    MobilNo: Text[20]; BankName: Text[80]; RemitterName: Text[80]; Remarks: Text[500]; FeeType: Text[100];
    GD2: Code[20]): Code[50]
    var
        RecRTGSPaymentSummaryCS: Record "RTGS Payment Summary-CS";
        FeeSetupRec: Record "Fee Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentMasterRec.Get(StudentNo);
        FeeSetupRec.Reset();
        FeeSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        FeeSetupRec.FindFirst();
        FeeSetupRec.TestField(FeeSetupRec."Wired Transfer Nos.");
        RecRTGSPaymentSummaryCS.Init();
        RecRTGSPaymentSummaryCS.Validate("Student No.", StudentNo);
        RecRTGSPaymentSummaryCS."Request No." := NoSeriesMgt.GetNextNo(FeeSetupRec."Wired Transfer Nos.", WorkDate(), true);
        RecRTGSPaymentSummaryCS.Validate("Transaction Number", UtrNo);
        IF PaymentDate <> '' Then
            Evaluate(RecRTGSPaymentSummaryCS."Payment Date", PaymentDate);
        RecRTGSPaymentSummaryCS.Validate("Fee Amount", FeeAmount);
        RecRTGSPaymentSummaryCS.Validate("Bank Name", BankName);
        RecRTGSPaymentSummaryCS.Validate("Remitter Name", RemitterName);
        RecRTGSPaymentSummaryCS."Requested By" := RequestedBy;
        IF RequestedOn <> '' Then
            Evaluate(RecRTGSPaymentSummaryCS."Requested Date", RequestedOn);
        RecRTGSPaymentSummaryCS.Validate(Remarks, Remarks);
        RecRTGSPaymentSummaryCS.Validate("Mobile no.", MobilNo);
        RecRTGSPaymentSummaryCS.Validate("Email ID", EmailId);
        RecRTGSPaymentSummaryCS."Global Dimension 2 Code" := GD2;
        RecRTGSPaymentSummaryCS."Fee Type" := FeeType;
        IF RecRTGSPaymentSummaryCS.INSERT() then
            EXIT('Success' + ' ' + RecRTGSPaymentSummaryCS."Request No.")
        ELSE
            EXIT('Failed' + ' ' + RecRTGSPaymentSummaryCS."Request No.");

    end;

    procedure WebAPIInsertRTGSLine(DocumentNo: Code[20]; InvoiceNo: Code[20]; InvoiceDate: Text;
           InvoiceAmount: Decimal; AppliedAmount: Decimal; LastLine: Boolean): Code[50]
    var
        RTGSLineRec: Record "RTGS Line";
        LineNo: Integer;
    begin
        RTGSLineRec.Reset();
        RTGSLineRec.SetRange("Document No.", DocumentNo);
        if RTGSLineRec.FindLast() then
            LineNo := RTGSLineRec."Line No." + 10000
        else
            LineNo := 10000;

        RTGSLineRec.Init();
        RTGSLineRec."Document No." := DocumentNo;
        RTGSLineRec."Line No." := LineNo;
        RTGSLineRec."Invoice No." := InvoiceNo;
        IF InvoiceDate <> '' Then
            Evaluate(RTGSLineRec."Invoice Date", InvoiceDate);
        RTGSLineRec."Invoice Amount" := InvoiceAmount;
        RTGSLineRec."Applied Amount" := AppliedAmount;
        RTGSLineRec."Last Line" := LastLine;
        IF RTGSLineRec.Insert() THEN
            EXIT('Success' + ' ' + Format(RTGSLineRec."Line No."))
        Else
            EXIT('Failed' + ' ' + Format(RTGSLineRec."Line No."));

    end;

    procedure WebAPIInsertintoStudentOpenElective(
    StudentNo: Code[20];
    Course: Code[20];
    Semester: Code[10];
    AcademicYear: Code[10];
    SubjectCode: Code[20];
    Section: Code[10];
    Description: Text[100];
    SubjectType: Code[20];
    StudentName: Text[100];
    GlobalDimension1Code: Code[20];
    GlobalDimension2Code: Code[20];
    Year: Code[10];
    EnrollmentNo: Code[20];
    UserID: Code[30];
    RollNo: Code[10]
): Text[50]
    var
        RecOptionalStudentSubjectCS: Record "Optional Student Subject-CS";

    begin
        RecOptionalStudentSubjectCS.Init();
        RecOptionalStudentSubjectCS.Validate("Student No.", StudentNo);
        RecOptionalStudentSubjectCS.Validate(Course, Course);
        RecOptionalStudentSubjectCS.Validate(Semester, Semester);
        RecOptionalStudentSubjectCS.Validate("Academic Year", AcademicYear);
        RecOptionalStudentSubjectCS.Validate("Subject Code", SubjectCode);
        RecOptionalStudentSubjectCS.Validate(Section, Section);
        RecOptionalStudentSubjectCS.Validate(Description, Description);
        RecOptionalStudentSubjectCS.Validate("Subject Type", SubjectType);
        RecOptionalStudentSubjectCS.Validate("Student Name", StudentName);
        RecOptionalStudentSubjectCS.Validate("Global Dimension 1 Code", GlobalDimension1Code);
        RecOptionalStudentSubjectCS.Validate("Global Dimension 2 Code", GlobalDimension2Code);
        RecOptionalStudentSubjectCS.Year := Year;
        RecOptionalStudentSubjectCS.Validate("Enrollment No", EnrollmentNo);
        RecOptionalStudentSubjectCS.Validate("User ID", UserId());
        RecOptionalStudentSubjectCS.Validate("Roll No.", RollNo);
        IF RecOptionalStudentSubjectCS.INSERT() then
            EXIT('Success' + ' ' + StudentNo)
        ELSE
            EXIT('Failed' + ' ' + StudentNo);
    end;

    procedure WebAPIUpdateApproveAndRejecteExaminationAbsentDocument(
    applicationno: Code[20];
    StudentNo: Code[20];
    Ar: Integer;
    acadmicyear: Code[10];
    userid: Text[50];
    Remark: Text[150];
    subjectCode: Code[10]
    ): Text[50]
    var
        RecRetestApplicationAttachCS: Record "Retest Application Attach-CS";

    begin
        IF Ar = 1 THEN BEGIN
            RecRetestApplicationAttachCS.RESET();
            RecRetestApplicationAttachCS.SETRANGE("Application No", applicationno);
            RecRetestApplicationAttachCS.SETRANGE("Academic Year", acadmicyear);
            RecRetestApplicationAttachCS.SETRANGE("Student No", StudentNo);
            RecRetestApplicationAttachCS.Validate("Subject Code", SubjectCode);
            IF RecRetestApplicationAttachCS.FINDFIRST() THEN BEGIN
                RecRetestApplicationAttachCS.Validate(Status, RecRetestApplicationAttachCS.Status::Approved);
                RecRetestApplicationAttachCS.Validate(Remark, Remark);
                RecRetestApplicationAttachCS.Validate("Approved By", UserId());
                RecRetestApplicationAttachCS.Validate("Approved Date", TODAY());
                IF RecRetestApplicationAttachCS.MODIFY() THEN
                    EXIT('Success' + ' ' + applicationno)
                ELSE
                    EXIT('Failed' + ' ' + applicationno);
            END;
        END;
        IF Ar = 2 THEN BEGIN
            RecRetestApplicationAttachCS.RESET();
            RecRetestApplicationAttachCS.SETRANGE("Application No", applicationno);
            RecRetestApplicationAttachCS.SETRANGE("Academic Year", acadmicyear);
            RecRetestApplicationAttachCS.SETRANGE("Student No", StudentNo);
            RecRetestApplicationAttachCS.Validate("Subject Code", SubjectCode);
            IF RecRetestApplicationAttachCS.FINDFIRST() THEN BEGIN
                RecRetestApplicationAttachCS.Validate(Status, RecRetestApplicationAttachCS.Status::Rejected);
                RecRetestApplicationAttachCS.Validate(Remark, Remark);
                RecRetestApplicationAttachCS.Validate("Approved By", UserId());
                RecRetestApplicationAttachCS.Validate("Approved Date", TODAY());
                IF RecRetestApplicationAttachCS.MODIFY() THEN
                    EXIT('Success' + ' ' + applicationno)
                ELSE
                    EXIT('Failed' + ' ' + applicationno);
            END;
        END;

    end;

    procedure WebAPIUpdateApproveAndRejecteMakeupExaminationDocument(
    applicationno: Code[20];
    StudentNo: Code[20];
    Ar: Integer;
    acadmicyear: Code[10];
    userid: Text[50];
    Remark: Text[150];
    subjectCode: Code[10]
): Text[50]
    var
        RecMakeUpExamDocumentCS: Record "MakeUp Exam Document-CS";

    begin
        IF Ar = 1 THEN BEGIN
            RecMakeUpExamDocumentCS.RESET();
            RecMakeUpExamDocumentCS.SETRANGE("Application No", applicationno);
            RecMakeUpExamDocumentCS.SETRANGE("Academic Year", acadmicyear);
            RecMakeUpExamDocumentCS.SETRANGE("Student No", StudentNo);
            RecMakeUpExamDocumentCS.Validate("Subject Code", SubjectCode);
            IF RecMakeUpExamDocumentCS.FINDFIRST() THEN BEGIN
                RecMakeUpExamDocumentCS.Status := RecMakeUpExamDocumentCS.Status::Approved;
                RecMakeUpExamDocumentCS.Remark := Remark;
                RecMakeUpExamDocumentCS."Approved By" := FORMAT(UserId());
                RecMakeUpExamDocumentCS."Approved Date" := TODAY();
                IF RecMakeUpExamDocumentCS.MODIFY() THEN
                    EXIT('Success' + ' ' + applicationno)
                ELSE
                    EXIT('Failed' + ' ' + applicationno);
            END;
        END;
        IF Ar = 2 THEN BEGIN
            RecMakeUpExamDocumentCS.RESET();
            RecMakeUpExamDocumentCS.SETRANGE("Application No", applicationno);
            RecMakeUpExamDocumentCS.SETRANGE("Academic Year", acadmicyear);
            RecMakeUpExamDocumentCS.SETRANGE("Student No", StudentNo);
            RecMakeUpExamDocumentCS.Validate("Subject Code", SubjectCode);
            IF RecMakeUpExamDocumentCS.FINDFIRST() THEN BEGIN
                RecMakeUpExamDocumentCS.Status := RecMakeUpExamDocumentCS.Status::Rejected;
                RecMakeUpExamDocumentCS.Remark := Remark;
                RecMakeUpExamDocumentCS."Approved By" := FORMAT(UserId());
                RecMakeUpExamDocumentCS."Approved Date" := TODAY();
                IF RecMakeUpExamDocumentCS.MODIFY() THEN
                    EXIT('Success' + ' ' + applicationno)
                ELSE
                    EXIT('Failed' + ' ' + applicationno);
            END;
        END;

    end;

    procedure WebAPIUpdateGradeInStudentSubjectStudentOptional(
    studentno: Code[20];
    Course: Code[20];
    Subjectcode: Code[10];
    acadmicyear: Code[10];
    subjectType: Code[20]
    ): Text[50]
    var
        RecMainStudentSubjectCS: Record "Main Student Subject-CS";
        RecOptionalStudentSubjectCS: Record "Optional Student Subject-CS";

    begin
        if subjectType = 'CORE' THEN BEGIN
            RecMainStudentSubjectCS.RESET();
            RecMainStudentSubjectCS.SETRANGE("Student No.", StudentNo);
            RecMainStudentSubjectCS.SETRANGE("Course", Course);
            RecMainStudentSubjectCS.Validate("Subject Code", SubjectCode);
            RecMainStudentSubjectCS.SETRANGE("Academic Year", acadmicyear);
            IF RecMainStudentSubjectCS.FINDFIRST() THEN BEGIN
                RecMainStudentSubjectCS.Validate("Grade", 'I');
                IF RecMainStudentSubjectCS.MODIFY() THEN
                    EXIT('Success' + ' ' + StudentNo)
                ELSE
                    EXIT('Failed' + ' ' + StudentNo);
            END;
        END;
        if (subjectType = 'ELECTIVE') or (subjectType = 'PROGRAM ELECTIVE') or (subjectType = 'OPEN ELECTIVE') THEN BEGIN
            RecOptionalStudentSubjectCS.SETRANGE("Student No.", StudentNo);
            RecOptionalStudentSubjectCS.SETRANGE("Course", Course);
            RecOptionalStudentSubjectCS.Validate("Subject Code", SubjectCode);
            RecOptionalStudentSubjectCS.SETRANGE("Academic Year", acadmicyear);
            IF RecOptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                RecOptionalStudentSubjectCS.Validate("Grade", 'I');
                IF RecOptionalStudentSubjectCS.MODIFY() THEN
                    EXIT('Success' + ' ' + StudentNo)
                ELSE
                    EXIT('Failed' + ' ' + StudentNo);
            END;
        END;

    end;

    procedure WebAPIUpdateMalpracticebehalfofdocumentNo(
    examtype: Integer;
    acadmicyear: Code[10];
    StudentNo: Code[20];
    Enrollmentno: Code[20];
    CourseCode: Code[20];
    Semester: Code[10];
    subjectcode: Code[20];
    mapractice: Code[20];
    Program: Code[10]

    )
    var
        RecExternalExamLineCS: Record "External Exam Line-CS";
        RecInternalExamLineCS: Record "Internal Exam Line-CS";
    begin

        if (examtype = 1) then BEGIN
            RecExternalExamLineCS.RESET();
            RecExternalExamLineCS.SETRANGE("Academic Year", acadmicyear);
            RecExternalExamLineCS.SETRANGE("Student No.", StudentNo);
            RecExternalExamLineCS.Validate("Subject Code", subjectCode);
            RecExternalExamLineCS.SETFILTER("Semester", 'I');
            RecExternalExamLineCS.SETFILTER("Program", 'UG');
            IF RecExternalExamLineCS.FINDFIRST() THEN
                REPEAT
                    RecExternalExamLineCS.Validate("MAL Practice Level", mapractice);
                    RecExternalExamLineCS.Modify();
                UNTIL RecExternalExamLineCS.Next() = 0;


            RecExternalExamLineCS.RESET();
            RecExternalExamLineCS.SETRANGE("Academic Year", acadmicyear);
            RecExternalExamLineCS.SETRANGE("Student No.", StudentNo);
            RecExternalExamLineCS.Validate("Course", CourseCode);
            RecExternalExamLineCS.Validate("Subject Code", subjectCode);
            RecExternalExamLineCS.SETFILTER("Semester", '<>%1', 'I');
            RecExternalExamLineCS.SETFILTER("Program", '<>%1', 'UG');
            IF RecExternalExamLineCS.FINDFIRST() THEN
                REPEAT
                    RecExternalExamLineCS.Validate("MAL Practice Level", mapractice);
                    RecExternalExamLineCS.Modify();
                UNTIL RecExternalExamLineCS.Next() = 0;


        END;
        if (examtype = 2) THEN BEGIN
            RecInternalExamLineCS.RESET();
            RecInternalExamLineCS.SETRANGE("Academic Year", acadmicyear);
            RecInternalExamLineCS.SETRANGE("Student No.", StudentNo);
            RecInternalExamLineCS.Validate("Subject Code", subjectCode);
            RecInternalExamLineCS.SETRANGE("Semester", 'I');
            RecInternalExamLineCS.SETRANGE("Program", 'UG');
            IF RecInternalExamLineCS.FINDFIRST() THEN
                REPEAT
                    RecInternalExamLineCS.Validate("MAL Practice Level", mapractice);
                    RecInternalExamLineCS.Modify();
                UNTIL RecInternalExamLineCS.Next() = 0;


            RecInternalExamLineCS.RESET();
            RecInternalExamLineCS.SETRANGE("Academic Year", acadmicyear);
            RecInternalExamLineCS.SETRANGE("Student No.", StudentNo);
            RecInternalExamLineCS.Validate("Subject Code", subjectCode);
            RecInternalExamLineCS.SETFILTER("Semester", '<>%1', 'I');
            RecInternalExamLineCS.SETFILTER("Program", '<>%1', 'UG');
            IF RecInternalExamLineCS.FINDFIRST() THEN
                REPEAT
                    RecInternalExamLineCS.Validate("MAL Practice Level", mapractice);
                    RecInternalExamLineCS.Modify();
                UNTIL RecInternalExamLineCS.Next() = 0;

        END;

    end;

    procedure WebAPIInsertNOCInNav(
    No: Code[20];
    StudentNo: Code[20];
    Course: Code[20];
    Semester: Code[10];
    Section: Code[10];
    AcademicYear: Code[10];
    Withdrawaldate: Date;
    No_Series: Code[20];
    TCIssued: Boolean;
    ReasonforLeaving: Text[500];
    GlobalDimension1Code: Code[20];
    GlobalDimension2Code: Code[20];
    TypeOfCourse: Option;
    FinalYearsCourse: Code[10];
    ApprovedBy: Text[50];
    RejectedBy: Text[50];
    RejectedOn: DateTime;
    WithdrawalStatus: Option;
    CourseName: Text[100];
    Updated: Boolean;
    UserID: Code[30];
    PortalID: Code[20]
   ): Text[50]

    var
        RecWithdrawalStudentCS: Record "Withdrawal Student-CS";

    begin
        RecWithdrawalStudentCS.Init();
        RecWithdrawalStudentCS."No." := No;
        RecWithdrawalStudentCS.Validate("Student No.", StudentNo);
        RecWithdrawalStudentCS.Validate(Course, Course);
        RecWithdrawalStudentCS.Validate(Semester, Semester);
        RecWithdrawalStudentCS.Validate(Section, Section);
        RecWithdrawalStudentCS.Validate("Academic Year", AcademicYear);
        RecWithdrawalStudentCS.Validate("Withdrawal date", Withdrawaldate);
        RecWithdrawalStudentCS.Validate("No. Series", No_Series);
        RecWithdrawalStudentCS.Validate("TC Issued", TCIssued);
        RecWithdrawalStudentCS."Reason for Leaving" := ReasonforLeaving;
        RecWithdrawalStudentCS.Validate("Global Dimension 1 Code", GlobalDimension1Code);
        RecWithdrawalStudentCS.Validate("Global Dimension 2 Code", GlobalDimension2Code);
        RecWithdrawalStudentCS.Validate("Type Of Course", TypeOfCourse);
        RecWithdrawalStudentCS.Validate("Final Years Course", FinalYearsCourse);
        //RecWithdrawalStudentCS.Validate("Approved By", ApprovedBy);
        //RecWithdrawalStudentCS.Validate("Rejected By", RejectedBy);
        //RecWithdrawalStudentCS."Rejected Date Time" := RejectedOn;
        //RecWithdrawalStudentCS."Rejected Date Time" := CURRENTDATETIME;
        RecWithdrawalStudentCS.Validate("Withdrawal Status", WithdrawalStatus);
        RecWithdrawalStudentCS.Validate("Course Name", CourseName);
        RecWithdrawalStudentCS.Updated := Updated;
        RecWithdrawalStudentCS."User ID" := FORMAT(UserId());
        RecWithdrawalStudentCS."Portal ID" := PortalID;
        IF RecWithdrawalStudentCS.Insert() THEN
            EXIT('Success' + ' ' + No)
        else
            EXIT('Failed' + ' ' + No);


    end;

    procedure WebAPIInsertApplicationCertificateCOL(/////////26//
        Ceritificate: Code[20];
        Status: Option;
        StudentNo: Code[20];
        FirstName: Text[35];
        MiddleName: Text[30];
        LastName: Text[35];
        Gender: option " ",Female,Male,"Not Specified";
        Relationship: Text[30];
        PhoneNo: Text[30];
        Email: Text[50];
        PostCode: Code[20];
        City: Text[30];
        State: Code[20];
        CountryCode: Code[10];
        ApplicationCategory: Code[20];
        PaymentAmount: Decimal;
        Purpose: Text[30];
        Remark: Text[250];
        Quantity: Integer;
        GlobalDimension1Code: Code[20];
        GlobalDimension2Code: Code[20];
        Statement: Text[250];
        UserID: Code[30];
        PortalID: Code[20];
        ModeofCollection: Option " ","Mail Official Transcript","E-Mail Transcript","BHHS Degree";
        CollectingBy: Text[30];
        CourierType: Option " ","Standard Mail","FedEx Next Day Delivery";
        CourierCharges: Decimal;
        CourierFeeCode: Code[20];
        CourierAddress: Text[250];
        FileName: Text[50];
        FilePath: Text[250];
        RankCertificate: Option;
        Attachment: Byte;
        OrganizationName: Text[250]
        ): Text[100]
    var
        RecCertificatesApplicationCS: Record "Certificates Application-CS";
        EducationSetup: Record "Education Setup-CS";
        Noseriesmgmt: Codeunit NoSeriesManagement;

    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        IF EducationSetup.FindFirst() then;
        EducationSetup.TestField("Certificate Application No.");
        RecCertificatesApplicationCS.Init();
        RecCertificatesApplicationCS."Application No." := Noseriesmgmt.GetNextNo(EducationSetup."Certificate Application No.", Today(), true);
        RecCertificatesApplicationCS.Validate(Certificate, Ceritificate);
        RecCertificatesApplicationCS.Validate(Status, Status);
        RecCertificatesApplicationCS.Validate("Student No.", StudentNo);
        if FirstName <> '' then
            RecCertificatesApplicationCS."First Name" := FirstName;
        RecCertificatesApplicationCS."Middle Name" := MiddleName;
        if LastName <> '' then
            RecCertificatesApplicationCS."Last Name" := LastName;
        RecCertificatesApplicationCS.Gender := Gender;
        RecCertificatesApplicationCS."Phone Number" := PhoneNo;
        IF Email <> '' then
            RecCertificatesApplicationCS."E-Mail Address" := Email;
        RecCertificatesApplicationCS.Relationship := Relationship;
        // if (PostCode <> '') or (City <> '') then
        //     CreatePostCode(PostCode, City, State, CountryCode);
        RecCertificatesApplicationCS."Post Code" := PostCode;
        RecCertificatesApplicationCS.City := City;
        RecCertificatesApplicationCS.State := State;
        RecCertificatesApplicationCS."Country Code" := CountryCode;
        RecCertificatesApplicationCS.Validate("Application Category", ApplicationCategory);
        RecCertificatesApplicationCS.Validate("Payment Amount", PaymentAmount);
        RecCertificatesApplicationCS.Validate(Purpose, Purpose);
        RecCertificatesApplicationCS.Validate(Remark, Remark);


        RecCertificatesApplicationCS.Validate("Global Dimension 1 Code", GlobalDimension1Code);
        RecCertificatesApplicationCS.Validate("Global Dimension 2 Code", GlobalDimension2Code);
        RecCertificatesApplicationCS.Statement := Statement;
        RecCertificatesApplicationCS."User ID" := FORMAT(UserId());
        RecCertificatesApplicationCS."Portal ID" := PortalID;
        RecCertificatesApplicationCS."Mode of Collection" := ModeofCollection;
        If ModeofCollection = ModeofCollection::"Mail Official Transcript" then begin
            RecCertificatesApplicationCS.Validate(Quantity, Quantity);
            RecCertificatesApplicationCS."Payment Status" := RecCertificatesApplicationCS."Payment Status"::Pending;
            RecCertificatesApplicationCS."Digital Signature Status" := RecCertificatesApplicationCS."Digital Signature Status"::Pending;
        end Else
            RecCertificatesApplicationCS.Quantity := 0;
        RecCertificatesApplicationCS."Collecting By" := CollectingBy;
        RecCertificatesApplicationCS."Courier Type" := CourierType;
        RecCertificatesApplicationCS."Courier Charges" := CourierCharges;
        RecCertificatesApplicationCS."Courier FeeCode" := CourierFeeCode;
        RecCertificatesApplicationCS."Courier Address" := CourierAddress;
        RecCertificatesApplicationCS."File Name" := FileName;
        RecCertificatesApplicationCS."File Path" := FilePath;
        RecCertificatesApplicationCS."Rank Certificate" := RankCertificate;
        RecCertificatesApplicationCS."Application Date" := Today();
        RecCertificatesApplicationCS."Organization Name " := OrganizationName;
        If RecCertificatesApplicationCS.Status = RecCertificatesApplicationCS.Status::Pending then begin
            IF RecCertificatesApplicationCS."Mode of Collection" = RecCertificatesApplicationCS."Mode of Collection"::"Mail Official Transcript" then
                RecCertificatesApplicationCS.CreateNotes('Pending Official Transcript Request');

            IF RecCertificatesApplicationCS."Mode of Collection" = RecCertificatesApplicationCS."Mode of Collection"::"E-Mail Transcript" then
                RecCertificatesApplicationCS.CreateNotes('Pending Unofficial Transcript Request');

            If RecCertificatesApplicationCS."Mode of Collection" = RecCertificatesApplicationCS."Mode of Collection"::"BHHS Degree" then
                RecCertificatesApplicationCS.CreateNotes('Pending BHHS Degree Request');
        end;

        //RecCertificatesApplicationCS."Attachment":=Attachment;
        IF RecCertificatesApplicationCS.Insert() then
            Exit('Success' + ' ' + RecCertificatesApplicationCS."Application No.")
        ELSE
            Exit('Failed' + ' ');
    end;

    procedure WebAPIInsertApplicationOptions(
    ApplicationNumber: Code[20];
    AppOptionCode: Code[20]
    ): Text[50]
    var
        RecCertificatesApplicationCS: Record "Application Cert. Option-CS";
        SequenceNo: Integer;
    begin
        RecCertificatesApplicationCS.Reset();
        if RecCertificatesApplicationCS.FINDLAST() then
            SequenceNo := RecCertificatesApplicationCS."Sequence No"
        else
            SequenceNo := 0;

        RecCertificatesApplicationCS.INIT();
        RecCertificatesApplicationCS."Sequence No" := SequenceNo + 1;
        RecCertificatesApplicationCS."Application Number" := ApplicationNumber;
        RecCertificatesApplicationCS."App Option Code" := AppOptionCode;

        IF RecCertificatesApplicationCS.INSERT() then
            Exit('Success' + ' ' + RecCertificatesApplicationCS."Application Number")
        ELSE
            Exit('Failed' + ' ' + RecCertificatesApplicationCS."Application Number");

    end;

    procedure WebAPIInsertAssignmentLine(
    assignmentno: Code[20];
    studentno: Code[20];
    studentname: Text[100];
    globaldim1: Code[20];
    semester: Code[10];
    coursecode: Code[20];
    section: Code[10];
    acadmicyear: Code[20];
    maxmarks: Decimal;
    maxweightage: Decimal
   ): Text[50]
    var
        RecClassAssignmentLineCS: Record "Class Assignment Line-CS";
        //SequenceNo: Integer;

        LineNo1: Integer;
    begin
        RecClassAssignmentLineCS.Reset();
        if RecClassAssignmentLineCS.FindLast() then
            LineNo1 := RecClassAssignmentLineCS."Line No." + 10000
        else
            LineNo1 := 10000;
        RecClassAssignmentLineCS.Init();
        RecClassAssignmentLineCS.Validate("Assignment No.", assignmentno);
        RecClassAssignmentLineCS."Line No." := LineNo1;
        RecClassAssignmentLineCS.Validate("Student No.", studentno);
        RecClassAssignmentLineCS.Validate("Student Name", studentname);
        RecClassAssignmentLineCS.Validate("Global Dimension 1 Code", globaldim1);
        RecClassAssignmentLineCS.Validate(Semester, semester);
        RecClassAssignmentLineCS.Validate("Course Code", coursecode);
        RecClassAssignmentLineCS.Validate(Section, section);
        RecClassAssignmentLineCS.Validate("Academic Year", acadmicyear);
        RecClassAssignmentLineCS.Validate("Maximum Mark", maxmarks);
        RecClassAssignmentLineCS.Validate("Maximum Weightage", maxweightage);
        IF RecClassAssignmentLineCS.INSERT() then
            Exit('Success' + ' ' + RecClassAssignmentLineCS."Assignment No.")
        ELSE
            Exit('Failed' + ' ' + RecClassAssignmentLineCS."Assignment No.");

    end;

    procedure WebAPIInsertMakeupExam(
    StudentNo: Code[20];
    CourseCode: Code[20];
    SubjectCode: Code[20];
    SubjectName: Text[100];
    Semester: Code[20];
    Year: Code[20];
    AcademicYear: Code[20];
    Grade: Code[20];
    Session: Code[50];
    GlobalDimension1Code: Code[20];
    GlobalDimension2Code: Code[20];
    CreatedBy: Text[50];
    CreatedByName: Text[100];
    UpdatedBy: Text[30];
    UpdateByName: Text[100];
    ExamType: Code[10]

       ): Text[50]
    var
        RecMakeUpExaminationCS: Record "MakeUp Examination-CS";
        RecOptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        RecMainStudentSubjectCS: Record "Main Student Subject-CS";
        RecSubjectMasterCS: Record "Subject Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        RecMakeUpExaminationCS.Init();
        RecMakeUpExaminationCS."Application No." := NoSeriesMgt.GetNextNo('MKP', WorkDate(), true);
        RecMakeUpExaminationCS.Validate("Student No.", StudentNo);
        RecMakeUpExaminationCS.Validate("Course Code", CourseCode);
        RecMakeUpExaminationCS.Validate("Subject Code", SubjectCode);
        RecMakeUpExaminationCS.Validate("Subject Name", SubjectName);
        RecMakeUpExaminationCS.Validate(Semester, Semester);
        RecMakeUpExaminationCS.Validate(Year, Year);
        RecMakeUpExaminationCS.Validate("Academic Year", AcademicYear);
        RecMakeUpExaminationCS.Validate(Grade, Grade);
        RecMakeUpExaminationCS.Validate(Session, Session);
        RecMakeUpExaminationCS.Validate("Global Dimension 1 Code", GlobalDimension1Code);
        RecMakeUpExaminationCS.Validate("Global Dimension 2 Code", GlobalDimension2Code);
        RecMakeUpExaminationCS."Created By" := CreatedBy;
        RecMakeUpExaminationCS."Created By Name" := CreatedByName;
        RecMakeUpExaminationCS."Updated By" := UpdatedBy;
        RecMakeUpExaminationCS."Updated By Name" := UpdateByName;
        RecMakeUpExaminationCS.Validate("Exam Classification", ExamType);
        IF RecMakeUpExaminationCS.INSERT() then BEGIN
            RecSubjectMasterCS.RESET();
            RecSubjectMasterCS.SETRANGE("Code", SubjectCode);
            IF RecSubjectMasterCS.FINDFIRST() THEN;

            IF (ExamType = 'MAKE-UP') AND (RecSubjectMasterCS."Subject Type" = 'CORE') THEN BEGIN

                RecMainStudentSubjectCS.Reset();
                RecMainStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecMainStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                IF RecMainStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecMainStudentSubjectCS."Make Up Examination" := True;
                    RecMainStudentSubjectCS.Publish := False;
                    IF RecMainStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecMakeUpExaminationCS."Application No.")
                    ELSE
                        EXIT('Success' + ' ' + RecMakeUpExaminationCS."Application No.");
                END;
            END;

            IF (ExamType = 'MAKE-UP') AND (RecSubjectMasterCS."Subject Type" <> 'CORE') THEN BEGIN

                RecOptionalStudentSubjectCS.Reset();
                RecOptionalStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecOptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                IF RecOptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecOptionalStudentSubjectCS."Make Up Examination" := True;
                    RecOptionalStudentSubjectCS.Publish := False;
                    IF RecOptionalStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecMakeUpExaminationCS."Application No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecMakeUpExaminationCS."Application No.");

                END;
            END;


            IF (ExamType = 'SPECIAL') AND (RecSubjectMasterCS."Subject Type" = 'CORE') THEN BEGIN

                RecMainStudentSubjectCS.Reset();
                RecMainStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecMainStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                IF RecMainStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecMainStudentSubjectCS."Re-Registration Exam Only" := True;
                    RecMainStudentSubjectCS.Publish := False;
                    IF RecMainStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecMakeUpExaminationCS."Application No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecMakeUpExaminationCS."Application No.");
                END;
            END;
            IF (ExamType = 'SPECIAL') AND (RecSubjectMasterCS."Subject Type" <> 'CORE') THEN BEGIN

                RecOptionalStudentSubjectCS.Reset();
                RecOptionalStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecOptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                IF RecOptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecOptionalStudentSubjectCS."Re-Registration Exam Only" := True;
                    RecOptionalStudentSubjectCS.Publish := False;
                    IF RecOptionalStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecMakeUpExaminationCS."Application No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecMakeUpExaminationCS."Application No.");
                END;
            END;
            EXIT('Success' + ' ' + RecMakeUpExaminationCS."Application No.")
        END
        ELSE
            EXIT('Failed' + ' ' + RecMakeUpExaminationCS."Application No.");

    end;

    procedure WebAPIInsertRevaluation(
    StudentNo: Code[20];
    CourseCode: Code[20];
    SubjectCode: Code[20];
    SubjectName: Text[100];
    Semester: Code[20];
    Year: Code[20];
    AcademicYear: Code[20];
    Grade: Code[20];
    TypeOfRevaluation: Option;
    Session: Code[50];
    GlobalDimension1Code: Code[20];
    GlobalDimension2Code: Code[20];
    CreatedBy: Text[50];
    CreatedByName: Text[100];
    UpdatedBy: Text[30];
    UpdateByName: Text[100]
       ): Text[50]
    var
        RecRevaluationStatusCS: Record "Revaluation Status-CS";
        RecOptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        RecMainStudentSubjectCS: Record "Main Student Subject-CS";
        RecSubjectMasterCS: Record "Subject Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        RecRevaluationStatusCS.Init();
        RecRevaluationStatusCS."No." := NoSeriesMgt.GetNextNo('REV', WorkDate(), true);
        RecRevaluationStatusCS.Validate("Student No.", StudentNo);
        RecRevaluationStatusCS.Validate("Course Code", CourseCode);
        RecRevaluationStatusCS.Validate("Subject Code", SubjectCode);
        //RecRevaluationStatusCS."Subject Name" := SubjectName;
        RecRevaluationStatusCS.Validate(Semester, Semester);
        //RecRevaluationStatusCS.Year := Year;
        RecRevaluationStatusCS.Validate("Academic Year", AcademicYear);
        // RecRevaluationStatusCS.Grade := Grade;
        //RecRevaluationStatusCS.Session := Session;
        //RecRevaluationStatusCS."Global Dimension 1 Code" := GlobalDimension1Code;
        //RecRevaluationStatusCS."Global Dimension 2 Code" := GlobalDimension2Code;
        //RecRevaluationStatusCS."Created By" := CreatedBy;
        //RecRevaluationStatusCS."Created By Name" := CreatedByName;
        //RecRevaluationStatusCS."Updated By" := UpdatedBy;
        //RecRevaluationStatusCS."Updated By Name" := UpdateByName;
        //RecRevaluationStatusCS."Exam Classification" := ExamType;
        //RecRevaluationStatusCS.Insert();
        IF RecRevaluationStatusCS.INSERT() then BEGIN
            RecSubjectMasterCS.RESET();
            RecSubjectMasterCS.SETRANGE("Code", SubjectCode);
            RecSubjectMasterCS.SETRANGE("Course", CourseCode);
            IF RecSubjectMasterCS.FINDFIRST() THEN;

            IF (TypeOfRevaluation = 0) AND (RecSubjectMasterCS."Subject Type" = 'CORE') THEN BEGIN
                RecMainStudentSubjectCS.Reset();
                RecMainStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecMainStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                RecMainStudentSubjectCS.SETRANGE("Course", CourseCode);
                IF RecMainStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecMainStudentSubjectCS."Make Up Examination" := True;
                    RecMainStudentSubjectCS.Publish := False;
                    IF RecMainStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecRevaluationStatusCS."No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecRevaluationStatusCS."No.");
                END;
            END;

            IF (TypeOfRevaluation = 0) AND (RecSubjectMasterCS."Subject Type" <> 'CORE') THEN BEGIN

                RecOptionalStudentSubjectCS.Reset();
                RecOptionalStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecOptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                RecOptionalStudentSubjectCS.SETRANGE("Course", CourseCode);
                IF RecOptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecOptionalStudentSubjectCS."Make Up Examination" := True;
                    RecOptionalStudentSubjectCS.Publish := False;
                    IF RecOptionalStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecRevaluationStatusCS."No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecRevaluationStatusCS."No.");
                END;
            END;

            IF (TypeOfRevaluation <> 0) AND (RecSubjectMasterCS."Subject Type" = 'CORE') THEN BEGIN
                RecMainStudentSubjectCS.Reset();
                RecMainStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecMainStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                RecMainStudentSubjectCS.SETRANGE("Course", CourseCode);
                IF RecMainStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecMainStudentSubjectCS."Re-Registration Exam Only" := True;
                    RecMainStudentSubjectCS.Publish := False;
                    IF RecMainStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecRevaluationStatusCS."No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecRevaluationStatusCS."No.");
                END;
            END;
            IF (TypeOfRevaluation <> 0) AND (RecSubjectMasterCS."Subject Type" <> 'CORE') THEN BEGIN

                RecOptionalStudentSubjectCS.Reset();
                RecOptionalStudentSubjectCS.SETRANGE("Student No.", StudentNo);
                RecOptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                RecOptionalStudentSubjectCS.SETRANGE("Course", CourseCode);
                IF RecOptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                    RecOptionalStudentSubjectCS."Re-Registration Exam Only" := True;
                    RecOptionalStudentSubjectCS.Publish := False;
                    IF RecOptionalStudentSubjectCS.MODIFY() THEN
                        EXIT('Success' + ' ' + RecRevaluationStatusCS."No.")
                    ELSE
                        EXIT('Failed' + ' ' + RecRevaluationStatusCS."No.");

                END;

            END;
            EXIT('Success' + ' ' + RecRevaluationStatusCS."No.")
        END
        ELSE
            EXIT('Failed' + ' ' + RecRevaluationStatusCS."No.");

    end;


    procedure WebAPIInsertTimeSlotIntoTimeTable(Date: Date;
    TimeSlotCode: Code[20];
    StartTime: Time;
    EndTime: Time;
    RoomNo: Code[20];
    AcademicCode: Code[20];
    CourseCode: Code[20];
    CourseName: Text[150];
    Semester: Code[10];
    SubjectCode: Code[20];
    SubjectName: Text[150];
    Batch: Code[20];
    Section: Code[10];
    Faculty1Code: Code[20];
    GlobalDimension1Code: Code[20];
    GlobalDimension2Code: Code[20];
    Group: Option;
    ExtraClass: Boolean
    ): Text[50]
    var
        RecFinalClassTimeTableCS: Record "Final Class Time Table-CS";

    begin
        RecFinalClassTimeTableCS.Init();
        RecFinalClassTimeTableCS.Validate(Date, Date);
        RecFinalClassTimeTableCS.Validate("Time Slot Code", TimeSlotCode);
        RecFinalClassTimeTableCS.Validate("Start Time", StartTime);
        RecFinalClassTimeTableCS.Validate("End Time", EndTime);
        RecFinalClassTimeTableCS.Validate("Room No", RoomNo);
        RecFinalClassTimeTableCS.Validate("Academic Code", AcademicCode);
        RecFinalClassTimeTableCS.Validate("Course code", CourseCode);
        RecFinalClassTimeTableCS.Validate("Course Name", CourseName);
        RecFinalClassTimeTableCS.Validate(Semester, Semester);
        RecFinalClassTimeTableCS."Subject Code" := SubjectCode;
        RecFinalClassTimeTableCS."Subject Name" := SubjectName;
        RecFinalClassTimeTableCS.Batch := Batch;
        RecFinalClassTimeTableCS.Section := Section;
        RecFinalClassTimeTableCS."Faculty 1Code" := Faculty1Code;
        RecFinalClassTimeTableCS."Global Dimension 1 Code" := GlobalDimension1Code;
        RecFinalClassTimeTableCS."Global Dimension 2 Code" := GlobalDimension2Code;
        RecFinalClassTimeTableCS.Group := Group;
        RecFinalClassTimeTableCS."Extra Class" := ExtraClass;
        IF RecFinalClassTimeTableCS.INSERT() then
            EXIT('Success' + ' ' + FORMAT(RecFinalClassTimeTableCS."S.No."))
        ELSE
            EXIT('Failed' + ' ' + FORMAT(RecFinalClassTimeTableCS."S.No."));


    end;

    //CSPL-00067::27-03-2020::END

    //CSPL-00092::27-03-2020 START
    procedure WebAPIClassAttendenceInsertHeader(CollegeCode: Code[50]; DepartmentCode: Code[20]; Coursecode: Code[20]; Semester: Code[10]; SubjectCode: Code[20]; Section: Code[10]; AcadmicYear: Code[10]; Subjecttype: Code[20]; Employeecode: Code[50]; Date: Date; Batch: Code[50]; facultyName: Text[20]; SrNumber: Integer; Timeslot: Code[50]; StartTime: Time; EndTime: Time; RoomNo: Code[50]): Text
    var
        ClassAttendanceHeader: Record "Class Attendance Header-CS";
        FinalClassTimeTable: Record "Final Class Time Table-CS";
        RecClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        RecClassAttendanceHeaderCS.RESET();
        RecClassAttendanceHeaderCS.SETRANGE("Time Table No", SrNumber);
        If Not RecClassAttendanceHeaderCS.FINDFIRST() Then Begin
            ClassAttendanceHeader.Init();
            ClassAttendanceHeader."No." := NoSeriesMgt.GetNextNo('ATT', WorkDate(), true);
            ClassAttendanceHeader.Validate("Course Code", Coursecode);
            ClassAttendanceHeader.Validate(Semester, Semester);
            ClassAttendanceHeader.Validate("Date", Date);
            ClassAttendanceHeader.Validate("Attendance By", Employeecode);
            ClassAttendanceHeader.Validate("Academic Year", AcadmicYear);
            ClassAttendanceHeader."Subject Type" := Subjecttype;
            ClassAttendanceHeader."No.Series" := 'ATT';
            ClassAttendanceHeader."Subject Code" := SubjectCode;
            ClassAttendanceHeader.Section := Section;
            ClassAttendanceHeader."Global Dimension 1 Code" := CollegeCode;
            ClassAttendanceHeader."Global Dimension 2 Code" := DepartmentCode;
            //ClassAttendanceHeader.Validate("Attendance Type", ClassAttendanceHeader."Attendance Type"::Regular);
            ClassAttendanceHeader."Batch Code" := Batch;
            FinalClassTimeTable."Attendance Date" := WorkDate();
            ClassAttendanceHeader."Room No." := RoomNo;
            ClassAttendanceHeader."Time Slot" := Timeslot;
            ClassAttendanceHeader."Time Table No" := SrNumber;
            ClassAttendanceHeader.Validate("Start Time", StartTime);
            ClassAttendanceHeader.Validate("End Time", EndTime);
            If FinalClassTimeTable.Get(SrNumber) then begin
                FinalClassTimeTable."Atttendance By" := Employeecode;
                FinalClassTimeTable.Attendance := 1;
                FinalClassTimeTable.Modify();
            end;
            IF ClassAttendanceHeader.INSERT() then
                EXIT('Success' + ' ' + FORMAT(ClassAttendanceHeader."No."))
            ELSE
                EXIT('Failed' + ' ' + FORMAT(ClassAttendanceHeader."No."));
        end Else
            EXIT('Duplicate' + ' ' + FORMAT(RecClassAttendanceHeaderCS."No."));
    end;

    procedure WebAPIInsertReRegistration(CollegeCode: Code[20]; AcadmicYear: Code[20]; DepartmentCode: Code[20]; SubjectCode: Code[20]; SubjuectName: text[100]; Semester: Code[20]; StudentNo: Code[20]; CourseCode: Code[20]; Grad: Code[20]; Credit: Code[20]; SubjectType: Code[20]): Text[50]
    var
        RegistrationStudent: Record "Registration Student-CS";
        RegistrationStudent1: Record "Registration Student-CS";
        EntryNo: Integer;
    begin
        RegistrationStudent1.Reset();
        if RegistrationStudent1.FindLast() then
            EntryNo := RegistrationStudent1."Entry No."
        else
            EntryNo := 0;
        RegistrationStudent.Init();
        RegistrationStudent."Entry No." := EntryNo + 1;
        RegistrationStudent.Validate("Academic Year", AcadmicYear);
        RegistrationStudent.Validate("Global Dimension 1 Code", CollegeCode);
        RegistrationStudent.Validate("Global Dimension 2 Code", DepartmentCode);
        RegistrationStudent.Validate("Subject Code", SubjectCode);
        RegistrationStudent.Validate("Subject Name", SubjuectName);
        RegistrationStudent.Validate(Semester, Semester);
        RegistrationStudent.Validate("Student No.", StudentNo);
        RegistrationStudent.Validate("Course Code", CourseCode);
        RegistrationStudent.Validate(Grade, Grad);
        RegistrationStudent.Validate(Credit, Credit);
        RegistrationStudent.Validate("Subject Type", SubjectType);
        IF RegistrationStudent.INSERT() then
            exit('Success')
        Else
            exit('Failed');

    end;

    procedure WebAPIMarksEntry(CollegeCode: Code[20]; Mark: Decimal; ObtWeight: Decimal; StudentNo: Code[20]; SrNo: Code[20]; ExamType: Option; Status: Option; ExamDate: Date;
    Attendence: Integer; Reason: Text[20]): Text[50]
    var
        InternalExamHeader: Record "Internal Exam Header-CS";
        InternalExamLine: Record "Internal Exam Line-CS";
        ExternalExamHeader: Record "External Exam Header-CS";
        ExternalExamLine: Record "External Exam Line-CS";
    begin
        IF ExamType = 1 then begin
            IF Attendence = 0 THEN BEGIN
                InternalExamLine.Reset();
                InternalExamLine.SetRange("Student No.", StudentNo);
                InternalExamLine.SetRange("Global Dimension 1 Code", CollegeCode);
                InternalExamLine.SetRange("Document No.", SrNo);
                if InternalExamLine.FindFirst() then Begin
                    repeat
                        InternalExamLine.Validate("Obtained Internal Marks", Mark);
                        InternalExamLine.Validate("Obtained Weightage", ObtWeight);
                        InternalExamLine.Validate(Status, Status);
                        InternalExamLine.Validate("Modified On", WorkDate());
                        InternalExamLine.Validate("Attendance Type", Attendence);
                        InternalExamLine.Validate(Reason, Reason);
                        InternalExamLine.Modify();
                    until InternalExamLine.Next() = 0;
                End;
                InternalExamHeader.Reset();
                InternalExamHeader.SetRange("No.", SrNo);
                IF InternalExamHeader.FINDFIRST() Then begin
                    InternalExamHeader.Status := Status;
                    InternalExamHeader."Exam Date" := ExamDate;
                    IF InternalExamHeader.MODIFY() THEN
                        EXIT('Success' + ' ' + SrNo)
                    ELSE
                        EXIT('Failed' + ' ' + SrNo);

                end;
            END;
        end;
        if ExamType = 2 then begin
            IF Attendence = 1 THEN BEGIN
                ExternalExamLine.Reset();
                ExternalExamLine.SetRange("Student No.", StudentNo);
                ExternalExamLine.SetRange("Global Dimension 1 Code", CollegeCode);
                ExternalExamLine.SetRange("Document No.", SrNo);
                if ExternalExamLine.FindFirst() then BEGIN
                    repeat
                        ExternalExamLine.Validate("External Mark", Mark);
                        ExternalExamLine.Validate(Status, Status);
                        ExternalExamLine.Modify();
                    Until ExternalExamLine.Next() = 0;

                END;
                ExternalExamHeader.Reset();
                ExternalExamHeader.SetRange("No.", SrNo);
                IF ExternalExamHeader.FINDFIRST() then begin
                    ExternalExamHeader.Status := Status;
                    IF ExternalExamHeader.Modify() then
                        EXIT('Success' + ' ' + SrNo)
                    ELSE
                        EXIT('Failed' + ' ' + SrNo);

                end;
            END;
        end;
    end;

    procedure WebAPIMarksPublishAll(CollegeCode: Code[20];
    Mark: Decimal; StudentNo: Code[20]; SrNo: Code[20];
    ExamType: Integer; Status: Option; Attendence: Integer): Text[50]
    var
        InternalExamHeader: Record "Internal Exam Header-CS";
        InternalExamLine: Record "Internal Exam Line-CS";
        ExternalExamHeader: Record "External Exam Header-CS";
        ExternalExamLine: Record "External Exam Line-CS";
        ClassAssignmentHeader: Record "Class Assignment Header-CS";
        ClassAssignmentLine: Record "Class Assignment Line-CS";
    Begin
        IF ExamType = 1 then begin
            IF Attendence = 0 THEN BEGIN
                InternalExamLine.Reset();
                InternalExamLine.SetRange("Document No.", SrNo);
                InternalExamLine.SetRange("Global Dimension 1 Code", CollegeCode);
                if InternalExamLine.FindFirst() then BEGIN
                    repeat
                        InternalExamLine.Status := Status;
                        InternalExamLine.Modify();
                    until InternalExamLine.NEXT() = 0;

                END;

                InternalExamHeader.Reset();
                InternalExamHeader.SetRange("No.", SrNo);
                IF InternalExamHeader.FindFirst() THEN BEGIN
                    InternalExamHeader.Status := Status;
                    IF InternalExamHeader.MODIFY() THEN
                        EXIT('Success' + ' ' + SrNo)
                    ELSE
                        EXIT('Failed' + ' ' + SrNo);
                end;
            END;
        end;
        IF ExamType = 2 then begin
            IF Attendence = 1 THEN BEGIN
                ExternalExamLine.Reset();
                ExternalExamLine.SetRange("Student No.", StudentNo);
                ExternalExamLine.SetRange("Document No.", SrNo);
                ExternalExamLine.SetRange("Global Dimension 1 Code", CollegeCode);
                if ExternalExamLine.FindFirst() then begin
                    repeat
                        ExternalExamLine."External Mark" := Mark;
                        ExternalExamLine.Status := Status;
                        ExternalExamLine.Modify();
                    until ExternalExamLine.Next() = 0;

                END;
                ExternalExamHeader.Reset();
                ExternalExamHeader.SetRange("No.", SrNo);
                IF ExternalExamHeader.FindFirst() THEN BEGIN
                    ExternalExamHeader.Status := Status;
                    IF ExternalExamHeader.MODIFY() THEN
                        EXIT('Success' + ' ' + SrNo)
                    ELSE
                        EXIT('Failed' + ' ' + SrNo);
                END;
            end;

        end;
        IF ExamType = 3 then begin
            ClassAssignmentLine.Reset();
            ClassAssignmentLine.SetRange("Assignment No.", SrNo);
            if ClassAssignmentLine.FindFirst() then BEGIN
                repeat
                    ClassAssignmentLine."Assignment Submitted" := true;
                    ClassAssignmentLine.Status := 2;
                    ClassAssignmentLine.Modify();
                until ClassAssignmentLine.Next() = 0;
            END;

            ClassAssignmentHeader.RESET();
            ClassAssignmentHeader.SetRange("Assignment No.", SrNo);
            IF ClassAssignmentHeader.FindFirst() THEN BEGIN
                ClassAssignmentHeader."Assignment Submitted" := true;
                ClassAssignmentHeader."Assignment Status" := 2;
                IF ClassAssignmentHeader.MODIFY() THEN
                    EXIT('Success' + ' ' + SrNo)
                ELSE
                    EXIT('Failed' + ' ' + SrNo);
            END;
        end;
    END;



    procedure WebAPIUpdateStudentClassAttendance(CollegeCode: Code[20]; facultycode: Code[20]; AcadmicYear: Code[20]; Remark: Text[100]; Reason: Text[20]; Attendancetype: Option; "Date": Date; StudentNo: Code[20]; SrNo: Code[20]): Text[50]
    var
        ClassAttendanceLine: Record "Class Attendance Line-CS";
    begin
        ClassAttendanceLine.Reset();
        ClassAttendanceLine.SetRange("Student No.", StudentNo);
        ClassAttendanceLine.SetRange("Document No.", SrNo);
        if ClassAttendanceLine.FindFirst() then Begin
            ClassAttendanceLine."Attendance Type" := Attendancetype;
            ClassAttendanceLine.Validate(Remark, Remark);
            ClassAttendanceLine."Reason Code" := Reason;
            If ClassAttendanceLine.MODIFY() THEN
                EXIT('Success' + ' ' + StudentNo)
            Else
                EXIT('Failed' + ' ' + StudentNo);
        End;

    end;

    procedure WebAPIUpdateStudentExamAttendance(CollegeCode: Code[20]; Attendancetype: Option; "Date": Date; StudentNo: Code[20]; DocumentNo: Code[20]; acadmicYear: Code[20]): Text[50]
    var
        ExternalAttendanceLine: Record "External Attendance Line-CS";
    begin
        ExternalAttendanceLine.SetRange("Student No.", StudentNo);
        ExternalAttendanceLine.SetRange("Document No.", DocumentNo);
        ExternalAttendanceLine.SetRange("Academic Year", acadmicYear);
        ExternalAttendanceLine.SetFilter("Global Dimension 1 Code", '%1|%2', CollegeCode, '');
        if ExternalAttendanceLine.FindFirst() then Begin
            repeat
                ExternalAttendanceLine.Validate("Attendance Type", Attendancetype);
                ExternalAttendanceLine.Validate("Exam Date", "Date");
                ExternalAttendanceLine.Modify();
            until ExternalAttendanceLine.Next() = 0;
            EXIT('Success' + ' ' + StudentNo);
        End;
    end;

    procedure WebAPIpublishallassignment(AssignmentNo: Code[20]): Text[50]
    var
        ClassAssignmentLine: Record "Class Assignment Line-CS";
        ClassAssignmentHeader: Record "Class Assignment Header-CS";
    begin
        ClassAssignmentLine.Reset();
        ClassAssignmentLine.SetRange("Assignment No.", AssignmentNo);
        if ClassAssignmentLine.FindFirst() then BEGIN
            repeat
                ClassAssignmentLine."Assignment Submitted" := true;
                ClassAssignmentLine.Status := 2;
                ClassAssignmentLine.Modify();
            until ClassAssignmentLine.Next() = 0;
        END;
        if ClassAssignmentHeader.Get(AssignmentNo) then begin
            ClassAssignmentHeader."Assignment Submitted" := true;
            ClassAssignmentHeader."Assignment Status" := 2;
            IF ClassAssignmentHeader.MODIFY() THEN
                EXIT('Success' + ' ' + AssignmentNo)
            ELSE
                EXIT('Failed' + ' ' + AssignmentNo);
        end;
    end;

    procedure WebAPIUpdateMobileNumberEmailNumber(email: Text[80]; mobileno: Text[30]; No: Code[20]; Semester: Code[20]; Acadmicyear: Code[20]; coursecode: Code[20]; GD1: Code[20]): Text[50]
    var
        StudentMaster: Record "Student Master-CS";
    begin
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", No);
        StudentMaster.SetRange(Semester, Semester);
        StudentMaster.SetRange("Academic Year", Acadmicyear);
        StudentMaster.SetRange("Course Code", coursecode);
        StudentMaster.SetRange("Global Dimension 1 Code", GD1);
        if StudentMaster.FindFirst() then begin
            StudentMaster."E-Mail Address" := email;
            StudentMaster."Mobile Number" := mobileno;
            StudentMaster."Pending For Registration" := false;
            IF StudentMaster.MODIFY() THEN
                EXIT('Success' + ' ' + No)
            ELSE
                EXIT('Failed' + ' ' + No)
        end;
    end;

    procedure WebAPIUpdatepercentageinSubjectColOptionalSubjectCol(attendancepercentage: Decimal;
    studentno: Code[20]; Course: Code[20]; Subjectcode: Code[20]; acadmicyear: Code[20]; subjectType: Code[20])
    var
        MainStudentSubject: Record "Main Student Subject-CS";
        AdmitCardLine: Record "Admit Card Line-CS";
        ExternalAttendanceLine: Record "External Attendance Line-CS";
        OptionalStudentSubject: Record "Optional Student Subject-CS";
    begin
        if subjectType = 'CORE' then begin
            MainStudentSubject.Reset();
            MainStudentSubject.SetRange("Student No.", studentno);
            MainStudentSubject.SetRange(Course, Course);
            MainStudentSubject.SetRange("Subject Code", Subjectcode);
            MainStudentSubject.SetRange("Academic Year", acadmicyear);
            MainStudentSubject.SetRange("Subject Type", subjectType);
            if MainStudentSubject.FindFirst() then
                repeat
                    MainStudentSubject.validate("Attendance Percentage", attendancepercentage);
                    MainStudentSubject.Modify();
                until MainStudentSubject.Next() = 0;

            AdmitCardLine.Reset();
            AdmitCardLine.SetRange("Student No.", studentno);
            AdmitCardLine.SetRange(Course, Course);
            AdmitCardLine.SetRange("Subject Code", Subjectcode);
            AdmitCardLine.SetRange("Academic Year", acadmicyear);
            AdmitCardLine.SetRange("Subject Type", subjectType);
            if AdmitCardLine.FindFirst() then
                repeat
                    AdmitCardLine.Detained := false;
                    AdmitCardLine.Modify();
                until AdmitCardLine.Next() = 0;

            ExternalAttendanceLine.Reset();
            ExternalAttendanceLine.SetRange("Student No.", studentno);
            ExternalAttendanceLine.SetRange(Course, Course);
            ExternalAttendanceLine.SetRange("Subject Code", Subjectcode);
            ExternalAttendanceLine.SetRange("Subject Type", subjectType);
            if ExternalAttendanceLine.FindFirst() then
                repeat
                    ExternalAttendanceLine."Attendance %" := attendancepercentage;
                    ExternalAttendanceLine.Detained := false;
                    ExternalAttendanceLine.Modify();
                until ExternalAttendanceLine.Next() = 0;

        end;
        if (subjectType = 'ELECTIVE') or (subjectType = 'PROGRAM ELECTIVE') or (subjectType = 'OPEN ELECTIVE') then begin
            OptionalStudentSubject.Reset();
            OptionalStudentSubject.SetRange("Student No.", studentno);
            OptionalStudentSubject.SetRange(Course, Course);
            OptionalStudentSubject.SetRange("Subject Code", Subjectcode);
            OptionalStudentSubject.SetRange("Academic Year", acadmicyear);
            OptionalStudentSubject.SetRange("Subject Type", subjectType);
            if OptionalStudentSubject.FindFirst() then
                repeat
                    OptionalStudentSubject.validate("Attendance Percentage", attendancepercentage);
                    OptionalStudentSubject.Modify();
                until OptionalStudentSubject.Next() = 0;

            AdmitCardLine.Reset();
            AdmitCardLine.SetRange("Student No.", studentno);
            AdmitCardLine.SetRange(Course, Course);
            AdmitCardLine.SetRange("Subject Code", Subjectcode);
            AdmitCardLine.SetRange("Academic Year", acadmicyear);
            AdmitCardLine.SetRange("Subject Type", subjectType);
            if AdmitCardLine.FindFirst() then
                repeat
                    AdmitCardLine.Detained := false;
                    AdmitCardLine.Modify();
                until AdmitCardLine.Next() = 0;

            ExternalAttendanceLine.Reset();
            ExternalAttendanceLine.SetRange("Student No.", studentno);
            ExternalAttendanceLine.SetRange(Course, Course);
            ExternalAttendanceLine.SetRange("Subject Code", Subjectcode);
            ExternalAttendanceLine.SetRange("Subject Type", subjectType);
            if ExternalAttendanceLine.FindFirst() then
                repeat
                    ExternalAttendanceLine."Attendance %" := attendancepercentage;
                    ExternalAttendanceLine.Detained := false;
                    ExternalAttendanceLine.Modify();
                until ExternalAttendanceLine.Next() = 0;
        end;
    end;


    procedure WebAPIUpdateStudentAttendancelineCondonation(Acadmicyear: Code[20]; SubjectCode: Code[20]; studentno: Code[20]; Stardate: Date; Enddate: Date): Text[50]
    var
        ClassAttendanceLine: Record "Class Attendance Line-CS";
    begin
        ClassAttendanceLine.Reset();
        ClassAttendanceLine.SetRange("Academic Year", Acadmicyear);
        ClassAttendanceLine.SetRange("Subject Code", SubjectCode);
        ClassAttendanceLine.SetRange("Student No.", studentno);
        ClassAttendanceLine.SetRange(Date, Stardate, Enddate);
        if ClassAttendanceLine.FindFirst() then begin
            repeat
                ClassAttendanceLine."Attendance Condonation" := true;
                ClassAttendanceLine.Modify();
            until ClassAttendanceLine.Next() = 0;
            Exit('Success' + ' ' + studentno);
        end;
    end;

    procedure WebAPIApprovedorRejectDate(Status: Integer; ApprovdBy: Code[20]; ApprovedforDepartment: Text[20]; strname: text[100]; RequestNo: Code[20]; RejectRemark: text[100]): Text[50]
    var
        WithdrawalStudent: Record "Withdrawal Student-CS";
    begin
        WithdrawalStudent.Reset();
        WithdrawalStudent.SetRange("No.", RequestNo);
        if WithdrawalStudent.FindFirst() then
            // repeat
            if (ApprovedforDepartment = 'FINANCE') and (Status = 1) then
                WithdrawalStudent."Withdrawal Status" := 2
            else
                if (ApprovedforDepartment = 'FINANCE') and (Status = 2) then
                    WithdrawalStudent."Withdrawal Status" := 3;
        IF WithdrawalStudent.Modify() then
            EXIT('Success' + ' ' + RequestNo)
        ELSE
            EXIT('Failed' + ' ' + RequestNo)
        //until WithdrawalStudent.Next() = 0;
    end;


    procedure WebAPIApprovedorRejectDateForNOC(Status: Integer; ApprovdBy: Code[20]; ApprovedforDepartment: Text[20]; strname: Code[20]; RequestNo: Code[20]; RejectRemark: text[100]): Text[50]
    var
        WithdrawalStudent: Record "Withdrawal Student-CS";
        StudentMaster: Record "Student Master-CS";
    begin
        if (ApprovedforDepartment = 'FINANCE') and (Status = 1) then begin
            WithdrawalStudent.Reset();
            WithdrawalStudent.SetRange("No.", RequestNo);
            if WithdrawalStudent.FindFirst() then
                //repeat
            WithdrawalStudent."Withdrawal Status" := 2;
            IF WithdrawalStudent.MODIFY() THEN
                Exit('Success' + ' ' + RequestNo)
            ELSE
                Exit('Failed' + ' ' + RequestNo);
            //until WithdrawalStudent.Next() = 0;

            if StudentMaster.Get(strname) then begin
                StudentMaster."Course Completion NOC" := false;
                StudentMaster.Modify();
            end;

        end else
            if (ApprovedforDepartment = 'FINANCE') and (Status = 2) then begin
                WithdrawalStudent.Reset();
                WithdrawalStudent.SetRange("No.", RequestNo);
                if WithdrawalStudent.FindFirst() then
                    repeat
                        WithdrawalStudent."Withdrawal Status" := 3;
                        WithdrawalStudent.Modify();
                    until WithdrawalStudent.Next() = 0;
            end;
    end;

    procedure WebAPIUpdateRTGSList(OrderId: Code[20]; updatedby: Code[50]): Text[50]
    var
        RTGSPaymentSummary: Record "RTGS Payment Summary-CS";
    begin
        RTGSPaymentSummary.Reset();
        RTGSPaymentSummary.SetRange("Request No.", OrderId);
        if RTGSPaymentSummary.FindFirst() then begin
            RTGSPaymentSummary."Approved By" := FORMAT(updatedby);
            RTGSPaymentSummary."Approved Date" := Today();
            IF RTGSPaymentSummary.MODIFY() THEN
                Exit('Success' + ' ' + OrderId)
            ELSE
                Exit('Failed' + ' ' + OrderId);
        end;
    end;

    procedure WebAPIUpdateRTGSListRejected(OrderId: Code[20]; updatedby: Code[50]): Text[50]
    var
        RTGSPaymentSummary: Record "RTGS Payment Summary-CS";
    begin
        RTGSPaymentSummary.Reset();
        RTGSPaymentSummary.SetRange("Request No.", OrderId);
        if RTGSPaymentSummary.FindFirst() then begin
            RTGSPaymentSummary."Approved By" := FORMAT(updatedby);
            RTGSPaymentSummary."Rejected Date" := Today();
            IF RTGSPaymentSummary.MODIFY() THEN
                Exit('Success' + ' ' + OrderId)
            ELSE
                Exit('Failed' + ' ' + OrderId);
        end;
    end;


    procedure WebAPIUpdateStudentDetails(StudentNo: Code[20]; NameasonCertificate: Text[100];
DateofJoining: Date; MobileNumber: Text[30]; PhoneNumber: Text[30]; EMailAddress: Text[50];
BloodGroup: Option; Nationality: Text[30]; Religion: Code[20]; Caste: Code[20]; MotherTongue: Code[20];
MaritalStatus: Option; Domicile: Code[20]; PANCardNumber: Code[20]; AadharCardNumber: Code[20];
BankACNumber: Code[20]; AccountHolderName: text[50]; IFSCCode: Code[11]; Branch: Text[30];
BankName: Text[30]; PassPortNo: Text[20]; PassPortExpiryDate: Date; PassPortIssuedDate: Date;
VisaNo: Text[20]; VisaIssuedDate: Date; VisaExpiryDate: Date; RCRPNumber: Text[20]; RCRPIssuedDate: Date;
RCRPExpiryDate: Date; SFormID: Text[20]; FathersName: Text[40]; FathersOccupation: Text[20];
FatherContactNumber: Text[20]; FatherEmailID: Text[50]; MothersName: Text[40]; MothersOccupation: Text[20];
MotherContactNumber: Text[20]; MotherEmailID: Text[50]; GuardianName: Text[40]; GuardianOccupation: Text[20];
GuardianContactNumber: Text[20]; GuardianEmailID: Text[50]; SponsorerName: Text[50]; Relation: Text[30];
SponsorerAddressLine1: Text[30]; SponsorerAddressLine2: Text[30]; SponsorerAddressLine3: Text[30];
SponsorerCity: Text[30]; SponsorerState: Code[10]; SponsorerCountry: Code[10]; SponsorerPinCode: Code[10];
AlternateEmailAddress: Code[50]; OfficialCorrespoMobileNo: Code[20]; EmergencyContactNo: Code[20];
TransfAdmissionHigherSem: Boolean; AddmissiontowhichSem: Code[5]; NumberofCreditsEarned: Decimal;
"10th": Text[5]; PhysicMathOptional: Text[5]; Addressee: Text[50]; Address1: Text[50]; Address2: Text[50];
City: Text[30]; PostCode: Code[20]; State: Code[10]; CountryCode: Code[10]; Address3: Text[50]; Address4: Text[50];
AddressTo: Text[50]; CorCity: Text[30]; CorState: Code[10]; CorCountryCode: Code[10]; CorPostCode: Code[20];
NameofBoardUniv: Text[50]; SchoolCollegeName: Text[50]; Yearofpassing: Integer; Description: Text[100];
Grade: Text[20]; MarkObtained: Decimal; PercentageofMark: Decimal; CommunicationAddress: Option;
GlobalDimension1Code: Code[20]; GlobalDimension2Code: Code[20]; OptionalSubjectName: Code[20]; studentStatus: Option;
SameAsPermanent: Boolean)
    var
        StudentMaster: Record "Student Master-CS";
        PortalUserLogin: Record "Portal User Login-CS";
        QualifyingDetailStud: Record "Qualifying Detail Stud-CS";
    begin
        if StudentMaster.Get(StudentNo) then begin
            StudentMaster."Name as on Certificate" := NameasonCertificate;
            StudentMaster."Mobile Number" := MobileNumber;
            StudentMaster."Phone Number" := PhoneNumber;
            StudentMaster."E-Mail Address" := EMailAddress;
            StudentMaster."Blood Group" := BloodGroup;
            StudentMaster.Nationality := Nationality;
            StudentMaster.Religion := Religion;
            StudentMaster.Caste := Caste;
            StudentMaster."Mother Tongue" := MotherTongue;
            StudentMaster."Marital Status" := MaritalStatus;
            StudentMaster.Domicile := Domicile;
            StudentMaster."PAN Card Number" := PANCardNumber;
            StudentMaster."Aadhar Card Number" := AadharCardNumber;
            StudentMaster."Bank A/C Number" := BankACNumber;
            StudentMaster."Account Holder Name" := AccountHolderName;
            StudentMaster."IFSC Code" := IFSCCode;
            StudentMaster.Branch := Branch;
            StudentMaster."Bank Name" := BankName;
            StudentMaster."Pass Port No." := PassPortNo;
            StudentMaster."Pass Port Expiry Date" := PassPortExpiryDate;
            StudentMaster."Pass Port Issued Date" := PassPortIssuedDate;
            StudentMaster."Visa No." := VisaNo;
            StudentMaster."Visa Issued Date" := VisaIssuedDate;
            StudentMaster."Visa Expiry Date" := VisaExpiryDate;
            StudentMaster."RC/RP Number" := RCRPNumber;
            StudentMaster."RC/RP Issued Date" := RCRPIssuedDate;
            StudentMaster."RC/RP Expiry Date" := RCRPExpiryDate;
            StudentMaster."S Form ID" := SFormID;
            StudentMaster."Fathers Name" := FathersName;
            StudentMaster."Fathers Occupation" := FathersOccupation;
            StudentMaster."Father Contact Number" := FatherContactNumber;
            StudentMaster."Father Email ID" := FatherEmailID;
            StudentMaster."Mothers Name" := MothersName;
            StudentMaster."Mothers Occupation" := MothersOccupation;
            StudentMaster."Mother Contact Number" := MotherContactNumber;
            StudentMaster."Mother Email ID" := MotherEmailID;
            StudentMaster."Guardian Name" := GuardianName;
            StudentMaster."Guardian Occupation" := GuardianOccupation;
            StudentMaster."Guardian Contact Number" := GuardianContactNumber;
            StudentMaster."Guardian Email ID" := GuardianEmailID;
            StudentMaster."Sponsorer Name" := SponsorerName;
            StudentMaster.Relation := Relation;
            StudentMaster."Sponsorer Address Line 1" := SponsorerAddressLine1;
            StudentMaster."Sponsorer Address Line 2" := SponsorerAddressLine2;
            StudentMaster."Sponsorer Address Line 3" := SponsorerAddressLine3;
            StudentMaster."Sponsorer City" := SponsorerCity;
            StudentMaster."Sponsorer State" := SponsorerState;
            StudentMaster."Sponsorer Country" := SponsorerCountry;
            StudentMaster."Sponsorer Pin Code" := SponsorerPinCode;
            StudentMaster."Alternate Email Address" := AlternateEmailAddress;
            StudentMaster."Official Correspo Mobile No." := OfficialCorrespoMobileNo;
            StudentMaster."Emergency Contact No." := EmergencyContactNo;
            StudentMaster."Transf Admission Higher Sem" := TransfAdmissionHigherSem;
            StudentMaster."Addmission to which Sem" := AddmissiontowhichSem;
            StudentMaster."Number of Credits Earned" := NumberofCreditsEarned;
            StudentMaster."10th %" := "10th";
            StudentMaster."Physic Math Optional %" := PhysicMathOptional;
            StudentMaster.Addressee := Addressee;
            StudentMaster.Address1 := Address1;
            StudentMaster.Address2 := Address2;
            // if (PostCode <> '') or (City <> '') then
            //     CreatePostCode(PostCode, City, State, CountryCode);
            StudentMaster."Post Code" := PostCode;
            StudentMaster.City := City;
            StudentMaster.State := State;
            StudentMaster."Country Code" := CountryCode;
            StudentMaster.Address3 := Address3;
            StudentMaster.Address4 := Address4;
            StudentMaster."Address To" := AddressTo;
            // if (CorPostCode <> '') or (CorCity <> '') then
            //     CreatePostCode(CorPostCode, CorCity, CorState, CorCountryCode);

            StudentMaster."Cor Post Code" := CorPostCode;
            StudentMaster."Cor City" := CorCity;
            StudentMaster."Cor State" := CorState;
            StudentMaster."Cor Country Code" := CorCountryCode;
            StudentMaster."Student Status" := StudentStatus;
            StudentMaster."Same As Permanent Address" := SameAsPermanent;
            //StudentMaster."All Fields Updated",
            StudentMaster."Communication Address" := CommunicationAddress;

            StudentMaster.Modify();
        end;
        PortalUserLogin.Reset();
        PortalUserLogin.SetRange(U_ID, StudentNo);
        if PortalUserLogin.FindFirst() then
            repeat
                PortalUserLogin.MobileNo := MobileNumber;
                PortalUserLogin.Email := EMailAddress;
                PortalUserLogin.Modify();
            until PortalUserLogin.Next() = 0;

        QualifyingDetailStud.Reset();
        QualifyingDetailStud.SetRange("Student No.", StudentNo);
        if not QualifyingDetailStud.FindFirst() then begin
            QualifyingDetailStud.Init();
            QualifyingDetailStud."Student No." := StudentNo;
            //QualifyingDetailStud.Validate("Qualifying Exam"
            //QualifyingDetailStud.Validate("Qualifying Year of Passing" 
            //QualifyingDetailStud.Validate("Exam Marks/Grade/Points" 
            //QualifyingDetailStud.Validate("College last Studied"
            QualifyingDetailStud."University/Board" := NameofBoardUniv;
            QualifyingDetailStud."Global Dimension 1 Code" := GlobalDimension1Code;
            QualifyingDetailStud."Global Dimension 2 Code" := GlobalDimension2Code;
            QualifyingDetailStud."Optional Subject Name" := OptionalSubjectName;
            //QualifyingDetailStud.Validate(Updated 
            QualifyingDetailStud.Insert();
        end;
    end;

    procedure WebAPIupdateStudentPassword(password: Code[20]; enrollment: Code[20]; currpassword: Text[50])
    var
        StudentMaster: Record "Student Master-CS";
        PortalUserLogin: Record "Portal User Login-CS";
    begin
        if StudentMaster.Get(enrollment) then begin
            StudentMaster.Password := password;
            StudentMaster.Modify();
        end;
        PortalUserLogin.Reset();
        PortalUserLogin.SetRange(U_ID, enrollment);
        if PortalUserLogin.FindFirst() then begin
            PortalUserLogin.Validate(Password, password);
            PortalUserLogin.Modify();
        end;
    end;

    procedure WebAPIupdateDeptStatusrejact(Status: Option; strname: Text[100]; RejectRemark: text[100]; ApprovedforDepartment: Text[50]; RequestNo: Code[20]; ApprovdBy: Code[20]): Text[50]
    var
        WithdrawalStudent: Record "Withdrawal Student-CS";
    begin
        WithdrawalStudent.Reset();
        WithdrawalStudent.SetRange("No.", RequestNo);
        if WithdrawalStudent.FindFirst() then begin
            if (ApprovedforDepartment = 'FINANCE') and (Status = 1) then begin
                WithdrawalStudent."Withdrawal Status" := Status;
                IF WithdrawalStudent.Modify() then
                    EXIT('Success' + ' ' + RequestNo)
                ELSE
                    EXIT('Failed' + ' ' + RequestNo);
            end else
                if (ApprovedforDepartment = 'FINANCE') and (Status = 2) then begin
                    WithdrawalStudent."Withdrawal Status" := Status;
                    IF WithdrawalStudent.Modify() then
                        EXIT('Success' + ' ' + RequestNo)
                    ELSE
                        EXIT('Failed' + ' ' + RequestNo);
                end;
        end;
    end;

    procedure WebAPIupdateDeptStatusrejactForNOC(Status: Option; strname: text[100]; RejectRemark: text[100]; ApprovedforDepartment: Text[50]; RequestNo: code[20]; ApprovdBy: code[20])
    var
        WithdrawalStudent: Record "Withdrawal Student-CS";
        StudentMaster: Record "Student Master-CS";
    begin
        WithdrawalStudent.Reset();
        WithdrawalStudent.SetRange("No.", RequestNo);
        if WithdrawalStudent.FindFirst() then begin
            if (ApprovedforDepartment = 'FINANCE') and (Status = 1) then begin
                WithdrawalStudent."Withdrawal Status" := Status;
                WithdrawalStudent.Modify();
                If StudentMaster.Get(strname) then begin
                    StudentMaster."Course Completion NOC" := false;
                    StudentMaster.Modify();
                end;
            end else
                if (ApprovedforDepartment = 'FINANCE') and (Status = 2) then begin
                    WithdrawalStudent."Withdrawal Status" := Status;
                    WithdrawalStudent.Modify();
                end;
        end;
    end;

    procedure WebAPIUpdateStudentStatusAfterWithdrawal(RegistrationNo: Code[20]; StudentStatus: Option): Text[50]
    var
        StudentMaster: Record "Student Master-CS";
    begin
        StudentMaster.Reset();
        StudentMaster.SetRange("Enrollment No.", RegistrationNo);
        if StudentMaster.FindFirst() then begin
            StudentMaster."Student Status" := StudentStatus;
            IF StudentMaster.MODIFY() THEN
                EXIT('Success' + ' ' + RegistrationNo)
            ELSE
                EXIT('Failed' + ' ' + RegistrationNo);
        end;
    end;

    procedure WebAPIupdatetransactionfailed(studentno: Code[20]; reciept: Text[50]; error: Text[250]; docno: Code[20]; lineno: Integer; successfail: Integer)
    var
        FailedTransactionDetails: Record "Failed Transaction Details-CS";
    begin
        FailedTransactionDetails.Reset();
        FailedTransactionDetails.SetRange("Student No.", studentno);
        FailedTransactionDetails.SetRange("Reciept No.", reciept);
        FailedTransactionDetails.SetRange("Line No.", lineno);
        if FailedTransactionDetails.FindFirst() then begin
            FailedTransactionDetails."Success/Fail" := successfail;
            FailedTransactionDetails."Documnet No." := docno;
            FailedTransactionDetails."Error Message" := error;
            FailedTransactionDetails.Modify();
        end;
    end;
    // CSPL-00092::27-03-2020 END 

    //CSPL-00114::31032020: Start
    procedure WebAPIupdateAssignmentMark(markobtained: Decimal; Remark: Text[100]; studentno: Code[20]; assignmentno: Code[20]; weightage: Decimal; examdate: Date)
    var
        ClassAssignmentHeader: Record "Class Assignment Header-CS";
        ClassAssignmentLine: Record "Class Assignment Line-CS";
    begin
        ClassAssignmentHeader.Reset();
        ClassAssignmentHeader.SetRange("Assignment No.", assignmentno);
        If ClassAssignmentHeader.FindFirst() then Begin
            ClassAssignmentHeader."Assignment Submitted" := true;
            ClassAssignmentHeader."Assignment Status" := ClassAssignmentHeader."Assignment Status"::Published;
            ClassAssignmentHeader."Exam Date" := examdate;
            ClassAssignmentHeader.Modify();

            ClassAssignmentLine.Reset();
            ClassAssignmentLine.SetRange("Assignment No.", assignmentno);
            ClassAssignmentLine.SetRange("Student No.", studentno);
            If ClassAssignmentLine.FindFirst() then begin
                ClassAssignmentLine."Marks Obtained" := markobtained;
                ClassAssignmentLine."Weightage Obtained" := weightage;
                ClassAssignmentLine."Assignment Submitted" := true;
                ClassAssignmentLine.Status := ClassAssignmentLine.Status::Published;
                ClassAssignmentLine.Modify();
            End
        End
    end;

    procedure WebAPIupdateCancelInTimeTable(eventid: Integer; Createby: Code[20]): Text[50]
    var
        FinalClassTimeTable: Record "Final Class Time Table-CS";

    begin
        FinalClassTimeTable.Reset();
        FinalClassTimeTable.SetRange("S.No.", eventid);
        If FinalClassTimeTable.FindFirst() then Begin
            FinalClassTimeTable.Cancelled := true;
            FinalClassTimeTable."Atttendance By" := Createby;
            FinalClassTimeTable."Attendance Date" := TODAY();

            IF FinalClassTimeTable.MODIFY() THEN
                Exit('Success' + ' ' + FORMAT(eventid))
            ELSE
                Exit('Failed' + ' ' + FORMAT(eventid));
        End
    End;

    procedure WebAPIupdateFacultyPassword(Password: Code[30]; enrollment: Code[20]; CurrentPassword: text[30])
    var
        EmployeeRec: Record Employee;
        PortalUser: Record "Portal User Login-CS";

    begin
        EmployeeRec.Reset();
        EmployeeRec.SetRange("No.", enrollment);
        EmployeeRec.SetRange("Web Portal Password", CurrentPassword);
        EmployeeRec.SetRange("Web portal Access", true);
        If EmployeeRec.FindFirst() then Begin
            EmployeeRec."Web Portal Password" := Password;
            EmployeeRec.Modify();
        End;

        PortalUser.Reset();
        PortalUser.SetRange(U_ID, enrollment);
        PortalUser.SetRange(Password, CurrentPassword);
        If PortalUser.FindFirst() then Begin
            PortalUser.Password := Password;
            PortalUser.Modify();
        End
    End;

    procedure WebAPIUpdateParrwordFromParent(ParentNo: Code[20]; Password: Code[30]): Text
    var
        PortalUser: Record "Portal User Login-CS";

    begin
        PortalUser.Reset();
        PortalUser.SetRange(U_ID, ParentNo);
        If PortalUser.FindFirst() then Begin
            PortalUser.Password := Password;
            PortalUser."Password Changed" := true;
            IF PortalUser.Modify() Then
                Exit('Success' + ' ' + FORMAT(ParentNo))
            ELSE
                Exit('Failed' + ' ' + FORMAT(ParentNo));
        End
    End;

    procedure WebAPIUpdateParrwordFromStudent(StudentNo: Code[20]; Password: Code[30]): Text
    var
        StudentMaster: Record "Student Master-CS";
        PortalUser: Record "Portal User Login-CS";

    begin
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", StudentNo);
        If StudentMaster.FindFirst() then Begin
            StudentMaster.Password := Password;
            IF StudentMaster.MODIFY() THEN Begin
                PortalUser.Reset();
                PortalUser.SetRange(U_ID, StudentNo);
                If PortalUser.FindFirst() then Begin
                    PortalUser.Password := Password;
                    IF PortalUser.MODIFY() THEN
                        exit('Success')
                    Else
                        exit('Failed');
                End;
            End Else
                exit('Failed');
        End;
    End;

    procedure WebAPIupdatePresentDetailsFromProfile(StudentNo: Code[20]; AlternateEmailAddress: Text[50]; OfficialCorrespoMobileNo: Text[30]; Address3: Text[50]; Address4: Text[50]; CorCity: Text[30]; CorState: Code[10]; CorCountryCode: Code[10]; CorPostCode: Code[20]; CommunicationAddress: Option; AddressTo: Text[50]): Text
    var
        StudentMaster: Record "Student Master-CS";
        PortalUser: Record "Portal User Login-CS";

    begin
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", StudentNo);
        If StudentMaster.FindFirst() then Begin
            StudentMaster."E-Mail Address" := AlternateEmailAddress;
            StudentMaster."Phone Number" := OfficialCorrespoMobileNo;
            StudentMaster.Address3 := Address3;
            StudentMaster.Address4 := Address4;
            StudentMaster."Address To" := AddressTo;
            // if (CorPostCode <> '') or (CorCity <> '') then
            //     CreatePostCode(CorPostCode, CorCity, CorState, CorCountryCode);
            StudentMaster."Cor Post Code" := CorPostCode;
            StudentMaster."Cor City" := CorCity;
            StudentMaster."Cor State" := CorState;
            StudentMaster."Cor Country Code" := CorCountryCode;


            StudentMaster."Communication Address" := CommunicationAddress;
            IF StudentMaster.MODIFY() THEN Begin
                PortalUser.Reset();
                PortalUser.SetRange(U_ID, StudentNo);
                If PortalUser.FindFirst() then Begin
                    PortalUser.Email := AlternateEmailAddress;
                    PortalUser.MobileNo := OfficialCorrespoMobileNo;
                    IF PortalUser.MODIFY() THEN
                        exit('Success')
                    Else
                        exit('Failed');
                End;
            End Else
                exit('Failed');
        End;
    End;

    procedure WebAPIupdatePosttransactionfailed(studentno: Code[20]; Receipt: Code[20]; status: text[250]; Lineno: Integer): Text
    var
        FailedTransactionDetail: Record "Failed Transaction Details-CS";
    begin

        IF (Lineno = 0) then begin
            FailedTransactionDetail.Reset();
            FailedTransactionDetail.SetRange("Reciept No.", Receipt);
            FailedTransactionDetail.SetRange("Student No.", studentno);
            If FailedTransactionDetail.FindFirst() then begin
                FailedTransactionDetail."Post Status" := status;
                IF FailedTransactionDetail.MODIFY() THEN
                    exit('Success')
                Else
                    exit('Failed');
            End
        End;

        IF (Lineno <> 0) then begin
            FailedTransactionDetail.Reset();
            FailedTransactionDetail.SetRange("Reciept No.", Receipt);
            FailedTransactionDetail.SetRange("Student No.", studentno);
            FailedTransactionDetail.SetRange("Line No.", Lineno);
            If FailedTransactionDetail.FindFirst() then begin
                FailedTransactionDetail."Post Status" := status;
                IF FailedTransactionDetail.MODIFY() THEN
                    exit('Success')
                Else
                    exit('Failed');
            End
        End;
    end;

    procedure WebAPITransactionFailedInfo(entryno: Integer; document: Code[20]; documentType: Option; templateName: Code[20]; batch: Code[20]; studentno: Code[20]; enrollmentno: Code[20]; studentname: Text[100]; Amount: Decimal; currencycode: Code[10]; bankaccountno: Code[20]; applytoDocNo: Code[20]; feecode: Code[20]; description: Text[100]; transactionno: Code[20]; reciept: Code[20]; balaccountno: Code[20]; errormessage: Text[250]; successfail: Option): Text
    var
        FailedTransactionDetail: Record "Failed Transaction Details-CS";
    begin
        FailedTransactionDetail.Init();
        FailedTransactionDetail."Student No." := studentno;
        FailedTransactionDetail."Reciept No." := reciept;
        FailedTransactionDetail."Line No." := entryno;
        FailedTransactionDetail."Documnet No." := document;
        FailedTransactionDetail."Document Type" := documentType;
        FailedTransactionDetail."Template Name" := templateName;
        FailedTransactionDetail."Batch Name" := batch;
        FailedTransactionDetail."Enrollment No." := enrollmentno;
        FailedTransactionDetail."Student Name" := studentname;
        FailedTransactionDetail.Amount := Amount;
        FailedTransactionDetail."Currency Code" := currencycode;
        FailedTransactionDetail."Bank Account No." := bankaccountno;
        FailedTransactionDetail."Apply To Doc No." := applytoDocNo;
        FailedTransactionDetail."Fee Code" := feecode;
        FailedTransactionDetail.Description := description;
        FailedTransactionDetail."Transaction No." := transactionno;
        FailedTransactionDetail."Bal. Account No." := balaccountno;
        FailedTransactionDetail."Error Message" := errormessage;
        FailedTransactionDetail."Success/Fail" := successfail;
        FailedTransactionDetail."Posting Date" := TODAY();
        IF FailedTransactionDetail.Insert() then
            exit('Success')
        Else
            exit('Failed');
    end;

    procedure WebAPIsaveAssignmentMark(markobtained: Decimal; Remark: Text[100]; studentno: Code[20]; assignmentno: Code[20]; weightage: Decimal; examdate: Date): Text
    var
        ClassAssignmentLine: Record "Class Assignment Line-CS";
    begin
        ClassAssignmentLine.Reset();
        ClassAssignmentLine.SetRange("Assignment No.", assignmentno);
        ClassAssignmentLine.SetRange("Student No.", studentno);
        If ClassAssignmentLine.FindFirst() then begin
            ClassAssignmentLine."Marks Obtained" := markobtained;
            ClassAssignmentLine."Weightage Obtained" := weightage;
            ClassAssignmentLine."Assignment Submitted" := true;
            ClassAssignmentLine.Status := ClassAssignmentLine.Status::Published;
            IF ClassAssignmentLine.MODIFY() THEN
                exit('Success')
            Else
                exit('Failed');
        End;

    end;

    //CSPL-00114::31032020: End
    //CSPL-00058    START DATE -> 02-04-2020
    procedure WebAPIUpdateApproveAndRejectedData(applicationno: code[20]; acadmicyear: code[10]; studentno: code[20]; AR: Integer; userid: Text[50]; Remark: text[250]; subjectCode: code[10]): Text[250];
    var
        ShortAttandanceAttach: Record "Short Attendance Attach-CS";
    begin
        ShortAttandanceAttach.Reset();
        ShortAttandanceAttach.SetRange("Application No.", applicationno);
        ShortAttandanceAttach.SetRange("Academic Year", acadmicyear);
        ShortAttandanceAttach.SetRange("Student No.", studentno);
        ShortAttandanceAttach.SetRange("Subject Code", subjectCode);
        IF ShortAttandanceAttach.FindFirst() then begin
            IF AR = 1 THEN begin
                ShortAttandanceAttach.Status := '1';
                ShortAttandanceAttach.Remark := Remark;
                ShortAttandanceAttach."Approved By" := FORMAT(UserId());
                ShortAttandanceAttach."Approved Date" := TODAY();
                IF ShortAttandanceAttach.Modify() then
                    exit('Success')
                Else
                    exit('Failed');
            end else begin
                if AR = 2 then begin
                    ShortAttandanceAttach.Status := '2';
                    ShortAttandanceAttach.Remark := Remark;
                    ShortAttandanceAttach."Approved By" := FORMAT(UserId());
                    ShortAttandanceAttach."Approved Date" := TODAY();
                    IF ShortAttandanceAttach.Modify() then
                        exit('Success')
                    Else
                        exit('Failed');
                end;
            end;
        end;
    end;

    procedure WebAPIInsertintDocumentshortattendance(studentno: code[20]; applicationno: code[20]; lineno: Integer; acadmicyear: code[10]; coursecode: code[20]; studentname: text[100]; semester: code[10]; subjectcode: code[10]; Documentpath: text[250]; documentname: text[50]; globaldimension1code: code[20]; globaldimension2code: code[20]; Createdby: text[30]; Documentdescription: text[50]; subjecttype: code[20]; section: code[10]; typecourse: Option; ByteImage: Byte; startdate: Date; enddate: Date): text[250];
    var
        ShortAttandanceAttach: Record "Short Attendance Attach-CS";
    begin
        ShortAttandanceAttach.Reset();
        ShortAttandanceAttach.Init();
        ShortAttandanceAttach."Application No." := applicationno;
        ShortAttandanceAttach."Student No." := studentno;
        ShortAttandanceAttach."Line No." := lineno;
        ShortAttandanceAttach."Academic Year" := acadmicyear;
        ShortAttandanceAttach."Course Code" := coursecode;
        ShortAttandanceAttach."Student Name" := studentname;
        ShortAttandanceAttach.Semester := semester;
        ShortAttandanceAttach."Subject Code" := subjectcode;
        ShortAttandanceAttach."Document Description" := Documentdescription;
        ShortAttandanceAttach."Document Name" := documentname;
        ShortAttandanceAttach."Document Path" := Documentpath;
        ShortAttandanceAttach."Global Dimension 1 Code" := globaldimension1code;
        ShortAttandanceAttach."Global Dimension 2 Code" := globaldimension2code;
        ShortAttandanceAttach."Created By" := Createdby;
        ShortAttandanceAttach."Subject Type" := subjecttype;
        ShortAttandanceAttach.Section := section;
        ShortAttandanceAttach."Type Of Course" := typecourse;
        //ShortAttandanceAttach.Attachment := ByteImage; //Image Hold
        IF ShortAttandanceAttach.Insert() then
            exit('Success')
        Else
            exit('Failed');
    end;

    procedure WebAPIInsertRERegistrationSubject(StudentNo: code[20]; course: code[20]; Semester: code[10]; AcademicYear: code[10]; SubjectCode: code[20]; Description: text[100]; SubjectType: code[20]; StudentName: text[100]; CollegeCode: code[20]; DepartmentCode: code[20]; grade: code[10]; credit: Decimal): text[250]
    var
        tab_MainStudentSubject: Record 50072;
        Main_OptionalSubject: Record "Main&Optional Subject Log-CS";
        OptionalSubjectLog: Record "Optional Student Subject-CS";

    begin
        tab_MainStudentSubject.Reset();
        tab_MainStudentSubject.SetRange("Student No.", StudentNo);
        tab_MainStudentSubject.SetRange(Course, course);
        tab_MainStudentSubject.SetRange("Subject Code", SubjectCode);
        tab_MainStudentSubject.SetRange(Semester, Semester);
        tab_MainStudentSubject.SetRange("Global Dimension 1 Code", CollegeCode);
        tab_MainStudentSubject.SetFilter("Subject Type", 'CORE');
        IF tab_MainStudentSubject.FindFirst() then begin
            //Insert Student No and Line No.
            Main_OptionalSubject.Init();
            Main_OptionalSubject.Reset();
            Main_OptionalSubject.SetRange("Student No.", tab_MainStudentSubject."Student No.");
            if Main_OptionalSubject.FindLast() then
                Main_OptionalSubject."Line No." += 10000
            ELSE
                Main_OptionalSubject."Line No." := 10000;

            Main_OptionalSubject."Student No." := StudentNo;
            Main_OptionalSubject."Subject Code" := SubjectCode;
            Main_OptionalSubject."Student Name" := StudentName;
            IF Main_OptionalSubject.INSERT() then
                exit('Success')
            else
                exit('Failed');
            tab_MainStudentSubject.Rename(tab_MainStudentSubject."Academic Year", AcademicYear);

            tab_MainStudentSubject."Re-Registration" := true;
            tab_MainStudentSubject."Re-Registration Exam Only" := false;
            tab_MainStudentSubject."Make Up Examination" := false;
            tab_MainStudentSubject.Revaluation1 := false;
            tab_MainStudentSubject.Revaluation2 := false;
            tab_MainStudentSubject."Special Exam" := false;
            tab_MainStudentSubject."Re-Registration Date" := TODAY();
            tab_MainStudentSubject.Publish := false;
            tab_MainStudentSubject.Modify();


        end;

        OptionalSubjectLog.Reset();
        OptionalSubjectLog.SetRange("Student No.", StudentNo);
        OptionalSubjectLog.SetRange(Course, course);
        OptionalSubjectLog.SetRange("Subject Code", SubjectCode);
        OptionalSubjectLog.SetRange("Academic Year", AcademicYear);
        OptionalSubjectLog.SetRange(Semester, Semester);
        OptionalSubjectLog.SetRange("Global Dimension 1 Code", CollegeCode);
        OptionalSubjectLog.SetFilter("Subject Type", '<>%1', 'CORE');
        IF OptionalSubjectLog.FindFirst() then begin
            //Insert Student No and Line No.
            Main_OptionalSubject.Init();
            Main_OptionalSubject.Reset();
            Main_OptionalSubject.SetRange("Student No.", tab_MainStudentSubject."Student No.");
            if Main_OptionalSubject.FindLast() then
                Main_OptionalSubject."Line No." += 10000
            ELSE
                Main_OptionalSubject."Line No." := 10000;

            Main_OptionalSubject."Student No." := StudentNo;
            Main_OptionalSubject."Subject Code" := SubjectCode;
            Main_OptionalSubject."Student Name" := StudentName;
            IF Main_OptionalSubject.INSERT() then
                exit('Success')
            else
                exit('Failed');

            OptionalSubjectLog.Rename(OptionalSubjectLog."Academic Year", AcademicYear);

            OptionalSubjectLog."Re-Registration" := true;
            OptionalSubjectLog."Re-Registration Exam Only" := false;
            OptionalSubjectLog."Make Up Examination" := false;
            OptionalSubjectLog.Revaluation1 := false;
            OptionalSubjectLog.Revaluation2 := false;
            OptionalSubjectLog."Special Exam" := false;
            OptionalSubjectLog."Re-Registration Date" := TODAY();
            OptionalSubjectLog.Publish := false;
            OptionalSubjectLog.Modify();



        end;
    end;

    procedure WebAPIinsertintDocumentsMakeupExamination(studentno: code[20];
    applicationno: code[20];
     acadmicyear: code[10];
     coursecode: code[20];
     studentname: text[100];
      semester: code[10];
       subjectcode: code[10];
        Documentpath: text[250];
         documentname: text[50];
          globaldimension1code: code[20];
          globaldimension2code: code[20];
          Createdby: text[30];
          Documentdescription: text[50];
           subjecttype: code[20]; typecourse: Option): text[250]
    var
        MakeupExamdoc: Record "MakeUp Exam Document-CS";
        RecNoSeriesLine: record "No. Series Line";
        LineNo1: Integer;
    begin
        MakeupExamdoc.Reset();
        if MakeupExamdoc.FindLast() then
            LineNo1 := MakeupExamdoc."Line No" + 10000
        else
            LineNo1 := 10000;

        MakeupExamdoc.Init();
        MakeupExamdoc."Student No" := studentno;
        MakeupExamdoc."Application No" := applicationno;
        MakeupExamdoc."Line No" := LineNo1;
        MakeupExamdoc."Academic Year" := acadmicyear;
        MakeupExamdoc."Course Code" := coursecode;
        MakeupExamdoc."Student Name" := studentname;
        MakeupExamdoc.Semester := semester;
        MakeupExamdoc."Subject Code" := subjectcode;
        MakeupExamdoc."Document Path" := Documentpath;
        MakeupExamdoc."Document Name" := documentname;
        MakeupExamdoc."Global Dimension 1 Code" := globaldimension1code;
        MakeupExamdoc."Global Dimension 2 Code" := globaldimension2code;
        MakeupExamdoc."Created By" := Createdby;
        MakeupExamdoc."Created Date" := TODAY();
        MakeupExamdoc."Document Description" := Documentdescription;
        MakeupExamdoc."Subject Type" := subjecttype;
        MakeupExamdoc."Type Of Course" := typecourse;
        if MakeupExamdoc.Insert() then
            EXIT('Success' + ' ' + FORMAT(LineNo1))
        ELSE
            EXIT('Failed' + ' ' + FORMAT(LineNo1));

        RecNoSeriesLine.Reset();
        RecNoSeriesLine.SetRange("Series Code", 'LINENO');
        IF RecNoSeriesLine.FindFirst() then begin
            RecNoSeriesLine."Last No. Used" := FORMAT(LineNo1);
            RecNoSeriesLine.Modify();
        end;
    end;

    procedure WebAPIinsertintDocumentsReExamination(studentno: code[20]; applicationno: code[20]; acadmicyear: code[10]; coursecode: code[20]; studentname: text[100]; semester: code[10]; subjectcode: code[10]; Documentpath: text[250]; documentname: text[50]; globaldimension1code: code[20]; globaldimension2code: code[20]; Createdby: text[30]; Documentdescription: text[50]; subjecttype: code[20]; section: code[10]; typecourse: Option; ExamType: Option): text[250]
    var
        DocResetApplication: Record 50195;
        RecNoSeriesLine: record "No. Series Line";
        LineNo1: Integer;
    begin
        DocResetApplication.Reset();
        DocResetApplication.Reset();
        if DocResetApplication.FindLast() then
            LineNo1 := DocResetApplication."Line No" + 10000
        else
            LineNo1 := 10000;

        DocResetApplication.Init();
        DocResetApplication."Application No" := applicationno;
        DocResetApplication."Student No" := studentno;
        DocResetApplication."Line No" := LineNo1;
        DocResetApplication."Academic Year" := acadmicyear;
        DocResetApplication."Course Code" := coursecode;
        DocResetApplication."Student Name" := studentname;
        DocResetApplication.Semester := semester;
        DocResetApplication."Subject Code" := subjectcode;
        DocResetApplication."Document Description" := Documentdescription;
        DocResetApplication."Document Name" := documentname;
        DocResetApplication."Document Path" := Documentpath;
        DocResetApplication."Global Dimension 1 Code" := globaldimension1code;
        DocResetApplication."Global Dimension 2 Code" := globaldimension2code;
        DocResetApplication."Created By" := Createdby;
        DocResetApplication."Subject Type" := subjecttype;
        //DocResetApplication.Section := section; //Field does not exist in table
        DocResetApplication."Type Of Course" := typecourse;
        DocResetApplication."Exam Type" := ExamType;
        if DocResetApplication.Insert() then
            exit('Success' + ' ' + FORMAT(LineNo1))
        else
            exit('Failed' + ' ' + FORMAT(LineNo1));

        RecNoSeriesLine.Reset();
        RecNoSeriesLine.SetRange("Series Code", 'LINENO');
        IF RecNoSeriesLine.FindFirst() then begin
            RecNoSeriesLine."Last No. Used" := FORMAT(LineNo1);
            RecNoSeriesLine.Modify();
        end;
    end;

    procedure WebAPIInsertIntoApplyForReExamination(Applicationno: code[20]; StudentNo: code[20]; Coursecode: code[20]; Subjectcode: code[20]; SubjectName: text[100]; Semester: code[10]; year: code[20]; AcademicYear: code[20]; grade: code[20]; Session: code[50]; GlobalDimension1Code: code[20]; GlobalDimension2Code: code[20]; CreatedBy: text[50]; CreatedByName: text[100]; UpdatedBy: text[50]; UpdateByName: text[100]; SubjectClassification: code[20]; Subjecttype: Code[20]; program: code[10]; TypeOfCourse: Option; section: code[10]; StudentName: text[100]; StudentGroup: code[20]; Studentbatch: code[20]; credit: Decimal; EnrollmentNo_: code[20]; Examtype: Code[10]): text[250]
    var
        MakeupExamination: Record "MakeUp Examination-CS";
        NoSeriesLine: Record "No. Series Line";
        MainStudentSubject: Record "Main Student Subject-CS";
        OptionalStudentSub: Record "Optional Student Subject-CS";
    begin
        MakeupExamination.Reset();
        MakeupExamination.Init();
        MakeupExamination."Application No." := Applicationno;
        MakeupExamination."Student No." := StudentNo;
        MakeupExamination."Course Code" := Coursecode;
        MakeupExamination."Subject Code" := Subjectcode;
        MakeupExamination."Subject Name" := SubjectName;
        MakeupExamination.Semester := Semester;
        MakeupExamination.Year := year;
        MakeupExamination."Academic Year" := AcademicYear;
        MakeupExamination.Grade := grade;
        MakeupExamination.Session := Session;
        MakeupExamination."Global Dimension 1 Code" := GlobalDimension1Code;
        MakeupExamination."Global Dimension 2 Code" := GlobalDimension2Code;
        MakeupExamination."Created By" := CreatedBy;
        MakeupExamination."Created By Name" := CreatedByName;
        MakeupExamination."Updated By" := UpdatedBy;
        MakeupExamination."Updated By Name" := UpdateByName;
        MakeupExamination."Subject Class" := SubjectClassification;
        MakeupExamination."Subject Type" := Subjecttype;
        MakeupExamination.Program := program;
        MakeupExamination."Type Of Course" := TypeOfCourse;
        MakeupExamination.Section := section;
        MakeupExamination."Student Name" := SubjectName;
        MakeupExamination."Student Group" := StudentGroup;
        MakeupExamination."Student Batch" := Studentbatch;
        MakeupExamination.Credit := credit;
        MakeupExamination."Enrollment No." := EnrollmentNo_;
        MakeupExamination."Exam Classification" := Examtype;
        IF MakeupExamination.Insert() then begin
            NoSeriesLine.Reset();
            NoSeriesLine.SetRange("Series Code", 'REX');
            IF NoSeriesLine.FindLast() then begin
                NoSeriesLine."Last No. Used" := Applicationno;
                NoSeriesLine."Last Date Used" := TODAY();
                NoSeriesLine.Modify();
            end;

            IF (Examtype = 'SPECIAL') and (Subjecttype = 'CORE') then begin
                MainStudentSubject.Reset();
                MainStudentSubject.SetRange("Student No.", StudentNo);
                MainStudentSubject.SetRange("Subject Code", Subjectcode);
                MainStudentSubject.SetRange(Course, Coursecode);
                IF MainStudentSubject.FindFirst() then begin
                    MainStudentSubject."Re-Registration Exam Only" := True;
                    MainStudentSubject.Publish := false;
                    MainStudentSubject.Modify()
                end;
            end;

            IF (Examtype = 'SPECIAL') and (Subjecttype <> 'CORE') then begin
                OptionalStudentSub.Reset();
                OptionalStudentSub.SetRange("Student No.", StudentNo);
                OptionalStudentSub.SetRange("Subject Code", Subjectcode);
                OptionalStudentSub.SetRange(Course, Coursecode);
                IF OptionalStudentSub.FindFirst() then begin
                    OptionalStudentSub."Re-Registration Exam Only" := True;
                    OptionalStudentSub.Publish := false;
                    OptionalStudentSub.Modify()
                end;
            end;
            exit('Success');
        end else
            exit('Failed');
    end;

    //CSPL-00058    END DATE -> 02-04-2020

    //CSPL-ABHISHEK
    procedure WebAPIHostelApplicationInsert(StudentNo: Code[20]; WithSpouse: Boolean; HostelPref1: Code[20]; HostelPref2: Code[20]; HostelPref3: Code[20]; RoomCategoryCode1: Code[20]; RoomCategoryCode2: Code[20];
    RoomCategoryCode3: Code[20]; HousingGroup1: code[20]; HousingGroup2: code[20]; HousingGroup3: code[20];
      PreferenceRemarks: Text[100]; RoomMateName: text[50]; RoomMateEmail: text[80]
      ; AY: Code[20]; Sem: Code[10]; Term: Option FALL,SPRING,SUMMER; FlightDate: Text; FlightTime: Text; FlightNumber: Text; AirlineCarrier: Text
      ; MedicalCondition: Boolean; Disable: Boolean; TravelWithSpouse: Boolean; TravelWithSpouseChild: Boolean; TravelWithServicAnimal: Boolean; OtherBool: Boolean; OtherDesc: Text[250]; SpecialRoommatePref: Text[1024]//GMCS//23//05//23
      ) Return: Text[50]

    var
        HostelApplicationRec: Record "Housing Application";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        StudentReg: Record "Student Registration-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentMasterRec.Get(StudentNo);

        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        EducationSetupRec.SetRange("Pre Housing App. Allowed", False);
        IF EducationSetupRec.FindFirst() then begin
            StudentReg.Reset();
            StudentReg.SetRange("Student No", StudentNo);
            StudentReg.SetRange(Semester, Sem);
            StudentReg.SetRange("Academic Year", AY);
            StudentReg.SetRange(Term, Term);
            if not StudentReg.findfirst() then
                Error('You Can not apply for the Housing.');
        end;

        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        // EducationSetupRec.FindFirst();
        GlSetup.Get();
        GlSetup.Testfield("Housing Application No.");

        HostelApplicationRec.RESET();
        HostelApplicationRec.SETRANGE("Student No.", StudentNo);
        HostelApplicationRec.SETRANGE(Semester, Sem);
        HostelApplicationRec.SETRANGE("Academic Year", AY);
        HostelApplicationRec.SETRANGE(Term, Term);
        HostelApplicationRec.Setrange(Posted, false);
        HostelApplicationRec.SetRange(Status, HostelApplicationRec.Status::Vacated);
        IF NOT HostelApplicationRec.FINDFIRST() THEN BEGIN
            HostelApplicationRec.INIT();
            HostelApplicationRec."Application No." := NoSeriesMgt.GetNextNo(GlSetup."Housing Application No.", 0D, TRUE);
            HostelApplicationRec."Entry From Portal" := True;
            HostelApplicationRec.Validate("Student No.", StudentNo);
            HostelApplicationRec."Student Name" := StudentMasterRec."Student Name";
            HostelApplicationRec."Enrolment No." := StudentMasterRec."Enrollment No.";
            HostelApplicationRec."Application Date" := WORKDATE();
            HostelApplicationRec."With Spouse" := WithSpouse;
            HostelApplicationRec.Validate("Housing Pref. 1", HostelPref1);
            HostelApplicationRec.Validate("Housing Pref. 2", HostelPref2);
            HostelApplicationRec.Validate("Housing Pref. 3", HostelPref3);
            if HousingGroup1 <> '' then
                HostelApplicationRec."Housing Group Pref.1" := HousingGroup1;
            if HousingGroup2 <> '' then
                HostelApplicationRec."Housing Group Pref.2" := HousingGroup2;
            if HousingGroup3 <> '' then
                HostelApplicationRec."Housing Group Pref.3" := HousingGroup3;
            // HostelApplicationRec."Room Category Pref.1" := RoomCategoryCode1;
            // HostelApplicationRec."Room Category Pref.2" := RoomCategoryCode2;
            // HostelApplicationRec."Room Category Pref.3" := RoomCategoryCode3;
            HostelApplicationRec.Validate("Room Category Pref.1", RoomCategoryCode1);
            HostelApplicationRec.Validate("Room Category Pref.2", RoomCategoryCode2);
            HostelApplicationRec.Validate("Room Category Pref.3", RoomCategoryCode3);

            HostelApplicationRec."Medical Condition" := MedicalCondition;//GMCS//23//05//23  FALL 2023 OLR Changes
            HostelApplicationRec.Disability := Disable;
            HostelApplicationRec."Traveling With Spouse" := TravelWithSpouse;
            HostelApplicationRec."Travel Spouse & Child" := TravelWithSpouseChild;
            HostelApplicationRec."Travel Ser. Animal" := TravelWithServicAnimal;
            HostelApplicationRec.Other := OtherBool;
            HostelApplicationRec."Other Description" := OtherDesc;
            HostelApplicationRec."Special Roommate Preference" := SpecialRoommatePref; //GMCS//23//05//23  FALL 2023 OLR Changes

            HostelApplicationRec."Preference Remarks" := PreferenceRemarks;
            HostelApplicationRec."Room Mate Name Pref" := RoomMateName;
            HostelApplicationRec."Room Mate Email Pref" := RoomMateEmail;
            HostelApplicationRec.validate("Academic Year", AY);
            HostelApplicationRec.validate(Semester, Sem);
            HostelApplicationRec.validate(Term, Term);
            HostelApplicationRec.Status := HostelApplicationRec.Status::"Pending for Approval";
            HostelApplicationRec.StartEndDateCreation(HostelApplicationRec, HostelApplicationRec."Student No.", HostelApplicationRec."Academic Year", HostelApplicationRec.Term, HostelApplicationRec.Semester, HostelApplicationRec."Global Dimension 1 Code");
            IF FlightDate <> '' then
                Evaluate(HostelApplicationRec."Flight Arrival Date", FlightDate);
            IF FlightTime <> '' then
                Evaluate(HostelApplicationRec."Flight Arrival Time", FlightTime);
            HostelApplicationRec."Flight Number" := FlightNumber;
            HostelApplicationRec."Airline/Carrier" := AirlineCarrier;
            HostelApplicationRec.Inserted := TRUE;

            If HostelApplicationRec.INSERT(true) then
                EXIT('Success' + ' ' + HostelApplicationRec."Application No.")
            Else
                EXIT('Failed' + ' ' + HostelApplicationRec."Application No.");

        END ELSE
            exit('Duplicate');
    END;



    procedure WebAPIHostelChangeApplicationInsert(StudentNo: Code[20]; Type: Option;
    EffectiveDate: text; ReasonCode: Code[10]; ReasonDescription: Text[100];
    WithSpouse: Boolean; HostelPref1: Code[20]; HostelPref2: Code[20]; HostelPref3: Code[20];
    RoomCategoryCode: Code[20]; OriginalAppNo: code[20]; Remarks: Text[100]; HousingID: Code[20];
    PresentAdd1: Text[50]; PresentAdd2: text[50]; PresentAdd3: Text[50]; LeaseAgrNo: code[20]; LeaseAgrGrp: Text[50];
    PostCode: Code[20]; City: Text[30]; Country: Code[10]; SState: Text[30]; RoomMateName: text[50]; RoomMateEmail: text[80]) Return: Text[50]
    var
        HousingChangeRec: Record "Housing Change Request";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        IF StudentMaster.HousingHoldCheck(StudentNo) = true Then
            EXIT('Failed')
        Else begin
            // StudentMaster.Get(StudentNo);
            // EducationSetupRec.Reset();
            // EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
            // EducationSetupRec.FindFirst();
            GlSetup.get();
            GlSetup.Testfield("Housing Change/Vacate No.");

            HousingChangeRec.RESET();
            HousingChangeRec.SETRANGE("Student No.", StudentNo);
            HousingChangeRec.Setrange(Posted, false);
            IF NOT HousingChangeRec.FINDFIRST() THEN BEGIN
                HousingChangeRec.INIT();
                HousingChangeRec."Application No." := NoSeriesMgt.GetNextNo(GlSetup."Housing Change/Vacate No.", 0D, TRUE);
                HousingChangeRec.Validate("Student No.", StudentNo);
                HousingChangeRec."Application Date" := WORKDATE();
                HousingChangeRec."Original Application No." := OriginalAppNo;
                HousingChangeRec.Validate("Housing ID", HousingID);
                HousingChangeRec.Validate("Housing Pref. 1", HostelPref1);
                HousingChangeRec.Validate("Housing Pref. 2", HostelPref2);
                HousingChangeRec.Validate("Housing Pref. 3", HostelPref3);
                HousingChangeRec."With Spouse" := WithSpouse;
                HousingChangeRec."Room Category Code" := RoomCategoryCode;
                HousingChangeRec."Room Mate Name Pref" := RoomMateName;
                HousingChangeRec."Room Mate Email Pref" := RoomMateEmail;
                HousingChangeRec.Type := Type;
                HousingChangeRec.Status := HousingChangeRec.Status::"Pending for Approval";
                IF EffectiveDate <> '' Then
                    Evaluate(HousingChangeRec."Effective Date", EffectiveDate);
                HousingChangeRec."Reason Code" := ReasonCode;
                HousingChangeRec."Reason Description" := ReasonDescription;
                HousingChangeRec.Remarks := Remarks;
                HousingChangeRec.Validate("Present Address1", PresentAdd1);
                HousingChangeRec.Validate("Present Address2", PresentAdd2);
                HousingChangeRec.Validate("Present Address3", PresentAdd3);
                HousingChangeRec.Validate("Lease Agreement/Contract No.", LeaseAgrNo);
                HousingChangeRec.Validate("Lease Agreement Group", LeaseAgrGrp);
                // if (PostCode <> '') or (City <> '') then
                //     CreatePostCode(PostCode, City, SState, Country);
                HousingChangeRec."Post Code" := PostCode;
                HousingChangeRec.City := City;
                HousingChangeRec.Validate(Country, Country);
                HousingChangeRec.County := SState;
                HousingChangeRec.Inserted := TRUE;
                If HousingChangeRec.INSERT(true) then begin
                    //if HousingChangeRec.Type = HousingChangeRec.Type::"Change Request" then
                    //HousingMailCod.MailSendforHousingChangeSubmit(StudentNo, HousingChangeRec."Application No.");
                    EXIT('Success' + ' ' + HousingChangeRec."Application No.")
                end else
                    EXIT('Failed' + ' ' + HousingChangeRec."Application No.");

            END ELSE
                exit('Duplicate');
        end;
    END;
    //CSPL-ABHISHEK

    procedure WebAPIUpdateClinicalDocumentAttachment(StudentNo: Code[20];
    EntryNo: Integer;
    DocumentCode: Code[250];
    DocumentsStatus: Option "Requested-Required","Portal Submitted","Submitted","On File","Rejected","Expired";
    TransactionNo: Code[50]) myText: Text[50];
    var
        StudentDocumentAttachment: Record "Student Document Attachment";
    begin
        StudentDocumentAttachment.Reset();
        if StudentDocumentAttachment.Get(EntryNo) then begin
            StudentDocumentAttachment.Validate("Transaction No.", TransactionNo);
            //StudentDocumentAttachment."Attached On" := AttachedOn;
            StudentDocumentAttachment."Documents Status" := DocumentsStatus;
            if StudentDocumentAttachment.Modify() then
                exit('Success ' + StudentNo)
            else
                exit('Failed ' + StudentNo);
        end
        else
            exit('Failed ' + StudentNo);
    end;


    procedure WebAPILeaveOfApplicationUpdate(StudentNo: Code[20]; StudentName: Text[100]; EnrolmentNo: Code[20]; AcademicYear: Code[20]; LSemester: Code[20];
             LeaveType: Option ELOA,SLOA,CLOA; StartDate: Text; EndDate: Text; LReason: Code[10]; LRemarks: Text[100]; LStatus: Option Pending,Submitted,Approved,Rejected; ReasonDesc: Text[500]; LDA: Text; pTerm: Option FALL,SPRING,SUMMER) myText: Text[100];
    var
        StudentLeaveofAbsence: Record "Student Leave of Absence";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        StudentMasterRec.Get(StudentNo);
        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        GlSetup.get();
        StudentLeaveofAbsence.Init();
        StudentLeaveofAbsence.Validate("Application No.", NoSeriesMgt.GetNextNo(GlSetup."Leave Of Absence No.", 0D, TRUE));

        StudentLeaveofAbsence."Application Date" := Today();
        StudentLeaveofAbsence.Validate("Student No.", StudentNo);
        StudentLeaveofAbsence."Student Name" := StudentName;
        StudentLeaveofAbsence."Enrolment No." := EnrolmentNo;
        StudentLeaveofAbsence."Academic Year" := AcademicYear;
        StudentLeaveofAbsence.Semester := LSemester;
        StudentLeaveofAbsence."Leave Types" := LeaveType;
        IF StartDate <> '' Then
            Evaluate(StudentLeaveofAbsence."Start Date", StartDate);
        IF EndDate <> '' Then
            Evaluate(StudentLeaveofAbsence."End Date", EndDate);
        StudentLeaveofAbsence.Reason := LReason;
        StudentLeaveofAbsence."Reason Description" := ReasonDesc;
        StudentLeaveofAbsence.Remarks := LRemarks;
        StudentLeaveofAbsence.Status := LStatus;
        StudentLeaveofAbsence.Term := pTerm;            //23Feb2023
        If LDA <> '' then
            Evaluate(StudentLeaveofAbsence."Last Date Of Attendance", LDA);
        if StudentLeaveofAbsence.Insert(true) then
            exit('Success ' + StudentLeaveofAbsence."Application No.")
        else
            exit('Failed ' + StudentLeaveofAbsence."Application No.");
    end;

    procedure WebAPILeaveApprovalsInsert(StudentNo: Code[20]; StudentName: Text[100]; ApplicationDate: Text;
              Status: Option Open,"Pending for Approval",Approved,Rejected; Remarks: Text[500]; ApprovedDepartment: Text[100]; RequestNo: Code[20];
              ApprovedBy: Code[50]; Course: Code[20]; RegistrationNo: Code[20];
              ApprovedRejectedDate: Text; RejectionRemark: Text[500]; TypeofLeaves: Option ELOA,SLOA,CLOA; StartDate: Text; EndDate: Text; FinalApproval: Boolean; pTerm: Option FALL,SPRING,SUMMER): text[50]
    var
        StudentLeaveofAbsence: Record "Student Leave of Absence";
        LeavesApprovalsRec: Record "Leaves Approvals";
        LineNo: Integer;

    begin
        StudentLeaveofAbsence.Reset();
        StudentLeaveofAbsence.SetRange("Application No.", RequestNo);
        StudentLeaveofAbsence.FindFirst();

        LeavesApprovalsRec.Reset();
        LeavesApprovalsRec.SetRange("Application No.", RequestNo);
        if LeavesApprovalsRec.FindLast() then
            LineNo := LeavesApprovalsRec."Line No." + 10000
        else
            LineNo := 10000;

        LeavesApprovalsRec.Reset();
        LeavesApprovalsRec.SetRange("Application No.", RequestNo);
        LeavesApprovalsRec.SetRange("Approved for Department", ApprovedDepartment);
        IF Not LeavesApprovalsRec.FindFirst() then begin
            LeavesApprovalsRec.Init();
            LeavesApprovalsRec."Application No." := RequestNo;
            LeavesApprovalsRec."Line No." := LineNo;
            LeavesApprovalsRec.Validate("Student No.", StudentNo);
            LeavesApprovalsRec."Student Name" := StudentName;
            if ApplicationDate <> '' then
                Evaluate(LeavesApprovalsRec."Application date", ApplicationDate);
            IF StartDate <> '' Then
                Evaluate(LeavesApprovalsRec."Start Date", StartDate);
            IF EndDate <> '' Then
                Evaluate(LeavesApprovalsRec."End Date", EndDate);
            LeavesApprovalsRec.status := status;
            LeavesApprovalsRec."Reason for Leave" := Remarks;
            LeavesApprovalsRec.Validate("Approved for Department", ApprovedDepartment);
            LeavesApprovalsRec."Approved By" := ApprovedBy;
            LeavesApprovalsRec.Course := Course;
            LeavesApprovalsRec.Status := LeavesApprovalsRec.Status::"Pending for Approval";
            LeavesApprovalsRec."Type of Leaves" := TypeofLeaves;
            LeavesApprovalsRec."Final Approval" := FinalApproval;
            LeavesApprovalsRec."Reason Code" := StudentLeaveofAbsence.Reason;
            LeavesApprovalsRec."Reason for Leave" := StudentLeaveofAbsence."Reason Description";
            if ApprovedRejectedDate <> '' then
                Evaluate(LeavesApprovalsRec."Approved On", ApprovedRejectedDate);
            LeavesApprovalsRec."Rejection Remark" := RejectionRemark;
            LeavesApprovalsRec.Term := pTerm;       //23Feb2023
            if LeavesApprovalsRec.Insert(true) then
                exit('Success' + ' ' + LeavesApprovalsRec."Application No." + ' ' + Format(LeavesApprovalsRec."Line No."))
            else
                exit('Failed' + ' ' + LeavesApprovalsRec."Application No." + ' ' + Format(LeavesApprovalsRec."Line No."));
        end;
    end;

    procedure WebAPILeaveApprovalStatusInsert(StudentNo: Code[20];
                  Status: Option Open,"Pending for Approval",Approved,Rejected;
                  ApprovedDepartment: Text[100]; RequestNo: Code[20];
                  TypeofLeaves: Option ELOA,SLOA,CLOA;
                  ApprovedBy: Code[50]; RejectedBy: Code[50]; RejectionRemark: Text[500];
                  LeaveStatus: Option Open,"Pending for Approval",Approved,Rejected): text[100]
    var
        LeavesApprovalsRec: Record "Leaves Approvals";
        StudentLeaveAbsenceRec: Record "Student Leave of Absence";

    begin
        LeavesApprovalsRec.Reset();
        LeavesApprovalsRec.SetRange("Student No.", StudentNo);
        LeavesApprovalsRec.SetRange("Approved for Department", ApprovedDepartment);
        LeavesApprovalsRec.SetRange("Application No.", RequestNo);
        IF LeavesApprovalsRec.FindFirst() then begin
            LeavesApprovalsRec.status := status;
            LeavesApprovalsRec."Approved By" := ApprovedBy;
            if ApprovedBy <> '' then
                LeavesApprovalsRec."Approved On" := WorkDate();
            LeavesApprovalsRec."Rejected By" := RejectedBy;
            if RejectedBy <> '' then
                LeavesApprovalsRec."Rejected On" := WorkDate();
            LeavesApprovalsRec."Rejection Remark" := RejectionRemark;
            LeavesApprovalsRec."Type of Leaves" := TypeofLeaves;
            if LeavesApprovalsRec.Modify() then begin
                if LeaveStatus = LeaveStatus::Approved then begin
                    StudentLeaveAbsenceRec.Reset();
                    StudentLeaveAbsenceRec.SetRange("Application No.", RequestNo);
                    if StudentLeaveAbsenceRec.FindFirst() then begin
                        StudentLeaveAbsenceRec.Status := StudentLeaveAbsenceRec.Status::Approved;
                        StudentLeaveAbsenceRec.Modify();
                    end;
                end;
                exit('Success' + ' ' + LeavesApprovalsRec."Application No.");
            end else
                exit('Failed' + ' ' + LeavesApprovalsRec."Application No.");
        end else
            Exit('No Record Found');

    end;

    procedure WebAPINonAffilatedHospitalApplicationInsert(
        GlobalDim1Code: Code[20];
        StudentNo: Code[20];
        LName: Text[100];
        LAddress: Text[50];
        LAddress_2: Text[50];
        LCity: Text[30];
        LPostCode: Code[10];
        LContact: Text[100];
        LContactTitle: Integer;
        LContactPhoneNo: Text[30];
        LContactEMail: Text[80];
        LPhoneNo: Text[30];
        LCountryRegionCode: Code[10];
        Email: Text[80];
        LACGMENo: Code[30];
        LResidency: Boolean;
        LAccreditation: Option " ",ACGME,AOA,"None";
        LSponsoringInstitution: Text[100];
        LSponsoredPrograms: Text[100];
        LProgramID: Text[50];
        LDMEName: Text[100];
        LDMEPhoneNo: Text[20];
        LDMEEmail: Text[100];
        LSupervisingPhysicianName: Text[100];
        LSupervisingPhoneNo: Text[20];
        LSupervisingEmail: Text[100];
        LConfirmed: Boolean;
        LConfirmedBy: Text[50];
        ApplicationDate: Date;
        ElectiveSubjectCode: Code[20];
        StartDate: Date;
        EndDate: Date
        ) Return: Text[100]
    var
        NonAffiliatedHospital: Record "Non-Affiliated Hospital";
    begin
        NonAffiliatedHospital.Init();
        NonAffiliatedHospital."Global Dimension 1 Code" := GlobalDim1Code;
        NonAffiliatedHospital."Application No." := '';
        NonAffiliatedHospital.Insert(true);

        NonAffiliatedHospital."Application Date" := ApplicationDate;
        NonAffiliatedHospital.Validate("Student No.", StudentNo);
        NonAffiliatedHospital.Validate(Name, LName);
        NonAffiliatedHospital.Address := LAddress;
        NonAffiliatedHospital."Address 2" := LAddress_2;
        NonAffiliatedHospital.City := LCity;
        NonAffiliatedHospital."Post Code" := LPostCode;
        NonAffiliatedHospital."Contact Title" := LContactTitle;
        NonAffiliatedHospital.Contact := LContact;
        NonAffiliatedHospital."Contact Phone No." := LContactPhoneNo;
        NonAffiliatedHospital."Contact E-Mail" := LContactEMail;
        NonAffiliatedHospital."Phone No." := LPhoneNo;
        NonAffiliatedHospital."Country/Region Code" := LCountryRegionCode;
        NonAffiliatedHospital."E-Mail" := Email;
        NonAffiliatedHospital."ACGME No." := LACGMENo;
        NonAffiliatedHospital."Residency" := LResidency;
        NonAffiliatedHospital.Accreditation := LAccreditation;
        NonAffiliatedHospital."Sponsoring Institution" := LSponsoringInstitution;
        NonAffiliatedHospital."Sponsored Programs" := LSponsoredPrograms;
        NonAffiliatedHospital."Program ID" := LProgramID;
        NonAffiliatedHospital."DME Name" := LDMEName;
        NonAffiliatedHospital."DME Phone No." := LDMEPhoneNo;
        NonAffiliatedHospital."DME Email" := LDMEEmail;
        NonAffiliatedHospital."Supervising Physician Name" := LSupervisingPhysicianName;
        NonAffiliatedHospital."Superviser Phone No." := LSupervisingPhoneNo;
        NonAffiliatedHospital."Superviser Email" := LSupervisingEmail;
        NonAffiliatedHospital.Validate("Student No.", StudentNo);
        NonAffiliatedHospital.Validate("Elective Course Code", ElectiveSubjectCode);
        NonAffiliatedHospital.Validate("Start Date", StartDate);
        NonAffiliatedHospital.Validate("End Date", EndDate);
        NonAffiliatedHospital.Confirmed := LConfirmed;
        NonAffiliatedHospital."Confirmed By" := LConfirmedBy;
        NonAffiliatedHospital."Confirmed On" := Today();
        NonAffiliatedHospital.Validate(Status, NonAffiliatedHospital.Status::"Pending for Approval");
        if NonAffiliatedHospital.MODIFY() then
            exit('Success ' + NonAffiliatedHospital."Application No.")
        else
            exit('Failed ' + NonAffiliatedHospital."Application No.");
    end;

    procedure WebAPISiteAndDatePreferenceInsert(
    GlobalDimension1Code: Code[20];
    CreationDate: Date;
    StudentNo: Code[20];
    EnrollmentNo: Code[20];
    PresetIDStartDate: Code[20];
    PFStartDate_1: Date; DocDueDate: Date;
    FirstPreferredSiteID: Code[20];
    SecondPreferredSiteID: Code[20];
    ThirdPreferredSiteID: Code[20];
    LConfirmed: Boolean;
    ConfirmedBy: Text[50];
    SPCLAccommodationRequired: Boolean) Return: Text[100];
    var
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        SDA: Record "Student Document Attachment";
        StudentMaster: record "Student Master-CS";
    begin
        if StudentNo = '' then
            Error('Student No. must not be blank.');
        if PresetIDStartDate = '' then
            Error('Preset ID Start Date must not be blank.');
        if FirstPreferredSiteID = '' then
            Error('First Preferred Site ID must not be blank.');

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        ClerkshipSiteAndDateSelection.Init();

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection."Application No." := '';
        ClerkshipSiteAndDateSelection."Global Dimension 1 Code" := GlobalDimension1Code;
        if not ClerkshipSiteAndDateSelection.Insert(true) then
            Error('Application No. not Generated.');

        ClerkshipSiteAndDateSelection."Creation Date" := CreationDate;
        ClerkshipSiteAndDateSelection.Validate("Student No.", StudentNo);
        ClerkshipSiteAndDateSelection.Validate("Preset Start Date ID", PresetIDStartDate);
        ClerkshipSiteAndDateSelection.Validate("First Preferred Site Type", ClerkshipSiteAndDateSelection."First Preferred Site Type"::"Affilated Hospital");
        ClerkshipSiteAndDateSelection.Validate("First Preferred Site ID", FirstPreferredSiteID);
        ClerkshipSiteAndDateSelection.Validate("Second Preferred Site Type", ClerkshipSiteAndDateSelection."Second Preferred Site Type"::"Affilated Hospital");
        ClerkshipSiteAndDateSelection.Validate("Second Preferred Site ID", SecondPreferredSiteID);
        ClerkshipSiteAndDateSelection.Validate("Third Preferred Site Type", ClerkshipSiteAndDateSelection."Third Preferred Site Type"::"Affilated Hospital");
        ClerkshipSiteAndDateSelection.Validate("Third Preferred Site ID", ThirdPreferredSiteID);
        ClerkshipSiteAndDateSelection."Special Accommodation Required" := SPCLAccommodationRequired;
        ClerkshipSiteAndDateSelection.Confirmed := LConfirmed;
        if LConfirmed = true then begin
            ClerkshipSiteAndDateSelection."Confirmed By" := StudentNo;
            ClerkshipSiteAndDateSelection."Confirmed On" := Today();
            ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::"Pending for Approval";
        end;
        ClerkshipSiteAndDateSelection."Status By" := '';
        ClerkshipSiteAndDateSelection."Status On" := 0D;

        SDA.Reset();
        SDA.SetRange("Student No.", StudentNo);
        SDA.SetRange("Document Category", 'CLINICAL');
        SDA.SetRange("Subject Code", 'DOCUMENTATION');
        if SDA.FindSet() then
            repeat
                SDA."Document Due" := ClerkshipSiteAndDateSelection."Document Due Date";
                SDA.Modify();
            until SDA.Next() = 0;

        if ClerkshipSiteAndDateSelection.Modify() then
            exit('Success ' + format(ClerkshipSiteAndDateSelection."Application No."))
        else
            exit('Failed ' + format(ClerkshipSiteAndDateSelection."Application No."));
    end;

    procedure WebAPISiteAndDatePreferenceUpdate(
    ApplicationNo: Code[20];
    StudentNo: Code[20];
    PresetIDStartDate: Code[20];
    FirstPreferredSiteID: Code[20];
    SecondPreferredSiteID: Code[20];
    ThirdPreferredSiteID: Code[20];
    SPCLAccommodationRequired: Boolean;
    LConfirmed: Boolean) Return: Text[100];
    var
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
    begin
        ClerkshipSiteAndDateSelection.Reset();
        if ClerkshipSiteAndDateSelection.Get(ApplicationNo) then begin
            ClerkshipSiteAndDateSelection.Validate("First Preferred Site ID", '');
            ClerkshipSiteAndDateSelection.Validate("Second Preferred Site ID", '');
            ClerkshipSiteAndDateSelection.Validate("Third Preferred Site ID", '');
            ClerkshipSiteAndDateSelection.Validate("Preset Start Date ID", PresetIDStartDate);
            ClerkshipSiteAndDateSelection.Validate("First Preferred Site Type", ClerkshipSiteAndDateSelection."First Preferred Site Type"::"Affilated Hospital");
            ClerkshipSiteAndDateSelection.Validate("First Preferred Site ID", FirstPreferredSiteID);
            ClerkshipSiteAndDateSelection.Validate("Second Preferred Site Type", ClerkshipSiteAndDateSelection."Second Preferred Site Type"::"Affilated Hospital");
            ClerkshipSiteAndDateSelection.Validate("Second Preferred Site ID", SecondPreferredSiteID);
            ClerkshipSiteAndDateSelection.Validate("Third Preferred Site Type", ClerkshipSiteAndDateSelection."Third Preferred Site Type"::"Affilated Hospital");
            ClerkshipSiteAndDateSelection.Validate("Third Preferred Site ID", ThirdPreferredSiteID);
            ClerkshipSiteAndDateSelection."Special Accommodation Required" := SPCLAccommodationRequired;
            if LConfirmed = true then begin
                ClerkshipSiteAndDateSelection.Confirmed := true;
                ClerkshipSiteAndDateSelection."Confirmed By" := StudentNo;
                ClerkshipSiteAndDateSelection."Confirmed On" := Today();
                ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::"Pending for Approval";
            end;
            ClerkshipSiteAndDateSelection."Status By" := '';
            ClerkshipSiteAndDateSelection."Status On" := 0D;
            ClerkshipSiteAndDateSelection."Reject Reason Code" := '';
            ClerkshipSiteAndDateSelection."Reject Reason Description" := '';
            if ClerkshipSiteAndDateSelection.Modify() then
                exit('Success ' + format(ClerkshipSiteAndDateSelection."Application No."))
            else
                exit('Failed ' + format(ClerkshipSiteAndDateSelection."Application No."));
        end
        else
            exit('NotFound ' + Format(ApplicationNo));
    end;

    procedure WebAPIUpdateStudentRoomWiseInventory(StudentNo: Code[20]; ApplicationNo: Code[20]; ItemNo: Code[20]; VerifiedBool: Boolean; Remarks: Text[100]): Text[100];
    var
        StudentRoomWiseInventory: Record "Student Room Wise Inventory";
    begin
        StudentRoomWiseInventory.Reset();
        StudentRoomWiseInventory.SetRange("Student No.", StudentNo);
        StudentRoomWiseInventory.SetRange("Application No.", ApplicationNo);
        StudentRoomWiseInventory.SetRange("Item No.", ItemNo);
        If StudentRoomWiseInventory.FindFirst() then begin
            StudentRoomWiseInventory.Validate("Quantity Verified Alloment", VerifiedBool);
            StudentRoomWiseInventory.Remarks := Remarks;
            if StudentRoomWiseInventory.Modify() then
                exit('Success' + ' ' + ApplicationNo)
            else
                exit('Failed' + ' ' + ApplicationNo);
        end;
    end;





    procedure WebAPIHousingIssueInsert(StudentNo: Code[20]; ApplicationNo: Code[20]; Issue: code[10]; Description: Text[250]; HousingID: Code[20]; StudentRemarks: Text[250]) Return: Text[50];
    var
        HousingIssueRec: Record "Housing Issue";
        HousingIssueRec1: Record "Housing Issue";
        GlSetup: Record "General Ledger Setup";
        AdmissionSetupRec: Record "Admission Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        // AdmissionSetupRec.Get();
        GlSetup.get();
        GlSetup.TestField(GlSetup."Housing Issue No.");
        HousingIssueRec1.Reset();
        HousingIssueRec1.SetRange("Application No.", ApplicationNo);
        HousingIssueRec1.SetRange("Student No.", StudentNo);
        HousingIssueRec1.SetRange("Issue Code", Issue);
        HousingIssueRec1.SetFilter(Status, '<>%1', HousingIssueRec1.Status::Resolved);
        IF Not HousingIssueRec1.FindFirst() then begin
            HousingIssueRec.INIT();
            HousingIssueRec.Validate("Document No.", NoSeriesMgt.GetNextNo(GlSetup."Housing Issue No.", 0D, TRUE));
            HousingIssueRec.Validate("Student No.", StudentNo);
            HousingIssueRec.Validate("Application No.", ApplicationNo);
            HousingIssueRec.Validate("Housing ID", HousingID);
            HousingIssueRec."Issue Code" := Issue;
            HousingIssueRec."Issue Description" := Description;
            HousingIssueRec."Remarks By Student" := StudentRemarks;
            If HousingIssueRec.INSERT(true) then
                EXIT('Success' + ' ' + HousingIssueRec."Document No.")
            Else
                EXIT('Failed' + ' ' + HousingIssueRec."Document No.");
        end Else
            EXIT('Duplicate' + ' ' + StudentNo);
    END;

    procedure WebAPIHousingIssueClose(DocumentNo: Code[20]; Remark: Text[250]) Return: Text[50];
    var
        HousingIssueRec1: Record "Housing Issue";
    begin
        HousingIssueRec1.Reset();
        HousingIssueRec1.SetRange("Document No.", DocumentNo);
        IF HousingIssueRec1.FindFirst() then begin
            HousingIssueRec1.Status := HousingIssueRec1.Status::Resolved;
            HousingIssueRec1.Updated := True;
            HousingIssueRec1."Remarks By Student" := Remark;
            HousingIssueRec1."Closed By Student" := True;
            If HousingIssueRec1.Modify() then
                EXIT('Success' + ' ' + HousingIssueRec1."Document No.")
            Else
                EXIT('Failed' + ' ' + HousingIssueRec1."Document No.");
        END;
    End;

    procedure WebAPIImmigrationDocumentUpload(StudentNo: Code[20];
    DocumentCategory: Option " ","Application Form","Passport Biodata","Stamp on Arrival Copy","Visa Copy","Return Ticket Copy","Passport Size Photo";
    DocumentSubCategory: Code[20]; DocumentPath: text[500]; DocumentID: Code[20];
    DocumentName: text[50];
    UpdatedDate: text) Return: Text[50]

    var
        ImmigrationDocumentUploadRec: Record "Immigration Document Upload";
        ImmigrationDocumentUploadRec1: Record "Immigration Document Upload";
    begin
        ImmigrationDocumentUploadRec1.RESET();
        ImmigrationDocumentUploadRec1.SETRANGE("Student No.", StudentNo);
        IF ImmigrationDocumentUploadRec1.FINDLAST() THEN
            ImmigrationDocumentUploadRec1."Line No." := ImmigrationDocumentUploadRec1."Line No." + 10000
        ELSE
            ImmigrationDocumentUploadRec1."Line No." := 10000;

        ImmigrationDocumentUploadRec.Init();
        ImmigrationDocumentUploadRec.Validate("Student No.", StudentNo);
        ImmigrationDocumentUploadRec."Line No." := ImmigrationDocumentUploadRec1."Line No.";
        ImmigrationDocumentUploadRec."Document Category" := DocumentCategory;
        ImmigrationDocumentUploadRec."Document Sub Category" := DocumentSubCategory;
        ImmigrationDocumentUploadRec."Document Path" := DocumentPath;
        ImmigrationDocumentUploadRec."Document ID" := DocumentID;
        ImmigrationDocumentUploadRec."Document Name" := DocumentName;
        // ImmigrationDocumentUploadRec."Document Extension" := FileType;
        if UpdatedDate <> '' then
            Evaluate(ImmigrationDocumentUploadRec."Document Update Date", UpdatedDate);
        if ImmigrationDocumentUploadRec.Insert() then
            exit('Success' + ' ' + StudentNo)
        else
            exit('Failed' + ' ' + StudentNo);
    End;

    procedure WebAPIFERPADetailsInsert(StudentNo: Code[20]; FirstName: text[50];
     LastName: text[50]; Email: text[50]; PhoneNo: text[30]; Relationship: Code[20];
     AsofDate: text; InfoHeaderNo: Code[20]; FerpaDetailLineNo: Integer; Addr1: Text[50];
     City: Text[30]; State: Code[20]; CountryCode: Code[10]; StartDate: Date; EndDate: Date
     ; AY: Code[20]; Sem: Code[10]; Term: Option FALL,SPRING,SUMMER): Text[100];
    var
        FERPADetailsRec: Record "FERPA Details";
        FERPADetailsRec1: Record "FERPA Details";
        RecStudentMaster: Record "Student Master-CS";
        LineNo: Integer;
    begin
        RecStudentMaster.get(StudentNo);
        FERPADetailsRec.Reset();
        FERPADetailsRec.SetRange("Info Header No", InfoHeaderNo);
        if FERPADetailsRec.FindLast() then
            LineNo := FERPADetailsRec."Ferpa Detail Line No" + 10000
        else
            LineNo := 10000;

        FERPADetailsRec1.Init();
        FERPADetailsRec1.Validate("Student No.", StudentNo);
        // FERPADetailsRec1."Academic Year" := RecStudentMaster."Academic Year";
        // FERPADetailsRec1.Semester := RecStudentMaster.Semester;
        // FERPADetailsRec1.Term := RecStudentMaster.Term;
        FERPADetailsRec1."Academic Year" := AY;
        FERPADetailsRec1.Semester := Sem;
        FERPADetailsRec1.Term := Term;
        FERPADetailsRec1."First Name" := FirstName;
        FERPADetailsRec1."Last Name" := LastName;
        FERPADetailsRec1.Validate("E-Mail Address", Email);
        FERPADetailsRec1."Phone Number" := PhoneNo;
        FERPADetailsRec1.validate(Relationship, Relationship);
        if AsofDate <> '' then
            Evaluate(FERPADetailsRec1."As of Date", AsofDate);
        FERPADetailsRec1."Info Header No" := InfoHeaderNo;
        FERPADetailsRec1."Ferpa Detail Line No" := LineNo;
        FERPADetailsRec1.Addr1 := Addr1;
        // FERPADetailsRec1.Addr2 := Addr2;
        FERPADetailsRec1.City := City;
        FERPADetailsRec1.State := State;
        FERPADetailsRec1."Country Code" := CountryCode;
        // FERPADetailsRec1."Start Date" := StartDate;
        // FERPADetailsRec1."End Date" := EndDate;
        FERPADetailsRec1."Start Date" := 0D;
        FERPADetailsRec1."End Date" := 0D;
        if FERPADetailsRec1.Insert(true) then begin
            exit('Success' + ' ' + StudentNo + ' ' + FORMAT(LineNo))
        end else
            exit('Failed' + ' ' + StudentNo + ' ' + FORMAT(LineNo));
    end;

    procedure WebAPIFERPAModuleAllowedInsert(StudentNo: Code[20]; Module: Option; InfoHeaderNo: Code[20]; ModuleCode: Code[20]; FerpaDetailLineNo: Integer
    ; AY: Code[20]; Sem: Code[10]; Term: Option FALL,SPRING,SUMMER): Text[100];
    var
        FERPAModuleAllowedRec: Record "FERPA Module Allowed";
        RecStudentMaster: Record "Student Master-CS";

    begin
        RecStudentMaster.get(StudentNo);
        FERPAModuleAllowedRec.Init();
        FERPAModuleAllowedRec.Validate("Student No.", StudentNo);
        // FERPAModuleAllowedRec."Academic Year" := RecStudentMaster."Academic Year";
        // FERPAModuleAllowedRec.Semester := RecStudentMaster.Semester;
        // FERPAModuleAllowedRec.Term := RecStudentMaster.Term;
        FERPAModuleAllowedRec."Academic Year" := AY;
        FERPAModuleAllowedRec.Semester := Sem;
        FERPAModuleAllowedRec.Term := Term;
        FERPAModuleAllowedRec."Module Name" := Module;
        FERPAModuleAllowedRec."Module Code" := ModuleCode;
        FERPAModuleAllowedRec."Ferpa Detail Line No" := FerpaDetailLineNo;
        FERPAModuleAllowedRec."Info Header No" := InfoHeaderNo;
        if FERPAModuleAllowedRec.Insert(true) then begin
            exit('Success' + ' ' + StudentNo + ' ' + FORMAT(FerpaDetailLineNo))
        end else
            exit('Failed' + ' ' + StudentNo + ' ' + FORMAT(FerpaDetailLineNo));

    end;

    procedure WebAPIFERPADetailsDelete(StudentNo: Code[20]; InfoHeaderNo: Code[20]; LineNo: Integer): Text[100];
    var
        FERPADetailsRec: Record "FERPA Details";
        RecStudentMaster: Record "Student Master-CS";
    begin
        RecStudentMaster.get(StudentNo);
        FERPADetailsRec.Reset();
        FERPADetailsRec.SetRange("Student No.", StudentNo);
        FERPADetailsRec.SetRange("Info Header No", InfoHeaderNo);
        FERPADetailsRec.SetRange("Ferpa Detail Line No", LineNo);
        IF FERPADetailsRec.FindFirst() then begin
            if FERPADetailsRec.Delete() then
                exit('Success' + ' ' + StudentNo)
            else
                exit('Failed' + ' ' + StudentNo);
        end
        else
            exit('Not Found');
    end;

    procedure WebAPIFERPAModuleDelete(StudentNo: Code[20]; ModuleCode: Code[20]; InfoHeaderNo: Code[20]; LineNo: Integer): Text[20];
    var
        FERPAModuleAllowed: Record "FERPA Module Allowed";
    begin
        FERPAModuleAllowed.Reset();
        FERPAModuleAllowed.SetRange("Student No.", StudentNo);
        FERPAModuleAllowed.SetRange("Info Header No", InfoHeaderNo);
        FERPAModuleAllowed.SetRange("Module Code", ModuleCode);
        FERPAModuleAllowed.SetRange("Ferpa Detail Line No", LineNo);
        IF FERPAModuleAllowed.FindFirst() then begin
            if FERPAModuleAllowed.Delete() then
                exit('Success' + ' ' + StudentNo)
            else
                exit('Failed');
        end;

    end;

    procedure WebAPIHousingParkingInsert(StudentNo: Code[20]; Vehicle: text[30];
    Model: text[30]; Colour: Text[30]; OwnerVehicle: text[100];
    NoVehicleOwner: Text[30]; RegistrationNumber: Text[30]; DriverLicense: Text[30];
    LicenseDate: Text; Make: Text[30]; DepartmentCode: Code[20]): text[50]

    var
        HousingParkingDetails: Record "Housing Parking Details";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentRec.Get(StudentNo);
        // EducationSetupCS.Reset();
        // EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If GlSetup.get() Then
            GlSetup.TestField(GlSetup."Housing Parking No.");
        HousingParkingDetails.Init();
        HousingParkingDetails.Validate("Parking Application No.", NoSeriesMgt.GetNextNo(GlSetup."Housing Parking No.", 0D, TRUE));
        HousingParkingDetails.Validate("Student No.", StudentNo);
        HousingParkingDetails.validate("Vehicle Number", Vehicle);
        HousingParkingDetails."Name of Vehicle Owner" := OwnerVehicle;
        HousingParkingDetails."Number of Vehicle Owner" := NoVehicleOwner;
        HousingParkingDetails."Registration Number" := RegistrationNumber;
        HousingParkingDetails."Driver License Number" := DriverLicense;
        if LicenseDate <> '' then
            Evaluate(HousingParkingDetails."License Expiration Date", LicenseDate);
        HousingParkingDetails.Model := Model;
        HousingParkingDetails.Colour := Colour;
        HousingParkingDetails.Make := Make;
        HousingParkingDetails.validate("Global Dimension 2 Code", DepartmentCode);
        if HousingParkingDetails.Insert(true) then
            exit('Success' + ' ' + HousingParkingDetails."Parking Application No.")
        else
            exit('Failed');
    end;

    procedure WebAPICreateElectiveRotation(OfferNo: Code[20]; StudentNo: Code[20]; StartDate: Date; EndDate: Date; GlobalDimension1Code: Code[20];
    ApprovalStatus: Integer; ApprovedStatusBy: Text[50]) ReturnText: Text[100]
    var
        RotationOfferApplication: Record "Rotation Offer Application";
        LineNo: Integer;
    begin
        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", OfferNo);
        if RotationOfferApplication.FindLast() then
            LineNo := RotationOfferApplication."Line No.";

        LineNo := LineNo + 10000;

        RotationOfferApplication.Init();
        RotationOfferApplication.Validate("Offer No.", OfferNo);
        RotationOfferApplication."Line No." := LineNo;
        RotationOfferApplication."Global Dimension 1 Code" := GlobalDimension1Code;
        RotationOfferApplication."Start Date" := StartDate;
        RotationOfferApplication."End Date" := EndDate;
        RotationOfferApplication.Validate("Student No.", StudentNo);
        RotationOfferApplication.Validate("Approval Status", ApprovalStatus);
        RotationOfferApplication."Approved Status By" := ApprovedStatusBy;
        RotationOfferApplication."Approved Status On" := Today();
        RotationOfferApplication.GenerateApplnNo();
        if RotationOfferApplication.Insert() then
            exit('Success ' + format(RotationOfferApplication."Offer No." + ' Line No.:' + Format(LineNo) + ' Application No.') + RotationOfferApplication."Application No.")
        else
            exit('Failed ' + format(RotationOfferApplication."Offer No."));
    end;

    procedure WebAPIUpdateElectiveRotation(OfferNo: Code[20]; LineNo: Integer; ApplicationNo: Code[20]; StartDate: Date; EndDate: Date;
    RejectReasonCode: Code[20]; RejectReasonDescription: Text[100];
    ApprovalStatus: Integer; ApprovedStatusBy: Text[50]) ReturnText: Text[100]
    var
        RotationOfferApplication: Record "Rotation Offer Application";
    begin
        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", OfferNo);
        RotationOfferApplication.SetRange("Line No.", LineNo);
        RotationOfferApplication.SetRange("Application No.", ApplicationNo);
        if RotationOfferApplication.FindLast() then begin
            RotationOfferApplication."Start Date" := StartDate;
            RotationOfferApplication."End Date" := EndDate;
            RotationOfferApplication.Validate("Approval Status", ApprovalStatus);
            RotationOfferApplication."Approved Status By" := ApprovedStatusBy;
            RotationOfferApplication."Approved Status On" := Today();
            if RotationOfferApplication.Modify() then
                exit('Success ' + format(RotationOfferApplication."Offer No." + ' Line No.:' + Format(LineNo) + ' Application No.') + RotationOfferApplication."Application No.")
            else
                exit('Failed ' + format(RotationOfferApplication."Offer No."));
        end;
    end;

    procedure WebAPI_SpclAccomodationApplication_Insert_Update(
    ApplicationNo: Code[20];
    GlobalDim1Code: Code[20];
    StudentNo: Code[20];
    Comment_1: Text[2048];
    SendforApproval: Boolean) ReturnTxt: Text[100]
    var
        SpclAccommodationApplication: Record "Spcl Accommodation Application";
    begin
        SpclAccommodationApplication.Reset();
        SpclAccommodationApplication.SetRange("Application No.", ApplicationNo);
        if SpclAccommodationApplication.FindFirst() then
            SpclAccommodationApplication.Delete(true);

        SpclAccommodationApplication."Application No." := ApplicationNo;
        SpclAccommodationApplication."Clinical Reference No." := ApplicationNo;
        SpclAccommodationApplication."Application Type" := SpclAccommodationApplication."Application Type"::"Clinical Rotation";
        SpclAccommodationApplication."Global Dimension 1 Code" := GlobalDim1Code;
        SpclAccommodationApplication.Validate("Student No.", StudentNo);
        SpclAccommodationApplication.Comments := Comment_1;
        SpclAccommodationApplication."Created By" := StudentNo;
        SpclAccommodationApplication."Created On" := Today();
        SpclAccommodationApplication."Send for Approval" := SendforApproval;
        if SendforApproval = true then begin
            SpclAccommodationApplication."Send for Approval By" := StudentNo;
            SpclAccommodationApplication."Send for Approval On" := Today();
            SpclAccommodationApplication."Approval Status" := SpclAccommodationApplication."Approval Status"::"Pending for Approval";
        end;
        if SpclAccommodationApplication.Insert() then
            exit('Success ' + format(SpclAccommodationApplication."Application No."))
        else
            exit('Failed ' + format(SpclAccommodationApplication."Application No."));
    end;

    procedure WebAPI_STDSpclAccomodationCategory_Insert_Update(
    ApplicationNo: Code[20];
    StudentNo: Code[20];
    CategoryCode: Code[20];
    LReason: Text[2048]) ReturnTxt: Text[100];
    var
        StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
    begin
        StdSplAccommodationCategory.Reset();
        StdSplAccommodationCategory.SetRange("Student ID", StudentNo);
        StdSplAccommodationCategory.SetRange("Application No.", ApplicationNo);
        StdSplAccommodationCategory.SetRange("Accommodation Category Code", CategoryCode);
        if StdSplAccommodationCategory.FindFirst() then
            StdSplAccommodationCategory.Delete(true);

        StdSplAccommodationCategory.Validate("Student ID", StudentNo);
        StdSplAccommodationCategory."Application No." := ApplicationNo;
        StdSplAccommodationCategory."Clinical Reference No." := ApplicationNo;
        StdSplAccommodationCategory.Validate("Accommodation Category Code", CategoryCode);
        StdSplAccommodationCategory.Reason := LReason;
        StdSplAccommodationCategory."Clinical Reference No." := ApplicationNo;
        StdSplAccommodationCategory."Created By" := StudentNo;
        StdSplAccommodationCategory."Created On" := Today();

        if StdSplAccommodationCategory.Insert() then
            exit('Success ' + format(StdSplAccommodationCategory."Application No."))
        else
            exit('Failed ' + format(StdSplAccommodationCategory."Application No."));
    end;

    procedure WebAPIFacutlyFeedbackInsert(StudentNo: Code[20];
    FeedbackFor: text[50]; QuestionDescription: text[250]; FeedBackType: text[20]; Rate: integer;
    Course: code[20]; Semester: code[10]; Section: code[10]; AcademicYear: Code[20];
    GD1: Code[20]; GD2: Code[20]; SubjectCode: Code[20]; FacultyCode: Code[20];
    StudentRemarks: Text[100]; QuestionId: Integer; AllSave: Boolean; TypeofEvaluation: Option; Term: Option): Text[20]

    var
        FacutlyFeedBackRec: Record "Faculty Feedback-CS";
    begin
        FacutlyFeedBackRec.Reset();
        FacutlyFeedBackRec.SetRange("Student No.", StudentNo);
        FacutlyFeedBackRec.SetRange("Academic Year", AcademicYear);
        FacutlyFeedBackRec.SetRange(Semester, Semester);
        FacutlyFeedBackRec.SetRange("Subject Code", SubjectCode);
        FacutlyFeedBackRec.SetRange("Question Id", QuestionId);
        FacutlyFeedBackRec.SetRange("Faculty Code", FacultyCode);
        If Not FacutlyFeedBackRec.FindFirst() then begin
            FacutlyFeedBackRec.Init();
            FacutlyFeedBackRec.Validate("Student No.", StudentNo);
            FacutlyFeedBackRec.Date := WorkDate();
            FacutlyFeedBackRec.FeedbackFor := FeedbackFor;
            FacutlyFeedBackRec."Question Description" := QuestionDescription;
            FacutlyFeedBackRec.Type := FeedBackType;
            FacutlyFeedBackRec.Rate := Rate;
            FacutlyFeedBackRec.Course := Course;
            FacutlyFeedBackRec.Semester := Semester;
            FacutlyFeedBackRec.Section := Section;
            FacutlyFeedBackRec."Academic Year" := AcademicYear;
            FacutlyFeedBackRec."Global Dimension 1 Code" := GD1;
            FacutlyFeedBackRec."Global Dimension 2 Code" := GD2;
            FacutlyFeedBackRec."Subject Code" := SubjectCode;
            FacutlyFeedBackRec."Faculty Code" := FacultyCode;
            FacutlyFeedBackRec."Remarks By Student" := StudentRemarks;
            FacutlyFeedBackRec."Question Id" := QuestionId;
            FacutlyFeedBackRec."All Save" := AllSave;
            FacutlyFeedBackRec."Type of Evaluation" := TypeofEvaluation;
            FacutlyFeedBackRec.Term := Term;
            if FacutlyFeedBackRec.Insert(true) then
                exit('Success')
            else
                exit('Failed');
        end else
            exit('Duplicate');
    end;

    //ELOA-CLOA-SLOA-START
    procedure WebApiELOA(
         StudentNo: Code[20];
         StartDate: Date;
         EndDate: Date;
         ReasonCode: Code[10];
         ReasonDescription: Text[2048];
         LeaveTypes: Option ELOA,SLOA,CLOA;
         DocumentCategory: Option " ","Application Form","Passport Biodata","Stamp on Arrival Copy","Visa Copy","Return Ticket Copy","Passport Size Photo";
         DocumentSubCategory: Code[20];
         DocumentName: Text[50];
         DocumentPath: Text[500];
         DocumentExtension: Text[500];
         DocumentID: Code[20];
         CreatedBy: Text[50]
         ): Text[50]
    var
        RecStudentLeaveOfAbsenece: Record "Student Leave of Absence";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        StudentMasterRec.Get(StudentNo);
        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        GlSetup.get();
        RecStudentLeaveOfAbsenece.Init();
        RecStudentLeaveOfAbsenece.Validate("Application No.", NoSeriesMgt.GetNextNo(GlSetup."Leave Of Absence No.", 0D, TRUE));
        RecStudentLeaveOfAbsenece.Validate("Student No.", StudentNo);
        RecStudentLeaveOfAbsenece.Validate("Start Date", StartDate);
        RecStudentLeaveOfAbsenece.Validate("Start Date", StartDate);
        RecStudentLeaveOfAbsenece.Validate("Leave Types", LeaveTypes);
        RecStudentLeaveOfAbsenece.Validate(Reason, ReasonCode);
        RecStudentLeaveOfAbsenece.Validate("Reason Description", ReasonDescription);
        RecStudentLeaveOfAbsenece."Library Department" := RecStudentLeaveOfAbsenece."Library Department"::"Pending for Approval";
        RecStudentLeaveOfAbsenece."Bursar Department" := RecStudentLeaveOfAbsenece."Bursar Department"::"Pending for Approval";
        RecStudentLeaveOfAbsenece."Financial Aid Department" := RecStudentLeaveOfAbsenece."Financial Aid Department"::"Pending for Approval";
        RecStudentLeaveOfAbsenece."EED Basic Science Department" := RecStudentLeaveOfAbsenece."EED Basic Science Department"::"Pending for Approval";
        RecStudentLeaveOfAbsenece."Dean of Students affairs" := RecStudentLeaveOfAbsenece."Dean of Students affairs"::"Pending for Approval";
        RecStudentLeaveOfAbsenece."Executive Dean" := RecStudentLeaveOfAbsenece."Executive Dean"::"Pending for Approval";
        RecStudentLeaveOfAbsenece.Validate("Document Category", DocumentCategory);
        RecStudentLeaveOfAbsenece.Validate("Document Sub Category", DocumentSubCategory);
        RecStudentLeaveOfAbsenece.Validate("Document Name", DocumentName);
        RecStudentLeaveOfAbsenece.Validate("Document Path", DocumentPath);
        RecStudentLeaveOfAbsenece.Validate("Document Extension", DocumentExtension);
        RecStudentLeaveOfAbsenece.Validate("Document ID", DocumentID);
        RecStudentLeaveOfAbsenece.Validate("Document Update Date", Today());
        RecStudentLeaveOfAbsenece."Created By" := CreatedBy;
        RecStudentLeaveOfAbsenece.OnlineLeave := True;
        IF RecStudentLeaveOfAbsenece.Insert() THEN
            EXIT('Success' + ' ' + RecStudentLeaveOfAbsenece."Application No.")
        Else
            EXIT('Failed' + ' ' + RecStudentLeaveOfAbsenece."Application No.");

    end;

    procedure WebApiSLOA(
     StudentNo: Code[20];
     StartDate: Date;
     EndDate: Date;
     ReasonCode: Code[10];
     ReasonDescription: Text[2048];
     LeaveTypes: Option ELOA,SLOA,CLOA;
     DocumentCategory: Option " ","Application Form","Passport Biodata","Stamp on Arrival Copy","Visa Copy","Return Ticket Copy","Passport Size Photo";
     DocumentSubCategory: Code[20];
     DocumentName: Text[50];
     DocumentPath: Text[500];
     DocumentExtension: Text[500];
     DocumentID: Code[20];
     CreatedBy: Text[50]
     ): Text[50]
    var
        RecStudentLeaveOfAbsenece: Record "Student Leave of Absence";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        StudentMasterRec.Get(StudentNo);
        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        GlSetup.get();
        RecStudentLeaveOfAbsenece.Init();
        RecStudentLeaveOfAbsenece.Validate("Application No.", NoSeriesMgt.GetNextNo(GlSetup."Leave Of Absence No.", 0D, TRUE));
        RecStudentLeaveOfAbsenece.Validate("Student No.", StudentNo);
        RecStudentLeaveOfAbsenece.Validate("Start Date", StartDate);
        RecStudentLeaveOfAbsenece.Validate("Start Date", StartDate);
        RecStudentLeaveOfAbsenece.Validate("Leave Types", LeaveTypes);
        RecStudentLeaveOfAbsenece."Student Affairs Dept." := RecStudentLeaveOfAbsenece."Student Affairs Dept."::Pending;
        RecStudentLeaveOfAbsenece.Validate(Reason, ReasonCode);
        RecStudentLeaveOfAbsenece.Validate("Reason Description", ReasonDescription);
        RecStudentLeaveOfAbsenece.Validate("Document Category", DocumentCategory);
        RecStudentLeaveOfAbsenece.Validate("Document Sub Category", DocumentSubCategory);
        RecStudentLeaveOfAbsenece.Validate("Document Name", DocumentName);
        RecStudentLeaveOfAbsenece.Validate("Document Path", DocumentPath);
        RecStudentLeaveOfAbsenece.Validate("Document Extension", DocumentExtension);
        RecStudentLeaveOfAbsenece.Validate("Document ID", DocumentID);
        RecStudentLeaveOfAbsenece.Validate("Document Update Date", Today());
        RecStudentLeaveOfAbsenece."Created By" := CreatedBy;
        RecStudentLeaveOfAbsenece.OnlineLeave := True;
        IF RecStudentLeaveOfAbsenece.Insert() THEN
            EXIT('Success' + ' ' + RecStudentLeaveOfAbsenece."Application No.")
        Else
            EXIT('Failed' + ' ' + RecStudentLeaveOfAbsenece."Application No.");

    end;

    procedure WebApiCLOA(
    StudentNo: Code[20];
    StartDate: Date;
    EndDate: Date;
    ReasonCode: Code[10];
    ReasonDescription: Text[2048];
    LeaveTypes: Option ELOA,SLOA,CLOA;
    DocumentCategory: Option " ","Application Form","Passport Biodata","Stamp on Arrival Copy","Visa Copy","Return Ticket Copy","Passport Size Photo";
    DocumentSubCategory: Code[20];
    DocumentName: Text[50];
    DocumentPath: Text[500];
    DocumentExtension: Text[500];
    DocumentID: Code[20];
    CreatedBy: Text[50]
    ): Text[50]
    var
        RecStudentLeaveOfAbsenece: Record "Student Leave of Absence";
        EducationSetupRec: Record "Education Setup-CS";
        StudentMasterRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        StudentMasterRec.Get(StudentNo);
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        RecStudentLeaveOfAbsenece.Init();
        RecStudentLeaveOfAbsenece.Validate("Application No.", NoSeriesMgt.GetNextNo(EducationSetupRec."Leave Of Absence No.", 0D, TRUE));
        RecStudentLeaveOfAbsenece.Validate("Student No.", StudentNo);
        RecStudentLeaveOfAbsenece.Validate("Start Date", StartDate);
        RecStudentLeaveOfAbsenece.Validate("Start Date", StartDate);
        RecStudentLeaveOfAbsenece.Validate("Leave Types", LeaveTypes);
        RecStudentLeaveOfAbsenece."Executive Dean" := RecStudentLeaveOfAbsenece."Executive Dean"::"Pending for Approval";
        RecStudentLeaveOfAbsenece.Validate(Reason, ReasonCode);
        RecStudentLeaveOfAbsenece.Validate("Reason Description", ReasonDescription);
        RecStudentLeaveOfAbsenece.Validate("Document Category", DocumentCategory);
        RecStudentLeaveOfAbsenece.Validate("Document Sub Category", DocumentSubCategory);
        RecStudentLeaveOfAbsenece.Validate("Document Name", DocumentName);
        RecStudentLeaveOfAbsenece.Validate("Document Path", DocumentPath);
        RecStudentLeaveOfAbsenece.Validate("Document Extension", DocumentExtension);
        RecStudentLeaveOfAbsenece.Validate("Document ID", DocumentID);
        RecStudentLeaveOfAbsenece.Validate("Document Update Date", Today());
        RecStudentLeaveOfAbsenece."Created By" := CreatedBy;
        RecStudentLeaveOfAbsenece.OnlineLeave := True;
        IF RecStudentLeaveOfAbsenece.Insert() THEN
            EXIT('Success' + ' ' + RecStudentLeaveOfAbsenece."Application No.")
        Else
            EXIT('Failed' + ' ' + RecStudentLeaveOfAbsenece."Application No.");

    end;
    //ELOA-COLA-SLOA-END
    procedure WebAPIExamOptOutInsert(StudentNo: Code[20]): text[50]
    var
        OptOutRec: Record "Opt Out";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        RecCourseSubjLine: Record "Course Wise Subject Line-CS";
        RecSubjectMaster: Record "Subject Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentRec.Get(StudentNo);
        OptOutRec.Reset();
        OptOutRec.SetRange("Student No.", StudentRec."No.");
        OptOutRec.SetRange("Academic Year", StudentRec."Academic Year");
        OptOutRec.SetRange(Semester, StudentRec.Semester);
        IF Not OptOutRec.FindFirst() then begin
            EducationSetupCS.Reset();
            EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            If EducationSetupCS.FindFirst() Then begin
                EducationSetupCS.TestField(EducationSetupCS."Exam Opt Out No.");
                OptOutRec.Init();
                OptOutRec.Validate("Application No.", NoSeriesMgt.GetNextNo(EducationSetupCS."Exam Opt Out No.", 0D, TRUE));
                OptOutRec.Validate("Student No.", StudentNo);
                RecCourseSubjLine.Reset();
                RecCourseSubjLine.SetRange("Academic Year", StudentRec."Academic Year");
                RecCourseSubjLine.SetRange(Semester, StudentRec.Semester);
                RecCourseSubjLine.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                RecCourseSubjLine.SetFilter("Level Description", '%1', RecCourseSubjLine."Level Description"::"External Examination");
                IF RecCourseSubjLine.FindSet() then
                    repeat
                        RecSubjectMaster.Reset();
                        RecSubjectMaster.SetRange(Code, RecCourseSubjLine."Subject Code");
                        RecSubjectMaster.SetRange("Exam Opt Out", true);
                        IF RecSubjectMaster.FindFirst() then begin
                            IF OptOutRec."Subject 1" = '' then
                                OptOutRec.Validate("Subject 1", RecSubjectMaster.Code);
                            IF OptOutRec."Subject 2" = '' then
                                OptOutRec.Validate("Subject 2", RecSubjectMaster.Code);
                            IF OptOutRec."Subject 3" = '' then
                                OptOutRec.Validate("Subject 3", RecSubjectMaster.Code);
                            IF OptOutRec."Subject 4" = '' then
                                OptOutRec.Validate("Subject 4", RecSubjectMaster.Code);
                            IF OptOutRec."Subject 5" = '' then
                                OptOutRec.Validate("Subject 5", RecSubjectMaster.Code);
                        end;
                    Until RecCourseSubjLine.Next() = 0;

                OptOutRec."Application Type" := OptOutRec."Application Type"::"Bsic Opt Out";
                OptOutRec.Status := OptOutRec.Status::"Pending for Approval";
                OptOutRec."Application Date" := WorkDate();
                if OptOutRec.Insert(true) then
                    exit('Success' + ' ' + OptOutRec."Application No.")
                else
                    exit('Failed');
            end;
        end Else
            exit('Duplicate');
    end;

    procedure WebAPIHousingWavierInsert(StudentNo: Code[20]; ApplicationType: Option "Bsic Opt Out","Housing Wavier","Make-Up","Restart","Appeal","Semester Registration";
    PresentAdd1: Text[50]; PresentAdd2: text[50]; PresentAdd3: Text[50]; LeaseAgrNo: code[20]; LeaseAgrGrp: Text[50];
    Transport: Boolean; TransportCell: Text[30]; PostCode: Code[20]; City: Text[30]; Country: Code[10]; SState: Text[30];
    Status: Option Open,"Pending for Approval",Approved,Rejected,Submit; AY: Code[20]; Sem: Code[10]; Term: Option FALL,SPRING,SUMMER): Text[30]
    var
        OptOutRec: Record "Opt Out";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    //HousingMailCod: Codeunit "Hosusing Mail";
    begin
        StudentRec.Get(StudentNo);
        if ApplicationType <> ApplicationType::"Housing Wavier" then
            Error('Application Type must be Housing Waiver');
        if PresentAdd1 = '' then
            Error('Present Address 1 cannot be empty');
        if City = '' then
            Error('City cannot be empty');
        if SState = '' then
            Error('State cannot be empty');
        if Country = '' then
            Error('Country cannot be empty');


        OptOutRec.Reset();
        OptOutRec.SetRange("Student No.", StudentRec."No.");
        // OptOutRec.SetRange("Academic Year", StudentRec."Academic Year");
        // OptOutRec.SetRange(Semester, StudentRec.Semester);
        OptOutRec.SetRange("Academic Year", AY);
        OptOutRec.SetRange(Semester, Sem);
        OptOutRec.SetRange(Term, Term);
        OptOutRec.SetRange("Application Type", ApplicationType);
        OptOutRec.SetFilter(Status, '%1|%2', OptOutRec.Status::"Pending for Approval", OptOutRec.Status::Approved);
        IF OptOutRec.FindFirst() then
            exit('Duplicate');
        // EducationSetupCS.Reset();
        // EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If GlSetup.get() Then
            GlSetup.TestField(GlSetup."Housing Opt Out No.");
        OptOutRec.Init();
        OptOutRec.Validate("Application No.", NoSeriesMgt.GetNextNo(GlSetup."Housing Opt Out No.", 0D, TRUE));
        OptOutRec."Entry From Portal" := true;
        OptOutRec.Validate("Student No.", StudentNo);
        OptOutRec."Application Type" := ApplicationType;
        OptOutRec."Application Date" := WorkDate();
        OptOutRec.Validate("Present Address1", PresentAdd1);
        OptOutRec.Validate("Present Address2", PresentAdd2);
        OptOutRec.Validate("Present Address3", PresentAdd3);
        OptOutRec.Validate("Lease Agreement/Contract No.", LeaseAgrNo);
        OptOutRec.Validate("Lease Agreement Group", LeaseAgrGrp);
        // if (PostCode <> '') or (City <> '') then
        //     CreatePostCode(PostCode, City, SState, Country);
        OptOutRec."Post Code" := PostCode;
        OptOutRec.Validate(Country, Country);
        OptOutRec.City := City;
        OptOutRec.County := SState;


        OptOutRec.Transportation := Transport;
        OptOutRec.Validate("Transport Cell", TransportCell);
        OptOutRec.validate("Academic Year", AY);
        OptOutRec.validate(Semester, Sem);
        OptOutRec.validate(Term, Term);
        OptOutRec.Status := Status;
        if OptOutRec.Insert(true) then begin
            //HousingMailCod.MailSendforHousingWaiverSubmit(OptOutRec."Student No.", OptOutRec."Application No.");
            exit('Success' + ' ' + OptOutRec."Application No.")
        end else
            exit('Failed');
    end;

    // procedure WebAPIStudentBalance(StudentNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    // var
    //     CustomerRec: Record Customer;
    //     Stud: Record "Student Master-CS";
    // begin
    //     if Stud.Get(StudentNo) then
    //         if CustomerRec.Get(Stud."Original Student No.") then begin
    //             IF (EndDate <> 0D) then
    //                 CustomerRec.SetRange("Date Filter", StartDate, EndDate);
    //             CustomerRec.CalcFields(CustomerRec.Balance);
    //             Exit(CustomerRec.Balance);
    //         end;
    // end;
    procedure WebAPIStudentBalance(StudentNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        CustomerLedgerEntryRec: Record "Cust. Ledger Entry";
        Stud: Record "Student Master-CS";
    begin
        if Stud.Get(StudentNo) then begin
            CustomerLedgerEntryRec.Reset();
            CustomerLedgerEntryRec.Setrange("Customer No.", Stud."Original Student No.");
            CustomerLedgerEntryRec.SetRange("Enrollment No.", stud."Enrollment No.");
            IF (EndDate <> 0D) then
                CustomerLedgerEntryRec.SetRange("Date Filter", StartDate, EndDate);
            if CustomerLedgerEntryRec.FindSet() then
                CustomerLedgerEntryRec.CalcFields(CustomerLedgerEntryRec.Amount);
            Exit(CustomerLedgerEntryRec.Amount);
        end;
    end;

    procedure WebAPIWithDrawalInsert(StudentNo: Code[20]; ReasonCode: Code[10]; ReasonforLeaving: Text[500]; TypeofWithdrwal: Option " ","Course-Withdrawal","College-Withdrawal";
     BankHolderName: Text[100]; BankAccountNo: Text[50]; WithDrawalDate: text;
     BankName: Text[100]; IFSCCode: Text[30]; LDA: Text; AcaYear: Code[20]; Sem: Code[10]; pTerm: Option FALL,SPRING,SUMMER): text[50]
    var
        WithdrawalStudentRec: Record "Withdrawal Student-CS";
        StudentRec: Record "Student Master-CS";
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if StudentRec.Get(StudentNo) then begin
            GLSetup.get();
            GLSetup.TestField("Withdrawal No.");
            // EducationSetupCS.Reset();
            // EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            // If EducationSetupCS.FindFirst() Then begin
            // EducationSetupCS.TestField(EducationSetupCS."Withdrawal No.");
            WithdrawalStudentRec.Reset();
            WithdrawalStudentRec.Init();
            WithdrawalStudentRec."Type of Withdrawal" := TypeofWithdrwal;
            WithdrawalStudentRec.Validate("No.", NoSeriesMgt.GetNextNo(GLSetup."Withdrawal No.", 0D, TRUE));
            WithdrawalStudentRec.Validate("Student No.", StudentNo);
            WithdrawalStudentRec."Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
            if WithDrawalDate <> '' then
                Evaluate(WithdrawalStudentRec."Withdrawal date", WithDrawalDate);
            WithdrawalStudentRec."Reason Code" := ReasonCode;
            WithdrawalStudentRec."Reason for Leaving" := ReasonforLeaving;
            WithdrawalStudentRec."Bank Acc Holder Name" := BankHolderName;
            WithdrawalStudentRec."Bank Name" := BankName;
            WithdrawalStudentRec."Bank Account No/IBAN Number" := BankAccountNo;
            WithdrawalStudentRec."IFSC Code Number/Swift Code" := IFSCCode;
            WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::"Pending for Approval";
            Evaluate(WithdrawalStudentRec."Last Date Of Attendance", LDA);
            WithdrawalStudentRec."Academic Year" := AcaYear;
            WithdrawalStudentRec.Semester := Sem;
            WithdrawalStudentRec.Term := pTerm;
            WithdrawalStudentRec."Entry From Portal" := true;
            if WithdrawalStudentRec.Insert(true) then;
            WithdrawalStudentRec."Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
            if WithdrawalStudentRec.modify() then
                exit('Success' + ' ' + WithdrawalStudentRec."No.")
            else
                exit('Failed');

        end
        else
            exit('Failed');
    end;

    procedure WebAPIWithdrawalApprovalsInsert(StudentNo: Code[20]; StudentName: Text[100]; ApplicationDate: Text;
              Status: Option Open,"Pending for Approval",Approved,Rejected; ReasonCode: Code[10]; Remarks: Text[500]; ApprovedDepartment: Text[100]; RequestNo: Code[20];
              FormType: Code[20]; ApprovedBy: Code[50]; Course: Code[20]; RegistrationNo: Code[20];
              ApprovedRejectedDate: Text; RejectionRemark: Text[500]; TypeofWithdrwal: Option " ","Course-Withdrawal","College-Withdrawal"
              ; FinalApproval: Boolean; WaiverApproval: Boolean): text[50]
    var
        WithdrawalApprovalsRec: Record "Withdrawal Approvals";
        StudentWithdrawal: Record "Withdrawal Student-CS";
    begin

        WithdrawalApprovalsRec.Reset();
        WithdrawalApprovalsRec.SetRange("Withdrawal No.", RequestNo);
        WithdrawalApprovalsRec.SetRange("Student No.", StudentNo);
        WithdrawalApprovalsRec.SetRange("Approved for Department", ApprovedDepartment);
        IF Not WithdrawalApprovalsRec.FindFirst() then begin
            StudentWithdrawal.Reset();
            StudentWithdrawal.SetRange("No.", RequestNo);
            If StudentWithdrawal.FindFirst() then;
            WithdrawalApprovalsRec.Init();
            WithdrawalApprovalsRec."Withdrawal No." := RequestNo;
            WithdrawalApprovalsRec.Validate("Student No.", StudentNo);
            WithdrawalApprovalsRec.Validate("Approved for Department", ApprovedDepartment);
            WithdrawalApprovalsRec."Student Name" := StudentName;
            if ApplicationDate <> '' then
                Evaluate(WithdrawalApprovalsRec."Application date", ApplicationDate);
            WithdrawalApprovalsRec.status := status;
            WithdrawalApprovalsRec."Reason Code" := ReasonCode;
            WithdrawalApprovalsRec."Reason for Leaving" := Remarks;
            WithdrawalApprovalsRec."Final Approval" := FinalApproval;
            WithdrawalApprovalsRec."Waiver Calculation Allowed" := WaiverApproval;
            WithdrawalApprovalsRec."Form Type" := FormType;
            WithdrawalApprovalsRec."Approved By" := ApprovedBy;
            WithdrawalApprovalsRec.Course := Course;
            WithdrawalApprovalsRec.Status := WithdrawalApprovalsRec.Status::"Pending for Approval";
            WithdrawalApprovalsRec."Type of Withdrawal" := TypeofWithdrwal;
            WithdrawalApprovalsRec."Last Date Of Attendance" := StudentWithdrawal."Last Date Of Attendance";
            WithdrawalApprovalsRec."Date Of Determination" := StudentWithdrawal."Date Of Determination";
            WithdrawalApprovalsRec."NSLDS Withdrawal Date" := StudentWithdrawal."NSLDS Withdrawal Date";
            if ApprovedRejectedDate <> '' then
                Evaluate(WithdrawalApprovalsRec."Approved On", ApprovedRejectedDate);
            WithdrawalApprovalsRec."Semester Start Date" := StudentWithdrawal."Semester Start Date";
            WithdrawalApprovalsRec."Rejection Remark" := RejectionRemark;
            if WithdrawalApprovalsRec.Insert(true) then
                exit('Success' + ' ' + WithdrawalApprovalsRec."Student No.")
            else
                exit('Failed');
        end Else
            exit('Duplicate');
    end;

    procedure WebApiRequisitionInsert(
         DocumentNo: Code[20];
         LocationCode: Code[10];
         DocumentDate: Text;
         GlobalDimension1Code: Code[20];
         GlobalDimension2Code: Code[30];//Department Name from Portal : CSPL-00307 
         DocumentID: Code[20];
         //  CreatedBy: Text[50];
         //  CreatedOn: Date;
         ItemCode: Code[20];
         RequestedQuantity: Decimal;
         RequisitionLastLine: Boolean;
         Reason: Code[10];
         RequisitionType: Integer //Added New Parameter CSPL-00307 
         ): Text[100]
    var
        RecRequisitionHeader: Record "Requisition Header";
        RecRequisitionLine: Record "Requisition Line_";
        RecRequisitionLine1: Record "Requisition Line_";
        PurchSetup: Record "Purchases & Payables Setup";
        Dimvalue: Record "Dimension Value";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        DocDate: Date;
    begin
        IF DocumentNo = '' THEN BEGIN
            PurchSetup.GET();
            PurchSetup.TESTFIELD("Requisition No.");
            RecRequisitionHeader.Init();
            RecRequisitionHeader."No." := NoSeriesMgt.GetNextNo(PurchSetup."Requisition No.", 0D, TRUE);
            RecRequisitionHeader."Document Type" := RecRequisitionHeader."Document Type"::Requisition;
            If DocumentDate <> '' then
                Evaluate(DocDate, DocumentDate);
            RecRequisitionHeader.Validate("Document Date", DocDate);
            RecRequisitionHeader.Validate("Posting Date", today());
            RecRequisitionHeader.Validate("Global Dimension 1 Code", GlobalDimension1Code);
            // CSPL-00307 
            Dimvalue.Reset();
            Dimvalue.SetRange(Name, GlobalDimension2Code);
            If Dimvalue.FindFirst() then
                RecRequisitionHeader.Validate("Global Dimension 2 Code", Dimvalue.Code);
            // CSPL-00307 
            RecRequisitionHeader.Validate("Location Code", LocationCode);
            // RecRequisitionHeader."Approval Status" := RecRequisitionHeader."Approval Status"::Open;
            RecRequisitionHeader.Status := RecRequisitionHeader.Status::Open;
            RecRequisitionHeader.Validate("Approval Status", RecRequisitionHeader."Approval Status"::"Send to Store"); //CSPL-00307       14-10-21 As per Dushyant This API Hits to Store Requisition HardCoded
            RecRequisitionHeader.Validate("Responsible Department", RecRequisitionHeader."Responsible Department"::Store); ////CSPL-00307 14-10-21 As per Dushyant This API Hits to Store Requisition HardCoded
            RecRequisitionHeader."Date & Time" := CurrentDateTime();
            RecRequisitionHeader."User Id" := FORMAT(UserId());
            RecRequisitionHeader."Created By" := UserId();
            RecRequisitionHeader."Created On" := Today();
            RecRequisitionHeader.Validate(Reason, Reason);
            RecRequisitionHeader.Validate("Requisition Type", RequisitionType);// CSPL-00307 
            IF RecRequisitionHeader.Insert() THEN
                EXIT('Success' + ' ' + RecRequisitionHeader."No.")
            Else
                EXIT('Failed' + ' ' + RecRequisitionHeader."No.");
        end ELSE begin
            IF RequisitionLastLine = False THEN BEGIN
                RecRequisitionLine1.Reset();
                RecRequisitionLine1.SetRange("Document No.", DocumentNo);
                if RecRequisitionLine1.FindLast() then
                    LineNo := RecRequisitionLine1."Line No." + 10000
                else
                    LineNo := 10000;

                RecRequisitionHeader.RESET();
                RecRequisitionHeader.SetRange("No.", DocumentNo);
                IF RecRequisitionHeader.FindFirst() THEN BEGIN
                    RecRequisitionLine.Init();
                    RecRequisitionLine."Document No." := DocumentNo;
                    RecRequisitionLine."Document Type" := RecRequisitionLine."Document Type"::Requisition;
                    RecRequisitionLine."Line No." := LineNo;
                    RecRequisitionLine.Type := RecRequisitionLine.Type::Item;
                    RecRequisitionLine.Validate("Item Code", ItemCode);
                    RecRequisitionLine.Validate("Requested Quantity", RequestedQuantity);
                    RecRequisitionLine.Status := RecRequisitionLine.Status::"Send to Store"; //CSPL-00307       14-10-21 As per Dushyant This API Hits to Store Requisition HardCoded
                    IF RecRequisitionLine.Insert() THEN
                        EXIT('Success' + ' ' + Format(RecRequisitionLine."Line No."))
                    Else
                        EXIT('Failed' + ' ' + Format(RecRequisitionLine."Line No."));
                end else
                    EXIT('Failed' + ' ' + DocumentNo);

            end else begin
                RecRequisitionLine1.Reset();
                RecRequisitionLine1.SetRange("Document No.", DocumentNo);
                if RecRequisitionLine1.FindLast() then
                    LineNo := RecRequisitionLine1."Line No." + 10000
                else
                    LineNo := 10000;
                RecRequisitionHeader.RESET();
                RecRequisitionHeader.SetRange("No.", DocumentNo);
                IF RecRequisitionHeader.FindFirst() THEN BEGIN
                    RecRequisitionLine.Init();
                    RecRequisitionLine."Document No." := DocumentNo;
                    RecRequisitionLine."Document Type" := RecRequisitionLine."Document Type"::Requisition;
                    RecRequisitionLine."Line No." := LineNo;
                    RecRequisitionLine.Type := RecRequisitionLine.Type::Item;
                    RecRequisitionLine.Validate("Item Code", ItemCode);
                    RecRequisitionLine.Validate("Requested Quantity", RequestedQuantity);
                    RecRequisitionLine."Requisition Last Line" := true;
                    RecRequisitionLine.Status := RecRequisitionLine.Status::"Send to Store"; //CSPL-00307       14-10-21 As per Dushyant This API Hits to Store Requisition HardCoded
                    IF RecRequisitionLine.Insert() THEN BEGIN
                        RecRequisitionHeader.SendRequisitionLastLine(DocumentNo);
                        EXIT('Success' + ' ' + Format(RecRequisitionLine."Line No."))
                    END Else
                        EXIT('Failed' + ' ' + Format(RecRequisitionLine."Line No."));
                end else
                    EXIT('Failed' + ' ' + DocumentNo);
            end;
        end;
    end;

    procedure WebAPIMakeUpInsert(
          StudentNo: Code[20];
          "ELOA/SLOANo": Code[20];
           ExamName: Text[100];
           ExamDate: Date;
           SubjectCode: Code[20];
           ReasonCode: Code[10]
           ): Text[100]
    var
        RecOptOut: Record "Opt Out";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        StudentRec.GET(StudentNo);
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            RecOptOut.Init();
            RecOptOut.Validate("Application No.", NoSeriesMgt.GetNextNo(EducationSetupCS."MakeUp Exam No.", 0D, TRUE));
            recOptOut."Application type" := RecOptOut."Application Type"::"Make-up";
            RecOptOut."Application Date" := WorkDate();
            RecOptOut.Validate("Student No.", StudentNo);
            RecOptOut.Validate("ELOA/SLOA No.", "ELOA/SLOANo");
            RecOptOut.Validate("Subject 1", SubjectCode);
            RecOptOut."Exam Name" := ExamName;
            RecOptOut."Exam Date" := ExamDate;
            RecOptOut.Status := RecOptOut.Status::"Pending for Approval";
            RecOptOut.Validate(Reason, ReasonCode);
            IF RecOptOut.Insert(True) THEN
                EXIT('Success' + ' ' + RecOptOut."Application No.")
            Else
                EXIT('Failed');
        end;
    end;

    procedure WebAPIWithdrawalApprovalStatusInsert(StudentNo: Code[20];
              Status: Option Open,"Pending for Approval",Approved,Rejected;
              ApprovedDepartment: Text[100]; RequestNo: Code[20];
              TypeofWithdrwal: Option " ","Course-Withdrawal","College-Withdrawal";
              ApprovedBy: Code[50]; RejectedBy: Code[50]; RejectionRemark: Text[500];
              WithdrawalStatus: Option Open,"Pending for Approval",Approved,Rejected): text[100]
    var
        WithdrawalApprovalsRec: Record "Withdrawal Approvals";
        WithdrawalStudentRec: Record "Withdrawal Student-CS";

    begin
        WithdrawalApprovalsRec.Reset();
        WithdrawalApprovalsRec.SetRange("Student No.", StudentNo);
        WithdrawalApprovalsRec.SetRange("Approved for Department", ApprovedDepartment);
        WithdrawalApprovalsRec.SetRange("Withdrawal No.", RequestNo);
        IF WithdrawalApprovalsRec.FindFirst() then begin
            WithdrawalApprovalsRec.status := status;
            WithdrawalApprovalsRec."Approved By" := ApprovedBy;
            if ApprovedBy <> '' then
                WithdrawalApprovalsRec."Approved On" := WorkDate();
            WithdrawalApprovalsRec."Rejected By" := RejectedBy;
            if RejectedBy <> '' then
                WithdrawalApprovalsRec."Rejected On" := WorkDate();
            WithdrawalApprovalsRec."Rejection Remark" := RejectionRemark;
            WithdrawalApprovalsRec."Type of Withdrawal" := TypeofWithdrwal;
            if WithdrawalApprovalsRec.Modify() then begin
                if WithdrawalStatus = WithdrawalStatus::Approved then begin
                    WithdrawalStudentRec.Reset();
                    WithdrawalStudentRec.SetRange("No.", RequestNo);
                    if WithdrawalStudentRec.FindFirst() then begin
                        WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::Approved;
                        WithdrawalStudentRec.Modify();
                    end;
                end;
                exit('Success' + ' ' + WithdrawalApprovalsRec."Student No.");
            end else
                exit('Failed');
        end else
            Exit('No Record Found');

    end;

    procedure WebAPIRestartSemester(StudentNo: Code[20]; Semcode: Code[20]; AcaYear: Code[20]; pTerm: Option FALL,SPRING,SUMMER): Text[100]
    var
        // RecOptOut: Record "Opt Out";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        StudSemRestart: Record StudentSemesterDecision;
        Sem: Record "Semester Master-CS";
    begin
        //arv
        StudentRec.GET(StudentNo);
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            StudSemRestart.Init();

            StudSemRestart.Validate("Student No.", StudentNo);
            StudSemRestart.Validate(Semester, Semcode);
            StudSemRestart.Validate("Academic Year", AcaYear);
            StudSemRestart.Validate(Term, pTerm);
            StudSemRestart.Status := StudSemRestart.Status::"Pending For Approval";
            // Sem.Reset();
            // Sem.SetRange(Code, StudentRec.Semester);
            // Sem.FindFirst();
            // Sem.TestField(Sequence);
            // if ((Sem.Sequence MOD 2) = 0) then
            //     StudSemRestart.validate("Decision Type", StudSemRestart."Decision Type"::RepeatApp)
            // else
            //     if ((Sem.Sequence MOD 2) > 0) then
            //         StudSemRestart.validate("Decision Type", StudSemRestart."Decision Type"::Restart);

            // StudSemRestart.Validate(Status, StudSemRestart.Status::"Pending For Approval");
            // If StudSemRestart."Decision Type" = StudSemRestart."Decision Type"::RepeatApp then
            //     StudSemRestart."Calculated SAP" := StudentRec.SAP + 1;
            // If StudSemRestart."Decision Type" = StudSemRestart."Decision Type"::Restart then
            //     StudSemRestart."Calculated SAP" := StudentRec.SAP + 2;
            // if ((Sem.Sequence MOD 2) = 0) and (StudSemRestart."Decision Type" = StudSemRestart."Decision Type"::Restart) then
            //     Error('Decision Type Restart cannot be set for Semester %1', Sem.Code);
            // if ((Sem.Sequence MOD 2) > 0) and (StudSemRestart."Decision Type" = StudSemRestart."Decision Type"::RepeatApp) then
            //     Error('Decision Type Repeat cannot be set for Semester %1', Sem.Code);

            IF StudSemRestart.Insert(True) THEN
                EXIT('Success' + ' ' + StudSemRestart."Document No.")
            Else
                EXIT('Failed');
        end;
    end;

    procedure WebAPISemesterRegistration(StudentNo: Code[20]; Reason: code[10];
    ReasonDescription: Text[2048]): Text[100]
    var

        RecOptOut: Record "Opt Out";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EndDate: Date;

    begin
        StudentRec.GET(StudentNo);
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.RESET();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'SPRING');
                EducationMultiEventCalCS.SETRANGE("Academic Year", StudentRec."Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    EndDate := EducationMultiEventCalCS."Revised End Date";
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'FALL');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", StudentRec."Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        EndDate := EducationMultiEventCalCS."Revised End Date";
                    END;
                END;
            IF WorkDate() <= CALCDATE(EducationSetupCS."Semester Registration Terms", EndDate) then begin
                RecOptOut.Init();
                RecOptOut.Validate("Application No.", NoSeriesMgt.GetNextNo(EducationSetupCS."Semester Regstration No.", 0D, TRUE));
                recOptOut."Application type" := RecOptOut."Application Type"::"Semester Registration";
                RecOptOut."Application Date" := WorkDate();
                RecOptOut.Validate("Student No.", StudentNo);
                RecOptOut.Reason := Reason;
                RecOptOut."Reason Description" := ReasonDescription;
                RecOptOut.Status := RecOptOut.Status::"Pending for Approval";
                IF RecOptOut.Insert(True) THEN
                    EXIT('Success' + ' ' + RecOptOut."Application No.")
                Else
                    EXIT('Failed');
            end else
                EXIT('Registration days are closed');
        end;
    end;

    procedure WebAPIElectiveApplicationInsert(
          StudentNo: Code[20];
           SubjectCode1: Code[20];
           ReasonCode: Text[2048]
           ): Text[100]
    var
        ElectiveApplicationRec: Record "Elective Application";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        Semester_lRec: Record "Semester Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        StudentRec.Reset();
        StudentRec.Get(StudentNo);
        IF StudentRec."Global Dimension 1 Code" = '9000' then
            Error('Selected Student %1 must be AICASA', StudentNo);

        Semester_lRec.Reset();
        Semester_lRec.SetRange(Code, StudentRec.Semester);
        IF Semester_lRec.FindFirst() then
            IF Semester_lRec.Sequence = 1 then
                Error('Student : %1 must not be in Semester : %2', StudentRec."No.", Semester_lRec.Code);

        ElectiveApplicationRec.Reset();
        ElectiveApplicationRec.SetRange("Student No.", StudentRec."No.");
        ElectiveApplicationRec.SetFilter(Status, '%1|%2|%3', ElectiveApplicationRec.Status::"Pending for Approval", ElectiveApplicationRec.Status::Approved, ElectiveApplicationRec.Status::Open);
        If ElectiveApplicationRec.FindFirst() then
            Error('Elective Application already exist for Student %1 whose status is %2', StudentRec."No.", ElectiveApplicationRec.Status);

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            ElectiveApplicationRec.Init();
            ElectiveApplicationRec.Validate("Application No.", NoSeriesMgt.GetNextNo(EducationSetupCS."Elective Application No.", 0D, TRUE));
            ElectiveApplicationRec."Application type" := ElectiveApplicationRec."Application Type"::"Elective Application";
            ElectiveApplicationRec."Application Date" := WorkDate();
            ElectiveApplicationRec.Validate("Student No.", StudentNo);
            ElectiveApplicationRec.Validate("Subject 1", SubjectCode1);
            ElectiveApplicationRec.Status := ElectiveApplicationRec.Status::"Pending for Approval";
            ElectiveApplicationRec.Validate("Reason Description", ReasonCode);
            IF ElectiveApplicationRec.Insert(True) THEN
                EXIT('Success' + ' ' + ElectiveApplicationRec."Application No.")
            Else
                EXIT('Failed');
        end;
    end;

    procedure WEBAPIInsertInvoice(TemplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal; CurrencyCode: Code[10]; BalAccountNo: Code[20]; FeeCode1: Code[20]; ReceiptNo: Code[20]): Text[100]
    var
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        // Customer: Record "Customer";
        StudentRec: Record "Student Master-CS";
        CLE: Record "Cust. Ledger Entry";
        FeeGenerated: Report "Fee Generation New";
        TempDocNo: Code[20];
        LineNo: Integer;
    begin
        // Customer.GET(StudNo);
        StudentRec.Get(StudNo);
        FeeComponentMasterCS.GET(FeeCode1);
        TempDocNo := FeeGenerated.GetLastDocumemtNo(TemplateName, BatchName);

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        GenJournalLine.SETRANGE("Receipt No.", ReceiptNo);
        IF GenJournalLine.FindSet() THEN
            repeat
                CLE.Reset();
                CLE.SetRange("Applies-to ID", GenJournalLine."Document No.");
                IF CLE.FindSet() then
                    repeat
                        CLE."Applies-to ID" := '';
                        CLE.Validate("Amount to Apply", 0);
                        CLE.Modify();
                    until CLE.Next() = 0;
                GenJournalLine.DELETE();
            Until GenJournalLine.Next() = 0;


        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF GenJournalLine.FINDLAST() THEN
            LineNo := GenJournalLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", TemplateName);
        GenJournalLine.VALIDATE("Journal Batch Name", BatchName);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE("Document No.", TempDocNo);
        GenJournalLine.VALIDATE("Line No.", LineNo);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", BalAccountNo);
        GenJournalLine.VALIDATE("Posting Date", WorkDate());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Credit Amount", Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", FeeComponentMasterCS."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(Course, StudentRec."Course Code");
        GenJournalLine.VALIDATE(Semester, StudentRec.Semester);
        GenJournalLine.VALIDATE(Year, StudentRec.Year);
        GenJournalLine.VALIDATE("Academic Year", StudentRec."Academic Year");
        GenJournalLine.VALIDATE("Enrollment No.", StudentRec."Enrollment No.");
        GenJournalLine.Validate(Term, StudentRec.Term);
        GenJournalLine.VALIDATE("Fee Code", FeeCode1);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);
        IF FeeCode1 <> '' THEN
            GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine.VALIDATE("Due Date", WorkDate());
        IF GenJournalLine.INSERT(TRUE) THEN begin

            GenJournalLine2.INIT();
            GenJournalLine2.VALIDATE("Journal Template Name", TemplateName);
            GenJournalLine2.VALIDATE("Journal Batch Name", BatchName);
            GenJournalLine2.VALIDATE("Document Type", GenJournalLine2."Document Type"::Invoice);
            GenJournalLine2.VALIDATE("Document No.", TempDocNo);
            GenJournalLine2.VALIDATE("Line No.", LineNo + 10000);
            GenJournalLine2.VALIDATE("Account Type", GenJournalLine2."Account Type"::Customer);
            GenJournalLine2.VALIDATE("Account No.", StudentRec."Original Student No.");
            GenJournalLine2.VALIDATE("Posting Date", WorkDate());
            GenJournalLine2.VALIDATE("Currency Code", CurrencyCode);
            GenJournalLine2.VALIDATE("Debit Amount", Amount);
            GenJournalLine2.VALIDATE("Shortcut Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            GenJournalLine2.VALIDATE(Course, StudentRec."Course Code");
            GenJournalLine2.VALIDATE(Semester, StudentRec.Semester);
            GenJournalLine2.VALIDATE(Year, StudentRec.Year);
            GenJournalLine2.VALIDATE("Academic Year", StudentRec."Academic Year");
            GenJournalLine2.Validate(Term, StudentRec.Term);
            GenJournalLine2.VALIDATE("Enrollment No.", StudentRec."Enrollment No.");
            GenJournalLine2.VALIDATE("Due Date", WorkDate());
            GenJournalLine2.VALIDATE("Receipt No.", ReceiptNo);
            GenJournalLine2.VALIDATE("Shortcut Dimension 2 Code", FeeComponentMasterCS."Global Dimension 2 Code");
            GenJournalLine2."Fee Description" := FeeComponentMasterCS.Description;
            IF GenJournalLine2.INSERT(TRUE) THEN begin
                GLSetup.Get();
                IF GLSetup."Portal Entries Auto Post" then
                    Exit(WEBAPIEntryPosting(TemplateName, BatchName, TempDocNo));
            end;
        End ELSE
            EXIT('False');
    End;

    procedure WEBAPIInsertPayment(TemplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal;
     CurrencyCode: Code[10]; BankAccountNo: Code[20]; Description: Text[100];
      TransectionNumber: Code[20]; ReceiptNo: Code[20]; GlobalDimension2Code: code[20]): Text[100] //SD-SN-18-Dec-2020 +
    var
        // Customer: Record "Customer";
        // StudentRec: Record "Student Master-CS";
        Stud: Record "Student Master-CS";
        FeeSetup: Record "Fee Setup-CS"; //SD-SN-18-Dec-2020 +
        CLE: Record "Cust. Ledger Entry";
        GenJnlTemp: Record "Gen. Journal Template";
        FeeGenerated: Report "Fee Generation New";
        TempDocNo: Code[20];
        LineNo: Integer;
    begin
        // Customer.GET(StudNo);
        Stud.Get(StudNo);
        TempDocNo := FeeGenerated.GetLastDocumemtNo(TemplateName, BatchName);
        GenJnlTemp.Reset();
        GenJnlTemp.Get(TemplateName);
        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        GenJournalLine.SETRANGE("Receipt No.", ReceiptNo);
        IF GenJournalLine.FindSet() THEN
            repeat
                CLE.Reset();
                CLE.SetRange("Applies-to ID", GenJournalLine."Document No.");
                IF CLE.FindSet() then
                    repeat
                        CLE."Applies-to ID" := '';
                        CLE.Validate("Amount to Apply", 0);
                        CLE.Modify();
                    until CLE.Next() = 0;
                GenJournalLine.DELETE();
            Until GenJournalLine.Next() = 0;
        //SD-SN-18-Dec-2020 +
        FeeSetup.reset();
        FeeSetup.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
        FeeSetup.FindFirst();
        Begin
            if BankAccountNo = '' then begin
                if GlobalDimension2Code <> '' then begin
                    if GlobalDimension2Code = '9300' then
                        BankAccountNo := FeeSetup."Grenville Bank Account No.";
                    if GlobalDimension2Code = '9500' then
                        BankAccountNo := FeeSetup."AUA Housing Bank Account No.";
                end Else
                    BankAccountNo := FeeSetup."Fee Bank Account No."
            end;
        end;
        //SD-SN-18-Dec-2020 -
        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF GenJournalLine.FINDLAST() THEN
            LineNo := GenJournalLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE("Journal Template Name", TemplateName);
        GenJournalLine.VALIDATE("Journal Batch Name", BatchName);
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.VALIDATE("Document No.", TempDocNo);
        GenJournalLine.VALIDATE("Line No.", LineNo);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"Bank Account");
        GenJournalLine.VALIDATE("Account No.", BankAccountNo);
        GenJournalLine."Source Code" := GenJnlTemp."Source Code";
        GenJournalLine.VALIDATE("Posting Date", WorkDate());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Debit Amount", Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", Stud."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Enrollment No.", Stud."Enrollment No.");
        GenJournalLine.VALIDATE(Course, Stud."Course Code");
        GenJournalLine.VALIDATE(Semester, Stud.Semester);
        GenJournalLine.VALIDATE(Year, Stud.Year);
        GenJournalLine.VALIDATE("Academic Year", Stud."Academic Year");
        GenJournalLine.Validate(Term, Stud.Term);
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GlobalDimension2Code);
        IF GenJournalLine.INSERT(TRUE) THEN begin

            GenJournalLine2.INIT();
            GenJournalLine2.VALIDATE("Journal Template Name", TemplateName);
            GenJournalLine2.VALIDATE("Journal Batch Name", BatchName);
            GenJournalLine2.VALIDATE("Document Type", GenJournalLine2."Document Type"::Payment);
            GenJournalLine2.VALIDATE("Document No.", TempDocNo);
            GenJournalLine2.VALIDATE("Line No.", LineNo + 10000);
            GenJournalLine2.VALIDATE("Account Type", GenJournalLine2."Account Type"::Customer);
            GenJournalLine2.VALIDATE("Account No.", Stud."Original Student No.");
            GenJournalLine2."Source Code" := GenJnlTemp."Source Code";
            GenJournalLine2.VALIDATE("Posting Date", WorkDate());
            GenJournalLine2.VALIDATE("Currency Code", CurrencyCode);
            GenJournalLine2.VALIDATE("Credit Amount", Amount);
            GenJournalLine2.VALIDATE("Shortcut Dimension 1 Code", Stud."Global Dimension 1 Code");

            GenJournalLine2.VALIDATE("Enrollment No.", Stud."Enrollment No.");
            GenJournalLine2.VALIDATE(Course, Stud."Course Code");
            GenJournalLine2.VALIDATE(Semester, Stud.Semester);
            GenJournalLine2.VALIDATE(Year, Stud.Year);
            GenJournalLine2.VALIDATE("Academic Year", Stud."Academic Year");
            GenJournalLine2.Validate(Term, Stud.Term);
            GenJournalLine2.VALIDATE("Transaction Number", TransectionNumber);
            GenJournalLine2.VALIDATE("Receipt No.", ReceiptNo);
            GenJournalLine2.VALIDATE("Shortcut Dimension 2 Code", GlobalDimension2Code);
            IF GenJournalLine2.INSERT(TRUE) THEN
                EXIT('True' + ' ' + TempDocNo)
            ELSE
                EXIT('False');
        end;
    end;

    procedure WEBAPIEntryPosting(TemplateName: Code[10]; BatchName: Code[10]; DocumentNo: Code[20]): Text[100]
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeries: Record "No. Series";
    begin
        GenJournalBatch.Reset();
        GenJournalBatch.SetRange("Journal Template Name", TemplateName);
        GenJournalBatch.SetRange(Name, BatchName);
        IF GenJournalBatch.FindFirst() then begin
            NoSeries.Get(GenJournalBatch."No. Series");
            IF NoSeries."Manual Nos." = false then begin
                NoSeries."Manual Nos." := true;
                NoSeries.Modify();
            end;
            GenJournalLine.RESET();
            GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", TemplateName);
            GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", BatchName);
            GenJournalLine.SETRANGE(GenJournalLine."Document No.", DocumentNo);
            IF GenJournalLine.FINDFIRST() THEN begin
                Commit();
                IF CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine) then
                    EXIT('True')
                Else
                    EXIT('False');
            end;
        end;
    end;

    procedure WEBAPIEntryApplied(TemplateName: Code[10]; BatchName: Code[10];
    InvDoc: Code[20]; InvAmt: Decimal; ReceiptNo: Code[20]; AppliedBy: Option Invoice,Receipt;
    PaymentDoc: Code[20]; ISLast: Boolean): Text[100]
    var
        CLE: Record "Cust. Ledger Entry";
        GenJournalLineRec: Record "Gen. Journal Line";
    begin
        CLE.Reset();
        // CLE.SetRange("Customer No.", CustNo);
        IF AppliedBy = AppliedBy::Invoice then
            CLE.SetRange("Document No.", InvDoc);
        IF AppliedBy = AppliedBy::Receipt then begin
            CLE.SetRange("Receipt No.", ReceiptNo);
            CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
        end;
        IF CLE.FindSet() then
            repeat
                CLE."Applies-to ID" := PaymentDoc;
                CLE.CalcFields(CLE."Remaining Amount");
                IF CLE."Remaining Amount" >= InvAmt then
                    CLE.Validate("Amount to Apply", InvAmt)
                Else
                    CLE.Validate("Amount to Apply", CLE."Remaining Amount");
                CLE.Modify();
            until CLE.Next() = 0;
        IF ISLast then begin
            GenJournalLineRec.Reset();
            GenJournalLineRec.SETRANGE("Journal Template Name", TemplateName);
            GenJournalLineRec.SETRANGE("Journal Batch Name", BatchName);
            GenJournalLineRec.SetRange("Document No.", PaymentDoc);
            GenJournalLineRec.SetRange("Account Type", GenJournalLineRec."Account Type"::Customer);
            IF GenJournalLineRec.FindFirst() Then begin
                GenJournalLineRec."Applies-to ID" := PaymentDoc;
                GenJournalLineRec.Modify();
                GLSetup.Get();
                IF GLSetup."Portal Entries Auto Post" then
                    Exit(WEBAPIEntryPosting(TemplateName, BatchName, PaymentDoc));
            end;
        end;
    end;

    procedure WEBAPIAmountToPay(StudentNo: Code[20]; NextAdYear: Code[20]; AdvanceFee: Boolean; var SemesterFee: Decimal; var GrenvilleFee: Decimal) AmountToPay: Decimal
    Var
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        // CustRec: Record Customer;
        Stud: Record "Student Master-CS";
        CurrentSemesterFee: Record "Current Semester Fee";
        FeeGeneration: Report "Fee Generation New";
        SQNo: Integer;
        NextSemester: Code[20];
        FeeComp: Code[20];
    begin
        // CustRec.Get(StudentNo);
        // Stud.get(StudentNo);                 //12122022 Navdeep Spring 2023
        // If AdvanceFee = true Then begin
        //     CourseSemMasterCS.Reset();
        //     CourseSemMasterCS.SETCURRENTKEY("Semester Code");
        //     CourseSemMasterCS.SETRANGE("Course Code", Stud."Course Code");
        //     CourseSemMasterCS.SETRANGE("Semester Code", Stud.Semester);
        //     IF CourseSemMasterCS.FINDFIRST() THEN begin
        //         SQNo := CourseSemMasterCS."Sequence No" + 1;
        //     end;

        //     IF SQNo <> 0 Then begin
        //         CourseSemMasterCS.Reset();
        //         CourseSemMasterCS.SETRANGE("Course Code", Stud."Course Code");
        //         CourseSemMasterCS.SetRange("Sequence No", SQNo);
        //         IF CourseSemMasterCS.FindFirst() then
        //             NextSemester := CourseSemMasterCS."Semester Code";
        //     end;
        // end;
        // CurrentSemesterFee.VariablePassing(StudentNo);
        // AmountToPay := FeeGeneration.StudentTotalFee(StudentNo, FeeComp, NextSemester, NextAdYear, AdvanceFee, SemesterFee, GrenvilleFee);
        AmountToPay := 0;
        EXIT(AmountToPay);
    end;

    procedure WebAPIFinAIDPPlanInsert(
       StudentNo: Code[20];
       DocumentDate: Date;
       ApplicationDate: Date;
       VisitFafsaWebsite: Option;
       VisitStuLoanWebseite: Option;
       FSAID: Code[20];
       EntranceCounseling: Option;
       UnsubsidizedLoan: Option;
       DirectGraduateplusloan: Option;
       LoanExpDate: Date;
       Livingexpenses: Option;
       GradPlusMPN: Option;
       GradPLUSDenial: Option;
       Endorse: Option;
       LoanAmt: Decimal;
       CreatedBy: Text[50];
       CreatedOn: Date;
       Type1: Option "Financial Aid","Payment Plan","Self Payment";
       PPlanInstalment: Integer;
       var ApplicationNo: Code[20]
       ): text[50]
    var
        FinancialAIDRec: Record "Financial AID";
        // FinancialAIDRec2: Record "Financial AID";
        FeeSetup: Record "Fee Setup-CS";
        StudentRec: Record "Student Master-CS";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentRec.Get(StudentNo);
        IF ApplicationNo <> '' then begin
            FinancialAIDRec.get(ApplicationNo);
            if FinancialAIDRec.Status <> FinancialAIDRec.Status::"Pending for Approval" then
                Error('Financial Aid Application No. %1 cannot be modified as it is %2', FinancialAIDRec."Application No.", FinancialAIDRec.Status);
        end else
            IF ApplicationNo = '' then begin
                FinancialAIDRec.Init();
                FeeSetup.Reset();
                FeeSetup.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                FeeSetup.FindFirst();
                if Type1 = Type1::"Financial Aid" then begin
                    FeeSetup.TestField("Financial AID No.");
                    FinancialAIDRec."Application No." := NoSeriesMgt.GetNextNo(FeeSetup."Financial AID No.", 0D, TRUE);
                    FinancialAIDRec."No. Series" := FeeSetup."Financial AID No.";
                end else begin
                    GlSetup.get();
                    GlSetup.TestField("Payment Plan No.");
                    FinancialAIDRec."Application No." := NoSeriesMgt.GetNextNo(GlSetup."Payment Plan No.", 0D, TRUE);
                    FinancialAIDRec."No. Series" := GlSetup."Payment Plan No.";
                end;
                FinancialAIDRec.Validate(Type, Type1);
                FinancialAIDRec.Validate("Student No.", StudentNo);
            end;


        FinancialAIDRec.Validate("Document Date", DocumentDate);
        FinancialAIDRec.validate("Application Date", ApplicationDate);
        FinancialAIDRec."Email Id" := StudentRec."E-Mail Address";
        FinancialAIDRec."Phone No." := StudentRec."Phone Number";
        FinancialAIDRec.Status := FinancialAIDRec.Status::"Pending for Approval";
        If Type1 = Type1::"Financial Aid" then begin
            FinancialAIDRec.Validate("Visited FAFSA Website", VisitFafsaWebsite);
            FinancialAIDRec.Validate("Visited Student Loan Website", VisitStuLoanWebseite);
            FinancialAIDRec.Validate("FSA ID", FSAID);
            FinancialAIDRec.Validate("Entrance Counseling", EntranceCounseling);
            FinancialAIDRec.Validate("Unsubsidized Loan", UnsubsidizedLoan);
            FinancialAIDRec.Validate("Direct Graduate plus loan", DirectGraduateplusloan);
            FinancialAIDRec.Validate("Loan Expiry Date", LoanExpDate);
            FinancialAIDRec.Validate("Living expenses", Livingexpenses);
            FinancialAIDRec.Validate("Grad PLUS MPN", GradPlusMPN);
            FinancialAIDRec.Validate("Grad PLUS Denial", GradPLUSDenial);
            FinancialAIDRec.Validate(Endorse, Endorse);
            FinancialAIDRec.Validate("Loan Amount", LoanAmt);
        end
        else
            if Type1 = Type1::"Payment Plan" then begin
                FinancialAIDRec.Validate("Payment Plan Instalment", PPlanInstalment);
            end;

        FinancialAIDRec.Validate("Created By", CreatedBy);
        FinancialAIDRec.Validate("Created On", CreatedOn);

        IF ApplicationNo = '' then begin
            if FinancialAIDRec.Insert() then
                exit('Success' + ' ' + FinancialAIDRec."Application No.")
            else
                exit('Failed');
        end else
            if FinancialAIDRec.Modify() then
                exit('Success' + ' ' + FinancialAIDRec."Application No.")
            else
                exit('Failed');
    end;


    // procedure WebAPIStudentRegistration(StudentNo: Code[20];
    // CourseName: Text[100];
    // Sem: Code[10];
    // AcademicYear: Code[10];
    // Title1: Option " ","Mr.","Mrs.","Miss","Ms.";
    // StudentName: Text[100];
    // GD1: Code[20];
    // GD2: Code[20];
    // Year1: Code[10];
    // Enrollment: Code[20];
    // CourseCode: Code[20];
    // Status: Option;
    // FirstName: Text[35];
    // LastName: Text[35];
    // MiddleName: Text[30];
    // MaidenName: Text[80];
    // EMail: Text[50];
    // DOB: Text[30];
    // Gender1: Option;
    // MaritalStatus: Option;
    // StreetAddress: Text[50];
    // City1: Text[30];
    // PostalCode: Code[50];
    // CountryCode: Code[10];
    // State1: Code[10];
    // EmergencyFirstName: Text[35];
    // EmergencyLastName: Text[35];
    // EmergencyEMail: Text[50];
    // EmergencyPhoneNo: Text[30];
    // EmergencyAddress: Text[100];
    // EmergencyContactRelation: Text[30];
    // EmergencyPhoneNo2: Text[30];
    // EmergencyCity: Text[30];
    // EmergencyPostalCode: Code[20];
    // EmergencyCountryCode: Code[10];
    // EmergencyState: Code[10];
    // LocalFirstName: Text[35];
    // LocalLastName: Text[35];
    // LocalStreetAddress: Text[50];
    // LocalCity: Text[30];
    // LocalhoneNo: Text[30];
    // Remark: Text[80];
    // Nationality1: Text[80];
    // Citizen1: Text[30];

    // BursarAgreement: Boolean;
    // RegistrarAgreement: Boolean;
    // TitleAgreement: Boolean;
    // ReleaseAgreement: Boolean;
    // EmergenctCheck: Boolean;
    // BursarHold: Boolean;
    // RegistrarHold: Boolean;
    // FinancialAIDHold: Boolean;
    // HousingHold: Boolean;
    // PassPortNo: Text[20];
    // PassPortExpiryDate: Text[20];
    // PassPortIssuedDate: Text[20];
    // PassPortIssuedBy: Text[50];
    // DocumentType: Option;
    // InsuranceCompanyName: Text[250];
    // PolicyNo: Code[20];
    // DateofComencement: Date;
    // ExpiryDate: Date;
    // InsuranceAgreement: Boolean;
    // ResidentialNetworkingAgmt: Boolean;
    // ApplyforInsurance: Boolean
    // ): Text[20];
    // var
    //     StudentRegistration: Record "Student Registration-CS";
    //     StudentRegistration1: Record "Student Registration-CS";
    //     StudentRec: Record "Student Master-CS";
    //     RecHousingMail: Codeunit "Hosusing Mail";
    // begin
    //     StudentRegistration1.RESET();
    //     StudentRegistration1.SETRANGE("Student No", StudentNo);
    //     IF StudentRegistration1.FINDLAST() THEN
    //         StudentRegistration1."Line No." := StudentRegistration1."Line No." + 10000
    //     ELSE
    //         StudentRegistration1."Line No." := 10000;

    //     StudentRegistration.Init();
    //     StudentRegistration.Validate("Student No", StudentNo);
    //     StudentRegistration.Course := CourseName;
    //     StudentRegistration."Line No." := StudentRegistration1."Line No.";
    //     StudentRegistration.Validate(Semester, Sem);
    //     StudentRegistration.Validate("Academic Year", AcademicYear);
    //     StudentRegistration."Student Name" := StudentName;
    //     StudentRegistration.Validate("Global Dimension 1 Code", GD1);
    //     StudentRegistration.Validate("Global Dimension 2 Code", GD2);
    //     StudentRegistration.Validate(Year, Year1);
    //     StudentRegistration.Validate("Enrollment No", Enrollment);
    //     StudentRegistration.Validate("Course Code", CourseCode);
    //     StudentRegistration.Validate("Student Status", Status);
    //     StudentRegistration.Validate(Title, Title1);
    //     StudentRegistration."First Name" := FirstName;
    //     StudentRegistration."Last Name" := LastName;
    //     StudentRegistration."Middle Name" := MiddleName;
    //     StudentRegistration."Maiden Name" := MaidenName;
    //     StudentRegistration."E-Mail Address" := EMail;
    //     IF DOB <> '' Then
    //         Evaluate(StudentRegistration."Date of Birth", DOB);
    //     StudentRegistration.Validate(Gender, Gender1);
    //     StudentRegistration.Validate("Marital Status", MaritalStatus);
    //     StudentRegistration."Street Address" := StreetAddress;
    //     StudentRegistration.Validate(City, City1);
    //     StudentRegistration.Validate("Postal Code", PostalCode);
    //     StudentRegistration.Validate("Country Code", CountryCode);
    //     StudentRegistration.Validate(State, State1);
    //     StudentRegistration."Emergency Contact First Name" := EmergencyFirstName;
    //     StudentRegistration."Emergency Contact Last Name" := EmergencyLastName;
    //     StudentRegistration."Emergency Contact E-Mail" := EmergencyEMail;
    //     StudentRegistration."Emergency Contact Phone No." := EmergencyPhoneNo;
    //     StudentRegistration."Emergency Contact Address" := EmergencyAddress;
    //     StudentRegistration."Emergency Contact RelationShip" := EmergencyContactRelation;
    //     StudentRegistration."Emergency Contact Phone No. 2" := EmergencyPhoneNo2;
    //     StudentRegistration.Validate("Emergency Contact City", EmergencyCity);
    //     StudentRegistration.Validate("Emergency Contact Postal Code", EmergencyPostalCode);
    //     StudentRegistration.Validate("Emergency Contact Country Code", EmergencyCountryCode);
    //     StudentRegistration.Validate("Emergency Contact State", EmergencyState);
    //     StudentRegistration."Local Emergency First Name" := LocalFirstName;
    //     StudentRegistration."Local Emergency Last Name" := LocalLastName;
    //     StudentRegistration."Local Emergency Street Address" := LocalStreetAddress;
    //     StudentRegistration.Validate("Local Emergency City", LocalCity);
    //     StudentRegistration."Local Emergency Phone No." := LocalhoneNo;
    //     StudentRegistration.Remarks := Remark;
    //     StudentRegistration.Validate(Nationality, Nationality1);

    //     StudentRegistration.Validate("Insurance Agreement", InsuranceAgreement);
    //     StudentRegistration.Validate("Bursar Agreement", BursarAgreement);
    //     StudentRegistration.Validate("Registrar Agreement", RegistrarAgreement);
    //     StudentRegistration.Validate("Title_IV Agreement", TitleAgreement);
    //     StudentRegistration.Validate("Release Agreement", ReleaseAgreement);
    //     StudentRegistration.Validate("Residential Network Agreement", ResidentialNetworkingAgmt);
    //     StudentRegistration.Validate("Emergency Contact Check Agmt", EmergenctCheck);
    //     StudentRegistration.Validate("Pass Port No. 1", PassPortNo);
    //     StudentRegistration.Validate("Document Type", DocumentType);
    //     StudentRegistration.Validate("Apply for Insurance", ApplyforInsurance);
    //     IF PassPortExpiryDate <> '' Then
    //         Evaluate(StudentRegistration."Pass Port Expiry Date 1", PassPortExpiryDate);
    //     IF PassPortIssuedDate <> '' Then
    //         Evaluate(StudentRegistration."Pass Port Issued Date 1", PassPortIssuedDate);
    //     StudentRegistration."Pass Port Issued By 1" := PassPortIssuedBy;

    //     if StudentRegistration.Insert() then Begin
    //         StudentRec.RESET();
    //         StudentRec.SETRANGE("No.", StudentNo);
    //         IF StudentRec.FIND() THEN Begin
    //             StudentRec.Validate("Pass Port No.", PassportNo);
    //             if PassPortIssuedDate <> '' then
    //                 Evaluate(StudentRec."Pass Port Issued Date", PassPortIssuedDate);
    //             StudentRec.Validate("Pass Port Issued By", PassPortIssuedBy);
    //             if PassPortExpiryDate <> '' then
    //                 Evaluate(StudentRec."Pass Port Expiry Date", PassPortExpiryDate);
    //             StudentRec.Validate(Nationality, Nationality1);
    //             StudentRec.Validate(Citizenship, Citizen1);
    //             StudentRec.Validate(Ethnicity, Ethnicity1);
    //             IF DOB <> '' Then
    //                 Evaluate(StudentRec."Date of Birth", DOB);
    //             StudentRec.Validate(Gender, Gender1);
    //             StudentRec.Validate("Marital Status", MaritalStatus);
    //             StudentRec.Validate(Title, Title1);
    //             StudentRec."First Name" := FirstName;
    //             StudentRec."Middle Name" := MiddleName;
    //             StudentRec."Maiden Name" := MaidenName;
    //             StudentRec."E-Mail Address" := EMail;
    //             StudentRec."Emergency Contact First Name" := EmergencyFirstName;
    //             StudentRec."Emergency Contact Last Name" := EmergencyLastName;
    //             StudentRec."Emergency Contact E-Mail" := EmergencyEMail;
    //             StudentRec."Emergency Contact Phone No." := EmergencyPhoneNo;
    //             StudentRec."Emergency Contact Address" := EmergencyAddress;
    //             StudentRec."Emergency Contact RelationShip" := EmergencyContactRelation;
    //             StudentRec."Emergency Contact Phone No. 2" := EmergencyPhoneNo2;
    //             StudentRec.Validate("Emergency Contact City", EmergencyCity);
    //             StudentRec.Validate("Emergency Contact Postal Code", EmergencyPostalCode);
    //             StudentRec.Validate("Emergency Contact Country Code", EmergencyCountryCode);
    //             StudentRec.Validate("Emergency Contact State", EmergencyState);
    //             StudentRec."Local Emergency First Name" := LocalFirstName;
    //             StudentRec."Local Emergency Last Name" := LocalLastName;
    //             StudentRec."Local Emergency Street Address" := LocalStreetAddress;
    //             StudentRec.Validate("Local Emergency City", LocalCity);
    //             StudentRec."Local Emergency Phone No." := LocalhoneNo;
    //             StudentRec.Remarks := Remark;
    //             StudentRec.Modify();
    //             // IF StudentRegistration."Apply for Insurance" = TRUE then
    //             //     StudentRegistration.InsuranceSignOff(StudentNo, AcademicYear, Sem, GD1);
    //             RecHousingMail.StudentIntimationOnlineRegistration(StudentNo, AcademicYear, Sem, CourseCode, GD1);
    //         end;
    //         exit('Success' + ' ' + StudentNo)
    //     end else
    //         exit('Failed' + ' ' + StudentNo);
    // end;

    // OLR Stages Start
    Procedure APIStageBasicInformation(StudentNo: Code[20]; EnrollmentNo: Code[20];
    SSN: Code[11]; Title: Option "Mr.","Mrs.",Miss,"Ms.";
    FirstName: Text[35]; LastName: Text[35]; MaidenName: Text[80]; MiddleName: Text[30];
    Email: Text[50]; DOB: Text[10]; Gender: Option " ",Female,Male,"Not Specified";
    MaritalStatus: Option " ",Single,Married,Separated,Divorced,Widowed;
    StreetAddress: Text[50]; Country: Code[10]; State: Code[10]; City: Text[30]; PostalCode: Code[20];
    EmergCntFirstName: Text[35]; EmergCntLastName: Text[30]; EmergCntEmail: Text[50]; EmergCntRelationship: Text[30];
    EmergCntPhone: Text[30];
    EmergCntAltPhone: Text[30]; EmergCntAddress: Text[100]; EmergCntCity: Text[30]; EmergCntCountry: Code[10];
    EmergCntPostalCode: Code[20]; EmergCntState: Code[10];
    LclEmrgCntFirstName: Text[35]; LclEmergCntLastName: Text[35]; LclEmergCntStreet: Text[50];
    LclEmergCntPhone: Text[30]; LclEmergCntCity: Text[30];
    Remarks: Text[80]; Nationality: Text[80]; Citizen: Integer; Ethnicity: Text[250];
    PassportFullName: Text[107]; PassportNo: Text[20]; PassportIssuedBy: Text[50]; PassportIssuedDate: Text[10]; PassportExpDate: Text[10];
    VisaNo: Text[20]; VisaIssuedDate: Text[10]; VisaExpiryDate: Text[10]; VisaExtensionDate: Text[10];
    //SD-SN-07-Dec-2020 +
    StageBasicInformation: Boolean; StageBaseInfoDate: Text[10]; StageBasicInfoTime: Text[8];
    //SD-SN-07-Dec-2020 -
    CourseCode: Code[20]; Sem: Code[10]; AcademicYear: Code[10]; Term: Option FALL,SPRING,SUMMER;
    ResidentAddress: text[250]; ResidentCountry: Code[20]; ResidentState: Code[20]; ResidentCity: Text[30];
    ResidentZipCode: Code[20]; ResidentPlan: Option " ","From Antigua","From my home"; ImmigrationIssuanceDate: Text[30]
    ; ImmiExpDate: Text[30]; Address2: Text[100]; Address3: Text[100]; FatherName: Text[40]; MotherName: Text[40]; FatherContactNo: Text[20]; FatherEmailID: Text[50]; MotherContactNo: Text[20]; MotherEmailID: Text[50]; GuardianName: Text[40]; GuardianContactNo: Text[20]; GuardianEmailID: Text[50]): Text[50]
    var
        StudentRegistrationIns: Record "Student Registration-CS";
        StudentRec: Record "Student Master-CS";
    Begin
        If StudentNo = '' then
            exit('Failed: Student No. must be filled');
        If AcademicYear = '' then
            Error('Academic Year must be filled');
        If Sem = '' then
            Error('Semester must be filled');

        StudentRegistrationIns.Reset();
        StudentRegistrationIns.SetRange("Student No", StudentNo);
        StudentRegistrationIns.SetRange("Course Code", CourseCode);
        StudentRegistrationIns.SetRange("Academic Year", AcademicYear);
        StudentRegistrationIns.SetRange(Term, Term);
        StudentRegistrationIns.SetRange(Semester, Sem);
        IF Not StudentRegistrationIns.FindFirst() then begin
            StudentRegistrationIns.Init();
            StudentRegistrationIns.Validate("Student No", StudentNo);
            StudentRec.Get(StudentNo);
            StudentRegistrationIns.Validate("Enrollment No", EnrollmentNo);
            StudentRegistrationIns.Validate("Academic Year", AcademicYear);
            StudentRegistrationIns.Validate(Semester, Sem);
            StudentRegistrationIns.Validate("Course Code", CourseCode);
            StudentRegistrationIns.Validate(Term, Term);


            StudentRegistrationIns.Validate("Stage Basic Information", StageBasicInformation);
            IF (StageBaseInfoDate <> '') and (StageBaseInfoDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Stage Basic Info Date", ConvertTextToDate(StageBaseInfoDate));
            StudentRegistrationIns.Validate("Stage Basic Info Time", ConvertTextToTime(StageBasicInfoTime));
            //SD-SN-07-Dec-2020 -

            StudentRegistrationIns.Validate(Title, Title);
            StudentRegistrationIns.Validate("First Name", FirstName);
            StudentRegistrationIns.Validate("Maiden Name", MaidenName);
            StudentRegistrationIns.Validate("Middle Name", MiddleName);
            StudentRegistrationIns.Validate("Last Name", LastName);

            StudentRegistrationIns.TESTFIELD("First Name");
            CLEAR(StudentRegistrationIns."Student Name");

            StudentRegistrationIns."Student Name" := StudentRegistrationIns."First Name";
            IF (StudentRegistrationIns."Last Name" <> '') AND (StudentRegistrationIns."Middle Name" = '') THEN
                StudentRegistrationIns."Student Name" := StudentRegistrationIns."First Name" + ' ' + StudentRegistrationIns."Last Name"
            ELSE
                IF (StudentRegistrationIns."Last Name" = '') AND (StudentRegistrationIns."Middle Name" <> '') THEN
                    StudentRegistrationIns."Student Name" := StudentRegistrationIns."First Name" + ' ' + StudentRegistrationIns."Middle Name"
                ELSE
                    IF (StudentRegistrationIns."Last Name" <> '') AND (StudentRegistrationIns."Middle Name" <> '') THEN
                        StudentRegistrationIns."Student Name" := Format(StudentRegistrationIns."First Name" + ' ' + StudentRegistrationIns."Middle Name" + ' ' + StudentRegistrationIns."Last Name");

            StudentRegistrationIns.Validate("Social Security No.", SSN);
            StudentRegistrationIns.Validate("Alternate E-Mail Address", Email);
            //StudentRegistrationIns."Student Name" := FirstName + ' ' + MiddleName + ' ' + LastName;

            //SD-SN-03-Dec-2020 +
            // if (PostalCode <> '') or (City <> '') then
            //     CreatePostCode(PostalCode, City, State, Country); //Post Code Creation for Normal
            // if (EmergCntPostalCode <> '') or (EmergCntCity <> '') then
            //     CreatePostCode(EmergCntPostalCode, EmergCntCity, EmergCntState, EmergCntCountry);//Emergency Contact  Post Code Creation
            // if (ResidentZipCode <> '') or (ResidentCity <> '') then
            //     CreatePostCode(ResidentZipCode, ResidentCity, ResidentState, ResidentCountry); //Resident Post Code Creation
            //SD-SN-03-Dec-2020 -

            If (DOB <> '') and (DOB <> '01/01/1900') then
                StudentRegistrationIns.validate("Date of Birth", ConvertTextToDate(DOB));
            StudentRegistrationIns.Validate(Gender, Gender);
            StudentRegistrationIns.Validate("Marital Status", MaritalStatus);
            StudentRegistrationIns.Validate("Street Address", StreetAddress);
            StudentRegistrationIns."Address 2" := Address2;
            StudentRegistrationIns."Address 3" := Address3;
            //StudentRegistrationIns.Validate("Postal Code", PostalCode);
            StudentRegistrationIns."Postal Code" := PostalCode;
            StudentRegistrationIns.Validate("Country Code", Country);
            if City <> '' then //SD-SN-04-Dec-2020 + 
                               //StudentRegistrationIns.Validate(City, City);
                StudentRegistrationIns.City := City;
            if State <> '' then //SD-SN-04-Dec-2020 +
                StudentRegistrationIns.Validate(State, State);

            StudentRegistrationIns.Validate("Emergency Contact First Name", EmergCntFirstName);
            StudentRegistrationIns.Validate("Emergency Contact Last Name", EmergCntLastName);
            StudentRegistrationIns.validate("Emergency Contact E-Mail", EmergCntEmail);
            StudentRegistrationIns.Validate("Emergency Contact RelationShip", EmergCntRelationship);
            StudentRegistrationIns.Validate("Emergency Contact Phone No.", EmergCntPhone);
            StudentRegistrationIns.Validate("Emergency Contact Phone No. 2", EmergCntAltPhone);
            StudentRegistrationIns.Validate("Emergency Contact Address", EmergCntAddress);
            if EmergCntPostalCode <> '' then //SD-SN-04-Dec-2020 + 
                                             //StudentRegistrationIns.Validate("Emergency Contact Postal Code", EmergCntPostalCode);
                StudentRegistrationIns."Emergency Contact Postal Code" := EmergCntPostalCode;
            StudentRegistrationIns.Validate("Emergency Contact Country Code", EmergCntCountry);
            if EmergCntCity <> '' then //SD-SN-04-Dec-2020 +
                                       //StudentRegistrationIns.Validate("Emergency Contact City", EmergCntCity);
                StudentRegistrationIns."Emergency Contact City" := EmergCntCity;
            StudentRegistrationIns.Validate("Emergency Contact State", EmergCntState);

            StudentRegistrationIns.Validate("Local Emergency First Name", LclEmrgCntFirstName);
            StudentRegistrationIns.Validate("Local Emergency Last Name", LclEmergCntLastName);
            StudentRegistrationIns.Validate("Local Emergency Street Address", LclEmergCntStreet);
            StudentRegistrationIns.Validate("Local Emergency Phone No.", LclEmergCntPhone);
            StudentRegistrationIns.Validate("Local Emergency City", LclEmergCntCity);

            StudentRegistrationIns.Validate(Remarks, Remarks);
            StudentRegistrationIns.Validate(Nationality, Nationality);
            StudentRegistrationIns.Validate(Citizenship, Citizen);
            //StudentRegistrationIns.Validate(Ethnicity, Ethnicity);
            StudentRegistrationIns.Validate("Student Passport Full Name", PassportFullName);
            StudentRegistrationIns.Validate("Pass Port No. 1", PassportNo);
            StudentRegistrationIns.Validate("Pass Port Issued By 1", PassportIssuedBy);
            IF (PassportIssuedDate <> '') and (PassportIssuedDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Pass Port Issued Date 1", ConvertTextToDate(PassportIssuedDate));
            IF (PassportExpDate <> '') and (PassportExpDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Pass Port Expiry Date 1", ConvertTextToDate(PassportExpDate));
            StudentRegistrationIns.Validate("Visa No.", VisaNo);
            If (VisaIssuedDate <> '') and (VisaIssuedDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Visa Issued Date", ConvertTextToDate(VisaIssuedDate));
            IF (VisaExpiryDate <> '') and (VisaExpiryDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Visa Expiry Date", ConvertTextToDate(VisaExpiryDate));
            IF (VisaExtensionDate <> '') and (VisaExtensionDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Visa Extension Date", ConvertTextToDate(VisaExtensionDate));
            // StudentRegistrationIns.Validate("Immigration Expiration Date", ConvertTextToDate(VisaExtensionDate));
            if (ImmiExpDate <> '') and (ImmiExpDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Immigration Expiration Date", ConvertTextToDate(ImmiExpDate));//change on 06May2021 discussed with Sanjeev

            If (ImmigrationIssuanceDate <> '') and (ImmigrationIssuanceDate <> '01/01/1900') then
                Evaluate(StudentRegistrationIns."Immigration Issuance Date", ImmigrationIssuanceDate);


            //SD-SN-03-Dec-2020 +
            //insert into Student Registration Record For Resident information
            StudentRegistrationIns.Validate("Resident Address", ResidentAddress);
            if ResidentZipCode <> '' then
                //StudentRegistrationIns.Validate("Resident Zip Code", ResidentZipCode);
                StudentRegistrationIns."Resident Zip Code" := ResidentZipCode;
            StudentRegistrationIns.Validate("Resident Country", ResidentCountry);
            if ResidentCity <> '' then
                //StudentRegistrationIns.Validate("Resident City", ResidentCity);
                StudentRegistrationIns."Resident City" := ResidentCity;
            StudentRegistrationIns.Validate("Resident state", ResidentState);
            StudentRegistrationIns."Fathers Name" := FatherName;
            StudentRegistrationIns."Father Contact Number" := FatherContactNo;
            StudentRegistrationIns."Father Email ID" := FatherEmailID;
            StudentRegistrationIns."Mothers Name" := MotherName;
            StudentRegistrationIns."Mother Contact Number" := MotherContactNo;
            StudentRegistrationIns."Mother Email ID" := MotherEmailID;
            StudentRegistrationIns."Guardian Name" := GuardianName;
            StudentRegistrationIns."Guardian Contact Number" := GuardianContactNo;
            StudentRegistrationIns."Guardian Email ID" := GuardianEmailID;
            //SD-SN-04-Dec-2020 +


            //SD-SN-04-Dec-2020 -

            //SD-SN-03-Dec-2020 -  
            IF not StudentRec."Returning Student" then begin
                //StudentRec.Validate(Title, StudentRegistrationIns.Title);
                //StudentRec.Validate("First Name", StudentRegistrationIns."First Name");
                // StudentRec.Validate("Last Name", StudentRegistrationIns."Last Name");
                // StudentRec.Validate("Middle Name", StudentRegistrationIns."Middle Name");
                // StudentRec.Validate("Maiden Name", StudentRegistrationIns."Maiden Name");
                StudentRec.Validate("Social Security No.", StudentRegistrationIns."Social Security No.");
                StudentRec.Validate("Alternate Email Address", StudentRegistrationIns."Alternate E-Mail Address");
                // StudentRec.Validate("Date of Birth", StudentRegistrationIns."Date of Birth");
                // StudentRec.Validate(Gender, StudentRegistrationIns.Gender);
                StudentRec.Validate("Marital Status", StudentRegistrationIns."Marital Status");

                StudentRec.Validate(Addressee, StudentRegistrationIns."Street Address");
                StudentRec.Address1 := StudentRegistrationIns."Address 2";
                StudentRec.Address2 := StudentRegistrationIns."Address 3";
            end;
            // if (StudentRegistrationIns."Postal Code" <> '') or (StudentRegistrationIns.City <> '') then
            //     CreatePostCode(StudentRegistrationIns."Postal Code", StudentRegistrationIns.City, StudentRegistrationIns.State, StudentRegistrationIns."Country Code");

            If not StudentRec."Returning Student" then begin
                //StudentRec.Validate("Post Code", StudentRegistrationIns."Postal Code");
                StudentRec."Post Code" := StudentRegistrationIns."Postal Code";
                StudentRec.Validate("Country Code", StudentRegistrationIns."Country Code");
                //StudentRec.Validate(City, StudentRegistrationIns.City);
                StudentRec.City := StudentRegistrationIns.City;
                StudentRec.Validate(State, StudentRegistrationIns.State);

                StudentRec.Validate("Emergency Contact First Name", StudentRegistrationIns."Emergency Contact First Name");
                StudentRec.Validate("Emergency Contact Last Name", StudentRegistrationIns."Emergency Contact Last Name");
                StudentRec.Validate("Emergency Contact E-Mail", StudentRegistrationIns."Emergency Contact E-Mail");
                StudentRec.Validate("Emergency Contact RelationShip", StudentRegistrationIns."Emergency Contact RelationShip");
                StudentRec.Validate("Emergency Contact Phone No.", StudentRegistrationIns."Emergency Contact Phone No.");
                StudentRec.Validate("Emergency Contact Phone No. 2", StudentRegistrationIns."Emergency Contact Phone No. 2");
                StudentRec.Validate("Emergency Contact Address", StudentRegistrationIns."Emergency Contact Address");

                //StudentRec.Validate("Emergency Contact Postal Code", StudentRegistrationIns."Emergency Contact Postal Code");
                StudentRec."Emergency Contact Postal Code" := StudentRegistrationIns."Emergency Contact Postal Code";
                StudentRec.Validate("Emergency Contact Country Code", StudentRegistrationIns."Emergency Contact Country Code");
                //StudentRec.Validate("Emergency Contact City", StudentRegistrationIns."Emergency Contact City");
                StudentRec."Emergency Contact City" := StudentRegistrationIns."Emergency contact City";
                StudentRec.Validate("Emergency Contact State", StudentRegistrationIns."Emergency Contact State");


                StudentRec.Validate("Local Emergency First Name", StudentRegistrationIns."Local Emergency First Name");
                StudentRec.Validate("Local Emergency Last Name", StudentRegistrationIns."Local Emergency Last Name");
                StudentRec.Validate("Local Emergency Street Address", StudentRegistrationIns."Local Emergency Street Address");
                StudentRec.Validate("Local Emergency City", StudentRegistrationIns."Local Emergency City");
                StudentRec.Validate(Remarks, StudentRegistrationIns.Remarks);
                StudentRec.Validate(Nationality, StudentRegistrationIns.Nationality);
                StudentRec.Validate(Citizenship, StudentRegistrationIns.Citizenship);
                //studentrec.Validate(Ethnicity, StudentRegistrationIns.Ethnicity);
                StudentRec.Validate("Name on Passport", StudentRegistrationIns."Student Passport Full Name");
                StudentRec.Validate("Pass Port No.", StudentRegistrationIns."Pass Port No. 1");
                StudentRec.Validate("Pass Port Issued By", StudentRegistrationIns."Pass Port Issued By 1");
                StudentRec.Validate("Pass Port Issued Date", StudentRegistrationIns."Pass Port Issued Date 1");
                StudentRec.Validate("Pass Port Expiry Date", StudentRegistrationIns."Pass Port Expiry Date 1");
                StudentRec.Validate("Visa No.", StudentRegistrationIns."Visa No.");
                StudentRec.Validate("Visa Issued Date", StudentRegistrationIns."Visa Issued Date");
                StudentRec.Validate("Visa Expiry Date", StudentRegistrationIns."Visa Expiry Date");
                StudentRec.Validate("Visa Extension Date", StudentRegistrationIns."Visa Extension Date");
                StudentRec.Validate("Immigration Expiration Date", StudentRegistrationIns."Immigration Expiration Date");
                StudentRec.Validate("Immigration Issuance Date", StudentRegistrationIns."Immigration Issuance Date");
                //SD-SN-03-Dec-2020 +
                //insert into Student Record For Resident information
                StudentRec.Validate("Resident Address", ResidentAddress);
                if ResidentZipCode <> '' then
                    //StudentRec.Validate("Resident Zip Code", ResidentZipCode);
                    StudentRec."Resident Zip Code" := ResidentZipCode;
                StudentRec.Validate("Resident Country", ResidentCountry);
                if ResidentCity <> '' then
                    //StudentRec.Validate("Resident City", ResidentCity);
                    StudentRec."Resident City" := ResidentCity;

                StudentRec.Validate("Resident state", ResidentState);
                If FatherName <> '' then
                    StudentRec."Fathers Name" := FatherName;
                If FatherContactNo <> '' then
                    StudentRec."Father Contact Number" := FatherContactNo;
                If FatherEmailID <> '' then
                    StudentRec."Father Email ID" := FatherEmailID;
                If MotherName <> '' then
                    StudentRec."Mothers Name" := MotherName;
                If MotherContactNo <> '' then
                    StudentRec."Mother Contact Number" := MotherContactNo;
                If MotherEmailID <> '' then
                    StudentRec."Mother Email ID" := MotherEmailID;
                If GuardianName <> '' then
                    StudentRec."Guardian Name" := GuardianName;
                If GuardianContactNo <> '' then
                    StudentRec."Guardian Contact Number" := GuardianContactNo;
                If GuardianEmailID <> '' then
                    StudentRec."Guardian Email ID" := GuardianEmailID;
                //SD-SN-04-Dec-2020 -


            end;
            //SD-SN-04-Dec-2020 -
            //SD-SN-03-Dec-2020 -

            if StudentRegistrationIns.Insert() then begin
                IF not StudentRec."Returning Student" then
                    StudentRec.Modify();
                EXIT('Success ' + Format(StudentRegistrationIns."Student No"));
            end else
                EXIT('Failed ' + Format(StudentRegistrationIns."Student No"));
        end;
        IF StudentRegistrationIns.FindFirst() then begin
            // StudentRegistrationIns.Init();
            // StudentRegistrationIns.Validate("Student No", StudentNo);
            // StudentRec.Get(StudentNo);
            // StudentRegistrationIns.Validate("Enrollment No", EnrollmentNo);
            // StudentRegistrationIns.Validate("Academic Year", AcademicYear);
            // StudentRegistrationIns.Validate(Semester, Sem);
            // StudentRegistrationIns.Validate("Course Code", CourseCode);
            // StudentRegistrationIns.Validate(Term, Term);

            StudentRec.Get(StudentNo);
            StudentRegistrationIns.Validate("Stage Basic Information", StageBasicInformation);
            IF (StageBaseInfoDate <> '') and (StageBaseInfoDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Stage Basic Info Date", ConvertTextToDate(StageBaseInfoDate));
            StudentRegistrationIns.Validate("Stage Basic Info Time", ConvertTextToTime(StageBasicInfoTime));
            //SD-SN-07-Dec-2020 -

            StudentRegistrationIns.Validate(Title, Title);
            StudentRegistrationIns.Validate("First Name", FirstName);
            StudentRegistrationIns.Validate("Maiden Name", MaidenName);
            StudentRegistrationIns.Validate("Middle Name", MiddleName);
            StudentRegistrationIns.Validate("Last Name", LastName);

            StudentRegistrationIns.TESTFIELD("First Name");
            CLEAR(StudentRegistrationIns."Student Name");

            StudentRegistrationIns."Student Name" := StudentRegistrationIns."First Name";
            IF (StudentRegistrationIns."Last Name" <> '') AND (StudentRegistrationIns."Middle Name" = '') THEN
                StudentRegistrationIns."Student Name" := StudentRegistrationIns."First Name" + ' ' + StudentRegistrationIns."Last Name"
            ELSE
                IF (StudentRegistrationIns."Last Name" = '') AND (StudentRegistrationIns."Middle Name" <> '') THEN
                    StudentRegistrationIns."Student Name" := StudentRegistrationIns."First Name" + ' ' + StudentRegistrationIns."Middle Name"
                ELSE
                    IF (StudentRegistrationIns."Last Name" <> '') AND (StudentRegistrationIns."Middle Name" <> '') THEN
                        StudentRegistrationIns."Student Name" := Format(StudentRegistrationIns."First Name" + ' ' + StudentRegistrationIns."Middle Name" + ' ' + StudentRegistrationIns."Last Name");

            StudentRegistrationIns.Validate("Social Security No.", SSN);
            StudentRegistrationIns.Validate("Alternate E-Mail Address", Email);
            //StudentRegistrationIns."Student Name" := FirstName + ' ' + MiddleName + ' ' + LastName;

            //SD-SN-03-Dec-2020 +
            // if (PostalCode <> '') or (City <> '') then
            //     CreatePostCode(PostalCode, City, State, Country); //Post Code Creation for Normal
            // if (EmergCntPostalCode <> '') or (EmergCntCity <> '') then
            //     CreatePostCode(EmergCntPostalCode, EmergCntCity, EmergCntState, EmergCntCountry);//Emergency Contact  Post Code Creation
            // if (ResidentZipCode <> '') or (ResidentCity <> '') then
            //     CreatePostCode(ResidentZipCode, ResidentCity, ResidentState, ResidentCountry); //Resident Post Code Creation
            //SD-SN-03-Dec-2020 -

            If (Dob <> '') and (DOB <> '01/01/1900') then
                StudentRegistrationIns.validate("Date of Birth", ConvertTextToDate(DOB));
            StudentRegistrationIns.Validate(Gender, Gender);
            StudentRegistrationIns.Validate("Marital Status", MaritalStatus);
            StudentRegistrationIns.Validate("Street Address", StreetAddress);
            //StudentRegistrationIns.Validate("Postal Code", PostalCode);
            StudentRegistrationIns."Postal Code" := PostalCode;
            StudentRegistrationIns.Validate("Country Code", Country);
            if City <> '' then //SD-SN-04-Dec-2020 + 
                               //StudentRegistrationIns.Validate(City, City);
                StudentRegistrationIns.City := City;
            if State <> '' then //SD-SN-04-Dec-2020 +
                StudentRegistrationIns.Validate(State, State);

            StudentRegistrationIns.Validate("Emergency Contact First Name", EmergCntFirstName);
            StudentRegistrationIns.Validate("Emergency Contact Last Name", EmergCntLastName);
            StudentRegistrationIns.validate("Emergency Contact E-Mail", EmergCntEmail);
            StudentRegistrationIns.Validate("Emergency Contact RelationShip", EmergCntRelationship);
            StudentRegistrationIns.Validate("Emergency Contact Phone No.", EmergCntPhone);
            StudentRegistrationIns.Validate("Emergency Contact Phone No. 2", EmergCntAltPhone);
            StudentRegistrationIns.Validate("Emergency Contact Address", EmergCntAddress);
            if EmergCntPostalCode <> '' then //SD-SN-04-Dec-2020 + 
                                             //StudentRegistrationIns.Validate("Emergency Contact Postal Code", EmergCntPostalCode);
                StudentRegistrationIns."Emergency Contact Postal Code" := EmergCntPostalCode;
            StudentRegistrationIns.Validate("Emergency Contact Country Code", EmergCntCountry);
            if EmergCntCity <> '' then //SD-SN-04-Dec-2020 +
                                       //StudentRegistrationIns.Validate("Emergency Contact City", EmergCntCity);
                StudentRegistrationIns."Emergency Contact City" := EmergCntCity;
            StudentRegistrationIns.Validate("Emergency Contact State", EmergCntState);

            StudentRegistrationIns.Validate("Local Emergency First Name", LclEmrgCntFirstName);
            StudentRegistrationIns.Validate("Local Emergency Last Name", LclEmergCntLastName);
            StudentRegistrationIns.Validate("Local Emergency Street Address", LclEmergCntStreet);
            StudentRegistrationIns.Validate("Local Emergency Phone No.", LclEmergCntPhone);
            StudentRegistrationIns.Validate("Local Emergency City", LclEmergCntCity);

            StudentRegistrationIns.Validate(Remarks, Remarks);
            StudentRegistrationIns.Validate(Nationality, Nationality);
            StudentRegistrationIns.Validate(Citizenship, Citizen);
            //StudentRegistrationIns.Validate(Ethnicity, Ethnicity);
            StudentRegistrationIns.Validate("Student Passport Full Name", PassportFullName);
            StudentRegistrationIns.Validate("Pass Port No. 1", PassportNo);
            StudentRegistrationIns.Validate("Pass Port Issued By 1", PassportIssuedBy);
            IF (PassportIssuedDate <> '') and (PassportIssuedDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Pass Port Issued Date 1", ConvertTextToDate(PassportIssuedDate));
            IF (PassportExpDate <> '') and (PassportExpDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Pass Port Expiry Date 1", ConvertTextToDate(PassportExpDate));
            StudentRegistrationIns.Validate("Visa No.", VisaNo);
            IF (VisaIssuedDate <> '') and (VisaIssuedDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Visa Issued Date", ConvertTextToDate(VisaIssuedDate));
            If (VisaExpiryDate <> '') And (VisaExpiryDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Visa Expiry Date", ConvertTextToDate(VisaExpiryDate));
            If (VisaExtensionDate <> '') and (VisaExtensionDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Visa Extension Date", ConvertTextToDate(VisaExtensionDate));
            // StudentRegistrationIns.Validate("Immigration Expiration Date", ConvertTextToDate(VisaExtensionDate));
            if (ImmiExpDate <> '') and (ImmiExpDate <> '01/01/1900') then
                StudentRegistrationIns.Validate("Immigration Expiration Date", ConvertTextToDate(ImmiExpDate));//change on 06May2021 discussed with Sanjeev

            If (ImmigrationIssuanceDate <> '') and (ImmigrationIssuanceDate <> '01/01/1900') then
                Evaluate(StudentRegistrationIns."Immigration Issuance Date", ImmigrationIssuanceDate);


            //SD-SN-03-Dec-2020 +
            //insert into Student Registration Record For Resident information
            StudentRegistrationIns.Validate("Resident Address", ResidentAddress);
            if ResidentZipCode <> '' then
                //StudentRegistrationIns.Validate("Resident Zip Code", ResidentZipCode);
                StudentRegistrationIns."Resident Zip Code" := ResidentZipCode;
            StudentRegistrationIns.Validate("Resident Country", ResidentCountry);
            if ResidentCity <> '' then
                //StudentRegistrationIns.Validate("Resident City", ResidentCity);
                StudentRegistrationIns."Resident City" := ResidentCity;
            StudentRegistrationIns.Validate("Resident state", ResidentState);
            StudentRegistrationIns."Fathers Name" := FatherName;
            StudentRegistrationIns."Father Contact Number" := FatherContactNo;
            StudentRegistrationIns."Father Email ID" := FatherEmailID;
            StudentRegistrationIns."Mothers Name" := MotherName;
            StudentRegistrationIns."Mother Contact Number" := MotherContactNo;
            StudentRegistrationIns."Mother Email ID" := MotherEmailID;
            StudentRegistrationIns."Guardian Name" := GuardianName;
            StudentRegistrationIns."Guardian Contact Number" := GuardianContactNo;
            StudentRegistrationIns."Guardian Email ID" := GuardianEmailID;
            //SD-SN-04-Dec-2020 +


            //SD-SN-04-Dec-2020 -

            //SD-SN-03-Dec-2020 -  
            IF not StudentRec."Returning Student" then begin
                //StudentRec.Validate(Title, StudentRegistrationIns.Title);
                //StudentRec.Validate("First Name", StudentRegistrationIns."First Name");
                // StudentRec.Validate("Last Name", StudentRegistrationIns."Last Name");
                // StudentRec.Validate("Middle Name", StudentRegistrationIns."Middle Name");
                // StudentRec.Validate("Maiden Name", StudentRegistrationIns."Maiden Name");
                StudentRec.Validate("Social Security No.", StudentRegistrationIns."Social Security No.");
                StudentRec.Validate("Alternate Email Address", StudentRegistrationIns."Alternate E-Mail Address");
                // StudentRec.Validate("Date of Birth", StudentRegistrationIns."Date of Birth");
                // StudentRec.Validate(Gender, StudentRegistrationIns.Gender);
                StudentRec.Validate("Marital Status", StudentRegistrationIns."Marital Status");

                StudentRec.Validate(Addressee, StudentRegistrationIns."Street Address");
            end;
            // if (StudentRegistrationIns."Postal Code" <> '') or (StudentRegistrationIns.City <> '') then
            //     CreatePostCode(StudentRegistrationIns."Postal Code", StudentRegistrationIns.City, StudentRegistrationIns.State, StudentRegistrationIns."Country Code");

            If not StudentRec."Returning Student" then begin
                //StudentRec.Validate("Post Code", StudentRegistrationIns."Postal Code");
                StudentRec."Post Code" := StudentRegistrationIns."Postal Code";
                StudentRec.Validate("Country Code", StudentRegistrationIns."Country Code");
                //StudentRec.Validate(City, StudentRegistrationIns.City);
                StudentRec.City := StudentRegistrationIns.City;
                StudentRec.Validate(State, StudentRegistrationIns.State);

                StudentRec.Validate("Emergency Contact First Name", StudentRegistrationIns."Emergency Contact First Name");
                StudentRec.Validate("Emergency Contact Last Name", StudentRegistrationIns."Emergency Contact Last Name");
                StudentRec.Validate("Emergency Contact E-Mail", StudentRegistrationIns."Emergency Contact E-Mail");
                StudentRec.Validate("Emergency Contact RelationShip", StudentRegistrationIns."Emergency Contact RelationShip");
                StudentRec.Validate("Emergency Contact Phone No.", StudentRegistrationIns."Emergency Contact Phone No.");
                StudentRec.Validate("Emergency Contact Phone No. 2", StudentRegistrationIns."Emergency Contact Phone No. 2");
                StudentRec.Validate("Emergency Contact Address", StudentRegistrationIns."Emergency Contact Address");

                //StudentRec.Validate("Emergency Contact Postal Code", StudentRegistrationIns."Emergency Contact Postal Code");
                StudentRec."Emergency Contact Postal Code" := StudentRegistrationIns."Emergency Contact Postal Code";
                StudentRec.Validate("Emergency Contact Country Code", StudentRegistrationIns."Emergency Contact Country Code");
                //StudentRec.Validate("Emergency Contact City", StudentRegistrationIns."Emergency Contact City");
                StudentRec."Emergency Contact City" := StudentRegistrationIns."Emergency contact City";
                StudentRec.Validate("Emergency Contact State", StudentRegistrationIns."Emergency Contact State");


                StudentRec.Validate("Local Emergency First Name", StudentRegistrationIns."Local Emergency First Name");
                StudentRec.Validate("Local Emergency Last Name", StudentRegistrationIns."Local Emergency Last Name");
                StudentRec.Validate("Local Emergency Street Address", StudentRegistrationIns."Local Emergency Street Address");
                StudentRec.Validate("Local Emergency City", StudentRegistrationIns."Local Emergency City");
                StudentRec."Local Emergency Phone No." := StudentRegistrationIns."Local Emergency Phone No.";
                StudentRec.Validate(Remarks, StudentRegistrationIns.Remarks);
                StudentRec.Validate(Nationality, StudentRegistrationIns.Nationality);
                StudentRec.Validate(Citizenship, StudentRegistrationIns.Citizenship);
                //studentrec.Validate(Ethnicity, StudentRegistrationIns.Ethnicity);
                StudentRec.Validate("Name on Passport", StudentRegistrationIns."Student Passport Full Name");
                StudentRec.Validate("Pass Port No.", StudentRegistrationIns."Pass Port No. 1");
                StudentRec.Validate("Pass Port Issued By", StudentRegistrationIns."Pass Port Issued By 1");
                StudentRec.Validate("Pass Port Issued Date", StudentRegistrationIns."Pass Port Issued Date 1");
                StudentRec.Validate("Pass Port Expiry Date", StudentRegistrationIns."Pass Port Expiry Date 1");
                StudentRec.Validate("Visa No.", StudentRegistrationIns."Visa No.");
                StudentRec.Validate("Visa Issued Date", StudentRegistrationIns."Visa Issued Date");
                StudentRec.Validate("Visa Expiry Date", StudentRegistrationIns."Visa Expiry Date");
                StudentRec.Validate("Visa Extension Date", StudentRegistrationIns."Visa Extension Date");
                StudentRec.Validate("Immigration Expiration Date", StudentRegistrationIns."Immigration Expiration Date");
                StudentRec.Validate("Immigration Issuance Date", StudentRegistrationIns."Immigration Issuance Date");
                //SD-SN-03-Dec-2020 +
                //insert into Student Record For Resident information
                StudentRec.Validate("Resident Address", ResidentAddress);
                if ResidentZipCode <> '' then
                    //StudentRec.Validate("Resident Zip Code", ResidentZipCode);
                    StudentRec."Resident Zip Code" := ResidentZipCode;
                StudentRec.Validate("Resident Country", ResidentCountry);
                if ResidentCity <> '' then
                    //StudentRec.Validate("Resident City", ResidentCity);
                    StudentRec."Resident City" := ResidentCity;

                StudentRec.Validate("Resident state", ResidentState);
                If FatherName <> '' then
                    StudentRec."Fathers Name" := FatherName;
                If FatherContactNo <> '' then
                    StudentRec."Father Contact Number" := FatherContactNo;
                If FatherEmailID <> '' then
                    StudentRec."Father Email ID" := FatherEmailID;
                If MotherName <> '' then
                    StudentRec."Mothers Name" := MotherName;
                If MotherContactNo <> '' then
                    StudentRec."Mother Contact Number" := MotherContactNo;
                If MotherEmailID <> '' then
                    StudentRec."Mother Email ID" := MotherEmailID;
                If GuardianName <> '' then
                    StudentRec."Guardian Name" := GuardianName;
                If GuardianContactNo <> '' then
                    StudentRec."Guardian Contact Number" := GuardianContactNo;
                If GuardianEmailID <> '' then
                    StudentRec."Guardian Email ID" := GuardianEmailID;
                //SD-SN-04-Dec-2020 -


            end;
            //SD-SN-04-Dec-2020 -
            //SD-SN-03-Dec-2020 -


            if StudentRegistrationIns.Modify() then begin
                IF not StudentRec."Returning Student" then
                    StudentRec.Modify();
                EXIT('Success ' + Format(StudentRegistrationIns."Student No"));
            end else
                EXIT('Failed ' + Format(StudentRegistrationIns."Student No"));
        end;

    End;

    Procedure APIStageAndOtherDetails(StageHousing: Boolean; StageHousingDate: Text[10]; StageHousingTime: Text[8];//////////////////////GMCS05
    BusTransportation: Boolean; BusTransportCell: Code[20];
    StageInsurance: Boolean; StageInsuranceDate: Text[10]; StageInsuranceTime: Text[8];
    StageFERPA: Boolean; StageFERPADate: Text[10]; StageFERPATime: Text[8];
    StageMediaRelease: Boolean; StageMediaReleaseDate: Text[10]; StageMediaReleaseTime: Text[8];
    MediaRelease: Boolean;
    StageAgreements: Boolean; StageAgreementsDate: Text[10]; StageAgreementsTime: Text[8];
    InsuranceAgreement: Boolean; BursarAgreement: Boolean; RegistrarAgreement: Boolean;
    T4Agreement: Boolean; ReleaseAgreement: Boolean; ResiNetworkAgreement: Boolean;
    EmergCntAgreement: Boolean;
    StageFinancialAid: Boolean; StageFinancialAidDate: Text[10]; StageFinancialAidTime: Text[8];
    StageBursar: Boolean; StageBursarDate: Text[10]; StageBursarTime: Text[8];
    StageConfirmation: Boolean; StageConfirmationDate: Text[10]; StageConfirmationTime: Text[8]; OLRComplete: Boolean;
    StageSignOff: Boolean; StageSignOffDate: Text[10]; StageSignOffTime: Text[8];
    StageFinalConfirm: Boolean;
    StudentNo: Code[20]; CourseCode: Code[20];
    Sem: Code[10];
    AcademicYear: Code[10]; Term: Option FALL,SPRING,SUMMER; MOUAgreement: Boolean; FERPARelease: Option " ",Accept,Decline; LeaseAgreement: Boolean; AntiguaCitizen: Boolean): Text[100];//GMCS//23//05//23

    var
        StudentRegistration: Record "Student Registration-CS";
        StudentRec: Record "Student Master-CS";
        StatusRec: Record "Student Status";
        StudentStatusMangCod: Codeunit "Student Status Mangement";
    Begin
        StudentRec.Get(StudentNo);
        StudentRegistration.Reset();
        StudentRegistration.SetRange("Student No", StudentNo);
        StudentRegistration.SetRange("Course Code", CourseCode);
        StudentRegistration.SetRange("Academic Year", AcademicYear);
        StudentRegistration.SetRange(Semester, Sem);
        StudentRegistration.SetRange(Term, Term);
        if not StudentRegistration.FindFirst() then
            Exit('Failed: Basic Information needs to be filled first');

        IF not StudentRec."Returning Student" then begin
            StudentRec."Transport Allot" := BusTransportation;
            StudentRec.Validate("Transport Cell", BusTransportCell);
            StudentRec."FERPA Release" := FERPARelease;
            IF (StageFERPADate <> '') and (StageFERPADate <> '01/01/1900') then
                StudentRec."Ferpa Release Date" := ConvertTextToDate(StageFERPADate);
        end;
        StudentRegistration.Validate("Transport Allot", BusTransportation);
        StudentRegistration.Validate("Transport Cell", BusTransportCell);
        StudentRegistration.validate("Stage Housing", StageHousing);

        IF (StageHousingDate <> '') and (StageHousingDate <> '01/01/1900') then
            StudentRegistration.Validate("Stage Housing Date", ConvertTextToDate(StageHousingDate));
        StudentRegistration.Validate("Stage Housing Time", ConvertTextToTime(StageHousingTime));

        StudentRegistration.validate("Stage Insurance", StageInsurance);
        IF (StageInsuranceDate <> '') and (StageInsuranceDate <> '01/01/1900') then
            StudentRegistration.validate("Stage Insurance Date", ConvertTextToDate(StageInsuranceDate));
        StudentRegistration.validate("Stage Insurance Time", ConvertTextToTime(StageInsuranceTime));

        StudentRegistration.validate("Stage FERPA", StageFERPA);
        IF (StageFERPADate <> '') and (StageFERPADate <> '01/01/1900') then
            StudentRegistration.validate("Stage FERPA Date", ConvertTextToDate(StageFERPADate));
        StudentRegistration.validate("Stage FERPA Time", ConvertTextToTime(StageFERPATime));
        StudentRegistration."FERPA Release" := FERPARelease;


        IF not StudentRec."Returning Student" then
            StudentRec.validate("Media Release Sign-off", MediaRelease);

        StudentRegistration.validate("Media Release Sign-off", MediaRelease);
        StudentRegistration.validate("Stage Media Release", StageMediaRelease);
        If (StageMediaReleaseDate <> '') and (StageMediaReleaseDate <> '01/01/1900') then
            StudentRegistration.validate("Stage Media Date", ConvertTextToDate(StageMediaReleaseDate));
        StudentRegistration.validate("Stage Media Time", ConvertTextToTime(StageMediaReleaseTime));

        StudentRegistration.validate("Insurance Agreement", InsuranceAgreement);
        StudentRegistration.validate("Bursar Agreement", BursarAgreement);
        StudentRegistration.validate("Registrar Agreement", RegistrarAgreement);
        StudentRegistration.CitizenAntiguaBarbuda := AntiguaCitizen;

        StudentRegistration.Validate("MOU Agreement", MOUAgreement);


        IF not StudentRec."Returning Student" then begin
            StudentRec.validate("T4 Authorization", T4Agreement);
            //StudentRec."MOU Agreement" := MOUAgreement;
            StudentRec."Lease Agreement" := LeaseAgreement;
            StudentRec.CitizenAntiguaBarbuda := AntiguaCitizen;
        end;

        StudentRegistration.validate("Title_IV Agreement", T4Agreement);
        StudentRegistration.validate("Release Agreement", ReleaseAgreement);
        StudentRegistration.validate("Residential Network Agreement", ResiNetworkAgreement);
        StudentRegistration.validate("Emergency Contact Check Agmt", EmergCntAgreement);

        StudentRegistration.validate("Stage Agreements", StageAgreements);

        IF (StageAgreementsDate <> '') and (StageAgreementsDate <> '01/01/1900') then
            StudentRegistration.validate("Stage Agreements Date", ConvertTextToDate(StageAgreementsDate));
        StudentRegistration.validate("Stage Agreements Time", ConvertTextToTime(StageAgreementsTime));


        StudentRegistration.validate("Stage Financial Aid", StageFinancialAid);


        IF (StageFinancialAidDate <> '') and (StageFinancialAidDate <> '01/01/1900') then
            StudentRegistration.validate("Stage Financial Aid Date", ConvertTextToDate(StageFinancialAidDate));
        StudentRegistration.validate("Stage Financial Aid Time", ConvertTextToTime(StageFinancialAidTime));

        StudentRegistration.validate("Stage Bursar", StageBursar);

        IF (StageBursarDate <> '') and (StageBursarDate <> '01/01/1900') then
            StudentRegistration.validate("Stage Bursar Date", ConvertTextToDate(StageBursarDate));
        StudentRegistration.validate("Stage Bursar Time", ConvertTextToTime(StageBursarTime));

        StudentRegistration.validate("Stage Confirmation", StageConfirmation);

        IF (StageConfirmationDate <> '') and (StageConfirmationDate <> '01/01/1900') then
            StudentRegistration.validate("Stage Confirmation Date", ConvertTextToDate(StageConfirmationDate));
        StudentRegistration.validate("Stage Confirmation Time", ConvertTextToTime(StageConfirmationTime));
        StudentRegistration."Lease Agreement" := LeaseAgreement;

        //IF not StudentRec."Returning Student" then begin
        IF StageSignOff then begin
            IF Not StudentREc."OLR Completed" then
                StudentRec.Validate("OLR Completed", StageSignoff); //not using OLRComplete boolean parameter anywhere.
            IF (StageSignOffDate <> '') and (StageSignOffDate <> '01/01/1900') then
                StudentRec.validate("OLR Completed Date", ConvertTextToDate(StageSignOffDate));
        end;
        //end;
        IF StageSignOff then begin
            IF not StudentRegistration."OLR Completed" then
                StudentRegistration.validate("OLR Completed", StageSignoff);

            IF (StageSignOffDate <> '') and (StageSignOffDate <> '01/01/1900') then
                StudentRegistration.validate("OLR Completed Date", ConvertTextToDate(StageSignOffDate));
            StudentRegistration.validate("OLR Completed Time", ConvertTextToTime(StageSignOffTime));
        end;
        //IF not StudentRec."Returning Student" then
        if StudentRec."OLR Completed" then begin
            StatusRec.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code");
            if StatusRec.Status IN [StatusRec.Status::Deposited, StatusRec.Status::Deferred, StatusRec.Status::Enrolled, StatusRec.Status::TWD] then
                StudentRec.validate(Status, StudentStatusMangCod.NewDeferredStudentOnlineRegistration(StudentRec."No.", StudentRec.Status, StudentRec."Global Dimension 1 Code"));

        end;

        //IF not StudentRec."Returning Student" then
        StudentRec.Modify(true);
        StudentRegistration.Modify(true);
        Exit('Success: Entry Inserted for Student No. ' + StudentRec."No.");
    end;


    Procedure APIInsuranceDetails(AlreadyHaveInsrance: Boolean; InsurancePolicyNo: Code[30]; InsuranceCarrier: Text[250];
     InsuranceValidFrom: Date; InsuranceValidTo: Date;
     StudentNo: Code[20]; CourseCode: Code[20]; Sem: Code[10]; AcademicYear: Code[10];
     Term: Option FALL,SPRING,SUMMER): Text[100]
    var
        StudentRegistration: Record "Student Registration-CS";
        StudentRec: Record "Student Master-CS";
        InsuranceValidFromTxt: Text;
        InsuranceValidToTxt: Text;
    Begin
        StudentRec.Get(StudentNo);
        StudentRegistration.Reset();
        StudentRegistration.SetRange("Student No", StudentNo);
        StudentRegistration.SetRange("Course Code", CourseCode);
        StudentRegistration.SetRange("Academic Year", AcademicYear);
        StudentRegistration.SetRange(Semester, Sem);
        StudentRegistration.SetRange(Term, Term);
        if not StudentRegistration.FindFirst() then
            Exit('Failed: Basic Information needs to be filled first');
        InsuranceValidFromTxt := Format(InsuranceValidFrom);
        InsuranceValidToTxt := Format(InsuranceValidTo);

        StudentRegistration.Validate("Apply for Insurance", Not (AlreadyHaveInsrance));
        IF not StudentRegistration."Apply for Insurance" then begin
            StudentRec.validate("Insurance Carrier", InsuranceCarrier);
            StudentRec.Validate("Policy Number / Group Number", InsurancePolicyNo);
            IF (InsuranceValidFromTxt <> '') And (InsuranceValidFromTxt <> '01/01/1900') then
                Evaluate(StudentRec."Insurance Valid From", InsuranceValidFromTxt);
            IF (InsuranceValidToTxt <> '') And (InsuranceValidToTxt <> '01/01/1900') then
                Evaluate(StudentRec."Insurance Valid To", InsuranceValidToTxt);
        end;
        IF StudentRegistration."Apply for Insurance" then begin
            StudentRec."Insurance Carrier" := '';
            StudentRec."Policy Number / Group Number" := '';
            StudentRec."Insurance Valid From" := 0D;
            StudentRec."Insurance Valid To" := 0D;
        end;

        //SD-SN-12-Dec-2020 +
        StudentRec.Validate("Apply for Insurance", Not (AlreadyHaveInsrance));
        //SD-SN-12-Dec-2020 -


        StudentRec.Modify(true);

        StudentRegistration.Modify(true);
        Exit('Success: Entry Inserted for Student No. ' + StudentRec."No.");
    End;

    procedure ConvertTextToDate(DateText: Text[10]): Date;
    var
        DateField: date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        DateErrorlbl: Label '"%1" is not in correct format, Date format must be yyyy-mm-dd.';
    begin
        if DateText = '' then
            DateField := 0D
        else begin
            if strlen(DateText) <> 10 then
                Error(DateErrorlbl, DateText); //yyyy-mm-dd 2020-12-18

            EVALUATE(Day, copystr(DateText, 9, 2));
            EVALUATE(Month, copystr(DateText, 6, 2));
            EVALUATE(Year, copystr(DateText, 1, 4));



            DateField := DMY2DATE(Day, Month, Year);
        end;
        exit(DateField);
    end;

    procedure ConvertTextToTime(TimeText: Text[8]): Time;
    var
        TimeField: Time;
    begin
        if TimeText = '' then
            Timefield := 0T
        else begin
            if strlen(TimeText) <> 8 then
                Error('"%1" is not in correct format, Time format must be hh:mm:ss.', TimeText); //hh:mm:ss 24:12:09
            evaluate(TimeField, TimeText);
        end;
        Exit(TimeField);
    end;
    // OLR Stages End

    procedure Studentongroundcheckin(StudentNo: Code[20]; AssignStudentGroup: Integer; DateAssigned: Date; AcademicYear: Code[20]; Semester: Code[20]; Term: Option FALL,SPRING,SUMMER; T4Agreement: Boolean): Text[50]////////////////////////GMCS05
    var
        Stud: Record "Student Master-CS";
        StudentRegistration: Record "Student Registration-CS";
        HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
        SlcMToSalesForce: Codeunit SLcMToSalesforce;
    begin
        if StudentNo = '' then
            Error('Student No. cannot be empty while sending information about Student OnGround Check-In.');
        if AssignStudentGroup <> 1 then
            Error('Student OnGround Check-In must be assigned.');
        if DateAssigned = 0D then
            Error('Student OnGround Check-In Date cannot be empty');
        Stud.Reset();
        Stud.Get(StudentNo);
        StudentRegistration.Reset();
        StudentRegistration.SetRange("Student No", StudentNo);
        StudentRegistration.SetRange(Semester, Semester);
        StudentRegistration.SetRange("Academic Year", AcademicYear);
        StudentRegistration.SetRange(Term, Term);
        If StudentRegistration.FindFirst() then begin
            If not (StudentRegistration."Title_IV Agreement") then
                StudentRegistration."Title_IV Agreement" := T4Agreement;
            StudentRegistration."Title 4 Agreement Dummy" := T4Agreement;
            StudentRegistration.Modify(True);
        end;


        //If not Stud."Clear OLR Data" then
        IF Stud."Student Group" = Stud."Student Group"::" " then begin
            Stud."Student Group" := Stud."Student Group"::"On-Ground Check-In";
            Stud."On Ground Check-In On" := DateAssigned;
            Stud."On Ground Check-In By" := StudentNo;

            Stud."T4 Authorization Dummy" := T4Agreement;//GMCS//23//05//23
            if not (Stud."T4 Authorization") then//GMCS//06062023
                Stud."T4 Authorization" := T4Agreement;//GMCS//23//05//23

            HoldUpdate_lCU.OnGroundCheckInStudentGroupEnable(StudentNo);
            Stud.Modify();
            SlcMToSalesForce.StudentStatusSFInsert(Stud);
        end;
    end;

    procedure WebAPIStudentImmigrationDetailsInsert(StudentNo: Code[20];
     PassportNo1: code[20]; PassPortIssuedDate1: Text; PassPortIssuedBy1: text[50];
     PassPortExpiryDate1: Text; PassportNo2: code[20]; PassPortIssuedDate2: Text; PassPortIssuedBy2: text[50];
     PassPortExpiryDate2: Text; PassportNo3: code[20]; PassPortIssuedDate3: Text; PassPortIssuedBy3: text[50];
     PassPortExpiryDate3: Text; VisaNo: Text[20]; VisaIssuedDate: Text; VisaExpiryDate: Text;
     VisaExtensionDate: Text; ImmigrationApplicationDate: Text;
     FirstName: Text[35]; LastName: Text[35]; CountryCode: Code[10];
     Addressee: Code[100]; Address1: Code[100]; Address2: Code[100]; PostCode: Code[20]; DocumentStatus: Option; ImmigrationIssuanceDate: Text; AcademicYear: Code[20]; Semester: Code[20]; Term: Integer): Text[100];
    var
        ImmigrationHeader: Record "Immigration Header";
        ImmigrationHeader1: Record "Immigration Header";
        CountryRegionRec: Record "Country/Region";
        StudentRec: Record "Student Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        GlSetup: record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RejectAppFound: Boolean;
    begin
        StudentRec.Get(StudentNo);
        // EducationSetupCS.Reset();
        // EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        // EducationSetupCS.FindFirst();
        GlSetup.get();
        GlSetup.TestField(GlSetup."Immigration Document No.");
        CountryRegionRec.Reset();
        CountryRegionRec.SetRange(Code, CountryCode);
        if CountryRegionRec.FindFirst() then
            if not CountryRegionRec."Immigration Applicable" then
                Error('Immigration is not Applicable for the Country %1', CountryRegionRec.Code);

        RejectAppFound := False;
        ImmigrationHeader1.Reset();
        ImmigrationHeader1.SetRange("Student No", StudentRec."No.");
        ImmigrationHeader1.SetRange(Semester, Semester);
        ImmigrationHeader1.SetRange("Academic Year", AcademicYear);
        ImmigrationHeader1.SetRange(Term, Term);
        //ImmigrationHeader1.SetRange("Document Status", ImmigrationHeader1."Document Status"::Rejected);
        IF ImmigrationHeader1.FindLast() then
            IF ImmigrationHeader1."Document Status" = ImmigrationHeader1."Document Status"::Rejected then
                RejectAppFound := True;

        If RejectAppFound then begin
            ImmigrationHeader.Init();
            ImmigrationHeader."Document No." := NoSeriesMgt.GetNextNo(GlSetup."Immigration Document No.", 0D, TRUE);
            ImmigrationHeader.Validate("Student No", StudentNo);
            ImmigrationHeader."First Name" := FirstName;
            ImmigrationHeader."Last Name" := LastName;
            ImmigrationHeader."Country Code" := CountryCode;
            ImmigrationHeader."Post Code" := PostCode;
            ImmigrationHeader.Addressee := Addressee;
            ImmigrationHeader.Address1 := Address1;
            ImmigrationHeader.Address2 := Address2;
            ImmigrationHeader."Document Status" := DocumentStatus;
            ImmigrationHeader.Validate("Pass Port No. 1", PassportNo1);
            if PassPortIssuedDate1 <> '' then
                Evaluate(ImmigrationHeader."Pass Port Issued Date 1", PassPortIssuedDate1);
            ImmigrationHeader.Validate("Pass Port Issued By 1", PassPortIssuedBy1);
            if PassPortExpiryDate1 <> '' then
                Evaluate(ImmigrationHeader."Pass Port Expiry Date 1", PassPortExpiryDate1);
            ImmigrationHeader.Validate("Pass Port No. 2", PassportNo2);
            if PassPortIssuedDate2 <> '' then
                Evaluate(ImmigrationHeader."Pass Port Issued Date 2", PassPortIssuedDate2);
            ImmigrationHeader.Validate("Pass Port Issued By 2", PassPortIssuedBy2);
            if PassPortExpiryDate2 <> '' then
                Evaluate(ImmigrationHeader."Pass Port Expiry Date 2", PassPortExpiryDate2);
            ImmigrationHeader.Validate("Pass Port No. 3", PassportNo3);
            if PassPortIssuedDate3 <> '' then
                Evaluate(ImmigrationHeader."Pass Port Issued Date 3", PassPortIssuedDate3);
            ImmigrationHeader.Validate("Pass Port Issued By 3", PassPortIssuedBy3);
            if PassPortExpiryDate3 <> '' then
                Evaluate(ImmigrationHeader."Pass Port Expiry Date 3", PassPortExpiryDate3);
            ImmigrationHeader.Validate("Visa No.", VisaNo);
            if VisaIssuedDate <> '' then
                Evaluate(ImmigrationHeader."Visa Issued Date", VisaIssuedDate);
            if VisaExpiryDate <> '' then
                Evaluate(ImmigrationHeader."Visa Expiry Date", VisaExpiryDate);
            if VisaExtensionDate <> '' then
                Evaluate(ImmigrationHeader."Visa Extension Date", VisaExtensionDate);
            if ImmigrationApplicationDate <> '' then
                Evaluate(ImmigrationHeader."Immigration Application Date", ImmigrationApplicationDate);
            If ImmigrationIssuanceDate <> '' then
                Evaluate(ImmigrationHeader."Immigration Issuance Date", ImmigrationIssuanceDate);
            IF AcademicYear <> '' then
                ImmigrationHeader.Validate("Academic Year", AcademicYear);
            IF Semester <> '' then
                ImmigrationHeader.Validate(Semester, Semester);
            ImmigrationHeader.Validate(Term, Term);
            if ImmigrationHeader.Insert() then
                exit('Success' + ' ' + ImmigrationHeader."Document No.")
            else
                exit('Failed' + ' ' + ImmigrationHeader."Document No.");
        end Else Begin
            ImmigrationHeader1.Reset();
            ImmigrationHeader1.SetRange("Student No", StudentRec."No.");
            ImmigrationHeader1.SetRange(Semester, Semester);
            ImmigrationHeader1.SetRange("Academic Year", AcademicYear);
            ImmigrationHeader1.SetRange(Term, Term);
            IF not ImmigrationHeader1.FindLast() then begin
                ImmigrationHeader.Init();
                ImmigrationHeader."Document No." := NoSeriesMgt.GetNextNo(GlSetup."Immigration Document No.", 0D, TRUE);
                ImmigrationHeader.Validate("Student No", StudentNo);
                ImmigrationHeader."First Name" := FirstName;
                ImmigrationHeader."Last Name" := LastName;
                ImmigrationHeader."Country Code" := CountryCode;
                ImmigrationHeader."Post Code" := PostCode;
                ImmigrationHeader.Addressee := Addressee;
                ImmigrationHeader.Address1 := Address1;
                ImmigrationHeader.Address2 := Address2;
                ImmigrationHeader."Document Status" := DocumentStatus;
                ImmigrationHeader.Validate("Pass Port No. 1", PassportNo1);
                if PassPortIssuedDate1 <> '' then
                    Evaluate(ImmigrationHeader."Pass Port Issued Date 1", PassPortIssuedDate1);
                ImmigrationHeader.Validate("Pass Port Issued By 1", PassPortIssuedBy1);
                if PassPortExpiryDate1 <> '' then
                    Evaluate(ImmigrationHeader."Pass Port Expiry Date 1", PassPortExpiryDate1);
                ImmigrationHeader.Validate("Pass Port No. 2", PassportNo2);
                if PassPortIssuedDate2 <> '' then
                    Evaluate(ImmigrationHeader."Pass Port Issued Date 2", PassPortIssuedDate2);
                ImmigrationHeader.Validate("Pass Port Issued By 2", PassPortIssuedBy2);
                if PassPortExpiryDate2 <> '' then
                    Evaluate(ImmigrationHeader."Pass Port Expiry Date 2", PassPortExpiryDate2);
                ImmigrationHeader.Validate("Pass Port No. 3", PassportNo3);
                if PassPortIssuedDate3 <> '' then
                    Evaluate(ImmigrationHeader."Pass Port Issued Date 3", PassPortIssuedDate3);
                ImmigrationHeader.Validate("Pass Port Issued By 3", PassPortIssuedBy3);
                if PassPortExpiryDate3 <> '' then
                    Evaluate(ImmigrationHeader."Pass Port Expiry Date 3", PassPortExpiryDate3);
                ImmigrationHeader.Validate("Visa No.", VisaNo);
                if VisaIssuedDate <> '' then
                    Evaluate(ImmigrationHeader."Visa Issued Date", VisaIssuedDate);
                if VisaExpiryDate <> '' then
                    Evaluate(ImmigrationHeader."Visa Expiry Date", VisaExpiryDate);
                if VisaExtensionDate <> '' then
                    Evaluate(ImmigrationHeader."Visa Extension Date", VisaExtensionDate);
                if ImmigrationApplicationDate <> '' then
                    Evaluate(ImmigrationHeader."Immigration Application Date", ImmigrationApplicationDate);
                If ImmigrationIssuanceDate <> '' then
                    Evaluate(ImmigrationHeader."Immigration Issuance Date", ImmigrationIssuanceDate);
                IF AcademicYear <> '' then
                    ImmigrationHeader.Validate("Academic Year", AcademicYear);
                IF Semester <> '' then
                    ImmigrationHeader.Validate(Semester, Semester);
                ImmigrationHeader.Validate(Term, Term);
                if ImmigrationHeader.Insert() then
                    exit('Success' + ' ' + ImmigrationHeader."Document No.")
                else
                    exit('Failed' + ' ' + ImmigrationHeader."Document No.");
            end Else begin
                If ImmigrationHeader1."Document Status" = ImmigrationHeader1."Document Status"::Verified then
                    exit('Already Verified' + ' ' + ImmigrationHeader1."Document No.");
                ImmigrationHeader1."First Name" := FirstName;
                ImmigrationHeader1."Last Name" := LastName;
                ImmigrationHeader1."Country Code" := CountryCode;
                ImmigrationHeader1."Post Code" := PostCode;
                ImmigrationHeader1.Addressee := Addressee;
                ImmigrationHeader1.Address1 := Address1;
                ImmigrationHeader1.Address2 := Address2;
                ImmigrationHeader1."Document Status" := DocumentStatus;
                ImmigrationHeader1.Validate("Pass Port No. 1", PassportNo1);
                if PassPortIssuedDate1 <> '' then
                    Evaluate(ImmigrationHeader1."Pass Port Issued Date 1", PassPortIssuedDate1);
                ImmigrationHeader1.Validate("Pass Port Issued By 1", PassPortIssuedBy1);
                if PassPortExpiryDate1 <> '' then
                    Evaluate(ImmigrationHeader1."Pass Port Expiry Date 1", PassPortExpiryDate1);
                ImmigrationHeader1.Validate("Pass Port No. 2", PassportNo2);
                if PassPortIssuedDate2 <> '' then
                    Evaluate(ImmigrationHeader1."Pass Port Issued Date 2", PassPortIssuedDate2);
                ImmigrationHeader1.Validate("Pass Port Issued By 2", PassPortIssuedBy2);
                if PassPortExpiryDate2 <> '' then
                    Evaluate(ImmigrationHeader1."Pass Port Expiry Date 2", PassPortExpiryDate2);
                ImmigrationHeader1.Validate("Pass Port No. 3", PassportNo3);
                if PassPortIssuedDate3 <> '' then
                    Evaluate(ImmigrationHeader1."Pass Port Issued Date 3", PassPortIssuedDate3);
                ImmigrationHeader1.Validate("Pass Port Issued By 3", PassPortIssuedBy3);
                if PassPortExpiryDate3 <> '' then
                    Evaluate(ImmigrationHeader1."Pass Port Expiry Date 3", PassPortExpiryDate3);
                ImmigrationHeader1.Validate("Visa No.", VisaNo);
                if VisaIssuedDate <> '' then
                    Evaluate(ImmigrationHeader1."Visa Issued Date", VisaIssuedDate);
                if VisaExpiryDate <> '' then
                    Evaluate(ImmigrationHeader1."Visa Expiry Date", VisaExpiryDate);
                if VisaExtensionDate <> '' then
                    Evaluate(ImmigrationHeader1."Visa Extension Date", VisaExtensionDate);
                if ImmigrationApplicationDate <> '' then
                    Evaluate(ImmigrationHeader1."Immigration Application Date", ImmigrationApplicationDate);
                If ImmigrationIssuanceDate <> '' then
                    Evaluate(ImmigrationHeader1."Immigration Issuance Date", ImmigrationIssuanceDate);
                IF AcademicYear <> '' then
                    ImmigrationHeader.Validate("Academic Year", AcademicYear);
                IF Semester <> '' then
                    ImmigrationHeader.Validate(Semester, Semester);
                ImmigrationHeader.Validate(Term, Term);
                IF ImmigrationHeader1.Modify(true) then
                    exit('Success' + ' ' + ImmigrationHeader1."Document No.")
                else
                    exit('Failed' + ' ' + ImmigrationHeader1."Document No.");
            End;
        end;
    end;

    procedure WebAPIStudentDocumentAttachment(StudentNo: Code[20]; DocumentCategory: Code[250]; DocumentSubCategory: Code[250];
     TransactionNo: Code[30]; DocumentID: Code[30]; SubjectCode: Code[20]; FileName: Text[100];
     FileType: Text[10]; UploadedOn: Date; UploadedBy: Text[100]; UploadedSource: Option; DocumentStatus: Option;
     StatusUpdatedby: Text[100]; StatusUpdatedDate: Date; DocumentDue: Date; ExpiryDate: Date; SLcMDocumentNo: Code[20]): Text[250];
    var
        StudentDocumentAttachment: Record "Student Document Attachment";
        StudentDocumentAttachment1: Record "Student Document Attachment";
        StudentDocumentAttachment2: Record "Student Document Attachment";
        DocSubCat: Record "Doc & Cate Attachment-CS";
        EntryNo: Integer;
    begin
        StudentDocumentAttachment2.RESET();
        StudentDocumentAttachment2.SetRange("Transaction No.", TransactionNo);
        IF NOT StudentDocumentAttachment2.FindFirst() THEN begin
            StudentDocumentAttachment1.RESET();
            IF StudentDocumentAttachment1.FINDLAST() THEN
                EntryNo := StudentDocumentAttachment1."Entry No." + 1;

            StudentDocumentAttachment.Init();
            StudentDocumentAttachment."Entry No." := EntryNo;
            StudentDocumentAttachment.Validate("Student No.", StudentNo);
            StudentDocumentAttachment."Document Category" := DocumentCategory;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Code, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment.Description := DocSubCat.Description;
                StudentDocumentAttachment."Document Description" := DocSubCat.Description;
            end;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Description, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment.Description := DocSubCat.Description;
                StudentDocumentAttachment."Document Description" := DocSubCat.Description;
            end;
            StudentDocumentAttachment."Transaction No." := TransactionNo;
            StudentDocumentAttachment."Document ID" := DocumentID;
            StudentDocumentAttachment."Subject Code" := SubjectCode;
            StudentDocumentAttachment."File Name" := FileName;
            StudentDocumentAttachment."File Type" := FileType;
            StudentDocumentAttachment."Uploaded On" := UploadedOn;
            StudentDocumentAttachment."Uploaded By" := UploadedBy;
            StudentDocumentAttachment."Uploaded Source" := UploadedSource;
            StudentDocumentAttachment."Document Status" := DocumentStatus;
            StudentDocumentAttachment."Status Updated By" := StatusUpdatedby;
            StudentDocumentAttachment."Status Updated Date" := StatusUpdatedDate;
            StudentDocumentAttachment."Document Due" := DocumentDue;
            StudentDocumentAttachment."Expiry Date" := ExpiryDate;
            StudentDocumentAttachment."SLcM Document No" := SLcMDocumentNo;
            if StudentDocumentAttachment.Insert() then begin
                exit('Success' + ' ' + Format(EntryNo))
            end else
                exit('Failed' + ' ' + StudentNo);
        end Else begin
            StudentDocumentAttachment2.Validate("Student No.", StudentNo);
            StudentDocumentAttachment2."Document Category" := DocumentCategory;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Code, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment2."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment2.Description := DocSubCat.Description;
                StudentDocumentAttachment2."Document Description" := DocSubCat.Description;
            end;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Description, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment2."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment2.Description := DocSubCat.Description;
                StudentDocumentAttachment2."Document Description" := DocSubCat.Description;
            end;
            StudentDocumentAttachment2."Document ID" := DocumentID;
            StudentDocumentAttachment2."Subject Code" := SubjectCode;
            StudentDocumentAttachment2."File Name" := FileName;
            StudentDocumentAttachment2."File Type" := FileType;
            StudentDocumentAttachment2."Uploaded On" := UploadedOn;
            StudentDocumentAttachment2."Uploaded By" := UploadedBy;
            StudentDocumentAttachment2."Uploaded Source" := UploadedSource;
            StudentDocumentAttachment2."Document Status" := DocumentStatus;
            StudentDocumentAttachment2."Status Updated By" := StatusUpdatedby;
            StudentDocumentAttachment2."Status Updated Date" := StatusUpdatedDate;
            StudentDocumentAttachment2."Document Due" := DocumentDue;
            StudentDocumentAttachment2."Expiry Date" := ExpiryDate;
            StudentDocumentAttachment2."SLcM Document No" := SLcMDocumentNo;
            if StudentDocumentAttachment2.Modify() then begin
                exit('Success' + ' ' + TransactionNo)
            end else
                exit('Failed' + ' ' + TransactionNo);

        end;
    end;


    procedure WebAPIDocumentIDUpdate(TransactionNo: Code[30]; DocumentID: Code[20]): Text[250];
    var
        StudentDocumentAttachment: Record "Student Document Attachment";
        StudentDocumentAttachment1: Record "Student Document Attachment";
        EntryNo: Integer;
    begin
        StudentDocumentAttachment.RESET();
        StudentDocumentAttachment.SetRange("Transaction No.", TransactionNo);
        IF StudentDocumentAttachment.FINDFIRST() THEN Begin
            IF DocumentID <> '' then begin
                StudentDocumentAttachment."Document ID" := DocumentID;
                IF StudentDocumentAttachment.Modify(true) then
                    exit('Success')
                else
                    exit('Failed');
            end Else begin
                IF StudentDocumentAttachment.Delete() then
                    exit('Success')
                else
                    exit('Failed');
            end;

        End;
    End;

    procedure WebAPIDigitalSignature(DocumentID: Code[30]; DocumentCategory: Code[250]; DocumentSubCategory: Code[250];
     HelloSign: Code[100]; SignatoryUser: Code[100]; SignatureRequestSentDate: Date; SignatureRequestSentTime: Time; SignatureStatus: Boolean;
    SignedDate: Date; SignedTime: Time; VerifiedRequired: Boolean; DigitalSignature: Boolean): Text[250];
    var
        DigitalSignatureDetail: Record "Digital Signature Details";
        DigitalSignatureDetail1: Record "Digital Signature Details";
        EntryNo: Integer;
    begin

        DigitalSignatureDetail1.Reset();
        If DigitalSignatureDetail1.FindLast() Then
            EntryNo := DigitalSignatureDetail1."Entry No." + 1;

        DigitalSignatureDetail.Init();
        DigitalSignatureDetail."Entry No." := EntryNo;
        DigitalSignatureDetail."Document ID" := DocumentID;
        DigitalSignatureDetail."Document Category" := DocumentCategory;
        DigitalSignatureDetail."Document Sub Category" := DocumentSubCategory;
        DigitalSignatureDetail."Hello Sign ID" := HelloSign;
        DigitalSignatureDetail."Signatory/User ID" := SignatoryUser;
        DigitalSignatureDetail."Signature Request Sent Date" := SignatureRequestSentDate;
        DigitalSignatureDetail."Signature Request Sent Time" := SignatureRequestSentTime;
        DigitalSignatureDetail."Signature Status" := SignatureStatus;
        DigitalSignatureDetail."Signed Date" := SignedDate;
        DigitalSignatureDetail."Signed Time" := SignedTime;
        DigitalSignatureDetail."Verified Required" := VerifiedRequired;
        DigitalSignatureDetail."Digital Signature Required" := DigitalSignature;
        IF DigitalSignatureDetail.Insert(true) then
            exit('Success' + ' ' + Format(EntryNo))
        else
            exit('Failed');
    End;

    procedure CreatePostCode(Postcode: code[20]; City: code[30]; StateCode: Code[20]; CountryCode: Code[10])
    var
        PostCodeRec: Record "Post Code";
        PostCodeRec2: Record "Post Code";
    begin
        if (StateCode <> '') and (CountryCode = '') then
            Error('Country Code cannot be blank');
        PostCodeRec.Reset();
        PostCodeRec.SetRange(Code, Postcode);
        PostCodeRec.SetRange(City, City);
        if PostCodeRec.FindFirst() then begin
            if (StateCode <> PostCodeRec."State Code") or (CountryCode <> PostCodeRec."Country/Region Code") then
                Error('Post Code %1 and City %2 are part of State Code %3 and Country Code %4. Please Enter correct Post Code and City',
                PostCode, City, PostCodeRec."State Code", PostCodeRec."Country/Region Code");
        end;


        PostCodeRec.Reset();
        PostCodeRec.SetRange(Code, Postcode);
        PostCodeRec.SetRange(City, City);
        PostCodeRec.SetRange("Country/Region Code", CountryCode);
        PostCodeRec.SetRange("State Code", StateCode);
        if not PostCodeRec.FindFirst() then begin
            PostCodeRec2.Reset();
            PostCodeRec2.Init();
            PostCodeRec2.Code := Postcode;
            PostCodeRec2.City := City;
            PostCodeRec2.Validate("Country/Region Code", CountryCode);
            if StateCode <> '' then
                PostCodeRec2.Validate("State Code", StateCode);

            PostCodeRec2.Insert(True);
        end;
    end;

    procedure StudentMissingFieldToSF(StudentNo: Code[20]; UserIDString: code[50]; EmailID: Text[50]; PasswordStringFinal: Code[30]): Text[2048]
    var
        StudentRec: Record "Student Master-CS";
        SLcMToSalesforceCodeunit: Codeunit SLcMToSalesforce;
        WebServFn: Codeunit WebServicesFunctionsCSL;
    begin
        If StudentNo = '' then
            Error('Student No. cannot be blank');
        if EmailID = '' then
            Error('Email ID cannot be blank');
        StudentRec.Reset();
        StudentRec.Get(StudentNo);
        WebServFn.PortalUserLoginInsert(StudentRec, UserIDString, EmailID, PasswordStringFinal);
        StudentRec.Modify();
        Exit(SLcMToSalesforceCodeunit.StudentMasterSFModify(StudentRec));
    end;

    procedure WebAPIStudentEthnicityInsert(
    StudentNo: Code[20];
    EthnicityCode: Code[20];
    EthnicityDescription: Text[50];
    CreatedBy: Text[50];
    CreatedOn: date;
    ModifiedBy: Text[50];
    ModifiedOn: date
    ): Text[100];
    var
        StudentEthnicity: Record "Student Ethnicity";
        StudentRec: Record "Student Master-CS";
    begin
        StudentRec.Get(StudentNo);
        StudentEthnicity.Reset();
        StudentEthnicity.SetRange("Student No.", StudentNo);
        StudentEthnicity.SetRange("Ethnicity Code", EthnicityCode);
        IF Not StudentEthnicity.FindFirst() then begin
            StudentEthnicity.Init();
            StudentEthnicity.Validate("Ethnicity Code", EthnicityCode);
            StudentEthnicity.Validate("Ethnicity Name", EthnicityDescription);
            StudentEthnicity.Validate("Student No.", StudentNo);
            StudentEthnicity."Student Name" := StudentRec."Student Name";
            StudentEthnicity."Created By" := CreatedBy;
            StudentEthnicity."Created On" := CreatedOn;
            StudentEthnicity."Modified By" := ModifiedBy;
            StudentEthnicity."Modified On" := ModifiedOn;
            if StudentEthnicity.Insert() then
                exit('Success' + ' ' + StudentEthnicity."Student No.")
            else
                exit('Failed' + ' ' + StudentEthnicity."Student No.");
        end Else Begin
            StudentEthnicity.Validate("Ethnicity Code", EthnicityCode);
            StudentEthnicity.Validate("Ethnicity Name", EthnicityDescription);
            StudentEthnicity.Validate("Student No.", StudentNo);
            StudentEthnicity."Student Name" := StudentRec."Student Name";
            StudentEthnicity."Created By" := CreatedBy;
            StudentEthnicity."Created On" := CreatedOn;
            StudentEthnicity."Modified By" := ModifiedBy;
            StudentEthnicity."Modified On" := ModifiedOn;
            if StudentEthnicity.Modify() then
                exit('Success' + ' ' + StudentEthnicity."Student No.")
            else
                exit('Failed' + ' ' + StudentEthnicity."Student No.");
        End;
    end;

    procedure WebAPIStudentEthnicityDelete(
    StudentNo: Code[20];
    EthnicityCode: Code[20]
    ): Text[100];
    var
        StudentEthnicity: Record "Student Ethnicity";
        StudentRec: Record "Student Master-CS";
    begin
        StudentRec.Get(StudentNo);
        StudentEthnicity.Reset();
        StudentEthnicity.SetRange("Student No.", StudentNo);
        StudentEthnicity.SetRange("Ethnicity Code", EthnicityCode);
        IF StudentEthnicity.FindFirst() then begin
            if StudentEthnicity.Delete() then
                exit('Success' + ' ' + StudentEthnicity."Student No.")
            else
                exit('Failed' + ' ' + StudentEthnicity."Student No.");
        end;
    end;

    procedure WebAPIFERPAInformationHeaderInsert(
    StudentNo: Code[20];
    ShareStartDate: Date;
    ShareEndDate: Date;
    CreationDate: Date;
    CreatedBy: Code[50];
    UpdatedOn: Date;
    UpdatedBy: Code[50];
    Reason: Text[250]
    ; AY: Code[20]; Sem: Code[10]; Term: Option FALL,SPRING,SUMMER): Text[100];
    var
        FERPAInformationHeader: Record "FERPA Information Header";
        FERPAInformationHeader1: Record "FERPA Information Header";
        RecStudentMaster: Record "Student Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        RecStudentMaster.GET(StudentNo);
        FERPAInformationHeader.Reset();
        FERPAInformationHeader.SetRange("Student No", StudentNo);
        // FERPAInformationHeader.SetRange(Semester, RecStudentMaster."Semester");
        // FERPAInformationHeader.SetRange("Academic Year", RecStudentMaster."Academic Year");
        FERPAInformationHeader.SetRange(Semester, Sem);
        FERPAInformationHeader.SetRange("Academic Year", AY);
        IF Not FERPAInformationHeader.FindFirst() then begin
            EducationSetupCS.Reset();
            EducationSetupCS.SetRange("Global Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
            EducationSetupCS.FindFirst();
            EducationSetupCS.TestField(EducationSetupCS."FERPA Info Header No.");
            FERPAInformationHeader.Init();
            FERPAInformationHeader."Info Header No" := NoSeriesMgt.GetNextNo(EducationSetupCS."FERPA Info Header No.", 0D, TRUE);
            FERPAInformationHeader.Validate("Student No", StudentNo);
            // FERPAInformationHeader.Validate("Academic Year", RecStudentMaster."Academic Year");
            // FERPAInformationHeader.Validate("Semester", RecStudentMaster."Semester");
            // FERPAInformationHeader.Validate("Term", RecStudentMaster."Term");
            FERPAInformationHeader.Validate("Academic Year", AY);
            FERPAInformationHeader.Validate("Semester", Sem);
            FERPAInformationHeader.Validate("Term", Term);
            // FERPAInformationHeader.Validate("Share Start Date", ShareStartDate);
            // FERPAInformationHeader.Validate("Share End Date", ShareEndDate);
            FERPAInformationHeader.Validate("Share Start Date", 0D);
            FERPAInformationHeader.Validate("Share End Date", 0D);
            FERPAInformationHeader.Validate("Creation Date", CreationDate);
            FERPAInformationHeader.Validate("Created By", CreatedBy);
            FERPAInformationHeader.Validate("User ID", UserId);
            FERPAInformationHeader.Validate("Updated On", UpdatedOn);
            FERPAInformationHeader.Validate("Updated By", UpdatedBy);
            FERPAInformationHeader.Validate(Reason, Reason);
            if FERPAInformationHeader.Insert() then
                exit('Success' + ' ' + FERPAInformationHeader."Info Header No")
            else
                exit('Failed' + ' ' + FERPAInformationHeader."Info Header No");
        end Else Begin
            FERPAInformationHeader.Validate("Student No", StudentNo);
            // FERPAInformationHeader.Validate("Academic Year", RecStudentMaster."Academic Year");
            // FERPAInformationHeader.Validate("Semester", RecStudentMaster."Semester");
            // FERPAInformationHeader.Validate("Term", RecStudentMaster."Term");
            FERPAInformationHeader.Validate("Academic Year", AY);
            FERPAInformationHeader.Validate("Semester", Sem);
            FERPAInformationHeader.Validate("Term", Term);
            // FERPAInformationHeader.Validate("Share Start Date", ShareStartDate);
            // FERPAInformationHeader.Validate("Share End Date", ShareEndDate);
            FERPAInformationHeader.Validate("Share Start Date", 0D);
            FERPAInformationHeader.Validate("Share End Date", 0D);
            FERPAInformationHeader.Validate("Creation Date", CreationDate);
            FERPAInformationHeader.Validate("Created By", CreatedBy);
            FERPAInformationHeader.Validate("User ID", UserId());
            FERPAInformationHeader.Validate("Updated On", UpdatedOn);
            FERPAInformationHeader.Validate("Updated By", UpdatedBy);
            FERPAInformationHeader.Validate(Reason, Reason);
            IF FERPAInformationHeader.Modify(true) then
                exit('Success' + ' ' + FERPAInformationHeader."Info Header No")
            else
                exit('Failed' + ' ' + FERPAInformationHeader."Info Header No");
        End;
    end;

    procedure WebAPICalcOldDues(CustNo: Code[20]; CurrAY: code[20]; CurrSem: Code[20]; CurrTerm: Option; var OldDueAmt: Decimal): Text[100];
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        Stud: Record "Student Master-CS";
    begin
        // Stud.Get(CustNo);                //12122022 Navdeep Spring 2023
        // CustomerLedgerEntry.reset();
        // CustomerLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Customer No.");
        // CustomerLedgerEntry.SetRange("Customer No.", Stud."Original Student No.");
        // CustomerLedgerEntry.SetFilter("Posting Date", '<%1', Today());
        // CustomerLedgerEntry.SetRange(Reversed, false);
        // CustomerLedgerEntry.SetFilter("Remaining Amount", '<>%1', 0);
        // CustomerLedgerEntry.SetRange("Enrollment No.", Stud."Enrollment No.");
        // if CustomerLedgerEntry.FindSet() then
        //     repeat
        //         if not ((CustomerLedgerEntry."Academic Year" = CurrAY) and (CustomerLedgerEntry.Semester = CurrSem) and (CustomerLedgerEntry.Term = CurrTerm)) then begin
        //             CustomerLedgerEntry.CalcFields("Remaining Amount");

        //             OldDueAmt := OldDueAmt + CustomerLedgerEntry."Remaining Amount";
        //         end;
        //     until CustomerLedgerEntry.Next() = 0;
        OldDueAmt := 0;

        Exit('Success' + ' ' + Format(OldDueAmt))

    end;

    //"Withdrawal Student Subject Master Start - 21-01-2021

    procedure WebAPIWithdrawalStudentSubjectMappingInsert(
    WithdrawalRequestNo_: Code[20];
    SubjectCode: Code[20];
    StudentNo_: Code[20]): Text[100];
    var
        WithdrawalStudentCourse_lRec: Record "Withdrawal Student Subject";
    begin
        WithdrawalStudentCourse_lRec.Reset();
        WithdrawalStudentCourse_lRec.SetRange("Withdrawal Request No.", WithdrawalRequestNo_);
        WithdrawalStudentCourse_lRec.SetRange("Subject Code", SubjectCode);
        IF not WithdrawalStudentCourse_lRec.FindFirst() then begin
            WithdrawalStudentCourse_lRec.Init();
            WithdrawalStudentCourse_lRec.Validate("Withdrawal Request No.", WithdrawalRequestNo_);
            WithdrawalStudentCourse_lRec.Validate("Subject Code", SubjectCode);
            WithdrawalStudentCourse_lRec.Validate("Student No.", StudentNo_);
            If WithdrawalStudentCourse_lRec.Insert() then
                exit('Success' + ' ' + WithdrawalStudentCourse_lRec."Withdrawal Request No." + ' ' + WithdrawalStudentCourse_lRec."Subject Code")
            else
                exit('Failed' + ' ' + WithdrawalStudentCourse_lRec."Withdrawal Request No." + ' ' + WithdrawalStudentCourse_lRec."Subject Code");
        end Else Begin
            WithdrawalStudentCourse_lRec.Validate("Withdrawal Request No.", WithdrawalRequestNo_);
            WithdrawalStudentCourse_lRec.Validate("Subject Code", SubjectCode);
            WithdrawalStudentCourse_lRec.Validate("Student No.", StudentNo_);
            If WithdrawalStudentCourse_lRec.Modify() then
                exit('Success' + ' ' + WithdrawalStudentCourse_lRec."Withdrawal Request No." + ' ' + WithdrawalStudentCourse_lRec."Subject Code")
            else
                exit('Failed' + ' ' + WithdrawalStudentCourse_lRec."Withdrawal Request No." + ' ' + WithdrawalStudentCourse_lRec."Subject Code");
        End;
    end;

    //"Withdrawal Student Subject Master End - 21-01-2021

    //Update Student Image from Portal Start - 29-01-2021
    procedure WebAPIUpdateStudentImagefromPortal(
        StudentNo_: Code[20];
        Base64String: Text): Text[100];
    Var
        StudentMaster_lRec: Record "Student Master-CS";
        TempBlob_lRec: Record "TempBlob Test";
        TempBlob: Codeunit "Temp Blob";

    Begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("No.", StudentNo_);
        If StudentMaster_lRec.FindFirst() then begin
            //TempBlob_lRec.FromBase64String(Base64String);
            StudentMaster_lRec."Student Image" := TempBlob_lRec.Blob;
            StudentMaster_lRec.Modify();
            If StudentMaster_lRec."Student Image".HasValue then
                exit('Success' + ' ' + StudentMaster_lRec."No.");
            IF not StudentMaster_lRec."Student Image".HasValue then
                exit('Failed' + ' ' + StudentMaster_lRec."No.");
        end;
    End;

    //Update Student Image from Portal End - 29-01-2021
    procedure WebAPIClinicalDocumentAttachment(StudentNo: Code[20]; DocumentCategory: Code[250]; DocumentSubCategory: Code[250];
     TransactionNo: Code[30]; DocumentID: Code[30]; SubjectCode: Code[20]; FileName: Text[100];
     FileType: Text[10]; UploadedBy: Text[100]; UploadedSource: Option; DocumentsStatusClinical: Option;
     ValidityStartDate: Text; ValidityExpiryDate: Text; DocumentDescription: text[100]; SLcMDocumentNo: Code[20]): Text[250];
    var
        StudentDocumentAttachment: Record "Student Document Attachment";
        StudentDocumentAttachment1: Record "Student Document Attachment";
        SDA_1: Record "Student Document Attachment";
        StudentMaster: Record "Student Master-CS";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        ClinicalNotification: Codeunit "Clinical Notification";
        DocumentDueDate: Date;
        LValidityStartDate: Date;
        EntryNo: Integer;
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then
            StudentMaster.TestField("Document Specialist");

        DocumentDueDate := 0D;
        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentNo);
        if ClerkshipSiteAndDateSelection.FindLast() then
            DocumentDueDate := ClerkshipSiteAndDateSelection."Document Due Date";

        SDA_1.Reset();
        SDA_1.SetRange("Student No.", StudentNo);
        SDA_1.SetRange("Document Category", DocumentCategory);
        SDA_1.SetRange("Document Sub Category", DocumentSubCategory);
        SDA_1.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
        IF not SDA_1.FindFirst() then begin
            StudentDocumentAttachment1.RESET();
            IF StudentDocumentAttachment1.FINDLAST() THEN
                EntryNo := StudentDocumentAttachment1."Entry No." + 1;

            StudentDocumentAttachment.Init();
            StudentDocumentAttachment."Entry No." := EntryNo;
            StudentDocumentAttachment.Validate("Student No.", StudentNo);
            StudentDocumentAttachment."Document Category" := DocumentCategory;
            StudentDocumentAttachment.Validate("Document Sub Category", DocumentSubCategory);
            StudentDocumentAttachment."Transaction No." := TransactionNo;
            StudentDocumentAttachment."Document ID" := DocumentID;
            StudentDocumentAttachment."Subject Code" := SubjectCode;
            StudentDocumentAttachment."File Name" := FileName;
            StudentDocumentAttachment."File Type" := FileType;
            StudentDocumentAttachment."Uploaded On" := Today();
            StudentDocumentAttachment."Submission Date" := Today();
            StudentDocumentAttachment."Uploaded By" := UploadedBy;
            StudentDocumentAttachment."Uploaded Source" := UploadedSource;
            StudentDocumentAttachment."Document Status" := DocumentsStatusClinical;

            LValidityStartDate := 0D;
            if ValidityStartDate <> '' then begin
                Evaluate(LValidityStartDate, ValidityStartDate);
                StudentDocumentAttachment.Validate("Validity Start Date", LValidityStartDate);
            end;

            StudentDocumentAttachment."Validity Expiry Date" := StudentDocumentAttachment."Expiry Date";
            StudentDocumentAttachment."Document Description" := DocumentDescription;
            StudentDocumentAttachment."SLcM Document No" := SLcMDocumentNo;
            StudentDocumentAttachment."Document Specialist ID" := StudentMaster."Document Specialist";
            StudentDocumentAttachment."Document Due" := DocumentDueDate;

            if StudentDocumentAttachment.Insert() then begin
                //ClinicalNotification.SendOnDocumentUpload(StudentNo, DocumentDescription);
                exit('Success' + ' ' + Format(EntryNo))
            END
            else
                exit('Failed' + ' ' + StudentNo);
        end Else begin
            SDA_1."Document ID" := DocumentID;
            SDA_1."Document Status" := SDA_1."Document Status"::"Portal Submitted";
            SDA_1."File Name" := FileName;
            SDA_1."Document Update Date" := Today;
            SDA_1."Uploaded By" := UserId;

            if SDA_1."Transaction No." = '' then begin
                SDA_1."Submission Date" := Today;
                SDA_1."Uploaded On" := Today;
                SDA_1."Uploaded By" := "UserID";
                SDA_1."Uploaded Source" := SDA_1."Uploaded Source"::SLcMPortal;
                SDA_1."Uploaded Time" := Time;
            end;

            SDA_1."Transaction No." := TransactionNo;

            LValidityStartDate := 0D;
            if ValidityStartDate <> '' then begin
                Evaluate(LValidityStartDate, ValidityStartDate);
                SDA_1.Validate("Validity Start Date", LValidityStartDate);
            end;

            SDA_1."Validity Expiry Date" := SDA_1."Expiry Date";
            SDA_1."Document Specialist ID" := StudentMaster."Document Specialist";
            SDA_1."Document Due" := DocumentDueDate;

            if SDA_1.Modify() then begin
                //ClinicalNotification.SendOnDocumentUpload(StudentNo, DocumentDescription);
                exit('Success' + ' ' + TransactionNo)
            END
            else
                exit('Failed' + ' ' + TransactionNo);
        end;
    end;

    procedure WebAPIGraduationAuditInsert(StudentNo: Code[20];
    CurrentAddress: text[250]; CurrentZipCode: Code[20]; CurrentState: Code[10];
    CurrentCity: Text[30]; CurrentCountry: code[10]; PermanentAddress: Text[250]; PermanentZipCode: Code[20];
    PermanentState: Code[10]; PermanentCity: text[30]; PermanentCountry: Code[10]; Phoneno: text[30];
    EmailAddress: Text[80]; ApplicationDate: Text; FirstName: Text[35]; LastName: Text[35]; DocumentStatus: Option; SemL: Code[20]; AcaYear: Code[20]; pTerm: Option FALL,SPRING,SUMMER): Text[100];
    var
        DegreeAuditRec: Record "Degree Audit";
        DegreeAuditRec1: Record "Degree Audit";
        StudentRec: Record "Student Master-CS";
        GeneralLedgerSetupRec: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        StudentRec.Get(StudentNo);

        GeneralLedgerSetupRec.Get();
        GeneralLedgerSetupRec.TestField("Degree Audit Document No.");

        DegreeAuditRec1.Reset();
        DegreeAuditRec1.SetRange("Student No.", StudentRec."No.");
        DegreeAuditRec1.SetRange(Semester, StudentRec.Semester);
        DegreeAuditRec1.SetRange("Academic Year", StudentRec."Academic Year");
        DegreeAuditRec1.SetRange(Term, StudentRec.Term);
        IF Not DegreeAuditRec1.FindFirst() then begin
            DegreeAuditRec.Init();
            DegreeAuditRec."Application No." := NoSeriesMgt.GetNextNo(GeneralLedgerSetupRec."Degree Audit Document No.", 0D, TRUE);
            DegreeAuditRec.Validate("Student No.", StudentNo);
            DegreeAuditRec."Current Address" := CurrentAddress;
            DegreeAuditRec."Current Zip Code" := CurrentZipCode;
            DegreeAuditRec."Current State" := CurrentState;
            DegreeAuditRec."Current City" := CurrentCity;
            DegreeAuditRec."Current Country Code" := CurrentCountry;
            DegreeAuditRec."Permanent Address" := PermanentAddress;
            DegreeAuditRec."Permanent Zip Code" := PermanentZipCode;
            DegreeAuditRec."Permanent State" := PermanentState;
            DegreeAuditRec."Permanent City" := PermanentCity;
            DegreeAuditRec."Permanent Country Code" := PermanentCountry;
            DegreeAuditRec."Permanent Phone No." := Phoneno;
            DegreeAuditRec."Personal E-Mail Address" := EmailAddress;
            DegreeAuditRec."Document Status" := DocumentStatus;
            if ApplicationDate <> '' then
                Evaluate(DegreeAuditRec."Application Date", ApplicationDate);
            DegreeAuditRec."Created On" := Today();
            DegreeAuditRec.Semester := SemL;
            DegreeAuditREc."Academic Year" := AcaYear;
            DegreeAuditRec.Term := pTerm;
            if DegreeAuditRec.Insert() then
                exit('Success' + ' ' + DegreeAuditRec."Application No.")
            else
                exit('Failed' + ' ' + DegreeAuditRec."Application No.");
        end Else
            exit('Duplicate');
    end;

    //MSPE Application Start - 15-02-2021

    procedure WebAPIMSPEApplication(ApplicationNo: Code[20]; ApplicationType: Option; StudentNo: Code[20];
                                    AcademicYear: Code[20]; Semester: Code[20]; Term: Integer; Step1Agree: Boolean; LastName: Text[35];
                                    FirstName: Text[35]; PreviousLastName: Text[35]; PreviousFirstName: Text[35]; PhoneNumber: Text[30];
                                    Mobile_Cell: Text[30]; Address: Text[100]; Country: Code[20]; State: Code[20]; City: Text[30]; Zip: Code[20];
                                    ERAS: Boolean; CaRMS: Boolean; OtherSpecialty: Boolean; OtherSpecialtyDescription: Text[100]; FirstNoteworthyCharExp: Text[500];
                                    FirstNoteworthyCharDates: Text[20]; FirstNoteworthyCharDatesEnd: Text[20]; FirstNoteworthyCharLoc: Text[100]; SecondNoteworthyCharExp: Text[500];
                                    SecondNoteworthyCharDates: Text[20]; SecondNoteworthyCharDatesEnd: Text[20]; SecondNoteworthyCharLoc: Text[100]; ThirdNoteworthyCharExp: Text[500];
                                    ThirdNoteworthyCharDates: Text[20]; ThirdNoteworthyCharDatesEnd: Text[20]; ThirdNoteworthyCharLoc: Text[100]; FourthNoteworthyCharExp: Text[500];
                                    FourthNoteworthyCharDates: Text[20]; FourthNoteworthyCharDatesEnd: Text[20]; FourthNoteworthyCharLoc: Text[100]; FifthNoteworthyCharExp: Text[500];
                                    FifthNoteworthyCharDates: Text[20]; FifthNoteworthyCharDatesEnd: Text[20]; FifthNoteworthyCharLoc: Text[100]; UnderGradSchoolName: Text[100]; UnderGradLoc: Text[100];
                                    UnderGradMonthYear: Text[20]; UnderGradDegree: Text[50]; UnderGradDegreeMajor: Text[50]; FieldofStudy: Text[100];
                                    PostGradCurrentPosDepartment: Text[100]; PostGradCurrentHospInstitution: Text[100]; PostGradCurrentCityState: Text[100];
                                    PostGradCurrentFrom: Text; PostGradCurrentTo: Text; DonotUpdateMSPE: Boolean; ApplicationStatus: Option;
                                    ProcessingStatus: Option; ProcessedBy: Code[20]; ProcessingDate: Text; Remarks: Text[500]; GAPS: Text[500]; ClinicalClerkshipRemediation: text[500]): Text[100];
    var
        MSPE_lRec: Record MSPE;
        AcademicsSetup_lRec: Record "Academics Setup-CS";
        NoSeriesMgmt_lCU: Codeunit NoSeriesManagement;
    begin
        If ApplicationNo = '' then begin
            AcademicsSetup_lRec.Get();
            AcademicsSetup_lRec.TestField("MSPE No.");

            MSPE_lRec.Init();
            MSPE_lRec."Application No" := NoSeriesMgmt_lCU.GetNextNo(AcademicsSetup_lRec."MSPE No.", Today(), true);
            MSPE_lRec."Application Date" := Today();
            MSPE_lRec."Application Type" := ApplicationType;
            MSPE_lRec.Validate("Student No", StudentNo);
            If AcademicYear <> '' then
                MSPE_lRec."Academic Year" := AcademicYear;
            If Semester <> '' then
                MSPE_lRec.Semester := Semester;
            If Format(Term) <> '' then
                Evaluate(MSPE_lRec.Term, Format(Term));
            MSPE_lRec."Step 1 Agree" := Step1Agree;
            If LastName <> '' then
                MSPE_lRec."Last Name" := LastName;
            If FirstName <> '' then
                MSPE_lRec."First Name" := FirstName;

            MSPE_lRec."Previous Last Name" := PreviousLastName;
            MSPE_lRec."Previous First Name" := PreviousFirstName;
            If PhoneNumber <> '' then
                MSPE_lRec."Phone Numbers" := PhoneNumber;
            If Mobile_Cell <> '' then
                MSPE_lRec.Mobile_Cell := Mobile_Cell;
            If Address <> '' then
                MSPE_lRec.Address := Address;
            If Country <> '' then
                MSPE_lRec.Country := Country;
            If State <> '' then
                MSPE_lRec.State := State;
            If City <> '' then
                MSPE_lRec.City := City;
            If Zip <> '' then
                MSPE_lRec.Zip := Zip;
            MSPE_lRec.ERAS := ERAS;
            MSPE_lRec.CaRMS := CaRMS;
            MSPE_lRec."Other Specialty" := OtherSpecialty;
            MSPE_lRec."Other Specialty Description" := Uppercase(OtherSpecialtyDescription);
            MSPE_lRec."1st Noteworthy Char. Exp." := FirstNoteworthyCharExp;
            MSPE_lRec."1st Noteworthy Char. Dates" := FirstNoteworthyCharDates;
            MSPE_lRec."1st Noteworthy Char. End Date" := FirstNoteworthyCharDatesEnd;
            MSPE_lRec."1st Noteworthy Char. Location" := FirstNoteworthyCharLoc;
            MSPE_lRec."2nd Noteworthy Char. Exp." := SecondNoteworthyCharExp;
            MSPE_lRec."2nd Noteworthy Char Dates" := SecondNoteworthyCharDates;
            MSPE_lRec."2nd Noteworthy Char. End Date" := SecondNoteworthyCharDatesEnd;
            MSPE_lRec."2nd Noteworthy Char Location" := SecondNoteworthyCharLoc;
            MSPE_lRec."3rd Noteworthy Char. Exp." := ThirdNoteworthyCharExp;
            MSPE_lRec."3rd Noteworthy Char Dates" := ThirdNoteworthyCharDates;
            MSPE_lRec."3rd Noteworthy Char. End Date" := ThirdNoteworthyCharDatesEnd;
            MSPE_lRec."3rd Noteworthy Char Location" := ThirdNoteworthyCharLoc;
            MSPE_lRec."4th Noteworthy Char Exp." := FourthNoteworthyCharExp;
            MSPE_lRec."4th Noteworthy Char Dates" := FourthNoteworthyCharDates;
            MSPE_lRec."4th Noteworthy Char. End Date" := FourthNoteworthyCharDatesEnd;
            MSPE_lRec."4th Noteworthy Char Location" := FourthNoteworthyCharLoc;
            MSPE_lRec."5th Noteworthy Char Exp." := FifthNoteworthyCharExp;
            MSPE_lRec."5th Noteworthy Char Dates" := FifthNoteworthyCharDates;
            MSPE_lRec."5th Noteworthy Char. End Date" := FifthNoteworthyCharDatesEnd;
            MSPE_lRec."5th Noteworthy Char Location" := FifthNoteworthyCharLoc;
            MSPE_lRec."Under Graduate School Name" := UnderGradSchoolName;
            MSPE_lRec."Under Graduate Location" := UnderGradLoc;
            MSPE_lRec."Under Graduate Month Year" := UnderGradMonthYear;
            MSPE_lRec."Under Graduate Degree" := UnderGradDegree;
            MSPE_lRec."Under Graduate Degree Major" := UnderGradDegreeMajor;
            MSPE_lRec."Field of Study" := FieldofStudy;
            MSPE_lRec."Post Graduate_Curr Pos_Dep" := PostGradCurrentPosDepartment;
            MSPE_lRec."Post Graduate_Curr Hosp_Inst" := PostGradCurrentHospInstitution;
            MSPE_lRec."Post Graduate_Curr City_State" := PostGradCurrentCityState;
            IF PostGradCurrentFrom <> '' then
                MSPE_lRec."Post Graduate_Current From" := PostGradCurrentFrom;
            If PostGradCurrentTo <> '' then
                MSPE_lRec."Post Graduate_Current To" := PostGradCurrentTo;

            MSPE_lRec."Do Not Update MPSE" := DonotUpdateMSPE;
            MSPE_lRec."Application Status" := ApplicationStatus;
            MSPE_lRec."Processing Status" := ProcessingStatus;
            IF MSPE_lRec."Processing Status" = MSPE_lRec."Processing Status"::" " then
                Exit('Failed');
            MSPE_lRec."Created By" := ProcessedBy;
            If ProcessingDate <> '' then
                Evaluate(MSPE_lRec."Creation On", ProcessingDate);
            MSPE_lRec.Remarks := Remarks;
            MSPE_lRec.GAPS := GAPS;
            MSPE_lRec.ClinicalClerkshipRemediation := ClinicalClerkshipRemediation;
            // MSPE_lRec."AUA Email Address" := AUAEmail;
            If MSPE_lRec.Insert(true) then
                exit('Success' + ' ' + MSPE_lRec."Application No")
            Else
                exit('Failed' + ' ' + MSPE_lRec."Application No");
        end ELSE begin
            MSPE_lRec.Reset();
            MSPE_lRec.SetRange("Application No", ApplicationNo);
            If MSPE_lRec.FindFirst() then begin
                MSPE_lRec."Application Type" := ApplicationType;
                MSPE_lRec.Validate("Student No", StudentNo);
                If AcademicYear <> '' then
                    MSPE_lRec."Academic Year" := AcademicYear;
                If Semester <> '' then
                    MSPE_lRec.Semester := Semester;
                If Format(Term) <> '' then
                    Evaluate(MSPE_lRec.Term, Format(Term));
                MSPE_lRec."Step 1 Agree" := Step1Agree;
                If LastName <> '' then
                    MSPE_lRec."Last Name" := LastName;
                If FirstName <> '' then
                    MSPE_lRec."First Name" := FirstName;

                MSPE_lRec."Previous Last Name" := PreviousLastName;
                MSPE_lRec."Previous First Name" := PreviousFirstName;
                If PhoneNumber <> '' then
                    MSPE_lRec."Phone Numbers" := PhoneNumber;
                If Mobile_Cell <> '' then
                    MSPE_lRec.Mobile_Cell := Mobile_Cell;
                If Address <> '' then
                    MSPE_lRec.Address := Address;
                If Country <> '' then
                    MSPE_lRec.Country := Country;
                If State <> '' then
                    MSPE_lRec.State := State;
                If City <> '' then
                    MSPE_lRec.City := City;
                If Zip <> '' then
                    MSPE_lRec.Zip := Zip;
                MSPE_lRec.ERAS := ERAS;
                MSPE_lRec.CaRMS := CaRMS;
                MSPE_lRec."Other Specialty" := OtherSpecialty;
                MSPE_lRec."Other Specialty Description" := Uppercase(OtherSpecialtyDescription);
                MSPE_lRec."1st Noteworthy Char. Exp." := FirstNoteworthyCharExp;
                MSPE_lRec."1st Noteworthy Char. Dates" := FirstNoteworthyCharDates;
                MSPE_lRec."1st Noteworthy Char. End Date" := FirstNoteworthyCharDatesEnd;
                MSPE_lRec."1st Noteworthy Char. Location" := FirstNoteworthyCharLoc;
                MSPE_lRec."2nd Noteworthy Char. Exp." := SecondNoteworthyCharExp;
                MSPE_lRec."2nd Noteworthy Char Dates" := SecondNoteworthyCharDates;
                MSPE_lRec."2nd Noteworthy Char. End Date" := SecondNoteworthyCharDatesEnd;
                MSPE_lRec."2nd Noteworthy Char Location" := SecondNoteworthyCharLoc;
                MSPE_lRec."3rd Noteworthy Char. Exp." := ThirdNoteworthyCharExp;
                MSPE_lRec."3rd Noteworthy Char Dates" := ThirdNoteworthyCharDates;
                MSPE_lRec."3rd Noteworthy Char. End Date" := ThirdNoteworthyCharDatesEnd;
                MSPE_lRec."3rd Noteworthy Char Location" := ThirdNoteworthyCharLoc;
                MSPE_lRec."4th Noteworthy Char Exp." := FourthNoteworthyCharExp;
                MSPE_lRec."4th Noteworthy Char Dates" := FourthNoteworthyCharDates;
                MSPE_lRec."4th Noteworthy Char. End Date" := FourthNoteworthyCharDatesEnd;
                MSPE_lRec."4th Noteworthy Char Location" := FourthNoteworthyCharLoc;
                MSPE_lRec."5th Noteworthy Char Exp." := FifthNoteworthyCharExp;
                MSPE_lRec."5th Noteworthy Char Dates" := FifthNoteworthyCharDates;
                MSPE_lRec."5th Noteworthy Char. End Date" := FifthNoteworthyCharDatesEnd;
                MSPE_lRec."5th Noteworthy Char Location" := FifthNoteworthyCharLoc;
                MSPE_lRec."Under Graduate School Name" := UnderGradSchoolName;
                MSPE_lRec."Under Graduate Location" := UnderGradLoc;
                MSPE_lRec."Under Graduate Month Year" := UnderGradMonthYear;
                MSPE_lRec."Under Graduate Degree" := UnderGradDegree;
                MSPE_lRec."Under Graduate Degree Major" := UnderGradDegreeMajor;
                MSPE_lRec."Field of Study" := FieldofStudy;
                MSPE_lRec."Post Graduate_Curr Pos_Dep" := PostGradCurrentPosDepartment;
                MSPE_lRec."Post Graduate_Curr Hosp_Inst" := PostGradCurrentHospInstitution;
                MSPE_lRec."Post Graduate_Curr City_State" := PostGradCurrentCityState;
                IF PostGradCurrentFrom <> '' then
                    MSPE_lRec."Post Graduate_Current From" := PostGradCurrentFrom;
                If PostGradCurrentTo <> '' then
                    MSPE_lRec."Post Graduate_Current To" := PostGradCurrentTo;
                MSPE_lRec."Do Not Update MPSE" := DonotUpdateMSPE;
                MSPE_lRec."Application Status" := ApplicationStatus;
                MSPE_lRec."Processing Status" := ProcessingStatus;
                IF MSPE_lRec."Processing Status" = MSPE_lRec."Processing Status"::" " then
                    Exit('Failed');
                MSPE_lRec."Created By" := ProcessedBy;
                If ProcessingDate <> '' then
                    Evaluate(MSPE_lRec."Creation On", ProcessingDate);
                MSPE_lRec.Remarks := Remarks;
                //   MSPE_lRec."AUA Email Address" := AUAEmail;
                MSPE_lRec.GAPS := GAPS;
                MSPE_lRec.ClinicalClerkshipRemediation := ClinicalClerkshipRemediation;
                If MSPE_lRec.Modify(true) then
                    exit('Success' + ' ' + MSPE_lRec."Application No")
                ELse
                    exit('Failed' + ' ' + MSPE_lRec."Application No");
            end;
        end;
    end;

    //MSPE Application End - 15-02-2021
    procedure DocuSignAssessmentScores(RotationNo: integer; RotationID: code[20]; CourseCode: Text[20];
                          CourseName: text[50]; CourseStartDate: Text[40]; CourseEndDate: Text[40];
                          StudentNo: Text[20];
                          StudentName: Text[100]; PatientCare: Option; MedicalKnowledge: Option; InterpersonalandCommunicationSkills: Option;
                          PracticeBaseLearningandImprovement: Option; SystemBasedLearning: Option; StudentPortfolio: Option; Professionalism: Option;
                          MPSEComment: Text[500]; AssessmentTotalScore: Decimal; AssessmentPercentage: Decimal; AssessmentWeightage: Decimal; CCSSEScore: Decimal;
                          CCSSEWeightage: Decimal; FinalPercentage: Decimal; Grade: Text[10]; SentDateTime: Text[40]; DeliveredDateTime: Text[40]; PreceptorSignedDateTime: Text[40];
                          PreceptorName: Text[100]; DMEName: Text[100]; DMESignedDateTime: Text[100]; EnvelopeID: Text[100]; FormNo: Integer): text[100];
    var
        DocuSignAssessmentScores: Record "DocuSign Assessment Scores";
        RSL: Record "Roster Scheduling Line";
        RLE: Record "Roster Ledger Entry";
        SubjectMaster: Record "Subject Master-CS";
        StudentMaster: Record "Student Master-CS";
        GroupCode: Code[20];
        GroupDescription: Text[100];
    begin
        RSL.Reset();
        RSL.SetRange("Rotation ID", RotationID);
        RSL.SetRange("Rotation No.", RotationNo);
        if RSL.FindFirst() then begin
            SubjectMaster.Reset();
            SubjectMaster.SetRange(Code, RSL."Course Code");
            if SubjectMaster.FindFirst() then
                SubjectMaster.TestField("Subject Group");

            GroupCode := SubjectMaster."Subject Group";
            SubjectMaster.Reset();
            SubjectMaster.SetRange(Code, GroupCode);
            if SubjectMaster.FindFirst() then
                GroupDescription := SubjectMaster.Description;

            if RSL."Clerkship Type" <> RSL."Clerkship Type"::Core then begin
                GroupCode := Format(RSL."Clerkship Type");
                GroupDescription := Format(RSL."Clerkship Type");
            end;

            RLE.Reset();
            if RLE.Get(RSL."Ledger Entry No.") then;
        end;

        StudentMaster.Reset();
        IF StudentMaster.Get(StudentNo) then;

        DocuSignAssessmentScores.Reset();
        DocuSignAssessmentScores.SetRange("Student No.", StudentNo);
        DocuSignAssessmentScores.SetRange("Rotation No.", RotationNo);
        DocuSignAssessmentScores.SetRange("Rotation ID", RotationID);
        if not DocuSignAssessmentScores.FindSet() then begin
            DocuSignAssessmentScores.Init();
            DocuSignAssessmentScores."Rotation No." := RotationNo;
            DocuSignAssessmentScores."Rotation ID" := RotationID;
            DocuSignAssessmentScores."Rotation Entry No." := RotationNo;            //CS:NAvdeep 03-08-2021
            DocuSignAssessmentScores."Course Start Date" := RSL."Start Date";
            DocuSignAssessmentScores."Course End Date" := RSL."End Date";
            DocuSignAssessmentScores."Clerkship Type" := RSL."Clerkship Type";
            DocuSignAssessmentScores."Course Group Code" := GroupCode;
            DocuSignAssessmentScores."Course Group Description" := GroupDescription;
            DocuSignAssessmentScores."Course Code" := CourseCode;
            DocuSignAssessmentScores."Course Name" := CourseName;
            // Evaluate(DocuSignAssessmentScores."Course Start Date", CourseStartDate);
            // Evaluate(DocuSignAssessmentScores."Course End Date", CourseEndDate);
            DocuSignAssessmentScores."Student No." := StudentNo;
            DocuSignAssessmentScores."Student Name" := StudentName;
            // DocuSignAssessmentScores."First Name" := StudentMaster."First Name";
            // DocuSignAssessmentScores."Last Name" := StudentMaster."Last Name";
            DocuSignAssessmentScores."Patient Care" := PatientCare;
            DocuSignAssessmentScores."Medical Knowledge" := MedicalKnowledge;
            DocuSignAssessmentScores."Interpersonal and Comm. Skills" := InterpersonalandCommunicationSkills;
            DocuSignAssessmentScores."Practice Base Learn and Impro" := PracticeBaseLearningandImprovement;
            DocuSignAssessmentScores."System Based Learning" := SystemBasedLearning;
            DocuSignAssessmentScores."Student Portfolio" := StudentPortfolio;
            DocuSignAssessmentScores.Professionalism := Professionalism;
            DocuSignAssessmentScores."MPSE Comment" := MPSEComment;
            DocuSignAssessmentScores."Assessment Total Score" := AssessmentTotalScore;
            DocuSignAssessmentScores."Assessment Percentage" := AssessmentPercentage;
            DocuSignAssessmentScores."Assessment Weightage" := AssessmentWeightage;
            DocuSignAssessmentScores."CCSSE Score" := CCSSEScore;
            DocuSignAssessmentScores."CCSSE Weightage" := CCSSEWeightage;
            DocuSignAssessmentScores."Final Percentage" := FinalPercentage;
            DocuSignAssessmentScores.Grade := Grade;
            if SentDateTime <> '' then
                evaluate(DocuSignAssessmentScores."Sent Date Time", SentDateTime);
            if DeliveredDateTime <> '' then
                evaluate(DocuSignAssessmentScores."Delivered Date Time", DeliveredDateTime);
            if PreceptorSignedDateTime <> '' then
                evaluate(DocuSignAssessmentScores."Preceptor Signed Date Time", PreceptorSignedDateTime);
            DocuSignAssessmentScores."Preceptor Name" := PreceptorName;
            DocuSignAssessmentScores."DME Name" := DMEName;
            if DMESignedDateTime <> '' then
                Evaluate(DocuSignAssessmentScores."DME Signed Date Time", DMESignedDateTime);
            DocuSignAssessmentScores."Envelope ID" := EnvelopeID;
            DocuSignAssessmentScores."Form No" := FormNo;
            if DocuSignAssessmentScores.Insert() then begin
                DocuSignAssessmentScores.CalculateEvalCount_Sum();
                exit('Success' + ' ' + DocuSignAssessmentScores."Student No.")
            end;
        end else begin
            // DocuSignAssessmentScores."Rotation No." := RotationNo;
            // DocuSignAssessmentScores."Rotation ID" := RotationID;
            DocuSignAssessmentScores."Course Code" := CourseCode;
            DocuSignAssessmentScores."Course Name" := CourseName;
            // Evaluate(DocuSignAssessmentScores."Course Start Date", CourseStartDate);
            // Evaluate(DocuSignAssessmentScores."Course End Date", CourseEndDate);
            DocuSignAssessmentScores."Student No." := StudentNo;
            DocuSignAssessmentScores."Student Name" := StudentName;
            // DocuSignAssessmentScores."First Name" := StudentMaster."First Name";
            // DocuSignAssessmentScores."Last Name" := StudentMaster."Last Name";
            DocuSignAssessmentScores."Course Start Date" := RSL."Start Date";
            DocuSignAssessmentScores."Course End Date" := RSL."End Date";
            DocuSignAssessmentScores."Clerkship Type" := RSL."Clerkship Type";
            DocuSignAssessmentScores."Course Group Code" := GroupCode;
            DocuSignAssessmentScores."Course Group Description" := GroupDescription;
            DocuSignAssessmentScores."Course Code" := CourseCode;
            DocuSignAssessmentScores."Course Name" := CourseName;
            DocuSignAssessmentScores."Patient Care" := PatientCare;
            DocuSignAssessmentScores."Medical Knowledge" := MedicalKnowledge;
            DocuSignAssessmentScores."Interpersonal and Comm. Skills" := InterpersonalandCommunicationSkills;
            DocuSignAssessmentScores."Practice Base Learn and Impro" := PracticeBaseLearningandImprovement;
            DocuSignAssessmentScores."System Based Learning" := SystemBasedLearning;
            DocuSignAssessmentScores."Student Portfolio" := StudentPortfolio;
            DocuSignAssessmentScores.Professionalism := Professionalism;
            DocuSignAssessmentScores."MPSE Comment" := MPSEComment;
            DocuSignAssessmentScores."Assessment Total Score" := AssessmentTotalScore;
            DocuSignAssessmentScores."Assessment Percentage" := AssessmentPercentage;
            DocuSignAssessmentScores."Assessment Weightage" := AssessmentWeightage;
            DocuSignAssessmentScores."CCSSE Score" := CCSSEScore;
            DocuSignAssessmentScores."CCSSE Weightage" := CCSSEWeightage;
            DocuSignAssessmentScores."Final Percentage" := FinalPercentage;
            DocuSignAssessmentScores.Grade := Grade;
            if SentDateTime <> '' then
                evaluate(DocuSignAssessmentScores."Sent Date Time", SentDateTime);
            if DeliveredDateTime <> '' then
                evaluate(DocuSignAssessmentScores."Delivered Date Time", DeliveredDateTime);
            if PreceptorSignedDateTime <> '' then
                evaluate(DocuSignAssessmentScores."Preceptor Signed Date Time", PreceptorSignedDateTime);
            DocuSignAssessmentScores."Preceptor Name" := PreceptorName;
            DocuSignAssessmentScores."DME Name" := DMEName;
            if DMESignedDateTime <> '' then
                Evaluate(DocuSignAssessmentScores."DME Signed Date Time", DMESignedDateTime);
            DocuSignAssessmentScores."Envelope ID" := EnvelopeID;
            DocuSignAssessmentScores."Form No" := FormNo;

            if DocuSignAssessmentScores.Modify() then begin
                DocuSignAssessmentScores.CalculateEvalCount_Sum();
                exit('Updated' + ' ' + DocuSignAssessmentScores."Student No.")
            END;
        end;
    end;

    procedure WebAPIRotationCancellationApplication(RotationID: Code[20]; StudentNo: Code[20]; ReasonCode: Code[20]; ReasonDescription: Text[100]): Text[250];
    var
        RotationCancellationAppln: Record "Rotation Cancellation Appln";
    begin
        RotationCancellationAppln.Init();
        RotationCancellationAppln."Application No." := '';
        RotationCancellationAppln.Validate("Student No.", StudentNo);
        RotationCancellationAppln.Validate("Rotation ID", RotationID);
        RotationCancellationAppln."Cancel Reason Code" := ReasonCode;
        RotationCancellationAppln."Cancel Reason Description" := ReasonDescription;
        RotationCancellationAppln.Status := RotationCancellationAppln.Status::"Pending for Approval";
        if RotationCancellationAppln.Insert(true) then
            exit('Success: ' + Format(RotationCancellationAppln."Application No."))
        else
            exit('Failed');
    end;

    procedure WebAPISiteAndDate_SPCLAccommodationUpdate(
    ApplicationNo: Code[20];
    StudentNo: Code[20];
    LConfirmed: Boolean) Return: Text[100];
    var
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        SpclAccommodationApplication: Record "Spcl Accommodation Application";
    begin
        ClerkshipSiteAndDateSelection.Reset();
        if not ClerkshipSiteAndDateSelection.Get(ApplicationNo) then
            exit('Failed');

        ClerkshipSiteAndDateSelection.Reset();
        if ClerkshipSiteAndDateSelection.Get(ApplicationNo) then begin
            if LConfirmed = true then begin
                ClerkshipSiteAndDateSelection.Confirmed := true;
                ClerkshipSiteAndDateSelection."Confirmed By" := StudentNo;
                ClerkshipSiteAndDateSelection."Confirmed On" := Today();
                ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::"Pending for Approval";
                ClerkshipSiteAndDateSelection.Modify();
            end
            else begin
                ClerkshipSiteAndDateSelection.Confirmed := false;
                ClerkshipSiteAndDateSelection."Confirmed By" := '';
                ClerkshipSiteAndDateSelection."Confirmed On" := 0D;
                ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::" ";
                ClerkshipSiteAndDateSelection.Modify();
            end;


            SpclAccommodationApplication.Reset();
            SpclAccommodationApplication.SetRange("Application No.", ApplicationNo);
            if SpclAccommodationApplication.FindFirst() then
                if LConfirmed = true then begin
                    SpclAccommodationApplication."Send for Approval" := true;
                    SpclAccommodationApplication."Send for Approval By" := StudentNo;
                    SpclAccommodationApplication."Send for Approval On" := Today();
                    SpclAccommodationApplication."Approval Status" := SpclAccommodationApplication."Approval Status"::"Pending for Approval";
                    SpclAccommodationApplication.Modify();
                end
                else begin
                    SpclAccommodationApplication."Send for Approval" := false;
                    SpclAccommodationApplication."Send for Approval By" := '';
                    SpclAccommodationApplication."Send for Approval On" := 0D;
                    SpclAccommodationApplication."Approval Status" := SpclAccommodationApplication."Approval Status"::" ";
                    SpclAccommodationApplication.Modify();
                end
        end;
        exit('Success: ' + ApplicationNo);
    end;


    procedure WebAPIStudentDocumentAttachmentNew(StudentNo: Code[20]; DocumentCategory: Code[250]; DocumentSubCategory: Code[250];
     TransactionNo: Code[30]; DocumentID: Code[30]; SubjectCode: Code[20]; FileName: Text[100];
     FileType: Text[10]; UploadedOn: Date; UploadedBy: Text[100]; UploadedSource: Option; DocumentStatus: Option;
     StatusUpdatedby: Text[100]; StatusUpdatedDate: Date; DocumentDue: Date; ExpiryDate: Date; SLcMDocumentNo: Code[20]; AcademicYear: Code[20]; Semester: Code[20]; Term_: Option FALL,SPRING,SUMMER): Text[250];
    var
        StudentDocumentAttachment: Record "Student Document Attachment";
        StudentDocumentAttachment1: Record "Student Document Attachment";
        StudentDocumentAttachment2: Record "Student Document Attachment";
        StudentMaster: Record "Student Master-CS";
        DocSubCat: Record "Doc & Cate Attachment-CS";
        DocumentCategory_lREc: Record "File Attachment-CS";
        EntryNo: Integer;
    begin
        ///Check Duplicate Entries - Immigration Issue - 17 Apr 2023
        DocumentCategory_lREc.Reset();
        DocumentCategory_lREc.SetRange(Code, DocumentCategory);
        If DocumentCategory_lREc.FindFirst() then
            If DocumentCategory_lREc."Check Duplicate Entries" then begin
                StudentDocumentAttachment2.Reset();
                StudentDocumentAttachment2.SetRange("Student No.", StudentNo);
                StudentDocumentAttachment2.SetRange("Academic Year", AcademicYear);
                StudentDocumentAttachment2.SetRange(Semester, Semester);
                StudentDocumentAttachment2.SetRange(Term, Term_);
                StudentDocumentAttachment2.SetRange("SLcM Document No", SLcMDocumentNo);
                StudentDocumentAttachment2.SetRange("Document Sub Category", DocumentSubCategory);
                If StudentDocumentAttachment2.FindFirst() then
                    Error('Selected document : %1 already uploaded for the student : %2', DocumentSubCategory, StudentNo);
            end;
        ///Check Duplicate Entries - Immigration Issue - 17 Apr 2023

        StudentMaster.Reset();
        StudentMaster.SetRange("No.", StudentNo);
        IF StudentMaster.FindFirst() then;
        StudentDocumentAttachment2.RESET();
        StudentDocumentAttachment2.SetRange("Transaction No.", TransactionNo);
        IF NOT StudentDocumentAttachment2.FindFirst() THEN begin
            StudentDocumentAttachment1.RESET();
            IF StudentDocumentAttachment1.FINDLAST() THEN
                EntryNo := StudentDocumentAttachment1."Entry No." + 1;

            StudentDocumentAttachment.Init();
            StudentDocumentAttachment."Entry No." := EntryNo;
            StudentDocumentAttachment.Validate("Student No.", StudentNo);
            StudentDocumentAttachment."Document Category" := DocumentCategory;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Code, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment.Description := DocSubCat.Description;
                StudentDocumentAttachment."Document Description" := DocSubCat.Description;
            end;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Description, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment.Description := DocSubCat.Description;
                StudentDocumentAttachment."Document Description" := DocSubCat.Description;
            end;
            StudentDocumentAttachment."Transaction No." := TransactionNo;
            StudentDocumentAttachment."Document ID" := DocumentID;
            StudentDocumentAttachment."Subject Code" := SubjectCode;
            StudentDocumentAttachment."File Name" := FileName;
            StudentDocumentAttachment."File Type" := FileType;
            StudentDocumentAttachment."Uploaded On" := UploadedOn;
            StudentDocumentAttachment."Uploaded By" := UploadedBy;
            StudentDocumentAttachment."Uploaded Source" := UploadedSource;
            StudentDocumentAttachment."Document Status" := DocumentStatus;
            StudentDocumentAttachment."Status Updated By" := StatusUpdatedby;
            StudentDocumentAttachment."Status Updated Date" := StatusUpdatedDate;
            StudentDocumentAttachment."Document Due" := DocumentDue;
            StudentDocumentAttachment."Expiry Date" := ExpiryDate;
            StudentDocumentAttachment."SLcM Document No" := SLcMDocumentNo;
            If AcademicYear <> '' then
                StudentDocumentAttachment."Academic Year" := AcademicYear
            Else
                StudentDocumentAttachment."Academic Year" := StudentMaster."Academic Year";

            If Semester <> '' then
                StudentDocumentAttachment.Semester := Semester
            Else
                StudentDocumentAttachment.Semester := StudentMaster.Semester;
            StudentDocumentAttachment.Term := Term_;
            if StudentDocumentAttachment.Insert() then begin
                exit('Success' + ' ' + Format(EntryNo))
            end else
                exit('Failed' + ' ' + StudentNo);
        end Else begin
            StudentDocumentAttachment2.Validate("Student No.", StudentNo);
            StudentDocumentAttachment2."Document Category" := DocumentCategory;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Code, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment2."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment2.Description := DocSubCat.Description;
                StudentDocumentAttachment2."Document Description" := DocSubCat.Description;
            end;
            DocSubCat.Reset();
            DocSubCat.SetRange("Document Type", DocumentCategory);
            DocSubCat.SetRange(Description, DocumentSubCategory);
            if DocSubCat.FindFirst() then begin
                StudentDocumentAttachment2."Document Sub Category" := DocSubCat.Code;
                StudentDocumentAttachment2.Description := DocSubCat.Description;
                StudentDocumentAttachment2."Document Description" := DocSubCat.Description;
            end;
            StudentDocumentAttachment2."Document ID" := DocumentID;
            StudentDocumentAttachment2."Subject Code" := SubjectCode;
            StudentDocumentAttachment2."File Name" := FileName;
            StudentDocumentAttachment2."File Type" := FileType;
            StudentDocumentAttachment2."Uploaded On" := UploadedOn;
            StudentDocumentAttachment2."Uploaded By" := UploadedBy;
            StudentDocumentAttachment2."Uploaded Source" := UploadedSource;
            StudentDocumentAttachment2."Document Status" := DocumentStatus;
            StudentDocumentAttachment2."Status Updated By" := StatusUpdatedby;
            StudentDocumentAttachment2."Status Updated Date" := StatusUpdatedDate;
            StudentDocumentAttachment2."Document Due" := DocumentDue;
            StudentDocumentAttachment2."Expiry Date" := ExpiryDate;
            StudentDocumentAttachment2."SLcM Document No" := SLcMDocumentNo;
            If AcademicYear <> '' then
                StudentDocumentAttachment2."Academic Year" := AcademicYear
            Else
                StudentDocumentAttachment2."Academic Year" := StudentMaster."Academic Year";
            If Semester <> '' then
                StudentDocumentAttachment2.Semester := Semester
            Else
                StudentDocumentAttachment2.Semester := StudentMaster.Semester;
            StudentDocumentAttachment2.Term := Term_;
            if StudentDocumentAttachment2.Modify() then begin
                exit('Success' + ' ' + TransactionNo)
            end else
                exit('Failed' + ' ' + TransactionNo);

        end;
    end;


    Procedure WebAPIIntentToPay(StudentID: Code[20]; FAApplied: Boolean; PaymentPlanApplied: Boolean; ScholarshipApplied: Boolean; SelfPayApplied: Boolean; VABenefits: Boolean): Text[100]
    var
        StudentMaster_lRec: Record "Student Master-CS";
    Begin
        If StudentID = '' then
            Error('Student ID must not be blank.');

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("No.", StudentID);
        IF StudentMaster_lRec.FindFirst() then begin
            StudentMaster_lRec."Financial Aid Approved" := FAApplied;
            StudentMaster_lRec."Payment Plan Applied" := PaymentPlanApplied;
            StudentMaster_lRec."Applied For Scholarship" := ScholarshipApplied;
            StudentMaster_lRec."Self-Pay Applied" := SelfPayApplied;
            StudentMaster_lRec."VA Benefit" := VABenefits;
            If StudentMaster_lRec.Modify(True) then
                Exit('Success ' + StudentID)
            Else
                exit('Failed ' + StudentID);

        end;

    End;

    procedure CreateNewAdvisingRequest("Request Reason": Code[20]; AdvisingTopic: Code[20]; FacultyMeet: Code[20]; RequestDate: Date;
    StudentNo: Code[20]; Requesteddate1Txt: Text; Requesteddate2Txt: Text; Requesteddate3Txt: Text;
    RequestedMeetingstarttime1Txt: Text; RequestedMeetingstarttime2Txt: Text; RequestedMeetingstarttime3Txt: Text;
    RequestedMeetingendtime1Txt: Text; RequestedMeetingendtime2Txt: Text; RequestedMeetingendtime3Txt: Text; Requestor: Integer; CoreTopic: Code[20]; RequestToChair: Boolean; DepartmentType: Integer; ResOldReqNo: Code[20]; ResNewReqNo: Code[20]; ReasonDesc: Text[2048]; MeetingMod: Integer): Text[100]
    Var
        AdvisingRequest: Record "Advising Request";
        Requesteddate1: date;
        Requesteddate2: Date;
        Requesteddate3: Date;
        RequestedMeetingstarttime1: Time;
        RequestedMeetingstarttime2: Time;
        RequestedMeetingstarttime3: time;
        RequestedMeetingendtime1: time;
        RequestedMeetingendtime2: time;
        RequestedMeetingendtime3: time;
    begin
        AdvisingRequest.INIT();
        AdvisingRequest."Request Date" := RequestDate;
        AdvisingRequest.Validate("Student No.", StudentNo);
        AdvisingRequest."Department Type" := DepartmentType;
        AdvisingRequest.Validate("Advising Topic Code", AdvisingTopic);
        AdvisingRequest.Validate("Reason Program Code", "Request Reason");

        if Requesteddate1Txt <> '' then begin
            Evaluate(Requesteddate1, Requesteddate1Txt);
            AdvisingRequest.Validate("Requested Meeting Date1", Requesteddate1);
        end
        else
            Error('Request Date 1 cannot be blank');

        if Requesteddate2Txt <> '' then begin
            Evaluate(Requesteddate2, Requesteddate2Txt);
            AdvisingRequest.Validate("Requested Meeting Date2", Requesteddate2);
        end;
        if Requesteddate3Txt <> '' then begin
            Evaluate(Requesteddate3, Requesteddate3Txt);
            AdvisingRequest.Validate("Requested Meeting Date3", Requesteddate3);
        end;
        if FacultyMeet <> '' then begin
            AdvisingRequest."Advisor ID" := FacultyMeet;
            AdvisingRequest.Validate("Advisor ID");
        end;

        if RequestedMeetingstarttime1Txt <> '' then begin
            Evaluate(RequestedMeetingstarttime1, RequestedMeetingstarttime1Txt);
            AdvisingRequest.Validate("Requested Meeting Start Time 1", RequestedMeetingstarttime1);
        end
        else
            Error('Request Start Time 1 cannot be blank');

        if RequestedMeetingstarttime2Txt <> '' then begin
            Evaluate(RequestedMeetingstarttime2, RequestedMeetingstarttime2Txt);
            AdvisingRequest.Validate("Requested Meeting Start Time 2", RequestedMeetingstarttime2);
        end;

        if RequestedMeetingstarttime3Txt <> '' then begin
            Evaluate(RequestedMeetingstarttime3, RequestedMeetingstarttime3Txt);
            AdvisingRequest.Validate("Requested Meeting Start Time 3", RequestedMeetingstarttime3);
        end;

        if RequestedMeetingEndtime1Txt <> '' then begin
            Evaluate(RequestedMeetingEndtime1, RequestedMeetingEndtime1Txt);
            AdvisingRequest.Validate("Requested Meeting End Time1", RequestedMeetingEndtime1);
        end
        else
            Error('Request End Time 1 cannot be blank');

        if RequestedMeetingEndtime2Txt <> '' then begin
            Evaluate(RequestedMeetingEndtime2, RequestedMeetingEndtime2Txt);
            AdvisingRequest.Validate("Requested Meeting End Time2", RequestedMeetingEndtime2);
        end;
        if RequestedMeetingEndtime3Txt <> '' then begin
            Evaluate(RequestedMeetingEndtime3, RequestedMeetingEndtime3Txt);
            AdvisingRequest.Validate("Requested Meeting End Time3", RequestedMeetingEndtime3);
        end;

        AdvisingRequest."Entry From Portal" := True;
        if (Requestor < 0) or (Requestor > 1) then
            Error('Requestor must be a Student or Faculty');
        AdvisingRequest.Requestor := Requestor;
        AdvisingRequest."Core Topic" := CoreTopic;
        AdvisingRequest."Request to Chair" := RequestToChair;
        AdvisingRequest."Rescheduled Old Req. No." := ResOldReqNo;
        AdvisingRequest."Rescheduled New Req. No." := ResNewReqNo;
        AdvisingRequest."Reason Description" := ReasonDesc;
        AdvisingRequest."Meeting Mode" := MeetingMod;
        IF AdvisingRequest.INSERT(True) then
            EXIT('Success : ' + AdvisingRequest."Request No")
        Else
            Exit('Failed');
    End;

    procedure WebAPIAdvisingRequest("Request Reason": Code[20]; AdvisingTopic: Code[20]; FacultyMeet: Code[20];
    StudentNo: Code[20]; Requestor: Integer; DepartmentType: Integer; MeetingStartTime: Text; MeetingEndTime: Text;
    MeetingDate: Text; ReasonDesc: Text[2048]): Text[100]
    Var
        AdvisingRequest: Record "Advising Request";
        Requesteddate1: date;
        RequestedMeetingstarttime1: Time;
        RequestedMeetingendtime1: time;
    begin
        If MeetingDate <> '' then
            Evaluate(Requesteddate1, MeetingDate)
        else
            Error('Meeting Date cannot be blank');

        if MeetingStartTime <> '' then
            Evaluate(RequestedMeetingstarttime1, MeetingStartTime)
        else
            Error('Meeting Start Time cannot be blank');
        if MeetingEndTime <> '' then
            Evaluate(RequestedMeetingEndtime1, MeetingEndTime)
        else
            Error('Meeting End Time cannot be blank');

        AdvisingRequest.Reset();
        // AdvisingRequest.SetRange("Meeting Date", Requesteddate1);
        // AdvisingRequest.SetRange("Meeting Start Time 1", RequestedMeetingstarttime1);
        // AdvisingRequest.SetRange("Meeting End Time 1", RequestedMeetingendtime1);
        // IF not AdvisingRequest.FindFirst() then begin
        AdvisingRequest.INIT();
        AdvisingRequest."Request Date" := Today();
        AdvisingRequest.Validate("Student No.", StudentNo);
        AdvisingRequest."Department Type" := DepartmentType;
        AdvisingRequest.Validate("Advising Topic Code", AdvisingTopic);
        AdvisingRequest.Validate("Reason Program Code", "Request Reason");

        if MeetingDate <> '' then begin
            Evaluate(Requesteddate1, MeetingDate);
            AdvisingRequest.Validate("Meeting Date", Requesteddate1);
        end;



        if FacultyMeet <> '' then begin
            AdvisingRequest."Advisor ID" := FacultyMeet;
            AdvisingRequest.Validate("Advisor ID");
        end;

        if MeetingStartTime <> '' then begin
            Evaluate(RequestedMeetingstarttime1, MeetingStartTime);
            AdvisingRequest.Validate("Meeting Start Time 1", RequestedMeetingstarttime1);
        end;

        if MeetingEndTime <> '' then begin
            Evaluate(RequestedMeetingEndtime1, MeetingEndTime);
            AdvisingRequest.Validate("Meeting End Time 1", RequestedMeetingEndtime1);
        end;


        AdvisingRequest."Entry From Portal" := True;
        if (Requestor < 0) or (Requestor > 1) then
            Error('Requestor must be a Student or Faculty');
        AdvisingRequest.Requestor := Requestor;
        AdvisingRequest."Reason Description" := ReasonDesc;
        AdvisingRequest."Request Status" := AdvisingRequest."Request Status"::Approved;
        AdvisingRequest."Entry From Portal" := true;
        IF AdvisingRequest.INSERT(True) then
            EXIT('Success : ' + AdvisingRequest."Request No")
        Else
            Exit('Failed');

    End;

    Procedure ApprovedAdvisingRequest(RequestNo: Code[20]; StudentNo: Code[20]; MeetingDate: Text; MeetingStartTime: Text; MeetingEndTime: Text; MeetingMode: Integer; RequestStatus: Integer; RequestReason: Text; RequestReasonDesc: Text[2048]): Text[100]
    Var
        AdvisingRequest_lRec: Record "Advising Request";
    Begin
        AdvisingRequest_lRec.Reset();
        AdvisingRequest_lRec.SetRange("Request No", RequestNo);
        IF AdvisingRequest_lRec.FindFirst() then begin
            If StudentNo <> '' then
                AdvisingRequest_lRec."Student No." := StudentNo;
            IF MeetingDate <> '' then
                Evaluate(AdvisingRequest_lRec."Meeting Date", MeetingDate);

            If MeetingStartTime <> '' then
                Evaluate(AdvisingRequest_lRec."Meeting Start Time 1", MeetingStartTime);

            If MeetingEndTime <> '' then
                Evaluate(AdvisingRequest_lRec."Meeting End Time 1", MeetingEndTime);

            AdvisingRequest_lRec."Request Status" := RequestStatus;

            If RequestReason <> '' then
                AdvisingRequest_lRec.Validate("Rejected Reason", RequestReason);
            If RequestReasonDesc <> '' then
                AdvisingRequest_lRec."Reason Description" := RequestReasonDesc;

            AdvisingRequest_lRec."Meeting Mode" := MeetingMode;

            If AdvisingRequest_lRec.Modify() then
                exit('Success ' + AdvisingRequest_lRec."Request No")
            Else
                exit('Failed ' + AdvisingRequest_lRec."Request No");
        end;
    End;

    procedure WebAPIInsertOtherMedicalScholars(StudentNo: Code[20]; FirstTimeApplicant: Boolean; PreviouslyMedicalScholar: Boolean; PreviousRole1: Integer;
    PreviousRole2: Integer; ApplyingNewRole: Boolean; MaintainSameRole: Boolean; RoleApplying: Integer; CourseName: Text[50]; CumulativeGPAAbove3: Integer;
    AcademicProbForUpcSem: Integer; ParticipatedRebootProg: Boolean; FirstChoicePosition: Integer; SecondChoicePosition: Integer; ThirdChoicePosition: Integer;
    ForthChoicePosition: Integer; InterestedBeingLead: Boolean; FirstLeadRole: Integer; SecondLeadRole: Integer; ThirdLeadRole: Integer; ForthLeadRole: Integer;
    FifthLeadRole: Integer; SixthLeadRole: Integer; ShortQNew1Exp: Text[500]; ShortQNew2Mot: Text[500]; ShortQNew3Adv: Text[500]; ShortQ4IntegrityEthic: Text[500];
    ShortQ5PRofessionalism: Text[500]; ShortRepeat1: Text[500]; ShortRepeat2: Text[500]; MemberofStudOrg: Boolean; ListSOAffiliation: Text[500]; Reference1: Code[20];
    Reference2: Code[20]; QueComments: Text[500]; ApplicationStatus: Integer; PreviousRole2Applying: Integer; ParticipatedinRebootProgramPrevSem: Boolean; SkypeID: Code[20];
    SeventhLeadRole: Integer; RepeatedAnySemester: Boolean; ApplicationNo: code[20]; ReturningScholar: Boolean): Text[100]
    var
        MedicalScholars: Record "Medical Scholar Program";
        EducationSetup: Record "Education Setup-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        NoseriesMgmt: Codeunit NoSeriesManagement;
        MedicalDate: Date;
    begin
        IF ApplicationNo = '' then begin
            EducationSetup.Reset();
            If EducationSetup.FindFirst() then;
            MedicalScholars.INIT();
            MedicalScholars."Application No" := NoseriesMgmt.GetNextNo(EducationSetup."Medical Nos.", Today(), true);
            MedicalScholars."Application Date" := Today();
            MedicalScholars.Validate("Student No.", StudentNo);
            IF SkypeID <> '' then
                MedicalScholars."Skype Id" := SkypeID;
            MedicalScholars."First Time Applicant" := FirstTimeApplicant;
            MedicalScholars."Previously Medical Scholar" := PreviouslyMedicalScholar;
            MedicalScholars."Previous Role 1" := PreviousRole1;
            MedicalScholars."Previous Role 2" := PreviousRole2;
            MedicalScholars."Applying New Role" := ApplyingNewRole;
            MedicalScholars."Maintain Same Role" := MaintainSameRole;
            MedicalScholars."Role Applying" := RoleApplying;
            MedicalScholars."Course Name" := CourseName;
            MedicalScholars."Cumulative GPA above 3" := CumulativeGPAAbove3;
            MedicalScholars."Academic Prob for upcoming Sem" := AcademicProbForUpcSem;
            MedicalScholars."Participated in Reboot program" := ParticipatedRebootProg;
            MedicalScholars."1st Choice for Position" := FirstChoicePosition;
            MedicalScholars."2nd Choice for Position" := SecondChoicePosition;
            MedicalScholars."3rd Choice for Position" := ThirdChoicePosition;
            MedicalScholars."4th Choice for Position" := ForthChoicePosition;
            IF (ReturningScholar = true) and (PreviouslyMedicalScholar = true) then
                MedicalScholars."Interested in being lead" := InterestedBeingLead;
            MedicalScholars."1st Choice Lead Role" := FirstLeadRole;
            MedicalScholars."2nd Choice Lead Role" := SecondLeadRole;
            MedicalScholars."3rd Choice Lead Role" := ThirdLeadRole;
            MedicalScholars."4th Choice Lead Role" := ForthLeadRole;
            MedicalScholars."5th Choice Lead Role" := FifthLeadRole;
            MedicalScholars."6th Choice Lead Role" := SixthLeadRole;
            MedicalScholars."7th Choice Lead Role" := SeventhLeadRole;
            MedicalScholars.ShortQ_New_1_Experience := ShortQNew1Exp;
            MedicalScholars.ShortQ_New_2_Motivation := ShortQNew2Mot;
            MedicalScholars.ShortQ_New_3_Advice := ShortQNew3Adv;
            MedicalScholars.ShortQ_New_4_Integrity_Ethic := ShortQ4IntegrityEthic;
            MedicalScholars.ShortQ_New_5_professionalism := ShortQ5PRofessionalism;
            MedicalScholars.ShortQ_Repeat_1_contribution := ShortRepeat1;
            MedicalScholars.ShortQ_Repeat_2_rationale := ShortRepeat2;
            MedicalScholars."Member or officer of stud org." := MemberofStudOrg;
            MedicalScholars."List of SO and affiliations" := ListSOAffiliation;
            MedicalScholars."Reference 1" := Reference1;
            MedicalScholars."Reference 2" := Reference2;
            MedicalScholars.Questions_comments := QueComments;
            MedicalScholars."Application Status" := ApplicationStatus;
            MedicalScholars."Previous Role 2 Applying" := PreviousRole2Applying;
            MedicalScholars."Participated in Reboot program PrevSem" := ParticipatedinRebootProgramPrevSem;
            MedicalScholars."Repeated any Semester" := RepeatedAnySemester;
            MedicalScholars."Returning Scholar" := ReturningScholar;
            If MedicalScholars.INSERT(true) then
                exit('Success ' + MedicalScholars."Application No")
            Else
                exit('Failed');
        end else begin
            MedicalScholars.Reset();
            MedicalScholars.SetRange("Application No", ApplicationNo);
            if MedicalScholars.FindFirst() then begin
                MedicalScholars.Validate("Student No.", StudentNo);
                IF SkypeID <> '' then
                    MedicalScholars."Skype Id" := SkypeID;
                MedicalScholars."First Time Applicant" := FirstTimeApplicant;
                MedicalScholars."Previously Medical Scholar" := PreviouslyMedicalScholar;
                MedicalScholars."Previous Role 1" := PreviousRole1;
                MedicalScholars."Previous Role 2" := PreviousRole2;
                MedicalScholars."Applying New Role" := ApplyingNewRole;
                MedicalScholars."Maintain Same Role" := MaintainSameRole;
                MedicalScholars."Role Applying" := RoleApplying;
                MedicalScholars."Course Name" := CourseName;
                MedicalScholars."Cumulative GPA above 3" := CumulativeGPAAbove3;
                MedicalScholars."Academic Prob for upcoming Sem" := AcademicProbForUpcSem;
                MedicalScholars."Participated in Reboot program" := ParticipatedRebootProg;
                MedicalScholars."1st Choice for Position" := FirstChoicePosition;
                MedicalScholars."2nd Choice for Position" := SecondChoicePosition;
                MedicalScholars."3rd Choice for Position" := ThirdChoicePosition;
                MedicalScholars."4th Choice for Position" := ForthChoicePosition;
                IF (ReturningScholar = true) and (PreviouslyMedicalScholar = true) then
                    MedicalScholars."Interested in being lead" := InterestedBeingLead;
                MedicalScholars."1st Choice Lead Role" := FirstLeadRole;
                MedicalScholars."2nd Choice Lead Role" := SecondLeadRole;
                MedicalScholars."3rd Choice Lead Role" := ThirdLeadRole;
                MedicalScholars."4th Choice Lead Role" := ForthLeadRole;
                MedicalScholars."5th Choice Lead Role" := FifthLeadRole;
                MedicalScholars."6th Choice Lead Role" := SixthLeadRole;
                MedicalScholars."7th Choice Lead Role" := SeventhLeadRole;
                MedicalScholars.ShortQ_New_1_Experience := ShortQNew1Exp;
                MedicalScholars.ShortQ_New_2_Motivation := ShortQNew2Mot;
                MedicalScholars.ShortQ_New_3_Advice := ShortQNew3Adv;
                MedicalScholars.ShortQ_New_4_Integrity_Ethic := ShortQ4IntegrityEthic;
                MedicalScholars.ShortQ_New_5_professionalism := ShortQ5PRofessionalism;
                MedicalScholars.ShortQ_Repeat_1_contribution := ShortRepeat1;
                MedicalScholars.ShortQ_Repeat_2_rationale := ShortRepeat2;
                MedicalScholars."Member or officer of stud org." := MemberofStudOrg;
                MedicalScholars."List of SO and affiliations" := ListSOAffiliation;
                MedicalScholars."Reference 1" := Reference1;
                MedicalScholars."Reference 2" := Reference2;
                MedicalScholars.Questions_comments := QueComments;
                MedicalScholars."Application Status" := ApplicationStatus;
                MedicalScholars."Previous Role 2 Applying" := PreviousRole2Applying;
                MedicalScholars."Participated in Reboot program PrevSem" := ParticipatedinRebootProgramPrevSem;
                MedicalScholars."Repeated any Semester" := RepeatedAnySemester;
                MedicalScholars."Returning Scholar" := ReturningScholar;
                If MedicalScholars.Modify(true) then
                    exit('Modify Success ' + MedicalScholars."Application No")
                Else
                    exit('Modify Failed');
            end else
                exit('Application No ' + ApplicationNo + ' Not Found');
        end;
    end;

    //For Post Graduate Documentation Request Form
    procedure WebAPIPostGraduateDocumentationForm(StudentNo: Code[20]; StateofLicensure: Text[250];
    TypeOfLicensurePermit: Text[50]; HospitalName: Text[100]; Specialty: Text[100]; DocumentNeeded: Text[250]; OtherInformationNeeded: text[250];
    RecipientName: Text[100]; RecipientAddress: Text[250]; RecipientEmail: Text[100]) ApplicationNo: Text[250];
    Var
        postGrdDocReqForm: Record "Post Grad. Doc. Req. Form";
        ApplicatDate: Date;
    begin
        postGrdDocReqForm.Init();
        postGrdDocReqForm."Application Date" := Today();
        if studentNo <> '' then
            postGrdDocReqForm.validate("Student No.", StudentNo);
        if StateofLicensure <> '' then
            postGrdDocReqForm.Validate("States for Licensure", StateofLicensure);
        if TypeOfLicensurePermit <> '' then
            postGrdDocReqForm.validate("Type of Licensure Permit", TypeOfLicensurePermit);
        if HospitalName <> '' then
            postGrdDocReqForm.validate("Hospital Name", HospitalName);
        if Specialty <> '' then
            postGrdDocReqForm.Validate(Specialty, Specialty);
        if DocumentNeeded <> '' then
            postGrdDocReqForm.Validate("Documents Needed", DocumentNeeded);
        if OtherInformationNeeded <> '' then
            postGrdDocReqForm.Validate("Other Information Needed", OtherInformationNeeded);
        if RecipientName <> '' then
            postGrdDocReqForm.Validate("Recipient Name", RecipientName);
        if RecipientAddress <> '' then
            postGrdDocReqForm.Validate("Recipient Address", RecipientAddress);
        if RecipientEmail <> '' then
            postGrdDocReqForm.validate("Recipient Email", RecipientEmail);

        postGrdDocReqForm."Entry From Portal" := true;
        IF postGrdDocReqForm.INSERT(True) then
            EXIT('Success ' + postGrdDocReqForm."Application No")
        Else
            Exit('Failed');
    end;

    procedure WebAPIResidencyPlacementResultForm(StudentNo: Code[20]; PreferredEmailId: Text[100]; PreferredPhonNo: Text[30];
    NRMPMatch: Boolean; CaRMS: Boolean; Other: Boolean; OtherDescription: Text[50]; Neither: Boolean; SecurePosition: Boolean; PlacementTypeVacantPosi: Boolean; PlacementTypeERASMatchDay: Boolean;
    PlacementTypeNRMPSOAP: Boolean; PlacementTypeAfterSOAP: Boolean; PlacementTypeOutsideMatch: Boolean; CaRMS1Iteration: Boolean; CaRMS2Iteration: Boolean;
    PlacmntTypeOther: Boolean; SecuredPosition: Integer; ChoiceDescription: Text[50]; PreliminaryProgram: Boolean; CategoricalProgram: Boolean; AdvancedProgram: Boolean;
    ProgramName: Text[100]; HospitalName: Text[100]; ACGMEProgramID: Text[50]; Specialty: Text[100]; City: text[30]; State: code[20]; StartDateTxt: Text; EndDateTxt: Text;
    ParticipateNRMPSoap: Integer; WithdrawNRMPMatch: Integer; WithdrawFromCaRMS: Integer; WithDueToGraDelayed: Boolean; WithDueToPersonalReason: Boolean; WithDueToNRMPNotEligible: Boolean;
    WithDueToNEStep2CS: Boolean; WithDueToNEStep2CK: Boolean; WithDueToNENotRecdResult: Boolean; WithdrewToCaRMSNotEligible: Boolean; WithdrewDueToOther: Boolean; HealthcarePosi: Text[50];
    PositionInstitution: Text[100]; PositionDepartment: Text[50]; PositionCity: Text[30]; PositionState: Code[20]; PositionStartDateTxt: Text; PositionProjectiveEndDatetxt: Text;
    DidNotSubmitROL: Boolean; ProgramName1: Text[100]; ProgramSpecialty1: text[100]; ProgramName2: Text[100]; ProgramSpecialty2: text[100]; ProgramName3: Text[100];
    ProgramSpecialty3: text[100]; ProgramName4: Text[100]; ProgramSpecialty4: text[100]; ProgramName5: Text[100]; ProgramSpecialty5: text[100]; NoOfProgramRanked: Integer;
    ResourceUsedWhileApplying: Text[2048]; UtilizetheAdvisoryService: Boolean; LessonsLearned: Text[2048]; CanContactToShareInfo: Boolean; PlaceChoice: Integer; FamMediERASPrgrmApld: Integer;
    FamMediCaRMSPrgrmApld: Integer; FamMediERASPrgrmOfrd: Integer; FamMediCaRMSPrgrmOfrd: Integer; FamMediERASPrgrmAtnd: Integer; FamMediCaRMSPrgrmAtnd: Integer; FamMediERASPrgrmRnkd: Integer;
    FamMediCaRMSPrgrmRnkd: Integer; IntnlMediERASPrgrmApld: Integer; IntnlMediCaRMSPrgrmApld: Integer; IntnlMediERASPrgrmOfrd: Integer; IntnlMediCaRMSPrgrmOfrd: Integer;
    IntnlMediERASPrgrmAtnd: Integer; IntnlMediCaRMSPrgrmAtnd: Integer; IntnlMediERASPrgrmRnkd: Integer; IntnlMediCaRMSPrgrmRnkd: Integer; OBGYNERASPrgrmApld: Integer;
    OBGYNCaRMSPrgrmApld: Integer; OBGYNERASPrgrmOfrd: Integer; OBGYNCaRMSPrgrmOfrd: Integer; OBGYNERASPrgrmAtnd: Integer; OBGYNCaRMSPrgrmAtnd: Integer; OBGYNERASPrgrmRnkd: Integer;
    OBGYNCaRMSPrgrmRnkd: Integer; PediatricsERASPrgrmApld: Integer; PediatricsCaRMSPrgrmApld: Integer; PediatricsERASPrgrmOfrd: Integer; PediatricsCaRMSPrgrmOfrd: Integer;
    PediatricsERASPrgrmAtnd: Integer; PediatricsCaRMSPrgrmAtnd: Integer; PediatricsERASPrgrmRnkd: Integer; PediatricsCaRMSPrgrmRnkd: Integer; PsychiatryERASPrgrmApld: Integer;
    PsychiatryCaRMSPrgrmApld: Integer; PsychiatryERASPrgrmOfrd: Integer; PsychiatryCaRMSPrgrmOfrd: Integer; PsychiatryERASPrgrmAtnd: Integer; PsychiatryCaRMSPrgrmAtnd: Integer;
    PsychiatryERASPrgrmRnkd: Integer; PsychiatryCaRMSPrgrmRnkd: Integer; SurgeryERASPrgrmApld: Integer; SurgeryCaRMSPrgrmApld: Integer; SurgeryERASPrgrmOfrd: Integer;
    SurgeryCaRMSPrgrmOfrd: Integer; SurgeryERASPrgrmAtnd: Integer; SurgeryCaRMSPrgrmAtnd: Integer; SurgeryERASPrgrmRnkd: Integer; SurgeryCaRMSPrgrmRnkd: Integer; OtherERASPrgrmApld: Integer;
    OtherCaRMSPrgrmApld: Integer; OtherERASPrgrmOfrd: Integer; OtherCaRMSPrgrmOfrd: Integer; OtherERASPrgrmAtnd: Integer; OtherCaRMSPrgrmAtnd: Integer; OtherERASPrgrmRnkd: Integer;
    OtherCaRMSPrgrmRnkd: Integer) ApplicationNo: text[250];
    var
        ResiPlacementRes: Record "Residency Placement Result New";
        ApplicatDate: Date;
        StartDate: Date;
        EndDate: Date;
        PositionStartDate: Date;
        PositionEndDate: Date;
    begin
        ResiPlacementRes.Init();
        // if ApplicationDateTxt <> '' then begin
        //     Evaluate(ApplicatDate, ApplicationDateTxt);
        //     ResiPlacementRes.Validate("Application Date", ApplicatDate);
        // end;
        ResiPlacementRes."Application Date" := Today();
        if studentNo <> '' then
            ResiPlacementRes.validate("Student No.", StudentNo);
        if PreferredEmailId <> '' then
            ResiPlacementRes.Validate("Preferred Email Address", PreferredEmailId);
        if PreferredPhonNo <> '' then
            ResiPlacementRes.Validate("Preferred Phone Number", PreferredPhonNo);
        ResiPlacementRes.validate("NRMP_ERAS", NRMPMatch);
        ResiPlacementRes.Validate(CaRMS, CaRMS);
        ResiPlacementRes.Validate(Other, Other);
        if ResiPlacementRes.Other <> false then begin
            if OtherDescription <> '' then
                ResiPlacementRes.Validate("Other Description", OtherDescription);
        end;
        ResiPlacementRes.Validate(Neither, Neither);
        ResiPlacementRes.Validate("Secure Position", SecurePosition);
        ResiPlacementRes.Validate("Placement Type_vacant position", PlacementTypeVacantPosi);
        ResiPlacementRes.Validate("Plac. Type_ERAS_NRMP_Match_Day", PlacementTypeERASMatchDay);

        ResiPlacementRes.Validate("Placement Type_NRMP_SOAP", PlacementTypeNRMPSOAP);
        ResiPlacementRes.Validate("Placement Type_After_SOAP", PlacementTypeAfterSOAP);
        ResiPlacementRes.Validate("Placement Type_Outside_Match", PlacementTypeOutsideMatch);
        ResiPlacementRes.Validate("Plac. Type_CarMS_1_Iteration", CaRMS1Iteration);
        ResiPlacementRes.Validate("Plac. Type_CarMS_2_Iteration", CaRMS2Iteration);
        ResiPlacementRes.Validate("Placement Type_Other", PlacmntTypeOther);
        ResiPlacementRes."Secured Position" := SecuredPosition;
        if ResiPlacementRes."Secured Position" = ResiPlacementRes."Secured Position"::Other then begin
            if ChoiceDescription <> '' then
                ResiPlacementRes.Validate("Other Choice Desci.", ChoiceDescription);
        end;
        ResiPlacementRes.Validate("Preliminary Program", PreliminaryProgram);
        ResiPlacementRes.Validate("Categorical Program", CategoricalProgram);
        ResiPlacementRes.Validate("Advanced Program", AdvancedProgram);

        if ProgramName <> '' then
            ResiPlacementRes.Validate("Program Name", ProgramName);
        if HospitalName <> '' then
            ResiPlacementRes.Validate("Hospital Name", HospitalName);
        if ACGMEProgramID <> '' then
            ResiPlacementRes.Validate("ACGME Program ID", ACGMEProgramID);
        if Specialty <> '' then
            ResiPlacementRes.Validate(Specialty, Specialty);
        if City <> '' then
            ResiPlacementRes.Validate(City, City);
        if State <> '' then
            ResiPlacementRes.Validate(State, State);
        if StartDateTxt <> '' then begin
            Evaluate(StartDate, StartDateTxt);
            ResiPlacementRes.Validate("Start Date", StartDate);
        end;
        if EndDateTxt <> '' then begin
            Evaluate(EndDate, EndDateTxt);
            ResiPlacementRes.Validate("End Date", EndDate);
        end;
        ResiPlacementRes."Participate NRMP SOAP" := ParticipateNRMPSoap;
        ResiPlacementRes."Withdraw NRMP Match" := WithdrawNRMPMatch;
        ResiPlacementRes."Withdraw from CaRMS" := WithdrawFromCaRMS;
        ResiPlacementRes.Validate("With_Due To Graduation Delayed", WithDueToGraDelayed);
        ResiPlacementRes.Validate("Withd_Due To Personal Reason", WithDueToPersonalReason);
        ResiPlacementRes.Validate("With_Due To NRMP Not Eligible", WithDueToNRMPNotEligible);

        ResiPlacementRes.Validate("Withdrew Due To NE_Step2 CS", WithDueToNEStep2CS);
        ResiPlacementRes.Validate("Withdrew Due To NE_Step2 CK", WithDueToNEStep2CK);
        ResiPlacementRes.Validate("With_Due To NE_Not Rec. Result", WithDueToNENotRecdResult);
        ResiPlacementRes.Validate("With_Due To CaRMS Not Eligible", WithdrewToCaRMSNotEligible);
        ResiPlacementRes.Validate("Withdrew Due To Other", WithdrewDueToOther);
        if HealthcarePosi <> '' then
            ResiPlacementRes.Validate("Healthcare Position", HealthcarePosi);
        if PositionInstitution <> '' then
            ResiPlacementRes.Validate("Position Institution", PositionInstitution);
        if PositionDepartment <> '' then
            ResiPlacementRes.Validate("Position Department", PositionDepartment);
        if PositionCity <> '' then
            ResiPlacementRes.Validate("Position City", PositionCity);
        if PositionState <> '' then
            ResiPlacementRes.Validate("Position State", PositionState);
        if PositionStartDateTxt <> '' then begin
            Evaluate(PositionStartDate, PositionStartDateTxt);
            ResiPlacementRes.Validate("Position Start Date", PositionStartDate);
        end;
        if PositionProjectiveEndDatetxt <> '' then begin
            Evaluate(PositionEndDate, PositionProjectiveEndDatetxt);
            ResiPlacementRes.Validate("Position Projective End Date", PositionEndDate);
        end;
        ResiPlacementRes.Validate("Did Not Submit Rank Order List", DidNotSubmitROL);
        if ProgramName1 <> '' then
            ResiPlacementRes.Validate("1st Program Name", ProgramName1);
        if ProgramSpecialty1 <> '' then
            ResiPlacementRes.Validate("1st Program Specialty", ProgramSpecialty1);
        if ProgramName2 <> '' then
            ResiPlacementRes.Validate("2nd Program Name", ProgramName2);
        if ProgramSpecialty2 <> '' then
            ResiPlacementRes.Validate("2nd Program Specialty", ProgramSpecialty2);
        if ProgramName3 <> '' then
            ResiPlacementRes.Validate("3rd Program Name", ProgramName3);
        if ProgramSpecialty3 <> '' then
            ResiPlacementRes.Validate("3rd Program Specialty", ProgramSpecialty3);
        if ProgramName4 <> '' then
            ResiPlacementRes.Validate("4th Program Name", ProgramName4);
        if ProgramSpecialty4 <> '' then
            ResiPlacementRes.Validate("4th Program Specialty", ProgramSpecialty4);
        if ProgramName5 <> '' then
            ResiPlacementRes.Validate("5th Program Name", ProgramName5);
        if ProgramSpecialty5 <> '' then
            ResiPlacementRes.Validate("5th Program Specialty", ProgramSpecialty5);

        ResiPlacementRes."No. of Programs Ranked" := NoOfProgramRanked;
        if ResourceUsedWhileApplying <> '' then
            ResiPlacementRes.Validate("Resources Used While Applying", ResourceUsedWhileApplying);
        ResiPlacementRes.Validate("Utilize the advisory services", UtilizetheAdvisoryService);
        if LessonsLearned <> '' then
            ResiPlacementRes.Validate("Lessons Learned", LessonsLearned);
        ResiPlacementRes.Validate("Can contact to share info", CanContactToShareInfo);
        ResiPlacementRes.Validate("Place Choice", PlaceChoice);
        ResiPlacementRes.Validate("Fam. Medic. ERAS Prgm Applied", FamMediERASPrgrmApld);
        ResiPlacementRes.Validate("Fam. Medi. CaRMS Prg. Applied", FamMediCaRMSPrgrmApld);
        ResiPlacementRes.Validate("Fam. Medi. ERAS intw Offered", FamMediERASPrgrmOfrd);
        ResiPlacementRes.Validate("Fam. Med. CaRMS Intw. Offered", FamMediCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("Fam. Medi. ERAS intw. Atnded.", FamMediERASPrgrmAtnd);
        ResiPlacementRes.Validate("Fam. Med. CaRMS Intw. Atnded.", FamMediCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("Fam. Med. ERAS Prg. Rnkd.", FamMediERASPrgrmRnkd);
        ResiPlacementRes.Validate("Fam. Med. CaRMS Prg. Rnkd.", FamMediCaRMSPrgrmRnkd);
        ResiPlacementRes.Validate("Int. Med. ERAS Prg. Appld.", IntnlMediERASPrgrmApld);
        ResiPlacementRes.Validate("Int. Med. CaRMS Prg. Appld.", IntnlMediCaRMSPrgrmApld);
        ResiPlacementRes.Validate("Int. Med. ERAS Int. Offrd.", IntnlMediERASPrgrmOfrd);
        ResiPlacementRes.Validate("Int. Med. CaRMS Int. Offrd.", IntnlMediCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("Int. Medi. ERAS Int. Attended", IntnlMediERASPrgrmAtnd);
        ResiPlacementRes.Validate("Int. Medi. CaRMS Int. Attended", IntnlMediCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("Int. Med. ERAS Prg. Rnkd.", IntnlMediERASPrgrmRnkd);
        ResiPlacementRes.Validate("Int. Med. CaRMS Prg. Rnkd.", IntnlMediCaRMSPrgrmRnkd);
        ResiPlacementRes.Validate("OB GYN ERAS Prg. Appld.", OBGYNERASPrgrmApld);
        ResiPlacementRes.Validate("OB GYN CaRMS Prg. Appld.", OBGYNCaRMSPrgrmApld);
        ResiPlacementRes.Validate("OB GYN ERAS Int. Offrd.", OBGYNCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("OB GYN CaRMS Int. Offrd.", OBGYNCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("OB GYN ERAS Inte. Attended", OBGYNCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("OB GYN CaRMS Inte. Attended", OBGYNCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("OB GYN ERAS Prg. Rnkd.", OBGYNERASPrgrmRnkd);
        ResiPlacementRes.Validate("OB GYN CaRMS Prg. Rnkd.", OBGYNCaRMSPrgrmRnkd);
        ResiPlacementRes.Validate("Pediatrics ERAS Prg. Appld.", PediatricsERASPrgrmApld);
        ResiPlacementRes.Validate("Pediatrics CaRMS Prg. Appld.", PediatricsCaRMSPrgrmApld);
        ResiPlacementRes.Validate("Pediatrics ERAS Int. Offrd.", PediatricsERASPrgrmOfrd);
        ResiPlacementRes.Validate("Pediatrics CaRMS Int. Offrd.", PediatricsCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("Pediatrics ERAS Inte. Attended", PediatricsERASPrgrmAtnd);
        ResiPlacementRes.Validate("Pediatris CaRMS Inte. Attended", PediatricsCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("Pediatrics ERAS Prg. Rnkd.", PediatricsERASPrgrmRnkd);
        ResiPlacementRes.Validate("Pediatrics CaRMS Prg. Rnkd.", PediatricsCaRMSPrgrmRnkd);
        ResiPlacementRes.Validate("Psychiatry ERAS Prg. Appld.", PsychiatryERASPrgrmApld);
        ResiPlacementRes.Validate("Psychiatry CaRMS Prg. Appld.", PsychiatryCaRMSPrgrmApld);
        ResiPlacementRes.Validate("Psychiatry ERAS Int. Offrd.", PsychiatryERASPrgrmOfrd);
        ResiPlacementRes.Validate("Psychiatry CaRMS Int. Offrd.", PsychiatryCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("Psychiatry ERAS Inte. Attended", PsychiatryERASPrgrmAtnd);
        ResiPlacementRes.Validate("Psychitry CaRMS Int. Attended", PsychiatryCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("Psychitry ERAS Prg. Rnkd.", PsychiatryERASPrgrmRnkd);
        ResiPlacementRes.Validate("Psychitry CaRMS Prg. Rnkd.", PsychiatryCaRMSPrgrmRnkd);
        ResiPlacementRes.Validate("Surgery ERAS Prg. Appld.", SurgeryERASPrgrmApld);
        ResiPlacementRes.Validate("Surgery CaRMS Prg. Appld.", SurgeryCaRMSPrgrmApld);
        ResiPlacementRes.Validate("Surgery ERAS Inte. Attended", SurgeryERASPrgrmAtnd);
        ResiPlacementRes.Validate("Surgery CaRMS Inte. Attended", SurgeryCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("Surgery ERAS Int. Offrd.", SurgeryERASPrgrmOfrd);
        ResiPlacementRes.Validate("Surgery CaRMS Int. Offrd.", SurgeryCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("Surgery ERAS Prg. Rnkd.", SurgeryERASPrgrmRnkd);
        ResiPlacementRes.Validate("Surgery CaRMS Prg. Rnkd.", SurgeryCaRMSPrgrmRnkd);
        ResiPlacementRes.Validate("Other ERAS Prg. Appld.", OtherERASPrgrmApld);
        ResiPlacementRes.Validate("Other CaRMS Prg. Appld.", OtherCaRMSPrgrmApld);
        ResiPlacementRes.Validate("Other CaRMS Int. Offrd.", OtherCaRMSPrgrmOfrd);
        ResiPlacementRes.Validate("Other ERAS Int. Offrd.", OtherERASPrgrmOfrd);
        ResiPlacementRes.Validate("Other ERAS Inte. Attended", OtherERASPrgrmAtnd);
        ResiPlacementRes.Validate("Other CaRMS Inte. Attended", OtherCaRMSPrgrmAtnd);
        ResiPlacementRes.Validate("Other ERAS Prg. Rnkd.", OtherERASPrgrmRnkd);
        ResiPlacementRes.Validate("Other CaRMS Prg. Rnkd.", OtherCaRMSPrgrmRnkd);

        ResiPlacementRes."Entry From Portal" := true;
        IF ResiPlacementRes.INSERT(True) then
            EXIT('Success ' + ResiPlacementRes."Application No")
        Else
            Exit('Failed');
    end;

    Procedure WebAPIProblemSolutionforAdvisingRequest(ReqNo: Code[20]; Problem: Text[100]; Solution: Text[2048]; RequestStatus: Integer): Text[100]
    var
        AdvisingRequest_lRec: Record "Advising Request";
    Begin
        AdvisingRequest_lRec.Reset();
        AdvisingRequest_lRec.Setrange("Request No", ReqNo);
        If AdvisingRequest_lRec.FindFirst() then begin
            AdvisingRequest_lRec."Problem Solution Id 1" := Problem;
            AdvisingRequest_lRec."Problem solution description" := Solution;
            AdvisingRequest_lRec."Request Status" := RequestStatus;
            If AdvisingRequest_lRec.Modify() then
                exit('Success ' + AdvisingRequest_lRec."Request No")
            Else
                exit('Failed ' + AdvisingRequest_lRec."Request No");
        end;

    End;

    // Site Visit Process----Start-------30-07-2021
    Procedure WebAPISiteVisitProcess(UserID_: Text[100]; VisitDate: Date; HospitalID: Code[20]; HospitalName: Text[100]; DepartmentName: Text[50]; PersonName: Text[100]; VisitCode: Code[20]; Inference: Code[20];
              Speciality: Code[20]; CourseDescription: Text[100]; EntryDate: Date; VisitReason: Code[20]; VisitorName: Text[100]; DateofVisit: Date; NameoftheInstitute: Text[100]; NumberofBeds: Integer; StreetAddress: Text[100];
              City: Text[20]; State: Text[20]; Country: Text[20]; ZipCode: Text[20]; ApprovedACGMEResiencyProgram: Text[250]; OtherServices: Text[250]; DMEFirstName: Text[50]; DMELastName: Text[50]; DMEEmail: Text[50];
              DMEPhonewithAreaCode: Text[50]; DeptChairpersonFirstName: Text[50]; DeptChairpersonLastName: Text[50]; DeptChairpersonEmail: Text[50]; DeptChairpersonPhonewithAreaCode: Text[50]; ProgramDirectorFirstName: Text[50]; ProgramDirectorLastName: Text[50];
                ProgramDirectorEmail: Text[50]; ProgramDirectorPhonewithAreaCode: Text[50]; ClerkshipDirectorFirstName: Text[50]; ClerkshipDirectorLastName: Text[50]; ClerkshipDirectorEmail: Text[50]; ClerkshipDirectorPhonewithAreaCode: Text[50]; StudentPreceptorContact: Text[50];
                StudentCoordinatorContact: Text[50]; NumberofClinicalFaculty: Text[20]; FormalLectures: Text[250]; InformalTeaching: Text[250]; FacultySupervision: Text[250]; FacultyAssessmentofStudents: Text[500]; GeneralComments: Text[2048]; NumberofAUAstudentsRotating: Text[20]; Numberofstudentsfromothermedicalschoolsinthatrotation: Text[100];
                ParticipatesMorningReport: Boolean; ParticipatesDailyRounds: Boolean; PerformsHistory: Boolean; PerformsPhysical: Boolean; AmbulatoryTraining: Boolean; PerformsProcedures: Boolean; WritesTypesOrders: Boolean; EMREntry: Boolean; NightCallsRotation: Boolean;
                CasePresentations: Boolean; EducationFacilities: Text[250]; StudentFacilities: Text[250]; Rating: Integer; Approval: Integer; ApprovalComments: Text[2048]; DMEAreaCode: Text[20]; DepartmentAreaCode: Text[20]; ProgramAreaCode: Text[20]; ClerkshipAreaCode: Text[20]; OtherSpeciality: Text[2048]): Text[100]
    var
        SiteVisit_lRec: Record "Site Visit";
        EducationSetup_lRec: Record "Education Setup-CS";
        NoSeriesManagement_lCU: Codeunit NoSeriesManagement;
    Begin
        SiteVisit_lRec.Reset();
        EducationSetup_lRec.Reset();
        IF EducationSetup_lRec.FindFirst() then;
        SiteVisit_lRec.Init();
        SiteVisit_lRec."Document No." := NoSeriesManagement_lCU.GetNextNo(EducationSetup_lRec."Site Visit Nos", Today(), true);
        SiteVisit_lRec."Entry Date" := Today();
        SiteVisit_lRec.Validate("User ID", VisitorName);
        SiteVisit_lRec."Visit Date" := VisitDate;

        SiteVisit_lRec."Hospital ID" := HospitalID;
        SiteVisit_lRec."Hospital Name" := HospitalName;
        SiteVisit_lRec."Department Name" := DepartmentName;
        SiteVisit_lRec."Person Name" := PersonName;
        SiteVisit_lRec."Visit Reason" := VisitCode;
        SiteVisit_lRec.Inference := Inference;
        SiteVisit_lRec.Speciality := Speciality;
        SiteVisit_lRec."Course Description" := CourseDescription;
        SiteVisit_lRec."Created By" := UserID_;
        SiteVisit_lRec.Inserted := true;
        SiteVisit_lRec."Inserted By" := UserId();
        SiteVisit_lRec."Inserted On" := Today();
        SiteVisit_lRec."No. Series" := EducationSetup_lRec."Site Visit Nos";
        //SiteVisit_lRec."Visitor Name" := VisitorName;
        SiteVisit_lRec."Date of Visit" := DateofVisit;
        SiteVisit_lRec."Name of the Institute" := NameoftheInstitute;
        SiteVisit_lRec."Number of Beds" := NumberofBeds;
        SiteVisit_lRec."Street Address" := StreetAddress;
        SiteVisit_lRec.City := City;
        SiteVisit_lRec.State := State;
        SiteVisit_lRec.Country := Country;
        SiteVisit_lRec."Zip Code" := ZipCode;
        SiteVisit_lRec."Appr. ACGME Residency Prog." := ApprovedACGMEResiencyProgram;
        SiteVisit_lRec."Other Services" := OtherServices;
        SiteVisit_lRec."DME First Name" := DMEFirstName;
        SiteVisit_lRec."DME Last Name" := DMELastName;
        SiteVisit_lRec."DME Email" := DMEEmail;
        SiteVisit_lRec."DME Phone with Area Code" := DMEPhonewithAreaCode;
        SiteVisit_lRec."Dept Chairperson First Name" := DeptChairpersonFirstName;
        SiteVisit_lRec."Dept Chairperson Last Name" := DeptChairpersonLastName;
        SiteVisit_lRec."Dept Chairperson Email" := DeptChairpersonEmail;
        SiteVisit_lRec."Dept Chairperson Phone" := DeptChairpersonPhonewithAreaCode;
        SiteVisit_lRec."Program Director First Name" := ProgramDirectorFirstName;
        SiteVisit_lRec."Program Director Last Name" := ProgramDirectorLastName;
        SiteVisit_lRec."Program Director Email" := ProgramDirectorEmail;
        SiteVisit_lRec."Program Director Phone" := ProgramDirectorPhonewithAreaCode;
        SiteVisit_lRec."Clerkship Director First Name" := ClerkshipDirectorFirstName;
        SiteVisit_lRec."Clerkship Director Last Name" := ClerkshipDirectorLastName;
        SiteVisit_lRec."Clerkship Director Email" := ClerkshipDirectorEmail;
        SiteVisit_lRec."Clerkship Director Phone" := ClerkshipDirectorPhonewithAreaCode;
        SiteVisit_lRec."Student Preceptor Contact" := StudentPreceptorContact;
        SiteVisit_lRec."Student Coordinator Contact" := StudentCoordinatorContact;
        SiteVisit_lRec."Number of Clinical Faculty" := NumberofClinicalFaculty;
        SiteVisit_lRec."Formal Lectures" := FormalLectures;
        SiteVisit_lRec."Informal Teaching" := InformalTeaching;
        SiteVisit_lRec."Faculty Supervision" := FacultySupervision;
        SiteVisit_lRec."Faculty Assessment of Students" := FacultyAssessmentofStudents;
        SiteVisit_lRec."General Comments" := GeneralComments;
        SiteVisit_lRec."AUA students Rotating" := NumberofAUAstudentsRotating;
        SiteVisit_lRec."Other Med. School Rotation" := Numberofstudentsfromothermedicalschoolsinthatrotation;
        SiteVisit_lRec."Participates Morning Report" := ParticipatesMorningReport;
        SiteVisit_lRec."Participates Daily Rounds" := ParticipatesDailyRounds;
        SiteVisit_lRec."Performs History" := PerformsHistory;
        SiteVisit_lRec."Performs Physical" := PerformsPhysical;
        SiteVisit_lRec."Ambulatory Training" := AmbulatoryTraining;
        SiteVisit_lRec."Performs Procedures" := PerformsProcedures;
        SiteVisit_lRec."Writes/Types Orders" := WritesTypesOrders;
        SiteVisit_lRec."EMR Entry" := EMREntry;
        SiteVisit_lRec."Night Calls/Rotation" := NightCallsRotation;
        SiteVisit_lRec."Case Presentations" := CasePresentations;
        SiteVisit_lRec."General_Comments" := GeneralComments;
        SiteVisit_lRec."Education Facilities" := EducationFacilities;
        SiteVisit_lRec."Student Facilities" := StudentFacilities;
        SiteVisit_lRec.Rating := Rating;
        SiteVisit_lRec.GeneralComments := GeneralComments;
        SiteVisit_lRec.Approval := Approval;
        SiteVisit_lRec."Approval Comments" := ApprovalComments;
        SiteVisit_lRec.Inserted := True;
        SiteVisit_lRec."Created By" := UserId();
        SiteVisit_lRec."Inserted By" := UserId();
        SiteVisit_lRec."Inserted On" := Today();
        SiteVisit_lRec."DME with Area Code" := DMEAreaCode;
        SiteVisit_lRec."Program Director Area Code" := ProgramAreaCode;
        SiteVisit_lRec."Clerk. Direc. Area Code" := ClerkshipAreaCode;
        SiteVisit_lRec."Dept Chair. with Area Code" := DepartmentAreaCode;
        SiteVisit_lRec."Other Speciality" := OtherSpeciality;
        SiteVisit_lRec."Date of Visit" := VisitDate;
        SiteVisit_lRec."Name of the Institute" := HospitalName;
        IF SiteVisit_lRec.Insert() then
            exit('Success ' + SiteVisit_lRec."Document No.")
        Else
            exit('Failed ' + SiteVisit_lRec."Document No.");
    End;

    // Site Visit Process----End-------30-07-2021

    procedure InternlExamInsert(StudentID: Code[20]; SubCode: Code[20]; InternalMarks: Decimal; ExamDate: Text; ExamClassification: Text[20]): Text[100]
    var
        Stud: Record "Student Master-CS";
        Stud2: Record "Student Master-CS";
        EduSetup: Record "Education Setup-CS";
        CourseSubLn: Record "Course Wise Subject Line-CS";
        IntExamHdr: Record "Internal Exam Header-CS";
        IntExamHdr2: Record "Internal Exam Header-CS";
        IntExamLn2: Record "Internal Exam Line-CS";
        IntExamLn: Record "Internal Exam Line-CS";
        SubjectMaster: Record "Subject Master-CS";
        StudentSubject: Record "Main Student Subject-CS";
        ExamClass: Code[20];
        Lvl1Subj: Code[20];
        LineNo: Integer;
        ExamDate_: Date;
    begin
        if StudentId = '' then
            Error('Student Id must not be blank');
        if SubCode = '' then
            Error('Subject Code must not be blank');
        if InternalMarks < 0 then
            Error('Internal Marks must be more than 0');

        if ExamClassification = 'REGULAR' then
            ExamClass := ExamClassification
        else
            if ExamClassification = 'SPECIAL' then
                ExamClass := ExamClassification
            else
                if ExamClassification = 'MAKEUP' then
                    ExamClass := ExamClassification
                else
                    Error('Exam Classification can only be REGULAR, SPECIAL or MAKEUP');
        Stud2.Reset();
        Stud2.SetCurrentKey("Enrollment Order");
        Stud2.Ascending(true);
        Stud2.SetRange("Original Student No.", StudentId);
        Stud2.FindLast();
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", Stud2."Global Dimension 1 Code");
        EduSetup.FindFirst();
        Stud.Reset();
        Stud.SetRange("No.", Stud2."No.");
        Stud.SetFilter(Status, EduSetup."Active Statuses");
        if not Stud.FindFirst() then
            Error('Latest Enrollment No. %1 of Student ID %2 is not Active', Stud2."Enrollment No.", StudentID);

        //Table insertion
        CourseSubLn.Reset();
        CourseSubLn.SetRange("Course Code", Stud."Course Code");
        CourseSubLn.SetRange(Semester, Stud.Semester);
        CourseSubLn.SetRange("Subject Code", SubCode);
        CourseSubLn.FindFirst();
        begin
            ExamDate_ := 0D;
            Evaluate(ExamDate_, ExamDate);
            IntExamHdr2.Reset();
            //IntExamHdr2.SetCurrentKey("Course Code", "Academic Year", Year, Semester, Term, "Global Dimension 1 Code", "Subject Code");
            IntExamHdr2.SetCurrentKey("Course Code", Semester, "Academic Year", Term, "Subject Code", "Global Dimension 1 Code", "Exam Classification");
            IntExamHdr2.SetRange("Course Code", Stud."Course Code");
            IntExamHdr2.SetRange(Semester, Stud.Semester);
            IntExamHdr2.SetRange("Academic Year", Stud."Academic Year");
            IntExamHdr2.SetRange(Term, Stud.Term);
            // IntExamHdr2.SetRange(Year, Stud.Year);
            IntExamHdr2.SetRange("Subject Code", SubCode);
            IntExamHdr2.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            IntExamHdr2.SetRange("Exam Classification", ExamClass);
            IntExamHdr2.SetRange("Exam Date", ExamDate_);
            // IntExamHdr2.SetFilter(Status, '<>%1', IntExamhdr2.status::Published);
            IntExamHdr2.FindFirst();
            begin
                if IntExamHdr2.Status = IntExamHdr2.Status::Published then
                    Error('Examination Header No. %1 is already Published, its Status should be Open or Released in order to upload', IntExamHdr2."No.");
                IntExamHdr.Get(IntExamHdr2."No.");
            end;
            // else begin
            //     clear(IntExamHdr);
            //     IntExamHdr.Reset();
            //     IntExamHdr.Init();
            //     IntExamHdr.Insert(True);
            //     IntExamHdr.Validate("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            //     IntExamHdr.Validate("Academic Year", Stud."Academic Year");
            //     IntExamHdr.Validate(Term, Stud.Term);
            //     IntExamHdr.Validate("Course Code", Stud."Course Code");
            //     IntExamHdr.Validate(Semester, Stud.Semester);


            //     IntExamHdr.Validate(Year, Stud.Year);
            //     IntExamHdr.Validate("Subject Code", SubCode);
            //     SubjectMaster.reset();
            //     SubjectMaster.Setrange(Code, IntExamHdr."Subject Code");
            //     SubjectMaster.FindFirst();
            //     // IntExamHdr."Internal Maximum" := SubjectMaster."Internal Maximum";
            //     SubjectMaster.TestField("Total Maximum");
            //     IntExamHdr."Maximum Mark" := SubjectMaster."Total Maximum";

            //     IntExamHdr.Validate("Exam Classification", ExamClass);
            //     IntExamHdr.Validate("Exam Date", ExamDate);
            //     IntExamHdr.Status := IntExamHdr.Status::Released;
            //     IntExamHdr."Created By" := FORMAT(UserId());
            //     IntExamHdr."Created On" := TODAY();




            //     StudentSubject.Reset();
            //     StudentSubject.SetCurrentKey(StudentSubject."Student No.");
            //     StudentSubject.SetRange("Global Dimension 1 Code", IntExamHdr."Global Dimension 1 Code");
            //     StudentSubject.SetRange("Academic Year", IntExamHdr."Academic Year");
            //     StudentSubject.SetRange(Term, IntExamHdr.Term);
            //     StudentSubject.SetRange(Semester, IntExamHdr.Semester);

            //     if IntExamHdr."Global Dimension 1 Code" = '9100' then
            //         StudentSubject.SetRange("Subject Code", IntExamHdr."Subject Code")
            //     else
            //         if IntExamHdr."Global Dimension 1 Code" = '9000' then begin
            //             SubjectMaster.Reset();
            //             SubjectMaster.SetRange(Code, IntExamHdr."Subject Code");
            //             SubjectMaster.FindFirst();
            //             Lvl1Subj := SubjectMaster."Subject Group";
            //             SubjectMaster.Reset();
            //             SubjectMaster.SetRange(Code, Lvl1Subj);
            //             SubjectMaster.FindFirst();
            //             if SubjectMaster.Level = 2 then begin
            //                 Lvl1Subj := SubjectMaster."Subject Group";
            //                 SubjectMaster.Reset();
            //                 SubjectMaster.SetRange(Code, Lvl1Subj);
            //                 SubjectMaster.FindFirst();
            //             end;
            //             StudentSubject.SetRange("Subject Code", SubjectMaster.Code)
            //         end
            //         else
            //             Error('Institute Code must be 9000 or 9100');

            //     StudentSubject.SetRange(Course, IntExamHdr."Course Code");
            //     if IntExamHdr."Student Group" <> '' then
            //         StudentSubject.SetRange(Section, IntExamHdr."Student Group");
            //     // StudentSubject.SetRange(Publish, false);
            //     StudentSubject.setrange("Grade Confirmed", false);
            //     StudentSubject.FindFirst();
            //     // IntExamHdr.Insert(true);
            //     IntExamHdr.Modify(True);
            //     /// //////
            // end;


            IntExamLn2.Reset();
            IntExamLn2.SetRange("Document No.", IntExamHdr."No.");
            IntExamLn2.SetRange("Student No.", Stud."No.");
            // IntExamLn2.SetRange("Subject Code", SubjectCode);
            IntExamLn2.FindFirst();
            begin
                IntExamLn.Get(IntExamLn2."Document No.", IntExamLn2."Line No.");
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, IntExamLn."Subject Code");
                SubjectMaster.FindFirst();
                if not SubjectMaster."Exam Record Not Required" then
                    IntExamLn.Validate("Obtained Internal Marks", InternalMarks);


                IntExamLn.Updated := TRUE;
                IntExamLn."Entry From Portal" := true;
                If IntExamLn.Modify(True) then
                    Exit('Success ' + IntExamLn."Document No." + ' ' + Format(IntExamLn."Line No."))
                Else
                    exit('Failed');
            end;
            // else begin
            //     IntExamLn.Reset();
            //     IntExamLn.SetRange("Document No.", IntExamHdr."No.");
            //     if IntExamLn.FindLast() then;
            //     LineNo := IntExamLn."Line No." + 10000;

            //     IntExamLn.Reset();
            //     IntExamLn.Init();
            //     IntExamLn.Validate("Document No.", IntExamHdr."No.");
            //     IntExamLn.Validate("Line No.", LineNo);
            //     IntExamLn.Insert();
            //     IntExamLn.Validate("Student No.", Stud."No.");
            //     SubjectMaster.Reset();
            //     SubjectMaster.SetRange(Code, IntExamLn."Subject Code");
            //     SubjectMaster.FindFirst();
            //     if not SubjectMaster."Exam Record Not Required" then
            //         IntExamLn.Validate("Obtained Internal Marks", InternalMarks);


            //     IntExamLn.Updated := TRUE;
            //IntExamLn."Entry From Portal" := true;
            //     IntExamLn.Modify();
            // end;

        end;
    end;

    Procedure WebAPIFinalTimeTableUpdate(SNo: Integer; AttendanceMarked: Integer; FacultyID: Code[20]): Text[100]
    Var
        FinalTimeTable_lRec: Record "Final Class Time Table-CS";

    Begin
        FinalTimeTable_lRec.Reset();
        FinalTimeTable_lRec.SetRange("S.No.", SNo);
        IF FinalTimeTable_lRec.FindFirst() then begin
            FinalTimeTable_lRec.Attendance := AttendanceMarked;
            FinalTimeTable_lRec."Attendance Date" := Today();
            FinalTimeTable_lRec."Atttendance By" := FacultyID;
            If FinalTimeTable_lRec.Modify(True) then
                exit('Success ' + Format(SNo))
            Else
                exit('Failed ' + Format(SNo));
        end;
    End;

    Procedure WebAPIClassAttendanceHdr(No: Code[20]; FacultyID: Code[20]; AttendanceMarked: Boolean): Text[100]
    var
        ClassAttendanceHdr_lRec: Record "Class Attendance Header-CS";
    Begin
        ClassAttendanceHdr_lRec.Reset();
        ClassAttendanceHdr_lRec.SetRange("No.", No);
        If ClassAttendanceHdr_lRec.FindFirst() then begin
            ClassAttendanceHdr_lRec.Validate("Attendance By", FacultyID);
            ClassAttendanceHdr_lRec."Attendance Marked" := AttendanceMarked;
            ClassAttendanceHdr_lRec."Attendance Date" := Today();
            IF ClassAttendanceHdr_lRec.Modify(True) then
                exit('Success ' + No)
            else
                Exit('Failed' + No);
        end;
    End;

    procedure WebAPIClassAttendanceLine(DocNo: Code[20]; LineNo: Integer; StudentID: Code[20]; AttendanceType: Integer; AbsentReason: Code[20]; Remarks: Text[100]): Text[100]
    var
        ClassAttendanceLine_lRec: Record "Class Attendance Line-CS";
        ClassAttendanceHdr_lRec: Record "Class Attendance Header-CS";
        FinalClassTimeTable_lRec: Record "Final Class Time Table-CS";
        AttendanceAction_lCU: Codeunit "Attendance Action-CS";
        LineNo_lInt: Integer;
    begin
        ClassAttendanceHdr_lRec.Reset();
        ClassAttendanceHdr_lRec.SetRange("No.", DocNo);
        ClassAttendanceHdr_lRec.FindFirst();

        LineNo_lInt := 0;
        ClassAttendanceLine_lRec.Reset();
        ClassAttendanceLine_lRec.SetRange("Document No.", DocNo);
        IF ClassAttendanceLine_lRec.FindLast() then
            LineNo_lInt := ClassAttendanceLine_lRec."Line No." + 10000
        Else
            LineNo_lInt := 10000;



        ClassAttendanceLine_lRec.Reset();
        ClassAttendanceLine_lRec.SetRange("Document No.", DocNo);
        ClassAttendanceLine_lRec.SetRange("Line No.", LineNo);
        IF Not ClassAttendanceLine_lRec.FindFirst() then begin
            ClassAttendanceLine_lRec.Init();
            ClassAttendanceLine_lRec."Document No." := DocNo;
            ClassAttendanceLine_lRec."Line No." := LineNo_lInt;
            ClassAttendanceLine_lRec.Validate("Student No.", StudentID);
            ClassAttendanceLine_lRec."Attendance Type" := AttendanceType;
            ClassAttendanceLine_lRec.Validate("Course Code", ClassAttendanceHdr_lRec."Course Code");
            ClassAttendanceLine_lRec.Semester := ClassAttendanceHdr_lRec.Semester;
            ClassAttendanceLine_lRec.Year := ClassAttendanceHdr_lRec.Year;
            ClassAttendanceLine_lRec.Term := ClassAttendanceHdr_lRec.Term;
            ClassAttendanceLine_lRec.Section := ClassAttendanceHdr_lRec.Section;
            ClassAttendanceLine_lRec."Batch Code" := ClassAttendanceHdr_lRec."Batch Code";
            ClassAttendanceLine_lRec."Subject Code" := ClassAttendanceHdr_lRec."Subject Code";
            ClassAttendanceLine_lRec."Academic Year" := ClassAttendanceHdr_lRec."Academic Year";
            ClassAttendanceLine_lRec."Global Dimension 1 Code" := ClassAttendanceHdr_lRec."Global Dimension 1 Code";
            ClassAttendanceLine_lRec.Graduation := ClassAttendanceHdr_lRec.Graduation;
            ClassAttendanceLine_lRec.Validate("Staff Code", ClassAttendanceHdr_lRec."Attendance By");
            ClassAttendanceLine_lRec."Final Time Table No." := ClassAttendanceHdr_lRec."Time Table No";
            ClassAttendanceLine_lRec."Time Table Doc No." := ClassAttendanceHdr_lRec."Time Table Doc. No.";
            ClassAttendanceLine_lRec."Reason Code" := AbsentReason;
            ClassAttendanceLine_lRec.Remark := Remarks;
            ClassAttendanceLine_lRec.Date := ClassAttendanceHdr_lRec."Time Table Date";
            If ClassAttendanceLine_lRec.Insert(true) then begin
                AttendanceAction_lCU.InsertStudentWiseGoal(ClassAttendanceLine_lRec);
                exit('Success ' + DocNo + ' ' + Format(LineNo_lInt));
            end Else
                exit('Failed ' + DocNo + ' ' + Format(LineNo_lInt));
        end Else begin
            IF ClassAttendanceLine_lRec."Attendance Type" <> AttendanceType then begin
                ClassAttendanceLine_lRec."Attendance Type" := AttendanceType;
                If ClassAttendanceLine_lRec.Modify() then
                    exit('Success ' + DocNo + ' ' + Format(LineNo))
                Else
                    exit('Failed ' + DocNo + ' ' + Format(LineNo));

            end;
        end;
    end;

    procedure WebAPIFinalClassTimeTableInsert(Date_pD: Date; TimeSlotCode: Code[20]; RoomNo: Code[20]; Batch: Code[30]; Section: Code[30]; SubjectClass: Code[20]; SubjectCode: Code[20];
        Coursecode: Code[20]; Semester: Code[10]; AcademicCode: Code[20]; GlobalDimension2Code: Code[20]; AttendanceDate: Date; AtttendanceBy: Code[20]; Attendance: Integer;
        Faculty1Code: Code[20]; TimeTableDocumentNo: Code[20]; Year: Code[20]; NoofHours: Decimal; TimeTableLineNo: Integer; SNoGrouping: Integer; SubjectGroup: Code[20]; Term: Integer): Text[2048]
    var

        FinalClassTimeTable_lRec: Record "Final Class Time Table-CS";
        FinalClassTimeTable_lRec1: Record "Final Class Time Table-CS";
        TimeSlotMaster: Record "Time Period-CS";
        SubjectDetail: Record "Subject Classification-CS";
        ClassTimeTableHdr: Record "Class Time Table Header-CS";
        WebServiceFn: Codeunit WebServicesFunctionsCSL;
        LineNo_lInts: Integer;
    begin

        LineNo_lInts := 0;
        FinalClassTimeTable_lRec1.Reset();
        IF FinalClassTimeTable_lRec1.FindLast() then
            LineNo_lInts := FinalClassTimeTable_lRec1."S.No." + 1
        Else
            LineNo_lInts := 1;



        FinalClassTimeTable_lRec.Reset();
        FinalClassTimeTable_lRec.Init();
        FinalClassTimeTable_lRec."S.No." := LineNo_lInts;
        FinalClassTimeTable_lRec.Date := Date_pD;
        FinalClassTimeTable_lRec.Validate("Time Slot Code", TimeSlotCode);
        FinalClassTimeTable_lRec."Room No" := RoomNo;
        FinalClassTimeTable_lRec.Batch := Batch;
        FinalClassTimeTable_lRec."Faculty 1Code" := Faculty1Code;
        FinalClassTimeTable_lRec.Section := Section;
        FinalClassTimeTable_lRec."Subject Class" := SubjectClass;
        FinalClassTimeTable_lRec.Validate("Subject Code", SubjectCode);
        FinalClassTimeTable_lRec.Validate("Course code", Coursecode);
        FinalClassTimeTable_lRec.Semester := Semester;
        FinalClassTimeTable_lRec."Academic Code" := AcademicCode;
        FinalClassTimeTable_lRec."Global Dimension 1 Code" := GlobalDimension2Code;
        FinalClassTimeTable_lRec."Atttendance By" := AtttendanceBy;
        FinalClassTimeTable_lRec.Attendance := Attendance;
        FinalClassTimeTable_lRec."Attendance Date" := Date_pD;
        FinalClassTimeTable_lRec."Time Table  Document No." := TimeTableDocumentNo;
        FinalClassTimeTable_lRec.Year := Year;
        FinalClassTimeTable_lRec."Time Table Line No." := TimeTableLineNo;
        FinalClassTimeTable_lRec."S.No. Grouping" := SNoGrouping;
        FinalClassTimeTable_lRec."Subject Group" := SubjectGroup;
        FinalClassTimeTable_lRec.Term := Term;
        If FinalClassTimeTable_lRec.Insert(true) then begin
            SubjectDetail.Reset();
            SubjectDetail.SetRange(Code, FinalClassTimeTable_lRec."Subject Class");
            IF SubjectDetail.FindFirst() then
                If not SubjectDetail."Attendance Not Applicable" then
                    ClassTimeTableHdr.AttendanceGeneratedforStudents(FinalClassTimeTable_lRec);
            //WebServiceFn.CreateTimeTableCalendar(FinalClassTimeTable_lRec);
            exit('Success ' + Format(LineNo_lInts));
        end Else
            exit('Failed ');
    end;

    Procedure UpdateTranscriptPaymentStatus(ApplicationNo: Code[20]): Text[200]
    var
        CertificateApplication: Record "Certificates Application-CS";
    Begin
        CertificateApplication.Reset();
        CertificateApplication.Setrange("Application No.", ApplicationNo);
        If CertificateApplication.Findfirst() then begin
            CertificateApplication.Payment := True;
            If CertificateApplication.Modify(True) then
                Exit('Success ' + ApplicationNo);
        end;
    End;

    Procedure WebAPICashnetStatement(): Text
    var
        CLE: Record "Cust. Ledger Entry";
        CLE2: Record "Cust. Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GLEntryDataItem: Record "G/L Entry";
        studentmaster: Record "Student Master-CS";
        Customer_lRec: Record Customer;
        StudentLegacyLedger: Record "Student Legacy Ledger";
        JObject: JsonObject;
        TempJObject: JsonObject;
        JArray: JsonArray;
        JObjectLines: JsonObject;
        GenLedSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        departName: Text[50];
        EnrollmentNoFilter: text;
        PreviousBalance: Decimal;
        PrevStartDate: Date;
        PrevEndDate: Date;
        StartDate: Date;
        EndDate: Date;
        studentadjustment: Boolean;
        SkipCLE: Boolean;
    begin
        // Clear(PreviousBalance);
        // Clear(TempJObject);
        // Clear(JObject);
        // Clear(JArray);
        // PrevStartDate := 20010101D;
        // PrevEndDate := 20210930D;
        // StartDate := 20211001D;
        // EndDate := 20221231D;
        // Customer_lRec.Reset();
        // IF Customer_lRec.FindSet() then begin
        //     Repeat
        //         EnrollmentNoFilter := '';
        //         studentmaster.Reset();
        //         studentmaster.SetRange("Original Student No.", Customer_lRec."No.");
        //         studentmaster.SetFilter("Enrollment No.", '<>%1', '');
        //         If studentmaster.FindSet() then
        //             repeat
        //                 If EnrollmentNoFilter = '' then
        //                     EnrollmentNoFilter := studentmaster."Enrollment No."
        //                 Else
        //                     EnrollmentNoFilter += '|' + studentmaster."Enrollment No.";
        //             until studentmaster.Next() = 0;
        //         IF EnrollmentNoFilter <> '' then begin
        //             Clear(PreviousBalance);
        //             StudentLegacyLedger.reset();
        //             StudentLegacyLedger.SetRange("Date", PrevStartDate, PrevEndDate);
        //             StudentLegacyLedger.SetRange("Student Number", Customer_lRec."No.");
        //             StudentLegacyLedger.setfilter("Global Dimension 2 Code", '');
        //             if StudentLegacyLedger.Findfirst() then BEGIN
        //                 StudentLegacyLedger.CalcSums(Amount);
        //                 PreviousBalance := StudentLegacyLedger.Amount;
        //             end;
        //             CLE2.reset();
        //             CLE2.SetCurrentKey("Posting Date", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", Reversed, "Document No.");
        //             CLE2.setrange("posting Date", PrevStartDate, PrevEndDate);
        //             CLE2.SetRange("customer No.", Customer_lRec."No.");
        //             CLE2.setfilter("Global Dimension 2 Code", '');
        //             CLE2.SetRange(Reversed, false);
        //             CLE2.SetFilter("Document No.", '<>%1', 'OPNG*');
        //             if CLE2.Findfirst() then BEGIN
        //                 repeat
        //                     CLE2.CalcFields(Amount);
        //                     PreviousBalance += CLE2.Amount;
        //                 until CLE2.Next() = 0;
        //             end;

        //             // JObject.Add('CustomerNo', Customer_lRec."No.");//Lucky
        //             ////***Fixed First Raw**Start**
        //             JArray.Add(JObjectLines);
        //             JObjectLines.Add('activity_date', '');
        //             JObjectLines.Add('activity_desc', 'previous_balance');
        //             JObjectLines.Add('charge', Round(PreviousBalance));
        //             JObjectLines.Add('student_id ', Customer_lRec."No.");
        //             Clear(JObjectLines);
        //             ////***Fixed First Raw**End**

        //             // CustLedgerEntry.Reset();
        //             // CustLedgerEntry.SetRange("Customer No.", Customer_lRec."No.");
        //             // CustLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        //             // CustLedgerEntry.SetFilter("Document Type", '%1|%2|%3|%4|%5', CustLedgerEntry."Document Type"::" ", CustLedgerEntry."Document Type"::"Credit Memo"
        //             //                         , CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
        //             // CustLedgerEntry.SetFilter("Document No.", '<>OPNG*');
        //             // CustLedgerEntry.SetRange(Reversed, false);
        //             // CustLedgerEntry.SetRange("Global Dimension 2 Code", '');
        //             // if CustLedgerEntry.FindSet() then begin
        //             //     repeat
        //             GLEntryDataItem.Reset();
        //             // GLEntryDataItem.SetRange("Document No.", CustLedgerEntry."Document No.");
        //             GLEntryDataItem.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        //             GLEntryDataItem.SetFilter("Enrollment No.", EnrollmentNoFilter);
        //             // GLEntryDataItem.SetRange("Document Type", CustLedgerEntry."Document Type");
        //             // GLEntryDataItem.SetRange("Global Dimension 1 Code", CustLedgerEntry."Global Dimension 1 Code");
        //             // GLEntryDataItem.SetRange("Global Dimension 2 Code", CustLedgerEntry."Global Dimension 2 Code");
        //             GLEntryDataItem.SetFilter("Document Type", '%1|%2|%3|%4|%5', GLEntryDataItem."Document Type"::" ", GLEntryDataItem."Document Type"::"Credit Memo"
        //                                        , GLEntryDataItem."Document Type"::Invoice, GLEntryDataItem."Document Type"::Payment, GLEntryDataItem."Document Type"::Refund);
        //             GLEntryDataItem.SetFilter("Document No.", '<>OPNG*');
        //             GLEntryDataItem.SetRange(Reversed, false);
        //             GLEntryDataItem.SetRange("Global Dimension 2 Code", '');
        //             IF GLEntryDataItem.FindSet() then begin
        //                 repeat
        //                     studentadjustment := false;
        //                     SkipCLE := false;
        //                     if (GLEntryDataItem."Document Type" = GLEntryDataItem."Document Type"::" ") and ((GLEntryDataItem."No. Series" = 'STUDENTADJ') or (GLEntryDataItem."No. Series" = 'STUDENTADJ+')) then
        //                         studentadjustment := true
        //                     else
        //                         studentadjustment := false;
        //                     if (not studentadjustment) then begin
        //                         CLE2.Reset();
        //                         CLE2.SetRange("Document Type", GLEntryDataItem."Document Type");
        //                         CLE2.SetRange("Document No.", GLEntryDataItem."Document No.");
        //                         CLE2.SetRange("Customer No.", Customer_lRec."No.");
        //                         if CLE2.FindFirst() then begin
        //                             CLE2.CalcFields(Amount);
        //                             if CLE2.Amount = GLEntryDataItem.amount then
        //                                 SkipCLE := true;
        //                         end;
        //                     end;
        //                     IF SkipCLE = false then begin
        //                         JArray.Add(JObjectLines);
        //                         JObjectLines.Add('activity_date', GLEntryDataItem."Posting Date");
        //                         JObjectLines.Add('activity_desc', GLEntryDataItem.Description);
        //                         if studentadjustment then
        //                             JObjectLines.Add('charge', Round((GLEntryDataItem.Amount * 1)))
        //                         else
        //                             JObjectLines.Add('charge', Round((GLEntryDataItem.Amount * -1)));
        //                         JObjectLines.Add('student_id ', Customer_lRec."No.");
        //                         Clear(JObjectLines);
        //                     end;
        //                 until GLEntryDataItem.Next() = 0;
        //             end;
        //             // until CustLedgerEntry.Next() = 0;
        //             // end;
        //         end;
        //     until Customer_lRec.Next() = 0;
        // end;
        // JObject.Add('Lines', JArray);
        // Clear(TempJObject);
        // Clear(JArray);
        exit(Format('Success'));
    end;

    procedure MedicalScholarSubjectLines(ApplicationNo: Code[20]; Subject: Code[100]; Semester: Text[20]; Position: integer): Code[20]
    var
        MedScholarLine: Record "Medical Scholars Line";
        lineNo: Integer;
        RecMSL: Record "Medical Scholars Line";
    begin
        MedScholarLine.Reset();
        MedScholarLine.SetCurrentKey("Document No.", "Line No.");
        MedScholarLine.SetRange("Document No.", ApplicationNo);
        IF MedScholarLine.FindLast() then
            lineNo := MedScholarLine."Line No." + 10000
        else
            lineNo := 10000;
        MedScholarLine.Reset();
        MedScholarLine.SetRange("Document No.", ApplicationNo);
        MedScholarLine.SetRange("Subect Name ", Subject);
        MedScholarLine.SetRange("Semster No", Semester);
        IF not MedScholarLine.FindFirst() then begin
            MedScholarLine.Reset();
            MedScholarLine.Init();
            MedScholarLine."Document No." := ApplicationNo;
            MedScholarLine."Line No." := lineNo;
            MedScholarLine."Subect Name " := Subject;
            MedScholarLine."Semster No" := Semester;
            MedScholarLine.Position := Position;
            IF (Semester = 'MED1') AND (lineNo in [20000, 30000, 40000]) then begin
                IF RecMSL.Get(ApplicationNo, 10000) then
                    MedScholarLine.Position := RecMSL.Position;
            end else
                IF (Semester = 'MED2') AND (lineNo in [70000, 80000, 90000]) then begin
                    IF RecMSL.Get(ApplicationNo, 60000) then
                        MedScholarLine.Position := RecMSL.Position;
                end else
                    IF (Semester = 'MED3') AND (lineNo in [120000, 130000, 140000]) then begin
                        IF RecMSL.Get(ApplicationNo, 110000) then
                            MedScholarLine.Position := RecMSL.Position;
                    end else
                        IF (Semester = 'MED4') AND (lineNo in [170000, 180000, 190000]) then begin
                            IF RecMSL.Get(ApplicationNo, 160000) then
                                MedScholarLine.Position := RecMSL.Position;
                        end;
            IF MedScholarLine.Insert() then
                exit('Success ' + FORMAT(MedScholarLine."Document No."))
            else
                exit('Failed ' + FORMAT(MedScholarLine."Document No."));
        end else
            if MedScholarLine.FindFirst() then begin
                MedScholarLine.Position := Position;
                IF (Semester = 'MED1') AND (MedScholarLine."Line No." in [20000, 30000, 40000]) then begin
                    IF RecMSL.Get(ApplicationNo, 10000) then
                        MedScholarLine.Position := RecMSL.Position;
                end else
                    IF (Semester = 'MED2') AND (MedScholarLine."Line No." in [70000, 80000, 90000]) then begin
                        IF RecMSL.Get(ApplicationNo, 60000) then
                            MedScholarLine.Position := RecMSL.Position;
                    end else
                        IF (Semester = 'MED3') AND (MedScholarLine."Line No." in [120000, 130000, 140000]) then begin
                            IF RecMSL.Get(ApplicationNo, 110000) then
                                MedScholarLine.Position := RecMSL.Position;
                        end else
                            IF (Semester = 'MED4') AND (MedScholarLine."Line No." in [170000, 180000, 190000]) then begin
                                IF RecMSL.Get(ApplicationNo, 160000) then
                                    MedScholarLine.Position := RecMSL.Position;
                            end;
                IF MedScholarLine.Modify() then
                    exit('Success ' + FORMAT(MedScholarLine."Document No."))
                else
                    exit('Failed ' + FORMAT(MedScholarLine."Document No."));
            end;
    end;

    Procedure WebAPICertificateApplicationUpdate(ApplicationNo: Code[20]; FirstName: Text[35]; LastName: Text[35]; OrganisationName: Text[250]; MailAddress: Text[250]; DigitalSignStatus: Option " ",Pending,Completed; PaymentStatus: option " ",Pending,Completed): Text[100]
    Var
        CertificationApplication: Record "Certificates Application-CS";
    Begin
        CertificationApplication.Reset();
        CertificationApplication.Setrange("Application No.", ApplicationNo);
        If CertificationApplication.FindFirst() then begin
            CertificationApplication."First Name" := FirstName;
            CertificationApplication."Last Name" := LastName;
            CertificationApplication."Organization Name " := OrganisationName;
            CertificationApplication."Courier Address" := MailAddress;
            CertificationApplication."Digital Signature Status" := DigitalSignStatus;
            CertificationApplication."Payment Status" := PaymentStatus;
            If CertificationApplication.Modify() then
                exit('Success ' + ApplicationNo)
            Else
                Exit('Failed ' + ApplicationNo);
        end;
    End;

    procedure WebAPIBlackboardGrading(EntryNo: Integer; StudentNo: Code[20]; GradeColumnID: Text[20]; GradeColumnName: Text[100];
   GradeValue: Text[10]; Score: Decimal; Status: Text[20]; CourseCode: Code[20]; Academicyear: Code[20]; Term: Option; Blackboardcourseid: Text[50]): Text[2048]
    var
        StudentMasterRec: Record "Student Master-CS";
        BlackboardGrading: Record BlackboardGrading;
        BlackboardGrading1: Record BlackboardGrading;
    begin

        StudentMasterRec.Get(StudentNo);
        BlackboardGrading.Reset();
        BlackboardGrading.SetRange("Student No.", StudentNo);
        BlackboardGrading.SetRange("Grade Column ID", GradeColumnID);
        BlackboardGrading.SetRange("Blackboard course id", Blackboardcourseid);
        BlackboardGrading.Setrange("Course Code", CourseCode);
        BlackboardGrading.SetRange("Academic year", Academicyear);
        BlackboardGrading.SetRange("Term 1", Term);
        IF not BlackboardGrading.FindFirst() then begin
            BlackboardGrading1.Reset();
            BlackboardGrading1.Init();
            // BlackboardGrading1."Entry No." := EntryNo;
            BlackboardGrading1.Validate("Student No.", StudentNo);
            BlackboardGrading1."Grade Column ID" := GradeColumnID;
            BlackboardGrading1."Grade Column Name" := GradeColumnName;
            BlackboardGrading1."Grade Value" := GradeValue;
            BlackboardGrading1.Score := Score;
            BlackboardGrading1.Status := Status;
            BlackboardGrading1."Creation Date" := Today;
            BlackboardGrading1."Course Code" := CourseCode;
            BlackboardGrading1."Academic year" := Academicyear;
            BlackboardGrading1."Term 1" := Term;
            BlackboardGrading1."Blackboard course id" := Blackboardcourseid;
            if BlackboardGrading1.Insert(true) then
                exit('Success ' + Format(BlackboardGrading1."Student No."))
            else
                exit('Failed ' + Format(BlackboardGrading1."Student No."));
        End else begin


            // BlackboardGrading.reset;
            // BlackboardGrading.SetRange("Student No.", StudentNo);
            // BlackboardGrading.SetRange("Grade Column ID", GradeColumnID);
            // BlackboardGrading.SetRange("Blackboard course id", Blackboardcourseid);
            // BlackboardGrading.Setrange("Course Code", CourseCode);
            // BlackboardGrading.SetRange("Academic year", Academicyear);
            // BlackboardGrading.SetRange("Term 1", Term);
            // IF BlackboardGrading.Findfirst Then Begin
            BlackboardGrading.Validate("Student No.", StudentNo);
            BlackboardGrading."Grade Column ID" := GradeColumnID;
            BlackboardGrading."Grade Column Name" := GradeColumnName;
            BlackboardGrading."Grade Value" := GradeValue;
            BlackboardGrading.Score := Score;
            BlackboardGrading.Status := Status;
            //    BlackboardGrading1."Creation Date" := Today;
            BlackboardGrading."Update Date" := Today;
            BlackboardGrading."Course Code" := CourseCode;
            BlackboardGrading."Academic year" := Academicyear;
            BlackboardGrading."Term 1" := Term;
            BlackboardGrading."Blackboard course id" := Blackboardcourseid;
            if BlackboardGrading.Modify(true) then
                exit('Success ' + Format(BlackboardGrading."Student No."))
            else
                exit('Failed ' + Format(BlackboardGrading."Student No."));


        end;
    end;

    //CSPL-00307 T1-T1518 Start
    procedure WebAPIAttandanceAbsenceEntry(StudentID: Code[20]; FacilitatorDetail: Text[200]; Comment: Text[2048]; ActivitySelection: option " ","Small Group Activity","Anatomy Lab","ICM session",Exam,Other; OtherActivityNAme: Text[100]; DateofAbsence: Text; TypeofAbsence: Option " ",Absent,Tardy; TotalMinTardy: Decimal; EmailReceiptRequired: Boolean; VarCreatedBy: Code[50]; UserName: Text[100]): Text[100]
    var
        AttandanceAbsenceEntry: REcord "User Group Insititute-CS";
        StudentMaster: Record "Student Master-CS";
        Employee: Record Employee;
        DoA: Date;
    Begin
        StudentMaster.Reset();
        StudentMaster.Setrange("No.", StudentID);
        StudentMaster.FindFirst();

        DoA := 0D;
        If DateofAbsence = '' then
            Error('Date of Absence must have a value');
        Evaluate(DoA, DateofAbsence);

        AttandanceAbsenceEntry.Reset();
        AttandanceAbsenceEntry.Setrange("Student ID", StudentID);
        AttandanceAbsenceEntry.SetRange("Date of Absence", DoA);
        AttandanceAbsenceEntry.SetRange("Type of Absence", TypeofAbsence);
        AttandanceAbsenceEntry.SetRange(Activity, ActivitySelection);
        If not AttandanceAbsenceEntry.FindFirst() then begin
            AttandanceAbsenceEntry.Init();
            AttandanceAbsenceEntry."Entry Date" := Today();
            AttandanceAbsenceEntry.Validate("Student ID", StudentID);
            AttandanceAbsenceEntry."Student Name" := StudentMaster."Student Name";
            AttandanceAbsenceEntry.Semester := StudentMaster.Semester;
            AttandanceAbsenceEntry."Academic Year" := StudentMaster."Academic Year";
            AttandanceAbsenceEntry.Term := StudentMaster.Term;
            AttandanceAbsenceEntry.Facilitator := FacilitatorDetail;
            AttandanceAbsenceEntry.Comments := Comment;
            AttandanceAbsenceEntry."Other Activity Name" := OtherActivityNAme;
            AttandanceAbsenceEntry.Activity := ActivitySelection;
            Evaluate(AttandanceAbsenceEntry."Date of Absence", DateofAbsence);
            AttandanceAbsenceEntry."Type of Absence" := TypeofAbsence;
            AttandanceAbsenceEntry."Total Minutes Tardy" := TotalMinTardy;
            AttandanceAbsenceEntry."Email Receipt Required" := EmailReceiptRequired;
            AttandanceAbsenceEntry."Created By" := VarCreatedBy;
            Employee.Reset();
            IF Employee.Get(VarCreatedBy) then
                AttandanceAbsenceEntry.Email := Employee."Company E-Mail";
            AttandanceAbsenceEntry."User Name" := UserName;
            AttandanceAbsenceEntry."Created On" := Today();
            AttandanceAbsenceEntry."Completion DateTime" := CurrentDateTime;
            If AttandanceAbsenceEntry.Insert(true) then
                Exit('Success ' + Format(AttandanceAbsenceEntry."Entry No."))
            Else
                Exit('Failed ' + StudentID);
        end Else
            Exit('Duplicate');

    End;
    //CSPL-00307 T1-T1518 ends

    //CSPL-00307 - Insurance Waiver  Starts
    procedure InsuranceWaiverDocument(StudentNo: Code[20]; AcademicYear: Code[20]; Term: Option; Semester: Code[20]; PolicyNumber: Text[100]; Carrier: text[100];
    MemberID: Text[100]; GroupNumber: Text[100]; InsuranceValidFrom: Date; InsuranceValidTo: Date; DocumentNo: Code[20]; OLR_Dashboard: Boolean): Text
    var
        RecIsuranceWaiver: Record "Student Rank-CS";
    begin
        IF DocumentNo = '' then begin
            RecIsuranceWaiver.Reset();
            RecIsuranceWaiver.SetRange("Student No.", StudentNo);
            RecIsuranceWaiver.SetRange("Academic Year", AcademicYear);
            RecIsuranceWaiver.SetRange(Semester, Semester);
            RecIsuranceWaiver.SetRange(Term, Term);
            RecIsuranceWaiver.SetFilter(Status, '<>%1', RecIsuranceWaiver.Status::Rejected);
            IF RecIsuranceWaiver.FindFirst() then
                Error('Application for Student %1 already Exist', RecIsuranceWaiver."Student No.");

            RecIsuranceWaiver.Init();
            RecIsuranceWaiver.Validate("Student No.", StudentNo);
            RecIsuranceWaiver."Academic Year" := AcademicYear;
            RecIsuranceWaiver.Term := Term;
            RecIsuranceWaiver.Semester := Semester;
            RecIsuranceWaiver."Policy No." := PolicyNumber;
            RecIsuranceWaiver.Carrier := Carrier;
            RecIsuranceWaiver."Member ID" := MemberID;
            RecIsuranceWaiver."Group Number" := GroupNumber;
            IF InsuranceValidFrom > 20000101D then
                RecIsuranceWaiver."Insurance Valid From" := InsuranceValidFrom;
            IF InsuranceValidTo > 20000101D then
                RecIsuranceWaiver."Insurance Valid To" := InsuranceValidTo;
            RecIsuranceWaiver."Application Date" := Today();
            RecIsuranceWaiver.Status := RecIsuranceWaiver.Status::Pending;
            If OLR_Dashboard then begin
                RecIsuranceWaiver."Entry From OLR Page" := True;
                RecIsuranceWaiver."Entry From Dashboard" := false;
            end
            Else begin
                RecIsuranceWaiver."Entry From OLR Page" := false;
                RecIsuranceWaiver."Entry From Dashboard" := true;
            end;
            IF RecIsuranceWaiver.Insert(true) Then
                Exit('Success ' + RecIsuranceWaiver."No.")
            Else
                Exit('Failed ' + StudentNo);
        end else begin
            RecIsuranceWaiver.Reset();
            RecIsuranceWaiver.Get(DocumentNo);
            RecIsuranceWaiver.Validate("Student No.", StudentNo);
            RecIsuranceWaiver."Academic Year" := AcademicYear;
            RecIsuranceWaiver.Term := Term;
            RecIsuranceWaiver.Semester := Semester;
            RecIsuranceWaiver."Policy No." := PolicyNumber;
            RecIsuranceWaiver.Carrier := Carrier;
            RecIsuranceWaiver."Member ID" := MemberID;
            RecIsuranceWaiver."Group Number" := GroupNumber;
            IF InsuranceValidFrom > 20000101D then
                RecIsuranceWaiver."Insurance Valid From" := InsuranceValidFrom;
            IF InsuranceValidTo > 20000101D then
                RecIsuranceWaiver."Insurance Valid To" := InsuranceValidTo;
            RecIsuranceWaiver."Application Date" := Today();
            If OLR_Dashboard then begin
                RecIsuranceWaiver."Entry From OLR Page" := True;
                RecIsuranceWaiver."Entry From Dashboard" := false;
            end
            Else begin
                RecIsuranceWaiver."Entry From OLR Page" := false;
                RecIsuranceWaiver."Entry From Dashboard" := true;
            end;
            IF RecIsuranceWaiver.Modify(true) Then
                Exit('Success ' + RecIsuranceWaiver."No.")
            Else
                Exit('Failed ' + StudentNo);
        end;
    end;
    //CSPL-00307 - Insurance Waiver  Ends

    Procedure CheckRosterForCLOA(StudentNo: Code[20]; StartDateText: Text; EndDateText: Text)
    var
        RosterScheduleLine_lRec: Record "Roster Scheduling Line";
        SLOA: Record "Student Leave of Absence";
        StudentMaster: Record "Student Master-CS";
        Text50000Lbl: Label 'CLOA Start Date : %1 is exist in the Roster Scheduled Period.', comment = '%1 = Leave of Absence Start Date ';
        StartDate: Date;
        EndDate: date;
        WeekDay: date;
        Text50001Lbl: Label 'Clinical Rotation schedule for next week does not exist.';
    begin
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", StudentNo);
        StudentMaster.FindFirst();

        If StartDateText = '' then
            Error('Start Date must not be blank');

        If EndDateText = '' then
            Error('End Date must not be blank');

        Evaluate(StartDate, StartDateText);
        Evaluate(EndDate, EndDateText);

        RosterScheduleLine_lRec.Reset();
        RosterScheduleLine_lRec.SetRange("Student No.", StudentNo);
        RosterScheduleLine_lRec.SetFilter("Start Date", '<=%1', StartDate);
        RosterScheduleLine_lRec.SetFilter("End Date", '>=%1', StartDate);
        RosterScheduleLine_lRec.SetFilter(Status, '%1|%2', RosterScheduleLine_lRec.Status::Scheduled, RosterScheduleLine_lRec.Status::Published);
        If RosterScheduleLine_lRec.FindFirst() then
            ERROR(Text50000Lbl, StartDate);

        WeekDay := 0D;

        //CSPL-00307 - 19-04-23 as per
        // WeekDay := SLOA.GetWeekDay(EndDate);
        WeekDay := CalcDate('<1D>', EndDate);
        //CSPL-00307 - 19-04-23 as per stuti CLOA End Date's Next Day must be a Rotation Starting Date

        RosterScheduleLine_lRec.Reset();
        RosterScheduleLine_lRec.SetRange("Student No.", StudentNo);
        //CSPL-00307 - 18-04-23 as per stuti
        RosterScheduleLine_lRec.SetFilter("Start Date", '%1', Weekday);
        // RosterScheduleLine_lRec.SetFilter("Start Date", '<=%1', Weekday);
        // RosterScheduleLine_lRec.SetFilter("End Date", '>=%1', WeekDay);
        //CSPL-00307 - 18-04-23 as per stuti

        //RosterScheduleLine_lRec.SetRange("Academic Year", _LOA."Academic Year");
        RosterScheduleLine_lRec.SetFilter(Status, '%1|%2', RosterScheduleLine_lRec.Status::Scheduled, RosterScheduleLine_lRec.Status::Published);
        IF not RosterScheduleLine_lRec.FindFirst() then
            Error(Text50001Lbl);

    End;

    Procedure WebAPIStudentCitizenshipUpdate(SLcMNo: Code[20]; Sem: Code[10]; AY: Code[20]; pTerm: Option FALL,SPRING,SUMMER; EligibleNon: Boolean; USCitizen: Boolean; AntiguaCitizen: Boolean; IndianCitizen: Boolean): Text
    Var
        StudentMAster: Record "Student Master-CS";
        StudentRegistration: Record "Student Registration-CS";
    Begin
        StudentMAster.Reset();
        StudentMAster.Setrange("No.", SLcMNo);
        If StudentMAster.FindFirst() then begin
            StudentRegistration.Reset();
            StudentRegistration.SetRange("Student No", SLcMNo);
            StudentRegistration.SetRange("Academic Year", AY);
            StudentRegistration.SetRange(Semester, Sem);
            StudentRegistration.SetRange(Term, pTerm);
            IF StudentRegistration.FindFirst() then begin
                StudentRegistration."Eligible Non Citizen" := EligibleNon;
                StudentRegistration."US Citizen" := USCitizen;
                StudentRegistration."Antigua Citizen" := AntiguaCitizen;
                StudentRegistration."Indian Citizen" := IndianCitizen;
                StudentRegistration.Modify(True);
            end;
            StudentMAster."Eligible Non Citizen" := EligibleNon;
            StudentMAster."US Citizen" := USCitizen;
            StudentMAster."Antigua Citizen" := AntiguaCitizen;
            StudentMAster."Indian Citizen" := IndianCitizen;
            IF StudentMAster.Modify(True) then
                Exit('Success ' + SLcMNo)
            Else
                exit('Failed ' + SLcMNo);
        end;

    End;

    //CSPL-00307-HelloSign_BUG
    procedure UpdateHelloSignConfirmed_Leave_Withdrawal(ApplicationType: Integer; ApplicationNo: Code[20]; HelloSignConfirmed: Boolean): Text
    var
        StudentLeave: Record "Student Leave of Absence";
        WithdrawalStudent: Record "Withdrawal Student-CS";
    begin
        // ApplicationType = 1 for Leave & ApplicationType = 2 for Withdrawal
        IF ApplicationType = 1 then begin
            StudentLeave.Reset();
            IF StudentLeave.Get(ApplicationNo) Then begin
                StudentLeave.HelloSign_Confirmed := HelloSignConfirmed;
                IF StudentLeave.Modify() then
                    exit('Success ' + ApplicationNo)
                Else
                    exit('Failed ' + ApplicationNo);
            end;
        end else
            IF ApplicationType = 2 then begin
                WithdrawalStudent.Reset();
                IF WithdrawalStudent.Get(ApplicationNo) then begin
                    WithdrawalStudent.HelloSign_Confirmed := HelloSignConfirmed;
                    IF WithdrawalStudent.Modify() then
                        exit('Success ' + ApplicationNo)
                    Else
                        exit('Failed ' + ApplicationNo);
                end;
            end;
    end;
}
