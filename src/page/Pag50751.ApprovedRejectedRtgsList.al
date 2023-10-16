page 50751 "Approved Rejected RTGS List"
{
    Caption = 'Approved/Rejected Wire Transfer List';
    PageType = List;
    SourceTable = "RTGS Payment Summary-CS";
    CardPageId = "Approved Rejected RTGS Card";
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTableView = Where(Status = filter(Approved | Rejected));
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Number"; Rec."Transaction Number")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Fee Amount"; Rec."Fee Amount")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Remitter Name"; Rec."Remitter Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                }
                field("Rejected Date"; Rec."Rejected Date")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Customer Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Customer Card';
                Runobject = page "Customer Card";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Customer Ledger Entries")
            {
                ApplicationArea = All;
                Image = Ledger;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Customer Ledger Entries';
                Runobject = page "Customer Ledger Entries";
                RunPageLink = "Customer No." = FIELD("Student No.");
            }
        }
    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}

