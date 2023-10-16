page 50558 "Requisition Store Card"
{
    PageType = Document;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Requisition Header";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                // Editable = editgroups;

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                    Editable = False;

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
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = False;
                    //Editable = FieldEdiable_bool;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                    //Editable = FieldEdiable_bool;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                    //Editable = FieldEdiable_bool;

                }
                Field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = all;
                    // Editable = False;
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date & Time"; Rec."Date & Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Requisition Store Subpage"; "Requisition Store Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Issue Quantity")
            {
                ApplicationArea = all;
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    //CSPL-00307
                    RequestionLine.Reset();
                    RequestionLine.SetRange("Document Type", Rec."Document Type");
                    RequestionLine.SetRange("Document No.", Rec."No.");
                    RequestionLine.SetRange(Selection, true);
                    IF RequestionLine.IsEmpty then
                        Error('Select the lines to issue the quantity.');
                    //CSPL-00307
                    // IssueQuantity(Rec);
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
                    RequestionLine.Reset();
                    RequestionLine.SetRange("Document Type", Rec."Document Type");
                    RequestionLine.SetRange("Document No.", Rec."No.");
                    RequestionLine.SetRange(Selection, true);
                    IF RequestionLine.IsEmpty then
                        Error('Select the lines for Send Approval Request.');
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

                    // RequestionLine.RESET();
                    // RequestionLine.SETRANGE(RequestionLine."Document Type", "Document Type");
                    // RequestionLine.SETRANGE(RequestionLine."Document No.", "No.");
                    // RequestionLine.SetRange(Selection, true);
                    // if not RequestionLine.FindFirst() then begin
                    //     if RequestionLine.Status = RequestionLine.Status::Approved then
                    //         Error('Cannot send approved Items for approval.');
                    // end;


                    if Confirm('Do you want to send requisition ?', false) then begin
                        StockCheck := True;
                        recRqLine.Reset();
                        recRqLine.SetRange("Document No.", Rec."No.");
                        recRqLine.SetRange(Selection, True);//SN11052021+
                        // recRqLine.SetFilter(Status, '<>%1', recRqLine.Status::Rejected);
                        IF recRqLine.FindSet() then begin
                            if recRqLine.Status <> recRqLine.Status::Rejected then begin
                                repeat
                                    recRqLine.CalcFields("Stock In Hand");
                                    //Lucky start cmnt
                                    // IF recRqLine."Stock In Hand" > recRqLine."Requested Quantity" then
                                    //     Error('Stock on Hand Qty. is more than Requested Qty., issue requested qty.');//CSPL00307
                                    // IF recRqLine."Stock In Hand" <> 0 then
                                    //     Error('Stock in Hand Qty. Must be Zero'); Rec.//CSPL00307
                                    // if (recRqLine."Stock In Hand" = 0) and (recRqLine."Requested Quantity" <> 0) then //SN13052021+
                                    //Lucky end cmnt
                                    // if recRqLine.Status = recRqLine.Status::"Send to Store" then
                                    //     RequisitionApprovalCodeunit.SendApprovalRequest(recRqLine, false);//SN13052021-
                                    IF (recRqLine."Requested Quantity") > (recRqLine."Stock In Hand") then
                                        StockCheck := false;
                                until recRqLine.Next() = 0;
                                // IF StockCheck = false then begin
                                // "Approval Status" := "Approval Status"::"Pending For 1st Approval";
                                // "Responsible Department" := "Responsible Department"::Purchase;
                                // Status := Status::"Pending for Approval";
                                // MODIFY();

                                MESSAGE('Approval send successfully for Requisition Approval');
                                // end else begin
                                //     // "Responsible Department" := "Responsible Department"::Store;
                                //     // Modify();
                                //     MESSAGE('Requisition send to Store');
                                // end;
                            end else
                                Error('You cannot send the rejected lines for approval. Please remove selection from rejected lines.');
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

    // procedure IssueQuantity(RequisionHeader: Record "Requisition Header")
    // var
    //     ItemJournalLine: Record "Item Journal Line";
    //     RequisionLine: Record "Requisition Line_";
    //     ItemJournalLine1: Record "Item Journal Line";
    //     RequisionLine1: Record "Requisition Line_";
    //     RequisionLine2: Record "Requisition Line_";
    //     ItmJnlBatch: Record "Item Journal Batch";
    //     postitemJnl: Codeunit "Item Jnl.-Post Line";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     RequisitionComplete: Boolean;
    //     LineNo_Var: integer;

    //     SMTPSetup: Record "Email Account";
    //     CompanyInformation: Record "Company Information";
    //     StudentMaster: Record "Student Master-CS";
    //     User: Record User;
    //     UserSetup: Record "User Setup";
    //     SMTPMail: Codeunit "Email Message";
    //     Recipient: Text[100];
    //     Recipients: List of [Text];
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];
    //     MailSubject: Text[500];
    //     Body: Text;
    //     WindowDialog: Dialog;
    //     VarPrefrence: integer;
    //     VarPrefrence1: Integer;
    // begin
    //     if Confirm('Do you want to issue ?') then begin
    //         //to check the quantity to issue is less than or equal to remaining quantity to issue
    //         RequisionLine.Reset();
    //         RequisionLine.SetRange("Document Type", RequisionHeader."Document Type");
    //         RequisionLine.SetRange("Document No.", RequisionHeader."No.");
    //         RequisionLine.SetFilter("Remaining Quantity to Issue", '<>%1', 0);
    //         RequisionLine.SetRange(Selection, true);
    //         IF RequisionLine.FindSet() then begin
    //             repeat
    //                 RequisionLine.TestField("Quantity To Issue");
    //                 If RequisionLine."Remaining Quantity to Issue" < RequisionLine."Quantity To Issue" then
    //                     Error('Quantity To Issue must be less or equal to Remaining Quantity to Issue for Item Code %1', RequisionLine."Item Code");
    //             until RequisionLine.next() = 0;
    //         END
    //         else
    //             Error('Please select the lines.');


    //         RequisitionComplete := true;
    //         RequisionLine.Reset();
    //         RequisionLine.SetRange("Document Type", RequisionHeader."Document Type");
    //         RequisionLine.SetRange("Document No.", RequisionHeader."No.");
    //         RequisionLine.SetFilter("Remaining Quantity to Issue", '<>%1', 0);
    //         RequisionLine.SetRange(Selection, true);
    //         IF RequisionLine.FindSet() then begin
    //             repeat
    //                 IF RequisionLine.Preferences <> '' then
    //                     Evaluate(VarPrefrence, RequisionLine.Preferences);
    //                 RequisionLine1.Reset();
    //                 RequisionLine1.SetCurrentKey(Preferences);
    //                 RequisionLine1.SetRange("Item Code", RequisionLine."Item Code");
    //                 RequisionLine1.SetRange("Location Code", RequisionLine."Location Code");
    //                 RequisionLine1.SetRange(Status, RequisionLine1.Status::"Send to Store");
    //                 RequisionLine1.SetFilter("Document No.", '<>%1', RequisionLine."Document No.");
    //                 RequisionLine1.SetFilter(Preferences, '<>%1', '');
    //                 RequisionLine1.SetAscending(Preferences, true);
    //                 if RequisionLine1.FindSet() then
    //                     repeat
    //                         Evaluate(VarPrefrence1, RequisionLine1.Preferences);
    //                         IF VarPrefrence1 < VarPrefrence then
    //                             Error('First you need to issue the Items to Requisition No. %1 , Preference %2', RequisionLine1."Document No.", VarPrefrence1);
    //                     until RequisionLine1.Next() = 0;
    //                 CLEAR(LineNo_Var);
    //                 ItemJournalLine1.Reset();
    //                 ItemJournalLine1.SetCurrentKey("Line No.");
    //                 ItemJournalLine1.SetRange("Journal Template Name", 'ITEM');
    //                 ItemJournalLine1.SetRange("Journal Batch Name", 'DEFAULT');
    //                 if ItemJournalLine1.FindLast() then
    //                     LineNo_Var := ItemJournalLine1."Line No." + 10000
    //                 else
    //                     LineNo_Var := 10000;
    //                 ItemJournalLine.Reset();
    //                 ItemJournalLine.Init();
    //                 ItemJournalLine."Journal Batch Name" := 'DEFAULT';
    //                 ItemJournalLine."Journal Template Name" := 'ITEM';
    //                 ItemJournalLine.Validate("Line No.", LineNo_Var);
    //                 //ItemJournalLine.SetUpNewLine(ItemJournalLine);
    //                 ItmJnlBatch.Reset();
    //                 ItmJnlBatch.SetRange("Journal Template Name", 'ITEM');
    //                 ItmJnlBatch.SetRange(Name, 'DEFAULT');
    //                 if ItmJnlBatch.FindFirst() then begin
    //                     If ItmJnlBatch."No. Series" <> '' then begin
    //                         Clear(NoSeriesMgt);
    //                         ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo(itmJnlBatch."No. Series", Today(), True);//(ItmJnlBatch."No. Series","Posting Date",FALSE);
    //                         //ItemJournalLine."Document No." := NoSeriesMgt.TryGetNextNo(ItmJnlBatch."No. Series", WorkDate());
    //                     end;
    //                 end;
    //                 //Message('Item Doc No. is %1', ItemJournalLine."Document No.");
    //                 ItemJournalLine."Document Date" := workdate();
    //                 ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
    //                 ItemJournalLine.Validate("item No.", RequisionLine."Item Code");
    //                 ItemJournalLine.Validate("Location Code", RequisionLine."Location Code");
    //                 ItemJournalLine.Validate("Posting Date", Rec."Posting Date");
    //                 ItemJournalLine.Validate(Description, RequisionLine.Description);
    //                 ItemJournalLine.validate(Quantity, RequisionLine."Quantity To Issue");
    //                 ItemJournalLine.Validate("Shortcut Dimension 1 Code", RequisionLine."Global Dimension 1 Code");
    //                 ItemJournalLine.Validate("Shortcut Dimension 2 Code", RequisionLine."Global Dimension 2 Code");
    //                 if ItmJnlBatch."Posting No. Series" <> '' then
    //                     ItemJournalLine.Validate("Posting No. Series", ItmJnlBatch."Posting No. Series")
    //                 Else
    //                     ItemJournalLine.Validate("Posting No. Series", ItmJnlBatch."No. Series");
    //                 If RequisionLine."Purchase Budget" <> '' then
    //                     ItemJournalLine."Purchase Budget" := RequisionLine."Purchase Budget"
    //                 Else
    //                     ItemJournalLine."Purchase Budget" := RequisionLine."Budget Code";

    //                 postitemJnl.Run(ItemJournalLine);
    //                 RequisionLine."Issued Quantity" += RequisionLine."Quantity To Issue";
    //                 RequisionLine."Remaining Quantity to Issue" := RequisionLine."Remaining Quantity to Issue" - RequisionLine."Quantity To Issue";
    //                 IF RequisionLine."Remaining Quantity to Issue" <> 0 THEN
    //                     RequisitionComplete := false;
    //                 RequisionLine."Quantity To Issue" := 0;
    //                 if RequisionLine."Remaining Quantity to Issue" = 0 then
    //                     RequisionLine.Status := RequisionLine.Status::Closed
    //                 else
    //                     RequisionLine."Purchase Quantity" := RequisionLine."Remaining Quantity to Issue";
    //                 RequisionLine.Modify();
    //                 Commit();
    //             until RequisionLine.Next() = 0;
    //             Message('Issued Successfully.');

    //             //
    //             CompanyInformation.Reset();
    //             if CompanyInformation.Get() then;
    //             SMTPSetup.reset;
    //             if SMTPSetup.Get() then;

    //             UserSetup.Reset();
    //             if UserSetup.Get(Rec."User Id") then begin
    //                 if UserSetup."E-Mail" = '' then
    //                     Error('E-Mail does not updated on User Setup for the ID %1.', Rec."User Id");

    //                 MailSubject := 'Store issued the Quantity';
    //                 clear(Body);
    //                 //if Recipient <> '' then begin
    //                 SMTPMail.Create(CompanyName, SMTPSetup."User ID", UserSetup."E-Mail", MailSubject, Body, true);
    //                 if CCRecipients.Count > 0 then
    //                     SMTPMail.AddCC(CCRecipients);

    //                 SMTPMail.AppendtoBody('Dear ' + Rec."User Id" + ',');
    //                 SMTPMail.AppendtoBody('<br><br>');
    //                 SMTPMail.AppendtoBody('<br>');
    //                 SMTPMail.AppendtoBody('Store issued the Quantity');
    //                 SMTPMail.AppendtoBody('<br><br>');
    //                 SMTPMail.AppendtoBody('Regards,');
    //                 SMTPMail.AppendtoBody('<br>');
    //                 SMTPMail.AppendtoBody(CompanyName);
    //                 SMTPMail.AppendtoBody('<br><br>');
    //                 SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //                 Body := SmtpMail.GetBody();
    //                 Mail_lCU.Send();
    //                 //end;
    //             end;
    //             //

    //             // For header approval status close
    //             RequisionLine1.Reset();
    //             RequisionLine1.SetRange("Document Type", RequisionHeader."Document Type");
    //             RequisionLine1.SetRange("Document No.", RequisionHeader."No.");
    //             RequisionLine1.SetRange(Status, RequisionLine1.Status::Closed);
    //             IF RequisionLine1.FindSet() then begin
    //                 RequisionLine2.Reset();
    //                 RequisionLine2.SetRange("Document Type", RequisionHeader."Document Type");
    //                 RequisionLine2.SetRange("Document No.", RequisionHeader."No.");
    //                 IF RequisionLine2.FindSet() then begin
    //                     if RequisionLine2.count = RequisionLine1.Count then begin
    //                         Rec."Approval Status" := Rec."Approval Status"::Closed;
    //                         Rec."Responsible Department" := Rec."Responsible Department"::Completed;
    //                         Rec.Posted := true;
    //                         Rec."Closed By" := UserId();
    //                         Rec."Closed Date" := Today();
    //                         Modify();
    //                         Message('Transaction Completed. The Requision request fulfilled.');
    //                     end;
    //                 end;
    //             end;
    //         end;
    //     end else begin
    //         Error('Please select the lines');
    //     end;
    // end;

}