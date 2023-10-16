page 50833 BackOfficeRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueBackOffice;
    Caption = 'Role Center Back Office';

    layout
    {
        area(Content)
        {
            cuegroup(BackOffice)
            {
                field("Pending Purchase Quotes"; Rec."Pending Purchase Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Quotes";
                }

                field("Pending Purchase Orders"; Rec."Pending Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Order List";
                }
                field("Pending Purchase Invoice"; Rec."Pending Purchase Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Invoices";
                }
                field("Request to Approve-Purchasing"; Rec."Request to Approve-Purchasing")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Trnfr. Ord.-Shd. but not Rec."; Rec."Trnfr. Ord.-Shd. but not Rec.")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Transfer Orders";
                }
                field("Pending Purchase Cr. Memo"; Rec."Pending Purchase Cr. Memo")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Credit Memos";
                }
                field("Hospital wise Invoices not Updated"; Rec."Hospital wise Inv. not Updated")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Roster Ledger Entries";
                }
                field("Hospital wise Check No. not Updated"; Rec."Hospitalwise Check No not Upd")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Roster Ledger Entries";
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        BackOfficeRoleCenter: Record RoleCenterCueBackOffice;
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;
        UserSetup.Get(UserId());
        BackOfficeRoleCenter.Get();
        BackOfficeRoleCenter."Institute Code" := UserSetup."Global Dimension 1 Code";
        BackOfficeRoleCenter.Modify();
        if UserSetup."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup."Global Dimension 1 Code") < 6 then
                Rec.SetFilter("Institute Code", '%1', Format(UserSetup."Global Dimension 1 Code"));
        Rec.SetFilter("User ID Filter", UserId());
    end;
}