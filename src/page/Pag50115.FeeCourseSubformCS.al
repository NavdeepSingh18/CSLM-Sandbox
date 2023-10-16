page 50115 "Fee Course Subform-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Fee Course Subform-CS';
    PageType = CardPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Fee Course Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fee Components"; Rec."Fee Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fee Components';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Fees Type"; Rec."Fees Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Fee Group"; Rec."Fee Group")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }
}