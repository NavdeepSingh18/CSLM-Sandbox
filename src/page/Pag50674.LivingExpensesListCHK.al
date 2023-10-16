page 50674 "Living Expenses Checking List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Living Expense Header";
    SourceTableView = where(Status = filter(Open));
    CardPageId = "Living Expense Checking";
    Caption = 'Living Expenses Checking';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(PastBalance; PastBalance)
                {
                    Caption = 'Past Balance';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(SeatDeposit; SeatDeposit)
                {
                    Caption = 'Seat Deposit';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(HousingDeposit; HousingDeposit)
                {
                    Caption = 'HousingDeposit';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(InstitutionalFee; InstitutionalFee)
                {
                    Caption = 'Institutional Fees';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(NonInstitutionalFee; NonInstitutionalFee)
                {
                    Caption = 'Non Institutional Fees';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(FAPayment; FAPayment)
                {
                    Caption = 'Financial Aid Payment';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(StudentPayment; StudentPayment)
                {
                    Caption = 'Student''s Payment';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Scholarship; Scholarship)
                {
                    Caption = 'Scholarship Amount';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(T4Advance; T4Advance)
                {
                    Caption = 'T4 Advance';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(T4StipendPaymentAdvance; T4StipendPaymentAdvance)
                {
                    Caption = 'T4 Stipend Payment Advance';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(ApplyEntry; ApplyEntry)
                {
                    Caption = 'Apply Entry';
                    OptionCaption = '"Pending for Approval",Approved';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(SeatDepositRefund; SeatDepositRefund)
                {
                    Caption = 'Refund of Seat Deposit';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(HousingTransferRefund; HousingTransferRefund)
                {
                    Caption = 'Housing Transfer Refund';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(HousingTransferPayment; HousingTransferPayment)
                {
                    Caption = 'Housing Transfer Payment';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(T4StipendPayment; T4StipendPayment)
                {
                    Caption = 'T4 Stipend Payment';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(RefundofStudentPayment; RefundofStudentPayment)
                {
                    Caption = 'Refund of Student Payment';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
            }
        }
    }


    var
        PastBalance: Decimal;
        SeatDeposit: Decimal;
        HousingDeposit: Decimal;
        InstitutionalFee: Decimal;
        NonInstitutionalFee: Decimal;
        FAPayment: Decimal;
        StudentPayment: Decimal;
        Scholarship: Decimal;
        T4Advance: Decimal;
        T4StipendPaymentAdvance: Decimal;
        ApplyEntry: Option "Pending for Approval",Approved;
        SeatDepositRefund: Decimal;
        HousingTransferRefund: Decimal;
        HousingTransferPayment: Decimal;
        T4StipendPayment: Decimal;
        RefundofStudentPayment: Decimal;


    trigger OnAfterGetRecord()
    var
        LivingExpenseLine: Record "Living Expense Line";
    begin
        PastBalance := 0;
        SeatDeposit := 0;
        HousingDeposit := 0;
        InstitutionalFee := 0;
        NonInstitutionalFee := 0;
        FAPayment := 0;
        StudentPayment := 0;
        Scholarship := 0;
        T4Advance := 0;
        T4StipendPaymentAdvance := 0;
        SeatDepositRefund := 0;
        HousingTransferRefund := 0;
        HousingTransferPayment := 0;
        T4StipendPayment := 0;
        RefundofStudentPayment := 0;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Past Balance");
        LivingExpenseLine.CalcSums(Amount);
        PastBalance := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Seat Deposit");
        LivingExpenseLine.CalcSums(Amount);
        SeatDeposit := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Housing Deposit");
        LivingExpenseLine.CalcSums(Amount);
        HousingDeposit := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::Institutional);
        LivingExpenseLine.CalcSums(Amount);
        InstitutionalFee := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Non-Institutional");
        LivingExpenseLine.CalcSums(Amount);
        NonInstitutionalFee := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetFilter("Entry Type", '%1|%2', LivingExpenseLine."Entry Type"::"Grad Plus", LivingExpenseLine."Entry Type"::Unsubsidized);
        LivingExpenseLine.CalcSums(Amount);
        FAPayment := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Student Payment");
        LivingExpenseLine.CalcSums(Amount);
        StudentPayment := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::Scholarship);
        LivingExpenseLine.CalcSums(Amount);
        Scholarship := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"T4 Advance");
        LivingExpenseLine.CalcSums(Amount);
        T4Advance := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"T4 Stipend Payment Advance");
        LivingExpenseLine.CalcSums(Amount);
        T4StipendPaymentAdvance := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Application Entries");
        LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::"Pending for Approval");
        if LivingExpenseLine.FindFirst() then
            ApplyEntry := ApplyEntry::"Pending for Approval"
        else
            ApplyEntry := ApplyEntry::Approved;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posting Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Seat Deposit Refund");
        LivingExpenseLine.CalcSums(Amount);
        SeatDepositRefund := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posting Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Rent Transfer Refund");
        LivingExpenseLine.CalcSums(Amount);
        HousingTransferRefund := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posting Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Rent Transfer Payment");
        LivingExpenseLine.CalcSums(Amount);
        HousingTransferPayment := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posting Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"T4 Stipend Payment");
        LivingExpenseLine.CalcSums(Amount);
        T4StipendPayment := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posting Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Refund of Student Payment");
        LivingExpenseLine.CalcSums(Amount);
        RefundofStudentPayment := LivingExpenseLine.Amount;
    end;
}