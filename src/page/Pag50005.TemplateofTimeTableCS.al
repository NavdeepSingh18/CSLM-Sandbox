page 50005 "Template of Time Table-CS"
{
    // version V.001-CS

    Caption = 'Template of Time Table-CS';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Time Table Tamplate-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code"';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Global Dimension 2 Code"';
                    ApplicationArea = All;
                }
            }
        }
    }


}

