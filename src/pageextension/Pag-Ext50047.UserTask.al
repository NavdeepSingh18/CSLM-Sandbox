pageextension 50047 UserTaskExt extends "User Task Card"
{
    layout
    {
        modify("Task Item")
        {
            Visible = False;
        }
        modify("Percent Complete")
        {
            Editable = False;
        }

        addafter("Created DateTime")
        {
            Field(Statuss; Rec.Statuss)
            {
                ApplicationArea = All;
                Editable = Assigned;
            }
            Field("Attachment Exist"; Rec."Attachment Exist")
            {
                ApplicationArea = All;
                Visible = Completed;
            }
            field("No. of Attachment"; Rec."No. of Attachment")
            {
                ApplicationArea = All;
            }
            field("Per. Com. per User"; Rec."Per. Com. per User")
            {
                ApplicationArea = All;
                Editable = False;
            }
        }
        addafter("Due DateTime")
        {
            field(PerCompletion; PerCompletion)
            {
                Caption = ' Input % Complete';
                trigger OnValidate()
                begin
                    If PerCompletion <> Rec."Per. Com. per User" then
                        Error('Assigned Task percentage is %1%.', Rec."Per. Com. per User");
                    Rec.Validate("Percent Complete", Rec."Percent Complete" + PerCompletion);
                end;
            }
        }
        modify(MultiLineTextControl)
        {
            Editable = Assigned;
        }
        modify("Due DateTime")
        {
            Editable = Assigned;
        }
        modify("User Task Group Assigned To")
        {
            Editable = Assigned;
        }
        modify("Start DateTime")
        {
            Editable = Assigned;
        }
        modify("Completed By User Name")
        {
            Editable = Assigned;
        }
        modify("Completed DateTime")
        {
            Editable = Assigned;
        }
        modify(Priority)
        {
            Editable = Assigned;
        }
        modify(Title)
        {
            Editable = Assigned;
        }

    }

    actions
    {
        modify("Go To Task Item")
        {
            Visible = false;
        }
        modify("Mark Completed")
        {
            Visible = false;
        }
        modify(Recurrence)
        {
            Visible = false;
        }
        addafter(Recurrence)
        {
            action("Upload Attachment")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+Shift+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = Attachments;

                trigger OnAction()
                var
                    StudentDocumentAttachment: Record "Student Document Attachment";
                    EntryNo: Integer;
                begin
                    StudentDocumentAttachment.Reset();
                    if StudentDocumentAttachment.FindLast() then
                        EntryNo := StudentDocumentAttachment."Entry No.";
                    EntryNo := EntryNo + 1;

                    AttachmentDocument(EntryNo);
                    Rec.Modify(true);
                end;
            }

            // action("Upload Attachment Verity")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = TRUE;
            //     Image = Attachments;

            //     trigger OnAction()
            //     var
            //         StudentDocumentAttachment: Record "Student Document Attachment";
            //         EntryNo: Integer;
            //     begin
            //         StudentDocumentAttachment.Reset();
            //         if StudentDocumentAttachment.FindLast() then
            //             EntryNo := StudentDocumentAttachment."Entry No.";
            //         EntryNo := EntryNo + 1;

            //         AttachmentDocumentVerity(EntryNo);
            //         Modify(true);
            //     end;
            // }

            action("Download Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = ExportAttachment;

                // Trigger OnAction()
                // Var
                //     StudentDocumentAttachment_lRec: Record "Student Document Attachment";
                //     StudentDocumentAttachment_lPag: Page "Site Visit Doc Attachment";
                // Begin
                //     Clear(StudentDocumentAttachment_lPag);
                //     StudentDocumentAttachment_lRec.Reset();
                //     StudentDocumentAttachment_lRec.SetRange("SLcM Document No", Rec."Document No.");
                //     StudentDocumentAttachment_lPag.SetTableView(StudentDocumentAttachment_lRec);
                //     StudentDocumentAttachment_lPag.UserTaskCaptionPermission(true);
                //     StudentDocumentAttachment_lPag.Run();
                // End;
            }
            action("Task Assigned")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Visible = Assigned;
                Trigger OnAction()
                var
                    UserTaskGroup: Record "User Task Group Member";
                    AssignedUserCnt: Integer;
                Begin
                    If not Confirm('Do you want to assigned the task : %1', false, Rec.Title) then
                        Exit;


                    Rec.Validate(Statuss, 'PENDING');
                    Rec."Last Modified By" := UserId();
                    Rec."Last Modified On" := Today();
                    If Rec."User Task Group Assigned To" <> '' then begin
                        UserTaskGroup.Reset();
                        UserTaskGroup.SetRange("User Task Group Code", Rec."User Task Group Assigned To");
                        AssignedUserCnt := UserTaskGroup.Count();
                        Rec."Per. Com. per User" := Round(100 / AssignedUserCnt);
                        UserTaskGroup.ModifyAll("Per User % Comp.", Rec."Per. Com. per User");
                    end Else
                        Rec."Per. Com. per User" := 100;
                    //PendingUserTaskEmail();
                    Message('Task has been assigned.');
                    Rec.Modify(true);
                    CurrPage.Close();
                End;
            }
            action("Task Completed")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Visible = Completed;
                Trigger OnAction()
                var
                    USerTaskGroupMember: REcord "User Task Group Member";
                Begin
                    If not Confirm('Do you want to complete the task : %1?', false, Rec.Title) then
                        Exit;

                    If Rec."User Task Group Assigned To" <> '' then begin
                        USerTaskGroupMember.Reset();
                        USerTaskGroupMember.SetRange("User Task Group Code", Rec."User Task Group Assigned To");
                        USerTaskGroupMember.SetRange("User Security ID", UserSecurityId());
                        IF USerTaskGroupMember.FindFirst() then begin
                            If (Rec."Percent Complete" + USerTaskGroupMember."Per User % Comp.") < 100 then begin
                                Rec.Validate(Statuss, 'PENDING');
                                Rec."Percent Complete" += USerTaskGroupMember."Per User % Comp.";
                                Rec."Last Modified By" := UserId();
                                Rec."Last Modified On" := Today();
                            end Else begin
                                Rec.Validate(Statuss, 'COMPLETED');
                                Rec."Percent Complete" := 100;
                                Rec."Completed By" := UserSecurityId();
                                Rec."Completed DateTime" := CurrentDateTime();
                                Rec."Last Modified By" := UserId();
                                Rec."Last Modified On" := Today();
                            end;
                        end;

                    End Else begin

                        Rec.Validate(Statuss, 'COMPLETED');
                        Rec."Percent Complete" := 100;
                        Rec."Completed By" := UserSecurityId();
                        Rec."Completed DateTime" := CurrentDateTime();
                        Rec."Last Modified By" := UserId();
                        Rec."Last Modified On" := Today();
                    end;
                    // CompleteUserTaskEmail(UserId());
                    Rec.Modify(true);
                    CurrPage.Close();

                End;
            }
        }
    }

    var
        Assigned: Boolean;
        Completed: Boolean;
        PerCompletion: Decimal;

    Trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate(Statuss, 'OPEN');
    end;



    procedure AttachmentDocument(EntryNo: Integer)
    var
        SDA: Record "Student Document Attachment";
        TempBlob: Record "TempBlob Test";
        StudentMaster: Record "Student Master-CS";
        FileMgmt: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        locOutFile: BigText;
        ResponseText: Text;
        FileName: Text;
        IStream: InStream;
        TransactionNo: Text[100];
        WindowDialog: Dialog;

    begin
        if not Confirm('Do you want to upload Document?') then
            exit;

        //FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');



        WindowDialog.Open('Uploading file...\Please wait...');
        if FileName = '' then
            exit;

        TempBlob.Reset();
        TempBlob.DeleteAll();

        TempBlob.INIT();
        //TempBlob.Blob.IMPORT(FileName);
        TempBlob.INSERT();
        TempBlob.Blob.CREATEINSTREAM(IStream);
        locOutFile.ADDTEXT(Base64Convert.ToBase64(IStream));
        ResponseText := SDA.UploadSchoolDoc('ZZZZZ', 'USERTASK', FileName, Format(locOutFile));
        StudentMaster.Reset();
        IF StudentMaster.Get('ZZZZZ') then;

        IF StrPos(ResponseText, '1</Success>') > 0 then begin
            TransactionNo := SDA.FindStringValue(ResponseText);

            SDA.Init();
            SDA."Entry No." := EntryNo;
            SDA."Document Category" := 'REGISTRAR';
            SDA."Document Sub Category" := 'USERTASK';
            SDA.Description := 'User Task Attachment';
            SDA."Document Description" := 'User Task Attachment';
            SDA.Validate("Student No.", 'ZZZZZ');
            SDA."Student Name" := StudentMaster."Student Name";
            //SDA."Subject Code" := Speciality;
            SDA."SLcM Document No" := Rec."Document No.";
            SDA."Transaction No." := TransactionNo;
            SDA."Note Entry No" := -100;
            SDA."File Name" := FileMgmt.GetFileName(FileName);
            SDA."File Type" := FileMgmt.GetExtension(FileName);
            // SDA.Description := FileMgmt.GetFileName(FileName);
            // SDA."Document Description" := FileMgmt.GetFileName(FileName);
            SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
            SDA."Document Status" := SDA."Document Status"::"Submitted";
            SDA."Submission Date" := Today;
            SDA."Uploaded By" := UserId;
            SDA."Uploaded On" := Today;
            SDA."Document Update Date" := Today();
            SDA.Insert(true);
        end
        else
            Error('School Docs Error\%1', ResponseText);

        WindowDialog.Close();
        Message('Document - %1 has been Uploaded.', 'User Task Attachment');
    end;

    // procedure AttachmentDocumentVerity(EntryNo: Integer)
    // var
    //     SDA: Record "Student Document Attachment";
    //     TempBlob: Record "TempBlob Test";
    //     StudentMaster: Record "Student Master-CS";
    //     FileMgmt: Codeunit "File Management";
    //     Base64Convert: Codeunit "Base64 Convert";
    //     //VerityIntegration: Codeunit "Verity Integration";
    //     locOutFile: BigText;
    //     ResponseText: Text;
    //     FileName: Text;
    //     IStream: InStream;
    //     TransactionNo: Text[100];
    //     WindowDialog: Dialog;
    //     lSuccessStatus: Boolean;

    // begin
    //     if not Confirm('Do you want to upload Document?') then
    //         exit;

    //     FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');



    //     WindowDialog.Open('Uploading file...\Please wait...');
    //     if FileName = '' then
    //         exit;

    //     TempBlob.Reset();
    //     TempBlob.DeleteAll();

    //     TempBlob.INIT();
    //     TempBlob.Blob.IMPORT(FileName);
    //     TempBlob.INSERT();
    //     TempBlob.Blob.CREATEINSTREAM(IStream);
    //     locOutFile.ADDTEXT(Base64Convert.ToBase64(IStream));

    //     ResponseText := VerityIntegration.DocumentUploadVerity('ZZZZZ', 'USERTASK', FileName, Format(locOutFile), lSuccessStatus);

    //     StudentMaster.Reset();
    //     IF StudentMaster.Get('ZZZZZ') then;

    //     IF lSuccessStatus then begin
    //         TransactionNo := SDA.GetTransactionNo(ResponseText);

    //         SDA.Init();
    //         SDA."Entry No." := EntryNo;
    //         SDA."Document Category" := 'REGISTRAR';
    //         SDA."Document Sub Category" := 'USERTASK';
    //         SDA.Description := 'User Task Attachment';
    //         SDA."Document Description" := 'User Task Attachment';
    //         SDA.Validate("Student No.", 'ZZZZZ');
    //         SDA."Student Name" := StudentMaster."Student Name";
    //         //SDA."Subject Code" := Speciality;
    //         SDA."SLcM Document No" := Rec."Document No.";
    //         SDA."Transaction No." := TransactionNo;
    //         SDA."Document ID" := TransactionNo;
    //         SDA."Note Entry No" := -100;
    //         SDA."File Name" := FileMgmt.GetFileName(FileName);
    //         SDA."File Type" := FileMgmt.GetExtension(FileName);
    //         // SDA.Description := FileMgmt.GetFileName(FileName);
    //         // SDA."Document Description" := FileMgmt.GetFileName(FileName);
    //         SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
    //         SDA."Document Status" := SDA."Document Status"::"Submitted";
    //         SDA."Submission Date" := Today;
    //         SDA."Uploaded By" := UserId;
    //         SDA."Uploaded On" := Today;
    //         SDA."Document Update Date" := Today();
    //         SDA.Insert(true);
    //     end
    //     else
    //         Error('School Docs Error\%1', ResponseText);

    //     WindowDialog.Close();
    //     Message('Document - %1 has been Uploaded.', 'User Task Attachment');
    // end;

    trigger OnOpenPage()
    var
        UserTaskGroup: Record "User Task Group Member";
    Begin
        Assigned := false;
        Completed := false;
        IF Rec."User Task Group Assigned To" <> '' then begin
            UserTaskGroup.Reset();
            UserTaskGroup.SetRange("User Task Group Code", Rec."User Task Group Assigned To");
            UserTaskGroup.SetRange("User Security ID", UserSecurityId());
            If UserTaskGroup.FindFirst() then
                Completed := True;

        end Else begin
            If Rec."Assigned To" = UserSecurityId() then
                Completed := true;
        end;
        IF Rec."Created By" = UserSecurityId() then
            Assigned := true;
    End;

    trigger OnAfterGetCurrRecord()
    var
        UserTaskGroup: Record "User Task Group Member";
    begin
        // PerCompletion := 0;
        // PerCompletion := Rec."Percent Complete";
        Assigned := false;
        Completed := false;
        IF Rec."User Task Group Assigned To" <> '' then begin
            UserTaskGroup.Reset();
            UserTaskGroup.SetRange("User Task Group Code", Rec."User Task Group Assigned To");
            UserTaskGroup.SetRange("User Security ID", UserSecurityId());
            If UserTaskGroup.FindFirst() then
                Completed := True;

        end Else begin
            If Rec."Assigned To" = UserSecurityId() then
                Completed := true;
        end;
        IF Rec."Created By" = UserSecurityId() then
            Assigned := true;
    end;
}