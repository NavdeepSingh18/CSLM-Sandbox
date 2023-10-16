page 50555 "Requisition Completed"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    Editable = false;
    CardPageId = "Requistion Completed Card";
    SourceTableView = Sorting("Document Type", "No.") order(descending) WHERE("Document Type" = FILTER(Requisition), Posted = FILTER(true), "Approval Status" = filter(Closed));


    layout
    {
        area(Content)
        {
            repeater(Requisition)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
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
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                }

                field("1st Level Approval"; Rec."1st Level Approval")
                {
                    ApplicationArea = all;
                }
                field("1st Level Approved Date"; Rec."1st Level Approved Date")
                {
                    ApplicationArea = all;

                }
                field("1st Level Approver ID"; Rec."1st Level Approver ID")
                {
                    ApplicationArea = all;

                }

                field("2nd Level Approval"; Rec."2nd Level Approval")
                {
                    ApplicationArea = all;
                }

                field("2nd Level Approved Date"; Rec."2nd Level Approved Date")
                {
                    ApplicationArea = all;

                }
                field("2nd Level Approver ID"; Rec."2nd Level Approver ID")
                {
                    ApplicationArea = all;

                }
                field("3rd Level Approval"; Rec."3rd Level Approval")
                {
                    ApplicationArea = all;
                }
                field("3rd Level Approved Date"; Rec."3rd Level Approved Date")
                {
                    ApplicationArea = all;

                }
                field("3rd Level Approver ID"; Rec."3rd Level Approver ID")
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