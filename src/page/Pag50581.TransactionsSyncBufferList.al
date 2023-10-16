page 50581 "Transactions Sync Buffer List"
{
    PageType = API;
    SourceTable = "Transactions Sync Buffer";
    Caption = 'Transactions Sync List';
    EntityName = 'tS';
    EntitySetName = 'tS';
    DelayedInsert = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    APIPublisher = 'tS01';
    APIGroup = 'tS';

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(digitTransactionID; Rec."18 Digit Transaction ID")
                {
                    ApplicationArea = All;
                }
                field(sLcMID; Rec."SLcM ID")
                {
                    ApplicationArea = All;
                }

                field(accountName; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(accouNt; Rec.Account)
                {
                    ApplicationArea = All;
                }
                field(amouNt; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(descriptiOn; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(itemCode; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field(paId; Rec.Paid)
                {
                    ApplicationArea = All;
                }
                field(paymentStatus; Rec."Payment Status")
                {
                    ApplicationArea = All;
                }
                field(processedDate; Rec."Processed Date")
                {
                    ApplicationArea = All;
                }
                field(studentApplication; Rec."Student Application")
                {
                    ApplicationArea = All;
                }
                field(transactionID; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                }
                field(transactionStatus; Rec."Transaction Status")
                {
                    ApplicationArea = All;
                }
                field(transactionSubType; Rec."Transaction Sub-Type")
                {
                    ApplicationArea = All;
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    var
        GBankAccountNo: code[20];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TranSyncBuff: Record "Transactions Sync Buffer";
        TranSyncBuff2: Record "Transactions Sync Buffer";
        CLE: Record "Cust. Ledger Entry";
        FeeSetup: Record "Fee Setup-CS";
        Stud: Record "Student Master-CS";
        TemplateName: code[10];
        BatchName: Code[10];
        Results: Code[20];
    begin
        TranSyncBuff.Reset();
        TranSyncBuff.SetRange("18 Digit Transaction ID", Rec."18 Digit Transaction ID");
        TranSyncBuff.SetRange("Item Code", Rec."Item Code");
        if TranSyncBuff.FindFirst() then
            Error('%1', TranSyncBuff."SLcM ID");

        CLE.Reset();
        CLE.SetRange("18 Digit Transaction ID", Rec."18 Digit Transaction ID");
        CLE.SetRange("Item Code", Rec."Item Code");
        if CLE.FindFirst() then
            Error('%1', CLE."Document No.");


        if Rec."SLcM ID" <> '' then
            Error('"SLcM ID" must be blank')
        else begin
            if Rec."Item Code" IN [Rec."Item Code"::" ", Rec."Item Code"::"EM-SEATHOS"] then
                Error('Item Code must be either Housing Deposit or Seat Deposit');

            if Rec."18 Digit Transaction ID" = '' then
                Error('"18 Digit Transaction ID" must not be blank');

            if Rec."Item Code" IN [Rec."Item Code"::HOUDEP, Rec."Item Code"::SEATDEP] then begin
                TranSyncBuff.Reset();
                TranSyncBuff.SetRange(Account, Rec.Account);
                TranSyncBuff.SetRange("Item Code", Rec."Item Code");
                if TranSyncBuff.FindLast() then begin
                    Rec."SLcM ID" := TranSyncBuff."SLcM ID";
                    Rec."Line No." := TranSyncBuff."Line No." + 1;
                    Rec."Void Entry" := true;
                end
                else begin
                    TemplateName := '';
                    BatchName := '';
                    Rec.TestField(Account);
                    Stud.Get(Rec.Account);
                    FeeSetup.Reset();
                    FeeSetup.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                    FeeSetup.FindFirst();
                    FeeSetup.TestField("Payment Template Name");
                    TemplateName := FeeSetup."Payment Template Name";
                    if Rec."Item Code" = Rec."Item Code"::HOUDEP then begin
                        FeeSetup.TestField("Housing Deposit Payment Batch");
                        BatchName := FeeSetup."Housing Deposit Payment Batch";
                        FeeSetup.TestField("Grenville Bank Account No.");
                        GBankAccountNo := FeeSetup."Grenville Bank Account No.";
                    end
                    else
                        if Rec."Item Code" = Rec."Item Code"::SEATDEP then begin
                            FeeSetup.TestField("Seat Deposit Payment Batch");
                            BatchName := FeeSetup."Seat Deposit Payment Batch";
                            FeeSetup.TestField("Fee Bank Account No.");
                            GBankAccountNo := FeeSetup."Fee Bank Account No.";
                        end
                        else
                            if Rec."Item Code" IN [Rec."Item Code"::" ", Rec."Item Code"::"EM-SEATHOS"] then
                                Error('Item Code can only be "Seat Deposit" or "Housing Deposit"');

                    Results := SFInsertPayment(TemplateName, BatchName, Rec.Account, Rec.Amount, '', GBankAccountNo, '', '', '', Rec."Item Code");
                    if Results = '' then
                        Error('Payment Journal has not been generated for Student No. %1, Contact Business Centrtal Administrator', Rec.Account);
                    if Results = 'FALSE' then
                        Error('Could not insert the Deposit')
                    else begin
                        Rec."SLcM ID" := Results;

                        TranSyncBuff2.Reset();
                        TranSyncBuff2.SetRange("SLcM ID", Rec."SLcM ID");
                        if TranSyncBuff.FindLast() then;
                        Rec."Line No." := TranSyncBuff2."Line No." + 1;
                        Rec."Entry From Salesforce" := true;
                    end;
                end;
            end;
        end;
    end;



    procedure SFInsertPayment(TemplateName: Code[10]; BatchName: Code[10]; StudNo: Code[20]; Amount: Decimal;
     CurrencyCode: Code[10]; BankAccountNo: Code[20]; Description: Text[100];
      TransectionNumber: Code[20]; ReceiptNo: Code[20]; DepType: Option): Code[20]
    var
        StudentRec: Record "Student Master-CS";
        GLSetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        BankAcc: Record "Bank Account";
        FeeGenerated: Report "Fee Generation New";
        GenWebJnl: Codeunit "Gen. Web  Journal -CS";
        TempDocNo: Code[20];
        LineNo: Integer;

    begin
        StudentRec.Get(StudNo);
        TempDocNo := FeeGenerated.GetLastDocumemtNo(TemplateName, BatchName);

        BankAcc.get(BankAccountNo);

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
        GenJournalLine.VALIDATE("Posting Date", WorkDate());
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Debit Amount", Amount);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", StudentRec."Global Dimension 1 Code");

        GenJournalLine.VALIDATE("Enrollment No.", StudentRec."Enrollment No.");
        GenJournalLine.VALIDATE(Course, StudentRec."Course Code");
        GenJournalLine.VALIDATE(Semester, StudentRec.Semester);
        GenJournalLine.VALIDATE(Year, StudentRec.Year);
        GenJournalLine.VALIDATE("Academic Year", StudentRec."Academic Year");
        GenJournalLine.Validate(Term, StudentRec.term);
        GenJournalLine.VALIDATE("Transaction Number", TransectionNumber);
        GenJournalLine.VALIDATE("Receipt No.", ReceiptNo);
        GenJournalLine.Validate("Deposit Type", DepType);

        GenJournalLine.VALIDATE(Course, StudentRec."Course Code");
        GenJournalLine.VALIDATE(Semester, StudentRec.Semester);
        GenJournalLine.VALIDATE(Year, StudentRec.Year);
        GenJournalLine.VALIDATE("Academic Year", StudentRec."Academic Year");
        GenJournalLine.VALIDATE("Enrollment No.", StudentRec."Enrollment No.");
        GenJournalLine.VALIDATE("Posting Date", Rec."Processed Date");
        // GenJournalLine.Validate(Description, Description);
        GenJournalLine.Validate("Item Code", Rec."Item Code");
        GenJournalLine.Validate(Paid, Rec.Paid);
        GenJournalLine.Validate("Payment Status", Rec."Payment Status");
        GenJournalLine.Validate("Processed Date", Rec."Processed Date");
        GenJournalLine.Validate("Student Application", Rec."Student Application");
        GenJournalLine.Validate("Transaction ID", Rec."Transaction ID");
        GenJournalLine.Validate("Transaction Status", Rec."Transaction Status");
        GenJournalLine.Validate("Transaction Sub-Type", Rec."Transaction Sub-Type");
        GenJournalLine.Validate("Transaction Types", Rec."Transaction Type");
        GenJournalLine.Validate("18 Digit Transaction ID", Rec."18 Digit Transaction ID");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", BankAcc."Global Dimension 2 Code");
        IF GenJournalLine.INSERT(TRUE) THEN begin

            GenJournalLine2.INIT();
            GenJournalLine2.VALIDATE("Journal Template Name", TemplateName);
            GenJournalLine2.VALIDATE("Journal Batch Name", BatchName);
            GenJournalLine2.VALIDATE("Document Type", GenJournalLine2."Document Type"::Payment);
            GenJournalLine2.VALIDATE("Document No.", TempDocNo);
            GenJournalLine2.VALIDATE("Line No.", LineNo + 10000);
            GenJournalLine2.VALIDATE("Account Type", GenJournalLine2."Account Type"::Customer);
            GenJournalLine2.VALIDATE("Account No.", StudentRec."Original Student No.");
            GenJournalLine2.VALIDATE("Posting Date", WorkDate());
            GenJournalLine2.VALIDATE("Currency Code", CurrencyCode);
            GenJournalLine2.VALIDATE("Credit Amount", Amount);
            GenJournalLine2.VALIDATE("Shortcut Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            GenJournalLine2.VALIDATE("Enrollment No.", StudentRec."Enrollment No.");
            GenJournalLine2.VALIDATE(Course, StudentRec."Course Code");
            GenJournalLine2.VALIDATE(Semester, StudentRec.Semester);
            GenJournalLine2.VALIDATE(Year, StudentRec.Year);
            GenJournalLine2.VALIDATE("Academic Year", StudentRec."Academic Year");
            GenJournalLine2.Validate(Term, StudentRec.term);
            GenJournalLine2.VALIDATE("Transaction Number", TransectionNumber);
            GenJournalLine2.VALIDATE("Receipt No.", ReceiptNo);
            GenJournalLine2.Validate("Deposit Type", DepType);

            GenJournalLine2.VALIDATE(Course, StudentRec."Course Code");
            GenJournalLine2.VALIDATE(Semester, StudentRec.Semester);
            GenJournalLine2.VALIDATE(Year, StudentRec.Year);
            GenJournalLine2.VALIDATE("Academic Year", StudentRec."Academic Year");
            GenJournalLine2.VALIDATE("Enrollment No.", StudentRec."Enrollment No.");
            GenJournalLine2.VALIDATE("Posting Date", Rec."Processed Date");
            // GenJournalLine2.Validate(Description, Description);
            GenJournalLine2.Validate("Item Code", Rec."Item Code");
            GenJournalLine2.Validate(Paid, Rec.Paid);
            GenJournalLine2.Validate("Payment Status", Rec."Payment Status");
            GenJournalLine2.Validate("Processed Date", Rec."Processed Date");
            GenJournalLine2.Validate("Student Application", Rec."Student Application");
            GenJournalLine2.Validate("Transaction ID", Rec."Transaction ID");
            GenJournalLine2.Validate("Transaction Status", Rec."Transaction Status");
            GenJournalLine2.Validate("Transaction Sub-Type", Rec."Transaction Sub-Type");
            GenJournalLine2.Validate("Transaction Types", Rec."Transaction Type");
            GenJournalLine2.Validate("18 Digit Transaction ID", Rec."18 Digit Transaction ID");
            GenJournalLine2.VALIDATE("Shortcut Dimension 2 Code", BankAcc."Global Dimension 2 Code");
            IF GenJournalLine2.INSERT(TRUE) THEN begin
                GLSetup.Get();
                //IF GLSetup."Portal Entries Auto Post" then
                GenWebJnl.WEBAPIEntryPosting(TemplateName, BatchName, TempDocNo);
                EXIT(TempDocNo)
            end
            ELSE
                EXIT('FALSE');
        end;
    end;


}