page 50675 "Living Expense Checking"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Living Expense Header";
    Caption = 'Living Expense Checking';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
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
            }
            // part("Posted Details"; "Living Exps Posted Details CHK")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     SubPageLink = "Document No." = field("No.");
            // }
            // part("Posting Entries"; "Living Exps Posting Entry CHK")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Document No." = field("No.");
            // }
        }
        area(Factboxes)
        {
            // part(Information; "Living Expenses FactBox")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Information';
            //     SubPageLink = "No." = field("Student ID");
            // }
        }
    }
}