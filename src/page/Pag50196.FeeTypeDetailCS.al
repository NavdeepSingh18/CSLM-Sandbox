page 50196 "Fee Type Detail-CS"
{
    // version V.001-CS

    Caption = 'Fee Type List';
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Fee Type Master-CS";
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
        area(processing)
        {
            action(" E&dit")
            {
                Caption = ' E&dit';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.EDITABLE := TRUE;
                end;
            }
        }
    }
}

