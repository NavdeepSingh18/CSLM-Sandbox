table 50492 "Medical Scholar Program"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = CustomerContent;
            Trigger OnValidate()
            Begin
                if "Application No" <> xRec."Application No" then begin
                    EducationSetup.Reset();
                    IF EducationSetup.FindFirst() then;
                    NoSeriesMgt.TestManual(EducationSetup."Medical Nos.");
                end;
            End;

        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            Var
                StudentMasterCS: Record "Student Master-CS";
                RecOLRUpdateLine: Record "OLR Update Line";
            begin
                IF "Student No." <> '' then begin
                    StudentMasterCS.Reset();
                    StudentMasterCS.SetRange("No.", "Student No.");
                    If StudentMasterCS.FindFirst() then begin
                        "Student Name" := StudentMasterCS."Student Name";
                        "Academic Year" := StudentMasterCS."Academic Year";
                        Term := StudentMasterCS.Term;
                        "Skype Id" := StudentMasterCS.Skype;
                        "AUA E-mail" := StudentMasterCS."E-Mail Address";
                        Gender := StudentMasterCS.Gender;
                        RecOLRUpdateLine.Reset();
                        RecOLRUpdateLine.SetRange("Student No.", "Student No.");
                        RecOLRUpdateLine.SetRange("OLR Academic Year", StudentMasterCS."Academic Year");
                        RecOLRUpdateLine.SetRange("OLR Term", StudentMasterCS.Term);
                        RecOLRUpdateLine.SetRange(Confirmed, true);
                        IF RecOLRUpdateLine.FindFirst() then
                            Semester := RecOLRUpdateLine."OLR Semester"
                        else
                            Semester := StudentMasterCS.Semester;
                    end;
                end Else begin
                    "Student Name" := '';
                    "Academic Year" := '';
                    Semester := '';
                    "Skype Id" := '';
                    "AUA E-mail" := '';
                end;
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(7; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(8; "Skype Id"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; "First Time Applicant"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Previously Medical Scholar"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(11; "Previous Role 1"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",TA,Tutor,"Not Applicable";
        }
        field(12; "Previous Role 2"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",TA,Tutor,"Not Applicable";
        }
        field(13; "Applying New Role"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Maintain Same Role"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Role Applying"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",TA,Tutor;
        }
        field(16; "Course Name"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Cumulative GPA above 3"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Yes,No,UnSure;
            OptionCaption = ' ,Yes,No,Unsure';
        }

        field(18; "Academic Prob for upcoming Sem"; Option)
        {
            Caption = 'Academic probation for upcoming semester';
            DataClassification = CustomerContent;
            OptionMembers = " ",Yes,No,UnSure;
            OptionCaption = ' ,Yes,No,Unsure';
        }

        field(19; "Participated in Reboot program"; Boolean)
        {
            Caption = 'Participated in Reboot program prior to the previous Semester';
            DataClassification = CustomerContent;
        }
        field(20; "1st Choice for Position"; Option)
        {
            Caption = '1st Choice for Position';
            DataClassification = CustomerContent;
            OptionMembers = " ",Tutor,"Teaching Assistant-Small Group","Teaching Assistant-Clinical Skills Lab","N/A";
            OptionCaption = ' ,Tutor,Teaching Assistant,Teaching Assistant-Clinical Skills Lab,N/A';
        }
        field(21; "2nd Choice for Position"; Option)
        {
            Caption = '2nd Choice for Position';
            DataClassification = CustomerContent;
            OptionMembers = " ",Tutor,"Teaching Assistant-Small Group","Teaching Assistant-Clinical Skills Lab","N/A";
            OptionCaption = ' ,Tutor,Teaching Assistant,Teaching Assistant-Clinical Skills Lab,N/A';
        }
        field(22; "3rd Choice for Position"; Option)
        {
            Caption = '3rd Choice for Position';
            DataClassification = CustomerContent;
            OptionMembers = " ",Tutor,"Teaching Assistant-Small Group","Teaching Assistant-Clinical Skills Lab","N/A";
            OptionCaption = ' ,Tutor,Teaching Assistant,Teaching Assistant-Clinical Skills Lab,N/A';
        }
        field(23; "4th Choice for Position"; Option)
        {
            Caption = '4th Choice for Position';
            DataClassification = CustomerContent;
            OptionMembers = " ",Tutor,"Teaching Assistant-Small Group","Teaching Assistant-Clinical Skills Lab","N/A";
            OptionCaption = ' ,Tutor,Teaching Assistant,Teaching Assistant-Clinical Skills Lab,N/A';
        }

        field(24; "Interested in being lead"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(25; "1st Choice Lead Role"; Option)
        {
            Caption = '1st Choice Lead Role';
            DataClassification = CustomerContent;
            //OptionMembers = " ","Lead Coordinator/Active Learning TA","Lead Curriculum Next TA-Med 1","Lead Curriculum Next TA-Med 2","Lead Curriculum Next TA-Med 3","Lead ICM Clinical Skills Lab TA","Lead Coordinator/ Lead Tutor","N/A";
            //OptionCaption = ' ,Lead Coordinator/Active Learning TA,Lead Curriculum Next TA-Med 1,Lead Curriculum Next TA-Med 2,Lead Curriculum Next TA-Med 3,Lead ICM Clinical Skills Lab TA,Lead Tutor,N/A';
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }
        field(26; "2nd Choice Lead Role"; Option)
        {
            Caption = '2nd Choice Lead Role';
            DataClassification = CustomerContent;
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }
        field(27; "3rd Choice Lead Role"; Option)
        {
            Caption = '3rd Choice Lead Role';
            DataClassification = CustomerContent;
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }
        field(28; "4th Choice Lead Role"; Option)
        {
            Caption = '4th Choice Lead Role';
            DataClassification = CustomerContent;
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }
        field(29; "5th Choice Lead Role"; Option)
        {
            Caption = '5th Choice Lead Role';
            DataClassification = CustomerContent;
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }
        field(30; "6th Choice Lead Role"; Option)
        {
            Caption = '6th Choice Lead Role';
            DataClassification = CustomerContent;
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }
        field(31; "7th Choice Lead Role"; Option)
        {
            Caption = '7th Choice Lead Role';
            DataClassification = CustomerContent;
            OptionMembers = " ","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';
        }

        field(32; "ShortQ_New_1_Experience"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(33; "ShortQ_New_2_Motivation"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(34; "ShortQ_New_3_Advice"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(35; "ShortQ_New_4_Integrity_Ethic"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(36; "ShortQ_New_5_professionalism"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(37; "ShortQ_Repeat_1_contribution"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(38; "ShortQ_Repeat_2_rationale"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Member or officer of stud org."; Boolean)
        {
            Caption = 'Member or officer of student organisation';
            DataClassification = CustomerContent;
        }
        field(40; "List of SO and affiliations"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Reference 1"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(42; "Reference 2"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(43; "Questions_comments"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(44; "Application Status"; Option)
        {
            Caption = 'Application Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Pending,Approved,Rejected,Suspended,NotSelected,"Interview Confirmed",Selected;
            OptionCaption = ' ,Pending,Approved,Rejected,Suspended,Not Selected,Interview Confirmed,Selected';
        }
        field(45; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(46; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(47; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(48; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(49; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        Field(51; "Previous Role 2 Applying"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Role 2 Applying New Role';
        }
        Field(52; "AUA E-mail"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Participated in Reboot program PrevSem"; Boolean)
        {
            Caption = 'Participated in Reboot program in previous Semester';
            DataClassification = CustomerContent;
        }
        Field(54; "Rejection Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code" where(Type = const(EED));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                if "Rejection Code" <> '' then
                    ReasonCode.Get("Rejection Code");
                "Rejection Reason Description" := ReasonCode.Description;

            end;
        }
        Field(55; "Rejection Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(56; "Role Offered"; Text[100]) //DataType change and created new field 59
        {
            DataClassification = CustomerContent;
        }
        field(57; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Female,Male,Not Specified';
            OptionMembers = " ",Female,Male,"Not Specified";
        }
        field(58; "Repeated any Semester"; Boolean)
        {
            Caption = 'Have you repeated any Semester in AUA? (Yes/No)';
            DataClassification = CustomerContent;
        }
        Field(59; "Role Offered New"; Option) //DataType change field no 56
        {
            // DataClassification = CustomerContent;
            OptionMembers = " ",Tutor,"Teaching Assistant","Teaching Assistant- Clinical Skills Lab","Lead TA - Coordinator","Lead TA - Assistant Coordinator & Active Learning","Lead TA - Clinical Skills Lab (ICM)","Lead TA - CN Med 1","Lead TA - CN Med 2","Lead TA - CN Med 3","Lead TA - CN Med 4","Lead Tutor - Coordinator","Lead Tutor - Assistant Coordinator";
            OptionCaption = ' ,Tutor,Teaching Assistant,Teaching Assistant- Clinical Skills Lab,Lead TA - Coordinator,Lead TA - Assistant Coordinator & Active Learning,Lead TA - Clinical Skills Lab (ICM),Lead TA - CN Med 1,Lead TA - CN Med 2 ,Lead TA - CN Med 3,Lead TA - CN Med 4,Lead Tutor - Coordinator,Lead Tutor - Assistant Coordinator';

        }
        field(60; "Returning Scholar"; Boolean)
        {
            caption = 'I have previously applied as a Medical Scholar';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Application No")
        {
            Clustered = true;
        }
        key(Key2; "Application Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := true;
        IF "Application No" = '' THEN BEGIN
            EducationSetup.Reset;
            If EducationSetup.FindFirst() then;
            EducationSetup.TESTFIELD("Medical Nos.");
            NoSeriesMgt.InitSeries(EducationSetup."Medical Nos.", '', 0D, "Application No", EducationSetup."Medical Nos.");
        END;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();

        if xRec.Updated = Updated then
            Updated := true;
    end;

    //CSPL-00307 Starts for Auto Mail Process 
    // procedure AppMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipient: Text[250];
    //     Recipients: List of [Text];
    // begin
    //     SMTPMailSetup.GET;
    //     Subject := 'Call for Applications into Medical Scholars Program';
    //     CLEAR(SMTPMail);
    //     Recipient := 'mishma.kaushik@corporateserve.com;Lucky.kumar@corporateserve.com';
    //     Recipients := Recipient.Split(';');
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     //Smtpmail.AppendtoBody('Dear AUA Basic Science Students,');
    //     Smtpmail.AppendtoBody('Dear AUA Pre-Clinical Science Students,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('The purpose of this email is to inform you about the great opportunity to become a Medical Scholar ');
    //     Smtpmail.AppendtoBody('in the <b>' + Rec.Semester + ', ' + Rec."Academic Year" + '</b> if you meet the requirements of the program. If you are interested in ');
    //     Smtpmail.AppendtoBody('becoming a Medical Scholar and serve your fellow students as a Teaching Assistant (TA) and/or ');
    //     Smtpmail.AppendtoBody('Tutor, please visit the Education Enhancement Department (EED) SLcM Portal and review ');
    //     Smtpmail.AppendtoBody('following Medical Scholars Program information: ');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('(1) Medical Scholars Program Description;');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('(2) Frequently Asked Questions; and');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('(3) Medical Scholars Application Form.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('We encourage you to review the program information first before you complete the application ');
    //     Smtpmail.AppendtoBody('form on the student portal. ');
    //     Smtpmail.AppendtoBody('<br><br>Returning Medical Scholars, please complete the application form as well. The Deadline ');
    //     Smtpmail.AppendtoBody('applications is 11:59pm on <b> January 15 (Spring Semester) and July 15 (Fall Semester). </b>'); //Date need to be dynamic
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('If you have any questions, please contact the EED at eed@auamed.net');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('We look forward to receiving your application for the Medical Scholars Program.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     //MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Employee Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Employee Email Alert', 'Employee Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // END;

    // procedure SuspendAppMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipients: List of [Text];
    //     Recipient: Text;
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     SMTPMailSetup.GET;

    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Suspension from Medical Scholars Program';
    //     CLEAR(SMTPMail);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('I am writing to inform you that after reviewing your CAS score and found it below the pass mark of ');
    //     Smtpmail.AppendtoBody('80%, the Medical Scholars Program Faculty Team decided to suspend you from the program for the ');
    //     Smtpmail.AppendtoBody('remainder of the <b>' + Rec.Semester + ', ' + Rec."Academic Year" + '</b>.<br/><br/> If your grade improves to be above the pass mark of 80%, ');
    //     Smtpmail.AppendtoBody('you are encouraged to reapply for readmission into the program. We are confident of your ability to ');
    //     Smtpmail.AppendtoBody('improve your grade.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('The Medical Scholars Program wishes to thank you for the time, effort, and commitment you ');
    //     Smtpmail.AppendtoBody('invested in the program. <br/><br/>Please feel free to approach us if you need help with your studies.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Thank you.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // END;

    // procedure RegularRejectAppMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     SMTPMailSetup.GET;
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Regret Email for unsuccessful Regular Medical Scholars Program';

    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Regret Email for unsuccessful Regular Medical Scholars Program', '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('I regret to inform you that upon review, we have decided not to approve your application for ');
    //     Smtpmail.AppendtoBody('Medical Scholars for the <b>' + Rec.Semester + ', ' + Rec."Academic Year" + '</b>.<br><br> If you wish to discuss this further, please feel free to ');
    //     Smtpmail.AppendtoBody('schedule an appointment with me. Otherwise, I wish you the best of luck in your studies and medical career.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // END;

    // procedure LeadRejectedMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     SMTPMailSetup.GET;

    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Regret Email for Lead Medical Scholars Program';

    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Regret Email for Lead Medical Scholars Program', '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Thank you for your interest in serving as a Lead in the Medical Scholars Program this semester. We had a rather competitive pool of candidates for Medical Scholars Program Leads.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('We regret to inform you that we will not be offering you a Lead role for this semester.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('We look forward to you serving as a Medical Scholar for the <b>' + Rec.Semester + ' ' + Rec."Academic Year" + '</b>, and we wish you the very best in your studies this semester.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     SMTPMail.AppendtoBody('Please let me know if you have any questions or concerns.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Thank you.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;

    // procedure LeadApprovedMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     SMTPMailSetup.GET;
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Invitation to Lead Medical Scholar Interview';

    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SenderAddress, Recipient, Subject, '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Greetings to you! You are officially being invited to interview for a Lead position in the Medical Scholars Program <b>' + Rec.Semester + ', ' + Rec."Academic Year" + '</b>.<br><br>');
    //     SMTPMail.AppendtoBody('We are very fortunate to have you as part of the team. The interview process will run for about three weeks and will be conducted via the Microsoft Teams platform.<br><br>');
    //     SMTPMail.AppendtoBody('A selected date and time will be sent to you. Once received, please confirm your availability and an online invite will be sent.<br><br>Looking forward to hearing from you soon.');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Please let me know if you have any questions or concerns.');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     // Smtpmail.AppendtoBody('Thanks');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;

    // procedure RegularApproved()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SMTPMailSetup.GET;
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Invitation to Regular Medical Scholars Interview (and process)';
    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, Subject, '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear Med Scholar Applicant,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Congratulations! I am writing to inform you that we have completed the review of Medical Scholar Program applications, and we selected you to proceed to the next and final step of the selection process.');
    //     SMTPMail.AppendtoBody('You are officially being invited to interview for position in the Medical Scholars Program <b>' + Semester + '</b>.<br><br>');
    //     SMTPMail.AppendtoBody('You will be contacted in two weeks to schedule an interview. Please note these session will be conducted on the Microsoft Teams platform.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     SMTPMail.AppendtoBody('In preparation for the interview please note the following::');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     SMTPMail.AppendtoBody('&bull; Kindly prepare a PowerPoint presentation around 5-8 slides on a learning objective of your choice that you covered in a previous semester.');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('&bull; Present your topic as if you are teaching medical students a semester or two below your current semester, highlighting strategies you would use to actively engage them in their own learning.');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('&bull; Ensure to dress appropriately.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     // SMTPMail.AppendtoBody(
    //     //                     '<table border="1" border-collapse: collapse width="100%" align="center" >' +
    //     //                     '<thead>' +
    //     //                         '<tr>' +
    //     //                         '<th bgcolor="#000000"><font color="#fff">Step</font></th>' +
    //     //                         '<th bgcolor="#000000"><font color="#fff">Duration</font></th>' +
    //     //                         '<th bgcolor="#000000" align="left"><font color="#fff"">Activity</font></th>' +
    //     //                         '</tr>' +
    //     //                     '</thead>' +
    //     //                    '<tbody>' +
    //     //                         '<tr>' +
    //     //                         '<td>1.</td>' +
    //     //                         '<td><p align="center">2 minutes</p></td>' +
    //     //                         '<td><p align="left">Interview panelists introduce themselves to the student and inform the  student of the interview agenda</p></td>' +
    //     //                         '</tr>' +
    //     //                         '<tr>' +
    //     //                         '<td>2.</td>' +
    //     //                         '<td><p align="center">10-15 minutes</p></td>' +
    //     //                         '<td><p align="left">Student makes presentation on a topic of their own choice</p></td>' +
    //     //                         '</tr>' +
    //     //                         '<tr>' +
    //     //                         '<td>3.</td>' +
    //     //                         '<td><p align="center">5 minutes </p></td>' +
    //     //                         '<td><p align="left">Ask student at least two Medical Scholar Possible Questions interview questions and give Feedback on the presentation </p></td>' +
    //     //                         '</tr>' +
    //     //                         '<tr>' +
    //     //                         '<td>4.</td>' +
    //     //                         '<td><p align="center">8 minutes</p>' +
    //     //                         '<td><p align="left">Provide student with an opportunity to ask questions and thank them for attending the interview. Inform student that they will hear from the Medical Scholars Director who will inform them of the EED’s decision </p></td>' +
    //     //                         '</tr>' +
    //     //                     '</tbody>' +
    //     //                     '</table>');
    //     // Smtpmail.AppendtoBody('<br/><br/>');
    //     SMTPMail.AppendtoBody('<p>An online invite will be sent to you shortly containing the link. If the suggested date and time is not feasible for you, please make another suggestion that is convenient. If you have any questions or concerns please let me know.</p>');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     // SMTPMail.AppendtoBody('<b>Monday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // SMTPMail.AppendtoBody('<b>Tuesday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // SMTPMail.AppendtoBody('<b>Wednesday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // SMTPMail.AppendtoBody('<b>Thursday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // SMTPMail.AppendtoBody('<b>Friday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // SMTPMail.AppendtoBody('<b>Saturday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/>');
    //     // SMTPMail.AppendtoBody('<b>Friday: [time range]</b>');
    //     // Smtpmail.AppendtoBody('<br/><br/>');
    //     // SMTPMail.AppendtoBody('If you have any questions, please let me know. ');
    //     // Smtpmail.AppendtoBody('<br/><br/>');
    //     // SMTPMail.AppendtoBody('All the best,');
    //     SMTPMail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;

    // procedure InterviewConfirmedMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     SMTPMailSetup.GET;
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Medical Scholar Confirmation of interview Email';
    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Medical Scholar Confirmation of interview Email', '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('<p>This is official confirmation of your interview for the Medical Scholars program.<br/><br/> Your interview will take place on <b>[day, month, date, year and time]</b>.' +
    //                          'You will be interviewing with myself and a current Medical Scholar or a Basic Sciences faculty.<br/><br/> Please prepare a 10-15 minute mock Tutor/TA session prepared on any material from Med 1 or 2 semester.' +
    //                          'You can present your session on either the white board, PowerPoint, or other format of your choice.</p>');
    //     SMTPMail.AppendtoBody('Dress for the interview would be business casual, and the interview will take place in the <b>EED Conference Room on the third floor.</b>');
    //     SMTPMail.AppendtoBody('<br/><br/>Should you have any questions prior to your interview, please do not hesitate to contact me.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     SMTPMail.AppendtoBody('Please let me know if you have any questions.');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Thanks');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;

    // procedure LeadSelectedMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    // begin
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');

    //     SMTPMailSetup.GET;
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     Subject := 'Lead Med Scholars Acceptance Email';
    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Lead Med Scholars Acceptance Email', '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('<p>We have completed the review of Lead Med Scholar interviews, and it is my pleasure to offer you ' +
    //                          'the role of <b>' + Format(Rec."Role Offered New") + '</b> for the <b>' + Rec.Semester + '</b>. I kindly ask you to confirm your acceptance of this role within the next five business days.</p>');
    //     SMTPMail.AppendtoBody('Congratulations on your successful interview and for receiving this offer! ');
    //     SMTPMail.AppendtoBody('<br/><br/> Please let me know if you have any questions or concerns. ');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director<br>');
    //     SMTPMail.AppendtoBody('Education Enhancement Department');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;

    // procedure RegularSelectedMail()
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     MEdicalScholarLine: Record "Medical Scholars Line";
    //     MSL: Record "Medical Scholars Line";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     Recipients: List of [Text];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     SemesterDecipline: Text;
    //     SemesterFilter: Text;
    //     SemCounter: integer;
    //     RunCounter: Integer;
    // begin
    //     Studentmaster.Reset();
    //     if Studentmaster.GET(rec."Student No.") then;
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     // Recipient := 'lucky.kumar@corporateserve.com';
    //     Recipients := Recipient.Split(';');
    //     SMTPMailSetup.GET();
    //     SenderAddress := SmtpMailSetup."Email Address";
    //     // IF "Returning Scholar" = false then
    //     //     Subject := 'Regular (New) Medical Scholar Acceptance Email'
    //     // else
    //     //     Subject := 'Regular (Returning) Medical Scholar Acceptance Email';
    //     Subject := Rec."Application No" + ' Medical Scholar Acceptance Email';
    //     CLEAR(SMTPMail);
    //     // SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Regular Medical Scholar Acceptance Email', '', TRUE);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //     Smtpmail.AppendtoBody('Dear ' + Rec."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     IF "Returning Scholar" = false then
    //         SMTPMail.AppendtoBody('<p>Congratulations! Welcome to the Medical Scholars Program! We are very excited to have you as part of the team. ')
    //     else
    //         SMTPMail.AppendtoBody('<p>Congratulations! Welcome back to the program! ');
    //     SMTPMail.AppendtoBody('We have selected you to be a Medical Scholar for <b>' + Rec.Semester + '</b> in the following position(s):</p>');
    //     // SemesterDecipline := '';
    //     // SemesterFilter := '';
    //     // MEdicalScholarLine.Reset();
    //     // MEdicalScholarLine.SetCurrentKey("Semster No");
    //     // MEdicalScholarLine.SetRange("Document No.", Rec."Application No");
    //     // MEdicalScholarLine.SetRange(Position, MEdicalScholarLine.Position::TA);
    //     // IF MEdicalScholarLine.FindSet() then begin
    //     //     SemesterDecipline := '<li>TA ';
    //     //     repeat
    //     //         IF SemesterFilter <> MEdicalScholarLine."Semster No" then begin
    //     //             RunCounter := 1;
    //     //             MSL.Reset();
    //     //             MSL.SetCurrentKey("Semster No");
    //     //             MSL.SetRange("Document No.", Rec."Application No");
    //     //             MSL.SetRange(Position, MSL.Position::TA);
    //     //             MSL.SetRange("Semster No", MEdicalScholarLine."Semster No");
    //     //             if MSL.FindSet() then
    //     //                 SemCounter := MSL.Count;
    //     //             SemesterFilter := MEdicalScholarLine."Semster No";
    //     //             SemesterDecipline += '<ul><li>' + MEdicalScholarLine."Semster No" + '<ul><li>' + MEdicalScholarLine."Subect Name " + '</li></ul>';
    //     //             IF SemCounter = 1 then
    //     //                 SemesterDecipline += '</li></ul>';
    //     //         end Else begin
    //     //             SemesterDecipline += '<ul><li>' + MEdicalScholarLine."Subect Name " + '</li></ul>';
    //     //             IF SemCounter > 1 then
    //     //                 RunCounter += 1;
    //     //             if RunCounter = SemCounter then
    //     //                 SemesterDecipline += '</li></ul>';
    //     //         end;
    //     //     until MEdicalScholarLine.Next() = 0;
    //     //     SemesterDecipline += '</li>';
    //     // end;
    //     // //SMTPMail.AppendtoBody('<li>TA <ul><li>Med(s)</li></ul></li> <li>Tutor <ul><li>Med(s)</li></ul></li>');
    //     // SMTPMail.AppendtoBody(SemesterDecipline);
    //     // SemesterDecipline := '';
    //     // SemesterFilter := '';
    //     // MEdicalScholarLine.Reset();
    //     // MEdicalScholarLine.SetCurrentKey("Semster No");
    //     // MEdicalScholarLine.SetRange("Document No.", Rec."Application No");
    //     // MEdicalScholarLine.SetRange(Position, MEdicalScholarLine.Position::Tutor);
    //     // IF MEdicalScholarLine.FindSet() then begin
    //     //     SemesterDecipline := '<li>Tutor ';
    //     //     repeat
    //     //         IF SemesterFilter <> MEdicalScholarLine."Semster No" then begin
    //     //             RunCounter := 1;
    //     //             MSL.Reset();
    //     //             MSL.SetCurrentKey("Semster No");
    //     //             MSL.SetRange("Document No.", Rec."Application No");
    //     //             MSL.SetRange(Position, MSL.Position::Tutor);
    //     //             MSL.SetRange("Semster No", MEdicalScholarLine."Semster No");
    //     //             if MSL.FindSet() then
    //     //                 SemCounter := MSL.Count;
    //     //             SemesterFilter := MEdicalScholarLine."Semster No";
    //     //             SemesterDecipline += '<ul><li>' + MEdicalScholarLine."Semster No" + '<ul><li>' + MEdicalScholarLine."Subect Name " + '</li></ul>';
    //     //             IF SemCounter = 1 then
    //     //                 SemesterDecipline += '</li></ul>';
    //     //         end Else begin
    //     //             SemesterDecipline += '<ul><li>' + MEdicalScholarLine."Subect Name " + '</li></ul>';
    //     //             IF SemCounter > 1 then
    //     //                 RunCounter += 1;
    //     //             if RunCounter = SemCounter then
    //     //                 SemesterDecipline += '</li></ul>';

    //     //         end;
    //     //     until MEdicalScholarLine.Next() = 0;
    //     //     SemesterDecipline += '</li>';
    //     // end;
    //     SemesterDecipline := '';
    //     SemesterDecipline := '<li>TA ';
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::TA);
    //     MSL.SetRange("Semster No", 'MED1');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::TA);
    //     MSL.SetRange("Semster No", 'MED2');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::TA);
    //     MSL.SetRange("Semster No", 'MED3');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::TA);
    //     MSL.SetRange("Semster No", 'MED4');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     SemesterDecipline += '</li>';
    //     // end;
    //     //SMTPMail.AppendtoBody('<li>TA <ul><li>Med(s)</li></ul></li> <li>Tutor <ul><li>Med(s)</li></ul></li>');
    //     SMTPMail.AppendtoBody(SemesterDecipline);
    //     SemesterDecipline := '';
    //     SemesterDecipline := '<li>Tutor ';
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::Tutor);
    //     MSL.SetRange("Semster No", 'MED1');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::Tutor);
    //     MSL.SetRange("Semster No", 'MED2');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::Tutor);
    //     MSL.SetRange("Semster No", 'MED3');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     MSL.Reset();
    //     MSL.SetCurrentKey("Semster No");
    //     MSL.SetRange("Document No.", Rec."Application No");
    //     MSL.SetRange(Position, MSL.Position::Tutor);
    //     MSL.SetRange("Semster No", 'MED4');
    //     if MSL.FindSet() then begin
    //         SemesterDecipline += '<ul><li>' + MSL."Semster No";
    //         repeat
    //             SemesterDecipline += '<ul><li>' + MSL."Subect Name " + '</li></ul>';
    //         until MSL.Next() = 0;
    //         SemesterDecipline += '</li></ul>';
    //     end;
    //     SemesterDecipline += '</li>';
    //     SMTPMail.AppendtoBody(SemesterDecipline);
    //     SMTPMail.AppendtoBody('<br/><br/>');
    //     // SMTPMail.AppendtoBody('Welcome to the program! To kick off this semesters Medical Scholars Program, we will have:');
    //     SMTPMail.AppendtoBody('In preparation for this semester, please get ready to take part in the Mandatory First Meeting and Active Learning Training Session. <br><br>' +
    //                         'Various members of the AUA leadership team, and EED faculty will be present for the respective sessions. <br><br>Information and scheduling will be corresponded shortly.');
    //     SMTPMail.AppendtoBody('<br/><br/> We wish you all the best in your studies, while serving in the above role this semester.');
    //     IF "Returning Scholar" = true then
    //         SMTPMail.AppendtoBody('<br><br>We appreciate all that you have done and will continue to do for the Medical Scholars Program.');
    //     SMTPMail.AppendtoBody('<br/><br/>If you have any questions or concerns, please feel free to contact me at nbelle@auamed.net or eed@auamed.net.');
    //     SMTPMail.AppendtoBody('<br/><br/>Again, congratulations on being selected for this prestigious honor and we truly look forward to working with you this semester!');
    //     Smtpmail.AppendtoBody('<br/><br/>');
    //     Smtpmail.AppendtoBody('Sincerely,');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('Medical Scholars Program Director');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Medical Scholar Email Alert', 'MEA', SenderAddress, "Student Name",
    //     Format("Student No."), Subject, BodyText, 'Medical Scholar Email Alert', 'Medical Scholar Email Alert', Format(Rec."Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;


    //CSPL-00307 Ends for Auto Mail Process 
    var
        EducationSetup: Record "Education Setup-CS";

        Studentmaster: Record "Student Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: Text;

}
