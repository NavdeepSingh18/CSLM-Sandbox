codeunit 50041 SLcMToSalesforce
{
    trigger OnRun()
    begin

    end;

    Procedure SFInsert(ReqURL: Text[2048]; ReqMethod: Text[20]; ReqBody: Text[2048]; var lSuccessStatusCode: Boolean; var ReasonPhrs: Text[2048]; var Responsetext: Text[2048])
    var
        CompInfo: Record "Company InFormation";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;

        SFAccessTokenAPIResult: Text;
        StatusCode: Integer;
    begin
        CompInfo.Get();
        if CompInfo."Salesforce Sync Enabled" then begin
            //if CompInfo."Salesforce Access Token" = '' then

            SFIntegr.GetSalesforceToken(SFAccessTokenAPIResult);
            CompInfo.TestField("Salesforce Access Token");
            CompInfo.TestField("Salesforce API Base URL");
            ReqURL := CompInfo."Salesforce API Base URL" + ReqURL;

            if CompInfo."Salesforce Access Token" = '' then
                Error('Salesforce Access Token has not been generated');

            http_request.Method(ReqMethod);

            http_request.SetRequestUri(ReqURL);
            http_content.GetHeaders(http_Headers);

            http_content.WriteFrom(ReqBody);

            http_Headers.Remove('Content-Type');
            http_Headers.Add('Content-Type', 'application/json');
            http_request.Content := http_content;

            StatusCode := SendAndResponseGet(http_request, http_Response, Responsetext, SFAccessTokenAPIResult, lSuccessStatusCode, ReasonPhrs);
            // http_Client.DefaultRequestHeaders().Add('Authorization', StrSubstNo('Bearer %1', CompInfo."Salesforce Access Token"));
            //http_client.Send(http_request, http_response);
            // http_response.Content().ReadAs(responseText);

            // //message('%1; %2; %3', http_Response.HttpStatusCode(), http_Response.ReasonPhrase(), Responsetext);

            // lSuccessStatusCode := http_Response.IsSuccessStatusCode();
            // ReasonPhrs := StrSubstNo('%1 ', Format(http_Response.HttpStatusCode()) + ': ' + http_Response.ReasonPhrase());
            // if (http_Response.HttpStatusCode() = 201) or (http_Response.HttpStatusCode() = 200) then

            // IF (StatusCode = 200) or (StatusCode = 201) then
            //     Message('Successfully Completed the request')
            // else
            //     Message('Could not complete the request')

        end;

    end;

    procedure HandlingBooleanAsTruFalse(Var BooleanName: Boolean): Text[5]
    begin
        IF BooleanName = TRUE then
            Exit('true')
        else
            Exit('false');
    end;

    procedure StudentStatusSFInsert(var Rec: Record "Student Master-CS")
    var
        StudentStatus: Record "Student Status";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin

        if Rec."Entry From Salesforce" then begin

            Rec.TestField("No.");
            Rec.TestField("Enrollment No.");
            Rec.TestField(Status);
            if Rec."Global Dimension 1 Code" <> '' then begin
                StudentStatus.Reset();
                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");

                ReqMethod := 'PATCH';
                ReqURL := StrSubstNo('/services/data/v49.0/sobjects/Opportunity/Id/%1', Rec."18 Digit ID");
                // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Opportunity/Enrollment_ID__c/%1', Rec."Enrollment No.");
                ReqBody := '{' +
                        '"Enrollment_Status__c": "' + WebSrvFnCS.EscapeValue(Format(StudentStatus.Status)) + '"' +
                        '}';

                lSuccessStatusCode := false;

                SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);
                IF not lSuccessStatusCode then begin
                    Clear(Recref);
                    RecRef.GetTable(Rec);
                    SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
                end;
            end;
        end;
    end;


    //SD-SN-18-Dec-2020 +
    procedure StudentMasterSFModify(Rec: Record "Student Master-CS"): Text[2048]
    var
        StudentStatus: Record "Student Status";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin
        if Rec."Entry From Salesforce" then begin
            Rec.TestField("No.");
            Rec.TestField("Enrollment No.");
            Rec.TestField("E-Mail Address");
            // Rec.TestField("Housing/Waiver Application No.");
            Rec.TestField(Status);
            Rec.TestField("Global Dimension 1 Code");
            StudentStatus.Reset();
            StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");

            ReqMethod := 'POST';
            ReqURL := StrSubstNo('/services/apexrest/UpdateStudentInfo?=%1', Rec."18 Digit ID");
            // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/apexrest/UpdateStudentInfo?=%1', Rec."18 Digit ID");
            ReqBody := '{' +
                    '"salesforceId": "' + WebSrvFnCS.EscapeValue(Format(Rec."18 Digit ID")) + '",' +
                    '"studentNo": "' + WebSrvFnCS.EscapeValue(Format(Rec."No.")) + '",' +
                    '"housingwaiverapplicationNo": "' + WebSrvFnCS.EscapeValue(Format(Rec."Housing/Waiver Application No.")) + '",' +
                    '"enrolmentNo": "' + WebSrvFnCS.EscapeValue(Format(Rec."Enrollment No.")) + '",' +
                    '"fafsaID": "' + WebSrvFnCS.EscapeValue(Format(Rec."FSA ID")) + '",' +
                    '"email": "' + WebSrvFnCS.EscapeValue(Format(Rec."E-Mail Address")) + '",' +
            '"fafsaType": "' + WebSrvFnCS.EscapeValue(Format(Rec."FAFSA Type")) + '",' +
                    '"statUs": "' + WebSrvFnCS.EscapeValue(Format(StudentStatus.Status)) + '"' +
                    '}';

            lSuccessStatusCode := false;
            SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);
            If not lSuccessStatusCode then begin
                Clear(Recref);
                RecRef.GetTable(Rec);
                SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
            end;
            Exit(ResData);
        end;
    end;




    procedure HousingAllomentInformationSFInsert(OptOut: Record "Opt Out"; HousingApp: Record "Housing Application"; AppType: Option Housing,Waiver)
    var
        StudentMaster_lRec: Record "Student Master-CS";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
        EnrolmmentNo: Text[18];
        HousingAssDate: Date;
    begin

        EnrolmmentNo := '';
        if AppType = AppType::Housing then begin
            //if HousingApp."Entry From Salesforce" then begin
            HousingApp.TestField("Student No.");
            HousingApp.TestField("Enrolment No.");
            HousingApp.TestField("Application No.");
            HousingApp.TestField("Application Date");

            // HousingApp.TestField("Start Date");
            // HousingApp.TestField("End Date");
            if HousingApp.Status = HousingApp.Status::Approved then begin
                HousingApp.TestField("Housing Group");
                HousingApp.TestField("Housing ID");
                HousingApp.TestField("Room Category Code");
                HousingApp.TestField("Approved On");
                HousingAssDate := HousingApp."Approved On";
            end
            else
                if HousingApp.Status = HousingApp.Status::Rejected then begin
                    HousingApp.TestField("Rejected On");
                    HousingAssDate := HousingApp."Rejected On";
                end;
            StudentMaster_lRec.Reset();
            IF StudentMaster_lRec.Get(HousingApp."Student No.") then;
            EnrolmmentNo := StudentMaster_lRec."18 Digit ID";
            ReqBody := '{' +
                '"Housing_Application_number__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Application No.")) + '",' +
                '"Housing_Application_Date__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Application Date", 0, 9)) + '",' +
                '"Housing_Group__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Housing Group")) + '",' +
                '"Housing_Unit_ID__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Housing ID")) + '",' +
                '"Room_Category_Code__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Room Category Code")) + '",' +
                '"Room_Number__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Bed No.")) + '",' +
                '"Apartment_Number__c": "' + WebSrvFnCS.EscapeValue(Format(HousingApp."Room No.")) + '",' +
                '"Housing_Assigned_Date__c": "' + WebSrvFnCS.EscapeValue(Format(HousingAssDate, 0, 9)) + '"' +
                '}';

        end
        else
            if AppType = AppType::Waiver then begin
                // if OptOut."Entry From Salesforce" then begin
                OptOut.TestField("Student No.");
                OptOut.TestField("Enrolment No.");
                OptOut.TestField("Application No.");
                OptOut.TestField("Application Date");
                OptOut.TestField("Approved/Rejected On");
                StudentMaster_lRec.Reset();
                IF StudentMaster_lRec.Get(OptOut."Student No.") then;
                EnrolmmentNo := StudentMaster_lRec."18 Digit ID";
                ReqBody := '{' +
                    '"Housing_Application_number__c": "' + WebSrvFnCS.EscapeValue(Format(OptOut."Application No.")) + '",' +
                    '"Housing_Application_Date__c": "' + WebSrvFnCS.EscapeValue(Format(OptOut."Application Date", 0, 9)) + '",' +
                    '"Housing_Assigned_Date__c": "' + WebSrvFnCS.EscapeValue(Format(OptOut."Approved/Rejected On", 0, 9)) + '"' +
                    '}';
                // end;
            end;
        ReqMethod := 'PATCH';
        ReqURL := StrSubstNo('/services/data/v49.0/sobjects/Opportunity/Id/%1', EnrolmmentNo);
        // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Opportunity/Enrollment_ID__c/%1', EnrolmmentNo);


        lSuccessStatusCode := false;

        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);
        if AppType = AppType::Housing then begin
            // if HousingApp."Entry From Salesforce" then begin
            If not lSuccessStatusCode then begin
                Clear(Recref);
                RecRef.GetTable(HousingApp);
                SFIntegr.InsertSalesforceLog(RecRef.Number(), HousingApp.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
            end;
            // end;
        end
        else
            if AppType = AppType::Waiver then begin
                // if OptOut."Entry From Salesforce" then begin
                If not lSuccessStatusCode then begin
                    Clear(Recref);
                    RecRef.GetTable(OptOut);
                    SFIntegr.InsertSalesforceLog(RecRef.Number(), OptOut.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
                end;
                // end;
            end;
    end;

    procedure OnlineRegistrationInsert(Rec: Record "Student Master-CS")
    var
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin
        if Rec."Entry From Salesforce" then begin
            // Rec.TestField("Student No.");
            Rec.TestField("18 Digit ID");
            Rec.TestField("On Ground Check-In Complete On");
            Rec.TestField("OLR Completed Date");

            ReqMethod := 'POST';

            ReqURL := StrSubstNo('/services/apexrest/UpdateOLRInfo?=');
            // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/apexrest/UpdateOLRInfo?=');
            ReqBody := '[' +
                    '{' +
                    '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(Rec."18 Digit ID")) + '",' +
                    '"onground_checkin_date": "' + WebSrvFnCS.EscapeValue(Format(Rec."On Ground Check-In Complete On", 0, 9)) + '",' +
                    '"olr_complete_date": "' + WebSrvFnCS.EscapeValue(Format(Rec."OLR Completed Date", 0, 9)) + '"' +
                    '}' +
                    ']';

            lSuccessStatusCode := false;

            SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);
            IF not lSuccessStatusCode then begin
                Clear(Recref);
                RecRef.GetTable(Rec);
                SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
            end;
        end;
    end;

    procedure ScholarshipHeaderSFInsert(Rec: Record "Scholarship Header-CS")
    var
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin
        // Rec.TestField("Source Name");
        Rec.TestField("No.");
        // Rec.TestField("Admitted Year");
        // Rec.TestField("Discount Type");
        // Rec.TestField("Global Dimension 1 Code");//institud Code
        // Rec.TestField("Source Code");
        // Rec.TestField("Grant Criteria");
        ReqMethod := 'POST';

        ReqURL := StrSubstNo('/services/data/v49.0/sobjects/Scholarship_Master__c');
        // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Scholarship_Master__c');
        ReqBody := '{' +
                //'"Name": "' + WebSrvFnCS.EscapeValue(Format(Rec."Source Name")) + '",' +
                '"Scholarship_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."No.")) + '"' +
                // '"Admitted_Year__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Admitted Year")) + '",' +
                // '"Discount_Type__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Discount Type")) + '",' +
                // '"Institute_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Global Dimension 1 Code")) + '",' +
                // '"Source_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Source Code")) + '",' +
                // '"Source_Name__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Source Name")) + '",' +
                // '"Grant_Criteria__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Grant Criteria")) + '"' +
                '}';

        lSuccessStatusCode := false;

        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);

        If lSuccessStatusCode then
            Commit()
        ElSE begin
            Clear(Recref);
            RecRef.GetTable(Rec);
            SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterInsertEvent');
        end;
    end;

    procedure ScholarshipHeaderSFModify(Rec: Record "Scholarship Header-CS")
    var
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin
        // Rec.TestField("Source Name");
        Rec.TestField("No.");
        // Rec.TestField("Admitted Year");
        // Rec.TestField("Discount Type");
        // Rec.TestField("Global Dimension 1 Code");//institute Code
        // Rec.TestField("Source Code");
        // Rec.TestField("Grant Criteria");
        ReqMethod := 'PATCH';
        ReqURL := StrSubstNo('/services/data/v49.0/sobjects/Scholarship_Master__c/Scholarship_Code__c/%1', Rec."No.");
        // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Scholarship_Master__c/Scholarship_Code__c/%1', Rec."No.");
        ReqBody := '{' +
                '"Name": "' + WebSrvFnCS.EscapeValue(Format(Rec."Source Name")) + '",' +
                //'"Scholarship_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."No.")) + '",' +
                '"Admitted_Year__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Admitted Year")) + '",' +
                '"Discount_Type__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Discount Type")) + '",' +
                '"Institute_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Global Dimension 1 Code")) + '",' +
                '"Source_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Source Code")) + '",' +
                '"Source_Name__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Source Name")) + '",' +
                '"Grant_Criteria__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Grant Criteria")) + '"' +
                '}';

        lSuccessStatusCode := false;
        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);

        //IF lSuccessStatusCode then begin
        // Rec."Inserted In SalesForce" := true;
        // Rec.Modify();
        If not lSuccessStatusCode then begin
            Clear(Recref);
            RecRef.GetTable(Rec);
            SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
        end;
    end;

    procedure ScholarshipLineSFInsert(Rec: Record "Scholarship Line-CS")
    var
        RecScholarshipHeaderCS: Record "Scholarship Header-CS";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];

    begin
        if RecScholarshipHeaderCS.get(Rec."Scholarship Code") then;
        //RecScholarshipHeaderCS.TestField("Scholarship Name");

        //    Rec.TestField("Scholarship Code");
        Rec.TestField("Line No.");
        // Rec.TestField("Amount To Pay");
        // Rec.TestField(Semester);
        // Rec.TestField("Percentage To Pay");
        // Rec.TestField("Alternative Percentage to Pay");

        ReqMethod := 'POST';
        ReqURL := StrSubstNo('/services/data/v49.0/sobjects/Scholarship_Line__c');
        // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Scholarship_Line__c');
        ReqBody := '{' +
                //'"Name": "' + WebSrvFnCS.EscapeValue(Format(RecScholarshipHeaderCS."Source Name")) + '",' +
                '"Scholarship_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Document No.")) + '",' +
                '"Line_No__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Line No.")) + '",' +
                '"External_ID__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Document No.") + Format(Rec."Line No.")) + '"' +
                // '"Amount_to_Pay__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Amount To Pay")) + '",' +
                // '"Semester__c": "' + WebSrvFnCS.EscapeValue(Format(Rec.Semester)) + '",' +
                // '"Percentage_to_Pay__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Percentage To Pay")) + '",' +
                // '"Alternative_Percentage_to_Pay__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Alternative Percentage to Pay")) + '"' +
                '}';

        lSuccessStatusCode := false;

        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);

        IF lSuccessStatusCode then
            Commit()
        ELSE begin
            Clear(Recref);
            RecRef.GetTable(Rec);
            SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterInsertEvent');
        end;
    End;

    procedure ScholarshipLinesSFModify(Rec: Record "Scholarship Line-CS")
    var

        RecScholarshipHeaderCS: Record "Scholarship Header-CS";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin

        if RecScholarshipHeaderCS.get(Rec."Scholarship Code") then;
        //RecScholarshipHeaderCS.TestField("Scholarship Name");

        // Rec.TestField("Scholarship Code");
        Rec.TestField("Line No.");
        // Rec.TestField("Amount To Pay");
        // Rec.TestField(Semester);
        // Rec.TestField("Percentage To Pay");
        // Rec.TestField("Alternative Percentage to Pay");

        ReqMethod := 'PATCH';
        ReqURL := StrSubstNo('/services/data/v49.0/sobjects/Scholarship_Line__c/External_ID__c/%1', Rec."Document No." + Format(Rec."Line No."));

        // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/data/v49.0/sobjects/Scholarship_Line__c/External_ID__c/%1', Rec."Document No." + Format(Rec."Line No."));
        ReqBody := '{' +
                '"Name": "' + WebSrvFnCS.EscapeValue(Format(RecScholarshipHeaderCS."Source Name")) + '",' +
                // '"Scholarship_Code__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Scholarship Code")) + '",' +
                // '"Line_No__c": "' + WebSrvFnCS.EscapeValue(Format(Rec."Line No.")) + '",' +
                // DelChr(Format(MyDec), '=', ',')
                // DelChr(Format(Rec."Amount To Pay"), '=', ',')
                '"Amount_to_Pay__c": ' + WebSrvFnCS.EscapeValue(Format(DelChr(Format(Rec."Amount To Pay"), '=', ','))) + ',' +
                // '"Amount_to_Pay__c": ' + WebSrvFnCS.EscapeValue(Format(Rec."Amount To Pay")) + ',' +
                '"Semester__c": "' + WebSrvFnCS.EscapeValue(Format(Rec.Semester)) + '",' +
                '"Percentage_to_Pay__c": ' + WebSrvFnCS.EscapeValue(Format(Rec."Percentage To Pay")) + ',' +
                '"Alternative_Percentage_to_Pay__c": ' + WebSrvFnCS.EscapeValue(Format(Rec."Alternative Percentage to Pay")) + '' +
                '}';

        lSuccessStatusCode := false;
        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);

        If not lSuccessStatusCode then begin
            Clear(Recref);
            RecRef.GetTable(Rec);
            SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
        end;
    end;

    var
        SFIntegr: Codeunit "SalesForce Integration";


    procedure SendAndResponseGet(http_request: HttpRequestMessage; http_response: HttpResponseMessage; var responseText: Text[2048]; SFAccessTokenAPIResult: Text; var lSuccessStatusCode: Boolean; var ReasonPhrs: Text[2048]): Integer
    var
        CompInfo: Record "Company Information";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        i: Integer;
    Begin

        for i := 1 to 5 do begin
            Commit();
            CompInfo.GET();
            http_Client.DefaultRequestHeaders().Add('Authorization', StrSubstNo('Bearer %1', CompInfo."Salesforce Access Token"));
            http_client.Send(http_request, http_response);
            http_response.Content().ReadAs(responseText);
            lSuccessStatusCode := http_Response.IsSuccessStatusCode();
            ReasonPhrs := StrSubstNo('%1 ', Format(http_Response.HttpStatusCode()) + ': ' + http_Response.ReasonPhrase());

            IF StrPos(responseText, 'Session expired or invalid') <> 0 then begin
                CompInfo.ModifyAll("Salesforce Access Token", '');
                SFIntegr.GetSalesforceToken(SFAccessTokenAPIResult);
                http_Client.DefaultRequestHeaders.Remove('Authorization');
                IF i = 5 then
                    exit(http_Response.HttpStatusCode());
            end Else
                exit(http_Response.HttpStatusCode());
        end;
    End;

    //Housing Waiver and Application - Start

    procedure HousingWaiverAndApplicationAPI(HousingApplication_lRec: Record "Housing Application"; HousingWaiver_lRec: Record "Opt Out"; AppType: Option Housing,Waiver)
    var
        StudentMaster_lRec: Record "Student Master-CS";
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
        AssignedDate: Date;
    Begin

        ReqMethod := 'POST';
        ReqURL := StrSubstNo('/services/apexrest/createHousing?=');
        IF AppType = AppType::Housing then begin
            AssignedDate := 0D;
            IF HousingApplication_lRec.Status = HousingApplication_lRec.Status::Approved then
                AssignedDate := HousingApplication_lRec."Approved On";
            IF HousingApplication_lRec.Status = HousingApplication_lRec.Status::Rejected then
                AssignedDate := HousingApplication_lRec."Rejected On";
            StudentMaster_lRec.Reset();
            StudentMaster_lRec.Get(HousingApplication_lRec."Student No.");
            If (HousingApplication_lRec."Housing Pref. 1" <> '') and (HousingApplication_lRec."Housing Group Pref.1" <> '') and (HousingApplication_lRec."Room Category Pref.1" <> '') then begin
                ReqBody := '[{' +
                            '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec."18 Digit ID")) + '",' +
                            '"houSing": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec.Housing)) + '",' +
                            '"applicationNo": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Application No.")) + '",' +
                            '"applicationDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Application Date", 0, 9)) + '",' +
                            '"housingassignedDate": "' + WebSrvFnCS.EscapeValue(Format(AssignedDate, 0, 9)) + '",' +
                            '"housingUnit":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing ID")) + '",' +
                            '"housingGroup":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group")) + '",' +
                            '"roomCategory":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Code")) + '",' +
                            '"housingPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 1")) + '",' +
                            '"housinggroupPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.1")) + '",' +
                            '"roomcategoryPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Pref.1")) + '",' +
                            '"housingPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 2")) + '",' +
                            '"housinggroupPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.2")) + '",' +
                            '"roomcategoryPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Pref.2")) + '",' +
                            '"housingPref3": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 3")) + '",' +
                            '"housinggroupPref3": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.3")) + '",' +
                            '"roomcategoryPref3": "' + WebSrvFnCS.EscapeValue(format(HousingApplication_lRec."Room Category Pref.3")) + '",' +
                            '"roommatenamePref": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Mate Name Pref")) + '",' +
                            '"roommateemailPref": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Mate Email Pref")) + '",' +
                            '"presentaddresS1" : "",' +
                            '"preferenceRemarks": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Preference Remarks")) + '",' +
                            '"presentcitY" : "",' +
                            '"presentstatE" : "",' +
                            '"presentcountrY" : ""' +
                            '}]'

            end;
            // '"housingstartDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Start Date", 0, 9)) + '",' +
            //                 '"housingendDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."End Date", 0, 9)) + '",' +
            If (HousingApplication_lRec."Housing Pref. 2" <> '') and (HousingApplication_lRec."Housing Group Pref.2" <> '') and (HousingApplication_lRec."Room Category Pref.2" <> '') then begin
                ReqBody := '[{' +
                            '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec."18 Digit ID")) + '",' +
                            '"houSing": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec.Housing)) + '",' +
                            '"applicationNo": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Application No.")) + '",' +
                            '"applicationDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Application Date", 0, 9)) + '",' +
                            '"housingassignedDate": "' + WebSrvFnCS.EscapeValue(Format(AssignedDate, 0, 9)) + '",' +
                            '"housingUnit":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing ID")) + '",' +
                            '"housingGroup":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group")) + '",' +
                            '"roomCategory":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Code")) + '",' +
                            '"housingPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 1")) + '",' +
                            '"housinggroupPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.1")) + '",' +
                            '"roomcategoryPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Pref.1")) + '",' +
                            '"housingPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 2")) + '",' +
                            '"housinggroupPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.2")) + '",' +
                            '"roomcategoryPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Pref.2")) + '",' +
                            '"housingPref3": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 3")) + '",' +
                            '"housinggroupPref3": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.3")) + '",' +
                            '"roomcategoryPref3": "' + WebSrvFnCS.EscapeValue(format(HousingApplication_lRec."Room Category Pref.3")) + '",' +
                            '"roommatenamePref": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Mate Name Pref")) + '",' +
                            '"roommateemailPref": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Mate Email Pref")) + '",' +
                            '"presentaddresS1" : "",' +
                            '"preferenceRemarks": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Preference Remarks")) + '",' +
                            '"presentcitY" : "",' +
                            '"presentstatE" : "",' +
                            '"presentcountrY" : ""' +
                            '}]'
            end;
            // '"housingstartDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Start Date", 0, 9)) + '",' +
            //                 '"housingendDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."End Date", 0, 9)) + '",' +
            If (HousingApplication_lRec."Housing Pref. 3" <> '') and (HousingApplication_lRec."Housing Group Pref.3" <> '') and (HousingApplication_lRec."Room Category Pref.3" <> '') then begin
                ReqBody := '[{' +
                            '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec."18 Digit ID")) + '",' +
                            '"houSing": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec.Housing)) + '",' +
                            '"applicationNo": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Application No.")) + '",' +
                            '"applicationDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Application Date", 0, 9)) + '",' +
                            '"housingassignedDate": "' + WebSrvFnCS.EscapeValue(Format(AssignedDate, 0, 9)) + '",' +
                            '"housingUnit":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing ID")) + '",' +
                            '"housingGroup":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group")) + '",' +
                            '"roomCategory":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Code")) + '",' +
                            '"housingPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 1")) + '",' +
                            '"housinggroupPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.1")) + '",' +
                            '"roomcategoryPref1": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Pref.1")) + '",' +
                            '"housingPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 2")) + '",' +
                            '"housinggroupPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.2")) + '",' +
                            '"roomcategoryPref2": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Category Pref.2")) + '",' +
                            '"housingPref3": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Pref. 3")) + '",' +
                            '"housinggroupPref3": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Housing Group Pref.3")) + '",' +
                            '"roomcategoryPref3": "' + WebSrvFnCS.EscapeValue(format(HousingApplication_lRec."Room Category Pref.3")) + '",' +
                            '"roommatenamePref": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Mate Name Pref")) + '",' +
                            '"roommateemailPref": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Room Mate Email Pref")) + '",' +
                            '"presentaddresS1" : "",' +
                            '"preferenceRemarks": "' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Preference Remarks")) + '",' +
                            '"presentcitY" : "",' +
                            '"presentstatE" : "",' +
                            '"presentcountrY" : ""' +
                            '}]'
            end;
        end;
        // '"housingstartDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."Start Date", 0, 9)) + '",' +
        //                     '"housingendDate":"' + WebSrvFnCS.EscapeValue(Format(HousingApplication_lRec."End Date", 0, 9)) + '",' +
        IF AppType = AppType::Waiver then begin
            AssignedDate := 0D;
            If HousingWaiver_lRec.Status = HousingWaiver_lRec.Status::Approved then
                AssignedDate := HousingWaiver_lRec."Approved/Rejected On";
            StudentMaster_lRec.Reset();
            StudentMaster_lRec.Get(HousingWaiver_lRec."Student No.");
            StudentMaster_lRec.Housing := StudentMaster_lRec.Housing::"Independent Housing";
            StudentMaster_lRec.Modify();
            ReqBody := '[{' +
                        '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec."18 Digit ID")) + '",' +
                            '"houSing": "' + WebSrvFnCS.EscapeValue(Format(StudentMaster_lRec.Housing)) + '",' +
                            '"applicationNo": "' + WebSrvFnCS.EscapeValue(Format(HousingWaiver_lRec."Application No.")) + '",' +
                            '"applicationDate":"' + WebSrvFnCS.EscapeValue(Format(HousingWaiver_lRec."Application Date", 0, 9)) + '",' +
                            '"housingassignedDate": "' + WebSrvFnCS.EscapeValue(Format(AssignedDate, 0, 9)) + '",' +
                            '"presentaddresS1" : "' + WebSrvFnCS.EscapeValue(Format(HousingWaiver_lRec."Present Address1")) + '",' +
                            '"presentcitY" : "' + WebSrvFnCS.EscapeValue(Format(HousingWaiver_lRec.City)) + '",' +
                            '"presentstatE" : "' + WebSrvFnCS.EscapeValue(Format(HousingWaiver_lRec.County)) + '",' +
                            '"presentcountrY" : "' + WebSrvFnCS.EscapeValue(Format(HousingWaiver_lRec.Country)) + '"' +
                       '}]'
        end;
        lSuccessStatusCode := false;

        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);
        IF not lSuccessStatusCode then begin
            Clear(Recref);
            If AppType = AppType::Housing then begin
                Recref.GetTable(HousingApplication_lRec);
                SFIntegr.InsertSalesforceLog(RecRef.Number(), HousingApplication_lRec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'HousingApplicationData');
            end;
            If AppType = AppType::Waiver then begin
                Recref.GetTable(HousingWaiver_lRec);
                SFIntegr.InsertSalesforceLog(RecRef.Number(), HousingWaiver_lRec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'HousingWaiverData');
            end;
        end;

    end;


    //Housing Waiver and Application - End

    procedure OnlineRegistrationInsertJobQueue(Rec: Record "Student Master-CS")
    var
        WebSrvFnCS: Codeunit "WebServicesFunctionsCSL";
        Recref: RecordRef;
        lSuccessStatusCode: Boolean;
        ReasonPhrs: Text;
        ReqURL: Text[2048];
        ReqMethod: Text[20];
        ReqBody: Text[2048];
        ResData: Text[2048];
    begin

        // Rec.TestField("Student No.");
        // Rec.TestField("18 Digit ID");
        // Rec.TestField("On Ground Check-In Complete On");
        // Rec.TestField("OLR Completed Date");

        ReqMethod := 'POST';

        ReqURL := StrSubstNo('/services/apexrest/UpdateOLRInfo?=');
        // ReqURL := StrSubstNo('https://auamed--slcm.my.salesforce.com/services/apexrest/UpdateOLRInfo?=');
        If Rec."On Ground Check-In Complete On" <> 0D then begin
            ReqBody := '[' +
                    '{' +
                    '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(Rec."18 Digit ID")) + '",' +
                    '"onground_checkin_date": "' + WebSrvFnCS.EscapeValue(Format(Rec."On Ground Check-In Complete On", 0, 9)) + '",' +
                    '"olr_complete_date": "' + WebSrvFnCS.EscapeValue(Format(Rec."OLR Completed Date", 0, 9)) + '"' +
                    '}' +
                    ']';
        end;
        If Rec."On Ground Check-In Complete On" = 0D then begin
            ReqBody := '[' +
                    '{' +
                    '"salesforce_app_id": "' + WebSrvFnCS.EscapeValue(Format(Rec."18 Digit ID")) + '",' +
                    '"olr_complete_date": "' + WebSrvFnCS.EscapeValue(Format(Rec."OLR Completed Date", 0, 9)) + '"' +
                    '}' +
                    ']';
        end;

        lSuccessStatusCode := false;

        SFInsert(ReqURL, ReqMethod, ReqBody, lSuccessStatusCode, ReasonPhrs, ResData);
        IF not lSuccessStatusCode then begin
            Clear(Recref);
            RecRef.GetTable(Rec);
            SFIntegr.InsertSalesforceLog(RecRef.Number(), Rec.TableName(), ReqURL, ReasonPhrs, ResData, ReqURL, ReqBody, '', ReqMethod, 'OnAfterModifyEvent');
        end;

    end;

}