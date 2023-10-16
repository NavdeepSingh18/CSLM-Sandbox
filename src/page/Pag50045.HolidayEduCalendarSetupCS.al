page 50045 "Holiday Edu Calendar Setup-CS"
{
    // version V.001-CS

    Caption = 'Holiday Edu Calendar';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Calendar Holiday-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Holiday Date"; Rec."Holiday Date")
                {
                    ToolTip = 'Holiday Date';
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
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

