page 50362 "Group Code-CS"
{
    // version V.001-CS

    Caption = 'Family Code';
    PageType = Card;
    SourceTable = "Family ID-CS";
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}