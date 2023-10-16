page 50383 "Follow Up-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Follow Up Status-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Follow Up';
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
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Follow Up Status"; Rec."Follow Up Status")
                {
                    ApplicationArea = All;
                }
                field("Next Follow Up Date"; Rec."Next Follow Up Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}