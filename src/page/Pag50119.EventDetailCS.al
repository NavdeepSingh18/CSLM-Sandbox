page 50119 "Event Detail-CS"
{
    // version V.001-CS

    CardPageID = "Event Master Hdr-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Education Event-CS";
    Caption='Event Detail';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Event Day Calculation"; Rec."Event Day Calculation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}