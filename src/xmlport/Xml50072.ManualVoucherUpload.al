xmlport 50072 "Manual Voucher Uppload"
{
    Caption = 'Manual Voucher Upload';
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
                XmlName = 'GeneralJournalLine';
                textelement(PostingDate)
                {
                }

                textelement(FeeCode)
                {

                }
                textelement(EnrollmentNo)
                {

                }
                textelement(BalAccountType)
                {

                }
                textelement(BalAccountNo)
                {

                }
                textelement(Amount)
                {

                }
                textelement(AppliestoDocType)
                {

                }
                textelement(AppliestoDocNo)
                {

                }
                trigger OnBeforeInsertRecord()
                begin
                    IF (Flag = TRUE) THEN
                        Flag := FALSE
                    ELSE BEGIN
                        IF (FeeCode <> '') AND (Amount <> '') THEN BEGIN

                            StudentMaster.Reset();
                            StudentMaster.Get(BalAccountNo);

                            FeeComponet.Reset();
                            FeeComponet.Get(FeeCode);

                            FeeSetup.Reset();
                            FeeSetup.SetRange("Global Dimension 1 Code", InstCode);
                            IF FeeSetup.FindFirst() then;

                            FeeSetup.TestField("Journal Template Name");
                            FeeSetup.TestField("Journal Batch Name");

                            GeneralJournalBatch_gRec.Reset();
                            GeneralJournalBatch_gRec.SetRange("Journal Template Name", FeeSetup."Journal Template Name");
                            GeneralJournalBatch_gRec.SetRange(Name, FeeSetup."Journal Batch Name");
                            If GeneralJournalBatch_gRec.FindFirst() then;

                            EntryNo := 0;
                            GenjournalLine_gRec.Reset();
                            GenjournalLine_gRec.SetRange("Journal Template Name", FeeSetup."Journal Template Name");
                            GenjournalLine_gRec.SetRange("Journal Batch Name", FeeSetup."Journal Batch Name");
                            If GenjournalLine_gRec.FindLast() then
                                EntryNo := GenjournalLine_gRec."Line No." + 10000
                            ELse
                                EntryNo := 10000;


                            GenjournalLine_gRec.Init();
                            GenjournalLine_gRec."Journal Template Name" := FeeSetup."Journal Template Name";
                            GenjournalLine_gRec."Journal Batch Name" := FeeSetup."Journal Batch Name";
                            GenjournalLine_gRec."Line No." := EntryNo;
                            GenjournalLine_gRec."Document No." := NoSeries.GetNextNo(GeneralJournalBatch_gRec."No. Series", 0D, false);
                            Evaluate(GenjournalLine_gRec."Posting Date", PostingDate);
                            GenjournalLine_gRec.Validate("Posting Date");
                            GenjournalLine_gRec.Validate("Document Date", Today());
                            GenjournalLine_gRec.Validate("Fee Code", FeeCode);
                            Evaluate(GenjournalLine_gRec."Bal. Account Type", BalAccountType);
                            GenjournalLine_gRec.Validate("Bal. Account Type");
                            GenjournalLine_gRec.Validate("Bal. Account No.", BalAccountNo);
                            GenjournalLine_gRec.Validate("Enrollment No.", EnrollmentNo);
                            Evaluate(GenjournalLine_gRec.Amount, Amount);
                            GenjournalLine_gRec.Validate(Amount);
                            Evaluate(GenjournalLine_gRec."Applies-to Doc. Type", AppliestoDocType);
                            GenjournalLine_gRec.Validate("Applies-to Doc. Type");
                            GenjournalLine_gRec.Validate("Applies-to Doc. No.", AppliestoDocNo);
                            GenjournalLine_gRec.Validate("Shortcut Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                            If StudentMaster."Global Dimension 2 Code" <> '' then
                                GenjournalLine_gRec.Validate("Shortcut Dimension 2 Code", StudentMaster."Global Dimension 2 Code")
                            Else
                                GenjournalLine_gRec.Validate("Shortcut Dimension 2 Code", FeeComponet."Global Dimension 2 Code");

                            GenjournalLine_gRec.Insert();
                        END;
                    END;
                    currXMLport.SKIP();
                END;
            }
        }
    }
    trigger OnInitXmlPort()
    begin
        IF (UserSetup.GET(USERID())) THEN BEGIN
            InstCode := UserSetup."Global Dimension 1 Code";
        END ELSE
            ERROR('Configure the user setup.');
        EntryNo := 0;
        Flag := TRUE;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Manual Voucher Upload Sucessfully !');
    end;

    var
        GenjournalLine_gRec: Record "Gen. Journal Line";
        StudentMaster: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        FeeSetup: Record "Fee Setup-CS";
        GeneralJournalBatch_gRec: Record "Gen. Journal Batch";
        FeeComponet: Record "Fee Component Master-CS";
        NoSeries: Codeunit NoSeriesManagement;
        Flag: Boolean;
        InstCode: Code[20];
        EntryNo: Integer;

}