page 50557 "Requisition Store Subpage"
{
    PageType = ListPart;
    // ApplicationArea = All;
    SourceTable = "Requisition Line_";
    AutoSplitKey = true;
    DeleteAllowed = true;
    MultipleNewLines = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Requisition Store Subpage")
            {
                field(Selection; Rec.Selection)
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = all;

                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    Editable = False;

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(status; Rec.status)
                {
                    caption = 'Approval Status';
                    ApplicationArea = all;
                    editable = false;
                }
                field("Requested Quantity"; Rec."Requested Quantity")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = all;
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Remaining Quantity to Issue"; Rec."Remaining Quantity to Issue")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec."Remaining Quantity to Issue" := Rec."Quantity To Issue" - Rec."Issued Quantity";
                        Rec.VALIDATE("Remaining Quantity to Issue");
                    end;
                }
                field("Purchase Quantity"; Rec."Purchase Quantity")
                {
                    ToolTip = 'Specifies the value of the Purchase Quantity field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = False;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Budget"; Rec."Purchase Budget")
                {
                    ToolTip = 'Specifies the value of the Purchase Budget field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Budget Code';
                }
                Field("Budget Description"; Rec."Budget Description")
                {
                    ApplicationArea = All;
                }
                field(Preferences; Rec.Preferences)
                {
                    ToolTip = 'Specifies the value of the Preferences field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Order Card")
            {
                ApplicationArea = All;
                Visible = Boolean_gBool1;
                RunPageMode = View;
                RunObject = page "Purchase Order";
                RunPageLink = "No." = field("Purchase Order No.");
            }
        }
    }
    var
        RequisitionHeader_gRec: Record "Requisition Header";
        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;


    trigger OnInit()
    begin
        Boolean_gBool := True;
    end;

    trigger OnOpenPage()
    begin
        Boolean_gBool1 := false;
        RequisitionHeader_gRec.Reset();
        RequisitionHeader_gRec.SetRange("Document Type", Rec."Document Type");
        RequisitionHeader_gRec.SetRange("No.", Rec."Document No.");
        If RequisitionHeader_gRec.FindFirst() then
            IF (RequisitionHeader_gRec.Status = RequisitionHeader_gRec.Status::Approved) and Rec.Approved then
                Boolean_gBool1 := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Boolean_gBool1 := false;
        IF Rec.Approved then
            Boolean_gBool := false
        ELSE
            Boolean_gBool := true;

        RequisitionHeader_gRec.Reset();
        RequisitionHeader_gRec.SetRange("Document Type", Rec."Document Type");
        RequisitionHeader_gRec.SetRange("No.", Rec."Document No.");
        If RequisitionHeader_gRec.FindFirst() then
            IF (RequisitionHeader_gRec.Status = RequisitionHeader_gRec.Status::Approved) and Rec.Approved then
                Boolean_gBool1 := true;

    end;
}
