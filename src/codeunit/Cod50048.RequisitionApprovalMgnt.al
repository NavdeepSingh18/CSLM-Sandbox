codeunit 50048 "Requisition Approval Mgnt"
{
    // procedure SendApprovalRequest(Var ReqLine: Record "Requisition Line_"; DepartmentApproval: Boolean)
    // var
    //     ReqApprovalUserSetUp: Record "Requisition Approval Setup";
    //     NewReqApprovalentries: Record "Requisition Approval entries";
    //     LastReqApprovalentries: Record "Requisition Approval entries";
    //     DepartmentUserSetup: Record "Requisition Approval Setup";
    //     SMTPSetup: Record "Email Account";
    //     CompanyInformation: Record "Company Information";
    //     StudentMaster: Record "Student Master-CS";
    //     User: Record User;
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text[100];
    //     Recipients: List of [Text];
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];
    //     MailSubject: Text[500];
    //     Body: Text;
    // begin
    //     ReqApprovalUserSetUp.Reset();
    //     ReqApprovalUserSetUp.SetRange("Location Code", ReqLine."Location Code");
    //     ReqApprovalUserSetUp.SetRange("Global Dimension 2 Code", ReqLine."Global Dimension 2 Code");
    //     IF DepartmentApproval then
    //         ReqApprovalUserSetUp.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Requisition)
    //     else
    //         ReqApprovalUserSetUp.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Purchase);
    //     if ReqApprovalUserSetUp.Findfirst() then begin
    //         NewReqApprovalentries.init();
    //         NewReqApprovalentries.validate("Document No.", ReqLine."Document No.");
    //         NewReqApprovalentries.validate("Global Dimension 2", ReqLine."Global Dimension 2 Code");
    //         NewReqApprovalentries.validate("Location Code", ReqLine."Location Code");
    //         NewReqApprovalentries.validate(Status, NewReqApprovalentries.status::Open);
    //         NewReqApprovalentries.validate("Document Line No.", ReqLine."Line No.");
    //         NewReqApprovalentries.Validate("Approval User ID", ReqApprovalUserSetUp."Requisition Approver 1");
    //         NewReqApprovalentries.Validate("Item code", ReqLine."Item Code");
    //         NewReqApprovalentries.Validate(Description, ReqLine.Description);
    //         NewReqApprovalentries.Validate(Remarks, ReqLine.Remarks);
    //         NewReqApprovalentries.Validate("Unit of Meassure Code", ReqLine."Unit of Measure Code");
    //         NewReqApprovalentries.Validate("Requested Qty.", ReqLine."Remaining Quantity to Issue");
    //         NewReqApprovalentries.Validate("Global Dimension 1 Code", ReqLine."Global Dimension 1 Code");
    //         NewReqApprovalentries.Validate("Global Dimension 2", ReqLine."Global Dimension 2 Code");
    //         NewReqApprovalentries.Validate("Requested User", ReqLine."User Id");
    //         NewReqApprovalentries.Validate("Document Date", ReqLine."Document Date");
    //         NewReqApprovalentries.Validate("Budget Edit", true);
    //         NewReqApprovalentries.Validate("Requisition Type", ReqLine."Requisition Type");//CSPL-00307//--chng 18-10-21
    //         NewReqApprovalentries."Purchase Budget" := ReqLine."Purchase Budget";//CSPL-00307//-- 17-11-21
    //         NewReqApprovalentries."Budget Code" := ReqLine."Purchase Budget";
    //         NewReqApprovalentries."Budget Description" := ReqLine."Budget Description";
    //         //NewReqApprovalentries.Validate("Purchase Budget");
    //         NewReqApprovalentries.DepartmentApproval := DepartmentApproval;
    //         LastReqApprovalentries.reset();
    //         if LastReqApprovalentries.FindLast() then;
    //         NewReqApprovalentries."Entry No." := LastReqApprovalentries."Entry No." + 1;
    //         NewReqApprovalentries.insert();
    //         // ReqLine."1st Level Approval" := true;
    //         // ReqLine."1st Level Approved Date" := Today();
    //         // ReqLine."1st Level Approver ID" := UserId();
    //         ReqLine.Status := Reqline.Status::"Pending For 1st Approval";
    //         ReqLine.modify();
    //         Commit();

    //         IF DepartmentApproval then begin
    //             if CompanyInformation.Get() then;
    //             SMTPSetup.reset;
    //             if SMTPSetup.Get() then;
    //             UserSetup.Reset();
    //             if UserSetup.Get(NewReqApprovalentries."Approval User ID") then
    //                 if UserSetup."E-Mail" = '' then
    //                     Error('E-Mail does not updated on User Setup for the ID %1.', NewReqApprovalentries."Approval User ID");

    //             MailSubject := 'Request for Approval of Requsition';
    //             clear(Body);
    //             //if Recipient <> '' then begin

    //             SMTPMail.Create(CompanyName, SMTPSetup."User ID", UserSetup."E-Mail", MailSubject, Body, true);
    //             SMTPMail.AppendtoBody('Dear ' + NewReqApprovalentries."Approval User ID" + ',');
    //             SMTPMail.AppendtoBody('<br><br>');
    //             SMTPMail.AppendtoBody('<br>');
    //             SMTPMail.AppendtoBody('Request to approve Requsition No. ' + NewReqApprovalentries."Document No.");
    //             SMTPMail.AppendtoBody('<br><br>');
    //             SMTPMail.AppendtoBody('Regards,');
    //             SMTPMail.AppendtoBody('<br>');
    //             SMTPMail.AppendtoBody(CompanyName);
    //             SMTPMail.AppendtoBody('<br><br>');
    //             SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //             Body := SmtpMail.GetBody();
    //             SMTPMail.Send();
    //         end;
    //     end Else begin
    //         Error('No Requisition Approval Setup Found for Selected Lines');
    //     end;

    // end;

    // procedure ApproveRejectRequest(Var ReqApprovalentries: Record "Requisition Approval entries"; Approved: Boolean; Reject: Boolean)
    // Var
    //     ReqLine: Record "Requisition Line_";
    //     SMTPSetup: Record "Email Account";
    //     CompanyInformation: Record "Company Information";
    //     StudentMaster: Record "Student Master-CS";
    //     User: Record User;
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text[100];
    //     Recipients: List of [Text];
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];
    //     MailSubject: Text[500];
    //     Body: Text;
    //     WindowDialog: Dialog;
    //     ReqHeader: Record "Requisition Header";

    //     ReqHeader1: Record "Requisition Header";
    //     ReqLine1: Record "Requisition Line_";
    //     UpdateRecord: Boolean;
    //     WithFilterCount: integer;
    //     WithoutFilterCount: integer;
    // begin
    //     //Rejected --
    //     if Reject then begin
    //         ReqLine.reset();
    //         reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
    //         reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
    //         ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
    //         if ReqLine.FindFirst() then begin
    //             ReqLine."Reject User Id" := UserId();
    //             ReqLine.Status := Reqline.Status::Rejected;
    //             ReqLine.modify();
    //         end;

    //         //+
    //         if ReqHeader1.get(ReqHeader1."Document Type"::Requisition, ReqApprovalentries."Document No.") then begin
    //             UpdateRecord := false;
    //             WithFilterCount := 0;
    //             WithoutFilterCount := 0;
    //             /*
    //                             ReqLine.reset();
    //                             ReqLine.SetRange("Document Type", ReqHeader1."Document Type");
    //                             ReqLine.SetRange("Document No.", ReqHeader1."No.");
    //                             if ReqLine.FindSet() then begin
    //                                 repeat
    //                                     WithoutFilterCount := WithoutFilterCount + 1;
    //                                     if (ReqLine.Status = ReqLine.Status::Closed) or (ReqLine.Status = reqline.Status::Rejected) then
    //                                         WithFilterCount := WithFilterCount + 1;
    //                                 until ReqLine.Next() = 0;
    //                             end;
    //                             if WithFilterCount + WithoutFilterCount > 0 then
    //                                 if WithoutFilterCount = WithFilterCount then begin
    //                                     ReqHeader1."Approval Status" := ReqHeader1."Approval Status"::Closed;
    //                                     ReqHeader1.Posted := true;
    //                                     ReqHeader1.Modify();
    //                                 end;
    //                 */ //Lucky- as per raja sir after rejection document should be re open for change and re send the request to approval.
    //             IF ReqApprovalentries.DepartmentApproval = false then begin
    //                 ReqHeader1."Approval Status" := ReqHeader1."Approval Status"::"Send to Store";
    //                 ReqHeader1.Posted := true;
    //                 ReqHeader1.Modify();
    //             end else begin
    //                 ReqHeader1."Approval Status" := ReqHeader1."Approval Status"::Open;
    //                 ReqHeader1.Posted := true;
    //                 ReqHeader1.Modify();
    //             end;
    //         End;
    //         //-

    //         //
    //         CompanyInformation.Reset();
    //         if CompanyInformation.Get() then;
    //         SMTPSetup.reset;
    //         if SMTPSetup.Get() then;
    //         ReqHeader.reset();
    //         ReqHeader.SetRange("No.", ReqApprovalentries."Document No.");
    //         if ReqHeader.FindFirst() then begin
    //             UserSetup.Reset();
    //             if UserSetup.Get(ReqHeader."User Id") then
    //                 if UserSetup."E-Mail" = '' then
    //                     Error('E-Mail does not updated on User Setup for the ID %1.', ReqHeader."User Id");

    //             //UserSetup.Reset();
    //             //if UserSetup.Get(ReqHeader."User Id") then
    //             //    if UserSetup."E-Mail" = '' then
    //             //        Error('E-Mail does not updated on User Setup for the ID %1.', Rec."User Id");

    //             MailSubject := 'Rejection of Requsition';
    //             clear(Body);
    //             //if Recipient <> '' then begin

    //             SMTPMail.Create(CompanyName, SMTPSetup."User ID", UserSetup."E-Mail", MailSubject, Body, true);
    //             if CCRecipients.Count > 0 then
    //                 SMTPMail.AddCC(CCRecipients);

    //             SMTPMail.AppendtoBody('Dear ' + ReqHeader."User Id" + ',');
    //             SMTPMail.AppendtoBody('<br><br>');
    //             SMTPMail.AppendtoBody('<br>');
    //             SMTPMail.AppendtoBody('Approver Reject Requsition No. ' + ReqApprovalentries."Document No.");
    //             SMTPMail.AppendtoBody('<br><br>');
    //             SMTPMail.AppendtoBody('Regards,');
    //             SMTPMail.AppendtoBody('<br>');
    //             SMTPMail.AppendtoBody(CompanyName);
    //             SMTPMail.AppendtoBody('<br><br>');
    //             SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //             Body := SmtpMail.GetBody();
    //             SMTPMail.Send();
    //             //end;
    //         end;
    //         //
    //         ReqApprovalentries.Status := ReqApprovalentries.Status::Rejected;
    //         ReqApprovalentries.modify();
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure ValidationPurchaseOrderAllowed(var Rec: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
        ErrorofUserNotAllow: Label 'You are not allow to create Purchase Order';
    begin
        If Rec."Document Type" = Rec."Document Type"::Order then begin
            if UserSetup.get(UserID) then begin
                if UserSetup."Allow Create PO" = false then
                    Error(ErrorofUserNotAllow);
            end Else
                Error(ErrorofUserNotAllow);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Requisition No.', false, false)]
    local procedure QuantityValidationRequisitionNo(var Rec: Record "Purchase Line")
    begin
        if Rec."Requisition No." = '' then
            Rec."Quantity Bool" := true
        else
            rec."Quantity Bool" := false;
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnBeforeValidateEvent', 'Quantity', false, false)]
    local procedure QuantityOnBeforeValidation(var Rec: Record "Purchase Line")
    begin
        if Rec."Requisition No." = '' then
            Rec."Quantity Bool" := true
        else
            rec."Quantity Bool" := false;
    end;
}
