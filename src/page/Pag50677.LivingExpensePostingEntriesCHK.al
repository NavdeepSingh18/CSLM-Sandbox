page 50677 "Living Exps Posting Entry CHK"
{
    Caption = 'Living Expense Posting Entries';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Living Expense Line";
    SourceTableView = where("View Part" = filter("Posting Entries" | "Application Entries" | "Past Application"));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Posting Amount"; Rec."Posting Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = PostingAmtEditable;
                }
                field("Posted Amount"; Rec."Posted Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    //Editable = false;
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
                field("Fee Group"; Rec."Fee Group")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("Fee Type"; Rec."Fee Type")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("Receipt Type"; Rec."Receipt Type")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Visible = false;
                }
                field("Applied Document No."; Rec."Applied Document No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
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

    var
        LStyle: Text[50];
        PostingAmtEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        LStyle := 'Strong';

        PostingAmtEditable := false;
        if Rec."Document Type" <> Rec."Document Type"::Application then
            PostingAmtEditable := true;
    end;
}