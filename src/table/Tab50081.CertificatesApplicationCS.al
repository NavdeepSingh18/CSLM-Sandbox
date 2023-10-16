table 50081 "Certificates Application-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    10-01-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Certificates Application-CS';
    DrillDownPageID = 50282;
    LookupPageID = 50282;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if UserSetup.Get(UserId()) then;
                IF "Application No." <> xRec."Application No." THEN BEGIN
                    EducationSetupRec.Reset();
                    EducationSetupRec.Setrange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                    if EducationSetupRec.Findfirst() then
                        NoSeriesManagement.TestManual(EducationSetupRec."Certificate Application No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Certificate; Code[20])
        {
            Caption = 'Certificate';
            DataClassification = CustomerContent;
            //TableRelation = "Certificate-CS";
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Pending,Completed,Rejected';
            OptionMembers = Pending,Completed,Rejected;
            Editable = false;
        }
        field(4; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Student No."; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            begin
                if StudentMasterRec.Get("Student No.") then begin
                    "Enrollment No." := StudentMasterRec."Enrollment No.";
                    Semester := StudentMasterRec.Semester;
                    Gender := StudentMasterRec.Gender;
                    "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                    "last Name" := StudentMasterRec."Last Name";
                    "Middle Name" := StudentMasterRec."Middle Name";
                    "First Name" := StudentMasterRec."First Name";
                    "Student Name" := StudentMasterRec."Student Name";
                    "Course Code" := StudentMasterRec."Course Code";
                    "Phone Number" := StudentMasterRec."Phone Number";
                    "E-Mail Address" := StudentMasterRec."E-Mail Address";
                end else begin
                    "Enrollment No." := '';
                    "First Name" := '';
                    "Last Name" := '';
                    "Student Name" := '';
                    "Course Code" := '';
                    "Phone Number" := '';
                    "E-Mail Address" := '';
                end;
            end;
        }
        field(6; "Application Category"; Code[20])
        {
            Caption = 'Application Category';
            DataClassification = CustomerContent;
        }
        field(7; "Payment Amount"; Decimal)
        {
            Caption = 'Payment Amount';
            DataClassification = CustomerContent;
        }
        field(8; Purpose; Text[30])
        {
            Caption = 'Purpose';
            DataClassification = CustomerContent;
        }
        field(9; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(10; "Status Date"; Date)
        {
            Caption = 'Status Date';
            DataClassification = CustomerContent;
        }
        field(50000; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Statement; Text[250])
        {
            Caption = 'Statement';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
        }
        field(50004; "Collecting By"; Text[30])
        {
            Caption = 'Collecting By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
        }
        field(50005; "Courier Type"; Option)
        {
            Caption = 'Mail Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Standard Mail,FedEx Next Day Delivery';
            OptionMembers = " ","Standard Mail","FedEx Next Day Delivery";
            Description = 'CS Field Added 29-01-2019';
        }
        field(50006; "Courier Charges"; Decimal)
        {
            Caption = 'Mail Charges';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
        }
        field(50007; "Courier FeeCode"; Code[20])
        {
            Caption = 'Courier FeeCode';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
        }
        field(50008; "Courier Address"; Text[250])
        {
            Caption = 'Mail Address';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29-01-2019';
        }
        field(50009; "File Name"; Text[50])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05-05-2019';
        }
        field(50010; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05-05-2019';
        }
        field(50011; Attachment; BLOB)
        {
            Caption = 'Attachment';
            DataClassification = CustomerContent;
            Compressed = false;
            Description = 'CS Field Added 05-05-2019';
            SubType = Bitmap;
        }
        field(50012; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05-05-2019';
        }
        field(50013; "Approved/Printed"; Boolean)
        {
            Caption = 'Approved/Printed';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05-05-2019';
        }
        field(50014; "Last Print Date/Time"; DateTime)
        {
            Caption = 'Last Print Date/Time';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05-05-2019';
        }
        field(50015; "No of Prints"; Integer)
        {
            Caption = 'No of Prints';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 05-05-2019';
        }
        field(50016; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No';
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50017; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50018; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50019; "Rank Certificate"; Option)
        {
            Caption = 'Rank Certificate';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
            OptionMembers = " ",Semester,Overall;
        }
        field(50020; Remark1; Text[250])
        {
            Caption = 'Remark1';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50021; "App Category Classification"; Text[50])
        {
            Caption = 'App Category Class';
            FieldClass = FlowField;
            CalcFormula = Lookup("Application Cert. Cate-CS"."App Category Classification" WHERE("Application Category Code" = FIELD("Application Category")));
            Description = 'CS Field Added 12-05-2019';

        }
        field(50022; "Last Date/Time of Application"; DateTime)
        {
            caption = 'Last date/Time of Application';
            FieldClass = FlowField;
            CalcFormula = Max("Certificates Application-CS"."Last Print Date/Time" WHERE("Student No." = FIELD("Student No."),
                                                                                          "Application Category" = FIELD("Application Category")));
            Description = 'CS Field Added 12-05-2019';
        }
        field(50023; "First Name"; Text[35])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(50024; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(50025; "Last Name"; Text[35])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(50026; Relationship; Text[30])
        {
            Caption = 'Relationship';
            DataClassification = CustomerContent;
        }
        field(50027; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Female,Male,Not Specified';
            OptionMembers = " ",Female,Male,"Not Specified";
        }
        field(50028; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }
        field(50029; "E-Mail Address"; Text[50])
        {
            Caption = 'E-Mail Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(50030; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            // TableRelation = if ("Country Code" = const()) "Post Code"
            // else
            // if ("Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Country Code"));
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Post Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         "Country Code" := PostCodeRec."Country/Region Code";
            //         city := PostCodeRec.City;
            //         State := PostCodeRec."State Code";
            //     END ELSE BEGIN
            //         "Country Code" := '';
            //         city := '';
            //         State := '';
            //     END;
            // end;
        }
        field(50031; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(50032; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            TableRelation = "State SLcM CS";
        }
        field(50033; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50034; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(50035; "Courier No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Mail Tracking No.';
        }
        field(50036; "Mode of Collection"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type of Request';
            OptionCaption = ' ,Mail Official Transcript,E-Mail Transcript,BHHS Degree';
            OptionMembers = " ","Mail Official Transcript","E-Mail Transcript","BHHS Degree";

            Trigger OnValidate()
            begin
                If Rec.Status = Rec.Status::Pending then begin
                    IF Rec."Mode of Collection" = Rec."Mode of Collection"::"Mail Official Transcript" then
                        CreateNotes('Pending Official Transcript Request');

                    IF Rec."Mode of Collection" = Rec."Mode of Collection"::"E-Mail Transcript" then
                        CreateNotes('Pending Unofficial Transcript Request');

                    If Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
                        CreateNotes('Pending BHHS Degree Request');
                end;
            end;
        }
        field(50037; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50038; "Organization Name "; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50039; "Completed By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50040; "Application Completed Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50041; "Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50042; "Rejected On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50043; Payment; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50044; "Digital Signature Status"; Option)
        {
            OptionCaption = ' ,Pending,Completed,Not Required';
            OptionMembers = " ",Pending,Completed,"Not Required";
        }
        Field(50045; "Payment Status"; Option)
        {
            OptionCaption = ' ,Pending,Completed';
            OptionMembers = " ",Pending,Completed;
        }
        field(50046; "Bursar Hold Exist"; Boolean)
        {
            //CSPL-00307
            Caption = 'Bursar Hold';
            FieldClass = FlowField;
            CalcFormula = exist("Student Wise Holds" where("Student No." = field("Student No."), "Hold Code" = filter('BURHOLD'), Status = Filter(Enable)));
            Editable = false;
        }
        Field(50047; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }


        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            Description = 'CS Field Added 12-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 12-05-2019';
        }

    }

    keys
    {
        key(Key1; "Application No.")
        {
        }
        key(Key2; "Application Date")
        {

        }
    }
    var
        PostCodeRec: Record "Post Code";
        StudentMasterRec: Record "Student Master-CS";
        EducationSetupRec: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        CompanyInfromation: Record "Company Information";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];

    trigger OnInsert()
    begin
        "User ID" := FORMAT(UserId());
        if UserSetup.Get(UserId()) then;
        EducationSetupRec.Reset();
        EducationSetupRec.Setrange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetupRec.Findfirst() then
            IF "No. Series" = '' THEN BEGIN
                EducationSetupRec.TESTFIELD("Certificate Application No.");
                NoSeriesManagement.InitSeries(EducationSetupRec."Certificate Application No.", xRec."No. Series", 0D, "Application No.", "No. Series");
            END;
        "Application Date" := Today();
        Inserted := True;
    end;

    Trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    procedure Assistedit(OldCertificate: Record "Certificates Application-CS"): Boolean
    Var
        CertificateApplicationRec: Record "Certificates Application-CS";
    begin

        WITH CertificateApplicationRec DO BEGIN
            CertificateApplicationRec := Rec;
            if UserSetup.Get(UserId()) then;
            EducationSetupRec.Reset();
            EducationSetupRec.Setrange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            if EducationSetupRec.Findfirst() then
                EducationSetupRec.TESTFIELD("Certificate Application No.");
            IF NoSeriesManagement.SelectSeries(EducationSetupRec."Certificate Application No.", OldCertificate."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries("Application No.");
                Rec := CertificateApplicationRec;
                EXIT(TRUE);
            END;
        END;
    end;

    // procedure SendTranscriptMail()
    // var
    //     SmtpMailRec: Record "Email Account";
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
    //     CompanyInfromation.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + 'Transcript Request Application');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your Transcript Request Application No.' + ' ' +
    //                         Format("Application No.") + ' ' + 'has been Completed.');

    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('You can track your Application status under “Transcript Requests Status” page on student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Office of the Registrar');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     if CompanyInfromation."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Graduation', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Degree Audit', 'Transcript Request', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure SendDegreeMail()
    // var
    //     SmtpMailRec: Record "Email Account";
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
    //     CompanyInfromation.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + 'BHHS Degree Request Application');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your BHHS Degree Request Application No. ' + ' ' +
    //                         Format("Application No.") + ' ' + 'has been completed.');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('You can track your Application status under “BHHS Degree Requests Status” page on student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Office of the Registrar');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     //  SmtpMail.AppendtoBody('<br>');
    //     //  //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     if CompanyInfromation."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Graduation', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Degree Audit', 'BHHS Degree', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    procedure CreateNotes(_Notes: Text[2048])
    Var
        StudentMaster: Record "Student Master-CS";
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        EntryNo: Integer;

    Begin
        StudentMaster.Reset();
        if StudentMaster.Get("Student No.") then;



        EntryNo := 0;
        InterLogEntryCommentLine.Reset();
        if InterLogEntryCommentLine.FindLast() then
            EntryNo := InterLogEntryCommentLine."Entry No."
        else
            EntryNo := 0;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        InterLogEntryCommentLine.Init();
        InterLogEntryCommentLine."Entry No." := EntryNo + 1;
        InterLogEntryCommentLine."Source No." := Rec."Student No.";
        InterLogEntryCommentLine.Validate("Interaction Template Code", 'Student');
        InterLogEntryCommentLine.Validate("Interaction Group Code", 'Student');
        InterLogEntryCommentLine.Validate("Student No.", Rec."Student No.");
        //InterLogEntryCommentLine.Validate("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        InterLogEntryCommentLine.Department := InterLogEntryCommentLine.Department::Graduation;
        InterLogEntryCommentLine.Notes := _Notes;
        InterLogEntryCommentLine."Student Notes" := true;
        InterLogEntryCommentLine."Created By" := UserId;
        InterLogEntryCommentLine."Created On" := Today;
        InterLogEntryCommentLine."Original Student No." := StudentMaster."Original Student No.";
        InterLogEntryCommentLine.Insert(true);
    End;
}

