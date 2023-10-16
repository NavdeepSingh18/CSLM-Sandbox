page 50559 "Requisition Purchase List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE("Document Type" = FILTER(Requisition), "Responsible Department" = filter(Purchase), "Approval Status" = filter(Approved));
    CardPageId = "Requisition Purchase Card";
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Requisition Store")

            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                Field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;


                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;


                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;

                }



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
            action("Purchase Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageMode = View;
                trigger OnAction()
                Var
                    PurchHeader: Record "Purchase Header";
                    PurchPage: Page "Purchase Order List";
                begin
                    PurchHeader.Reset();
                    PurchHeader.setrange("Requisition No.", Rec."No.");
                    PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
                    PurchPage.SETTABLEVIEW(PurchHeader);
                    PurchPage.RUN();
                end;
            }


        }
    }
    var
        RecReqHeader: Record "Requisition Header";

}