page 50401 "List of Pur. Ord. For Gate-CS"
{
    // version V.001-CS

    Caption = 'List of Pur. Ord. For Gate-CS';
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE(Type = FILTER(Item),
                            "Document Type" = FILTER(Order));
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}