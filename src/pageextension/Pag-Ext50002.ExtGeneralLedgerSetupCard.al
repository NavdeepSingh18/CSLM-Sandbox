pageextension 50002 ExtGeneralLedgerSetupCard extends "General Ledger Setup"
{

    layout
    {

        addafter("Max. Payment Tolerance Amount")
        {
            field("Portal Entries Auto Post"; Rec."Portal Entries Auto Post")
            {
                ApplicationArea = all;
            }


        }
        addafter(Application)
        {
            group(Numbering)
            {
                field("Payment Plan No."; Rec."Payment Plan No.")
                {
                    ApplicationArea = All;
                }
                field("Financial Accountability No."; Rec."Financial Accountability No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Change/Vacate No."; Rec."Housing Change/Vacate No.")
                {
                    ApplicationArea = All;

                }
                field("Housing Opt Out No."; Rec."Housing Opt Out No.")
                {
                    ApplicationArea = All;

                }
                field("Housing Issue No."; Rec."Housing Issue No.")
                {
                    ApplicationArea = All;

                }
                field("Housing Application No."; Rec."Housing Application No.")
                {
                    ApplicationArea = All;

                }
                field("Leave Of Absence No."; Rec."Leave Of Absence No.")
                {
                    ApplicationArea = All;

                }
                field("Housing Parking No."; Rec."Housing Parking No.")
                {
                    ApplicationArea = All;

                }
                field("Immigration Document No."; Rec."Immigration Document No.")
                {
                    ApplicationArea = All;

                }
                field("Withdrawal No."; Rec."Withdrawal No.")
                {
                    ApplicationArea = All;

                }
                field("Degree Audit Document No."; Rec."Degree Audit Document No.")
                {
                    ApplicationArea = All;

                }
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = all;
                }
            }
        }


    }

}