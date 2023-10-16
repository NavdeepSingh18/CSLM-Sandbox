page 50400 "SubPage Issues-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Indent L-CS";
    SourceTableView = WHERE(Release = CONST(True),
                            "Indent Status" = FILTER(Pending | Indent));

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Varient Code"; Rec."Varient Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Avl.Qty"; Rec."Avl.Qty")
                {
                    ApplicationArea = All;
                }
                field("Indent Quantity"; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Rem.Qty"; Rec."Rem.Qty")
                {
                    ApplicationArea = All;
                }
                field("Issue Qty"; Rec."Issue Qty")
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Indent Status"; Rec."Indent Status")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}