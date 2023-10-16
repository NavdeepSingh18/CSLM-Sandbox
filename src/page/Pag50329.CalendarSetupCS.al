page 50329 "Calendar Setup-CS"
{
    // version V.001-CS

    Caption = 'Calendar Setup';
    PageType = Card;
    SourceTable = "Specialization-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Total no of Elective"; Rec."Total no of Elective")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

