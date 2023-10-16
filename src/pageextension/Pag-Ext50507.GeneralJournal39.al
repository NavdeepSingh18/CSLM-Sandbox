pageextension 50507 ExtendGeneralJournal extends "General Journal"
{
    layout
    {
        modify("Document No.")
        {
            Editable = false;
        }
        addbefore("Account Type")
        {
            field("Fee Code"; Rec."Fee Code")
            {
                ApplicationArea = All;
                Style = Strong;
            }
            field("Fee Description"; Rec."Fee Description")
            {
                ApplicationArea = All;
                Editable = False;
            }
        }
        addafter("Bal. Account No.")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Cheque No."; Rec."Cheque Nos.")
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; Rec."Cheque Dates")
            {
                ApplicationArea = All;
            }
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
            field("SAP Code"; Rec."SAP Code")
            {
                ApplicationArea = All;
            }
            field("SAP Description"; Rec."SAP Description")
            {
                ApplicationArea = All;
            }
            field("Waiver/Scholar/Grant Code"; Rec."Waiver/Scholar/Grant Code")
            {
                ApplicationArea = All;
            }
            field("Waiver/Scholar/Grant Desc"; Rec."Waiver/Scholar/Grant Desc")
            {
                ApplicationArea = All;
            }

        }


        moveafter("SAP Description"; "Currency Code")
        moveafter("Currency Code"; "Shortcut Dimension 1 Code")
        moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        moveafter("Shortcut Dimension 2 Code"; ShortcutDimCode3)
        moveafter(ShortcutDimCode3; "Applies-to Doc. Type")
        moveafter("Applies-to Doc. Type"; "Applies-to Doc. No.")


        addafter("Applies-to Doc. No.")
        {
            field("Source Code"; Rec."Source Code")
            {
                ApplicationArea = All;
            }
            field("Financial Aid Approved"; Rec."Financial Aid Approved")
            {
                ApplicationArea = All;
            }
            field("Payment Plan Applied"; Rec."Payment Plan Applied")
            {
                ApplicationArea = All;
            }
            field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
            {
                ApplicationArea = All;
            }
            field("Self Payment Applied"; Rec."Self Payment Applied")
            {
                ApplicationArea = All;
            }

        }


        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        // modify("Tax Liable")
        // {
        //     Visible = false;
        // }
        // modify("Tax Area Code")
        // {
        //     Visible = false;
        // }
        // modify("Tax Group Code")
        // {
        //     Visible = false;
        // }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Business Unit Code")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = true;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = True;
        }

    }
}