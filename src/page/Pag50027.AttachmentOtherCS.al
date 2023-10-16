page 50027 "Attachment(Other)-CS"
{
    // version V.001-CS
    Caption = 'Document Uploads Section';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Different Attachment-CS";
    // DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("S.No."; Rec."S.No.")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type New")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                }
                field("File Path"; Rec."File Path")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Category"; Rec."Document Category")
                {
                    ToolTip = 'Specifies the value of the Important field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Updated By Name"; Rec."Updated By Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created By Name"; Rec."Created By Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
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
                    Rec.TestField("Document Type New");
                    AttachmentDocument(EntryNo);
                end;
            }

            action("Download Document")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = ExportAttachment;

                Trigger OnAction()
                Var
                    StudentDocumentAttachment_lRec: Record "Student Document Attachment";
                // StudentDocumentAttachment_lPag: Page "Site Visit Doc Attachment";
                Begin
                    // Clear(StudentDocumentAttachment_lPag);
                    // StudentDocumentAttachment_lRec.Reset();
                    // StudentDocumentAttachment_lRec.SetRange("Transaction No.", Rec."Transaction No.");
                    // StudentDocumentAttachment_lPag.SetTableView(StudentDocumentAttachment_lRec);
                    // StudentDocumentAttachment_lPag.InitPrameter(true);
                    // StudentDocumentAttachment_lPag.Run();
                End;
            }
        }
    }

    procedure AttachmentDocument(EntryNo: Integer)
    var
        SDA: Record "Student Document Attachment";
        TempBlob: Record "TempBlob Test";
        StudentMaster: Record "Student Master-CS";
        // FileMgmt: Codeunit "File Management";
        locOutFile: BigText;
        ResponseText: Text;
        FileName: Text;
        IStream: InStream;
        TransactionNo: Text[100];
        WindowDialog: Dialog;
    // MemoryStream: DotNet NewImageStream;
    // Bytes: DotNet Bytes;
    // Convert: DotNet ImageConvert;
    // PathHelper: DotNet Path;
    begin
        if not Confirm('Do you want to upload Document?') then
            exit;

        // FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');
        // //CSPL-00307
        // Rec."File Name" := PathHelper.GetFileName(FileName);
        // Rec."File Extension" := PathHelper.GetExtension(FileName);
        // Rec."File Path" := FileName;
        // Rec."Document Category" := 'EED CLINICAL';
        // // Rec.Description := 'AD Generic';
        // //CSPL-00307
        // WindowDialog.Open('Uploading file...\Please wait...');
        // if FileName = '' then
        //     exit;

        // TempBlob.Reset();
        // TempBlob.DeleteAll();

        // TempBlob.INIT();
        // TempBlob.Blob.IMPORT(FileName);
        // TempBlob.INSERT();
        // TempBlob.Blob.CREATEINSTREAM(IStream);
        // MemoryStream := MemoryStream.MemoryStream();
        // COPYSTREAM(MemoryStream, IStream);
        // Bytes := MemoryStream.GetBuffer();
        // locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
        // IF Rec."Document Type New" = Rec."Document Type New"::Form then
        //     ResponseText := SDA.UploadSchoolDoc('ZZZZZ', 'FORM', FileName, Format(locOutFile));
        // IF Rec."Document Type New" = Rec."Document Type New"::Document then
        //     ResponseText := SDA.UploadSchoolDoc('ZZZZZ', 'DOC', FileName, Format(locOutFile));
        // StudentMaster.Reset();
        // IF StudentMaster.Get('ZZZZZ') then;

        // IF StrPos(ResponseText, '1</Success>') > 0 then begin
        //     TransactionNo := SDA.FindStringValue(ResponseText);
        //     Rec."Transaction No." := TransactionNo;//CSPL-00307
        //     SDA.Init();
        //     SDA."Entry No." := EntryNo;
        //     SDA."Document Category" := 'EED CLINICAL';
        //     IF Rec."Document Type New" = Rec."Document Type New"::Form then begin
        //         SDA."Document Sub Category" := 'FORM';
        //         SDA.Description := 'Forms';
        //     end;
        //     IF Rec."Document Type New" = Rec."Document Type New"::Document then begin
        //         SDA."Document Sub Category" := 'DOC';
        //         SDA.Description := 'Study Documents';
        //     end;
        //     SDA."Document Description" := 'EED CLINICAL';
        //     SDA.Validate("Student No.", 'ZZZZZ');
        //     SDA."Student Name" := StudentMaster."Student Name";
        //     //SDA."Subject Code" := Speciality;
        //     SDA."SLcM Document No" := Format("S.No.");
        //     SDA."Transaction No." := TransactionNo;
        //     SDA."Note Entry No" := -100;
        //     SDA."File Name" := Rec."File Name";
        //     SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
        //     SDA."Document Status" := SDA."Document Status"::"Submitted";
        //     SDA."Submission Date" := Today;
        //     SDA."Uploaded By" := UserId;
        //     SDA."Uploaded On" := Today;
        //     SDA."Document Update Date" := Today();
        //     SDA.Insert(true);
        // end
        // else
        //     Error('School Docs Error\%1', ResponseText);

        // WindowDialog.Close();
        // Message('Document - %1 has been Uploded.', SDA.Description);
    end;
}

