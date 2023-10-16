page 50225 "Subject Group Detail-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Subject Group Detail-CS';
    PageType = List;
    SourceTable = "Time Table Subject Group-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Elective; Rec.Elective)
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
}

