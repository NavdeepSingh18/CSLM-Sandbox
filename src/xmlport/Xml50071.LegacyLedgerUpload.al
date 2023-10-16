xmlport 50071 "Legacy Ledger Upload"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'legacyLedger';


                textelement(PostingDate) { }

                textelement(DocumentDate) { }

                textelement(DocumentType) { }
                textelement(DocumentNo) { }
                textelement(FeeCode) { }
                textelement(FeeDescription) { }
                textelement(AccountType) { }
                textelement(AccountNo) { }
                textelement(AccountName) { }
                textelement(Description) { }
                textelement(Amount) { }
                textelement(BalAccountType) { }
                textelement(BalAccountNo) { }

                textelement(DueDate) { }

                textelement(StudentEnrollmentNo) { }
                textelement(InstituteCode) { }
                textelement(DepartmentCode) { }
                textelement(CheckNo) { }
                textelement(CheckDate) { }


                trigger OnBeforeInsertRecord()
                begin
                    if (DocumentNo <> '') then begin

                        GenJourLine1.Reset();
                        GenJourLine1.SetRange("Journal Template Name", 'GENERAL');
                        GenJourLine1.SetRange("Journal Batch Name", 'OP. BALANC');
                        if GenJourLine1.FindLast() then
                            LineNo := GenJourLine1."Line No." + 10000;

                        GenJourLine.Reset();
                        GenJourLine.Init();
                        GenJourLine."Journal Template Name" := 'GENERAL';
                        GenJourLine."Journal Batch Name" := 'OP. BALANC';
                        GenJourLine."Line No." := LineNo;
                        Evaluate(PostingDate1, PostingDate);
                        Evaluate(DocumentDate1, DocumentDate);

                        GenJourLine."Posting Date" := PostingDate1;
                        GenJourLine."Document Date" := DocumentDate1;
                        GenJourLine."Document No." := DocumentNo;
                        if DocumentType = '' then
                            GenJourLine."Document Type" := GenJourLine."Document Type"::" ";
                        if DocumentType = 'Payment' then begin
                            GenJourLine."Document Type" := GenJourLine."Document Type"::Payment;
                            GenJourLine."Account Type" := GenJourLine."Account Type"::"Bank Account";
                            GenJourLine.Validate("Account No.", AccountNo);
                            GenJourLine."Fee Code" := FeeCode;

                            // if BalAccountType = 'G/L Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                            // if BalAccountType = 'Bank Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Bank Account";
                            // if BalAccountType = 'Customer' then
                            GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                            // if BalAccountType = 'Employee' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Employee;
                            // if BalAccountType = 'Fixed Asset' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Fixed Asset";
                            // if BalAccountType = 'IC Partner' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"IC Partner";
                            // if BalAccountType = 'Vendor' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Vendor;
                            GenJourLine.Validate("Bal. Account No.", BalAccountNo);
                        end;
                        if DocumentType = 'Invoice' then begin
                            GenJourLine."Document Type" := GenJourLine."Document Type"::Invoice;
                            GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
                            GenJourLine.Validate("Fee Code", FeeCode);
                            // if BalAccountType = 'G/L Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                            // if BalAccountType = 'Bank Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Bank Account";
                            // if BalAccountType = 'Customer' then
                            GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                            // if BalAccountType = 'Employee' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Employee;
                            // if BalAccountType = 'Fixed Asset' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Fixed Asset";
                            // if BalAccountType = 'IC Partner' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"IC Partner";
                            // if BalAccountType = 'Vendor' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Vendor;
                            GenJourLine.Validate("Bal. Account No.", BalAccountNo);
                        end;
                        if DocumentType = 'Credit Memo' then begin
                            GenJourLine."Document Type" := GenJourLine."Document Type"::"Credit Memo";
                            GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
                            GenJourLine.Validate("Fee Code", FeeCode);
                            // if BalAccountType = 'G/L Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                            // if BalAccountType = 'Bank Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Bank Account";
                            // if BalAccountType = 'Customer' then
                            GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                            // if BalAccountType = 'Employee' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Employee;
                            // if BalAccountType = 'Fixed Asset' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Fixed Asset";
                            // if BalAccountType = 'IC Partner' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"IC Partner";
                            // if BalAccountType = 'Vendor' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Vendor;
                            GenJourLine.Validate("Bal. Account No.", BalAccountNo);
                        end;
                        if DocumentType = 'Refund' then begin
                            GenJourLine."Document Type" := GenJourLine."Document Type"::Refund;
                            GenJourLine."Account Type" := GenJourLine."Account Type"::"Bank Account";
                            GenJourLine.Validate("Account No.", AccountNo);
                            GenJourLine."Fee Code" := FeeCode;

                            // if BalAccountType = 'G/L Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                            // if BalAccountType = 'Bank Account' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Bank Account";
                            // if BalAccountType = 'Customer' then
                            GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Customer;
                            // if BalAccountType = 'Employee' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Employee;
                            // if BalAccountType = 'Fixed Asset' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"Fixed Asset";
                            // if BalAccountType = 'IC Partner' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"IC Partner";
                            // if BalAccountType = 'Vendor' then
                            //     GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::Vendor;
                            GenJourLine.Validate("Bal. Account No.", BalAccountNo);
                        end;
                        if Description <> '' then
                            GenJourLine.Description := Description;

                        Evaluate(Amount1, Amount);
                        GenJourLine.Validate(Amount, Amount1);

                        Evaluate(DueDate1, DueDate);
                        if DueDate <> '' then
                            GenJourLine."Due Date" := DueDate1;
                        GenJourLine.Validate("Shortcut Dimension 1 Code", InstituteCode);
                        GenJourLine.Validate("Shortcut Dimension 2 Code", DepartmentCode);
                        GenJourLine."Cheque Nos." := CheckNo;
                        Evaluate(CheckDate1, CheckDate);
                        GenJourLine."Cheque Dates" := CheckDate1;
                        // GenJourLine.Validate("Enrollment No.", StudentEnrollmentNo);
                        GenJourLine."Enrollment No." := StudentEnrollmentNo;

                        GenJourLine.Insert();
                    end;
                    currXMLport.SKIP();

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }


    }
    trigger OnInitXmlPort()
    begin
        LineNo := 0;

    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Legacy Ledger Upload Sucessfully !');
    end;

    var
        Stud: Record "Student Master-CS";
        GenJourLine: Record "Gen. Journal Line";
        GenJourLine1: Record "Gen. Journal Line";
        GenJourLine2: Record "Gen. Journal Line";
        StudentMaster: Record "Student Master-CS";
        GenBatchName: Record "Gen. Journal Batch";
        FeeComponet: Record "Fee Component Master-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Customer: Record Customer;
        Amount1: Decimal;
        LineNo: Integer;
        PostingDate1: Date;

        DocumentDate1: Date;

        DueDate1: Date;
        CheckDate1: Date;

}

