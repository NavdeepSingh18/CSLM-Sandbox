page 50023 "Reason Master List-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Reason Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Reason';
                    ApplicationArea = All;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ToolTip = 'Reason Descriptions';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

