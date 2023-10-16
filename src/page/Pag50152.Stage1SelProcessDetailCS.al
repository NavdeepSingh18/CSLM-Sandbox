page 50152 "Stage1 Sel Process Detail-CS"
{
    // version V.001-CS

    Caption = 'Stage1 Sel Process Detail-CS';
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Sel Process Stage H1-CS";

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
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Stage1 Selection List No."; Rec."Stage1 Selection List No.")
                {
                    ApplicationArea = All;
                }
                field("Number of Students"; Rec."Number of Students")
                {
                    ApplicationArea = All;
                }
                field("Application Receive Till Date"; Rec."Application Receive Till Date")
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

