report 50197 "SAFI Financial Entries Export"
{
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(ascending);
            dataitem("Student Legacy Ledger"; "Student Legacy Ledger")
            {
                DataItemLink = "Student Number" = field("No.");
                DataItemTableView = sorting("Student Number") order(ascending) where(Type = filter(Invoice | "Credit Memo" | Charge | "Debit Memo"), "Bill Code" = filter('BAS1|BAS2|BAS3|BAS4|BAS5|CLN5|CLN6|CLN7|CLN8|GMDSC|PREMED'));
                PrintOnlyIfDetail = true;
                trigger OnPreDataItem()
                begin
                    //SetRange(Date, 0D, AsonDate);
                    Setrange(Date, FromDate, AsonDate);
                    if InstituteCode <> '' then
                        SetFilter("Global Dimension 1 Code", '%1', InstituteCode);

                    if DepartmentCode <> '' then
                        SetFilter("Global Dimension 2 Code", '%1', DepartmentCode);

                end;

                trigger OnAfterGetRecord()
                Var
                    FeeComponentMaster: Record "Fee Component Master-CS";
                begin
                    // FeeComponentMaster.Reset();
                    // FeeComponentMaster.SetRange(Code, "Student Legacy Ledger"."Bill Code");
                    // FeeComponentMaster.SetRange("G/L Account", '3000010');
                    // IF Not FeeComponentMaster.FindFirst() then
                    //     CurrReport.Skip();

                    FaEligible := '';
                    studentmaster.Reset();
                    studentmaster.setrange("Enrollment No.", Enrollment);
                    if studentmaster.FindFirst() then begin
                        if studentmaster."Financial Aid Approved" then
                            FaEligible := 'TRUE'
                        else
                            FaEligible := 'TRUE';
                    end;

                    // ExcelBuffer.NewRow();
                    // ExcelBuffer.AddColumn("Student Number", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Format("Entry No."), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Date, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Amount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn(0, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn(FaEligible, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('Actual', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                end;

                trigger OnPostDataItem()
                begin

                end;
            }
            dataitem("G/L Entry"; "G/L Entry")
            {

                DataItemTableView = where("Document Type" = filter("Credit Memo" | Invoice),
                                        "Waiver/Scholar/Grant Desc" = filter(''), "Document No." = filter('<>OPNG*'), Reversed = const(false), "G/L Account No." = filter('3000010'));
                PrintOnlyIfDetail = true;
                trigger OnPreDataItem()
                begin
                    //SetRange("Posting Date", 0D, AsonDate);
                    SetFilter("Enrollment No.", EnrollmentNoFilter);
                    Setrange("Posting Date", FromDate, AsonDate);
                    if InstituteCode <> '' then
                        SetFilter("Global Dimension 1 Code", '%1', InstituteCode);

                    if DepartmentCode <> '' then
                        SetFilter("Global Dimension 2 Code", '%1', DepartmentCode);
                end;

                trigger OnAfterGetRecord()
                begin
                    FaEligible := '';
                    studentmaster.Reset();
                    studentmaster.setrange("Enrollment No.", "Enrollment No.");
                    if studentmaster.FindFirst() then begin
                        if studentmaster."Financial Aid Approved" then
                            FaEligible := 'TRUE'
                        else
                            FaEligible := 'TRUE';
                    end;
                    if Amount > 0 then
                        Amountformat := (Amount * -1)
                    else
                        if Amount < 0 then
                            Amountformat := (Amount * -1);

                    // ExcelBuffer.NewRow();
                    // ExcelBuffer.AddColumn(Customer."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Format("Entry No."), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn("Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Amountformat, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn(0, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn(FaEligible, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('Actual', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                end;

                trigger OnPostDataItem()
                begin

                end;
            }

            trigger OnPreDataItem()
            begin
                headerprinted := false;
                //ExcelBuffer.reset();
                //ExcelBuffer.DELETEALL();
                if not (Customercode = '') then
                    SetFilter("No.", customercode);

            end;

            trigger OnAfterGetRecord()

            begin
                EnrollmentNoFilter := '';
                studentmaster.Reset();
                studentmaster.SetRange("Original Student No.", Customer."No.");
                If studentmaster.FindSet() then begin
                    repeat
                        IF studentmaster."Enrollment No." <> '' then begin
                            If EnrollmentNoFilter = '' then
                                EnrollmentNoFilter := studentmaster."Enrollment No."
                            Else
                                EnrollmentNoFilter += '|' + studentmaster."Enrollment No.";
                        end;
                    until studentmaster.Next() = 0;
                end;
                IF EnrollmentNoFilter = '' then
                    CurrReport.Skip();
                counter += 1;
                totalcount := Customer.Count;
                progresswindow.Update(2, Customer."No.");
                progresswindow.update(3, ROUND(counter / totalcount * 10000, 1));
                if not headerprinted then begin
                    MakeExcelDataHeader();
                    headerprinted := true;
                end;
            end;

            trigger OnPostDataItem()
            begin
                // ExcelBuffer.AddSheet('', 'ChargeElement');
            end;
        }
        dataitem(Customer2; Customer)
        {
            DataItemTableView = sorting("No.") order(ascending);
            dataitem("Student Legacy Ledger2"; "Student Legacy Ledger")
            {
                DataItemLink = "Student Number" = field("No.");
                DataItemTableView = sorting("Student Number") order(ascending) where(Type = filter(Invoice | "Credit Memo" | Charge | "Debit Memo"), "Bill Code" = filter('WS-AICAS|WS-AUA'));
                PrintOnlyIfDetail = true;
                trigger OnPreDataItem()
                begin
                    //SetRange(Date, 0D, AsonDate);
                    Setrange(Date, FromDate, AsonDate);
                    if InstituteCode <> '' then
                        SetFilter("Global Dimension 1 Code", '%1', InstituteCode);

                    if DepartmentCode <> '' then
                        SetFilter("Global Dimension 2 Code", '%1', DepartmentCode);

                end;

                trigger OnAfterGetRecord()
                begin

                    // ExcelBuffer.NewRow();
                    // ExcelBuffer.AddColumn("Student Number", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Format("Entry No."), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('SIS Financial System', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Amount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn(Date, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('Actual', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn("Bill Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                end;

                trigger OnPostDataItem()
                begin

                end;
            }
            dataitem("G/L Entry2"; "G/L Entry")
            {

                DataItemTableView = where("Document Type" = filter("Credit Memo" | Invoice),
                                        "Waiver/Scholar/Grant Desc" = filter(<> ''), "Document No." = filter('<>OPNG*'), Reversed = const(false), "G/L Account No." = filter('<>1310004'));
                PrintOnlyIfDetail = true;
                trigger OnPreDataItem()
                begin
                    //SetRange("Posting Date", 0D, AsonDate);
                    Setrange("Posting Date", FromDate, AsonDate);
                    SetFilter("Enrollment No.", EnrollmentNoFilter);

                    if InstituteCode <> '' then
                        SetFilter("Global Dimension 1 Code", '%1', InstituteCode);

                    if DepartmentCode <> '' then
                        SetFilter("Global Dimension 2 Code", '%1', DepartmentCode);
                end;

                trigger OnAfterGetRecord()
                begin

                    if Amount > 0 then
                        Amountformat := (Amount * -1)
                    else
                        if Amount < 0 then
                            Amountformat := (Amount * -1);

                    // ExcelBuffer.NewRow();
                    // ExcelBuffer.AddColumn(Customer2."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Format("Entry No."), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('SIS Financial System', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn(Amountformat, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    // ExcelBuffer.AddColumn("Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn('Actual', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    // ExcelBuffer.AddColumn("Waiver/Scholar/Grant Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                end;

                trigger OnPostDataItem()
                begin

                end;
            }
            trigger OnPreDataItem()
            begin
                headerprinted := false;
                //ExcelBuffer.reset();
                //ExcelBuffer.DELETEALL();
                if not (customercode = '') then
                    SetFilter("No.", customercode);
            end;

            trigger OnAfterGetRecord()
            begin
                EnrollmentNoFilter := '';
                studentmaster.Reset();
                studentmaster.SetRange("Original Student No.", Customer2."No.");
                If studentmaster.FindSet() then begin
                    repeat
                        IF studentmaster."Enrollment No." <> '' then begin
                            If EnrollmentNoFilter = '' then
                                EnrollmentNoFilter := studentmaster."Enrollment No."
                            Else
                                EnrollmentNoFilter += '|' + studentmaster."Enrollment No.";
                        end;
                    until studentmaster.Next() = 0;
                end;
                IF EnrollmentNoFilter = '' then
                    CurrReport.Skip();
                if not headerprinted then begin
                    counter += 1;
                    totalcount := Customer.Count;
                    progresswindow.Update(2, Customer."No.");
                    progresswindow.update(3, ROUND(counter / totalcount * 10000, 1));
                    MakeExcelDataHeader2();
                    headerprinted := true;
                end;
            end;

            trigger OnPostDataItem()
            begin
                // ExcelBuffer.AddSheet('', 'StudentResources');
            end;
        }

    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                group(UserInput)
                {
                    Field(FromDate; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                    }
                    field(AsonDate; AsonDate)
                    {
                        Caption = 'As on Date';
                        ApplicationArea = all;
                    }

                    field(customercode; customercode)
                    {
                        ApplicationArea = all;
                        Caption = 'Customer No.';
                        TableRelation = Customer."No.";
                    }
                    field(InstituteCode; InstituteCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Institute Code';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            DimensionValue: record "Dimension Value";
                            GLSetup: Record "General Ledger Setup";
                        begin
                            GLSetup.get();
                            DimensionValue.Reset();
                            DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                            if page.RunModal(Page::"Dimension Value List", DimensionValue) = Action::LookupOK then begin
                                InstituteCode := DimensionValue.code;
                            end;
                        end;
                    }
                    field(DepartmentCode; DepartmentCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Department Code';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            DimensionValue: record "Dimension Value";
                            GLSetup: Record "General Ledger Setup";
                        begin
                            GLSetup.get();
                            DimensionValue.Reset();
                            DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                            if page.RunModal(Page::"Dimension Value List", DimensionValue) = Action::LookupOK then begin
                                DepartmentCode := DimensionValue.code;
                            end;
                        end;
                    }
                }
            }

        }

        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        AsonDate: Date;
        ExcelBuffer: Record "Excel Buffer Test" Temporary;
        excelbuffernew: Record "Excel Buffer";
        studentmaster: record "Student Master-CS";
        Amountformat: Decimal;
        i: Integer;
        j: Integer;
        headerprinted: Boolean;
        customercode: text;
        FaEligible: text;
        DepartmentCode: text;
        InstituteCode: text;
        FromDate: Date;
        progresswindow: Dialog;
        counter: Integer;
        EnrollmentNoFilter: Text;
        totalcount: Integer;
        progesslabel: Label 'Customer No......#2#######\';
        progesslabel2: Label 'Processing Data.....@3@@@@@@@';




    trigger OnInitReport()
    begin
        AsonDate := Today;
        FromDate := 20210320D;
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.reset();
        ExcelBuffer.DeleteAll;
        if GuiAllowed then
            progresswindow.open(
                '#1#################################\\' +
                progesslabel +
                progesslabel2);

    end;

    trigger OnPostReport()
    begin
        if GuiAllowed then
            progresswindow.Close();
        CreateExcelbook();
    end;

    procedure CreateExcelbook()
    begin
        // ExcelBuffer.CloseBook();
        // ExcelBuffer.OpenExcel();
    end;

    procedure MakeExcelDataHeader()
    begin
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn('StuNum', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('ExternalChargeId', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('ChargeType', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Open Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('FaEligibleIndicator', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('R2T4OnlyIndicator', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataHeader2()
    begin
        // ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn('StuNum', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('ExternalChargeId', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Source', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('FunCode', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('LedgerPostingDate', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Status', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('SaBillCode', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;



}
