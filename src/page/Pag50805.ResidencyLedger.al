page 50805 "Residency Ledger"
{
    Caption = 'Residency Ledger';
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Residency Ledger";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Residency No."; Rec."Residency No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Residency Specialty"; Rec."Residency Specialty")
                {
                    ApplicationArea = All;
                }
                field("Hospital Country"; Rec."Hospital Country")
                {
                    ApplicationArea = All;
                }
                field("Hospital State"; Rec."Hospital State")
                {
                    ApplicationArea = All;
                }
                field("Hospital City"; Rec."Hospital City")
                {
                    ApplicationArea = All;
                }
                field("Residency Status"; Rec."Residency Status")
                {
                    ApplicationArea = All;
                }
                field("NRMP Status"; Rec."NRMP Status")
                {
                    ApplicationArea = All;
                }
                field("CaRMS Status"; Rec."CaRMS Status")
                {
                    ApplicationArea = All;
                }
                field("San Francisco Status"; Rec."San Francisco Status")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }

            }

        }
    }
}