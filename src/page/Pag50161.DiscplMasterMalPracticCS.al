page 50161 "Discpl Master-Mal Practic-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Discipline MalPractice-CS";

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
                field("Offence Description"; Rec."Offence Description")
                {
                    ApplicationArea = All;
                }
                field("Discipline Classification"; Rec."Discipline Classification")
                {
                    ApplicationArea = All;
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
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

