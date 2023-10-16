report 50277 "Audit Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            DataItemTableView = sorting("No.") order(ascending);

            dataitem("Student Legacy Ledger"; "Student Legacy Ledger")
            {
                DataItemLink = "Student Number" = field("No."), date = field("Date filter"),
                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
                DataItemTableView = sorting("Global Dimension 2 Code", Date) order(ascending);

                trigger OnPreDataItem()
                begin

                end;

                trigger OnAfterGetRecord()
                begin
                    RunningTotal := "Student Legacy Ledger".Amount + RunningTotal;

                    FromStudentLegacyLedger();
                end;
            }

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "posting date" = field("Date filter"),
                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
                DataItemTableView = sorting("Global Dimension 2 Code", "Posting Date") order(ascending) Where("Document Type" = filter(" " | Invoice | Refund | Payment | "Credit Memo"), "Document No." = filter(<> 'OPNG*'), Reversed = filter(false));
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemTableView = sorting("Global Dimension 2 Code", "Posting Date") order(ascending);
                    DataItemLink = "Document No." = field("Document No."), "Student No." = field("Customer No."), "Document Type" = field("Document Type"),
                                    "Global Dimension 1 Code" = field("Global Dimension 1 code"), "Global Dimension 2 Code" = field("Global Dimension 2 code");
                    CalcFields = "Student No.";
                    trigger OnPreDataItem()
                    begin

                    end;

                    trigger OnAfterGetRecord()
                    begin
                        studentadjustment := false;

                        if ("Document Type" = "Document Type"::" ") and ("No. Series" = 'STUDENTADJ') then
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

                        if ("Document Type" = "Document Type"::" ") then begin
                            //if (not studentadjustment) then
                            //    RunningTotal := (Amount * (-1)) + RunningTotal
                            //else
                            //    RunningTotal := (Amount * (1)) + RunningTotal;

                            FromCustomerLedgerEntry();
                        end;

                        if "Document Type" in ["Document Type"::Invoice, "Document Type"::Refund] then begin
                            if Amount < 0 then begin
                                //RunningTotal := (Amount * (-1)) + RunningTotal;
                                FromCustomerLedgerEntry();
                            end else
                                CurrReport.skip();
                        end;

                        if "Document Type" in ["Document Type"::payment, "Document Type"::"Credit Memo"] then begin
                            if Amount > 0 then begin
                                //RunningTotal := (Amount * (-1)) + RunningTotal;
                                FromCustomerLedgerEntry();
                            end else
                                CurrReport.skip();
                        end;
                    end;

                    trigger OnPostDataItem()
                    begin

                    end;
                }

                trigger OnPreDataItem()
                begin

                end;
            }

            trigger OnPreDataItem()
            begin
                counter := 0;
                totalcount := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                counter += 1;
                totalcount := Customer.Count;

                if "No." = '3000291' then
                    CurrReport.skip();

                progresswindow.Update(2, Customer."No.");
                progresswindow.update(3, ROUND(counter / totalcount * 10000, 1));

                studentmaster.reset();
                studentmaster.setrange("No.", "No.");
                if studentmaster.FindFirst() then;


                //Clear(RunningTotal);
                // if GetRangeMin("Date Filter") <> 0D then begin
                //     StudentLegacyLedger.reset();
                //     StudentLegacyLedger.SetRange("Date", 0D, GetRangeMin("Date Filter") - 1);
                //     StudentLegacyLedger.SetRange("Student Number", "No.");
                //     if globaldimensionfilter1 <> '' then
                //         StudentLegacyLedger.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                //     if globaldimensionfilter2 <> '' then
                //         StudentLegacyLedger.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                //     if StudentLegacyLedger.Findfirst() then BEGIN
                //         StudentLegacyLedger.CalcSums(Amount);
                //         RunningTotal := StudentLegacyLedger.Amount;
                //     end;

                //     glentry.reset();
                //     glentry.setrange("posting Date", 0D, GetRangeMin("Date Filter") - 1);
                //     glentry.SetRange("customer No.", "No.");
                //     if globaldimensionfilter1 <> '' then
                //         glentry.setfilter("Global Dimension 1 Code", globaldimensionfilter1);
                //     if globaldimensionfilter2 <> '' then
                //         glentry.setfilter("Global Dimension 2 Code", globaldimensionfilter2);
                //     glentry.SetRange(Reversed, false);
                //     glentry.SetFilter("Document No.", '<>%1', 'OPNG*');
                //     if glentry.Findfirst() then BEGIN
                //         repeat
                //             glentry.CalcFields(Amount);
                //             RunningTotal += glentry.Amount;
                //         until glentry.Next() = 0;
                //     end;
                // end;
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

                }
            }
        }
        Trigger OnInit()
        Begin

        End;
    }

    var
        temptable: record "Temp Record";
        Studentledger: page "Consolidated Student Ledger";
        StudentLegacyLedger: record "Student Legacy Ledger";
        studentmaster: record "Student Master-CS";
        glentry: record "Cust. Ledger Entry";
        StudentNo: text;
        CustomerNo: text;
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
        auditpage: Page "Audit Report Data";

    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        //temptable.Reset();
        //temptable.DeleteAll();

        temptable.Reset();
        temptable.SetRange("Unique ID", 'AUDITREPORT' + UserId());
        if temptable.FindFirst() then
            temptable.DeleteAll();

        datefilter := Customer.GetFilter("Date Filter");
        globaldimensionfilter1 := Customer.GetFilter("Global Dimension 1 Filter");
        globaldimensionfilter2 := Customer.GetFilter("Global Dimension 2 Filter");

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

        temptable.Reset();
        if temptable.FindFirst() then begin
            auditpage.setdatafilter(globaldimensionfilter1, Customer.GetRangeMin("Date Filter"));
            auditpage.SetTableView(temptable);
            auditpage.Run();
            //page.run(51008, temptable);
        end;
    end;

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
        temptable."Posting Date" := "Student Legacy Ledger".Date;
        temptable."bill code" := "Student Legacy Ledger".TN;
        if "Student Legacy Ledger"."Global Dimension 2 Code" = '' then
            temptable."Bill Discription" := 'Tution'
        else
            temptable."Bill Discription" := 'Housing';
        temptable."Transaction Description" := "Student Legacy Ledger".Description;
        temptable.Amount := "Student Legacy Ledger".Amount;
        temptable."institute code" := "Student Legacy Ledger"."Global Dimension 1 Code";
        temptable."Department Code" := "Student Legacy Ledger"."Global Dimension 2 Code";
        //temptable."Running Balance" := round(RunningTotal, 0.01, '=');
        temptable."Unique ID" := 'AUDITREPORT' + UserId();
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
        temptable."Posting Date" := "G/L Entry"."posting Date";
        temptable."bill code" := "G/L Entry"."Transaction Number";
        if "G/L Entry"."Global Dimension 2 Code" = '' then
            temptable."Bill Discription" := 'Tution'
        else
            temptable."Bill Discription" := 'Housing';

        temptable."Transaction Description" := "G/L Entry".Description;
        if studentadjustment then
            temptable.Amount := ("G/L Entry".Amount * 1)
        else
            temptable.Amount := ("G/L Entry".Amount * -1);
        temptable."institute code" := "G/L Entry"."Global Dimension 1 Code";
        temptable."Department Code" := "G/L Entry"."Global Dimension 2 Code";

        //temptable."Running Balance" := round(RunningTotal, 0.01, '=');
        temptable."Unique ID" := 'AUDITREPORT' + UserId();
        temptable.Insert();
    end;
}