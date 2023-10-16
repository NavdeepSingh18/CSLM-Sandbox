page 50327 "Duration Generation Subform-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Duration Generation Subform-CS';
    PageType = ListPart;
    SourceTable = "CBCS Student Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = all;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = all;
                }
                field("CBCS Status"; Rec."CBCS Status")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

