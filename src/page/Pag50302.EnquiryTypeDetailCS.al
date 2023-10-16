page 50302 "Enquiry Type Detail-CS"
{
    // version V.001-CS

    Caption = 'Enquiry Type Detail';
    Editable = true;
    PageType = List;
    SourceTable = "Enquiry Type-CS";
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

