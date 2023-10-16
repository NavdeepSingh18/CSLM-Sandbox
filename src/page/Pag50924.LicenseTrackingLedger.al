page 50924 "License Tracking Ledger"
{
    Caption = 'License Tracking Ledger';
    Editable = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "License Tracking Ledger";
    SourceTableView = sorting("Entry No.");

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("License ID"; Rec."License ID")
                {
                    ApplicationArea = All;
                }
                field("License Type"; Rec."License Type")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(Expiration; Rec.Expiration)
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