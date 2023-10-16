page 50283 "Fee Group Detail-CS"
{
    // version V.001-CS
    Caption = 'Fee Group Detail';
    PageType = List;
    SourceTable = "Group Fee Details-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("S. No."; Rec."S. No.")
                {
                    ApplicationArea = All;
                }
                field("Fee Group Code"; Rec."Fee Group Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}