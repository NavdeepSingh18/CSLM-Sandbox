page 50752 "Approved Rejected RTGS Card"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    07-01-2019    Approve - OnAction                  Call Function for Approval.
    // 2         CSPL-00092    07-01-2019    Reject - OnAction                   Call Function for Reject
    Caption = 'Approved/Rejected Wire Transfer Card';
    PageType = Card;
    SourceTable = "RTGS Payment Summary-CS";
    UsageCategory = None;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    SourceTableView = Where(Status = filter(Approved | Rejected));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No.';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                field("Transaction Number"; Rec."Transaction Number")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Payment Date';
                    ApplicationArea = All;
                }
                field("Fee Amount"; Rec."Fee Amount")
                {
                    ToolTip = 'Fee Amount';
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Bank Name';
                    ApplicationArea = All;
                }
                field("Remitter Name"; Rec."Remitter Name")
                {
                    ToolTip = 'Remitter Name';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Remarks';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ToolTip = 'Requested Date';
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Requested By';
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Approved By';
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ToolTip = 'Approved Date';
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ToolTip = 'Rejected By';
                    ApplicationArea = All;
                }
                field("Rejected Date"; Rec."Rejected Date")
                {
                    ToolTip = 'Rejected Date';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
            part("RTGS SubPage"; "RTGS SubPage")
            {
                SubPageLink = "Document No." = FIELD("Request No.");
                ApplicationArea = All;
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
}

