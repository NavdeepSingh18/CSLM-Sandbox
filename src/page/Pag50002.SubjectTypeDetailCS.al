page 50002 "Subject Type Detail-CS"
{
    // version V.001-CS

    Caption = 'Subject Type List';
    // Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Subject Type-CS";

    layout
    {
        area(content)
        {
            repeater(Groups)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field("Type of Subject"; Rec."Type of Subject")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}

