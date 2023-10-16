page 50044 "Edu Calendar SubPage-CS"
{
    // version V.001-CS

    Caption = 'Edu Calendar SubPage';
    DeleteAllowed = false;
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Education Calendar Entry-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field("Off Day"; Rec."Off Day")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Holiday; Rec.Holiday)
                {
                    ApplicationArea = All;
                }
                field("Day Order"; Rec."Day Order")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Multi Event Exist"; Rec."Multi Event Exist")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Multi Event")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = Page "Multi Evt Entry Edu Cale-CS";
                RunPageLink = Code = FIELD(Code),
                              Date = FIELD(Date),
                              "Academic Year" = FIELD("Academic Year");
            }
        }
    }
}