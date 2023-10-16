page 50378 "Fee Setup Initial List-CS"
{
    // version V.001-CS

    Caption = 'Initial Fee Setup List';
    PageType = List;
    SourceTable = "Initial Fee Setup-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fee Type Code"; Rec."Fee Type Code")
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