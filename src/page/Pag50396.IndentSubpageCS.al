page 50396 "Indent Subpage-CS"
{
    // version V.001-CS

    AutoSplitKey = false;
    DelayedInsert = true;
    PageType = ListPart;
    RefreshOnActivate = false;
    SourceTable = "Indent L-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variance Code"; Rec."Varient Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. for Requsition"; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Issue Qty"; Rec."Issue Qty")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Inventory; Rec."Avl.Qty")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Rem.Qty"; Rec."Rem.Qty")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Indent Status"; Rec."Indent Status")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Issue Indent"; Rec."Issue Indent")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}