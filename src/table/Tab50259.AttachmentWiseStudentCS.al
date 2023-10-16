table 50259 "Attachment Wise Student-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                       Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/08/2019       Student No. - OnValidate()                    Code added for Student Relation Information
    // 02    CSPL-00114   19/08/2019       Document Type - OnValidate()                  Code added for Get Document Description
    // 03    CSPL-00114   19/08/2019       Approved - OnValidate()                       Code added for Auto Approved By
    // 04    CSPL-00114   19/08/2019       ImportAttachment() - Function                 Create Function for Import File
    // 05    CSPL-00114   19/08/2019       OpenAttachment() - Function                   Create Function for Open File
    // 06    CSPL-00114   19/08/2019       ExportAttachment() - Function                 Create Function for Export File
    // 07    CSPL-00114   19/08/2019       RemoveAttachment() - Function                 Create Function for Remove File

    Caption = 'Attachment Wise Student-CS';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;

            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student Relation Information::CSPL-00114::19082019: Start
                AttachmentWiseStudentCS.Reset();
                AttachmentWiseStudentCS.SETRANGE("Student No.", "Student No.");
                IF AttachmentWiseStudentCS.FINDLAST() THEN
                    LineNum := AttachmentWiseStudentCS."Line No." + 10000
                ELSE
                    LineNum := 10000;
                "Line No." := LineNum;
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Name as on Certificate";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                END;
                //Code added for Student Relation Information::CSPL-00114::19082019: End
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Student Name"; Text[150])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(4; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(5; "Document Type"; Code[20])
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;

            TableRelation = "File Attachment-CS";

            trigger OnValidate()
            begin
                //Code added for Get Document Description ::CSPL-00114::19082019: Start
                FileAttachmentCS.Reset();
                FileAttachmentCS.SETRANGE(Code, "Document Type");
                IF FileAttachmentCS.FINDFIRST() THEN
                    "Document Description" := FileAttachmentCS.Description
                ELSE
                    "Document Description" := '';
                //Code added for Get Document Description ::CSPL-00114::19082019: End 
            END;


        }
        field(6; "File Name"; Text[250])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(7; "File Extension"; Text[250])
        {
            Caption = 'File Extension';
            DataClassification = CustomerContent;
        }
        field(8; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(9; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(10; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(11; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(12; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(13; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(14; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(15; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Auto Approved By::CSPL-00114::19082019: Start
                IF CONFIRM(Text0001Lbl, FALSE) THEN BEGIN
                    IF Approved THEN
                        "Approved By" := FORMAT(UserId())
                    ELSE
                        "Approved By" := '';
                END
                ELSE
                    EXIT;
                //Code added for Auto Approved By::CSPL-00114::19082019: End

            END;
        }

        field(16; "Approved By"; Text[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
            DataClassification = CustomerContent;
        }
        field(20; "Document Description"; Text[80])
        {
            Caption = 'Document Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(21; "Transaction No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Document Category"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Doc & Cate Attachment-CS".Code;
        }
        field(23; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pending,Approved,Rejected';
            OptionMembers = " ","Pending","Approved","Rejected";
        }
        field(24; "Reject Reason"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = Const(EED));
            Trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            Begin
                IF "Reject Reason" <> '' then begin
                    ReasonCode.Reset();
                    ReasonCode.SetRange(Code, "Reject Reason");
                    IF ReasonCode.FindFirst() then
                        "Reject Reason Description" := ReasonCode.Description;
                end Else
                    "Reject Reason Description" := '';

            End;
        }
        field(25; "Reject Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        Field(26; "Attachment Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Different Attachment-CS";
        }
    }

    keys
    {
        key(Key1; "Student No.", "Line No.")
        {
        }
        key(Key2; "Updated On", "Created On")
        {

        }
    }

    fieldgroups
    {
    }

    var
        AttachmentWiseStudentCS: Record "Attachment Wise Student-CS";
        StudentMasterCS: Record "Student Master-CS";
        FileAttachmentCS: Record "File Attachment-CS";
        Text0001Lbl: Label 'Do you want to approve this document?';


        LineNum: Integer;

    trigger OnInsert()
    var
    // myInt: Integer;
    begin
        "Created By" := UserId;
        "Created On" := Today;
    end;

    trigger OnModify()
    var
    // myInt: Integer;
    begin
        "Updated By" := UserId;
        "Updated On" := Today;
    end;

    procedure ImportAttachment()
    var


    begin
        //Create Function for Import File::CSPL-00114::19082019: Start
        //CS-BLOCKEDIF NewAttachment.ImportAttachmentFromClientFile('', FALSE, TRUE) THEN 
        //CS-BLOCKEDBEGIN
        //CS-BLOCKED"Attachment No." := NewAttachment."No.";
        //CS-BLOCKED"File Name" := NewAttachment."File Name";
        //CS-BLOCKEDModify();
        //CS-BLOCKEDMESSAGE('Attachment Imported Successfully');
        //CS-BLOCKEDEND ELSE
        //CS-BLOCKEDERROR(Text002Lbl);
        //Create Function for Import File::CSPL-00114::19082019: End
    END;

    procedure OpenAttachment()
    var

        NewAttachment: Record "Attachment";
    begin
        //Create Function for Open File::CSPL-00114::19082019: Start
        IF "Attachment No." = 0 THEN
            EXIT;

        NewAttachment.GET("Attachment No.");
        //CS-BLOCKEDNewAttachment.OpenAttachment("File Name", FALSE, '');
        //Create Function for Open File::CSPL-00114::19082019: End
    end;

    procedure ExportAttachment()
    var
        Attachment: Record "Attachment";
        ExportToFile: Text[240];
    begin
        //Create Function for Export File::CSPL-00114::19082019: Start
        ExportToFile := '';
        Attachment.GET("Attachment No.");
        //CS-BLOCKEDAttachment.ExportAttachmentToClientFile(ExportToFile);
        //Create Function for Export File::CSPL-00114::19082019: End
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        //Create Function for Remove File::CSPL-00114::19082019: Start

        Attachment.GET("Attachment No.");
        //CS-BLOCKEDIF Attachment.RemoveAttachment(Prompt) THEN 
        BEGIN
            "Attachment No." := 0;
            Modify();
        END;
        //Create Function for Remove File::CSPL-00114::19082019: End
    end;

    // procedure SendEMail(RecAttachmentWiseStudent: Record "Attachment Wise Student-CS")
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Studentmaster: Record "Student Master-CS";
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: text;
    // begin
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     // Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     // Recipient := Studentmaster."E-Mail Address";
    //     Recipient := 'Lucky.kumar@corporateserve.com;stuti.khandelwal@corporateserve.com';
    //     Recipients := Recipient.Split(';');
    //     SMTPMailSetup.GET;
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     IF RecAttachmentWiseStudent.Status = RecAttachmentWiseStudent.Status::Approved then
    //         Subject := 'SLcM: Form Upload - Confirmed';
    //     IF RecAttachmentWiseStudent.Status = RecAttachmentWiseStudent.Status::Rejected then
    //         Subject := 'SLcM: Form Upload - Rejected';
    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Regular Medical Scholar Acceptance Email', '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     IF RecAttachmentWiseStudent.Status = RecAttachmentWiseStudent.Status::Approved then
    //         SMTPMail.AppendtoBody('<p>The purpose of this message is to confirm that the following form uploaded by you has been accepted:</p>');
    //     IF RecAttachmentWiseStudent.Status = RecAttachmentWiseStudent.Status::Rejected then
    //         SMTPMail.AppendtoBody('<p>The purpose of this message is to inform you that the following form uploaded by you has been rejected:</p>');
    //     SMTPMail.AppendtoBody('<li>' + RecAttachmentWiseStudent."Document Description" + '</li>');
    //     SMTPMail.AppendtoBody('<br><br>Log into the SLcM System for more details and to re-submit the form. <br><br>');
    //     SMTPMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].<br><br>');
    //     Smtpmail.AppendtoBody('Thankyou,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('SLcM System Administrator');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     // MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Document Received Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Document Received Alert', 'Document Received Alert', Format(Rec."Student No."), Format("Created On", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;
}