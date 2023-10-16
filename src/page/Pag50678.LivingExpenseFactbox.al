page 50678 "Living Expenses FactBox"
{
    PageType = CardPart;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Student Master-CS";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Entries Status")
            {
                field("T4 Authorization"; Rec."T4 Authorization")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'T4 Authorization';
                }
                group("Apply Entries")
                {
                    field("ApplicationEntry"; "ApplicationEntry")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Status';
                        OptionCaption = 'Not Applicable,Pending for Approval,Approved';
                    }
                }
                group("Seat Deposit")
                {
                    field(SeatDepositEntry; SeatDepositEntry)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Status';
                        OptionCaption = 'Not Applicable,Pending for Approval,Approved';
                    }
                    field(SeatDepositAmount; SeatDepositAmount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Amount';
                    }
                    field(SeatDepositApprovedAmt; SeatDepositApprovedAmt)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Strong;
                        Caption = 'Approved Amount';
                    }
                }
                group("Housing Transfer")
                {
                    field(RentTransferRefundEntry; RentTransferRefundEntry)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Status';
                        OptionCaption = 'Not Applicable,Pending for Approval,Approved';
                    }
                    field(RentTransferRefundAmount; RentTransferRefundAmount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Amount';
                    }
                    field(RentTransferRefundApprovedAmt; RentTransferRefundApprovedAmt)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Strong;
                        Caption = 'Approved Amount';
                    }
                }
                group("T4 Stipend Payment")
                {
                    field(RefundEntry; RefundEntry)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Status';
                        OptionCaption = 'Not Applicable,Pending for Approval,Approved';
                    }
                    field(RefundAmount; RefundAmount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Amount';
                    }
                    field(RefundApprovedAmount; RefundApprovedAmount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Strong;
                        Caption = 'Approved Amount';
                    }
                }

                group("Refund of Student Payment")
                {
                    field(StudentPaymentEntry; StudentPaymentEntry)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Status';
                        OptionCaption = 'Not Applicable,Pending for Approval,Approved';
                    }
                    field(StudentPaymentAmount; StudentPaymentAmount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Amount';
                    }
                    field(StudentPaymentApprovedAmount; StudentPaymentApprovedAmount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Strong;
                        Caption = 'Approved Amount';
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        LivingExpenseLine: Record "Living Expense Line";
    begin
        ApplicationEntry := ApplicationEntry::"Not Applicable";
        SeatDepositEntry := SeatDepositEntry::"Not Applicable";
        RentTransferPaymentEntry := RentTransferPaymentEntry::"Not Applicable";
        RentTransferRefundEntry := RentTransferRefundEntry::"Not Applicable";
        RefundEntry := RefundEntry::"Not Applicable";
        StudentPaymentEntry := StudentPaymentEntry::"Not Applicable";

        SeatDepositAmount := 0;
        RentTransferRefundAmount := 0;
        RefundAmount := 0;
        StudentPaymentAmount := 0;

        SeatDepositApprovedAmt := 0;
        RentTransferRefundEntry := 0;
        RefundApprovedAmount := 0;
        StudentPaymentApprovedAmount := 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", Rec."No.");
        LivingExpenseLine.SetRange("Academic Year", Rec."Academic Year");
        LivingExpenseLine.SetRange(Semester, Rec.Semester);
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Application);
        if LivingExpenseLine.FindFirst() then begin
            if LivingExpenseLine.Status = LivingExpenseLine.Status::"Pending for Approval" then
                ApplicationEntry := ApplicationEntry::"Pending for Approval";
            if LivingExpenseLine.Status = LivingExpenseLine.Status::Approved then
                ApplicationEntry := ApplicationEntry::Approved;
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", Rec."No.");
        LivingExpenseLine.SetRange("Academic Year", Rec."Academic Year");
        LivingExpenseLine.SetRange(Semester, Rec.Semester);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"Seat Deposit");
        if LivingExpenseLine.FindFirst() then begin
            SeatDepositApprovedAmt := LivingExpenseLine."Posted Amount";
            SeatDepositAmount := LivingExpenseLine.Amount;

            if LivingExpenseLine.Status = LivingExpenseLine.Status::"Pending for Approval" then
                SeatDepositEntry := SeatDepositEntry::"Pending for Approval";
            if LivingExpenseLine.Status = LivingExpenseLine.Status::Approved then
                SeatDepositEntry := SeatDepositEntry::Approved;
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", Rec."No.");
        LivingExpenseLine.SetRange("Academic Year", Rec."Academic Year");
        LivingExpenseLine.SetRange(Semester, Rec.Semester);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"GV Transfer");
        LivingExpenseLine.SetRange("Document Type", LivingExpenseLine."Document Type"::Refund);
        if LivingExpenseLine.FindFirst() then begin
            RentTransferRefundApprovedAmt := LivingExpenseLine."Posted Amount";
            RentTransferRefundAmount := LivingExpenseLine.Amount;

            if LivingExpenseLine.Status = LivingExpenseLine.Status::"Pending for Approval" then
                RentTransferRefundEntry := RentTransferRefundEntry::"Pending for Approval";
            if LivingExpenseLine.Status = LivingExpenseLine.Status::Approved then
                RentTransferRefundEntry := RentTransferRefundEntry::Approved;
        end;


        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", Rec."No.");
        LivingExpenseLine.SetRange("Academic Year", Rec."Academic Year");
        LivingExpenseLine.SetRange(Semester, Rec.Semester);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"T4 Stipend Payment");
        if LivingExpenseLine.FindFirst() then begin
            RefundApprovedAmount := LivingExpenseLine."Posted Amount";
            RefundAmount := LivingExpenseLine.Amount;
            if LivingExpenseLine.Status = LivingExpenseLine.Status::"Pending for Approval" then
                RefundEntry := RefundEntry::"Pending for Approval";
            if LivingExpenseLine.Status = LivingExpenseLine.Status::Approved then
                RefundEntry := RefundEntry::Approved;
        end;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Student ID", Rec."No.");
        LivingExpenseLine.SetRange("Academic Year", Rec."Academic Year");
        LivingExpenseLine.SetRange(Semester, Rec.Semester);
        LivingExpenseLine.SetRange("Refund Type", LivingExpenseLine."Refund Type"::"Student Payment");
        if LivingExpenseLine.FindFirst() then begin
            StudentPaymentApprovedAmount := LivingExpenseLine."Posted Amount";
            StudentPaymentAmount := LivingExpenseLine.Amount;

            if LivingExpenseLine.Status = LivingExpenseLine.Status::"Pending for Approval" then
                StudentPaymentEntry := StudentPaymentEntry::"Pending for Approval";
            if LivingExpenseLine.Status = LivingExpenseLine.Status::Approved then
                StudentPaymentEntry := StudentPaymentEntry::Approved;
        end;
    end;

    var
        ApplicationEntry: Option "Not Applicable","Pending for Approval","Approved";
        SeatDepositEntry: Option "Not Applicable","Pending for Approval","Approved";
        SeatDepositAmount: Decimal;
        SeatDepositApprovedAmt: Decimal;
        RentTransferRefundEntry: Option "Not Applicable","Pending for Approval","Approved";
        RentTransferRefundAmount: Decimal;
        RentTransferRefundApprovedAmt: Decimal;
        RentTransferPaymentEntry: Option "Not Applicable","Pending for Approval","Approved";
        RefundEntry: Option "Not Applicable","Pending for Approval","Approved";
        RefundAmount: Decimal;
        RefundApprovedAmount: Decimal;
        StudentPaymentEntry: Option "Not Applicable","Pending for Approval","Approved";
        StudentPaymentAmount: Decimal;
        StudentPaymentApprovedAmount: Decimal;

}