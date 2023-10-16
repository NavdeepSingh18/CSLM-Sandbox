table 50390 "Withdrawal Approvals"
{
    Caption = 'Pending Withdrawal Approval List';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Student No.", "Student Name";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    Course := StudentMasterCS."Course Code";
                    "Enrolment No." := StudentMasterCS."Enrollment No.";
                    Semester := StudentMasterCS.Semester;
                    "Course Name" := StudentMasterCS."Course Name";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                END else begin
                    "Student Name" := '';
                    Course := '';
                    "Enrolment No." := '';
                    Semester := '';
                    "Course Name" := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                end;
            end;
        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
        }

        field(6; "Approved for Department"; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                DepartmentMasterRec.Reset();
                DepartmentMasterRec.SetRange("Department Code", "Approved for Department");
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::Withdrawal);
                if DepartmentMasterRec.FindFirst() then
                    "Department Name" := DepartmentMasterRec."Department Name"
                else
                    "Department Name" := '';

            end;
        }
        field(7; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 28-04-2019';
            Editable = false;
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(10; "Rejected By"; Code[50])
        {
            Caption = 'Rejected By';
            DataClassification = CustomerContent;
        }
        field(11; "Approved On"; Date)
        {
            Caption = 'Approved On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Rejection Remark"; Text[500])
        {
            Caption = 'Rejection Remark';
            DataClassification = CustomerContent;
        }
        field(13; "Rejected On"; Date)
        {
            Caption = 'Rejected On';
            DataClassification = CustomerContent;
        }
        field(14; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "HOD Approved/Rejected Date"; Date)
        {
            Caption = 'HOD Approved/Rejected Date';
            DataClassification = CustomerContent;
        }
        field(16; "HOD Remark"; Text[500])
        {
            Caption = 'HOD Remark';
            DataClassification = CustomerContent;
        }
        field(17; "AD Approval"; Boolean)
        {
            Caption = 'AD Approval';
            DataClassification = CustomerContent;
        }
        field(18; "AD ID"; Code[50])
        {
            Caption = 'AD ID';
            DataClassification = CustomerContent;
        }
        field(19; "AD Approved/Rejected Date"; Date)
        {
            Caption = 'AD Approved/Rejected Date';
            DataClassification = CustomerContent;
        }
        field(20; "AD Remark"; Text[500])
        {
            Caption = 'AD Remark';
            DataClassification = CustomerContent;
        }
        field(21; "Form Type"; Code[20])
        {
            Caption = 'Form Type';
            DataClassification = CustomerContent;
        }
        field(22; "Withdrawal No."; Code[20])
        {
            Caption = 'Withdrawal No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Type of Withdrawal"; Option)
        {
            OptionCaption = ' ,Course-Withdrawal,College-Withdrawal';
            OptionMembers = " ","Course-Withdrawal","College-Withdrawal";
            ;
            Caption = 'Type of Withdrawal';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "Final Approval"; Boolean)
        {
            Caption = 'Final Approval';
            DataClassification = CustomerContent;
        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code" WHERE(Type = FILTER(Withdrawal));
            Editable = false;
        }
        field(26; "Reason for Leaving"; Text[500])
        {
            Caption = 'Reason for Leaving';
            DataClassification = CustomerContent;

        }
        field(27; Comments; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            Var
                RecWithdrawalApprovals: Record "Withdrawal Approvals";
            begin
                // CSPL-00307-T1-T1516-CR
                RecWithdrawalApprovals.Reset();
                RecWithdrawalApprovals.SetRange("Withdrawal No.", "Withdrawal No.");
                RecWithdrawalApprovals.SetFilter("Approved for Department", '<>%1', "Approved for Department");
                IF RecWithdrawalApprovals.FindSet() then
                    RecWithdrawalApprovals.ModifyAll(Comments, Rec.Comments);
            end;
        }

        field(50032; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50033; "Waiver Code"; Code[20])
        {
            Caption = 'Waiver Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Waiver)
                                                          , "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            begin
                if "Waiver Code" <> '' then
                    if "Waiver Calculation Allowed" = true then begin
                        if SourceScholarship.Get("Waiver Code") then
                            "Waiver Description" := SourceScholarship.Description
                        else
                            "Waiver Description" := '';
                    end else
                        Error('You donot have permission to enter Waiver Code');
            end;
        }
        field(50034; "Waiver Description"; Text[100])
        {
            Caption = 'Waiver Descripton';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50035; "Waiver Amount"; Decimal)
        {
            Caption = 'Waiver Amount';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                "Approved Amount" := "Waiver Amount";
            end;
        }
        field(50036; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
            trigger OnValidate()
            begin
                if "Waiver Calculation Allowed" = false then
                    Error('You donot have permission to modify the Waiver Amount');

                WithdrawalApprovalRec.Reset();
                WithdrawalApprovalRec.SetRange("Withdrawal No.", "Withdrawal No.");
                if WithdrawalApprovalRec.FindSet() then begin
                    repeat
                        WithdrawalApprovalRec."Waiver Code" := "Waiver Code";
                        WithdrawalApprovalRec."Waiver Description" := "Waiver Description";
                        WithdrawalApprovalRec."Waiver Amount" := "Waiver Amount";
                        WithdrawalApprovalRec."Approved Amount" := "Approved Amount";
                        WithdrawalApprovalRec.Modify();
                    until WithdrawalApprovalRec.next() = 0;
                end;
            end;
        }
        field(50037; "Withdrawal Date"; Date)
        {
            Caption = 'Withdrawal Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50038; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(50039; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(50040; "Approved In Days"; Integer)
        {
            Caption = 'Approved In Days';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50041; "Waiver Calculation Allowed"; Boolean)
        {
            Caption = 'Waiver Calculation Allowed';
            DataClassification = CustomerContent;
        }
        field(50042; "Waiver Calculated"; Boolean)
        {
            Caption = 'Waiver Calculated';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50043; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50044; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50045; "NSLDS Withdrawal Date"; Date)
        {
            Caption = 'NSLDS Withdrawal Dates';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                // if "NSLDS Withdrawal Date" < "Application Date" then
                //     Error('NSLDS Withdrawal Date must be greater then Application Date.');
                DepartmentMasterRec.Reset();
                DepartmentMasterRec.SetFilter("User Name", DepartmentMasterRec.GetUserGroup());//CSPL-00307-T1-T1516-CR
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType(Rec."Student No."));//CSPL-00307-T1-T1516-CR
                DepartmentMasterRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                IF DepartmentMasterRec.FindFirst() then begin
                    if not DepartmentMasterRec."Update NSLDS" then
                        Error('You do not have permission to update this field');
                    WithdrawalApprovalRec.Reset();
                    WithdrawalApprovalRec.SetRange("Withdrawal No.", "Withdrawal No.");
                    WithdrawalApprovalRec.SetFilter("Approved for Department", '<>%1', "Approved for Department");
                    if WithdrawalApprovalRec.FindSet() then begin
                        repeat
                            WithdrawalApprovalRec."NSLDS Withdrawal Date" := Rec."NSLDS Withdrawal Date";
                            WithdrawalApprovalRec.Modify();
                        until WithdrawalApprovalRec.next() = 0;
                    end;
                end else
                    Error('Only Approver can modify this field');
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."NSLDS Withdrawal Date" := "NSLDS Withdrawal Date";
                    StudentMaster.Modify();
                end;
            end;

        }
        field(50046; "Date Of Determination"; Date)
        {
            Caption = 'Date of Determination';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                // if "Date of Determination" < "Application Date" then
                //     Error('Date of Determination must be greater then Application Date.');
                DepartmentMasterRec.Reset();
                DepartmentMasterRec.SetFilter("User Name", DepartmentMasterRec.GetUserGroup());//CSPL-00307-T1-T1516-CR
                DepartmentMasterRec.SetRange("Department Code", Rec."Approved for Department");
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType(Rec."Student No."));//CSPL-00307-T1-T1516-CR
                DepartmentMasterRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                IF DepartmentMasterRec.FindFirst() then begin
                    if not DepartmentMasterRec."Update DOD" then
                        Error('You do not have permission to update this field');
                    WithdrawalApprovalRec.Reset();
                    WithdrawalApprovalRec.SetRange("Withdrawal No.", "Withdrawal No.");
                    WithdrawalApprovalRec.SetFilter("Approved for Department", '<>%1', "Approved for Department");
                    if WithdrawalApprovalRec.FindSet() then begin
                        repeat
                            WithdrawalApprovalRec."Date Of Determination" := Rec."Date Of Determination";
                            WithdrawalApprovalRec.Modify();
                        until WithdrawalApprovalRec.next() = 0;
                    end;
                end else
                    Error('Only Approver can modify this field');
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Date Of Determination" := "Date Of Determination";
                    StudentMaster.Modify();
                end;
            end;
        }
        field(50047; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                // if "Last Date Of Attendance" < "Application Date" then
                //     Error('Last Date Of Attendance must be greater then Application Date.');
                DepartmentMasterRec.Reset();
                DepartmentMasterRec.SetFilter("User Name", DepartmentMasterRec.GetUserGroup());//CSPL-00307-T1-T1516-CR
                DepartmentMasterRec.SetRange("Department Code", Rec."Approved for Department");
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType(Rec."Student No."));//CSPL-00307-T1-T1516-CR
                DepartmentMasterRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                IF DepartmentMasterRec.FindFirst() then begin
                    if not DepartmentMasterRec."Update LDA" then
                        Error('You do not have permission to update this field');
                    WithdrawalApprovalRec.Reset();
                    WithdrawalApprovalRec.SetRange("Withdrawal No.", "Withdrawal No.");
                    WithdrawalApprovalRec.SetFilter("Approved for Department", '<>%1', "Approved for Department");
                    if WithdrawalApprovalRec.FindSet() then begin
                        repeat
                            WithdrawalApprovalRec."Last Date Of Attendance" := Rec."Last Date Of Attendance";
                            WithdrawalApprovalRec.Modify();
                        until WithdrawalApprovalRec.next() = 0;
                    end;
                end else
                    Error('Only Approver can modify this field');
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster.LDA := "Last Date Of Attendance";
                    StudentMaster."Last Date Of Attendance" := "Last Date Of Attendance";
                    StudentMaster.Modify();
                end;
            end;
        }
        field(50048; "Semester Start Date"; Date)
        {
            Caption = 'Semester Start Dates';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50049; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50050; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(50051; Sequence; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Student No.", "Approved for Department", "Withdrawal No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    Begin
        Inserted := true;
    End;

    trigger OnModify()
    Begin
        If xRec.Updated = Updated then
            Updated := true;
    End;

    var
        SourceScholarship: Record "Source Scholarship-CS";
        DepartmentMasterRec: Record "Withdrawal Department";
        StudentMasterCS: Record "Student Master-CS";
        WithdrawalApprovalRec: Record "Withdrawal Approvals";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];

    // procedure WithdrawalRejectionMail(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     WithdrawalDepartmentRec: Record "Withdrawal Department";

    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];


    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     WithdrawalDepartmentRec.Reset();
    //     WithdrawalDepartmentRec.SetRange("Department Code", "Approved for Department");
    //     WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
    //     if WithdrawalDepartmentRec.FindFirst() then;

    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Withdrawal No.") + ' ' + 'Withdrawal Request Rejection');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that your request for Withdrawal has been' + ' ' + '"' + '' + Format(Status) + '' + '"'
    //                          + ' ' + 'by' + ' ' + WithdrawalDepartmentRec."Department Name" + ' ' + ' department due to' + ' ' + Format("Rejection Remark") + ' ' + '.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please contact the' + ' ' + WithdrawalDepartmentRec."Department Name" + ' ' + 'office' + ' ' + '(' + '' + Format(WithdrawalDepartmentRec."User E-Mail")
    //                         + ' ' + ',' + ' ' + 'or call' + '' + Format(WithdrawalDepartmentRec."User Phone No.")
    //                         + '' + ')' + ' ' + 'for further Clarifications.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(WithdrawalDepartmentRec."Department Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Withdrawal', 'MEA', SenderAddress, Format("Student Name"),
    //             "Student No.", Subject, BodyText, 'Withdrawal', 'Withdrawal', Format("Withdrawal No."), Format("Application Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure WithdrawalApprovalDepartmentMail(StudentNo: Code[20])
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
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Withdrawal No.") + ' ' + 'Withdrawal Request Approval');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This notification is to confirm that your Withdrawal Request for' + ' ' +
    //                          Format("Withdrawal No.") + ' ' + 'has been' + ' ' + Format(Status)
    //                          + ' ' + 'by' + ' ' + "Department Name" + ' ' +
    //                          '. You shall receive final confirmation from Registrar department after your request is approved by all.');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody("Department Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Withdrawal', 'MEA', SenderAddress, Format("Student Name"),
    //             "Student No.", Subject, BodyText, 'Withdrawal', 'Withdrawal', Format("Withdrawal No."), Format("Application Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure WithdrawalFinalApproverMail(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     DimensionValuesRec: Record "Dimension Value";

    //     SMTPMail: codeunit "Email Message";
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //     DimensionValuesRec.Reset();
    //     DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
    //     DimensionValuesRec.SetRange(Code, "Global Dimension 1 Code");
    //     if DimensionValuesRec.FindFirst() then;

    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Withdrawal No.") + ' ' + 'Withdrawal Request Approval');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This notification is to confirm that your Withdrawal Request for' + ' ' +
    //                          Format("Withdrawal No.") + ' ' + 'has been' + ' ' + Format(Status)
    //                          + ' ' + 'by all departments. Please process the request further.');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(DimensionValuesRec.Name);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //Mail_lCU.Send();
    // end;
    //     procedure WithdrawalRequestMailtoFinalApprover(StudentNo: Code[20]; Department: Code[20]; GD1: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";
    //         Studentmaster: Record "Student Master-CS";
    //         WithdrawalDepartmentRec: Record "Withdrawal Department";
    //         SMTPMail: codeunit "Email Message";
    // Mail_lCU : Codeunit Mail;
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text;
    //         CCRecipient: Text[100];
    //         CCRecipients: List of [Text];

    //     begin
    //         SmtpMailRec.Get();
    //         Studentmaster.GET(StudentNo);
    //         WithdrawalDepartmentRec.Reset();
    //         // WithdrawalDepartmentRec.SetRange("Department Code", Department);
    //         WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", GD1);
    //         WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec.GetDocumentType(StudentNo));//CSPL-00307-T1-T1516-CR
    //         WithdrawalDepartmentRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
    //         WithdrawalDepartmentRec.SetRange("Final Approval", true);
    //         if WithdrawalDepartmentRec.FindFirst() then;
    //         //CSPL-00307-T1-T1516-CR
    //         Recipient := WithdrawalDepartmentRec.GetUsersEmailid(WithdrawalDepartmentRec."Department Code");//CSPL-00307-T1-T1516-CR
    //         //CSPL-00307-T1-T1516-CR
    //         Recipients := Recipient.Split(';');
    //         IF WithdrawalDepartmentRec."CC E-Mail" <> '' then begin
    //             CCRecipient := WithdrawalDepartmentRec."CC E-Mail";
    //             CCRecipients := CCRecipient.Split(';');
    //         end;
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //         SenderName := 'MEA';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := (Format("Withdrawal No.") + ' ' + 'Withdrawal Request:' + ' ' + Format(StudentNo) + ',' + ' ' +
    //                     Format("Student Name") + ',' + ' ' + Format("Enrolment No.") + ',' + ' ' + Format(Semester));

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //         IF CCRecipients.Count > 0 then
    //             SmtpMail.AddCC(CCRecipients);
    //         SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartmentRec."Department Name") + ',');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('This notification is to confirm that Withdrawal Request for' + ' ' +
    //                             Format(StudentNo) + ',' + ' ' + Format("Student Name") + ',' + ' ' + Format("Enrolment No.")
    //                             + ',' + ' ' + Format(Semester) + ' ' + 'has been approved by all departments. Please process the request further.');

    //         // + ' ' + 'effective' + ' ' + Format("Application Date") + '.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Regards,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody("Department Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail ID.');
    //         SmtpMail.AppendtoBody('<br>');
    //         //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Withdrawal', 'MEA', SenderAddress, Format("Student Name"),
    //          "Student No.", Subject, BodyText, 'Withdrawal', 'Withdrawal', Format("Withdrawal No."), Format("Application Date", 0, 9),
    //          Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     end;

    //     procedure WithdrawalFinalMail(StudentNo: Code[20]; GD1: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";
    //         Studentmaster: Record "Student Master-CS";
    //         DimensionValuesRec: Record "Dimension Value";
    //         EducationSetup: Record "Education Setup-CS";
    //         SemesterMaster: Record "Semester Master-CS";
    //         SMTPMail: codeunit "Email Message";
    // Mail_lCU : Codeunit Mail;
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text;
    //     begin
    //         EducationSetup.Reset();
    //         EducationSetup.SetRange("Global Dimension 1 Code", '9000');
    //         If EducationSetup.FindFirst() then;

    //         SmtpMailRec.Get();
    //         Studentmaster.GET(StudentNo);

    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //         DimensionValuesRec.Reset();
    //         DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
    //         DimensionValuesRec.SetRange(Code, "Global Dimension 1 Code");
    //         if DimensionValuesRec.FindFirst() then;


    //         SemesterMaster.Reset();
    //         SemesterMaster.SetRange(Code, Studentmaster.Semester);
    //         If SemesterMaster.FindFirst() then
    //             IF SemesterMaster.Sequence <= 5 then
    //                 Recipient := EducationSetup."Withdrawal BSIC Email ID"
    //             Else
    //                 Recipient := EducationSetup."Withdrawal CLN Email ID";

    //         Recipients := Recipient.Split(';');

    //         If (Recipients.Count > 0) then begin
    //             SenderName := 'MEA';
    //             SenderAddress := SmtpMailRec."Email Address";
    //             Subject := ('Withdrawal Request Processed:' + ' ' + Format("Withdrawal No.") + ' ' +
    //                          Format(StudentNo) + ',' + ' ' + Format("Student Name") + ',' + ' ' +
    //                          Format("Enrolment No.") + ',' + ' ' + Format(Semester));

    //             SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //             SmtpMail.AppendtoBody('Dear All,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('Please be informed that' + ' ' + Format(StudentNo) + ',' + ' ' +
    //                                  Format("Student Name") + ',' + ' ' + Format("Enrolment No.") + ',' + ' ' +
    //                                  Format(Semester) + ' ' + 'has officially withdrawn from the' + ' ' +
    //                                  DimensionValuesRec.Name + ',' + ' ' + 'effective' + ' ' + Format("Application Date")
    //                                  + ' ' + 'due to ' + "Reason for Leaving" + '. Student Last Date of Attendance is ' + Format(Rec."Last Date Of Attendance") + '. The Date of Determination is recorded as ' + Format(Rec."Date Of Determination") + '.'); //CS_SG 20230504 //+ '( Last day of attendance).'
    //             // SmtpMail.AppendtoBody('<br><br>'); //CS_SG
    //             // SmtpMail.AppendtoBody("Reason for Leaving"); CS_SG
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('Regards,');
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody("Department Name");
    //             SmtpMail.AppendtoBody('<br><br>');
    //             SmtpMail.AppendtoBody('<br>');
    //             SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
    //             SmtpMail.AppendtoBody('<br>');
    //             BodyText := SmtpMail.GetBody();
    //             //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //             Mail_lCU.Send();
    //             WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Withdrawal', 'MEA', SenderAddress, Format("Student Name"),
    //             "Student No.", Subject, BodyText, 'Withdrawal', 'Withdrawal', Format("Withdrawal No."), Format("Application Date", 0, 9),
    //             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //         end;

    //     end;

    //     //CSPL-00307-T1-T1516-CR New Mail Copy from Leave Process
    //     procedure WithdrawalSeqenceApproverMail(StudentNo: Code[20])//GMCS//28//11//22//
    //     var
    //         SmtpMailRec: Record "Email Account";
    //         Studentmaster: Record "Student Master-CS";
    //         DimensionValuesRec: Record "Dimension Value";
    //         WithdrawalDepartmentRec: Record "Withdrawal Department";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //         BodyText: text;
    //         SMTPMail: codeunit "Email Message";
    // Mail_lCU : Codeunit Mail;
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         CCRecipient: Text[100];
    //         CCRecipients: List of [Text];
    //         WithdrawalDepartment1: Record "Withdrawal Department";
    //     begin
    //         SmtpMailRec.Get();
    //         Studentmaster.GET(StudentNo);
    //         // Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //         DimensionValuesRec.Reset();
    //         DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
    //         DimensionValuesRec.SetRange(Code, "Global Dimension 1 Code");
    //         if DimensionValuesRec.FindFirst() then;

    //         WithdrawalDepartmentRec.Reset();
    //         WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec.GetDocumentType(StudentNo));
    //         WithdrawalDepartmentRec.SetRange("Department Code", Rec."Approved for Department");//GMCS
    //         WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");//GMCS
    //         WithdrawalDepartmentRec.SetRange("Final Approval", false);
    //         WithdrawalDepartmentRec.Setrange(Sequence, Rec.Sequence);
    //         if WithdrawalDepartmentRec.FindFirst() then begin
    //             WithdrawalDepartment1.Reset();
    //             WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartmentRec."Document Type");//GMCS
    //             WithdrawalDepartment1.SetRange("Global Dimension 1 Code", WithdrawalDepartmentRec."Global Dimension 1 Code");//GMCS
    //             WithdrawalDepartment1.SetRange("Final Approval", false);
    //             WithdrawalDepartment1.SetRange(Sequence, WithdrawalDepartmentRec.Sequence + 1);
    //             IF WithdrawalDepartment1.FindFirst() then begin

    //                 Recipient := WithdrawalDepartment1.GetUsersEmailid(WithdrawalDepartment1."Department Code"); //CSPL-00307-T1-T1516-CR
    //                 Recipients := Recipient.Split(';');
    //                 // CCRecipient := WithdrawalDepartment1."CC E-Mail";
    //                 // CCRecipients := CCRecipient.Split(';');

    //                 SenderName := 'MEA';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := (Format("Withdrawal No.") + ' ' + 'Withdrawal Request Approval');

    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 // if CCRecipient <> '' then
    //                 //     SmtpMail.AddCC(CCRecipients);
    //                 SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartment1."Department Name") + ',');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('This notification is to confirm that Withdrawal Request for' + ' ' +
    //                                     Format(StudentNo) + ',' + ' ' + Format("Student Name") + ',' + ' ' + Format("Enrolment No.")
    //                                     + ',' + ' ' + Format(Semester) + ' ' + 'has been approved by' + ' ' + (Format(WithdrawalDepartmentRec."Department Name"))
    //                                     + '.' + ' ' + 'Please process the request further.');
    //                 // + ' ' + 'effective' + ' ' + Format("Application Date") + '.');        // + ' ' + 'effective' + ' ' + Format("Application Date") + '.');
    //                 // + ' ' + 'effective' + ' ' + Format("Application Date") + '.');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('Regards,');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody(Format(WithdrawalDepartmentRec."Department Name"));
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('<br>');
    //                 SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail ID.');
    //                 ////SmtpMail.AppendtoBodyTHIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARDIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //                 //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //                 BodyText := SmtpMail.GetBody();
    //                 Mail_lCU.Send();
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Withdrawal', 'MEA', SenderAddress, Format("Student Name"),
    //                                                                             "Student No.", Subject, BodyText, 'Withdrawal', 'Withdrawal', Format("Withdrawal No."), Format("Application Date", 0, 9),
    //                                                                             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             end;
    //         End;
    //     end; //END//GMCS//28//11//22//


}
