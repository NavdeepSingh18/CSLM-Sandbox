
report 50176 "Cheque Print Acc0438"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Check Print Acc0438';
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Cheque Print Acc0438.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            RequestFilterFields = "Document No.";
            column(Document_No_; "Document No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(StudentName; StudentName)
            { }
            column(Amount; ABS(Amount))
            { }
            column(Filter_Caption; GETFILTERS())
            { }
            column(InstituteName; Uppercase(InstituteName))
            { }
            column(CompInfo_Name; CompInfo.Name)
            { }
            column(HeaderText; HeaderText)
            { }
            column(CompInfo_Address; Uppercase(CompInfo.Address))
            { }
            column(CompInfo_Address2; Uppercase(CompInfo."Address 2"))
            { }
            column(CompInfo_City; Uppercase(CompInfo.City))
            { }
            column(State; Uppercase(StateVar))
            { }
            column(CompInfoPostCode; CompInfo."Post Code")
            { }
            column(CompInfo_PhoneNo; CompInfo."Phone No.")
            { }
            column(BottomNamePrint; BottomNamePrint)
            { }
            column(PayToTheOrderOf; PayToTheOrderOf)
            { }
            column(Dollars; Dollars)
            { }
            column(TextSgnature; TextSgnature)
            { }
            column(TextAuthSign; TextAuthSign)
            { }
            column(AmountInWords; AmountInWords)
            { }
            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                IF NOT ("Bank Account No." = 'BANK0002') then
                    error('You can only print cheque for Bank Account No:"BANK0002"');
                RecBankLedger.Reset();
                RecBankLedger.SetRange("Document No.", "Document No.");
                IF RecBankLedger.FindFirst() then
                    IF NOT ((RecBankLedger."Document Type" = "Document Type"::Payment) OR (RecBankLedger."Document Type" = "Document Type"::Refund)) then
                        Error('Document Type must be %1 or %2', "Document Type"::Payment, "Document Type"::Refund);

                InstituteName := '';
                StudentName := '';
                StateVar := '';
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", "SAP Company Code");
                IF EducationSetup.FindFirst() then
                    InstituteName := EducationSetup."Institute Name";

                IF "Enrollment No." <> '' then begin
                    RecStudentMaster.Reset();
                    RecStudentMaster.SetRange("Enrollment No.", "Enrollment No.");
                    IF RecStudentMaster.FindFirst() then
                        StudentName := RecStudentMaster."Student Name";
                end;

                RecPostCode.Reset();
                RecPostCode.SetRange(Code, CompInfo."Post Code");
                IF RecPostCode.FindFirst() then
                    StateVar := RecPostCode.County;
                HeaderText := 'STUDENT REFUND & LOAN REPAYMENT ACCOUNT';
                BottomNamePrint := UpperCASE(InstituteName + '/STUDENT REFUND & LOAN REPAYMENT ACCOUNT');

                InitTextVariable();
                AmountInWords := NumberInWords(Amount, "Currency Code", '');

                PayToTheOrderOf := 'PAY TO THE ORDER OF';
                Dollars := 'DOLLARS';
                TextSgnature := 'TWO SIGNATURES REQUIRED';
                TextAuthSign := 'AUTHORIZED SIGNATURE'
            end;



        }


    }


    trigger OnInitReport()
    begin
        CompInfo.GET();
    end;

    trigger OnPreReport()
    begin

    end;

    var
        CompInfo: Record "Company Information";
        EducationSetup: Record "Education Setup-CS";
        RecStudentMaster: Record "Student Master-CS";
        RecBankLedger: Record "Bank Account Ledger Entry";
        RecPostCode: Record "Post Code";
        InstituteName: Text[500];
        AmountInWords: Text;
        StudentName: Text[100];
        BottomNamePrint: Text[500];
        OnesText: array[20] of Text[90];
        TensText: array[10] of Text[90];
        ThousText: Array[5] of Text[90];

        StateVar: Code[20];
        PayToTheOrderOf: Text;
        Dollars: Text;
        HeaderText: Text;
        TextSgnature: Text;
        TextAuthSign: Text;

    procedure NumberInWords(number: Decimal; CurrencyName: Text[30]; DenomName: Text[30]): Text[300]
    var
        WholePart: Decimal;
        DecimalPart: Decimal;
        WholeInWords: Text;
        DecimalInWords: Text;
    begin
        WholePart := ROUND(ABS(number), 1, '<');
        DecimalPart := ABS((ABS(number) - WholePart) * 100);

        WholeInWords := NumberToWords(WholePart, CurrencyName);

        IF DecimalPart <> 0 THEN BEGIN
            DecimalInWords := NumberToWords(DecimalPart, DenomName);
            WholeInWords := WholeInWords + ' and ' + DecimalInWords;
        END;

        AmountInWords := '****' + WholeInWords + ' Only****';
        EXIT(AmountInWords);
    end;

    procedure NumberToWords(number: Decimal; appendScale: Text[30]): Text[300]
    var
        numString: Text[300];
        pow: Integer;
        powStr: Text[50];
        log: Integer;

    begin
        numString := '';
        IF number < 100 THEN
            IF number < 20 THEN BEGIN
                IF number <> 0 THEN numString := OnesText[number];
            END ELSE BEGIN
                numString := TensText[number DIV 10];
                IF (number MOD 10) > 0 THEN
                    numString := numString + ' ' + OnesText[number MOD 10];
            END
        ELSE BEGIN
            pow := 0;
            powStr := '';
            IF number < 1000 THEN BEGIN // number is between 100 and 1000
                pow := 100;
                powStr := ThousText[1];
            END ELSE BEGIN // find the scale of the number
                log := ROUND(STRLEN(FORMAT(number DIV 1000)) / 3, 1, '>');
                pow := POWER(1000, log);
                powStr := ThousText[log + 1];
            END;

            numString := NumberToWords(number DIV pow, powStr) + ' ' + NumberToWords(number MOD pow, '');
        END;

        EXIT(DELCHR(numString, '<>', ' ') + ' ' + appendScale);

    end;

    procedure InitTextVariable()
    begin

        OnesText[1] := 'One';
        OnesText[2] := 'Two';
        OnesText[3] := 'Three';
        OnesText[4] := 'Four';
        OnesText[5] := 'Five';
        OnesText[6] := 'Six';
        OnesText[7] := 'Seven';
        OnesText[8] := 'Eight';
        OnesText[9] := 'Nine';
        OnesText[10] := 'Ten';
        OnesText[11] := 'Eleven';
        OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen';
        OnesText[14] := 'Fourteen';
        OnesText[15] := 'Fifteen';
        OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen';
        OnesText[18] := 'Eighteen';
        OnesText[19] := 'Nineteen';


        TensText[1] := '';
        TensText[2] := 'Twenty';
        TensText[3] := 'Thirty';
        TensText[4] := 'Forty';
        TensText[5] := 'Fifty';
        TensText[6] := 'Sixty';
        TensText[7] := 'Seventy';
        TensText[8] := 'Eighty';
        TensText[9] := 'Ninety';

        ThousText[1] := 'Hundred';
        ThousText[2] := 'Thousand';
        ThousText[3] := 'Million';
        ThousText[4] := 'Billion';
        ThousText[5] := 'Trillion';
    end;

}