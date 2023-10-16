report 50208 "KK Report Test Final"
{
    Caption = 'KK Report';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")

        {

            DataItemTableView = sorting("Entry No.") where("Start Date" = filter(<> 0D), "End Date" = Filter(<> 0D),
             "Hospital Id" = filter(<> ''), "Course Code" = filter(<> ''));
            RequestFilterFields = "Hospital ID", "Rotation ID";
            CalcFields = "Paid Weeks", "Paid Total Actual Rot. Cost", "Invoiced Weeks", "Inv. Total Actual Rot. Cost", Prepayment;

            trigger OnPreDataItem()
            var
            begin

                CompInf.get();

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
                if StudentMaster.get("Student ID") then;

                EstRotationWkCost := 0;
                EstRotationTotalCost := 0;
                ValidRotation := 0;
                CourseCreditWeeks := 0;
                WeeksPaid := 0;
                WeeksInvoiced := 0;
                Graded := 0;
                TotalInvoiced := 0;
                WeeksCredited := 0;
                CreditAmount := 0;
                ExpenseRealized := 0;
                TotalPaid := 0;
                InvoiceBalance := 0;
                WeeksCompleted := 0;
                RateTableRate := 0;
                UnpaidWksCompleted := 0;
                ExpenseAccrual := 0;
                PrePayment := 0;
                InvoiceRate := 0;
                WeeksDeliveredCurrentPeriod := 0;
                WeeksDeliveredAllPriorPeriods := 0;
                RateUsed := 0;
                WeeklyCost := 0;
                Clear(HospitalInvoiceNumber);
                Clear(CheckeNoText);
                Clear(CheckDateText);


                TotalCount += 1;
                Window.Update(2, TotalCount);

                RateTableRate := 0;
                Clear(WeeklyCost);
                HospitalCostMaster.Reset();
                HospitalCostMaster.SetRange("Hospital ID", "Roster Ledger Entry"."Hospital ID");
                HospitalCostMaster.SetRange("Clerkship Type", "Roster Ledger Entry"."Clerkship Type");
                HospitalCostMaster.SetRange("Effective Date", 0D, "Roster Ledger Entry"."Start Date");
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

                if "Cost Per week Override" <> 0 then begin           //30112022 Navdeep
                    EstRotationWkCost := "Cost Per week Override";
                    EstRotationTotalCost := "Cost Per week Override" * "Roster Ledger Entry"."Total No. of Weeks";
                end;

                ValidRotation := -1;
                if (Format("Roster Ledger Entry"."Rotation Grade") = 'X') or (format("Roster Ledger Entry"."Rotation Grade") = 'TC') then
                    ValidRotation := 0;

                RotationGrade := '';
                if "End Date" > ToDate then begin
                    if "Rotation Grade" = '' then
                        RotationGrade := 'M'
                    else
                        RotationGrade := "Rotation Grade";
                end else
                    RotationGrade := "Rotation Grade";

                Graded := -1;
                if (RotationGrade = 'X') or (RotationGrade = 'TC') or (RotationGrade = 'UC') or (RotationGrade = 'SC') or
                    (RotationGrade = 'M')
                then
                    Graded := 0;


                CourseCreditWeeks := 0;
                if SubjectMasterCS.Get("Course Code") then
                    CourseCreditWeeks := SubjectMasterCS.Credit;

                if CourseCreditWeeks = 0 then
                    CourseCreditWeeks := Round(("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7, 1, '=');

                WeeksCompleted := 0;
                WeeksCompleted1 := 0;
                WeeksDeliveredCurrentPeriod := 0;
                Clear(StringLen1);
                Clear(StringPos1);
                if ToDate < "Roster Ledger Entry"."End Date" then begin
                    WeeksCompleted1 := ((ToDate - "Roster Ledger Entry"."Start Date") / 7);
                    StringLen1 := StrLen(format(WeeksCompleted1));
                    StringPos1 := StrPos(format(WeeksCompleted1), '.');
                    if StrPos(format(WeeksCompleted1), '.') <> 0 then begin
                        if CopyStr(Format(WeeksCompleted1), StringPos1, 2) > '.35' then
                            WeeksCompleted := round((ToDate - "Roster Ledger Entry"."Start Date") / 7, 1, '>')
                        else
                            WeeksCompleted := round((ToDate - "Roster Ledger Entry"."Start Date") / 7, 1, '=');
                    end else
                        WeeksCompleted := round((ToDate - "Roster Ledger Entry"."Start Date") / 7, 1, '=');
                end
                else begin
                    WeeksCompleted1 := (("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7);
                    StringPos1 := StrPos(format(WeeksCompleted1), '.');
                    StringLen1 := StrLen(format(WeeksCompleted1));
                    if StrPos(format(WeeksCompleted1), '.') <> 0 then begin
                        if CopyStr(Format(WeeksCompleted1), StringPos1, 2) > '.35' then
                            WeeksCompleted := Round(("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7, 1, '>')
                        else
                            WeeksCompleted := Round(("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7, 1, '=');
                    end else
                        WeeksCompleted := Round(("Roster Ledger Entry"."End Date" - "Roster Ledger Entry"."Start Date") / 7, 1, '=');
                end;

                if ToDate < "Roster Ledger Entry"."Start Date" then
                    WeeksCompleted := 0;
                if "Clerkship Type" = "Clerkship Type"::Elective then
                    CourseCoreClinicalReqirement := 'False'
                else
                    CourseCoreClinicalReqirement := 'True';


                WeeksPaid := 0;
                TotalPaid := 0;
                WeeksPaid := Abs("Roster Ledger Entry"."Paid Weeks");
                TotalPaid := Abs("Roster Ledger Entry"."Paid Total Actual Rot. Cost");

                if WeeksPaid <> 0 then
                    TotalPaid := EstRotationWkCost * WeeksPaid;

                HospitalInvoiceNumber := '';
                CheckDateText := '';
                CheckeNoText := '';
                rosterledgerdocuments.Reset();
                rosterledgerdocuments.SetRange("Entry No.", "Roster Ledger Entry"."Entry No.");
                if rosterledgerdocuments.FindFirst() then begin
                    HospitalInvoiceNumber := rosterledgerdocuments."Invoice Nos.";
                    CheckDateText := rosterledgerdocuments."Cheque Dates";
                    CheckeNoText := rosterledgerdocuments."Cheque Nos.";
                end;

                HospitalInvoiceNumber := "Roster Ledger Entry"."Invoice No."; //CSPL-00307

                WeeksInvoiced := 0;
                TotalInvoiced := 0;
                // WeeksInvoiced := Abs("Roster Ledger Entry"."Paid Weeks");//CSPL-00307 as per raja sir 10-06-2022
                WeeksInvoiced := Abs("Roster Ledger Entry"."Weeks Invoiced");//CSPL-00307 as per raja sir 10-06-2022
                TotalInvoiced := Abs("Roster Ledger Entry"."Paid Total Actual Rot. Cost");


                if WeeksInvoiced <> 0 then
                    TotalInvoiced := EstRotationWkCost * WeeksInvoiced;


                if "Check No." = '' then begin
                    TotalPaid := 0;
                    WeeksPaid := 0;
                end;

                if ToDate < "Roster Ledger Entry"."Start Date" then begin
                    WeeksInvoiced := 0;
                    TotalInvoiced := 0;
                end;

                if HospitalInvoiceNumber = '' then begin
                    WeeksInvoiced := 0;
                    TotalInvoiced := 0;
                end;


                WeeksDeliveredCurrentPeriod := 0;
                WeeksDeliveredAllPriorPeriods := 0;
                WeeksDeliveredAllPriorPeriods1 := 0;
                Clear(StringPos);
                Clear(StringLen);
                if "Roster Ledger Entry"."End Date" <= FromDate then begin
                    WeeksDeliveredAllPriorPeriods1 := (("End Date" - "Start Date") / 7);
                    StringPos := StrPos(format(WeeksDeliveredAllPriorPeriods1), '.');
                    StringLen := StrLen(format(WeeksDeliveredAllPriorPeriods1));
                    if StrPos(format(WeeksDeliveredAllPriorPeriods1), '.') <> 0 then begin
                        if CopyStr(Format(WeeksDeliveredAllPriorPeriods1), StringPos, StringLen) > '.35' then
                            WeeksDeliveredAllPriorPeriods := Round(("End Date" - "Start Date") / 7, 1, '>')
                        else
                            WeeksDeliveredAllPriorPeriods := Round(("End Date" - "Start Date") / 7, 1, '=');
                    end else
                        WeeksDeliveredAllPriorPeriods := Round(("End Date" - "Start Date") / 7, 1, '=');
                end;

                if "Roster Ledger Entry"."End Date" > FromDate then begin
                    WeeksDeliveredAllPriorPeriods1 := ((FromDate - "Roster Ledger Entry"."Start Date") / 7);
                    StringPos := StrPos(format(WeeksDeliveredAllPriorPeriods1), '.');
                    StringLen := StrLen(format(WeeksDeliveredAllPriorPeriods1));
                    if StrPos(format(WeeksDeliveredAllPriorPeriods1), '.') <> 0 then begin
                        if CopyStr(Format(WeeksDeliveredAllPriorPeriods1), StringPos, StringLen) > '.35' then
                            WeeksDeliveredAllPriorPeriods := Round((FromDate - "Roster Ledger Entry"."Start Date") / 7, 1, '>')
                        else
                            WeeksDeliveredAllPriorPeriods := Round((FromDate - "Roster Ledger Entry"."Start Date") / 7, 1, '=');
                    end else
                        WeeksDeliveredAllPriorPeriods := Round((FromDate - "Roster Ledger Entry"."Start Date") / 7, 1, '=');
                end;

                if "Roster Ledger Entry"."Start Date" > FromDate then
                    WeeksDeliveredAllPriorPeriods := 0;

                if WeeksCompleted <> 0 then
                    WeeksDeliveredCurrentPeriod := WeeksCompleted - WeeksDeliveredAllPriorPeriods;

                InvoiceRate := 0;
                if (TotalInvoiced <> 0) and (WeeksInvoiced <> 0) then
                    InvoiceRate := TotalInvoiced / WeeksInvoiced
                else
                    InvoiceRate := 0;


                if WeeklyCost > 0 then begin
                    RateType := 'RateTableRate';
                    RateUsed := WeeklyCost;
                end;
                if WeeklyCost = 0 then begin
                    RateType := 'Default';
                    RateUsed := DefaultRate;
                end;
                if WeeksInvoiced > 0 then begin
                    RateType := 'Invoice';
                    RateUsed := InvoiceRate;
                end;
                if "Cost Per week Override" > EstRotationWkCost then begin
                    RateUsed := InvoiceRate;
                end;


                if (WeeksInvoiced = 0) and ("Check No." = '') then
                    WeeksPaid := 0;

                if (TotalInvoiced = 0) and ("Check No." = '') then
                    TotalPaid := 0;

                ExpenseRealized := 0;
                if ValidRotation <> 0 then
                    ExpenseRealized := (WeeksCompleted * EstRotationWkCost);


                InvoiceBalance := 0;
                InvoiceBalance := Abs(TotalInvoiced - TotalPaid);


                ExpenseAccrual := 0;
                if (ExpenseRealized - (TotalPaid + CreditAmount)) <> 0 then
                    ExpenseAccrual := (ExpenseRealized - (TotalPaid + CreditAmount))
                else
                    ExpenseAccrual := 0;


                rosterledgerentry.Reset();
                rosterledgerentry.SetRange("Entry No.", "Roster Ledger Entry"."Entry No.");
                rosterledgerentry.Setrange("date filter", 0D, "Roster Ledger Entry"."End Date" - 1);
                PrePayment := -1 * rosterledgerentry.Prepayment;

                if ("Rotation Grade" = 'X') then begin
                    WeeksCompleted := 0;
                    WeeksPaid := 0;
                    WeeksCredited := 0;
                    CreditAmount := 0;
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

                if "Hospital ID" = '18440' then begin
                    EstRotationWkCost := 0;
                    EstRotationTotalCost := 0;
                    TotalInvoiced := 0;
                    WeeksPaid := 0;
                    WeeksCredited := 0;
                    CreditAmount := 0;
                    InvoiceBalance := 0;
                    ExpenseRealized := 0;
                    TotalPaid := 0;
                    InvoiceRate := 0;
                    RateTableRate := 0;
                    ExpenseAccrual := 0;
                    PrePayment := 0;
                end;

                if (StrPos(HospitalInvoiceNumber, 'WO') <> 0) and ("Check No." = '') then begin
                    TotalInvoiced := 0;
                    WeeksPaid := 0;
                    WeeksCredited := 0;
                    CreditAmount := 0;
                    InvoiceBalance := 0;
                    ExpenseRealized := 0;
                    TotalPaid := 0;
                    InvoiceRate := 0;
                    RateTableRate := 0;
                    ExpenseAccrual := 0;
                    PrePayment := 0;
                end;

                if (StrPos(HospitalInvoiceNumber, 'WO') <> 0) and ("Check No." = '-1') then begin
                    EstRotationWkCost := 0;
                    EstRotationTotalCost := 0;
                    TotalInvoiced := 0;
                    WeeksPaid := 0;
                    WeeksCredited := 0;
                    CreditAmount := 0;
                    InvoiceBalance := 0;
                    ExpenseRealized := 0;
                    TotalPaid := 0;
                    InvoiceRate := 0;
                    RateTableRate := 0;
                    ExpenseAccrual := 0;
                    PrePayment := 0;
                end;

                if (StrPos(HospitalInvoiceNumber, 'JE') <> 0) and (("Check No." = '') or ("Check No." = '-1')) then begin
                    if "Check No." = '-1' then begin
                        EstRotationWkCost := 0;
                        EstRotationTotalCost := 0;
                    end;
                    TotalInvoiced := 0;
                    WeeksPaid := 0;
                    WeeksCredited := 0;
                    CreditAmount := 0;
                    InvoiceBalance := 0;
                    ExpenseRealized := 0;
                    TotalPaid := 0;
                    InvoiceRate := 0;
                    RateTableRate := 0;
                    ExpenseAccrual := 0;
                    PrePayment := 0;
                end;

                UnpaidWksCompleted := (WeeksCompleted + WeeksCredited) - WeeksPaid;

                TempTable.Init();
                if TempTable.FindLast() then
                    TempTable."Entry No" += 1;
                TempTable."Student ID" := StudentMaster."Original Student No.";
                TempTable."Course UID" := "Roster Ledger Entry"."Course Code";
                TempTable."Hospital Name" := "Hospital Name";
                TempTable."Course Start Date" := "Roster Ledger Entry"."Start Date";
                TempTable."Course End Date" := "Roster Ledger Entry"."End Date";
                TempTable."Hospital UID" := "Roster Ledger Entry"."Hospital ID";
                TempTable."Est Rotation Wk Cost" := EstRotationWkCost;
                TempTable."Est Rotation Total Cost" := EstRotationTotalCost;
                TempTable."Valid Rotation" := ValidRotation;
                TempTable."Course Title" := "Roster Ledger Entry"."Course Description";
                TempTable.Grade := RotationGrade;
                TempTable."Course Credit Weeks" := CourseCreditWeeks;
                TempTable."Course Core Clinical Req." := CourseCoreClinicalReqirement;
                TempTable."Weeks Completed" := WeeksCompleted;
                TempTable."Weeks Paid" := WeeksPaid;
                TempTable."Weeks Invoiced" := WeeksInvoiced;
                TempTable."Total Invoiced" := TotalInvoiced;
                TempTable."Weeks Credited" := WeeksCredited;
                TempTable."Credit Amount" := CreditAmount;
                TempTable.Graded := Graded;
                TempTable."Invoice Balance" := InvoiceBalance;
                TempTable."Expense Realized" := ExpenseRealized;
                TempTable."Total Paid" := TotalPaid;
                TempTable."Student Last Name" := "Roster Ledger Entry"."Last Name";
                TempTable."Student First Name" := "Roster Ledger Entry"."First Name";
                TempTable."Student Spec. Prog." := ClerkshipPaymentLedgerEntry."Elective Course Code";
                TempTable."Rate Table Rate" := RateTableRate;
                TempTable."Accrual Week End" := ToDate;
                TempTable."Invoice Rate" := InvoiceRate;
                TempTable."Rate Used" := RateUsed;
                TempTable."Rate Type" := RateType;
                TempTable."Unpaid Wks Completed" := UnpaidWksCompleted;
                TempTable."Expense Accrual" := ExpenseAccrual;
                TempTable."Hospital Invoice Number" := HospitalInvoiceNumber;
                TempTable."Hospital Payment Number" := CheckeNoText;
                TempTable."Payment Date" := CheckDateText;
                TempTable."Pre Payment" := PrePayment;
                TempTable."Weeks Delivered Current Period" := WeeksDeliveredCurrentPeriod;
                TempTable."Weeks Del. All Prior Periods" := WeeksDeliveredAllPriorPeriods;
                TempTable."Rotation ID" := "Rotation ID";
                TempTable.Insert();
            end;
        }
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
        TempTable: Record "Temp Record" temporary;
        // Date_Rec: Record Date;
        rosterledgerentry: Record "Roster Ledger Entry";
        ClerkshipPaymentLedgerEntry: Record "Clerkship Payment Ledger Entry";
        rosterledgerdocuments: Record "Roster Ledger Documents";
        SubjectMasterCS: Record "Subject Master-CS";
        StudentMaster: Record "Student Master-CS";
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
        WeeksCompleted1: Decimal;
        FromDate: Date;
        ToDate: Date;
        RateTableRate: Decimal;
        UnpaidWksCompleted: Decimal;
        ExpenseAccrual: Decimal;
        PrePayment: Decimal;
        InvoiceRate: Decimal;
        WeeksDeliveredCurrentPeriod: Decimal;
        WeeksDeliveredAllPriorPeriods: Decimal;
        WeeksDeliveredAllPriorPeriods1: Decimal;
        RateType: Text;
        RateUsed: Decimal;
        DefaultRate: Decimal;
        HospitalInvoiceNumber: Text;
        TotalCount: Integer;
        WeeklyCost: Decimal;
        RotationGrade: Text;
        StringPos: Integer;
        StringLen: Integer;
        StringPos1: Integer;
        StringLen1: Integer;
        CheckeNoText: Text;
        CheckDateText: Text;

    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        TempTable.Reset();
        TempTable.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        TempTable.Reset();
        if TempTable.FindFirst() then
            page.Run(51004, TempTable);
    end;

}