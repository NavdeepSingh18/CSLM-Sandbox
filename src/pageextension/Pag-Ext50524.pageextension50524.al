pageextension 50524 "pageextension50524" extends "Chart of Accounts"
{
    // version NAVW19.00.00.45778-CS


    //Unsupported feature: Property Insertion (Editable) on ""Chart of Accounts"(Page 16)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Chart of Accounts"(Page 16)".
    layout
    {

    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        RoleAndPermissionNew();
    end;

    procedure RoleAndPermissionNew()
    Var
        usersetupapprover: Record "Document Approver Users";
    begin

        usersetupapprover.Reset();
        usersetupapprover.setrange("User ID", UserId);
        if usersetupapprover.FindFirst() then begin
            if not (usersetupapprover."Department Approver Type" IN [usersetupapprover."Department Approver Type"::"Financial Aid Department", usersetupapprover."Department Approver Type"::" ",
                                                                usersetupapprover."Department Approver Type"::BackOffice, usersetupapprover."Department Approver Type"::"Bursar Department"]) then
                Error('You are not authorized');
        end;

    end;

}

