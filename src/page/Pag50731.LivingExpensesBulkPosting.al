page 50731 "Living Expenses Bulk Posting"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Living Expense Header";
    SourceTableView = sorting("Student ID") where(Status = filter(Open));
    CardPageId = "Living Expense";
    Caption = 'Living Expenses Bulk Posting';
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
                field("T4 Authorization"; Rec."T4 Authorization")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(LivingExps; LivingExps)
                {
                    Caption = 'Living Expenses';
                    OptionCaption = ' ,YES,NO';
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
                field(HousingFee; HousingFee)
                {
                    Caption = 'Housing Fees';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(FAPaymentGP; FAPaymentGP)
                {
                    Caption = 'Grad Plus';
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(FAPaymentUS; FAPaymentUS)
                {
                    Caption = 'Unsubsidized';
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
                    Caption = 'Scholarships';
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
                    Caption = 'T4 Stipend';
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

    actions
    {
        area(Processing)
        {
            action("Post Entries")
            {
                ApplicationArea = All;
                Caption = 'Post Entries';
                ShortcutKey = 'F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostBatch;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                    LivingExpenseHeader: Record "Living Expense Header";
                    T: Integer;
                    C: Integer;
                    W: Dialog;
                    Text001Lbl: Label 'Students In Progress....      ##################1################\';
                begin
                    T := 0;
                    C := 0;
                    LivingExpenseHeader.Reset();
                    CurrPage.SetSelectionFilter(LivingExpenseHeader);
                    T := LivingExpenseHeader.Count();

                    if not Confirm('You have Selected %1 Students.\\\\Do you want to Post Entries for Selected Students?', true, T) then
                        exit;

                    W.Open('Posting Entries\' + Text001Lbl);

                    if LivingExpenseHeader.Findset() then
                        repeat
                            C := C + 1;
                            W.Update(1, Format(C) + ' of ' + Format(T));
                            StudentMaster.Reset();
                            if StudentMaster.Get(LivingExpenseHeader."Student ID") then begin
                                Rec.PostApplication(StudentMaster, LivingExpenseHeader."No.", true);
                                Rec.InitialiseSeatDepositRefundPostingEntry(StudentMaster, true, LivingExpenseHeader."No.");
                                Rec.InitialiseGVTransferRefundPostingEntry(StudentMaster, true, LivingExpenseHeader."No.");
                                Rec.InitialiseT4RefundPostingEntry(StudentMaster, true, LivingExpenseHeader."No.");
                                Rec.InitialiseStudentPaymentRefundPostingEntry(StudentMaster, true, LivingExpenseHeader."No.");
                            end;
                        until LivingExpenseHeader.Next() = 0;

                    Message('Process of Entry Posting is Completed Successfully.');
                end;
            }

            action("Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Ledger E&ntries';
                Image = CustomerLedger;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F7';
                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    CustomerLedgerEntries: Page "Customer Ledger Entries";
                begin
                    CLE.Reset();
                    CLE.SetCurrentKey("Customer No.");
                    CLE.FilterGroup(2);
                    CLE.SetRange("Customer No.", Rec."Student ID");
                    CLE.FilterGroup(0);
                    CustomerLedgerEntries.Editable := false;
                    CustomerLedgerEntries.SetTableView(CLE);
                    CustomerLedgerEntries.RunModal();
                end;
            }

            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Card;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F5';
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    StudentDetailCard: Page "Student Detail Card-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."Student ID");
                    StudentMaster.FilterGroup(0);
                    StudentDetailCard.SetTableView(StudentMaster);
                    StudentDetailCard.Editable(false);
                    StudentDetailCard.RunModal();
                end;
            }
        }
    }
    var
        LivingExps: Option " ",YES,NO;
        PastBalance: Decimal;
        SeatDeposit: Decimal;
        HousingDeposit: Decimal;
        InstitutionalFee: Decimal;
        NonInstitutionalFee: Decimal;
        HousingFee: Decimal;
        FAPaymentGP: Decimal;
        FAPaymentUS: Decimal;
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

    trigger OnOpenPage()
    var
        StudentMaster: Record "Student Master-CS";
        LivingExpenseHeader: Record "Living Expense Header";
        T: Integer;
        C: Integer;
        W: Dialog;
        Text001Lbl: Label 'Records In Progress....      ##################1################\';
    begin
        W.Open('Checking Status....\' + Text001Lbl);
        if LivingExpenseHeader.Findset() then begin
            T := LivingExpenseHeader.Count;
            C := 0;
            repeat
                C := C + 1;
                W.Update(1, Format(C) + ' of ' + Format(T));
                StudentMaster.Reset();
                if StudentMaster.Get(LivingExpenseHeader."Student ID") then
                    Rec.UpdateStatus(LivingExpenseHeader."No.", StudentMaster);
            until LivingExpenseHeader.Next() = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        LivingExpenseLine: Record "Living Expense Line";
        FinancialAID: Record "Financial AID";
    begin
        PastBalance := 0;
        SeatDeposit := 0;
        HousingDeposit := 0;
        InstitutionalFee := 0;
        NonInstitutionalFee := 0;
        HousingFee := 0;
        FAPaymentGP := 0;
        FAPaymentUS := 0;
        StudentPayment := 0;
        Scholarship := 0;
        T4Advance := 0;
        T4StipendPaymentAdvance := 0;
        SeatDepositRefund := 0;
        HousingTransferRefund := 0;
        HousingTransferPayment := 0;
        T4StipendPayment := 0;
        RefundofStudentPayment := 0;

        LivingExps := LivingExps::" ";
        FinancialAID.Reset();
        FinancialAID.SetRange("Student No.", Rec."Student ID");
        //FinancialAID.SetRange("Academic Year", "Academic Year");Rec. //TO BE OPEN
        FinancialAID.SetRange(Semester, Rec.Semester);
        if FinancialAID.FindLast() then;
        LivingExps := FinancialAID."Living expenses";

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
        LivingExpenseLine.SetRange("Global Dimension 2 Code", '');
        LivingExpenseLine.CalcSums(Amount);
        NonInstitutionalFee := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetRange("Entry Type", LivingExpenseLine."Entry Type"::"Non-Institutional");
        LivingExpenseLine.SetFilter("Global Dimension 2 Code", '<>%1', '');
        LivingExpenseLine.CalcSums(Amount);
        HousingFee := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetFilter("Entry Type", '%1', LivingExpenseLine."Entry Type"::"Grad Plus");
        LivingExpenseLine.CalcSums(Amount);
        FAPaymentGP := LivingExpenseLine.Amount;

        LivingExpenseLine.Reset();
        LivingExpenseLine.SetRange("Document No.", Rec."No.");
        LivingExpenseLine.SetRange("Student ID", Rec."Student ID");
        LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Posted Entries");
        LivingExpenseLine.SetFilter("Entry Type", '%1', LivingExpenseLine."Entry Type"::Unsubsidized);
        LivingExpenseLine.CalcSums(Amount);
        FAPaymentUS := LivingExpenseLine.Amount;

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