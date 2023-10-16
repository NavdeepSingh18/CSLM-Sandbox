page 50301 "Application Eval. Detail-CS"
{
    // version V.001-CS

    Caption = 'Application Eval. Detail';
    PageType = Card;
    SourceTable = "Application-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("University Interested"; Rec."University Interested")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
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

