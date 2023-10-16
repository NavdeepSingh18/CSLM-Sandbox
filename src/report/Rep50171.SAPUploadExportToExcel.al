report 50171 "SAP-UploadExportToExcel"
{
    Caption = 'SAP-Upload Export To Excel';
    UsageCategory = None;
    ProcessingOnly = true;
    //ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entries Date WiseAUA"; "G/L Entries Date Wise")
        {
            DataItemTableView = sorting("SAP Code") where("SAP Code" = filter(<> ''),
             "Document Type" = filter(Invoice | "Credit Memo"),
             "Global Dimension 1 Code" = filter(9000),
             "Global Dimension 2 Code" = filter(''),
              Reversed = filter(false));
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                i := 1;
                k := 0;
                DebitTotal := 0;
                CreditTotal := 0;
                SapCode := '';
                ExcelBuffer.DELETEALL();

            end;

            trigger OnAfterGetRecord()
            begin
                FeeSetup.Reset();
                FeeSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                FeeSetup.FindFirst();
                IF SapCode <> "SAP Code" then begin
                    TotalAmt := 0;
                    GLEntriesDateWise.Reset();
                    GLEntriesDateWise.SetRange("SAP Code", "SAP Code");
                    GLEntriesDateWise.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF GLEntriesDateWise.FindSet() then
                        repeat
                            TotalAmt += GLEntriesDateWise.Amount;
                        Until GLEntriesDateWise.Next() = 0;

                    IF TotalAmt > 0 then
                        DebitTotal := DebitTotal + TotalAmt;
                    IF TotalAmt < 0 then
                        CreditTotal := CreditTotal + (-1 * TotalAmt);

                    SapCode := "SAP Code";
                end Else begin
                    CurrReport.Skip();
                end;

                // If i = 1 Then begin
                //     k := MakeExcelDataHeader(i, "G/L Entries Date WiseAUA", "G/L Entries Date WiseAUA"."Global Dimension 1 Code");
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date WiseAUA");
                // end Else begin
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date WiseAUA");
                // end;

                i += 1;
            end;

            trigger OnPostDataItem()
            begin
                // IF "G/L Entries Date WiseAUA".Count() <> 0 Then
                //     MakeExcelInfoTotal(k + i, 1, "G/L Entries Date WiseAUA".Narration, "G/L Entries Date WiseAUA".EndDate, 'AR-9000', FeeSetup."SAP Bus. Area", FeeSetup."SAP Profit Centre");
            end;
        }

        dataitem("G/L Entries Date WiseAICASA"; "G/L Entries Date Wise")
        {
            DataItemTableView = sorting("SAP Code") where("SAP Code" = filter(<> ''),
             "Document Type" = filter(Invoice | "Credit Memo"),
             "Global Dimension 1 Code" = filter(9100),
             "Global Dimension 2 Code" = filter(''),
              Reversed = filter(false));
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                i := 1;
                k := 0;
                DebitTotal := 0;
                CreditTotal := 0;
                SapCode := '';
                ExcelBuffer.DELETEALL();

            end;

            trigger OnAfterGetRecord()
            begin
                FeeSetup.Reset();
                FeeSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                FeeSetup.FindFirst();
                IF SapCode <> "SAP Code" then begin
                    TotalAmt := 0;
                    GLEntriesDateWise.Reset();
                    GLEntriesDateWise.SetRange("SAP Code", "SAP Code");
                    GLEntriesDateWise.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF GLEntriesDateWise.FindSet() then
                        repeat
                            TotalAmt += GLEntriesDateWise.Amount;
                        Until GLEntriesDateWise.Next() = 0;

                    IF TotalAmt > 0 then
                        DebitTotal := DebitTotal + TotalAmt;
                    IF TotalAmt < 0 then
                        CreditTotal := CreditTotal + (-1 * TotalAmt);

                    SapCode := "SAP Code";
                end Else begin
                    CurrReport.Skip();
                end;

                // If i = 1 Then begin
                //     k := MakeExcelDataHeader(i, "G/L Entries Date WiseAICASA", "G/L Entries Date WiseAICASA"."Global Dimension 1 Code");
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date WiseAICASA");
                // end Else begin
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date WiseAICASA");
                // end;

                i += 1;
            end;

            trigger OnPostDataItem()
            begin
            //     IF "G/L Entries Date WiseAICASA".Count() <> 0 Then
            //         MakeExcelInfoTotal(k + i, 1, "G/L Entries Date WiseAICASA".Narration, "G/L Entries Date WiseAICASA".EndDate, 'AR-9100', FeeSetup."SAP Bus. Area", FeeSetup."SAP Profit Centre");
             end;
        }
        dataitem("G/L Entries Date Wise9300"; "G/L Entries Date Wise")
        {
            DataItemTableView = sorting("SAP Code") where("SAP Code" = filter(<> ''),
             "Document Type" = filter(Invoice | "Credit Memo"),
             "Global Dimension 2 Code" = filter(9300),
              Reversed = filter(false));
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                i := 1;
                k := 0;
                DebitTotal := 0;
                CreditTotal := 0;
                SapCode := '';
                ExcelBuffer.DELETEALL();

            end;

            trigger OnAfterGetRecord()
            begin
                IF SapCode <> "SAP Code" then begin
                    TotalAmt := 0;
                    GLEntriesDateWise.Reset();
                    GLEntriesDateWise.SetRange("SAP Code", "SAP Code");
                    GLEntriesDateWise.SetRange("Global Dimension 2 Code", "Global Dimension 2 Code");
                    IF GLEntriesDateWise.FindSet() then
                        repeat
                            TotalAmt += GLEntriesDateWise.Amount;
                        Until GLEntriesDateWise.Next() = 0;

                    IF TotalAmt > 0 then
                        DebitTotal := DebitTotal + TotalAmt;
                    IF TotalAmt < 0 then
                        CreditTotal := CreditTotal + (-1 * TotalAmt);

                    SapCode := "SAP Code";
                end Else begin
                    CurrReport.Skip();
                end;

                // If i = 1 Then begin
                //     k := MakeExcelDataHeader(i, "G/L Entries Date Wise9300", "G/L Entries Date Wise9300"."Global Dimension 2 Code");
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date Wise9300");
                // end Else begin
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date Wise9300");
                // end;

                i += 1;
            end;

            trigger OnPostDataItem()
            begin
                // IF "G/L Entries Date Wise9300".Count() <> 0 Then
                //     MakeExcelInfoTotal(k + i, 1, "G/L Entries Date Wise9300".Narration, "G/L Entries Date Wise9300".EndDate, 'AR-9300', "G/L Entries Date Wise9300"."SAP Bus. Area", "G/L Entries Date Wise9300"."SAP Profit Centre");

            end;
        }

        dataitem("G/L Entries Date Wise9500"; "G/L Entries Date Wise")
        {
            DataItemTableView = sorting("SAP Code") where("SAP Code" = filter(<> ''),
             "Document Type" = filter(Invoice | "Credit Memo"),
             "Global Dimension 2 Code" = filter(9500),
              Reversed = filter(false));
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                i := 1;
                k := 0;
                DebitTotal := 0;
                CreditTotal := 0;
                SapCode := '';
                ExcelBuffer.DELETEALL();

            end;

            trigger OnAfterGetRecord()
            begin
                IF SapCode <> "SAP Code" then begin
                    TotalAmt := 0;
                    GLEntriesDateWise.Reset();
                    GLEntriesDateWise.SetRange("SAP Code", "SAP Code");
                    GLEntriesDateWise.SetRange("Global Dimension 2 Code", "Global Dimension 2 Code");
                    IF GLEntriesDateWise.FindSet() then
                        repeat
                            TotalAmt += GLEntriesDateWise.Amount;
                        Until GLEntriesDateWise.Next() = 0;

                    IF TotalAmt > 0 then
                        DebitTotal := DebitTotal + TotalAmt;
                    IF TotalAmt < 0 then
                        CreditTotal := CreditTotal + (-1 * TotalAmt);

                    SapCode := "SAP Code";
                end Else begin
                    CurrReport.Skip();
                end;

                // If i = 1 Then begin
                //     k := MakeExcelDataHeader(i, "G/L Entries Date Wise9500", "G/L Entries Date Wise9500"."Global Dimension 2 Code");
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date Wise9500");
                // end Else begin
                //     MakeExcelInfo(k + i, 1, "G/L Entries Date Wise9500");
                // end;

                i += 1;
            end;

            trigger OnPostDataItem()
            begin
                // IF "G/L Entries Date Wise9500".Count() <> 0 Then
                //     MakeExcelInfoTotal(k + i, 1, "G/L Entries Date Wise9500".Narration, "G/L Entries Date Wise9500".EndDate, 'AR-9500', "G/L Entries Date Wise9500"."SAP Bus. Area", "G/L Entries Date Wise9500"."SAP Profit Centre");

            end;
        }
        dataitem("G/L Entries Date WiseBank"; "G/L Entries Date Wise")
        {
            DataItemTableView = sorting("SAP G/L Account") where("SAP G/L Account" = filter(<> ''),
             "Document Type" = filter(Payment | Refund),
              Reversed = filter(false));
            PrintOnlyIfDetail = true;

            trigger OnPreDataItem()
            begin
                DebitTotal := 0;
                CreditTotal := 0;
                TotalAmt := 0;
                SapCode := '';
                ExcelBuffer.DELETEALL();
                BusArea := '';
                ProfitCentre := '';
            end;

            trigger OnAfterGetRecord()
            begin
                customerNo := '';
                customername := '';
                customerRec.reset();
                customerRec.SetRange("Enrollment No.", "Enrollment No.");
                if customerRec.FindFirst() then begin
                    customerNo := customerRec."Original Student No.";
                    customername := customerRec."First Name" + ' ' + customerRec."Last Name";
                end else begin
                    customerNo := '';
                    customername := '';
                end;

                IF SapCode <> "SAP G/L Account" then begin
                    IF SapCode <> '' then begin
                        // MakeExcelInfoTotal(k + i, 1, BankNarration, "G/L Entries Date WiseBank".EndDate, SapCode, BusArea, ProfitCentre);
                        DebitTotal := 0;
                        CreditTotal := 0;
                        BankNarration := '';
                        BusArea := '';
                        ProfitCentre := '';
                    end;

                    i := 1;
                    k := 0;
                    TotalAmt := 0;
                    TotalAmt := "G/L Entries Date WiseBank".Amount;
                    BankAccount.Reset();
                    BankAccount.SetRange("SAP G/L Account", "SAP G/L Account");
                    BankAccount.FindFirst();
                    // k := MakeExcelDataHeader(i, "G/L Entries Date WiseBank", BankAccount."SAP Company Code");
                    // MakeExcelInfo(k + i, 1, "G/L Entries Date WiseBank");
                end Else begin
                    TotalAmt := 0;
                    TotalAmt := "G/L Entries Date WiseBank".Amount;
                    // MakeExcelInfo(k + i, 1, "G/L Entries Date WiseBank");
                end;

                IF TotalAmt > 0 then
                    DebitTotal := DebitTotal + TotalAmt;
                IF TotalAmt < 0 then
                    CreditTotal := CreditTotal + (-1 * TotalAmt);

                BankNarration := "G/L Entries Date WiseBank".Narration;
                BusArea := "G/L Entries Date WiseBank"."SAP Bus. Area";
                ProfitCentre := "G/L Entries Date WiseBank"."SAP Profit Centre";
                SapCode := "SAP G/L Account";
                i += 1;
            end;

            trigger OnPostDataItem()
            begin
                // IF "G/L Entries Date WiseBank".Count() <> 0 Then
                //     MakeExcelInfoTotal(k + i, 1, BankNarration, "G/L Entries Date WiseBank".EndDate, SapCode, BusArea, ProfitCentre);
            end;
        }

    }

    trigger OnPostReport()
    Begin
        // CreateExcelbook();
    End;

    var
        ExcelBuffer: Record "Excel Buffer Test";
        ExcelBuff: Record "Excel Buffer Test";
        GLEntriesDateWise: Record "G/L Entries Date Wise";
        FeeSetup: Record "Fee Setup-CS";
        BankAccount: Record "Bank Account";

        customerRec: Record "Student Master-CS";

        RowNo: Integer;
        ColumNo: Integer;
        SapCode: Code[20];
        customerNo: Code[20];
        TotalAmt: Decimal;
        DebitTotal: Decimal;
        CreditTotal: Decimal;
        i: Integer;
        k: Integer;
        BankNarration: Text[100];
        customername: Text;
        BusArea: Code[20];
        ProfitCentre: Code[20];


    // procedure MakeExcelDataHeader(j: Integer; GLEntriesDateWise: Record "G/L Entries Date Wise"; CompanyCode: Code[20]): Integer
    // begin
    //     //Header
    //     RowNo := j;
    //     ColumNo := j;
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ColumNo, 'S.No', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Index', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Document Date in Document', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Document Type', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Company Code', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Posting Date in the Document', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Currency Key', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Document Header Text', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Reference Document Number', TRUE, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Exchange rate', TRUE, FALSE, FALSE);

    //     //Header Value
    //     RowNo := RowNo + j;
    //     ColumNo := j;
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ColumNo, '1', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'H', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, Format(GLEntriesDateWise.EndDate), False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'SA', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, CompanyCode, False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, Format(GLEntriesDateWise.EndDate), False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'USD', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'AR Upload' + ' ' + Format(GLEntriesDateWise.EndDate), False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '2.6882', False, FALSE, FALSE);

    //     //Line 
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Posting key', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Account', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Special G/L Indicator for the Next Line Item', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Amount in document currency', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Amount in Local Currency', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Business Place ', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Section code', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Tax Code', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Business Area', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Profit Center', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Cost Center', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Order Number', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Baseline Date for Due Date Calculation', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Assignment Number', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Item Text', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Number of the Invoice the Transaction Belongs to', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Value date', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Payment terms', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Reference Key-1', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Reference Key-2', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'Reference Key-3', True, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'New Comp. Code', True, FALSE, FALSE);
    //     exit(RowNo);

    // end;

    // procedure MakeExcelInfo(j: Integer; l: integer; GLEntriesDateWise: Record "G/L Entries Date Wise")
    // begin

    //     //Header Value
    //     RowNo := j;
    //     ColumNo := l;
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ColumNo, '1', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'L', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);

    //     //Line ValueTotalAmt
    //     IF TotalAmt > 0 Then
    //         ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '40', False, FALSE, FALSE);
    //     IF TotalAmt < 0 Then
    //         ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '50', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, GLEntriesDateWise."SAP G/L Account", False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, Abs(TotalAmt), False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, GLEntriesDateWise."SAP Bus. Area", False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, GLEntriesDateWise."SAP Profit Centre", False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, GLEntriesDateWise."SAP Cost Centre", False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, Format(GLEntriesDateWise.EndDate), False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, GLEntriesDateWise."SAP Assignment Code", False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, customerNo + '-' + customername, False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    // end;

    // procedure MakeExcelInfoTotal(j: Integer; l: integer; Narration: Text[100]; EndDate: Date; SheetName: Text[100]; BusArea: Code[20]; ProfitCentre: Code[20])
    // begin

    //     //Header Value
    //     RowNo := j;
    //     ColumNo := l;
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ColumNo, '1', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, 'L', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);

    //     //Line Value
    //     IF DebitTotal > CreditTotal Then
    //         ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '50', False, FALSE, FALSE);
    //     IF DebitTotal < CreditTotal Then
    //         ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '40', False, FALSE, FALSE);

    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '1310004', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);

    //     IF DebitTotal > CreditTotal Then
    //         ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, (DebitTotal - CreditTotal), False, FALSE, FALSE);
    //     IF DebitTotal < CreditTotal Then
    //         ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, (CreditTotal - DebitTotal), False, FALSE, FALSE);

    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, BusArea, False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, ProfitCentre, False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, Format("EndDate"), False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, Narration, False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.EnterCell(ExcelBuff, RowNo, ExcelBuff."Column No." + 1, '', False, FALSE, FALSE);
    //     ExcelBuffer.AddSheet('', SheetName);
    // end;

    // procedure CreateExcelbook()
    // begin
    //     ExcelBuffer.CloseBook();
    //     ExcelBuffer.OpenExcel();
    // end;


}