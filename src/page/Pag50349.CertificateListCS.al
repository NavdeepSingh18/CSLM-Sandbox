page 50349 "Certificate List-CS"
{
    // version V.001-CS

    Caption = 'Certificate List';
    PageType = List;
    SourceTable = "Certificate-CS";
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}

