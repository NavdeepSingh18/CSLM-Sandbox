page 51039 "Approved Requisition"
{
    PageType = List;
    UsageCategory = none;
    SourceTable = "Requisition Line_";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = WHERE(Status = filter(Approved), "PO No." = filter(= ''));
    // 
    layout
    {
        area(Content)
        {
            repeater(Requisition)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item code"; Rec."Item code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Quantity"; Rec."Remaining Quantity to Issue")
                {
                    ApplicationArea = all;
                }
                field("Purchase Quantity"; Rec."Purchase Quantity")
                {
                    ToolTip = 'Specifies the value of the Purchase Quantity field.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    procedure SetSelectionLine()
    begin
        CurrPage.SetSelectionFilter(Rec);
    end;
}