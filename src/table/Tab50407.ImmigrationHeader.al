table 50407 "Immigration Header"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Document No.", "Student Name";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                // EducationSetup: Record "Education Setup-CS";
                GlSetup: record "General Ledger Setup";
            begin
                // GetFeeSetup(EducationSetup);
                GlSetup.get();
                GlSetup.TestField("Immigration Document No.");
                NoSeriesMgmt_lCU.TestManual(GlSetup."Immigration Document No.");
                "No. Series" := '';
            end;
        }
        field(2; "Student No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            begin
                StudentmasterRec.Reset();
                StudentmasterRec.SetRange("No.", "Student No");
                IF StudentmasterRec.FindFirst() then begin


                    SemesterRec.Reset();
                    SemesterRec.Setrange(Code, StudentmasterRec.Semester);
                    if SemesterRec.FindFirst() then
                        if not SemesterRec."Immigration Applicable" then
                            Error('Immigration is not Applicable for the Semester %1', StudentmasterRec.Semester);

                    "Enrollment No" := StudentmasterRec."Enrollment No.";
                    Semester := StudentmasterRec.Semester;
                    "Academic Year" := StudentmasterRec."Academic Year";
                    "Global Dimension 1 Code" := StudentmasterRec."Global Dimension 1 Code";
                    "Student Name" := StudentmasterRec."Student Name";
                    Term := StudentmasterRec.Term;
                    "First Name" := StudentmasterRec."First Name";
                    "Last Name" := StudentmasterRec."Last Name";
                    "AUA Email ID" := StudentmasterRec."E-Mail Address";
                end Else begin
                    "Enrollment No" := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Student Name" := '';
                    "First Name" := StudentmasterRec."First Name";
                    "Last Name" := StudentmasterRec."Last Name";
                    "AUA Email ID" := StudentmasterRec."E-Mail Address";
                end;
            end;
        }
        field(3; "Enrollment No"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
            Editable = false;
        }
        field(5; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            Editable = false;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Pass Port No. 1"; Text[20])
        {
            Caption = 'Passport No. 1';
            DataClassification = CustomerContent;
        }
        field(8; "Pass Port Issued Date 1"; Date)
        {
            Caption = 'Passport Issued Date 1';
            DataClassification = CustomerContent;
        }
        field(9; "Pass Port Issued By 1"; Text[50])
        {
            Caption = 'Place of Issue 1';
            DataClassification = CustomerContent;
        }

        field(10; "Pass Port Expiry Date 1"; Date)
        {
            Caption = 'Passport Expiry Date 1';
            DataClassification = CustomerContent;
        }
        field(11; "Pass Port No. 2"; Text[20])
        {
            Caption = 'Passport No. 2';
            DataClassification = CustomerContent;
        }
        field(12; "Pass Port Issued Date 2"; Date)
        {
            Caption = 'Passport Issued Date 2';
            DataClassification = CustomerContent;
        }
        field(13; "Pass Port Issued By 2"; Text[50])
        {
            Caption = 'Place of Issue 2';
            DataClassification = CustomerContent;
        }

        field(14; "Pass Port Expiry Date 2"; Date)
        {
            Caption = 'Passport Expiry Date 2';
            DataClassification = CustomerContent;
        }
        field(15; "Pass Port No. 3"; Text[20])
        {
            Caption = 'Passport No. 3';
            DataClassification = CustomerContent;
        }
        field(16; "Pass Port Issued Date 3"; Date)
        {
            Caption = 'Passport Issued Date 3';
            DataClassification = CustomerContent;
        }
        field(17; "Pass Port Issued By 3"; Text[50])
        {
            Caption = 'Place of Issue 3';
            DataClassification = CustomerContent;
        }

        field(18; "Pass Port Expiry Date 3"; Date)
        {
            Caption = 'Passport Expiry Date 3';
            DataClassification = CustomerContent;
        }
        field(19; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            DataClassification = CustomerContent;
        }
        field(20; "Visa Issued Date"; Date)
        {
            Caption = 'VISA Issued Date';
            DataClassification = CustomerContent;
        }
        field(21; "Visa Expiry Date"; Date)
        {
            Caption = 'Visa Exp Date';
            DataClassification = CustomerContent;
        }
        field(22; "Visa Extension Date"; Date)
        {
            Caption = 'Immigration Expiration Date';
            DataClassification = CustomerContent;
        }
        field(23; "Immigration Application Date"; Date)
        {
            Caption = 'Immigration Application Date';
            DataClassification = CustomerContent;
        }
        field(24; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(25; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Document Status"; Option)
        {
            OptionCaption = ' ,Pending for Verification,Verified,Rejected';
            OptionMembers = " ","Pending for Verification",Verified,Rejected;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Editable = False;

        }
        field(28; "Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(29; "Country Code"; Text[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CountryRegionRec.Reset();
                CountryRegionRec.SetRange(Code, "Country Code");
                if CountryRegionRec.FindFirst() then
                    if not CountryRegionRec."Immigration Applicable" then
                        Error('Immigration is not Applicable for the Country %1', CountryRegionRec.Code);
            end;
        }
        field(30; "Addressee"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Address1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(32; "Address2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(33; "Post Code"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(35; "Rejection Remark"; Text[500])
        {
            DataClassification = CustomerContent;

        }
        field(36; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(37; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(38; "Approved/Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected By';
            Editable = false;

        }
        Field(39; "Approved/Rejected On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected On';
            Editable = False;

        }
        field(40; "Immigration Hold"; Boolean)
        {
            Caption = 'Immigration Hold';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Student Wise Holds" WHERE("Student No." = FIELD("Student No"),
                                                            "Semester" = FIELD(Semester),
                                                            Status = filter(Enable),
                                                            "Hold Type" = filter("Immigration")));

        }

        field(41; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }

        field(42; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(43; "Immigration Issuance Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(44; "AUA Email ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }

    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Created On")
        {

        }
    }
    trigger OnInsert()
    var
        // EducationSetup: Record "Education Setup-CS";
        GlSetup: Record "General Ledger Setup";
    begin
        IF "Document No." = '' then begin
            // GetFeeSetup(EducationSetup);
            GlSetup.get();
            GlSetup.TestField("Immigration Document No.");
            NoSeriesMgmt_lCU.InitSeries(GlSetup."Immigration Document No.", xRec."No. Series", 0D, "Document No.", Rec."No. Series");
        end;
        "Created By" := FORMAT(UserId());
        "Created On" := Today();

        Inserted := true;
    end;

    Trigger OnModify()
    begin
        If xRec.Updated = updated then
            Updated := True;
    end;

    Trigger OnDelete()
    var
        StudentDocAttachment: Record "Student Document Attachment";
    begin
        StudentDocAttachment.Reset();
        StudentDocAttachment.SetRange("SLcM Document No", Rec."Document No.");
        StudentDocAttachment.DeleteAll();
    end;

    procedure AssistEdit(OldImmigrationHeader: Record "Immigration Header"): Boolean
    var
        // EducationSetup: Record "Education Setup-CS";
        ImmigrationHeaderRec: Record "Immigration Header";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        with ImmigrationHeaderRec do begin
            ImmigrationHeaderRec := Rec;
            // GetFeeSetup(EducationSetup);
            GlSetup.get();
            GlSetup.TestField("Immigration Document No.");
            if NoSeriesMgt.SelectSeries(GlSetup."Immigration Document No.", OldImmigrationHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                Rec := ImmigrationHeaderRec;
                exit(true);
            end
        end;
    end;

    procedure GetFeeSetup(var EducationSetup: Record "Education Setup-CS")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        UserSetup.FindFirst();

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        EducationSetup.FindFirst();
    end;


    // procedure MailSendforImmigrationDocumentApproved(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Document No." + ' ' + 'Immigration Application Approved';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that your Immigration Application ' + Rec."Document No." + ' is Approved.');//CSPL-00307 Changes 22-10-21
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     SmtpMail.AppendtoBody('<br>');
    //     ////SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration Application Approved', 'MEA', SenderAddress, Format("Student Name"),
    //     StudentNo, Subject, BodyText, 'Immigration Application', 'Immigration Application', "Document No.", '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailSendforImmigrationApplicationRejected(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Document No." + ' ' + 'Immigration Application Rejected';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     //CSPL-00307 Changes 22-10-21
    //     SmtpMail.AppendtoBody('This is to inform you that Immigration Application ' + Rec."Document No." + ' is Rejected. Please resubmit your application again 48 hours after receipt of this email request. Failure will result in your application being place on HOLD until document(s) is/are uploaded.');
    //     // 'Failure will result in your application being place on HOLD until document(s) is/are uploaded.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Please contact Residential Services for more information.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();                     //08-June-2023 As per Mishma confirmation (Mail Subject : Immigration Notification);

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration Application Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     StudentNo, Subject, BodyText, 'Immigration Application', 'Immigration Application', "Document No.", '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailSendforImmigrationHold(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     //Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Document No." + ' ' + 'Immigration Hold';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     //CSPL-00307 Changes 22-10-21
    //     SmtpMail.AppendtoBody('This is to inform you that you have been placed on Immigration Hold! Pending submission of hardcopies of immigration application and documents to the Residential Services Department.');          //19Dec2022 Navdeep
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please submit all the hard copies of the Immigration Document/s 48 hours after receipt of this email request.'); //CSPL-00307 Changes 22-10-21 
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     SmtpMail.AppendtoBody('<br>');
    //     ////SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration Application OnHold', 'MEA', SenderAddress, Format("Student Name"),
    //     StudentNo, Subject, BodyText, 'Immigration Application', 'Immigration Application', "Document No.", '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;


    procedure ImmigrationHoldCheck(StudentNo: Code[20]): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldOption: Option Enable,Disable;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::"Immigration");
        if StudentWiseHoldRec.FindFirst() then begin
            HoldOption := StudentWiseHoldRec.Status;
            If HoldOption = HoldOption::Enable Then
                exit(true)
            else
                exit(false);
        end;
    end;

    var
        StudentmasterRec: Record "Student Master-CS";
        CountryRegionRec: Record "Country/Region";
        SemesterRec: Record "Semester Master-CS";
        CompanyInformationRec: Record "Company Information";
        NoSeriesMgmt_lCU: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];

}