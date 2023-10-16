pageextension 50583 "pageextension50583" extends "Payment Journal"
{
    layout
    {
        modify("Document No.")
        {
            Editable = False;
        }
        addafter("Payment Method Code")
        {
            field("Course"; Rec."Course")
            {
                ApplicationArea = All;
            }
            field("Enrollment No."; Rec."Enrollment No.")
            {
                ApplicationArea = All;
            }
            field(Semester; Rec.Semester)
            {
                ApplicationArea = All;
            }
            field(Year; Rec.Year)
            {
                ApplicationArea = All;
            }
            field("Academic Year"; Rec."Academic Year")
            {
                ApplicationArea = All;
            }
            field(Term; Rec.Term)
            {
                ApplicationArea = All;
            }
            field("SAP G/L Account"; Rec."SAP G/L Account")
            {
                ApplicationArea = All;
            }
            field("SAP Profit Centre"; Rec."SAP Profit Centre")
            {
                ApplicationArea = All;
            }
            field("SAP Bus. Area"; Rec."SAP Bus. Area")
            {
                ApplicationArea = All;
            }
            field("SAP Company Code"; Rec."SAP Company Code")
            {
                ApplicationArea = All;
            }


        }
        modify("Recipient Bank Account")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Applied (Yes/No)")
        {
            Visible = false;
        }


        moveafter("Check Printed"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Shortcut Dimension 2 Code"; ShortcutDimCode3)

        addafter(ShortcutDimCode3)
        {
            field("Payment By Financial Aid"; Rec."Payment By Financial Aid")
            {
                ApplicationArea = All;
            }
            field("Fund Type"; Rec."Fund Type")
            {
                ApplicationArea = All;
            }
            field("Deposit Type"; Rec."Deposit Type")
            {
                ApplicationArea = All;
            }
        }
    }

}