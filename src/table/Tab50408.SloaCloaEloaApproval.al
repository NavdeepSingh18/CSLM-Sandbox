table 50408 "Leaves Approvals"
{
    Caption = 'Pending Leaves Approval List';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Student No.", "Student Name";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Student No."; Code[20])
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
        field(5; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(6; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Open,Pending for Approval,Approved,Cancelled,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Cancelled,Rejected;
            Editable = False;
        }

        field(7; "Approved for Department"; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                DepartmentMasterRec.Reset();
                DepartmentMasterRec.SetRange("Department Code", "Approved for Department");
                if DepartmentMasterRec.FindFirst() then
                    "Department Name" := DepartmentMasterRec."Department Name"
                else
                    "Department Name" := '';
            end;
        }
        field(8; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(9; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 28-04-2019';
            Editable = false;
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(11; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Approved On"; Date)
        {
            Caption = 'Approved On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Rejected By"; Code[50])
        {
            Caption = 'Rejected By';
            DataClassification = CustomerContent;
        }
        field(14; "Rejected On"; Date)
        {
            Caption = 'Rejected On';
            DataClassification = CustomerContent;
        }

        field(15; "Rejection Remark"; Text[500])
        {
            Caption = 'Rejection Remarks';
            DataClassification = CustomerContent;
        }

        field(16; "Type of Leaves"; Option)
        {
            OptionCaption = 'ELOA,SLOA,CLOA';
            OptionMembers = ELOA,SLOA,CLOA;
            Caption = 'Type of Leaves';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Final Approval"; Boolean)
        {
            Caption = 'Final Approval';
            DataClassification = CustomerContent;
        }
        field(18; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code" WHERE(Type = FILTER(Withdrawal));
            Editable = false;
        }
        field(19; "Reason for Leave"; Text[2048])
        {
            Caption = 'Reason for Description';
            DataClassification = CustomerContent;
            Editable = false;

        }

        field(20; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(22; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(23; "Approved In Days"; Integer)
        {
            Caption = 'Approved In Days';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(25; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(26; "Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
            DataClassification = CustomerContent;
        }
        field(27; "Cancelled On"; Date)
        {
            Caption = 'Cancelled On';
            DataClassification = CustomerContent;
        }

        field(28; "Cancelled Remarks"; Text[500])
        {
            Caption = 'Cancelled Remarks';
            DataClassification = CustomerContent;
        }
        field(29; "Cancelled In Days"; Integer)
        {
            Caption = 'Cancelled In Days';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Rejected In Days"; Integer)
        {
            Caption = 'Rejected In Days';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(32; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(33; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(34; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(35; "sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(36; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(60; "Date Of Determination"; Date)
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
                DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
                DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                    DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA)
                else
                    if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                        DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA)
                    else
                        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
                IF DepartmentMasterRec.FindFirst() then begin
                    if not DepartmentMasterRec."Update DOD" then
                        Error('You do not have permission to update this field');
                    RecleaveApprovals.Reset();
                    RecleaveApprovals.SetRange("Application No.", "Application No.");
                    RecleaveApprovals.SetFilter("Line No.", '<>%1', "Line No.");
                    IF RecleaveApprovals.FindFirst() then
                        RecleaveApprovals.ModifyAll("Date Of Determination", Rec."Date Of Determination");
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
        field(61; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = CustomerContent;
            //Editable = false;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                DateRec: Record Date;
            begin
                // if "Last Date Of Attendance" < "Application Date" then
                //     Error('Last Date Of Attendance must be greater then Application Date.');

                IF "Type of Leaves" = "Type of Leaves"::CLOA then begin
                    If "Last Date Of Attendance" <> 0D then begin
                        DateRec.Reset();
                        DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
                        DateRec.SetRange("Period Start", "Last Date Of Attendance");
                        If DateRec.FindFirst() then
                            If DateRec."Period Name" <> 'Friday' then
                                Error('Selected date is incorrect.(LDA should always be a Friday)');

                    end;
                end;

                DepartmentMasterRec.Reset();
                DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
                DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                    DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA)
                else
                    if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                        DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA)
                    else
                        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
                IF DepartmentMasterRec.FindFirst() then begin
                    if not DepartmentMasterRec."Update LDA" then
                        Error('You do not have permission to update this field');
                    RecleaveApprovals.Reset();
                    RecleaveApprovals.SetRange("Application No.", "Application No.");
                    RecleaveApprovals.SetFilter("Line No.", '<>%1', "Line No.");
                    IF RecleaveApprovals.FindFirst() then
                        RecleaveApprovals.ModifyAll("Last Date Of Attendance", Rec."Last Date Of Attendance");
                end else
                    Error('Only Approver can modify this field');

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster.LDA := "Last Date Of Attendance";
                    StudentMaster.Modify();
                end;
            end;


        }

        Field(62; "NSLDS Withdrawal Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                // if "NSLDS Withdrawal Date" < "Application Date" then
                //     Error('NSLDS Withdrawal Date must be greater then Application Date.');
                DepartmentMasterRec.Reset();
                DepartmentMasterRec.Setfilter("User Name", DepartmentMasterRec.GetUserGroup());
                DepartmentMasterRec.SetRange("Department Name", Rec."Department Name");
                DepartmentMasterRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
                    DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::SLOA)
                else
                    if Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
                        DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::ELOA)
                    else
                        if Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
                            DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec."Document Type"::CLOA);
                IF DepartmentMasterRec.FindFirst() then begin
                    if not DepartmentMasterRec."Update NSLDS" then
                        Error('You do not have permission to update this field');
                    RecleaveApprovals.Reset();
                    RecleaveApprovals.SetRange("Application No.", "Application No.");
                    RecleaveApprovals.SetFilter("Line No.", '<>%1', "Line No.");
                    IF RecleaveApprovals.FindFirst() then
                        RecleaveApprovals.ModifyAll("NSLDS Withdrawal Date", Rec."NSLDS Withdrawal Date");
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
        field(63; Comments; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //CSPL-00307-T1-T1516-CR
                RecleaveApprovals.Reset();
                RecleaveApprovals.SetRange("Application No.", "Application No.");
                RecleaveApprovals.SetFilter("Line No.", '<>%1', "Line No.");
                IF RecleaveApprovals.FindSet() then
                    RecleaveApprovals.ModifyAll(Comments, Rec.Comments);
            end;
        }

    }
    keys
    {
        key(Key1; "Application No.", "Line No.")
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
        DepartmentMasterRec: Record "Withdrawal Department";
        StudentMasterCS: Record "Student Master-CS";
        RecleaveApprovals: Record "Leaves Approvals";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];

        // procedure LeaveRejectionMail(StudentNo: Code[20])
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
        //     Subject := (Format("Application No.") + ' ' + Format("Type of Leaves") + ' ' + 'Leave Request Rejection');

        //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name");
        //     SmtpMail.AppendtoBody('<br><br>');
        //     SmtpMail.AppendtoBody('Please be advised that your request for leave has been' + ' ' + '"' + '' + Format(Status) + '' + '"'
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
        //     //Mail_lCU.Send();

        //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave of Absence', 'MEA', SenderAddress, Format("Student Name"),
        //     "Student No.", Subject, BodyText, 'Leave of Absence', 'Leave', Format("Application No."), Format("Application Date"),
        //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
        // end;

        // procedure LeaveHoldMail(StudentNo: Code[20])
        // var
        //     SmtpMailRec: Record "Email Account";
        //     Studentmaster: Record "Student Master-CS";
        //     WithdrawalDepartmentRec: Record "Withdrawal Department";
        //     Departments: Record Department;
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
        //     Departments.reset();
        //     Departments.Get("Approved for Department");

        //     Recipient := Studentmaster."E-Mail Address";
        //     Recipients := Recipient.Split(';');
        //     SenderName := 'MEA';
        //     SenderAddress := SmtpMailRec."Email Address";
        //     Subject := (Format("Application No.") + ' ' + Format("Type of Leaves") + ' ' + 'Leave Request Hold');

        //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name");
        //     SmtpMail.AppendtoBody('<br><br>');
        //     SmtpMail.AppendtoBody('Please be advised that your request for leave has been' + ' ' + '"' + '' + Format(Status) + '' + '"'
        //                          + ' ' + 'by' + ' ' + WithdrawalDepartmentRec."Department Name" + ' ' + ' department due to' + ' ' + Format("Rejection Remark") + ' ' + '.');
        //     SmtpMail.AppendtoBody('<br><br>');
        //     SmtpMail.AppendtoBody('Please contact the' + ' ' + WithdrawalDepartmentRec."Department Name" + ' ' + 'office' + ' ' + '(' + '' + Format(Departments."Department Email")
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
        //     //Mail_lCU.Send();

        //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave of Absence', 'MEA', SenderAddress, Format("Student Name"),
        //     "Student No.", Subject, BodyText, 'Leave of Absence', 'Leave', Format("Application No."), Format("Application Date"),
        //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
        // end;

        // procedure LeaveApprovalDepartmentMail(StudentNo: Code[20])
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
        //     Subject := (Format("Application No.") + ' ' + FORMAT("Type of Leaves") + ' ' + 'Leave Request Approval');

        //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name");
        //     SmtpMail.AppendtoBody('<br><br>');
        //     SmtpMail.AppendtoBody('This notification is to confirm that your Leave request for' + ' ' +
        //                          Format("Application No.") + ' ' + 'has been' + ' ' + Format(Status)
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
        //     //Mail_lCU.Send();

        //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave of Absence', 'MEA', SenderAddress, Format("Student Name"),
        //     "Student No.", Subject, BodyText, 'Leave of Absence', 'Leave', Format("Application No."), Format("Application Date", 0, 9),
        //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
        // end;


        // procedure LeaveFinalApproverMail(StudentNo: Code[20])
        // var
        //     SmtpMailRec: Record "Email Account";
        //     Studentmaster: Record "Student Master-CS";
        //     DimensionValuesRec: Record "Dimension Value";
        //     WithdrawalDepartmentRec: Record "Withdrawal Department";
        //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        //     BodyText: text[2048];
        //     SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //     DimensionValuesRec.Reset();
    //     DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
    //     DimensionValuesRec.SetRange(Code, "Global Dimension 1 Code");
    //     if DimensionValuesRec.FindFirst() then;

    //     WithdrawalDepartmentRec.Reset();
    //     // WithdrawalDepartmentRec.SetRange("Department Code", Department);
    //     WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
    //     IF "Type of Leaves" = "Type of Leaves"::SLOA then
    //         WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::SLOA);
    //     IF "Type of Leaves" = "Type of Leaves"::ELOA then
    //         WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::ELOA);
    //     IF "Type of Leaves" = "Type of Leaves"::CLOA then
    //         WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::CLOA);

    //     WithdrawalDepartmentRec.SetRange("Final Approval", true);
    //     if WithdrawalDepartmentRec.FindFirst() then;
    //     Recipient := WithdrawalDepartmentRec."User E-Mail";
    //     Recipients := Recipient.Split(';');
    //     CCRecipient := WithdrawalDepartmentRec."CC E-Mail";
    //     CCRecipients := CCRecipient.Split(';');

    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + 'Leave Request Approval');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     if CCRecipient <> '' then
    //         SmtpMail.AddCC(CCRecipients);
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartmentRec."Department Name") + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This notification is to confirm that Leave Request for' + ' ' +
    //                         Format(StudentNo) + ',' + ' ' + Format("Student Name") + ',' + ' ' + Format("Enrolment No.")
    //                         + ',' + ' ' + Format(Semester) + ' ' + 'has been approved by' + ' ' + (Format(WithdrawalDepartmentRec."Department Name"))
    //                                 + '.' + ' ' + 'Please process the request further.');

    //     // + ' ' + 'effective' + ' ' + Format("Application Date") + '.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody("Department Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail ID.');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave Request Approval Department', 'MEA', SenderAddress, Format("Student Name"),
    //                                                                 "Student No.", Subject, BodyText, 'Leave Request Approval Department', 'Leave', Format("Application No."), Format("Application Date", 0, 9),
    //                                                                 Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;


    //     procedure LeaveSeqApproverMail(StudentNo: Code[20])////GAURAV//28.11.22///
    //     var
    //         SmtpMailRec: Record "Email Account";
    //         Studentmaster: Record "Student Master-CS";
    //         DimensionValuesRec: Record "Dimension Value";
    //         WithdrawalDepartmentRec: Record "Withdrawal Department";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //         BodyText: text[2048];
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
    //         WithdrawalDepartmentRec.SetRange("Department Code", Rec."Approved for Department");//GAURAV
    //         WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");//GAURAV
    //         IF "Type of Leaves" = "Type of Leaves"::SLOA then
    //             WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::SLOA);
    //         IF "Type of Leaves" = "Type of Leaves"::ELOA then
    //             WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::ELOA);
    //         IF "Type of Leaves" = "Type of Leaves"::CLOA then
    //             WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::CLOA);
    //         WithdrawalDepartmentRec.SetRange("Final Approval", false);
    //         WithdrawalDepartmentRec.Setrange(Sequence, Rec.Sequence);
    //         if WithdrawalDepartmentRec.FindFirst() then begin
    //             WithdrawalDepartment1.Reset();
    //             WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartmentRec."Document Type");//GAURAV
    //             WithdrawalDepartment1.SetRange("Global Dimension 1 Code", WithdrawalDepartmentRec."Global Dimension 1 Code");//GAURAV
    //             WithdrawalDepartment1.SetRange(Sequence, WithdrawalDepartmentRec.Sequence + 1);
    //             IF WithdrawalDepartment1.FindFirst() then begin

    //                 Recipient := WithdrawalDepartment1.GetUsersEmailid(WithdrawalDepartment1."Department Code"); //CSPL-00307-T1-T1516-CR
    //                 Recipients := Recipient.Split(';');
    //                 // CCRecipient := WithdrawalDepartment1."CC E-Mail";
    //                 // CCRecipients := CCRecipient.Split(';');

    //                 SenderName := 'MEA';
    //                 SenderAddress := SmtpMailRec."Email Address";
    //                 Subject := (Format("Application No.") + ' ' + 'Leave Request Approval');

    //                 SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //                 // if CCRecipient <> '' then
    //                 //     SmtpMail.AddCC(CCRecipients);
    //                 SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartment1."Department Name") + ',');
    //                 SmtpMail.AppendtoBody('<br><br>');
    //                 SmtpMail.AppendtoBody('This notification is to confirm that Leave Request for' + ' ' +
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
    //                 WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave Request Approval Department', 'MEA', SenderAddress, Format("Student Name"),
    //                                                                             "Student No.", Subject, BodyText, 'Leave Request Approval Department', 'Leave', Format("Application No."), Format("Application Date", 0, 9),
    //                                                                             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //             end;
    //         End;
    //     end; //END/////GAURAV//28.11.22///


    //     procedure WithdrawalFinalMail(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";
    //         Studentmaster: Record "Student Master-CS";
    //         DimensionValuesRec: Record "Dimension Value";

    //         SMTPMail: codeunit "Email Message";
    // Mail_lCU : Codeunit Mail;
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];

    //     begin
    //         SmtpMailRec.Get();
    //         Studentmaster.GET(StudentNo);
    //         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //         DimensionValuesRec.Reset();
    //         DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
    //         DimensionValuesRec.SetRange(Code, "Global Dimension 1 Code");
    //         if DimensionValuesRec.FindFirst() then;

    //         Recipient := Studentmaster."E-Mail Address";
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'MEA';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := ('Leave Request Processed:' + ' ' + Format("Application No.") + ' ' +
    //                      Format(StudentNo) + ',' + ' ' + Format("Student Name") + ',' + ' ' +
    //                      Format("Enrolment No.") + ',' + ' ' + Format(Semester));

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Please be informed that' + ' ' + Format(StudentNo) + ',' + ' ' +
    //                              Format("Student Name") + ',' + ' ' + Format("Enrolment No.") + ',' + ' ' +
    //                              Format(Semester) + ' ' + 'has officially leave from the' + ' ' +
    //                              DimensionValuesRec.Name + ',' + ' ' + 'effective' + ' ' + Format("Application Date")
    //                              + ' ' + '( Last day of attendance.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody("Reason for Leave");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Regards,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody("Department Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
    //         SmtpMail.AppendtoBody('<br>');
    //         //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //         BodyText := SmtpMail.GetBody();
    //         //Mail_lCU.Send();
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave Request Process', 'MEA', SenderAddress, Format("Student Name"),
    //                                                                     "Student No.", Subject, BodyText, 'Leave Request Process', 'Leave', Format("Application No."), Format("Application Date", 0, 9),
    //                                                                     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    //CSPL-00307-HelloSign_BUG
    procedure CheckHelloSignConfirmed(ApplicationNo: Code[20]): Boolean;
    var
        StudentLeave: Record "Student Leave of Absence";
    begin
        StudentLeave.Reset();
        IF StudentLeave.Get(ApplicationNo) Then
            exit(StudentLeave.HelloSign_Confirmed);
    end;
    //CSPL-00307-HelloSign_BUG

}
