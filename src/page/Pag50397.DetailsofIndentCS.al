page 50397 "Details of Indent-CS"
{
    // version V.001-CS

    CardPageID = "Stage1 Indent-CS";
    Editable = true;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Indent H-CS";
    SourceTableView = WHERE(Status = FILTER(Open | "Processed for Approval" | Rejected | Approved));

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
                field("Issue For"; Rec."Issue For")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}