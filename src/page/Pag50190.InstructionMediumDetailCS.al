page 50190 "Instruction Medium Detail-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Medium of Instruction List';
    Editable = true;
    PageType = List;
    SourceTable = "Medium of Instruction-CS";

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

