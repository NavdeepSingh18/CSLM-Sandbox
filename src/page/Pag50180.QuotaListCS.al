page 50180 "Quota List-CS"
{
    // version V.001-CS

    Caption = 'Quota List-CS';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Quota-CS";

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
                field(Reserve; Rec.Reserve)
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

