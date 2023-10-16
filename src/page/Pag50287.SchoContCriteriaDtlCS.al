page 50287 "Scho. Cont. Criteria Dtl-CS"
{
    // version V.001-CS
    Caption = 'Scho. Cont. Criteria Dtl';
    DeleteAllowed = false;
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
                field("Applicable Percentage"; Rec."Applicable Percentage")
                {
                    ApplicationArea = All;
                }
                field("Total CGPA"; Rec."Total CGPA")
                {
                    ApplicationArea = All;
                }
                field("Applicable CGPA"; Rec."Applicable CGPA")
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
            }
        }
    }

    actions
    {
    }
}

