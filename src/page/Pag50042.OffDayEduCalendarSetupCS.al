page 50042 "Off Day Edu Calendar Setup-CS"
{
    // version V.001-CS

    Caption = 'Off Day Edu Calendar';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Calendar Off Day-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(WeekDay; Rec.WeekDay)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}

