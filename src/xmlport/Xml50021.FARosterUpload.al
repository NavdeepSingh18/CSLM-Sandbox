xmlport 50021 FARosterUpload
{
    Caption = 'FARoster';
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(Root)
        {
            tableelement("Financial Aid Roster"; "Financial Aid Roster")
            {
                XmlName = 'FinancialAidRoster';
                textelement(PostingDate)
                {
                    MinOccurs = Zero;
                }
                textelement(StudentNo)
                {
                }


                textelement(Amount)
                {
                }
                textelement(FundType)
                {
                }
                textelement(Description)
                {
                }

                textelement(Semester)
                {
                    MinOccurs = Zero;
                }

                textelement(AcademicYear)
                {
                    MinOccurs = Zero;
                }
                textelement(Term)
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


                trigger OnBeforeInsertRecord()
                begin
                    IF (Flag = TRUE) THEN
                        Flag := FALSE
                    ELSE BEGIN
                        If StudentNo = '' then
                            Error('Please fill Enrollment No.');

                        If Amount = '' then
                            Error('Please fill Amount');

                        If FundType = '' then
                            Error('Please fill Fund Type');

                        if PostingDate = '' then
                            Error('Please fill Posting Date');

                        Evaluate(VarTerm, Term);

                        IF (StudentNo <> '') AND (Amount <> '') THEN BEGIN
                            Amount1 := 0;
                            Evaluate(Amount1, Amount);
                            StudentMaster.Reset();
                            StudentMaster.SetRange("Enrollment No.", StudentNo);
                            IF StudentMaster.FindFirst() then begin
                                FeeSetupCS.Reset();
                                FeeSetupCS.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                                IF FeeSetupCS.FindFirst() then begin
                                    FeeSetupCS.TESTFIELD("Payment Template Name");
                                    FeeSetupCS.TESTFIELD("Receipt Batch");


                                    // GenJournalLine1.Reset();
                                    // GenJournalLine1.SETRANGE("Journal Template Name", FeeSetupCS."Payment Template Name");
                                    // GenJournalLine1.SETRANGE("Journal Batch Name", FeeSetupCS."Receipt Batch");
                                    // IF GenJournalLine1.FINDLAST() THEN
                                    //     TempDocNo := INCSTR(GenJournalLine1."Document No.")
                                    // ELSE begin
                                    GenJournalBatch.RESET();
                                    GenJournalBatch.SETRANGE("Journal Template Name", FeeSetupCS."Payment Template Name");
                                    GenJournalBatch.SETRANGE(Name, FeeSetupCS."Receipt Batch");
                                    IF GenJournalBatch.FINDFIRST() THEN;
                                    TempDocNo := NoSeries.GetNextNo(GenJournalBatch."No. Series", 0D, true);
                                    // end;


                                    GenJournalLine1.RESET();
                                    GenJournalLine1.SetRange("Journal Template Name", FeeSetupCS."Payment Template Name");
                                    GenJournalLine1.SetRange("Journal Batch Name", FeeSetupCS."Receipt Batch");
                                    IF GenJournalLine1.FINDLAST() THEN
                                        LineNo := GenJournalLine1."Line No." + 10000
                                    ELSE
                                        LineNo := 10000;

                                    GenJournalLine.RESET();
                                    GenJournalLine.INIT();
                                    GenJournalLine.VALIDATE("Journal Template Name", FeeSetupCS."Payment Template Name");
                                    GenJournalLine.VALIDATE("Journal Batch Name", FeeSetupCS."Receipt Batch");
                                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                                    GenJournalLine.VALIDATE("Document No.", TempDocNo);
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"Bank Account");
                                    GenJournalLine.VALIDATE("Account No.", FeeSetupCS."Financial Aid Payment Bank");
                                    Evaluate(GenJournalLine."Posting Date", PostingDate);
                                    GenJournalLine.VALIDATE("Document Date", Today());
                                    GenJournalLine.VALIDATE("Debit Amount", Amount1);
                                    Evaluate(GenJournalLine."Fund Type", FundType);
                                    GenJournalLine.Validate("Fund Type");
                                    //GenJournalLine.VALIDATE("Roster Entry No.", CurrentRec."Entry No");
                                    GenJournalLine."Payment By Financial Aid" := true;
                                    IF Semester <> '' then
                                        GenJournalLine.Semester := Semester
                                    Else
                                        GenJournalLine.Semester := StudentMaster.Semester;
                                    IF AcademicYear <> '' then
                                        GenJournalLine."Academic Year" := AcademicYear
                                    Else
                                        GenJournalLine."Academic Year" := StudentMaster."Academic Year";
                                    GenJournalLine.Course := StudentMaster."Course Code";
                                    GenJournalLine."Enrollment No." := StudentMaster."Enrollment No.";
                                    GenJournalLine.Year := StudentMaster.Year;
                                    If VarTerm <> VarTerm::" " then begin
                                        IF VarTerm = VarTerm::FALL then
                                            GenJournalLine.Term := GenJournalLine.Term::FALL;
                                        If VarTerm = VarTerm::SPRING then
                                            GenJournalLine.Term := GenJournalLine.Term::SPRING;
                                        If VarTerm = VarTerm::SUMMER then
                                            GenJournalLine.Term := GenJournalLine.Term::SUMMER;
                                    end Else
                                        GenJournalLine.Term := StudentMaster.Term;

                                    //CSPL-00307
                                    GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
                                    GenJournalLine.Validate("Bal. Account No.", StudentMaster."Original Student No.");
                                    IF Description <> '' Then
                                        GenJournalLine.Description := Description;
                                    //CSPL-00307
                                    Evaluate(GenJournalLine."Applies-to Doc. Type", AppliestoDocType);
                                    GenJournalLine.Validate("Applies-to Doc. Type");
                                    GenJournalLine.Validate("Applies-to Doc. No.", AppliestoDocNo);
                                    GenJournalLine.INSERT();

                                end;
                            end;
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
        Flag := TRUE;
        EntryNo := 0;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('FA Roster Upload Sucessfully !');
    end;

    var
        FinancialAidRoster: Record "Financial Aid Roster";
        FinancialAidRoster1: Record "Financial Aid Roster";
        StudentMaster: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        GenJournalLine1: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        FeeSetupCS: Record "Fee Setup-CS";
        GenJournalBatch: Record "Gen. Journal Batch";

        NoSeries: Codeunit NoSeriesManagement;
        Flag: Boolean;
        InstCode: Code[20];
        Amount1: Decimal;
        EntryNo: Integer;

        VarTerm: Option " ",FALL,SPRING,SUMMER;
        TempDocNo: Code[20];
        LineNo: Integer;

}

