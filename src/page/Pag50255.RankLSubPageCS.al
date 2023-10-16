page 50255 "Rank L SubPage-CS"
{
    // version V.001-CS

    Caption = 'Rank L SubPage-CS';
    AutoSplitKey = true;
    PageType = CardPart;
    SourceTable = "Stud. Rank Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scholarship Code"; Rec."Scholarship Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Min Rank"; Rec."Min Rank")
                {
                    ApplicationArea = All;
                }
                field("Max Rank"; Rec."Max Rank")
                {
                    ApplicationArea = All;
                }
                field("Discount %"; Rec."Discount %")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

