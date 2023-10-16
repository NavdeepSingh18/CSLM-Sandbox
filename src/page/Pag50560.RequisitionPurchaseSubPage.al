page 50560 "Requisition Purchase Subpage"
{
    PageType = ListPart;
    // ApplicationArea = All;
    SourceTable = "Requisition Line_";
    AutoSplitKey = true;
    DeleteAllowed = false;
    MultipleNewLines = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Requisition Store Subpage")
            {
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

                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = all;

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;


                }
                field("Requested Quantity"; Rec."Requested Quantity")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                Field("Supplier's Code"; Rec."Supplier's Code")
                {
                    ApplicationArea = all;
                }
                field("Supplier's Name"; Rec."Supplier's Name")
                {
                    ApplicationArea = all;

                }
                field("Purchase Quantity"; Rec."Purchase Quantity")
                {
                    ApplicationArea = all;
                }
                field("Remaining Purchase Quantity"; Rec."Remaining Purchase Quantity")
                {
                    ApplicationArea = all;
                }
                field("Purchased Order Quantity"; Rec."Purchased Order Quantity")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    Editable = false;

                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {


        }
    }
    var
    //RequisitionHeader_gRec: Record "Requisition Header";
    //Boolean_gBool: Boolean;
    //Boolean_gBool1: Boolean;


    trigger OnInit()
    begin
        // Boolean_gBool := True;
    end;

    trigger OnOpenPage()
    begin
        // Boolean_gBool1 := true;
        // RequisitionHeader_gRec.Reset();
        // RequisitionHeader_gRec.SetRange("Document Type", Rec."Document Type");
        // RequisitionHeader_gRec.SetRange("No.", Rec."Document No.");
        // If RequisitionHeader_gRec.FindFirst() then
        //     IF (RequisitionHeader_gRec."Approval Status" = RequisitionHeader_gRec."Approval Status" ::Approved)  then
        //         Boolean_gBool1 := false;
    end;

    trigger OnAfterGetRecord()
    begin
        // Boolean_gBool1 := false;
        // IF Approved then
        //     Boolean_gBool := false
        // ELSE
        //     Boolean_gBool := true;

        // Boolean_gBool1 := true;
        // RequisitionHeader_gRec.Reset();
        // RequisitionHeader_gRec.SetRange("Document Type", Rec."Document Type");
        // RequisitionHeader_gRec.SetRange("No.", Rec."Document No.");
        // If RequisitionHeader_gRec.FindFirst() then
        //     IF (RequisitionHeader_gRec."Approval Status" = RequisitionHeader_gRec."Approval Status" ::Approved)  then
        //         Boolean_gBool1 := false;




    end;



}
