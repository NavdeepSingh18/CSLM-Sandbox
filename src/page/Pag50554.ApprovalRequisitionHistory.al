page 50554 "Approval Requisition History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Line_";
    Editable = false;
    InsertAllowed = false;
    SourceTableView = WHERE(Status = filter("Pending For 1st Approval" | "Pending For 2nd Approval" | "Pending For 3rd Approval" | Approved | rejected));

    layout
    {
        area(Content)
        {
            repeater(Requisition)
            {
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Reject User Id"; Rec."Reject User Id")
                {
                    ApplicationArea = all;
                }
                field("1st Level Approval"; Rec."1st Level Approval")
                {
                    ApplicationArea = all;
                }
                field("1st Level Approved Date"; Rec."1st Level Approved Date")
                {
                    ApplicationArea = all;
                }
                field("1st Level Approver ID"; Rec."1st Level Approver ID")
                {
                    ApplicationArea = all;
                }
                field("2nd Level Approval"; Rec."2nd Level Approval")
                {
                    ApplicationArea = all;
                }
                field("2nd Level Approved Date"; Rec."2nd Level Approved Date")
                {
                    ApplicationArea = all;
                }
                field("2nd Level Approver ID"; Rec."2nd Level Approver ID")
                {
                    ApplicationArea = all;
                }
                field("3rd Level Approval"; Rec."3rd Level Approval")
                {
                    ApplicationArea = all;
                }
                field("3rd Level Approved Date"; Rec."3rd Level Approved Date")
                {
                    ApplicationArea = all;
                }
                field("3rd Level Approver ID"; Rec."3rd Level Approver ID")
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
                field("Requisition Type"; Rec."Requisition Type")
                {
                    //CSPL-00307
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // area(Reporting)
        // {
        //     action("Requisition Report")
        //     {
        //         ApplicationArea = all;
        //         Image = Report;
        //         trigger OnAction()
        //         begin
        //             RecReqHeader.RESET();
        //             RecReqHeader.SETRANGE(RecReqHeader."Document Type", "Document Type");
        //             RecReqHeader.SETRANGE(RecReqHeader."No.", "No.");
        //             IF RecReqHeader.FIND('-') THEN
        //                 REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
        //         end;
        //     }
        // }
    }
    var
    // RecReqHeader: Record "Requisition Header";


    trigger OnOpenPage()
    begin
        // RecUserSetup.GET(UserId());
        // FILTERGROUP(2);
        // SetFilter("Global Dimension 1 Code", '%1', RecUserSetup."Global Dimension 1 Code");
        // FILTERGROUP(0);
        // GetFilterUserID();
    end;

    // trigger OnAfterGetRecord()
    // var
    //     OLDReqApprovalentries: Record "Requisition Approval entries";
    //     ReqApprovalentries: Record "Requisition Approval entries";
    //     ReqApprovalUserSetUp: Record "Requisition Approval Setup";
    // begin
    //     OLDReqApprovalentries.reset();
    //     OLDReqApprovalentries.SetCurrentKey("Entry No.");
    //     OLDReqApprovalentries.setrange("Document No.", Rec."Document No.");
    //     OLDReqApprovalentries.setrange("Document Line No.", Rec."Document Line No.");
    //     OLDReqApprovalentries.SetRange(Status, Rec.status::Approved);
    //     if OLDReqApprovalentries.FindLast() then begin
    //         ReqApprovalUserSetUp.Reset();
    //         ReqApprovalUserSetUp.SetRange("Location Code", ReqApprovalentries."Location Code");
    //         ReqApprovalUserSetUp.SetRange("Global Dimension Code 2", ReqApprovalentries."Global Dimension 2");
    //         if ReqApprovalUserSetUp.Findfirst() then begin
    //             if ReqApprovalUserSetUp."Approval User 1" = OLDReqApprovalentries."Approval User ID" then begin
    //                 OLDReqApprovalentries.Validate("1st Level Approval", true);
    //                 OLDReqApprovalentries.Validate("1st Level Approved Date", Today());
    //                 OLDReqApprovalentries.Validate("1st Level Approver ID", UserId());
    //             end;
    //             if ReqApprovalUserSetUp."Approval User 2" = OLDReqApprovalentries."Approval User ID" then begin

    //             end;
    //             if ReqApprovalUserSetUp."Approval User 3" = OLDReqApprovalentries."Approval User ID" then begin

    //             end;
    //             //     RecUserSetup.GET(UserId());
    //             //     FILTERGROUP(2);
    //             //     SetFilter("Global Dimension 1 Code", '%1', RecUserSetup."Global Dimension 1 Code");
    //             //     FILTERGROUP(0);
    //         end;
    //     end;

    /*   procedure GetFilterUserID(): Text[100]
       var
           RecDimValue: Record "Dimension Value";
           j: Integer;
           Selection: Integer;
           Text0055Lbl: Label '&Pending for 1st Level Approval,&Pending for 2nd Level Approval,&Pending for 3rd Level Approval';
       begin
           RecUserSetup.Reset();
           RecUserSetup.GET(USERID());

           RecDimValue.reset();
           RecDimValue.SetRange(Code, RecUserSetup."Global Dimension 2 Code");
           IF RecDimValue.FindFirst() then;
           SetRange("Global Dimension 2 Code", RecUserSetup."Global Dimension 2 Code");

           j := 0;
           IF StrPos(RecDimValue."Requisition Approver Level 1", UserId()) > 0 THEN
               J += 1;
           IF StrPos(RecDimValue."Requisition Approver Level 2", UserId()) > 0 THEN
               J += 1;
           IF StrPos(RecDimValue."Requisition Approver Level 3", UserId()) > 0 THEN
               J += 1;

           IF j > 1 THEN begin
               Selection := STRMENU(Text0055Lbl, 1);
               IF Selection = 1 then begin
                   IF StrPos(RecDimValue."Requisition Approver Level 1", UserId()) > 0 THEN
                       SetRange("Approval Status", "Approval Status"::"Pending For 1st Approval")
                   else
                       Error('You are not authorize for 1st Level Approval')
               end;
               IF Selection = 2 then begin
                   IF StrPos(RecDimValue."Requisition Approver Level 2", UserId()) > 0 THEN begin
                       SetRange("1st Level Approval", TRUE);
                       SetRange("Approval Status", "Approval Status"::"Pending For 2nd Approval");
                   end else
                       Error('You are not authorize for 2nd Level Approval')
               end;
               IF Selection = 3 then begin
                   IF StrPos(RecDimValue."Requisition Approver Level 3", UserId()) > 0 THEN begin
                       SetRange("2nd Level Approval", TRUE);
                       SetRange("Approval Status", "Approval Status"::"Pending For 3rd Approval");
                   end else
                       Error('You are not authorize for 3rd Level Approval')
               end;

           end ELSE begin

               IF StrPos(UserId(), RecDimValue."Requisition Approver Level 1") > 0 THEN
                   SetRange("Approval Status", "Approval Status"::"Pending For 1st Approval");

               IF StrPos(UserId(), RecDimValue."Requisition Approver Level 2") > 0 THEN begin
                   SetRange("1st Level Approval", TRUE);
                   SetRange("Approval Status", "Approval Status"::"Pending For 2nd Approval");
               end;
               IF StrPos(UserId(), RecDimValue."Requisition Approver Level 3") > 0 THEN begin
                   SetRange("2nd Level Approval", TRUE);
                   SetRange("Approval Status", "Approval Status"::"Pending For 3rd Approval");
               end;
           end;

       end;*/
}