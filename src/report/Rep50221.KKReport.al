report 50221 "KK Report"
{
    Caption = 'KK Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/KK Report.rdl';
    UsageCategory = None;
    //    ApplicationArea = all;
    PreviewMode = Normal;

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")

        {
            DataItemTableView = sorting("Entry No.") where("Start Date" = filter(<> 0D), "End Date" = Filter(<> 0D));
            CalcFields = "Paid Weeks", "Paid Total Actual Rot. Cost", "Invoiced Weeks", "Inv. Total Actual Rot. Cost", Prepayment;
            column(RepoerRunDate; ToDate)
            {

            }
            column(FromDate; FromDate)
            {

            }
            column(StudentID; "Student ID")
            {


            }
            column(CourseUID; "Roster Ledger Entry"."Course Code")
            {

            }
            column(HospitalName; "Hospital Name")
            {

            }
            column(CourseDateStart; "Roster Ledger Entry"."Start Date")
            {

            }
            column(CourseEndDate; "Roster Ledger Entry"."End Date")
            {

            }
            column(HospitalUID; "Roster Ledger Entry"."Hospital ID")
            {

            }
            column(EstRotationWkCost; EstRotationWkCost)
            {

            }
            column(EstRotationTotalCost; EstRotationTotalCost)
            {

            }
            column(ValidRotation; ValidRotation)
            {

            }
            column(CourseTitle; "Roster Ledger Entry"."Course Description")
            {

            }
            column(Grade; "Roster Ledger Entry"."Rotation Grade")
            {

            }
            column(CourseCreditWeeks; CourseCreditWeeks)
            {

            }

            column(CourseCoreClinicalReqirement; CourseCoreClinicalReqirement)
            {

            }
            column(WeeksCompleted; WeeksCompleted)
            {

            }
            column(WeeksPaid; WeeksPaid)
            {

            }
            column(WeeksInvoiced; WeeksInvoiced)
            {

            }
            column(TotalInvoiced; round(TotalInvoiced, 1, '='))
            {

            }
            column(WeeksCredited; WeeksCredited)
            {

            }
            column(CreditAmount; CreditAmount)
            {

            }
            column(Graded; Graded)
            {

            }
            column(InvoiceBalance; round(InvoiceBalance, 1, '='))
            {

            }
            column(ExpenseRealized; Round(ExpenseRealized, 1, '='))
            {

            }
            column(TotalPaid; TotalPaid)
            {

            }
            column(StudentLastName; "Roster Ledger Entry"."Last Name")
            {

            }
            column(StudentFirstName; "Roster Ledger Entry"."First Name")
            {

            }
            column(StudentSpecialProgram; ClerkshipPaymentLedgerEntry."Elective Course Code")
            {

            }
            column(RateTableRate; RateTableRate)
            {

            }
            column(AccrualWeekEnd; Todate)
            {

            }
            column(InvoiceRate; InvoiceRate)
            {

            }
            column(RateUsed; RateUsed)
            {

            }
            column(RateType; RateType)
            {

            }
            column(UnpaidWksCompleted; UnpaidWksCompleted)
            {

            }

            column(ExpenseAccrual; ExpenseAccrual)
            {

            }
            column(HospitalInvoiceNumber; HospitalInvoiceNumber)
            {

            }
            column(HospitalPaymentNumber; "Roster Ledger Entry"."Check No.")
            {

            }
            column(PaymentDate; "Roster Ledger Entry"."Check Date")
            {

            }
            column(PrePayment; PrePayment)
            {

            }
            column(WeeksDeliveredCurrentPeriod; WeeksDeliveredCurrentPeriod)
            {

            }
            column(WeeksDeliveredAllPriorPeriods; WeeksDeliveredAllPriorPeriods)
            {

            }
            column(CompanyName; CompanyName)
            {

            }
            column(CompPic; CompInf.Picture)
            {

            }

            trigger OnPreDataItem()
            var
            begin
                // SetFilter("End Date", '%1..%2', 0D, ToDate);

                CompInf.get();
                //CompInf.CalcFields(Picture);
                CompanyName := CompInf.Name;
                CourseCreditWeeks := 0;
                WeeksCompleted := 0;

                if FromDate = 0D then
                    Error('Please fill From Date');
                if ToDate = 0D then
                    Error('Please fill To Date');

                if DefaultRate = 0 then
                    Error('Please fill the Default Rate');

                window.Open('Total Count ##1##########\\' + 'Line Count ###2############');
                Window.Update(1, "Roster Ledger Entry".Count);
            end;

            trigger OnAfterGetRecord()
            begin
                TotalCount += 1;
                Window.Update(2, TotalCount);
                RateTableRate := 0;
                Clear(WeeklyCost);
                HospitalCostMaster.Reset();
                HospitalCostMaster.SetRange("Hospital ID", "Roster Ledger Entry"."Hospital ID");
                HospitalCostMaster.SetRange("Clerkship Type", "Roster Ledger Entry"."Clerkship Type");
                HospitalCostMaster.SetFilter("Effective Date", '%1..%2', 0D, "Roster Ledger Entry"."Start Date");
                if HospitalCostMaster.findlast() then begin
                    RateTableRate := HospitalCostMaster."Weekly Cost";
                    WeeklyCost := HospitalCostMaster."Weekly Cost";
                end;
                if RateTableRate = 0 then begin
                    RateUsed := DefaultRate;
                    RateTableRate := DefaultRate;
                end;
                EstRotationWkCost := 0;
                EstRotationTotalCost := 0;
                if WeeklyCost = 0 then begin
                    EstRotationWkCost := DefaultRate;
                    EstRotationTotalCost := DefaultRate * "Roster Ledger Entry"."Total No. of Weeks";
                end else begin
                    EstRotationWkCost := WeeklyCost;
                    EstRotationTotalCost := WeeklyCost * "Roster Ledger Entry"."Total No. of Weeks";
                end;
                ValidRotation := -1;
                if (Format("Roster Ledger Entry"."Rotation Grade") = 'X') or (format("Roster Ledger Entry"."Rotation Grade") = 'TC') then
                    ValidRotation := 0;

                Graded := -1;
                if (Format("Roster Ledger Entry"."Rotation Grade") = 'X') or (format("Roster Ledger Entry"."Rotation Grade") = 'TC') or
                    (Format("Roster Ledger Entry"."Rotation Grade") = 'UC') or (Format("Roster Ledger Entry"."Rotation Grade") = 'SC') or
                    (Format("Roster Ledger Entry"."Rotation Grade") = 'M')
                then
                    Graded := 0;


                CourseCreditWeeks := 0;
                CourseCreditWeeks := Round(("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7, 1, '=');

                WeeksCompleted := 0;
                WeeksDeliveredCurrentPeriod := 0;
                if ToDate < "Roster Ledger Entry"."End Date" then
                    WeeksCompleted := round((ToDate - "Roster Ledger Entry"."Start Date") / 7, 1, '=')
                else
                    WeeksCompleted := Round(("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7, 1, '=');

                if ToDate < "Roster Ledger Entry"."Start Date" then
                    WeeksCompleted := 0;
                if "Clerkship Type" = "Clerkship Type"::Elective then
                    CourseCoreClinicalReqirement := 'False'
                else
                    CourseCoreClinicalReqirement := 'True';

                if ("Rotation Grade" = 'X') Or ("Rotation Grade" = 'SC') Or ("Rotation Grade" = 'UC') then
                    WeeksCompleted := 0;

                WeeksPaid := 0;
                TotalPaid := 0;

                WeeksPaid := Abs("Roster Ledger Entry"."Paid Weeks");
                TotalPaid := Abs("Roster Ledger Entry"."Paid Total Actual Rot. Cost");

                if TotalPaid = 0 then
                    TotalPaid := DefaultRate * "Total No. of Weeks";

                HospitalInvoiceNumber := '';
                ClerkshipPaymentLedgerEntry.Reset();
                ClerkshipPaymentLedgerEntry.SetRange("Rotation Entry No.", "Roster Ledger Entry"."Entry No.");
                ClerkshipPaymentLedgerEntry.SetFilter("Entry Type", '%1|%2', ClerkshipPaymentLedgerEntry."Entry Type"::Invoice, ClerkshipPaymentLedgerEntry."Entry Type"::"Invoice Reversal");
                ClerkshipPaymentLedgerEntry.SetFilter("Invoice Date", '%1..%2', 0D, ToDate);
                if ClerkshipPaymentLedgerEntry.FindFirst() then
                    HospitalInvoiceNumber := ClerkshipPaymentLedgerEntry."Invoice No.";

                if HospitalInvoiceNumber = '' then begin
                    WeeksPaid := 0;
                    TotalPaid := 0;
                end;

                WeeksInvoiced := 0;
                TotalInvoiced := 0;

                WeeksInvoiced := Abs("Roster Ledger Entry"."Paid Weeks");
                TotalInvoiced := Abs("Roster Ledger Entry"."Paid Total Actual Rot. Cost");

                if TotalInvoiced = 0 then
                    TotalInvoiced := DefaultRate * "Total No. of Weeks";

                if ToDate < "Roster Ledger Entry"."Start Date" then begin
                    WeeksInvoiced := 0;
                    TotalInvoiced := 0;
                end;

                WeeksDeliveredCurrentPeriod := 0;
                WeeksDeliveredAllPriorPeriods := 0;
                if "Roster Ledger Entry"."End Date" <= FromDate then
                    WeeksDeliveredAllPriorPeriods := "Roster Ledger Entry"."Total No. of Weeks";

                if "Roster Ledger Entry"."End Date" > FromDate then
                    WeeksDeliveredAllPriorPeriods := Round((FromDate - "Roster Ledger Entry"."Start Date") / 7, 1, '=');

                if "Roster Ledger Entry"."Start Date" > FromDate then
                    WeeksDeliveredAllPriorPeriods := 0;

                if WeeksCompleted <> 0 then
                    WeeksDeliveredCurrentPeriod := WeeksCompleted - WeeksDeliveredAllPriorPeriods;

                InvoiceRate := 0;
                if (TotalInvoiced <> 0) and (WeeksInvoiced <> 0) then
                    InvoiceRate := TotalInvoiced / WeeksInvoiced
                else
                    InvoiceRate := 0;

                // if "Roster Ledger Entry"."Actual Rotation Cost" <> 0 then
                //     RateUsed := "Roster Ledger Entry"."Actual Rotation Cost"
                // else
                //     RateUsed := EstRotationWkCost;

                if WeeklyCost > 0 then
                    RateType := 'RateTableRate';

                if WeeksInvoiced > 0 then
                    RateType := 'Invoice';

                if WeeklyCost = 0 then
                    RateType := 'Default';

                if WeeklyCost > 0 then
                    RateUsed := WeeklyCost;

                if WeeksInvoiced > 0 then
                    RateUsed := InvoiceRate;

                if WeeklyCost = 0 then
                    RateUsed := DefaultRate;

                if WeeksInvoiced = 0 then
                    WeeksPaid := 0;

                if TotalInvoiced = 0 then
                    TotalPaid := 0;


                UnpaidWksCompleted := Abs((WeeksCompleted + WeeksCredited) - WeeksPaid);

                // if TotalInvoiced <> 0 then
                //     ExpenseRealized := Abs(TotalInvoiced)
                // else
                ExpenseRealized := round((WeeksCompleted * "Roster Ledger Entry"."Actual Rotation Cost"), 1, '=');

                if ExpenseRealized = 0 then
                    ExpenseRealized := round(WeeksCompleted * DefaultRate, 1, '=');

                if ValidRotation <> 0 then begin
                    if WeeksInvoiced > 0 then
                        ExpenseRealized := TotalInvoiced
                    else
                        ExpenseRealized := WeeksCompleted * EstRotationWkCost;
                end else
                    ExpenseRealized := 0;


                InvoiceBalance := Abs(TotalInvoiced - TotalPaid);

                ExpenseAccrual := 0;
                ExpenseAccrual := Round(WeeksCompleted * DefaultRate, 1, '=');
                if (TotalPaid = 0) then
                    ExpenseAccrual := round("Roster Ledger Entry"."Actual Rotation Cost" * WeeksCompleted, 1, '=');


                rosterledgerentry.Reset();
                rosterledgerentry.SetRange("Entry No.", "Roster Ledger Entry"."Entry No.");
                rosterledgerentry.Setrange("date filter", 0D, "Roster Ledger Entry"."End Date" - 1);
                PrePayment := -1 * rosterledgerentry.Prepayment;

                if ("Rotation Grade" = 'X') then begin
                    TotalInvoiced := 0;
                    WeeksCompleted := 0;
                    WeeksPaid := 0;
                    WeeksInvoiced := 0;
                    WeeksCredited := 0;
                    CreditAmount := 0;
                    Graded := 0;
                    InvoiceBalance := 0;
                    ExpenseRealized := 0;
                    TotalPaid := 0;
                    InvoiceRate := 0;
                    RateTableRate := 0;
                    UnpaidWksCompleted := 0;
                    ExpenseAccrual := 0;
                    PrePayment := 0;
                    WeeksDeliveredCurrentPeriod := 0;
                    WeeksDeliveredAllPriorPeriods := 0;
                end;
            end;
        }
        // }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {

            area(Content)
            {
                group("Option")
                {
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                        trigger OnValidate()
                        var
                        begin
                            if FromDate = 0D then
                                Error('Please fill the from date');
                        end;

                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                        // trigger OnValidate()
                        // begin
                        //     if ToDate > WorkDate() then
                        //         Error('To Date must not be more than %1', Todate);
                        // end;

                    }
                    field("Default Rate"; DefaultRate)
                    {
                        ApplicationArea = all;
                        Caption = 'Default Rate';
                    }

                }
            }
        }

        //     actions
        //     {
        //         area(processing)
        //         {
        //             action(ActionName)
        //             {
        //                 ApplicationArea = All;

        //             }
        //         }
        //     }
    }
    var
        CompInf: Record "Company Information";
        HospitalCostMaster: Record "Hospital Cost Master";
        // Date_Rec: Record Date;
        rosterledgerentry: Record "Roster Ledger Entry";
        ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
        Window: Dialog;
        CompanyName: Text;
        EstRotationWkCost: Decimal;
        EstRotationTotalCost: Decimal;
        ValidRotation: Decimal;
        CourseCreditWeeks: Decimal;
        // Monday: Decimal;
        // Friday: Decimal;
        CourseCoreClinicalReqirement: Text;
        WeeksPaid: Decimal;
        WeeksInvoiced: Decimal;
        Graded: Decimal;
        TotalInvoiced: Decimal;
        WeeksCredited: Decimal;
        CreditAmount: Decimal;
        ExpenseRealized: Decimal;
        TotalPaid: Decimal;
        InvoiceBalance: Decimal;
        WeeksCompleted: Decimal;
        FromDate: Date;
        ToDate: Date;
        RateTableRate: Decimal;
        UnpaidWksCompleted: Decimal;
        ExpenseAccrual: Decimal;
        PrePayment: Decimal;
        InvoiceRate: Decimal;
        WeeksDeliveredCurrentPeriod: Decimal;
        WeeksDeliveredAllPriorPeriods: Decimal;
        RateType: Text;
        RateUsed: Decimal;
        DefaultRate: Decimal;
        HospitalInvoiceNumber: Text;
        TotalCount: Integer;
        WeeklyCost: Decimal;
}