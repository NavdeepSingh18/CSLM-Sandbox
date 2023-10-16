table 50405 "Student Document Attachment"
{
    DataClassification = CustomerContent;
    LookupPageId = "Student Document Attachment";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Document Category"; Code[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "File Attachment-CS";
            trigger OnValidate()
            var
                FileAtt: Record "File Attachment-CS";
            begin
                FileAtt.Reset();
                if FileAtt.Get("Document Category") then
                    if FileAtt."Type Category No. SchoolDocs" = 0 then
                        Error('"Type Category No. Schooldocs" for Document Category %1 is blank', "Document Category");

            end;
        }
        field(3; "Document Sub Category"; Code[250])
        {
            DataClassification = CustomerContent;
            TableRelation = "Doc & Cate Attachment-CS".Code;
            trigger OnValidate()
            var
                DocSubCat: Record "Doc & Cate Attachment-CS";
            Begin
                DocSubCat.Reset();
                DocSubCat.SetRange("Document Type", "Document Category");
                DocSubCat.SetRange(Code, "Document Sub Category");
                if DocSubCat.FindFirst() then
                    Description := DocSubCat.Description
                else
                    Description := '';
            End;
        }
        field(4; "Transaction No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document ID"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            begin
                Studentmaster.Reset();
                Studentmaster.SetRange(Studentmaster."No.", "Student No.");
                IF Studentmaster.FindFirst() then begin
                    "Student Name" := Studentmaster."Student Name";
                    "Enrolment No." := Studentmaster."Enrollment No.";
                    Semester := Studentmaster.Semester;
                    "Academic Year" := Studentmaster."Academic Year";
                    "Global Dimension 1 Code" := Studentmaster."Global Dimension 1 Code";
                    Term := Studentmaster.Term;
                    "First Name" := Studentmaster."First Name";
                    "Middle Name" := Studentmaster."Middle Name";
                    "Last Name" := Studentmaster."Last Name";
                end Else begin
                    "Enrolment No." := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "First Name" := '';
                    "Middle Name" := '';
                    "Last Name" := '';
                end;
            end;
        }
        field(7; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            Editable = false;
        }
        field(9; Semester; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
            Editable = false;
        }
        field(10; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "File Name"; Text[300])
        {
            DataClassification = CustomerContent;

        }
        field(13; "File Type"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Uploaded Source"; Option)
        {
            OptionCaption = ' ,SalesForce,SLcMBC,SLcMPortal,SchoolDocs';
            OptionMembers = " ",SalesForce,SLcMBC,SLcMPortal,SchoolDocs;
            DataClassification = CustomerContent;
        }
        field(15; "Document Status"; Option)
        {
            OptionCaption = ' ,Pending for Verification,Verified,Rejected,Requested-Required,Portal Submitted,Submitted,On File,Expired,Under Review,Auto Register - Basic Science New and Returning,Document Received NYC Office,Document Received On Campus,Forms Builder Submitted,No Longer Needed,Not Requested,Not Sent,Received but Rejected,Required,Requested - Not Required,Resubmitted,Revision to SchoolDocs,Revisions Required - Please Call Advisor,Sent,Under Review,When Needed';
            OptionMembers = " ","Pending for Verification",Verified,Rejected,"Requested-Required","Portal Submitted","Submitted","On File","Expired","Under Review","AUTOREG","DRNYC","DROC","FBSUB","NA","NO","NOTSENT","REJ","REQ","REQNR","RESUBMIT","REVSD","RRPCA","SENT","UREVIEW","WN";
            DataClassification = CustomerContent;
        }
        field(16; "Uploaded By"; code[100])
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(17; "Uploaded On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(18; "Document Update Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Status Updated By"; code[100])
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(21; "Status Updated Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(22; "Document Due"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(23; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "SLcM Document No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(26; "Uploaded Time"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }

        //
        field(27; "Due Date Days"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Doc Schedule ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Doc Status ID"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(32; Due; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Due Date"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Doc Type ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Date Required"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Date Recv"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(38; "ImageNow_Doc_ID0"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Comments2"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(198; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(199; "Middle Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(200; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(201; "Document Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(202; "Sorting No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(203; "Document Specialist ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Specialist';
            Editable = false;
        }
        field(205; "Validity Start Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ClinicalRequiredDcouments: Record "Doc & Cate Attachment-CS";
            begin
                ClinicalRequiredDcouments.Reset();
                if ClinicalRequiredDcouments.Get("Document Sub Category", "Document Category") then begin
                    if (ClinicalRequiredDcouments."Expiry Not Applicable" = false) and
                    ("Validity Start Date" <> 0D) and (ClinicalRequiredDcouments."Validity Days" > 0) then begin
                        "Expiry Date" := 0D;
                        "Expiry Date" := "Validity Start Date" + ClinicalRequiredDcouments."Validity Days";
                        "Validity Expiry Date" := "Expiry Date";
                    end;
                end;
            end;
        }
        field(206; "Validity Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(207; "Submission Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(208; "Documents Status"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = "Requested-Required","Portal Submitted","Submitted","On File","Rejected","Expired";
            trigger OnValidate()
            begin
                "Verified By" := '';
                "Verified On" := 0D;
                if "Documents Status" = "Documents Status"::"On File" then begin
                    TestField("Submission Date");
                    "Verified By" := UserId;
                    "Verified On" := Today;
                end;
                if "Documents Status" = "Documents Status"::"Requested-Required" then begin
                    "Submission Date" := 0D;
                    "Verified By" := '';
                    "Verified On" := 0D;
                end;
            end;
        }
        field(209; "Verified By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(210; "Verified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(211; "Reject Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = if ("Document Category" = filter('CLINICAL')) "Reason Code".Code where(Type = filter("Clerkship Documentation"))
            else
            "Reason Code".Code;

            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Reject Reason" := '';
                if ReasonCode.Get("Reject Reason Code") then
                    "Reject Reason" := ReasonCode.Description;
            end;
        }
        field(212; "Reject Reason"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(213; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(214; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(215; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(216; Updated; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Updated';
        }
        field(217; "Note Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(218; "Document Status Completed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(219; "Student Email"; Text[50])
        { //CSPL-00307 As per ajay
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."E-Mail Address" where("No." = field("Student No.")));
            Editable = false;
        }
        field(220; "Old Transaction No."; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(221; "New Transaction No."; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(222; "Old Student No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Student Status"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("No." = field("Student No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK_1; "Document Category", "Document Sub Category", "Student No.")
        {
            Clustered = false;
        }
        key(PK_2; "Student No.", "Document Status", "Document Category", "SLcM Document No")
        {
            Clustered = false;
        }
    }

    Trigger OnInsert()
    begin
        Inserted := True;
    end;

    Trigger OnModify()
    Begin

        If xRec.Updated = Updated then
            Updated := true;
    End;

    Trigger OnDelete()
    Begin
        IF UserSetupRec.GET(UserId()) THEN
            IF not UserSetupRec."Document Delete Allowed" THEN
                Error('You do not have permission to delete the document.')

    End;

    var
        Studentmaster: Record "Student Master-CS";
        UserSetupRec: Record "User Setup";

    procedure ImportAttachment(StudentNo: Code[20]; DocSubCategory: Code[500]; DocCategory: Code[500]; SLcMDocNo: Code[20]; SubCode: Code[20]; EntryNo: Integer)
    var
        Attachment_lRec: Record Attachment;
        TempBlob: Record "TempBlob Test";
        FileMgmt: Codeunit "File Management";
        locOutFile: BigText;
        ResponseText1: Text;
        FileName: Text;
        IStream: InStream;
        TempNo: Integer;
        TransNo: Text[100];
    // MemoryStream: DotNet NewImageStream;
    // Bytes: DotNet Bytes;
    // Convert: DotNet ImageConvert;
    begin
        TempBlob.Reset();
        TempBlob.DeleteAll();

        // FileName := FileMgmt.UploadFile('Upload', '');
        If FileName = '' then
            exit;

        TempBlob.INIT();
        // TempBlob.Blob.IMPORT(FileName);
        TempBlob.INSERT();
        TempBlob.Blob.CREATEINSTREAM(IStream);
        // MemoryStream := MemoryStream.MemoryStream();
        // COPYSTREAM(MemoryStream, IStream);
        // Bytes := MemoryStream.GetBuffer();
        // locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));

        ResponseText1 := UploadSchoolDoc(StudentNo, DocSubCategory, FileName, Format(locOutFile));


        IF StrPos(ResponseText1, '1</Success>') > 0 then begin
            TransNo := FindStringValue(ResponseText1);
            StudentDocumentAttachmentUpdate(FileName, TransNo, Attachment_lRec."File Extension", SLcMDocNo, EntryNo);
        end;

        Message('Document has been Uploded');
    END;

    procedure UploadSchoolDoc(StudentNo: Code[20]; DocumentSubCate: Code[500]; FileName: Text; PDFImage: Text) Responsetext: Text
    var
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
    begin
        api_url := StrSubstNo(('https://schooldocsconnect.com/connect/4fa76f7578a574e23112bec092625fb4'));
        http_content.clear();
        http_content.WriteFrom(
        '<SchoolDocs>' +
        '<Student>' +
        '<ID>' + StudentNo + '</ID>' +
        '</Student>' +
        '<Document>' +
        '<Type>' + DocumentSubCate + '</Type>' +
        '<FileName>' + FileName + '</FileName>' +
        '<PDFBytes>' + PDFImage + '</PDFBytes>' +
        '</Document>' +
        '</SchoolDocs>'
        );

        http_content.GetHeaders(http_Headers);
        http_Headers.Clear();
        http_Headers.Add('Content-type', 'application/xml');
        http_request.Content := http_content;
        http_request.GetHeaders(http_Headers);
        http_request.SetRequestUri(api_url);
        http_request.Method('POST');
        http_client.Send(http_request, http_response);
        http_response.Content().ReadAs(responseText);
    end;

    Procedure FindStringValue(ResponsesString: Text[2048]) TransactionNo: Text[100];
    var
        StringFind1: Text[2048];
        TransactionNo1: Text[500];
        Pos: Integer;
        Pos1: Integer;
        Pos2: Integer;
    begin
        StringFind1 := ResponsesString;
        Pos := STRPOS(StringFind1, '<TransactionID>');
        Pos1 := STRPOS(StringFind1, '</TransactionID>');
        Pos2 := Pos1 - Pos;

        TransactionNo1 := COPYSTR(StringFind1, Pos, Pos2);
        TransactionNo := COPYSTR(TransactionNo1, 16, StrLen(TransactionNo1));
    End;


    procedure StudentDocumentAttachmentUpdate(FileName: Text; TransactionNo: Text[100]; FileExt: Text[250]; SLcMDocumentNo: Code[20]; EntryNo: Integer)
    var
        StudentDocumentAttachment: Record "Student Document Attachment";
    begin
        StudentDocumentAttachment.RESET();
        StudentDocumentAttachment.SetRange("Entry No.", EntryNo);
        IF StudentDocumentAttachment.FindFirst() THEN begin
            StudentDocumentAttachment."Transaction No." := TransactionNo;
            StudentDocumentAttachment."File Name" := FileName;
            StudentDocumentAttachment."File Type" := FileExt;
            StudentDocumentAttachment."Uploaded On" := WorkDate();
            StudentDocumentAttachment."Uploaded Time" := Time();
            StudentDocumentAttachment."Uploaded By" := UserId();
            StudentDocumentAttachment."Uploaded Source" := StudentDocumentAttachment."Uploaded Source"::SLcMBC;
            StudentDocumentAttachment."Document Status" := StudentDocumentAttachment."Document Status"::"Pending for Verification";
            StudentDocumentAttachment."Status Updated By" := '';
            StudentDocumentAttachment."Status Updated Date" := 0D;
            StudentDocumentAttachment."Document Due" := WorkDate();
            StudentDocumentAttachment."Expiry Date" := WorkDate();
            StudentDocumentAttachment."SLcM Document No" := SLcMDocumentNo;
            StudentDocumentAttachment.Modify(true);
        End;
    End;

}