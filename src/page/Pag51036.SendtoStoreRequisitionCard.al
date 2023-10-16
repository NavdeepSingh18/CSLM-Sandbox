page 51036 "Send to Store History Card"
{
    PageType = Document;
    UsageCategory = None;
    SourceTable = "Requisition Header";
    DeleteAllowed = false;
    // InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }

            }
            part("Send to Store history SubPage"; "Send to Store history SubPage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                // SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type"), Status = field("Approval Status");
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Requisition Report")
            {
                ApplicationArea = All;
                PromotedCategory = Report;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RequisitionHdr: Record "Requisition Header";
                    RequisitionReport: Report "Requisition Report";
                Begin
                    Clear(RequisitionReport);
                    RequisitionHdr.Reset();
                    RequisitionHdr.SetRange("No.", Rec."No.");
                    RequisitionReport.SetTableView(RequisitionHdr);
                    RequisitionReport.Run();
                End;
            }
        }
    }
}