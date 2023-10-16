pageextension 50584 "pageextension50584" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Receipt No."; Rec."Receipt No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Course"; Rec."Course Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Enrollment No."; Rec."Enrollment No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Semester; Rec.Semester)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Year; Rec.Year)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Academic Year"; Rec."Academic Year")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Term; Rec.Term)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Financial Aid Approved"; Rec."Financial Aid Approved")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Payment Plan Applied"; Rec."Payment Plan Applied")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Payment By Financial Aid"; Rec."Payment By Financial Aid")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Self Payment Applied"; Rec."Self Payment Applied")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Fund Type"; Rec."Fund Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Waiver/Scholar/Grant Code"; Rec."Waiver/Scholar/Grant Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Waiver/Scholar/Grant Desc"; Rec."Waiver/Scholar/Grant Desc")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Reason; Rec.Reason)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Item Code"; Rec."Item Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Paid; Rec.Paid)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Payment Status"; Rec."Payment Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Processed Date"; Rec."Processed Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Student Application"; Rec."Student Application")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Transaction ID"; Rec."Transaction ID")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Transaction Status"; Rec."Transaction Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Transaction Sub-Type"; Rec."Transaction Sub-Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Transaction Type"; Rec."Transaction Types")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("18 Digit Transaction ID"; Rec."18 Digit Transaction ID")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Deposit Type"; Rec."Deposit Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Fee Code"; Rec."Fee Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Fee Description"; Rec."Fee Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            Field("1098-T From"; Rec."1098-T From")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }

        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Rec."Entry No.");
        RoleAndPermissionNew();
    end;

    var
        UserSetup: Record "User Setup";

    procedure RoleAndPermissionNew()
    var
        usersetupapprover: record "Document Approver Users";
    begin


        usersetupapprover.Reset();
        usersetupapprover.setrange("User ID", UserId);
        if usersetupapprover.FindFirst() then begin
            if not (usersetupapprover."Department Approver Type" IN [usersetupapprover."Department Approver Type"::"Financial Aid Department", usersetupapprover."Department Approver Type"::" ",
                                                                usersetupapprover."Department Approver Type"::BackOffice, usersetupapprover."Department Approver Type"::"Bursar Department"]) then
                Error('You are not authorized');
        end;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" <> UserSetup."Department Approver"::"Financial Aid Department") or
        //     (UserSetup."Department Approver" <> UserSetup."Department Approver"::" ") or (UserSetup."Department Approver" <> UserSetup."Department Approver"::BackOffice) or
        //     (UserSetup."Department Approver" <> UserSetup."Department Approver"::"Bursar Department") then
        //         Error('You are not authorized');

    end;
}