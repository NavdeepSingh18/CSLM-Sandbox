page 50167 "Setup Fee-CS"
{
    // version V.001-CS

    Caption = 'Fee Setup';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Fee Setup-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = EditList;

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Course Fee No"; Rec."Course Fee No")
                {
                    ApplicationArea = All;
                }
                field("Fee Invoice No."; Rec."Fee Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Installment Scheme"; Rec."Installment Scheme")
                {
                    ApplicationArea = All;
                }
                field("No Of Installment"; Rec."No Of Installment")
                {
                    ApplicationArea = All;
                }
                field("Installment Charges"; Rec."Installment Charges")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Template Name"; Rec."Payment Plan Template Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Batch Name"; Rec."Payment Plan Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Other Fee Template Name"; Rec."Other Fee Template Name")
                {
                    ApplicationArea = All;
                }
                field("Other Fee Batch Name"; Rec."Other Fee Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Template Name"; Rec."Payment Template Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Batch Name"; Rec."Payment Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Receipt Batch"; Rec."Receipt Batch")
                {
                    ApplicationArea = All;
                }

                field("Seat Deposit Payment Batch"; Rec."Seat Deposit Payment Batch")
                {
                    ApplicationArea = all;
                }
                field("Housing Deposit Payment Batch"; Rec."Housing Deposit Payment Batch")
                {
                    ApplicationArea = all;
                }
                field("Financial Aid Payment Bank"; Rec."Financial Aid Payment Bank")
                {
                    ApplicationArea = All;
                }
                field("Living Exps Document Nos."; Rec."Living Exps Document Nos.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Living Expense Template"; Rec."Living Expense Template")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Living Expense Batch"; Rec."Living Expense Batch")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Regular Refund Bank No."; Rec."Regular Refund Bank No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("GV Transfer Payment Bank No."; Rec."GV Transfer Payment Bank No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("ScholarShip Template Name"; Rec."ScholarShip Template Name")
                {
                    ApplicationArea = All;
                }
                field("ScholarShip Batch Name"; Rec."ScholarShip Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Wired Transfer Nos."; Rec."Wired Transfer Nos.")
                {
                    ApplicationArea = All;
                }
                field("Wired Transfer Template Name"; Rec."Wired Transfer Template Name")
                {
                    ApplicationArea = All;
                }
                field("Wired Transfer Batch Name"; Rec."Wired Transfer Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Fee Bank Account No."; Rec."Fee Bank Account No.")
                {
                    ApplicationArea = All;//SD-SN-18-Dec-2020 + 
                }

                field("AUA Housing Bank Account No."; Rec."AUA Housing Bank Account No.")
                {
                    ApplicationArea = All;//SD-SN-18-Dec-2020 +
                }
                field("Grenville Bank Account No."; Rec."Grenville Bank Account No.")
                {
                    ApplicationArea = All;//SD-SN-18-Dec-2020 +
                }
                field("Other Fee No."; Rec."Other Fee No.")
                {
                    ApplicationArea = All;
                }
                field("Fin Account Template Name"; Rec."Fin Account Template Name")
                {
                    ApplicationArea = All;
                }
                field("Fin Acc Batch Name"; Rec."Fin Acc Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Fin Acc Due Date"; Rec."Fin Acc Due Date")
                {
                    ApplicationArea = All;
                }
                field("Fee Discount No."; Rec."Fee Discount No.")
                {
                    ApplicationArea = All;
                }
                field("Exam Fee Code"; Rec."Exam Fee Code")
                {
                    ApplicationArea = All;
                }
                field("Attendance Fine Code"; Rec."Attendance Fine Code")
                {
                    ApplicationArea = All;
                }
                field("Discount No."; Rec."Discount No.")
                {
                    ApplicationArea = All;
                }
                field("Fee Discount"; Rec."Fee Discount")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Detail No."; Rec."Scholarship Detail No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Template Name"; Rec."Withdrawal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Batch Name"; Rec."Withdrawal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal G/L Account No."; Rec."Withdrawal G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Document No."; Rec."Withdrawal Document No.")
                {
                    ApplicationArea = All;
                }
                field("Waiver Auto Post"; Rec."Waiver Auto Post")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan No."; Rec."Payment Plan No.")
                {
                    ApplicationArea = all;
                }
                field("Financial AID No."; Rec."Financial AID No.")
                {
                    ApplicationArea = all;
                }
                field("Fin. Aid Exp. Date Formula"; Rec."Fin. Aid Exp. Date Formula")
                {
                    ApplicationArea = all;
                }
                field("Unsubsidized Budgetted Amount"; Rec."Unsubsidized Budgetted Amount")
                {
                    ApplicationArea = All;
                }
                field("Graduate Plus Budgetted Amount"; Rec."Graduate Plus Budgetted Amount")
                {
                    ApplicationArea = All;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = All;
                }

            }
            group("SAP Intigration")
            {
                Editable = EditList;
                field("SAP Bus. Area"; Rec."SAP Bus. Area")
                {
                    ApplicationArea = All;
                }
                field("SAP Profit Centre"; Rec."SAP Profit Centre")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Fee Setup Allowed" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;

    end;

    var
        UserSetup: Record "User Setup";
        EditList: Boolean;
}

