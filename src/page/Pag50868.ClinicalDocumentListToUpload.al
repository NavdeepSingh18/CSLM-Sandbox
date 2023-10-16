page 50868 "CLN List of Docs for Upload"
{
    Caption = 'List of Clinical Required Documents for Upload';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Doc & Cate Attachment-CS";
    //SourceTableView = sorting("Sorting No.") where("Document Type" = filter('CLINICAL'), Blocked = filter(false));
    SourceTableView = where("Document Type" = filter('CLINICAL'), Blocked = filter(false), Responsibility = filter(<> " "));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Student Details")
            {
                field(StudentNo; StudentNo)
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(StudentName; StudentName)
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Semester; Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(AcademicYear; AcademicYear)
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
            }
            repeater(Rows)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expiry Not Applicable"; Rec."Expiry Not Applicable")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Validity Days"; Rec."Validity Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DocumentStatus; DocumentStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Document Status';
                    Editable = false;
                }
                field(ValidityStartDate; ValidityStartDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Validity Start Date';
                    Visible = false;
                    trigger OnValidate()
                    var
                        ClinicalRequiredDcouments: Record "Doc & Cate Attachment-CS";
                    begin
                        ClinicalRequiredDcouments.Reset();
                        if ClinicalRequiredDcouments.Get(Rec.Code, Rec."Document Type") then;

                        if (ClinicalRequiredDcouments."Expiry Not Applicable" = false) and
                        ("ValidityStartDate" <> 0D) and (ClinicalRequiredDcouments."Validity Days" > 0) then begin
                            "ValidityExpiryDate" := 0D;
                            "ValidityExpiryDate" := "ValidityStartDate" + ClinicalRequiredDcouments."Validity Days";
                        end;
                    end;
                }
                field(ValidityExpiryDate; ValidityExpiryDate)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Expiry Date';
                    Editable = false;
                    Visible = false;
                }
                field(ChooseFile; ChooseFile)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Upload File';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        StudentDocumentAttachment: Record "Student Document Attachment";
                        RivisionStudentDocumentAttachment: Record "Student Document Attachment";
                        ClinicalRequiredDcouments: Record "Doc & Cate Attachment-CS";
                        EntryNo: Integer;
                        RevisionTransactionNo: Text[100];
                    begin
                        ClinicalRequiredDcouments.Reset();
                        if ClinicalRequiredDcouments.Get(Rec.Code, Rec."Document Type") then;

                        //if ClinicalRequiredDcouments."Expiry Not Applicable" = false then
                        //    if (ValidityStartDate = 0D) or (ValidityExpiryDate = 0D) then
                        //        Error('Validity Start Date & Expiry must not be Blank.');

                        RevisionTransactionNo := '';
                        RivisionStudentDocumentAttachment.Reset();
                        RivisionStudentDocumentAttachment.SetCurrentKey("Student No.");
                        RivisionStudentDocumentAttachment.SetRange("Student No.", StudentNo);
                        RivisionStudentDocumentAttachment.SetRange("Document Category", Rec."Document Type");
                        RivisionStudentDocumentAttachment.SetRange("Document Sub Category", Rec.Code);
                        RivisionStudentDocumentAttachment.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                        RivisionStudentDocumentAttachment.SetFilter("Transaction No.", '<>%1', '');
                        if RivisionStudentDocumentAttachment.Findlast() then
                            RevisionTransactionNo := RivisionStudentDocumentAttachment."Transaction No.";

                        if RevisionTransactionNo = '' then begin
                            StudentDocumentAttachment.Reset();
                            if StudentDocumentAttachment.FindLast() then
                                EntryNo := StudentDocumentAttachment."Entry No.";
                            EntryNo := EntryNo + 1;
                            // AttachmentDocument(StudentNo, Rec.Code, Rec."Document Type", 'DOCUMENTATION', 'DOCUMENTATION', EntryNo);
                        end
                        else
                            // RevisionAttachmentDocument(RevisionTransactionNo, RivisionStudentDocumentAttachment);
                        CheckStatus();
                    end;
                }
                field(LastUploadedOn; LastUploadedOn)
                {
                    ApplicationArea = All;
                    Caption = 'Last Document Uploaded On';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Document")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = DocInBrowser;
                trigger OnAction();
                var
                    CompanyInfo: Record "Company Information";
                    StudentMaster: Record "Student Master-CS";
                    SDA: Record "Student Document Attachment";
                    TransactionNo: Code[50];
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    TransactionNo := '';
                    SDA.Reset();
                    SDA.SetRange("Student No.", StudentNo);
                    SDA.SetRange("Document Category", 'CLINICAL');
                    SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    SDA.SetRange("Document Sub Category", Rec.Code);
                    SDA.SetFilter("Transaction No.", '<>%1', '');
                    IF SDA.FindLast() then
                        TransactionNo := SDA."Transaction No.";

                    if TransactionNo <> '' then begin
                        CompanyInfo.TestField("SchoolDocs Download Url");
                        PostUrl := CompanyInfo."SchoolDocs Download Url";
                        PostUrl := PostUrl + TransactionNo;
                        Hyperlink(PostUrl);
                    end
                    else begin
                        StudentMaster.Reset();
                        if StudentMaster.Get(StudentNo) then;

                        if StudentMaster."Creation Date" < 20210410D then begin
                            if StudentMaster."Original Student No." <> '' then
                                StudentNo := StudentMaster."Original Student No."
                            else
                                StudentNo := StudentMaster."No.";
                        end
                        else
                            StudentNo := StudentMaster."No.";

                        CompanyInfo.TestField("SchoolDocs Documents Open Url");
                        PostUrl := CompanyInfo."SchoolDocs Documents Open Url";
                        PostUrl := PostUrl + StudentNo;

                        Hyperlink(PostUrl);
                    end;
                end;
            }
        }
    }

    var
        StudentNo: Code[20];
        StudentName: Text[100];
        Semester: Code[20];
        AcademicYear: Code[20];
        ChooseFile: Text[100];
        LastUploadedOn: Date;
        DocumentStatus: Text[100];
        ValidityStartDate: Date;
        ValidityExpiryDate: Date;

    trigger OnAfterGetRecord()
    begin
        CheckStatus();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CheckStatus();
    end;

    procedure CheckStatus()
    Var
        SDA: Record "Student Document Attachment";
    begin
        LastUploadedOn := 0D;
        ChooseFile := 'Uploaded';
        SDA.Reset();
        SDA.SetRange("Student No.", StudentNo);
        SDA.SetRange("Document Category", 'CLINICAL');
        SDA.SetRange("Document Sub Category", Rec.Code);
        SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
        IF SDA.FindLast() then begin
            DocumentStatus := Format(SDA."Document Status");

            if (SDA."Document Status" in [SDA."Document Status"::"On File",
            SDA."Document Status"::Expired, SDA."Document Status"::"Under Review",
            SDA."Document Status"::Submitted, SDA."Document Status"::"Portal Submitted",
            SDA."Document Status"::DROC, SDA."Document Status"::RESUBMIT,
            SDA."Document Status"::DRNYC]) and (SDA."Transaction No." <> '') then begin
                ChooseFile := 'Uploaded';
                LastUploadedOn := SDA."Submission Date";
                if SDA."Document Update Date" <> 0D then
                    LastUploadedOn := SDA."Document Update Date";

                ValidityStartDate := SDA."Validity Start Date";
                ValidityExpiryDate := SDA."Expiry Date";
            end
            else
                ChooseFile := 'Choose File to Upload';
        end
        ELSE begin
            DocumentStatus := 'Requested-Required';
            ChooseFile := 'Choose File to Upload';
            LastUploadedOn := 0D;
            ValidityStartDate := 0D;
            ValidityExpiryDate := 0D;
        end;
    end;

    procedure SetVariables(LStudentNo: Code[20]; LStudentName: Text[100]; LSemester: Code[20]; LAcademicYear: Code[20])
    begin
        StudentNo := LStudentNo;
        StudentName := LStudentName;
        Semester := LSemester;
        AcademicYear := LAcademicYear;
    end;

    // procedure AttachmentDocument(StudentNo: Code[20]; DocSubCategory: Code[500]; DocCategory: Code[500]; SLcMDocNo: Code[20]; SubCode: Code[20]; EntryNo: Integer)
    // var
    //     SDA: Record "Student Document Attachment";
    //     SDA_1: Record "Student Document Attachment";
    //     StudentMaster: Record "Student Master-CS";
    //     ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
    //     TempBlob: Record "TempBlob Test";
    //     FileMgmt: Codeunit "File Management";
    //     ClinicalNotification: Codeunit "Clinical Notification";
    //     Base64Convert: Codeunit "Base64 Convert";
    //     locOutFile: BigText;
    //     DocumentDueDate: Date;
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
    //     if StudentMaster.Get(StudentNo) then
    //         StudentMaster.TestField("Document Specialist");

    //     DocumentDueDate := 0D;
    //     ClerkshipSiteAndDateSelection.Reset();
    //     ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentNo);
    //     if ClerkshipSiteAndDateSelection.FindLast() then
    //         DocumentDueDate := ClerkshipSiteAndDateSelection."Document Due Date";

    //     //FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');//GMCSCOM

    //     PDFFile := false;
    //     if StrPos(FileName, '.pdf') > 0 then
    //         PDFFile := true;

    //     if StrPos(FileName, '.PDF') > 0 then
    //         PDFFile := true;

    //     if PDFFile = false then
    //         Error('Selected file must be pdf file.');

    //     WindowDialog.Open('Uploading PDF Please wait....');
    //     if FileName = '' then
    //         exit;

    //     TempBlob.Reset();
    //     TempBlob.DeleteAll();
    //     Clear(Base64Convert);

    //     TempBlob.INIT();
    //     TempBlob.Blob.IMPORT(FileName);
    //     TempBlob.INSERT();
    //     TempBlob.Blob.CREATEINSTREAM(IStream);

    //     // MemoryStream := MemoryStream.MemoryStream();
    //     // COPYSTREAM(MemoryStream, IStream);
    //     // Bytes := MemoryStream.GetBuffer();
    //     // locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));

    //     locOutFile.AddText(Base64Convert.ToBase64(IStream));

    //     ResponseText := SDA.UploadSchoolDoc(StudentMaster."Original Student No.", DocSubCategory, FileName, Format(locOutFile));

    //     IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //         TransactionNo := SDA.FindStringValue(ResponseText);

    //         SDA_1.Reset();
    //         SDA_1.SetRange("Student No.", StudentNo);
    //         SDA_1.SetRange("Document Category", Rec."Document Type");
    //         SDA_1.SetRange("Document Sub Category", Rec.Code);
    //         SDA_1.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
    //         IF SDA_1.FindFirst() then begin
    //             SDA_1."Document Status" := SDA_1."Document Status"::"Portal Submitted";
    //             SDA_1."File Name" := FileName;
    //             SDA_1."Document Update Date" := Today;
    //             SDA_1."Uploaded By" := UserId;

    //             if SDA_1."Transaction No." = '' then begin
    //                 SDA_1."Submission Date" := Today;
    //                 SDA_1."Uploaded On" := Today;
    //                 SDA_1."Uploaded By" := "UserID";
    //                 SDA_1."Uploaded Source" := SDA_1."Uploaded Source"::SLcMBC;
    //                 SDA_1."Uploaded Time" := Time;
    //             end;

    //             SDA_1."Transaction No." := TransactionNo;
    //             SDA_1.Modify();
    //         end
    //         ELSE begin
    //             SDA.Init();
    //             SDA."Entry No." := EntryNo;
    //             SDA."Document Category" := Rec."Document Type";
    //             SDA."Document Sub Category" := Rec.Code;
    //             SDA."Document Description" := CopyStr(Rec.Description, 1, 100);
    //             SDA.Description := Rec.Description;
    //             SDA.Validate("Student No.", StudentNo);
    //             SDA."Student Name" := StudentMaster."Student Name";
    //             SDA."Validity Start Date" := ValidityStartDate;
    //             If (ValidityExpiryDate <> 0D) or (ValidityExpiryDate <> 19000101D) then
    //                 SDA."Expiry Date" := ValidityExpiryDate;
    //             SDA."Subject Code" := 'DOCUMENTATION';
    //             SDA."SLcM Document No" := 'CLINICAL_DOCUMENTS';
    //             SDA."Document Specialist ID" := StudentMaster."Document Specialist";
    //             SDA."Document Due" := DocumentDueDate;
    //             SDA."Transaction No." := TransactionNo;
    //             SDA."File Name" := FileName;
    //             SDA."File Type" := '.pdf';
    //             SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
    //             SDA."Document Status" := SDA."Document Status"::"Portal Submitted";
    //             SDA."Submission Date" := Today;
    //             SDA."Uploaded By" := UserId;
    //             SDA."Uploaded On" := Today;

    //             SDA.Insert(true);
    //         end;
    //         ClinicalNotification.SendOnDocumentUpload(StudentMaster."No.", Rec.Description);
    //     end
    //     else
    //         Error('School Docs Error\%1', ResponseText);

    //     WindowDialog.Close();
    //     Message('%1 - Document has been Uploded.', Rec.Description);
    // end;


    // procedure RevisionAttachmentDocument(TransactionNo: Text[100]; RivisionStudentDocumentAttachment: Record "Student Document Attachment")
    // var
    //     StudentMaster: Record "Student Master-CS";
    //     TempBlob: Record "TempBlob Test";
    //     FileMgmt: Codeunit "File Management";
    //     ClinicalNotification: Codeunit "Clinical Notification";
    //     Base64Convert: Codeunit "Base64 Convert";
    //     locOutFile: BigText;
    //     ResponseText: Text;
    //     FileName: Text;
    //     IStream: InStream;
    //     WindowDialog: Dialog;
    //     PDFFile: Boolean;
    // begin
    //     if not Confirm('Do you want to upload Document?') then
    //         exit;

    //     StudentMaster.Reset();
    //     if StudentMaster.Get(StudentNo) then
    //         StudentMaster.TestField("Document Specialist");

    //     FileName := FileMgmt.UploadFile('Upload', 'C\LGSLetter');

    //     PDFFile := false;
    //     if StrPos(FileName, '.pdf') > 0 then
    //         PDFFile := true;

    //     if StrPos(FileName, '.PDF') > 0 then
    //         PDFFile := true;

    //     if PDFFile = false then
    //         Error('Selected file must be pdf file.');

    //     WindowDialog.Open('Uploading PDF Please wait....');
    //     if FileName = '' then
    //         exit;

    //     TempBlob.Reset();
    //     TempBlob.DeleteAll();
    //     Clear(Base64Convert);

    //     TempBlob.INIT();
    //     TempBlob.Blob.IMPORT(FileName);
    //     TempBlob.INSERT();
    //     TempBlob.Blob.CREATEINSTREAM(IStream);

    //     // MemoryStream := MemoryStream.MemoryStream();
    //     // COPYSTREAM(MemoryStream, IStream);
    //     // Bytes := MemoryStream.GetBuffer();
    //     // locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));

    //     locOutFile.AddText(Base64Convert.ToBase64(IStream));

    //     ResponseText := RevisionUploadSchoolDoc(TransactionNo, FileName, Format(locOutFile));

    //     IF StrPos(ResponseText, '1</Success>') > 0 then begin
    //         RivisionStudentDocumentAttachment."Document Status" := RivisionStudentDocumentAttachment."Document Status"::"Portal Submitted";
    //         RivisionStudentDocumentAttachment."File Name" := FileName;

    //         RivisionStudentDocumentAttachment."Document Update Date" := Today;
    //         RivisionStudentDocumentAttachment."Uploaded By" := UserId;
    //         RivisionStudentDocumentAttachment.Modify();
    //         ClinicalNotification.SendOnDocumentUpload(StudentMaster."No.", Rec.Description);
    //         Message('%1 - Document has been Uploded.', Rec.Description)
    //     end
    //     else
    //         Error('School Docs Error\%1', ResponseText);

    //     WindowDialog.Close();
    // end;

    // procedure RevisionUploadSchoolDoc(TransactionNo: Text[100]; FileName: Text; PDFImage: Text) Responsetext: Text
    // var
    //     http_Client: HttpClient;
    //     http_Headers: HttpHeaders;
    //     http_content: HttpContent;
    //     http_Response: HttpResponseMessage;
    //     http_request: HttpRequestMessage;
    //     api_url: text;
    // begin
    //     api_url := StrSubstNo(format('https://schooldocsconnect.com/connect/4fa76f7578a574e23112bec092625fb4/revisions'));
    //     http_content.clear();
    //     http_content.WriteFrom(
    //     '<SchoolDocs>' +
    //     '<Document>' +
    //     '<TransactionID>' + TransactionNo + '</TransactionID>' +
    //     '<FileName>' + FileName + '</FileName>' +
    //     '<DatabaseName>StudentDocs</DatabaseName>' +
    //     '<PDFBytes>' + PDFImage + '</PDFBytes>' +
    //     '</Document>' +
    //     '</SchoolDocs>'
    //     );

    //     http_content.GetHeaders(http_Headers);
    //     http_Headers.Clear();
    //     http_Headers.Add('Content-type', 'application/xml');
    //     http_request.Content := http_content;
    //     http_request.GetHeaders(http_Headers);
    //     http_request.SetRequestUri(api_url);
    //     http_request.Method('POST');
    //     http_client.Send(http_request, http_response);
    //     http_response.Content().ReadAs(responseText);
    // end;

    // var
    //     MemoryStream: DotNet NewImageStream;
    //     Bytes: DotNet Bytes;
    //     Convert: DotNet ImageConvert;
}