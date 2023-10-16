page 50676 "Living Exps Posted Details CHK"
{
    Caption = 'Living Expense Posted Details';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Living Expense Line";
    SourceTableView = where("View Part" = filter("Posted Entries"));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            label(BeforeEntryNo)
            {
                ApplicationArea = All;
                Caption = 'All Debit Entries are shown in "Black" & Credit Entries in "Red"';
                Style = Strong;
            }
            repeater("General")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Entry Document No."; Rec."Entry Document No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Fee Description"; Rec."Fee Description")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    begin
                        DtldCustLedgEntry.Reset();
                        DtldCustLedgEntry.FilterGroup(2);
                        DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", Rec."Cust. Ledger Entry No.");
                        DtldCustLedgEntry.FilterGroup(0);
                        Page.RunModal(Page::"Detailed Cust. Ledg. Entries", DtldCustLedgEntry);
                    end;
                }
                field("Provisional Remaining Amount"; Rec."Provisional Remaining Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Receipt Type"; Rec."Receipt Type")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("G/L Entry No."; Rec."G/L Entry No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("Cust. Ledger Entry No."; Rec."Cust. Ledger Entry No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("General Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'General Ledger Entries';
                Image = GeneralLedger;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ShortCutKey = 'Alt+G';
                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    GeneralLedgerEntries: Page "General Ledger Entries";
                begin
                    GLEntry.Reset();
                    GLEntry.SetCurrentKey("Document No.");
                    GLEntry.FilterGroup(2);
                    GLEntry.SetRange("Document No.", Rec."Entry Document No.");
                    GLEntry.FilterGroup(0);
                    GeneralLedgerEntries.Editable := false;
                    GeneralLedgerEntries.SetTableView(GLEntry);
                    GeneralLedgerEntries.RunModal();
                end;
            }
            action("Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Ledger E&ntries';
                Image = CustomerLedger;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ShortCutKey = 'Alt+C';
                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    CustomerLedgerEntries: Page "Customer Ledger Entries";
                begin
                    CLE.Reset();
                    CLE.SetCurrentKey("Customer No.");
                    CLE.FilterGroup(2);
                    CLE.SetRange("Customer No.", Rec."Student ID");
                    CLE.SetRange("Document No.", Rec."Entry Document No.");
                    CLE.FilterGroup(0);
                    CustomerLedgerEntries.Editable := false;
                    CustomerLedgerEntries.SetTableView(CLE);
                    CustomerLedgerEntries.RunModal();
                end;
            }
        }
    }

    var
        LStyle: Text[50];

    trigger OnAfterGetRecord()
    begin
        if Rec.Amount > 0 then
            LStyle := 'Strong';
        if Rec.Amount < 0 then
            LStyle := 'Unfavorable';
    end;
}