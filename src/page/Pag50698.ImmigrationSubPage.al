page 50698 "Immigration SubPage"
{

    PageType = ListPart;
    InsertAllowed = False;
    DeleteAllowed = false;
    SourceTable = "Student Document Attachment";
    Caption = 'Immigration Document List';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SLcM Document No"; Rec."SLcM Document No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Category"; Rec."Document Category")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Sub Category"; Rec."Document Sub Category")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    trigger OnValidate()
                    var
                        Text001Lbl: Label 'Do you want to change Document Status?';
                    begin
                        if Rec."Document Status" = Rec."Document Status"::" " then
                            Error('You cannot change the Document Status to blank.');

                        if xRec."Document Status" = xRec."Document Status"::Rejected then
                            Error('You cannot change the Document Status as this document is already Rejected.');

                        if xRec."Document Status" = xRec."Document Status"::Verified then
                            Error('You cannot change the Document Status as this document is already Verified.');

                        IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                            IF Rec."Document Status" = Rec."Document Status"::Rejected Then
                                MailSendforImmigrationDocumentRejected(Rec."Student No.", Rec."Document Sub Category")
                        end else
                            Error('');
                    End;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Open Attachment")
            {
                ApplicationArea = All;
                Caption = 'Open Attachment';
                Image = DocInBrowser;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                begin
                    if Rec."Transaction No." = '' then
                        exit;
                End;
            }
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

                    StudentNo: Code[20];

                    PostUrl: Text;

                begin

                    CompanyInfo.Reset();

                    if CompanyInfo.Get() then;



                    if Rec."Transaction No." <> '' then begin

                        CompanyInfo.TestField("SchoolDocs Download Url");

                        PostUrl := CompanyInfo."SchoolDocs Download Url";

                        PostUrl := PostUrl + Rec."Transaction No.";

                        Hyperlink(PostUrl);

                    end

                    else begin

                        StudentMaster.Reset();

                        if StudentMaster.Get(Rec."Student No.") then;



                        if StudentMaster."Creation Date" < 20210301D then begin

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
    procedure MailSendforImmigrationDocumentRejected(StudentNo: Code[20]; SubCategory: Text[250])
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        CompanyInformationRec: Record "Company Information";
        SmtpMail: Codeunit "Email Message";
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
    begin
        SmtpMailRec.Get();
        CompanyInformationRec.Get();
        Studentmaster.GET(StudentNo);
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."SLcM Document No" + ' ' + SubCategory + ' ' + 'Immigration Document Rejected';

        //SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM

        SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('This is to inform you that' + ' ' + SubCategory + ' ' + 'Immigration Document has been Rejected.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Please upload the rejected document again in your student portal for verification within 48 hours after receipt of this email request. ' +
        'Failure will result in your application being place on HOLD until document(s) is/are uploaded.');//CSPL-00307 22-10-21 Changes
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Residential Services Team');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        SmtpMail.AppendtoBody('<br>');
        ////SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
        BodyText := SmtpMail.GetBody();
        IF CompanyInformationRec."Send Email On/Off" then
            //Mail_lCU.Send();//GMCSCOM

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration Document', 'MEA', SenderAddress, Format(Rec."Student Name"),
        Rec."Student No.", Subject, BodyText, 'Immigration Document', 'Immigration Document', Rec."SLcM Document No", '',
        Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;

    var
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

        BodyText: text[2048];
}