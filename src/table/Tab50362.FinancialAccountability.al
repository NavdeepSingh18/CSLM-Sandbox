table 50362 "Financial Accountability"
{
    Caption = 'Financial Accountability';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Fine Application No.", "Student Name";

    fields
    {
        field(1; "Fine Application No."; Code[20])
        {
            Caption = 'Financial Accountability Application No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Fine Application No." <> xRec."Fine Application No." THEN BEGIN
                    // UserSetupRec.get(UserId());
                    // EducationSetup.Reset();
                    // EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    if GlSetup.get() then begin
                        NoSeriesMgt.TestManual(GlSetup."Financial Accountability No.");
                        "No. Series" := '';
                    END;
                end;
            end;
        }

        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()

            begin
                If StudentMasterRec.Get("Student No.") then begin
                    StudentStatus.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code");
                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                    StudentStatus.Status::Suspension, StudentStatus.Status::Withdrawn, StudentStatus.Status::Dismissed,
                    StudentStatus.Status::Deceased] then
                        Error('Please check the student status.')
                    else begin
                        "Student Name" := StudentMasterRec."Name as on Certificate";
                        "Enrolment No." := StudentMasterRec."Enrollment No.";
                        Semester := StudentMasterRec.Semester;
                        "Academic Year" := StudentMasterRec."Academic Year";
                        "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                    end;
                end else begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                end;
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(4; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(7; "Fine Category Code"; Code[20])
        {
            Caption = 'Financial Accountability Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Financial Account Category";
            trigger OnValidate()
            begin
                FinancialAccountRec.Reset();
                FinancialAccountRec.SetRange("Student No.", "Student No.");
                FinancialAccountRec.SetRange("Academic Year", "Academic Year");
                FinancialAccountRec.SetRange(Semester, Semester);
                FinancialAccountRec.SetRange("Fine Category Code", "Fine Category Code");
                FinancialAccountRec.SetRange(Status, FinancialAccountRec.Status::"Pending for Approval");
                if FinancialAccountRec.findfirst() then
                    error('Application of student No. %1 for this semester %2 and academic year %3 is already pending'
                    , "Student No.", Semester, "Academic Year");

                if FinAccCateRec.Get("Fine Category Code") then begin
                    "Fine Category Description" := FinAccCateRec."Category Description";
                    "Fee Component Code" := FinAccCateRec."Fee Component Code";
                    "Fee Component Description" := FinAccCateRec."Fee Component Description";
                    "Global Dimension 2 Code" := FinAccCateRec."Global Dimension 2 Code";
                end else begin
                    "Fine Category Description" := '';
                    "Fee Component Code" := '';
                    "Fee Component Description" := '';
                    "Global Dimension 2 Code" := '';
                end;
            end;
        }
        field(8; "Fine Category Description"; text[100])
        {
            Caption = 'Financial Accountability Category Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Applicable Amount"; Decimal)
        {
            Caption = 'Applicable Amount';
            DataClassification = CustomerContent;
            MinValue = 1;
            trigger OnValidate();
            begin
                "Approved Amount" := "Applicable Amount";
            end;
        }
        field(10; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
            trigger OnValidate()
            begin
                if "Rejection Remarks" <> '' then
                    Error('Rejection Remarks must be blank.');
            end;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(13; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(14; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(15; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(16; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(17; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(18; Inserted; Boolean)
        {
            Caption = 'Inserted';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            Editable = false;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = '"No. Series"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(22; "Approved On"; Date)
        {
            Caption = 'Approved On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Rejected By"; Code[50])
        {
            Caption = 'Rejected By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "Rejected On"; Date)
        {
            Caption = 'Rejected On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(25; "Approved In Days"; Integer)
        {
            Caption = 'Approved In Days';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Fine Date"; Date)
        {
            Caption = 'Financial Accountability Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; "Rejection Remarks"; text[500])
        {
            Caption = 'Rejection Remarks';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Approved Amount" <> 0 then
                    Error('Approved amount must be zero.');
            end;
        }
        field(28; "Fee Component Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Component Code';
            Editable = false;
        }
        field(29; Remarks; text[500])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(30; "Fee Component Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Component Description';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Fine Application No.")
        {
            Clustered = true;
        }
        key(Key2; "Created On")
        {

        }
    }
    Var
        StudentMasterRec: Record "Student Master-CS";
        EducationSetup: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        FinAccCateRec: Record "Financial Account Category";
        FinancialAccountRec: Record "Financial Accountability";
        StudentStatus: Record "Student Status";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];


    trigger OnInsert()
    begin
        UserSetupRec.get(UserId());
        IF "Fine Application No." = '' THEN BEGIN
            // EducationSetup.Reset();
            // EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if GlSetup.get() then begin
                GlSetup.TESTFIELD("Financial Accountability No.");
                NoSeriesMgt.InitSeries(GlSetup."Financial Accountability No.", xRec."No. Series", 0D, "Fine Application No.", "No. Series");
            end;
        end;

        "Created By" := Format(USERID());
        "Created On" := TODAY();
        Inserted := true;
        "Fine Date" := workdate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(USERID());
        "Modified On" := TODAY();
        Updated := true;
    end;

    procedure AssistEdit(OldFinancialAccountability: Record "Financial Accountability"): Boolean
    var
        FinancialAccountabilityRec: Record "Financial Accountability";
    begin
        WITH FinancialAccountabilityRec DO BEGIN
            FinancialAccountabilityRec := Rec;
            // UserSetupRec.get(UserId());
            // EducationSetup.Reset();
            // EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if GlSetup.get() then begin
                GlSetup.TESTFIELD("Financial Accountability No.");
                IF NoSeriesMgt.SelectSeries(GlSetup."Financial Accountability No.", OldFinancialAccountability."No. Series", "No. Series") THEN BEGIN
                    NoSeriesMgt.SetSeries("Fine Application No.");
                    Rec := FinancialAccountabilityRec;
                    EXIT(TRUE);
                END;
            end;
        END;

    End;

    // procedure MailForApproved(StudentNo: Code[20]; FineCategory: text[100]; ApplicableCharge: Decimal)
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
    //     UserSetupRec.Get(UserId());
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Financial Accountability Payment Clearance';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that Financial Accountability charge has been raised by Residential Services. Here are the details:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Financial Accountability Category:' + ' ' + "Fine Category Description");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Applicable Charges:' + ' ' + '$' + Format("Approved Amount"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please clear your dues accordingly. For any further clarification, kindly contact the Bursar department at' + ' ' + UserSetupRec."E-Mail" + ' ' + 'or' + ' ' + UserSetupRec."Phone No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Bursar Department');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     //SmtpMail.AddAttachment(FileName, 'Customer');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Financial Accountability Approved', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Financial Accountability', 'Financial Accountability', Format("Fine Application No."), Format("Fine Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailForRejection(StudentNo: Code[20]; FineCategory: text[100]; ApplicableCharge: Decimal)
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     UserSetupRec: Record "User Setup";
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
    //     UserSetupRec.Get("Created By");
    //     Studentmaster.GET(StudentNo);
    //     UserSetupRec.TESTFIELD(UserSetupRec."E-Mail");
    //     Recipient := UserSetupRec."E-Mail";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Housing Fine Rejection';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + UserSetupRec."User ID");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('It is informed to you that, Bursar deparment has rejected a fine of' + ' ' + 'USD' + ' ' + Format(ApplicableCharge) + ' ' + 'against the'
    //                          + ' ' + Format(FineCategory) + ' ' + 'due to' + ' ' + "Rejection Remarks");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Bursar Department');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Financial Accountability Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Financial Accountability', 'Financial Accountability', Format("Fine Application No."), Format("Fine Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure ApprovalRequestMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     UserSetupRec: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     usersetupapprover: Record "Document Approver Users";
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
    //     usersetupapprover.Reset();
    //     usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Bursar Department");
    //     usersetupapprover.FindFirst();

    //     UserSetupRec.Reset();
    //     UserSetupRec.SetRange("User ID", usersetupapprover."User ID");
    //     If UserSetupRec.FindFirst() Then
    //         Recipient := UserSetupRec."E-Mail";


    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Fine Application No.") + ' ' + 'Financial Accountability Raised'
    //                + ' ' + "Student Name" + ',' + ' ' + "Student No.");

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + 'Bursar Team' + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that Financial Accountability charge has been raised for' + ' ' +
    //                         "Student Name" + ' ' + "Student No." + ' ' + 'due for your approval');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please find the details below:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Financial Accountability Category:' + ' ' + "Fine Category Description");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Applicable Charges:' + ' ' + Format("Applicable Amount"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Financial Accountability Raised', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Financial Accountability', 'Financial Accountability', Format("Fine Application No."), Format("Fine Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);

    // end;

}
