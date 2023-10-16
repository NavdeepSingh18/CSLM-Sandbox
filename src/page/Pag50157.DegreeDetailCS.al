page 50157 "Degree Detail-CS"
{
    // version V.001-CS

    Caption = 'Degree List';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Final Degree-CS";

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
                Field("Min. CGPA Required"; Rec."Min. CGPA Required")
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

