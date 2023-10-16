page 50240 "Question (Faculty) Detail-CS"
{
    // version V.001-CS

    // No   Date      Sign     Trigger                     Description
    // ------------------------------------------------------------------------------------------------

    Caption = 'Question (Faculty) Detail';
    PageType = List;
    SourceTable = "Scholarship Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
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
                field("Scholarship Code"; Rec."Scholarship Code")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

