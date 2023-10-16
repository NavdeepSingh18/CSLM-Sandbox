page 50563 "Requistion Completed Card"
{
    PageType = Document;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Requisition Header";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                // Editable = editgroups;

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
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
            }
            part("Requisition Complete Subpage"; "Requisition Completed Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action("Requisition Report")
            {
                ApplicationArea = all;
                Image = Report;
                trigger OnAction()
                var
                begin
                    RecReqHeader.RESET();
                    RecReqHeader.SETRANGE(RecReqHeader."Document Type", Rec."Document Type");
                    RecReqHeader.SETRANGE(RecReqHeader."No.", Rec."No.");
                    IF RecReqHeader.FIND('-') THEN
                        REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
                end;
            }
        }
    }
    var
        RecReqHeader: Record "Requisition Header";
}