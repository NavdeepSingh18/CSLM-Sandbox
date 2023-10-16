xmlport 50070 "Student Document Attah"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Student Document Attachment"; "Student Document Attachment")
            {
                XmlName = 'StudentAtt';


                textelement(DocumentCategoryCode) { }
                //textelement(DocumentCategoryDescription) { }
                textelement(DocumentSubCategorycode) { }
                //textelement(DocumentSubCategorydescription) { }
                textelement(TransactionNo) { }
                textelement(DocumentID) { }
                textelement(StudentNo) { }
                textelement(EnrollmentNo) { }
                //textelement(ReferenceAdTermID) { }
                textelement(Academicyear) { }
                textelement(Semester) { }
                textelement(Term) { }
                textelement(GlobalDimension1Code) { }
                textelement(FileName) { }
                textelement(FileType) { }
                textelement(UploadedSource) { }
                textelement(DocumentStatuscode) { }
                //textelement(DocumentStatusDescription) { }
                textelement(UploadedBy) { }
                textelement(UploadedOn) { }
                textelement(DocumentUpdateDate) { }
                textelement(StatusUpdatedBy) { }
                textelement(StatusUpdatedDate) { }
                //textelement(DocumentDue) { }
                textelement(ExpiryDate) { }
                textelement(SLcMDocumentNo) { }
                textelement(SubjectCode) { }
                textelement(UploadedTime) { }
                textelement(DateRequired) { }
                textelement(DateRecv) { }
                textelement(DateDue) { }
                textelement(ImageNow_Doc_ID0) { }
                textelement(Comments) { }

                trigger OnBeforeInsertRecord()
                begin
                    StuDocAttChk.Reset();
                    if StuDocAttChk.FindLast() then
                        EntryNo := StuDocAttChk."Entry No." + 10000
                    else
                        EntryNo := 10000;
                    if EntryNo <> 0 then begin
                        StuDocAtt.Reset();
                        StuDocAtt.Init();
                        StuDocAtt."Entry No." := EntryNo;
                        StuDocAtt."Document Sub Category" := DocumentCategoryCode;
                        // StuDocAtt.cat desc
                        StuDocAtt."Document Category" := DocumentSubCategorycode;
                        // StuDocAtt.sub cat des
                        StuDocAtt."Transaction No." := TransactionNo;
                        StuDocAtt."Document ID" := DocumentID;
                        ////////////////////////
                        //StuDocAtt."Document Sub Category" := DocumentCategoryCode;
                        //StuDocAtt."Document Category" := DocumentSubCategorycode;
                        StuDocAtt."Transaction No." := TransactionNo;
                        StuDocAtt."Document ID" := DocumentID;
                        StuDocAtt."Student No." := StudentNo;
                        StuDocAtt."Enrolment No." := EnrollmentNo;
                        StuDocAtt."Academic year" := Academicyear;
                        StuDocAtt."Semester" := Semester;
                        if Term = 'FALL' then
                            StuDocAtt."Term" := StuDocAtt.term::FALL
                        else
                            if Term = 'SPRING' then
                                StuDocAtt."Term" := StuDocAtt.term::SPRING
                            else
                                if Term = 'SUMMER' then
                                    StuDocAtt."Term" := StuDocAtt.term::SUMMER;

                        StuDocAtt."Global Dimension 1 Code" := GlobalDimension1Code;
                        StuDocAtt."File Name" := FileName;
                        StuDocAtt."File Type" := FileType;

                        if UploadedSource = '' then
                            StuDocAtt."Uploaded Source" := StuDocAtt."Uploaded Source"::" ";
                        if UploadedSource = 'SalesForce' then
                            StuDocAtt."Uploaded Source" := StuDocAtt."Uploaded Source"::SalesForce;
                        if UploadedSource = 'SLcMBC' then
                            StuDocAtt."Uploaded Source" := StuDocAtt."Uploaded Source"::SLcMBC;
                        if UploadedSource = 'SLcMPortal' then
                            StuDocAtt."Uploaded Source" := StuDocAtt."Uploaded Source"::SLcMPortal;
                        if UploadedSource = 'SchoolDocs' then
                            StuDocAtt."Uploaded Source" := StuDocAtt."Uploaded Source"::SchoolDocs;
                        if DocumentStatuscode = '' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::" ";
                        if DocumentStatuscode = 'AUTOREG' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::AUTOREG;
                        if DocumentStatuscode = 'DRNYC' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::DRNYC;
                        if DocumentStatuscode = 'DROC' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::DROC;
                        if DocumentStatuscode = 'EXPIRED' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::Expired;
                        if DocumentStatuscode = 'NA' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::NA;
                        if DocumentStatuscode = 'NO' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::NO;
                        if DocumentStatuscode = 'NOTSENT' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::NOTSENT;
                        if DocumentStatuscode = 'OK' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::NO;
                        if DocumentStatuscode = 'PRTLSUB' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::"Portal Submitted";
                        if DocumentStatuscode = 'REJECT' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::Rejected;
                        if DocumentStatuscode = 'REQ' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::REQ;
                        if DocumentStatuscode = 'REQNR' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::REQNR;
                        if DocumentStatuscode = 'REQREQ' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::"Requested-Required";
                        if DocumentStatuscode = 'RRPCA' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::RRPCA;
                        if DocumentStatuscode = 'RESUBMIT' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::RESUBMIT;
                        if DocumentStatuscode = 'SUBMIT' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::Submitted;
                        if DocumentStatuscode = 'WN' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::WN;
                        if DocumentStatuscode = 'UREVIEW' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::"Under Review";
                        if DocumentStatuscode = 'SENT' then
                            StuDocAtt."Document Status" := StuDocAtt."Document Status"::SENT;


                        //StuDocAtt."Document Status Description" := DocumentStatusDescription;
                        StuDocAtt."Uploaded By" := UploadedBy;
                        // StuDocAtt."Doc Status ID"
                        // StuDocAtt.doc st
                        Evaluate(UploadedOn1, UploadedOn);
                        Evaluate(DocumentUpdateDate1, DocumentUpdateDate);
                        Evaluate(StatusUpdatedDate1, StatusUpdatedDate);
                        StuDocAtt."Uploaded On" := UploadedOn1;
                        StuDocAtt."Document Update Date" := DocumentUpdateDate1;
                        StuDocAtt."Status Updated By" := StatusUpdatedBy;
                        StuDocAtt."Status Updated Date" := StatusUpdatedDate1;
                        Evaluate(DocumentDue1, DateDue);
                        Evaluate(ExpiryDate1, ExpiryDate);
                        Evaluate(UploadedTime1, UploadedTime);
                        Evaluate(DateRequired1, DateRequired);
                        Evaluate(DateRecv1, DateRecv);
                        StuDocAtt."Document Due" := DocumentDue1;
                        StuDocAtt."Expiry Date" := ExpiryDate1;
                        StuDocAtt."SLcM Document No" := SLcMDocumentNo;
                        StuDocAtt."Subject Code" := SubjectCode;
                        StuDocAtt."Uploaded Time" := UploadedTime1;
                        StuDocAtt."Date Required" := DateRequired1;
                        StuDocAtt."Date Recv" := DateRecv1;
                        // StuDocAtt."Date Due" := DateDue;
                        //StuDocAtt."Due Date" := DateDue;
                        StuDocAtt."ImageNow_Doc_ID0" := ImageNow_Doc_ID0;
                        StuDocAtt."Comments" := Comments;
                        StuDocAtt.Insert();
                    end;
                    currXMLport.Skip();
                end;

            }
        }
    }

    requestpage
    {

        layout
        {
        }


    }
    trigger OnInitXmlPort()
    begin
        EntryNo := 0;

    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Uploaded Sucessfully !');
    end;

    var
        StuDocAtt: Record "Student Document Attachment";
        StuDocAttChk: Record "Student Document Attachment";
        EntryNo: Integer;
        UploadedOn1: Date;
        DocumentUpdateDate1: Date;
        StatusUpdatedDate1: Date;
        DocumentDue1: Date;
        UploadedTime1: Time;

        ExpiryDate1: Date;
        DateRequired1: Date;
        DateRecv1: Date;
}

