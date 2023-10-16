page 50360 "Movement Taken List-CS"
{
    // version V.001-CS

    Caption = 'Movement Taken List-CS';
    Editable = true;
    PageType = List;
    SourceTable = "College Taken Action-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}