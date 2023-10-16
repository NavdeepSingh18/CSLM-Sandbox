page 51038 "Send to store History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    Editable = false;
    CardPageId = "Send to Store History Card";
    // DeleteAllowed = false;
    SourceTableView = Sorting("Document Type", "No.") Order(descending) WHERE("Document Type" = FILTER(Requisition), "Approval Status" = filter("Send to Store"), "Responsible Department" = filter(Store), posted = filter(false));

    layout
    {
        area(Content)
        {
            repeater(Requisition)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
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
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}