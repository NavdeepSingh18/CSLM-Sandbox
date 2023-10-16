page 50552 "Requisition Card"
{
    PageType = Document;
    UsageCategory = none;
    SourceTable = "Requisition Header";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                // Editable = editgroups;
                //Editable = ApprovalStatus_Bool;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                    //Editable = FieldEdiable_bool;
                    // Editable = ApprovalStatus_Bool;
                    Editable = false;
                    //CSPL-00307 11/11/21
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    // Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    //Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //Editable = FieldEdiable_bool;

                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    // Editable = ApprovalStatus_Bool;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    //Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }


                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = all;

                }

                field("1st Level Approval"; Rec."1st Level Approval")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("1st Level Approved Date"; Rec."1st Level Approved Date")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("1st Level Approver ID"; Rec."1st Level Approver ID")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }

                field("2nd Level Approval"; Rec."2nd Level Approval")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;
                    //Editable = Status_bool;
                }

                field("2nd Level Approver Date"; Rec."2nd Level Approved Date")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("2nd Level Approver ID"; Rec."2nd Level Approver ID")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("3rd Level Approval"; Rec."3rd Level Approval")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("3rd Level Approver Date"; Rec."3rd Level Approved Date")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("3rd Level Approver ID"; Rec."3rd Level Approver ID")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    // Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date & Time"; Rec."Date & Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Visible = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Visible = false;
                }

            }
            part("Requisition Subpage"; "Requisition Line Subpage")
            {
                ApplicationArea = All;
                //Editable = editgroups;
                Editable = ApprovalStatus_Bool;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send to store")
            {
                ApplicationArea = all;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                var
                    ReqLine: Record "Requisition Line_";
                begin
                    // Rec.TestField("Requisition Type");//CSPL-00307--13-10-21 //Cmnt 14-10-21
                    if Confirm('Do you want to send requisition ?') then begin
                        ReqLine.Reset();
                        ReqLine.SetRange("Document No.", Rec."No.");
                        ReqLine.SetRange(ReqLine."Document Type", Rec."Document Type"::Requisition);
                        if ReqLine.FindSet() then begin
                            repeat
                                ReqLine.TestField("Item Code");
                                ReqLine.TestField("Location Code");
                                ReqLine.TestField("Requested Quantity");
                                ReqLine.TestField("Global Dimension 1 Code");
                                ReqLine.TestField("Global Dimension 2 Code");
                                // ReqLine.TestField("Requisition Type");//CSPL-00307--13-10-21 //Cmnt 14-10-21
                                ReqLine.TestField("Purchase Budget");//CSPL-00307 --22-11-21
                            until ReqLine.Next() = 0;
                        end Else begin
                            Error('Lines must have Values of  Item ,Location , Requested Qty,Insitute Code and Department Code');
                        end;

                        Rec.Validate("Approval Status", Rec."Approval Status"::"Send to Store");
                        Rec.validate("Responsible Department", Rec."Responsible Department"::Store);
                        Rec.Modify();
                        ReqLine.Reset();
                        ReqLine.SetRange("Document No.", Rec."No.");
                        ReqLine.SetRange(ReqLine."Document Type", Rec."Document Type"::Requisition);
                        ReqLine.ModifyAll(Status, ReqLine.Status::"Send to Store");
                        CurrPage.Close();
                    end;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = all;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //Visible = Boolean_gBool1;
                trigger OnAction()
                var
                    recRqLine: Record "Requisition Line_";
                    RequisitionApprovalCodeunit: Codeunit "Requisition Approval Mgnt";
                    StockCheck: Boolean;
                begin
                    Rec.TestField("Location Code");
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");

                    //CSPL-00307
                    // RequestionLine.Reset();
                    // RequestionLine.SetRange("Document Type", Rec."Document Type");
                    // RequestionLine.SetRange("Document No.", Rec."No.");
                    // RequestionLine.SetRange(Selection, true);
                    // IF RequestionLine.IsEmpty then
                    //     Error('Select the lines for Send Approval Request.');
                    //CSPL-00307

                    RequestionLine.RESET();
                    RequestionLine.SETRANGE(RequestionLine."Document Type", Rec."Document Type");
                    RequestionLine.SETRANGE(RequestionLine."Document No.", Rec."No.");
                    if not RequestionLine.findfirst() then
                        Error('Please Enter Item Details')
                    else begin
                        repeat
                            if RequestionLine."Requested Quantity" = 0 then
                                RequestionLine.TESTFIELD(RequestionLine."Requested Quantity");
                        until RequestionLine.NEXT() = 0;
                    end;

                    if Confirm('Do you want to send requisition ?', false) then begin
                        // StockCheck := True;
                        recRqLine.Reset();
                        recRqLine.SetRange("Document No.", Rec."No.");
                        // recRqLine.SetRange(Selection, True);
                        IF recRqLine.FindSet() then begin
                            repeat
                            // RequisitionApprovalCodeunit.SendApprovalRequest(recRqLine, true);//CSPL-00307
                            until recRqLine.Next() = 0;
                            Rec."Approval Status" := Rec."Approval Status"::"Pending For 1st Approval";
                            Rec.Modify();
                            CurrPage.Update();
                        end;
                    end;
                end;
            }


        }

        area(Reporting)
        {
            action("Requisition Report")
            {
                ApplicationArea = all;
                Image = Report;
                trigger OnAction()
                var
                begin
                    RecReqHeader.RESET();
                    RecReqHeader.SETRANGE(RecReqHeader."Document Type", Rec."Document Type");
                    RecReqHeader.SETRANGE(RecReqHeader."No.", Rec."No.");
                    IF RecReqHeader.FIND('-') THEN
                        REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
                end;
            }
        }



    }

    var
        RecReqHeader: Record "Requisition Header";
        RequestionLine: Record "Requisition Line_";

        editgroups: Boolean;


        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;
        Boolean_gBool2: Boolean;
        ApprovalStatus_Bool: Boolean;

        Status_bool: Boolean;
        Visible_Bool: Boolean;





    trigger OnInit();
    begin
        editgroups := true;
    end;

    trigger OnOpenPage()
    begin
        if not (Rec.Status = Rec.Status::Open) then begin
            editgroups := false;
        end else
            editgroups := true;



        Boolean_gBool := false;
        IF (Rec.Status = Rec.Status::"Pending for Approval") then
            Boolean_gBool := true;


        Boolean_gBool1 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Open then
            Boolean_gBool1 := true;

        Boolean_gBool2 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Boolean_gBool2 := true;

        Status_bool := True;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Status_bool := False;


        ApprovalStatus_Bool := True;
        IF (Rec.Status = Rec.Status::"Pending for Approval") THEN
            ApprovalStatus_Bool := false;

        Visible_Bool := True;
        IF (Rec.Status = Rec.Status::Open) THEN
            Visible_Bool := false;

    end;

    trigger OnAfterGetRecord()
    begin
        if not (Rec.Status = Rec.Status::Open) then begin
            editgroups := false;
        end else
            editgroups := true;



        Boolean_gBool := false;
        IF (Rec.Status = Rec.Status::"Pending for Approval") then
            Boolean_gBool := true;


        Boolean_gBool1 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Open then
            Boolean_gBool1 := true;

        Boolean_gBool2 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Boolean_gBool2 := true;

        Status_bool := True;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Status_bool := False;


        ApprovalStatus_Bool := True;
        IF (Rec.Status = Rec.Status::"Pending for Approval") THEN
            ApprovalStatus_Bool := false;


        Visible_Bool := True;
        IF (Rec.Status = Rec.Status::Open) THEN
            Visible_Bool := false;

    end;
}

