page 50553 "Requisition Line Subpage"
{
    PageType = ListPart;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Requisition Line_";
    AutoSplitKey = true;
    DeleteAllowed = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater("Requisition Subpage")
            {
                Editable = Boolean_gBool1;
                field(No; Rec."Item Code")
                {
                    ApplicationArea = all;
                    Editable = Boolean_gBool;

                    trigger OnValidate()
                    var
                        ReqLine: Record "Requisition Line_";
                    begin
                        if Rec."Item Code" <> '' then begin
                            ReqLine.reset();
                            ReqLine.setrange("Document No.", Rec."Document No.");
                            ReqLine.setrange("Document Type", Rec."Document Type");
                            ReqLine.SetRange("Item Code", Rec."Item Code");
                            if ReqLine.findfirst then begin
                                Error('You can not select item Code %1 again', Rec."Item Code");
                            end;
                        end;

                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = all;
                    Editable = Boolean_gBool;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = all;
                    // visible = false;
                }

                field("Requested Quantity"; Rec."Requested Quantity")
                {
                    ApplicationArea = all;
                    Editable = Boolean_gBool;

                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    Editable = Boolean_gBool;

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
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
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Approval Status';
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = all;
                    editable = false;

                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    //CSPL-00307
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Budget"; Rec."Purchase Budget")
                {
                    ToolTip = 'Specifies the value of the Purchase Budget field.';
                    ApplicationArea = All;
                    Caption = 'Budget Code';
                }
                Field("Budget Description"; Rec."Budget Description")
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
            action("Issue Quantity")
            {
                ApplicationArea = All;
                //Visible = Boolean_gBool1;
                Visible = False;


                trigger OnAction()
                begin
                    IssueQuantity(Rec);
                    CurrPage.Close();
                end;
            }
            // action("Order Card")
            // {
            //     ApplicationArea = All;
            //     Visible = Boolean_gBool1;
            //     RunPageMode = View;
            //     RunObject = page "Purchase Order";
            //     RunPageLink = "No." = field("Purchase Order No.");
            // }
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
        Boolean_gBool1 := true;
        RequisitionHeader_gRec.Reset();
        RequisitionHeader_gRec.SetRange("Document Type", Rec."Document Type");
        RequisitionHeader_gRec.SetRange("No.", Rec."Document No.");
        If RequisitionHeader_gRec.FindFirst() then
            IF (RequisitionHeader_gRec."Approval Status" = RequisitionHeader_gRec."Approval Status"::"Pending For 1st Approval")
            or (RequisitionHeader_gRec."Approval Status" = RequisitionHeader_gRec."Approval Status"::"Pending For 2nd Approval") THEN
                Boolean_gBool1 := false;
    end;

    trigger OnAfterGetRecord()
    begin
        Boolean_gBool1 := false;
        IF Rec.Approved then
            Boolean_gBool := false
        ELSE
            Boolean_gBool := true;

        Boolean_gBool1 := true;
        RequisitionHeader_gRec.Reset();
        RequisitionHeader_gRec.SetRange("Document Type", Rec."Document Type");
        RequisitionHeader_gRec.SetRange("No.", Rec."Document No.");
        If RequisitionHeader_gRec.FindFirst() then
            IF (RequisitionHeader_gRec."Approval Status" = RequisitionHeader_gRec."Approval Status"::"Pending For 1st Approval")
            or (RequisitionHeader_gRec."Approval Status" = RequisitionHeader_gRec."Approval Status"::"Pending For 2nd Approval") THEN
                Boolean_gBool1 := false;
    end;

    procedure IssueQuantity(RequisionLine: Record "Requisition Line_")
    var
        ItemJournalLine: Record "Item Journal Line";
        postitemJnl: Codeunit "Item Jnl.-Post Line";
    begin
        // RequisionLine.TestField("Quantity To Issue");
        // if RequisionLine."Remaining Quantity to Issue" < "Quantity To Issue" then
        //     Error(StrSubstNo('%1 must be less or equal to %2', RequisionLine.FieldCaption("Quantity To Issue"), RequisionLine.FieldCaption("Remaining Quantity to Issue")));
        // if RequisionLine."Remaining Quantity to Issue" = 0 then
        //     exit;
        ItemJournalLine.Reset();
        ItemJournalLine.Init();
        ItemJournalLine."Journal Batch Name" := 'Default';
        ItemJournalLine."Journal Template Name" := 'Item';
        ItemJournalLine.SetUpNewLine(ItemJournalLine);
        ItemJournalLine."Document Date" := workdate();
        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
        ItemJournalLine.Validate("item No.", RequisionLine."Item Code");
        ItemJournalLine.Validate("Location Code", RequisionLine."Location Code");
        ItemJournalLine.validate(Quantity, RequisionLine."Quantity To Issue");
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", RequisionLine."Global Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", RequisionLine."Global Dimension 2 Code");
        postitemJnl.Run(ItemJournalLine);
        RequisionLine."Issued Quantity" += RequisionLine."Quantity To Issue";
        RequisionLine."Remaining Quantity to Issue" := RequisionLine."Remaining Quantity to Issue" - RequisionLine."Quantity To Issue";
        RequisionLine."Quantity To Issue" := 0;
        RequisionLine.Modify();

        Message('Issued Successfully.');
        Commit();
    end;

}
