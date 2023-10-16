page 50220 "Reason Card-CS"
{
    // version V.001-CS

    PageType = Card;
    SourceTable = "Reason Master-CS";
    UsageCategory = None;
    Caption = 'Reason Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Reason Description"; Rec."Reason Description")
                {
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
                field("Reason Type"; Rec."Reason Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}