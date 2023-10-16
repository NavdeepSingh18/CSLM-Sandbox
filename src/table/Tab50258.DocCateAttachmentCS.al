table 50258 "Doc & Cate Attachment-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/07/2019       OnInsert()                                 Code Add for any record change then Assign Value in Updated
    // 02    CSPL-00114   19/07/2019       Code - OnValidate()                        Code Add for Get Category Description

    Caption = 'Doc & Cate Attachment-CS';
    LookupPageID = "Cat Attachment & Doc-CS";

    fields
    {
        field(1; "Code"; Code[250])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            //TableRelation = "Fee Classification Master-CS";

            // trigger OnValidate()
            // begin
            //     //Code Add for Get Category Description::CSPL-00114::19072019: Start
            //     IF CategoryMasterCS.GET(Code) THEN
            //         Description := CategoryMasterCS.Description
            //     ELSE
            //         Description := '';
            //     //Code Add for Get Category Description::CSPL-00114::19072019: End
            // end;
        }
        field(2; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Code[250])
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            TableRelation = "File Attachment-CS".Code;
        }
        field(4; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(8; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
        field(9; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(10; "Department View"; Code[2048])
        {
            Caption = 'Department View';
            DataClassification = CustomerContent;
        }
        field(11; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(12; "Portal Menu ID"; Code[250])
        {
            Caption = 'Portal Menu ID';
            DataClassification = CustomerContent;
        }
        field(13; "Student Upload Required"; Boolean)
        {
            Caption = 'Student Upload Required';
            DataClassification = CustomerContent;
        }
        field(14; "Document No. Required"; Boolean)
        {
            Caption = 'Document No. Required';
            DataClassification = CustomerContent;
        }
        field(30; "Sorting No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Expiry Not Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Validity Days" := 0;
            end;
        }
        field(33; "Validity Days"; Integer)
        {
            DataClassification = CustomerContent;
            MinValue = 0;
            trigger OnValidate()
            begin
                TestField("Expiry Not Applicable", false);
            end;
        }
        field(34; "Responsibility"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Student,University;
        }
        field(35; "Titer Flag Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(36; "Show on Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code", "Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Document Type");
        TestField(Code);
        TestField(Description);
        SchoolDocAPICall();
    end;

    trigger OnModify()
    begin
        //Code Add for any record change then Assign Value in Updated Field::CSPL-00114::19072019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code Add for any record change then Assign Value in Updated Field::CSPL-00114::19072019: End
    end;

    var
    // CategoryMasterCS: Record "Category Master-CS";
    procedure SchoolDocAPICall()
    var
        FileAttachmentCS: Record "File Attachment-CS";
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        responseText: Text;
        TypeName: text;
        TypeCode: Text;
        TypeCategoryNumber: Text;
    begin
        FileAttachmentCS.Reset();
        FileAttachmentCS.SetRange(Code, Rec."Document Type");
        if FileAttachmentCS.FindFirst() then
            FileAttachmentCS.TestField("Type Category No. SchoolDocs");

        TypeName := Rec.Description;
        TypeCode := Rec.Code;
        TypeCategoryNumber := format(FileAttachmentCS."Type Category No. SchoolDocs");
        if (TypeName <> '') and (TypeCode <> '') and (TypeCategoryNumber <> '') then begin
            api_url := StrSubstNo('https://schooldocsconnect.com/connect/4fa76f7578a574e23112bec092625fb4/doctype');
            http_content.clear();
            http_content.WriteFrom(
            '<SchoolDocs>' +
            '<Document>' +
            '<TypeName>' + TypeName + '</TypeName>' +
            '<TypeCode>' + TypeCode + '</TypeCode>' +
            '<TypeCategoryNumber>' + TypeCategoryNumber + '</TypeCategoryNumber>' +
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
            Message('School Docs API Response\' + responseText);
        end;
    end;
}

