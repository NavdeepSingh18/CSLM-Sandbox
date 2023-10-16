pageextension 50581 ExtendGeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field("SAP Code"; Rec."SAP Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP G/L Account"; Rec."SAP G/L Account")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP Assignment Code"; Rec."SAP Assignment Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP Description"; Rec."SAP Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP Cost Centre"; Rec."SAP Cost Centre")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP Profit Centre"; Rec."SAP Profit Centre")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP Company Code"; Rec."SAP Company Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SAP Bus. Area"; Rec."SAP Bus. Area")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Fee Group"; Rec."Fee Group")
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
            field("Roster Entry No."; Rec."Roster Entry No.")
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
            field("Student No."; Rec."Student No.")
            {
                ApplicationArea = all;
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