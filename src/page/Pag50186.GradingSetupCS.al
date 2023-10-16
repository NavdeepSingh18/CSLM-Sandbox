page 50186 "Grading Setup-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Grading Rule Setup-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Grading Rule"; Rec."Grading Rule")
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
                field("Maximum Grace Marks"; Rec."Maximum Grace Marks")
                {
                    ApplicationArea = All;
                }
                field("Highest Grade Highest Cut Off"; Rec."Highest Grade Highest Cut Off")
                {
                    ApplicationArea = All;
                }
                field("Highest Grade Lowest Cut Off"; Rec."Highest Grade Lowest Cut Off")
                {
                    ApplicationArea = All;
                }
                field("Lowest Grade Highest Cut Off"; Rec."Lowest Grade Highest Cut Off")
                {
                    ApplicationArea = All;
                }
                field("Lowest Grade Lowest Cut Off"; Rec."Lowest Grade Lowest Cut Off")
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

