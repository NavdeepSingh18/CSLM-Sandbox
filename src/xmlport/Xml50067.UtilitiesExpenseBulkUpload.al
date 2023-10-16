xmlport 50067 "Utilities Expense Bulk Upload"
{
    Caption = 'Utilities Expense Bulk Upload';
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
                XmlName = 'UtilitiesExpenseBulkUpload';
                textelement(StudentNo)
                {
                }

                textelement(Amount)
                {
                }
                textelement(FeeType)
                {
                }
                textelement(Description)
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    if (StudentNo <> '') AND (Amount <> '') AND (FeeType <> '') then begin
                        GenJourLine1.Reset();
                        GenJourLine1.SetRange("Journal Template Name", 'UTILITIES');
                        GenJourLine1.SetRange("Journal Batch Name", 'UTILITIES');
                        if GenJourLine1.FindLast() then
                            LineNo := GenJourLine1."Line No." + 10000;

                        GenJourLine.Reset();
                        GenJourLine.Init();
                        GenJourLine."Journal Template Name" := 'UTILITIES';
                        GenJourLine."Journal Batch Name" := 'UTILITIES';
                        GenJourLine."Line No." := LineNo;
                        GenJourLine."Document Type" := GenJourLine."Document Type"::Invoice;
                        if GenBatchName.Get('UTILITIES', 'UTILITIES') then;
                        GenJourLine."Document No." := NoSeriesManagement.GetNextNo(GenBatchName."No. Series", Today, true);
                        GenJourLine.Validate("Posting No. Series", GenBatchName."Posting No. Series");
                        GenJourLine."Posting Date" := WorkDate();
                        GenJourLine.Validate("Fee Code", FeeType);
                        GenJourLine.Description := Description;
                        FeeComponet.Get(FeeType);
                        // Customer.Get(StudentNo);
                        StudentMaster.Get(StudentNo);
                        GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
                        GenJourLine.Validate("Account No.", FeeComponet."G/L Account");
                        Evaluate(Amount1, Amount);
                        GenJourLine.Validate(Amount, -Amount1);
                        GenJourLine."Due Date" := WorkDate();
                        GenJourLine.Validate("Enrollment No.", StudentMaster."Enrollment No.");
                        GenJourLine.Term := StudentMaster.Term;
                        GenJourLine."SAP Code" := FeeComponet."SAP Code";
                        GenJourLine.Validate("Shortcut Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                        GenJourLine.Validate("Shortcut Dimension 2 Code", FeeComponet."Global Dimension 2 Code");
                        //GenJourLine."Shortcut Dimension 2 Code" := FeeComponet."Global Dimension 2 Code";
                        GenJourLine.Insert();

                        GenJourLine1.Reset();
                        GenJourLine1.SetRange("Journal Template Name", 'UTILITIES');
                        GenJourLine1.SetRange("Journal Batch Name", 'UTILITIES');
                        if GenJourLine1.FindLast() then
                            LineNo := GenJourLine1."Line No." + 10000;

                        GenJourLine2.Reset();
                        GenJourLine2.Init();
                        GenJourLine2."Journal Template Name" := 'UTILITIES';
                        GenJourLine2."Journal Batch Name" := 'UTILITIES';
                        GenJourLine2."Line No." := LineNo;
                        GenJourLine2."Document Type" := GenJourLine2."Document Type"::Invoice;
                        GenJourLine2."Document No." := GenJourLine."Document No.";
                        GenJourLine2."Posting Date" := WorkDate();
                        GenJourLine2.Validate("Posting No. Series", GenBatchName."Posting No. Series");
                        //         Customer.Get(StudentNo);
                        StudentMaster.Get(StudentNo);
                        GenJourLine2."Account Type" := GenJourLine2."Account Type"::Customer;
                        GenJourLine2.Validate("Account No.", StudentMaster."Original Student No.");
                        Evaluate(Amount1, Amount);
                        GenJourLine2.Validate(Amount, Amount1);
                        GenJourLine2."Due Date" := WorkDate();
                        GenJourLine2.Description := Description;
                        GenJourLine2.Semester := StudentMaster.Semester;
                        GenJourLine2."Academic Year" := StudentMaster."Academic Year";
                        GenJourLine2.Year := StudentMaster.Year;
                        GenJourLine2."Enrollment No." := StudentMaster."Enrollment No.";
                        GenJourLine2.Term := StudentMaster.Term;

                        GenJourLine2.Validate("Shortcut Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                        If StudentMaster."Global Dimension 2 Code" <> '' then
                            GenJourLine2.Validate("Shortcut Dimension 2 Code", StudentMaster."Global Dimension 2 Code")
                        Else
                            GenJourLine2.Validate("Shortcut Dimension 2 Code", FeeComponet."Global Dimension 2 Code");


                        GenJourLine2."Fee Description" := FeeComponet.Description;
                        //GenJourLine2."Shortcut Dimension 1 Code" := Customer."Global Dimension 1 Code";
                        //GenJourLine2."Shortcut Dimension 2 Code" := Customer."Global Dimension 2 Code";
                        GenJourLine2.Insert();
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
        MESSAGE('Utilities Expense Bulk Upload Sucessfully !');
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
}