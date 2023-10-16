page 50191 "Citizenship Detail-CS"
{
    // version V.001-CS

    Caption = 'Citizenship List';
    Editable = true;
    PageType = List;
    SourceTable = "Citizenship Master-CS";
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
            }
        }
    }

    actions
    {
    }
}

