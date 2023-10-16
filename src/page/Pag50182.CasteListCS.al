page 50182 "Caste List-CS"
{
    // version V.001-CS

    Caption = 'Caste List';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Caste Master-CS";

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

