codeunit 50036 "SalesForce Integration"
{
    trigger OnRun()
    begin

    end;


    // procedure WebAPISalesForceStudentInsert(
    //     ApplicationNo: Code[20]; FirstName: text[35]; MiddleName: Text[30]; LastName: text[35];
    //     AcademicYear: Code[20]; DOB: Text; CourseCode: Code[20]; MobileNo: Text[30]; Email: text[30]; FeeClassificationCode: Code[20]; Category: code[20];
    //     Gender: Option; Semester: Code[10]; DateofJoining: Text; SalesForceNo: Code[20]; RoomCategory: Code[20];
    //     AdmittedYear: Code[20]; Year: Code[10]; GD1: Code[20]; GD2: Code[20]; FatherName: Text[40]; MotherName: text[40]; Citizenship: code[20];
    //     Nationality: text[30]; PostCode: Code[20]; PassPortNo: text[20]; PassPortExpiryDate: Text
    //     ) Return: Text[250];
    // var
    //     StudentMasterRec: Record "Student Master-CS";
    //     StudentMasterRec2: Record "Student Master-CS";
    //     AcademicSetupRec: Record "Academics Setup-CS";
    //     AdmissionSetupRec: Record "Admission Setup-CS";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     DateOfBirth: Date;

    // begin
    //     AcademicSetupRec.Get();
    //     AcademicSetupRec.TestField(AcademicSetupRec."Student No.");
    //     AdmissionSetupRec.Get();
    //     AdmissionSetupRec.TestField(AdmissionSetupRec."Enrolment No.");
    //     StudentMasterRec2.RESET();
    //     StudentMasterRec2.SETRANGE("SalesForce Reference No.", SalesForceNo);
    //     IF NOT StudentMasterRec2.FINDFIRST() THEN BEGIN
    //         StudentMasterRec.INIT();
    //         StudentMasterRec.Validate("No.", NoSeriesMgt.GetNextNo(AcademicSetupRec."Student No.", 0D, TRUE));
    //         StudentMasterRec."Application No." := ApplicationNo;
    //         StudentMasterRec.validate("First Name", FirstName);
    //         StudentMasterRec.validate("Middle Name", MiddleName);
    //         StudentMasterRec.validate("Last Name", LastName);
    //         StudentMasterRec."Academic Year" := AcademicYear;
    //         if DOB <> '' then begin
    //             Evaluate(DateOfBirth, DOB);
    //             StudentMasterRec.Validate("Date of Birth", DateOfBirth);
    //         end;
    //         StudentMasterRec."Course Code" := CourseCode;
    //         StudentMasterRec.Graduation := 'PG';
    //         StudentMasterRec."Mobile Number" := MobileNo;
    //         StudentMasterRec."E-Mail Address" := Email;
    //         StudentMasterRec."Fee Classification Code" := FeeClassificationCode;
    //         StudentMasterRec.Category := Category;
    //         StudentMasterRec.Gender := Gender;
    //         StudentMasterRec.Semester := Semester;
    //         if DateofJoining <> '' then
    //             evaluate(StudentMasterRec."Date of Joining", DateofJoining);



    //         StudentMasterRec."SalesForce Reference No." := SalesForceNo;
    //         StudentMasterRec."Room Category Code" := RoomCategory;

    //         StudentMasterRec."Admitted Year" := AdmittedYear;
    //         StudentMasterRec.Year := Year;
    //         StudentMasterRec."Global Dimension 1 Code" := GD1;
    //         StudentMasterRec."Global Dimension 2 Code" := GD2;
    //         StudentMasterRec."Fathers Name" := FatherName;
    //         StudentMasterRec."Mothers Name" := MotherName;
    //         StudentMasterRec.Citizenship := Citizenship;
    //         StudentMasterRec.Nationality := Nationality;
    //         StudentMasterRec.Validate("Post Code", PostCode);
    //         StudentMasterRec."Pass Port No." := PassPortNo;
    //         If PassPortExpiryDate <> '' then
    //             Evaluate(StudentMasterRec."Pass Port Expiry Date", PassPortExpiryDate);

    //         StudentMasterRec."Salesforce Inserted" := true;
    //         StudentMasterRec.Validate("Enrollment No.", NoSeriesMgt.GetNextNo(AdmissionSetupRec."Enrolment No.", 0D, TRUE));
    //         StudentMasterRec."Student Status" := StudentMasterRec."Student Status"::Student;
    //         If StudentMasterRec.INSERT(true) then
    //             EXIT('Success:' + ' SalesForce Ref. No.: ' + SalesForceNo + '; SLcM Student No.: ' + StudentMasterRec."No."
    //             + '; Enrolment No.: ' + StudentMasterRec."Enrollment No." + '; Status: ' + format(StudentMasterRec."Student Status"))
    //         Else
    //             EXIT('Failed' + ' ' + SalesForceNo);

    //     END ELSE
    //         Exit('Duplicate' + ' ' + SalesForceNo);
    // END;


    procedure InsertSalesforceLog(TableID: Integer; TableName: Text; WebServiceName: Text[2048]; ErrorDescription: Text[2048]; Data: Text[2048]; Url: Text[2048]; Body1: Text[2048]; Body2: Text[20480]; Method: Text[10]; EventTrigger: Text[50])
    var
        RecSalesforceSyncLog: Record "Salesforce Sync Error Log";
    begin
        RecSalesforceSyncLog.Reset();
        if RecSalesforceSyncLog.FindLast() then
            RecSalesforceSyncLog."Entry No." += 1
        else
            RecSalesforceSyncLog."Entry No." := 1;
        RecSalesforceSyncLog.Init();
        RecSalesforceSyncLog."Entry No." := RecSalesforceSyncLog."Entry No.";
        RecSalesforceSyncLog."Log Date" := CurrentDateTime();
        RecSalesforceSyncLog."Table ID" := TableID;
        RecSalesforceSyncLog."Data Table Name" := TableName;
        RecSalesforceSyncLog."Web Service Name" := WebServiceName;
        RecSalesforceSyncLog."Error Description" := ErrorDescription;
        RecSalesforceSyncLog.Data := Data;
        RecSalesforceSyncLog.URL := Url;
        RecSalesforceSyncLog."Body 1" := Body1;
        RecSalesforceSyncLog."Body 2" := Body2;
        RecSalesforceSyncLog.Method := Method;
        RecSalesforceSyncLog."Event Trigger" := EventTrigger;
        RecSalesforceSyncLog.Counter := 0;
        RecSalesforceSyncLog.Insert();
    end;

    // Calling SALESFORCE APIs Start

    procedure GetSalesforceToken(var APIResult: Text)
    var
        CompInfo: Record "Company Information";
        TokenURLTxt: Text[2048];
        ClientIdTxt: Text[2048];
        ClientSecretTxt: Text[2048];
        TempBlob: Codeunit "Temp Blob";
        TokenURL: Label 'https://auamed--slcm.my.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9gI0ielx8zHK3SQ6DDbQxzFhu4XhCEATdU7aoJCcfQx46lLSR5uNBldiLbQzFbSodlf.Th_mgsY5nREIH&client_secret=C9B9F656D368CDD5557528E65534E074AAC452B8A3569FA2FA587940D4344D83&username=vnagpal@auamed.org.slcm&password=auaslcm%239090';
        ClientId: Label '3MVG9gI0ielx8zHK3SQ6DDbQxzFhu4XhCEATdU7aoJCcfQx46lLSR5uNBldiLbQzFbSodlf.Th_mgsY5nREIH';
        ClientSecret: Label 'C9B9F656D368CDD5557528E65534E074AAC452B8A3569FA2FA587940D4344D83';
        Resource: Label 'https://api.businesscentral.dynamics.com';
        RequestBody: Label 'grant_type=client_credentials&client_id=%1&client_secret=%2&resource=%3';
        HttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeader: HttpHeaders;
        Content: HttpContent;
        Outstr: OutStream;
        Instr: InStream;
    begin
        CompInfo.Reset();
        CompInfo.Get();
        CompInfo.TestField("Salesforce Token URL");
        CompInfo.TestField("Salesforce API Base URL");
        CompInfo.TestField("Salesforce Client Id");
        CompInfo.TestField("Salesforce Client Secret");
        TokenURLTxt := CompInfo."Salesforce Token URL";
        ClientIdTxt := CompInfo."Salesforce Client Id";
        ClientSecretTxt := CompInfo."Salesforce Client Secret";
        Content.GetHeaders(RequestHeader);
        RequestHeader.Clear();

        // HttpClient.SetBaseAddress(TokenURL);
        HttpClient.SetBaseAddress(TokenURLTxt);
        RequestMessage.Method('POST');
        RequestHeader.Remove('Content-Type');
        RequestHeader.Add('Content-Type', 'application/x-www-form-urlencoded');

        Clear(TempBlob);
        TempBlob.CreateOutStream(Outstr);
        // Outstr.WriteText(StrSubstNo(RequestBody, ClientId, ClientSecret, Resource));
        Outstr.WriteText(StrSubstNo(RequestBody, ClientIdTxt, ClientSecretTxt, Resource));
        TempBlob.CreateInStream(Instr);

        Content.WriteFrom(Instr);
        RequestMessage.Content(Content);
        HttpClient.Send(RequestMessage, ResponseMessage);

        if ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(APIResult);
            APIResult := '[' + APIResult + ']';
            GetJsonFile(APIResult);
        end;
    end;

    procedure GetJsonFile(JsonFile: Text): Text;
    var
        CompInfo: Record "Company Information";
        JsonMgt: Codeunit "JSONMgt.CS";
        JsonMgtBase: Codeunit "JSON Management";
        JsonObject2: JsonObject;
        JsonArray2: JsonArray;
        JsonToken2: JsonToken;
        i: Integer;
        SalesforceToken: Text;

    begin
        JsonMgtBase.GetValue(JsonFile);
        i := 0;
        JsonArray2.ReadFrom(Format(JsonFile));
        for i := 0 to JsonArray2.Count() - 1 do begin
            JsonArray2.Get(i, JsonToken2);
            JsonObject2 := JsonToken2.AsObject();
            JsonMgt.SetJsonObject(JsonObject2);
            SalesforceToken := JsonMgt.SelectJsonToken('access_token');
            CompInfo.get();
            CompInfo."Salesforce Access Token" := SalesforceToken;
            CompInfo.Modify();
        end;
    end;

    // procedure SendingToSalesforce(ReqURL: Text[2048]; ReqMethod: Text[20]; ReqBody: Text[2048]; var SuccessStatusCode: Boolean; var ReasonPhrs: Text) Responsetext: Text
    // var
    //     CompInfo: Record "Company Information";
    //     http_Client: HttpClient;
    //     http_Headers: HttpHeaders;
    //     http_content: HttpContent;
    //     http_Response: HttpResponseMessage;
    //     http_request: HttpRequestMessage;
    //     api_url: text;
    //     AuthText: Text;
    //     ContentTypeTxt: Label 'application/json';
    //     SFAccessTokenAPIResult: Text;
    // begin
    //     CompInfo.Get();
    //     if CompInfo."Salesforce Access Token" = '' then

    //     CompInfo.Get();
    //     if CompInfo."Salesforce Access Token" = '' then
    //         Error('Salesforce Access Token has not been generated');


    //     http_request.Method(ReqMethod);
    //     api_url := ReqURL;
    //     AuthText := StrSubstNo('%1', CompInfo."Salesforce Access Token");

    //     http_Client.DefaultRequestHeaders().Add('Authorization', StrSubstNo('Bearer %1', AuthText));
    //     http_request.SetRequestUri(api_url);
    //     http_content.clear();
    //     http_content.GetHeaders(http_Headers);
    //     http_Headers.Remove('Content-Type');
    //     http_Headers.Add('Content-Type', ContentTypeTxt);

    //     http_content.WriteFrom(ReqBody);

    //     http_request.Content := http_content;
    //     http_client.Send(http_request, http_response);
    //     http_response.Content().ReadAs(responseText);
    //     SuccessStatusCode := http_Response.IsSuccessStatusCode();
    //     ReasonPhrs := http_Response.ReasonPhrase();

    //     Message('2  %1', http_Response.ReasonPhrase);
    //     Message('3  %1', Responsetext);

    // end;

    // procedure HousingMasterSyncSalesforce(Rec: Record "Housing Master")
    // var
    //     WebSrvFnCS: Codeunit "WebServicesFunctionsCS";
    //     Recref: RecordRef;
    //     lSuccessStatusCode: Boolean;
    //     ReasonPhrs: Text;
    //     ReqURL: Text[2048];
    //     ReqMethod: Text[20];
    //     ReqBody: Text[2048];
    // begin
    //     Rec.TestField("Housing ID");
    //     Rec.TestField("Housing Name");
    //     Rec.TestField(Address);
    //     Rec.TestField("Post Code");
    //     Rec.TestField(City);
    //     Rec.TestField(Country);
    //     Rec.TestField("Contact Person Name");
    //     Rec.TestField("Contact Number");
    //     Rec.TestField("E-Mail");
    //     ReqMethod := 'POST';

    //     ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Housing_Master__c');
    //     ReqBody :=
    //             '[' +
    //             '{' +
    //             '"Name": "' + WebSrvFnCS.EscapeValue(Format(Rec."Housing Name")) + '",' +
    //             '"Hostel_ID__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Housing ID")) + '",' +
    //             '"Institute_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Global Dimension 1 Code")) + '",' +
    //             '"Off_Campus__c": "' + WebSrvFnCS.EscapeValue(Format(WebSrvFnCS.HandlingBoolean(Rec."Off Campus"))) + '",' +
    //             '"Blocked__c": "' + WebSrvFnCS.EscapeValue(Format(WebSrvFnCS.HandlingBoolean(Rec.Blocked))) + '",' +
    //             '"Owned_By_University__c": "' + WebSrvFnCS.EscapeValue(Format(WebSrvFnCS.HandlingBoolean(Rec."Owned By University"))) + '",' +
    //             '"Address__c": "' + WebSrvFnCS.EscapeValue(Format(Rec.Address)) + '",' +
    //             '"Address_2__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Address 2")) + '",' +
    //             '"Post_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Post Code")) + '",' +
    //             '"City__c": "' + WebSrvFnCS.EscapeValue(Format(Rec.City)) + '",' +
    //             '"Country__c": "' + WebSrvFnCS.EscapeValue(Format(Rec.Country)) + '",' +
    //             '"Contact_Person_Name__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Contact Person Name")) + '",' +
    //             '"Contact_Number__c: "' + WebSrvFnCS.EscapeValue(Format(Rec."Contact Number")) + '",' +
    //             '"E_Mail__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."E-Mail")) + '"' +
    //             '}' +
    //             ']'
    //             ;

    //     lSuccessStatusCode := false;
    //     SendingToSalesforce(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs);

    //     IF lSuccessStatusCode then begin
    //         Rec."Insert Sync" := 0;
    //         Rec."Update Sync" := 0;
    //         Rec."Inserted In SalesForce" := True;
    //         Rec.Modify();
    //     end else begin
    //         IF Rec."Insert Sync" >= 99 then
    //             Error('Please check the Errors Log and correct manually')
    //         else
    //             IF Rec."Insert Sync" >= 5 then begin
    //                 Clear(Recref);
    //                 RecRef.GetTable(Rec);
    //                 InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, '');
    //                 Rec."Insert Sync" := 99;
    //             end
    //             else
    //                 Rec."Insert Sync" := Rec."Insert Sync" + 1;
    //         Rec.Modify();
    //     end;
    // end;
    // Calling SALESFORCE APIs End

}
