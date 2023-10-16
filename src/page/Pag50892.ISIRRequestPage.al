page 50892 "ISIR Request Page"
{
    Caption = 'ISIR Request Page';
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field("File Path"; Path)
            {
                Caption = 'File Path';
                ApplicationArea = All;
            }
            field("Data File Name"; DataFileName)
            {
                Caption = 'Data File Name';
                ApplicationArea = All;
            }
            field("XML File Name"; XMLFileName)
            {
                Caption = 'XML File Name';
                ApplicationArea = All;
                Editable = false;
            }
            field("Table Name"; TableName)
            {
                Caption = 'Table Name';
                ApplicationArea = All;
                Editable = false;
            }

        }
    }

    actions
    {
        area(creation)
        {
            action("Import")
            {
                Image = Import;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ISIRRec: Record "ISIR File";
                    RecCompanyInformation: Record "Company Information";
                    HttpClnt: HttpClient;
                    HttpResponse: HttpResponseMessage;
                    ResponseText: Text;
                    URL: Text;
                    Text001Lbl: Label 'Do you want to Upload the ISIR file?';
                    Text002Lbl: Label 'ISIR file has been Uploaded.';
                    EntryNo: integer;
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        if Path = '' then
                            Error('File Path can not be blank');
                        if DataFileName = '' then
                            Error('File Data File Name can not be blank');
                        if XMLFileName = '' then
                            Error('XML File Name can not be blank');
                        if TableName = '' then
                            Error('Table Name can not be blank');

                        ISIRRec.Reset();
                        if ISIRRec.FindSet() then
                            ISIRRec.DeleteAll();

                        RecCompanyInformation.get();
                        If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
                            RecCompanyInformation.TestField("Portal Api URL");
                            URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/ISIRFileImport?Path=%1&DataFileName=%2&XMLFileName=%3&TableName=%4', Path, DataFileName, XMLFileName, TableName);
                            If HttpClnt.Get(URL, HttpResponse) then
                                HttpResponse.Content().ReadAs(ResponseText);

                            EntryNo := 0;
                            ISIRRec.Reset();
                            IF ISIRRec.FindLast() then
                                EntryNo := ISIRRec."Entry No." + 1;

                            ISIRRec.Reset();
                            ISIRRec.SetRange("Entry No.", EntryNo);
                            ISIRRec.Deleteall();

                            SaveApiLogDetails('ISIR File', ResponseText, 'Upload');
                            Message(Text002Lbl);
                            CurrPage.Close();
                        end;
                    end else
                        exit;

                End;

            }
        }
    }

    var

        Path: Text[250];
        DataFileName: Text[250];
        XMLFileName: Text[250];
        TableName: Text[250];

    trigger OnOpenPage()
    begin
        Path := 'F:\AUASharedFolder\ISIRFiles';
        DataFileName := 'isrf21op.dat';
        XMLFileName := 'ISIR_Import.xml';
        TableName := 'ISIR File';
    end;

    procedure SaveApiLogDetails(TableName: Text; APIResponse: Text; Remarks: Text)
    var
        PortalApiLog: Record "Portal APIs Error Log";
    begin
        IF Not (Strpos(APIResponse, 'ok</string>') > 0) then begin
            PortalApiLog.Init();
            PortalApiLog."Table Name" := TableName;
            PortalApiLog."API Responses" := APIResponse;
            PortalApiLog.Remarks := Remarks;
            PortalApiLog."Modified On" := CurrentDateTime();
            PortalApiLog."Modified By" := UserId();
            PortalApiLog.Insert();
        end;
    end;

}