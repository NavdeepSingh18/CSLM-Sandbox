pageextension 50509 "pageextension50509" extends "Bank Account Card"
{

    layout
    {
        addafter("Bank Account No.")
        {
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
            field("Beneficiary ABA No."; Rec."Beneficiary ABA No.")
            {
                ApplicationArea = All;
            }
            field("Statement of Accounts"; Rec."Statement of Accounts")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Name"; Rec."Beneficiary Name")
            {
                ApplicationArea = all;
            }
        }
    }
    var

    trigger OnClosePage()
    begin
        Rec.TestField("SAP Company Code");
        Rec.TestField("SAP Bus. Area");
        Rec.TestField("SAP Profit Centre");
        Rec.TestField("SAP G/L Account");

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.TestField("SAP Company Code");
        Rec.TestField("SAP Bus. Area");
        Rec.TestField("SAP Profit Centre");
        Rec.TestField("SAP G/L Account");

    end;

    trigger OnOpenPage()
    begin
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

