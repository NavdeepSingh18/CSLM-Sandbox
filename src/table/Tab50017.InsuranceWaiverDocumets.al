table 50017 "Student Rank-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    30-04-2019    OnInsert                    Assign Value in Fields

    //Version V.002 CS
    //CSPL-00307 - Using on Insurance Waiver Documents application  
    //Code related to Insurence Module would have "//CSPL-00307 - Insurance Waiver" Tag in all SLcM System

    Caption = 'Insurance Waiver Documents';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Average"; Decimal)
        {
            Caption = 'Average';
            DataClassification = CustomerContent;
        }
        field(3; Rank; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
        }
        field(4; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(5; Carrier; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Member ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Group Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Insurance Valid From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Insurance Valid To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                IF StudentMasterCS.Get(Rec."Student No.") then begin
                    "Student No." := StudentMasterCS."No.";
                    "Student Name" := StudentMasterCS."Student Name";
                    Course := StudentMasterCS."Course Code";
                    Semester := StudentMasterCS.Semester;
                    Section := StudentMasterCS.Section;
                    "Academic Year" := StudentMasterCS."Academic Year";
                    Term := StudentMasterCS.Term;
                    "Enrolment No." := StudentMasterCS."Enrollment No.";
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                    "Student ID" := StudentMasterCS."Original Student No.";
                end else begin
                    "Student No." := '';
                    "Student Name" := '';
                    Course := '';
                    Semester := '';
                    Section := '';
                    "Academic Year" := '';
                    Term := Term::FALL;
                    "Enrolment No." := '';
                    "Student ID" := '';
                end;
            end;

            trigger OnLookup()
            var

            begin
                EducationSetup.Reset();
                IF EducationSetup.FindFirst() THEN;
                StudentMasterCS.SETRANGE("Academic Year", EducationSetup."Academic Year");
                IF StudentMasterCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN BEGIN
                        "Student No." := StudentMasterCS."No.";
                        "Student Name" := StudentMasterCS."Student Name";
                        Course := StudentMasterCS."Course Code";
                        Semester := StudentMasterCS.Semester;
                        Section := StudentMasterCS.Section;
                        "Academic Year" := StudentMasterCS."Academic Year";
                        Term := StudentMasterCS.Term;
                        "Enrolment No." := StudentMasterCS."Enrollment No.";
                        "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                        "Student ID" := StudentMasterCS."Original Student No.";
                    END;
            end;
        }
        field(11; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(12; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";
        }
        field(13; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(14; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(15; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(16; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
            Trigger OnValidate()
            begin

            end;
        }
        field(17; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrolment No.';
            Editable = false;

        }
        field(18; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pending,Approved,Rejected';
            OptionMembers = " ","Pending","Approved","Rejected";
            Trigger OnValidate()
            begin

            end;
        }
        field(19; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Trigger OnValidate()
            begin

            end;
        }
        field(20; "Policy No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Student ID"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var

            begin
                EducationSetup.Reset();
                IF EducationSetup.FindFirst() THEN;
                StudentMasterCS.SETRANGE("Academic Year", EducationSetup."Academic Year");
                IF StudentMasterCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN BEGIN
                        "Student No." := StudentMasterCS."No.";
                        "Student Name" := StudentMasterCS."Student Name";
                        Course := StudentMasterCS."Course Code";
                        Semester := StudentMasterCS.Semester;
                        Section := StudentMasterCS.Section;
                        "Academic Year" := StudentMasterCS."Academic Year";
                        Term := StudentMasterCS.Term;
                        "Enrolment No." := StudentMasterCS."Enrollment No.";
                        "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                        "Student ID" := StudentMasterCS."Original Student No.";
                    END;
            end;
        }
        field(23; "Approved On"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(24; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(26; "Rejected On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Reject Reason"; Text[100])
        {
            DataClassification = CustomerContent;
        }


        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Entry From OLR Page"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Entry From Dashboard"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 03-05-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Average")
        {
        }
        key(Key3; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        If "No." = '' then begin
            EducationSetup.Reset();
            EducationSetup.SetFilter("Rank Generation No.", '<>%1', '');
            if EducationSetup.FindFirst() then
                EducationSetup.TESTFIELD(EducationSetup."Rank Generation No.");

            "No." := "No.seriesManagement".GetNextNo(EducationSetup."Rank Generation No.", 0D, TRUE);
        end;
        "User ID" := FORMAT(UserId());
        "Created On" := Today();
    end;

    var
        EducationSetup: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        "No.seriesManagement": Codeunit "NoSeriesManagement";


    Procedure OnAssistTrigger()
    Begin
        IF "No." = '' then begin
            EducationSetup.Reset();
            EducationSetup.SetFilter("Rank Generation No.", '<>%1', '');
            if EducationSetup.FindFirst() then
                EducationSetup.TESTFIELD(EducationSetup."Rank Generation No.");

            "No." := "No.seriesManagement".GetNextNo(EducationSetup."Rank Generation No.", 0D, TRUE);
        end;
    End;

    // Procedure ApprovalMail()
    // Var
    //     SMTPMailSetup: Record "Email Account";
    //     StudentMaster: REcord "Student Master-CS";
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text[2048];
    // begin
    //     Clear(SMTPMailSetup);
    //     Studentmaster.Reset();
    //     if Studentmaster.GET("Student No.") then;
    //     // UserSetup.reset();
    //     // UserSetup.Get(UserId);
    //     Recipient := StudentMaster."E-Mail Address";
    //     // Recipient := UserSetup."E-Mail";
    //     Recipients := Recipient.Split(';');
    //     SMTPMailSetup.GET();
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Insurance Waiver Documentation Approval';
    //     CLEAR(SMTPMail);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     SMTPMail.AppendtoBody('Dear ' + StudentMaster."First Name" + ' ' + StudentMaster."Last Name");
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Your Insurance waiver has been granted by University Park Health Centre.');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Thank you,');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('UPHC Verification Team');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');

    //     BodyText := SMTPMail.GetBody();
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Insurance Waiver Document Approval', 'MEA', SenderAddress, Studentmaster."Student Name",
    //         Format(Studentmaster."No."), Subject, BodyText, 'Insurance Waiver Document Approval', 'Insurance Waiver Document Approval', Format(Rec."No."), Format(WorkDate(), 0, 9),
    //         Recipient, 1, Studentmaster."Mobile Number", '', 1);

    // End;


    // Procedure RejectMail()
    // Var
    //     SMTPMailSetup: Record "Email Account";
    //     StudentMaster: REcord "Student Master-CS";
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text[2048];
    // begin
    //     Clear(SMTPMailSetup);
    //     Studentmaster.Reset();
    //     if Studentmaster.GET("Student No.") then;
    //     // UserSetup.reset();
    //     // UserSetup.Get(UserId);
    //     Recipient := StudentMaster."E-Mail Address";
    //     // Recipient := UserSetup."E-Mail";
    //     Recipients := Recipient.Split(';');
    //     SMTPMailSetup.GET();
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Insurance Waiver Documentation Rejection';
    //     CLEAR(SMTPMail);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     SMTPMail.AppendtoBody('Dear ' + StudentMaster."First Name" + ' ' + StudentMaster."Last Name");
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Your Insurance waiver has been rejected by University Park Health Centre due to ' + Rec."Reject Reason");
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('To submit new documents or make adjustments to your previous submission you will be required to reapply.');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Log into the SLcM System to do so or for more details please send an email to insurancewaiver@auamed.org.');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('Thank you,');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('UPHC Verification Team');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('<br><br>');
    //     SMTPMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');

    //     BodyText := SMTPMail.GetBody();
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Insurance Waiver Document Rejection', 'MEA', SenderAddress, Studentmaster."Student Name",
    //         Format(Studentmaster."No."), Subject, BodyText, 'Insurance Waiver Document Rejection', 'Insurance Waiver Document Rejection', Format(Rec."No."), Format(WorkDate(), 0, 9),
    //         Recipient, 1, Studentmaster."Mobile Number", '', 1);

    // End;

}

