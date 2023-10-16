xmlport 50065 "Financial Aid Roster Upload"
{
    Caption = 'Financial Aid Roster Upload';
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
                textelement(StudentNo)
                {
                }

                textelement(Amount)
                {
                }
                textelement(FundType)
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

                trigger OnBeforeInsertRecord()
                begin
                    IF (Flag = TRUE) THEN
                        Flag := FALSE
                    ELSE BEGIN
                        IF (StudentNo <> '') AND (Amount <> '') THEN BEGIN


                            // StudentMaster.Reset();
                            // StudentMaster.SetRange("Enrollment No.", StudentNo);
                            // StudentMaster.SetRange("Type of FA Roster", StudentMaster."Type of FA Roster"::SFP);
                            // If StudentMaster.FindFirst() then
                            //     Error('Type of FA Roster value must not be equal is SFP for student No. %1', StudentNo);

                            FinancialAidRoster1.Reset();
                            If FinancialAidRoster1.FindLast() Then
                                EntryNo := FinancialAidRoster1."Entry No" + 1;

                            FinancialAidRoster.RESET();
                            FinancialAidRoster.INIT();
                            FinancialAidRoster."Entry No" := EntryNo;
                            FinancialAidRoster."Date" := Today();

                            FeeSetup.Reset();
                            FeeSetup.SetRange("Global Dimension 1 Code", '9000');
                            IF FeeSetup.FindFirst() then
                                FinancialAidRoster."Bank Account No." := FeeSetup."Financial Aid Payment Bank";

                            If FundType = Format(FinancialAidRoster."Fund Type"::"FDSL-Plus") then
                                FinancialAidRoster."Fund Type" := FinancialAidRoster."Fund Type"::"FDSL-Plus";
                            If FundType = Format(FinancialAidRoster."Fund Type"::"FDSL-Unsub") then
                                FinancialAidRoster."Fund Type" := FinancialAidRoster."Fund Type"::"FDSL-Unsub";

                            If AppliestoDocType <> '' then
                                Evaluate(FinancialAidRoster."Applies to Doc. Type", AppliestoDocType);

                            IF AppliestoDocNo <> '' then
                                FinancialAidRoster."Applies to Doc. No." := AppliestoDocNo;
                            Evaluate(Amount1, Amount);
                            FinancialAidRoster."Uploaded Amount" := Amount1;
                            FinancialAidRoster."Approved Amount" := Amount1;

                            StudentMaster.Reset();
                            StudentMaster.SetRange("Enrollment No.", StudentNo);
                            IF StudentMaster.FindFirst() then begin
                                FinancialAidRoster."Student No." := StudentMaster."No.";
                                FinancialAidRoster.Semester := StudentMaster.Semester;
                                FinancialAidRoster."Academic Year" := StudentMaster."Academic Year";
                                FinancialAidRoster.Course := StudentMaster."Course Code";
                                FinancialAidRoster.Year := StudentMaster.Year;
                                FinancialAidRoster."Enrollment No." := StudentMaster."Enrollment No.";
                                FinancialAidRoster."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                                FinancialAidRoster."Global Dimension 2 Code" := StudentMaster."Global Dimension 2 Code";
                                FinancialAidRoster.Term := StudentMaster.Term;
                            end;
                            FinancialAidRoster."User ID" := UserId();
                            FinancialAidRoster.INSERT();
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
        MESSAGE('Financial Aid Roster Upload Sucessfully !');
    end;

    var
        FinancialAidRoster: Record "Financial Aid Roster";
        FinancialAidRoster1: Record "Financial Aid Roster";
        StudentMaster: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        FeeSetup: Record "Fee Setup-CS";
        Flag: Boolean;
        InstCode: Code[20];
        Amount1: Decimal;
        EntryNo: Integer;

}

