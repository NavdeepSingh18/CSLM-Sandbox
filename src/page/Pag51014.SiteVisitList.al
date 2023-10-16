page 51014 "Site Visit List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Site Visit";
    Editable = false;
    CardPageId = SiteVisit;
    SourceTableView = sorting("Document No.") order(descending);
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;

                }

                Field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                Field("Visit Date"; Rec."Visit Date")
                {
                    ApplicationArea = All;
                }
                Field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                Field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                Field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                Field("Person Name"; Rec."Person Name")
                {
                    ApplicationArea = All;
                }
                Field("Visit Reason"; Rec."Visit Reason")
                {
                    ApplicationArea = All;
                }
                Field(Inference; Rec.Inference)
                {
                    ApplicationArea = All;
                }
                Field(Speciality; Rec.Speciality)
                {
                    ApplicationArea = All;
                }
                Field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }

            }

        }
        area(Factboxes)
        {

        }
    }


    // procedure AttachmentDocument(EntryNo: Integer)
    // var
    //     SDA: Record "Student Document Attachment";
    //     TempBlob: Record "TempBlob Test";
    //     StudentMaster: Record "Student Master-CS";
    //     FileMgmt: Codeunit "File Management";
    //     SalesOrder: Page "Sales Order";
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
    //     ResponseText := SDA.UploadSchoolDoc('ZZZZZ', 'SITEVISIT', FileName, Format(locOutFile));
    //     StudentMaster.Reset();
    //     IF StudentMaster.Get('ZZZZZ') then;

    //     IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //         TransactionNo := SDA.FindStringValue(ResponseText);

    //         SDA.Init();
    //         SDA."Entry No." := EntryNo;
    //         SDA."Document Category" := 'EED CLINICAL';
    //         SDA."Document Sub Category" := 'SITEVISIT';
    //         SDA.Description := 'Site Visit Document';
    //         SDA."Document Description" := 'Academics';
    //         SDA.Validate("Student No.", 'ZZZZZ');
    //         SDA."Student Name" := 'ZZZZZ';
    //         //SDA."Subject Code" := Speciality;
    //         SDA."SLcM Document No" := Rec."Document No.";
    //         SDA."Transaction No." := TransactionNo;
    //         SDA."Note Entry No" := -100;
    //         SDA."File Name" := FileName;
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
    //     Message('Document - %1 has been Uploded.', 'Site Visit Document');
    // end;
}