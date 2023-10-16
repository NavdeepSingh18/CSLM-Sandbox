pageextension 50051 "PgExtVendorList" extends "Vendor List"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Sub Type"; Rec."Vendor Sub Type")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RoleAndPermissionNew();
    end;

    procedure RoleAndPermissionNew()
    var
        usersetupapprover: record "Document Approver Users";
    begin

        usersetupapprover.Reset();
        usersetupapprover.setrange("User ID", UserId);
        if usersetupapprover.FindFirst() then begin
            if not (usersetupapprover."Department Approver Type" IN [usersetupapprover."Department Approver Type"::"Financial Aid Department", usersetupapprover."Department Approver Type"::" ",
                                                                usersetupapprover."Department Approver Type"::BackOffice, usersetupapprover."Department Approver Type"::"Bursar Department", usersetupapprover."Department Approver Type"::"Clinical Details"]) then
                Error('You are not authorized');
        end;
    end;
}