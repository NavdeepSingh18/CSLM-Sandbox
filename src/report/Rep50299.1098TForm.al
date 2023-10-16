report 50299 "1098-T Form"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                TotalBox1 := 0;
                TotalBox5 := 0;
                EntryCount := 0;
                Box9Count := 0;
                Box10Count := 0;
                FileName := '';
                FileName := '1098-T Statement Data ' + Format(YearSelection) + '.txt';
                Clear(TempBlob_gCU);
                TempBlob_gCU.CreateOutStream(OStream, TextEncoding::Windows);
                OStream.WriteText('Record Type|Tax Year|Client Code|Account Number|Account ID|First Name|Middle Name|Last Name|Address1|Address2|City|State|Zip Code|Country|Box 1|Box 4|Box 5|Box 6 |Box 7|Box 8|Box 9|Box 10|IRS SSN Compliance');

            end;

            trigger OnAfterGetRecord()
            var
                StudentMaster_lRec: Record "Student Master-CS";
                GLEntry_lRec: Record "G/L Entry";
                CustomerLedgerEntry_lRec: Record "Cust. Ledger Entry";
                StudentLegacyLedger_lRec: Record "Student Legacy Ledger";
                FlaggedAmt: Decimal;
                PaymentAmt: Decimal;
                ScholarShipAmt: Decimal;
                EnrollmentFilter: Text;
                Box9: Text;
                IRS: Text;


            begin
                EnrollmentFilter := '';
                StudentMaster_lRec.Reset();
                StudentMaster_lRec.SetRange("Original Student No.", Customer."No.");
                IF StudentMaster_lRec.FindSet(true) then begin
                    repeat
                        If EnrollmentFilter = '' then
                            EnrollmentFilter := StudentMaster_lRec."Enrollment No."
                        Else
                            EnrollmentFilter += '|' + StudentMaster_lRec."Enrollment No.";
                    until StudentMaster_lRec.Next() = 0;
                end;
                FlaggedAmt := 0;
                PaymentAmt := 0;
                ScholarShipAmt := 0;
                StudentMaster_lRec.Reset();
                StudentMaster_lRec.SetRange("Enrollment No.", Customer."Enrollment No.");
                //StudentMaster_lRec.Setfilter(Citizenship, '%1|%2', StudentMaster_lRec.Citizenship::"Eligible Non Citizen", StudentMaster_lRec.Citizenship::"US Citizen");
                IF StudentMaster_lRec.FindFirst() then begin

                    StudentLegacyLedger_lRec.Reset();
                    StudentLegacyLedger_lRec.SetRange("Student Number", Customer."No.");
                    StudentLegacyLedger_lRec.SetRange(Date, StartDate, EndDate);
                    StudentLegacyLedger_lRec.SetRange("1098-T Form", true);
                    StudentLegacyLedger_lRec.CalcSums(Amount);
                    FlaggedAmt := (StudentLegacyLedger_lRec.Amount);

                    CustomerLedgerEntry_lRec.Reset();
                    CustomerLedgerEntry_lRec.SetRange("Customer No.", Customer."No.");
                    CustomerLedgerEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    CustomerLedgerEntry_lRec.SetRange(Reversed, false);
                    CustomerLedgerEntry_lRec.SetFilter("Document Type", '%1|%2', CustomerLedgerEntry_lRec."Document Type"::"Credit Memo", CustomerLedgerEntry_lRec."Document Type"::Invoice);
                    CustomerLedgerEntry_lRec.SetFilter("Document No.", '<>%1', 'OPNG*');
                    IF CustomerLedgerEntry_lRec.FindSet(true) then begin
                        repeat
                            CustomerLedgerEntry_lRec.CalcFields(Amount);
                            GLEntry_lRec.Reset();
                            GLEntry_lRec.SetRange("Document No.", CustomerLedgerEntry_lRec."Document No.");
                            GLEntry_lRec.SetFilter("Enrollment No.", EnrollmentFilter);
                            GLEntry_lRec.SetRange("1098-T From", true);
                            GLEntry_lRec.SetFilter(Amount, '<>%1', CustomerLedgerEntry_lRec.Amount);
                            IF GLEntry_lRec.FindSet() then
                                Repeat
                                    FlaggedAmt += -1 * GLEntry_lRec.Amount;
                                until GLEntry_lRec.Next() = 0;

                        until CustomerLedgerEntry_lRec.Next() = 0;
                    end;


                    StudentLegacyLedger_lRec.Reset();
                    StudentLegacyLedger_lRec.SetRange("Student Number", Customer."No.");
                    StudentLegacyLedger_lRec.SetRange(Date, StartDate, EndDate);
                    //StudentLegacyLedger_lRec.SetRange("1098-T Form", true);
                    StudentLegacyLedger_lRec.SetRange("Document Type", StudentLegacyLedger_lRec."Document Type"::Payment);
                    StudentLegacyLedger_lRec.SetRange("Global Dimension 2 Code", '');
                    StudentLegacyLedger_lRec.CalcSums(Amount);
                    PaymentAmt := (StudentLegacyLedger_lRec.Amount);

                    StudentLegacyLedger_lRec.Reset();
                    StudentLegacyLedger_lRec.SetRange("Student Number", Customer."No.");
                    StudentLegacyLedger_lRec.SetRange(Date, StartDate, EndDate);
                    //StudentLegacyLedger_lRec.SetRange("1098-T Form", true);
                    StudentLegacyLedger_lRec.SetRange("Document Type", StudentLegacyLedger_lRec."Document Type"::Refund);
                    //StudentLegacyLedger_lRec.SetRange("Global Dimension 2 Code", '');
                    StudentLegacyLedger_lRec.CalcSums(Amount);
                    PaymentAmt += (StudentLegacyLedger_lRec.Amount);

                    CustomerLedgerEntry_lRec.Reset();
                    CustomerLedgerEntry_lRec.SetCurrentKey("Customer No.", "Posting Date");
                    CustomerLedgerEntry_lRec.SetRange("Customer No.", Customer."No.");
                    CustomerLedgerEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    CustomerLedgerEntry_lRec.Setrange("Document Type", CustomerLedgerEntry_lRec."Document Type"::Payment);
                    CustomerLedgerEntry_lRec.SetRange("Global Dimension 2 Code", '');
                    CustomerLedgerEntry_lRec.SetRange(Reversed, false);
                    CustomerLedgerEntry_lRec.SetFilter("Document No.", '<>%1', 'OPNG*');
                    IF CustomerLedgerEntry_lRec.FindSet(true) then begin
                        repeat
                            CustomerLedgerEntry_lRec.CalcFields(Amount);
                            PaymentAmt += (CustomerLedgerEntry_lRec.Amount);
                        until CustomerLedgerEntry_lRec.Next() = 0;
                    end;

                    CustomerLedgerEntry_lRec.Reset();
                    CustomerLedgerEntry_lRec.SetCurrentKey("Customer No.", "Posting Date");
                    CustomerLedgerEntry_lRec.SetRange("Customer No.", Customer."No.");
                    CustomerLedgerEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    CustomerLedgerEntry_lRec.SetRange("Document Type", CustomerLedgerEntry_lRec."Document Type"::Refund);
                    //CustomerLedgerEntry_lRec.SetRange("Global Dimension 2 Code", '');
                    CustomerLedgerEntry_lRec.SetRange(Reversed, false);
                    CustomerLedgerEntry_lRec.SetFilter("Document No.", '<>%1', 'OPNG*');
                    IF CustomerLedgerEntry_lRec.FindSet(true) then begin
                        repeat
                            CustomerLedgerEntry_lRec.CalcFields(Amount);
                            PaymentAmt += (CustomerLedgerEntry_lRec.Amount);
                        until CustomerLedgerEntry_lRec.Next() = 0;
                    end;

                    StudentLegacyLedger_lRec.Reset();
                    StudentLegacyLedger_lRec.SetRange("Student Number", Customer."No.");
                    StudentLegacyLedger_lRec.SetRange(Date, StartDate, EndDate);
                    //StudentLegacyLedger_lRec.SetRange("1098-T Form", true);
                    StudentLegacyLedger_lRec.SetFilter(Description, '%1|%2', '*Scholarship*', '*Grant*');
                    StudentLegacyLedger_lRec.CalcSums(Amount);
                    ScholarShipAmt += (StudentLegacyLedger_lRec.Amount);

                    CustomerLedgerEntry_lRec.Reset();
                    CustomerLedgerEntry_lRec.SetCurrentKey("Customer No.", "Posting Date", "Fee Code");
                    CustomerLedgerEntry_lRec.SetRange("Customer No.", Customer."No.");
                    CustomerLedgerEntry_lRec.SetRange("Posting Date", StartDate, EndDate);
                    CustomerLedgerEntry_lRec.SetFilter("Fee Code", '%1|%2', 'SCHLSP-AICASA', 'SCHLSP-AUA');
                    CustomerLedgerEntry_lRec.SetRange(Reversed, false);
                    IF CustomerLedgerEntry_lRec.FindSet(true) then begin
                        repeat
                            CustomerLedgerEntry_lRec.CalcFields(Amount);
                            ScholarShipAmt += (CustomerLedgerEntry_lRec.Amount);
                        until CustomerLedgerEntry_lRec.Next() = 0;
                    end;

                    IF ABS(FlaggedAmt) < ABS(PaymentAmt + ScholarShipAmt) then
                        FlaggedAmt := Round(ABS(FlaggedAmt))
                    Else
                        FlaggedAmt := Round(ABS(PaymentAmt + ScholarShipAmt));

                    IF ABS(FlaggedAmt) = ABS(PaymentAmt + ScholarShipAmt) then
                        FlaggedAmt := Round(ABS(FlaggedAmt));

                    ScholarShipAmt := Round(Abs(ScholarShipAmt));

                    IF FlaggedAmt < 600 then
                        CurrReport.Skip();

                    If StrLen(StudentMaster_lRec."Social Security No.") <> 11 then
                        CurrReport.Skip();

                    EntryCount += 1;

                    TotalBox1 += Round(FlaggedAmt);

                    TotalBox5 += Round(ScholarShipAmt);

                    Box9 := '';
                    If StudentMaster_lRec."Global Dimension 1 Code" = '9000' then
                        Box9 := 'X';

                    IRS := '';

                    IRS := 'X';


                    Box10Count += 1;

                    IF Box9 <> '' then
                        Box9Count += 1;

                    OStream.WriteText();
                    OStream.WriteText('S|' + YearSelection + '|ACHN|' + StudentMaster_lRec."Social Security No." + '|' + Customer."No." + '|' + CopyStr(StudentMaster_lRec."First Name", 1, 40) + '|' + Copystr(StudentMaster_lRec."Middle Name", 1, 40) + '|' + CopyStr(StudentMaster_lRec."Last Name", 1, 40) + '|' + CopyStr(ReduceSpaces(StudentMaster_lRec.Addressee), 1, 40) + '| |' + CopyStr(ReduceSpaces(StudentMaster_lRec.City), 1, 25) + '|' + COPYSTR(StudentMaster_lRec.State, 1, 2) + '|' + CopyStr(StudentMaster_lRec."Post Code", 1, 10) + '|' + CopyStr(ReduceSpaces(StudentMaster_lRec."Country Code"), 1, 30) + '|' + delchr(Format(FlaggedAmt, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>'), '=', ',') + '| |' + delchr(Format(ScholarShipAmt, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>'), '=', ',') + '| | |X|' + Box9 + '| |' + IRS);
                    //CSPL-00307 - Single Change on 30-01-2023 as per Raja Da Address 2 always Blank = '| |'
                end;
            end;

            trigger OnPostDataItem()
            begin
                OStream.WriteText();
                OStream.WriteText('T|' + Format(EntryCount) + '|' + delchr(Format(TotalBox1, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>'), '=', ',') + '| |' + delchr(Format(TotalBox5, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>'), '=', ',') + '| | |' + Format(EntryCount) + '|' + Format(Box9Count) + '| |' + Format(Box10Count));
                TempBlob_gCU.CreateInStream(IStream, TextEncoding::Windows);
                DownloadFromStream(IStream, '', '', '', FileName);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(YearSelection; YearSelection)
                    {
                        ApplicationArea = All;
                        Caption = 'Tax Year';
                        TableRelation = "Academic Year Master-CS";
                        trigger OnValidate()
                        var
                            AcaYear: Record "Academic Year Master-CS";
                        Begin
                            StartDate := 0D;
                            EndDate := 0D;
                            IF YearSelection <> '' then begin
                                AcaYear.Reset();
                                AcaYear.SetRange(Code, YearSelection);
                                IF AcaYear.FindFirst() then begin
                                    StartDate := AcaYear."Start Date";
                                    EndDate := AcaYear."End Date";
                                end;
                            end;
                        End;

                    }
                }
            }
        }

        // actions
        // {
        //     area(processing)
        //     {
        //         action(ActionName)
        //         {
        //             ApplicationArea = All;

        //         }
        //     }
        // }
    }

    var
        TempBlob_gCU: Codeunit "Temp Blob";
        IStream: InStream;
        OStream: OutStream;

        FileName: Text;
        YearSelection: code[20];
        StartDate: Date;
        EndDate: Date;
        TotalBox1: Decimal;
        TotalBox5: Decimal;
        EntryCount: Integer;
        Box9Count: Integer;
        Box10Count: Integer;


    trigger OnPreReport()
    begin
        IF YearSelection = '' then
            Error('Please select Tax Year');
    end;

    procedure ReduceSpaces(InputString: Text) OutputString: Text
    Var
        n: Integer;
        i: Integer;
    Begin
        n := STRLEN(InputString);
        FOR i := 1 TO n DO
            IF (InputString[i] = ' ') AND (i < n) THEN BEGIN
                IF NOT (InputString[i + 1] IN [32 .. 47, 58 .. 63]) THEN //if the next char is special as 'empty space,.,!' etc we do not copy the current space
                    OutputString += FORMAT(InputString[i])
            END ELSE
                OutputString += FORMAT(InputString[i]);

        OutputString := DELCHR(OutputString, '<>', ' ');
    end;
}