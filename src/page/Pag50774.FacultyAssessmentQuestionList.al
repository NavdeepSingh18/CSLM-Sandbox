page 50774 "Faculty Assessment Question"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Faculty Assessment Question-CS";
    Caption = 'Faculty Assessment Question List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                }
                field("Type of Question"; Rec."Type of Question")
                {
                    ApplicationArea = All;
                }
                field("Rating Type"; Rec."Rating Type")
                {
                    ApplicationArea = All;
                }


            }
        }
    }


}