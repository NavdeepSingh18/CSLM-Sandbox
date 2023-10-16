codeunit 50050 "WebJournal1"
{
    procedure WebApiRequisitionInsert(
     DocumentNo: Code[30];
     LocationCode: Code[10];
     DocumentDate: Date;
     GlobalDimension1Code: Code[2];
     GlobalDimension2Code: Code[2];
     DocumentID: Code[20];
     CreatedBy: Text[50];
     CreatedOn: Date;
     ItemCode: Code[20];
     RequestedQuantity: Decimal
     ): Text[100]
    var
        RecRequisitionHeader: Record "Requisition Header";
        RecRequisitionLine: Record "Requisition Line_";
        RecRequisitionLine1: Record "Requisition Line_";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
    begin
        IF DocumentNo = '' THEN BEGIN
            PurchSetup.GET();
            PurchSetup.TESTFIELD("Requisition No.");
            RecRequisitionHeader.Init();
            RecRequisitionHeader."No." := NoSeriesMgt.GetNextNo(PurchSetup."Requisition No.", 0D, TRUE);
            RecRequisitionHeader."Document Type" := RecRequisitionHeader."Document Type"::Requisition;
            RecRequisitionHeader."Document Date" := DocumentDate;
            RecRequisitionHeader."Posting Date" := today();
            RecRequisitionHeader."Global Dimension 1 Code" := GlobalDimension1Code;
            RecRequisitionHeader."Global Dimension 2 Code" := GlobalDimension2Code;
            RecRequisitionHeader."Approval Status" := RecRequisitionHeader."Approval Status"::Open;
            RecRequisitionHeader.Status := RecRequisitionHeader.Status::Open;
            RecRequisitionHeader."Date & Time" := CurrentDateTime();
            RecRequisitionHeader."User Id" := UserId();
            IF RecRequisitionHeader.Insert() THEN
                EXIT('Header Inserted' + ' ' + RecRequisitionHeader."No.")
            Else
                EXIT('Header Insertion Failed' + ' ' + RecRequisitionHeader."No.");
        end ELSE begin

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
                IF RecRequisitionLine.Insert() THEN
                    EXIT('Line Inserted' + ' ' + RecRequisitionLine."Document No.")
                Else
                    EXIT('Line Insertion Failed' + ' ' + RecRequisitionLine."Document No.");
            end else
                EXIT('Header Not Found' + ' ' + DocumentNo);

        end;
    end;

    /// <summary> 
    /// Description for FeeProcess.
    /// </summary>
    /// <param name="StudNo">Parameter of type Code[20].</param>
    /// <param name="FeeCode1">Parameter of type Code[20].</param>
    /// <param name="Amount">Parameter of type Decimal.</param>
    /// <param name="TempDocNo">Parameter of type Code[20].</param>
    /// <param name="CurrencyCode">Parameter of type Code[10].</param>
    /// <param name="DueDate">Parameter of type Date.</param>
    /// <param name="SourceCode">Parameter of type Code[20].</param>
    procedure FeeProcess(StudNo: Code[20]; FeeCode1: Code[20]; Amount: Decimal; TempDocNo: Code[20]; CurrencyCode: Code[10]; DueDate: Date; SourceCode: Code[20]; GD2: Code[20]; StartDate: Date; Sem: Code[10]; AdYear: Code[20]; NextYear: Code[20]; FABool: Boolean; PPBool: Boolean; PPInstalment: Integer; SelfBool: Boolean; var TemplateName: Code[20]; var BatchName: Code[20])
    var
        FeeSetupCS: Record "Fee Setup-CS";
        StudentRec: Record "Student Master-CS";
        GenJournalLine: Record "Gen. Journal Line";
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        // Customer: Record Customer;
        SAPFeeCode: Record "SAP Fee Code";
        GenJournalTemplate: Record "Gen. Journal Template";

    begin
        FeeComponentMasterCS.GET(FeeCode1);
        // Customer.GET(StudNo);
        StudentRec.Get(StudNo);
        FeeSetupCS.Reset();
        FeeSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        IF FeeSetupCS.FindFirst() then begin
            IF PPBool = false then begin
                FeeSetupCS.TESTFIELD("Journal Template Name");
                FeeSetupCS.TESTFIELD("Journal Batch Name")
            End Else begin
                FeeSetupCS.TESTFIELD("Payment Plan Template Name");
                FeeSetupCS.TESTFIELD("Payment Plan Batch Name");
            end;
        end;

        GenJournalLine.Reset();
        IF PPBool = false then begin
            GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
            GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
        End Else begin
            GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Payment Plan Template Name");
            GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Payment Plan Batch Name");
        end;
        IF GenJournalLine.FINDLAST() THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT();

        IF PPBool = false then begin
            TemplateName := FeeSetupCS."Journal Template Name";
            BatchName := FeeSetupCS."Journal Batch Name";
            GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
            GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
        End Else begin
            TemplateName := FeeSetupCS."Journal Template Name";
            BatchName := FeeSetupCS."Payment Plan Batch Name";
            GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Payment Plan Template Name");
            GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Payment Plan Batch Name");
        end;
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", FeeComponentMasterCS."G/L Account");
        GenJournalLine.VALIDATE(Description, FeeComponentMasterCS.Description);
        GenJournalLine."Posting Date" := StartDate;
        GenJournalLine.VALIDATE("Posting Date");
        GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
        GenJournalLine.VALIDATE("Credit Amount", Amount);
        GenJournalLine.VALIDATE("Document No.", TempDocNo);
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GD2);
        GenJournalLine.VALIDATE(Course, StudentRec."Course Code");
        GenJournalLine.Semester := Sem;
        GenJournalLine."Enrollment No." := StudentRec."Enrollment No.";
        GenJournalLine.VALIDATE(Year, NextYear);
        GenJournalLine.VALIDATE("Academic Year", AdYear);
        GenJournalLine.Validate(Term, StudentRec.Term);
        GenJournalLine."Fee Code" := FeeCode1;
        GenJournalLine."Fee Description" := FeeComponentMasterCS.Description;
        GenJournalLine.VALIDATE("Due Date", DueDate);
        GenJournalTemplate.Get(GenJournalLine."Journal Template Name");
        GenJournalLine."Source Code" := GenJournalTemplate."Source Code";
        SAPFeeCode.Reset();
        SAPFeeCode.SetRange("SAP Code", FeeComponentMasterCS."SAP Code");
        IF SAPFeeCode.FindFirst() then begin
            GenJournalLine."SAP Code" := SAPFeeCode."SAP Code";
            GenJournalLine."SAP G/L Account" := SAPFeeCode."SAP G/L Account";
            GenJournalLine."SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
            GenJournalLine."SAP Description" := SAPFeeCode."SAP Description";
            GenJournalLine."SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
            GenJournalLine."SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
            GenJournalLine."SAP Company Code" := SAPFeeCode."SAP Company Code";
            GenJournalLine."SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
            GenJournalLine."Fee Group" := SAPFeeCode."Fee Group";
        end;
        GenJournalLine."Auto Generated" := True;
        GenJournalLine."Financial Aid Approved" := FABool;
        GenJournalLine."Payment Plan Applied" := PPBool;
        GenJournalLine."Payment Plan Instalment" := PPInstalment;
        GenJournalLine."Self Payment Applied" := SelfBool;
        GenJournalLine.INSERT(TRUE);
    End;

    /// <summary> 
    /// Description for CustomerInsert.
    /// </summary>
    /// <param name="StudNo">Parameter of type Code[20].</param>
    /// <param name="FeeCode1">Parameter of type Code[20].</param>
    /// <param name="Amount">Parameter of type Decimal.</param>
    /// <param name="TempDocNo">Parameter of type Code[20].</param>
    /// <param name="CurrencyCode">Parameter of type Code[10].</param>
    /// <param name="DueDate">Parameter of type Date.</param>
    /// <param name="SourceCode">Parameter of type Option "Non-Institutional","Institutional","Grenville Realty".</param>
    procedure CustomerInsert(StudNo: Code[20]; Amount: Decimal; TempDocNo: Code[20]; CurrencyCode: Code[10]; DueDate: Date; SourceCode: Option "Semester Fee","Grenville Realty","Installment Fee"; StartDate: Date; Sem: Code[10]; AdYear: Code[20]; NextYear: Code[20]; FABool: Boolean; PPBool: Boolean; PPInstalment: Integer; ApplytoDocNo: Code[20]; SelfBool: Boolean; GD2: Code[20]; FeeCode1: Code[20]): Boolean
    var
        FeeComponentMasterCS: Record "Fee Component Master-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        StudentRec: Record "Student Master-CS";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine_lRec: Record "Gen. Journal Line";
        // Customer: Record Customer;
        GenJournalTemplate: Record "Gen. Journal Template";
        NoSeries: Codeunit "NoSeriesManagement";
        Boolean_lBool: Boolean;
    begin
        CLEAR(NoSeries);
        // Customer.GET(StudNo);
        StudentRec.get(StudNo);
        FeeSetupCS.Reset();
        FeeComponentMasterCS.Get(FeeCode1);
        FeeSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        IF FeeSetupCS.FindFirst() then begin
            IF PPBool = false then begin
                FeeSetupCS.TESTFIELD("Journal Template Name");
                FeeSetupCS.TESTFIELD("Journal Batch Name")
            End Else begin
                FeeSetupCS.TESTFIELD("Payment Plan Template Name");
                FeeSetupCS.TESTFIELD("Payment Plan Batch Name");
            end;

            GenJournalLine.Reset();
            IF PPBool = false then begin
                GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
                GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Journal Template Name");
            End Else begin
                GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCS."Payment Plan Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCS."Payment Plan Batch Name");
            end;
            IF GenJournalLine.FINDLAST() THEN
                GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
            ELSE
                GenJournalLine."Line No." := 10000;

            GenJournalLine.INIT();
            IF PPBool = false then begin
                GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Journal Template Name");
                GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Journal Batch Name");
            End Else begin
                GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Payment Plan Template Name");
                GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Payment Plan Batch Name");
            end;
            GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
            IF Amount > 0 THEN
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
            GenJournalLine.VALIDATE("Account No.", StudentRec."Original Student No.");
            GenJournalLine.VALIDATE(Description, Format(SourceCode));
            GenJournalLine."Posting Date" := StartDate;
            GenJournalLine.VALIDATE("Posting Date");
            GenJournalLine.VALIDATE("Currency Code", CurrencyCode);
            GenJournalLine.VALIDATE("Debit Amount", Amount);
            GenJournalLine.VALIDATE("Document No.", TempDocNo);
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", GD2);//SD-SN-18-Dec-2020+
            GenJournalLine.VALIDATE(Course, StudentRec."Course Code");
            GenJournalLine.Semester := Sem;
            GenJournalLine."Enrollment No." := StudentRec."Enrollment No.";
            GenJournalLine.VALIDATE(Year, StudentRec.Year);
            GenJournalLine.VALIDATE("Academic Year", AdYear);
            GenJournalLine.VALIDATE(Year, NextYear);
            GenJournalLine.Validate(Term, StudentRec.Term);
            GenJournalLine.VALIDATE("Due Date", DueDate);
            GenJournalLine."Fee Description" := FeeComponentMasterCS.Description;
            GenJournalTemplate.Get(GenJournalLine."Journal Template Name");
            GenJournalLine."Source Code" := GenJournalTemplate."Source Code";
            Boolean_lBool := false;
            GenJournalLine_lRec.Reset();
            ;
            GenJournalLine_lRec.SetRange("Applies-to Doc. No.", ApplytoDocNo);
            If GenJournalLine_lRec.FindFirst() then
                Boolean_lBool := True;

            IF not Boolean_lBool then
                IF ApplytoDocNo <> '' then begin
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Payment;
                    GenJournalLine."Applies-to Doc. No." := ApplytoDocNo;
                end;
            GenJournalLine."Auto Generated" := True;
            GenJournalLine."Financial Aid Approved" := FABool;
            GenJournalLine."Payment Plan Applied" := PPBool;
            GenJournalLine."Payment Plan Instalment" := PPInstalment;
            GenJournalLine."Self Payment Applied" := SelfBool;
            IF GenJournalLine.INSERT(TRUE) then;
            DifferenceAmtCheck(TempDocNo);
            exit(True);
        end;
    End;

    procedure DifferenceAmtCheck(DocNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine1: Record "Gen. Journal Line";
        CreditDiffAmt: Decimal;
        DebitDiffAmt: Decimal;
    begin
        GenJournalLine.Reset();
        GenJournalLine.SETRANGE("Document No.", DocNo);
        GenJournalLine.CalcSums(GenJournalLine."Debit Amount", GenJournalLine."Credit Amount");

        If GenJournalLine."Debit Amount" > GenJournalLine."Credit Amount" then
            CreditDiffAmt := GenJournalLine."Debit Amount" - GenJournalLine."Credit Amount";

        If GenJournalLine."Debit Amount" < GenJournalLine."Credit Amount" then
            DebitDiffAmt := GenJournalLine."Credit Amount" - GenJournalLine."Debit Amount";

        GenJournalLine1.Reset();
        GenJournalLine1.SetRange("Document No.", DocNo);
        GenJournalLine1.SetRange("Account Type", GenJournalLine1."Account Type"::"G/L Account");
        if GenJournalLine1.FindLast() then begin
            iF CreditDiffAmt <> 0 Then
                GenJournalLine1.Validate(GenJournalLine1."Credit Amount", (GenJournalLine1."Credit Amount" + CreditDiffAmt));
            iF DebitDiffAmt <> 0 Then
                GenJournalLine1.Validate(GenJournalLine1."Credit Amount", (GenJournalLine1."Credit Amount" - DebitDiffAmt));
            GenJournalLine1.Modify();
        end;
    end;
}

