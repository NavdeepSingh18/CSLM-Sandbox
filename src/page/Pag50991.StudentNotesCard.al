page 50991 "Student Notes Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Student Notes';
    SourceTable = "Interaction Log Entry";
    InsertAllowed = false;


    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Editable = EditDept;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = EditPage;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Interaction Template Code"; Rec."Interaction Template Code")
                {
                    ApplicationArea = All;
                    Caption = 'Template Type';

                    trigger OnValidate()
                    var
                        InteractionGroup: Record "Interaction Group";
                        InteractionTemplate: Record "Interaction Template";
                    begin
                        TemplateDescription := '';
                        InteractionTemplate.Reset();
                        if InteractionTemplate.Get(Rec."Interaction Template Code") then
                            TemplateDescription := InteractionTemplate.Description;
                        InteractionGroup.Reset();
                        if InteractionGroup.Get(Rec."Interaction Template Code") then
                            Rec.Validate(Rec."Interaction Group Code", Rec."Interaction Template Code");
                    end;
                }
                field(TemplateDescription; TemplateDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Template Description';
                    Editable = false;
                }
                field("Interaction Status code"; Rec."Interaction Status code")
                {
                    ApplicationArea = All;
                    Editable = EditPage;
                }
                field("Interaction Status Description"; Rec."Interaction Status Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Student Attachment Lines"; "Student Attachment Line")
            {
                SubPageLink = "Note Entry No" = field("Entry No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Expanded Notes")
            {
                ApplicationArea = All;
                Caption = 'View Expanded Notes';
                Image = ExportMessage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'Ctrl+Shift+D';

                trigger OnAction()
                begin
                    Message('%1', Rec.Notes);
                end;
            }
            action("Upload Attachment")
            {
                ApplicationArea = All;
                Image = ExportMessage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'Ctrl+Shift+U';

                trigger OnAction()
                var
                    StudentDocumentAttachment: Record "Student Document Attachment";
                    EntryNo: Integer;
                begin
                    StudentDocumentAttachment.Reset();
                    if StudentDocumentAttachment.FindLast() then
                        EntryNo := StudentDocumentAttachment."Entry No.";
                    EntryNo := EntryNo + 1;
                    // AttachmentDocument(Rec."Student No.", 'STUNDENTNOTES', 'NOTES', 'STUNDENTNOTES', 'STUNDENTNOTES', EntryNo, Rec."Entry No.")
                end;
            }
        }
    }

    var
        TemplateDescription: Text[100];

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
        DimValue: Record "Dimension Value";
    begin
        Rec."Student Notes" := true;
        UserSetup.Reset();
        IF UserSetup.Get(UserId()) then
            Rec.Department := UserSetup."Department Approver";


        Rec."Department Name" := '';
        if DimValue.Get('DEPARTMENT', Rec."Global Dimension 2 Code") then
            Rec."Department Name" := DimValue.Name;
    end;

    trigger OnOpenPage()
    begin
        EditDept := true;
        if Rec.Department <> Rec.Department::" " then
            EditDept := false;
    end;

    trigger OnAfterGetRecord()
    var
        InteractionTemplate: Record "Interaction Template";
    begin
        EditDept := true;
        if Rec.Department <> Rec.Department::" " then
            EditDept := false;

        EditPage := true;
        //PosStr := StrPos("Interaction Status Description", 'Close');
        PosStr := StrPos(Rec."Interaction Status Description", 'NOT REQUIRED');
        if PosStr <> 0 then
            EditPage := false;

        TemplateDescription := '';
        InteractionTemplate.Reset();
        if InteractionTemplate.Get(Rec."Interaction Template Code") then
            TemplateDescription := InteractionTemplate.Description;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec.Notes = '') and (Rec."Entry No." <> 0) then
            if Rec.Delete() then;
    end;

    // procedure AttachmentDocument(StudentNo: Code[20]; DocSubCategory: Code[500]; DocCategory: Code[500]; SLcMDocNo: Code[20]; SubCode: Code[20]; EntryNo: Integer; NoteEntryNo: Integer)
    // var
    //     SDA: Record "Student Document Attachment";
    //     StudentMaster: Record "Student Master-CS";
    //     TempBlob: Record "TempBlob Test";
    //     FileMgmt: Codeunit "File Management";
    //     locOutFile: BigText;
    //     //ClinicalNotification: Codeunit "Clinical Notification";Rec. //TO_DO
    //     ResponseText: Text;
    //     FileName: Text;
    //     IStream: InStream;
    //     TransactionNo: Text[100];
    //     WindowDialog: Dialog;
    //     PDFFile: Boolean;
    // begin
    //     if not Confirm('Do you want to upload Document?') then
    //         exit;

    //     StudentMaster.Reset();
    //     if StudentMaster.Get(StudentNo) then;

    //     FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');

    //     // PDFFile := false;
    //     // if StrPos(FileName, '.pdf') > 0 then
    //     //     PDFFile := true;

    //     // if StrPos(FileName, '.PDF') > 0 then
    //     //     PDFFile := true;

    //     // if PDFFile = false then
    //     //     Error('Selected file must be pdf file.');

    //     WindowDialog.Open('Uploading Files Please wait....');
    //     if FileName = '' then
    //         exit;

    //     TempBlob.Reset();
    //     TempBlob.DeleteAll();

    //     TempBlob.INIT();
    //     TempBlob.Blob.IMPORT(FileName);
    //     TempBlob.INSERT();
    //     TempBlob.Blob.CREATEINSTREAM(IStream);
    //     MemoryStream := MemoryStream.MemoryStream();
    //     COPYSTREAM(MemoryStream, IStream);
    //     Bytes := MemoryStream.GetBuffer();
    //     locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
    //     ResponseText := SDA.UploadSchoolDoc(StudentMaster."Original Student No.", DocSubCategory, FileName, Format(locOutFile));

    //     IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //         TransactionNo := SDA.FindStringValue(ResponseText);

    //         SDA.Init();
    //         SDA."Entry No." := EntryNo;
    //         SDA."Document Category" := 'NOTES';
    //         SDA."Document Sub Category" := 'STUNDENTNOTES';
    //         SDA."Document Description" := 'STUNDENTNOTES';
    //         SDA.Validate("Student No.", StudentNo);
    //         SDA."Student Name" := StudentMaster."Student Name";
    //         SDA."Subject Code" := 'DOCUMENTATION';
    //         SDA."SLcM Document No" := 'STUNDENTNOTES';
    //         SDA."Document Specialist ID" := StudentMaster."Document Specialist";
    //         SDA."Transaction No." := TransactionNo;
    //         SDA."Note Entry No" := NoteEntryNo;
    //         SDA."File Name" := FileName;
    //         //SDA."File Type" := '.pdf';
    //         SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
    //         SDA."Document Status" := SDA."Document Status"::"Submitted";
    //         SDA."Submission Date" := Today;
    //         SDA."Uploaded By" := UserId;
    //         SDA."Uploaded On" := Today;
    //         SDA.Insert(true);
    //     end
    //     else
    //         Error('School Docs Error\%1', ResponseText);

    //     WindowDialog.Close();
    //     Message('Document has been Uploded.', Rec.Description);
    // end;

    var
        EditDept: Boolean;

        PosStr: Integer;

        EditPage: Boolean;
        // MemoryStream: DotNet NewImageStream;
        // Bytes: DotNet Bytes;
        // Convert: DotNet ImageConvert;
}