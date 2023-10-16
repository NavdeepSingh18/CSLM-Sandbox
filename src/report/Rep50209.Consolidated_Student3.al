report 50209 "Consolidated Student Ledger"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter";
            DataItemTableView = sorting("No.") order(ascending);

            dataitem("Student Legacy Ledger"; "Student Legacy Ledger")
            {
                DataItemLink = "Student Number" = field("No."), date = field("Date filter"),
                "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting(Date) order(ascending);

                trigger OnPreDataItem()
                begin
                    if Summary then
                        CurrReport.Break();

                    if Detailed then begin
                        if FeeCode <> '' then
                            SetRange("Bill Code", FeeCode);

                        if DocumentType = DocumentType::Invoice then
                            SetRange("Document Type", "Student Legacy Ledger"."Document Type"::Invoice);

                        if DocumentType = DocumentType::Payment then
                            SetRange("Document Type", "Student Legacy Ledger"."Document Type"::Payment);

                        if DocumentType = DocumentType::"Credit Memo" then
                            SetRange("Document Type", "Student Legacy Ledger"."Document Type"::"Credit Memo");

                        if DocumentType = DocumentType::Refund then
                            SetRange("Document Type", "Student Legacy Ledger"."Document Type"::Refund);
                    end;
                    SetFilter("Global Dimension 2 Code", globaldimensionfilter2);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Detailed then begin
                        RunningTotal := "Student Legacy Ledger".Amount + RunningTotal;

                        FromStudentLegacyLedger();
                    end;
                end;
            }

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "posting date" = field("Date filter"),
                "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Posting Date") order(ascending) Where("Document Type" = filter(" " | Invoice | Refund | Payment | "Credit Memo"), "Document No." = filter(<> 'OPNG*'), Reversed = filter(false));
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Document Type" = field("Document Type"),
                                    "Global Dimension 1 Code" = field("Global Dimension 1 code"), "Global Dimension 2 Code" = field("Global Dimension 2 code");
                    CalcFields = "Student No.";
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Enrollment No.", EnrollmentNoFilter);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        studentadjustment := false;

                        if ("Document Type" = "Document Type"::" ") and (("No. Series" = 'STUDENTADJ') or ("No. Series" = 'STUDENTADJ+')) then
                            studentadjustment := true
                        else
                            studentadjustment := false;


                        if (not studentadjustment) then begin
                            glentry.Reset();
                            glentry.SetRange("Document Type", "Document Type");
                            glentry.SetRange("Document No.", "Document No.");
                            glentry.SetRange("Customer No.", "Student No.");
                            if glentry.FindFirst() then begin
                                glentry.CalcFields(Amount);
                                if glentry.Amount = amount then
                                    CurrReport.skip();
                            end;
                        end;

                        if detailed then begin
                            if ("Document Type" = "Document Type"::" ") then begin
                                if (not studentadjustment) then
                                    RunningTotal := (Amount * (-1)) + RunningTotal
                                else
                                    RunningTotal := (Amount * (1)) + RunningTotal;
                                FromCustomerLedgerEntry();
                            end;


                            if "Document Type" in ["Document Type"::Invoice, "Document Type"::Refund] then begin
                                if Amount < 0 then begin
                                    RunningTotal := (Amount * (-1)) + RunningTotal;
                                    FromCustomerLedgerEntry();
                                end else
                                    CurrReport.skip();
                            end;

                            if "Document Type" in ["Document Type"::payment, "Document Type"::"Credit Memo"] then begin
                                if Amount > 0 then begin
                                    RunningTotal := (Amount * (-1)) + RunningTotal;
                                    FromCustomerLedgerEntry();
                                end else
                                    CurrReport.skip();
                            end;
                        end;
                    end;

                    trigger OnPostDataItem()
                    begin

                    end;
                }

                trigger OnPreDataItem()
                begin
                    if Detailed then begin
                        if FeeCode <> '' then
                            setfilter("Fee Code", FeeCode);

                        if DocumentType = DocumentType::Invoice then
                            SetRange("Document Type", "Document Type"::Invoice);

                        if DocumentType = DocumentType::Payment then
                            SetRange("Document Type", "Document Type"::Payment);

                        if DocumentType = DocumentType::"Credit Memo" then
                            SetRange("Document Type", "Document Type"::"Credit Memo");

                        if DocumentType = DocumentType::Refund then
                            SetRange("Document Type", "Document Type"::Refund);
                    end;
                    SetFilter("Global Dimension 2 Code", globaldimensionfilter2);
                end;
            }

            trigger OnPreDataItem()
            begin
                counter := 0;
                totalcount := 0;
                //if Detailed then begin
                //    MakeExcelDataHeader();
                //end;

                if Summary then begin
                    if FeeCode <> '' then
                        Error('You Can not Select Fee Code as Filter for Summary');
                    if DocumentType <> DocumentType::" " then
                        Error('You Can not Select Document Type as Filter for Summary');
                    SummaryHeader();
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                counter += 1;
                totalcount := Customer.Count;

                if "No." = '3000291' then
                    CurrReport.skip();

                EnrollmentNoFilter := '';
                studentmaster.Reset();
                studentmaster.SetRange("Original Student No.", Customer."No.");
                If studentmaster.FindSet() then begin
                    repeat
                        If studentmaster."Enrollment No." <> '' then begin
                            If EnrollmentNoFilter = '' then
                                EnrollmentNoFilter := studentmaster."Enrollment No."
                            Else
                                EnrollmentNoFilter += '|' + studentmaster."Enrollment No.";
                        end;
                    until studentmaster.Next() = 0;

                end;
                progresswindow.Update(2, Customer."No.");
                progresswindow.update(3, ROUND(counter / totalcount * 10000, 1));

                studentmaster.reset();
                studentmaster.setrange("No.", "No.");
                if studentmaster.FindFirst() then;

                if Detailed then begin
                    Clear(RunningTotal);
                    if GetRangeMin("Date Filter") <> 0D then begin
                        StudentLegacyLedger.reset();
                        StudentLegacyLedger.SetRange("Date", 0D, GetRangeMin("Date Filter") - 1);
                        StudentLegacyLedger.SetRange("Student Number", "No.");
                        if globaldimensionfilter1 <> '' then
                            StudentLegacyLedger.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        if globaldimensionfilter2 <> '' then
                            StudentLegacyLedger.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                        if StudentLegacyLedger.Findfirst() then BEGIN
                            StudentLegacyLedger.CalcSums(Amount);
                            RunningTotal := StudentLegacyLedger.Amount;
                        end;

                        glentry.reset();
                        glentry.SetCurrentKey("Posting Date", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", Reversed, "Document No.");//CSPL-00307
                        glentry.setrange("posting Date", 0D, GetRangeMin("Date Filter") - 1);
                        glentry.SetRange("customer No.", "No.");
                        if globaldimensionfilter1 <> '' then
                            glentry.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        if globaldimensionfilter2 <> '' then
                            glentry.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                        glentry.SetRange(Reversed, false);
                        glentry.SetFilter("Document No.", '<>%1', 'OPNG*');
                        if glentry.Findfirst() then BEGIN
                            repeat
                                glentry.CalcFields(Amount);
                                //glentry.CalcSums(Amount);
                                RunningTotal += glentry.Amount;
                            until glentry.Next() = 0;
                        end;
                    end;
                end;

                if Summary then begin
                    Clear(BalanceAsOfDate);
                    Clear(OpeningBal);
                    Clear(CurrentTransTotal);
                    IF GetRangeMin("Date Filter") <> 0D then begin
                        StudentLegacyLedger.reset();
                        StudentLegacyLedger.setfilter("Date", '%1..%2', 0D, GetRangeMin("Date Filter") - 1);
                        StudentLegacyLedger.SetRange("Student Number", "No.");

                        if globaldimensionfilter1 <> '' then
                            StudentLegacyLedger.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        if globaldimensionfilter2 <> '' then
                            StudentLegacyLedger.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                        if StudentLegacyLedger.Findfirst() then begin
                            StudentLegacyLedger.CalcSums(Amount);
                            OpeningBal := StudentLegacyLedger.Amount;
                        end;

                        glentry.reset();
                        glentry.SetCurrentKey("Posting Date", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", Reversed, "Document No.");//CSPL-00307
                        glentry.setrange("Posting Date", 0D, GetRangeMin("Date Filter") - 1);
                        glentry.SetRange("customer No.", "No.");
                        if globaldimensionfilter1 <> '' then
                            glentry.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                        if globaldimensionfilter2 <> '' then
                            glentry.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                        glentry.SetRange(Reversed, false);
                        glentry.SetFilter("Document No.", '<>%1', 'OPNG*');
                        if glentry.Findfirst() then BEGIN
                            repeat
                                glentry.CalcFields(Amount);
                                //glentry.CalcSums(Amount);
                                OpeningBal += glentry.Amount;
                            until glentry.Next() = 0;
                        end;
                    end;

                    StudentLegacyLedger.reset();
                    if datefilter <> '' then
                        StudentLegacyLedger.setrange("Date", GetRangeMin("Date Filter"), GetRangeMax("Date Filter"));
                    StudentLegacyLedger.SetRange("Student Number", "No.");
                    if globaldimensionfilter1 <> '' then
                        StudentLegacyLedger.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                    if globaldimensionfilter2 <> '' then
                        StudentLegacyLedger.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                    if StudentLegacyLedger.Findfirst() then begin
                        StudentLegacyLedger.CalcSums(Amount);
                        CurrentTransTotal := StudentLegacyLedger.Amount;
                    end;

                    glentry.reset();
                    glentry.SetCurrentKey("Posting Date", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", Reversed, "Document No.");//CSPL-00307
                    if datefilter <> '' then
                        glentry.setrange("posting Date", GetRangeMin("Date Filter"), GetRangeMax("Date Filter"));
                    glentry.SetRange("customer No.", "No.");
                    if globaldimensionfilter1 <> '' then
                        glentry.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                    if globaldimensionfilter2 <> '' then
                        glentry.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                    glentry.SetRange(Reversed, false);
                    glentry.SetFilter("Document No.", '<>%1', 'OPNG*');
                    if glentry.Findfirst() then BEGIN
                        repeat
                            glentry.CalcFields(Amount);
                            //glentry.CalcSums(Amount);
                            CurrentTransTotal += glentry.Amount;
                        until glentry.Next() = 0;
                    end;

                    BalanceAsOfDate := CurrentTransTotal + OpeningBal;
                    SummaryData();

                end;
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Filter Input")
                {
                    // field("Start Date"; "Start Date")
                    // {
                    //     ApplicationArea = All;
                    //     caption = 'Start Date';
                    // }
                    // field("End Date"; "End Date")
                    // {
                    //     caption = 'End Date';
                    //     ApplicationArea = all;
                    // }
                    // field(CustomerNo; CustomerNo)
                    // {
                    //     ApplicationArea = all;
                    //     TableRelation = Customer."No.";
                    //     Caption = 'Customer No.';
                    // }
                    field(FeeCode; FeeCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Fee Code';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            FeeRecord: Record "Fee Component Master-CS";
                            FeeComponentsDetailCS: Page "Fee Components Detail-CS";
                        begin
                            if page.RunModal(Page::"Fee Components Detail-CS", FeeRecord) = Action::LookupOK then begin
                                FeeCode := FeeRecord.code;
                            end;
                        end;
                    }
                    field(DocumentType; DocumentType)
                    {
                        ApplicationArea = all;
                        Caption = 'Document Type';
                    }
                    // field(InstituteCode; InstituteCode)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Institute Code';
                    //     trigger OnLookup(var Text: Text): Boolean
                    //     var
                    //         DimensionValue: record "Dimension Value";
                    //         GLSetup: Record "General Ledger Setup";
                    //     begin
                    //         GLSetup.get();
                    //         DimensionValue.Reset();
                    //         DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                    //         if page.RunModal(Page::"Dimension Value List", DimensionValue) = Action::LookupOK then begin
                    //             InstituteCode := DimensionValue.code;
                    //         end;
                    //     end;
                    // }
                    field(DepartmentCode; globaldimensionfilter2)
                    {
                        ApplicationArea = all;
                        Caption = 'Department Filter';
                        // CaptionClass = '1,1,2';
                        // Caption = 'Global Dimension 2 Code';
                        // Description = 'CS Field Added 15-02-2019';
                        // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                        // trigger OnLookup(var Text: Text): Boolean
                        // var
                        //     DimensionValue: record "Dimension Value";
                        //     GLSetup: Record "General Ledger Setup";
                        // begin
                        //     GLSetup.get();
                        //     DimensionValue.Reset();
                        //     DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                        //     if page.RunModal(Page::"Dimension Value List", DimensionValue) = Action::LookupOK then begin
                        //         DepartmentCode := DimensionValue.code;
                        //     end;
                        // end;
                    }
                    field(Detailed; Detailed)
                    {
                        applicationarea = all;
                        Caption = 'Detailed';
                    }
                    field(summary; Summary)
                    {
                        ApplicationArea = all;
                        caption = 'Summary';
                    }
                }
            }
        }
        Trigger OnInit()
        Begin

            Detailed := True;
        End;
    }

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        temptable: record "Temp Record" temporary;
        Studentledger: page "Consolidated Student Ledger";
        StudentLegacyLedger: record "Student Legacy Ledger";
        studentmaster: record "Student Master-CS";
        glentry: record "Cust. Ledger Entry";
        bankaccountledger: Record "Bank Account Ledger Entry";
        bankaccounts: Record "Bank Account";
        txt001: Label 'Please select either details or summary.';
        Summary: boolean;
        Detailed: boolean;
        "Start Date": Date;
        "End Date": Date;
        StudentNo: text;
        CustomerNo: text;
        InstituteCode: Text;
        FeeCode: Text;
        DocumentType: Option " ","Invoice","Payment","Refund","Credit Memo";
        DepartmentCode: text;
        RunningTotal: decimal;
        BalanceAsOfDate: Decimal;
        OpeningBal: Decimal;
        CurrentTransTotal: decimal;
        progresswindow: Dialog;
        counter: Integer;
        totalcount: Integer;
        progesslabel: Label 'Customer No......#2#######\';
        progesslabel2: Label 'Processing Data.....@3@@@@@@@';
        datefilter: text;
        globaldimensionfilter1: text;
        globaldimensionfilter2: text;
        studentadjustment: Boolean;
        EnrollmentNoFilter: text;

    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        if (not Detailed) and (not Summary) then
            Error(Txt001);

        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();

        temptable.Reset();
        temptable.DeleteAll();

        datefilter := Customer.GetFilter("Date Filter");
        globaldimensionfilter1 := Customer.GetFilter("Global Dimension 1 Filter");
        // globaldimensionfilter2 := Customer.GetFilter("Global Dimension 2 Filter");

        if (Detailed and Summary) then
            Error(Txt001);

        if GuiAllowed then
            progresswindow.open(
                '#1#################################\\' +
                progesslabel +
                progesslabel2);
    end;

    trigger OnPostReport()
    begin
        if Summary then
            CreateExcelbook();
        if GuiAllowed then
            progresswindow.Close();
        if Detailed then begin
            temptable.Reset();
            if temptable.FindFirst() then
                page.run(50189, temptable)
        end;
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Student ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Student Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Student First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Enrollment No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Doc. Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Doc. No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bill Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bill Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transaction Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        if (FeeCode = '') or (DocumentType = DocumentType::" ") then
            ExcelBuffer.AddColumn('Running Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Fee Group', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Institute Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Department Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure OpeningLines()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Customer."No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(studentmaster."Last Name" + ' ' + studentmaster."First Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Customer."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        if (FeeCode = '') or (DocumentType = DocumentType::" ") then
            ExcelBuffer.AddColumn('Opening Amount', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn(RunningTotal, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //Running total
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure closingLines()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Customer."No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(studentmaster."Last Name" + ' ' + studentmaster."First Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Customer."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        if (FeeCode = '') or (DocumentType = DocumentType::" ") then
            ExcelBuffer.AddColumn('Closing Amount', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn(RunningTotal, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //closing Balance
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //closing Balance
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    // procedure FromStudentLegacyLedger()
    // begin
    //     //for SLL's data
    //     ExcelBuffer.NewRow();
    //     ExcelBuffer.AddColumn(Customer."No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(studentmaster."Last Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(studentmaster."First Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("Student Legacy Ledger".Enrollment, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); //program
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); // semester
    //     ExcelBuffer.AddColumn("Student Legacy Ledger"."Document Type", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("Student Legacy Ledger".Date, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::date);
    //     ExcelBuffer.AddColumn("Student Legacy Ledger"."Bill Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("Student Legacy Ledger"."Bill Code Desc", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("Student Legacy Ledger".Description, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); //transaction Description
    //     ExcelBuffer.AddColumn("Student Legacy Ledger".Amount, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    //     //02042021 +
    //     if (FeeCode = '') or (DocumentType = DocumentType::" ") then
    //         ExcelBuffer.AddColumn(round(RunningTotal, 0.01, '='), FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //Running Balance
    //     //02042021 -
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);  //Fee Group
    //     ExcelBuffer.AddColumn("Student Legacy Ledger"."Global Dimension 1 Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    //     ExcelBuffer.AddColumn("Student Legacy Ledger"."Global Dimension 2 Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    // end;

    // procedure FromCustomerLedgerEntry()
    // begin
    //     //for CLE's data
    //     ExcelBuffer.NewRow();
    //     ExcelBuffer.AddColumn(Customer."No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(studentmaster."Last Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn(studentmaster."First Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("G/L Entry"."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); //program
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); // Semester
    //     ExcelBuffer.AddColumn("G/L Entry"."Document Type", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("G/L Entry"."Document No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("G/L Entry"."Posting Date", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
    //     ExcelBuffer.AddColumn("G/L Entry"."Fee Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("G/L Entry"."Fee Description", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    //     ExcelBuffer.AddColumn("G/L Entry".Description, FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); //transaction description
    //     ExcelBuffer.AddColumn("G/L Entry".Amount * (-1), FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    //     //02042021 +
    //     if (FeeCode = '') or (DocumentType = DocumentType::" ") then
    //         ExcelBuffer.AddColumn(round(RunningTotal, 0.01, '='), FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number); //Running balance
    //     //02042021 -
    //     ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); //Fee Group
    //     ExcelBuffer.AddColumn("G/L Entry"."Global Dimension 1 Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    //     ExcelBuffer.AddColumn("G/L Entry"."Global Dimension 2 Code", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
    // end;

    procedure FromStudentLegacyLedger()
    begin

        temptable.Init();
        if temptable.FindLast() then
            temptable."Entry No" += 1;
        temptable."Student ID" := Customer."No.";
        temptable."Student Last Name" := studentmaster."Last Name";
        temptable."Student First Name" := studentmaster."First Name";
        temptable."Enrollment No." := "Student Legacy Ledger".Enrollment;
        temptable."Doc. Type" := format("Student Legacy Ledger"."Document Type");
        temptable."Doc. No." := '';
        temptable."Posting Date" := "Student Legacy Ledger".Date;
        temptable."bill code" := "Student Legacy Ledger"."Bill Code";
        temptable."Bill Discription" := "Student Legacy Ledger"."Bill Code Desc";
        temptable."Transaction Description" := "Student Legacy Ledger".Description;
        temptable.Amount := "Student Legacy Ledger".Amount;
        temptable."institute code" := "Student Legacy Ledger"."Global Dimension 1 Code";
        temptable."Department Code" := "Student Legacy Ledger"."Global Dimension 2 Code";
        if (FeeCode = '') or (DocumentType = DocumentType::" ") then
            temptable."Running Balance" := round(RunningTotal, 0.01, '=');
        temptable.Insert();

    end;

    procedure FromCustomerLedgerEntry()
    begin
        temptable.Init();
        if temptable.FindLast() then
            temptable."Entry No" += 1;
        temptable."Student ID" := Customer."No.";
        temptable."Student Last Name" := studentmaster."Last Name";
        temptable."Student First Name" := studentmaster."First Name";
        temptable."Enrollment No." := "G/L Entry"."Enrollment No.";
        temptable."Doc. Type" := format("G/L Entry"."Document Type");
        temptable."Doc. No." := "G/L Entry"."Document No.";
        temptable."Posting Date" := "G/L Entry"."posting Date";
        temptable."bill code" := "G/L Entry"."Fee Code";
        temptable."Bill Discription" := "G/L Entry"."Fee Description";

        bankaccountledger.Reset();
        bankaccountledger.setrange("Document No.", "G/L Entry"."Document No.");
        bankaccountledger.SetRange("Document Type", bankaccountledger."Document Type"::Payment, bankaccountledger."Document Type"::Refund);
        if bankaccountledger.FindFirst() then begin
            temptable."bill code" := bankaccountledger."Bank Account No.";
            if bankaccounts.get(bankaccountledger."Bank Account No.") then;
            temptable."Bill Discription" := bankaccounts.Name;
        end;

        temptable."Transaction Description" := "G/L Entry".Description;
        if studentadjustment then
            temptable.Amount := ("G/L Entry".Amount * 1)
        else
            temptable.Amount := ("G/L Entry".Amount * -1);
        temptable."institute code" := "G/L Entry"."Global Dimension 1 Code";
        temptable."Department Code" := "G/L Entry"."Global Dimension 2 Code";
        if (FeeCode = '') or (DocumentType = DocumentType::" ") then
            temptable."Running Balance" := round(RunningTotal, 0.01, '=');
        temptable.Insert();
    end;

    procedure SummaryHeader()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Student ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Student Last Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Student First Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Enrollment No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Program', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Semester', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Opening Balance', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Current Transaction', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance as on date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure SummaryData()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(Customer."No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(studentmaster."Last Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(studentmaster."First Name", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Customer."Enrollment No.", FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); // program
        ExcelBuffer.AddColumn('', FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text); // semester
        ExcelBuffer.AddColumn(round(OpeningBal, 0.01, '='), FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number); // Opening Balance
        ExcelBuffer.AddColumn(round(currentTransTotal, 0.01, '='), FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  //Current Transaction
        ExcelBuffer.AddColumn(round(BalanceAsOfDate, 0.01, '='), FALSE, '', False, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);  // Balance as of date
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuffer.CreateNewBook('Consolidated Student Ledger');
        ExcelBuffer.WriteSheet('Consolidated Student Ledger', COMPANYNAME, USERID);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Consolidated Student Ledger');
        ExcelBuffer.OpenExcel();
    end;

    Procedure GetDepartmentFilter(_DepartmentFilter: Text)
    begin
        globaldimensionfilter2 := _DepartmentFilter;
    end;
}