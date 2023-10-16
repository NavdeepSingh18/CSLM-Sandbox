page 50562 "Requisition Completed SubPage"
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
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    Editable = False;

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
                    Editable = false;
                }
                field(Status; Rec.status)
                {
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
