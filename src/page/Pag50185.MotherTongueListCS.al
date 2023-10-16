page 50185 "Mother Tongue List-CS"
{
    // version V.001-CS

    Caption = 'Mother Tongue List-CS';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Mother Tongue-CS";

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
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

