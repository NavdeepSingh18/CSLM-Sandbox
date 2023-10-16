Codeunit 50034 WebServicesFunctionsCSL
{
    procedure GenerateGrade(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    //XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportalUAT.corporateserve.com/SLCMAPI.asmx/Generate_Grade_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        // Message(ResponseText);

    End;

    procedure Generate_Allocation_Grade_Markeup_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Allocation_Grade_Markeup_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText)
    End;

    procedure Generate_Allocation_Grade_Revaluation1_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Allocation_Grade_Revaluation1_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);

    end;

    procedure Generate_Allocation_Grade_Revaluation2_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Allocation_Grade_Revaluation2_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText)
    end;

    procedure Generate_Allocation_Grade_Special_Exam_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    //XMLDoc: XmlDocument;
    //XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Allocation_Grade_Special_Exam_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);
    end;

    procedure Generate_Allocation_Grade_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Allocation_Grade_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);
    end;


    procedure Generate_CGPA_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_CGPA_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);
    end;


    procedure Generate_GPA_Util(InstituteCode: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    //XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_GPA_Util?InstituteCode=%1', InstituteCode);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);
    end;


    procedure Generate_Time_Table_Update_Util(DocumentNo: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        //HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Time_Table_Update_Util?DocumentNo=%1', DocumentNo);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);

    End;

    procedure Generate_Time_Table_Util(DocumentNo: Text);

    var
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // HttpRequest: HttpRequestMessage;
        // HttpHeader: HttpHeaders;
        // HttpCont: HttpContent;

        ResponseText: Text;
        URL: Text;
    // XMLDoc: XmlDocument;
    // XMLElmt: XmlElement;

    begin
        URL := StrSubstNo('http://meaportal.corporateserve.com/SLCMAPI.asmx/Generate_Time_Table_Util?DocumentNo=%1', DocumentNo);

        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //Message(ResponseText);
    end;


    //START::Portal API Creation





    // [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_Allocation_Grade_Markeup_UtilOnModify(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_Allocation_Grade_Markeup_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");
    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // End;

    // [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_Allocation_Grade_Revaluation1_UtilOnModify(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_Allocation_Grade_Revaluation1_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_Allocation_Grade_Revaluation2_UtilOnModify(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_Allocation_Grade_Revaluation2_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_Allocation_Grade_Special_Exam_UtilOnModify(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;


    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_Allocation_Grade_Special_Exam_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_Allocation_Grade_UtilOnModify(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;


    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_Allocation_Grade_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50057, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_CGPA_UtilOnModify(VAR Rec: Record "Student Master-CS"; VAR xRec: Record "Student Master-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;

    //     ResponseText: Text;
    //     URL: Text;


    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_CGPA_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, 50057, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_GPA_UtilOnModify(VAR Rec: Record "Student Master-CS"; VAR xRec: Record "Student Master-CS"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;

    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + 'Generate_GPA_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, 50298, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalGenerate_Grade_UtilOnModify(VAR Rec: Record "Grade Cutoff Master-CS"; VAR xRec: Record "Grade Cutoff Master-CS"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;


    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Generate_Grade_Util?InstituteCode=%1', Rec."Global Dimension 1 Code");

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, '');
        end;

    End;

    // procedure ApiPortalSave_Update_Academics_DocCateAttachment
    // (
    //     Code1: Code[20];
    //     DocumentType: Text[30];
    //     Description: Code[20];
    //     Mandatory: Boolean;
    //     GlobalDimension1Code: Code[20];
    //     GlobalDimension2Code: Code[20];
    //     UserID: Code[30];
    //     PortalID: Code[20];
    //     Updated: Boolean
    // );
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_DocCateAttachment?Code=%1&DocumentType=%2&Description=%3&Mandatory=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&UserID=%7&PortalID=%8&Updated=%9', Code1, DocumentType, Description, HandlingBoolean(Mandatory), GlobalDimension1Code, GlobalDimension2Code, UserID, PortalID, HandlingBoolean(Updated));

    //     If HttpClnt.Get(URL, HttpResponse) then
    //            HttpResponse.Content().ReadAs(ResponseText);
    //         IF Not (StrPos(ResponseText, 'ok') > 0) then
    //             SaveApiLogDetails(Rec.TableName(), ResponseText, '');

    // End;


























    // [EventSubscriber(ObjectType::Table, 50347, 'OnAfterInsertEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Student_Clinical_DcoumentsOnInsert(VAR Rec: Record "Student Clinical Dcouments"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Student_Clinical_Dcouments?StudentNo=%1&TypeofDocument=%2&DocumentDescription=%3&SortingNo=%4&FirstName=%5&MiddleName=%6&LastName=%7&StudentName=%8&EnrollmentNo_=%9&DueDate=%10&ValidityStartDate=%11&Validity_Expiry_Date=%12&SubmissionDate=%13&DocumentsStatus=%14&VerifiedBy=%15&VerifiedOn=%16&RejectReasonCode=%17&RejectReason=%18&FileExtension=%19&FilePath=%20&AttachedOn=%21&systemId=%22', Rec."Student No.", HandlingOption(Rec."Type of Document"), Rec."Document Description", Rec."Sorting No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", FORMAT(Rec."Due Date", 0, 9), FORMAT(Rec."Validity Start Date", 0, 9), FORMAT(Rec."Validity Expiry Date", 0, 9), FORMAT(Rec."Submission Date", 0, 9), HandlingOption(Rec."Documents Status"), Rec."Verified By", FORMAT(Rec."Verified On", 0, 9), Rec."Reject Reason Code", Rec."Reject Reason", Rec."File Extension", Rec."File Path", FORMAT(Rec."Attached On", 0, 9), Rec.SystemId);

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     End;
    // end;

    // [EventSubscriber(ObjectType::Table, 50347, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Student_Clinical_DcoumentsOnModify(VAR Rec: Record "Student Clinical Dcouments"; VAR xRec: Record "Student Clinical Dcouments"; RunTrigger: Boolean)
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Student_Clinical_Dcouments?StudentNo=%1&TypeofDocument=%2&DocumentDescription=%3&SortingNo=%4&FirstName=%5&MiddleName=%6&LastName=%7&StudentName=%8&EnrollmentNo_=%9&DueDate=%10&ValidityStartDate=%11&Validity_Expiry_Date=%12&SubmissionDate=%13&DocumentsStatus=%14&VerifiedBy=%15&VerifiedOn=%16&RejectReasonCode=%17&RejectReason=%18&FileExtension=%19&FilePath=%20&AttachedOn=%21&systemId=%22', Rec."Student No.", HandlingOption(Rec."Type of Document"), Rec."Document Description", Rec."Sorting No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", FORMAT(Rec."Due Date", 0, 9), FORMAT(Rec."Validity Start Date", 0, 9), FORMAT(Rec."Validity Expiry Date", 0, 9), FORMAT(Rec."Submission Date", 0, 9), HandlingOption(Rec."Documents Status"), Rec."Verified By", FORMAT(Rec."Verified On", 0, 9), Rec."Reject Reason Code", Rec."Reject Reason", Rec."File Extension", Rec."File Path", FORMAT(Rec."Attached On", 0, 9), Rec.SystemId);

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     End;
    // end;

    // [EventSubscriber(ObjectType::Table, 50364, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Student_Hold_MasterOnModify(VAR Rec: Record "Student Hold"; VAR xRec: Record "Student Hold"; RunTrigger: Boolean)
    // var

    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Student_Hold_Master?HoldCode=%1&HoldDescription=%2&HoldType=%3&PotalLoginRestriction=%4&ClinicalRotation=%5&TranscriptPrint=%6&Progression=%7&Billing=%8&GlobalDimension1Code=%9&GlobalDimension2Code=%10&Inserted=%11&Updated=%12&CreatedBy=%13&CreatedOn=%14&ModifiedBy=%15&ModifiedOn=%16&systemId=%17', Rec."Hold Code", Rec."Hold Description", HandlingOption(Rec."Hold Type"), HandlingBoolean(Rec."Potal Login Restriction"), HandlingBoolean(Rec."Clinical Rotation"), HandlingBoolean(Rec."Transcript Print"), HandlingBoolean(Rec.Progression), HandlingBoolean(Rec.Billing), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec.SystemId);

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //     End;
    // end;









    // procedure ApiPortalSave_Update_StudentDocumentUpload
    // (
    //     documentid: Code[20];
    //     transactionid: Code[20];
    //     no_: Code[20];
    //     enrolmentno: Code[20];
    //     documentcategory: Option;
    //     documentsubcategory: Code[10];
    //     documentcategoryname: Text[100];
    //     documentname: Text[50];
    //     status: Option
    // );

    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentDocumentUpload?documentid=%1;transactionid=%2;no_=%3;enrolmentno=%4;documentcategory=%5;documentsubcategory=%6;documentcategoryname=%7;documentname=%8;status=%9', documentid, transactionid, no_, enrolmentno, HandlingOption(documentcategory), documentsubcategory, documentcategoryname, documentname, HandlingOption(status));

    //     If HttpClnt.Get(URL, HttpResponse) then
    //            HttpResponse.Content().ReadAs(ResponseText);
    //         IF Not (StrPos(ResponseText, 'ok') > 0) then
    //             SaveApiLogDetails(Rec.TableName(), ResponseText, '');
    // End;



















    // procedure ApiPortalSave_Update_Academics_ApplicationState
    // (
    // Code1: Code[10];
    // Description: Text[50];
    // StateCodeforeTDSTCS: Code[2];
    // StateCodeforTIN: Code[2];
    // TaxAccountSales: Code[20];
    // TaxAccountPurchases: Code[20];
    // VATDeferredAccountNo: Code[20];
    // VATPayableAccountNo: Code[20];
    // VATRefundAccountNo: Code[20];
    // ExcessCrCFAccountNo: Code[20];
    // BranchTransferRetention: Decimal;
    // TaxPeriod: Text[32];
    // SpecifiedPeriodforRefund: Text[32];
    // PeriodforDebitCreditNote: Text[32];
    // DefermentPeriod: Text[32];
    // FinancialYear: Integer;
    // CSTAccountSales: Code[20];
    // CountryRegionCode: Code[10];
    // SISCode: Code[10]

    // );

    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;
    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_ApplicationState?Code=%1;Description=%2;StateCodeforeTDSTCS=%3;StateCodeforTIN=%4;TaxAccountSales=%5;TaxAccountPurchases=%6;VATDeferredAccountNo=%7;VATPayableAccountNo=%8;VATRefundAccountNo=%9;ExcessCrCFAccountNo=%10;BranchTransferRetention=%11;TaxPeriod=%12;SpecifiedPeriodforRefund=%13;PeriodforDebitCreditNote=%14;DefermentPeriod=%15;FinancialYear=%16;CSTAccountSales=%17;CountryRegionCode=%18;SISCode=%19', Code1, Description, StateCodeforeTDSTCS, StateCodeforTIN, TaxAccountSales, TaxAccountPurchases, VATDeferredAccountNo, VATPayableAccountNo, VATRefundAccountNo, ExcessCrCFAccountNo, BranchTransferRetention, TaxPeriod, SpecifiedPeriodforRefund, PeriodforDebitCreditNote, DefermentPeriod, FinancialYear, CSTAccountSales, CountryRegionCode, SISCode);

    //     If HttpClnt.Get(URL, HttpResponse) then
    //            HttpResponse.Content().ReadAs(ResponseText);
    //         IF Not (StrPos(ResponseText, 'ok') > 0) then
    //             SaveApiLogDetails(Rec.TableName(), ResponseText, '');

    // end;

    procedure EmployeeCreation(var EmployeeRec: Record Employee)
    var
        RecCompanyInformation: Record "Company Information";
        InstituteRoleCS: Record "Institute Role-CS";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        EmployeeRec.TestField("No.");
        EmployeeRec.TestField("First Name");
        EmployeeRec.TestField("Last Name");
        EmployeeRec.TestField("Global Dimension 1 Code");

        InstituteRoleCS.Reset();
        InstituteRoleCS.SETRANGE("Role Name", EmployeeRec."Employee Group");
        if InstituteRoleCS.FINDFIRST() then;

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Faculty_Creation?no_=%1&firstname=%2&middlename=%3&lastname=%4&globaldimension1code=%5&Role=%6&Globaldimension2code=%7', EmployeeRec."No.", EmployeeRec."First Name", EmployeeRec."Middle Name", EmployeeRec."Last Name", EmployeeRec."Global Dimension 1 Code", InstituteRoleCS."Role Code", EmployeeRec."Global Dimension 2 Code");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            //  PortalUserLoginEmployeeInsert(EmployeeRec, '', '', '');

            ResponseText := CopyStr(ResponseText, 1, 2048);
            IF StrPos(ResponseText, 'UserID') > 0 then
                FindStringValueEmployee(EmployeeRec, ResponseText) //Split String & Portal User ID Creation
            Else
                SaveApiLogDetails(EmployeeRec.TableName(), ResponseText, '');
        end;
    end;

    Procedure FindStringValueEmployee(var EmployeeRec: Record Employee; ResponsesString: Text[2048])
    var
        RecEmployee: Record Employee;
        StringFind1: Text[2048];
        StringFind2: Text[2048];
        StringFind3: Text[2048];
        UserIDString: Text[200];
        UserIDStringFinal: Code[50];
        EmailIDString: Text[200];
        EmailIDStringFinal: Text[80];
        PasswordString: Text[200];
        PasswordStringFinal: Code[30];
    begin
        StringFind1 := CopyStr(ResponsesString, 77, StrLen(ResponsesString));
        StringFind2 := Token(StringFind1, '<');
        StringFind3 := DelChr(StringFind2, '=', ' ');

        //Find User ID
        UserIDString := Token(StringFind3, ',');
        UserIDStringFinal := DelStr(UserIDString, 1, 7);
        //FIND Email ID
        EmailIDString := SelectStr(1, StringFind3);
        EmailIDStringFinal := DelStr(EmailIDString, 1, 8);
        //Find Password ID
        PasswordString := SelectStr(2, StringFind3);
        PasswordStringFinal := DelStr(PasswordString, 1, 9);

        PortalUserLoginEmployeeInsert(EmployeeRec, UserIDStringFinal, EmailIDStringFinal, PasswordStringFinal);
    end;

    procedure PortalUserLoginEmployeeInsert(var EmployeeRec: Record Employee; EmployeeUserID: Code[50]; EmployeeEmailID: Text[80]; EmployeePassword: Code[30])
    var
        PortalUserLoginCS: Record "Portal User Login-CS";
        PortalUserLoginCS1: Record "Portal User Login-CS";
        EntryNo: Integer;
    begin
        PortalUserLoginCS.Reset();
        IF PortalUserLoginCS.FINDLAST() THEN
            EntryNo := PortalUserLoginCS.No + 1
        ELSE
            EntryNo := 1;

        PortalUserLoginCS.Reset();
        PortalUserLoginCS.SETRANGE(U_ID, EmployeeRec."No.");
        IF PortalUserLoginCS.FINDSET() THEN begin
            PortalUserLoginCS."Login ID" := EmployeeUserID;
            PortalUserLoginCS.Password := EmployeePassword;
            PortalUserLoginCS.Email := EmployeeEmailID;
            PortalUserLoginCS.Modify();
        end;
        // else begin
        //     PortalUserLoginCS1.INIT();
        //     PortalUserLoginCS1.No := EntryNo;
        //     PortalUserLoginCS1.Type := PortalUserLoginCS1.Type::Employee;
        //     PortalUserLoginCS1.U_ID := EmployeeRec."No.";
        //     PortalUserLoginCS1."Login ID" := EmployeeUserID;
        //     PortalUserLoginCS1.Password := EmployeePassword;
        //     PortalUserLoginCS1."User Group" := 'Employee';
        //     PortalUserLoginCS1."Global Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
        //     PortalUserLoginCS1."Global Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
        //     PortalUserLoginCS1.Role_Code := 'ROLE00004';
        //     PortalUserLoginCS1.WindowsAuthentication := FALSE;
        //     PortalUserLoginCS1.IsAdmin := FALSE;
        //     PortalUserLoginCS1.UserName := copystr(EmployeeRec."Search Name", 1, 50);
        //     PortalUserLoginCS1.MobileNo := EmployeeRec."Phone No.";
        //     PortalUserLoginCS1.Email := EmployeeEmailID;
        //     PortalUserLoginCS1."Created By" := FORMAT(UserId());
        //     PortalUserLoginCS1."Created On" := TODAY();
        //     PortalUserLoginCS1.INSERT();
        // end;
        EmployeeRec."Company E-Mail" := EmployeeEmailID;
        EmployeeRec."Web Portal Password" := EmployeePassword;
    end;

    procedure StudentCreation(var StudentMaster: Record "Student Master-CS")
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        StudentMaster.TestField("No.");
        StudentMaster.TestField("First Name");
        StudentMaster.TestField("Last Name");
        StudentMaster.TestField("Academic Year");
        StudentMaster.TestField(Semester);
        StudentMaster.TestField("Global Dimension 1 Code");
        StudentMaster.TestField("Course Code");
        StudentMaster.TestField("Course Name");
        StudentMaster.TestField("Enrollment No.");
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Student_Creation?no_=%1&firstname=%2&middlename=%3&lastname=%4&academicyear=%5&coursecode=%6&semester=%7&globaldimension1code=%8&coursename=%9&enrollmentno_=%10&StudentAlternateEmailAddress=%11&creationdate=%12&Originalstudentno=%13', StudentMaster."No.", StudentMaster."First Name", StudentMaster."Middle Name", StudentMaster."Last Name", StudentMaster."Academic Year", StudentMaster."Course Code", StudentMaster.Semester, StudentMaster."Global Dimension 1 Code", StudentMaster."Course Name", StudentMaster."Enrollment No.", StudentMaster."Alternate Email Address", format(StudentMaster."Creation Date", 0, 9), StudentMaster."Original Student No.");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            PortalUserLoginInsert(StudentMaster, '', '', '');

            ResponseText := CopyStr(ResponseText, 1, 2048);
            IF StrPos(ResponseText, 'UserID') > 0 then
                FindStringValue(StudentMaster, ResponseText) //Split String & Portal User ID Creation
            Else
                SaveApiLogDetails(StudentMaster.TableName(), ResponseText, 'Student_Creation');
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50057, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalNewStudentCreationOnModify(VAR Rec: Record "Student Master-CS"; VAR xRec: Record "Student Master-CS"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" then begin
            ModifyStudent1(Rec);
            ModifyStudent2(Rec);
            ModifyStudent3(Rec);
            ModifyStudent4(Rec);
            ModifyStudent5(Rec);
            ModifyStudent6(Rec);
            ModifyStudent7(Rec);
            ModifyStudent8(Rec);
        end;
        // if (Rec.Status <> '') and (Rec."18 Digit ID" <> '') then
        //     SLcMToSalesforce.StudentStatusSFInsert(Rec);
    end;

    Procedure ModifyStudent1(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
                '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
                '"FirstName": "' + EscapeValue(Format(StudentRec."First Name")) + '",' +
                '"LastName": "' + EscapeValue(Format(StudentRec."Last Name")) + '",' +
                '"middlename": "' + EscapeValue(Format(StudentRec."Middle Name")) + '",' +
                '"nameasoncertificate": "' + EscapeValue(Format(StudentRec."Name as on Certificate")) + '",' +
                '"studentname": "' + EscapeValue(Format(StudentRec."Student Name")) + '",' +
                '"dateofbirth": "' + EscapeValue(Format(StudentRec."Date of Birth", 0, 9)) + '",' +
                '"fathersname": "' + EscapeValue(Format(StudentRec."Fathers Name")) + '",' +
                '"mothersname": "' + EscapeValue(Format(StudentRec."Mothers Name")) + '",' +
                '"citizenship": "' + EscapeValue(Format(HandlingOption(StudentRec.Citizenship))) + '",' +
                '"academicyear": "' + EscapeValue(Format(StudentRec."Academic Year")) + '",' +
                '"coursecode": "' + EscapeValue(Format(StudentRec."Course Code")) + '",' +
                '"universityinterested": "' + EscapeValue(Format(StudentRec."University Interested")) + '",' +
                '"nameofpreviousinst": "' + EscapeValue(Format(StudentRec."Name of Previous Inst")) + '",' +
                '"certificationauthority": "' + EscapeValue(Format(StudentRec."Certification Authority")) + '",' +
                '"mediumofinstruction": "' + EscapeValue(Format(StudentRec."Medium of Instruction")) + '",' +
                '"addressto": "' + EscapeValue(Format(StudentRec."Address To")) + '",' +
                '"addressee": "' + EscapeValue(Format(StudentRec.Addressee)) + '",' +
                '"address1": "' + EscapeValue(Format(StudentRec.Address1)) + '",' +
                '"address2": "' + EscapeValue(Format(StudentRec.Address2)) + '",' +
                '"city": "' + EscapeValue(Format(StudentRec.City)) + '",' +
                '"postcode": "' + EscapeValue(Format(StudentRec."Post Code")) + '",' +
                '"countrycode": "' + EscapeValue(Format(StudentRec."Country Code")) + '",' +
                '"mobilenumber": "' + EscapeValue(Format(StudentRec."Mobile Number")) + '",' +
                '"phonenumber": "' + EscapeValue(Format(StudentRec."Phone Number")) + '",' +
                '"gender": "' + EscapeValue(Format(Handlingoption(StudentRec.Gender))) + '",' +
                '"state": "' + EscapeValue(Format(StudentRec.State)) + '",' +
                '"address3": "' + EscapeValue(Format(StudentRec.Address3)) + '",' +
                '"visaexpirydate": "' + EscapeValue(Format(StudentRec."Visa Expiry Date", 0, 9)) + '",' +
                '"cocurricularactivities": "' + EscapeValue(Format(StudentRec."Co-Curricular Activities")) + '",' +
                '"foodhabits": "' + EscapeValue(Format(HandlingOption(StudentRec."Food Habits"))) + '",' +
                '"passportno_": "' + EscapeValue(Format(StudentRec."Pass Port No.")) + '",' +
                '"passportexpirydate": "' + EscapeValue(Format(StudentRec."Pass Port Expiry Date", 0, 9)) + '",' +
                '"caste": "' + EscapeValue(Format(StudentRec.Caste)) + '",' +
                '"promotiongranted": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Promotion Granted"))) + '",' +
                '"presentlyresidingwith": "' + EscapeValue(Format(StudentRec."Presently Residing with")) + '",' +
                '"quota": "' + EscapeValue(Format(StudentRec.Quota)) + '",' +
                '"fathersoccupation": "' + EscapeValue(Format(StudentRec."Fathers Occupation")) + '",' +
                '"fathersannualincome": "' + EscapeValue(Format(StudentRec."Fathers Annual Income")) + '"' +
                '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent1');
        end;
    end;

    Procedure ModifyStudent2(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
            '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
            '"mothersoccupation": "' + EscapeValue(Format(StudentRec."Mothers Occupation")) + '",' +
            '"mothersannualincome": "' + EscapeValue(Format(StudentRec."Mothers Annual Income")) + '",' +
            '"guardianname": "' + EscapeValue(Format(StudentRec."Guardian Name")) + '",' +
            '"guardianoccupation": "' + EscapeValue(Format(StudentRec."Guardian Occupation")) + '",' +
            '"guardianannualincome": "' + EscapeValue(Format(StudentRec."Guardian Annual Income")) + '",' +
            '"nationality": "' + EscapeValue(Format(StudentRec.Nationality)) + '",' +
            '"physicallychallenged": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Physically Challenged"))) + '",' +
            '"visuallychallenged": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Visually Challenged"))) + '",' +
            '"firstgenerationleaner": "' + EscapeValue(Format(HandlingBoolean(StudentRec."First Generation Leaner"))) + '",' +
            '"staffchild": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Staff Child"))) + '",' +
            '"staffcode": "' + EscapeValue(Format(StudentRec."Staff Code")) + '",' +
            '"breakinstudy": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Break In Study"))) + '",' +
            '"sportsperson": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Sports Person"))) + '",' +
            '"sportsspecialization": "' + EscapeValue(Format(StudentRec."Sports Specialization")) + '",' +
            '"enquiryno_": "' + EscapeValue(Format(StudentRec."Enquiry No.")) + '",' +
            '"religion": "' + EscapeValue(Format(StudentRec.Religion)) + '",' +
            '"visano_": "' + EscapeValue(Format(StudentRec."Visa No.")) + '",' +
            '"age": "' + EscapeValue(Format(StudentRec.Age)) + '",' +
            '"months": "' + EscapeValue(Format(StudentRec.Months)) + '",' +
            '"dateofjoining": "' + EscapeValue(Format(StudentRec."Date of Joining", 0, 9)) + '",' +
            '"dateofleaving": "' + EscapeValue(Format(StudentRec."Date of Leaving", 0, 9)) + '",' +
            '"newstudent": "' + EscapeValue(Format(HandlingBoolean(StudentRec."New Student"))) + '",' +
            '"staffname": "' + EscapeValue(Format(StudentRec."Staff Name")) + '",' +
            '"semester": "' + EscapeValue(Format(StudentRec.Semester)) + '",' +
            '"feeclassificationcode": "' + EscapeValue(Format(StudentRec."Fee Classification Code")) + '",' +
            '"section": "' + EscapeValue(Format(StudentRec.Section)) + '",' +
            '"studentstatus": "' + EscapeValue(Format(HandlingOption(StudStatus.Status))) + '",' +
            '"admittedyear": "' + EscapeValue(Format(StudentRec."Admitted Year")) + '",' +
            '"currentyear": "' + EscapeValue(Format(StudentRec."Current Year")) + '",' +
            '"applicationno_": "' + EscapeValue(Format(StudentRec."Application No.")) + '",' +
            '"mess": "' + EscapeValue(Format(StudentRec.Mess)) + '",' +
            '"cgpagrade": "' + EscapeValue(Format(StudentRec."CGPA Grade")) + '",' +
            '"latestrank": "' + EscapeValue(Format(StudentRec."Latest Rank")) + '",' +
            '"latestgpa": "' + EscapeValue(Format(StudentRec."Latest GPA")) + '",' +
            '"latestgrade": "' + EscapeValue(Format(StudentRec."Latest Grade")) + '",' +
            '"specialization": "' + EscapeValue(Format(StudentRec.Specialization)) + '",' +
            '"globaldimension1code": "' + EscapeValue(Format(StudentRec."Global Dimension 1 Code")) + '",' +
            '"globaldimension2code": "' + EscapeValue(Format(StudentRec."Global Dimension 2 Code")) + '",' +
            '"prospectusno_": "' + EscapeValue(Format(StudentRec."Prospectus No.")) + '"' +
            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent2');
        end;
    end;

    Procedure ModifyStudent3(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
                '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
                '"gaptaken": "' + EscapeValue(Format(StudentRec."Gap Taken")) + '",' +
            '"category": "' + EscapeValue(Format(StudentRec.Category)) + '",' +
            '"branchtransfer": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Branch Transfer"))) + '",' +
            '"graduation": "' + EscapeValue(Format(StudentRec.Graduation)) + '",' +
            '"group": "' + EscapeValue(Format(StudentRec."Group")) + '",' +
            '"batch": "' + EscapeValue(Format(StudentRec.Batch)) + '",' +
            '"typeofcourse": "' + EscapeValue(Format(HandlingOption(StudentRec."Type Of Course"))) + '",' +
            '"finalyearscouawwrse": "' + EscapeValue(Format(StudentRec."Final Years Course")) + '",' +
            '"paytype": "' + EscapeValue(Format(HandlingOption(StudentRec."Pay Type"))) + '",' +
            '"year": "' + EscapeValue(Format(StudentRec.year)) + '",' +
            '"address4": "' + EscapeValue(Format(StudentRec.Address4)) + '",' +
            '"corcity": "' + EscapeValue(Format(StudentRec."Cor City")) + '",' +
            '"corstate": "' + EscapeValue(Format(StudentRec."Cor State")) + '",' +
            '"corcountrycode": "' + EscapeValue(Format(StudentRec."Cor Country Code")) + '",' +
            '"corpostcode": "' + EscapeValue(Format(StudentRec."Cor Post Code")) + '",' +
            '"sameaspermanentaddress": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Same As Permanent Address"))) + '",' +
            '"disability": "' + EscapeValue(Format(HandlingBoolean(StudentRec.Disability))) + '",' +
            '"maritalstatus": "' + EscapeValue(Format(HandlingOption(StudentRec."Marital Status"))) + '",' +
            '"mothertongue": "' + EscapeValue(Format(StudentRec."Mother Tongue")) + '",' +
            '"residentstatus": "' + EscapeValue(Format(StudentRec."Residency Status")) + '",' +
            '"cordistrict": "' + EscapeValue(Format(StudentRec."Cor District")) + '",' +
            '"coursename": "' + EscapeValue(Format(StudentRec."Course Name")) + '",' +
            '"prequalificationsubject": "' + EscapeValue(Format(StudentRec."Pre Qualification Subject")) + '",' +
            '"joiningday": "' + EscapeValue(Format(StudentRec."Joining Day")) + '",' +
            '"joiningmonth": "' + EscapeValue(Format(StudentRec."Joining Month")) + '",' +
            '"prequalification": "' + EscapeValue(Format(HandlingOption(StudentRec."Pre Qualification"))) + '",' +
            '"stateofdomicile": "' + EscapeValue(Format(StudentRec."State Of Domicile")) + '",' +
            '"semestericreditearned": "' + EscapeValue(Format(StudentRec."Semester I Credit Earned")) + '",' +
            '"semesteriicreditearned": "' + EscapeValue(Format(StudentRec."Semester II Credit Earned")) + '",' +
            '"semesteriiicreditearned": "' + EscapeValue(Format(StudentRec."Semester III Credit Earned")) + '",' +
            '"semesterivcreditearned": "' + EscapeValue(Format(StudentRec."Semester IV Credit Earned")) + '",' +
            '"semestervcreditearned": "' + EscapeValue(Format(StudentRec."Semester V Credit Earned")) + '",' +
            '"semestervicreditearned": "' + EscapeValue(Format(StudentRec."Semester VI Credit Earned")) + '",' +
            '"semesterviicreditearned": "' + EscapeValue(Format(StudentRec."Semester VII Credit Earned")) + '",' +
            '"semesterviiicreditearned": "' + EscapeValue(Format(StudentRec."Semester VIII Credit Earned")) + '",' +
            '"netsemestercgpa": "' + EscapeValue(Format(StudentRec."Net Semester CGPA")) + '",' +
            '"netyearcgpa": "' + EscapeValue(Format(StudentRec."Net Year CGPA")) + '"' +
            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent3');
        end;
    end;

    Procedure ModifyStudent4(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
                '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
            '"year1creditearned": "' + EscapeValue(Format(StudentRec."Year 1 Credit Earned")) + '",' +
            '"year2creditearned": "' + EscapeValue(Format(StudentRec."Year 2 Credit Earned")) + '",' +
            '"year3creditearned": "' + EscapeValue(Format(StudentRec."Year 3 Credit Earned")) + '",' +
            '"year4creditearned": "' + EscapeValue(Format(StudentRec."Year 4 Credit Earned")) + '",' +
            '"year1gpa": "' + EscapeValue(Format(StudentRec."Year 1 GPA")) + '",' +
            '"year2gpa": "' + EscapeValue(Format(StudentRec."Year 2 GPA")) + '",' +
            '"year3gpa": "' + EscapeValue(Format(StudentRec."Year 3 GPA")) + '",' +
            '"year4gpa": "' + EscapeValue(Format(StudentRec."Year 4 GPA")) + '",' +
            '"scholarshipno": "' + EscapeValue(Format(StudentRec."Scholarship Source")) + '",' +
            '"appliedforscholarship": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Applied For Scholarship"))) + '",' +
            '"approvedforscholarship": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Approved For Scholarship"))) + '",' +
            '"userid": "' + EscapeValue(Format(StudentRec."User ID")) + '",' +
            '"portalid": "' + EscapeValue(Format(StudentRec."Portal ID")) + '",' +
            '"department": "' + EscapeValue(Format(StudentRec.Department)) + '",' +
            '"bloodgroup": "' + EscapeValue(Format(HandlingOption(StudentRec."Blood Group"))) + '",' +
            '"district": "' + EscapeValue(Format(StudentRec.District)) + '",' +
            '"alternateemailaddress": "' + EscapeValue(Format(StudentRec."Alternate Email Address")) + '",' +
            '"domicile": "' + EscapeValue(Format(StudentRec.Domicile)) + '",' +
            '"emergencycontactno_": "' + EscapeValue(Format(StudentRec."Emergency Contact No.")) + '",' +
            '"session": "' + EscapeValue(Format(StudentRec.Session)) + '",' +
            '"enrollmentno_": "' + EscapeValue(Format(StudentRec."Enrollment No.")) + '",' +
            '"holdresult": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Hold Result"))) + '",' +
            '"result": "' + EscapeValue(Format(HandlingOption(StudentRec.Result))) + '",' +
            '"semesteripass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester I Pass"))) + '",' +
            '"semesteriipass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester II Pass"))) + '",' +
            '"semesteriiipass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester III Pass"))) + '",' +
            '"semesterivpass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester IV Pass"))) + '",' +
            '"semestervpass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester V Pass"))) + '",' +
            '"semestervipass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester VI Pass"))) + '",' +
            '"semesterviipass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester VII Pass"))) + '",' +
            '"semesterviiipass": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Semester VIII Pass"))) + '",' +
            '"semesterigpa": "' + EscapeValue(Format(StudentRec."Semester I GPA")) + '",' +
            '"semesteriigpa": "' + EscapeValue(Format(StudentRec."Semester II GPA")) + '",' +
            '"semesteriiigpa": "' + EscapeValue(Format(StudentRec."Semester III GPA")) + '",' +
            '"semesterivgpa": "' + EscapeValue(Format(StudentRec."Semester IV GPA")) + '",' +
            '"semestervgpa": "' + EscapeValue(Format(StudentRec."Semester V GPA")) + '",' +
            '"semestervigpa": "' + EscapeValue(Format(StudentRec."Semester VI GPA")) + '",' +
            '"semesterviigpa": "' + EscapeValue(Format(StudentRec."Semester VII GPA")) + '",' +
            '"semesterviiigpa": "' + EscapeValue(Format(StudentRec."Semester VIII GPA")) + '",' +
            '"transportfacility": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Transport Facility"))) + '",' +
            '"examinationform": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Examination Form"))) + '"' +
            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent4');
        end;
    end;

    Procedure ModifyStudent5(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
                '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
            '"provisionaldegree": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Provisional Degree"))) + '",' +
            '"finaldegree": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Final Degree"))) + '",' +
            '"coursecode_minor": "' + EscapeValue(Format(StudentRec."Course Code(Minor)")) + '",' +
            '"no_series": "' + EscapeValue(Format(StudentRec."No. Series")) + '",' +
            '"transportallot": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Transport Allot"))) + '",' +
            '"allfieldsupdated": "' + EscapeValue(Format(HandlingBoolean(StudentRec."OLR Completed"))) + '",' +
            '"portaldb": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Portal DB"))) + '",' +
            '"pancardnumber": "' + EscapeValue(Format(StudentRec."PAN Card Number")) + '",' +
            '"aadharcardnumber": "' + EscapeValue(Format(StudentRec."Aadhar Card Number")) + '",' +
            '"banka_cnumber": "' + EscapeValue(Format(StudentRec."Bank A/C Number")) + '",' +
            '"accountholdername": "' + EscapeValue(Format(StudentRec."Account Holder Name")) + '",' +
            '"ifsccode": "' + EscapeValue(Format(StudentRec."IFSC Code")) + '",' +
            '"branch": "' + EscapeValue(Format(StudentRec.Branch)) + '",' +
            '"bankname": "' + EscapeValue(Format(StudentRec."Bank Name")) + '",' +
            '"fathercontactnumber": "' + EscapeValue(Format(StudentRec."Father Contact Number")) + '",' +
            '"fatheremailid": "' + EscapeValue(Format(StudentRec."Father Email ID")) + '",' +
            '"mothercontactnumber": "' + EscapeValue(Format(StudentRec."Mother Contact Number")) + '",' +
            '"motheremailid": "' + EscapeValue(Format(StudentRec."Mother Email ID")) + '",' +
            '"guardiancontactnumber": "' + EscapeValue(Format(StudentRec."Guardian Contact Number")) + '",' +
            '"guardianemailid": "' + EscapeValue(Format(StudentRec."Guardian Email ID")) + '",' +
            '"sponsorername": "' + EscapeValue(Format(StudentRec."Sponsorer Name")) + '",' +
            '"relation": "' + EscapeValue(Format(StudentRec.Relation)) + '",' +
            '"sponsoreraddressline1": "' + EscapeValue(Format(StudentRec."Sponsorer Address Line 1")) + '",' +
            '"sponsoreraddressline2": "' + EscapeValue(Format(StudentRec."Sponsorer Address Line 2")) + '",' +
            '"sponsoreraddressline3": "' + EscapeValue(Format(StudentRec."Sponsorer Address Line 3")) + '",' +
            '"sponsorercity": "' + EscapeValue(Format(StudentRec."Sponsorer City")) + '",' +
            '"sponsorerstate": "' + EscapeValue(Format(StudentRec."Sponsorer State")) + '",' +
            '"sponsorercountry": "' + EscapeValue(Format(StudentRec."Sponsorer Country")) + '",' +
            '"sponsorerpincode": "' + EscapeValue(Format(StudentRec."Sponsorer Pin Code")) + '",' +
            '"officialcorrespomobileno_": "' + EscapeValue(Format(StudentRec."Official Correspo Mobile No.")) + '",' +
            '"transfadmissionhighersem": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Transf Admission Higher Sem"))) + '",' +
            '"addmissiontowhichsem": "' + EscapeValue(Format(StudentRec."Addmission to which Sem")) + '",' +
            '"numberofcreditsearned": "' + EscapeValue(Format(StudentRec."Number of Credits Earned")) + '",' +
            '"passportissueddate": "' + EscapeValue(Format(StudentRec."Pass Port Issued Date", 0, 9)) + '",' +
            '"visaissueddate": "' + EscapeValue(Format(StudentRec."Visa Issued Date", 0, 9)) + '",' +
            '"rc_rpnumber": "' + EscapeValue(Format(StudentRec."RC/RP Number")) + '",' +
            '"rc_rpissueddate": "' + EscapeValue(Format(StudentRec."RC/RP Issued Date", 0, 9)) + '",' +
            '"rc_rpexpirydate": "' + EscapeValue(Format(StudentRec."RC/RP Expiry Date", 0, 9)) + '",' +
            '"sformid": "' + EscapeValue(Format(StudentRec."S Form ID")) + '",' +
            '"entrancetestrank_": "' + EscapeValue(Format(StudentRec."Entrance Test Rank")) + '",' +
            '"upemailsent": "' + EscapeValue(Format(HandlingBoolean(StudentRec."UP Email Sent"))) + '",' +
            '"tenth": "' + EscapeValue(Format('')) + '",' +
            '"physicmathoptional_": "' + EscapeValue(Format(StudentRec."Physic Math Optional %")) + '"' +
            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent5');
        end;
    end;

    Procedure ModifyStudent6(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
            '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
            '"totalfamilyincome": "' + EscapeValue(Format(StudentRec."Total Family Income")) + '",' +
            '"lateralstudent": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Lateral Student"))) + '",' +
            '"creditstudent": "' + EscapeValue(Format(HandlingOption(StudentRec."Credit Student"))) + '",' +
            '"updatedon": "' + EscapeValue(Format(StudentRec."Updated On", 0, 9)) + '",' +
            '"updatedby": "' + EscapeValue(Format(StudentRec."Updated By")) + '",' +
            '"remark": "' + EscapeValue(Format(StudentRec.Remark)) + '",' +
            '"updated": "' + EscapeValue(Format(HandlingBoolean(StudentRec.Updated))) + '",' +
            '"communicationaddress": "' + EscapeValue(Format(HandlingOption(StudentRec."Communication Address"))) + '",' +
            '"board": "' + EscapeValue(Format('')) + '",' +
            '"collage": "' + EscapeValue(Format('')) + '",' +
            '"exam": "' + EscapeValue(Format('')) + '",' +
            '"yearofpassing": "' + EscapeValue(Format('')) + '",' +
            '"grade": "' + EscapeValue(Format('')) + '",' +
            '"tenthpersentage": "' + EscapeValue(Format('')) + '",' +
            '"physicspersentage": "' + EscapeValue(Format('')) + '",' +
            '"entrancetestpersentage": "' + EscapeValue(Format('')) + '",' +
            '"section_rollno_": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Section & Roll No."))) + '",' +
            '"optionalsubjectname": "' + EscapeValue(Format('')) + '",' +
            '"saveaspermanent": "' + EscapeValue(Format('')) + '",' +
            '"pendingforregistration": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Pending For Registration"))) + '",' +
            '"coursecompletionnoc": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Course Completion NOC"))) + '",' +
            '"changepasswordfirsttime": "' + EscapeValue(Format('')) + '",' +
            '"parentloginemailstatus": "' + EscapeValue(Format('')) + '",' +
            '"scholarshipsource": "' + EscapeValue(Format(StudentRec."Scholarship Source")) + '",' +
            '"clinicalcoordinator": "' + EscapeValue(Format(StudentRec."Clinical Coordinator")) + '",' +
            '"documentspecialist": "' + EscapeValue(Format(StudentRec."Document Specialist")) + '",' +
            '"passportissuedby": "' + EscapeValue(Format(StudentRec."Pass Port Issued By")) + '",' +
            '"visaextensiondate": "' + EscapeValue(Format(StudentRec."Visa Extension Date", 0, 9)) + '",' +
            '"bursarhold": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Bursar Hold"))) + '",' +
            '"checkmanually": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Check Manually"))) + '",' +
            '"currencycode": "' + EscapeValue(Format(StudentRec."Currency Code")) + '",' +
            '"degreecode": "' + EscapeValue(Format(StudentRec."Degree Code")) + '",' +
            '"ethnicity": "' + EscapeValue(Format(StudentRec.Ethnicity)) + '",' +
            '"externalrank": "' + EscapeValue(Format(StudentRec."External Rank")) + '",' +
            '"financialaidhold": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Financial Aid Hold"))) + '",' +
            '"fm1_im1coordinator": "' + EscapeValue(Format(StudentRec."FM1/IM1 Coordinator")) + '",' +
            '"housinghold": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Housing Hold"))) + '",' +
            '"internalrank": "' + EscapeValue(Format(StudentRec."Internal Rank")) + '",' +
            '"maidenname": "' + EscapeValue(Format(StudentRec."Maiden Name")) + '",' +
            '"mobileinsert": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Mobile Insert"))) + '",' +
            '"mobileresult": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Mobile Result"))) + '",' +
            '"mobileupdate": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Mobile Update"))) + '"' +

            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent6');
        end;
    end;

    Procedure ModifyStudent7(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
    begin
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
            '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
            '"parentsincome": "' + EscapeValue(Format(StudentRec."Parents Income")) + '",' +
            '"prequalification_": "' + EscapeValue(Format(StudentRec.Prequalification)) + '",' +
            '"registrarhold": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Registrar Hold"))) + '",' +
            '"salesforceinserted": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Salesforce Inserted"))) + '",' +
            '"title": "' + EscapeValue(Format(HandlingOption(StudentRec.Title))) + '",' +
            '"socialsecurityno_": "' + EscapeValue(Format(StudentRec."Social Security No.")) + '",' +
            '"housinggrouppref_1": "' + EscapeValue(Format('')) + '",' +
            '"houseno_pref_1": "' + EscapeValue(Format('')) + '",' +
            '"roomcategorypref_1": "' + EscapeValue(Format('')) + '",' +
            '"housinggrouppref_2": "' + EscapeValue(Format('')) + '",' +
            '"houseno_pref_2": "' + EscapeValue(Format('')) + '",' +
            '"roomcategorypref_2": "' + EscapeValue(Format('')) + '",' +
            '"housinggrouppref_3": "' + EscapeValue(Format('')) + '",' +
            '"houseno_pref_3": "' + EscapeValue(Format('')) + '",' +
            '"roomcategorypref_3": "' + EscapeValue(Format('')) + '",' +
            '"accountpersontype": "' + EscapeValue(Format(HandlingOption(StudentRec."Account Person Type"))) + '",' +
            '"schoollevel": "' + EscapeValue(Format(StudentRec."School Level")) + '",' +
            '"countrycode_phone": "' + EscapeValue(Format(StudentRec."Country Code (Phone)")) + '",' +
            '"graduategpa": "' + EscapeValue(Format(StudentRec."Graduate GPA")) + '",' +
            '"highschoolgpa": "' + EscapeValue(Format(StudentRec."High School GPA")) + '",' +
            '"nameonpassport": "' + EscapeValue(Format(StudentRec."Name on Passport")) + '",' +
            '"othergpa": "' + EscapeValue(Format(StudentRec."Other GPA")) + '",' +
            '"permanentu_s_resident": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Permanent U.S. Resident"))) + '",' +
            '"personleadsource": "' + EscapeValue(Format(StudentRec."Person Lead Source")) + '",' +
            '"pre_reqgpa": "' + EscapeValue(Format(StudentRec."Pre-Req GPA")) + '",' +
            '"primaryleadsource": "' + EscapeValue(Format(StudentRec."Primary Lead Source")) + '",' +
            '"skype": "' + EscapeValue(Format(StudentRec.Skype)) + '",' +
            '"transfergpa": "' + EscapeValue(Format(StudentRec."Transfer GPA")) + '",' +
            '"digitid_18": "' + EscapeValue(Format(StudentRec."18 Digit ID")) + '",' +
            '"fafsareceived": "' + EscapeValue(Format(HandlingBoolean(StudentRec."FAFSA Received"))) + '",' +
            '"residencyhospital1": "' + EscapeValue(Format(StudentRec."Residency Hospital 2")) + '",' +
            '"residencyhospital2": "' + EscapeValue(Format(StudentRec."Residency Hospital 2")) + '",' +
            '"residencystatus": "' + EscapeValue(Format(StudentRec."Residency Status")) + '",' +
            '"residencycity": "' + EscapeValue(Format(StudentRec."Residency City")) + '",' +
            '"residencyspecialty1": "' + EscapeValue(Format(StudentRec."Residency Specialty 1")) + '",' +
            '"residencyspecialty2": "' + EscapeValue(Format(StudentRec."Residency Specialty 2")) + '",' +
            '"residencystate": "' + EscapeValue(Format(StudentRec."Residency State")) + '",' +
            '"residencyyear": "' + EscapeValue(Format(StudentRec."Residency Year")) + '"' +
            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent7');
        end;
    end;

    Procedure ModifyStudent8(StudentRec: Record "Student Master-CS")
    var
        CompInfo: Record "Company InFormation";
        StudStatus: Record "Student Status";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        BodyText: Text;
        Responsetext: Text;
        isInsurancefield: Boolean;
    begin
        isInsurancefield := not StudentRec."Apply For Insurance";
        if StudentRec."Enrollment No." <> '' then begin
            CompInfo.Reset();
            CompInfo.Get();
            if StudStatus.Get(StudentRec.Status, StudentRec."Global Dimension 1 Code") then;
            http_request.Method('POST');
            // api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
            CompInfo.Testfield("Portal Student Update Api URL");
            api_url := StrSubstNo(CompInfo."Portal Student Update Api URL");
            http_request.SetRequestUri(api_url);
            http_content.GetHeaders(http_Headers);
            BodyText := '{' +
            '"StudentID": "' + EscapeValue(Format(StudentRec."No.")) + '",' +
            '"roommatenamepref": "' + EscapeValue(Format('')) + '",' +
            '"roommateemailpref": "' + EscapeValue(Format('')) + '",' +
            '"status": "' + EscapeValue(Format(StudentRec.Status)) + '",' +
            '"fafsa_id": "' + EscapeValue(Format('')) + '",' +
            '"financial_aid_status": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Financial Aid Approved"))) + '",' +
            '"authorized_for_living_expense": "' + EscapeValue(Format('')) + '",' +
            '"graduation_plus": "' + EscapeValue(Format('')) + '",' +
            '"unsubsidized_loan": "' + EscapeValue(Format('')) + '",' +
            '"isinsurance": "' + EscapeValue(Format(HandlingBoolean(isInsurancefield))) + '",' +
            '"ReturningStudent": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Returning Student"))) + '",' +
            '"insurancepolicyno": "' + EscapeValue(Format(StudentRec."Policy Number / Group Number")) + '",' +
            '"insuranceprovidername": "' + EscapeValue(Format(StudentRec."Insurance Carrier")) + '",' +
            '"insurancevalidfrom": "' + EscapeValue(Format(StudentRec."Insurance Valid From", 0, 9)) + '",' +
            '"insurancevalidto": "' + EscapeValue(Format(StudentRec."Insurance Valid To", 0, 9)) + '",' +
            '"insurancesignoff_approvaldate": "' + EscapeValue(Format('01 Jan 1957')) + '",' +
            '"insurancetype": "' + EscapeValue(Format('')) + '",' +
            '"newsemestertype": "' + EscapeValue(Format(StudentRec."New Term")) + '",' +
            '"newacademicyear": "' + EscapeValue(Format(StudentRec."New Academic Year")) + '",' +
            '"scholarshipcode2": "' + EscapeValue(Format(StudentRec."Grant Code 1")) + '",' +
            '"otherleadsource": "' + EscapeValue(Format(StudentRec."Other Lead Source")) + '",' +
            '"leaseagreement_contractno_": "' + EscapeValue(Format(StudentRec."Lease Agreement/Contract No.")) + '",' +
            '"leaseagreementgroup": "' + EscapeValue(Format(StudentRec."Lease Agreement Group")) + '",' +
            '"transportcell": "' + EscapeValue(Format(StudentRec."Transport Cell")) + '",' +
            '"insurancecompanyname": "' + EscapeValue(Format(StudentRec."Insurance Carrier")) + '",' +
            '"policyno_": "' + EscapeValue(Format(StudentRec."Policy Number / Group Number")) + '",' +
            '"dateofcomencement": "' + EscapeValue(Format(StudentRec."Insurance Valid From", 0, 9)) + '",' +
            '"expirydate": "' + EscapeValue(Format(StudentRec."Insurance Valid To", 0, 9)) + '",' +
            '"parentstudentno_": "' + EscapeValue(Format(StudentRec."Parent Student No.")) + '",' +
            '"registrarsignoff": "' + EscapeValue(Format(HandlingBoolean(StudentRec."Registrar Signoff"))) + '",' +
            '"feepaymentmethod": "' + EscapeValue(Format('')) + '",' +
            '"paymentplaninstalment": "' + EscapeValue(Format(StudentRec."Payment Plan Instalment")) + '",' +
            '"OnGroundCheckInBy" : "' + EscapeValue(Format(StudentRec."On Ground Check-In By")) + '",' +
            '"OnGroundCheckInCompleteBy" : "' + EscapeValue(Format(StudentRec."On Ground Check-In Complete By")) + '",' +
            '"OnGroundCheckInCompleteOn" : "' + EscapeValue(Format(StudentRec."On Ground Check-In Complete On", 0, 9)) + '",' +
            '"OnGroundCheckInOn" : "' + EscapeValue(Format(StudentRec."On Ground Check-In On", 0, 9)) + '",' +
            '"StudentGroup" : "' + EscapeValue(Format(HandlingOption(StudentRec."Student Group"))) + '",' +
            '"Email" : "' + EscapeValue(Format((StudentRec."E-Mail Address"))) + '",' +//CSPL-00307 Added new Line 09-12-21
            '"FASAPStatus" : "' + EscapeValue(Format(HandlingOption(StudentRec."FA SAP Status"))) + '",' +//CSPL-00307 Added new Line 20-12-21
            //CSPL-00307- 04-01-2022---Start
            '"StatusManuallyChangedby" : "' + EscapeValue(Format(StudentRec."Status Manually Changed by")) + '",' +
            '"StatusManuallyChangedon" : "' + EscapeValue(Format(StudentRec."Status Manually Changed on", 0, 9)) + '",' +
            '"ApplicationType" : "' + EscapeValue(Format(StudentRec."Application Type")) + '",' +
            '"EntryFromSalesforce" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."Entry From Salesforce"))) + '",' +
            '"LocalEmergencyEmailAddress" : "' + EscapeValue(Format(StudentRec."Local Emergency Email Address")) + '",' +
            '"LeadDate" : "' + EscapeValue(Format(StudentRec."Lead Date", 0, 9)) + '",' +
            '"LeadTypeCode" : "' + EscapeValue(Format(StudentRec."Lead Type Code")) + '",' +
            '"Block" : "' + EscapeValue(Format(HandlingBoolean(StudentRec.Block))) + '",' +
            '"Vet" : "' + EscapeValue(Format(StudentRec.Vet)) + '",' +
            '"OriginalStartDate" : "' + EscapeValue(Format(StudentRec."Original Start Date", 0, 9)) + '",' +
            '"OriginalExpStartDate" : "' + EscapeValue(Format(StudentRec."Original Exp. Start Date", 0, 9)) + '",' +
            '"RawLastName" : "' + EscapeValue(Format(StudentRec."Raw Last Name")) + '",' +
            '"RawFirstName" : "' + EscapeValue(Format(StudentRec."Raw First Name")) + '",' +
            '"PhoneExtension" : "' + EscapeValue(Format(StudentRec."Phone Extension")) + '",' +
            '"ApplicationReceivedDate" : "' + EscapeValue(Format(StudentRec."Application Received Date", 0, 9)) + '",' +
            '"ReEntryDate" : "' + EscapeValue(Format(StudentRec."Re-Entry Date", 0, 9)) + '",' +
            '"MidDate" : "' + EscapeValue(Format(StudentRec."Mid Date", 0, 9)) + '",' +
            '"LDA" : "' + EscapeValue(Format(StudentRec.LDA, 0, 9)) + '",' +
            '"StatusDate" : "' + EscapeValue(Format(StudentRec."Status Date", 0, 9)) + '",' +
            '"GradeLevelDescription" : "' + EscapeValue(Format(StudentRec."Grade Level Description")) + '",' +
            '"CreditsAttempt" : "' + EscapeValue(Format(StudentRec."Credits Attempt")) + '",' +
            '"ProgramVersionID" : "' + EscapeValue(Format(StudentRec."Program Version ID")) + '",' +
            '"TransferInDate" : "' + EscapeValue(Format(StudentRec."Transfer In Date", 0, 9)) + '",' +
            '"SAP" : "' + EscapeValue(Format(StudentRec.SAP)) + '",' +
            '"BillingMethodID" : "' + EscapeValue(Format(StudentRec."Billing Method ID")) + '",' +
            '"GPACredits" : "' + EscapeValue(Format(StudentRec."GPA Credits")) + '",' +
            '"DatePlaced" : "' + EscapeValue(Format(StudentRec."Date Placed", 0, 9)) + '",' +
            '"NSLDSWithdrawalDate" : "' + EscapeValue(Format(StudentRec."NSLDS Withdrawal Date", 0, 9)) + '",' +
            '"SuffixCode" : "' + EscapeValue(Format(StudentRec."Suffix Code")) + '",' +
            '"AddressType" : "' + EscapeValue(Format(StudentRec."Address Type")) + '",' +
            '"ExternalSISID" : "' + EscapeValue(Format(StudentRec."External SIS ID")) + '",' +
            '"FeeGenerated" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."Fee Generated"))) + '",' +
            '"DateOfDetermination" : "' + EscapeValue(Format(StudentRec."Date Of Determination", 0, 9)) + '",' +
            '"LastDateOfAttendance" : "' + EscapeValue(Format(StudentRec."Last Date Of Attendance", 0, 9)) + '",' +
            '"CurrentSemesterStartDate" : "' + EscapeValue(Format(StudentRec."Current Semester Start Date", 0, 9)) + '",' +
            '"CurrentSemesterEndDate" : "' + EscapeValue(Format(StudentRec."Current Semester End Date", 0, 9)) + '",' +
            '"BSICOptOut" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."BSIC Opt Out"))) + '",' +
            '"OLREmailSent" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."OLR Email Sent"))) + '",' +
            '"OriginalStudentNo_" : "' + EscapeValue(Format(StudentRec."Original Student No.")) + '",' +
            '"StudentSFPInitiation" : "' + EscapeValue(Format(StudentRec."Student SFP Initiation")) + '",' +
            '"StudentSFPUpdate" : "' + EscapeValue(Format(StudentRec."Student SFP Update")) + '",' +
            '"SAFISync" : "' + EscapeValue(Format(HandlingOption(StudentRec."SAFI Sync"))) + '",' +
            '"SFPLOA" : "' + EscapeValue(Format(HandlingOption(StudentRec."SFP-LOA"))) + '",' +
            '"SelfPayApplied" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."Self-Pay Applied"))) + '",' +
            '"VABenefit" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."VA Benefit"))) + '",' +
            '"MOUAgreement" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."MOU Agreement"))) + '",' +
            '"EnrolmentOrder" : "' + EscapeValue(Format(StudentRec."Enrollment Order")) + '",' +
            '"AssistantRegistrar" : "' + EscapeValue(Format(StudentRec."Assistant Registrar")) + '",' +
            //CSPL-00307- 04-01-2022--End
            '"TeachingAssistant" : "' + EscapeValue(Format(HandlingBoolean(StudentRec."Teaching Assistant"))) + '",' +
            //CSPL-00307- 04-01-2022--End
            //Varity Integration Related Changes
            '"DMSInsert" : "' + EscapeValue(Format(HandlingOption(StudentRec."DMS Insert"))) + '",' +
            '"DMSUpdate" : "' + EscapeValue(Format(HandlingOption(StudentRec."DMS Update"))) + '",' +
            '"AdmissionAdvisor" : "' + EscapeValue(Format(StudentRec."Admission Advisor")) + '",' +
            '"RegistrarAdvisor" : "' + EscapeValue(Format(StudentRec."Registrar Advisor")) + '",' +
            //Varity Integration Related Changes 
            '"CitizenAntiguaBarbuda" : "' + EscapeValue(Format(HandlingBoolean(StudentRec.CitizenAntiguaBarbuda))) + '",' + //FALL 2023 OLR Changes
            '"term": "' + EscapeValue(Format(HandlingOption(StudentRec.Term))) + '"' +
            '}';
            http_content.WriteFrom(BodyText);
            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            if Not http_Response.IsSuccessStatusCode() then
                SaveApiLogDetails(StudentRec.TableName(), ResponseText, 'ModifyStudent8');
        end;
    end;



    procedure EscapeValue(Value: Text) NewValue: Text;
    var
        Char: Char;
        Pos: Integer;
    begin
        if Value = '' THEN EXIT('');
        for Pos := 1 to StrLen(Value) do begin
            Char := Value[Pos];
            case Char of
                8: // Backspace
                    NewValue += '\b';
                10: // New line
                    NewValue += '\n';
                12: // Form feed
                    NewValue += '\f';
                13: // Carriage return
                    NewValue += '\r';
                9: // Tab
                    NewValue += '\t';
                34: // Double Quote
                    NewValue += '\"';
                92: // Backslash character
                    NewValue += '\\';
                else
                    NewValue += CopyStr(Value, Pos, 1);
            end;
        end;
    end;


    procedure SaveApiLogDetails(TableName: Text; APIResponse: Text; Remarks: Text)
    var
        PortalApiLog: Record "Portal APIs Error Log";
    begin
        IF Not (Strpos(APIResponse, 'ok</string>') > 0) then begin
            PortalApiLog.Init();
            PortalApiLog."Table Name" := TableName;
            PortalApiLog."API Responses" := CopyStr(APIResponse, 1, 2048);
            PortalApiLog.Remarks := Remarks;
            PortalApiLog."Modified On" := CurrentDateTime();
            PortalApiLog."Modified By" := UserId();
            PortalApiLog.Insert();
        end;
    end;

    Procedure FindStringValue(var RecStudentMaster: Record "Student Master-CS"; ResponsesString: Text[2048])
    var
        RecStudentMasterCs1: Record "Student Master-CS";
        StringFind1: Text[2048];
        StringFind2: Text[2048];
        StringFind3: Text[2048];
        UserIDString: Text[200];
        UserIDStringFinal: Code[50];
        EmailIDString: Text[200];
        EmailIDStringFinal: Text[80];
        PasswordString: Text[200];
        PasswordStringFinal: Code[30];
    begin
        StringFind1 := CopyStr(ResponsesString, 77, StrLen(ResponsesString));
        StringFind2 := Token(StringFind1, '<');
        StringFind3 := DelChr(StringFind2, '=', ' ');

        //Find User ID
        UserIDString := Token(StringFind3, ',');
        UserIDStringFinal := DelStr(UserIDString, 1, 7);
        //FIND Email ID
        EmailIDString := SelectStr(1, StringFind3);
        EmailIDStringFinal := DelStr(EmailIDString, 1, 8);
        //Find Password ID
        PasswordString := SelectStr(2, StringFind3);
        PasswordStringFinal := DelStr(PasswordString, 1, 9);

        PortalUserLoginInsert(RecStudentMaster, UserIDStringFinal, EmailIDStringFinal, PasswordStringFinal);
    end;

    procedure PortalUserLoginInsert(var StudentMaster: Record "Student Master-CS"; StudentUserID: Code[50]; StudentEmailID: Text[80]; StudentPassword: Code[30])
    var
        PortalUserLoginCS: Record "Portal User Login-CS";
        PortalUserLoginCS1: Record "Portal User Login-CS";
        EntryNo: Integer;
    begin
        PortalUserLoginCS.Reset();
        IF PortalUserLoginCS.FINDLAST() THEN
            EntryNo := PortalUserLoginCS.No + 1
        ELSE
            EntryNo := 1;

        PortalUserLoginCS.Reset();
        PortalUserLoginCS.SETRANGE(U_ID, StudentMaster."No.");
        IF PortalUserLoginCS.FINDSET() THEN begin
            PortalUserLoginCS."Login ID" := StudentUserID;
            PortalUserLoginCS.Password := StudentPassword;
            PortalUserLoginCS.Email := StudentEmailID;
            PortalUserLoginCS.Modify();
        end
        else begin
            PortalUserLoginCS1.INIT();
            PortalUserLoginCS1.No := EntryNo;
            PortalUserLoginCS1.Type := PortalUserLoginCS1.Type::Student;
            PortalUserLoginCS1.U_ID := StudentMaster."No.";
            PortalUserLoginCS1."Login ID" := StudentUserID;
            PortalUserLoginCS1.Password := StudentPassword;
            PortalUserLoginCS1."User Group" := 'STUDENT';
            PortalUserLoginCS1."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
            PortalUserLoginCS1."Global Dimension 2 Code" := StudentMaster."Global Dimension 2 Code";
            PortalUserLoginCS1.Role_Code := 'ROLE00004';
            PortalUserLoginCS1.WindowsAuthentication := FALSE;
            PortalUserLoginCS1.IsAdmin := FALSE;
            PortalUserLoginCS1.UserName := copystr(StudentMaster."Student Name", 1, 50);
            PortalUserLoginCS1.MobileNo := StudentMaster."Mobile Number";
            PortalUserLoginCS1.Email := StudentEmailID;
            PortalUserLoginCS1."Created By" := FORMAT(UserId());
            PortalUserLoginCS1."Created On" := TODAY();
            PortalUserLoginCS1.INSERT();
        end;
        StudentMaster."E-Mail Address" := StudentEmailID;
        StudentMaster.Password := StudentPassword;
    end;

    procedure Token(VAR Text: Text[1024]; Separator: Text[1]) Token: Text[1024]
    Var
        Pos: Integer;
    begin
        Pos := STRPOS(Text, Separator);
        IF Pos > 0 THEN BEGIN
            Token := COPYSTR(Text, 1, Pos - 1);
            IF Pos + 1 <= STRLEN(Text) THEN
                Text := COPYSTR(Text, Pos + 1)
            ELSE
                Text := '';
        END ELSE BEGIN
            Token := Text;
            Text := '';
        END;

    end;

    procedure HandlingOption(Var OptionName: Option "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"): Integer
    begin
        Exit(OptionName);
    end;

    procedure HandlingBoolean(Var BooleanName: Boolean): Integer
    begin
        IF BooleanName = TRUE then
            Exit(1)
        else
            Exit(0);
    end;



    //END::Portal API Creation

    //START::Send Notification Creation
    procedure ApiPortalinsertupdatesendNotification(DocumentType: text[50]; SenderName: text[50]; SenderId: text[50];
    ReceiverName: text; ReceiverId: text; Subject: text[200]; Documenttext: text; Process: text[100];
    DocumentEvent: text[100]; ProcessNo: text[30]; EDate: text[30]; ReceiverEmailId: text;
    sendEmail: Integer; mobileNo: text[30]; SmsText: text[30]; SendSms: Integer)
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.Get();
        // If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
        RecCompanyInformation.TestField("Portal Api URL");
        URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/sendNotification?Type=%1&SenderName=%2&SenderId=%3&ReceiverName=%4&ReceiverId=%5&Subject=%6&text=%7&Process=%8&Event=%9&ProcessNo=%10&EDate=%11&ReceiverEmailId=%12&sendEmail=%13&mobileNo=%14&SmsText=%15&SendSms=%16',
        DocumentType, SenderName, SenderId, ReceiverName, ReceiverId, Subject, Documenttext, Process, DocumentEvent, ProcessNo, EDate, ReceiverEmailId, sendEmail, mobileNo, SmsText, SendSms);
        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //end;

        IF DocumentType <> 'CLINICAL' then
            EmailNotification(DocumentType, SenderName, SenderId, ReceiverName
            , ReceiverId, Subject, Documenttext, Process, DocumentEvent, ProcessNo, EDate, ReceiverEmailId, sendEmail,
            1, format(CurrentDateTime()), 1, mobileNo, SmsText, SendSms, 0, Format(CurrentDateTime), UserId(), '', '');
    end;
    //END::Send Notification Creation






    //////////////////























    // [EventSubscriber(ObjectType::Table, 50323, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalSave_Update_EnquiryModify(VAR Rec: Record "Enquiry-CS"; VAR xRec: Record "Enquiry-CS"; RunTrigger: Boolean)

    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;

    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Enquiry?Name=%1&Gender=%2&TypeOfEnquiry=%3&EnquirySource=%4&EnquirerName=%5&RelationshipwithApplicant=%6&MediaVehicle=%7&DateofBirth=%8&FathersName=%9&MothersName=%10&Citizenship=%11&AcademicYear=%12&EnquiryDate=%13&ClassApplied=%14&HostelAccomodation=%15&NameOfThePreviousInstitute=%16&MediumOfInstruction=%17&CurriculumIntrested=%18&ClassLastAttended=%19&CurriculumFollowed=%20&AddressTo=%21&Addressee=%22&Address1=%23&Address2=%24&City=%25&PostCode=%26&CountryCode=%27&EMailAddress=%28&MobileNumber=%29&PhoneNumber=%30&State=%31&NoSeries=%32&Age=%33&Months=%34&Campaign=%35&Address3=%36&EnquiryClosed=%37&UserID=%38&PortalID=%39&ApplicationID=%40&ApplicationSubtype=%41&ApplicationType=%42&ClinicalSemester=%43&CountryofCitizenship=%44&DepositPaidDate=%45&DepositWaived=%46&DepositWaiverStatus=%47&ExpectedStartDate=%48&FAFSAApplied=%49&GraduateGPA=%50&GraduationDate=%51&HighSchoolGPA=%52&HousingDepositPaid=%53&HousingWaiver=%54&LeadSource=%55&OriginalAnticipatedTerm=%56&PreReqGPA=%57&HousingDepositDate=%58&ProgramStart=%59&Program=%60&ScholarshipAmountAwarded=%61&ScholarshipAwarded=%62&ScholarshipType=%63&Scholarship=%64&SeatDepositPaid=%65&SpecialProgramStartDate=%66&SpecialProgram=%67&StudentAcceptedDate=%68&SubStage=%69&TransferGPA=%70&TransportRequired=%71&UndergraduateGPA=%72&EighteenDigitID=%73&EighteenDigitSchoolStudentID=%74&GlobalDimension1Code=%75&GlobalDimension2Code=%76', Rec.Name, HandlingOption(Rec.Gender), Rec."Type Of Enquiry", Rec."Enquiry Source", Rec."Enquirer Name", Rec."Relationship with Applicant", Rec."Media Vehicle", Rec."Date of Birth", Rec."Father's Name", Rec."Mother's Name", Rec.Citizenship, Rec."Academic Year", FORMAT(Rec."Enquiry Date", 0, 9), Rec."Class Applied", HandlingBoolean(Rec."Hostel Accomodation"), Rec."Name Of The Previous Institute", Rec."Medium Of Instruction", Rec."Curriculum Intrested", Rec."Class Last Attended", Rec."Curriculum Followed", Rec."Address To", Rec.Addressee, Rec."Address 1", Rec."Address 2", Rec.City, Rec."Post Code", Rec."Country Code", Rec."E-Mail Address", Rec."Mobile Number", Rec."Phone Number", Rec.State, Rec."No Series", Rec.Age, Rec.Months, Rec.Campaign, Rec."Address 3", HandlingBoolean(Rec."Enquiry Closed"), Rec."User ID", Rec."Portal ID", Rec."Application ID", Rec."Application Sub-type", Rec."Application Type", Rec."Clinical Semester", Rec."Country of Citizenship", FORMAT(Rec."Deposit Paid Date"), HandlingBoolean(Rec."Deposit Waived"), Rec."Deposit Waiver Status", FORMAT(Rec."Expected Start Date", 0, 9), HandlingBoolean(Rec."FAFSA Applied"), FORMAT(Rec."Graduate GPA", 0, 1), FORMAT(Rec."Graduation Date", 0, 9), FORMAT(Rec."High School GPA", 0, 1), HandlingBoolean(Rec."Housing Deposit Paid"), HandlingOption(Rec."Housing Waiver"), Rec."Lead Source", Rec."Original Anticipated Term", FORMAT(Rec."Pre-Req GPA", 0, 1), FORMAT(Rec."Housing Deposit Date", 0, 9), Rec."Program Start", Rec.Program, FORMAT(Rec."Scholarship Amount Awarded", 0, 1), HandlingBoolean(Rec."Scholarship Awarded"), Rec."Scholarship Type", HandlingBoolean(Rec.Scholarship), HandlingBoolean(Rec."Seat Deposit Paid"), FORMAT(Rec."Special Program Start Date", 0, 9), Rec."Special Program", FORMAT(Rec."Student Accepted Date", 0, 9), Rec."Sub-Stage", FORMAT(Rec."Transfer GPA", 0, 1), HandlingBoolean(Rec."Transport Required"), FORMAT(Rec."Undergraduate GPA", 0, 1), Rec."18 Digit ID", Rec."18 digit School/Student ID", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code");
    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);
    //         SaveApiLogDetails(Rec.TableName(), ResponseText, '');
    //     end;
    // end;














    procedure StudentEmailCreation(var Rec: Record "Student Master-CS"; Int: Integer)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Student_EmailCreation?no_=%1', Rec."No.");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            ResponseText := CopyStr(ResponseText, 1, 2048);
            IF StrPos(ResponseText, 'UserID') > 0 then begin
                FindStringValue(Rec, ResponseText); //Split String & Portal User ID Creation
                IF Int = 1 then
                    Rec.Modify();
            end
            Else
                SaveApiLogDetails(Rec.TableName(), ResponseText, 'Student Email Creation API');
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50353, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FERPADetailsOnModify(VAR Rec: Record "FERPA Details"; VAR xRec: Record "FERPA Details"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_FERPADetails?InfoHeaderNo=%1&FerpaDetailLineNo=%2&StudentNo_=%3&EnrolmentNo_=%4&StudentName=%5&AcademicYear=%6&Semester=%7&FirstName=%8&LastName=%9&EMailAddress=%10&PhoneNumber=%11&Relationship=%12&AsofDate=%13&Term=%14&CreatedBy=%15&CreatedOn=%16&ModifiedBy=%17&ModifiedOn=%18&RelationshipName=%19&Addr1=%20&City=%21&State=%22&CountryCode=%23&StartDate=%24&EndDate=%25', Rec."Info Header No", Rec."Ferpa Detail Line No", Rec."Student No.", Rec."Enrolment No.", Rec."Student Name", Rec."Academic Year", Rec.Semester, Rec."First Name", Rec."Last Name", Rec."E-Mail Address", Rec."Phone Number", Rec.Relationship, Format(Rec."As of Date", 0, 9), HandlingOption(Rec.Term), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On"), Rec."Relationship Name", Rec.Addr1, Rec.City, Rec.State, Rec."Country Code", Format(Rec."Start Date", 0, 9), format(Rec."End Date", 0, 9));
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterModifyEvent');
        End;
    end;

    [EventSubscriber(ObjectType::Table, 50353, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FERPADetailsOnInsert(VAR Rec: Record "FERPA Details"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_FERPADetails?InfoHeaderNo=%1&FerpaDetailLineNo=%2&StudentNo_=%3&EnrolmentNo_=%4&StudentName=%5&AcademicYear=%6&Semester=%7&FirstName=%8&LastName=%9&EMailAddress=%10&PhoneNumber=%11&Relationship=%12&AsofDate=%13&Term=%14&CreatedBy=%15&CreatedOn=%16&ModifiedBy=%17&ModifiedOn=%18&RelationshipName=%19&Addr1=%20&City=%21&State=%22&CountryCode=%23&StartDate=%24&EndDate=%25', Rec."Info Header No", Rec."Ferpa Detail Line No", Rec."Student No.", Rec."Enrolment No.", Rec."Student Name", Rec."Academic Year", Rec.Semester, Rec."First Name", Rec."Last Name", Rec."E-Mail Address", Rec."Phone Number", Rec.Relationship, Format(Rec."As of Date", 0, 9), HandlingOption(Rec.Term), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On"), Rec."Relationship Name", Rec.Addr1, Rec.City, Rec.State, Rec."Country Code", Format(Rec."Start Date", 0, 9), format(Rec."End Date", 0, 9));
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterInsertEvent');
        End;
    end;

    [EventSubscriber(ObjectType::Table, 50353, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalDelete_API_FERPADetailsModify(VAR Rec: Record "FERPA Details"; RunTrigger: Boolean)

    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Delete_API_FERPADetails?InfoHeaderNo=%1&FerpaDetailLineNo=%2', Rec."Info Header No", Rec."Ferpa Detail Line No");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterDeleteEvent');
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50453, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_FERPA_Information_HeaderModify(VAR Rec: Record "FERPA Information Header"; VAR xRec: Record "FERPA Information Header"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FERPA_Information_Header?InfoHeaderNo=%1&StudentNo=%2&AcademicYear=%3&Semester=%4&Term=%5&ShareStartDate=%6&ShareEndDate=%7&CreationDate=%8&CreatedBy=%9&UserID=%10&UpdatedOn=%11&UpdatedBy=%12&Reason=%13', Rec."Info Header No", Rec."Student No", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), FORMAT(Rec."Share Start Date", 0, 9), FORMAT(Rec."Share End Date", 0, 9), FORMAT(Rec."Creation Date", 0, 9), Rec."Created By", Rec."User ID", FORMAT(Rec."Updated On", 0, 9), Rec."Updated By", Rec.Reason);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterModifyEvent');
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50453, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_FERPA_Information_HeaderOnInsert(VAR Rec: Record "FERPA Information Header"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FERPA_Information_Header?InfoHeaderNo=%1&StudentNo=%2&AcademicYear=%3&Semester=%4&Term=%5&ShareStartDate=%6&ShareEndDate=%7&CreationDate=%8&CreatedBy=%9&UserID=%10&UpdatedOn=%11&UpdatedBy=%12&Reason=%13', Rec."Info Header No", Rec."Student No", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), FORMAT(Rec."Share Start Date", 0, 9), FORMAT(Rec."Share End Date", 0, 9), FORMAT(Rec."Creation Date", 0, 9), Rec."Created By", Rec."User ID", FORMAT(Rec."Updated On", 0, 9), Rec."Updated By", Rec.Reason);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterInsertEvent');
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50453, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalDelete_API_FERPA_Information_HeaderDelete(VAR Rec: Record "FERPA Information Header"; RunTrigger: Boolean)
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Delete_API_FERPA_Information_Header?InfoHeaderNo=%1', Rec."Info Header No");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterDeleteEvent');
        end;
    end;

    //"FERPA Module Allowed"-Start--------------------------------------------------------------------
    [EventSubscriber(ObjectType::Table, 50404, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_FERPA_Module_AllowedModify(VAR Rec: Record "FERPA Module Allowed"; VAR xRec: Record "FERPA Module Allowed"; RunTrigger: Boolean)

    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FERPA_Module_Allowed?InfoHeaderNo=%1&ModuleCode=%2&FerpaDetailLineNo=%3&StudentNo_=%4&EnrolmentNo_=%5&StudentName=%6&AcademicYear=%7&Semester=%8&ModuleName=%9&Term=%10&CreatedBy=%11&CreatedOn=%12&ModifiedBy=%13&ModifiedOn=%14', Rec."Info Header No", Rec."Module Code", Rec."Ferpa Detail Line No", Rec."Student No.", Rec."Enrolment No.", Rec."Student Name", Rec."Academic Year", Rec.Semester, HandlingOption(Rec."Module Name"), HandlingOption(Rec.Term), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9));
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterModifyEvent');
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50404, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_FERPA_Module_AllowedOnInsert(VAR Rec: Record "FERPA Module Allowed"; RunTrigger: Boolean)

    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FERPA_Module_Allowed?InfoHeaderNo=%1&ModuleCode=%2&FerpaDetailLineNo=%3&StudentNo_=%4&EnrolmentNo_=%5&StudentName=%6&AcademicYear=%7&Semester=%8&ModuleName=%9&Term=%10&CreatedBy=%11&CreatedOn=%12&ModifiedBy=%13&ModifiedOn=%14', Rec."Info Header No", Rec."Module Code", Rec."Ferpa Detail Line No", Rec."Student No.", Rec."Enrolment No.", Rec."Student Name", Rec."Academic Year", Rec.Semester, HandlingOption(Rec."Module Name"), HandlingOption(Rec.Term), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9));
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterInsertEvent');
        end;
    end;


    [EventSubscriber(ObjectType::Table, 50404, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalDelete_API_FERPA_Module_AllowedModify(VAR Rec: Record "FERPA Module Allowed"; RunTrigger: Boolean)

    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Delete_API_FERPA_Module_Allowed?InfoHeaderNo=%1&ModuleCode=%2&FerpaDetailLineNo=%3', Rec."Info Header No", Rec."Module Code", Rec."Ferpa Detail Line No");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OnAfterDeleteEvent');
        end;
    end;

    //"FERPA Module Allowed"-End-----------------------------------------------------------------------

    //"Ferpa Module"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50451, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_ModuleInsert(VAR Rec: Record "Ferpa Module"; RunTrigger: Boolean)
    begin
        FerpaModuleFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50451, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_ModuleModify(VAR Rec: Record "Ferpa Module"; VAR xRec: Record "Ferpa Module"; RunTrigger: Boolean)
    begin
        FerpaModuleFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50451, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_ModuleRename(VAR Rec: Record "Ferpa Module"; VAR xRec: Record "Ferpa Module"; RunTrigger: Boolean)
    begin
        FerpaModuleFunction(Rec, xRec."Module Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50451, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_ModuleDelete(VAR Rec: Record "Ferpa Module"; RunTrigger: Boolean)
    begin
        FerpaModuleFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FerpaModuleFunction(var Rec: Record "Ferpa Module"; xRecModuleCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Ferpa_Module?ModuleCode=%1&ModuleName=%2&Blocked=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&CreationDate=%6&CreatedBy=%7&UserID=%8&UpdatedOn=%9&UpdatedBy=%10&OldModuleCode=%11&Delete=%12', Rec."Module Code", Rec."Module Name", HandlingBoolean(Rec.Blocked), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", FORMAT(Rec."Creation Date", 0, 9), Rec."Created By", Rec."User ID", FORMAT(Rec."Updated On"), Rec."Updated By", xRecModuleCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Ferpa Module"-End-------------------------------------------------------------------------------------------------

    //"Ferpa Relationship"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50452, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_RelationshipInsert(VAR Rec: Record "Ferpa Relationship"; RunTrigger: Boolean)
    begin
        FerpaRelationshipFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50452, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_RelationshipModify(VAR Rec: Record "Ferpa Relationship"; VAR xRec: Record "Ferpa Relationship"; RunTrigger: Boolean)
    begin
        FerpaRelationshipFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50452, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_RelationshipRename(VAR Rec: Record "Ferpa Relationship"; VAR xRec: Record "Ferpa Relationship"; RunTrigger: Boolean)
    begin
        FerpaRelationshipFunction(Rec, xRec."Relationship Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50452, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Ferpa_RelationshipDelete(VAR Rec: Record "Ferpa Relationship"; RunTrigger: Boolean)
    begin
        FerpaRelationshipFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FerpaRelationshipFunction(var Rec: Record "Ferpa Relationship"; xRecRelationshipCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Ferpa_Relationship?RelationshipCode=%1&RelationshipName=%2&Blocked=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&CreationDate=%6&CreatedBy=%7&UserID=%8&UpdatedOn=%9&UpdatedBy=%10&OldRelationshipCode=%11&Delete=%12', Rec."Relationship Code", Rec."Relationship Name", HandlingBoolean(Rec.Blocked), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", FORMAT(Rec."Creation Date", 0, 9), Rec."Created By", Rec."User ID", FORMAT(Rec."Updated On", 0, 9), Rec."Updated By", xRecRelationshipCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //"Ferpa Relationship"-End-------------------------------------------------------------------------------------------------

    //"Faculty Category"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50440, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCategoryInsert(VAR Rec: Record "Faculty Category"; RunTrigger: Boolean)
    begin
        FacultyCategoryFunction(Rec, '', 0, 'OnAfterInserEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50440, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCategoryModify(VAR Rec: Record "Faculty Category"; VAR xRec: Record "Faculty Category"; RunTrigger: Boolean)
    begin
        FacultyCategoryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50440, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCategoryRename(VAR Rec: Record "Faculty Category"; VAR xRec: Record "Faculty Category"; RunTrigger: Boolean)
    begin
        FacultyCategoryFunction(Rec, xRec."Category Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50440, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCategoryDelete(VAR Rec: Record "Faculty Category"; RunTrigger: Boolean)
    begin
        FacultyCategoryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FacultyCategoryFunction(var Rec: Record "Faculty Category"; xRecCategoryCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FacultyCategory?CategoryCode=%1&CategoryDescription=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&OldCategoryCode=%5&Delete=%6', Rec."Category Code", Rec."Category Description", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", xRecCategoryCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //"Faculty Category"-End-------------------------------------------------------------------------------------------------

    //"Subject Faculty Category"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50441, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_SubjectFacultyCategoryInsert(VAR Rec: Record "Subject Faculty Category"; RunTrigger: Boolean)
    begin
        SubjectFacultyCategoryFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50441, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_SubjectFacultyCategoryModify(VAR Rec: Record "Subject Faculty Category"; VAR xRec: Record "Subject Faculty Category"; RunTrigger: Boolean)
    begin
        SubjectFacultyCategoryFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50441, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_SubjectFacultyCategoryRename(VAR Rec: Record "Subject Faculty Category"; VAR xRec: Record "Subject Faculty Category"; RunTrigger: Boolean)
    begin
        SubjectFacultyCategoryFunction(Rec, xRec."Subject Code", xRec."Category Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50441, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_SubjectFacultyCategoryDelete(VAR Rec: Record "Subject Faculty Category"; RunTrigger: Boolean)
    begin
        SubjectFacultyCategoryFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SubjectFacultyCategoryFunction(var Rec: Record "Subject Faculty Category"; xRecSubjectCode: Code[20]; xRecCategoryCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_SubjectFacultyCategory?SubjectCode=%1&CategoryCode=%2&SubjectDescription=%3&CategoryDescription=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&OldSubjectCode=%7&OldCategoryCode=%8&Delete=%9', Rec."Subject Code", Rec."Category Code", Rec."Subject Description", Rec."Category Description", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", xRecSubjectCode, xRecCategoryCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Subject Faculty Category"-End-------------------------------------------------------------------------------------------------

    //"Faculty Course Wise-CS"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50022, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCourseWiseInsert(VAR Rec: Record "Faculty Course Wise-CS"; RunTrigger: Boolean)
    begin
        FacultyCourseWiseFunction(Rec, '', '', '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50022, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCourseWiseModify(VAR Rec: Record "Faculty Course Wise-CS"; VAR xRec: Record "Faculty Course Wise-CS"; RunTrigger: Boolean)
    begin
        FacultyCourseWiseFunction(Rec, '', '', '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50022, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCourseWiseRename(VAR Rec: Record "Faculty Course Wise-CS"; VAR xRec: Record "Faculty Course Wise-CS"; RunTrigger: Boolean)
    begin
        FacultyCourseWiseFunction(Rec, xRec."Course Code", xRec."Faculty Code", xRec."Semester Code", xRec."Section Code", Format(xRec."Line No"), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50022, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_FacultyCourseWiseDelete(VAR Rec: Record "Faculty Course Wise-CS"; RunTrigger: Boolean)
    begin
        FacultyCourseWiseFunction(Rec, '', '', '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FacultyCourseWiseFunction(var Rec: Record "Faculty Course Wise-CS"; xRecCourseCode: Code[20]; xRecFacultyCode: Code[20]; xRecSemesterCode: Code[10]; xRecSectionCode: Code[10]; xRecLineNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FacultyCourseWise?CourseCode=%1&FacultyCode=%2&SemesterCode=%3&SectionCode=%4&LineNo=%5&SubjectCode=%6&AcademicYear=%7&SubjectType=%8&FacultyName=%9&SubjectDescription=%10&Role=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&TypeOfCourse=%14&YearCode=%15&Graduation=%16&SubjectClass=%17&Batch=%18&Group=%19&OldCourseCode=%20&OldFacultyCode=%21&OldSemesterCode=%22&OldSectionCode=%23&OldLineNo=%24&Delete=%25', Rec."Course Code", Rec."Faculty Code", Rec."Semester Code", Rec."Section Code", Rec."Line No", Rec."Subject Code", Rec."Academic Year", Rec."Subject Type", Rec."Faculty Name", Rec."Subject Description", Rec.Role, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Year Code", Rec.Graduation, Rec."Subject Class", Rec.Batch, Rec.Group, xRecCourseCode, xRecFacultyCode, xRecSemesterCode, xRecSectionCode, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Faculty Course Wise-CS"-End-------------------------------------------------------------------------------------------------

    //"Level Wise Description"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50443, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelWiseDescriptionInsert(VAR Rec: Record "Level Wise Description"; RunTrigger: Boolean)
    begin
        LevelWiseDescriptionFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50443, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelWiseDescriptionModify(VAR Rec: Record "Level Wise Description"; VAR xRec: Record "Level Wise Description"; RunTrigger: Boolean)
    begin
        LevelWiseDescriptionFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50443, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelWiseDescriptionRename(VAR Rec: Record "Level Wise Description"; VAR xRec: Record "Level Wise Description"; RunTrigger: Boolean)
    begin
        LevelWiseDescriptionFunction(Rec, xRec."Level Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50443, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelWiseDescriptionDelete(VAR Rec: Record "Level Wise Description"; RunTrigger: Boolean)
    begin
        LevelWiseDescriptionFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure LevelWiseDescriptionFunction(var Rec: Record "Level Wise Description"; xRecLevelCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_LevelWiseDescription?LevelCode=%1&Description=%2&LevelDescription=%3&Level=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&OldLevelCode=%7&Delete=%8', Rec."Level Code", Rec.Description, HandlingOption(Rec."Level Description"), Rec.Level, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", xRecLevelCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Level Wise Description"-End-------------------------------------------------------------------------------------------------

    //"Level"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50442, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelInsert(VAR Rec: Record Level; RunTrigger: Boolean)
    begin
        LevelFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50442, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelModify(VAR Rec: Record Level; VAR xRec: Record Level; RunTrigger: Boolean)
    begin
        LevelFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50442, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelRename(VAR Rec: Record Level; VAR xRec: Record Level; RunTrigger: Boolean)
    begin
        LevelFunction(Rec, Format(xRec.Level), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50442, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_LevelDelete(VAR Rec: Record Level; RunTrigger: Boolean)
    begin
        LevelFunction(Rec, '', 1, 'OnAfterRenameEvent');
    end;

    procedure LevelFunction(var Rec: Record Level; xRecLevel: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Level?Level=%1&Description=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&OldLevel=&%5Delete=%6', Rec.Level, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", xRecLevel, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Level"-End-------------------------------------------------------------------------------------------------

    //"School"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50387, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_SchoolInsert(VAR Rec: Record "School"; RunTrigger: Boolean)
    begin
        SchoolFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50387, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_SchoolModify(VAR Rec: Record "School"; VAR xRec: Record "School"; RunTrigger: Boolean)
    begin
        SchoolFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50387, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_SchoolRename(VAR Rec: Record "School"; VAR xRec: Record "School"; RunTrigger: Boolean)
    begin
        SchoolFunction(Rec, xRec."School ID", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50387, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_SchoolDelete(VAR Rec: Record "School"; RunTrigger: Boolean)
    begin
        SchoolFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SchoolFunction(var Rec: Record School; xRecSchoolID: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_School?SchoolID=%1&EighteenDigitID=%2&AlternateEmailAddress=%3&Name=%4&AccountPersonType=%5&Advisor=%6&BillingAddress=%7&ShippingAddress=%8&CurrentGPAScale=%9&Phone=%10&Website=%11&City=%12&State=%13&Country=%14&ZipCode=%15&GlobalDimension1Code=%16&OldSchoolID=%17&Delete=%18', Rec."School ID", Rec."18 Digit ID", Rec."Alternate Email Address", Rec.Name, HandlingOption(Rec."Account Person Type"), HandlingBoolean(Rec.Advisor), Rec."Billing Address", Rec."Shipping Address", Rec."Current GPA Scale", Rec.Phone, Rec.Website, Rec."City ", Rec.State, Rec.Country, Rec."Zip Code", Rec."Global Dimension 1 Code", xRecSchoolID, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"School"-End-------------------------------------------------------------------------------------------------

    //"Enrollment History"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50437, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_EnrollmentHistoryInsert(VAR Rec: Record "Enrollment History"; RunTrigger: Boolean)
    begin
        EnrollmentHistoryFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50437, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_EnrollmentHistoryModify(VAR Rec: Record "Enrollment History"; VAR xRec: Record "Enrollment History"; RunTrigger: Boolean)
    begin
        EnrollmentHistoryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50437, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_EnrollmentHistoryRename(VAR Rec: Record "Enrollment History"; VAR xRec: Record "Enrollment History"; RunTrigger: Boolean)
    begin
        EnrollmentHistoryFunction(Rec, xRec."Enrollment History No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50437, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_EnrollmentHistoryDelete(VAR Rec: Record "Enrollment History"; RunTrigger: Boolean)
    begin
        EnrollmentHistoryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure EnrollmentHistoryFunction(var Rec: Record "Enrollment History"; xRecEnrollmentHistoryNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EnrollmentHistory?EnrollmentHistoryNo=%1&SchoolNo=%2&StudentNo=%3&CollegeofGraduation=%4&CurrentlyEnrolled=%5&DegreeCandidate=%6&DegreeEarned=%7&DegreeType=%8&DidyouGraduate=%9&EarnedCredits=%10&EndDate=%11&GPACredits=%12&GraduationDate=%13&GraduationYear=%14&OfficialGPAScale=%15&OfficialGPA=%16&OfficialRecalculatedGPA=%17&OfficialTranscriptsReceived=%18&PreReqCredits=%19&PreReqQualityPoints=%20&PrevAttendedMedicalSchool=%21&PrimaryCollege=%22&QualityPoints=%23&ReasonforTransfer=%24&SchoolLevel=%25&SelfReportedGraduationYear=%26&StartDate=%27&TestsTaken=%28&Transfer=%29&Type=%30&EighteenDigitEnrollmentId=%31&OldEnrollmentHistoryNo=%32&Delete=%33', Rec."Enrollment History No.", Rec."School No.", Rec."Student No.", HandlingBoolean(Rec."College of Graduation"), HandlingBoolean(Rec."Currently Enrolled"), HandlingBoolean(Rec."Degree Candidate"), Rec."Degree Earned", HandlingOption(Rec."Degree Type"), HandlingBoolean(Rec."Did you Graduate"), Rec."Earned Credits", FORMAT(Rec."End Date", 0, 9), Rec."GPA Credits", FORMAT(Rec."Graduation Date", 0, 9), Rec."Graduation Year", HandlingOption(Rec."Official GPA Scale"), Rec."Official GPA", Rec."Official Recalculated GPA", HandlingBoolean(Rec."Official Transcripts Received"), Rec."Pre-Req Credits", Rec."Pre-Req Quality Points", HandlingBoolean(Rec."Prev. Attended Medical School"), HandlingBoolean(Rec."Primary College"), Rec."Quality Points", Rec."Reason for Transfer", HandlingOption(Rec."School Level"), Rec."Self-Reported Graduation Year", FORMAT(Rec."Start Date", 0, 9), Rec."Tests Taken", HandlingBoolean(Rec.Transfer), HandlingOption(Rec.Type), Rec."18 Digit EnrollmentId", xRecEnrollmentHistoryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Enrollment History"-End-------------------------------------------------------------------------------------------------


    //"Requisition Header"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50375, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionHeaderInsert(VAR Rec: Record "Requisition Header"; RunTrigger: Boolean)
    begin
        RequisitionHeaderFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50375, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionHeaderModify(VAR Rec: Record "Requisition Header"; VAR xRec: Record "Requisition Header"; RunTrigger: Boolean)
    begin
        RequisitionHeaderFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50375, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionHeaderRename(VAR Rec: Record "Requisition Header"; VAR xRec: Record "Requisition Header"; RunTrigger: Boolean)
    begin
        RequisitionHeaderFunction(Rec, Format(HandlingOption(xRec."Document Type")), xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50375, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionHeaderDelete(VAR Rec: Record "Requisition Header"; RunTrigger: Boolean)
    begin
        RequisitionHeaderFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RequisitionHeaderFunction(var Rec: Record "Requisition Header"; xRecDocumentType: Text[30]; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RequisitionHeader?DocumentType=%1&No=%2&PostingDate=%3&DocumentDate=%4&LocationCode=%5&GlobalDimension1Code=%6&GlobalDimension2Code=%7&UserId=%8&DateAndTime=%9&NoSeries=%10&Status=%11&Description=%12&Closed=%13&Approved=%14&ApprovedBy=%15&ClosedBy=%16&ClosedDate=%17&FirstLevelApproval=%18&SecondLevelApproval=%19&ThirdLevelApproval=%20&FirstLevelApproverID=%21&SecondLevelApproverID=%22&ThirdLevelApproverID=%23&RejectionStatus=%24&Remarks=%25&ApprovalStatus=%26&SendApproverID=%27&FirstLevelApprovedDate=%28&SecondLevelApprovedDate=%29&ThirdLevelApprovedDate=%30&SendforApprovalDate=%31&Reason=%32&ReasonDescription=%33&CreatedBy=%34&CreatedOn=%35&ResponsibleDepartment=%36&Posted=%37&Inserted=%38&Updated=%39&DepartmentName=%40&oldDocumentType=%41&oldNo=%42&Delete=%43', HandlingOption(Rec."Document Type"), Rec."No.", FORMAT(Rec."Posting Date", 0, 9), FORMAT(Rec."Document Date", 0, 9), Rec."Location Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User Id", FORMAT(Rec."Date & Time", 0, 9), Rec."No. Series", HandlingOption(Rec.Status), Rec.Description, HandlingBoolean(Rec.Closed), HandlingBoolean(Rec.Approved), Rec."Approved By", Rec."Closed By", FORMAT(Rec."Closed Date", 0, 9), HandlingBoolean(Rec."1st Level Approval"), HandlingBoolean(Rec."2nd Level Approval"), HandlingBoolean(Rec."3rd Level Approval"), Rec."1st Level Approver ID", Rec."2nd Level Approver ID", Rec."3rd Level Approver ID", HandlingOption(Rec."Rejection Status"), Rec.Remarks, HandlingOption(Rec."Approval Status"), Rec."Send Approver ID", FORMAT(Rec."1st Level Approved Date", 0, 9), FORMAT(Rec."2nd Level Approved Date", 0, 9), FORMAT(Rec."3rd Level Approved Date", 0, 9), FORMAT(Rec."Send for Approval Date", 0, 9), Rec.Reason, Rec."Reason Description", Rec."Created By", FORMAT(Rec."Created On", 0, 9), HandlingOption(Rec."Responsible Department"), HandlingBoolean(Rec.Posted), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Department Name", xRecDocumentType, xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Requisition Header"-End-------------------------------------------------------------------------------------------------

    //"Requisition Line"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50376, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionLineInsert(VAR Rec: Record "Requisition Line_"; RunTrigger: Boolean)
    begin
        RequisitionLineFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50376, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionLineModify(VAR Rec: Record "Requisition Line_"; VAR xRec: Record "Requisition Line_"; RunTrigger: Boolean)
    begin
        RequisitionLineFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50376, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionLineRename(VAR Rec: Record "Requisition Line_"; VAR xRec: Record "Requisition Line_"; RunTrigger: Boolean)
    begin
        RequisitionLineFunction(Rec, Format(HandlingOption(xRec."Document Type")), xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50376, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RequisitionLineDelete(VAR Rec: Record "Requisition Line_"; RunTrigger: Boolean)
    begin
        RequisitionLineFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RequisitionLineFunction(var Rec: Record "Requisition Line_"; xRecDocumentType: Text[30]; xRecDocumentNo: Code[20]; xRecLineNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RequisitionLine?DocumentType=%1&DocumentNo=%2&LineNo=%3&PostingDate=%4&DocumentDate=%5&LocationCode=%6&GlobalDimension1Code=%7&GlobalDimension2Code=%8&ItemCode=%9&Description=%10&RequestedQuantity=%11&UnitofMeasureCode=%12&UnitofMeasure=%13&SuppliersCode=%14&SuppliersName=%15&Status=%16&QuantityIssued=%17&ApprovedQuantity=%18&RequiredQuantity=%19&Description2=%20&Remarks=%21&QuantityToIssue=%22&IssuedQuantity=%23&RemainingQuantitytoIssue=%24&QuantityIssuedBase=%25&QuantityToIssueBase=%26&RequestedQuantityBase=%27&RemainingQtytoIssueBase=%28&BinCode=%29&QtyperUnitofMeasure=%30&QuantityBase=%31&Type=%32&PurchaseOrderNo=%33&PurchaseLineNo=%34&PurchaseQuantity=%35&RemainingPurchaseQuantity=%36&PurchasedOrderQuantity=%37&PromisedDate=%38&ItemIssued=%39&Approved=%40&RequisitionLastLine=%41&DepartmentName=%42&Updated=%43&Inserted=%44&Selection=%45&BudgetCode=%46&OldDocumentType=%47&OldDocumentNo=%48&OldLineNo=%49&Delete=%50', HandlingOption(Rec."Document Type"), Rec."Document No.", Rec."Line No.", FORMAT(Rec."Posting Date", 0, 9), FORMAT(Rec."Document Date", 0, 9), Rec."Location Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Item Code", Rec.Description, FORMAT(Rec."Requested Quantity", 0, 1), Rec."Unit of Measure Code", Rec."Unit of Measure", Rec."Supplier's Code", Rec."Supplier's Name", HandlingOption(Rec.Status), FORMAT(Rec."Quantity Issued", 0, 1), FORMAT(Rec."Approved Quantity", 0, 1), FORMAT(Rec."Required Quantity", 0, 1), Rec."Description 2", Rec.Remarks, FORMAT(Rec."Quantity To Issue", 0, 1), FORMAT(Rec."Issued Quantity", 0, 1), FORMAT(Rec."Remaining Quantity to Issue", 0, 1), FORMAT(Rec."Quantity Issued (Base)", 0, 1), FORMAT(Rec."Quantity To Issue (Base)", 0, 1), FORMAT(Rec."Requested Quantity (Base)", 0, 1), FORMAT(Rec."Remaining Qty to Issue (Base)", 0, 1), Rec."Bin Code", FORMAT(Rec."Qty. per Unit of Measure", 0, 1), FORMAT(Rec."Quantity (Base)", 0, 1), HandlingOption(Rec.Type), Rec."Purchase Order No.", Rec."Purchase Line No.", FORMAT(Rec."Purchase Quantity", 0, 1), Format(Rec."Remaining Purchase Quantity", 0, 1), FORMAT(Rec."Purchased Order Quantity", 0, 1), FORMAT(Rec."Promised Date", 0, 1), HandlingBoolean(Rec."Item Issued"), HandlingBoolean(Rec.Approved), HandlingBoolean(Rec."Requisition Last Line"), Rec."Department Name", HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Selection), Rec."Budget Code", xRecDocumentType, xRecDocumentNo, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Requisition Line"-End-------------------------------------------------------------------------------------------------

    //"Source Scholarship"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50121, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_SourceScholarshipInsert(VAR Rec: Record "Source Scholarship-CS"; RunTrigger: Boolean)
    begin
        SourceScholarshipFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50121, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_SourceScholarshipModify(VAR Rec: Record "Source Scholarship-CS"; VAR xRec: Record "Source Scholarship-CS"; RunTrigger: Boolean)
    begin
        SourceScholarshipFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50121, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_SourceScholarshipRename(VAR Rec: Record "Source Scholarship-CS"; VAR xRec: Record "Source Scholarship-CS"; RunTrigger: Boolean)
    begin
        SourceScholarshipFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50121, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_SourceScholarshipDelete(VAR Rec: Record "Source Scholarship-CS"; RunTrigger: Boolean)
    begin
        SourceScholarshipFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SourceScholarshipFunction(var Rec: Record "Source Scholarship-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_SourceScholarship?Code=%1&Description=%2&CategoryCode=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&DiscountType=%6&SAPCode=%7&OldCode=%8&Delete=%9', Rec.Code, Rec.Description, Rec."Category Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Discount Type"), Rec."SAP Code", xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Source Scholarship"-End-------------------------------------------------------------------------------------------------

    //"Scholarship Line"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50178, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipLineInsert(VAR Rec: Record "Scholarship Line-CS"; RunTrigger: Boolean)
    begin
        ScholarshipLineFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50178, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipLineModify(VAR Rec: Record "Scholarship Line-CS"; VAR xRec: Record "Scholarship Line-CS"; RunTrigger: Boolean)
    begin
        ScholarshipLineFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50178, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipLineRename(VAR Rec: Record "Scholarship Line-CS"; VAR xRec: Record "Scholarship Line-CS"; RunTrigger: Boolean)
    begin
        ScholarshipLineFunction(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50178, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipLineDelete(VAR Rec: Record "Scholarship Line-CS"; RunTrigger: Boolean)
    begin
        ScholarshipLineFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure ScholarshipLineFunction(var Rec: Record "Scholarship Line-CS"; xRecDocumentNo: Code[20]; xRecLineNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ScholarshipLine?DocumentNo=%1&LineNo=%2&ScholarshipCode=%3&Description=%4&AdmittedYear=%5&CourseCode=%6&MinParentIncome=%7&MaxParentIncome=%8&Discount=%9&AmountToPay=%10&PercentageToPay=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&Semester=%14&FeeComponent=%15&AlternativePercentagetoPay=%16&InsertedInSalesForce=%17&InsertSync=%18&UpdateSync=%19&oldDocumentNo=%20&oldLineNo=%21&Delete=%22', Rec."Document No.", Rec."Line No.", Rec."Scholarship Code", Rec.Description, Rec."Admitted Year", Rec."Course Code", FORMAT(Rec."Min Parent Income", 0, 1), FORMAT(Rec."Max Parent Income", 0, 1), Rec."Discount %", FORMAT(Rec."Amount To Pay", 0, 1), FORMAT(Rec."Percentage To Pay", 0, 1), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Semester, Rec."Fee Component", FORMAT(Rec."Alternative Percentage to Pay", 0, 1), HandlingBoolean(Rec."Inserted In SalesForce"), Rec."Insert Sync", Rec."Update Sync", xRecDocumentNo, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Scholarship Line"-End-------------------------------------------------------------------------------------------------

    //"Scholarship Header"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50177, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipHeaderInsert(VAR Rec: Record "Scholarship Header-CS"; RunTrigger: Boolean)
    begin
        ScholarshipHeaderFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50177, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipHeaderModify(VAR Rec: Record "Scholarship Header-CS"; VAR xRec: Record "Scholarship Header-CS"; RunTrigger: Boolean)
    begin
        ScholarshipHeaderFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50177, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipHeaderRename(VAR Rec: Record "Scholarship Header-CS"; VAR xRec: Record "Scholarship Header-CS"; RunTrigger: Boolean)
    begin
        ScholarshipHeaderFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50177, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_ScholarshipHeaderDelete(VAR Rec: Record "Scholarship Header-CS"; RunTrigger: Boolean)
    begin
        ScholarshipHeaderFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure ScholarshipHeaderFunction(var Rec: Record "Scholarship Header-CS"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ScholarshipHeader?No=%1&ScholarshipCode=%2&ScholarshipName=%3&SourceCode=%4&SourceName=%5&FeeClassificationCode=%6&AdmittedYear=%7&UserID=%8&NoSeries=%9&CourseCode=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&GLAccountNo=%13&DiscountType=%14&GrantCriteria=%15&SAPCode=%16&oldNo=%17&Delete=%18', Rec."No.", Rec."Scholarship Code", Rec."Scholarship Name", Rec."Source Code", Rec."Source Name", Rec."Fee Classification Code", Rec."Admitted Year", Rec."User ID", Rec."No. Series", Rec."Course Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."G/L Account No.", HandlingOption(Rec."Discount Type"), HandlingOption(Rec."Grant Criteria"), Rec."SAP Code", xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Scholarship Header"-End-------------------------------------------------------------------------------------------------

    //"SSN Group Area Code"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50436, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalGroupAreaAPIInsert(VAR Rec: Record "SSN Group Area Code"; RunTrigger: Boolean)
    begin
        SSNGroupAreaCodeFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50436, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalGroupAreaAPIModify(VAR Rec: Record "SSN Group Area Code"; VAR xRec: Record "SSN Group Area Code"; RunTrigger: Boolean)
    begin
        SSNGroupAreaCodeFunction(Rec, xRec."Group Code", xRec."Area Code", 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50436, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalGroupAreaAPIRename(VAR Rec: Record "SSN Group Area Code"; VAR xRec: Record "SSN Group Area Code"; RunTrigger: Boolean)
    begin
        SSNGroupAreaCodeFunction(Rec, xRec."Group Code", xRec."Area Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50436, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalGroupAreaAPIDelete(VAR Rec: Record "SSN Group Area Code"; RunTrigger: Boolean)
    begin
        SSNGroupAreaCodeFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SSNGroupAreaCodeFunction(var Rec: Record "SSN Group Area Code"; xRecGroupCode: Code[2]; xRecAreaCode: Code[3]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/GroupAreaAPI?GroupCode=%1&AreaCode=%2&OldGroupCode=%3&OldAreaCode=%4&Delete=%5', Rec."Group Code", Rec."Area Code", xRecGroupCode, xRecAreaCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"SSN Group Area Code"-End-------------------------------------------------------------------------------------------------

    //"Portal User Login"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50030, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalUserCreationUpdateAPIInsert(VAR Rec: Record "Portal User Login-CS"; RunTrigger: Boolean)
    begin
        PortalUserLoginFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50030, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalUserCreationUpdateAPIModify(VAR Rec: Record "Portal User Login-CS"; VAR xRec: Record "Portal User Login-CS"; RunTrigger: Boolean)
    begin
        PortalUserLoginFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50030, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalUserCreationUpdateAPIRename(VAR Rec: Record "Portal User Login-CS"; VAR xRec: Record "Portal User Login-CS"; RunTrigger: Boolean)
    begin
        PortalUserLoginFunction(Rec, xRec.U_ID, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50030, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalUserCreationUpdateAPIDelete(VAR Rec: Record "Portal User Login-CS"; RunTrigger: Boolean)
    begin
        PortalUserLoginFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure PortalUserLoginFunction(var Rec: Record "Portal User Login-CS"; xRecUID: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/UserCreationUpdateAPI?No=%1&Type=%2&LoginID=%3&Password=%4&UserGroup=%5&GlobalDimension1Code=%6&GlobalDimension2Code=%7&UID=%8&RoleCode=%9&WindowsAuthentication=%10&IsAdmin=%11&UserName=%12&MobileNo=%13&Email=%14&ImagePath=%15&Extension=%16&FileName=%17&CreatedBy=%18&CreatedOn=%19&UpdatedBy=%20&UpdatedOn=%21&UpdatedByName=%22&CreatedByName=%23&Updated=%24&ShadowLogin=%25&SUID=%26&PasswordChanged=%27&AzureObjectId=%28&oldUID=%29&Delete=%30', Rec.No, HandlingOption(Rec.Type), Rec."Login ID", Rec.Password, Rec."User Group", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.U_ID, Rec.Role_Code, HandlingBoolean(Rec.WindowsAuthentication), HandlingBoolean(Rec.IsAdmin), Rec.UserName, Rec.MobileNo, Rec.Email, Rec.Image_Path, Rec.Extension, Rec.FileName, Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Updated By", FORMAT(Rec."Updated On", 0, 9), Rec."Updated By Name", Rec."Created By Name", HandlingBoolean(Rec.Updated), HandlingBoolean(Rec."Shadow Login"), Rec.SU_ID, HandlingBoolean(Rec."Password Changed"), '', xRecUID, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Portal User Login"-End-------------------------------------------------------------------------------------------------

    //"FM1/IM1 Date Preset Entry"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50378, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_FM1_IM1_Date_Preset_EntryInsert(VAR Rec: Record "FM1/IM1 Date Preset Entry"; RunTrigger: Boolean)
    begin
        FMIMDatePresetEntryFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50378, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_FM1_IM1_Date_Preset_EntryModify(VAR Rec: Record "FM1/IM1 Date Preset Entry"; VAR xRec: Record "FM1/IM1 Date Preset Entry"; RunTrigger: Boolean)
    begin
        FMIMDatePresetEntryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50378, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_FM1_IM1_Date_Preset_EntryRename(VAR Rec: Record "FM1/IM1 Date Preset Entry"; VAR xRec: Record "FM1/IM1 Date Preset Entry"; RunTrigger: Boolean)
    begin
        FMIMDatePresetEntryFunction(Rec, xRec."Preset No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50378, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_FM1_IM1_Date_Preset_EntryDelete(VAR Rec: Record "FM1/IM1 Date Preset Entry"; RunTrigger: Boolean)
    begin
        FMIMDatePresetEntryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FMIMDatePresetEntryFunction(var Rec: Record "FM1/IM1 Date Preset Entry"; xRecPresetNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FM1_IM1_Date_Preset_Entry?PresetNo_=%1&AcademicYear=%2&SubjectCode=%3&SubjectDescription=%4&RotationDescription=%5&StartDate=%6&No_ofWeeks=%7&EndDate=%8&DocumentDueDate=%9&GlobalDimension1Code=%10&Status=%11&No_Series=%12&CreatedBy=%13&CreatedOn=%14&ConfirmedBy=%15&ConfirmedOn=%16&SpecialAccommodation=%17&oldPresetNo_=%18&Delete=%19', Rec."Preset No.", Rec."Academic Year", Rec."Course Code", Rec."Course Description", Rec."Rotation Description", FORMAT(Rec."Start Date", 0, 9), Rec."No. of Weeks", FORMAT(Rec."End Date", 0, 9), FORMAT(Rec."Document Due Date", 0, 9), Rec."Global Dimension 1 Code", HandlingOption(Rec.Status), Rec."No. Series", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Confirmed By", Format(Rec."Confirmed On", 0, 9), HandlingOption(Rec."Special Accommodation"), xRecPresetNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"FM1/IM1 Date Preset Entry"-End-------------------------------------------------------------------------------------------------

    //"Std Spl Accommodation Category"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50412, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Std_Spl_Accommodation_CategoryInsert(VAR Rec: Record "Std Spl Accommodation Category"; RunTrigger: Boolean)
    begin
        StdSplAccommodationCategoryFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50412, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Std_Spl_Accommodation_CategoryModify(VAR Rec: Record "Std Spl Accommodation Category"; VAR xRec: Record "Std Spl Accommodation Category"; RunTrigger: Boolean)
    begin
        StdSplAccommodationCategoryFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50412, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Std_Spl_Accommodation_CategoryRename(VAR Rec: Record "Std Spl Accommodation Category"; VAR xRec: Record "Std Spl Accommodation Category"; RunTrigger: Boolean)
    begin
        StdSplAccommodationCategoryFunction(Rec, xRec."Student ID", xRec."Application No.", xRec."Accommodation Category Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50412, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Std_Spl_Accommodation_CategoryDelete(VAR Rec: Record "Std Spl Accommodation Category"; RunTrigger: Boolean)
    begin
        StdSplAccommodationCategoryFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StdSplAccommodationCategoryFunction(var Rec: Record "Std Spl Accommodation Category"; xRecStudentID: Code[20]; xRecApplicationNo: Code[20]; xRecAccommodationCategoryCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Std_Spl_Accommodation_Category?StudentID=%1&ApplicationNo_=%2&AccommodationCategoryCode=%3&CategoryDescription=%4&Category=%5&StudentName=%6&Reason=%7&AttachmentDescription=%8&FilePath=%9&FileExtension=%10&AttachmentID=%11&AttachmentCategory=%12&ClinicalReferenceNo_=%13&CreatedBy=%14&CreatedOn=%15&OldStudentID=%16&OldApplicationNo_=%17&OldAccommodationCategoryCode=%18&Delete=%19', Rec."Student ID", Rec."Application No.", Rec."Accommodation Category Code", Rec."Category Description", HandlingOption(Rec.Category), Rec."Student Name", Rec.Reason, Rec."Attachment Description", Rec."File Path", Rec."File Extension", Rec."Attachment ID", Rec."Attachment Category", Rec."Clinical Reference No.", Rec."Created By", FORMAT(Rec."Created On", 0, 9), xRecStudentID, xRecApplicationNo, xRecAccommodationCategoryCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Std Spl Accommodation Category"-End-------------------------------------------------------------------------------------------------

    //"Special Accommodation Category"-Start-------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50411, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Special_Accommodation_CategoryInsert(VAR Rec: Record "Special Accommodation Category"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50411, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Special_Accommodation_CategoryModify(VAR Rec: Record "Special Accommodation Category"; VAR xRec: Record "Special Accommodation Category"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50411, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Special_Accommodation_CategoryRename(VAR Rec: Record "Special Accommodation Category"; VAR xRec: Record "Special Accommodation Category"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50411, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Special_Accommodation_CategoryDelete(VAR Rec: Record "Special Accommodation Category"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SpecialAccommodationCategoryFunction(var Rec: Record "Special Accommodation Category"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Special_Accommodation_Category?Code=%1&ReasonDescription=%2&Category=%3&CreatedBy=%4&CreatedOn=%5&OldCode=%6&Delete=%7', Rec.Code, Rec."Reason Description", HandlingOption(Rec.Category), Rec."Created By", FORMAT(Rec."Created On", 0, 9), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Special Accommodation Category"-End------------------------------------------------------------------------------------------------

    //"Spcl Accommodation Application"-Start------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Table, 50374, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Spcl_Consideration_ApplicationInsert(VAR Rec: Record "Spcl Accommodation Application"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50374, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Spcl_Consideration_ApplicationModify(VAR Rec: Record "Spcl Accommodation Application"; VAR xRec: Record "Spcl Accommodation Application"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50374, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Spcl_Consideration_ApplicationRename(VAR Rec: Record "Spcl Accommodation Application"; VAR xRec: Record "Spcl Accommodation Application"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50374, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Spcl_Consideration_ApplicationDelete(VAR Rec: Record "Spcl Accommodation Application"; RunTrigger: Boolean)
    begin
        SpecialAccommodationCategoryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SpecialAccommodationCategoryFunction(var Rec: Record "Spcl Accommodation Application"; xRecApplicationNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Spcl_Consideration_Application?ApplicationNo_=%1&ApplicationType=%2&StudentNo_=%3&FirstName=%4&MiddleName=%5&LastName=%6&StudentName=%7&EnrollmentNo_=%8&AcademicYear=%9&Semester=%10&GlobalDimension1Code=%11&ClinicalCordinatorID=%12&No_Series=%13&Comments=%14&CreatedBy=%15&CreatedOn=%16&SendforApproval=%17&SendforApprovalBy=%18&SendforApprovalOn=%19&ApprovalStatus=%20&ApprovalStatusBy=%21&ApprovalStatusOn=%22&ClinicalReferenceNo_=%23&OldApplicationNo_=%24&Delete=%25', Rec."Application No.", HandlingOption(Rec."Application Type"), Rec."Student No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", Rec."Academic Year", Rec.Semester, Rec."Global Dimension 1 Code", Rec."Clinical Cordinator ID", Rec."No. Series", Rec.Comments, Rec."Created By", FORMAT(Rec."Created On", 0, 9), HandlingBoolean(Rec."Send for Approval"), Rec."Send for Approval By", FORMAT(Rec."Send for Approval On", 0, 9), HandlingOption(Rec."Approval Status"), Rec."Approval Status By", FORMAT(Rec."Approval Status On", 0, 9), Rec."Clinical Reference No.", xRecApplicationNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Spcl Accommodation Application"-End------------------------------------------------------------------------------------------------

    //"Clinical Coordinator Planning"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50418, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Coordinator_MappingInsert(VAR Rec: Record "Clinical Coordinator Planning"; RunTrigger: Boolean)
    begin
        ClinicalCoordinatorPlanningFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50418, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Coordinator_MappingModify(VAR Rec: Record "Clinical Coordinator Planning"; VAR xRec: Record "Clinical Coordinator Planning"; RunTrigger: Boolean)
    begin
        ClinicalCoordinatorPlanningFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50418, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Coordinator_MappingRename(VAR Rec: Record "Clinical Coordinator Planning"; VAR xRec: Record "Clinical Coordinator Planning"; RunTrigger: Boolean)
    begin
        ClinicalCoordinatorPlanningFunction(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50418, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Coordinator_MappingDelete(VAR Rec: Record "Clinical Coordinator Planning"; RunTrigger: Boolean)
    begin
        ClinicalCoordinatorPlanningFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure ClinicalCoordinatorPlanningFunction(var Rec: Record "Clinical Coordinator Planning"; xRecEntryNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Clinical_Coordinator_Mapping?EntryNo_=%1&Type=%2&StartRange=%3&EndRange=%4&Status=%5&CoordinatorUserID=%6&CoordinatorUserName=%7&OldEntryNo_=%8&Delete=%9', Rec."Entry No.", HandlingOption(Rec.Role), Rec."Start Alpha Range", Rec."End Alpha Range", HandlingOption(Rec.Status), Rec."User ID", Rec."User Name", xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Clinical Coordinator Planning"-End------------------------------------------------------------------------------------------------

    //"Portal Menu"-Start-----------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50432, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_tblmstmenuInsert(VAR Rec: Record "Portal Menu"; RunTrigger: Boolean)
    begin
        PortalMenuFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50432, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_tblmstmenuModify(VAR Rec: Record "Portal Menu"; VAR xRec: Record "Portal Menu"; RunTrigger: Boolean)
    begin
        PortalMenuFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50432, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_tblmstmenuRename(VAR Rec: Record "Portal Menu"; VAR xRec: Record "Portal Menu"; RunTrigger: Boolean)
    begin
        PortalMenuFunction(Rec, xRec."Menu Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50432, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_tblmstmenuDelete(VAR Rec: Record "Portal Menu"; RunTrigger: Boolean)
    begin
        PortalMenuFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure PortalMenuFunction(var Rec: Record "Portal Menu"; xRecMenuCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_tblmstmenu?MENUCODE=%1&MENUNAME=%2&PRIORITY=%3&LINK=%4&ParentIntId=%5&ACTIVE=%6&Availability=%7&EventCode=%8&OldMENUCODE=%9&Delete=%10', Rec."Menu Code", Rec."Menu Name", Rec.PRIORITY, Rec.Link, Rec."Parent ID", Rec.Active, Rec.Availability, Rec."Event Code", xRecMenuCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Portal Menu"-End------------------------------------------------------------------------------------------------

    //"Roster Scheduling Line"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50344, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_LineInsert(VAR Rec: Record "Roster Scheduling Line"; RunTrigger: Boolean)
    begin
        RosterSchedulingLineFunction(Rec, '', '', '', 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50344, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_LineModify(VAR Rec: Record "Roster Scheduling Line"; VAR xRec: Record "Roster Scheduling Line"; RunTrigger: Boolean)
    begin
        RosterSchedulingLineFunction(Rec, '', '', '', 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50344, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_LineRename(VAR Rec: Record "Roster Scheduling Line"; VAR xRec: Record "Roster Scheduling Line"; RunTrigger: Boolean)
    begin
        RosterSchedulingLineFunction(Rec, xRec."Rotation ID", xRec."Academic Year", xRec."Student No.", xRec."Rotation No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50344, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_LineDelete(VAR Rec: Record "Roster Scheduling Line"; RunTrigger: Boolean)
    begin
        RosterSchedulingLineFunction(Rec, '', '', '', 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure RosterSchedulingLineFunction(var Rec: Record "Roster Scheduling Line"; xRecRotationID: Code[20]; xRecAcademicYear: Code[10]; xRecStudentNo: Code[20]; xRecRotationCode: Integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Roster_Scheduling_Line?RotationID=%1&AcademicYear=%2&StudentNo_=%3&RotationNo_=%4&Semester=%5&FirstName=%6&MiddleName=%7&LastName=%8&StudentName=%9&EnrollmentNo_=%10&EntryType=%11&ClerkshipType=%12&SubjectCode=%13&SubjectDescription=%14&ElectiveSubjectCode=%15&RotationDescription=%16&SubjectType=%17&No_ofWeeks=%18&StartDate=%19&EndDate=%20&HospitalID=%21&HospitalName=%22&ClinicalCordinatorID=%23&DocumentSpecialistID=%24&GlobalDimension1Code=%25&GlobalDimension2Code=%26&TotalNo_ofSeats=%27&StudentStatus=%28&EstimatedRotationCost=%29&TotalEstimatedRotationCost=%30&Status=%31&PublishedBy=%32&PublishedOn=%33&ScheduledBy=%34&ScheduledOn=%35&CancelledBy=%36&CancelledDate=%37&CancelledTime=%38&StudentType=%39&Waitlisted=%40&RotationConfirmed=%41&RotationConfirmedBy=%42&RotationConfirmedOn=%43&CancelReasonCode=%44&CancelReasonDescription=%45&OfferNo_=%46&OfferApplicationLineNo_=%47&FM1_IM1ApplicationNo_=%48&NonAffiliatedApplicationNo_=%49&LedgerEntryNo_=%50&ActionofStudent=%51&NotifiedtoHospital=%52&CLOAApplicationNo_=%53&OldRotationID=%54&OldAcademicYear=%55&OldStudentNo_=%56&OldRotationNo_=%57&Delete=%58', Rec."Rotation ID", Rec."Academic Year", Rec."Student No.", Rec."Rotation No.", Rec.Semester, Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", HandlingOption(Rec."Entry Type"), HandlingOption(Rec."Clerkship Type"), Rec."Course Code", Rec."Course Description", Rec."Elective Course Code", Rec."Rotation Description", HandlingOption(Rec."Course Type"), Rec."No. of Weeks", FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."End Date", 0, 9), Rec."Hospital ID", Rec."Hospital Name", Rec."Coordinator ID", Rec."Document Specialist ID", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Total No. of Seats", HandlingOption(Rec."Student Status"), Rec."Estimated Rotation Cost", Rec."Total Estimated Rotation Cost", HandlingOption(Rec.Status), Rec."Published By", FORMAT(Rec."Published On", 0, 9), Rec."Scheduled By", FORMAT(Rec."Scheduled On", 0, 9), Rec."Cancelled By", FORMAT(Rec."Cancelled Date", 0, 9), FORMAT(Rec."Cancelled Time", 0, 9), HandlingOption(Rec."Student Type"), HandlingBoolean(Rec.Waitlisted), HandlingBoolean(Rec."Rotation Confirmed"), Rec."Rotation Confirmed By", FORMAT(Rec."Rotation Confirmed On", 0, 9), Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Offer No.", Rec."Offer Application Line No.", Rec."FM1/IM1 Application No.", Rec."Non-Affiliated Application No.", Rec."Ledger Entry No.", HandlingOption(Rec."Action of Student"), HandlingBoolean(Rec."Notified to Hospital"), Rec."CLOA Application No.", xRecRotationID, xRecAcademicYear, xRecStudentNo, xRecRotationCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Roster Scheduling Line"-End------------------------------------------------------------------------------------------------


    //"Rotation Offers"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50414, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Rotation_OffersInsert(VAR Rec: Record "Rotation Offers"; RunTrigger: Boolean)
    begin
        RotationOffersFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50414, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Rotation_OffersModify(VAR Rec: Record "Rotation Offers"; VAR xRec: Record "Rotation Offers"; RunTrigger: Boolean)
    begin
        RotationOffersFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50414, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Rotation_OffersRename(VAR Rec: Record "Rotation Offers"; VAR xRec: Record "Rotation Offers"; RunTrigger: Boolean)
    begin
        RotationOffersFunction(Rec, xRec."Offer No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50414, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Rotation_OffersDelete(VAR Rec: Record "Rotation Offers"; RunTrigger: Boolean)
    begin
        RotationOffersFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RotationOffersFunction(var Rec: Record "Rotation Offers"; xRecOfferNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Clinical_Rotation_Offers?OfferNo_=%1&AcademicYear=%2&SubjectCode=%3&SubjectDescription=%4&SubjectPrefix=%5&ElectiveSubjectCode=%6&RotationDescription=%7&StartDate=%8&EndDate=%9&No_ofWeeks=%10&CordinationID=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&Status=%14&No_Series=%15&StatusBy=%16&StatusOn=%17&HospitalID=%18&HospitalName=%19&AvailableNo_ofSeats=%20&MaximumWaitlistStudents=%21&TotalNo_ofSeats=%22&VisibleonPortal=%23&OldOfferNo_=%24&Delete=%25', Rec."Offer No.", Rec."Academic Year", Rec."Course Code", Rec."Course Description", Rec."Course Prefix", Rec."Elective Course Code", Rec."Rotation Description", FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."End Date", 0, 9), Rec."No. of Weeks", Rec."Cordination ID", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec.Status), Rec."No. Series", Rec."Status By", FORMAT(Rec."Status On", 0, 9), Rec."Hospital ID", Rec."Hospital Name", FORMAT(Rec."No. of Seats", 0, 1), FORMAT(Rec."Maximum Waitlist Students", 0, 1), FORMAT(Rec."Total No. of Seats", 0, 1), HandlingBoolean(Rec."Visible on Portal"), xRecOfferNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Rotation Offers"-End------------------------------------------------------------------------------------------------

    //"In Person Registration"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50401, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_InPersonRegistrationInsert(VAR Rec: Record "In Person Registration"; RunTrigger: Boolean)
    begin
        InPersonRegistrationFunction(Rec, '', '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50401, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_InPersonRegistrationModify(VAR Rec: Record "In Person Registration"; VAR xRec: Record "In Person Registration"; RunTrigger: Boolean)
    begin
        InPersonRegistrationFunction(Rec, '', '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50401, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_InPersonRegistrationRename(VAR Rec: Record "In Person Registration"; VAR xRec: Record "In Person Registration"; RunTrigger: Boolean)
    begin
        InPersonRegistrationFunction(Rec, xRec."Academic Year", xRec.Semester, xRec."Last Name First Letter Range", xRec."Global Dimension 1 Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50401, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_InPersonRegistrationDelete(VAR Rec: Record "In Person Registration"; RunTrigger: Boolean)
    begin
        InPersonRegistrationFunction(Rec, '', '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure InPersonRegistrationFunction(var Rec: Record "In Person Registration"; xRecAcademicYear: Code[20]; xRecSemester: Code[10]; xRecLastNameFirstLetterRange: text[3]; xRecGlobalDimension1Code: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_InPersonRegistration?AcademicYear=%1&Semester=%2&LastNameFirstLetterRange=%3&GlobalDimension1Code=%4&DateofInPerson=%5&TimeSlotofInPerson=%6&Session=%7&PlaceofInPerson=%8&GlobalDimension2Code=%9&CreatedBy=%10&CreatedOn=%11&ModifiedBy=%12&ModifiedOn=%13&Updated=%14&OldAcademicYear=%15&OldSemester=%16&OldLastNameFirstLetterRange=%17&OldGlobalDimension1Code=%18&Delete=%19', Rec."Academic Year", Rec.Semester, Rec."Last Name First Letter Range", Rec."Global Dimension 1 Code", FORMAT(Rec."Date of In-Person", 0, 9), Rec."Time Slot of In-Person", HandlingOption(Rec.Session), Rec."Place of In-Person", Rec."Global Dimension 1 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Updated), xRecAcademicYear, xRecSemester, xRecLastNameFirstLetterRange, xRecGlobalDimension1Code, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"In Person Registration"-End------------------------------------------------------------------------------------------------

    //"Financial AID"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50400, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_FinancialAidOnInsert(VAR Rec: Record "Financial AID"; RunTrigger: Boolean)
    begin
        FinancialAIDFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50400, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_FinancialAidOnModify(VAR Rec: Record "Financial AID"; VAR xRec: Record "Financial AID"; RunTrigger: Boolean)
    begin
        FinancialAIDFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50400, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_FinancialAidOnRename(VAR Rec: Record "Financial AID"; VAR xRec: Record "Financial AID"; RunTrigger: Boolean)
    begin
        FinancialAIDFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50400, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_FinancialAidOnDelete(VAR Rec: Record "Financial AID"; RunTrigger: Boolean)
    begin
        FinancialAIDFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FinancialAIDFunction(var Rec: Record "Financial AID"; xRecApplicationNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FinancialAid?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&StudentName=%4&AcademicYear=%5&Semester=%6&GlobalDimension1Code=%7&GlobalDimension2Code=%8&Reason=%9&ReasonDescription=%10&Status=%11&ApprovedRejectedBy=%12&ApprovedRejectedOn=%13&NoSeries=%14&CreatedBy=%15&CreatedOn=%16&ModifiedBy=%17&ModifiedOn=%18&EntranceCounseling=%19&UnsubsidizedLoan=%20&DirectGraduateplusloan=%21&Livingexpenses=%22&GradPlusTransactionAmount=%23&UnsubsidizedTransationAmount=%24&GradPLUSMPN=%25&GradPLUSDenial=%26&Endorse=%27&LoanAmount=%28&PLUSCounseling=%29&FSAID=%30&LoanExpiryDate=%31&EnrollmentNo=%32&UnsubsidizedBudgettedAmount=%33&GraduatePlusBudgettedAmount=%34&Type=%35&PaymentPlanInstalment=%36&DateofBirth=%37&EmailId=%38&VisitedFAFSAWebsite=%39&VisitedStudentLoanWebsite=%40&DocumentDate=%41&PortalEntry=%42&PhoneNo=%43&FeeIncludedInFinancialAid=%44&NonInstitutionalFee=%45&StudentSignature=%46&SignDate=%47&CreatedDate=%48&ModifiedDate=%49&livingexpensesValue=%50&OldApplicationNo=%51&Delete=%52', Rec."Application No.", FORMAT(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Student Name", Rec."Academic Year", Rec.Semester, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Reason, Rec."Reason Description", HandlingOption(Rec.Status), Rec."Approved/Rejected By", FORMAT(Rec."Approved/Rejected On", 0, 9), Rec."No. Series", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingOption(Rec."Entrance Counseling"), HandlingOption(Rec."Unsubsidized Loan"), HandlingOption(Rec."Direct Graduate plus loan"), HandlingOption(Rec."Living expenses"), FORMAT(Rec."Grad. Plus Transaction Amount", 0, 1), FORMAT(Rec."Unsubsidized Transation Amount", 0, 1), HandlingOption(Rec."Grad PLUS MPN"), HandlingOption(Rec."Grad PLUS Denial"), HandlingOption(Rec.Endorse), FORMAT(Rec."Loan Amount", 0, 1), HandlingOption(Rec."PLUS Counseling"), Rec."FSA ID", FORMAT(Rec."Loan Expiry Date", 0, 9), Rec."Enrollment No.", FORMAT(Rec."Unsubsidized Budgetted Amount", 0, 1), FORMAT(Rec."Graduate Plus Budgetted Amount", 0, 1), HandlingOption(REc.Type), Rec."Payment Plan Instalment", FORMAT(Rec."Date of Birth", 0, 9), Rec."Email Id", HandlingOption(Rec."Visited FAFSA Website"), HandlingOption(Rec."Visited Student Loan Website"), FORMAT(Rec."Document Date", 0, 9), HandlingBoolean(Rec."Portal Entry"), Rec."Phone No.", '0', '', '', '', FORMAT(Rec."Created On", 0, 9), FORMAT(Rec."Modified On", 0, 9), '', xRecApplicationNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Financial AID"-End------------------------------------------------------------------------------------------------

    //"Immigration Header"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50407, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationHeaderOnInsert(VAR Rec: Record "Immigration Header"; RunTrigger: Boolean)
    begin
        ImmigrationHeaderFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50407, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationHeaderOnModify(VAR Rec: Record "Immigration Header"; VAR xRec: Record "Immigration Header"; RunTrigger: Boolean)
    begin
        ImmigrationHeaderFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50407, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationHeaderRename(VAR Rec: Record "Immigration Header"; VAR xRec: Record "Immigration Header"; RunTrigger: Boolean)
    begin
        ImmigrationHeaderFunction(Rec, xRec."Document No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50407, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationHeaderOnDelete(VAR Rec: Record "Immigration Header"; RunTrigger: Boolean)
    begin
        ImmigrationHeaderFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure ImmigrationHeaderFunction(var Rec: Record "Immigration Header"; xRecDocumentNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ImmigrationHeader?DocumentNo=%1&StudentNo=%2&EnrollmentNo=%3&Semester=%4&AcademicYear=%5&GlobalDimension1Code=%6&PassPortNo1=%7&PassPortIssuedDate1=%8&PassPortIssuedBy1=%9&PassPortExpiryDate1=%10&PassPortNo2=%11&PassPortIssuedDate2=%12&PassPortIssuedBy2=%13&PassPortExpiryDate2=%14&PassPortNo3=%15&PassPortIssuedDate3=%16&PassPortIssuedBy3=%17&PassPortExpiryDate3=%18&VisaNo=%19&VisaIssuedDate=%20&VisaExpiryDate=%21&VisaExtensionDate=%22&ImmigrationApplicationDate=%23&NoSeries=%24&StudentName=%25&DocumentStatus=%26&FirstName=%27&LastName=%28&CountryCode=%29&Addressee=%30&Address1=%31&Address2=%32&PostCode=%33&Term=%34&RejectionRemark=%35&CreatedBy=%36&CreatedOn=%37&ApprovedRejectedBy=%38&ApprovedRejectedOn=%39&ImmigrationIssuanceDate=%40&OldDocumentNo=%41&Delete=%42', Rec."Document No.", Rec."Student No", Rec."Enrollment No", Rec.Semester, Rec."Academic Year", Rec."Global Dimension 1 Code", Rec."Pass Port No. 1", FORMAT(Rec."Pass Port Issued Date 1", 0, 9), Rec."Pass Port Issued By 1", FORMAT(Rec."Pass Port Expiry Date 1", 0, 9), Rec."Pass Port No. 2", FORMAT(Rec."Pass Port Issued Date 2", 0, 9), Rec."Pass Port Issued By 2", FORMAT(Rec."Pass Port Expiry Date 2", 0, 9), Rec."Pass Port No. 3", FORMAT(Rec."Pass Port Issued Date 3", 0, 9), Rec."Pass Port Issued By 3", FORMAT(Rec."Pass Port Expiry Date 3", 0, 9), Rec."Visa No.", FORMAT(Rec."Visa Issued Date", 0, 9), FORMAT(Rec."Visa Expiry Date", 0, 9), FORMAT(Rec."Visa Extension Date", 0, 9), FORMAT(Rec."Immigration Application Date", 0, 9), Rec."No. Series", Rec."Student Name", HandlingOption(Rec."Document Status"), Rec."First Name", Rec."Last Name", Rec."Country Code", Rec.Addressee, Rec.Address1, Rec.Address2, Rec."Post Code", HandlingOption(Rec.Term), Rec."Rejection Remark", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Approved/Rejected By", FORMAT(Rec."Approved/Rejected On", 0, 9), FORMAT(Rec."Immigration Issuance Date", 0, 9), xRecDocumentNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Immigration Header"-End------------------------------------------------------------------------------------------------    

    //"Withdrawal Department"-Start------------------------------------------------------------------------------------------------    

    [EventSubscriber(ObjectType::Table, 50388, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalDepartmentOnInsert(VAR Rec: Record "Withdrawal Department"; RunTrigger: Boolean)
    begin
        WithdrawalDepartmentFunction(Rec, '', '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50388, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalDepartmentOnModify(VAR Rec: Record "Withdrawal Department"; VAR xRec: Record "Withdrawal Department"; RunTrigger: Boolean)
    begin
        WithdrawalDepartmentFunction(Rec, '', '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50388, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalDepartmentOnRename(VAR Rec: Record "Withdrawal Department"; VAR xRec: Record "Withdrawal Department"; RunTrigger: Boolean)
    begin
        WithdrawalDepartmentFunction(Rec, xRec."Department Code", xRec."Global Dimension 1 Code", Format(HandlingOption(xRec."Document Type")), Format(HandlingOption(xRec."Type of Withdrawal")), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50388, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalDepartmentOnDelete(VAR Rec: Record "Withdrawal Department"; RunTrigger: Boolean)
    begin
        WithdrawalDepartmentFunction(Rec, '', '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure WithdrawalDepartmentFunction(var Rec: Record "Withdrawal Department"; xRecDepartmentCode: Code[20]; xRecGlobalDimension1Code: Code[20]; xRecDocumentType: Text[20]; xRecTypeofWithdrawal: Text[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_WithdrawalDepartment?DepartmentCode=%1&GlobalDimension1Code=%2&DepartmentName=%3&Status=%4&TypeofWithdrawal=%5&FinalApproval=%6&waivercalculationallowed=%7&username=%8&useremail=%9&userphoneno_=%10&DocumentType=%11&OldDepartmentCode=%12&OldGlobalDimension1Code=%13&OldDocumentType=%14&OldTypeofWithdrawal=%15&Delete=%16', Rec."Department Code", Rec."Global Dimension 1 Code", Rec."Department Name", HandlingOption(Rec.Status), HandlingOption(Rec."Type of Withdrawal"), HandlingBoolean(Rec."Final Approval"), HandlingBoolean(Rec."Waiver Calculation Allowed"), Rec."User Name", Rec."User E-Mail", Rec."User Phone No.", HandlingOption(Rec."Document Type"), xRecDepartmentCode, xRecGlobalDimension1Code, xRecDocumentType, xRecTypeofWithdrawal, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Withdrawal Department"-End------------------------------------------------------------------------------------------------ 

    //"Fee Component Master"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50159, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsupdateFeecomponentsOnInsert(VAR Rec: Record "Fee Component Master-CS"; RunTrigger: Boolean)
    begin
        FeeComponentMasterFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50159, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsupdateFeecomponentsOnModify(VAR Rec: Record "Fee Component Master-CS"; VAR xRec: Record "Fee Component Master-CS"; RunTrigger: Boolean)
    begin
        FeeComponentMasterFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50159, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsupdateFeecomponentsOnRename(VAR Rec: Record "Fee Component Master-CS"; VAR xRec: Record "Fee Component Master-CS"; RunTrigger: Boolean)
    begin
        FeeComponentMasterFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50159, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsupdateFeecomponentsOnDelete(VAR Rec: Record "Fee Component Master-CS"; RunTrigger: Boolean)
    begin
        FeeComponentMasterFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;


    procedure FeeComponentMasterFunction(var Rec: Record "Fee Component Master-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insupdateFeecomponents?Code=%1&Description=%2&G_LAccount=%3&FeeGroup=%4&CheckDuplication=%5&NoOfMonths=%6&GlobalDimension1Code=%7&GlobalDimension2Code=%8&UserID=%9&PortalID=%10&FeeGenerationAmount=%11&OldCode=%12&Delete=%13', Rec.Code, Rec.Description, Rec."G/L Account", HandlingOption(Rec."Fee Group"), HandlingBoolean(Rec."Check Duplication"), Rec."No Of Months", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec."Fee Generation Amount Based"), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Fee Component Master"-End------------------------------------------------------------------------------------------------ 

    //"Fee Setup"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50155, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateCourseFeeSetupOnInsert(VAR Rec: Record "Fee Setup-CS"; RunTrigger: Boolean)
    begin
        FeeSetupFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50155, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateCourseFeeSetupOnModify(VAR Rec: Record "Fee Setup-CS"; VAR xRec: Record "Fee Setup-CS"; RunTrigger: Boolean)
    begin
        FeeSetupFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50155, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateCourseFeeSetupOnRename(VAR Rec: Record "Fee Setup-CS"; VAR xRec: Record "Fee Setup-CS"; RunTrigger: Boolean)
    begin
        FeeSetupFunction(Rec, xRec."Primary Key", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50155, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateCourseFeeSetupOnDelete(VAR Rec: Record "Fee Setup-CS"; RunTrigger: Boolean)
    begin
        FeeSetupFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FeeSetupFunction(var Rec: Record "Fee Setup-CS"; xRecPrimaryKey: Code[10]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateCourseFeeSetup?PrimaryKey=%1&CourseFeeNo=%2&InstallmentScheme=%3&NoOfInstallment=%4&InstallmentCharges=%5&JournalTemplateName=%6&JournalBatchName=%7&FeeInvoiceNo_=%8&ExamFeeCode=%9&AttendanceFineCode=%10&JournalBatchForHostel=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&JournalBatchTransport=%14&ScholarshipDetailNo=%15&RankDetailNo=%16&LateFeeFineNo=%17&OtherFeeNo=%18&DiscountNo=%19&FeeDiscount=%20&UserID=%21&PortalID=%22&HostalNo=%23&TransportNo=%24&TransferFeeAmount=%25&TransferFeeNoSeries=%26&PaymentTemplateName=%27&PaymentBatchName=%28&ScholarShipTemplate=%29&ScholarShipBatchName=%30&FinancialAidPaymentBank=%31&ReminderPaymentPlan=%32&PaymentPlanBatchName=%33&OtherFeeBatchName=%34&Fin_AidExp_DateFormula=%35&OldPrimaryKey=%36&Delete=%37', Rec."Primary Key", Rec."Course Fee No", HandlingOption(Rec."Installment Scheme"), Rec."No Of Installment", Rec."Installment Charges", Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Fee Invoice No.", Rec."Exam Fee Code", Rec."Attendance Fine Code", Rec."Journal Batch For Hostel", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Journal Batch For Transport", Rec."Scholarship Detail No.", Rec."Rank Detail No.", Rec."Late Fee Fine No.", Rec."Other Fee No.", Rec."Discount No.", Rec."Fee Discount", Rec."User ID", Rec."Portal ID", REc."Hostal No", Rec."Transport No", FORMAT(Rec."Transfer Fee Amount", 0, 1), Rec."Transfer Fee No. Series", Rec."Payment Template Name", Rec."Payment Batch Name", Rec."ScholarShip Template Name", Rec."ScholarShip Batch Name", Rec."Financial Aid Payment Bank", FORMAT(Rec."Reminder Payment Plan"), Rec."Payment Plan Batch Name", Rec."Other Fee Batch Name", rec."Fin. Aid Exp. Date Formula", xRecPrimaryKey, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Fee Setup"-End------------------------------------------------------------------------------------------------

    //"Fee Classification Master"-Start------------------------------------------------------------------------------------------------ 
    [EventSubscriber(ObjectType::Table, 50151, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateFeeclassificationOnInsert(VAR Rec: Record "Fee Classification Master-CS"; RunTrigger: Boolean)
    begin
        FeeClassificationFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50151, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateFeeclassificationOnModify(VAR Rec: Record "Fee Classification Master-CS"; VAR xRec: Record "Fee Classification Master-CS"; RunTrigger: Boolean)
    begin
        FeeClassificationFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50151, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateFeeclassificationOnRename(VAR Rec: Record "Fee Classification Master-CS"; VAR xRec: Record "Fee Classification Master-CS"; RunTrigger: Boolean)
    begin
        FeeClassificationFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50151, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateFeeclassificationOnDelete(VAR Rec: Record "Fee Classification Master-CS"; RunTrigger: Boolean)
    begin
        FeeClassificationFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FeeClassificationFunction(var Rec: Record "Fee Classification Master-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateFeeclassification?Code=%1&Description=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&userid=%5&portaiid=%6&BankAccountNo=%7&OldCode=%8&Delete=%9', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", Rec."Credit Card Bank Account No.", xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Fee Classification Master"-End------------------------------------------------------------------------------------------------ 

    //"Dimension Value"-Start------------------------------------------------------------------------------------------------ 
    [EventSubscriber(ObjectType::Table, 349, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateDimensionValueOnInsert(VAR Rec: Record "Dimension Value"; RunTrigger: Boolean)
    begin
        DimensionValueFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 349, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateDimensionValueOnModify(VAR Rec: Record "Dimension Value"; VAR xRec: Record "Dimension Value"; RunTrigger: Boolean)
    begin
        DimensionValueFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 349, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateDimensionValueOnRename(VAR Rec: Record "Dimension Value"; VAR xRec: Record "Dimension Value"; RunTrigger: Boolean)
    begin
        DimensionValueFunction(Rec, xRec."Dimension Code", xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 349, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateDimensionValueOnDelete(VAR Rec: Record "Dimension Value"; RunTrigger: Boolean)
    begin
        DimensionValueFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure DimensionValueFunction(var Rec: Record "Dimension Value"; xRecDimensionCode: Code[20]; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateDimensionValue?DimensionCode=%1&Code=%2&Name=%3&DimensionValueType=%4&Totaling=%5&Blocked=%6&ConsolidationCode=%7&Indentation=%8&GlobalDimensionNo_=%9&MaptoICDimensionCode=%10&MaptoICDimensionValue=%11&ParentDimension=%12&GlobalDimension1Code=%13&EmailAddress=%14&OldDimensionCode=%15&OldCode=%16&Delete=%17', Rec."Dimension Code", Rec.Code, Rec.Name, HandlingOption(Rec."Dimension Value Type"), Rec.Totaling, HandlingBoolean(Rec.Blocked), Rec."Consolidation Code", Rec.Indentation, Rec."Global Dimension No.", Rec."Map-to IC Dimension Code", Rec."Map-to IC Dimension Value Code", Rec."Parent Dimension", Rec."Global Dimension 1 Code", Rec."Email Address", xRecDimensionCode, xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Dimension Value"-End------------------------------------------------------------------------------------------------ 

    //"Detailed Cust. Ledg. Entry"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 379, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateDetailedCustomerLedgerEntryOnInsert(VAR Rec: Record "Detailed Cust. Ledg. Entry"; RunTrigger: Boolean)
    begin
        DetailedCustLedgEntryFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 379, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateDetailedCustomerLedgerEntryOnModify(VAR Rec: Record "Detailed Cust. Ledg. Entry"; VAR xRec: Record "Detailed Cust. Ledg. Entry"; RunTrigger: Boolean)
    begin
        DetailedCustLedgEntryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 379, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateDetailedCustomerLedgerEntryOnRename(VAR Rec: Record "Detailed Cust. Ledg. Entry"; VAR xRec: Record "Detailed Cust. Ledg. Entry"; RunTrigger: Boolean)
    begin
        DetailedCustLedgEntryFunction(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 379, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateDetailedCustomerLedgerEntryOnDelete(VAR Rec: Record "Detailed Cust. Ledg. Entry"; RunTrigger: Boolean)
    begin
        DetailedCustLedgEntryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure DetailedCustLedgEntryFunction(var Rec: Record "Detailed Cust. Ledg. Entry"; xRecEntryNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateDetailedCustomerLedgerEntry?EntryNo_=%1&CustLedgerEntryNo_=%2&PostingDate=%3&DocumentNo_=%4&Amount=%5&CustomerNo_=%6&CurrencyCode=%7&EnrollmentNo_=%8&CourseCode=%9&OldEntryNo_=%10&Delete=%11', Rec."Entry No.", Rec."Cust. Ledger Entry No.", FORMAT(Rec."Posting Date", 0, 9), Rec."Document No.", FORMAT(Rec.Amount, 0, 1), Rec."Customer No.", Rec."Currency Code", Rec."Enrollment No.", Rec."Course Code", xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Detailed Cust. Ledg. Entry"-End------------------------------------------------------------------------------------------------ 

    //"Cust. Ledger Entry"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerLedgerEntryOnInsert(VAR Rec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    begin
        CustLedgerEntryFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerLedgerEntryOnModify(VAR Rec: Record "Cust. Ledger Entry"; VAR xRec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    begin
        CustLedgerEntryFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerLedgerEntryOnRename(VAR Rec: Record "Cust. Ledger Entry"; VAR xRec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    begin
        CustLedgerEntryFunction(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerLedgerEntryOnDelete(VAR Rec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    begin
        CustLedgerEntryFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure CustLedgerEntryFunction(var Rec: Record "Cust. Ledger Entry"; xRecEntryNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateCustomerLedgerEntry?EntryNo_=%1&CustomerNo_=%2&PostingDate=%3&DocumentType=%4&DocumentNo_=%5&Description=%6&CurrencyCode=%7&CustomerPostingGroup=%8&GlobalDimension1Code=%9&GlobalDimension2Code=%10&SalespersonCode=%11&UserID=%12&SourceCode=%13&OnHold=%14&AppliestoDocType=%15&AppliestoDocNo=%16&Open=%17&DueDate=%18&Pmt_DiscountDate=%19&OriginalPmtDiscPossible=%20&PmtDiscGivenLCY=%21&FeeCode=%22&CourseCode=%23&Semester=%24&AcademicYear=%25&Year=%26&EnrollmentNo_=%27&InstrumentType=%28&Narration=%29&TransactionNumber=%30&ReceiptNo_=%31&ReversalNew=%32&AppliesToRevDocNo=%33&ShowINR=%34&OldEntryNo_=%35&Delete=%36', Rec."Entry No.", Rec."Customer No.", FORMAT(Rec."Posting Date", 0, 9), HandlingOption(Rec."Document Type"), Rec."Document No.", Rec.Description, Rec."Currency Code", Rec."Customer Posting Group", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Salesperson Code", Rec."User ID", Rec."Source Code", Rec."On Hold", HandlingOption(Rec."Applies-to Doc. Type"), Rec."Applies-to Doc. No.", HandlingBoolean(Rec.Open), Format(Rec."Due Date", 0, 9), FORMAT(Rec."Pmt. Discount Date", 0, 9), Rec."Original Pmt. Disc. Possible", Rec."Pmt. Disc. Given (LCY)", Rec."Fee Code", Rec."Course Code", Rec.Semester, Rec."Academic Year", Rec.Year, Rec."Enrollment No.", HandlingOption(Rec."Instrument Type"), Rec.Narration, Rec."Transaction Number", Rec."Receipt No.", HandlingBoolean(Rec."Reversal New"), Rec."Applies To Rev. Doc. No.", HandlingBoolean(Rec."Show INR"), xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Cust. Ledger Entry"-End------------------------------------------------------------------------------------------------ 

    //"Customer Bank Code"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50164, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankCodeOnInsert(VAR Rec: Record "Customer Bank Code-CS"; RunTrigger: Boolean)
    begin
        CustomerBankCodeFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50164, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankCodeOnModify(VAR Rec: Record "Customer Bank Code-CS"; VAR xRec: Record "Customer Bank Code-CS"; RunTrigger: Boolean)
    begin
        CustomerBankCodeFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50164, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankCodeOnRename(VAR Rec: Record "Customer Bank Code-CS"; VAR xRec: Record "Customer Bank Code-CS"; RunTrigger: Boolean)
    begin
        CustomerBankCodeFunction(Rec, xRec.BankCode, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50164, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankCodeOnDelete(VAR Rec: Record "Customer Bank Code-CS"; RunTrigger: Boolean)
    begin
        CustomerBankCodeFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure CustomerBankCodeFunction(var Rec: Record "Customer Bank Code-CS"; xRecBankCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateBankCode?BankCode=%1&BankDesc=%2&userid=%3&Datetime=%4&CreateDate=%5&EffStat=%6&OldBankCode=%7&Delete=%8', Rec.BankCode, Rec.BankDesc, Rec.UserID, FORMAT(Rec.DateTime, 0, 9), FORMAT(Rec."Create Date", 0, 9), Rec.EffStat, xRecBankCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Customer Bank Code"-End------------------------------------------------------------------------------------------------ 

    //"Customer Bank Branch"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50165, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankBranchOnInsert(VAR Rec: Record "Cust Bank Branch-CS"; RunTrigger: Boolean)
    begin
        CustomerBankBranchFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50165, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankBranchOnModify(VAR Rec: Record "Cust Bank Branch-CS"; VAR xRec: Record "Cust Bank Branch-CS"; RunTrigger: Boolean)
    begin
        CustomerBankBranchFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50165, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankBranchOnRename(VAR Rec: Record "Cust Bank Branch-CS"; VAR xRec: Record "Cust Bank Branch-CS"; RunTrigger: Boolean)
    begin
        CustomerBankBranchFunction(Rec, xRec.BranchCode, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50165, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateBankBranchOnDelete(VAR Rec: Record "Cust Bank Branch-CS"; RunTrigger: Boolean)
    begin
        CustomerBankBranchFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure CustomerBankBranchFunction(var Rec: Record "Cust Bank Branch-CS"; xRecBranchCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateBankBranch?BranchCode=%1&BranchName=%2&userid=%3&Datetime=%4&CreateDate=%5&EffStat=%6&OldBranchCode=%7&Delete=%8', Rec.BranchCode, Rec.BranchName, Rec.UserID, FORMAT(Rec.DateTime, 0, 9), FORMAT(Rec."Create Date", 0, 9), Rec.EffStat, xRecBranchCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Customer Bank Branch"-End------------------------------------------------------------------------------------------------ 

    //"Customer"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerOnInsert(VAR Rec: Record Customer; RunTrigger: Boolean)
    begin
        CustomerFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerOnModify(VAR Rec: Record Customer; VAR xRec: Record Customer; RunTrigger: Boolean)
    begin
        CustomerFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerOnRename(VAR Rec: Record Customer; VAR xRec: Record Customer; RunTrigger: Boolean)
    begin
        CustomerFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsertupdateCustomerOnDelete(VAR Rec: Record Customer; RunTrigger: Boolean)
    begin
        CustomerFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure CustomerFunction(var Rec: Record Customer; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insertupdateCustomer?No_=%1&EnrollmentNo_=%2&ApplicationNo_=%3&PayType=%4&CourseCode=%5&Semester=%6&Year=%7&AcademicYear=%8&ConverttoStudent=%9&Category=%10&ParentsIncome=%11&ScholarshipSource=%12&InternalRank=%13&EntranceTestRank=%14&AdmittedYear=%15&CheckManually=%16&FeeGenerated=%17&CertificationCourse=%18&ParentCustomer=%19&BranchTransfer=%20&LateralStudent=%21&Program=%22&PendingForRegistration=%23&CourseCompletionNOC=%24&Section=%25&Batch=%26&RollNo_=%27&FeestoGenerate=%28&Gender=%29&Session=%30&HostelAccomadation=%31&TransportAccomadation=%32&StudentMotherName=%33&TypeOfCourse=%34&FeeClassificationCode=%35&PaymentPlanInstalment=%36&Status=%37&Sibling_SpouseNo=%38&ScholarshipCode=%39&FinancialAidApproved=%40&PaymentPlanApplied=%41&OldNo_=%42&Delete=%43', Rec."No.", Rec."Enrollment No.", Rec."Application No.", HandlingOption(Rec."Pay Type"), Rec."Course Code", Rec.Semester, Rec.Year, Rec."Academic Year", HandlingBoolean(Rec."Convert to Student"), Rec.Category, Rec."Parents Income", Rec."Scholarship Source", Rec."Internal Rank", Rec."Entrance Test Rank", Rec."Admitted Year", HandlingBoolean(Rec."Check Manually"), HandlingBoolean(Rec."Fee Generated"), HandlingBoolean(Rec."Certification Course"), Rec."Parent Customer", HandlingBoolean(Rec."Branch Transfer"), HandlingBoolean(Rec."Lateral Student"), Rec.Program, HandlingBoolean(Rec."Pending For Registration"), HandlingBoolean(Rec."Course Completion NOC"), Rec.Section, Rec.Batch, Rec."Roll No.", HandlingBoolean(Rec."Fees to Generate"), HandlingOption(Rec.Gender), Rec.Session, HandlingBoolean(Rec."Hostel Accomadation"), HandlingBoolean(Rec."Transport Accomadation"), Rec."Student Mother Name", HandlingOption(Rec."Type Of Course"), Rec."Fee Classification Code", Rec."Payment Plan Instalment", Rec.Status, Rec."Sibling/Spouse No.", Rec."Grant Code 1", HandlingBoolean(Rec."Financial Aid Approved"), HandlingBoolean(Rec."Payment Plan Applied"), xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Customer"-End------------------------------------------------------------------------------------------------ 

    //"Fee Course Line"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50158, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeLineOnInsert(VAR Rec: Record "Fee Course Line-CS"; RunTrigger: Boolean)
    begin
        FeeCourseLineFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50158, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeLineOnModify(VAR Rec: Record "Fee Course Line-CS"; VAR xRec: Record "Fee Course Line-CS"; RunTrigger: Boolean)
    begin
        FeeCourseLineFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50158, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeLineOnRename(VAR Rec: Record "Fee Course Line-CS"; VAR xRec: Record "Fee Course Line-CS"; RunTrigger: Boolean)
    begin
        FeeCourseLineFunction(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50158, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeLineOnDelete(VAR Rec: Record "Fee Course Line-CS"; RunTrigger: Boolean)
    begin
        FeeCourseLineFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FeeCourseLineFunction(var Rec: Record "Fee Course Line-CS"; xRecDocumentNo: Code[20]; xRecLineNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insupdateCourseFeeLine?DocumentNo_=%1&LineNo_=%2&FeeCode=%3&GroupCode=%4&Amount=%5&Description=%6&FeesType=%7&Installment=%8&NoOfInstallment=%9&InstallmentCharges=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&StartDate=%13&LastDate=%14&LateFeeAmountForCompound=%15&LateFeeAmount=%16&G_LAcountforfine=%17&CourseCode=%18&Semester=%19&Year=%20&AcademicYear=%21&FixedAmount=%22&AdmittedYear=%23&YearPart=%24&FeeClassificationCode=%25&FeeGroup=%26&OldDocumentNo_=%27&OldLineNo_=%28&Delete=%29', Rec."Document No.", Rec."Line No.", Rec."Fee Code", Rec."Group Code", FORMAT(Rec.Amount, 0, 1), Rec.Description, Rec."Fees Type", HandlingBoolean(Rec.Installment), Rec."No Of Installment", Rec."Installment Charges", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Format(Rec."Start Date", 0, 9), FORMAT(Rec."Last Date", 0, 9), FORMAT(Rec."Late Fee Amount For Compound %", 0, 1), FORMAT(Rec."Late Fee Amount %", 0, 1), Rec."G/L Acount for fine", Rec."Course Code", Rec.Semester, Rec.Year, Rec."Academic Year", FORMAT(Rec."Fixed Amount", 0, 1), Rec."Admitted Year", HandlingOption(Rec."Year Part"), Rec."Fee Classification Code", HandlingOption(Rec."Fee Group"), xRecDocumentNo, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Fee Course Line"-End------------------------------------------------------------------------------------------------ 

    //"Fee Course Header"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50157, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeHeadOnInsert(VAR Rec: Record "Fee Course Head-CS"; RunTrigger: Boolean)
    begin
        FeeCourseHeaderFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50157, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeHeadOnModify(VAR Rec: Record "Fee Course Head-CS"; VAR xRec: Record "Fee Course Head-CS"; RunTrigger: Boolean)
    begin
        FeeCourseHeaderFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50157, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeHeadOnRename(VAR Rec: Record "Fee Course Head-CS"; VAR xRec: Record "Fee Course Head-CS"; RunTrigger: Boolean)
    begin
        FeeCourseHeaderFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50157, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalinsupdateCourseFeeHeadOnDelete(VAR Rec: Record "Fee Course Head-CS"; RunTrigger: Boolean)
    begin
        FeeCourseHeaderFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure FeeCourseHeaderFunction(var Rec: Record "Fee Course Head-CS"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/insupdateCourseFeeHead?No_=%1&CourseCode=%2&Semester=%3&FeeClassificationCode=%4&NoOfInstallment=%5&InstallmentCharges=%6&No_Series=%7&AcademicYear=%8&GlobalDimension1Code=%9&GlobalDimension2Code=%10&DueDate=%11&FixedAmount=%12&G_LAccountforfine=%13&TypeOfCourse=%14&Year=%15&CourseName=%16&AdmittedYear=%17&LateFine=%18&StartDate=%19&EndDate=%20&Category=%21&OtherFees=%22&Program=%23&OldNo_=%24&Delete=%25', Rec."No.", Rec."Course Code", Rec.Semester, Rec."Fee Classification Code", Rec."No Of Installment", Rec."Installment Charges", rEC."No.Series", Rec."Academic Year", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", FORMAT(Rec."Due Date", 0, 9), FORMAT(Rec."Fixed Amount", 0, 1), Rec."G/L Account for fine", HandlingOption(Rec."Type Of Course"), Rec.Year, Rec."Course Name", Rec."Admitted Year", Rec."Late Fine %", FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."End Date", 0, 9), Rec.Category, HandlingBoolean(Rec."Other Fees"), Rec.Program, xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Fee Course Header"-End------------------------------------------------------------------------------------------------ 

    //"Hold Status Ledger"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50392, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HoldStatusLedgerOnInsert(VAR Rec: Record "Hold Status Ledger"; RunTrigger: Boolean)
    begin
        HoldStatusLedgerFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50392, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HoldStatusLedgerOnModify(VAR Rec: Record "Hold Status Ledger"; VAR xRec: Record "Hold Status Ledger"; RunTrigger: Boolean)
    begin
        HoldStatusLedgerFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50392, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HoldStatusLedgerOnRename(VAR Rec: Record "Hold Status Ledger"; VAR xRec: Record "Hold Status Ledger"; RunTrigger: Boolean)
    begin
        HoldStatusLedgerFunction(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50392, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HoldStatusLedgerOnDelete(VAR Rec: Record "Hold Status Ledger"; RunTrigger: Boolean)
    begin
        HoldStatusLedgerFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure HoldStatusLedgerFunction(var Rec: Record "Hold Status Ledger"; xRecEntryNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HoldStatusLedger?EntryNo=%1&EntryDate=%2&EntryTime=%3&StudentNo=%4&StudentName=%5&Semester=%6&AcademicYear=%7&AdmittedYear=%8&HoldCode=%9&HoldDescription=%10&HoldType=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&Status=%14&UserID=%15&TableID=%16&TableCaption=%17&OldEntryNo=%18&Delete=%19', Rec."Entry No.", FORMAT(Rec."Entry Date", 0, 9), FORMAT(Rec."Entry Time"), Rec."Student No.", Rec."Student Name", Rec.Semester, Rec."Academic Year", Rec."Admitted Year", Rec."Hold Code", Rec."Hold Description", HandlingOption(Rec."Hold Type"), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec.Status), Rec."User ID", Rec."Table ID", Rec."Table Caption", xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Hold Status Ledger"-End------------------------------------------------------------------------------------------------ 

    //"Student Hold"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50364, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentHoldOnInsert(VAR Rec: Record "Student Hold"; RunTrigger: Boolean)
    begin
        StudentHoldFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50364, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentHoldOnModify(VAR Rec: Record "Student Hold"; VAR xRec: Record "Student Hold"; RunTrigger: Boolean)
    begin
        StudentHoldFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50364, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentHoldOnRename(VAR Rec: Record "Student Hold"; VAR xRec: Record "Student Hold"; RunTrigger: Boolean)
    begin
        StudentHoldFunction(Rec, xRec."Hold Code", xRec."Global Dimension 1 Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50364, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentHoldOnDelete(VAR Rec: Record "Student Hold"; RunTrigger: Boolean)
    begin
        StudentHoldFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentHoldFunction(var Rec: Record "Student Hold"; xRecHoldCode: Code[20]; xRecGlobalDimension1Code: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentHold?HoldCode=%1&HoldDescription=%2&HoldType=%3&PotalLoginRestriction=%4&ClinicalRotation=%5&TranscriptPrint=%6&Progression=%7&Billing=%8&GlobalDimension1Code=%9&GlobalDimension2Code=%10&Inserted=%11&Updated=%12&CreatedBy=%13&CreatedOn=%14&ModifiedBy=%15&ModifiedOn=%16&OldHoldCode=%17&OldGlobalDimension1Code=%18&Delete=%19', Rec."Hold Code", Rec."Hold Description", HandlingOption(Rec."Hold Type"), HandlingBoolean(Rec."Potal Login Restriction"), HandlingBoolean(Rec."Clinical Rotation"), HandlingBoolean(Rec."Transcript Print"), HandlingBoolean(Rec.Progression), HandlingBoolean(Rec.Billing), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), xRecHoldCode, xRecGlobalDimension1Code, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Student Hold"-End------------------------------------------------------------------------------------------------ 

    //"Withdrawal Student"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50005, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalStudentOnInsert(VAR Rec: Record "Withdrawal Student-CS"; RunTrigger: Boolean)
    begin
        WithdrawalStudentFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50005, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalStudentOnModify(VAR Rec: Record "Withdrawal Student-CS"; VAR xRec: Record "Withdrawal Student-CS"; RunTrigger: Boolean)
    begin
        IF xRec.HelloSign_Confirmed = Rec.HelloSign_Confirmed then //CSPL-00307-HelloSign_BUG
            WithdrawalStudentFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50005, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalStudentOnRename(VAR Rec: Record "Withdrawal Student-CS"; VAR xRec: Record "Withdrawal Student-CS"; RunTrigger: Boolean)
    begin
        WithdrawalStudentFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50005, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalStudentOnDelete(VAR Rec: Record "Withdrawal Student-CS"; RunTrigger: Boolean)
    begin
        WithdrawalStudentFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure WithdrawalStudentFunction(var Rec: Record "Withdrawal Student-CS"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_WithdrawalStudent?No=%1&studentno_=%2&course=%3&Semester=%4&Section=%5&AcademicYear=%6&NoSeries=%7&TCIssued=%8&ReasonforLeaving=%9&GlobalDimension1Code=%10&GlobalDimension2Code=%11&TypeOfCourse=%12&FinalYearsCourse=%13&WithdrawalStatus=%14&CourseName=%15&Updated=%16&BankAccHolderName=%17&BankAccountNoIBAN_Number=%18&BankName=%19&IFSCCodeNumberSwiftCode=%20&Refund=%21&TypeofWithdrawal=%22&StudentName=%23&UserID=%24&PortalID=%25&EnrolmentNo_=%26&ApplicationDate=%27&ReasonCode=%28&Term=%29&OldNo=%30&Delete=%31', Rec."No.", Rec."Student No.", Rec.Course, Rec.Semester, Rec.Section, Rec."Academic Year", Rec."No. Series", HandlingBoolean(rec."TC Issued"), Rec."Reason for Leaving", rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", HandlingOption(Rec."Withdrawal Status"), Rec."Course Name", HandlingBoolean(Rec.Updated), Rec."Bank Acc Holder Name", Rec."Bank Account No/IBAN Number", Rec."Bank Name", Rec."IFSC Code Number/Swift Code", HandlingBoolean(Rec.Refund), HandlingOption(Rec."Type of Withdrawal"), Rec."Student Name", Rec."User ID", Rec."Portal ID", Rec."Enrolment No.", FORMAT(Rec."Application Date", 0, 9), Rec."Reason Code", HandlingOption(Rec.Term), xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Withdrawal Student"-End------------------------------------------------------------------------------------------------ 

    //"Withdrawal Approvals"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50390, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalApprovalsOnInsert(VAR Rec: Record "Withdrawal Approvals"; RunTrigger: Boolean)
    begin
        WithdrawalApprovalsFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50390, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalApprovalsOnModify(VAR Rec: Record "Withdrawal Approvals"; VAR xRec: Record "Withdrawal Approvals"; RunTrigger: Boolean)
    begin
        WithdrawalApprovalsFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50390, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalApprovalsOnRename(VAR Rec: Record "Withdrawal Approvals"; VAR xRec: Record "Withdrawal Approvals"; RunTrigger: Boolean)
    begin
        WithdrawalApprovalsFunction(Rec, xrec."Student No.", xRec."Approved for Department", xRec."Withdrawal No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50390, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_WithdrawalApprovalsOnDelete(VAR Rec: Record "Withdrawal Approvals"; RunTrigger: Boolean)
    begin
        WithdrawalApprovalsFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure WithdrawalApprovalsFunction(var Rec: Record "Withdrawal Approvals"; xRecStudentNo: Code[20]; xRecApprovedforDepartment: Code[20]; xRecOldWithdrawalNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_WithdrawalApprovals?StudentNo=%1&ApprovedforDepartment=%2&StudentName=%3&Status=%4&ApprovdBy=%5&Course=%6&CourseName=%7&RejectedBy=%8&ApprovedOn=%9&RejectionRemark=%10&RejectedOn=%11&DepartmentName=%12&HODApproved_RejectedDate=%13&HODRemark=%14&ADApproval=%15&ADID=%16&ADApproved_RejectedDate=%17&ADRemark=%18&FormType=%19&WithdrawalNo=%20&TypeofWithdrawal=%21&FinalApproval=%22&ReasonCode=%23&ReasonforLeaving=%24&EnrolmentNo_=%25&WaiverCode=%26&WaiverDescription=%27&WaiverAmount=%28&ApprovedAmount=%29&Semester=%30&AcademicYear=%31&ApprovedInDays=%32&Waivercalculationallowed=%33&Waivercalculated=%34&GlobalDimension1Code=%35&GlobalDimension2Code=%36&OldStudentNo=%37&OldapprovedforDepartment=%38&OldWithdrawalNo=%39&Delete=%40', Rec."Student No.", Rec."Approved for Department", Rec."Student Name", HandlingOption(Rec.Status), Rec."Approved By", Rec.Course, Rec."Course Name", FORMAT(Rec."Rejected By"), FORMAT(Rec."Approved On", 0, 9), Rec."Rejection Remark", FORMAT(Rec."Rejected On", 0, 9), Rec."Department Name", FORMAT(Rec."HOD Approved/Rejected Date", 0, 9), Rec."HOD Remark", HandlingBoolean(Rec."AD Approval"), Rec."AD ID", FORMAT(Rec."AD Approved/Rejected Date", 0, 9), rec."AD Remark", FORMAT(Rec."Form Type"), Rec."Withdrawal No.", HandlingOption(Rec."Type of Withdrawal"), HandlingBoolean(Rec."Final Approval"), Rec."Reason Code", Rec."Reason for Leaving", Rec."Enrolment No.", Rec."Waiver Code", Rec."Waiver Description", FORMAT(Rec."Waiver Amount", 0, 1), FORMAT(Rec."Approved Amount", 0, 1), Rec.Semester, Rec."Academic Year", Rec."Approved In Days", HandlingBoolean(Rec."Waiver Calculation Allowed"), HandlingBoolean(Rec."Waiver Calculated"), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", xRecStudentNo, xRecApprovedforDepartment, xRecOldWithdrawalNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Withdrawal Approvals"-End------------------------------------------------------------------------------------------------ 

    //"Vendor"-Start------------------------------------------------------------------------------------------------ 
    [EventSubscriber(ObjectType::Table, 23, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Vendor_MasterOnInsert(VAR Rec: Record "Vendor"; RunTrigger: Boolean)
    begin
        VendorFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Vendor_MasterOnModify(VAR Rec: Record "Vendor"; VAR xRec: Record "Vendor"; RunTrigger: Boolean)
    begin
        VendorFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Vendor_MasterOnRename(VAR Rec: Record "Vendor"; VAR xRec: Record "Vendor"; RunTrigger: Boolean)
    begin
        VendorFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Vendor_MasterOnDelete(VAR Rec: Record "Vendor"; RunTrigger: Boolean)
    begin
        VendorFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure VendorFunction(var Rec: Record "Vendor"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Vendor_Master?No_=%1&VendorSubType=%2&Name=%3&SearchName=%4&Name2=%5&Address=%6&Address2=%7&City=%8&Contact=%9&PhoneNo_=%10&VendorPostingGroup=%11&Blocked=%12&Gen_Bus_PostingGroup=%13&EMail=%14&FM1_IM1RotationApplicable=%15&PrefferedforGHTStudents=%16&PrefferedforInternational=%17&NonAffiliatedHospital=%18&LCMESponsored=%19&Accreditation=%20&Latitude=%21&Longitude=%22&ACGMENo_=%23&Residency=%24&SystemRef_No_=%25&SponsoringInstitution=%26&SponsoredPrograms=%27&DMEName=%28&DMEPhoneNo_=%29&DMEEmail=%30&SupervisingPhysicianName=%31&SuperviserPhoneNo_=%32&SuperviserEmail=%33&OldNo_=%34&Delete=%35', Rec."No.", HandlingOption(Rec."Vendor Sub Type"), Rec.Name, Rec."Search Name", Rec."Name 2", Rec.Address, Rec."Address 2", Rec.City, Rec.Contact, Rec."Phone No.", Rec."Vendor Posting Group", HandlingOption(Rec.Blocked), Rec."Gen. Bus. Posting Group", Rec."E-Mail", HandlingBoolean(Rec."FM1/IM1 Rotation Applicable"), HandlingBoolean(Rec."Preffered for GHT Students"), HandlingBoolean(Rec."Preffered for International"), HandlingBoolean(Rec."Non-Affiliated Hospital"), HandlingBoolean(Rec."LCME Sponsored"), HandlingOption(Rec.Accreditation), Rec.Latitude, Rec.Longitude, Rec."ACGME No.", HandlingBoolean(Rec.Residency), Rec."System Ref. No.", Rec."Sponsoring Institution", Rec."Sponsored Programs", Rec."DME Name", Rec."DME Phone No.", Rec."DME Email", Rec."Supervising Physician Name", Rec."Superviser Phone No.", Rec."Superviser Email", xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Vendor"-End------------------------------------------------------------------------------------------------ 

    //"Student Status"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50391, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentStatusOnInsert(VAR Rec: Record "Student Status"; RunTrigger: Boolean)
    begin
        StudentStatusFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50391, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentStatusOnModify(VAR Rec: Record "Student Status"; VAR xRec: Record "Student Status"; RunTrigger: Boolean)
    begin
        StudentStatusFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50391, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentStatusOnRename(VAR Rec: Record "Student Status"; VAR xRec: Record "Student Status"; RunTrigger: Boolean)
    begin
        StudentStatusFunction(Rec, xRec.Code, xRec."Global Dimension 1 Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50391, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentStatusOnDelete(VAR Rec: Record "Student Status"; RunTrigger: Boolean)
    begin
        StudentStatusFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentStatusFunction(var Rec: Record "Student Status"; xRecCode: Code[20]; xRecGlobalDimension1Code: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentStatus?Code=%1&Description=%2&Status=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&Blocked=%6&OldCode=%7&OldGlobalDimension1Code=%8&Delete=%9', Rec.Code, Rec.Description, HandlingOption(Rec.Status), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Blocked), xRecCode, xRecGlobalDimension1Code, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Student Status"-End------------------------------------------------------------------------------------------------ 

    //"Student Room Wise Inventory"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50352, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentRoomWiseInventoryOnInsert(VAR Rec: Record "Student Room Wise Inventory"; RunTrigger: Boolean)
    begin
        StudentRoomWiseInventoryFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50352, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentRoomWiseInventoryOnModify(VAR Rec: Record "Student Room Wise Inventory"; VAR xRec: Record "Student Room Wise Inventory"; RunTrigger: Boolean)
    begin
        StudentRoomWiseInventoryFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50352, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentRoomWiseInventoryOnRename(VAR Rec: Record "Student Room Wise Inventory"; VAR xRec: Record "Student Room Wise Inventory"; RunTrigger: Boolean)
    begin
        StudentRoomWiseInventoryFunction(Rec, xRec."Application No.", xRec."Item No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50352, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentRoomWiseInventoryOnDelete(VAR Rec: Record "Student Room Wise Inventory"; RunTrigger: Boolean)
    begin
        StudentRoomWiseInventoryFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentRoomWiseInventoryFunction(var Rec: Record "Student Room Wise Inventory"; xRecApplicationNo: Code[20]; xRecItemNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentRoomWiseInventory?ApplicationNo=%1&ItemNo=%2&HostelID=%3&RoomNo=%4&StudentNo=%5&EnrolmentNo=%6&LedgerEntryNo=%7&ItemName=%8&QuantityAllotted=%9&QuantityVerifiedAlloment=%10&QuantityVerifiedVacate=%11&VerifiedAllomentDate=%12&VerifiedVacateDate=%13&Remarks=%14&GlobalDimension1Code=%15&GlobalDimension2Code=%16&CreatedBy=%17&CreatedOn=%18&ModifiedBy=%19&ModifiedOn=%20&Updated=%21&Inserted=%22&StudentName=%23&oldApplicationNo=%24&OldItemNo=%25&Delete=%26', Rec."Application No.", Rec."Item No.", Rec."Housing ID", Rec."Room No.", Rec."Student No.", Rec."Enrolment No.", Rec."Ledger Entry No.", Rec."Item Name", Rec."Quantity Allotted", HandlingBoolean(Rec."Quantity Verified Alloment"), HandlingBoolean(Rec."Quantity Verified Vacate"), FORMAT(Rec."Verified Alloment Date", 0, 9), FORMAT(Rec."Verified Vacate Date", 0, 9), Rec.Remarks, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), Rec."Student Name", xRecApplicationNo, xRecItemNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Student Room Wise Inventory"-End------------------------------------------------------------------------------------------------ 

    //"Student Document Attachment"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50405, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSaveUpdateStudentDocumentUploadOnInsert(VAR Rec: Record "Student Document Attachment"; RunTrigger: Boolean)
    begin
        StudentDocumentAttachmentFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50405, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSaveUpdateStudentDocumentUploadOnModify(VAR Rec: Record "Student Document Attachment"; VAR xRec: Record "Student Document Attachment"; RunTrigger: Boolean)
    begin
        StudentDocumentAttachmentFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50405, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSaveUpdateStudentDocumentUploadOnRename(VAR Rec: Record "Student Document Attachment"; VAR xRec: Record "Student Document Attachment"; RunTrigger: Boolean)
    begin
        StudentDocumentAttachmentFunction(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50405, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSaveUpdateStudentDocumentUploadOnDelete(VAR Rec: Record "Student Document Attachment"; RunTrigger: Boolean)
    begin
        StudentDocumentAttachmentFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentDocumentAttachmentFunction(var Rec: Record "Student Document Attachment"; xRecEntryNo: text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        IF Rec."Transaction No." = '' then
            exit;
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentDocumentUpload?EntryNo=%1&DocumentCategory=%2&DocumentSubCategory=%3&TransactionNo=%4&DocumentID=%5&StudentNo=%6&EnrolmentNo=%7&AcademicYear=%8&Semester=%9&Term=%10&GlobalDimension1Code=%11&FileName=%12&FileType=%13&UploadedSource=%14&DocumentStatus=%15&UploadedBy=%16&UploadedOn=%17&DocumentUpdateDate=%18&StatusUpdatedBy=%19&StatusUpdatedDate=%20&DocumentDue=%21&ExpiryDate=%22&SLcMDocumentNo=%23&SubjectCode=%24&Docupath=%25&FileData=%26&hellosignid=%27&ValidityStartDate=%28&OldEntryNo=%29&Delete=%30', Rec."Entry No.", Rec."Document Category", Rec."Document Sub Category", Rec."Transaction No.", Rec."Document ID", Rec."Student No.", Rec."Enrolment No.", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), Rec."Global Dimension 1 Code", Rec."File Name", Rec."File Type", HandlingOption(Rec."Uploaded Source"), HandlingOption(Rec."Document Status"), Rec."Uploaded By", Format(Rec."Uploaded On", 0, 9), Format(Rec."Document Update Date", 0, 9), Rec."Status Updated By", Format(Rec."Status Updated Date", 0, 9), Format(Rec."Document Due", 0, 9), Format(Rec."Expiry Date", 0, 9), Rec."SLcM Document No", Rec."Subject Code", '', '', '', Rec."Validity Start Date", xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Student Document Attachment"-End------------------------------------------------------------------------------------------------ 


    //"Main Student Subject"-Start------------------------------------------------------------------------------------------------ 

    //"Main Student Subject"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentCourse_SubjectMappingOnInsert(VAR Rec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    begin
        MainStudentSubjectFunction(Rec, '', '', '', '', '', '', 0D, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentCourse_SubjectMappingOnModify(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    begin
        MainStudentSubjectFunction(Rec, '', '', '', '', '', '', 0D, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentCourse_SubjectMappingOnRename(VAR Rec: Record "Main Student Subject-CS"; VAR xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    begin
        MainStudentSubjectFunction(Rec, xRec."Student No.", xrec.Course, xrec.Semester, xRec."Academic Year", xRec."Subject Code", xRec.Section, xRec."Start Date", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentCourse_SubjectMappingOnDelete(VAR Rec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    begin
        MainStudentSubjectFunction(Rec, '', '', '', '', '', '', 0D, 1, 'OnAfterDeleteEvent');
    end;

    procedure MainStudentSubjectFunction(var Rec: Record "Main Student Subject-CS"; xRecStudentNo: Code[20]; xRecCourse: Code[20]; xRecSemester: Code[10]; xRecAcademicYear: Code[20]; xRecSubjectCode: Code[20]; xRecSection: Code[10]; xRecStartDate: Date; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentCourse_SubjectMapping?StudentNo=%1&Course=%2&Semester=%3&AcademicYear=%4&SubjectCode=%5&Section=%6&Description=%7&SubjectType=%8&Completed=%9&Credit=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&TypeOfCourse=%13&FinalYearsCourse=%14&EnrollmentNo=%15&Group=%16&Batch=%17&Inactive=%18&StudentName=%19&Year=%20&Grade=%21&InternalObtained=%22&ExternalObtained=%23&GraceMarks=%24&TotalInternal=%25&ReRegister=%26&GraceCriteria=%27&RollNo=%28&Publish=%29&SubjectClass=%30&ReRegistration=%31&ReApply=%32&AttendancePercentage=%33&AssignmentMarks=%34&ProgramOpenElectiveTemp=%35&UserID=%36&PortalID=%37&ExamFee=%38&InternalMaximum=%39&ExternalMaximum=%40&ApplicableAttendanceper=%41&Total=%42&Updated=%43&ElectiveGroupCode=%44&UFM=%45&Dropped=%46&CreditEarned=%47&CreditGradePointsEarned=%48&CurrencyCode=%49&SelectedSubject=%50&SelectedSubName=%51&ReAppearExternalMarks=%52&ReAppearTotal=%53&ReAppearResult=%54&Points=%55&AttendanceasonDate=%56&MaximumMark=%57&PercentageObtained=%58&Specilization=%59&Detained=%60&AttendanceDetail=%61&Absent=%62&MainExamResultUpdated=%63&Result=%64&AttendanceType=%65&CBCSBatch=%66&RegistrationDate=%67&ReRegistrationDate=%68&GradeChangeType=%69&Graduation=%70&InternalMarksUpdated=%71&ExternalMarksUpdated=%72&ActualSemester=%73&ActualYear=%74&ActualAcademicYear=%75&ActualSubjectCode=%76&ActualSubjectDescription=%77&MakeUpExamination=%78&Revaluation1=%79&Revaluation2=%80&SpecialExam=%81&ReRegistrationExamOnly=%82&TotalClassHeld=%83&TotalAttendanceTaken=%84&PresentCount=%85&AbsentCount=%86&SubjectDrop=%87&SubjectPassDate=%88&PreviousDetainedStatus=%89&CurrentSession=%90&MobileInsert=%91&MobileUpdate=%92&MobileResult=%93&PreviousSession=%94&ActualSession=%95&SubjectGroup=%96&Examination=%97&Level=%98&LevelDescription=%99&StartDate=%100&ExpectedEndDate=%101&EndDate=%102&Term=%103&Sequence=%104&TC=%105&Inserted=%106&OriginalStudentNo_=%107&GradeConfirmed=%108&TermSequence=%109&NonDegree=%110&ModifiedOn=%111&ModifiedBy=%112&SemesterBreak=%113&GradeBookNo_=%114&Recommendation=%115&_Range=%116&SmallGroup_Section=%117&LabGroup=%118&OldStudentNo=%119&OldCourse=%120&OldSemester=%121&OldAcademicYear=%122&OldSubjectCode=%123&OldSection=%124&OldStartDate=%125&Delete=%126', Rec."Student No.", Rec.Course, Rec.Semester, Rec."Academic Year", Rec."Subject Code", Rec.Section, Rec.Description, Rec."Subject Type", HandlingBoolean(Rec.Completed), Rec.Credit, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec."Enrollment No", Rec.Group, Rec.Batch, HandlingBoolean(Rec.Inactive), Rec."Student Name", Rec.Year, Rec.Grade, Rec."Internal Mark", Rec."External Mark", Rec."Grace Marks", Rec."Total Internal", HandlingBoolean(Rec."Re- Register"), HandlingOption(Rec."Grace Criteria"), Rec."Roll No.", HandlingBoolean(Rec.Publish), Rec."Subject Class", HandlingBoolean(Rec."Re-Registration"), HandlingBoolean(Rec."Re-Apply"), Rec."Attendance Percentage", Rec."Assignment Marks", HandlingOption(Rec."Program/Open Elective Temp"), Rec."User ID", Rec."Portal ID", Rec."Exam Fee", Rec."Internal Maximum", Rec."External Maximum", Rec."Applicable Attendance per", Rec.Total, HandlingBoolean(Rec.Updated), Rec."Elective Group Code", HandlingBoolean(Rec.UFM), HandlingBoolean(Rec.Dropped), Rec."Credit Earned", Rec."Credit Grade Points Earned", Rec."Currency Code", Rec."Selected Subject", Rec."Selected Sub. Name", Rec."Re-Appear External Marks", Rec."Re-Appear Total", Rec."Re-Appear Result", Rec.Points, FORMAT(Rec."Attendance % as on Date", 0, 9), Rec."Maximum Mark", Rec."Percentage Obtained", Rec.Specilization, HandlingBoolean(Rec.Detained), Rec."Attendance Detail", HandlingBoolean(Rec.Absent), HandlingBoolean(Rec."Main Exam Result Updated"), HandlingOption(Rec.Result), HandlingOption(Rec."Attendance Type"), Rec."CBCS Batch", FORMAT(Rec."Registration Date", 0, 9), FORMAT(Rec."Re-Registration Date", 0, 9), HandlingOption(Rec."Grade Change Type"), Rec.Graduation, HandlingBoolean(Rec."Internal Marks Updated"), HandlingBoolean(Rec."External Marks Updated"), Rec."Actual Semester", Rec."Actual Year", Rec."Actual Academic Year", Rec."Actual Subject Code", Rec."Actual Subject Description", HandlingBoolean(Rec."Make Up Examination"), HandlingBoolean(Rec.Revaluation1), HandlingBoolean(Rec.Revaluation2), HandlingBoolean(Rec."Special Exam"), HandlingBoolean(Rec."Re-Registration Exam Only"), Rec."Total Class Held", Rec."Total Attendance Taken", Rec."Present Count", Rec."Absent Count", HandlingBoolean(Rec."Subject Drop"), FORMAT(Rec."Subject Pass Date", 0, 9), HandlingBoolean(Rec."Previous Detained Status"), Rec."Current Session", HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), HandlingBoolean(Rec."Mobile Result"), Rec."Previous Session", Rec."Actual Session", Rec."Subject Group", HandlingBoolean(Rec.Examination), Rec.Level, HandlingOption(Rec."Level Description"), Format(Rec."Start Date", 0, 9), Format(Rec."Expected End Date", 0, 9), Format(Rec."End Date", 0, 9), HandlingOption(Rec.Term), Rec.Sequence, HandlingBoolean(Rec.TC), HandlingBoolean(Rec.Inserted), Rec."Original Student No.", HandlingBoolean(rec."Grade Confirmed"), Rec."Term Sequence", HandlingBoolean(Rec."Non Degree"), FORMAT(Rec."Modified On", 0, 9), Rec."Modified By", Rec."Semester Break", Rec."Grade Book No.", Rec.Recommendation, Rec."% Range", Rec."Small Group / Section", Rec."Lab Group", xRecStudentNo, xRecCourse, xRecSemester, xRecAcademicYear, xRecSubjectCode, xRecSection, Format(XRecStartDate, 0, 9), DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Main Student Subject"-End------------------------------------------------------------------------------------------------ 

    //"Student Wise Holds"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50365, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Wise_HoldOnInsert(VAR Rec: Record "Student Wise Holds"; RunTrigger: Boolean)
    begin
        StudentWiseHoldsFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50365, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Wise_HoldOnModify(VAR Rec: Record "Student Wise Holds"; VAR xRec: Record "Student Wise Holds"; RunTrigger: Boolean)
    begin
        StudentWiseHoldsFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50365, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Wise_HoldOnRename(VAR Rec: Record "Student Wise Holds"; VAR xRec: Record "Student Wise Holds"; RunTrigger: Boolean)
    begin
        StudentWiseHoldsFunction(Rec, xRec."Student No.", xRec."Hold Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50365, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Wise_HoldOnDelete(VAR Rec: Record "Student Wise Holds"; RunTrigger: Boolean)
    begin
        StudentWiseHoldsFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentWiseHoldsFunction(var Rec: Record "Student Wise Holds"; xRecStudentNo: Code[20]; xRecHoldCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Student_Wise_Hold?StudentNo=%1&StudentName=%2&Semester=%3&AcademicYear=%4&AdmittedYear=%5&HoldCode=%6&HoldDescription=%7&HoldType=%8&PotalLoginRestriction=%9&ClinicalRotation=%10&TranscriptPrint=%11&Progression=%12&Billing=%13&GlobalDimension1Code=%14&GlobalDimension2Code=%15&Status=%16&Inserted=%17&Updated=%18&CreatedBy=%19&CreatedOn=%20&ModifiedBy=%21&ModifiedOn=%22&Signoff=%23&GroupCode=%24&OldStudentNo=%25&OldHoldCode=%26&Delete=%27', Rec."Student No.", Rec."Student Name", Rec.Semester, Rec."Academic Year", Rec."Admitted Year", Rec."Hold Code", Rec."Hold Description", HandlingOption(Rec."Hold Type"), HandlingBoolean(Rec."Potal Login Restriction"), HandlingBoolean(Rec."Clinical Rotation"), HandlingBoolean(Rec."Transcript Print"), HandlingBoolean(Rec.Progression), HandlingBoolean(Rec.Billing), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec.Status), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec."Sign-off"), Rec."Group Code", xRecStudentNo, xRecHoldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Student Wise Holds"-End------------------------------------------------------------------------------------------------ 

    //"Roster Scheduling Header"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50343, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_HeaderOnInsert(VAR Rec: Record "Roster Scheduling Header"; RunTrigger: Boolean)
    begin
        RosterSchedulingHeaderFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50343, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_HeaderOnModify(VAR Rec: Record "Roster Scheduling Header"; VAR xRec: Record "Roster Scheduling Header"; RunTrigger: Boolean)
    begin
        RosterSchedulingHeaderFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50343, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_HeaderOnRename(VAR Rec: Record "Roster Scheduling Header"; VAR xRec: Record "Roster Scheduling Header"; RunTrigger: Boolean)
    begin
        RosterSchedulingHeaderFunction(Rec, xRec."Rotation ID", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50343, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Roster_Scheduling_HeaderOnDelete(VAR Rec: Record "Roster Scheduling Header"; RunTrigger: Boolean)
    begin
        RosterSchedulingHeaderFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RosterSchedulingHeaderFunction(var Rec: Record "Roster Scheduling Header"; xRecRotationID: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Roster_Scheduling_Header?RotationID=%1&AcademicYear=%2&Semester=%3&EntryType=%4&ClerkshipType=%5&SubjectCode=%6&SubjectDescription=%7&RotationDescription=%8&SubjectType=%9&StartDate=%10&No_ofWeeks=%11&EndDate=%12&No_ofStudents=%13&GlobalDimension1Code=%14&GlobalDimension2Code=%15&Status=%16&NoSeries=%17&systemId=%18&OldRotationID=%19&Delete=%20', Rec."Rotation ID", Rec."Academic Year", Rec.Semester, HandlingOption(Rec."Entry Type"), HandlingOption(Rec."Clerkship Type"), Rec."Course Code", Rec."Course Description", Rec."Rotation Description", HandlingOption(Rec."Course Type"), FORMAT(Rec."Start Date", 0, 9), Rec."No. of Weeks", FORMAT(Rec."End Date", 0, 9), Rec."No. of Students", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec.Status), Rec."No. Series", Rec.SystemId, xRecRotationID, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Roster Scheduling Header"-End------------------------------------------------------------------------------------------------ 

    //"Room Wise Bed"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50333, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomWiseBedOnInsert(VAR Rec: Record "Room Wise Bed"; RunTrigger: Boolean)
    begin
        RoomWiseBedFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent');
    end;


    [EventSubscriber(ObjectType::Table, 50333, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomWiseBedOnModify(VAR Rec: Record "Room Wise Bed"; VAR xRec: Record "Room Wise Bed"; RunTrigger: Boolean)
    begin
        RoomWiseBedFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50333, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomWiseBedOnRename(VAR Rec: Record "Room Wise Bed"; VAR xRec: Record "Room Wise Bed"; RunTrigger: Boolean)
    begin
        RoomWiseBedFunction(Rec, xRec."Housing ID", xRec."Room No.", xRec."Bed No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50333, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomWiseBedOnDelete(VAR Rec: Record "Room Wise Bed"; RunTrigger: Boolean)
    begin
        RoomWiseBedFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RoomWiseBedFunction(var Rec: Record "Room Wise Bed"; xRecHostelID: Code[20]; xRecRoomNo: Code[20]; xRecBedNo: Code[10]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RoomWiseBed?HostelID=%1&RoomNo=%2&BedNo=%3&CreatedBy=%4&CreatedOn=%5&ModifiedBy=%6&ModifiedOn=%7&Blocked=%8&Available=%9&GlobalDimension1Code=%10&GlobalDimension2Code=%11&Inserted=%12&Updated=%13&MaximumNoofBed=%14&RoomCategoryCode=%15&BedSize=%16&OldHostelID=%15&OldRoomNo=%16&OldBedNo=%17&Delete=%18', Rec."Housing ID", Rec."Room No.", Rec."Bed No.", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Blocked), HandlingBoolean(Rec.Available), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Maximum No. of Bed", Rec."Room Category Code", Rec."Bed Size", xRecHostelID, xRecRoomNo, xRecBedNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Room Wise Bed"-End------------------------------------------------------------------------------------------------ 

    //"Room Master"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50332, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomMasterOnInsert(VAR Rec: Record "Room Master"; RunTrigger: Boolean)
    begin
        RoomMasterFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50332, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomMasterOnModify(VAR Rec: Record "Room Master"; VAR xRec: Record "Room Master"; RunTrigger: Boolean)
    begin
        RoomMasterFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50332, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomMasterOnRename(VAR Rec: Record "Room Master"; VAR xRec: Record "Room Master"; RunTrigger: Boolean)
    begin
        RoomMasterFunction(Rec, xRec."Housing ID", xRec."Room No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50332, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomMasterOnDelete(VAR Rec: Record "Room Master"; RunTrigger: Boolean)
    begin
        RoomMasterFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RoomMasterFunction(var Rec: Record "Room Master"; xRecHostelID: Code[20]; xRecRoomNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RoomMaster?HostelID=%1&RoomNo=%2&FloorNo=%3&RoomCategoryCode=%4&MaximumNoofBed=%5&CreatedBy=%6&CreatedOn=%7&ModifiedBy=%8&ModifiedOn=%9&Blocked=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&Inserted=%13&Updated=%14&StudentNo=%15&StudentName=%16&OldHostelID=%17&OldRoomNo=%18&Delete=%19', Rec."Housing ID", Rec."Room No.", Rec."Floor No.", Rec."Room Category Code", Rec."Maximum No. of Bed", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Blocked), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Student No.", Rec."Student Name", xRecHostelID, xRecRoomNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Room Master"-End------------------------------------------------------------------------------------------------ 

    //"Room Category Master"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50330, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryMasterOnInsert(VAR Rec: Record "Room Category Master"; RunTrigger: Boolean)
    begin
        RoomCategoryMasterFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50330, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryMasterOnModify(VAR Rec: Record "Room Category Master"; VAR xRec: Record "Room Category Master"; RunTrigger: Boolean)
    begin
        RoomCategoryMasterFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50330, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryMasterOnRename(VAR Rec: Record "Room Category Master"; VAR xRec: Record "Room Category Master"; RunTrigger: Boolean)
    begin
        RoomCategoryMasterFunction(Rec, xRec."Room Category Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50330, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryMasterOnDelete(VAR Rec: Record "Room Category Master"; RunTrigger: Boolean)
    begin
        RoomCategoryMasterFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RoomCategoryMasterFunction(var Rec: Record "Room Category Master"; xRecRoomCategoryCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RoomCategoryMaster?RoomCategoryCode=%1&RoomCategory=%2&MaximumNoofBed=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&WithSpouse=%6&Inserted=%7&Updated=%8&CreatedBy=%9&CreatedOn=%10&ModifiedBy=%11&ModifiedOn=%12&RoomCategoryName=%13&Block=%14&OldRoomCategoryCode=%14&Delete=%15', Rec."Room Category Code", Rec."Room Category Name", Rec."Maximum No. of Bed", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec."With Spouse"), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."Room Category Name", HandlingBoolean(Rec.Block), xRecRoomCategoryCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Room Category Master"-End------------------------------------------------------------------------------------------------ 

    //"Room Category Fee Setup"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50331, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryFeeSetupOnInsert(VAR Rec: Record "Room Category Fee Setup"; RunTrigger: Boolean)
    begin
        RoomCategoryFeeSetupFunction(Rec, '', 0D, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50331, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryFeeSetupOnModify(VAR Rec: Record "Room Category Fee Setup"; VAR xRec: Record "Room Category Fee Setup"; RunTrigger: Boolean)
    begin
        RoomCategoryFeeSetupFunction(Rec, '', 0D, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50331, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryFeeSetupOnRename(VAR Rec: Record "Room Category Fee Setup"; VAR xRec: Record "Room Category Fee Setup"; RunTrigger: Boolean)
    begin
        RoomCategoryFeeSetupFunction(Rec, xRec."Room Category Code", xRec."Effective From", xRec."Housing ID", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50331, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RoomCategoryFeeSetupOnDelete(VAR Rec: Record "Room Category Fee Setup"; RunTrigger: Boolean)
    begin
        RoomCategoryFeeSetupFunction(Rec, '', 0D, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RoomCategoryFeeSetupFunction(var Rec: Record "Room Category Fee Setup"; xRecRoomCategoryCode: Code[20]; xRecEffectiveFrom: Date; xRecHostelID: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RoomCategoryFeeSetup?RoomCategoryCode=%1&EffectiveFrom=%2&Cost=%3&GLAccountNo=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&HostelID=%7&WithSpouseCost=%8&CreatedBy=%9&CreatedOn=%10&ModifiedBy=%11&ModifiedOn=%12&Updated=%13&Inserted=%14&RoomCategoryName=%15&HousingName=%16&HousingGroup=%17&OffCampus=%18&WithSpouse=%19&HousingGroupName=%20&Blocked=%21&BlockedOnCampusHousing=%22&OldRoomCategoryCode=%23&OldEffectiveFrom=%24&OldHostelID=%25&Delete=%26', Rec."Room Category Code", FORMAT(Rec."Effective From", 0, 9), FORMAT(Rec.Cost, 0, 1), Rec."G/L Account No.", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Housing ID", FORMAT(Rec."With Spouse Cost", 0, 1), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), Rec."Room Category Name", Rec."Housing Name", Rec."Housing Group", HandlingBoolean(Rec."Off Campus"), HandlingBoolean(Rec."With Spouse"), Rec."Housing Group Name", HandlingBoolean(Rec.Blocked), HandlingBoolean(Rec."Blocked (On Campus Housing)"), xRecRoomCategoryCode, FORMAT(xRecEffectiveFrom, 0, 9), xRecHostelID, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    //"Room Category Fee Setup"-End------------------------------------------------------------------------------------------------ 

    //"Promotion Line"-Start------------------------------------------------------------------------------------------------ 

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Promotion_Line_CSOnInsert(VAR Rec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineFunction(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Promotion_Line_CSOnModify(VAR Rec: Record "Promotion Line-CS"; VAR xRec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineFunction(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Promotion_Line_CSOnRename(VAR Rec: Record "Promotion Line-CS"; VAR xRec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineFunction(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Promotion_Line_CSOnDelete(VAR Rec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineFunction(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure PromotionLineFunction(var Rec: Record "Promotion Line-CS"; xRecDocumentNo: Code[20]; xRecLineNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Promotion_Line_CS?DocumentNo_=%1&LineNo_=%2&StudentNo_=%3&CourseCode=%4&Semester=%5&StudentName=%6&InActive=%7&Section=%8&AcademicYear=%9&GraduationCode=%10&DepartmentCode=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&TypeOfCourse=%14&FinalYearsCourse=%15&NotEligible=%16&Session=%17&Order=%18&Year=%19&StudentPromoted=%20&EnrollmentNo_=%21&Credit=%22&PromotedYear=%23&PromotedSemester=%24&PromotedAcademicYear=%25&Graduated=%26&CreatedBy=%27&CreatedOn=%28&ModifiedBy=%29&ModifiedOn=%30&FeeGenerated=%31&Group=%32&PromotedToGroup=%33&LateralStudent=%34&OldDocumentNo_=%35&OldLineNo_=%36&Delete=%36', Rec."Document No.", Rec."Line No.", Rec."Student No.", rec."Course Code", Rec.Semester, Rec."Student Name", HandlingBoolean(rec."In Active"), Rec.Section, Rec."Academic Year", Rec."Graduation Code", Rec."Department Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", HandlingBoolean(Rec."Not Eligible"), Rec.Session, Rec.Order, Rec.Year, HandlingBoolean(Rec."Student Promoted"), Rec."Enrollment No.", Rec.Credit, Rec."Promoted Year", Rec."Promoted Semester", Rec."Promoted  Academic Year", HandlingBoolean(Rec.Graduated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec."Fee Generated"), Rec.Group, Rec."Promoted To Group", HandlingBoolean(Rec."Lateral Student"), xRecDocumentNo, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Promotion Line"-End------------------------------------------------------------------------------------------------ 



    //Ethnicity Start
    [EventSubscriber(ObjectType::Table, 50445, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalWebApi_Ethnicity_MasterInsert(VAR Rec: Record "Ethnicity"; RunTrigger: Boolean)
    begin
        EthnicityMasterFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50445, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalWebApi_Ethnicity_MasterModify(VAR Rec: Record "Ethnicity"; VAR xRec: Record Ethnicity; RunTrigger: Boolean)
    begin
        EthnicityMasterFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50445, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalWebApi_Ethnicity_MasterDelete(VAR Rec: Record "Ethnicity"; RunTrigger: Boolean)
    begin
        EthnicityMasterFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50445, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalWebApi_Ethnicity_MasterRename(VAR Rec: Record "Ethnicity"; VAR xRec: Record Ethnicity; RunTrigger: Boolean)
    begin
        EthnicityMasterFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    Procedure EthnicityMasterFunction(VAR Rec: Record "Ethnicity"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/WebApi_Ethnicity_Master?Id=%1&Ethnicity=%2&EthnicitySeq=%3&Active=%4&OldID=%5&Delete=%6', Rec.Code, Rec."Ethnicity Description", '', '', xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Ethnicity Stop

    // Student Ethnicity Start
    [EventSubscriber(ObjectType::Table, 50461, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_API_Student_EthnicityModify(VAR Rec: Record "Student Ethnicity"; VAR xRec: Record "Student Ethnicity"; RunTrigger: Boolean)
    begin
        StudentEthnicityFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50461, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_API_Student_EthnicityRename(VAR Rec: Record "Student Ethnicity"; VAR xRec: Record "Student Ethnicity"; RunTrigger: Boolean)
    begin
        StudentEthnicityFunction(Rec, xRec."Ethnicity Code", xRec."Student No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50461, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_API_Student_EthnicityDelete(VAR Rec: Record "Student Ethnicity"; RunTrigger: Boolean)
    begin
        StudentEthnicityFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50461, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_API_Student_EthnicityInsert(VAR Rec: Record "Student Ethnicity"; RunTrigger: Boolean)
    begin
        StudentEthnicityFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure StudentEthnicityFunction(var Rec: Record "Student Ethnicity"; xReEthnCode: Code[20]; xRecStudNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_API_Student_Ethnicity?EthnicityCode=%1&StudentNo_=%2&EthnicityName=%3&StudentName=%4&CreatedBy=%5&CreatedOn=%6&ModifiedBy=%7&ModifiedOn=%8&OldEthnicityCode=%9&OldStudentNo_=%10&Delete=%11', Rec."Ethnicity Code", Rec."Student No.", Rec."Ethnicity Name", Rec."Student Name", Rec."Created By", Rec."Created On", Rec."Modified By", Rec."Modified On", xReEthnCode, xRecStudNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    // Student Ethnicity End


    //Housing Application Start
    [EventSubscriber(ObjectType::Table, 50334, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingApplicationOnInsert(VAR Rec: Record "Housing Application"; RunTrigger: Boolean)
    begin
        HousingApplicationFunction(Rec, '', 0, 'OnAfterInsertEvent')
    End;

    [EventSubscriber(ObjectType::Table, 50334, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingApplicationOnModify(VAR Rec: Record "Housing Application"; VAR xRec: Record "Housing Application"; RunTrigger: Boolean)

    begin
        HousingApplicationFunction(Rec, '', 0, 'OnAfterModifyEvent')
    End;

    [EventSubscriber(ObjectType::Table, 50334, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingApplicationOnDelete(VAR Rec: Record "Housing Application"; RunTrigger: Boolean)

    begin
        HousingApplicationFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    End;

    [EventSubscriber(ObjectType::Table, 50334, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingApplicationOnRename(VAR Rec: Record "Housing Application"; VAR xRec: Record "Housing Application"; RunTrigger: Boolean)

    begin
        HousingApplicationFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    End;

    procedure HousingApplicationFunction(var Rec: Record "Housing Application"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.testfield("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingApplication?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&EnrolmentNo=%4&WithSpouse=%5&HostelPref1=%6&Pref1Selected=%7&HostelPref2=%8&Pref2Selected=%9&HostelPref3=%10&Pref3Selected=%11&RoomCategoryCode=%12&RoomNo=%13&BedNo=%14&PreferenceRemarks=%15&AllotmentTransactionID=%16&CreatedBy=%17&CreatedOn=%18&ModifiedBy=%19&ModifiedOn=%20&GlobalDimension1Code=%21&GlobalDimension2Code=%22&Posted=%23&StartDate=%24&EndDate=%25&EntryFromPortal=%26&Group=%27&Status=%28&InventoryVerified=%29&ReasonCode=%30&NoSeries=%31&HostelID=%32&HousingGroup=%33&RoomCategoryPref1=%34&RoomCategoryPref2=%35&RoomCategoryPref3=%36&HousingGroupPref1=%37&HousingGroupPref2=%38&HousingGroupPref3=%39&AppliedtoContinue=%40&AcceptedforPreviousHousing=%41&StudentName=%42&Semester=%43&AcademicYear=%44&Term=%45&Inserted=%46&Updated=%47&RejectionReasonCode=%48&RejectionDescription=%49&ApprovedBy=%50&ApprovedOn=%51&RejectedBy=%52&RejectedOn=%53&ApprovedInDays=%54&RejectedInDays=%55&HousingPref1Name=%56&HousingPref2Name=%57&HousingPref3Name=%58&EntryFromChange=%59&HousingCost=%60&RoomMateNamePref=%61&RoomMateEmailPref=%62&FirstTimeIsland=%63&FlightArrivalDate=%64&FlightArrivalTime=%65&FlightNumber=%66&AirlineCarrier=%67&MedicalCondition=%68&Disability=%69&TravelingWithSpouse=%70&TravelSpouseChild=%71&TravelSerAnimal=%72&Other=%73&OtherDescription=%74&SpecialRoommatePreference=%75&OldApplicationNo=%76&Delete=%77', rec."Application No.", FORMAT(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Enrolment No.", HandlingBoolean(Rec."With Spouse"), rec."Housing Pref. 1", HandlingBoolean(Rec."Pref. 1 Selected"), rec."Housing Pref. 2", HandlingBoolean(Rec."Pref. 2 Selected"), rec."Housing Pref. 3", HandlingBoolean(Rec."Pref. 3 Selected"), Rec."Room Category Code", Rec."Room No.", Rec."Bed No.", Rec."Preference Remarks", '', Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Posted), FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."End Date", 0, 9), HandlingBoolean(Rec."Entry From Portal"), Rec."Housing Group", HandlingOption(Rec.Status), HandlingBoolean(Rec."Inventory Verified"), Rec."Rejection Reason Code", Rec."No.Series", Rec."Housing ID", Rec."Housing Group", Rec."Room Category Pref.1", Rec."Room Category Pref.2", Rec."Room Category Pref.3", Rec."Housing Group Pref.1", Rec."Housing Group Pref.2", Rec."Housing Group Pref.3", HandlingBoolean(Rec."Applied to Continue"), HandlingBoolean(Rec."Accepted for Previous Housing"), Rec."Student Name", Rec.Semester, Rec."Academic Year", HandlingOption(Rec.Term), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Rejection Reason Code", Rec."Rejection Description", Rec."Approved By", FORMAT(Rec."Approved On", 0, 9), Rec."Rejected By", FORMAT(Rec."Rejected On", 0, 9), Rec."Approved In Days", Rec."Rejected In Days", Rec."Housing Pref. 1 Name", Rec."Housing Pref. 2 Name", Rec."Housing Pref. 3 Name", HandlingBoolean(Rec."Entry From Change"), FORMAT(Rec."Housing Cost", 0, 1), Rec."Room Mate Name Pref", Rec."Room Mate Email Pref", HandlingBoolean(Rec."1st Time Island"), Format(Rec."Flight Arrival Date", 0, 9), Format(Rec."Flight Arrival Time", 0, 9), Rec."Flight Number", Rec."Airline/Carrier", HandlingBoolean(Rec."Medical Condition"), HandlingBoolean(Rec.Disability), HandlingBoolean(Rec."Traveling With Spouse"), HandlingBoolean(Rec."Travel Spouse & Child"), HandlingBoolean(Rec."Travel Ser. Animal"), HandlingBoolean(Rec.Other), Rec."Other Description", Rec."Special Roommate Preference", xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;

    end;
    //Housing Application Start

    //Housing Group Start
    [EventSubscriber(ObjectType::Table, 50329, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingGroupOnModify(VAR Rec: Record "Housing Group"; VAR xRec: Record "Housing Group"; RunTrigger: Boolean)
    begin
        HousingGroupFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50329, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingGroupOnDelete(VAR Rec: Record "Housing Group"; RunTrigger: Boolean)
    begin
        HousingGroupFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50329, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingGroupOnInsert(VAR Rec: Record "Housing Group"; RunTrigger: Boolean)
    begin
        HousingGroupFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50329, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingGroupOnRename(VAR Rec: Record "Housing Group"; VAR xRec: Record "Housing Group"; RunTrigger: Boolean)
    begin
        HousingGroupFunction(Rec, xRec."Group Code", 0, 'OnAfterRenameEvent')
    end;

    procedure HousingGroupFunction(var Rec: Record "Housing Group"; xRecGroupCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.testfield("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingGroup?GroupCode=%1&GroupName=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&Inserted=%5&Updated=%6&CreatedBy=%7&CreatedOn=%8&ModifiedBy=%9&ModifiedOn=%10&OldGroupCode=%11&Delete=%12', Rec."Group Code", Rec."Group Name", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), xRecGroupCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Housing Group Stop

    //Housing Parking Detail Start
    [EventSubscriber(ObjectType::Table, 50361, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingParkingOnModify(VAR Rec: Record "Housing Parking Details"; VAR xRec: Record "Housing Parking Details"; RunTrigger: Boolean)
    begin
        HousingParkingDetailFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50361, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingParkingOnDelete(VAR Rec: Record "Housing Parking Details"; RunTrigger: Boolean)
    begin
        HousingParkingDetailFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50361, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingParkingOnInsert(VAR Rec: Record "Housing Parking Details"; RunTrigger: Boolean)
    begin
        HousingParkingDetailFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50361, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingParkingOnRename(VAR Rec: Record "Housing Parking Details"; VAR xRec: Record "Housing Parking Details"; RunTrigger: Boolean)
    begin
        HousingParkingDetailFunction(Rec, xRec."Parking Application No.", 0, 'OnAfterRenameEvent')
    end;

    procedure HousingParkingDetailFunction(var Rec: Record "Housing Parking Details"; xRecParkAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        RecStudentMaster: Record "Student Master-CS";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        IF Rec."Student No." <> '' then
            RecStudentMaster.Get(Rec."Student No.");
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingParking?ParkingApplicationNo=%1&StudentNo=%2&StudentName=%3&EnrolmentNo=%4&Semester=%5&AcademicYear=%6&VehicleNumber=%7&HousingParkingNo=%8&IssuedOn=%9&IssuedUpto=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&CreatedBy=%13&CreatedOn=%14&ModifiedBy=%15&ModifiedOn=%16&Updated=%17&Inserted=%18&Status=%19&NoSeries=%20&Make=%21&Model=%22&Colour=%23&NameofVehicleOwner=%24&NumberofVehicleOwner=%25&RegistrationNumber=%26&DriverLicenseNumber=%27&LicenseExpirationDate=%28&Comment=%29&StickerNumber=%30&Term=%31&ApplicationDate=%32&IssuedFrom=%33&StickerAssignedDate=%34&ApprovedInDays=%35&OldParkingApplicationNo=%36&Delete=%37', Rec."Parking Application No.", Rec."Student No.", Rec."Student Name", Rec."Enrolment No.", Rec.Semester, Rec."Academic Year", Rec."Vehicle Number", Rec."Sticker Number", FORMAT(Rec."Issued From", 0, 9), FORMAT(Rec."Issued Upto", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), HandlingOption(Rec.Status), Rec."No. Series", Rec.Make, Rec.Model, Rec.Colour, Rec."Name of Vehicle Owner", Rec."Number of Vehicle Owner", Rec."Registration Number", Rec."Driver License Number", FORMAT(Rec."License Expiration Date", 0, 9), Rec.Comment, Rec."Sticker Number", HandlingOption(RecStudentMaster.Term), FORMAT(Rec."Application Date", 0, 9), FORMAT(Rec."Issued From", 0, 9), FORMAT(Rec."Sticker Assigned Date", 0, 9), Rec."Approved In Days", xRecParkAppNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //Housing Parking Detail Start

    //Housing Ledger Start
    [EventSubscriber(ObjectType::Table, 50335, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingLedgerOnInsert(VAR Rec: Record "Housing Ledger"; RunTrigger: Boolean)
    begin
        HousingLedgerlFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50335, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingLedgerOnDelete(VAR Rec: Record "Housing Ledger"; RunTrigger: Boolean)
    begin
        HousingLedgerlFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50335, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingLedgerOnModify(VAR Rec: Record "Housing Ledger"; var xRec: Record "Housing Ledger"; RunTrigger: Boolean)
    begin
        HousingLedgerlFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50335, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingLedgerOnRename(VAR Rec: Record "Housing Ledger"; var xRec: Record "Housing Ledger"; RunTrigger: Boolean)
    begin
        HousingLedgerlFunction(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent')
    end;

    procedure HousingLedgerlFunction(var Rec: Record "Housing Ledger"; xRecEntryNo: text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingLedger?EntryNo=%1&ApplicationNo=%2&Status=%3&HostelID=%4&RoomCategoryCode=%5&RoomNo=%6&BedNo=%7&StudentNo=%8&EnrolmentNo=%9&AcademicYear=%10&Semester=%11&RoomAssignment=%12&HostelAllottedOn=%13&PostingDate=%14&HostelAllotedEndDate=%15&InventoryVerified=%16&HostelVacatedOn=%17&HostelChangedOn=%18&CreatedBy=%19&CreatedOn=%20&ModifiedBy=%21&ModifiedOn=%22&GlobalDimension1Code=%23&GlobalDimension2Code=%24&Inserted=%25&Updated=%26&Type=%27&OriginalApplicationNo=%28&ContractNo=%29&HousingGroup=%30&HousingAllottedStartDate=%31&StudentName=%32&Term=%33&WithSpouse=%34&SpouseEntry=%35&HousingCost=%36&RoomMateNamePref=%37&RoomMateEmailPref=%38&FirstTimeIsland=%39&OldEntryNo=%40&Delete=%41', Rec."Entry No.", Rec."Application No.", HandlingOption(Rec.Status), Rec."Housing ID", Rec."Room Category Code", Rec."Room No.", Rec."Bed No.", Rec."Student No.", Rec."Enrolment No.", Rec."Academic Year", Rec.Semester, Rec."Room Assignment", FORMAT(Rec."Housing Allotted Start Date", 0, 9), FORMAT(Rec."Posting Date", 0, 9), FORMAT(Rec."Housing Alloted End Date", 0, 9), HandlingBoolean(Rec."Inventory Verified"), FORMAT(Rec."Housing Vacated On", 0, 9), FORMAT(Rec."Housing Changed On", 0, 9), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), HandlingOption(Rec.Type), Rec."Original Application No.", Rec."Contract No.", Rec."Housing Group", FORMAT(Rec."Housing Allotted Start Date", 0, 9), Rec."Student Name", HandlingOption(Rec.Term), HandlingBoolean(Rec."With Spouse"), HandlingBoolean(Rec."Spouse Entry"), FORMAT(Rec."Housing Cost", 0, 1), rec."Room Mate Name Pref", Rec."Room Mate Email Pref", HandlingBoolean(Rec."1st Time Island"), xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Housing Ledger Stop
    //Housing Inventory Allocation Function Start
    [EventSubscriber(ObjectType::Table, 50351, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryAllocationOnModify(VAR Rec: Record "Housing Inventory Allocation"; VAR xRec: Record "Housing Inventory Allocation"; RunTrigger: Boolean)
    begin
        HousingInvAllcoFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50351, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryAllocationOnDelete(VAR Rec: Record "Housing Inventory Allocation"; RunTrigger: Boolean)
    begin
        HousingInvAllcoFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50351, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryAllocationOnInsert(VAR Rec: Record "Housing Inventory Allocation"; RunTrigger: Boolean)
    begin
        HousingInvAllcoFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50351, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryAllocationOnRename(VAR Rec: Record "Housing Inventory Allocation"; VAR xRec: Record "Housing Inventory Allocation"; RunTrigger: Boolean)
    begin
        HousingInvAllcoFunction(Rec, xRec."Housing ID", xRec."Item Code", xRec."Room No.", 0, 'OnAfterRenameEvent')
    end;

    procedure HousingInvAllcoFunction(var Rec: Record "Housing Inventory Allocation"; xRecHousingId: Code[20]; xRecItemCode: Code[20]; xRecRoomNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingInventoryAllocation?HostelID=%1&ItemCode=%2&ItemName=%3&Qunatity=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&CreatedBy=%7&CreatedOn=%8&ModifiedBy=%9&ModifiedOn=%10&Updated=%11&Inserted=%12&RoomNo=%13&InventoryCategory=%14&OldHostelID=%15&OldItemCode=%16&OldRoomNo=%17&Delete=%18', Rec."Housing ID", Rec."Item Code", Rec."Item Name", Rec.Qunatity, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), Rec."Room No.", HandlingOption(Rec."Inventory Category"), xRecHousingId, xRecItemCode, xRecRoomNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Housing Inventory Allocation Function Stop

    // //Class Time Table Header-CS Function Start
    // [EventSubscriber(ObjectType::Table, 50128, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalGenerate_Time_Table_Update_UtilOnModify(VAR Rec: Record "Class Time Table Header-CS"; VAR xRec: Record "Class Time Table Header-CS"; RunTrigger: Boolean)

    // begin
    //     ClassTimeTableHeaderCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    // End;

    // [EventSubscriber(ObjectType::Table, 50128, 'OnAfterRenameEvent', '', false, false)]
    // procedure ApiPortalGenerate_Time_Table_Update_UtilOnRename(VAR Rec: Record "Class Time Table Header-CS"; VAR xRec: Record "Class Time Table Header-CS"; RunTrigger: Boolean)

    // begin
    //     ClassTimeTableHeaderCSFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent')
    // End;

    // [EventSubscriber(ObjectType::Table, 50128, 'OnAfterDeleteEvent', '', false, false)]
    // procedure ApiPortalGenerate_Time_Table_Update_UtilOnDelete(VAR Rec: Record "Class Time Table Header-CS"; RunTrigger: Boolean)

    // begin
    //     ClassTimeTableHeaderCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    // End;

    // [EventSubscriber(ObjectType::Table, 50128, 'OnAfterInsertEvent', '', false, false)]
    // procedure ApiPortalGenerate_Time_Table_Update_UtilOnInsert(VAR Rec: Record "Class Time Table Header-CS"; RunTrigger: Boolean)

    // begin
    //     ClassTimeTableHeaderCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    // End;

    // procedure ClassTimeTableHeaderCSFunction(var Rec: Record "Class Time Table Header-CS"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    // Var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;

    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + 'Generate_Time_Table_Update_Util?DocumentNo=%1&OldDocumentNo=%2&Delete=%3', Rec."No.", xRecNo, DeleteAllowed);

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);

    //         SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
    //     end;
    // end;
    // //Class Time Table Header-CS Function Stop


    //Academic Year Master-CS Function Start
    [EventSubscriber(ObjectType::Table, 50036, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_AcademicYearMasterOnModify(VAR Rec: Record "Academic Year Master-CS"; VAR xRec: Record "Academic Year Master-CS"; RunTrigger: Boolean)
    begin
        AcademicYearMasterCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50036, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_AcademicYearMasterOnRename(VAR Rec: Record "Academic Year Master-CS"; VAR xRec: Record "Academic Year Master-CS"; RunTrigger: Boolean)
    begin
        AcademicYearMasterCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50036, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_AcademicYearMasterOnDelete(VAR Rec: Record "Academic Year Master-CS"; RunTrigger: Boolean)
    begin
        AcademicYearMasterCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50036, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_AcademicYearMasterOnInsert(VAR Rec: Record "Academic Year Master-CS"; RunTrigger: Boolean)
    begin
        AcademicYearMasterCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure AcademicYearMasterCSFunction(var Rec: Record "Academic Year Master-CS"; xRecCode: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_AcademicYearMaster?Code=%1&Description=%2&Sequence=%3&Closed=%4&StartDate=%5&EndDate=%6&GlobalDimension1Code=%7&GlobalDimension2Code=%8&UserID=%9&PortalID=%10&OldCode=%11&Delete=%12', Rec.Code, Rec.Description, Rec.Sequence, HandlingBoolean(Rec.Closed), Format(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Academic Year Master-CS Function Stop

    //Application Option Master-CS Start
    [EventSubscriber(ObjectType::Table, 50185, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationOptionMasterOnModify(VAR Rec: Record "Application Option Master-CS"; VAR xRec: Record "Application Option Master-CS"; RunTrigger: Boolean)

    begin
        ApplicationOptionMasterCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50185, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationOptionMasterOnRename(VAR Rec: Record "Application Option Master-CS"; VAR xRec: Record "Application Option Master-CS"; RunTrigger: Boolean)

    begin
        ApplicationOptionMasterCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50185, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationOptionMasterOnDelete(VAR Rec: Record "Application Option Master-CS"; RunTrigger: Boolean)

    begin
        ApplicationOptionMasterCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50185, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationOptionMasterOnInsert(VAR Rec: Record "Application Option Master-CS"; RunTrigger: Boolean)

    begin
        ApplicationOptionMasterCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;


    procedure ApplicationOptionMasterCSFunction(var Rec: Record "Application Option Master-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_ApplicationOptionMaster?Code=%1&Description=%2&OldCode=%3&Delete=%4', Rec.Code, Rec.Description, xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Application Option Master-CS Stop
    //Batch of Student-CS Start
    [EventSubscriber(ObjectType::Table, 50047, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_BatchofStudentOnModify(VAR Rec: Record "Batch of Student-CS"; VAR xRec: Record "Batch of Student-CS"; RunTrigger: Boolean)
    var

    begin
        BatchofStudentCSFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50047, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_BatchofStudentOnRename(VAR Rec: Record "Batch of Student-CS"; VAR xRec: Record "Batch of Student-CS"; RunTrigger: Boolean)
    var

    begin
        BatchofStudentCSFunction(Rec, xRec.Course, xRec."Batch Code", xRec."Academic Year", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50047, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_BatchofStudentOnDelete(VAR Rec: Record "Batch of Student-CS"; RunTrigger: Boolean)
    var

    begin
        BatchofStudentCSFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50047, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_BatchofStudentOnInsert(VAR Rec: Record "Batch of Student-CS"; RunTrigger: Boolean)
    var

    begin
        BatchofStudentCSFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure BatchofStudentCSFunction(var Rec: Record "Batch of Student-CS"; xRecCourse: Code[20]; xRecBatchCode: Code[20]; xRecAcadYear: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");

            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_BatchofStudent?Course=%1&BatchCode=%2&BatchCodeDescription=%3&NoOfStudent=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&Semester=%7&AcademicYear=%8&Section=%9&Session=%10&Year=%11&TypeOfCourse=%12&AvailableStudent=%13&Updated=%14&OldCourse=%15&OldBatchCode=%16&OldAcademicYear=%17&Delete=%18', Rec.Course, Rec."Batch Code", Rec."Batch Code Description", Rec."No. Of Student", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Semester, Rec."Academic Year", Rec.Section, Rec.Session, Rec.Year, HandlingOption(Rec."Type Of Course"), Rec."Available Student", HandlingBoolean(Rec.Updated), xRecCourse, xRecBatchCode, xRecAcadYear, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Batch of Student-CS Stop
    //Category Master-CS Start
    [EventSubscriber(ObjectType::Table, 50201, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CategoryMasterOnModify(VAR Rec: Record "Category Master-CS"; VAR xRec: Record "Category Master-CS"; RunTrigger: Boolean)

    begin
        CategoryMasterCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50201, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CategoryMasterOnRename(VAR Rec: Record "Category Master-CS"; VAR xRec: Record "Category Master-CS"; RunTrigger: Boolean)

    begin
        CategoryMasterCSFunction(Rec, xRec.Code, xRec."Fee Classification", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50201, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CategoryMasterOnDelete(VAR Rec: Record "Category Master-CS"; RunTrigger: Boolean)

    begin
        CategoryMasterCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50201, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CategoryMasterOnInsert(VAR Rec: Record "Category Master-CS"; RunTrigger: Boolean)

    begin
        CategoryMasterCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure CategoryMasterCSFunction(var Rec: Record "Category Master-CS"; xRecCode: Code[20]; xRecFee: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CategoryMaster?Code=%1&FeeClassification=%2&Description=%3&DiscountCode=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&SISCode=%7&UserID=%8&PortalID=%9&OldCode=%10&OldFeeClassification=%11&Delete=%12', Rec.Code, Rec."Fee Classification", Rec.Description, Rec."Discount Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."SIS Code", Rec."User ID", Rec."Portal ID", xRecCode, xRecFee, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Category Master-CS Stop

    //Company Information Start
    [EventSubscriber(ObjectType::Table, 79, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CompanyInformationOnModify(VAR Rec: Record "Company Information"; VAR xRec: Record "Company Information"; RunTrigger: Boolean)

    begin
        CompanyInformationFunction(Rec, xRec."Primary Key", 0, 'OnAfterModifyEvent')//CSPL-00307 Added --08-12-21-XRec.PrimaryKey
    end;

    [EventSubscriber(ObjectType::Table, 79, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CompanyInformationOnRename(VAR Rec: Record "Company Information"; VAR xRec: Record "Company Information"; RunTrigger: Boolean)

    begin
        CompanyInformationFunction(Rec, xRec."Primary Key", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 79, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CompanyInformationOnDelete(VAR Rec: Record "Company Information"; RunTrigger: Boolean)

    begin
        CompanyInformationFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 79, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CompanyInformationOnInsert(VAR Rec: Record "Company Information"; RunTrigger: Boolean)

    begin
        CompanyInformationFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure CompanyInformationFunction(var Rec: Record "Company Information"; xRecPriKey: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CompanyInformation?PrimaryKey=%1&Name=%2&Name2=%3&Address=%4&Address2=%5&City=%6&PhoneNo=%7&PhoneNo2=%8&TelexNo=%9&FaxNo=%10&GiroNo=%11&BankName=%12&BankBranchNo=%13&BankAccountNo=%14&PaymentRoutingNo=%15&CustomsPermitNo=%16&CustomsPermitDate=%17&VATRegistrationNo=%18&RegistrationNo=%19&TelexAnswerBack=%20&ShiptoName=%21&ShiptoName2=%22&ShiptoAddress=%23&ShiptoAddress2=%24&ShiptoCity=%25&ShiptoContact=%26&LocationCode=%27&Picture=%28&PostCode=%29&County=%30&ShiptoPostCode=%31&ShiptoCounty=%32&EMail=%33&HomePage=%34&CountryRegionCode=%35&ShiptoCountryRegionCode=%36&IBAN=%37&SWIFTCode=%38&IndustrialClassification=%39&ICPartnerCode=%40&ICInboxType=%41&ICInboxDetails=%42&AutoSendTransactions=%43&SystemIndicator=%44&CustomSystemIndicatorText=%45&SystemIndicatorStyle=%46&AllowBlankPaymentInfo=%47&ContactPerson=%48&GLN=%49&PictureLastModDateTime=%50&LastModifiedDateTime=%51&CreatedDateTime=%52&DemoCompany=%53&AlternativeLanguageCode=%54&BrandColorValue=%55&BrandColorCode=%56&ResponsibilityCenter=%57&CheckAvailPeriodCalc=%58&CheckAvailTimeBucket=%59&BaseCalendarCode=%60&CalConvergenceTimeFrame=%61&ShowChartOnRoleCenter=%62&SyncwithO365Busprofile=%63&ShiptoUPSZone=%64&UPSShipperID=%65&TaxAreaCode=%66&TaxExemptionNo=%67&FederalIDNo=%68&QSTRegistrationNo=%69&ProvincialTaxAreaCode=%70&SoftwareIdentificationCode=%71&RFCNo=%72&CURPNo=%73&StateInscription=%74&TaxScheme=%75&SATTaxRegimeClassification=%76&SATPostalCode=%77&StudentRegisSyncEnable=%78&OldPrimaryKey=%79&Delete=%80', Rec."Primary Key", Rec.Name, Rec."Name 2", Rec.Address, Rec."Address 2", Rec.City, Rec."Phone No.", Rec."Phone No. 2", Rec."Telex No.", Rec."Fax No.", Rec."Giro No.", Rec."Bank Name", Rec."Bank Branch No.", Rec."Bank Account No.", Rec."Payment Routing No.", Rec."Customs Permit No.", FORMAT(Rec."Customs Permit Date", 0, 9), Rec."VAT Registration No.", Rec."Registration No.", Rec."Telex Answer Back", Rec."Ship-to Name", Rec."Ship-to Name 2", Rec."Ship-to Address", Rec."Ship-to Address 2", Rec."Ship-to City", Rec."Ship-to Contact", Rec."Location Code", Rec.Picture, Rec."Post Code", Rec.County, Rec."Ship-to Post Code", Rec."Ship-to County", Rec."E-Mail", Rec."Home Page", Rec."Country/Region Code", Rec."Ship-to Country/Region Code", Rec.IBAN, Rec."SWIFT Code", Rec."Industrial Classification", Rec."IC Partner Code", HandlingOption(Rec."IC Inbox Type"), Rec."IC Inbox Details", HandlingBoolean(Rec."Auto. Send Transactions"), HandlingOption(Rec."System Indicator"), Rec."Custom System Indicator Text", HandlingOption(Rec."System Indicator Style"), HandlingBoolean(Rec."Allow Blank Payment Info."), Rec."Contact Person", Rec.GLN, FORMAT(Rec."Picture - Last Mod. Date Time", 0, 9), FORMAT(Rec."Last Modified Date Time", 0, 9), FORMAT(Rec."Created DateTime", 0, 9), HandlingBoolean(Rec."Demo Company"), Rec."Alternative Language Code", Rec."Brand Color Value", Rec."Brand Color Code", Rec."Responsibility Center", FORMAT(Rec."Check-Avail. Period Calc."), HandlingOption(Rec."Check-Avail. Time Bucket"), Rec."Base Calendar Code", FORMAT(Rec."Cal. Convergence Time Frame"), False, False, '', '', '', '', '', '', '', '', '', '', '', '', '', '', HandlingBoolean(Rec."Student Regis. Sync Enable"), xRecPriKey, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);

        end;
    end;
    ////Company Information Stop
    //Country/Region Start
    [EventSubscriber(ObjectType::Table, 9, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CountryRegionOnModify(VAR Rec: Record "Country/Region"; VAR xRec: Record "Country/Region"; RunTrigger: Boolean)

    begin
        CountryRegionFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 9, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CountryRegionOnRename(VAR Rec: Record "Country/Region"; VAR xRec: Record "Country/Region"; RunTrigger: Boolean)

    begin
        CountryRegionFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 9, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CountryRegionOnDelete(VAR Rec: Record "Country/Region"; RunTrigger: Boolean)

    begin
        CountryRegionFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 9, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CountryRegionOnInsert(VAR Rec: Record "Country/Region"; RunTrigger: Boolean)

    begin
        CountryRegionFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure CountryRegionFunction(var Rec: Record "Country/Region"; xRecCode: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;


    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CountryRegion?Code=%1&Name=%2&EUCountryRegionCode=%3&IntrastatCode=%4&AddressFormat=%5&ContactAddressFormat=%6&VATScheme=%7&CountryCodeforeTDSTCS=%8&SISCode=%9&Nationality=%10&Citizenship=%11&Block=%12&ImmigrationApplicable=%13&VisaApplicable=%14&OldCode=%15&Delete=%16', Rec.Code, Rec.Name, Rec."EU Country/Region Code", Rec."Intrastat Code", HandlingOption(Rec."Address Format"), HandlingOption(Rec."Contact Address Format"), Rec."VAT Scheme", '', Rec."SIS Code", Rec.Nationality, Rec.Citizenship, HandlingBoolean(Rec.Block), HandlingBoolean(Rec."Immigration Applicable"), HandlingBoolean(Rec."Visa Applicable"), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //Country/Region Stop
    //Course Master-CS Start
    [EventSubscriber(ObjectType::Table, 50077, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseMasterOnModify(VAR Rec: Record "Course Master-CS"; VAR xRec: Record "Course Master-CS"; RunTrigger: Boolean)

    begin
        CourseMasterCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50077, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseMasterOnInsert(VAR Rec: Record "Course Master-CS"; RunTrigger: Boolean)

    begin
        CourseMasterCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50077, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseMasterOnRename(VAR Rec: Record "Course Master-CS"; VAR xRec: Record "Course Master-CS"; RunTrigger: Boolean)

    begin
        CourseMasterCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50077, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseMasterOnDelete(VAR Rec: Record "Course Master-CS"; RunTrigger: Boolean)

    begin
        CourseMasterCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    procedure CourseMasterCSFunction(var Rec: Record "Course Master-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CourseMaster?Code=%1&Description=%2&Graduation=%3&DurationofYears=%4&ApplicationCostForReserve=%5&ApplicationCostForOthers=%6&RegistrationCostForReserve=%7&RegistrationCostForOthers=%8&DegreeCode=%9&Entrance=%10&EntranceDate=%11&EntranceMaxMark=%12&AcademicYear=%13&MiniimumAgeLimit=%14&MaximumAgeLimit=%15&AgeAsonDate=%16&ApplicationSaleFrom=%17&ApplicationSaleTill=%18&ApplicationReceiveFrom=%19&ApplicationReceiveTill=%20&University=%21&LastStage2GeneratedListNo=%22&Capacity=%23&NumberofSemesters=%24&LastStage1GeneratedListNo=%25&TotalCredit=%26&FinalSemesterCode=%27&CourseDroped=%28&GraceMarks=%29&CreditRequired=%30&GlobalDimension1Code=%31&GlobalDimension2Code=%32&TypeOfCourse=%33&FinalYearsCourse=%34&Year=%35&Semester=%36&AssignmentMark=%37&AttendancePercentage=%38&ConvertTypeOfCourse=%39&CourseClosed=%40&DepartmentName=%41&PromotionCriteria=%42&MinPassingCredit=%43&GroupMandatory=%44&SISCode=%45&Updated=%46&CourseType=%47&MobileInsert=%48&MobileUpdate=%49&Taxable=%50&UserID=%51&PortalID=%52&Section=%53&DiscountGranted=%54&OptionalPreQualification=%55&USINNo=%56&DurationinMonth=%57&EventCode=%58&AdmittedYearWiseFee=%59&SemesterWiseFee=%60&EnrollmentNo=%61&FinancialAIDApplicable=%62&CourseCategory=%63&OLRApplicable=%64&NewOLREnabled=%65&ReturningOLREnabled=%66&InsertedInSalesForce=%67&InsertSync=%68&UpdateSync=%69&CoreRotationWeeks=%70&ElectiveRotationWeeks=%71&Block=%72&ProgramVersionID=%73&ProgramGroupID=%74&AcademicSAP=%75&LateralEntryAllowed=%76&Inserted=%77&ClinicalClerkshipApplicable=%78&TranscriptDataFilter=%79&HonorsApplicable=%80&MinCGPARequired=%81&NonDegree=%82&ShowGradeDescription=%83&CourseChangeAllowed=%84&OldCode=%85&Delete=%86', Rec.Code, Rec.Description, Rec.Graduation, Rec."Duration of Years", FORMAT(Rec."Application Cost For Reserve", 0, 1), FORMAT(Rec."Application Cost For Others", 0, 1), FORMAT(Rec."Registration Cost For Reserve", 0, 1), FORMAT(Rec."Registration Cost For Others", 0, 1), Rec."Degree Code", HandlingBoolean(Rec.Entrance), FORMAT(Rec."Entrance Date", 0, 9), Rec."Entrance Max Mark", Rec."Academic Year", Rec."Miniimum Age Limit", Rec."Maximum Age Limit", FORMAT(Rec."Age As on Date", 0, 9), FORMAT(Rec."Application Sale From", 0, 9), FORMAT(Rec."Application Sale Till", 0, 9), FORMAT(Rec."Application Receive From", 0, 9), FORMAT(Rec."Application Receive Till", 0, 9), Rec.University, Rec."Last Stage2 Generated List No.", Rec.Capacity, Rec."Number of Semesters", Rec."Last Stage1 Generated List No.", Rec."Total Credit", Rec."Final Semester Code", HandlingBoolean(Rec."Course Droped"), Rec."Grace Marks", Rec."Credit Required", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Year, Rec.Semester, Rec."Assignment Mark", Rec."Attendance Percentage", HandlingBoolean(Rec."Convert Type Of Course"), HandlingBoolean(Rec."Course Closed"), Rec."Department Name", HandlingOption(Rec."Promotion Criteria"), Rec."Min. Passing Credit", HandlingBoolean(Rec."Group Mandatory"), Rec."SIS Code", HandlingBoolean(Rec.Updated), HandlingOption(Rec."Course Type"), HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), HandlingBoolean(Rec.Taxable), Rec."User ID", Rec."Portal ID", Rec.Section, HandlingBoolean(Rec."Discount Granted"), HandlingBoolean(Rec."Optional Pre Qualification"), Rec."USIN No.", Rec."Duration in Month", Rec."Event Code", HandlingBoolean(Rec."Admitted Year Wise Fee"), HandlingBoolean(Rec."Semester Wise Fee"), Rec."Enrollment Nos.", HandlingBoolean(Rec."Financial AID Applicable"), HandlingOption(Rec."Course Category"), HandlingBoolean(Rec."OLR Applicable"), HandlingBoolean(Rec."New OLR Enabled"), HandlingBoolean(Rec."Returning OLR Enabled"), HandlingBoolean(Rec."Inserted In SalesForce"), Rec."Insert Sync", Rec."Update Sync", Rec."Core Rotation Weeks", Rec."Elective Rotation Weeks", HandlingBoolean(Rec.Block), Rec."Program Version ID", Rec."Program Group ID", Rec."Academic SAP", HandlingBoolean(Rec."Lateral Entry Allowed"), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec."Clinical Clerkship Applicable"), HandlingBoolean(Rec."Transcript Data Filter"), HandlingBoolean(Rec."Honors Applicable"), Rec."Min CGPA Required", HandlingBoolean(Rec."Non Degree"), HandlingBoolean(Rec."Show Grade Description"), HandlingBoolean(Rec."Course Change Allowed"), xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //Course Master-CS Stop

    //Course Section Master-CS Start
    [EventSubscriber(ObjectType::Table, 50094, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSectionMasterOnRename(VAR Rec: Record "Course Section Master-CS"; VAR xRec: Record "Course Section Master-CS"; RunTrigger: Boolean)
    begin
        CourseSectionMasterCSFunction(Rec, xRec."Course Code", xRec.Year, xRec."Section Code", xRec."Academic Year", xRec.Semester, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50094, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSectionMasterOnModify(VAR Rec: Record "Course Section Master-CS"; VAR xRec: Record "Course Section Master-CS"; RunTrigger: Boolean)
    begin
        CourseSectionMasterCSFunction(Rec, '', '', '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50094, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSectionMasterOndelete(VAR Rec: Record "Course Section Master-CS"; RunTrigger: Boolean)
    begin
        CourseSectionMasterCSFunction(Rec, '', '', '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50094, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSectionMasterOnInsert(VAR Rec: Record "Course Section Master-CS"; RunTrigger: Boolean)
    begin
        CourseSectionMasterCSFunction(Rec, '', '', '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure CourseSectionMasterCSFunction(var Rec: Record "Course Section Master-CS"; xRecCourseCode: Code[20]; xRecYear: code[10]; xRecSecCode: code[10]; xRecAcaYear: code[20]; xRecSem: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;


    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CourseSectionMaster?CourseCode=%1&Year=%2&SectionCode=%3&AcademicYear=%4&GlobalDimension1Code=%5&Semester=%6&GlobalDimension2Code=%7&SequenceNo=%8&Capacity=%9&TypeOfCourse=%10&FinalYearsCourse=%11&Updated=%12&Program=%13&TimeTableGenerated=%14&TemplateNo=%15&MobileInsert=%16&MobileUpdate=%17&UserID=%18&PortalID=%19&OldCourseCode=%20&OldYear=%21&OldSectionCode=%22&OldAcademicYear=%23&OldSemester=%24&Delete=%25', Rec."Course Code", Rec.Year, Rec."Section Code", Rec."Academic Year", Rec."Global Dimension 1 Code", Rec.Semester, Rec."Global Dimension 2 Code", Rec."Sequence No", Rec.Capacity, HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", HandlingBoolean(Rec.Updated), Rec.Program, HandlingBoolean(Rec."Time Table Generated"), Rec."Template No.", HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), Rec."User ID", Rec."Portal ID", xRecCourseCode, xRecYear, xRecSecCode, xRecAcaYear, xRecSem, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Course Section Master-CS Stop
    //Course Sem. Master-CS Start
    [EventSubscriber(ObjectType::Table, 50227, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSemMasterOnModify(VAR Rec: Record "Course Sem. Master-CS"; VAR xRec: Record "Course Sem. Master-CS"; RunTrigger: Boolean)
    begin
        CourseSemMasterCSFunction(Rec, '', '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50227, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSemMasterOnRename(VAR Rec: Record "Course Sem. Master-CS"; VAR xRec: Record "Course Sem. Master-CS"; RunTrigger: Boolean)
    begin
        CourseSemMasterCSFunction(Rec, xRec."Course Code", xRec."Semester Code", xRec."Academic Year", Format(HandlingOption(xRec.Term)), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50227, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSemMasterOnDelete(VAR Rec: Record "Course Sem. Master-CS"; RunTrigger: Boolean)
    begin
        CourseSemMasterCSFunction(Rec, '', '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50227, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseSemMasterOnInsert(VAR Rec: Record "Course Sem. Master-CS"; RunTrigger: Boolean)
    begin
        CourseSemMasterCSFunction(Rec, '', '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure CourseSemMasterCSFunction(var Rec: Record "Course Sem. Master-CS"; xRecCourseCode: Code[20]; xRecSem: code[10]; xRecAcaYear: code[20]; xRecTerm: Text[50]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CourseSemMaster?CourseCode=%1&SemesterCode=%2&AcademicYear=%3&StartDate=%4&EndDate=%5&Promoted=%6&GlobalDimension1Code=%7&GlobalDimension2Code=%8&TypeOfCourse=%9&FinalYearsCourse=%10&UserID=%11&PortalID=%12&Updated=%13&SequenceNo=%14&Term=%15&MSPEApplication=%16&StartDateNotApplicable=%17&FeeDueDate=%18&NewOLRStartDate=%19&NewOLREndDate=%20&ReturningOLRStartDate=%21&ReturningOLREndDate=%22&ElectiveOffering=%23&OldCourseCode=%24&OldSemesterCode=%25&OldAcademicYear=%26&OldTerm=%27&Delete=%28', Rec."Course Code", Rec."Semester Code", Rec."Academic Year", FORMAT(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), HandlingBoolean(Rec.Promoted), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec.Updated), Rec."Sequence No", HandlingOption(Rec.Term), HandlingBoolean(Rec."MSPE Application"), HandlingBoolean(Rec."Start Date Not Applicable"), Format(Rec."Fee Due Date", 0, 9), Format(Rec."New OLR Start Date", 0, 9), Format(Rec."New OLR End Date", 0, 9), Format(Rec."Returning OLR Start Date", 0, 9), Format(Rec."Returning OLR End Date", 0, 9), HandlingBoolean(Rec."Elective Offering"), xRecCourseCode, xRecSem, xRecAcaYear, xRecTerm, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Course Sem. Master-CS Stop

    //Course Wise Subject Head-CS Start
    [EventSubscriber(ObjectType::Table, 50059, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectHeadOnModify(VAR Rec: Record "Course Wise Subject Head-CS"; VAR xRec: Record "Course Wise Subject Head-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectHeadCSFunction(Rec, '', '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50059, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectHeadOnRename(VAR Rec: Record "Course Wise Subject Head-CS"; VAR xRec: Record "Course Wise Subject Head-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectHeadCSFunction(Rec, xRec.Course, xRec.Semester, xRec."Academic Year", xRec.Year, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50059, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectHeadOnDelete(VAR Rec: Record "Course Wise Subject Head-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectHeadCSFunction(Rec, '', '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50059, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectHeadOnInsert(VAR Rec: Record "Course Wise Subject Head-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectHeadCSFunction(Rec, '', '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure CourseWiseSubjectHeadCSFunction(var Rec: Record "Course Wise Subject Head-CS"; xRecCourseCode: Code[20]; xRecSem: code[10]; xRecAcaYear: code[20]; xRecYear: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CourseWiseSubjectHead?Course=%1&Semester=%2&AcademicYear=%3&Year=%4&MinCreditPoints=%5&RegistrationFrom=%6&RegistrationTill=%7&GlobalDimension1Code=%8&GlobalDimension2Code=%9&CourseName=%10&TypeOfCourse=%11&IntExamGroupGenerated=%12&Promoted=%13&Program=%14&UserID=%15&PortalID=%16&AdmittedYear=%17&Updated=%18&OldCourse=%19&OldSemester=%20&OldAcademicYear=%21&OldYear=%22&Delete=%23', Rec.Course, Rec.Semester, Rec."Academic Year", Rec.Year, Rec."Min Credit Points", Format(Rec."Registration From", 0, 9), Format(Rec."Registration Till", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Course Name", HandlingOption(Rec."Type Of Course"), HandlingBoolean(Rec."Int. Exam Group Generated"), HandlingBoolean(Rec.Promoted), Rec.Program, Rec."User ID", Rec."Portal ID", Rec."Admitted Year", HandlingBoolean(Rec.Updated), xRecCourseCode, xRecSem, xRecAcaYear, xRecYear, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Course Wise Subject Head-CS Stop

    //Course Wise Subject Line-CS Start
    [EventSubscriber(ObjectType::Table, 50071, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectLineOnModify(VAR Rec: Record "Course Wise Subject Line-CS"; VAR xRec: Record "Course Wise Subject Line-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectLineCSFunction(Rec, '', '', '', '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50071, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectLineOnRename(VAR Rec: Record "Course Wise Subject Line-CS"; VAR xRec: Record "Course Wise Subject Line-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectLineCSFunction(Rec, xRec."Course Code", xRec.Semester, xRec."Academic Year", xRec.Year, xRec."Subject Code", Format(xRec."Line No."), 0, 'OnAfterRenameEvent')
    end;


    [EventSubscriber(ObjectType::Table, 50071, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectLineOnDelete(VAR Rec: Record "Course Wise Subject Line-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectLineCSFunction(Rec, '', '', '', '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50071, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_CourseWiseSubjectLineOnInsert(VAR Rec: Record "Course Wise Subject Line-CS"; RunTrigger: Boolean)

    begin
        CourseWiseSubjectLineCSFunction(Rec, '', '', '', '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure CourseWiseSubjectLineCSFunction(var Rec: Record "Course Wise Subject Line-CS"; xRecCourseCode: Code[20]; xRecSem: code[10]; xRecAcaYear: code[20]; xRecYear: Code[20]; xRecSubjectCode: Code[20]; xRecLineNo: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_CourseWiseSubjectLine?CourseCode=%1&Semester=%2&AcademicYear=%3&Year=%4&SubjectCode=%5&LineNo=%6&Description=%7&SubjectType=%8&GroupCode=%9&InternalMaximum=%10&ExamFee=%11&Credit=%12&Capacity=%13&WeeklyHours=%14&SubjectClassification=%15&Selected=%16&PreferenceHours=%17&MaxHoursPerDay=%18&FacultyCode=%19&CombinationCode=%20&ExternalPass=%21&ExternalMaximum=%22&TotalPass=%23&TotalMaximum=%24&Specilization=%25&MinimumPassingMarks=%26&GlobalDimension1Code=%27&GlobalDimension2Code=%28&TypeOfCourse=%29&FinalYearsCourse=%30&Section=%31&StudentGroup=%32&StudentBatch=%33&ElectiveGroupCode=%34&ProgramOpenElectiveTemp=%35&ReRegistration=%36&ReApply=%37&ExamScheduleCreated=%38&IntExamGroupGenerated=%39&IntExamGenerated=%40&AssignmentGenerated=%41&Updated=%42&Program=%43&CourseFacultyGenerated=%44&ExternalExamGenerated=%45&AuditSubject=%46&ApplicableBatch=%47&NumberofLabComponent=%48&MinCapacity=%49&MaxCapacityUG=%50&MaxCapacityPG=%51&CategoryCode=%52&CategoryDescription=%53&CourseDescription=%54&PartSemester=%55&Duration=%56&TypeofSubject=%57&AdmittedYear=%58&SubjectGroup=%59&SubjectGroupDescription=%60&Level=%61&LevelDescription=%62&CoreRotationGroup=%63&Examination=%64&Term=%65&TermDescription=%66&OldCourseCode=%67&OldSemester=%68&OldAcademicYear=%69&OldYear=%70&OldSubjectCode=%71&OldLineNo=%72&Delete=%72', Rec."Course Code", Rec.Semester, Rec."Academic Year", Rec.Year, Rec."Subject Code", Rec."Line No.", Rec.Description, Rec."Subject Type", Rec."Group Code", Rec."Internal Maximum", Rec."Exam Fee", Rec.Credit, Rec.Capacity, Rec."Weekly Hours", Rec."Subject Classification", HandlingBoolean(Rec.Selected), Rec."Preference Hours", Rec."Max Hours Per Day", Rec."Faculty Code", Rec."Combination Code", Rec."External Pass", Rec."External Maximum", Rec."Total Pass", Rec."Total Maximum", Rec.Specilization, Rec."Minimum Passing Marks", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Section, Rec."Student Group", Rec."Student Batch", Rec."Elective Group Code", HandlingOption(Rec."Program/Open Elective Temp"), HandlingBoolean(Rec."Re-Registration"), HandlingBoolean(Rec."Re-Apply"), HandlingBoolean(Rec."Exam Schedule Created"), HandlingBoolean(Rec."Int. Exam Group Generated"), HandlingBoolean(Rec."Int. Exam Generated"), HandlingBoolean(Rec."Assignment Generated"), HandlingBoolean(Rec.Updated), Rec.Program, HandlingBoolean(Rec."Course Faculty Generated"), HandlingBoolean(Rec."External Exam Generated"), HandlingBoolean(Rec."Audit Subject"), Rec."Applicable Batch", Rec."Number of Lab Component", Rec."Min. Capacity", Rec."Max. Capacity UG", Rec."Max. Capacity PG", Rec."Category Code", Rec."Category Description", Rec."Course Description", Rec."Part/Semester", FORMAT(Rec.Duration), HandlingOption(Rec."Type of Subject"), Rec."Admitted Year", Rec."Subject Group", Rec."Subject Group Description", Rec.Level, HandlingOption(Rec."Level Description"), Rec."Core Rotation Group", HandlingBoolean(Rec.Examination), HandlingOption(Rec.Term), Rec."Term Description", xRecCourseCode, xRecSem, xRecAcaYear, xRecYear, xRecSubjectCode, xRecLineNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);

        end;
    end;
    //Course Wise Subject Line-CS STop

    //Employee Start
    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_EmployeeOnModify(VAR Rec: Record Employee; VAR xRec: Record Employee; RunTrigger: Boolean)
    begin
        EmployeeFunction(Rec, '', 0, 'OnAfterModifyEvent')
    End;

    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_EmployeeOnRename(VAR Rec: Record Employee; VAR xRec: Record Employee; RunTrigger: Boolean)
    begin
        EmployeeFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent')
    End;

    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_EmployeeOnDelete(VAR Rec: Record Employee; RunTrigger: Boolean)
    begin
        EmployeeFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    End;

    // [EventSubscriber(ObjectType::Table, 5200, 'OnAfterInsertEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Academics_EmployeeOnInsert(VAR Rec: Record Employee; RunTrigger: Boolean)
    // begin
    //     EmployeeFunction(Rec, '', 0, 'OnAfterInsertEvent')
    // End;

    procedure EmployeeFunction(var Rec: Record "Employee"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_Employee?No=%1&FirstName=%2&MiddleName=%3&LastName=%4&Initials=%5&JobTitle=%6&SearchName=%7&Address=%8&Address2=%9&City=%10&PostCode=%11&County=%12&PhoneNo=%13&MobilePhoneNo=%14&EMail=%15&AltAddressCode=%16&AltAddressStartDate=%17&AltAddressEndDate=%18&Picture=%19&BirthDate=%20&SocialSecurityNo=%21&UnionCode=%22&UnionMembershipNo=%23&Gender=%24&CountryRegionCode=%25&ManagerNo=%26&EmplymtContractCode=%27&StatisticsGroupCode=%28&EmploymentDate=%29&Status=%30&InactiveDate=%31&CauseofInactivityCode=%32&TerminationDate=%33&GroundsforTermCode=%34&GlobalDimension1Code=%35&GlobalDimension2Code=%36&ResourceNo=%37&LastDateModified=%38&Extension=%39&Pager=%40&FaxNo=%41&CompanyEMail=%42&Title=%43&SalespersPurchCode=%44&NoSeries=%45&CostCenterCode=%46&CostObjectCode=%47&LocationCode=%48&FullName=%49&JobTitleGrade=%50&EmployeeMachineCode=%51&ShiftPattern=%52&ShiftCodeonlyFixedShift=%53&WeeklyOffonlyFixedShift=%54&StartIn=%55&EndOut=%56&CompanyHolidayAllowed=%57&HOD=%58&JobTitleGradeDesc=%59&HODName=%60&BranchName=%61&HOD1=%62&HODName1=%63&DesignationCode=%64&EmployeePostingGroup=%65&DeparmentName=%66&State=%67&EmergencyContactPerson=%68&EmergencyPhoneNo=%69&WebPortalPassword=%70&WebportalAccess=%71&WebPortalType=%72&ProfilePhoto=%73&ChangePasswordStatus=%74&HR=%75&Finance=%76&GoogleSiteLink=%77&Updated=%78&EmployeeGroup=%79&Department=%80&ClinicalChair=%81&AdministrativeAssistant=%82&CancelClassAllowed=%83&RescheduleClassAllowed=%84&AzureServiceLink=%85&DeleteClassAllowed=%86&OldNo=%87&Delete=%88', Rec."No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec.Initials, Rec."Job Title", Rec."Search Name", Rec.Address, Rec."Address 2", Rec.City, Rec."Post Code", Rec.County, Rec."Phone No.", Rec."Mobile Phone No.", Rec."E-Mail", Rec."Alt. Address Code", Format(Rec."Alt. Address Start Date", 0, 9), Format(Rec."Alt. Address End Date", 0, 9), '', Format(Rec."Birth Date", 0, 9), Rec."Social Security No.", Rec."Union Code", Rec."Union Membership No.", HandlingOption(Rec.Gender), Rec."Country/Region Code", Rec."Manager No.", Rec."Emplymt. Contract Code", Rec."Statistics Group Code", Format(Rec."Employment Date", 0, 9), HandlingOption(Rec.Status), Format(Rec."Inactive Date", 0, 9), Rec."Cause of Inactivity Code", Format(Rec."Termination Date", 0, 9), Rec."Grounds for Term. Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Resource No.", Format(Rec."Last Date Modified", 0, 9), Rec.Extension, Rec.Pager, Rec."Fax No.", Rec."Company E-Mail", Rec.Title, Rec."Salespers./Purch. Code", Rec."No. Series", Rec."Cost Center Code", Rec."Cost Object Code", Rec."Location Code", Rec."Full Name", Rec."Job Title/Grade", Rec."Employee Machine Code", HandlingOption(Rec."Shift Pattern"), Rec."Shift Code only Fixed Shift", HandlingOption(Rec."Weekly Off only Fixed Shift"), Rec."Start In", Rec."End Out", HandlingOption(Rec."Company Holiday Allowed"), Rec.HOD, Rec."Job Title/Grade Desc", Rec."HOD Name", Rec."Branch Name", Rec."HOD 1", Rec."HOD Name 1", Rec."Designation Code", Rec."Employee Posting Group", Rec."Deparment Name", Rec.State, Rec."Emergency Contact Person", Rec."Emergency Phone No.", Rec."Web Portal Password", HandlingBoolean(Rec."Web portal Access"), HandlingOption(Rec."Web Portal Type"), Rec."ProfilePhoto", HandlingBoolean(Rec."Change_PasswordStatus"), Rec.HR, Rec.Finance, Rec."Google Site Link", HandlingBoolean(Rec.Updated), Rec."Employee Group", HandlingOption(Rec.Department), HandlingBoolean(Rec."Clinical Chair"), HandlingBoolean(Rec."Administrative Assistant"), HandlingBoolean(Rec."Cancel Class Allowed"), HandlingBoolean(Rec."Reschedule Class Allowed"), Rec."Azure Service Link", HandlingBoolean(Rec."Delete Class Allowed"), xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);

        end;
    end;
    //Employee Stop
    //Exam Time Table Head-CS Start
    //Exam Time Table Head-CS Start
    [EventSubscriber(ObjectType::Table, 50288, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ExamTimeTableHeadOnModify(VAR Rec: Record "Exam Time Table Head-CS"; VAR xRec: Record "Exam Time Table Head-CS"; RunTrigger: Boolean)
    var

    begin
        ExamTimeTableHeadCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    End;

    [EventSubscriber(ObjectType::Table, 50288, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ExamTimeTableHeadOnInsert(VAR Rec: Record "Exam Time Table Head-CS"; RunTrigger: Boolean)
    var

    begin
        ExamTimeTableHeadCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    End;

    [EventSubscriber(ObjectType::Table, 50288, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ExamTimeTableHeadOnRename(VAR Rec: Record "Exam Time Table Head-CS"; VAR xRec: Record "Exam Time Table Head-CS"; RunTrigger: Boolean)
    var

    begin
        ExamTimeTableHeadCSFunction(Rec, xrec."No.", 0, 'OnAfterRenameEvent')
    End;

    [EventSubscriber(ObjectType::Table, 50288, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ExamTimeTableHeadOnDelete(VAR Rec: Record "Exam Time Table Head-CS"; RunTrigger: Boolean)
    var

    begin
        ExamTimeTableHeadCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    End;

    procedure ExamTimeTableHeadCSFunction(var Rec: Record "Exam Time Table Head-CS"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_ExamTimeTableHead?No=%1&Date=%2&ExamType=%3&ExamMethod=%4&ExamSlot=%5&NoSeries=%6&AcademicYear=%7&StartTime=%8&EndTime=%9&ExamClassification=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&ExtExamAttendanceNo=%13&UserID=%14&PortalID=%15&Status=%16&LastModifyDate=%17&SubjectClassification=%18&Updated=%19&CreatedBy=%20&CreatedOn=%21&UpdatedBy=%22&UpdatedOn=%23&OldNo=%24&Delete=%25', Rec."No.", Format(Rec.Date, 0, 9), HandlingOption(Rec."Exam Type"), Rec."Exam Method", Rec."Exam Slot", Rec."No. Series", Rec."Academic Year", Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), Rec."Exam Classification", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Ext Exam Attendance No.", Rec."User ID", Rec."Portal ID", HandlingOption(Rec.Status), Format(Rec."Last Modify Date", 0, 9), Rec."Subject Classification", HandlingBoolean(Rec.Updated), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), xRecNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Exam Time Table Head-CS Stop

    //Exam Time Table Head-CS Stop

    //Faculty Assessment Question-CS Start

    [EventSubscriber(ObjectType::Table, 50111, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FacultyAssessmentQuestionOnModify(VAR Rec: Record "Faculty Assessment Question-CS"; VAR xRec: Record "Faculty Assessment Question-CS"; RunTrigger: Boolean)

    begin
        FacultyAssessmentQuestionCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50111, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FacultyAssessmentQuestionOnRename(VAR Rec: Record "Faculty Assessment Question-CS"; VAR xRec: Record "Faculty Assessment Question-CS"; RunTrigger: Boolean)

    begin
        FacultyAssessmentQuestionCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50111, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FacultyAssessmentQuestionOnDelete(VAR Rec: Record "Faculty Assessment Question-CS"; RunTrigger: Boolean)

    begin
        FacultyAssessmentQuestionCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50111, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FacultyAssessmentQuestionOnInsert(VAR Rec: Record "Faculty Assessment Question-CS"; RunTrigger: Boolean)

    begin
        FacultyAssessmentQuestionCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure FacultyAssessmentQuestionCSFunction(var Rec: Record "Faculty Assessment Question-CS"; xRecCode: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_FacultyAssessmentQuestion?Code=%1&Question=%2&Updated=%3&TypeofQuestion=%4&OldCode=%5&Delete=%6', Rec.Code, Rec.Question, HandlingBoolean(Rec.Updated), HandlingOption(Rec."Type of Question"), xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Faculty Assessment Question-CS Stop
    //File Attachment-CS Start
    [EventSubscriber(ObjectType::Table, 50257, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FileAttachmentOnModify(VAR Rec: Record "File Attachment-CS"; VAR xRec: Record "File Attachment-CS"; RunTrigger: Boolean)
    var

    begin
        FileAttachmentCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50257, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FileAttachmentOnRename(VAR Rec: Record "File Attachment-CS"; VAR xRec: Record "File Attachment-CS"; RunTrigger: Boolean)
    var

    begin
        FileAttachmentCSFunction(Rec, xRec.Code, 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50257, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FileAttachmentOnDelete(VAR Rec: Record "File Attachment-CS"; RunTrigger: Boolean)
    var

    begin
        FileAttachmentCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50257, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_FileAttachmentOnInsert(VAR Rec: Record "File Attachment-CS"; RunTrigger: Boolean)
    var

    begin
        FileAttachmentCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure FileAttachmentCSFunction(var Rec: Record "File Attachment-CS"; xRecCode: Code[250]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_FileAttachment?Code=%1&Description=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&UserID=%5&PortalID=%6&UserGroup=%7&Updated=%8&OldCode=%9&Delete=%10', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", Rec."User Group", HandlingBoolean(Rec.Updated), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //File Attachment-CS Stop
    //Graduation Master-CS Start
    [EventSubscriber(ObjectType::Table, 50078, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_GraduationMasterOnModify(VAR Rec: Record "Graduation Master-CS"; VAR xRec: Record "Graduation Master-CS"; RunTrigger: Boolean)
    var

    begin
        GraduationMasterCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50078, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_GraduationMasterOnRename(VAR Rec: Record "Graduation Master-CS"; VAR xRec: Record "Graduation Master-CS"; RunTrigger: Boolean)
    var

    begin
        GraduationMasterCSFunction(Rec, xRec.Code, 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50078, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_GraduationMasterOnDelete(VAR Rec: Record "Graduation Master-CS"; RunTrigger: Boolean)
    var
    begin
        GraduationMasterCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50078, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_GraduationMasterOnInsert(VAR Rec: Record "Graduation Master-CS"; RunTrigger: Boolean)
    var

    begin
        GraduationMasterCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    procedure GraduationMasterCSFunction(var Rec: Record "Graduation Master-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_GraduationMaster?Code=%1&Description=%2&AcademicYear=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&UserID=%6&PortalID=%7&Updated=%8&OldCode=%9&Delete=%10', Rec.Code, Rec.Description, Rec."Academic Year", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec.Updated), xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Graduation Master-CS Stop

    //Post Code Start
    [EventSubscriber(ObjectType::Table, 225, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PostCodeOnModify(VAR Rec: Record "Post Code"; VAR xRec: Record "Post Code"; RunTrigger: Boolean)
    var

    begin
        PostCodeFunction(rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 225, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PostCodeOnRename(VAR Rec: Record "Post Code"; VAR xRec: Record "Post Code"; RunTrigger: Boolean)
    var

    begin
        PostCodeFunction(rec, xRec.Code, xRec.City, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 225, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PostCodeOnDelete(VAR Rec: Record "Post Code"; RunTrigger: Boolean)
    var

    begin
        PostCodeFunction(rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 225, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PostCodeOnInsert(VAR Rec: Record "Post Code"; RunTrigger: Boolean)
    var

    begin
        PostCodeFunction(rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure PostCodeFunction(var Rec: Record "Post Code"; xRecCode: Code[20]; xRecCity: Text[30]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            // URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_PostCode?Code=%1&City=%2&SearchCity=%3&CountryRegionCode=%4&County=%5&State=%6&District=%7&StateDescription=%8&TimeZone=%9', Rec.Code, Rec.City, Rec."Search City", Rec."Country/Region Code", Rec.County, Rec.County, Rec."State Description", Rec.County, Rec."Time Zone");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_PostCode?Code=%1&City=%2&SearchCity=%3&CountryRegionCode=%4&County=%5&State=%6&District=%7&StateDescription=%8&TimeZone=%9&OldCode=%10&OldCity=%11&Delete=%12', Rec.Code, Rec.City, Rec."Search City", Rec."Country/Region Code", Rec.County, Rec.County, Rec."District 3", Rec."State Description 3", Rec."Time Zone", xRecCode, xRecCity, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Post Code Stop

    //Promotion Line-CS Start
    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PromotionLineOnModify(VAR Rec: Record "Promotion Line-CS"; VAR xRec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PromotionLineOnRename(VAR Rec: Record "Promotion Line-CS"; VAR xRec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineCSFunction(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PromotionLineOnDelete(VAR Rec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50093, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_PromotionLineOnInsert(VAR Rec: Record "Promotion Line-CS"; RunTrigger: Boolean)
    begin
        PromotionLineCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure PromotionLineCSFunction(var Rec: Record "Promotion Line-CS"; xRecDocu: Code[20]; xRecLineNo: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_PromotionLine?DocumentNo=%1&LineNo=%2&StudentNo=%3&CourseCode=%4&Semester=%5&StudentName=%6&InActive=%7&Section=%8&AcademicYear=%9&GraduationCode=%10&DepartmentCode=%11&GlobalDimension1Code=%12&GlobalDimension2Code=%13&TypeOfCourse=%14&FinalYearsCourse=%15&NotEligible=%16&Session=%17&Order=%18&Year=%19&StudentPromoted=%20&EnrollmentNo=%21&Credit=%22&PromotedYear=%23&PromotedSemester=%24&PromotedAcademicYear=%25&Graduated=%26&CreatedBy=%27&CreatedOn=%28&ModifiedBy=%29&ModifiedOn=%30&FeeGenerated=%31&Group=%32&PromotedToGroup=%33&LateralStudent=%34&OldDocumentNo=%35&OldLineNo=%36&Delete=%37', Rec."Document No.", Rec."Line No.", Rec."Student No.", Rec."Course Code", Rec.Semester, Rec."Student Name", HandlingBoolean(Rec."In Active"), Rec.Section, Rec."Academic Year", Rec."Graduation Code", Rec."Department Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", HandlingBoolean(Rec."Not Eligible"), Rec.Session, Rec.Order, Rec.Year, HandlingBoolean(Rec."Student Promoted"), Rec."Enrollment No.", Rec.Credit, Rec."Promoted Year", Rec."Promoted Semester", Rec."Promoted  Academic Year", HandlingBoolean(Rec.Graduated), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec."Fee Generated"), Rec.Group, Rec."Promoted To Group", HandlingBoolean(Rec."Lateral Student"), xRecDocu, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Promotion Line-CS Stop
    //Qualifying Detail Stud-CS Start
    [EventSubscriber(ObjectType::Table, 50113, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_QualifyingDetailStudOnModify(VAR Rec: Record "Qualifying Detail Stud-CS"; VAR xRec: Record "Qualifying Detail Stud-CS"; RunTrigger: Boolean)
    var

    begin
        QualifyingDetailStudCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50113, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_QualifyingDetailStudOnRename(VAR Rec: Record "Qualifying Detail Stud-CS"; VAR xRec: Record "Qualifying Detail Stud-CS"; RunTrigger: Boolean)
    var

    begin
        QualifyingDetailStudCSFunction(Rec, xRec."Student No.", xRec."SLcM ID", 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50113, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_QualifyingDetailStudOnDelete(VAR Rec: Record "Qualifying Detail Stud-CS"; RunTrigger: Boolean)
    var

    begin
        QualifyingDetailStudCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50113, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_QualifyingDetailStudOnInsert(VAR Rec: Record "Qualifying Detail Stud-CS"; RunTrigger: Boolean)
    var

    begin
        QualifyingDetailStudCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;


    procedure QualifyingDetailStudCSFunction(var Rec: Record "Qualifying Detail Stud-CS"; xRecStuNo: Code[20]; xRecSLcmId: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_QualifyingDetailStud?StudentNo=%1&SLcMID=%2&QualifyingExam=%3&QualifyingYearofPassing=%4&ExamMarksGradePoints=%5&CollegelastStudied=%6&UniversityBoard=%7&GlobalDimension1Code=%8&GlobalDimension2Code=%9&OptionalSubjectName=%10&Updated=%11&EighteenDigitTestID=%12&Test=%13&EighteenDigitStudentID=%14&MCATTestScore=%15&NBMECompTestScore=%16&NewMCAT2015TestScore=%17&OverallScore=%18&MCATBiologicalScience=%19&MCATPhysicalScience=%20&MCATTotalScore=%21&MCATVerbalReasoning=%22&MCATWriting=%23&TestDate=%24&USMLEStep1Score=%25&USMLEStep2CKScore=%26&USMLEStep2CSScore=%27&USMLETestScore=%28&OldStudentNo=%29&OldSLcMID=%30&Delete=%31', Rec."Student No.", Rec."SLcM ID", Rec."Qualifying Exam", Rec."Qualifying Year of Passing", Rec."Exam Marks/Grade/Points", Rec."College last Studied", Rec."University/Board", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Optional Subject Name", HandlingBoolean(Rec.Updated), Rec."18 Digit Test ID", Rec.Test, Rec."18 Digit Student ID", Rec."MCAT Test Score", Rec."NBME Comp Test Score", Rec."New MCAT 2015 Test Score", Rec."Overall Score", Rec."MCAT Biological Science", Rec."MCAT Physical Science", Rec."MCAT Total Score", Rec."MCAT Verbal Reasoning", Rec."MCAT Writing", FORMAT(Rec."Test Date", 0, 9), Rec."USMLE Step 1 Score", Rec."USMLE Step 2 CK Score", Rec."USMLE Step 2 CS Score", Rec."USMLE Test Score", xRecStuNo, xRecSLcmId, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Qualifying Detail Stud-CS Stop
    //Reason Code Start
    [EventSubscriber(ObjectType::Table, 231, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ReasonMasterOnModify(VAR Rec: Record "Reason Code"; VAR xRec: Record "Reason Code"; RunTrigger: Boolean)
    var
    begin
        ReasonCodeFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 231, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ReasonMasterOnRename(VAR Rec: Record "Reason Code"; VAR xRec: Record "Reason Code"; RunTrigger: Boolean)
    var
    begin
        ReasonCodeFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 231, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ReasonMasterOnDelete(VAR Rec: Record "Reason Code"; RunTrigger: Boolean)
    var
    begin
        ReasonCodeFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 231, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ReasonMasterOnInsert(VAR Rec: Record "Reason Code"; RunTrigger: Boolean)
    var
    begin
        ReasonCodeFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure ReasonCodeFunction(var Rec: Record "Reason Code"; xRecCode: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_ReasonMaster?ReasonCode=%1&ReasonDescription=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&CreatedOn=%5&UpdatedBy=%6&UpdatedOn=%7&UpdatedByName=%8&CreatedByName=%9&ReasonType=%10&OldReasonCode=%11&Delete=%12', Rec.Code, Rec.Description, '', '', FORMAT(Today(), 0, 9), UserId(), '', '', '', HandlingOption(Rec.Type), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Reason Code Stop
    //Relative Start
    [EventSubscriber(ObjectType::Table, 5204, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RelativeOnModify(VAR Rec: Record Relative; VAR xRec: Record Relative; RunTrigger: Boolean)

    begin
        RelativeFunction(rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 5204, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RelativeOnRename(VAR Rec: Record Relative; VAR xRec: Record Relative; RunTrigger: Boolean)

    begin
        RelativeFunction(rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 5204, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RelativeOnDelete(VAR Rec: Record Relative; RunTrigger: Boolean)

    begin
        RelativeFunction(rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 5204, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RelativeOnInsert(VAR Rec: Record Relative; RunTrigger: Boolean)

    begin
        RelativeFunction(rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure RelativeFunction(var Rec: Record "Relative"; xRecCode: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_Relative?Code=%1&Description=%2&Updated=%3&OldCode=%4&Delete=%5', Rec.Code, Rec.Description, HandlingBoolean(Rec.Updated), xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Relative Stop

    //Section Master-CS Start
    [EventSubscriber(ObjectType::Table, 50034, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SectionMasterOnModify(VAR Rec: Record "Section Master-CS"; VAR xRec: Record "Section Master-CS"; RunTrigger: Boolean)
    var


    begin
        SectionMasterCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50034, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SectionMasterOnRename(VAR Rec: Record "Section Master-CS"; VAR xRec: Record "Section Master-CS"; RunTrigger: Boolean)

    begin
        SectionMasterCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50034, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SectionMasterOnDelete(VAR Rec: Record "Section Master-CS"; RunTrigger: Boolean)
    begin
        SectionMasterCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50034, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SectionMasterOnInsert(VAR Rec: Record "Section Master-CS"; RunTrigger: Boolean)
    begin
        SectionMasterCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure SectionMasterCSFunction(var Rec: Record "Section Master-CS"; xRecCode: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SectionMaster?Code=%1&Description=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&UserID=%5&PortalID=%6&Group=%7&SequenceNo=%8&Updated=%9&TimeTableGenerated=%10&TemplateNo=%11&Capacity=%12&OldCode=%13&Delete=%14', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", Rec.Group, Rec."Sequence No", HandlingBoolean(Rec.Updated), HandlingBoolean(Rec."Time Table Generated"), Rec."Template No.", Rec.Capacity, xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Section Master-CS Stop
    //Semester Master-CS Start
    [EventSubscriber(ObjectType::Table, 50056, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SemesterMasterOnModify(VAR Rec: Record "Semester Master-CS"; VAR xRec: Record "Semester Master-CS"; RunTrigger: Boolean)
    var

    begin
        SemesterMasterCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50056, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SemesterMasterOnRename(VAR Rec: Record "Semester Master-CS"; VAR xRec: Record "Semester Master-CS"; RunTrigger: Boolean)
    var

    begin
        SemesterMasterCSFunction(Rec, xRec.Code, xRec.Graduation, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50056, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SemesterMasterOnDelete(VAR Rec: Record "Semester Master-CS"; RunTrigger: Boolean)
    var

    begin
        SemesterMasterCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50056, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SemesterMasterOnInsert(VAR Rec: Record "Semester Master-CS"; RunTrigger: Boolean)
    var

    begin
        SemesterMasterCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure SemesterMasterCSFunction(var Rec: Record "Semester Master-CS"; xRecCode: Code[10]; xRecGrad: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SemesterMaster?Code=%1&Graduation=%2&Description=%3&Order=%4&Year=%5&GlobalDimension1Code=%6&GlobalDimension2Code=%7&SemesterCode=%8&UserID=%9&PortalID=%10&DepartmentName=%11&Sequence=%12&Updated=%13&OldCode=%14&OldGraduation=%15&Delete=%16', Rec.Code, Rec.Graduation, Rec.Description, Rec.Order, Rec.Year, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Semester Code", Rec."User ID", Rec."Portal ID", Rec."Department Name", Rec.Sequence, HandlingBoolean(Rec.Updated), xRecCode, xRecGrad, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Semester Master-CS Stop

    //Sessional Exam Group Head-CS Start
    [EventSubscriber(ObjectType::Table, 50101, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupHeadOnModify(VAR Rec: Record "Sessional Exam Group Head-CS"; VAR xRec: Record "Sessional Exam Group Head-CS"; RunTrigger: Boolean)

    begin
        SessionalExamGroupHeadCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50101, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupHeadOnRename(VAR Rec: Record "Sessional Exam Group Head-CS"; VAR xRec: Record "Sessional Exam Group Head-CS"; RunTrigger: Boolean)

    begin
        SessionalExamGroupHeadCSFunction(Rec, xRec."No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50101, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupHeadOnDelete(VAR Rec: Record "Sessional Exam Group Head-CS"; RunTrigger: Boolean)

    begin
        SessionalExamGroupHeadCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50101, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupHeadOnInsert(VAR Rec: Record "Sessional Exam Group Head-CS"; RunTrigger: Boolean)

    begin
        SessionalExamGroupHeadCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure SessionalExamGroupHeadCSFunction(var Rec: Record "Sessional Exam Group Head-CS"; xRecNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SessionalExamGroupHead?No=%1&CourseCode=%2&Semester=%3&SubjectType=%4&SubjectCode=%5&Section=%6&AcademicYear=%7&NoSeries=%8&ExamGroup=%9&ResultGenerated=%10&GlobalDimension1Code=%11&GlobalDimension2Code=%12&TypeOfCourse=%13&FinalYearsCourse=%14&Year=%15&InternalEvaluationMethod=%16&InternalMaximum=%17&UserID=%18&PortalID=%19&SubjectClass=%20&CreatedBy=%21&CreatedOn=%22&ModifiedBy=%23&ModifiedOn=%24&Status=%25&Updated=%26&Program=%27&OldNo=%28&Delete=%29', Rec."No.", Rec."Course Code", Rec.Semester, Rec."Subject Type", Rec."Subject Code", Rec.Section, Rec."Academic Year", Rec."No.Series", Rec."Exam Group", HandlingBoolean(Rec."Result Generated"), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Year, HandlingOption(Rec."Internal Evaluation Method"), Rec."Internal Maximum", Rec."User ID", Rec."Portal ID", Rec."Subject Class", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9), HandlingOption(Rec.Status), HandlingBoolean(Rec.Updated), Rec.Program, xRecNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Sessional Exam Group Head-CS STop
    //Sessional Exam Group Line-CS STart
    [EventSubscriber(ObjectType::Table, 50002, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupLineOnModify(VAR Rec: Record "Sessional Exam Group Line-CS"; VAR xRec: Record "Sessional Exam Group Line-CS"; RunTrigger: Boolean)
    var

    begin
        SessionalExamGroupLineCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50002, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupLineOnRename(VAR Rec: Record "Sessional Exam Group Line-CS"; VAR xRec: Record "Sessional Exam Group Line-CS"; RunTrigger: Boolean)
    var

    begin
        SessionalExamGroupLineCSFunction(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50002, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupLineOnDElete(VAR Rec: Record "Sessional Exam Group Line-CS"; RunTrigger: Boolean)
    var

    begin
        SessionalExamGroupLineCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50002, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SessionalExamGroupLineOnInsert(VAR Rec: Record "Sessional Exam Group Line-CS"; RunTrigger: Boolean)
    var

    begin
        SessionalExamGroupLineCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure SessionalExamGroupLineCSFunction(var Rec: Record "Sessional Exam Group Line-CS"; xRecDocument: Code[20]; XrecLineNO: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SessionalExamGroupLine?DocumentNo=%1&LineNo=%2&Course=%3&Semester=%4&SubjectType=%5&SubjectCode=%6&Section=%7&Academicyear=%8&ExamGroup=%9&ExamMethod=%10&MaximumMarks=%11&Order=%12&Weightage=%13&MethodDescription=%14&GlobalDimension1Code=%15&GlobalDimension2Code=%16&TypeOfCourse=%17&FinalYearsCourse=%18&Year=%19&UserID=%20&PortalID=%21&CreatedBy=%22&CreatedOn=%23&ModifiedBy=%24&ModifiedOn=%25&MarksPublished=%26&Updated=%27&Program=%28&OldDocumentNo=%29&OldLineNo=%30&Delete=%31', Rec."Document No.", Rec."Line No.", Rec.Course, Rec.Semester, Rec."Subject Type", Rec."Subject Code", Rec.Section, Rec."Academic Year", Rec."Exam Group", Rec."Exam Method", Rec."Maximum Marks", Rec.Order, Rec.Weightage, Rec."Method Description", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Year, Rec."User ID", Rec."Portal ID", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec."Marks Published"), HandlingBoolean(Rec.Updated), Rec.Program, xRecDocument, XrecLineNO, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Sessional Exam Group Line-CS Stop
    //Student Achievement-CS Start
    [EventSubscriber(ObjectType::Table, 50231, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_StudentAchievementOnModify(VAR Rec: Record "Student Achievement-CS"; VAR xRec: Record "Student Achievement-CS"; RunTrigger: Boolean)

    begin
        StudentAchievementCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50231, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_StudentAchievementOnRename(VAR Rec: Record "Student Achievement-CS"; VAR xRec: Record "Student Achievement-CS"; RunTrigger: Boolean)

    begin
        StudentAchievementCSFunction(Rec, xRec."Student No", Format(xRec."Line No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50231, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_StudentAchievementOnDelete(VAR Rec: Record "Student Achievement-CS"; RunTrigger: Boolean)

    begin
        StudentAchievementCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50231, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_StudentAchievementOnInsert(VAR Rec: Record "Student Achievement-CS"; RunTrigger: Boolean)

    begin
        StudentAchievementCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure StudentAchievementCSFunction(var Rec: Record "Student Achievement-CS"; xRecStudNo: Code[20]; XrecLineNo: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_StudentAchievement?StudentNo=%1&LineNo=%2&Enrollment=%3&RollNo=%4&Semester=%5&AcademicYear=%6&Course=%7&Date=%8&Description=%9&Extension=%10&FileName=%11&Type=%12&CreatedBy=%13&CreatedDate=%14&UpdatedBy=%15&UpdatedDate=%16&StudentName=%17&AttachmentNo=%18&OldStudentNo=%19&OldLineNo=%20&Delete=%21', Rec."Student No", Rec."Line No", Rec.Enrollment, Rec."Roll No", Rec.Semester, Rec."Academic Year", Rec.Course, Format(Rec.Date, 0, 9), Rec.Description, Rec.Extension, Rec."File Name", HandlingOption(Rec.Type), Rec."Created By", FORMAT(Rec."Created Date", 0, 9), Rec."Updated By", FORMAT(Rec."Updated Date", 0, 9), Rec."Student Name", Rec."Attachment No.", xRecStudNo, XrecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Student Achievement-CS Stop
    //Subject Classification-CS Start
    [EventSubscriber(ObjectType::Table, 50074, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectClassificationOnModify(VAR Rec: Record "Subject Classification-CS"; VAR xRec: Record "Subject Classification-CS"; RunTrigger: Boolean)

    begin
        SubjectClassificationCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50074, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectClassificationOnRename(VAR Rec: Record "Subject Classification-CS"; VAR xRec: Record "Subject Classification-CS"; RunTrigger: Boolean)

    begin
        SubjectClassificationCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50074, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectClassificationOnDelete(VAR Rec: Record "Subject Classification-CS"; RunTrigger: Boolean)

    begin
        SubjectClassificationCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50074, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectClassificationOnnsert(VAR Rec: Record "Subject Classification-CS"; RunTrigger: Boolean)

    begin
        SubjectClassificationCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure SubjectClassificationCSFunction(var Rec: Record "Subject Classification-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SubjectClassification?Code=%1&Description=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&ShowInternalMarks=%5&ShowExternalMarks=%6&LastSemesterEvaluation=%7&AttendanceNotApplicable=%8&ExternalPassNotMandatory=%9&IntExamNotApplicable=%10&GradingRule=%11&RevaluationApplicable=%12&UserID=%13&PortalID=%14&RoomAllocation=%15&Invigilator=%16&HallTicket=%17&Updated=%18&OldCode=%19&Delete=%20', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec."Show Internal Marks"), HandlingBoolean(Rec."Show External Marks"), HandlingBoolean(Rec."Last Semester Evaluation"), HandlingBoolean(Rec."Attendance Not Applicable"), HandlingBoolean(Rec."External Pass Not Mandatory"), HandlingBoolean(Rec."Int. Exam Not Applicable"), HandlingOption(Rec."Grading Rule"), HandlingBoolean(Rec."Revaluation Applicable"), Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec."Room Allocation"), HandlingBoolean(Rec.Invigilator), HandlingBoolean(Rec."Hall Ticket"), HandlingBoolean(Rec.Updated), xRecCode, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Subject Classification-CS Stop

    //Subject Master-CS Start
    [EventSubscriber(ObjectType::Table, 50058, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectMasterOnModify(VAR Rec: Record "Subject Master-CS"; VAR xRec: Record "Subject Master-CS"; RunTrigger: Boolean)

    begin
        SubjectMasterCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50058, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectMasterOnRename(VAR Rec: Record "Subject Master-CS"; VAR xRec: Record "Subject Master-CS"; RunTrigger: Boolean)

    begin
        SubjectMasterCSFunction(Rec, xRec.Code, xRec.Course, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50058, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectMasterOnDelete(VAR Rec: Record "Subject Master-CS"; RunTrigger: Boolean)

    begin
        SubjectMasterCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50058, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectMasterOnInsert(VAR Rec: Record "Subject Master-CS"; RunTrigger: Boolean)

    begin
        SubjectMasterCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure SubjectMasterCSFunction(var Rec: Record "Subject Master-CS"; xRecCode: Code[20]; xRecCourse: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SubjectMaster?Code=%1&Course=%2&Description=%3&AcademicYear=%4&SubjectType=%5&SubjectClassification=%6&Credit=%7&MinCapacity=%8&GroupCode=%9&InternalMaximum=%10&ExternalPass=%11&ExternalMaximum=%12&TotalPass=%13&TotalMaximum=%14&ExamFee=%15&InternalSubjectCode=%16&MaxCapacityUG=%17&MaxCapacityPG=%18&GlobalDimension1Code=%19&GlobalDimension2Code=%20&Semester=%21&TypeOfCourse=%22&Year=%23&ElectiveGroupCode=%24&SubjectClosed=%25&AuditSubject=%26&ProgramOpenElectiveTemp=%27&Assignmaxmarks=%28&AssigmentCalculation=%29&Updated=%30&InternalPass=%31&ApplicableBatch=%32&NumberofLabComponent=%33&SubjectWiseExamination=%34&ReApply=%35&SubjectNotRequired=%36&MobileInsert=%37&MobileUpdate=%38&CommonSubject=%39&Specilization=%40&UserID=%41&PortalID=%42&CategoryCode=%43&CategoryDescription=%44&CourseDescription=%45&PartSemester=%46&Duration=%47&TypeofSubject=%48&SubjectGroup=%49&SubjectGroupDescription=%50&Level=%51&LevelDescription=%52&CoreRotationGroup=%53&Examination=%54&SubjectPrefix=%55&ExamOptOut=%56&MaxCapacityofLab=%57&AttendanceNotApplicable=%58&LevelCode=%59&ElectiveOffering=%60&OldCode=%61&OldCourse=%62&Delete=%63', Rec.Code, Rec.Course, Rec.Description, Rec."Academic Year", Rec."Subject Type", Rec."Subject Classification", Rec.Credit, Rec."Min. Capacity", Rec."Group Code", Rec."Internal Maximum", Rec."External Pass", Rec."External Maximum", Rec."Total Pass", Rec."Total Maximum", Rec."Exam Fee", Rec."Internal Subject Code", Rec."Max. Capacity UG", Rec."Max. Capacity PG", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Semester, HandlingOption(Rec."Type Of Course"), Rec.Year, Rec."Elective Group Code", HandlingBoolean(Rec."Subject Closed"), HandlingBoolean(Rec."Audit Subject"), HandlingOption(Rec."Program/Open Elective Temp"), Rec."Assign max marks", Rec."Assigment Calculation", HandlingBoolean(Rec.Updated), Rec."Internal Pass", Rec."Applicable Batch", Rec."Number of Lab Component", HandlingBoolean(Rec."Subject Wise Examination"), HandlingBoolean(Rec."Re-Apply"), HandlingBoolean(Rec."Subject Not Required"), HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), HandlingBoolean(Rec."Common Subject"), Rec.Specilization, Rec."User ID", Rec."Portal ID", Rec."Category Code", Rec."Category Description", Rec."Course Description", Rec."Part/Semester", FORMAT(Rec.Duration), HandlingOption(Rec."Type of Subject"), Rec."Subject Group", Rec."Subject Group Description", Rec.Level, HandlingOption(Rec."Level Description"), Rec."Core Rotation Group", HandlingBoolean(Rec.Examination), Rec."Subject Prefix", HandlingBoolean(Rec."Exam Opt Out"), Rec."Max Capacity of Lab", HandlingBoolean(Rec."Attendance Not Applicable"), Rec."Level Code", HandlingBoolean(Rec."Elective Offering"), xRecCode, xRecCourse, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Subject Master-CS Stop

    //Subject Type-CS Start
    [EventSubscriber(ObjectType::Table, 50073, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectTypeOnModify(VAR Rec: Record "Subject Type-CS"; VAR xRec: Record "Subject Type-CS"; RunTrigger: Boolean)
    begin
        SubjectTypeCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50073, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectTypeOnRename(VAR Rec: Record "Subject Type-CS"; VAR xRec: Record "Subject Type-CS"; RunTrigger: Boolean)
    begin
        SubjectTypeCSFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50073, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectTypeOnDelete(VAR Rec: Record "Subject Type-CS"; RunTrigger: Boolean)
    begin
        SubjectTypeCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50073, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_SubjectTypeOnInsert(VAR Rec: Record "Subject Type-CS"; RunTrigger: Boolean)
    begin
        SubjectTypeCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure SubjectTypeCSFunction(var Rec: Record "Subject Type-CS"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_SubjectType?Code=%1&Description=%2&GlobalDimension1Code=%3&GlobalDimension2Code=%4&UserID=%5&PortalID=%6&Updated=%7&TypeofSubject=%8&OldCode=%9&Delete=%10', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec.Updated), HandlingOption(rec."Type of Subject"), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Subject Type-CS Stop

    //Certificates Application-CS Start
    [EventSubscriber(ObjectType::Table, 50081, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_ApplicationforCertificateProcessingOnModify(VAR Rec: Record "Certificates Application-CS"; VAR xRec: Record "Certificates Application-CS"; RunTrigger: Boolean)
    begin
        CertificatesApplicationCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50081, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_ApplicationforCertificateProcessingOnDelete(VAR Rec: Record "Certificates Application-CS"; RunTrigger: Boolean)
    begin
        CertificatesApplicationCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50081, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_ApplicationforCertificateProcessingOnRename(VAR Rec: Record "Certificates Application-CS"; VAR xRec: Record "Certificates Application-CS"; RunTrigger: Boolean)
    begin
        CertificatesApplicationCSFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50081, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_ApplicationforCertificateProcessingOnInsert(VAR Rec: Record "Certificates Application-CS"; RunTrigger: Boolean)
    begin
        CertificatesApplicationCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure CertificatesApplicationCSFunction(var Rec: Record "Certificates Application-CS"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;


    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ApplicationforCertificateProcessing?applicationno=%1&certificate=%2&status=%3&applicationdate=%4&studentno=%5&applicationcategory=%6&paymentamount=%7&purpose=%8&remark=%9&statusdate=%10&quantity=%11&globaldimension1code=%12&globaldimension2code=%13&statement=%14&collectingby=%15&couriertype=%16&couriercharges=%17&courierfeecode=%18&courieraddress=%19&filename=%20&filepath=%21&attachment=%22&updated=%23&approvedprinted=%24&lastprintdatetime=%25&noofprints=%26&enrollmentno=%27&coursecode=%28&studentname=%29&rankcertificate=%30&remark1=%31&userid=%32&portalid=%33&city=%34&state=%35&country=%36&zip=%37&email=%38&Oldapplicationno=%39&Delete=%40', Rec."Application No.", Rec.Certificate, HandlingOption(Rec.Status), FORMAT(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Application Category", Rec."Payment Amount", Rec.Purpose, Rec.Remark, FORMAT(Rec."Status Date", 0, 9), Rec.Quantity, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Statement, Rec."Collecting By", Rec."Courier Type", Rec."Courier Charges", Rec."Courier FeeCode", Rec."Courier Address", Rec."File Name", Rec."File Path", FORMAT(Rec.Attachment), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec."Approved/Printed"), FORMAT(Rec."Last Print Date/Time", 0, 9), Rec."No of Prints", Rec."Enrollment No.", Rec."Course Code", Rec."Student Name", HandlingOption(Rec."Rank Certificate"), Rec.Remark1, Rec."User Id", Rec."Portal ID", Rec.City, Rec.State, Rec."Country Code", Rec."Post Code", Rec."E-mail Address", xRecAppNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Certificates Application-CS STop
    //Opt Out Start
    [EventSubscriber(ObjectType::Table, 50363, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_BSICOptoutApproval_ProcessingOnModify(VAR Rec: Record "Opt Out"; VAR xRec: Record "Opt Out"; RunTrigger: Boolean)

    begin
        OptOutFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50363, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_BSICOptoutApproval_ProcessingOnRename(VAR Rec: Record "Opt Out"; VAR xRec: Record "Opt Out"; RunTrigger: Boolean)

    begin
        OptOutFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    end;


    [EventSubscriber(ObjectType::Table, 50363, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_BSICOptoutApproval_ProcessingOnInsert(VAR Rec: Record "Opt Out"; RunTrigger: Boolean)
    begin
        OptOutFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50363, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_BSICOptoutApproval_ProcessingOnDelete(VAR Rec: Record "Opt Out"; RunTrigger: Boolean)
    begin
        OptOutFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    procedure OptOutFunction(var Rec: Record "Opt Out"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        RecStudentMaster: Record "Student Master-CS";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        IF RecStudentMaster.Get(Rec."Student No.") then;//Term
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_BSICOptoutApproval_Processing?ApplicationNo=%1&ApplicationDate=%2&ApplicationType=%3&StudentNo=%4&StudentName=%5&EnrolmentNo=%6&AcademicYear=%7&Semester=%8&RestartingSemester=%9&GlobalDimension1Code=%10&GlobalDimension2Code=%11&Reason=%12&ReasonDescription=%13&Status=%14&ApprovedRejectedBy=%15&ApprovedRejectedOn=%16&NoSeries=%17&CreatedBy=%18&CreatedOn=%19&ModifiedBy=%20&ModifiedOn=%21&Subject1=%22&Subject2=%23&Subject3=%24&Subject4=%25&Subject5=%26&SubjectDescription1=%27&SubjectDescription2=%28&SubjectDescription3=%29&SubjectDescription4=%30&SubjectDescription5=%31&ApprovedConditionFailed=%32&Term=%33&Country=%34&State=%35&City=%36&PostalCode=%37&PercentageObtained=%38&Grade=%39&CourseCode=%40&ELOASLOANo=%41&ExamName=%42&ExamDate=%43&TypeOfRepeat=%44&ApplicationUsed=%45&PresentAddress1=%46&PresentAddress2=%47&PresentAddress3=%48&LeaseAgreementContractNo=%49&LeaseAgreementGroup=%50&Transportation=%51&TransportCell=%52&SemesterStartDate=%53&SemesterEndDate=%54&OldApplicationNo=%55&Delete=%56', Rec."Application No.", FORMAT(Rec."Application Date", 0, 9), HandlingOption(Rec."Application Type"), Rec."Student No.", Rec."Student Name", Rec."Enrolment No.", Rec."Academic Year", Rec.Semester, '', rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Reason, Rec."Reason Description", HandlingOption(Rec.Status), Rec."Approved/Rejected By", FORMAT(Rec."Approved/Rejected On", 0, 9), Rec."No. Series", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."Subject 1", Rec."Subject 2", Rec."Subject 3", Rec."Subject 4", Rec."Subject 5", Rec."Subject Description 1", Rec."Subject Description 2", Rec."Subject Description 3", Rec."Subject Description 4", Rec."Subject Description 5", HandlingBoolean(Rec."Approved Condition Failed"), HandlingOption(Rec.Term), Rec.Country, Rec.County, Rec.City, Rec."Post Code", FORMAT(Rec."Percentage Obtained", 0, 1), Rec.Grade, Rec."Course Code", Rec."ELOA/SLOA No.", Rec."Exam Name", FORMAT(Rec."Exam Date", 0, 9), HandlingOption(Rec."Type Of Repeat"), HandlingBoolean(Rec."Application Used"), Rec."Present Address1", rec."Present Address2", rec."Present Address3", rec."Lease Agreement/Contract No.", Rec."Lease Agreement Group", HandlingBoolean(Rec.Transportation), Rec."Transport Cell", FORMAT(Rec."Semester Start Date", 0, 9), FORMAT(Rec."Semester End Date", 0, 9), xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Opt Out Stop

    //Clinical Required Dcouments Start
    // [EventSubscriber(ObjectType::Table, 50346, 'OnAfterModifyEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Clinical_Required_DcoumentsOnModify(VAR Rec: Record "Clinical Required Dcouments"; VAR xRec: Record "Clinical Required Dcouments"; RunTrigger: Boolean)
    // begin
    //     ClinicalRequiredDcoumentsFunction(Rec, '', 0, 'OnAfterModifyEvent')
    // end;

    // [EventSubscriber(ObjectType::Table, 50346, 'OnAfterRenameEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Clinical_Required_DcoumentsOnRename(VAR Rec: Record "Clinical Required Dcouments"; VAR xRec: Record "Clinical Required Dcouments"; RunTrigger: Boolean)
    // begin
    //     ClinicalRequiredDcoumentsFunction(Rec, Format(xRec."Type"), 0, 'OnAfterRenameEvent')
    // end;

    // [EventSubscriber(ObjectType::Table, 50346, 'OnAfterDeleteEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Clinical_Required_DcoumentsOnDelete(VAR Rec: Record "Clinical Required Dcouments"; RunTrigger: Boolean)
    // begin
    //     ClinicalRequiredDcoumentsFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    // end;

    // [EventSubscriber(ObjectType::Table, 50346, 'OnAfterInsertEvent', '', false, false)]
    // procedure ApiPortalSave_Update_Clinical_Required_DcoumentsOnInsert(VAR Rec: Record "Clinical Required Dcouments"; RunTrigger: Boolean)
    // begin
    //     ClinicalRequiredDcoumentsFunction(Rec, '', 0, 'OnAfterInsertEvent')
    // end;

    // procedure ClinicalRequiredDcoumentsFunction(var Rec: Record "Clinical Required Dcouments"; xRecTypeOfDocu: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    // var
    //     RecCompanyInformation: Record "Company Information";
    //     HttpClnt: HttpClient;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     URL: Text;


    // begin
    //     RecCompanyInformation.Reset();
    //RecCompanyInformation.get();
    //     If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
    //         RecCompanyInformation.TestField("Portal Api URL");
    //         URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Clinical_Required_Dcouments?TypeofDocument=%1&Types=%2&Description=%3&SortingNo_=%4&Blocked=%5&ExpiryNotApplicable=%6&ValidityDays=%7&Responsibility=%8&systemId=%9&OldTypeofDocument=%10&Delete=%11', Rec.Type, Rec."Document Code", Rec.Description, Rec."Sorting No.", HandlingBoolean(Rec.Blocked), HandlingBoolean(Rec."Expiry Not Applicable"), Rec."Validity Days", HandlingOption(Rec.Responsibility), Rec.SystemId, xRecTypeOfDocu, DeleteAllowed);

    //         If HttpClnt.Get(URL, HttpResponse) then
    //             HttpResponse.Content().ReadAs(ResponseText);

    //         SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
    //     End;
    // end;
    //Clinical Required Dcouments Stop
    //Student Teacher Guardian-CS Start
    [EventSubscriber(ObjectType::Table, 50269, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_AdvisorAssignmentOnModify(VAR Rec: Record "Student Teacher Guardian-CS"; VAR xRec: Record "Student Teacher Guardian-CS"; RunTrigger: Boolean)
    begin
        StudentTeacherGuardianCSFunction(Rec, '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50269, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_AdvisorAssignmentOnRename(VAR Rec: Record "Student Teacher Guardian-CS"; VAR xRec: Record "Student Teacher Guardian-CS"; RunTrigger: Boolean)
    begin
        StudentTeacherGuardianCSFunction(Rec, xRec."No.", xRec."Academic Year", xRec.Semester, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50269, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_AdvisorAssignmentOnDelete(VAR Rec: Record "Student Teacher Guardian-CS"; RunTrigger: Boolean)
    begin
        StudentTeacherGuardianCSFunction(Rec, '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50269, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_AdvisorAssignmentOnInsert(VAR Rec: Record "Student Teacher Guardian-CS"; RunTrigger: Boolean)
    begin
        StudentTeacherGuardianCSFunction(Rec, '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure StudentTeacherGuardianCSFunction(var Rec: Record "Student Teacher Guardian-CS"; xRecNo: Code[20]; xRecAcaYear: Code[20]; xRecSemester: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_AdvisorAssignment?no=%1&academicyear=%2&semester=%3&facultycode=%4&studentname=%5&program=%6&section=%7&hostlerdayscholar=%8&fathersname=%9&mothersname=%10&correspondenceaddress=%11&phonenumberstudent=%12&fathermothermobileno=%13&emailaddressstudent=%14&emailaddressparent=%15&dateofbirth=%16&highschool=%17&intermediate=%18&graduation=%19&enrollmentno=%20&batch=%21&group=%22&globaldimension1code=%23&globaldimension2code=%24&lineno=%25&communicationdate=%26&contactpersonname=%27&contactpersonphoneno=%28&interactionsummary=%29&year=%30&typeofcourse=%31&updated=%32&course=%33&createdby=%34&createdon=%35&modefiedby=%36&modefiedon=%37&facultyname=%38&coursename=%39&rollno=%40&Oldno=%41&Oldacademicyear=%42&Oldsemester=%43&Delete=%44', Rec."No.", Rec."Academic Year", Rec.Semester, Rec."Faculty Code", Rec."Student Image", Rec.Program, Rec.Section, Rec."Hostler/ Day Scholar", Rec."Fathers Name", Rec."Mothers Name", Rec."Correspondence Address", Rec."Phone Number Student", Rec."Father/Mother Mobile No.", Rec."E-Mail Address Student", Rec."E-Mail Address Parent", FORMAT(Rec."Date of Birth", 0, 9), Rec."High School %", Rec."Intermediate %", Rec."Graduation %", Rec."Enrollment No.", Rec.Batch, rec.Group, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Line No.", FORMAT(Rec."Communication Date", 0, 9), Rec."Contact Person Name", rec."Contact Person Phone No.", Rec."Interaction Summary", Rec.Year, HandlingOption(Rec."Type Of Course"), HandlingBoolean(Rec.Updated), Rec.Course, Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modefied By", FORMAT(Rec."Modefied On", 0, 9), Rec."Faculty Name", Rec."Course Name", Rec."Roll No.", xRecNo, xRecAcaYear, xRecSemester, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Student Teacher Guardian-CS Stop
    //Education Setup-CS Start
    [EventSubscriber(ObjectType::Table, 50028, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_EducationSetupOnModify(VAR Rec: Record "Education Setup-CS"; VAR xRec: Record "Education Setup-CS"; RunTrigger: Boolean)
    begin
        EducationSetupCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50028, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_EducationSetupOnRename(VAR Rec: Record "Education Setup-CS"; VAR xRec: Record "Education Setup-CS"; RunTrigger: Boolean)
    begin
        EducationSetupCSFunction(Rec, xRec."Primary Key", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50028, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_EducationSetupOnDelete(VAR Rec: Record "Education Setup-CS"; RunTrigger: Boolean)
    begin
        EducationSetupCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50028, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_EducationSetupOnInsert(VAR Rec: Record "Education Setup-CS"; RunTrigger: Boolean)
    begin
        EducationSetupCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure EducationSetupCSFunction(var Rec: Record "Education Setup-CS"; xRecPriKey: Code[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EducationSetup?primarykey=%1&academicyear=%2&rankgenerationno=%3&company=%4&startdate=%5&enddate=%6&taskno=%7&announcementno=%8&imagefilepath=%9&xmlfilepath=%10&assignmentno=%11&globaldimension1code=%12&globaldimension2code=%13&attachmentfilepath=%14&userid=%15&portalid=%16&evenoddsemester=%17&updated=%18&coursecode=%19&classattendancedays=%20&internalmarksdays=%21&externalmarksdays=%22&minexternalexamattdper=%23&minlabattdper=%24&visiblestudtimetable=%25&absentmaildays=%26&minimumnumberofelectives=%27&promoted=%28&internalexamgenerated=%29&assignmentgenerated=%30&examschedulegenerated=%31&externalexamgenerated=%32&endsemestermarkspublished=%33&gradegenerated=%34&regularexamgradealloted=%35&regularexamgradepublished=%36&makeupexamgradealloted=%37&makeupexamgradepublished=%38&rev1examgradealloted=%39&rev1examgradepublished=%40&spacialexamgradealloted=%41&spacialexamgradepublished=%42&rev2examgradealloted=%43&rev2examgradepublished=%44&gpacgpagenerated=%45&makeupexamschedulegenerated=%46&makeupexternalexamgenerated=%47&parkingauano=%48&parkingbsicno=%49&parkingaicasano=%50&hostelmailterms=%51&hostelparkingno=%52&financialaccountabilityno=%53&optoutno=%54&minimumclinicalweeksallowed=%55&maximumclinicalweeksallowed=%56&coreclinicalrosternos=%57&electiveclinicalrosternos=%58&fm1im1clerkshipnos=%59&clinicalsplconsidrationnos=%60&examsplconsidrationnos=%61&studentsattendanceupdated=%62&internalmarkspublished=%63&specialexamschegenerated=%64&updatedetainedlist=%65&samesession=%66&detaineelistprepaired=%67&parkingaicasaauano=%68&housingmailterms=%69&housingparkingno=%70&housingoptoutno=%71&makeupexamno=%72&examoptoutno=%73&withdrawalno=%74&enrollmentno=%75&schoolid=%76&slcmequiryno=%77&slcmid=%78&promotionno=%79&restartapplication=%80&appealapplication=%81&specialexamgradealloted=%82&specialexamgradepublished=%83&registrationemail=%84&curriculumnalert=%85&coursewithdrawalapplicable=%86&ReturningOLRAcademicYear=%87&ReturningOLRTerm=%88&PreHousingAppAllowed=%89&DocumentUploadEmail=%90&FromInsuranceWaiverdate=%91&ToInsuranceWaiverDate=%92&Oldprimarykey=%93&Delete=%94', Rec."Primary key", Rec."Academic Year", '', HandlingOption(Rec.Company), Format(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), '', '', Rec."Image File Path", Rec."XML File Path", '', Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Attachment File Path", Rec."User ID", Rec."Portal ID", HandlingOption(Rec."Even/Odd Semester"), HandlingBoolean(Rec.Updated), Rec."Course Code", Rec."Class Attendance Days", Rec."Internal Marks Days", Rec."External Marks Days", Rec."Min. External Exam Attd. Per.", Rec."Min. Lab Attd. Per.", Rec."Visible Stud. Time Table", Rec."Absent Mail Days", Rec."Minimum Number of Electives", HandlingBoolean(Rec.Promoted), HandlingBoolean(Rec."Internal Exam Generated"), HandlingBoolean(Rec."Assignment  Generated"), HandlingBoolean(Rec."Exam Schedule Generated"), HandlingBoolean(Rec."External Exam Generated"), HandlingBoolean(Rec."End Semester Marks Published"), HandlingBoolean(Rec."Grade Generated"), HandlingBoolean(Rec."Regular Exam Grade Alloted"), HandlingBoolean(Rec."Regular Exam Grade Published"), HandlingBoolean(Rec."Makeup Exam Grade Alloted"), HandlingBoolean(Rec."Makeup Exam Grade Published"), HandlingBoolean(Rec."Rev. 1 Exam Grade Alloted"), HandlingBoolean(Rec."Rev. 1  Exam Grade Published"), HandlingBoolean(Rec."Special Exam Grade Alloted"), HandlingBoolean(Rec."Special Exam Grade published"), HandlingBoolean(Rec."Rev. 2  Exam Grade Alloted"), HandlingBoolean(Rec."Rev. 2  Exam Grade Published"), HandlingBoolean(Rec."GPA & CGPA Generated"), HandlingBoolean(Rec."MakeUp Exam Schedule Generated"), HandlingBoolean(Rec."MakeUp External Exam Generated"), '', '', '', Format(Rec."Housing Mail Terms"), '', '', '', Rec."Minimum Clinical Weeks Allowed", Rec."Maximum Clinical Weeks Allowed", '', '', '', '', '', HandlingBoolean(Rec."Students Attendance Updated"), HandlingBoolean(Rec."Internal Marks Published"), HandlingBoolean(Rec."Special Exam Sche. Generated"), HandlingBoolean(Rec."Update Detained List"), HandlingBoolean(Rec."Same Session"), HandlingBoolean(Rec."Detainee List Prepaired"), '', Format(Rec."Housing Mail Terms"), '', '', '', '', '', '', Rec."School ID", '', '', '', '', '', HandlingBoolean(Rec."Special Exam Grade Alloted"), HandlingBoolean(Rec."Special Exam Grade published"), Format(Rec."Registration Email"), HandlingBoolean(Rec."Curriculumn Alert"), HandlingBoolean(Rec."Course Withdrawal Applicable"), Rec."Returning OLR Academic Year", HandlingOption(Rec."Returning OLR Term"), HandlingBoolean(Rec."Pre Housing App. Allowed"), Rec."Document Upload Email", Format(Rec."From Insurance Waiver date", 0, 9), Format(Rec."To Insurance Waiver Date", 0, 9), xRecPriKey, DeleteAllowed);//CSPL-00307 - Insurance Waiver --Added 2 Parameters

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Education Setup-CS Stop
    //Education Calendar-CS Start
    [EventSubscriber(ObjectType::Table, 50045, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarOnModify(VAR Rec: Record "Education Calendar-CS"; VAR xRec: Record "Education Calendar-CS"; RunTrigger: Boolean)

    begin
        EducationCalendarCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;


    [EventSubscriber(ObjectType::Table, 50045, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarOnRename(VAR Rec: Record "Education Calendar-CS"; VAR xRec: Record "Education Calendar-CS"; RunTrigger: Boolean)
    begin
        EducationCalendarCSFunction(Rec, xRec.Code, xRec."Academic Year", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50045, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarOnDelete(VAR Rec: Record "Education Calendar-CS"; RunTrigger: Boolean)
    begin
        EducationCalendarCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50045, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarOnInsert(VAR Rec: Record "Education Calendar-CS"; RunTrigger: Boolean)
    begin
        EducationCalendarCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure EducationCalendarCSFunction(var Rec: Record "Education Calendar-CS"; xRecCode: Code[20]; xRecAcaYear: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EventCalendar_EducationCalendar?code=%1&academicyear=%2&startdate=%3&enddate=%4&globaldimension1code=%5&globaldimension2code=%6&program=%7&updated=%8&OldCode=%9&Oldacademicyear=%10&Delete=%11', Rec.Code, Rec."Academic Year", FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."End Date", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec.Program, HandlingBoolean(Rec.Updated), xRecCode, xRecAcaYear, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Education Calendar-CS Stop
    //Education Calendar Entry-CS Start
    [EventSubscriber(ObjectType::Table, 50050, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarEntryOnInsert(VAR Rec: Record "Education Calendar Entry-CS"; RunTrigger: Boolean)

    begin
        EducationCalendarEntryCSFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50050, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarEntryOnDelete(VAR Rec: Record "Education Calendar Entry-CS"; RunTrigger: Boolean)

    begin
        EducationCalendarEntryCSFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50050, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarEntryOnModify(VAR Rec: Record "Education Calendar Entry-CS"; VAR xRec: Record "Education Calendar Entry-CS"; RunTrigger: Boolean)
    begin
        EducationCalendarEntryCSFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50050, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationCalendarEntryOnRename(VAR Rec: Record "Education Calendar Entry-CS"; VAR xRec: Record "Education Calendar Entry-CS"; RunTrigger: Boolean)
    begin
        EducationCalendarEntryCSFunction(Rec, xRec.Code, Format(xRec.Date), 0, 'OnAfterRenameEvent')
    end;

    procedure EducationCalendarEntryCSFunction(var Rec: Record "Education Calendar Entry-CS"; xRecCode: Code[20]; xRecDate: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var

        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EventCalendar_EducationCalendarEntry?code=%1&date=%2&day=%3&offday=%4&holiday=%5&description=%6&dayorder=%7&academicyear=%8&globaldimension1code=%9&globaldimension2code=%10&multieventexist=%11&updated=%12&Oldcode=%13&Olddate=%14&Delete=%15', Rec.Code, FORMAT(Rec.Date), HandlingOption(Rec.Day), HandlingBoolean(Rec."Off Day"), HandlingBoolean(Rec.Holiday), Rec.Description, Rec."Day Order", Rec."Academic Year", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec."Multi Event Exist"), HandlingBoolean(Rec.Updated), xRecCode, xRecDate, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Education Calendar Entry-CS STop
    //Education Event-CS Start
    [EventSubscriber(ObjectType::Table, 50300, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationEventOnModify(VAR Rec: Record "Education Event-CS"; VAR xRec: Record "Education Event-CS"; RunTrigger: Boolean)
    begin
        EducationEventCSFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50300, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationEventOnRename(VAR Rec: Record "Education Event-CS"; VAR xRec: Record "Education Event-CS"; RunTrigger: Boolean)
    begin
        EducationEventCSFunction(Rec, xRec."Event Code", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50300, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationEventOnDelete(VAR Rec: Record "Education Event-CS"; RunTrigger: Boolean)
    begin
        EducationEventCSFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50300, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationEventOnInsert(VAR Rec: Record "Education Event-CS"; RunTrigger: Boolean)
    begin
        EducationEventCSFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure EducationEventCSFunction(var Rec: Record "Education Event-CS"; xRecEventCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EventCalendar_EducationEvent?eventcode=%1&description=%2&eventdaycalculation=%3&reminderdays=%4&portalmenuname=%5&updated=%6&Oldeventcode=%7&Delete=%8', Rec."Event Code", Rec.Description, Rec."Event Day Calculation", Rec."Reminder Days", Rec."Portal Menu Name", HandlingBoolean(Rec.Updated), xRecEventCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;
    //Education Event-CS Stop
    //Housing Inventory Master Start
    [EventSubscriber(ObjectType::Table, 50337, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryMasterOnModify(VAR Rec: Record "Housing Inventory Master"; VAR xRec: Record "Housing Inventory Master"; RunTrigger: Boolean)
    begin
        HousingInventoryMasterFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50337, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryMasterOnRename(VAR Rec: Record "Housing Inventory Master"; VAR xRec: Record "Housing Inventory Master"; RunTrigger: Boolean)
    begin
        HousingInventoryMasterFunction(Rec, xRec."Item Code", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50337, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryMasterOnDelete(VAR Rec: Record "Housing Inventory Master"; RunTrigger: Boolean)
    begin
        HousingInventoryMasterFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50337, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingInventoryMasterOnInsert(VAR Rec: Record "Housing Inventory Master"; RunTrigger: Boolean)
    begin
        HousingInventoryMasterFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure HousingInventoryMasterFunction(var Rec: Record "Housing Inventory Master"; xRecItemCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingInventoryMaster?ItemCode=%1&ItemDescription=%2&CreatedBy=%3&CreatedOn=%4&ModifiedBy=%5&ModifiedOn=%6&Updated=%7&Inserted=%8&OldItemCode=%9&Delete=%10', Rec."Item Code", Rec."Item Description", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), xRecItemCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Housing Inventory Master Stop
    //Housing Issue Start
    [EventSubscriber(ObjectType::Table, 50356, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalApiPortalSave_Update_HousingIssueOnModify(VAR Rec: Record "Housing Issue"; VAR xRec: Record "Housing Issue"; RunTrigger: Boolean)
    begin
        HousingIssueFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50356, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalApiPortalSave_Update_HousingIssueOnRename(VAR Rec: Record "Housing Issue"; VAR xRec: Record "Housing Issue"; RunTrigger: Boolean)
    begin
        HousingIssueFunction(Rec, xRec."Document No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50356, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalApiPortalSave_Update_HousingIssueOnDelete(VAR Rec: Record "Housing Issue"; RunTrigger: Boolean)
    begin
        HousingIssueFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50356, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalApiPortalSave_Update_HousingIssueOnInsert(VAR Rec: Record "Housing Issue"; RunTrigger: Boolean)
    begin
        HousingIssueFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure HousingIssueFunction(var Rec: Record "Housing Issue"; xRecDocumentNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingIssue?DocumentNo=%1&StudentNo=%2&StudentName=%3&IssueCode=%4&IssueDescription=%5&ShortcutDimension1Code=%6&ShortcutDimension2Code=%7&Status=%8&RejectionDescription=%9&ApplicationNo=%10&EnrolmentNo=%11&NoSeries=%12&DocumentDate=%13&PostingDate=%14&AcceptedBy=%15&AcceptedDate=%16&RejectedBy=%17&RejectionDate=%18&ClosedBy=%19&ClosedDate=%20&ClosedByStudent=%21&RemarksByStudent=%22&DimensionSetID=%23&RejectionReasonCode=%24&Updated=%25&ResolutionMail=%26&AcceptedInDays=%27&ResolvedInDays=%28&RejectedInDays=%29&HousingID=%30&HousingName=%31&HousingAddress=%32&HousingAddress2=%33&HousingCity=%34&HousingCountry=%35&ContactNumber=%36&EMail=%37&ResolutionRemarks=%38&OldDocumentNo=%39&Delete=%40', Rec."Document No.", Rec."Student No.", Rec."Student Name", Rec."Issue Code", Rec."Issue Description", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code", HandlingOption(Rec.Status), Rec."Rejection Description", Rec."Application No.", Rec."Enrolment No.", Rec."No. Series", FORMAT(Rec."Document Date", 0, 9), FORMAT(Rec."Posting Date", 0, 9), Rec."Accepted By", FORMAT(Rec."Accepted Date", 0, 9), Rec."Rejected By", FORMAT(Rec."Rejection Date", 0, 9), Rec."Closed By", FORMAT(Rec."Closed Date", 0, 9), HandlingBoolean(Rec."Closed By Student"), Rec."Remarks By Student", Rec."Dimension Set ID", Rec."Rejection Reason Code", HandlingBoolean(Rec.Updated), HandlingBoolean(Rec."Resolution Mail"), Rec."Accepted In Days", Rec."Resolved In Days", Rec."Rejected In Days", Rec."Housing ID", Rec."Housing Name", Rec."Housing Address", Rec."Housing Address 2", Rec."Housing City", Rec."Housing Country", Rec."Contact Number", Rec."E-Mail", Rec."Resolution Remarks", xRecDocumentNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;

    End;

    //Housing Issue STop
    //Immigration Document Upload Start
    [EventSubscriber(ObjectType::Table, 50354, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationDocumentUploadOnModify(VAR Rec: Record "Immigration Document Upload"; VAR xRec: Record "Immigration Document Upload"; RunTrigger: Boolean)

    begin
        ImmigrationDocumentUploadFunction(Rec, '', '', '', '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50354, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationDocumentUploadOnRename(VAR Rec: Record "Immigration Document Upload"; VAR xRec: Record "Immigration Document Upload"; RunTrigger: Boolean)

    begin
        ImmigrationDocumentUploadFunction(Rec, xRec."Student No.", xRec.Semester, xRec."Academic Year", Format(HandlingOption(xRec."Document Category")), Format(xRec."Line No."), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50354, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationDocumentUploadOnDelete(VAR Rec: Record "Immigration Document Upload"; RunTrigger: Boolean)

    begin
        ImmigrationDocumentUploadFunction(Rec, '', '', '', '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50354, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_ImmigrationDocumentUploadOnInsert(VAR Rec: Record "Immigration Document Upload"; RunTrigger: Boolean)

    begin
        ImmigrationDocumentUploadFunction(Rec, '', '', '', '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure ImmigrationDocumentUploadFunction(var Rec: Record "Immigration Document Upload"; xRecStudNo: Code[20]; xRecSemester: Code[20]; xRecAcaYear: Code[20]; xRecDocuCate: Text[50]; xRecLineNo: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ImmigrationDocumentUpload?StudentNo=%1&Semester=%2&AcademicYear=%3&DocumentCategory=%4&LineNo=%5&EnrolmentNo=%6&DocumentSubCategory=%7&DocumentName=%8&DocumentPath=%9&DocumentExtension=%10&DocumentID=%11&DocumentUpdateDate=%12&VerifiedDocument=%13&CreatedBy=%14&CreatedOn=%15&ModifiedBy=%16&ModifiedOn=%17&GlobalDimension1Code=%18&GlobalDimension2Code=%19&TransactionID=%20&OldStudentNo=%21&OldSemester=%22&OldAcademicYear=%23&OldDocumentCategory=%24&OldLineNo=%25&Delete=%26', Rec."Student No.", Rec.Semester, Rec."Academic Year", HandlingOption(Rec."Document Category"), Rec."Line No.", Rec."Enrolment No.", Rec."Document Sub Category", Rec."Document Name", Rec."Document Path", Rec."Document Extension", Rec."Document ID", FORMAT(Rec."Document Update Date", 0, 9), HandlingBoolean(Rec."Verified Document"), Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", '', xRecStudNo, xRecSemester, xRecAcaYear, xRecDocuCate, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Immigration Document Upload Stop

    //Non-Affiliated Hospital Start
    [EventSubscriber(ObjectType::Table, 50350, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Non_Affiliated_HospitalOnModify(VAR Rec: Record "Non-Affiliated Hospital"; VAR xRec: Record "Non-Affiliated Hospital"; RunTrigger: Boolean)
    begin
        NonAffiliatedHospitalFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50350, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Non_Affiliated_HospitalOnRename(VAR Rec: Record "Non-Affiliated Hospital"; VAR xRec: Record "Non-Affiliated Hospital"; RunTrigger: Boolean)
    begin
        NonAffiliatedHospitalFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50350, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Non_Affiliated_HospitalOnDelete(VAR Rec: Record "Non-Affiliated Hospital"; RunTrigger: Boolean)
    begin
        NonAffiliatedHospitalFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50350, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Non_Affiliated_HospitalOnInsert(VAR Rec: Record "Non-Affiliated Hospital"; RunTrigger: Boolean)
    begin
        NonAffiliatedHospitalFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure NonAffiliatedHospitalFunction(var Rec: Record "Non-Affiliated Hospital"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Non_Affiliated_Hospital?ApplicationNo=%1&Name=%2&SearchName=%3&Name2=%4&Address=%5&Address2=%6&City=%7&Contact=%8&PhoneNo=%9&TelexNo=%10&CountryRegionCode=%11&EMail=%12&ACGMENo=%13&Residency=%14&SystemRef_No=%15&Accreditation=%16&SponsoringInstitution=%17&SponsoredPrograms=%18&DMEName=%19&DMEPhoneNo=%20&DMEEmail=%21&SupervisingPhysicianName=%22&SuperviserPhoneNo=%23&SuperviserEmail=%24&Status=%25&StatusBy=%26&StatusOn=%27&Confirmed=%28&ConfirmedBy=%29&ConfirmedOn=%30&StudentNo=%31&EnrolmentNo=%32&ApplicationDate=%33&Postcode=%34&subjectcode=%35&country=%36&Firstname=%37&Middlename=%38&Lastname=%39&studentname=%40&semester=%41&academicyear=%42&clinicalcoordinator=%43&subjectdescription=%44&subjectprefix=%45&electivesubjectcode=%46&rotationdesc=%47&startdate=%48&enddate=%49&noofweek=%50&noseries=%51&rotationid=%52&rotationstatus=%53&title=%54&contactphone=%55&contactemail=%56&contacttitle=%57&programeid=%58&rejectreasoncode=%59&rejectreason=%60&OldApplicationNo=%61&Delete=%62', Rec."Application No.", Rec.Name, Rec."Search Name", Rec."Name 2", Rec.Address, Rec."Address 2", Rec.City, Rec.Contact, Rec."Phone No.", Rec."Telex No.", Rec."Country/Region Code", Rec."E-Mail", Rec."ACGME No.", HandlingBoolean(Rec.Residency), Rec."System Ref. No.", HandlingOption(Rec.Accreditation), Rec."Sponsoring Institution", Rec."Sponsored Programs", Rec."DME Name", Rec."DME Phone No.", Rec."DME Email", Rec."Supervising Physician Name", Rec."Superviser Phone No.", Rec."Superviser Email", HandlingOption(Rec.Status), Rec."Status By", FORMAT(Rec."Status On", 0, 9), HandlingBoolean(Rec.Confirmed), Rec."Confirmed By", FORMAT(Rec."Confirmed On", 0, 9), Rec."Student No.", Rec."Enrollment No.", FORMAT(Rec."Application Date", 0, 9), Rec."Post Code", Rec."Course Code", Rec.County, Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec.Semester, Rec."Academic Year", Rec."Clinical Cordinator ID", Rec."Course Description", Rec."Course Prefix", Rec."Elective Course Code", Rec."Rotation Description", Format(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), Rec."No. of Weeks", Rec."No. Series", Rec."Rotation ID", HandlingOption(Rec."Rotation Status"), HandlingOption(Rec.Title), Rec."Contact Phone No.", Rec."Contact E-Mail", HandlingOption(Rec."Contact Title"), Rec."Program ID", Rec."Reject Reason Code", Rec."Reject Reason", xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Non-Affiliated Hospital Stop

    //Housing Master Start
    [EventSubscriber(ObjectType::Table, 50339, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingMasterOnModify(VAR Rec: Record "Housing Master"; VAR xRec: Record "Housing Master"; RunTrigger: Boolean)
    begin
        HousingMasterFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50339, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingMasterOnRename(VAR Rec: Record "Housing Master"; VAR xRec: Record "Housing Master"; RunTrigger: Boolean)
    begin
        HousingMasterFunction(Rec, xRec."Housing ID", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50339, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingMasterOnDelete(VAR Rec: Record "Housing Master"; RunTrigger: Boolean)
    begin
        HousingMasterFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50339, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingMasterOnInsert(VAR Rec: Record "Housing Master"; RunTrigger: Boolean)
    begin
        HousingMasterFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure HousingMasterFunction(var Rec: Record "Housing Master"; xRecHousingId: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingMaster?HostelID=%1&HostelName=%2&CreatedBy=%3&CreatedOn=%4&ModifiedBy=%5&ModifiedOn=%6&Blocked=%7&HostelGroup=%8&OwnedByUniversity=%9&VendorNo=%10&OwnerName=%11&Address=%12&Address2=%13&City=%14&Country=%15&ContactNumber=%16&EMail=%17&GlobalDimension1Code=%18&GlobalDimension2Code=%19&PostCode=%20&OffCampus=%21&ContactPersonName=%22&Updated=%23&Inserted=%24&OldHostelID=%25&Delete=%26', Rec."Housing ID", Rec."Housing Name", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Blocked), Rec."Housing Group", HandlingBoolean(Rec."Owned By University"), Rec."Vendor No.", Rec."Owner Name", Rec.Address, Rec."Address 2", Rec.City, Rec.Country, Rec."Contact Number", Rec."E-Mail", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Post Code", HandlingBoolean(Rec."Off Campus"), Rec."Contact Person Name", HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Inserted), xRecHousingId, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;
    //Housing Master Stop
    //Student Leave of Absence Start
    [EventSubscriber(ObjectType::Table, 50349, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_CLOA_LOA_SLOAOnModify(VAR Rec: Record "Student Leave of Absence"; VAR xRec: Record "Student Leave of Absence"; RunTrigger: Boolean)
    begin
        IF xRec.HelloSign_Confirmed = Rec.HelloSign_Confirmed Then //CSPL-00307-HelloSign_BUG
            StudentLeaveofAbsenceFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50349, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_CLOA_LOA_SLOAOnRename(VAR Rec: Record "Student Leave of Absence"; VAR xRec: Record "Student Leave of Absence"; RunTrigger: Boolean)
    begin
        StudentLeaveofAbsenceFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50349, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_CLOA_LOA_SLOAOnDelete(VAR Rec: Record "Student Leave of Absence"; RunTrigger: Boolean)
    begin
        StudentLeaveofAbsenceFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50349, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_CLOA_LOA_SLOAOnInsert(VAR Rec: Record "Student Leave of Absence"; RunTrigger: Boolean)
    begin
        StudentLeaveofAbsenceFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure StudentLeaveofAbsenceFunction(var Rec: Record "Student Leave of Absence"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;


    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_CLOA_LOA_SLOA?ApplicationNo=%1&AppDate=%2&StudentNo=%3&StudentName=%4&EnrolmentNo=%5&AcademicYear=%6&Semester=%7&LeaveType=%8&StartDate=%9&EndDate=%10&Reason=%11&Remarks=%12&Status=%13&ApprovedBy=%14&ApprovedOn=%15&OldApplicationNo=%16&Delete=%17', Rec."Application No.", Format(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Student Name", Rec."Enrolment No.", Rec."Academic Year", Rec.Semester, HandlingOption(Rec."Leave Types"), FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."End Date", 0, 9), Rec.Reason, Rec.Remarks, HandlingOption(Rec.Status), Rec."Approved By", FORMAT(Rec."Approved On", 0, 9), xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Student Leave of Absence Stop

    //Housing Change Request Start
    [EventSubscriber(ObjectType::Table, 50336, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingChangeRequestOnModify(VAR Rec: Record "Housing Change Request"; VAR xRec: Record "Housing Change Request"; RunTrigger: Boolean)
    begin
        HousingChangeRequestFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50336, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingChangeRequestOnRename(VAR Rec: Record "Housing Change Request"; VAR xRec: Record "Housing Change Request"; RunTrigger: Boolean)
    begin
        HousingChangeRequestFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50336, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingChangeRequestOnDelete(VAR Rec: Record "Housing Change Request"; RunTrigger: Boolean)
    begin
        HousingChangeRequestFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50336, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_HousingChangeRequestOnInsert(VAR Rec: Record "Housing Change Request"; RunTrigger: Boolean)
    begin
        HousingChangeRequestFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure HousingChangeRequestFunction(var Rec: Record "Housing Change Request"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.testfield("Portal Api URL");
            IF Rec.Type = Rec.Type::"Change Request" then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingChangeRequest?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&EnrolmentNo=%4&EffectiveDate=%5&ReasonCode=%6&OriginalApplicationNo=%7&NewApplicationNo=%8&RoomKeysReturned=%9&ReasonDescription=%10&Status=%11&ApproveRejectDate=%12&ApproveRejectRemarks=%13&RenewStartDate=%14&RenewEndDate=%15&Type=%16&GlobalDimension1Code=%17&GlobalDimension2Code=%18&CreatedBy=%19&CreatedOn=%20&ModifiedBy=%21&ModifiedOn=%22&NoSeries=%23&Posted=%24&EntryFromPortal=%25&Inserted=%26&Updated=%27&HostelPref1=%28&HostelPref2=%29&HostelPref3=%30&WithSpouse=%31&RoomCategoryCode=%32&Remarks=%33&StudentName=%34&Semester=%35&AcademicYear=%36&HousingPref1Name=%37&HousingPref2Name=%38&HousingPref3Name=%39&HousingID=%40&HousingName=%41&HousingAddress=%42&HousingAddress2=%43&HousingCity=%44&HousingCountry=%45&ContactNumber=%46&EMail=%47&ApprovedBy=%48&ApprovedOn=%49&RejectedBy=%50&RejectedOn=%51&ApprovedInDays=%52&RejectedInDays=%53&Term=%54&PresentAddress1=%55&PresentAddress2=%56&PresentAddress3=%57&PostCode=%58&City=%59&Country=%60&County=%61&RoomMateNamePref=%62&RoomMateEmailPref=%63&OldApplicationNo=%64&Delete=%65', Rec."Application No.", FORMAT(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Enrolment No.", FORMAT(Rec."Effective Date", 0, 9), Rec."Reason Code", Rec."Original Application No.", Rec."New Application No.", HandlingBoolean(Rec."Room Keys Returned"), Rec."Reason Description", HandlingOption(Rec.Status), FORMAT(Rec."Approve/Reject Date", 0, 9), Rec."Approve/Reject Remarks", FORMAT(Rec."Renew Start Date", 0, 9), FORMAT(Rec."Renew End Date", 0, 9), HandlingOption(Rec.Type), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."No.Series", HandlingBoolean(Rec.Posted), HandlingBoolean(Rec."Entry From Portal"), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), FORMAT(Rec."Housing Pref. 1"), FORMAT(Rec."Housing Pref. 2"), FORMAT(Rec."Housing Pref. 3"), HandlingBoolean(Rec."With Spouse"), Rec."Room Category Code", Rec.Remarks, Rec."Student Name", Rec.Semester, Rec."Academic Year", Rec."Housing Pref. 1 Name", Rec."Housing Pref. 2 Name", Rec."Housing Pref. 3 Name", Rec."Housing ID", Rec."Housing Name", Rec."Housing Address", Rec."Housing Address 2", Rec."Housing City", Rec."Housing Country", Rec."Contact Number", Rec."E-Mail", Rec."Approved By", FORMAT(Rec."Approved On", 0, 9), Rec."Rejected By", FORMAT(Rec."Rejected On", 0, 9), Rec."Approved In Days", Rec."Rejected In Days", HandlingOption(Rec.Term), Rec."Present Address1", Rec."Present Address2", Rec."Present Address3", Rec."Post Code", Rec.City, Rec.Country, Rec.County, Rec."Room Mate Name Pref", Rec."Room Mate Email Pref", xRecAppNo, DeleteAllowed);
            IF Rec.Type = Rec.Type::Vacate then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingVacateRequest?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&EnrolmentNo=%4&EffectiveDate=%5&ReasonCode=%6&OriginalApplicationNo=%7&NewApplicationNo=%8&RoomKeysReturned=%9&ReasonDescription=%10&Status=%11&ApproveRejectDate=%12&ApproveRejectRemarks=%13&RenewStartDate=%14&RenewEndDate=%15&Type=%16&GlobalDimension1Code=%17&GlobalDimension2Code=%18&CreatedBy=%19&CreatedOn=%20&ModifiedBy=%21&ModifiedOn=%22&NoSeries=%23&Posted=%24&EntryFromPortal=%25&Inserted=%26&Updated=%27&HostelPref1=%28&HostelPref2=%29&HostelPref3=%30&WithSpouse=%31&RoomCategoryCode=%32&Remarks=%33&StudentName=%34&Semester=%35&AcademicYear=%36&HousingPref1Name=%37&HousingPref2Name=%38&HousingPref3Name=%39&HousingID=%40&HousingName=%41&HousingAddress=%42&HousingAddress2=%43&HousingCity=%44&HousingCountry=%45&ContactNumber=%46&EMail=%47&ApprovedBy=%48&ApprovedOn=%49&RejectedBy=%50&RejectedOn=%51&ApprovedInDays=%52&RejectedInDays=%53&Term=%54&OldApplicationNo=%55&Delete=%56', Rec."Application No.", FORMAT(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Enrolment No.", Format(Rec."Effective Date", 0, 9), Rec."Reason Code", REC."Original Application No.", Rec."New Application No.", HandlingBoolean(Rec."Room Keys Returned"), Rec."Reason Description", HandlingOption(Rec.Status), FORMAT(Rec."Approve/Reject Date", 0, 9), Rec."Approve/Reject Remarks", FORMAT(Rec."Renew Start Date", 0, 9), FORMAT(Rec."Renew End Date", 0, 9), HandlingOption(Rec.Type), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."No.Series", HandlingBoolean(Rec.Posted), HandlingBoolean(Rec."Entry From Portal"), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Housing Pref. 1", Rec."Housing Pref. 2", Rec."Housing Pref. 3", HandlingBoolean(Rec."With Spouse"), Rec."Room Category Code", Rec.Remarks, Rec."Student Name", Rec.Semester, Rec."Academic Year", Rec."Housing Pref. 1 Name", Rec."Housing Pref. 2 Name", Rec."Housing Pref. 3 Name", Rec."Housing ID", Rec."Housing Name", Rec."Housing Address", Rec."Housing Address 2", Rec."Housing City", Rec."Housing Country", Rec."Contact Number", Rec."E-Mail", Rec."Approved By", FORMAT(Rec."Approved On", 0, 9), Rec."Rejected By", FORMAT(Rec."Rejected On", 0, 9), Rec."Approved In Days", Rec."Rejected In Days", HandlingOption(Rec.Term), xRecAppNo, DeleteAllowed);
            IF Rec.Type = Rec.Type::"Re-Registration" then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_HousingReRegistration?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&EnrolmentNo=%4&EffectiveDate=%5&ReasonCode=%6&OriginalApplicationNo=%7&NewApplicationNo=%8&RoomKeysReturned=%9&ReasonDescription=%10&Status=%11&ApproveRejectDate=%12&ApproveRejectRemarks=%13&RenewStartDate=%14&RenewEndDate=%15&Type=%16&GlobalDimension1Code=%17&GlobalDimension2Code=%18&CreatedBy=%19&CreatedOn=%20&ModifiedBy=%21&ModifiedOn=%22&NoSeries=%23&Posted=%24&EntryFromPortal=%25&Inserted=%26&Updated=%27&HostelPref1=%28&HostelPref2=%29&HostelPref3=%30&WithSpouse=%31&RoomCategoryCode=%32&Remarks=%33&StudentName=%34&Semester=%35&AcademicYear=%36&HousingPref1Name=%37&HousingPref2Name=%38&HousingPref3Name=%39&HousingID=%40&HousingName=%41&HousingAddress=%42&HousingAddress2=%43&HousingCity=%44&HousingCountry=%45&ContactNumber=%46&EMail=%47&ApprovedBy=%48&ApprovedOn=%49&RejectedBy=%50&RejectedOn=%51&ApprovedInDays=%52&RejectedInDays=%53&Term=%54&PresentAddress1=%55&PresentAddress2=%56&PresentAddress3=%57&PostCode=%58&City=%59&Country=%60&County=%61&RoomMateNamePref=%62&RoomMateEmailPref=%63&OldApplicationNo=%64&Delete=%65', Rec."Application No.", FORMAT(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Enrolment No.", FORMAT(Rec."Effective Date", 0, 9), Rec."Reason Code", Rec."Original Application No.", Rec."New Application No.", HandlingBoolean(Rec."Room Keys Returned"), Rec."Reason Description", HandlingOption(Rec.Status), Format(Rec."Approve/Reject Date", 0, 9), Rec."Approve/Reject Remarks", FORMAT(Rec."Renew Start Date", 0, 9), FORMAT(Rec."Renew End Date", 0, 9), HandlingOption(Rec.Type), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Modified By", FORMAT(Rec."Modified On", 0, 9), Rec."No.Series", HandlingBoolean(Rec.Posted), HandlingBoolean(Rec."Entry From Portal"), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Housing Pref. 1", Rec."Housing Pref. 2", Rec."Housing Pref. 3", HandlingBoolean(Rec."With Spouse"), Rec."Room Category Code", Rec.Remarks, Rec."Student Name", Rec.Semester, Rec."Academic Year", Rec."Housing Pref. 1 Name", Rec."Housing Pref. 2 Name", Rec."Housing Pref. 3 Name", Rec."Housing ID", Rec."Housing Name", Rec."Housing Address", Rec."Housing Address 2", Rec."Housing City", Rec."Housing Country", Rec."Contact Number", Rec."E-Mail", Rec."Approved By", FORMAT(Rec."Approved On", 0, 9), Rec."Rejected By", FORMAT(Rec."Rejected On", 0, 9), Rec."Approved In Days", Rec."Rejected In Days", HandlingOption(Rec.Term), Rec."Present Address1", Rec."Present Address2", Rec."Present Address3", Rec."Post Code", Rec.City, Rec.Country, Rec.County, Rec."Room Mate Name Pref", Rec."Room Mate Email Pref", xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;
    //Housing Change Request Stop

    //ClerkshipSiteAndDateSelection Start
    [EventSubscriber(ObjectType::Table, 50348, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Site_SelectionOnModify(VAR Rec: Record "ClerkshipSiteAndDateSelection"; VAR xRec: Record "ClerkshipSiteAndDateSelection"; RunTrigger: Boolean)
    begin
        ClerkshipSiteAndDateSelectionFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50348, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Site_SelectionOnRename(VAR Rec: Record "ClerkshipSiteAndDateSelection"; VAR xRec: Record "ClerkshipSiteAndDateSelection"; RunTrigger: Boolean)
    begin
        ClerkshipSiteAndDateSelectionFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50348, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Site_SelectionOnDelete(VAR Rec: Record "ClerkshipSiteAndDateSelection"; RunTrigger: Boolean)
    begin
        ClerkshipSiteAndDateSelectionFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50348, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Clinical_Site_SelectionOnInsert(VAR Rec: Record "ClerkshipSiteAndDateSelection"; RunTrigger: Boolean)
    begin
        ClerkshipSiteAndDateSelectionFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure ClerkshipSiteAndDateSelectionFunction(var Rec: Record "ClerkshipSiteAndDateSelection"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Clinical_Site_Selection?ApplicationNo_=%1&CreationDate=%2&StudentNo_=%3&FirstName=%4&MiddleName=%5&LastName=%6&StudentName=%7&EnrollmentNo_=%8&FM1_IM1Coordinator=%9&PresetStartDateID=%10&PreferredStartDate=%11&No_ofWeeks=%12&EndDate=%13&DocumentDueDate=%14&GlobalDimension1Code=%15&GlobalDimension2Code=%16&Approx_SchedulingDate=%17&Approx_PublishingDate=%18&FirstPreferredSiteType=%19&FirstPreferredSiteID=%20&FirstPreferredSiteName=%21&SecondPreferredSiteType=%22&SecondPreferredSiteID=%23&SecondPreferredSiteName=%24&ThirdPreferredSiteType=%25&ThirdPreferredSiteID=%26&ThirdPreferredSiteName=%27&StudentType=%28&SpecialAccommodationRequired=%29&Comments=%30&RejectReasonCode=%31&RejectReasonDescription=%32&Confirmed=%33&ConfirmedOn=%34&ConfirmedBy=%35&Status=%36&StatusBy=%37&StatusOn=%38&RotatioID=%39&FirstSiteConfirmed=%40&SecondSiteConfirmed=%41&ThirdSiteConfirmed=%42&ConfirmedSiteID=%43&ConfirmedSiteName=%44&No_Series=%45&OldApplicationNo_=%46&Delete=%47', Rec."Application No.", FORMAT(Rec."Creation Date", 0, 9), Rec."Student No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", Rec."FM1/IM1 Coordinator", Rec."Preset Start Date ID", Format(Rec."Preferred Start Date", 0, 9), Rec."No. of Weeks", Format(Rec."End Date", 0, 9), FORMAT(Rec."Document Due Date", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", FORMAT(Rec."Approx. Scheduling Date", 0, 9), FORMAT(Rec."Approx. Publishing Date", 0, 9), HandlingOption(Rec."First Preferred Site Type"), Rec."First Preferred Site ID", Rec."First Preferred Site Name", HandlingOption(Rec."Second Preferred Site Type"), Rec."Second Preferred Site ID", Rec."Second Preferred Site Name", HandlingOption(Rec."Third Preferred Site Type"), Rec."Third Preferred Site ID", Rec."Third Preferred Site Name", HandlingOption(Rec."Student Type"), HandlingBoolean(Rec."Special Accommodation Required"), Rec.Comments, Rec."Reject Reason Code", Rec."Reject Reason Description", HandlingBoolean(Rec.Confirmed), FORMAT(Rec."Confirmed On", 0, 9), Rec."Confirmed By", HandlingOption(Rec.Status), Rec."Status By", FORMAT(Rec."Status On", 0, 9), Rec."Rotation ID", HandlingBoolean(Rec."First Site Confirmed"), HandlingBoolean(Rec."Second Site Confirmed"), HandlingBoolean(Rec."Third Site Confirmed"), Rec."Confirmed Site ID", Rec."Confirmed Site Name", Rec."No. Series", xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;
    //ClerkshipSiteAndDateSelection Stop

    [EventSubscriber(ObjectType::Table, 50301, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationMultiEventCalOnInsert(VAR Rec: Record "Education Multi Event Cal-CS"; RunTrigger: Boolean)
    begin
        EducationMultiEventFunction(Rec, '', 0D, '', '', '', 0, 'OnAfterInsertEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50301, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationMultiEventCalOnModify(VAR Rec: Record "Education Multi Event Cal-CS"; VAR xRec: Record "Education Multi Event Cal-CS"; RunTrigger: Boolean)
    begin
        EducationMultiEventFunction(Rec, '', 0D, '', '', '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50301, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationMultiEventCalOnRename(VAR Rec: Record "Education Multi Event Cal-CS"; VAR xRec: Record "Education Multi Event Cal-CS"; RunTrigger: Boolean)
    begin
        EducationMultiEventFunction(Rec, xRec.Code, xRec.Date, xRec."Event Code", xRec."Academic Year", Format(HandlingOption(xRec."Even/Odd Semester")), 0, 'OnAfterRenameEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50301, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_EventCalendar_EducationMultiEventCalOnDelete(VAR Rec: Record "Education Multi Event Cal-CS"; RunTrigger: Boolean)
    begin
        EducationMultiEventFunction(Rec, '', 0D, '', '', '', 1, 'OnAfterDeleteEvent');
    End;

    procedure EducationMultiEventFunction(var Rec: Record "Education Multi Event Cal-CS"; xRecCode: Code[20]; xRecDate: Date; xReceventcode: Code[20]; xRecacademicyear: Code[20]; xRecEvenOddSemester: Text; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EventCalendar_EducationMultiEventCal?code=%1&date=%2&eventcode=%3&academicyear=%4&eventdaycalculation=%5&eventdescription=%6&semester=%7&subjectcode=%8&year=%9&startdate=%10&revisedenddate=%11&enddate=%12&lineno=%13&revised=%14&updated=%15&globaldimension1code=%16', Rec.Code, FORMAT(Rec.Date, 0, 9), Rec."Event code", Rec."Academic Year", Rec."Event Day Calculation", Rec."Event Description", Rec.Semester, Rec."Subject Code", Rec.Year, FORMAT(Rec."Start Date", 0, 9), FORMAT(Rec."Revised End Date", 0, 9), FORMAT(Rec."End Date", 0, 9), Rec."Line No.", HandlingBoolean(Rec.Revised), HandlingBoolean(Rec.Updated), Rec."Global Dimension 1 code");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    //Elective Roster Start - 18.01.2021
    [EventSubscriber(ObjectType::Table, 50373, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_ElectiveRostersOnModify(VAR Rec: Record "Rotation Offer Application"; VAR xRec: Record "Rotation Offer Application"; RunTrigger: Boolean)
    begin
        ElectiveRosterFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50373, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_ElectiveRostersOnRename(VAR Rec: Record "Rotation Offer Application"; VAR xRec: Record "Rotation Offer Application"; RunTrigger: Boolean)
    begin
        ElectiveRosterFunction(Rec, xRec."Offer No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50373, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_ElectiveRostersOnDelete(VAR Rec: Record "Rotation Offer Application"; RunTrigger: Boolean)
    begin
        ElectiveRosterFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50373, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_ElectiveRostersOnInsert(VAR Rec: Record "Rotation Offer Application"; RunTrigger: Boolean)
    begin
        ElectiveRosterFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure ElectiveRosterFunction(var Rec: Record "Rotation Offer Application"; xRecDocu: Code[20]; xRecLineNo: Text[10]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ElectiveRosters?ApplicationNo=%1&OfferNo_=%2&LineNo_=%3&StudentNo_=%4&FirstName=%5&MiddleName=%6&LastName=%7&StudentName=%8&EnrollmentNo_=%9&AcademicYear=%10&Semester=%11&SubjectCode=%12&SubjectDescription=%13&SubjectPrefix=%14&ElectiveSubjectCode=%15&RotationDescription=%16&SameRotationApplied=%17&CordinationID=%18&StartDate=%19&No_ofWeeks=%20&EndDate=%21&HospitalID=%22&HospitalName=%23&ClinicalCordinatorID=%24&GlobalDimension1Code=%25&GlobalDimension2Code=%26&AlternateStartDate=%27&AlternateEndDate=%28&EstimatedRotationCost=%29&TotalEstimatedRotationCost=%30&Status=%31&ConfirmedBy=%32&ConfirmedOn=%33&ApprovalStatus=%34&ApprovedStatusBy=%35&ApprovedStatusOn=%36&RotationStatus=%37&RotationID=%38&RejectedBy=%39&RejectedOn=%40&RejectReason=%41&RejectReasonDescription=%42&OldOfferNo_=%43&OldLineNo_=%44&Delete=%45', Rec."Application No.", Rec."Offer No.", Rec."Line No.", Rec."Student No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", Rec."Academic Year", Rec.Semester, Rec."Course Code", Rec."Course Description", Rec."Course Prefix", Rec."Elective Course Code", Rec."Rotation Description", HandlingBoolean(Rec."Same Rotation Applied"), Rec."Cordination ID", Format(Rec."Start Date", 0, 9), Rec."No. of Weeks", Format(Rec."End Date", 0, 9), Rec."Hospital ID", Rec."Hospital Name", Rec."Clinical Cordinator ID", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Format(Rec."Alternate Start Date", 0, 9), Format(Rec."Alternate End Date", 0, 9), Rec."Estimated Rotation Cost", Rec."Total Estimated Rotation Cost", HandlingOption(Rec.Status), Rec."Confirmed By", Format(Rec."Confirmed On", 0, 9), HandlingOption(Rec."Approval Status"), Rec."Approved Status By", Format(Rec."Approved Status On", 0, 9), HandlingOption(Rec."Rotation Status"), Rec."Rotation ID", Rec."Rejected By", Format(Rec."Rejected On", 0, 9), Rec."Reject Reason", Rec."Reject Reason Description", xRecDocu, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Elective Roster Stop - 18.01.2021

    //Start Reason Program
    [EventSubscriber(ObjectType::Table, 50487, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Reason_ProgramsOnModify(VAR Rec: Record "Reason Program"; VAR xRec: Record "Reason Program"; RunTrigger: Boolean)
    begin
        ReasonProgramFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50487, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_Reason_ProgramOnRename(VAR Rec: Record "Reason Program"; VAR xRec: Record "Reason Program"; RunTrigger: Boolean)
    begin
        ReasonProgramFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50487, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_Reason_ProgramOnDelete(VAR Rec: Record "Reason Program"; RunTrigger: Boolean)
    begin
        ReasonProgramFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50487, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Reason_ProgramOnInsert(VAR Rec: Record "Reason Program"; RunTrigger: Boolean)
    begin
        ReasonProgramFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure ReasonProgramFunction(var Rec: Record "Reason Program"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Reason_Program?Code=%1&Description=%2&GlobalDimension1Code=%3&Blocked=%4&DepartmentType=%5&Semester=%6&AzureServiceLink=%7&BookingLink=%8&OldCode=%9&Delete=%10', Rec.code, Rec.Description, Rec."Global Dimension 1 Code", HandlingBoolean(Rec.Blocked), HandlingOption(Rec."Department Type"), Rec.Semester, Rec."Azure Service Link", Rec."Booking Link to Display", xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Reason Program

    //Start Advising Topics 
    [EventSubscriber(ObjectType::Table, 50488, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Advising_TopicsOnModify(VAR Rec: Record "Advising Topics"; VAR xRec: Record "Advising Topics"; RunTrigger: Boolean)
    begin
        AdvisingTopicsFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50488, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_Advising_TopicsOnRename(VAR Rec: Record "Advising Topics"; VAR xRec: Record "Advising Topics"; RunTrigger: Boolean)
    begin
        AdvisingTopicsFunction(Rec, xRec.Code, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50488, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_Advising_TopicsOnDelete(VAR Rec: Record "Advising Topics"; RunTrigger: Boolean)
    begin
        AdvisingTopicsFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50488, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Advising_TopicsOnInsert(VAR Rec: Record "Advising Topics"; RunTrigger: Boolean)
    begin
        AdvisingTopicsFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure AdvisingTopicsFunction(var Rec: Record "Advising Topics"; xRecCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Advising_Topics?Code=%1&Description=%2&GlobalDimension1Code=%3&Blocked=%4&DepartmentType=%5&OldCode=%6&Delete=%7', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", HandlingBoolean(Rec.Blocked), HandlingOption(Rec."Department Type"), xRecCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Start Advising Topics 
    //Start Problem Solution
    [EventSubscriber(ObjectType::Table, 50489, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Problem_SolutionOnModify(VAR Rec: Record "Problem Solution"; VAR xRec: Record "Problem Solution"; RunTrigger: Boolean)
    begin
        ProblemSolutionFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50489, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_Problem_SolutionOnRename(VAR Rec: Record "Problem Solution"; VAR xRec: Record "Problem Solution"; RunTrigger: Boolean)
    begin
        ProblemSolutionFunction(Rec, Format(xRec."Entry No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50489, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_Problem_SolutionOnDelete(VAR Rec: Record "Problem Solution"; RunTrigger: Boolean)
    begin
        ProblemSolutionFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50489, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Problem_SolutionOnInsert(VAR Rec: Record "Problem Solution"; RunTrigger: Boolean)
    begin
        ProblemSolutionFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure ProblemSolutionFunction(var Rec: Record "Problem Solution"; xRecEntry: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Problem_Solution?EntryNo=%1&Problem=%2&Solution=%3&GlobalDimension1Code=%4&Blocked=%5&CreatedBy=%6&CreatedOn=%7&ModifiedBy=%8&ModifiedOn=%9&Inserted=%10&Updated=%11&DepartmentType=%12&OldEntryNo=%13&Delete=%14', Rec."Entry No", Rec.Problem, Rec.Solution, Rec."Global Dimension 1 Code", HandlingBoolean(Rec.Blocked), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On"), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), HandlingOption(Rec."Department Type"), xRecEntry, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    //Stop Problem Solution
    //Start EED Team Mapping
    [EventSubscriber(ObjectType::Table, 50490, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_EED_Team_MappingOnModify(VAR Rec: Record "EED Team Mapping"; VAR xRec: Record "EED Team Mapping"; RunTrigger: Boolean)
    begin
        EEDTeamMappingFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50490, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_EED_Team_MappingOnRename(VAR Rec: Record "EED Team Mapping"; VAR xRec: Record "EED Team Mapping"; RunTrigger: Boolean)
    begin
        EEDTeamMappingFunction(Rec, Format(xRec."Entry No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50490, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_EED_Team_MappingOnDelete(VAR Rec: Record "EED Team Mapping"; RunTrigger: Boolean)
    begin
        EEDTeamMappingFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50490, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_EED_Team_MappingOnInsert(VAR Rec: Record "EED Team Mapping"; RunTrigger: Boolean)
    begin
        EEDTeamMappingFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure EEDTeamMappingFunction(var Rec: Record "EED Team Mapping"; xRecEntry: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EED_Team_Mapping?EntryNo=%1&TopicCode=%2&ReasonProgramCode=%3&AdvisorID=%4&StartAlphaRange=%5&EndAlphaRange=%6&AcademicYear=%7&Semester=%8&Term=%9&GlobalDimension1Code=%10&OldEntryNo=%11&Delete=%12', Rec."Entry No", Rec."Topic Code", Rec."Reason Program Code", Rec."Advisor ID", Rec."Start Alpha Range", Rec."End Alpha Range", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), Rec."Global Dimension 1 Code", xRecEntry, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop EED Team Mapping
    //Strat Advising Request
    [EventSubscriber(ObjectType::Table, 50491, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_EED_AdvisingRequestOnModify(VAR Rec: Record "Advising Request"; VAR xRec: Record "Advising Request"; RunTrigger: Boolean)
    begin
        AdvisingRequestFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50491, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_EED_AdvisingRequestOnRename(VAR Rec: Record "Advising Request"; VAR xRec: Record "Advising Request"; RunTrigger: Boolean)
    begin
        AdvisingRequestFunction(Rec, xRec."Request No", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50491, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_EED_AdvisingRequestOnDelete(VAR Rec: Record "Advising Request"; RunTrigger: Boolean)
    begin
        AdvisingRequestFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50491, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_EED_AdvisingRequestOnInsert(VAR Rec: Record "Advising Request"; RunTrigger: Boolean)
    begin
        AdvisingRequestFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure AdvisingRequestFunction(var Rec: Record "Advising Request"; xRecReqNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_EED_AdvisingRequest?RequestNo=%1&RequestDate=%2&StudentNo=%3&AcademicYear=%4&Semester=%5&Term=%6&CourseCode=%7&GlobalDimension1Code=%8&AdvisorID=%9&ReasonProgramCode=%10&ReasonDescription=%11&AdvisingTopicCode=%12&AdvisingTopicDescription=%13&MeetingDate=%14&MeetingStartTime=%15&MeetingEndTime=%16&RequestedMeetingDate1=%17&RequestedMeetingStartTime1=%18&RequestedMeetingEndTime1=%19&RequestedMeetingDate2=%20&RequestedMeetingStartTime2=%21&RequestedMeetingEndTime2=%22&RequestedMeetingDate3=%23&RequestedMeetingStartTime3=%24&RequestedMeetingEndTime3=%25&MeetingMode=%26&RequestStatus=%27&RejectedReason=%28&PreviousAdvisingRequestNo=%29&NextAdvisingRequestNo=%30&AdvisorNo=%31&RequestedBy=%32&Approved_Rejected_On=%33&ProblemSolutionId1=%34&CoreTopic=%35&RequestToChair=%36&SolutionDESC=%37&ProblemSolutionId=%38&DepartmentType=%39&CreatedBy=%40&CreatedOn=%41&ModifiedBy=%42&ModifiedOn=%43&StudentName=%44&Inserted=%45&Updated=%46&NoSeries=%47&FirstCharacter=%48&ConfirmDate=%49&EnrollmentNo=%50&EntryFromPortal=%51&RescheduledOldReqNo=%52&Problemsolutiondescription=%53&TimeZone=%54&Location=%55&StudentEmail=%56&FirstName=%57&LastName=%58&RejectionReasonDescription=%59&AdvisorFirstName=%60&AdvisorLastName=%61&RescheduledNewReqNo=%62&OldRequestNo=%63&Delete=%64', Rec."Request No", Format(Rec."Request Date", 0, 9), Rec."Student No.", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), Rec."Course Code", Rec."Global Dimension 1 Code", Rec."Advisor ID", rec."Reason Program Code", Rec."Reason Description", Rec."Advising Topic Code", Rec."Advising Topic Description", Format(Rec."Meeting Date", 0, 9), Format(Rec."Meeting Start Time 1", 0, 9), Format(Rec."Meeting End Time 1", 0, 9), Format(Rec."Requested Meeting Date1", 0, 9), Format(Rec."Requested Meeting Start Time 1", 0, 9), Format(Rec."Requested Meeting End Time1", 0, 9), Format(Rec."Requested Meeting Date2", 0, 9), Format(Rec."Requested Meeting Start Time 2", 0, 9), Format(Rec."Requested Meeting End Time2", 0, 9), Format(Rec."Requested Meeting Date3", 0, 9), Format(Rec."Requested Meeting Start Time 3", 0, 9), Format(Rec."Requested Meeting End Time3", 0, 9), HandlingOption(Rec."Meeting Mode"), HandlingOption(Rec."Request Status"), Rec."Rejected Reason", Rec."Previous Advising Request No", Rec."Next Advising Request No", Rec."Advisor ID", HandlingOption(Rec.Requestor), Format(Rec."Modified On", 0, 9), Rec."Problem Solution Id 1", Rec."Core Topic", HandlingBoolean(Rec."Request to Chair"), Rec."Problem solution description", 0, HandlingOption(Rec."Department Type"), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9), Rec."Student Name", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."No. Series", Rec."First Character", HandlingOption(Rec."Confirm Date"), Rec."Enrollment No.", HandlingBoolean(Rec."Entry From Portal"), Rec."Rescheduled Old Req. No.", Rec."Problem solution description", HandlingOption(Rec."Time Zone"), Rec.Location, Rec."Student Email", Rec."First Name", Rec."Last Name", Rec."Rejection Reason Description", Rec."Advisor First Name", Rec."Advisor Last Name", Rec."Rescheduled New Req. No.", xRecReqNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Advising Request
    //Start Medical Scholar Program
    [EventSubscriber(ObjectType::Table, 50492, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_MedicalScholarProgramOnModify(VAR Rec: Record "Medical Scholar Program"; VAR xRec: Record "Medical Scholar Program"; RunTrigger: Boolean)
    begin
        MedicalScholarProgramFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50492, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_MedicalScholarProgramOnRename(VAR Rec: Record "Medical Scholar Program"; VAR xRec: Record "Medical Scholar Program"; RunTrigger: Boolean)
    begin
        MedicalScholarProgramFunction(Rec, xRec."Application No", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50492, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_MedicalScholarProgramOnDelete(VAR Rec: Record "Medical Scholar Program"; RunTrigger: Boolean)
    begin
        MedicalScholarProgramFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50492, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_MedicalScholarProgramOnInsert(VAR Rec: Record "Medical Scholar Program"; RunTrigger: Boolean)
    begin
        MedicalScholarProgramFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure MedicalScholarProgramFunction(var Rec: Record "Medical Scholar Program"; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_MedicalScholarProgram?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&StudentName=%4&AcademicYear=%5&Semester=%6&Term=%7&SkypeId=%8&FirstTimeApplicant=%9&PreviouslyMedicalScholar=%10&PreviousRole1=%11&PreviousRole2=%12&ApplyingNewRole=%13&MaintainSameRole=%14&RoleApplying=%15&CourseName=%16&CumulativeGPAabove3=%17&Academicprobationforupcomingsemester=%18&ParticipatedinRebootprogram=%19&FstChoiceforPosition=%20&SndChoiceforPosition=%21&TrdChoiceforPosition=%22&FthChoiceforPosition=%23&interestedinbeinglead=%24&FstChoiceLeadRole=%25&SndChoiceLeadRole=%26&TrdChoiceLeadRole=%27&FthChoiceLeadRole=%28&FithChoiceLeadRole=%29&SthChoiceLeadRole=%30&SithChoiceLeadRole=%31&ShortQ_New_1_Experience=%32&ShortQ_New_2_Motivation=%33&ShortQ_New_3_Advice=%34&ShortQ_New_4_Integrity_Ethic=%35&ShortQ_New_5_professionalism=%36&ShortQ_Repeat_1_contribution=%37&ShortQ_Repeat_2_rationale=%38&Memberorofficerofstudentorganisation=%39&listofSOandaffiliations=%40&Reference1=%41&Reference2=%42&Questions_comments=%43&ApplicationStatus=%44&CreatedBy=%45&CreatedOn=%46&ModifiedBy=%47&ModifiedOn=%48&Inserted=%49&Updated=%50&PreviousRole2ApplyingNewRole=%51&AUAEmail=%52&ParticipatedinRebootprogramPrevSem=%53&RepeatedAnySemester=%54&OldApplicationNo=%55&Delete=%56', Rec."Application No", Format(Rec."Application Date", 0, 9), Rec."Student No.", rec."Student Name", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), Rec."Skype Id", HandlingBoolean(Rec."First Time Applicant"), HandlingBoolean(Rec."Previously Medical Scholar"), HandlingOption(Rec."Previous Role 1"), HandlingOption(rec."Previous Role 2"), HandlingBoolean(Rec."Applying New Role"), HandlingBoolean(Rec."Maintain Same Role"), HandlingOption(Rec."Role Applying"), Rec."Course Name", HandlingOption(Rec."Cumulative GPA above 3"), HandlingOption(Rec."Academic Prob for upcoming Sem"), HandlingBoolean(Rec."Participated in Reboot program"), HandlingOption(Rec."1st Choice for Position"), HandlingOption(Rec."2nd Choice for Position"), HandlingOption(Rec."3rd Choice for Position"), HandlingOption(Rec."4th Choice for Position"), HandlingBoolean(rec."Interested in being lead"), HandlingOption(Rec."1st Choice Lead Role"), HandlingOption(Rec."2nd Choice Lead Role"), HandlingOption(Rec."3rd Choice Lead Role"), HandlingOption(rec."4th Choice Lead Role"), HandlingOption(rec."5th Choice Lead Role"), HandlingOption(rec."6th Choice Lead Role"), HandlingOption(rec."7th Choice Lead Role"), Rec.ShortQ_New_1_Experience, Rec.ShortQ_New_2_Motivation, Rec.ShortQ_New_3_Advice, Rec.ShortQ_New_4_Integrity_Ethic, rec.ShortQ_New_5_professionalism, Rec.ShortQ_Repeat_1_contribution, Rec.ShortQ_Repeat_2_rationale, HandlingBoolean(Rec."Member or officer of stud org."), Rec."List of SO and affiliations", Rec."Reference 1", rec."Reference 2", Rec.Questions_comments, HandlingOption(Rec."Application Status"), rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Rec."Previous Role 2 Applying", Rec."AUA E-mail", HandlingBoolean(Rec."Participated in Reboot program PrevSem"), HandlingBoolean(Rec."Repeated any Semester"), xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);


            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Medical Scholar Program
    //Start MSP Subject Choice
    [EventSubscriber(ObjectType::Table, 50493, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_MSPSubjectChoiceOnModify(VAR Rec: Record "MSP Subject Choice"; VAR xRec: Record "MSP Subject Choice"; RunTrigger: Boolean)
    begin
        MSPSubjectChoiceFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50493, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_MSPSubjectChoiceOnRename(VAR Rec: Record "MSP Subject Choice"; VAR xRec: Record "MSP Subject Choice"; RunTrigger: Boolean)
    begin
        MSPSubjectChoiceFunction(Rec, Format(xRec."Application No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50493, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_MSPSubjectChoiceOnDelete(VAR Rec: Record "MSP Subject Choice"; RunTrigger: Boolean)
    begin
        MSPSubjectChoiceFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50493, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_MSPSubjectChoiceOnInsert(VAR Rec: Record "MSP Subject Choice"; RunTrigger: Boolean)
    begin
        MSPSubjectChoiceFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure MSPSubjectChoiceFunction(var Rec: Record "MSP Subject Choice"; xRecAppNo: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_MSPSubjectChoice?ApplicationNo=%1&Subject=%2&SubjectSemester=%3&Position=%4&OldApplicationNo=%5&Delete=%6', Rec."Application No", Rec.Subject, Rec."Subject Semester", HandlingOption(Rec.Position), xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop MSP Subject Choice
    //Start MPSE Application
    [EventSubscriber(ObjectType::Table, 50494, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_MPSEApplicationOnModify(VAR Rec: Record "MPSE Application"; VAR xRec: Record "MPSE Application"; RunTrigger: Boolean)
    begin
        MPSEApplicationFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50494, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_MPSEApplicationOnRename(VAR Rec: Record "MPSE Application"; VAR xRec: Record "MPSE Application"; RunTrigger: Boolean)
    begin
        MPSEApplicationFunction(Rec, Format(xRec."Application No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50494, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_MPSEApplicationOnDelete(VAR Rec: Record "MPSE Application"; RunTrigger: Boolean)
    begin
        MPSEApplicationFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50494, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_MPSEApplicationOnInsert(VAR Rec: Record "MPSE Application"; RunTrigger: Boolean)
    begin
        MPSEApplicationFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure MPSEApplicationFunction(var Rec: Record "MPSE Application"; xRecAppNo: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_MPSEApplication?ApplicationNo=%1&ApplicationDate=%2&ApplicationType=%3&StudentNo=%4&AcademicYear=%5&Semester=%6&Term=%7&OldApplicationNo=%8&Delete=%9', Rec."Application No", Format(Rec."Application Date", 0, 9), HandlingOption(Rec."Application Type"), Rec."Student No.", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop MPSE Application

    //Start Documentation Request
    [EventSubscriber(ObjectType::Table, 50495, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_DocumentationRequestOnModify(VAR Rec: Record "Documentation Request"; VAR xRec: Record "Documentation Request"; RunTrigger: Boolean)
    begin
        DocumentationRequestFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50495, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_DocumentationRequestOnRename(VAR Rec: Record "Documentation Request"; VAR xRec: Record "Documentation Request"; RunTrigger: Boolean)
    begin
        DocumentationRequestFunction(Rec, Format(xRec."Application No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50495, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_DocumentationRequestOnDelete(VAR Rec: Record "Documentation Request"; RunTrigger: Boolean)
    begin
        DocumentationRequestFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50495, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_DocumentationRequestOnInsert(VAR Rec: Record "Documentation Request"; RunTrigger: Boolean)
    begin
        DocumentationRequestFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure DocumentationRequestFunction(var Rec: Record "Documentation Request"; xRecAppNo: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_DocumentationRequest?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&Statesforlicen=%4&Typeoflicenpermit=%5&Hospitalname=%6&Specialty=%7&DocumentsNeeded=%8&Otherinformation=%9&RecipientName=%10&RecipientEmail=%11&RecipientAddress=%12&ProcessingStatus=%13&ProcessedBy=%14&OldApplicationNo=%15&Delete=%16', Rec."Application No", Format(Rec."Application Date", 0, 9), Rec."Student No.", Rec."States for  licensure", Rec, Rec."Type of licensure permit", Rec."Hospital name", Rec.Specialty, Rec."Documents Needed", Rec."Other information needed", Rec."Recipient Name", Rec."Recipient Email", Rec."Recipient Address", Rec."Processed By", xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Documentation Request
    //Start Residency Placement Result
    [EventSubscriber(ObjectType::Table, 50496, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultOnModify(VAR Rec: Record "Residency Placement Result"; VAR xRec: Record "Residency Placement Result"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50496, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultOnRename(VAR Rec: Record "Residency Placement Result"; VAR xRec: Record "Residency Placement Result"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, Format(xRec."Application No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50496, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultOnDelete(VAR Rec: Record "Residency Placement Result"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50496, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultOnInsert(VAR Rec: Record "Residency Placement Result"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure ResidencyPlacementResultFunction(var Rec: Record "Residency Placement Result"; xRecAppNo: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ResidencyPlacementResult?ApplicationNo=%1&ApplicationDate=%2&StudentNo=%3&PreferredEmailAddress=%4&PreferredPhoneNumber=%5&OldApplicationNo=%6&Delete=%7', Rec."Application No", Format(Rec."Application Date", 0, 9), Rec."Student No.", Rec."Preferred Email Address", Rec."Preferred Phone Number", xRecAppNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Residency Placement Result

    //Start Residency Placement Result Lines
    [EventSubscriber(ObjectType::Table, 50497, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultLineOnModify(VAR Rec: Record "Residency Plac. Result Lines"; VAR xRec: Record "Residency Plac. Result Lines"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50497, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultLineOnRename(VAR Rec: Record "Residency Plac. Result Lines"; VAR xRec: Record "Residency Plac. Result Lines"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, Format(xRec."Application No"), Format(xRec."Line No"), 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50497, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultLineOnDelete(VAR Rec: Record "Residency Plac. Result Lines"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50497, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_ResidencyPlacementResultLineOnInsert(VAR Rec: Record "Residency Plac. Result Lines"; RunTrigger: Boolean)
    begin
        ResidencyPlacementResultFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure ResidencyPlacementResultFunction(var Rec: Record "Residency Plac. Result Lines"; xRecAppNo: Text[20]; xRecLineNo: Text[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ResidencyPlacementResultLine?ApplicationNo=%1&LineNo=%2&StudentNo=%3&Subject_SpecialityName=%4&ERASApplied=%5&ERASInterviewOffered=%6&ERASInterviewAttended=%7&ERASProgramRanked=%8&CaRMSApplied=%9&CaRMSInterviewOffered=%10&CaRMSInterviewAttended=%11&CaRMSProgramRanked=%12&OldApplicationNo=%13&OldLineNo=%14&Delete=%15', Rec."Application No", Rec."Line No", Rec."Student No.", Rec."Subject_Speciality Name", Rec."ERAS Applied", Rec."ERAS Interview Offered", Rec."ERAS Interview Attended", Rec."ERAS Program Ranked", Rec."CaRMS Applied", Rec."CaRMS Interview Offered", Rec."CaRMS Interview Attended", Rec."CaRMS Program Ranked", xRecAppNo, xRecLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Residency Placement Result Lines

    //Start Student Degree
    [EventSubscriber(ObjectType::Table, 50455, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_StudentDegreeOnModify(VAR Rec: Record "Student Degree"; VAR xRec: Record "Student Degree"; RunTrigger: Boolean)
    begin
        StudentDegreeFunction(Rec, '', '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50455, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_StudentDegreeOnRename(VAR Rec: Record "Student Degree"; VAR xRec: Record "Student Degree"; RunTrigger: Boolean)
    begin
        StudentDegreeFunction(Rec, xRec."Student No.", xRec."Degree Code", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50455, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_StudentDegreeOnDelete(VAR Rec: Record "Student Degree"; RunTrigger: Boolean)
    begin
        StudentDegreeFunction(Rec, '', '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50455, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_StudentDegreeOnInsert(VAR Rec: Record "Student Degree"; RunTrigger: Boolean)
    begin
        StudentDegreeFunction(Rec, '', '', 0, 'OnAfterInsertEvent')
    end;

    procedure StudentDegreeFunction(var Rec: Record "Student Degree"; xRecStudNo: Code[20]; xRecDegreeCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentDegree?StudentNo=%1&DegreeCode=%2&DegreeName=%3&EnrollmentNo=%4&CreationDate=%5&CreatedBy=%6&UpdatedOn=%7&UpdatedBy=%8&GlobalDimension1Code=%9&GlobalDimension2Code=%10&UserID=%11&DateAwarded=%12&DateCleared=%13&CertificateDate=%14&ExpirationDate=%15&OldStudentNo=%16&OldDegreeCode=%17&Delete=%18', Rec."Student No.", Rec."Degree Code", Rec."Degree Name", Rec."Enrollment No.", Format(Rec."Creation Date", 0, 9), Rec."Created By", Format(Rec."Updated On", 0, 9), Rec."Updated By", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Format(Rec.DateAwarded, 0, 9), Format(Rec.DateCleared, 0, 9), Format(Rec."Certificate Date", 0, 9), Format(Rec."Expiration Date", 0, 9), xRecStudNo, xRecDegreeCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop Student Degree

    //Start MSPE
    [EventSubscriber(ObjectType::Table, 50516, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_MSPEOnModify(VAR Rec: Record MSPE; VAR xRec: Record MSPE; RunTrigger: Boolean)
    begin
        MSPEFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50516, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_MSPEOnRename(VAR Rec: Record MSPE; VAR xRec: Record MSPE; RunTrigger: Boolean)
    begin
        MSPEFunction(Rec, xRec."Application No", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50516, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_MSPEOnDelete(VAR Rec: Record MSPE; RunTrigger: Boolean)
    begin
        MSPEFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50516, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_MSPEOnInsert(VAR Rec: Record MSPE; RunTrigger: Boolean)
    begin
        MSPEFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure MSPEFunction(var Rec: Record MSPE; xRecAppNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_MSPE?ApplicationNo_=%1&ApplicationDate=%2&ApplicationType=%3&StudentNo_=%4&AcademicYear=%5&Semester=%6&Term=%7&Step1Agree=%8&LastName=%9&FirstName=%10&PreviousLastName=%11&PreviousFirstName=%12&PhoneNumbers=%13&Mobile_Cell=%14&Address=%15&Country=%16&State=%17&City=%18&Zip=%19&ERAS=%20&CaRMS=%21&OtherSpecialty=%22&OtherSpecialtyDescription=%23&FirstNoteworthyCharacteristicsExp=%24&FirstNoteworthyCharacteristicsDates=%25&FirstNoteworthyCharacteristicsDatesEnd=%26&FirstNoteworthyCharacteristicsLocation=%27&SecondNoteworthyCharacteristicsExp=%28&SecondNoteworthyCharacteristicsDates=%29&SecondNoteworthyCharacteristicsDatesEnd=%30&SecondNoteworthyCharacteristicsLocation=%31&ThirdNoteworthyCharacteristicsExp=%32&ThirdNoteworthyCharacteristicsDates=%33&ThirdNoteworthyCharacteristicsDatesEnd=%34&ThirdNoteworthyCharacteristicsLocation=%35&ForthNoteworthyCharacteristicsExp=%36&ForthNoteworthyCharacteristicsDates=%37&ForthNoteworthyCharacteristicsDatesEnd=%38&ForthNoteworthyCharacteristicsLocation=%39&FifthNoteworthyCharacteristicsExp=%40&FifthNoteworthyCharacteristicsDates=%41&FifthNoteworthyCharacteristicsDatesEnd=%42&FifthNoteworthyCharacteristicsLocation=%43&UnderGraduateSchoolName=%44&UnderGraduateLocation=%45&UnderGraduateMonthYear=%46&UnderGraduateDegree=%47&UnderGraduateDegreeMajor=%48&FieldOfStudy=%49&PostGraduate_CurrentPosition_Department=%50&PostGraduate_CurrentHospital_Institution=%51&PostGraduate_CurrentCity_State=%52&PostGraduate_CurrentFrom=%53&PostGraduate_CurrentTo=%54&DoNotUpdateMPSE=%55&ApplicationStatus=%56&ProcessedBy=%57&ProcessingDate=%58&Step2Agree=%59&Remarks=%60&OldApplicationNo=%61&Delete=%62&Gaps=%63&Clinical_clerckship_rem=%64', Rec."Application No", Format(Rec."Application Date", 0, 9), HandlingOption(Rec."Application Type"), Rec."Student No", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), HandlingBoolean(Rec."Step 1 Agree"), Rec."Last Name", Rec."First Name", Rec."Previous Last Name", Rec."Previous First Name", Rec."Phone Numbers", Rec.Mobile_Cell, Rec.Address, Rec.Country, Rec.State, Rec.City, Rec.Zip, HandlingBoolean(Rec.ERAS), HandlingBoolean(Rec.CaRMS), HandlingBoolean(Rec."Other Specialty"), Rec."Other Specialty Description", Rec."1st Noteworthy Char. Exp.", Rec."1st Noteworthy Char. Dates", Rec."1st Noteworthy Char. End Date", Rec."1st Noteworthy Char. Location", Rec."2nd Noteworthy Char. Exp.", Rec."2nd Noteworthy Char Dates", Rec."2nd Noteworthy Char. End Date", Rec."2nd Noteworthy Char Location", Rec."3rd Noteworthy Char. Exp.", Rec."3rd Noteworthy Char Dates", Rec."3rd Noteworthy Char. End Date", Rec."3rd Noteworthy Char Location", Rec."4th Noteworthy Char Exp.", Rec."4th Noteworthy Char Dates", Rec."4th Noteworthy Char. End Date", Rec."4th Noteworthy Char Location", Rec."5th Noteworthy Char Exp.", Rec."5th Noteworthy Char Dates", Rec."5th Noteworthy Char. End Date", Rec."5th Noteworthy Char Location", Rec."Under Graduate School Name", Rec."Under Graduate Location", Rec."Under Graduate Month Year", Rec."Under Graduate Degree", Rec."Under Graduate Degree Major", Rec."Field of Study", Rec."Post Graduate_Curr Pos_Dep", Rec."Post Graduate_Curr Hosp_Inst", Rec."Post Graduate_Curr City_State", Rec."Post Graduate_Current From", Rec."Post Graduate_Current To", HandlingBoolean(Rec."Do Not Update MPSE"), HandlingOption(Rec."Application Status"), Rec."Created By", Format(Rec."Creation On", 0, 9), HandlingBoolean(Rec."Step 2 Agree"), Rec.Remarks, xRecAppNo, DeleteAllowed, Rec.GAPS, Rec.ClinicalClerkshipRemediation);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop MSPE
    //Start NRMP Match List
    [EventSubscriber(ObjectType::Table, 50485, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_ResidencyMatchUploadOnModify(VAR Rec: Record "NRMP Match List"; VAR xRec: Record "NRMP Match List"; RunTrigger: Boolean)
    begin
        NRMPMatchListFunction(Rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50485, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_ResidencyMatchUploadOnRename(VAR Rec: Record "NRMP Match List"; VAR xRec: Record "NRMP Match List"; RunTrigger: Boolean)
    begin
        NRMPMatchListFunction(Rec, xRec.ECFMG_ID, 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50485, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_ResidencyMatchUploadOnDelete(VAR Rec: Record "NRMP Match List"; RunTrigger: Boolean)
    begin
        NRMPMatchListFunction(Rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50485, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_ResidencyMatchUploadOnInsert(VAR Rec: Record "NRMP Match List"; RunTrigger: Boolean)
    begin
        NRMPMatchListFunction(Rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure NRMPMatchListFunction(var Rec: Record "NRMP Match List"; xRecECFMGID: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ResidencyMatchUpload?ECFMG_ID=%1&SCHOOL_NAME=%2&FNAME=%3&MNAME=%4&LNAME=%5&USER_TYPE_CD=%6&MATCH_STATUS_CD=%7&PGY1_INST_NAME=%8&PGY1_PGM_NAME=%9&PGY1_PGM_CD=%10&PGY2_INST_NAME=%11&PGY2_PGM_NAME=%12&PGY2_PGM_CD=%13&MATCH_YR=%14&OldECFMG_ID=%15&Delete=%16', Rec.ECFMG_ID, Rec.SCHOOL_NAME, Rec.FNAME, Rec.MNAME, Rec.LNAME, Rec.USER_TYPE_CD, HandlingOption(Rec.MATCH_STATUS_CD), Rec.PGY1_INST_NAME, Rec.PGY1_PGM_NAME, Rec.PGY1_PGM_CD, Rec.PGY2_INST_NAME, Rec.PGY2_PGM_NAME, Rec.PGY2_PGM_CD, Rec.MATCH_YR, xRecECFMGID, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Stop NRMP Match List


    //"Degree Audit"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50512, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_DegreeAuditOnInsert(VAR Rec: Record "Degree Audit"; RunTrigger: Boolean)
    begin
        DegreeAuditFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50512, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_DegreeAuditOnModify(VAR Rec: Record "Degree Audit"; VAR xRec: Record "Degree Audit"; RunTrigger: Boolean)
    begin
        DegreeAuditFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50512, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_DegreeAuditOnRename(VAR Rec: Record "Degree Audit"; VAR xRec: Record "Degree Audit"; RunTrigger: Boolean)
    begin
        DegreeAuditFunction(Rec, xRec."Application No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50512, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_DegreeAuditOnDelete(VAR Rec: Record "Degree Audit"; RunTrigger: Boolean)
    begin
        DegreeAuditFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure DegreeAuditFunction(var Rec: Record "Degree Audit"; xRecOldApplicationNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        Rec.CalcFields(LDA);
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Degree_Audit?ApplicationNo_=%1&StudentNo_=%2&StudentName=%3&EnrollmentNo=%4&Semester=%5&AcademicYear=%6&CourseCode=%7&CourseName=%8&GlobalDimension1Code=%9&LastDateofAttendance=%10&PermanentPhoneNo_=%11&ApplicationDate=%12&DocumentStatus=%13&FirstName=%14&LastName=%15&CurrentAddress=%16&CurrentCountryCode=%17&CurrentState=%18&CurrentZipCode=%19&CurrentCity=%20&PermanentAddress=%21&PermanentCountryCode=%22&PermanentState=%23&PermanentZipCode=%24&PermanentCity=%25&Term=%26&RejectionRemark=%27&CreatedBy=%28&CreatedOn=%29&Approved_RejectedBy=%30&Approved_RejectedOn=%31&BSICOptOutStatus=%32&PersonalEMailAddress=%33&ReasonDescription=%34&GraduationDate=%35&DateAwarded=%36&DateCleared=%37&EffectiveDate=%38&EstimatedGraduationDate=%39&TotalClerkshipWeeks=%40&ClinicalCurriculum=%41&OldApplicationNo=%42&Delete=%43', Rec."Application No.", Rec."Student No.", Rec."Student Name", Rec."Enrollment No", Rec.Semester, Rec."Academic Year", Rec."Course Code", Rec."Course Name", Rec."Global Dimension 1 Code", Format(Rec.LDA, 0, 9), Rec."Permanent Phone No.", FORMAT(Rec."Application Date", 0, 9), HandlingOption(Rec."Document Status"), Rec."First Name", Rec."Last Name", Rec."Current Address", Rec."Current Country Code", Rec."Current State", Rec."Current Zip Code", Rec."Current City", Rec."Permanent Address", Rec."Permanent Country Code", Rec."Permanent State", Rec."Permanent Zip Code", Rec."Permanent City", HandlingOption(Rec.Term), Rec."Rejection Remark", Rec."Created By", FORMAT(Rec."Created On", 0, 9), Rec."Approved/Rejected By", FORMAT(Rec."Approved/Rejected On", 0, 9), HandlingBoolean(Rec."BSIC Opt-Out"), Rec."Personal E-Mail Address", Rec."Reason Description", Format(Rec."Graduation Date", 0, 9), Format(Rec."Date Awarded", 0, 9), Format(Rec."Date Cleared", 0, 9), Format(Rec."Effective Date", 0, 9), Format(Rec."Estimated Graduation Date", 0, 9), Rec."Total Clerkship Weeks", HandlingOption(Rec."Clinical Curriculum"), xRecOldApplicationNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Degree Audit Header"-End------------------------------------------------------------------------------------------------    

    procedure SAFI_Student_InitiationFunction(StudentNo: Code[20])
    var
        RecCompanyInformation: Record "Company Information";
        TempBlob: Record "TempBlob Test";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        // FileMang: Codeunit "File Management";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        // ResponseHeaders: DotNet NameValueCollection;
        // HttpStatusCode: DotNet HttpStatusCode;
        ResponseText: Text;
        URL: Text;
        JsonFilePath: File;
        JsonOutStream: OutStream;
        Instr: Instream;
        NewInStream: InStream;
        TofileName: Variant;


    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = true then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/SAFI_Student_Initiation?StudentNo=%1', StudentNo);


            // HttpWebRequestMgt.Initialize(URL);
            // HttpWebRequestMgt.DisableUI();
            // HttpWebRequestMgt.SetMethod('GET');

            // TempBlob.INIT;
            // TempBlob.Blob.CREATEINSTREAM(Instr);

            // HttpWebRequestMgt.GetResponse(Instr, HttpStatusCode, ResponseHeaders);
            // ResponseText := TempBlob.ReadAsText('', TEXTENCODING::Windows);
            //MESSAGE(ResponseText);
            //TempBlob.Blob.Export(Path + '\SAFI.xml');

            // JsonFilePath.CreateTempFile();
            // JsonFilePath.Write(ResponseText);
            // JsonFilePath.CreateInStream(NewInStream);
            TofileName := 'SAFI_Student_Initiation .xml';
            DownloadFromStream(Instr, 'Export', '', '*.xml*', ToFileName);

        end;
    end;

    procedure SAFI_Student_EventFunction(StudentNo: Code[20]; Sem: code[10]; StudentID: Code[20])
    var
        RecCompanyInformation: Record "Company Information";
        TempBlob: Record "TempBlob Test";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        // FileMang: Codeunit "File Management";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        JsonFilePath: File;
        JsonOutStream: OutStream;
        Instr: Instream;
        NewInStream: InStream;
        TofileName: Variant;
        Path: Text;
        OStr: OutStream;
        test: Codeunit "Temp Blob";

    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = true then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + 'http://10.2.108.4:802/SLCMAPI.asmx' + '/SAFI_EventLive?StudentNo=%1&Semester=%2&OriginalStudentNo=%3', StudentNo, Sem, StudentID);
            If HttpClnt.Get(URL, HttpResponse) then begin
                HttpResponse.Content().ReadAs(ResponseText);

                Path := '\\10.2.108.4\Safi\safi_' + StudentID + '.xml';


                TempBlob.Reset();
                TempBlob.DeleteAll();

                TempBlob.Blob.CreateOutStream(OStr);
                CopyStream(OStr, Instr);

                TofileName := 'safi_' + StudentID + '.xml';
                DownloadFromStream(Instr, 'Export', '', '*.xml*', ToFileName);
            end;
        end;

    end;


    procedure EmailNotification(Type_: text[50]; SenderName: Text[100]; SenderId: text[50];
                            ReceiverName: text; ReceiverId: Text; Subject: text[200]; Text_: text;
                            Process: Text[100]; Event_: text[100]; ProcessNo: text[50]; EDate: text[40]; ReceiverEmailId: text;
                            SendEmail: Integer; EmailSent: Integer; EmailSentDatetime: text[40]; mailitem_id: Integer; MobileNo: Text[20];
                            SmsText: text[500]; SendSms: Integer; SmsSent: Integer; SmsSentDatetime: text[40]; UserName: Code[50]; FileName: Text[2048]; MailingAdd: Text[250])
    var
        EmailNotification: Record "Email Notification";
        EmailNotificationRec: Record "Email Notification";
        LastEntryNo: Integer;
        OStream: OutStream;
    begin
        EmailNotificationRec.SetCurrentKey(Id);
        if EmailNotificationRec.FindLast() then
            LastEntryNo := EmailNotificationRec.Id + 1
        else
            LastEntryNo := 1;

        EmailNotification.Init();
        EmailNotification.Id := LastEntryNo;
        EmailNotification.Type := Type_;
        EmailNotification."Sender Name" := SenderName;
        EmailNotification.SenderId := SenderId;
        EmailNotification.ReceiverName := ReceiverName;
        EmailNotification.ReceiverId := ReceiverId;
        EmailNotification.Subject := Subject;
        EmailNotification.Text_ := Copystr(Text_, 1, 2048);
        EmailNotification.Process := Process;
        EmailNotification.Event_ := Event_;
        EmailNotification."Process No" := ProcessNo;
        Evaluate(EmailNotification.EDate, EDate);
        EmailNotification."Receiver Email Id" := CopyStr(ReceiverEmailId, 1, 100);
        EmailNotification."Send Email" := SendEmail;
        EmailNotification."Email Sent" := EmailSent;
        Evaluate(EmailNotification."Email Sent Datetime", EmailSentDatetime);
        EmailNotification."Mail Item Id" := mailitem_id;
        EmailNotification."Mobile No" := MobileNo;
        EmailNotification."Sms Text" := SmsText;
        EmailNotification."Send Sms" := SendSms;
        EmailNotification."Sms Sent" := SmsSent;
        EmailNotification."Notification Sent By" := UserName;
        Evaluate(EmailNotification."Sms Sent Datetime", SmsSentDatetime);
        If FileName <> '' then begin
            EmailNotification."File Attachment".CreateOutStream(OStream);
            OStream.WriteText(FileName);
        end;
        EmailNotification.Address := MailingAdd;
        EmailNotification.Insert();

    end;

    Procedure MSPE_Change_Status(_Rec: Record MSPE)
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Mspe_update_status?ApplicationNo=%1&Status=%2', _Rec."Application No", HandlingOption(_Rec."Processing Status"));
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(_Rec.TableName(), ResponseText, 'Save_Update_Mspe_update_status');
        End;

    End;

    //Rotation Cancellation Application-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50214, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RotationCancellationApplnOnInsert(VAR Rec: Record "Rotation Cancellation Appln"; RunTrigger: Boolean)
    begin
        RotationCancellationApplicationFn(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50214, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RotationCancellationApplnOnModify(VAR Rec: Record "Rotation Cancellation Appln"; VAR xRec: Record "Rotation Cancellation Appln"; RunTrigger: Boolean)
    begin
        RotationCancellationApplicationFn(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50214, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RotationCancellationApplnOnRename(VAR Rec: Record "Rotation Cancellation Appln"; VAR xRec: Record "Rotation Cancellation Appln"; RunTrigger: Boolean)
    begin
        RotationCancellationApplicationFn(Rec, Format(xRec."Application No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50214, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RotationCancellationApplnOnDelete(VAR Rec: Record "Rotation Cancellation Appln"; RunTrigger: Boolean)
    begin
        RotationCancellationApplicationFn(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure RotationCancellationApplicationFn(var Rec: Record "Rotation Cancellation Appln"; xRecOldEntryNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_RotationCancellationAppln?ApplicationNo=%1&RotationID=%2&RotationNo=%3&StudentNo=%4&FirstName=%5&MiddleName=%6&LastName=%7&StudentName=%8&EnrollmentNo=%9&Semester=%10&NoofWeeks=%11&StartDate=%12&CourseCode=%13&CourseDescription=%14&ElectiveCourseCode=%15&RotationDescription=%16&EndDate=%17&HospitalID=%18&HospitalName=%19&CoordinatorID=%20&CancelReasonCode=%21&CancelReasonDescription=%22&CoursePrefixCode=%23&CreatedOn=%24&CreatedBy=%25&Status=%26&ClerkshipType=%27&StatusBy=%28&StatusOn=%29&FilteringID=%30&OldApplicationNo=%31&Delete=%32', Rec."Application No.", Rec."Rotation ID", Rec."Rotation No.", Rec."Student No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", Rec.Semester, Rec."No. of Weeks", Format(Rec."Start Date", 0, 9), Rec."Course Code", Rec."Course Description", Rec."Elective Course Code", Rec."Rotation Description", Format(Rec."End Date", 0, 9), Rec."Hospital ID", Rec."Hospital Name", Rec."Coordinator ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Course Prefix Code", Format(Rec."Created On", 0, 9), Rec."Created By", HandlingOption(Rec.Status), HandlingOption(Rec."Clerkship Type"), Rec."Status By", Format(Rec."Status On", 0, 9), Rec."Filtering ID", xRecOldEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Rotation Cancellation Application"-End------------------------------------------------------------------------------------------------    

    //OLR Returning Student Email Notification ---Start
    procedure OLRReturningStudentEmailNotifyFn(Rec: Record "OLR Update Line"; Reminders: Boolean)
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            If Not Reminders then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Email_Notification_Returning_Student?StudentNo_=%1&Semester=%2&AcademicYear=%3&Term=%4&InstituteCode=%5&DocumentNo=%6&LineNo=%7&StudentName=%8&EnrollmentNo=%9&OriginalStudentNo=%10&Status=%11&CourseCode=%12&RegistrarSignOff=%13&OLRStartDate=%14&OLRAcademicYear=%15&OLRSemester=%16&OLRTerm=%17&Confirmed=%18&Select=%19&OLRStatus=%20&ReadytoConfirm=%21&Reminderno=%22&Reminderemailsent=%23&Reminder=%24', Rec."Student No.", Rec.Semester, Rec."Academic Year", HandlingOption(Rec.Term), Rec."Global Dimension 1 Code", Rec."Document No.", Rec."Line No.", Rec."Student Name", Rec."Enrollment No.", Rec."Original Student No.", Rec.Status, Rec."Course Code", HandlingBoolean(Rec."Registrar Sign Off"), Format(Rec."OLR Start Date", 0, 9), Rec."OLR Academic Year", Rec."OLR Semester", HandlingOption(Rec."OLR Term"), HandlingBoolean(Rec.Confirmed), HandlingBoolean(Rec.Select), HandlingOption(Rec."OLR Status"), HandlingBoolean(Rec."Ready to Confirm"), Rec."Reminder No.", 0, HandlingBoolean(Rec.Reminder));

            IF Reminders then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Email_Notification_Returning_Student?StudentNo_=%1&Semester=%2&AcademicYear=%3&Term=%4&InstituteCode=%5&DocumentNo=%6&LineNo=%7&StudentName=%8&EnrollmentNo=%9&OriginalStudentNo=%10&Status=%11&CourseCode=%12&RegistrarSignOff=%13&OLRStartDate=%14&OLRAcademicYear=%15&OLRSemester=%16&OLRTerm=%17&Confirmed=%18&Select=%19&OLRStatus=%20&ReadytoConfirm=%21&Reminderno=%22&Reminderemailsent=%23&Reminder=%24', Rec."Student No.", Rec.Semester, Rec."Academic Year", HandlingOption(Rec.Term), Rec."Global Dimension 1 Code", Rec."Document No.", Rec."Line No.", Rec."Student Name", Rec."Enrollment No.", Rec."Original Student No.", Rec.Status, Rec."Course Code", HandlingBoolean(Rec."Registrar Sign Off"), Format(Rec."OLR Start Date", 0, 9), Rec."OLR Academic Year", Rec."OLR Semester", HandlingOption(Rec."OLR Term"), HandlingBoolean(Rec.Confirmed), HandlingBoolean(Rec.Select), HandlingOption(Rec."OLR Status"), HandlingBoolean(Rec."Ready to Confirm"), Rec."Reminder No.", 0, HandlingBoolean(Rec.Reminder));
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'OLR Returning Student Email Notification');
        end;
    end;



    //OLR Returning Student Email Notification ---End

    [EventSubscriber(ObjectType::Table, 50421, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationStateOnInsert(VAR Rec: Record "State SLcM CS"; RunTrigger: Boolean)
    begin
        SLcMStateFn(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50421, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationStateOnModify(VAR Rec: Record "State SLcM CS"; VAR xRec: Record "State SLcM CS"; RunTrigger: Boolean)
    begin
        SLcMStateFn(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50421, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationStateOnRename(VAR Rec: Record "State SLcM CS"; VAR xRec: Record "State SLcM CS"; RunTrigger: Boolean)
    begin
        SLcMStateFn(Rec, Format(xRec.Code), Format(xRec."Country/Region Code"), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50421, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_ApplicationStateOnDelete(VAR Rec: Record "State SLcM CS"; RunTrigger: Boolean)
    begin
        SLcMStateFn(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure SLcMStateFn(var Rec: Record "State SLcM CS"; xRecOldCode: Code[20]; xRecOldCountryRegionCode: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_ApplicationState?Code=%1&CountryRegionCode=%2&Description=%3&Block=%4&OldCode=%5&OldCountryRegionCode=%6&Delete=%7', Rec.Code, Rec."Country/Region Code", Rec.Description, HandlingBoolean(Rec.Block), xRecOldCode, xRecOldCountryRegionCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    Procedure StudentOnGroundCheckInBCtoPortal(_Rec: Record "Student Master-CS")
    var
        RecCompanyInformation: Record "Company Information";
        EducationSetup: Record "Education Setup-CS";
        CourseSemesterRec: Record "Course Sem. Master-CS";
        CourseSemesterRec1: Record "Course Sem. Master-CS";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        OLRSemester: Code[20];
    Begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", _Rec."Global Dimension 1 Code");
        If EducationSetup.FindFirst() then;

        CourseSemesterRec.Reset();
        CourseSemesterRec.Setrange("Course Code", _Rec."Course Code");
        CourseSemesterRec.SetRange("Semester Code", _Rec.Semester);
        IF CourseSemesterRec.FindFirst() then begin
            CourseSemesterRec1.Reset();
            CourseSemesterRec1.Setrange("Course Code", CourseSemesterREc."Course Code");
            CourseSemesterRec1.Setrange("Sequence No", CourseSemesterRec."Sequence No" + 1);
            IF CourseSemesterRec1.FindFirst() then
                OLRSemester := CourseSEmesterREc1."Semester Code";
        end;

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/StudentOnGroundCheckIn?StudentNo=%1&AcademicYear=%2&Term=%3&Semester=%4', _Rec."No.", EducationSetup."Returning OLR Academic Year", HandlingOption(EducationSetup."Returning OLR Term"), OLRSemester);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(_Rec.TableName(), ResponseText, 'StudentOnGroundCheckIn');
        end;

    End;

    //Student Registration Update & Delete Start------------------------------

    [EventSubscriber(ObjectType::Table, 50197, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalupdate_Semester_Student_Registration_CSOnRename(VAR Rec: Record "Student Registration-CS"; VAR xRec: Record "Student Registration-CS"; RunTrigger: Boolean)
    begin
        StudentRegistrationSync(Rec, xRec."Student No", xRec."Academic Year", xRec.Semester, HandlingOption(xRec.Term), xRec."Course Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50197, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalupdate_Semester_Student_Registration_CSOnDelete(VAR Rec: Record "Student Registration-CS"; RunTrigger: Boolean)
    begin
        StudentRegistrationSync(Rec, '', '', '', 0, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentRegistrationSync(Var Rec: Record "Student Registration-CS"; xStudentNo: Code[20]; xAcademicYear: Code[20]; xSemester: Code[20]; xTerm: Integer; xCourseCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Update_Semester_Student_Registration_CS?StudentNo_=%1&AcademicYear=%2&Semester=%3&Term=%4&CourseCode=%5&OldStudentNo_=%6&OldAcademicYear=%7&OldSemester=%8&OldTerm=%9&OldCourseCode=%10&NewSemester=%11&Delete=%12', Rec."Student No", Rec."Academic Year", Rec.Semester, HandlingOption(Rec.Term), Rec."Course Code", xStudentNo, xAcademicYear, xSemester, xTerm, xCourseCode, '', DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //Student Registration Update & Delete End------------------------------

    //Student Delete & Rename API ===20-07-2021====Start

    [EventSubscriber(ObjectType::Table, 50057, 'OnAfterRenameEvent', '', false, false)]
    procedure StudentRenameAPIEvent(var Rec: Record "Student Master-CS"; var xRec: Record "Student Master-CS"; RunTrigger: Boolean)
    begin
        StudentDeleteAPI(Rec, xRec."No.", 0, 'OnAfterDeleteEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50057, 'OnAfterDeleteEvent', '', false, false)]
    procedure StudentDeleteAPIEvent(var Rec: Record "Student Master-CS"; RunTrigger: Boolean)
    begin
        StudentDeleteAPI(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentDeleteAPI(var Rec: Record "Student Master-CS"; OldStudentNo_: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Delete_Update_Api_Student_Master?No=%1&OldNo=%2&Delete=%3', Rec."No.", OldStudentNo_, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    //Student Delete & Rename API ===20-07-2021====End

    // Doc & Cat Attachment ================Start===========16-08-2021

    [EventSubscriber(ObjectType::Table, 50258, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Academics_DocCateAttachmentOnInsert(var Rec: Record "Doc & Cate Attachment-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_DocCateAttachment(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50258, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Academics_DocCateAttachmentOnModify(var Rec: Record "Doc & Cate Attachment-CS"; var xRec: Record "Doc & Cate Attachment-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_Academics_DocCateAttachment(Rec, '', '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50258, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_Academics_DocCateAttachmentOnRename(var Rec: Record "Doc & Cate Attachment-CS"; var xRec: Record "Doc & Cate Attachment-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_DocCateAttachment(Rec, xRec.Code, xRec."Document Type", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50258, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_Academics_DocCateAttachmentOnDelete(Rec: Record "Doc & Cate Attachment-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_DocCateAttachment(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_Academics_DocCateAttachment(Rec: Record "Doc & Cate Attachment-CS"; OldCode: Code[20]; OldDocType: Text; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_DocCateAttachment?Code=%1&DocumentType=%2&Description=%3&Mandatory=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&UserID=%7&PortalID=%8&Updated=%9&DepartmentView=%10&Blocked=%11&PortalMenuID=%12&StudentUploadRequired=%13&DocumentNoRequired=%14&SortingNo=%15&ExpiryNotApplicable=%16&ValidityDays=%17&Responsibility=%18&ShowonPortal=%19&oldCode=%20&oldDocumentType=%21&Delete=%22', Rec.Code, Rec."Document Type", Rec.Description, HandlingBoolean(Rec.Mandatory), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec.Updated), Rec."Department View", HandlingBoolean(Rec.Blocked), Rec."Portal Menu ID", HandlingBoolean(Rec."Student Upload Required"), HandlingBoolean(Rec."Document No. Required"), Rec."Sorting No.", HandlingBoolean(Rec."Expiry Not Applicable"), Rec."Validity Days", HandlingOption(Rec.Responsibility), HandlingBoolean(Rec."Show on Portal"), OldCode, OldDocType, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    // Doc & Cat Attachment ================End===========16-08-2021

    procedure CreateAzureCalendarMeeting(Rec: Record "Advising Request")
    var
        RecCompanyInformation: Record "Company Information";
        StudentMaster_lRec: Record "Student Master-CS";
        EmployeeMaster_lRec: Record Employee;
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        EmailID1: Text;
        Name1: Text;
        EmailID2: Text;
        Name2: Text;
        StartDate: Date;
    Begin
        StudentMaster_lRec.Reset();
        If StudentMaster_lRec.Get(Rec."Student No.") then;

        EmployeeMaster_lRec.Reset();
        If EmployeeMaster_lRec.Get(Rec."Advisor ID") then;

        StartDate := 0D;

        If Rec."Confirm Date" = Rec."Confirm Date"::"Date 1" then
            StartDate := Rec."Requested Meeting Date1";

        If Rec."Confirm Date" = Rec."Confirm Date"::"Date 2" then
            StartDate := Rec."Requested Meeting Date2";

        If Rec."Confirm Date" = Rec."Confirm Date"::"Date 3" then
            StartDate := Rec."Requested Meeting Date3";

        EmailID1 := '';
        EmailID2 := '';
        Name1 := '';
        Name2 := '';
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If Rec.Requestor = Rec.Requestor::"By Student" then begin
            EmailID1 := StudentMaster_lRec."E-Mail Address";
            Name1 := StudentMaster_lRec."Student Name";
            EmailID2 := EmployeeMaster_lRec."Company E-Mail";
            Name2 := EmployeeMaster_lRec."First Name" + ' ' + EmployeeMaster_lRec."Last Name";
        end;
        IF Rec.Requestor = Rec.Requestor::"By Faculty" then begin
            EmailID1 := EmployeeMaster_lRec."Company E-Mail";
            Name1 := EmployeeMaster_lRec."First Name" + ' ' + EmployeeMaster_lRec."Last Name";
            EmailID2 := StudentMaster_lRec."E-Mail Address";
            Name2 := StudentMaster_lRec."Student Name";
        end;

        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/CreateAzureCalendarMeeting?AttendeesEmail_1=%1&AttendeesName_1=%2&AttendeesEmail_2=%3&AttendeesName_2=%4&Subject=%5&Description=%6&StartTime=%7&EndTime=%8&StartDate=%9&EndtDate=%10&Location=%11&TimeZone=%12&MeetingMode=%13&globaldimension1code=%14&AdvisingId=%15', EmailID1, Name1, EmailID2, Name2, Rec."Advising Topic Code", Rec."Advising Topic Description", Format(Rec."Meeting Start Time 1", 0, 9), Format(Rec."Meeting End Time 1", 0, 9), Format(StartDate, 0, 9), Format(StartDate, 0, 9), 'MEA', 'Eastern Standard Time', Rec."Meeting Mode", Rec."Global Dimension 1 Code", Rec."Request No");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'CreateAzureCalendarMeeting');
        end;
    End;

    Procedure AdvisingRequestAzureMeetingCancellation(Rec: Record "Advising Request")
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            If Rec."Request Status" = Rec."Request Status"::Cancel then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/AdvisingRequestAzureMeetingCancellation?AdvisngRequestNo=%1&comment=%2', Rec."Request No", Rec."Problem solution description");
            If Rec."Request Status" = Rec."Request Status"::Rescheduled then
                URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/AdvisingRequestAzureMeetingCancellation?AdvisngRequestNo=%1&comment=%2', Rec."Request No", Rec."Problem solution description");
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'AdvisingRequestAzureMeetingCancellation');
        end;

    End;



    procedure Save_Update_TentativeHousingAllotmentAlert(Rec: Record "Housing Application");
    Var
        RecCompanyInformation: Record "Company Information";
        RoomCategoryMaster: Record "Room Category Master";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        RoomCategoryNAme: Text;
    begin
        RoomCategoryName := '';
        RoomCategoryMaster.Reset();
        RoomCategoryMaster.Setrange("Room Category Code", Rec."Room Category Code");
        IF RoomCategoryMaster.Findfirst() then
            RoomCategoryName := RoomCategoryMaster."Room Category Name";

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_TentativeHousingAllotmentAlert?HousingApplicationNo=%1&StudentNo=%2&StudentName=%3&HousingName=%4&Apartmentnumber=%5&RoomNumber=%6&Cost=%7&RoomCategoryDescription=%8&OldHousingApplicationNo=%9&Delete=%10', Rec."Application No.", Rec."Student No.", Rec."Student Name", Rec."Temporary Housing Name", rec."Temporary Apartment No.", rec."Temporary Room No.", 0, RoomCategoryName, '', 0);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, 'Save_Update_TentativeHousingAllotmentAlert');
        end;
    end;

    //CSPL-00307 HelloSignStart-
    procedure Hello_Sign_Download_Email_Sent(DocNo: Code[20]; StudentNo: Code[20]; ApproverUserID: Code[50]; AppType: Text);
    Var
        RecCompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        LeaveApplication: Record "Leave Application-CS";
        Width: Record "Withdrawal Approvals";
        UsersRec: REcord User;
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        TableName: Text;

    begin
        IF AppType = 'LEAVE' then
            TableName := LeaveApplication.TableName();
        IF AppType = 'WITHDRAWL' then
            TableName := Width.TableName();
        IF ApproverUserID <> '' then begin
            IF UserSetup.Get(ApproverUserID) then;
            UsersRec.Reset();
            UsersRec.Setrange("User Name", ApproverUserID);
            IF UsersRec.FindFirst() then;
        end;




        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Hello_Sign_Download_Email_Sent?slcmdocumentno=%1&StudentNo=%2&applicationno=%3&approveremail=%4&approvername=%5&approverid=%6&applicationtype=%7', DocNo, StudentNo, DocNo, UserSetup."E-Mail", UsersRec."Full Name", '', AppType);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(TableName, ResponseText, 'Hello_Sign_Download_Email_Sent');
        end;
    end;
    //CSPL-00307 HelloSignEnds

    [EventSubscriber(ObjectType::Table, 50368, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_TopicMasterOnInsert(VAR Rec: Record "Topic Master"; RunTrigger: Boolean)
    begin
        TopicMasterFn(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50368, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_TopicMasterOnModify(VAR Rec: Record "Topic Master"; VAR xRec: Record "Topic Master"; RunTrigger: Boolean)
    begin
        TopicMasterFn(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50368, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_TopicMasterOnRename(VAR Rec: Record "Topic Master"; VAR xRec: Record "Topic Master"; RunTrigger: Boolean)
    begin
        TopicMasterFn(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50368, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_TopicMasterOnDelete(VAR Rec: Record "Topic Master"; RunTrigger: Boolean)
    begin
        TopicMasterFn(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure TopicMasterFn(var Rec: Record "Topic Master"; xRecOldNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_TopicMaster?EntryNo_=%1&Code=%2&AdviserId=%3&StudentLastNameChar_=%4&A=%5&B=%6&C=%7&D=%8&E=%9&F=%10&G=%11&H=%12&I=%13&J=%14&K=%15&L=%16&M=%17&N=%18&O=%19&P=%20&Q=%21&R=%22&S=%23&T=%24&U=%25&V=%26&W=%27&X=%28&Y=%29&Z=%30&firstChara=%31&LastChr=%32&firstChr=%33&AdvisorName=%34&OldEntryNo=%35&Delete=%36', Rec."Entry No.", Rec.Code, Rec."Adviser Id", Rec."Student Last Name Char.", HandlingBoolean(Rec.A), HandlingBoolean(Rec.B), HandlingBoolean(Rec.C), HandlingBoolean(Rec.D), HandlingBoolean(Rec.E), HandlingBoolean(Rec.F), HandlingBoolean(Rec.G), HandlingBoolean(Rec.H), HandlingBoolean(Rec.I), HandlingBoolean(Rec.J), HandlingBoolean(Rec.K), HandlingBoolean(Rec.L), HandlingBoolean(Rec.M), HandlingBoolean(Rec.N), HandlingBoolean(Rec.O), HandlingBoolean(Rec.P), HandlingBoolean(Rec.Q), HandlingBoolean(Rec.R), HandlingBoolean(Rec.S), HandlingBoolean(Rec.T), HandlingBoolean(Rec.U), HandlingBoolean(Rec.V), HandlingBoolean(Rec.W), HandlingBoolean(Rec.X), HandlingBoolean(Rec.Y), HandlingBoolean(Rec.Z), '', Rec."Last Chr", Rec."first Chr", Rec."Advisor Name", xRecOldNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50153, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Academics_InternalExamLineCSOnInsert(var Rec: Record "Internal Exam Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_InternalExamLineCS(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50153, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Academics_InternalExamLineCSOnModify(var Rec: Record "Internal Exam Line-CS"; var xRec: Record "Internal Exam Line-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_Academics_InternalExamLineCS(Rec, '', '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50153, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_Academics_InternalExamLineCSOnRename(var Rec: Record "Internal Exam Line-CS"; var xRec: Record "Internal Exam Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_InternalExamLineCS(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50153, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_Academics_InternalExamLineCSOnDelete(Rec: Record "Internal Exam Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_InternalExamLineCS(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_Academics_InternalExamLineCS(Rec: Record "Internal Exam Line-CS"; OldCode: Code[20]; xRecOldLineNo: Text; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_InternalExamLineCS?DocumentNo_=%1&LineNo_=%2&Course=%3&Semester=%4&SubjectType=%5&SubjectCode=%6&MarksObtained=%7&StudentNo_=%8&StudentName=%9&Section=%10&AttendanceType=%11&ExamMethodCode=%12&AcademicYear=%13&Grade=%14&Rank=%15&ASN=%16&ACT=%17&DimensionSetID=%18&GlobalDimension1Code=%19&GlobalDimension2Code=%20&TypeOfCourse=%21FinalYearsCourse=%22&ExamGroup=%23&Year=%24&DocumentType=%25&ReSessional=%26&Status=%27&Attendance=%28&ExamType=%29&RollNo_=%30&CreatedBy=%31&CreatedOn=%32&ModifiedBy=%33&ModifiedOn=%34&UpdatedByName=%35&CreatedByName=%36&AssignmentMarks=%37&EnrollmentNo_=%38&ExamMethod=%39&MaximumInternalMarks=%40&ObtainedInternalMarks=%41&MaximumWeightage=%42&ObtainedWeightage=%43&MarksPublished=%44&Updated=%45&MALPracticeLevel=%46&Program=%47&Reason=%48&StudentGroup=%49&SubjectClass=%50&MobileInsert=%51&MobileUpdate=%52&PercentageObtained=%53&ExamDate=%54&ExamSlot=%55&Term=%56&ExamClassification=%57&ExamScheduleNo_=%58&Batch=%59&StartTime=%60&EndTime=%61&LeaveTypes=%62&OriginalStudentNo_=%63&SelectToPerform=%64&CBSEVersion=%65&PublishedDocumentNo_=%66&OldDocumentNo=%67&OldLineNo=%68&Delete=%69&', Rec."Document No.", Rec."Line No.", Rec.Course, Rec.Semester, Rec."Subject Type", Rec."Subject Code", Rec."Marks Obtained", Rec."Student No.", Rec."Student Name", Rec.Section, HandlingOption(Rec."Attendance Type"), Rec."Exam Method Code", Rec."Academic Year", Rec.Grade, Rec.Rank, Rec.ASN, Rec.ACT, Rec."Dimension Set ID", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec."Exam Group", Rec.Year, HandlingOption(Rec."Document Type"), Rec."Re-Sessional", HandlingOption(Rec.Status), Rec."Attendance %", HandlingOption(Rec."Exam Type"), Rec."Roll No.", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9), Rec."Updated By Name", Rec."Created By Name", Rec."Assignment Marks", Rec."Enrollment No.", Rec."Exam Method", Rec."Maximum Internal  Marks", Rec."Obtained Internal Marks", Rec."Maximum Weightage", Rec."Obtained Weightage", HandlingBoolean(Rec."Marks Published"), HandlingBoolean(Rec.Updated), Rec."MAL Practice Level", Rec.Program, Rec.Reason, Rec."Student Group", Rec."Subject Class", HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), Rec."Percentage Obtained", Format(Rec."Exam Date", 0, 9), Rec."Exam Slot", HandlingOption(Rec.Term), Rec."Exam Classification", Rec."Exam Schedule No.", Rec.Batch, Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), Rec."Leave Types", Rec."Original Student No.", HandlingBoolean(Rec."Select To Perform"), Rec."CBSE Version", Rec."Published Document No.", OldCode, xRecOldLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;



    /////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////11.11.2021///////////////////////////////



    [EventSubscriber(ObjectType::Table, 50156, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Academics_InternalExamHeaderCSOnInsert(var Rec: Record "Internal Exam Header-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_InternalExamHeaderCS(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50156, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Academics_InternalExamHeaderCSOnModify(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_Academics_InternalExamHeaderCS(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50156, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_Academics_InternalExamHeaderCSOnRename(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_InternalExamHeaderCS(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50156, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_Academics_InternalExamHeaderCSOnDelete(Rec: Record "Internal Exam Header-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_InternalExamHeaderCS(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_Academics_InternalExamHeaderCS(Rec: Record "Internal Exam Header-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_InternalExamHeaderCS?No_=%1&CourseCode=%2&Semester=%3&SubjectType=%4&SubjectCode=%5&SubjectDescription=%6&ExamMethodCode=%7&ExamDescription=%8&MaximumMark=%9&AcademicYear=%10&StaffCode=%11&No_Series=%12&Section=%13&ResultGenerated=%14&CBCSBatch=%15&DimensionSetID=%16&GlobalDimension1Code=%17&GlobalDimension2Code=%18&TypeOfCourse=%19&FinalYearsCourse=%20&Year=%21&ExamGroup=%22&Status=%23&DocumentType=%24&ExamType=%25&UserID=%26&PortalID=%27&CreatedBy=%28&CreatedOn=%29&ModifiedBy=%30&ModifiedOn=%31&UpdatedByName=%32&CreatedByName=%33&ExamScheduleCode=%34&SubjectClass=%35&CourseName=%36&MaximumWeightage=%37&ExamDate=%38&StaffName=%39&Updated=%40&Program=%41&StudentGroup=%42&Term=%43&ExamClassification=%44&ExamSlot=%45&Batch=%46&StartTime=%47&EndTime=%48&OldNo=%49&Delete=%50&', Rec."No.", Rec."Course Code", Rec.Semester, Rec."Subject Type", Rec."Subject Code", Rec."Subject Description", Rec."Exam Method Code", Rec."Exam Description", Rec."Maximum Mark", Rec."Academic Year", Rec."Staff Code", Rec."No.Series", Rec.Section, HandlingBoolean(Rec."Result Generated"), Rec."CBCS Batch", Rec."Dimension Set ID", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Year, Rec."Exam Group", HandlingOption(Rec."Document Type"), HandlingOption(Rec."Exam Type"), (Rec."User ID"), Rec."Portal ID", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", fORMAT(Rec."Modified On", 0, 9), Rec."Updated By Name", Rec."Created By Name", Rec."Exam Schedule Code", Rec."Subject Class", Rec."Course Name", Rec."Maximum Weightage", Format(Rec."Exam Date", 0, 9), (Rec."Staff Name"), HandlingBoolean(Rec.Updated), Rec.Program, Rec."Student Group", HandlingOption(Rec.Term), Rec."Exam Classification", (Rec."Exam Slot"), Rec.Batch, Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    ///////////////////////////////11.15.2021

    [EventSubscriber(ObjectType::Table, 50154, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Academics_ExternalExamLineCSOnInsert(var Rec: Record "External Exam Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_ExternalExamLineCS(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50154, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Academics_ExternalExamLineCSOnModify(var Rec: Record "External Exam Line-CS"; var xRec: Record "External Exam Line-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_Academics_ExternalExamLineCS(Rec, '', '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50154, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_Academics_ExternalExamLineCSOnRename(var Rec: Record "External Exam Line-CS"; var xRec: Record "External Exam Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_ExternalExamLineCS(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50154, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_Academics_ExternalExamLineCSOnDelete(Rec: Record "External Exam Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_Academics_ExternalExamLineCS(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_Academics_ExternalExamLineCS(Rec: Record "External Exam Line-CS"; OldCode: Code[20]; xRecOldLineNo: Text; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ExternalExamLineCS?DocumentNo_=%1&LineNo_=%2&Course=%3&Semester=%4&SubjectType=%5&SubjectCode=%6&ExternalMark=%7&StudentNo_=%8&StudentName=%9&Section=%10&InternalMark=%11&Total=%12&Result=%13&AttendanceType=%14&Std_Grade=%15&Academicyear=%16&ApplyType=%17&Points=%18&PercentageObtained=%19&TotalMaximum=%20&OldResultI=%21&OldResultII=%22&OldResultIII=%23&CrPoints=%24&GraceMarks=%25&ExternalMarksOldResultI=%26&ExternalMarksOldResultII=%27&ExternalMarksOldResultIII=%28&Detained=%29&Absent=%30&UFM=%31&Dropped=%32&DimensionSetID=%33&GlobalDimension1Code=%34&GlobalDimension2Code=%35&TypeOfCourse=%36&FinalYearsCourse=%37&Year=%38&DocumentType=%39&Status=%40&Attendance_=%41&GradeGenerated=%42&ExamType=%43&GradePoints=%44&CreditGradePointsCGP=%45&Rev_Grade=%46&RollNo_=%47&MALPracticeLevel=%48&EnrollmentNo_=%49&StaffCode=%50&Updated=%51&ExamClassification=%52&Program=%53&SubjectClass=%54&MarksPublished=%55&ExamGroup=%56&ExternalMaximum=%57&Batch=%58&ExamScheduleNo_=%59&CreatedBy=%60&CreatedOn=%61&UpdatedBy=%62&UpdatedOn=%63&UpdatedByName=%64&CreatedByName=%65&Term=%66&ExamDate=%67&ExamSlot=%68&StartTime=%69&EndTime=%70&LeaveTypes=%71&ObtainedWeightage=%72&MaximumWeightage=%73&ReasonCode=%74&ReasonDescription=%75&OriginalStudentNo_=%76&StudentGroup=%77&SelectToPerform=%78&CBSEVersion=%79&PublishedDocumentNo_=%80&OldDocumentNo=%81&OldLineNo=%82&Delete=%83&', Rec."Document No.",
            Rec."Line No.",
             Rec.Course,
             Rec.Semester,
             Rec."Subject Type",
              Rec."Subject Code",
               Rec."External Mark",
                Rec."Student No.",
                Rec."Student Name",
                 Rec.Section,
                 Rec."Internal Mark",
                 Rec.Total,
                  HandlingOption(Rec.Result),
                  HandlingOption(Rec."Attendance Type"),
                   Rec."Std. Grade",
                    Rec."Academic year",
                     HandlingOption(Rec."Apply Type"),
                      Rec.Points,
                       Rec."Percentage Obtained",
                       (Rec."Total Maximum"),
                       HandlingOption(Rec."Old Result-I"),
                        HandlingOption(Rec."Old Result-II"),
                        HandlingOption(Rec."Old Result-III"),
                         Rec."Cr Points",
                          Rec."Grace Marks",
                           Rec."External Marks Old Result-I",
                            Rec."External Marks Old Result-II",
                             Rec."External Marks Old Result-III",
                              HandlingBoolean(Rec.Detained),
                              HandlingBoolean(Rec.Absent),
                               HandlingBoolean(Rec.UFM),
                                HandlingBoolean(Rec.Dropped),
                                 Rec."Dimension Set ID",
                                 (Rec."Global Dimension 1 Code"),
                                 (Rec."Global Dimension 2 Code"),
                                  HandlingOption(Rec."Type Of Course"),
                                  Rec."Final Years Course",
                                   Rec.Year,
                                   HandlingOption(Rec."Document Type"),
                                   HandlingOption(Rec.Status),
                                    Rec."Attendance %",
                                    HandlingBoolean(Rec."Grade Generated"),
                                     HandlingOption(Rec."Exam Type"),
                                      Rec."Grade Points",
                                      rec."Credit Grade Points(CGP)",
                                       Rec."Rev. Grade",
                                       Rec."Roll No.",
                                        Rec."MAL Practice Level",
                                        Rec."Enrollment No.",
                                         Rec."Staff Code",
                                         HandlingBoolean(Rec.Updated),
                                         Rec."Exam Classification",
                                          Rec.Program,
                                          Rec."Subject Class",
                                           HandlingBoolean(Rec."Marks Published"),
                                           Rec."Exam Group",
                                           Rec."External Maximum",
                                           Rec.Batch, Rec."Exam Schedule No.",
                                           Rec."Created By",
                                           Format(Rec."Created On", 0, 9),
                                           Rec."Updated By",
                                           Format(Rec."Updated On", 0, 9),
                                           Rec."Updated By Name",
                                           Rec."Created By Name",
                                           HandlingOption(Rec.Term),
                                           Format(Rec."Exam Date", 0, 9),
                                           Rec."Exam Slot",
                                           Format(Rec."Start Time", 0, 9),
                                           Format(Rec."End Time", 0, 9),
                                           Rec."Leave Types",
                                           Rec."Obtained Weightage",
                                           Rec."Maximum Weightage",
                                           rec."Reason Code",
                                           Rec."Reason Description",
                                           Rec."Original Student No.",
                                           Rec."Student Group",
                                           HandlingBoolean(Rec."Select To Perform"),
                                           Rec."CBSE Version",
                                           Rec."Published Document No.",
                                           OldCode, xRecOldLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;



    //////////////////
    /// 
    [EventSubscriber(ObjectType::Table, 50209, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_Academics_ExternalExamHeaderCSOnInsert(var Rec: Record "External Exam Header-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ExternalExamHeaderCS(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50209, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Academics_ExternalExamHeaderCSOnModify(var Rec: Record "External Exam Header-CS"; var xRec: Record "External Exam Header-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_ExternalExamHeaderCS(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50209, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_Academics_ExternalExamHeaderCSOnRename(var Rec: Record "External Exam Header-CS"; var xRec: Record "External Exam Header-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ExternalExamHeaderCS(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50209, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_Academics_ExternalExamHeaderCSOnDelete(Rec: Record "External Exam Header-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ExternalExamHeaderCS(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_ExternalExamHeaderCS(Rec: Record "External Exam Header-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ExternalExamHeaderCS?No_=%1&CourseCode=%2&Semester=%3&SubjectType=%4&SubjectCode=%5&ExternalMaximum=%6&AcademicYear=%7&StaffCode=%8&No_Series=%9&Section=%10&TotalMaximum=%11&InternalGenerated=%12&ExternalGenerated=%13&ResultGenerated=%14&CBCSBatch=%15&DimensionSetID=%16&Status=%17&GlobalDimension1Code=%18&GlobalDimension2Code=%19&Updated=%20&TypeOfCourse=%21&FinalYearsCourse=%22&Year=%23&InternalMaximum=%24&MinimumCreditPointsRequired=%25&DocumentType=%26&ExamType=%27&ExamScheduleCode=%28&SubjectClass=%29&CourseName=%30&SubjectDescription=%31&ExamDate=%32&Program=%33&StudentGroup=%34&ExamClassification=%35&UserID=%36&PortalID=%37&CreatedBy=%38&CreatedOn=%39&UpdatedBy=%40&UpdatedOn=%41&UpdatedByName=%42&CreatedByName=%43&Term=%44&ExamSlot=%45&Batch=%46&StartTime=%47&EndTime=%48&OldNo=%49&Delete=%50&',
           Rec."No.", Rec."Course Code", Rec.Semester, Rec."Subject Type", Rec."Subject Code", Rec."External Maximum", Rec."Academic Year", Rec."Staff Code", Rec."No.Series", Rec.Section, Rec."Total Maximum", HandlingBoolean(Rec."Internal Generated"), HandlingBoolean(Rec."External Generated"), HandlingBoolean(Rec."Result Generated"), Rec."CBCS Batch", Rec."Dimension Set ID", HandlingOption(Rec.Status), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Updated), HandlingOption(Rec."Type Of Course"), (Rec."Final Years Course"), (Rec.Year), Rec."Internal Maximum", Rec."Minimum Credit Points Required", HandlingOption(Rec."Document Type"), HandlingOption(Rec."Exam Type"), Rec."Exam Schedule Code", Rec."Subject Class", Rec."Course Name", Rec."Subject Description", Format(Rec."Exam Date", 0, 9), Rec.Program, Rec."Student Group", Rec."Exam Classification", Rec."User ID", Rec."Portal ID", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By Name", Rec."Created By Name", HandlingOption(Rec.Term), Rec."Exam Slot", Rec.Batch, Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;


    //22Dec2021
    PRocedure ChangeUserRoleToGraduate(Rec: Record "Student Master-CS")
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/ChangeUserRoleToGraduate?UID=%1', Rec."No.");

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'ChangeUserRoleToGraduate');
        End;
    end;
    //22Dec2021

    //06Jan2022
    [EventSubscriber(ObjectType::Table, 50531, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_OLRUpdateHeaderOnInsert(VAR Rec: Record "OLR Update Header"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateHeader(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50531, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_OLRUpdateHeaderOnModify(VAR Rec: Record "OLR Update Header"; VAR xRec: Record "OLR Update Header"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateHeader(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50531, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_OLRUpdateHeaderOnRename(VAR Rec: Record "OLR Update Header"; VAR xRec: Record "OLR Update Header"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateHeader(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50531, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_OLRUpdateHeaderOnDelete(VAR Rec: Record "OLR Update Header"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateHeader(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure Save_Update_OLRUpdateHeader(var Rec: Record "OLR Update Header"; xRecEntryNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_OLRUpdateHeader?No=%1&AcademicYear=%2&Term=%3&CourseCode=%4&Semester=%5&OLRAcademicYear=%6&OLRTerm=%7&OLRSemester=%8&CreatedBy=%9&CreatedOn=%10&UpdatedBy=%11&UpdatedOn=%12&Inserted=%13&Updated=%14&OLRStartDate=%15&Status=%16&ConfirmedOn=%17&ConfirmedBy=%18&NoSeries=%19&GlobalDimension1Code=%20&OldNo=%21&Delete=%22', Rec."No.", Rec."Academic Year", HandlingOption(Rec.Term), Rec."Course Code", Rec.Semester, Rec."OLR Academic Year", HandlingOption(Rec."OLR Term"), Rec."OLR Semester", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), Format(Rec."OLR Start Date", 0, 9), HandlingOption(Rec.Status), Rec."Confirmed By", Format(Rec."Confirmed On", 0, 9), Rec."No. Series", Rec."Global Dimension 1 Code", xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    [EventSubscriber(ObjectType::Table, 50532, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_OLRUpdateLineOnInsert(var Rec: Record "OLR Update Line"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateLine(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50532, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_OLRUpdateLineOnModify(var Rec: Record "OLR Update Line"; var xRec: Record "OLR Update Line"; RunTrigger: Boolean)
    Begin
        Save_Update_OLRUpdateLine(Rec, '', '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50532, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_OLRUpdateLineOnRename(var Rec: Record "OLR Update Line"; var xRec: Record "OLR Update Line"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateLine(Rec, xRec."Document No.", Format(xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50532, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_OLRUpdateLineOnDelete(Rec: Record "OLR Update Line"; RunTrigger: Boolean)
    begin
        Save_Update_OLRUpdateLine(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_OLRUpdateLine(Rec: Record "OLR Update Line"; OldCode: Code[20]; xRecOldLineNo: Text; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_OLRUpdateLine?DocumentNo=%1&LineNo=%2&StudentNo=%3&StudentName=%4&EnrollmentNo=%5&OriginalStudentNo=%6&Status=%7&CourseCode=%8&AcademicYear=%9&Term=%10&GlobalDimension1Code=%11&Semester=%12&RegistrarSignOff=%13&OLRStartDate=%14&OLRAcademicYear=%15&OLRSemester=%16&OLRTerm=%17&Confirmed=%18&Select=%19&OLRStatus=%20&ReadytoConfirm=%21&ProcessDateTime=%22&ReminderNo=%23&Reminder=%24&StudentMasterSync=%25&InsertBy=%26&InsertOn=%27&ModifiedBy=%28&ModifiedOn=%29&OldDocumentNo=%30&OldLineNo=%31&Delete=%32', Rec."Document No.", Rec."Line No.", Rec."Student No.", Rec."Student Name", Rec."Enrollment No.", Rec."Original Student No.", Rec.Status, Rec."Course Code", Rec."Academic Year", HandlingOption(Rec.Term), Rec."Global Dimension 1 Code", Rec.Semester, HandlingBoolean(Rec."Registrar Sign Off"), Format(Rec."OLR Start Date", 0, 9), Rec."OLR Academic Year", Rec."OLR Semester", HandlingOption(Rec."OLR Term"), HandlingBoolean(Rec.Confirmed), HandlingBoolean(Rec.Select), HandlingOption(Rec."OLR Status"), HandlingBoolean(Rec."Ready to Confirm"), Format(Rec."Process Date Time", 0, 9), Rec."Reminder No.", HandlingBoolean(Rec.Reminder), HandlingBoolean(Rec."Student Master Sync"), Rec."Insert By", Format(Rec."Insert On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9), OldCode, xRecOldLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    //Site Visit =======03-08-2021=======Start
    [EventSubscriber(ObjectType::Table, 50449, 'OnAfterInsertEvent', '', False, false)]
    procedure Save_Update_ResidencySiteVisitOnInsert(var Rec: Record "Site Visit"; RunTrigger: Boolean)
    begin
        SiteVisitFn(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50449, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_ResidencySiteVisitOnModify(var Rec: Record "Site Visit"; var xRec: Record "Site Visit"; RunTrigger: Boolean)
    begin
        SiteVisitFn(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50449, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_ResidencySiteVisitOnDelete(var Rec: Record "Site Visit"; RunTrigger: Boolean)
    begin
        SiteVisitFn(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50449, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_ResidencySiteVisitOnRename(var Rec: Record "Site Visit"; var xRec: Record "Site Visit"; RunTrigger: Boolean)
    begin
        SiteVisitFn(Rec, xRec."Document No.", 0, 'OnAfterRenameEvent');

    end;

    procedure SiteVisitFn(Rec: Record "Site Visit"; OldDocNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ResidencySiteVisit?DocumentNo_=%1&EntryDate=%2&UserID=%3&VisitDate=%4&HospitalID=%5&HospitalName=%6&DepartmentName=%7&PersonName=%8&VisitReason=%9&Inference=%10&CreatedBy=%11&Speciality=%12&CourseDescription=%13&Inserted=%14&InsertedBy=%15&InsertedOn=%16&Updated=%17&UpdatedBy=%18&UpdatedOn=%19&No_Series=%20&VisitorName=%21&DateofVisit=%22&NameoftheInstitute=%23&NumberofBeds=%24&StreetAddress=%25&City=%26&State=%27&Country=%28&ZipCode=%29&ApprovedACGMEResiencyPrograms=%30&OtherServices=%31&DMEFirstName=%32&DMELastName=%33&DMEEmail=%34&DMEPhonewithAreaCode=%35&DeptChairpersonFirstName=%36&DeptChairpersonLastName=%37&DeptChairpersonEmail=%38&DeptChairpersonPhonewithAreaCode=%39&ProgramDirectorFirstName=%40&ProgramDirectorLastName=%41&ProgramDirectorEmail=%42&ProgramDirectorPhonewithAreaCode=%43&ClerkshipDirectorFirstName=%44&ClerkshipDirectorLastName=%45&ClerkshipDirectorEmail=%46&ClerkshipDirectorPhonewithAreaCode=%47&StudentPreceptorContact=%48&StudentCoordinatorContact=%49&NumberofClinicalFaculty=%50&FormalLectures=%51&InformalTeaching=%52&FacultySupervision=%53&FacultyAssessmentofStudents=%54&GeneralComments1=%55&NumberofAUAstudentsRotating=%56&Numberofstudentsfromothermedicalschoolsinthatrotation=%57&ParticipatesMorningReport=%58&ParticipatesDailyRounds=%59&PerformsHistory=%60&PerformsPhysical=%61&AmbulatoryTraining=%62&PerformsProcedures=%63&Writes_TypesOrders=%64&EMREntry=%65&NightCalls_Rotation=%66&CasePresentations=%67&General_Comments=%68&EducationFacilities=%69&StudentFacilities=%70&Rating=%71&GeneralComments2=%72&Approval=%73&ApprovalComments=%74&AreaCode1=%75&AreaCode2=%76&AreaCode3=%77&AreaCode4=%78&Appr_ACGMEResidencyProg_=%79&DeptChairpersonPhone=%80&ProgramDirectorPhone=%81&ClerkshipDirectorPhone=%82&AUAstudentsRotating=%83&OtherMed_SchoolRotation=%84&Speciality1=%85&DMEwithAreaCode=%86&DeptChair_withAreaCode=%87&ProgramDirectorAreaCode=%88&Clerk_Direc_AreaCode=%89&OtherSpeciality=%90&OldDocumentNo=%91&Delete=%92', Rec."Document No.", Format(Rec."Entry Date", 0, 9), Rec."User ID", Format(Rec."Visit Date", 0, 9), Rec."Hospital ID", Rec."Hospital Name", Rec."Department Name", Rec."Person Name", Rec."Visit Reason", Rec.Inference, Rec."Created By", Rec.Speciality, Rec."Course Description", HandlingBoolean(Rec.Inserted), Rec."Inserted By", Format(Rec."Inserted On", 0, 9), HandlingBoolean(Rec.Updated), Rec."Updated By", Format(Rec."Updated On", 0, 9), Rec."No. Series", Rec."User ID", Format(Rec."Visit Date", 0, 9), Rec."Hospital Name", Rec."Number of Beds", Rec."Street Address", Rec.City, Rec.State, Rec.Country, Rec."Zip Code", Rec."Appr. ACGME Residency Prog.", Rec."Other Services", Rec."DME First Name", Rec."DME Last Name", Rec."DME Email", Rec."DME Phone with Area Code", Rec."Dept Chairperson First Name", Rec."Dept Chairperson Last Name", Rec."Dept Chairperson Email", Rec."Dept Chairperson Phone", Rec."Program Director First Name", Rec."Program Director Last Name", Rec."Program Director Email", Rec."Program Director Phone", Rec."Clerkship Director First Name", Rec."Clerkship Director Last Name", Rec."Clerkship Director Email", Rec."Clerkship Director Phone", Rec."Student Preceptor Contact", Rec."Student Coordinator Contact", Rec."Number of Clinical Faculty", Rec."Formal Lectures", Rec."Informal Teaching", Rec."Faculty Supervision", Rec."Faculty Assessment of Students", Rec."General Comments", Rec."AUA students Rotating", Rec."Other Med. School Rotation", HandlingBoolean(Rec."Participates Morning Report"), HandlingBoolean(Rec."Participates Daily Rounds"), HandlingBoolean(Rec."Performs History"), HandlingBoolean(Rec."Performs Physical"), HandlingBoolean(Rec."Ambulatory Training"), HandlingBoolean(Rec."Performs Procedures"), HandlingBoolean(Rec."Writes/Types Orders"), HandlingBoolean(Rec."EMR Entry"), HandlingBoolean(Rec."Night Calls/Rotation"), HandlingBoolean(Rec."Case Presentations"), Rec.General_Comments, Rec."Education Facilities", Rec."Student Facilities", HandlingOption(Rec.Rating), Rec.GeneralComments, HandlingOption(Rec.Approval), Rec."Approval Comments", '', '', '', '', Rec."Appr. ACGME Residency Prog.", Rec."Dept Chairperson Phone", Rec."Program Director Phone", Rec."Clerkship Director Phone", Rec."AUA students Rotating", Rec."Other Med. School Rotation", HandlingOption(Rec."Speciality 1"), Rec."DME with Area Code", Rec."Dept Chair. with Area Code", Rec."Program Director Area Code", Rec."Clerk. Direc. Area Code", Rec."Other Speciality", OldDocNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;
    //Site Visit =======03-08-2021=======End

    [EventSubscriber(ObjectType::Table, 50498, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentSubjectExamOnInsert(VAR Rec: Record "Student Subject Exam"; RunTrigger: Boolean)
    begin
        StudentStudentSubjectExamFn(Rec, '', '', '', '', '', '', 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50498, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentSubjectExamOnModify(VAR Rec: Record "Student Subject Exam"; VAR xRec: Record "Student Subject Exam"; RunTrigger: Boolean)
    begin
        StudentStudentSubjectExamFn(Rec, '', '', '', '', '', '', 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50498, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentSubjectExamOnRename(VAR Rec: Record "Student Subject Exam"; VAR xRec: Record "Student Subject Exam"; RunTrigger: Boolean)
    begin
        StudentStudentSubjectExamFn(Rec, Format(xRec."Student No."), Format(xRec.Course), Format(xRec.Semester), Format(xRec."Academic Year"), Format(xRec."Subject Code"), Format(xRec.Section), Xrec."Line No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50498, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_StudentSubjectExamOnDelete(VAR Rec: Record "Student Subject Exam"; RunTrigger: Boolean)
    begin
        StudentStudentSubjectExamFn(Rec, '', '', '', '', '', '', 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentStudentSubjectExamFn(var Rec: Record "Student Subject Exam"; xRecOldStudentNo: Code[20]; xRecOldCourse: Code[20]; xRecOldSemester: Code[20];
    xRecOldAcademicYear: Code[20]; xRecOldSubjectCode: Code[20]; xRecSection: code[20]; RecOldLineNo_: Integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentSubjectExam?StudentNo_=%1&Course=%2&Semester=%3&AcademicYear=%4&SubjectCode=%5&Section=%6&LineNo_=%7&Description=%8&InternalMark=%9&ExternalMark=%10&Total=%11&Result=%12&Grade=%13&StudentName=%14&Credit=%15&MaximumMark=%16&PercentageObtained=%17&GlobalDimension1Code=%18&GlobalDimension2Code=%19&Year=%20&EnrollmentNo=%21&CreditEarned=%22&CreditGradePointsEarned=%23&CurrencyCode=%24&TotalInternal=%25&Updated=%26&SubjectGroup=%27&SubjectGroupDescription=%28&Level=%29&Term=%30&CategoryCourseDescription=%31&Sequence=%32&SchoolID=%33&TC=%34&UserID=%35&AdClassSchedCode=%36&StartDate=%37&EndDate=%38&Block=%39&ProgramID=%40&ProgramDescription=%41&ProgramVersionCode=%42&ProgramVersionDescription=%43&ScoreType=%44&OriginalStudentNo_=%45&StepExam=%46&ScoreAvailableUntil=%47&DateCertified=%48&ExamWindow=%49&SittingDate=%50&Exam_Location=%51&PublishedDocumentNo_=%52&Published=%53&PublishedEntryNo_=%54&CreationDate=%55&ModificationDate=%56&ModifiedBy=%57&ExamSequence=%58&CoreClerkshipSubjectCode=%59&CoreClerkshipSubjectDesc=%60&ShelfExamValue=%61&ConsideredinGrading=%62&LevelDescription=%63&CBSEVersion=%64&OldStudentNo_=%65&OldCourse=%66&OldSemester=%67&OldAcademicYear=%68&OldSubjectCode=%69&OldSection=%70&OldLineNo_=%71&Delete=%72', Rec."Student No.", Rec.Course, Rec.Semester, Rec."Academic Year", (Rec."Subject Code"), (Rec.Section), Rec."Line No.", (Rec.Description), (Rec."Internal Mark"), (Rec."External Mark"), (Rec.Total), HandlingOption(Rec.Result), (Rec.Grade), (Rec."Student Name"), (Rec.Credit), (Rec."Maximum Mark"), (Rec."Percentage Obtained"), (Rec."Global Dimension 1 Code"), (Rec."Global Dimension 2 Code"), (Rec.Year), (Rec."Enrollment No"), (Rec."Credit Earned"), (Rec."Credit Grade Points Earned"), (Rec."Currency Code"), (Rec."Total Internal"), HandlingBoolean(Rec.Updated), (Rec."Subject Code"), (Rec."Subject Group Description"), (Rec."Level"), HandlingOption(Rec.Term), (Rec."Category-Course Description"), (Rec.Sequence), (Rec."School ID"), HandlingBoolean(Rec.TC), (Rec."User ID"), (Rec."AdClassSchedCode"), Format(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), HandlingBoolean(Rec.Block), (Rec."Program ID"), (Rec."Program Description"), (Rec."Program Version Code"), (Rec."Program Description"), HandlingOption(Rec."Score Type"), (Rec."Original Student No."), HandlingOption(Rec."Step Exam"), Format(Rec."Score Available Until", 0, 9), Format(Rec."Date Certified", 0, 9), (Rec."Exam Window"), Format(Rec."Sitting Date", 0, 9), (Rec."Exam. Location"), (Rec."Published Document No."), HandlingBoolean(Rec.Published), (Rec."Published Entry No."), Format(Rec."Creation Date", 0, 9), Format(Rec."Modification Date", 0, 9), (Rec."Modified By"), (Rec."Exam Sequence"), (Rec."Core Clerkship Subject Code"), (Rec."Core Clerkship Subject Desc"), (Rec."Shelf Exam Value"), HandlingBoolean(Rec."Considered in Grading"), HandlingOption(Rec."Level Description"), (Rec."CBSE Version"), (xRecOldStudentNo), (xRecOldCourse), (xRecOldSemester), (xRecOldAcademicYear), xRecOldSubjectCode, xRecSection, RecOldLineNo_, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    [EventSubscriber(ObjectType::Table, 50467, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Subject_Grade_BookOnInsert(VAR Rec: Record "Student Subject GradeBook"; RunTrigger: Boolean)
    begin
        StudentSubjectGradeBookFn(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50467, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Subject_Grade_BookOnModify(VAR Rec: Record "Student Subject GradeBook"; VAR xRec: Record "Student Subject GradeBook"; RunTrigger: Boolean)
    begin
        StudentSubjectGradeBookFn(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50467, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Subject_Grade_BookOnRename(VAR Rec: Record "Student Subject GradeBook"; VAR xRec: Record "Student Subject GradeBook"; RunTrigger: Boolean)
    begin
        StudentSubjectGradeBookFn(Rec, Format(xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50467, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Student_Subject_Grade_BookOnDelete(VAR Rec: Record "Student Subject GradeBook"; RunTrigger: Boolean)
    begin
        StudentSubjectGradeBookFn(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure StudentSubjectGradeBookFn(var Rec: Record "Student Subject GradeBook"; xRecOldNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentSubjectGradeBook?EntryNo_=%1&StudentNo_=%2&Semester=%3&SubjectCode=%4&AcademicYear=%5&Description=%6&Course=%7&Section=%8&InternalMark=%9&ExternalMark=%10&Total=%11&Result=%12&Grade=%13&StudentName=%14&PercentageObtained=%15&GlobalDimension1Code=%16&CreditEarned=%17&Term=%18&GradeBookNo_=%19&Recommendation=%20&_Range=%21&GradeToBePublished=%22&StartDate=%23&EndDate=%24&Status=%25&OldEntryNo_=%26&Delete=%27&communications=%28&createdby=%29&updatedby=%30&inserted=%31&updated=%32&failed=%33&academicsuggestion=%34&studentsemdocumentno_=%35&year=%36&numericgrade=%37&newsemester=%38&oldsemester=%39&GPA=%40', Rec."Entry No.", Rec."Student No.", Rec.Semester, Rec."Subject Code", Rec."Academic Year", Rec.Description, Rec.Course, Rec.Section, Rec."Internal Mark", Rec."External Mark", Rec.Total, HandlingOption(Rec.Result), Rec.Grade, Rec."Student Name", Rec."Percentage Obtained", Rec."Global Dimension 1 Code", Rec."Credit Earned", HandlingOption(Rec.Term), Rec."Grade Book No.", Rec.Recommendation, Rec."% Range", Rec."Grade Book No.", Format(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), HandlingOption(Rec.Status), xRecOldNo, (DeleteAllowed), Rec.communications, Rec."Created By", Rec."Updated By", HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.failed), HandlingOption(Rec."Academic Suggestion"), Rec."Student Sem Document No.", Rec.year, Rec."Numeric Grade", Rec."New Semester", Rec."Old Semester", Rec.GPA);
            IF HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    [EventSubscriber(ObjectType::Table, 50173, 'OnAfterInsertEvent', '', false, false)]
    procedure SaveUpdateTDifferentAttachmentCSMasterOnInsert(VAR Rec: Record "Different Attachment-CS"; RunTrigger: Boolean)
    begin
        ApiPortalSave_Update_Academics_DifferentAttachmentCS(Rec, 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50173, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_Academics_DifferentAttachmentCSOnModify(VAR Rec: Record "Different Attachment-CS"; RunTrigger: Boolean)
    begin
        ApiPortalSave_Update_Academics_DifferentAttachmentCS(Rec, 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50173, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_DifferentAttachmentCSOnRename(VAR Rec: Record "Different Attachment-CS"; VAR xRec: Record "Different Attachment-CS"; RunTrigger: Boolean)
    begin
        ApiPortalSave_Update_Academics_DifferentAttachmentCS(Rec, (xRec."S.No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50173, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_DifferentAttachmentCSOnDelete(VAR Rec: Record "Different Attachment-CS"; RunTrigger: Boolean)
    begin
        ApiPortalSave_Update_Academics_DifferentAttachmentCS(Rec, 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure ApiPortalSave_Update_Academics_DifferentAttachmentCS(VAR Rec: Record "Different Attachment-CS"; xRecOldNo: Integer; DeleteAllowed: Integer; TriggerName: text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_DifferentAttachment?SNo=%1&FacultyCode=%2&FacultyName=%3&FileName=%4&FileExtension=%5&FilePath=%6&AcademicYear=%7&CourseCode=%8&Semester=%9&Year=%10&SubjectCode=%11&Section=%12&DocumentType=%13&StartDate=%14&EndDate=%15&CreatedBy=%16&CreatedOn=%17&UpdatedBy=%18&UpdatedOn=%19&UpdatedByName=%20&CreatedByName=%21&Description=%22&IsActive=%23&GlobalDimension1Code=%24&GlobalDimension2Code=%25&Program=%26&Important=%27&TransactionNo_=%28&DocumentCategory=%29&No_=%30&oldS_No_=%31&Delete=%32', Rec."S.No.", Rec."Faculty Code", Rec."Faculty Name", Rec."File Name", Rec."File Extension", Rec."File Path", Rec."Academic Year", Rec."Course Code", Rec.Semester, Rec.Year, Rec."Subject Code", Rec.Section, Format(Rec."Document Type New"), Format(Rec."Start Date", 0, 9), Format(Rec."End Date", 0, 9), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), Rec."Updated By Name", Rec."Created By Name", Rec.Description, HandlingBoolean(Rec.IsActive), rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", rec.Program, HandlingBoolean(rec.Important), rec."Transaction No.", rec."Document Category", Rec."Student No.", xRecOldNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;





    //10.19.2021
    //Start AttachmentWiseStudentCS
    [EventSubscriber(ObjectType::Table, 50259, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_AttachmentWiseStudentCSFunctionOnModify(VAR Rec: Record "Attachment Wise Student-CS"; VAR xRec: Record "Attachment Wise Student-CS"; RunTrigger: Boolean)
    begin
        AttachmentWiseStudentCSFunction(Rec, '', 0, 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50259, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_AttachmentWiseStudentCSFunctionOnRename(VAR Rec: Record "Attachment Wise Student-CS"; VAR xRec: Record "Attachment Wise Student-CS"; RunTrigger: Boolean)
    begin
        AttachmentWiseStudentCSFunction(Rec, xRec."Student No.", xRec."Line No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50259, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_AttachmentWiseStudentCSFunctionOnDelete(VAR Rec: Record "Attachment Wise Student-CS"; RunTrigger: Boolean)
    begin
        AttachmentWiseStudentCSFunction(Rec, '', 0, 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50259, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_AttachmentWiseStudentCSFunctionOnInsert(VAR Rec: Record "Attachment Wise Student-CS"; RunTrigger: Boolean)
    begin
        AttachmentWiseStudentCSFunction(Rec, '', 0, 0, 'OnAfterInsertEvent')
    end;

    procedure AttachmentWiseStudentCSFunction(var Rec: Record "Attachment Wise Student-CS"; xRecAppNo: Code[20]; XRecLineNo: Integer; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_AttachmentWiseStudentCS?StudentNo_=%1&LineNo_=%2&StudentName=%3&EnrollmentNo_=%4&DocumentType=%5&FileName=%6&FileExtension=%7&FilePath=%8&CreatedBy=%9&CreatedOn=%10&UpdatedBy=%11&UpdatedOn=%12&UpdatedByName=%13&CreatedByName=%14&Approved=%15&ApprovedBy=%16&GlobalDimension1Code=%17&GlobalDimension2Code=%18&AttachmentNo_=%19&DocumentDescription=%20&TransactionNo_=%21&DocumentCategory=%22&Status=%23&RejectReason=%24&RejectReasonDescription=%25&OldStudentNo=%26&OldLineNo=%27&Delete=%28', Rec."Student No.", Rec."Line No.", Rec."Student Name", Rec."Enrollment No.", Rec."Document Type", Rec."File Name", Rec."File Extension", Rec."File Path", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), Rec."Updated By Name", Rec."Updated By Name", HandlingBoolean(Rec.Approved), Rec."Approved By", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Attachment No.", Rec."Document Description", Rec."Transaction No.", Rec."Document Category", HandlingOption(Rec.Status), Rec."Reject Reason", Rec."Reject Reason Description", xRecAppNo, XRecLineNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);


            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;

    [EventSubscriber(ObjectType::Table, 50470, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_StudentSemesterDecisionOnInsert(VAR Rec: Record StudentSemesterDecision; RunTrigger: Boolean)
    begin
        Save_Update_StudentSemesterDecision(Rec, 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50470, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_StudentSemesterDecisionOnModify(VAR Rec: Record StudentSemesterDecision; VAR xRec: Record StudentSemesterDecision; RunTrigger: Boolean)
    begin
        Save_Update_StudentSemesterDecision(Rec, 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50470, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_StudentSemesterDecisionOnRename(VAR Rec: Record StudentSemesterDecision; VAR xRec: Record StudentSemesterDecision; RunTrigger: Boolean)
    begin
        Save_Update_StudentSemesterDecision(Rec, (xRec."Decision No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50470, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_StudentSemesterDecisionOnDelete(VAR Rec: Record StudentSemesterDecision; RunTrigger: Boolean)
    begin
        Save_Update_StudentSemesterDecision(Rec, 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure Save_Update_StudentSemesterDecision(var Rec: Record StudentSemesterDecision; xRecEntryNo: Integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentSemesterDecision?DecisionNo=%1&StudentNo=%2&GlobalDimension1Code=%3&AcademicYear=%4&Term=%5&CourseCode=%6&Semester=%7&DecisionType=%8&DecisionDate=%9&DecisionTime=%10&EntryFromPortal=%11&CreatedBy=%12&CreatedOn=%13&UpdatedBy=%14&UpdatedOn=%15&StudentName=%16&PreviousSAP=%17&CalculatedSAP=%18&ApprovedRejectedBy=%19&ApprovedRejectedOn=%20&Status=%21&DocumentNo=%22&OldDecisionNo=%23&Delete=%24', Rec."Decision No.", Rec."Student No.", Rec."Global Dimension 1 Code", Rec."Academic Year", HandlingOption(Rec.Term), Rec."Course Code", Rec.Semester, HandlingOption(Rec."Decision Type"), Format(Rec."Decision Date", 0, 9), Format(Rec."Decision Time", 0, 9), HandlingBoolean(Rec."Entry From Portal"), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), Rec."Student Name", Rec."Previous SAP", Rec."Calculated SAP", Rec."Approved/Rejected By", Format(Rec."Approved/Rejected On", 0, 9), HandlingOption(Rec.Status), rec."Document No.", xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    [EventSubscriber(ObjectType::Table, 50123, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_TimePeriodOnInsert(var Rec: Record "Time Period-CS"; RunTrigger: Boolean)
    begin
        Save_Update_TimePeriod(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50123, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_TimePeriodOnModify(var Rec: Record "Time Period-CS"; var xRec: Record "Time Period-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_TimePeriod(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50123, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_TimePeriodOnRename(var Rec: Record "Time Period-CS"; var xRec: Record "Time Period-CS"; RunTrigger: Boolean)
    begin
        Save_Update_TimePeriod(Rec, xRec."Slot No", 1, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50123, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_TimePeriodOnDelete(Rec: Record "Time Period-CS"; RunTrigger: Boolean)
    begin
        Save_Update_TimePeriod(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_TimePeriod(Rec: Record "Time Period-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" +
            '/Save_Update_TimePeriod?SlotNo=%1&StartTime=%2&EndTime=%3&GlobalDimension1Code=%4&GlobalDimension2Code=%5&Updated=%6&OldSlotNo=%7&Delete=%8',
            Rec."Slot No", Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Updated), OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    //Rooms-CS Start
    [EventSubscriber(ObjectType::Table, 50126, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RoomsOnModify(VAR Rec: Record "Rooms-CS"; VAR xRec: Record "Rooms-CS"; RunTrigger: Boolean)

    begin
        RoomsCSFunction(rec, '', 0, 'OnAfterModifyEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50126, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RoomsOnRename(VAR Rec: Record "Rooms-CS"; VAR xRec: Record "Rooms-CS"; RunTrigger: Boolean)

    begin
        RoomsCSFunction(rec, xRec."Room No.", 0, 'OnAfterRenameEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50126, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RoomsOnDelete(VAR Rec: Record "Rooms-CS"; RunTrigger: Boolean)

    begin
        RoomsCSFunction(rec, '', 1, 'OnAfterDeleteEvent')
    end;

    [EventSubscriber(ObjectType::Table, 50126, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Academics_RoomsOnInsert(VAR Rec: Record "Rooms-CS"; RunTrigger: Boolean)

    begin
        RoomsCSFunction(rec, '', 0, 'OnAfterInsertEvent')
    end;

    procedure RoomsCSFunction(var Rec: Record "Rooms-CS"; xRecRoomNo: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Academics_Rooms?RoomNo=%1&RoomType=%2&FloorNo=%3&BuildingName=%4&ClassCapacity=%5&GlobalDimension1Code=%6&GlobalDimension2Code=%7&AllotForExamination=%8&ExamCapacity=%9&BuildingNumber=%10&AcademicYear=%11&Course=%12&AcademicBlock=%13&Year=%14&DisplayRoomNo=%15&ExaminationDepartmentCode=%16&RoomDescription=%17&ExamDate=%18&ExamSlot=%19&OldRoomNo=%20&Delete=%21', Rec."Room No.", HandlingOption(Rec."Room Type"), Rec."Floor No.", Rec."Building Name", Rec."Class Capacity", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec."Allot For Examination"), Rec."Exam Capacity", Rec."Building Number", Rec."Academic Year", Rec.Course, Rec."Academic Block", Rec.Year, Rec."Display Room No.", Rec."Examination Department Code", Rec."Room Description", FORMAT(Rec."Exam Date", 0, 9), Rec."Exam Slot", xRecRoomNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        End;
    end;
    //Rooms-CS Stop

    /// BatchCS
    [EventSubscriber(ObjectType::Table, 50186, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Batch_CSInsert(VAR Rec: Record "Batch-CS"; RunTrigger: Boolean)
    begin
        BatchCS(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50186, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Batch_CSOnModify(VAR Rec: Record "Batch-CS"; VAR xRec: Record "Batch-CS"; RunTrigger: Boolean)
    begin
        BatchCS(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50186, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Batch_CSOnRename(VAR Rec: Record "Batch-CS"; VAR xRec: Record "Batch-CS"; RunTrigger: Boolean)
    begin
        BatchCS(Rec, Format(xRec.Code), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50186, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Batch_CSOnDelete(VAR Rec: Record "Batch-CS"; RunTrigger: Boolean)
    begin
        BatchCS(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure BatchCS(var Rec: Record "Batch-CS"; xRecOldNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Batch?Code=%1&Description=%2&SequanceNo_=%3&ApplicableBatch=%4&GlobalDimension1Code=%5&GlobalDimension2Code=%6&Selection=%7&OldNo=%8&Delete=%9',
             Rec."Code",
             Rec.Description,
              Rec."Sequance No.",
              HandlingBoolean(Rec."Applicable Batch"),
              Rec."Global Dimension 1 Code",
               Rec."Global Dimension 2 Code",
                HandlingBoolean(Rec.Selection),
                xRecOldNo,
                 DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50129, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_ClassTimeTableLineCSOnInsert(VAR Rec: Record "Class Time Table Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ClassTimeTableLineCS(Rec, '', 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50129, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_ClassTimeTableLineCSOnModify(VAR Rec: Record "Class Time Table Line-CS"; VAR xRec: Record "Class Time Table Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ClassTimeTableLineCS(Rec, '', 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50129, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_ClassTimeTableLineCSRename(VAR Rec: Record "Class Time Table Line-CS"; VAR xRec: Record "Class Time Table Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ClassTimeTableLineCS(Rec, '', (xRec."Line No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50129, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_ClassTimeTableLineCSOnDelete(VAR Rec: Record "Class Time Table Line-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ClassTimeTableLineCS(Rec, '', 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure Save_Update_ClassTimeTableLineCS(var Rec: Record "Class Time Table Line-CS"; xRecOldNo: Code[20]; xRecOldLineNo: integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            // RecCompanyInformation.TestField("Portal Api URL");
            // URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ClassTimeTableLineCS?DocumentNO_=%1&LineNo_=%2&SubjectGroup=%3&SubjectClass=%4&SubjectCode=%5&SubjectName=%6&RoomNo=%7&Batch=%8&Faculty1Code=%9&Faculty1Name=%10&Faculty1StartDate=%11&Faculty1EndDate=%12&Faculty2Code=%13&Faculty2Name=%14&Faculty2StartDate=%15&Faculty2EndDate=%16&Faculty3Code=%17&Faculty3Name=%18&Faculty3StartDate=%19&Faculty3EndDate=%20&Faculty4Code=%21&Faculty4Name=%22&Faculty4StartDate=%23&Faculty4EndDate=%24&GlobalDimension1Code=%25&GlobalDimension2Code=%26&Updated=%27&TimeSlot=%28&Day=%29&CreatedBy=%30&CreatedOn=%31&ModifiedBy=%32&ModifiedOn=%33&Interval=%34&IntervalType=%35&ExtraClass=%36&OpenElective=%37&Section=%38&SubjectType=%39&DifferentFaculty=%40&DifferentRoom=%41&Elective=%42&Program_OpenElectiveTemp=%43&OverRideValidation=%44&No_ofHours=%45&TimeTableStatus=%46&GoalCode=%47&SubjectTopics=%48&TopicsSelected=%49&Level1SubjectCode=%50&ParentLineNo_=%51&No_ofOccurence=%52&SubjectCategory=%53&TopicCode=%54&TopicDescription=%55&StartDate=%56&FinalTimeTableNo_=%57&Inserted=%58&Term=%59&OldDocumentNo=%60&OldLineNo=%61&Delete=%62',
            // Rec."Document No.", Rec."Line No.", Rec."Subject Group", Rec."Subject Class", Rec."Subject Code", Rec."Subject Name", Rec."Room No", Rec.Batch, Rec."Faculty 1 Code", Rec."Faculty 1 Name", Format(Rec."Faculty 1 Start Date", 0, 9), Format(Rec."Faculty 1 End Date", 0, 9), Rec."Faculty 2 Code", Rec."Faculty 2 Name", Format(Rec."Faculty 2 Start Date", 0, 9), Format(Rec."Faculty 2 End Date", 0, 9), Rec."Faculty 3 Code", Rec."Faculty 3 Name", Format(Rec."Faculty 3 Start Date", 0, 9), Format(Rec."Faculty 3 End Date", 0, 9), Rec."Faculty 4 Code", Rec."Faculty 4 Name", Format(Rec."Faculty 4 Start Date", 0, 9), Format(Rec."Faculty 4 End Date", 0, 9), Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingBoolean(Rec.Updated), Rec."Time Slot", HandlingOption(Rec.Day), Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Modified By", Format(Rec."Modified On", 0, 9), HandlingBoolean(Rec.Interval), Rec."Interval Type", HandlingBoolean(Rec."Extra Class"), HandlingBoolean(Rec."Open Elective"), Rec.Section, Rec."Subject Type", HandlingBoolean(Rec."Different Faculty"), HandlingBoolean(Rec."Different Room"), HandlingBoolean(Rec.Elective), HandlingOption(Rec."Program/Open Elective Temp"), HandlingBoolean(Rec."OverRide Validation"), Rec."No. of Hours", HandlingOption(Rec."Time Table Status"), Rec."Goal Code", HandlingOption(Rec."Subject Topics"), HandlingBoolean(Rec."Topics Selected"), Rec."Level 1 Subject Code", Rec."Parent Line No.", Rec."No. of Occurence", Rec."Subject Category", Rec."Topic Code", Rec."Topic Description", Format(Rec."Start Date", 0, 9), Rec."Final Time Table No.", HandlingBoolean(Rec.Inserted), HandlingOption(Rec.Term), xRecOldNo, xRecOldLineNo, DeleteAllowed);
            // If HttpClnt.Get(URL, HttpResponse) then
            //     HttpResponse.Content().ReadAs(ResponseText);

            // SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50130, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_FinalClassTimeTableCSOnInsert(VAR Rec: Record "Final Class Time Table-CS"; RunTrigger: Boolean)
    begin
        FinalClassTimeTable(Rec, 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50130, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_FinalClassTimeTableCSOnModify(VAR Rec: Record "Final Class Time Table-CS"; VAR xRec: Record "Final Class Time Table-CS"; RunTrigger: Boolean)
    begin
        FinalClassTimeTable(Rec, 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50130, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_FinalClassTimeTableCSRename(VAR Rec: Record "Final Class Time Table-CS"; VAR xRec: Record "Final Class Time Table-CS"; RunTrigger: Boolean)
    begin
        FinalClassTimeTable(Rec, (xRec."S.No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50130, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_FinalClassTimeTableCSOnDelete(VAR Rec: Record "Final Class Time Table-CS"; RunTrigger: Boolean)
    begin
        FinalClassTimeTable(Rec, 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure FinalClassTimeTable(var Rec: Record "Final Class Time Table-CS"; xRecOldNo: Integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_FinalClassTimeTableCS?S_No_=%1&Date=%2&TimeSlotCode=%3&StartTime=%4&EndTime=%5&RoomNo=%6&Batch=%7&Section=%8&SubjectClass=%9&SubjectCode=%10&SubjectName=%11&Coursecode=%12&CourseName=%13&Semester=%14&AcademicCode=%15&GlobalDimension1Code=%16&GlobalDimension2Code=%17&AttendanceDate=%18&AtttendanceBy=%19&Attendance=%20&AbsentReasconCode=%21&Faculty1Code=%22&Cancelled=%23&TimeTableDocumentNo_=%24&Group=%25&Year=%26&Updated=%27&Interval=%28&IntervalType=%29&ExtraClass=%30&OpenElective=%31&Faculty2Code=%32&Faculty3Code=%33&Faculty4Code=%34&No_ofHours=%35&MobileInsert=%36&MobileUpdate=%37&TopicCode=%38&TopicDescription=%39&TimeTableLineNo_=%40&S_No_Grouping=%41&CreatedBy=%42&CreatedOn=%43&Inserted=%44&UpdatedBy=%45&UpdatedOn=%46&SubjectGroup=%47&Term=%48&OldS_No=%49&Delete=%50', Rec."S.No.", Format(Rec.Date, 0, 9), Rec."Time Slot Code", Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), Rec."Room No", Rec.Batch, Rec.Section, Rec."Subject Class", Rec."Subject Code", Rec."Subject Name", Rec."Course Code", Rec."Course NAme", Rec.Semester, Rec."Academic Code", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Format(Rec."Attendance Date", 0, 9), Rec."Atttendance By", HandlingOption(Rec.Attendance), Rec."Absent Reascon Code", Rec."Faculty 1Code", HandlingBoolean(Rec.Cancelled), Rec."Time Table  Document No.", HandlingOption(Rec.group), Rec.Year, HandlingBoolean(Rec.Updated), HandlingBoolean(Rec.Interval), Rec."Interval Type", HandlingBoolean(Rec."Extra Class"), HandlingBoolean(Rec."Open Elective"), Rec."Faculty 2 Code", Rec."Faculty 3 Code", Rec."Faculty 4 Code", Rec."No. of Hours", HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), Rec."Topic Code", Rec."Topic Description", Rec."Time Table Line No.", Rec."S.No. Grouping", Rec."Created By", Format(Rec."Created On", 0, 9), HandlingBoolean(Rec.Inserted), Rec."Updated By", Format(Rec."Updated On", 0, 9), Rec."Subject Group", HandlingOption(Rec.Term), xRecOldNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    /// Class Attendance Header-CS

    [EventSubscriber(ObjectType::Table, 50097, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Header_CSInsert(VAR Rec: Record "Class Attendance Header-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceHeaderCS(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50097, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Header_CSOnModify(VAR Rec: Record "Class Attendance Header-CS"; VAR xRec: Record "Class Attendance Header-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceHeaderCS(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50097, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Header_CSOnRename(VAR Rec: Record "Class Attendance Header-CS"; VAR xRec: Record "Class Attendance Header-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceHeaderCS(Rec, Format(xRec."No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50097, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Header_CSOnDelete(VAR Rec: Record "Class Attendance Header-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceHeaderCS(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure ClassAttendanceHeaderCS(var Rec: Record "Class Attendance Header-CS"; xRecOldNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ClassAttendanceHeaderCS?No_=%1&CourseCode=%2&Semester=%&Date=%4&Hour=%5&AttendanceBy=%6&PresentAll=%7&AcademicYear=%8&SubjectType=%9&No_Series=%10&SubjectCode=%11&Section=%12&ResultGenerated=%13&CBCSBatch=%14&GlobalDimension1Code=%15&GlobalDimension2Code=%16&TopicCovered=%17&AttendanceType=%18&SubjectDescription=%19&SelectUnit=%20&TypeOfCourse=%21&FinalYearsCourse=%22&Session=%23&Type=%24&Graduation=%25&Year=%26&BatchCode=%27&GroupCode=%28&AttendanceGenerated=%29&AttendanceDate=%30&AttendanceByName=%31&Cancelled=%32&AttendanceMarked=%33&RoomNo_=%34&TimeSlot=%35&StartTime=%36&EndTime=%37&TimeTableNo=%38&SubjectClass=%39&CourseName=%40&UserID=%41&PortalID=%42&Updated=%43&TimeTableDoc_No_=%44&TimeTableDate=%45&CreatedBy=%46&CreatedOn=%47&Inserted=%48&UpdatedBy=%49&UpdatedOn=%50&Term=%51&OldNo=%52&Delete=%53', Rec."No.", Rec."Course Code", Rec.Semester, Format(Rec.Date, 0, 9), Rec.Hour, Rec."Attendance By", HandlingBoolean(Rec."Present All"), Rec."Academic Year", Rec."Subject Type", Rec."No.Series", Rec."Subject Code", Rec.Section, HandlingBoolean(Rec."Result Generated"), Rec."CBCS Batch", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Topic Covered", HandlingOption(Rec."Attendance Type"), Rec."Subject Description", Rec."Select Unit", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Session, HandlingOption(Rec.Type), Rec.Graduation, Rec.Year, Rec."Batch Code", Rec."Group Code", HandlingBoolean(Rec."Attendance Generated"), Format(Rec."Attendance Date", 0, 9), Rec."Attendance By Name", HandlingBoolean(Rec.Cancelled), HandlingBoolean(Rec."Attendance Marked"), Rec."Room No.", Rec."Time Slot", Format(Rec."Start Time", 0, 9), Format(Rec."End Time", 0, 9), Rec."Time Table No", Rec."Subject Class", Rec."Course Name", Rec."User ID", Rec."Portal ID", HandlingBoolean(Rec.Updated), Rec."Time Table Doc. No.", Format(Rec."Time Table Date", 0, 9), Rec."Created By", Format(Rec."Created On", 0, 9), HandlingBoolean(Rec.Inserted), Rec."Updated By", Format(Rec."Updated On", 0, 9), HandlingOption(Rec.Term), xRecOldNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50098, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Line_CSInsert(VAR Rec: Record "Class Attendance Line-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceLineCS(Rec, '', 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50098, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Line_CSOnModify(VAR Rec: Record "Class Attendance Line-CS"; VAR xRec: Record "Class Attendance Line-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceLineCS(Rec, '', 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50098, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Line_CSOnRename(VAR Rec: Record "Class Attendance Line-CS"; VAR xRec: Record "Class Attendance Line-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceLineCS(Rec, Format(xRec."Document No."), xRec."Line No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50098, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Class_Attendance_Line_CSOnDelete(VAR Rec: Record "Class Attendance Line-CS"; RunTrigger: Boolean)
    begin
        ClassAttendanceLineCS(Rec, '', 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure ClassAttendanceLineCS(var Rec: Record "Class Attendance Line-CS"; xRecOldNo: Code[20]; OldLineNo: integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ClassAttendanceLineCS?DocumentNo_=%1&LineNo_=%2&CourseCode=%3&Semester=%4&SubjectCode=%5&Date=%6&Hour=%7&StudentNo_=%8&AttendanceType=%9&AcademicYear=%10&StudentName=%11&Description=%12&SubjectType=%13&Section=%14&GlobalDimension1Code=%15&GlobalDimension2Code=%16&TypeOfCourse=%17&FinalYearsCourse=%18&Session=%19&Type=%20&Graduation=%21&Year=%22&BatchCode=%23&GroupCode=%24&AttendanceGenerated=%25&StaffCode=%26&RollNo_=%27&ReasonCode=%28&EnrollmentNo_=%29&Remark=%30&Updated=%31&SubjectClass=%32&AttendanceCondonation=%33&MobileInsert=%34&MobileUpdate=%35&FinalTimeTableNo_=%36&TimeTableDocNo=%37&CreatedBy=%38&CreatedOn=%39&Inserted=%40&UpdatedBy=%41&UpdatedOn=%42&Term=%43&OldDocumentNo=%44&OldLineNo=%45&Delete=%46', Rec."Document No.", Rec."Line No.", Rec."Course Code", Rec.Semester, Rec."Subject Code", Format(Rec.Date, 0, 9), Rec.Hour, Rec."Student No.", HandlingOption(Rec."Attendance Type"), Rec."Academic Year", Rec."Student Name", Rec.Description, Rec."Subject Type", Rec.Section, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", HandlingOption(Rec."Type Of Course"), Rec."Final Years Course", Rec.Session, HandlingOption(Rec.Type), Rec.Graduation, Rec.Year, Rec."Batch Code", Rec."Group Code", HandlingBoolean(Rec."Attendance Generated"), Rec."Staff Code", Rec."Roll No.", Rec."Reason Code", Rec."Enrollment No.", Rec.Remark, HandlingBoolean(Rec.Updated), Rec."Subject Class", HandlingBoolean(Rec."Attendance Condonation"), HandlingBoolean(Rec."Mobile Insert"), HandlingBoolean(Rec."Mobile Update"), Rec."Final Time Table No.", Rec."Time Table Doc No.", Rec."Created By", Format(Rec."Created On", 0, 9), HandlingBoolean(REc.Inserted), Rec."Updated By", Format(Rec."Updated On", 0, 9), HandlingOption(Rec.Term), xRecOldNo, OldLineNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50423, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_StudentWiseGoalOnInsert(VAR Rec: Record "Student Wise Goal"; RunTrigger: Boolean)
    begin
        Save_Update_StudentWiseGoal(Rec, 0, 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50423, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_StudentWiseGoalOnModify(VAR Rec: Record "Student Wise Goal"; VAR xRec: Record "Student Wise Goal"; RunTrigger: Boolean)
    begin
        Save_Update_StudentWiseGoal(Rec, 0, 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50423, 'OnAfterRenameEvent', '', false, false)]
    procedure Save_Update_StudentWiseGoalOnRename(VAR Rec: Record "Student Wise Goal"; VAR xRec: Record "Student Wise Goal"; RunTrigger: Boolean)
    begin
        Save_Update_StudentWiseGoal(Rec, (xRec."Entry No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50423, 'OnAfterDeleteEvent', '', false, false)]
    procedure Save_Update_StudentWiseGoalOnDelete(VAR Rec: Record "Student Wise Goal"; RunTrigger: Boolean)
    begin
        Save_Update_StudentWiseGoal(Rec, 0, 1, 'OnAfterDeleteEvent');
    end;

    procedure Save_Update_StudentWiseGoal(var Rec: Record "Student Wise Goal"; xRecEntryNo: Integer; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentWiseGoal?EntryNo_=%1&StudentNo_=%2&StudentName=%3&EnrollmentNo_=%4&CourseCode=%5&Semester=%6&AcademicYear=%7&Term=%8&GoalCode=%9&GoalDescription=%10&TimeTableDocNo_=%11&TimeTableLineNo_=%12&FinalTimeTableNo_=%13&GroupingNo_=%14&SubjectCode=%15&SubjectDescription=%16&GlobalDimension1Code=%17&CreatedBy=%18&CreatedOn=%19&UpdatedBy=%20&UpdatedOn=%21&Inserted=%22&Updated=%23&AttendanceDate=%24&OldEntryNo=%25&Delete=%26',
            Rec."Entry No.", Rec."Student No.", Rec."Student Name", Rec."Enrollment No.", Rec."Course Code", Rec.Semester, Rec."Academic year", HandlingOption(Rec.Term), Rec."Goal Code", Rec."Goal Description", Rec."Time Table Doc No.", Rec."Time Table Line No.", Rec."Final Time Table No.", Rec."Grouping No.", Rec."Subject Code", Rec."Subject Description", Rec."Global Dimension 1 Code", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), HandlingBoolean(Rec.Inserted), HandlingBoolean(rec.Updated), Format(Rec."Attendance Date", 0, 9), xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    Procedure CreateTimeTableCalendar(FinalTimeTable: Record "Final Class Time Table-CS")
    Var
        RecCompanyInformation: Record "Company Information";
        EmployeeRec: Record Employee;
        ClassAttendanceHdr: Record "Class Attendance Header-CS";
        AttendanceCU: Codeunit "Attendance Action-CS";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
        EmployeeEmail: Text;
        EmployeeName: Text;
        StudentNo: Text;
    Begin
        EmployeeEmail := '';
        EmployeeName := '';
        EmployeeRec.Reset();
        EmployeeRec.Setrange("No.", FinalTimeTable."Faculty 1Code");
        IF EmployeeRec.FindFirst() then begin
            EMployeeEmail := EmployeeRec."Company E-Mail";
            EmployeeName := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
        end;
        StudentNo := '';
        ClassAttendanceHdr.Reset();
        ClassAttendanceHdr.SetRange("Time Table No", FinalTimeTable."S.No.");
        If ClassAttendanceHdr.FindFirst() then
            StudentNo := AttendanceCU.GetStudentNo(ClassAttendanceHdr);

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/CreateTimeTableCalendar?AttendeesEmail_1=%1&AttendeesName_1=%2&AttendeesID_2=%3&Subject=%4&Description=%5&StartTime=%6&EndTime=%7&StartDate=%8&EndtDate=%9&Location=%10&TimeZone=%11&MeetingMode=%12&globaldimension1code=%13&serialNo=%14', EmployeeEmail, EmployeeName, StudentNo, FinalTimeTable."Subject Code", FinalTimeTable."Subject Name", Format(FinalTimeTable."Start Time", 0, 9), Format(FinalTimeTable."End Time", 0, 9), Format(FinalTimeTable.Date, 0, 9), Format(FinalTimeTable.Date, 0, 9), 'MEA', 'Eastern Standard Time', 'ONLINE', FinalTimeTable."Global Dimension 1 Code", FinalTimeTable."S.No.");

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(FinalTimeTable.TableName(), ResponseText, 'CreateTimeTableCalendar');
        end;
    End;

    [EventSubscriber(ObjectType::Table, 50371, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_RecommendationsInsert(VAR Rec: Record Recommendations; RunTrigger: Boolean)
    begin
        Recommendations(Rec, '', '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50371, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_RecommendationsOnModify(VAR Rec: Record Recommendations; VAR xRec: Record Recommendations; RunTrigger: Boolean)
    begin
        Recommendations(Rec, '', '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50371, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_RecommendationsOnRename(VAR Rec: Record Recommendations; VAR xRec: Record Recommendations; RunTrigger: Boolean)
    begin
        Recommendations(Rec, Format(xRec."Global Dimension 1 Code"), Format(xRec.Semester), Format(xRec."Min Percentage"), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50371, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_RecommendationsOnDelete(VAR Rec: Record Recommendations; RunTrigger: Boolean)
    begin
        Recommendations(Rec, '', '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure Recommendations(var Rec: Record Recommendations; xRecGlobalDimension1Code: code[20]; xRecOldNo: Code[20]; xRecOldminpercentage: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Recommendations?GlobalDimension1Code=%1&AcademicYear=%2&Semester=%3&MinPercentage=%4&MaxPercentage=%5&RangePercentage=%6&Recommendation=%7&Communications=%8&AcademicSAP=%9&Repeating=%10&CBSE=%11&Min_Percentage=%12&CBSEMax=%13&CBSEMin=%14&Oldglobaldimension1code=%15&Oldsemester=%16&Oldminpercentage=%17&Delete=%18',
            Rec."Global Dimension 1 Code", Rec."Academic Year", Rec.Semester, Rec."Min Percentage", Rec."Max Percentage", Rec."Range Percentage", Rec.Recommendation, Rec.Communications, Rec."Academic SAP", HandlingBoolean(Rec.Repeating), Rec.CBSE, Rec."Min. Percentage", Rec."CBSE Max", Rec."CBSE Min", xRecGlobalDimension1Code, xRecOldNo, xRecOldminpercentage, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;


    [EventSubscriber(ObjectType::Table, 50372, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Grade_BookInsert(VAR Rec: Record "Grade Book"; RunTrigger: Boolean)
    begin
        GradeBook_(Rec, '', '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50372, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Grade_BookOnModify(VAR Rec: Record "Grade Book"; VAR xRec: Record "Grade Book"; RunTrigger: Boolean)
    begin
        GradeBook_(Rec, '', '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50372, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Grade_BookOnRename(VAR Rec: Record "Grade Book"; VAR xRec: Record "Grade Book"; RunTrigger: Boolean)
    begin
        GradeBook_(Rec, Format(xRec."Entry No."), Format(xRec."Student No."), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50372, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Grade_OnDelete(VAR Rec: Record "Grade Book"; RunTrigger: Boolean)
    begin
        GradeBook_(Rec, '', '', 1, 'OnAfterDeleteEvent');
    end;

    procedure GradeBook_(var Rec: Record "Grade Book"; xRecOldNo: Code[20]; xRecAdvNo: Code[20]; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_GradeBook?EntryNo=%1&StudentNo=%2&FirstName=%3&MiddleName=%4&LastName=%5&StudentName=%6&EnrollmentNo=%7&AcademicYear=%8&AdmittedYear=%9&Semester=%10&ExamCode=%11&ExamDescription=%12&GlobalDimension1Code=%13&TypeofInput=%14&InputSequence=%15&PercentageObtained=%16&Grade=%17&EarnedPoints=%18&AvailablePoints=%19&EarnedPointsPercentage=%20&Range=%21&GradeResult=%22&Recommendation=%23&Indentation=%24&QualityPoint=%25&Credit=%26&CreditEarned=%27&ExamClassification=%28&Term=%29&DocumentNo=%30&CreatedBy=%31&CreatedOn=%32&UpdatedBy=%33&UpdatedOn=%34&GradeBookNo=%35&Status=%36&Level=%37&ExamLineNo=%38&OldEntryNo=%39&OldStudentNo=%40&Delete=%41', Rec."Entry No.", Rec."Student No.", Rec."First Name", Rec."Middle Name", Rec."Last Name", Rec."Student Name", Rec."Enrollment No.", Rec."Academic Year", Rec."Admitted Year", Rec.Semester, Rec."Exam Code", Rec."Exam Description", Rec."Global Dimension 1 Code", Handlingoption(Rec."Type of Input"), Rec."Input Sequence", Rec."Percentage Obtained", Rec.Grade, Rec."Earned Points", Rec."Available Points", Rec."Earned Points Percentage", Rec."% Range", Rec."Grade Result", Rec.Recommendation, Rec.Indentation, Rec."Quality Point", Rec.Credit, Rec."Credit Earned", Rec."Exam Classification", HandlingOption(REc.Term), Rec."Document No.", Rec."Created By", Format(Rec."Created On", 0, 9), Rec."Updated By", Format(Rec."Updated On", 0, 9), REc."Grade Book No.", HandlingOption(Rec.Status), Rec.Level, Rec."Exam Line No.", xRecOldNo, xRecAdvNo, DeleteAllowed);

            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;

    end;

    // 18/04/2022 SynchBookingAppointments
    procedure SynchBookingAppointments()
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        AdvisingRequest: Record "Advising Request";
        ResponseText: Text;
        URL: Text;
    begin

        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/SynchBookingAppointments?');
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);
            SaveApiLogDetails('Advising Request', ResponseText, 'SynchBookingAppointments');
        end;
    end;

    //"Assistant Registrar Mapping"-Start------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, 50135, 'OnAfterInsertEvent', '', false, false)]
    procedure ApiPortalSave_Update_Test1Insert(VAR Rec: Record "Test1-CS"; RunTrigger: Boolean)
    begin
        AssistantRegistrarMappingFunction(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50135, 'OnAfterModifyEvent', '', false, false)]
    procedure ApiPortalSave_Update_Test1Modify(VAR Rec: Record "Test1-CS"; VAR xRec: Record "Test1-CS"; RunTrigger: Boolean)
    begin
        AssistantRegistrarMappingFunction(Rec, '', 0, 'OnAfterModifyEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50135, 'OnAfterRenameEvent', '', false, false)]
    procedure ApiPortalSave_Update_Test1Rename(VAR Rec: Record "Test1-CS"; VAR xRec: Record "Test1-CS"; RunTrigger: Boolean)
    begin
        AssistantRegistrarMappingFunction(Rec, Format(xRec."Entry No"), 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50135, 'OnAfterDeleteEvent', '', false, false)]
    procedure ApiPortalSave_Update_Test1Delete(VAR Rec: Record "Test1-CS"; RunTrigger: Boolean)
    begin
        AssistantRegistrarMappingFunction(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    procedure AssistantRegistrarMappingFunction(var Rec: Record "Test1-CS"; xRecEntryNo: Text; DeleteAllowed: Integer; TriggerName: text[50])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_Test1?Entryno=%1&StartAlphaRange=%2&EndAlphaRange=%3&UserID=%4&UserName=%5&Status=%6&Inserted=%7&Updated=%8&OldEntryno=%9&Delete=%10', Rec."Entry No", Rec."Start Alpha Range", Rec."End Alpha Range", Rec."User ID", Rec."User Name", HandlingOption(Rec.Status), HandlingBoolean(Rec.Inserted), HandlingBoolean(Rec.Updated), xRecEntryNo, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    end;

    //"Assistant Registrar Mapping"-End------------------------------------------------------------------------------------------------

    PRocedure SynchStudenttoBlackboard(Rec: Record "Student Master-CS")//GORV//
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/SynchStudenttoBlackboard?');
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'SynchStudenttoBlackboard');
        End;
    end;

    PRocedure SynchFacultytoBlackboard(Rec: Record Employee)//GAURAV//8.6.22//
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/SynchFacultytoBlackboard?');
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, 'SynchFacultytoBlackboard');
        End;
    end;
    ////GAURAV//13/08//22/////////////////////
    /// 
    Procedure SynchOnlyCoursetoBlackBoard()
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/SynchOnlyCoursetoBlackBoard?');
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails('Course Subject Line - COLLEGE', ResponseText, 'SynchOnlyCoursetoBlackBoard');
        End;
    end;

    //CSPL-00307 Save_Update_DepartmentMaster- Start 
    [EventSubscriber(ObjectType::Table, 50402, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_DepartmentMasterOnInsert(var Rec: Record Department; RunTrigger: Boolean)
    begin
        Save_Update_DepartmentMaster(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50402, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_DepartmentMasterOnModify(var Rec: Record Department; var xRec: Record Department; RunTrigger: Boolean)
    Begin
        Save_Update_DepartmentMaster(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50402, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_DepartmentMasterOnRename(var Rec: Record Department; var xRec: Record Department; RunTrigger: Boolean)
    begin
        Save_Update_DepartmentMaster(Rec, xRec."Department Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50402, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_DepartmentMasterOnDelete(Rec: Record Department; RunTrigger: Boolean)
    begin
        Save_Update_DepartmentMaster(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_DepartmentMaster(Rec: Record Department; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_DepartmentMaster?DepNo=%1&DepName=%2&Status=%3&GlobalDimension1=%4&GlobalDimension2=%5&TypeofWithdrawal=%6&DepartmentEmail=%7&OldDepNo=%8&Delete=%9', Rec."Department Code", Rec."Department Name", 1, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", '', Rec."Department Email", OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    //CSPL-00307 Save_Update_DepartmentMaster. - Ends 


    //CSPL-00307 T1-T1518 Start
    [EventSubscriber(ObjectType::Table, 50016, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_AttandanceAbsenceEntryOnInsert(var Rec: Record "User Group Insititute-CS"; RunTrigger: Boolean)
    begin
        Save_Update_AttandanceAbsenceEntry(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50016, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_AttandanceAbsenceEntryOnModify(var Rec: Record "User Group Insititute-CS"; var xRec: Record "User Group Insititute-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_AttandanceAbsenceEntry(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50016, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_AttandanceAbsenceEntryOnRename(var Rec: Record "User Group Insititute-CS"; var xRec: Record "User Group Insititute-CS"; RunTrigger: Boolean)
    begin
        Save_Update_AttandanceAbsenceEntry(Rec, xRec."User Group", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50016, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_AttandanceAbsenceEntryOnDelete(Rec: Record "User Group Insititute-CS"; RunTrigger: Boolean)
    begin
        Save_Update_AttandanceAbsenceEntry(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_AttandanceAbsenceEntry(Rec: Record "User Group Insititute-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_AttandanceAbsenceEntry?usergroup=%1&companyaccess=%2&globaldimension1code=%3&globaldimension2code=%4&entryno=%5&entrydate=%6&studentid=%7&studentname=%8&semester=%9&term=%10&academicyear=%11&facilitator=%12&comments=%13&activity=%14&otheractivityname=%15&dateofabsence=%16&typeofabsence=%17&totalminutestardy=%18&emailreceiptrequired=%19&createdby=%20&Oldusergroup=%21&OLdcompanyaccess=%22&Delete=%23', Rec."User Group", Rec."Company Access", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."Entry No.", Format(Rec."Entry Date", 0, 9), Rec."Student ID", Rec."Student Name", Rec.Semester, HandlingOption(Rec.Term), Rec."Academic Year", Rec.Facilitator, Rec.Comments, HandlingOption(Rec.Activity), Rec."Other Activity Name", Format(Rec."Date of Absence", 0, 9), HandlingOption(Rec."Type of Absence"), Rec."Total Minutes Tardy", HandlingBoolean(Rec."Email Receipt Required"), Rec."Created By", OldCode, '', DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;
    //CSPL-00307 T1-T1518 End
    //CSPL-00307 - Insurance Waiver- Start 
    [EventSubscriber(ObjectType::Table, 50017, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_StudentRankOnInsert(var Rec: Record "Student Rank-CS"; RunTrigger: Boolean)
    begin
        Save_Update_StudentRank(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50017, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_StudentRankOnModify(var Rec: Record "Student Rank-CS"; var xRec: Record "Student Rank-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_StudentRank(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50017, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_StudentRankOnRename(var Rec: Record "Student Rank-CS"; var xRec: Record "Student Rank-CS"; RunTrigger: Boolean)
    begin
        Save_Update_StudentRank(Rec, xRec."No.", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50017, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_StudentRankOnDelete(Rec: Record "Student Rank-CS"; RunTrigger: Boolean)
    begin
        Save_Update_StudentRank(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_StudentRank(Rec: Record "Student Rank-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_StudentRank?DocumentNo=%1&ApplicationDate=%2&Average=%3&Rank=%4&EntryNo=%5&GlobalDimension1Code=%6&GlobalDimension2Code=%7&UserID=%8&PortalID=%9&Carrier=%10&MemberID=%11&GroupNumber=%12&InsuranceValidFrom=%13&InsuranceValidTo=%14&StudentNo=%15&StudentName=%16&Course=%17&Semester=%18&Section=%19&AcademicYear=%20&Term=%21&EnrolmentNo=%22&Status=%23&CreatedOn=%24&PolicyNo=%25&OldDocumentNo=%26&Delete=%27', Rec."No.", Format(Rec."Application Date", 0, 9), Rec.Average, Rec.Rank, Rec."Entry No.", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", Rec.Carrier, Rec."Member ID", Rec."Group Number", Format(Rec."Insurance Valid From", 0, 9), Format(Rec."Insurance Valid To", 0, 9), Rec."Student No.", Rec."Student Name", Rec.Course, Rec.Semester, Rec.Section, Rec."Academic Year", HandlingOption(Rec.Term), Rec."Enrolment No.", HandlingOption(Rec.Status), Format(Rec."Created On", 0, 9), Rec."Policy No.", OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    //CSPL-00307 - Insurance Waiver-. - Ends

    procedure EmailNotificationForTranscriptDegree(DocumentType: text[50]; SenderName: text[50]; SenderId: text[50];
    ReceiverName: text[150]; ReceiverId: text[50]; Subject: text[200]; Documenttext: text; Process: text[100];
    DocumentEvent: text[100]; ProcessNo: text[30]; EDate: text[30]; ReceiverEmailId: text[200];
    sendEmail: Integer; mobileNo: text[30]; SmsText: text[30]; SendSms: Integer; FileName: Text[2048]; MailingAdd: Text[250])
    Var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        // If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
        RecCompanyInformation.TestField("Portal Api URL");
        URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/sendNotification?Type=%1&SenderName=%2&SenderId=%3&ReceiverName=%4&ReceiverId=%5&Subject=%6&text=%7&Process=%8&Event=%9&ProcessNo=%10&EDate=%11&ReceiverEmailId=%12&sendEmail=%13&mobileNo=%14&SmsText=%15&SendSms=%16',
        DocumentType, SenderName, SenderId, ReceiverName, ReceiverId, Subject, Documenttext, Process, DocumentEvent, ProcessNo, EDate, ReceiverEmailId, sendEmail, mobileNo, SmsText, SendSms);
        If HttpClnt.Get(URL, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);
        //end;

        IF DocumentType <> 'CLINICAL' then
            EmailNotification(DocumentType, SenderName, SenderId, ReceiverName
            , ReceiverId, Subject, Documenttext, Process, DocumentEvent, ProcessNo, EDate, ReceiverEmailId, sendEmail,
            1, format(CurrentDateTime()), 1, mobileNo, SmsText, SendSms, 0, Format(CurrentDateTime), UserId(), FileName, MailingAdd);
    end;

    [EventSubscriber(ObjectType::Table, 50103, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_SlabTransportCSOnInsert(var Rec: Record "Slab Transport-CS"; RunTrigger: Boolean)
    begin
        Save_Update_SlabTransportCS(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50103, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_SlabTransportCSOnModify(var Rec: Record "Slab Transport-CS"; var xRec: Record "Slab Transport-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_SlabTransportCS(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50103, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_SlabTransportCSOnRename(var Rec: Record "Slab Transport-CS"; var xRec: Record "Slab Transport-CS"; RunTrigger: Boolean)
    begin
        Save_Update_SlabTransportCS(Rec, xRec."Slab Code", 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50103, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_SlabTransportCSOnDelete(Rec: Record "Slab Transport-CS"; RunTrigger: Boolean)
    begin
        Save_Update_SlabTransportCS(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_SlabTransportCS(Rec: Record "Slab Transport-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_SlabTransportCS?SlabCode=%1&SlabName=%2&SlabStartDistanceinKM=%3&SlabEndDistanceinKM=%4&Amount=%5&UserID=%6&PortalID=%7&StudentLastNameMini=%8&StudentLastNameMax=%9&Email=%10&Type=%11&OldSlabCode=%12&Delete=%13', Rec."Slab Code", Rec."Slab Name", Rec."Slab Start Distance in KM", Rec."Slab End Distance in KM", Rec.Amount, Rec."User ID", Rec."Portal ID", Rec.StudentLastNameMini, Rec.StudentLastNameMax, Rec.Email, HandlingOption(Rec.Type), OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;

    [EventSubscriber(ObjectType::Table, 50024, 'OnAfterInsertEvent', '', false, false)]
    procedure Save_Update_ExamRunningTotalOnInsert(var Rec: Record "Enquiry Type-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ExamRunningTotal(Rec, '', 0, 'OnAfterInsertEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50024, 'OnAfterModifyEvent', '', false, false)]
    procedure Save_Update_ExamRunningTotalOnModify(var Rec: Record "Enquiry Type-CS"; var xRec: Record "Enquiry Type-CS"; RunTrigger: Boolean)
    Begin
        Save_Update_ExamRunningTotal(Rec, '', 0, 'OnAfterModifyEvent');
    End;

    [EventSubscriber(ObjectType::Table, 50024, 'OnAfterRenameEvent', '', False, false)]
    Procedure Save_Update_ExamRunningTotalOnRename(var Rec: Record "Enquiry Type-CS"; var xRec: Record "Enquiry Type-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ExamRunningTotal(Rec, xRec.Code, 0, 'OnAfterRenameEvent');
    end;

    [EventSubscriber(ObjectType::Table, 50024, 'OnAfterDeleteEvent', '', False, false)]
    procedure Save_Update_ExamRunningTotalOnDelete(Rec: Record "Enquiry Type-CS"; RunTrigger: Boolean)
    begin
        Save_Update_ExamRunningTotal(Rec, '', 1, 'OnAfterDeleteEvent');
    end;

    Procedure Save_Update_ExamRunningTotal(Rec: Record "Enquiry Type-CS"; OldCode: Code[20]; DeleteAllowed: Integer; TriggerName: Text[50])
    var
        RecCompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        URL: Text;
    Begin
        RecCompanyInformation.Reset();
        RecCompanyInformation.get();
        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
            RecCompanyInformation.TestField("Portal Api URL");
            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/Save_Update_ExamRunningTotal?code=%1&description=%2&globaldimension1code=%3&globaldimension2code=%4&userid=%5&portalid=%6&coursecode=%7&semestercode=%8&subjectcode=%9&datamappingfield=%10&Oldcode=%11&Delete=%12', Rec.Code, Rec.Description, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", Rec."User ID", Rec."Portal ID", REc."Course Code", Rec."Semester Code", Rec."Subject Code", Rec."Data Mapping Field", OldCode, DeleteAllowed);
            If HttpClnt.Get(URL, HttpResponse) then
                HttpResponse.Content().ReadAs(ResponseText);

            SaveApiLogDetails(Rec.TableName(), ResponseText, TriggerName);
        end;
    End;
}


