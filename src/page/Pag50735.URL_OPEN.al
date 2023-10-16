page 50735 Open_URL
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    Caption = 'Open_URL';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(schooldocs_username; UserName)
                {
                    ApplicationArea = All;
                    Caption = 'User Name';
                }
                field(schooldocs_student_id; StudentID)
                {
                    ApplicationArea = All;
                    Caption = 'Student ID';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Uploaded Documents")
            {
                ApplicationArea = All;
                Caption = 'Show Uploaded Documents';
                PromotedIsBig = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Open_SchoolDocs(StudentID, UserName);
                end;
            }
        }
    }

    var
        PostUrl: Text;
        UserName: Text;
        StudentID: Text;

    trigger OnOpenPage()
    begin
        UserName := 'CSPL\SchoolDocsAdmin';
        StudentID := '111111';
    end;

    procedure Open_SchoolDocs(StudentNo: Code[20]; User_ID: Code[50])
    var
        CompanyInformation: Record "Company Information";
        HttpClnt: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        EncryptedUserName: Text;
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        if StrPos(User_ID, '\') > 0 then
            User_ID := CopyStr(User_ID, StrPos(User_ID, '\') + 1, 50);

        PostUrl := CompanyInformation."Portal Api URL" + '/EncryptValue?inputValue=' + User_ID;

        If HttpClnt.Get(PostUrl, HttpResponse) then
            HttpResponse.Content().ReadAs(ResponseText);

        EncryptedUserName := CopyStr(ResponseText, 77, 24);

        PostUrl := 'http://meaportaluatapi.corporateserve.com/schooldocsdocuments.aspx?U=' + EncryptedUserName + '&S=' + StudentNo;
        Hyperlink(PostUrl);
    end;
}