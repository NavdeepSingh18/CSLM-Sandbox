table 50356 "Housing Issue"
{
    Caption = 'Housing Issue';
    DataClassification = CustomerContent;
    DataCaptionFields = "Document No.", "Student Name";
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Application No.';
            trigger OnValidate()
            begin
                IF "Document No." <> xRec."Document No." THEN BEGIN
                    AdmissionSetup.GET();
                    Glsetup.Get();
                    NoSeriesMgt.TestManual(Glsetup."Housing Issue No.");
                    "No. Series" := '';
                END;
            end;

        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            begin
                if StudentMaster.Get("Student No.") then begin
                    "Student Name" := StudentMaster."Student Name";
                    "Enrolment No." := StudentMaster."Enrollment No.";
                    "Shortcut Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := StudentMaster."Global Dimension 2 Code";
                end else begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    "Shortcut Dimension 1 Code" := '';
                    "Shortcut Dimension 2 Code" := '';
                end;
            end;

        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }

        field(4; "Issue Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue';
            TableRelation = "Reason Code".Code where(Type = filter(Issue));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                ReasonCode.Reset();
                ReasonCode.SetRange(Code, "Issue Code");
                if ReasonCode.FindFirst() then
                    "Issue Description" := ReasonCode.Description;
            end;
        }
        field(5; "Issue Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Description';
        }
        field(6; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(7; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(8; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Pending for Approval","Accepted","Rejected","Resolved";
        }
        field(9; "Rejection Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection Description';
        }
        field(10; "Application No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
            // trigger OnValidate()
            // begin
            //     Validate("Housing ID", HostalApplication."Housing ID");
            // end;
            trigger OnLookup()
            var
                HostalApplication: Record "Housing Application";

            begin
                HostalApplication.Reset();
                HostalApplication.SetRange(Posted, true);
                HostalApplication.SetRange("Student No.", "Student No.");
                If Page.RunModal(Page::"Posted Housing Application", HostalApplication) = Action::LookupOK then
                    if "Document Date" IN [HostalApplication."Start Date" .. HostalApplication."End Date"] then begin
                        "Application No." := HostalApplication."Application No.";
                        Validate("Housing ID", HostalApplication."Housing ID");
                    end else
                        Error('Please check document date.');

            end;
        }
        field(11; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrolment No.';
            Editable = false;
        }
        field(12; "Rejection Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter(" "));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                ReasonCode.Reset();
                ReasonCode.SetRange(Code, "Rejection Reason Code");
                if ReasonCode.FindFirst() then
                    "Rejection Description" := ReasonCode.Description
                else
                    "Rejection Description" := '';
            end;
        }
        field(13; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;
        }
        field(14; "Resolution Mail"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Resolution Mail';
            Editable = false;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Application Date';
        }
        field(17; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
            trigger OnValidate()
            begin
                if "Posting Date" < "Document Date" then
                    Error('Posting date must not be less than document date.');
            end;
        }
        field(20; "Accepted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Accepted By';
            Editable = false;
        }
        field(21; "Accepted Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Accepted Date';
            Editable = false;
        }
        field(22; "Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected By';
            Editable = false;
        }
        field(23; "Rejection Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection Date';
            Editable = false;
        }
        field(24; "Closed By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Resolved By';
            Editable = false;
        }
        field(25; "Closed Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Resolved Date';
            Editable = false;
        }
        field(26; "Closed By Student"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Resolved By Student';
        }
        field(27; "Remarks By Student"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks By Student';
        }
        field(28; "Accepted In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Accepted In Days';
        }
        field(29; "Resolved In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Resolved In Days';
        }
        field(30; "Rejected In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected In Days';
        }
        field(31; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            Editable = false;
            trigger OnValidate()
            begin
                if HousingMasterRec.Get("Housing ID") then begin
                    "Housing Name" := HousingMasterRec."Housing Name";
                    "Housing Address" := HousingMasterRec.Address;
                    "Housing Address 2" := HousingMasterRec."Address 2";
                    "Housing City" := HousingMasterRec.City;
                    "Housing Country" := HousingMasterRec.Country;
                    "Contact Number" := HousingMasterRec."Contact Number";
                    "E-Mail" := HousingMasterRec."E-mail";
                end else begin
                    "Housing Name" := '';
                    "Housing Address" := '';
                    "Housing Address 2" := '';
                    "Housing City" := '';
                    "Housing Country" := '';
                    "Contact Number" := '';
                    "E-Mail" := '';
                end;
            end;
        }
        field(32; "Housing Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Name';
            Editable = false;

        }
        Field(33; "Housing Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Address';
            Editable = false;
        }
        Field(34; "Housing Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Address 2';
            Editable = false;
        }
        Field(35; "Housing City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing City';
            Editable = false;
        }
        Field(36; "Housing Country"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Housing Country';
            TableRelation = "Country/Region";
        }
        Field(37; "Contact Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Housing Contact Number';
        }
        Field(38; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Housing E-Mail';
            ExtendedDatatype = EMail;
        }
        Field(39; "Resolution Remarks"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Resolution Remarks';
        }
        field(40; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            Begin
                ShowDimensions();
            End;
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Date")
        {

        }
    }
    var
        AdmissionSetup: Record "Admission Setup-CS";
        HousingIssue: Record "Housing Issue";
        StudentMaster: Record "Student Master-CS";
        HousingMasterRec: Record "Housing Master";
        Glsetup: record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        Text051Lbl: Label 'The housing issue document no. %1 already exists.';

    trigger OnInsert()
    begin
        InitInsert();
        Inserted := true;
    end;

    trigger OnDelete()
    begin
        TestField(Status, Status::"Pending for Approval");
    end;

    Trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    procedure InitInsert()
    begin
        if "Document No." = '' then begin
            // AdmissionSetup.Get();
            Glsetup.Get();
            NoSeriesMgt.InitSeries(Glsetup."Housing Issue No.", xRec."No. Series", "Posting Date", "Document No.", "No. Series");
        end;
        "Document Date" := WorkDate();
    end;

    procedure AssistEdit(OldHousingIssue: Record "Housing Issue"): Boolean
    var
        HousingIssue2: Record "Housing Issue";
    begin
        with HousingIssue do begin
            Copy(Rec);
            // AdmissionSetup.Get();
            Glsetup.Get();
            if NoSeriesMgt.SelectSeries(Glsetup."Housing Issue No.", OldHousingIssue."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                if HousingIssue2.Get("Document No.") then
                    Error(Text051Lbl, "Document No.");
                Rec := HousingIssue;
                exit(true);
            end;
        end;
    end;

    procedure ShowDimensions()
    Begin
        "Dimension Set ID" :=
        DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "Document No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    End;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    // procedure MailDocumentforAcception()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Document No.") + ' ' + 'Housing Issue Request Accepted');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that the Housing Issue Request No.' + ' ' +
    //                         Format("Document No.") + ' ' + 'Raised by you has been accepted and is under review with Residential Services Team.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('You will be further notified regarding your request. You may also track status updates under “Housing Issue Status” page on SLcM student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Issue Accepted', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Issue', 'Housing', Format("Document No."), Format("Document Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailDocumentforRejection()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     UserSetupRec: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     UserSetupRec.Get(UserId());
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Document No.") + ' ' + 'Housing Issue Request Rejected');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that Housing Issue Request #' + ' ' +
    //                         Format("Document No.") + ' ' + 'has been' + ' ' + Format(Status) + ' ' + 'due to'
    //                         + ' ' + "Rejection Description" + '.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('You may contact Residential Services team for further details at' + ' ' + UserSetupRec."E-Mail"
    //                          + ' ' + 'or' + ' ' + UserSetupRec."Phone No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     If CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Issue Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Issue', 'Housing', Format("Document No."), Format("Document Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure ResolutionMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Document No.") + ' ' + 'Housing Issue Request Resolved');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that the Housing Issue Request No.' + ' ' +
    //                         Format("Document No.") + ' ' + 'raised by you has been resolved.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('You may also track status updates under “Housing Issue Status” page on SLcM student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Issue Resolved', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Issue', 'Housing', Format("Document No."), Format("Document Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;
}