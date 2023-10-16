xmlport 50074 "Bulk Payment Upload"
{
    Caption = 'Bulk Payment Upload';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'BulkPayment';
                textelement(GeneralJournalTemplate)
                {
                }

                textelement(GeneralJouralBatch)
                {
                }
                textelement(PostingDate)
                {
                }
                textelement(DocumentType)
                {

                }
                textelement(AccountNo)
                {

                }
                textelement(Description)
                {

                }
                textelement(Amount)
                {

                }
                textelement(EnrolmentNo)
                {

                }
                textelement(PaymentMethodCode)
                {
                    MinOccurs = Zero;
                }
                textelement(CheckNo)
                {
                    MinOccurs = Zero;
                }
                textelement(CheckDate)
                {
                    MinOccurs = Zero;
                }
                textelement(AppliestoDocType)
                {
                    MinOccurs = Zero;
                }
                textelement(AppliestoDocNo)
                {
                    MinOccurs = Zero;
                }
                TextElement(DepartmentCode)
                {
                    MinOccurs = Zero;
                }
                textelement(FundType)
                {
                    MinOccurs = Zero;
                }
                textelement(DepositType)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end Else begin
                        if (GeneralJournalTemplate <> '') AND (GeneralJouralBatch <> '') then begin
                            GenJourLine1.Reset();
                            GenJourLine1.SetRange("Journal Template Name", GeneralJournalTemplate);
                            GenJourLine1.SetRange("Journal Batch Name", GeneralJouralBatch);
                            if GenJourLine1.FindLast() then
                                LineNo := GenJourLine1."Line No." + 10000;

                            GenJourLine.Reset();
                            GenJourLine.Init();
                            GenJourLine."Journal Template Name" := GeneralJournalTemplate;
                            GenJourLine."Journal Batch Name" := GeneralJouralBatch;
                            GenJourLine."Line No." := LineNo;
                            if (DocumentType <> 'Payment') and (DocumentType <> 'Refund') then
                                Error('You can not upload Invoice/Credit Memo Entries.');
                            if DocumentType = 'Payment' then
                                GenJourLine."Document Type" := GenJourLine."Document Type"::Payment;
                            if DocumentType = 'Refund' then
                                GenJourLine."Document Type" := GenJourLine."Document Type"::Refund;
                            Evaluate(PostingDate1, PostingDate);
                            GenJourLine."Posting Date" := PostingDate1;
                            GenBatchName.Reset();
                            if GenBatchName.Get(GeneralJournalTemplate, GeneralJouralBatch) then begin
                                GenJourLine."Document No." := NoSeriesManagement.GetNextNo(GenBatchName."No. Series", Today, false);
                                GenJourLine.Validate("Posting No. Series", GenBatchName."Posting No. Series");
                            end;
                            GenJourLine."Account Type" := GenJourLine."Account Type"::"Bank Account";
                            GenJourLine.Validate("Account No.", AccountNo);
                            GenJourLine.Description := Description;
                            if AppliestoDocType = '' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::" ";
                            if AppliestoDocType = 'Payment' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::Payment;
                            if AppliestoDocType = 'Invoice' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::Invoice;
                            if AppliestoDocType = 'Credit Memo' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::"Credit Memo";
                            if AppliestoDocType = 'Finance Charge Memo' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::"Finance Charge Memo";
                            if AppliestoDocType = 'Refund' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::Refund;
                            if AppliestoDocType = 'Reminder' then
                                GenJourLine."Applies-to Doc. Type" := GenJourLine."Applies-to Doc. Type"::Reminder;
                            if AppliestoDocNo <> '' then
                                GenJourLine."Applies-to Doc. No." := AppliestoDocNo;


                            If FundType <> '' then
                                Evaluate(GenJourLine."Fund Type", FundType);

                            IF DepositType <> '' then
                                Evaluate(GenJourLine."Deposit Type", DepositType);


                            Clear(StudentNo);
                            StudentMaster.Reset();
                            StudentMaster.SetRange("Enrollment No.", EnrolmentNo);
                            if StudentMaster.FindFirst() then begin
                                StudentNo := StudentMaster."Original Student No.";
                            end;
                            Evaluate(Amount1, Amount);
                            GenJourLine.Validate(Amount, Amount1);
                            GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                            GenJourLine.Validate("Bal. Account No.", StudentNo);
                            GenJourLine.Validate("Enrollment No.", EnrolmentNo);
                            GenJourLine."Due Date" := WorkDate();
                            GenJourLine.Validate("Payment Method Code", PaymentMethodCode);
                            GenJourLine."Cheque Nos." := CheckNo;
                            Evaluate(CheckDate1, CheckDate);
                            GenJourLine."Cheque Dates" := CheckDate1;
                            If DepartmentCode <> '' then
                                GenJourLine.Validate("Shortcut Dimension 2 Code", DepartmentCode);
                            GenJourLine.Insert();


                        end;
                    end;
                    currXMLport.SKIP();

                end;
            }

        }
    }

    trigger OnInitXmlPort()
    begin
        LineNo := 0;
        SkipFirstLine := True;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Bulk Payment Upload Sucessfully !');
    end;

    var
        GenJourLine: Record "Gen. Journal Line";
        GenJourLine1: Record "Gen. Journal Line";
        GenJourLine2: Record "Gen. Journal Line";
        StudentMaster: Record "Student Master-CS";
        GenBatchName: Record "Gen. Journal Batch";
        FeeComponet: Record "Fee Component Master-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Amount1: Decimal;
        LineNo: Integer;
        PostingDate1: Date;

        StudentNo: Code[20];
        CheckDate1: Date;
        SkipFirstLine: Boolean;
}