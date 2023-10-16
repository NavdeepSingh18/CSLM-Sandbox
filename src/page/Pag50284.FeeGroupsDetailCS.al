page 50284 "Fee Groups Detail-CS"
{
    // version V.001-CS
    Caption = 'Fee Groups Detail-CS';
    PageType = List;
    SourceTable = "Scho Continuation criteria-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
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
                field("Applicable Code"; Rec."Applicable Code")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
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