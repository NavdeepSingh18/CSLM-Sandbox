page 50381 "Fee List Discount-CS"
{
    // version V.001-CS

    CardPageID = "Credit Criteria Promotion-CS";
    PageType = List;
    SourceTable = "Fee Discount Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Fee List Discount';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Student Category"; Rec."Fee Clasification Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}