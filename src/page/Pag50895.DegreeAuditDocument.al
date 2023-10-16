page 50895 "Degree Audit Documents"
{

    PageType = ListPart;
    InsertAllowed = False;
    DeleteAllowed = false;
    SourceTable = "Student Document Attachment";
    Caption = 'Degree Audit Subpage';
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
                                MailSendforDegreeAuditDocumentRejected(Rec."Student No.", Rec."Document Sub Category")
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
    procedure MailSendforDegreeAuditDocumentRejected(StudentNo: Code[20]; SubCategory: Text[250])
    var
        SmtpMailRec: Record "Email Account";
        Studentmaster: Record "Student Master-CS";
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
    begin
        SmtpMailRec.Get();
        Studentmaster.GET(StudentNo);
        Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."SLcM Document No" + ' ' + SubCategory + ' ' + 'Degree Audit Document Rejection';

        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM

        SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate" + ',');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('This is to inform you that' + ' ' + SubCategory + ' ' + 'submitted by you has been Rejected.');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody('Please upload the rejected document again in your SLcM student portal for verification.');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Graduation Team');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('<br>');
        SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        BodyText := SmtpMail.GetBody();
        SmtpMail.AppendtoBody('<br>');
        //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
        //Mail_lCU.Send();

        WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Degree Audit', 'MEA', SenderAddress, Format(Rec."Student Name"),
        Rec."Student No.", Subject, BodyText, 'Degree Audit', 'Degree Audit', '', '',
        Recipient, 1, Studentmaster."Mobile Number", '', 1);
    end;
}