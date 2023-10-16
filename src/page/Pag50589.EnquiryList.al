page 50589 "Enquiry List"
{

    PageType = List;
    SourceTable = "Enquiry-CS";
    Caption = 'Enquiry List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("18 Digit ID"; Rec."18 Digit ID")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = all;
                }
                field("Application ID"; Rec."Application ID")
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = all;
                }
                field("Application Sub-type"; Rec."Application Sub-type")
                {
                    ApplicationArea = All;
                }
                field("Deposit Paid Date"; Rec."Deposit Paid Date")
                {
                    ApplicationArea = All;
                }
                field("Deposit Waived"; Rec."Deposit Waived")
                {
                    ApplicationArea = All;
                }

                field(Housing; Rec.Housing)
                {
                    ApplicationArea = all;
                }
                field("Housing/Waiver Application No."; Rec."Housing/Waiver Application No.")
                {
                    ApplicationArea = all;
                }

                field("Housing Deposit Date"; Rec."Housing Deposit Date")
                {
                    ApplicationArea = All;
                }
                field("Housing Deposit Waived"; Rec."Housing Deposit Waived")
                {
                    ApplicationArea = All;
                }

                field("Seat Deposit Paid"; Rec."Seat Deposit Paid")
                {
                    ApplicationArea = All;
                }
                field("Student Accepted Date"; Rec."Student Accepted Date")
                {
                    ApplicationArea = All;
                }
                field("Sub-Stage"; Rec."Sub-Stage")
                {
                    ApplicationArea = All;
                }
                
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
