page 50387 "Vehicle List Media-CS"
{
    // version V.001-CS

    Caption = 'Vehicle List Media';
    PageType = Card;
    SourceTable = "Vehicle - CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field(Code; Rec.Code)
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