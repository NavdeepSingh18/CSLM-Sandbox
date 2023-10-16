page 50348 "Syllabus List-CS"
{
    // version V.001-CS

    Caption = 'Co-Curricular List';
    Editable = false;
    PageType = Card;
    SourceTable = "Co-Curricular Activities-CS";
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

    actions
    {
    }
}

