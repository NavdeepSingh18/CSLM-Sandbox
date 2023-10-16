page 50032 "Sections List-CS"
{
    // version V.001-CS

    Caption = 'Sections List';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Section Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group_1)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sequence No"; Rec."Sequence No")
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Section Import / Export")
            {
                Image = XMLFile;
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;

                RunObject = XMLport "Import SectionCS";
            }
        }
    }
}