xmlport 50073 "Bulk Batch Billing"
{
    Caption = 'Bulk Batch Billing';
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
                XmlName = 'BulkBatchBilling';
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
                textelement(FeeCode)
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
                textelement(AppliestoDocType)
                {
                    MinOccurs = Zero;
                }
                textelement(AppliestoDocNo)
                {
                    MinOccurs = Zero;
                }
                textelement(DueDate)
                {
                    MinOccurs = Zero;
                }

                textelement(DepartCode)
                {
                    MinOccurs = Zero;
                }
                textelement(DocumentDate)
                {
                    MinOccurs = Zero;
                }
                textelement(ScholarShipCode)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    if (GeneralJournalTemplate <> '') AND (GeneralJouralBatch <> '') then begin
                        GenBatchName.Reset();
                        GenBatchName.SetRange("Journal Template Name", GeneralJournalTemplate);
                        GenBatchName.SetRange(Name, GeneralJouralBatch);
                        If GenBatchName.FindFirst() then begin

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
                            // if (DocumentType <> 'Invoice') and (DocumentType <> 'Credit Memo') then
                            //     Error('You can not upload Payment/Refund Entries');
                            // if DocumentType = 'Invoice' then
                            //     GenJourLine."Document Type" := GenJourLine."Document Type"::Invoice;
                            // if DocumentType = 'Credit Memo' then
                            //     GenJourLine."Document Type" := GenJourLine."Document Type"::"Credit Memo";


                            Evaluate(GenJourLine."Document Type", DocumentType);
                            Evaluate(PostingDate1, PostingDate);
                            GenJourLine."Posting Date" := PostingDate1;

                            GenJourLine."Document No." := NoSeriesManagement.GetNextNo(GenBatchName."No. Series", Today, true);
                            GenJourLine.Validate("Posting No. Series", GenBatchName."Posting No. Series");
                            GenJourLine.Validate("Fee Code", FeeCode);
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
                            if DueDate <> '' then
                                Evaluate(GenJourLine."Due Date", DueDate)
                            else
                                GenJourLine."Due Date" := WorkDate();
                            // IF ChequeNo <> '' then
                            //     GenJourLine.Validate("Cheque No.", ChequeNo);
                            // IF ChequeDate <> '' then
                            //     Evaluate(GenJourLine."Cheque Date", ChequeDate);


                            If DocumentDate <> '' then
                                Evaluate(GenJourLine."Document Date", DocumentDate);

                            If ScholarShipCode <> '' then
                                GenJourLine.Validate("Waiver/Scholar/Grant Code", ScholarShipCode);

                            FeeComponet.Get(FeeCode);
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

                            GenJourLine.Validate("Shortcut Dimension 2 Code", FeeComponet."Global Dimension 2 Code");
                            // If PaymentMethodCode <> '' then
                            //     GenJourLine.Validate("Payment Method Code", PaymentMethodCode);

                            // If InstCode <> '' then
                            //     GenJourLine.Validate("Shortcut Dimension 1 Code", InstCode);
                            If DepartCode <> '' then
                                GenJourLine.Validate("Shortcut Dimension 2 Code", DepartCode);
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
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Bulk Batch Billing Upload Sucessfully !');
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
}