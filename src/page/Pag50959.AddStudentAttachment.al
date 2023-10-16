page 50959 "Add Student Attachment"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Add Student Attachment';
    SourceTable = "Student Master-CS";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Student Details")
            {
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
            }
            group(Input)
            {
                field(LCategory; LCategory)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    Style = Unfavorable;
                    ShowMandatory = true;
                    TableRelation = "File Attachment-CS".Code;

                    trigger OnValidate()
                    var
                        FileAttachment: Record "File Attachment-CS";
                    begin
                        CategoryDescription := '';
                        FileAttachment.Reset();
                        if FileAttachment.Get(LCategory) then
                            CategoryDescription := FileAttachment.Description;
                    end;
                }
                field(CategoryDescription; CategoryDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Category Description';
                    Style = Unfavorable;
                    Editable = false;
                    MultiLine = true;
                }
                field(SubCategory; SubCategory)
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category';
                    Style = Favorable;
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DocCat: Record "Doc & Cate Attachment-CS";
                    begin
                        DocCat.Reset();
                        DocCat.SetRange("Document Type", LCategory);
                        DocCat.SetRange(Blocked, false);
                        DocCat.SetRange(Responsibility, DocCat.Responsibility::" ");
                        IF Page.RUNMODAL(Page::"Cat Attachment & Doc-CS", DocCat) = ACTION::LookupOK THEN begin
                            SubCategory := DocCat.Code;
                            SubCategoryDescription := DocCat.Description;
                        end;
                    end;
                }
                field(SubCategoryDescription; SubCategoryDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category Description';
                    Editable = false;
                    Style = Favorable;
                    MultiLine = true;
                }
            }
            part("Student Attachment Lines"; "Student Attachment Line")
            {
                SubPageLink = "Student No." = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = all;
                Editable = false;
                Caption = 'Attachment Details';
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
                    if LCategory = '' then
                        Error('Category must not be blank.');
                    if SubCategory = '' then
                        Error('Sub Category must not be blank.');

                    StudentDocumentAttachment.Reset();
                    if StudentDocumentAttachment.FindLast() then
                        EntryNo := StudentDocumentAttachment."Entry No.";
                    EntryNo := EntryNo + 1;

                    // AttachmentDocument(EntryNo);
                end;
            }
        }
    }

    // procedure AttachmentDocument(EntryNo: Integer)
    // var
    //     SDA: Record "Student Document Attachment";
    //     TempBlob: Record "TempBlob Test";
    //     FileMgmt: Codeunit "File Management";
    //     locOutFile: BigText;
    //     ResponseText: Text;
    //     FileName: Text;
    //     IStream: InStream;
    //     TransactionNo: Text[100];
    //     WindowDialog: Dialog;
    //     MemoryStream: DotNet NewImageStream;
    //     Bytes: DotNet Bytes;
    //     Convert: DotNet ImageConvert;
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
    //     MemoryStream := MemoryStream.MemoryStream();
    //     COPYSTREAM(MemoryStream, IStream);
    //     Bytes := MemoryStream.GetBuffer();
    //     locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
    //     ResponseText := SDA.UploadSchoolDoc(Rec."Original Student No.", SubCategory, FileName, Format(locOutFile));

    //     IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //         TransactionNo := SDA.FindStringValue(ResponseText);

    //         SDA.Init();
    //         SDA."Entry No." := EntryNo;
    //         SDA."Document Category" := LCategory;
    //         SDA."Document Sub Category" := SubCategory;
    //         SDA."Document Description" := SubCategoryDescription;
    //         SDA.Validate("Student No.", Rec."No.");
    //         SDA."Student Name" := Rec."Student Name";
    //         SDA."Subject Code" := 'ATTACHMENT';
    //         SDA."SLcM Document No" := 'STUNDENTATTACH';
    //         SDA."Transaction No." := TransactionNo;
    //         SDA."Note Entry No" := -100;
    //         SDA."File Name" := FileName;
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
    //     Message('Document - %1 has been Uploded.', SubCategoryDescription);
    // end;

    var
        LCategory: Code[20];
        CategoryDescription: Text[500];
        SubCategory: Code[20];
        SubCategoryDescription: Text[500];
}