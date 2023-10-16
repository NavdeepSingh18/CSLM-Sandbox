// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type(System.IO.MemoryStream; NewImageStream) { }
//     }
// }

// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type("System.Convert"; ImageConvert)
//         {

//         }
//     }
// }
// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type("System.Array"; Bytes)
//         {

//         }
//     }
// }
codeunit 50044 "Clinical Notification"
{
    trigger OnRun()
    begin

    end;

    /*
    procedure NewRotationOnSchedule(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;
        StudentMaster.TestField("Clinical Coordinator");
        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        WindowDialog.Open('Sending New rotation on schedule..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");


        CCRecipient := StudentMaster."E-Mail Address";
        CCRecipients := CCRecipient.Split(';');

        MailSubject := 'New rotation on schedule';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."First Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please be aware that the following addition of ' + RSL."Rotation Description" + ' ' + Format(RSL."Clerkship Type") + ' rotation at ' + RSL."Hospital Name" + ' beginning on ' + Format(RSL."Start Date") + ' has been made to your schedule.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(StudentMaster."Staff Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'New Rotation Scheduling', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure OtherUmbrellaNotificationEmail(RSL: Record "Roster Scheduling Line")
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text;
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Sending Umbrella Rotation Mail..\' + Text001Lbl);

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;

        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");

            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

            CCRecipient := CCRecipient + ';' + UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        WindowDialog.Update(1, StudentMaster."No." + ' - ' + StudentMaster."Student Name");

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Rotation Notification';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name");
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('In an effort to ensure all students are assigned cores needed in order to graduate, you have been scheduled for ' + RSL."Rotation Description" + ' at ' + RSL."Hospital Name" + ' starting ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks. Please note that this ' + RSL."Rotation Description" + ' falls under the umbrella of the ACGME accredited Family Practice residency program. This will be sufficient for licensure in the majority of the states, including, California and New York. Please refer to the website of the licensure board of the state you are considering for licensure.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please reply to your coordinator (listed below) with your acknowledgement of this placement. Failure to respond to your coordinator, does not excuse any student from their assigned rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All students must pass the corresponding Clinical Core Subject Shelf Exam for each of their cores. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Case vignettes provided by Aquifer have been proven to increase the in-depth knowledge of core rotation subject matters and improve students’ performance on NBME core and comprehensive shelf examinations as well as on USMLE Step 2 CK.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA recommends to review ALL Aquifer case vignettes as well as those provided by Wise-MD for Surgery and those provided by APGO for OB/GYN.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('In order to further enhance students’ academic performance and foster the standardization of the curriculum across clinical sites, the following Aquifer cases are mandated for clinical core rotations in Internal Medicine, Family Medicine and Pediatrics starting on or after August 31, 2020:');
            SMTPMail.AppendtoBody('•	Internal Medicine         1, 2, 3, 4, 5, 6, 9, 12, 17, 19, 21, 24');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Family Medicine           1, 2, 6, 7, 8, 10, 11, 13, 16, 18, 26, 28');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Pediatrics:                   1, 8, 10, 13, 16, 19, 21, 23, 27, 28, 31, 32');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Failure to complete the above listed case vignettes <u>during</u> the core rotation will result in withholding of the grade for that rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>Accessing Aquifer:</u> Your name will be loaded into the Aquifer system before the start of core rotations in IM, FAM, PEDS and SUR.  For example, before the start of PEDSs, you will gain access to Aquifer Pediatrics.  You will only have access to the case studies in that section of Aquifer while you are enrolled in the rotation.  <u>Watch for an email from Aquifer with instructions on how to access and use the system</u>. If you don’t see an email, be sure to check your Junk folder to see if it is there.  <u>If you still don’t see a message, go to</u> https://uantigua-md.meduapp.com/users/sign_in.  At the bottom where it says “Need to register?” you should enter your AUA email address and the system will send you another welcome email to walk you through the registration process. If you’re still unable to access it, please contact:  helpdesk@auamed.org');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. The meetings are scheduled on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed entry into the U.S. for your clinical clerkships. These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University.' +
            ' As a result of this requirement, all students who need immigration paperwork are required to submit a request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). Failure to comply with this requirement may result in a delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships. To request your immigration paperwork, please send an email to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Clinical guidelines');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email:helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>If this is your first rotation in New York, please confirm that your clinical coordinator has received a copy of your New York State Letter.All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</u>');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002<br>Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your Clinical Coordinator is: ' + UserSetup."E-Mail");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards,');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br><br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Umbrella Rotation Notification II', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;


    procedure FirstUmbrellaNotificationEmail(RSL: Record "Roster Scheduling Line")
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text;
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Sending Umbrella Rotation Mail..\' + Text001Lbl);

        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindLast() then;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        WindowDialog.Update(1, StudentMaster."No." + ' - ' + StudentMaster."Student Name");

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Rotation Notification';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name");
            SMTPMail.AppendtoBody('<br><br><br>');

            SMTPMail.AppendtoBody('You have been scheduled for ' + RSL."Rotation Description" + ' at ' + RSL."Hospital Name" + ' stating ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks.' +
            ' Please note that this ' + RSL."Rotation Description" + ' core core falls under the umbrella of the ACGME accredited Family Practice residency program. This will be sufficient for licensure in the majority of the states, including, California and New York. Please refer to the website of the licensure board of the state you are considering for licensure.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please reply to your coordinator (listed below) with your acknowledgement of this placement. Failure to respond to your coordinator, does not excuse any student from their assigned rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please note, an evaluation and portfolio must be submitted for all completed clerkships.  Final grades will not be available for clerkships with missing evaluations and or portfolios. You should receive an email through DocuSign at the start of each rotation. To gain access to evaluation or portfolio information please refer to your My Courses list posted on BlackBoard. A How-To Guide can be found in the Portfolios & Evaluations menu item under each corresponding course. This guide can also be found within the Clinical Guidelines. If a particular course is missing from your BlackBoard My Courses List, please email helpdesk@auamed.net and ask to be enrolled into the particular missing course(s).');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All students must pass the corresponding Clinical Core Subject Shelf Exam for each of their cores. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Case vignettes provided by Aquifer have been proven to increase the in-depth knowledge of core rotation subject matters and improve students’ performance on NBME core and comprehensive shelf examinations as well as on USMLE Step 2 CK.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA recommends to review ALL Aquifer case vignettes as well as those provided by Wise-MD for Surgery and those provided by APGO for OB/GYN.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('In order to further enhance students’ academic performance and foster the standardization of the curriculum across clinical sites, the following Aquifer cases are mandated for clinical core rotations in Internal Medicine, Family Medicine and Pediatrics starting on or after August 31, 2020:');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•	Internal Medicine         1, 2, 3, 4, 5, 6, 9, 12, 17, 19, 21, 24');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Family Medicine           1, 2, 6, 7, 8, 10, 11, 13, 16, 18, 26, 28');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Pediatrics:                   1, 8, 10, 13, 16, 19, 21, 23, 27, 28, 31, 32');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Failure to complete the above listed case vignettes <u>during</u> the core rotation will result in withholding of the grade for that rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>Accessing Aquifer:</u> Your name will be loaded into the Aquifer system before the start of core rotations in IM, FAM, PEDS and SUR.  For example, before the start of PEDSs, you will gain access to Aquifer Pediatrics.  You will only have access to the case studies in that section of Aquifer while you are enrolled in the rotation.  <u>Watch for an email from Aquifer with instructions on how to access and use the system</u>. If you don’t see an email, be sure to check your Junk folder to see if it is there.  <u>If you still don’t see a message, go to</u> https://uantigua-md.meduapp.com/users/sign_in.  At the bottom where it says “Need to register?” you should enter your AUA email address and the system will send you another welcome email to walk you through the registration process. If you’re still unable to access it, please contact:  helpdesk@auamed.org');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. The meetings are scheduled on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed entry into the U.S. for your clinical clerkships. These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University.' +
            ' As a result of this requirement, all students who need immigration paperwork are required to submit a request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). Failure to comply with this requirement may result in a delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships. To request your immigration paperwork, please send an email to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Clinical guidelines');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email:helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>If this is your first rotation in New York, please confirm that your clinical coordinator has received a copy of your New York State Letter.All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</u>');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002<br>Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your Clinical Coordinator is: ' + UserSetup."E-Mail");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards,');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br><br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Umbrella Rotation Notification I', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure SendTWDEmail(StudentNo: Code[20])
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        RSL: Record "Roster Scheduling Line";
        LDate: Record Date;
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text;
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        LastDateOfAttendance: Date;
        FirstMondayDate: Date;
    begin
        WindowDialog.Open('Sending TWD Mail..\' + Text001Lbl);

        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindLast() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        RSL.Reset();
        RSL.SetCurrentKey("Student No.", "Start Date");
        RSL.SetRange("Student No.", StudentMaster."No.");
        RSL.SetFilter("Start Date", '<=%1&<>%2', Today, 0D);
        RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
        if RSL.FindLast() then
            if RSL."End Date" < Today then begin
                LastDateOfAttendance := RSL."End Date";
                LDate.Reset();
                LDate.SetRange("Period Type", LDate."Period Type"::Date);
                LDate.SetFilter("Period Start", '>%1', Today);
                LDate.SetFilter("Period Name", 'Monday');
                if LDate.FindFirst() then
                    FirstMondayDate := LDate."Period Start";
            end;

        //Recipient := StudentMaster."E-Mail Address";
        Recipient := 'vikas.sharma@corporateserve.com';
        Recipients := Recipient.Split(';');

        WindowDialog.Update(1, StudentMaster."No." + ' - ' + StudentMaster."Student Name");

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'AUA Temporary Withdrawal Status';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name");
            SMTPMail.AppendtoBody('<br><br><br>');

            SMTPMail.AppendtoBody('The Office of the Registrar is responsible for tracking clinical enrollment, and informing students of extended breaks in their clinical schedule. This email is to confirm that your enrollment status has been changed to Temporarily Withdrawn (TWD) effective Friday, ' + format(LastDateOfAttendance) + ' (your last date of attendance) due to one of the following reasons:');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•         Your clinical schedule reflects that you have completed all scheduled clinical rotations but have no future rotations confirmed by your AUA Clinical Coordinator');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          •   Confirmation emails from hospitals does not equate to confirmation from your AUA Clinical Coordinator');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          •   You must contact your AUA Clinical Coordinator to receive official confirmation');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          •   Your status will be updated to Active (full-time) if you can schedule/adjust a rotation with your AUA Clinical Coordinator to start no later than Monday, ' + Format(FirstMondayDate));
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          •   Please reach out to your AUA Clinical Coordinator to begin the scheduling process');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          •   Any rotations that start after Monday, ' + format(FirstMondayDate) + ' will update your status to Active when you start that rotation');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•         You have a break in your clinical schedule of more than 4 weeks, or you have not been approved for a Clinical Leave of Absence (CLOA)');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          •   CLOA applications must be submitted and approved before your last date of attendance:  Friday, ' + Format(LastDateOfAttendance) + ' but not after your last date of attendance');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•         <u>Students on Academic Probation, Non-Academic Probation, or Professional Probation are ineligible to participate in the CLOA</u>');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•         The TWD status will not impede your eligibility to register, schedule, or participate in any basic/clinical comprehensive examinations or USMLE Step 1 & 2 examinations');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please note the following policy regarding TWD status:');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Students who enter a TWD status are not eligible for a Clinical Leave of Absence (CLOA) and are considered Withdrawn for Financial Aid purposes. Students reported to the National Student Loan Data System (NSLDS) as Withdrawn may enter repayment until they return to an approved clinical rotation. A TWD status, regardless of the reason, will also adversely impact federal aid eligibility. <u>Please contact the Office of Student Financial Services, studentfinancialservices@auamed.org, for more information on how a TWD status may impact your federal/private loans.</u>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Students on a TWD status are not eligible for an in-school deferment or an enrollment verification letter. Students who enter repayment while on this status should contact the Office of Student Financial Services and/or the federal servicer of their loans to discuss postponement of repayment options that may be available to them. Breaks of more than 4 weeks between scheduled rotations must also be disclosed and explained in residency interviews.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you have no future rotations scheduled, please work with your clinical coordinator to schedule a clinical rotation as soon as possible. Please be aware that last minute schedule additions cannot be guaranteed and is at the discretion of the hospital. Per AUA policy, if you remain on a TWD status for more than 180 days you will be subject to administrative withdrawal from the University.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Upon returning from a TWD status into an approved clinical rotation, your enrollment status will be updated to Active (full-time). If you entered repayment and need to place your loans back on an in-school deferment, please submit a request to the Office of the Registrar at registrar@auamed.org.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you have any further questions or concerns regarding your enrollment status, you can reference the Student Handbook on the University’s website, http://auamed.org/student-life/guides/student-handbook/, or you can email me directly, for this is the best way to reach me. ');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Sincerely,');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('_______________________');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Office of the Registrar<br>Manipal Education Americas, LLC Representative for<br>American University of Antigua College of Medicine<br>40 Wall Street, 10th floor<br>New York, NY 10005<br>www.auamed.org');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<p style="font-size:10px color:blue">DISCLAIMER:<br></p>');
            SMTPMail.AppendtoBody('<p style="font-size:9px">This message is for the named person''s use only.  It may contain confidential, proprietary or legally privileged information.  No confidentiality or privilege is waived or lost by any mis-transmission.  ' +
            'If you receive this message in error, please immediately delete it and all copies of it from your system, destroy any hard copies of it and notify the sender.  ' +
            'You must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message if you are not the intended recipient. ' +
            'Manipal Education of Americas, LLC Agent  for American University of Antigua College of Medicine, and any of its subsidiaries each reserve the right to monitor all e-mail communications through its networks. ' +
            'Any views expressed in this message are those of the individual sender, except where the message states otherwise and the sender is authorized to state them to be the views of any such entity.</p>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br><br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');

            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Status Changed to TWD', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure SendOnDocumentUpload(StudentNo: Code[20]; DocumentDescription: Text[500])
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        DSExist: Boolean;
        MailSubject: Text;
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Sending Document Submission Mail..\' + Text001Lbl);

        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindLast() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        DSExist := false;
        if StudentMaster."Document Specialist" <> '' then begin
            User.Reset();
            User.SetRange("User Name", StudentMaster."Document Specialist");
            if User.FindLast() then
                if User."Full Name" = '' then
                    Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

            UserSetup.Reset();
            if UserSetup.Get(StudentMaster."Document Specialist") then begin
                if UserSetup."E-Mail" = '' then
                    Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");
            end;
            // else
            //     Error('User Setup not found for the Document Specialist ID %1.', StudentMaster."Document Specialist");

            if UserSetup."E-Mail" <> '' then
                DSExist := true;
            CCRecipient := UserSetup."E-Mail";

            IF DocumentDescription IN ['OTH - FM1/IM1 Site Selection Form', 'OTH - FIU FM1/IM1 Attestation Form'] then//Description on UAT & Prod Are Different
                CCRecipient := CCRecipient + ';' + 'Kwashington@auamed.org';

            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Update(1, StudentMaster."No." + ' - ' + StudentMaster."Student Name");

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Documentation Submission ' + DocumentDescription;
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + 'Student,');
            SMTPMail.AppendtoBody('<br><br><br>');

            SMTPMail.AppendtoBody('Your ' + DocumentDescription + ' has been received and added to your digital file. This is not a confirmation of documentation compliance.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Once reviewed by your Document Specialist, you will be contacted via email advising you of your compliant and non-compliant documents.');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('<u>5th SEMESTER STUDENTS</u>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•	You must include your cover sheet with your document submission. Your submission will be returned if the coversheet is not attached.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	You must also include your student ID# in the subject line of your submissions.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Documents are reviewed within 5 business days of receipt of this email.');
            SMTPMail.AppendtoBody('<br><br>');
            // SMTPMail.AppendtoBody('<u>CREDENTIAL STUDENTS</u>');
            // SMTPMail.AppendtoBody('<br><br>');
            // SMTPMail.AppendtoBody('•	Document submissions are only reviewed 5 days prior to the 15th and 30th of the month.');
            // SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>RETURNING STUDENTS</u>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•	Documents are reviewed within 5 business days of receipt of this email.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Documents must be updated and cleared 6 weeks prior to the start of a rotation.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('All students should become familiar with the Policy on Clinical Clerkships. This can be accessed via Blackboard.');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('<u>***Important NOTICE, please read***</u>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>Per, AUA requirements it is the students’ responsibility to review and keep track of their documents expiration dates. You may review the current list of AUA requirements on Blackboard. Expiring documents must be on file 6 weeks prior to the rotation start date in accordance to the signed Clinical Clerkship Placement Attestation form. Hospitals reserve the right to request a more recent record of your health documentation. ' +
            'Please ensure that you are reviewing the specific hospital requirements on Blackboard in comparison to your documents expiration dates to ensure that you are AUA and Hospital compliant prior to the rotation start date.  Without the required documentation you are at risk of being dropped from the rotation. Some hospitals’ requirements differ from AUA’s requirements. If a student is scheduled for such hospital(s), the student will be sent a courtesy reminder.</u>');

            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('-------------------------------');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Administration');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('p: (212) 661-8899');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('f: (646) 390-4947');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('csd@auamed.org');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Manipal Education Americas, Representative for <br>American University of Antigua College of Medicine');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('40 Wall Street, 10th Floor,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('New York, NY 10005');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('www.auamed.org');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('<p style="font-size:10px color:blue">DISCLAIMER:<br></p>');
            SMTPMail.AppendtoBody('<p style="font-size:9px">This message is for the named person''s use only.  It may contain confidential, proprietary or legally privileged information.  No confidentiality or privilege is waived or lost by any mis-transmission.  ' +
            'If you receive this message in error, please immediately delete it and all copies of it from your system, destroy any hard copies of it and notify the sender.  ' +
            'You must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message if you are not the intended recipient. ' +
            'Manipal Education of Americas, LLC Agent  for American University of Antigua College of Medicine, and any of its subsidiaries each reserve the right to monitor all e-mail communications through its networks. ' +
            'Any views expressed in this message are those of the individual sender, except where the message states otherwise and the sender is authorized to state them to be the views of any such entity.</p>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br><br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');

            Body := SmtpMail.GetBody();
            SMTPMail.AddCC(CCRecipients);
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Document Upload', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();

        end;
    end;



    procedure SendRotationCancellationApplRejected(RCA: Record "Rotation Cancellation Appln")
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text;
        Body: Text;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RCA."Student No.") then;
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Rotation Cancellation Application Rejected';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');

            SMTPMail.AppendtoBody('Please notice that your Rotation Application Cancellation request for ' + format(RCA."Clerkship Type") + ' - ' + RCA."Rotation Description" + ' starting ' + Format(RCA."Start Date") + ' at ' + RCA."Hospital Name" + ' has rejected.');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Regards');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Administrator');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', StudentMaster."No.", StudentMaster."Student Name", Recipient, MailSubject, Body, 'Rotation Cancellation Application Reject', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
        end;
    end;

    procedure SendDocRejectMail(SDA: Record "Student Document Attachment")
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text;
        Body: Text;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindLast() then
            StudentMaster.Reset();
        if StudentMaster.Get(SDA."Student No.") then;
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Clinical Document Rejected';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');

            SMTPMail.AppendtoBody('This mail is regarding rejection of your ' + Format(SDA."Document Description"));
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Reason of rejection the document is ' + SDA."Reject Reason");
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Regards');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Clinical Administration');
            SMTPMail.AppendtoBody('<br>[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', StudentMaster."No.", StudentMaster."Student Name", Recipient, MailSubject, Body, 'Clinical Document Rejection', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
        end;
    end;


    procedure SendDocUnderReviewMail(SDA: Record "Student Document Attachment")
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text;
        Body: Text;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindLast() then
            StudentMaster.Reset();
        if StudentMaster.Get(SDA."Student No.") then;
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Clinical Document Under Review';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');

            SMTPMail.AppendtoBody('This mail is regarding of your document - ' + Format(SDA."Document Description") + '. The document is under review.');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Clinical Administration');
            SMTPMail.AppendtoBody('<br>[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', StudentMaster."No.", StudentMaster."Student Name", Recipient, MailSubject, Body, 'Clinical Document Rejection', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
        end;
    end;

    procedure SendDocPendingForVarificationMail(SDA: Record "Student Document Attachment")
    var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        User: Record User;
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text;
        Body: Text;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", UserId);
        if User.FindLast() then
            StudentMaster.Reset();
        if StudentMaster.Get(SDA."Student No.") then;
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        MailSubject := 'Clinical Document Under Pending for Verification';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');

            SMTPMail.AppendtoBody('This mail is regarding of your document - ' + Format(SDA."Document Description") + '. The document is pending for Verification.');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Regards');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Clinical Administration');
            SMTPMail.AppendtoBody('<br>[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', StudentMaster."No.", StudentMaster."Student Name", Recipient, MailSubject, Body, 'Clinical Document Rejection', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
        end;
    end;

    procedure ElectiveRequestsPending()
    Var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        RotationOfferApplication: Record "Rotation Offer Application";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        CoordinatorID: Text[50];
        ProblemExist: Boolean;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        WindowDialog.Open('Sending Elective Requests Pending Mail..\' + Text001Lbl);
        CoordinatorID := '';

        MailSubject := 'Elective Requests Pending';

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetCurrentKey("Clinical Cordinator ID");
        RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Open);
        if RotationOfferApplication.FindSet() then
            repeat
                StudentMaster.Reset();
                if StudentMaster.Get(RotationOfferApplication."Student No.") then;

                WindowDialog.Update(1, RotationOfferApplication."Student Name" + ' - ' + RotationOfferApplication."Student No.");

                if StudentMaster."Clinical Coordinator" <> CoordinatorID then begin
                    ProblemExist := false;
                    CoordinatorID := StudentMaster."Clinical Coordinator";

                    User.Reset();
                    User.SetRange("User Name", CoordinatorID);
                    if User.FindLast() then
                        if User."Full Name" = '' then
                            ProblemExist := true;

                    UserSetup.Reset();
                    if UserSetup.Get(CoordinatorID) then begin
                        if UserSetup."E-Mail" = '' then
                            ProblemExist := true;
                    end
                    else
                        ProblemExist := true;

                    if ProblemExist = false then begin
                        Recipient := UserSetup."E-Mail";
                        Recipients := Recipient.Split(';');

                        clear(Body);
                        if Recipient <> '' then begin
                            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
                            SMTPMail.AppendtoBody('Dear ' + User."Full Name" + ',');
                            SMTPMail.AppendtoBody('<br><br>');
                            SMTPMail.AppendtoBody('Please note that there are elective requests pending action on the portal for students in your alpha range.');
                            SMTPMail.AppendtoBody('<br><br>');
                            SMTPMail.AppendtoBody('Regards,');
                            SMTPMail.AppendtoBody('<br>');
                            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
                            SMTPMail.AppendtoBody('<br><br>');
                            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
                            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
                            Body := SmtpMail.GetBody();
                            //SMTPMail.Send();
                            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", User."Full Name", Recipient, MailSubject, Body, 'Weekly reminders for requests that remain in progress', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
                        end;
                    end;
                end;
            until RotationOfferApplication.Next() = 0;

        WindowDialog.Close();
    end;

    procedure PreliminaryRosterFM1IM1(RotationNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        RSH: Record "Roster Scheduling Header";
        RSL: Record "Roster Scheduling Line";
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        // CCRecipient: Text[100];
        // CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        RSH.Reset();
        if RSH.Get(RotationNo) then;
        RSH.CalcFields("No. of Students");


        RSL.Reset();
        RSL.SetRange("Rotation ID", RotationNo);
        if RSL.FindSet() then
            repeat
                StudentMaster.Reset();
                if StudentMaster.Get(RSL."Student No.") then;

                Recipient := StudentMaster."E-Mail Address";
                Recipients := Recipient.Split(';');

                UserSetup.Reset();
                if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
                    if UserSetup."E-Mail" = '' then
                        Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
                end;
            // else
            //     Error('User Setup not found for the Clinical Coordinator %1.', StudentMaster."Clinical Coordinator");

            // if UserSetup."E-Mail" <> '' then begin
            //     Recipient := UserSetup."E-Mail";
            //     Recipients := Recipient.Split(';');
            // end;
            until RSL.Next() = 0;

        WindowDialog.Open('Sending Preliminary Roster for FM1/IM1 Start Date Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

        MailSubject := 'Preliminary Roster for ' + format(RSH."Start Date");

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Good Evening, ');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please review the attached <b><u>preliminary</b></u> roster for the ' + Format(RSH."Start Date") + 'FM1-IM1 start. There are currently a total of ' + format(RSH."No. of Students") + ' students. ' +
            'This list has the potential to increase as more students pass their USMLE (Step 1) exams and finalize their student file. An updated list will be provided next week. ' +
            '{{{USMLE Step 1 Deadline for start}}} is the last date students can pass to become eligible for this start.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•	Clinical Coordinators, ');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          Please enter the rotations in the course load.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          Please enter the rotations in the course load. Students highlighted in red have a balance on their account, please do not update their schedules until further notice.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•	Bursar,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('          Please confirm if all the students are cleared for their rotation.');
            SMTPMail.AppendtoBody('<br><br><br>');

            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Ms. Katrina M. Washington');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Document Specialist (A-G)');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('p: (212) 661-8899, ext. 104');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('f: (646) 390-4947');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('kwashington@auamed.org');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Manipal Education Americas, Representative for <br>American University of Antigua College of Medicine');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('1 Battery Park Plaza, 33rd floor');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('New York, NY 10004');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('www.auamed.org');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('<p style="font-size:10px color:blue">DISCLAIMER:<br></p>');
            SMTPMail.AppendtoBody('<p style="font-size:9px">This message is for the named person''s use only.  It may contain confidential, proprietary or legally privileged information.  No confidentiality or privilege is waived or lost by any mis-transmission.  ' +
            'If you receive this message in error, please immediately delete it and all copies of it from your system, destroy any hard copies of it and notify the sender.  ' +
            'You must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message if you are not the intended recipient. ' +
            'Manipal Education of Americas, LLC Agent  for American University of Antigua College of Medicine, and any of its subsidiaries each reserve the right to monitor all e-mail communications through its networks. ' +
            'Any views expressed in this message are those of the individual sender, except where the message states otherwise and the sender is authorized to state them to be the views of any such entity.</p>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Preliminary Roster for FM1/IM1 Start Date', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure BSICFM1_IM1Packet(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then
            StudentMaster.TestField("E-Mail Address");

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clinical Coordinator %1.', StudentMaster."Clinical Coordinator");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Sending BSIC & FM1 - IM1 Packet Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

        MailSubject := 'BSIC & FM1 - IM1 Packet';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('<p style="font-family:Adobe Garamond Pro"> Dear Students,');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('My name is Katrina Washington and I am the contact person for FM1-IM1. ' +
            'My contact information is listed below for reference or you may reply to this correspondence if you have any additional questions.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please see attachment for information regarding the ' +
            '{{{Upcoming Session Dates}}} BSIC & Family Medicine 1/Internal Medicine 1 clerkship in {{{Academic Year}}}. ' +
            'Review the file for all necessary deadlines, in order to ensure a smooth transition into your 5th semester.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('The Family Medicine 1/Internal Medicine 1 clerkship is a 6 week clinical training course that focuses on enhancing the skills required to perform physical examinations and to interact with patients, ' +
            'family, and health care providers in a US medical environment. This rotation is supplemented by a three-week Blackboard based component.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Students are required to pass the Comprehensive Basic Science - Shelf Exam (also known as the CBSE /COMP) and the USMLE Step 1 exam prior to beginning FM1/IM1. ' +
            'I will not be able to determine site placement availability until our office receives your passing Step 1 score and confirmation from your assigned Document Specialist that the AUA requirements are completed.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('There are revisions to the FM1/IM1 start dates (pg. I & II). Pay close attention to the separate deadlines noted for the Site Selection Form and Clinical paperwork. ' +
            'We kindly request that you comply with any new deadlines for your corresponding start. ');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Questions regarding your Clinical paperwork, may be directed to your respective Document Specialist:');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('	Ms. Katrina Washington: A - G kwashington@auamed.org');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('	Mr. Jelani Bustamonte: H - O jbustamonte@auamed.org');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('	Mr. Ronald DeLeon: P - Z rdeleon@auamed.org');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please forward all document submissions to csd@auamed.org Your completed documents will be reviewed for compliance by your assigned Clinical Document Specialist.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Ms. Katrina M. Washington');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Document Specialist (A-G)');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('FM1-IM1 Coordinator');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('p: (212) 661-8899, ext. 104');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('f: (646) 390-4947');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('kwashington@auamed.org');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Manipal Education Americas, Representative for <br>American University of Antigua College of Medicine');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('1 Battery Park Plaza, 33rd floor');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('New York, NY 10004');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('www.auamed.org');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('<p style="font-size:10px color:blue">DISCLAIMER:<br></p>');
            SMTPMail.AppendtoBody('<p style="font-size:9px">This message is for the named person''s use only.  It may contain confidential, proprietary or legally privileged information.  No confidentiality or privilege is waived or lost by any mis-transmission.  ' +
            'If you receive this message in error, please immediately delete it and all copies of it from your system, destroy any hard copies of it and notify the sender.  ' +
            'You must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message if you are not the intended recipient. ' +
            'Manipal Education of Americas, LLC Agent  for American University of Antigua College of Medicine, and any of its subsidiaries each reserve the right to monitor all e-mail communications through its networks. ' +
            'Any views expressed in this message are those of the individual sender, except where the message states otherwise and the sender is authorized to state them to be the views of any such entity.</p>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'BSIC/FMI/IM1 information packet', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure HOLDRotationNotificationCore(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        //CSPL-00307-RTP -- changes in Email Body
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");

            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

            CCRecipient := CCRecipient + ';' + UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Sending Core Rotation on HOLD Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        MailSubject := Format(RSL."Clerkship Type") + ' Rotation on HOLD';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ');
            SMTPMail.AppendtoBody(StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('In an effort to ensure all students are assigned cores needed in order to graduate, You have been scheduled for ' + RSL."Rotation Description" + ' ' + Format(RSL."Clerkship Type") + ' at ' + RSL."Hospital Name" + ' starting ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please be aware that you currently have a HOLD on your clinical schedule. For this reason, your assigned rotation is not reflected on your current course load. This notification is a record of your assigned rotations while you clear your holds.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('The rotation is being held for you to meet graduation deadlines. Once your holds have been cleared the rotation will be entered into your course load and you will be sent an updated course schedule. As stated in the Clinical Guidelines, ' +
            'if you are on a clinical hold you cannot be assured of being permitted to participate in the rotation. You may also be responsible for the tuition of this missed / forfeited rotation, as well as, any associated penalty fees.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have a Bursar HOLD, please settle your account balance immediately or risk losing your spot in assigned rotations. If you find you cannot meet your financial obligations, ' +
            'you should enter into a clinical leave of absence until your finances permit you to continue your rotations. This will allow you to avoid possible tuition charges for abandoning an assigned rotation. ' +
            'Please review the CLOA policy on Blackboard and the Clinical Guidelines. Please maintain an open line of communication with the clinical department. Abandonment of a rotation is a very serious offense and carries considerable penalties.');
            SMTPMail.AppendtoBody('<br>');
            //---------------New Lines Added Start---------
            SMTPMail.AppendtoBody('All students must pass the corresponding Clinical Core Subject Shelf Exam for each of their cores. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Case vignettes provided by Aquifer have been proven to increase the in-depth knowledge of core rotation subject matters and improve students’ performance on NBME core and comprehensive shelf examinations as well as on USMLE Step 2 CK.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA recommends to review ALL Aquifer case vignettes as well as those provided by Wise-MD for Surgery and those provided by APGO for OB/GYN.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('In order to further enhance students’ academic performance and foster the standardization of the curriculum across clinical sites, the following Aquifer cases are mandated for clinical core rotations in Internal Medicine, Family Medicine and Pediatrics starting on or after August 31, 2020:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<li>Internal Medicine    1, 2, 3, 4, 5, 6, 9, 12, 17, 19, 21, 24 </li>');
            SMTPMail.AppendtoBody('<li>Family Medicine      1, 2, 6, 7, 8, 10, 11, 13, 16, 18, 26, 28 </li>');
            SMTPMail.AppendtoBody('<li>Pediatrics:          1, 8, 10, 13, 16, 19, 21, 23, 27, 28, 31, 32 </li>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Failure to complete the above listed case vignettes during the core rotation will result in withholding of the grade for that rotation.');
            SMTPMail.AppendtoBody('<b>Accessing Aquifer:</b>  Your name will be loaded into the Aquifer system before the start of core rotations in IM, FAM, PEDS and SUR.  For example, before the start of PEDSs, you will gain access to Aquifer Pediatrics.  You will only have access to the case studies in that section of' +
                                ' Aquifer while you are enrolled in the rotation.  Watch for an email from Aquifer with instructions on how to access and use the system.  If you don’t see an email, be sure to check your Junk folder to see if it is there.  If you still don’t see a message, go to https://uantigua-md.meduapp.com/users/sign_in.  At the bottom where it says “Need to register?” you should enter' +
                                ' your AUA email address and the system will send you another welcome email to walk you through the registration process. If you’re still unable to access it, please contact:  helpdesk@auamed.org');
            //---------------New Lines Added End---------
            SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody('All students who started a core rotation on or after 8/1/13 will have to pass the corresponding core Clinical Core Subject Shelf Exam. Please note that you do NOT have to take the CCSSE for rotations you already passed. Please refer to the Clinical Guidelines for further information.');
            // SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. ' +
            // 'The meetings are scheduled on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed entry into the U.S. for your clinical clerkships. ' +
            'These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University. ' +
            '<b>As a result of this requirement, all students who need immigration paperwork are required to submit a request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). ' +
            'Failure to comply with this requirement may result in a delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships.</b> ' +
            'To request your immigration paperwork, please send an email to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you are a 4th year student, scheduled during interview season, please be mindful of the hospitals attendance policy when accepting interviews and schedule them accordingly. Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence during interview season. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            // SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            // SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Clinical guidelines');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email: helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<b>If this is your first rotation in New York, please confirm that your clinical coordinator has received a copy of your New York State Letter.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</b>');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Your Clinical Coordinator is: ' + UserSetup."E-Mail");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'HOLD Rotation Registration Student Email', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure HOLDRotationNotificationCoreSurgery(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Sending HOLD Rotation Registration Student Email (Surgey and specific hospitals) Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        MailSubject := 'Core Rotation on HOLD';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ');
            SMTPMail.AppendtoBody(StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You have been scheduled for ' + RSL."Rotation Description" + ' core at ' + RSL."Hospital Name" + ' starting ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks.');
            SMTPMail.AppendtoBody('Please be aware that you are required to attend a mandatory 4-week General Surgery elective immediately following the conclusion of your 8-week Surgery core.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('The rotation is being held for you to meet graduation deadlines. Once your holds have been cleared the rotation will be entered into your course load and you will be sent an updated course schedule. ' +
            'As stated in the Clinical Guidelines, if you are on a clinical hold you cannot be assured of being permitted to participate in the rotation. You may also be responsible for the tuition of this missed / forfeited rotation, as well as, any associated penalty fees.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have a Bursar HOLD, please settle your account balance immediately or risk losing your spot in assigned rotations. If you find you cannot meet your financial obligations, ' +
            'you should enter into a clinical leave of absence until your finances permit you to continue your rotations. This will allow you to avoid possible tuition charges for abandoning an assigned rotation. ' +
            'Please review the CLOA policy on Blackboard and the Clinical Guidelines. Please maintain an open line of communication with the clinical department. Abandonment of a rotation is a very serious offense and carries considerable penalties.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('All students who started a core rotation on or after 8/1/13 will have to pass the corresponding core Clinical Core Subject Shelf Exam. Please note that you do NOT have to take the CCSSE for rotations you already passed. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. ' +
            'The meetings are scheduled on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed entry into the U.S. for your clinical clerkships. ' +
            'These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University. ' +
            '<b>As a result of this requirement, all students who need immigration paperwork are required to submit a request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). ' +
            'Failure to comply with this requirement may result in a delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships.</b> ' +
            'To request your immigration paperwork, please send an email to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Clinical guidelines');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email: helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<b>If this is your first rotation in New York, please confirm that your clinical coordinator has received a copy of your New York State Letter.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</b>');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'HOLD Rotation Registration Student Email (Surgery and specific hospitals)', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure RotationNotificationCoreSurgery(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        CCRecipient := UserSetup."E-Mail";
        CCRecipients := CCRecipient.Split(';');

        WindowDialog.Open('Sending Core Modified Registration Student Email (Surgey and specific hospitals) Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        MailSubject := 'Rotation Notification';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ');
            SMTPMail.AppendtoBody(StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You have been scheduled for ' + RSL."Rotation Description" + ' core at ' + RSL."Hospital Name" + ' starting ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks.');
            SMTPMail.AppendtoBody('Please be aware that you are required to attend a mandatory 4-week General Surgery elective immediately following the conclusion of your 8-week Surgery core. ' +
            'Please reply to your coordinator (listed below) with your acknowledgement of this placement. Failure to respond to your coordinator, does not excuse any student from their assigned rotation.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Please note, an evaluation and portfolio must be submitted for all completed clerkships.  Final grades will not be available for clerkships with missing evaluations and or portfolios. You should receive an email through DocuSign at the start of each rotation. ' +
            'To gain access to evaluation or portfolio information please refer to your My Courses list posted on BlackBoard. A How-To Guide can be found in the Portfolios & Evaluations menu item under each corresponding course. This guide can also be found within the Clinical Guidelines. ' +
            'If a particular course is missing from your BlackBoard My Courses List, please email helpdesk@auamed.net and ask to be enrolled into the particular missing course(s).');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('All students who started a core rotation on or after 8/1/13 will have to pass the corresponding core Clinical Core Subject Shelf Exam. Please note that you do NOT have to take the CCSSE for rotations you already passed. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. ' +
            'The meetings are scheduled on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.  ');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed entry into the U.S. for your clinical clerkships. ' +
            'These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University. ' +
            '<b>As a result of this requirement, all students who need immigration paperwork are required to submit a request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). ' +
            'Failure to comply with this requirement may result in a delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships.</b> ' +
            'To request your immigration paperwork, please send an email to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Clinical guidelines');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email: helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<b>If this is your first rotation in New York, please confirm that your clinical coordinator has received a copy of your New York State Letter.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</b>');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Core Modified Registration Student Email (Surgery and specific hospitals)', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure RemainingElectiveWeeks(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        RSL: Record "Roster Scheduling Line";
        CourseMaster: Record "Course Master-CS";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        ElectiveWeeksScheduled: Integer;
        ElectiveWeeksPending: Integer;
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");

        ElectiveWeeksScheduled := 0;
        CourseMaster.Reset();
        if CourseMaster.Get(StudentMaster."Course Code") then;

        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", StudentNo);
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Elective);
        if RSL.FindSet() then
            repeat
                ElectiveWeeksScheduled := ElectiveWeeksScheduled + RSL."No. of Weeks";
            until RSL.Next() = 0;

        ElectiveWeeksPending := CourseMaster."Elective Rotation Weeks" - ElectiveWeeksScheduled;

        if ElectiveWeeksPending <= 0 then
            exit;

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clinical Coordinator %1.', StudentMaster."Clinical Coordinator");

        CCRecipient := UserSetup."E-Mail";
        CCRecipients := CCRecipient.Split(';');

        WindowDialog.Open('Sending Remaining Elective Weeks Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

        MailSubject := 'Regarding your remaining elective weeks';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your Clinical Clerkship Schedule has been reviewed and it has been determined that you have ' + Format(ElectiveWeeksPending) + ' weeks left of electives to schedule. ' +
            'You may request your electives through the student portal. Please be reminded that for elective scheduling all of your documents must be up to date and you must be financially clear. ' +
            'Please be sure to be in contact with your Document Specialist and the Bursar Department to ensure that your account is clear in both respects.');

            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'After all core completion identify how many elective weeks need to be scheduled', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure ApproachingGAP(StudentNo: Code[20]; Days: Integer)
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        // CCRecipient: Text[100];
        // CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        GAPWeeks: Integer;
    begin
        if Days > 0 then
            GAPWeeks := Round(Days / 7, 1, '=');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        WindowDialog.Open('Sending Approaching GAP Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

        MailSubject := 'Approaching GAP';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your Clinical Clerkship Schedule has been reviewed and it has been determined that you are approaching a gap of ' + Format(GAPWeeks) + ' weeks ');
            SMTPMail.AppendtoBody('You may request some electives through the student portal. Please be reminded that for elective scheduling all of your documents must be up to date and you must be financially clear. ' +
            'Please be sure to be in contact with your Document Specialist and the Bursar Department to ensure that your account is clear in both respects.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Student is approaching GAP', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure HoldhasbeenLifted(StudentNo: Code[20])
    Var

        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        // CCRecipient: Text[100];
        // CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then begin
            StudentMaster.CalcFields("Clinical Hold Exist");
            if StudentMaster."Clinical Hold Exist" then
                exit;
        end;

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clinical Coordinator %1.', StudentMaster."Clinical Coordinator");

        WindowDialog.Open('Sending Hold has been lifted Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

        Recipient := UserSetup."E-Mail";
        Recipients := Recipient.Split(';');

        MailSubject := 'Hold has been lifted';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + User."Full Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please note that ' + StudentMaster."Student Name" + ' Student ID# ' + StudentNo + ' has had their Clinical Hold cleared and the following rotations have been automatically published to their schedule:');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", UserSetup."User ID", User."Full Name", MailSubject, Body, 'Alert to clinical coordinator when hold is lifted', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure YourHoldhasbeenlifted(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then begin
            StudentMaster.CalcFields("Clinical Hold Exist");
            if StudentMaster."Clinical Hold Exist" then
                exit;
        end;

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        WindowDialog.Open('Sending Your Hold has been lifted Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

        CCRecipient := UserSetup."E-Mail";
        CCRecipients := CCRecipient.Split(';');

        MailSubject := 'Your Hold has been lifted';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please be aware that your Clinical Hold has been cleared. New rotations may now have been confirmed for you. ' +
            'Please be sure to visit the portal to review your schedule for updates.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Alert to Student when hold is lifted', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure NewRotationonScheduleDocumentsInNeedOfUpdate(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        DocCat: Record "Doc & Cate Attachment-CS";
        SDA: Record "Student Document Attachment";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        ListOfDocuments: Text;
        I: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        ListOfDocuments := '';
        I := 0;

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        DocCat.Reset();
        DocCat.SetRange("Document Type", 'CLINICAL');
        DocCat.SetFilter(Responsibility, '<>%1', DocCat.Responsibility::" ");
        DocCat.SetRange(Blocked, false);
        if DocCat.FindSet() then
            repeat
                SDA.Reset();
                SDA.SetCurrentKey("Document Category", "Document Sub Category", "Student No.");
                SDA.SetRange("Student No.", RSL."Student No.");
                SDA.SetRange("Document Category", 'CLINICAL');
                SDA.SetRange("Document Sub Category", DocCat.Code);
                SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                IF not SDA.FindFirst() then begin
                    I += 1;
                    if ListOfDocuments = '' then
                        ListOfDocuments := Format(I) + '. ' + DocCat.Description
                    else
                        ListOfDocuments := ListOfDocuments + '<br>' + Format(I) + '. ' + DocCat.Description;
                end;

                SDA.Reset();
                SDA.SetCurrentKey("Document Category", "Document Sub Category", "Student No.");
                SDA.SetRange("Student No.", RSL."Student No.");
                SDA.SetRange("Document Category", 'CLINICAL');
                SDA.SetRange("Document Sub Category", DocCat.Code);
                SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                SDA.SetFilter("Document Status", '%1|%2', SDA."Document Status"::Expired, SDA."Document Status"::Rejected);
                IF SDA.FindFirst() then begin
                    I += 1;
                    if ListOfDocuments = '' then
                        ListOfDocuments := Format(I) + '. ' + DocCat.Description + ' - ' + Format(SDA."Document Status")
                    else
                        ListOfDocuments := ListOfDocuments + '<br>' + Format(I) + '. ' + DocCat.Description + ' - ' + Format(SDA."Document Status");
                end;
            until DocCat.Next() = 0;

        if ListOfDocuments = '' then
            exit;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Document Specialist");

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");
        end;
        // else
        //     Error('User Setup not found for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        CCRecipient := UserSetup."E-Mail";
        CCRecipients := CCRecipient.Split(';');

        WindowDialog.Open('Sending New Rotation on Schedule. Documents in need of Update Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        MailSubject := 'New rotation on schedule. Documents in need of update';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ');
            SMTPMail.AppendtoBody(StudentMaster."Student Name" + ', ');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please be aware that with the addition of the ' + RSL."Rotation Description" + ' ' + Format(RSL."Clerkship Type") + ' rotation at ');
            SMTPMail.AppendtoBody(RSL."Hospital Name" + ' beginning on ' + format(RSL."Start Date"));
            SMTPMail.AppendtoBody(', the following documents will need to be updated and approved no later than 6-weeks prior to the start.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<b>List of Documents</b><br>');
            SMTPMail.AppendtoBody(ListOfDocuments);
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            // SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Document alert email Alert to student regarding the schedule update', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure SiteSelectionFormRequired(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("FM1/IM1 Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
        ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentNo);
        if ClerkshipSiteAndDateSelection.FindLast() then
            exit;

        User.Reset();
        User.SetRange("User Name", StudentMaster."FM1/IM1 Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."FM1/IM1 Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator %1.', ClerkshipSiteAndDateSelection."FM1/IM1 Coordinator");

        WindowDialog.Open('Sending Site Selection Form Required Mail..\' + Text001Lbl);
        WindowDialog.Update(1, ClerkshipSiteAndDateSelection."Student Name" + '-' + ClerkshipSiteAndDateSelection."Student No.");

        CCRecipient := UserSetup."E-Mail";
        CCRecipients := CCRecipient.Split(';');

        MailSubject := 'Site Selection Form Required';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Congratulations on passing USMLE Step 1. Please be aware that, we do not have a Site Selection Form on file for you to assess your preference and eligibility to being FM1/IM1. ' +
            'Please submit a Site Selection Form at your earliest possible convenience.');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Missing a site preferences selection  email', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure FM1IM1PreferredStartDateConfirmation(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        OtherSites: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
        ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentNo);
        if not ClerkshipSiteAndDateSelection.FindLast() then
            exit;

        StudentMaster.Reset();
        if StudentMaster.Get(ClerkshipSiteAndDateSelection."Student No.") then;

        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("FM1/IM1 Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."FM1/IM1 Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."FM1/IM1 Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator ID %1.', ClerkshipSiteAndDateSelection."FM1/IM1 Coordinator");
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");

        WindowDialog.Open('Sending FM1-IM1 Preferred Start Date Confirmation Mail..\' + Text001Lbl);
        WindowDialog.Update(1, ClerkshipSiteAndDateSelection."Student Name" + '-' + ClerkshipSiteAndDateSelection."Student No.");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        MailSubject := 'FM1/IM1 Preferred Start Date Confirmation';

        if ClerkshipSiteAndDateSelection."Second Preferred Site Name" <> '' then
            OtherSites := ' with ' + ClerkshipSiteAndDateSelection."Second Preferred Site Name";
        if ClerkshipSiteAndDateSelection."Third Preferred Site Name" <> '' then
            OtherSites := OtherSites + ', ' + ClerkshipSiteAndDateSelection."Third Preferred Site Name";

        if OtherSites <> '' then
            OtherSites := OtherSites + ' as a backup';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Congratulations on passing Comp. Previously you submitted a site selection form indicating your preferred start date as ');
            SMTPMail.AppendtoBody('<b>' + Format(ClerkshipSiteAndDateSelection."Preferred Start Date") + '</b> at <b>' + ClerkshipSiteAndDateSelection."First Preferred Site Name" +
            OtherSites + '</b> If this information remains correct, no action is necessary on your part. In the event that your preferences have changed, please be sure to resubmit your Site Selection to update your preferences in our system.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Email to confirm preferred start date of FMI/IMI has not changed', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure UpdatedSiteSelectionFormPending(StudentNo: Code[20]; ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection)
    Var
        SMTPSetup: Record "Email Account";
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        NextFM1IM1StartDate: Date;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        CalculatedDate: Date;
        Day: Integer;
        Week: Integer;
        Year: Integer;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        FM1IM1DatePresetEntry.Reset();
        FM1IM1DatePresetEntry.SetFilter("Start Date", '>=%1', ClerkshipSiteAndDateSelection."Preferred Start Date");
        if FM1IM1DatePresetEntry.FindFirst() then
            NextFM1IM1StartDate := FM1IM1DatePresetEntry."Start Date";
        //CSPL-00307 Start
        IF NextFM1IM1StartDate <> 0D THEN
            CalculatedDate := CalcDate('-59D', NextFM1IM1StartDate); //59 days will always be friday as the start date will always be a monday
        //CSPL-00307 End

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."FM1/IM1 Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."FM1/IM1 Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator ID %1.', StudentMaster."Document Specialist")
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator %1.', StudentMaster."Document Specialist");

        WindowDialog.Open('Sending Updated Site Selection Form Pending Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        MailSubject := 'Updated Site Selection Form Pending-Please Submit';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('<b>' + EducationSetup."Institute Name" + '</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('The deadline to submit the site selection form for the upcoming FM1-IM1 cohort has passed. If you are interested in the ');
            SMTPMail.AppendtoBody(Format(NextFM1IM1StartDate) + ' FM1-IM1 cohort, please complete the site selection form on the portal as soon as possible. As of ' + Format(CalculatedDate) + ', the site confirmation notices will be emailed to students. *Be advised that if the completed forms are not received by this date, placement will be at AUA’s discretion.');
            //SMTPMail.AppendtoBody('Starting the week of ' + Format(NextFM1IM1StartDate) + ', the site confirmation notices will be emailed to students.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('*Placement can only be confirmed if the passing USMLE report is on file, your file is deemed complete by your Document Specialist, and you do not have any financial holds on your account as of 4 weeks prior to the preferred FM1 - IM1 start.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'New site preferences selection notification', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure MeetYourDocumentSpecialist(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        DocSpclName: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist")
            else
                DocSpclName := UserSetup."E-Mail";
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator %1.', StudentMaster."Document Specialist");

        WindowDialog.Open('Sending Congrats Email - Pending Documents - On passing USMLE Step 1 Exam Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        MailSubject := 'Congrats email - pending documents - On passing USMLE step 1 exam';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('<b>' + EducationSetup."Institute Name" + '</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><b>ID#: ' + StudentMaster."No." + '</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Congratulations on passing the USMLE Step 1 Exam!');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('To obtain placement into clinical clerkships, you must first become a credentialed student. The credentialing process consists of a thorough review of all your clinical documents. ' +
            'Your document specialist will screen these documents for validity and hospital compliance.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please follow the instructions below for guidance throughout the credentialing process:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('1.	Please review the attached welcome letter from the Executive Dean of Clinical Sciences, Dr. Bell; the Clinical Guidelines and all other attached forms. Click here to download attachments.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('2.	Refer to the document checklist for all mandatory documentation. This checklist, a link to discounts on health certificates and a downloadable clinical forms packet can all be found in the ' +
            'Clinical Information Center on Blackboard. If you encounter issues with your BlackBoard password please email: helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('3.	You will only become eligible to enter a hospital for clinical rotations after you submit all required and up-to-date documents and they are deemed as approved by your Clinical Document Specialist. ' +
            'Your Clinical Document Specialist is versed in all hospital requirements and will provide you with guidance on how to correct a document that may be rejected for credentialing. Please make sure your documents do not expire ' +
            '90 days prior to the start of your rotation. It is your responsibility to keep your clinical documents updated and compliant for the remainder of your clinical rotations. Some hospitals have additional document requirements, ' +
            'which can include medical testing that exceed AUA requirements. If scheduled at any of those sites, you will be notified accordingly.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('4.	You must email the completed packet in an <b>unsecured PDF</b> format to csd@auamed.org. Your assigned Clinical Document Specialist will review the submission and send you a ' +
            'confirmation email with a status for each piece of required documentation.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('5.	Please allow at least five business days after the submission of your documents for your Document Specialist to review and verify the status of your submission. ' +
            'Incomplete and/or missing documents will delay your credentialing, which in turn will delay your ability to begin a clinical clerkship. Once your documents are deemed compliant, ' +
            'you will be notified of your credentialed status and your Clinical Coordinator will contact you to set up a welcome meeting to help you begin acclimating to the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('6.	The NYSED Long-Term Clerkship application form is the PRIMARY factor in determining the scheduling of a rotation in New York. In order to prepare for potential schedule changes between States, ' +
            '<u>AUA requires that all students fill out the form regardless of where they may be scheduled to rotate</u>. Instructions regarding how to complete the application is included within the AUA Requirements Packet. ' +
            'You will be billed for the $20.00usd application fee. Once the application is approved by NYSED, their office will forward a letter of eligibility to AUA for your records. ' +
            'That letter will allow you to rotate at AUA’s affiliated hospitals in the State of New York.  ' +
            'Please be aware that AUA does not have control over the NYSED application processing time. Should we encounter any delays in processing, we will be sure to follow-up with the NYSED on your behalf. ' +
            'Please do not attempt to contact the NYSED directly. Direct contact from students can adversely affect the timeliness of approvals by the NYSED.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('7.	Once credentialed and after your welcome meeting is conducted, your Clinical Coordinator will notify you of your finalized placement(s). Please do not make any travel or housing arrangements until you receive your confirmed schedule.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA strives to provide you with the best quality service throughout your clinical clerkships. That support, along with the information on BlackBoard and within this email, ' +
            'helps us to facilitate your placement into clinical clerkships as soon as possible.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Questions regarding documentation may be sent to your Clinical Document Specialist at ' + DocSpclName);
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<b>All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002 <br>Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best regards, ');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(DocSpclName);
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Congrats email - Pending Documents - On passing USMLE Step 1 Exam', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure MeetYourClinicalCoordinator(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        DocSpclName: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("Clinical Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator")
            else
                DocSpclName := User."Full Name";

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");

        WindowDialog.Open('Sending Meet your Clinical Coordinator! Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        MailSubject := 'Meet your Clinical Coordinator!';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('<b>' + EducationSetup."Institute Name" + '</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Welcome to Clinicals! My name is ' + User."Full Name");
            SMTPMail.AppendtoBody(' and I’ll be your Clinical Coordinator for semesters five through eight. I’m writing to provide you with important information on the Clinical Sciences scheduling policies and procedures. ' +
            'I know this is a lot of information, but will become a useful reference for you to refer back to during and after our welcome meeting is conducted. I’d like to schedule that meeting with you the soonest possible. ' +
            'I am available for a Skype, in- person (NYC based) or telephone meeting. Meetings are mostly conducted on Wednesdays. Please let me know of your availability at your earliest convenience and do not hesitate to reply with any questions or concerns.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('First off, I would like to remind you that you should only use your AUA email when contacting anyone from AUA or any of our hospitals that permit direct student contact. ' +
            'Also please make sure that you have access to Blackboard and that you are enrolled in the Clinical Information Center. It should populate under your list of organizations. If that is not the case, ' +
            'please email helpdesk@auamed.net.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('During your meeting, we will start off with the following questions. If you wish, you can reply to this email with your answers to help move things along.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('1. Do you have a hospital site preference?<br>');
            SMTPMail.AppendtoBody('2. Do you know what specialty you are interested in specializing in at this point?<br>');
            SMTPMail.AppendtoBody('3. Do you have a state that you plan to practice in?<br>');
            SMTPMail.AppendtoBody('4.	Which match year are you striving for?');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your answers will be noted in your file. I will refer to these notes when preparing your clinical schedule. Please be reminded that accommodation of scheduling preferences cannot be guaranteed, ' +
            'but are taken into consideration. We will continue to document preferences, and accommodate as many as possible, whenever possible. Changes to your schedule are subject to approval and may require the submission of supporting documentation. ' +
            'No changes can be made after the hospital document submission deadline has passed.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('For information on which cores are available at which hospital, please refer to Blackboard. When you log into your account click on the following links to find the chart: ' +
            '"My Organizations” > “Clinical Information Center" > "Hospital and Rotation Information" > "Rotation Information" > "AUA Affiliate Hospitals."');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('We will begin by scheduling you into your core rotations. There are 44 weeks of core rotations and 34 weeks of elective rotations ' +
            '(unless you opted out of BSIC at which point you would be required to attend additional rotation weeks). When the times comes to schedule electives, ' +
            'we will review the process together.  Before requesting electives, please review the hospital’s approved electives on Blackboard. ' +
            'Select <b>Clinical Information Center> Hospital & Rotation Information> Hospital Information> Hospital Name> Electives Offered.</b> ' +
            'Although hospitals may have other electives listed on their websites, the electives posted on BlackBoard are the only approved electives for AUA students. ' +
            'Students are not permitted to contact affiliate hospitals directly without instruction to do so from their Clinical Coordinator. ' +
            'There are a few hospitals which require that students contact them for scheduling.  Please refer to the tab within the Clinical Information Center on Blackboard labeled "Schedule Electives" ' +
            'and view the “Hospitals You Are Permitted to Contact” section.  If the hospital of your interest in not listed that means you must contact me to schedule the elective.  ' +
            'I will contact the hospital on your behalf.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Students can also complete elective rotations with hospitals that are not affiliated with AUA. Please review the Non-Affiliate Hospital Clerkship Request form on Blackboard (the first page outlines the process and policy). ' +
            'This is another unique process that we will work through together if this is something you are interested in. However, generally speaking you would begin by researching the hospital you are interested in and finding out if they are accepting ' +
            'applications from students attending an international medical school.  Please be advised that AUA students are not permitted to rotate in New Jersey or Texas. Any interest in the State of Florida will be reviewed on a case by case basis.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Besides the completion of all clinical rotation weeks, below are some additional requirements needed for graduation: (details found in Clinical Guidelines)');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('•	Complete all core rotations and Clinical Core Subject Shelf Exams (CCSSE) prior to Step 2 exams<br>');
            SMTPMail.AppendtoBody('•	Obtain a qualifying score on the NBME Comprehensive Clinical Science Examination (CCSE)<br>');
            SMTPMail.AppendtoBody('•	Completion of approved CS & CK preparation programs<br>');
            SMTPMail.AppendtoBody('•	Obtain a passing score for both CS & CK');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Typically, students take up to 1 month off to prepare for their Step II exams, after completing their 6th core. ' +
            'I will help you determine how much time you have to work with once we have a confirmed FM1/IM1 rotation on your schedule. When you begin your 4th or 5th core rotation, ' +
            'we will schedule another meeting to discuss your match timeline as you will be scheduled further along and will have more of an idea of whether you can/will strive for the upcoming match.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Once scheduled, most hospitals will send you reporting/orientation instructions a few days before the start of the rotation. ' +
            'If you do not receive them, make sure you check Blackboard as some hospitals send AUA reporting information and we will post it on Blackboard under the corresponding site. ' +
            'Also, if applicable, there are housing suggestions/resources posted in Blackboard under each hospital folder.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please note, an evaluation and portfolio must be submitted for all completed clerkships.  You should receive an email through DocuSign at the start of each rotation. ' +
            'To gain access to evaluation or portfolio information please refer to your My Courses list posted on BlackBoard. A How-To Guide can be found in the Portfolios & Evaluations menu item under each corresponding course. ' +
            'This guide can also be found within the Clinical Guidelines. If a particular course is missing from your BlackBoard My Courses List, please email helpdesk@auamed.net and ask to be enrolled into the particular missing course(s).');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Any questions regarding the CCSSE, CCSE, CK & CS exams can be answered with information found in the Student Handbook and the Clinical Guidelines. ' +
            'You may also contact the Registrar department with any questions on exams and exam preparations. Also, in order to avoid any delays in scheduling it is your responsibility to keep all of your clinical documents up to date. ' +
            'Please maintain communication with your Document Specialist- ' + DocSpclName + ' on the status of your documents.  You will receive courtesy reminder emails from your Document Specialist ' +
            'who is prepping your documentation for a particular hospital. All requested documents are due no later than 6 weeks prior to the start of the rotation. Please be sure to submit ' +
            'your documents on time to avoid any rotation cancellations and a $500 clinical HOLD penalty fee.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Lastly, please be sure to review your Clinical Guidelines and Residency Preparation Manual (available on Blackboard) as there is information available that will best prepare you for your clinical rotations.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Thank you for taking the time to read this email. I hope it was helpful and I look forward to meeting with you.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'USMLE Congrats and Credentialed Email', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure YourClinicalPacketisNowConditionallyComplete(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        DocSpecialistEmail: Text[100];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        DocSpecialistEmail := '';
        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("FM1/IM1 Coordinator");
        StudentMaster.TestField("Document Specialist");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then;

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist %1.', StudentMaster."FM1/IM1 Coordinator")
            else
                DocSpecialistEmail := UserSetup."E-Mail";
        end;
        // else
        //     Error('User Setup not found for the Document Specialist %1.', StudentMaster."FM1/IM1 Coordinator");

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");
        // else
        //     Error('User Setup not found for the Document Specialist %1.', StudentMaster."Document Specialist");

        WindowDialog.Open('Sending Conditionally Credentialed Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        MailSubject := 'Your Clinical Packet is Now Conditionally Complete';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('<b>' + EducationSetup."Institute Name" + '</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<b>ID#: ' + StudentMaster."No." + '</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Congratulations! You have been <u> conditionally credentialed </u>as of ' + Format(StudentMaster."Credential Date") + 'With the exception of {{{Detail Field}}');
            SMTPMail.AppendtoBody('all of your documentation is current and up to date, per AUA requirements.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please allow your clinical coordinator to contact you regarding scheduling rotations.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If anything expires as per academic standards you will be placed on a Clinical Hold until all updates arrive. Please set yourself reminders as it is solely your responsibility to keep your file up to date.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Students with clinical holds on their records will not be scheduled or allowed to participate in rotations. Clinical holds are placed only when documentation is missing or expired. ' +
            'If a Clinical coordinator informs you that there has been a Clinical Hold placed on your account please contact your document specialist for further details. ' +
            'All holds must be cleared 6 weeks prior to the start of a rotation or risk a drop and financial responsibility for the rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Reminder: Hospitals may ask for documentation to meet certain/stricter guidelines after you schedule your rotation, in which case a document specialist will reach out to you to obtain the requested documentation if it is not on file.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Thank you for all your efforts in gathering and updating your documentation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA strives to provide you with the best quality service while you complete your clinical clerkships.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Questions regarding documentation may be sent via email to ' + DocSpecialistEmail);
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA will only send communications to and will only respond to communications sent from your AUA-assigned email address.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<b>Please make certain to include your student number in all communications.</b>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Good luck!');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Conditionally Credentialed', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure UpdatedSiteSelectionFormRequired(ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection)
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(ClerkshipSiteAndDateSelection."Student No.") then;
        StudentMaster.TestField("E-Mail Address");
        StudentMaster.TestField("FM1/IM1 Coordinator");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."FM1/IM1 Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."FM1/IM1 Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");

        WindowDialog.Open('Sending Updated Site Selection Form Required Mail..\' + Text001Lbl);
        WindowDialog.Update(1, ClerkshipSiteAndDateSelection."Student Name" + '-' + ClerkshipSiteAndDateSelection."Student No.");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        MailSubject := 'Updated Site Selection Form Required';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please be aware that, unfortunately, due to your failure of Step 1 it is likely that you will miss the ' +
            'eligibility window for your preferred start date of ' + Format(ClerkshipSiteAndDateSelection."Preferred Start Date"));
            SMTPMail.AppendtoBody(' Kindly resubmit your Site Selection to update your preferences in our system for a later start date.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Email to contact FM I/IM I coordinator to reschedule FM I/IM I date', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure FM1IM1SitePlacementEmail(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        EducationSetup: Record "Education Setup-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        //FileName: Text;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", RSL."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then
            StudentMaster.TestField("Clinical Coordinator");
        StudentMaster.TestField("FM1/IM1 Coordinator");

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clinical Coordinator %1.', StudentMaster."Clinical Coordinator");
        end;
        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
        end;


        User.Reset();
        User.SetRange("User Name", StudentMaster."FM1/IM1 Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."FM1/IM1 Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");
        end;


        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := CCRecipient + ';' + UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Sending FM1-IM1 Site Placement Email..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        MailSubject := 'FM1-IM1 Site Placement Email';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);
            //SMTPMail.AppendtoBody('<IMG src = "file:///' + FileName + '"');
            SMTPMail.AppendtoBody(FORMAT(Today, 0, '<Month Text> <Day,2>, <Year4>'));
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<b><center>WELCOME TO THE CLINICAL SCIENCES</center></b>');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Congratulations!');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Dear: ' + RSL."First Name" + ' ' + RSL."Last Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('ID:' + RSL."Student No.");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You will be starting <b>' + FORMAT(RSL."Start Date", 0, '<Month Text> <Day,2>, <Year4>') + '</b> Family Medicine 1/Internal Medicine 1 at <b>' + RSL."Hospital Name" + '.</b> Thank you for compiling all your clinical documentation requirements.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Please refer to Blackboard to review the Clinical Guidelines, Clinical Courses, Organizations, and Groups. There is a large quantity of information that you need to become familiar with. As per the Clinical Guidelines, you should review and keep ' +
            'track of all documentation expiration dates and update them at least 6 weeks prior to the start of a rotation in order to be permitted to continue with your rotations.');
            SMTPMail.AppendtoBody('Prior to starting FM1/IM1 students are required to attend an Online Mandatory Meeting. During the meeting you will be informed of some important aspects of the supplemental program for FM1/IM1. An email confirming the date of the Online Mandatory Meeting will be sent to students 3 to 4 weeks prior to the FM1/IM1 start date.');
            SMTPMail.AppendtoBody('<br>');
            IF RSL."Hospital Name" = 'WRHE-Trumbull Regional Medical Center' then
                SMTPMail.AppendtoBody('Questions about orientation information for this site should be referred to Teresa Wilson (Teresa.Wilson@steward.org). Her phone number is <b>(330) 884-3573</b>.')
            else
                SMTPMail.AppendtoBody('Questions about orientation information for this site should be referred to Mariel Gutierrez (mariguti@fiu.edu). Her phone number is <b>305-348-0658</b>.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('All other questions should be referred to your Clinical Document Specialist.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<b><u>Immigration Information:</u></b><br>');
            SMTPMail.AppendtoBody('For International and Canadian students, you will be required to present hospital and school letters to immigration officials before you will be allowed entry into the United States for your Clinical rotations. These letters are essential in helping to secure the visas you will need throughout your rotations. ' +
            'Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University. <b>As soon as you are confirmed for a rotation</b>, send an email requesting your immigration letters to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org.  DO NOT request an immigration letter directly from the hospital. ' +
            'It is your responsibility to notify Mr. Gonzalez of your need for these letters. Late submissions run the very real risk of not being fulfilled.');
            SMTPMail.AppendtoBody('<b><u><br><br>Student Portfolio Information:</u></b><br>');
            SMTPMail.AppendtoBody('Please note that upon completion of the FM1/IM1 program, students have to submit the following mandatory documents: the portfolio, the mid-clerkship evaluation, the student clerkship evaluation, and the student faculty evaluation through the link provided in the Portfolios and Evaluations section under “Courses” on Blackboard. ' +
            'To submit portfolio documents, log into Blackboard and find the “Courses” category on the top right-side of Blackboard.  Once you are in a course, find the Portfolios and Evaluations section in the box on the left side.  Click on the form you are submitting.  On the form, there is a blank that says “Name of Rotation” or “Clerkship Type” ' +
            'either click on the drop-down arrow where there is a choice for FM1/IM1 or select the bullet for core where you can then select FM1/IM1 from the drop-down list under core.  Once you have completed the document, scroll to the bottom of the page and click submit. If these documents are not submitted in this manner, ' +
            'you will be requested to re-submit as described above.');
            SMTPMail.AppendtoBody('<b><u><br><br>US Department of Health & Human Sciences online Cultural Competency Program:</u></b><br>');
            SMTPMail.AppendtoBody('This course is mandated by the Executive Dean of Clinical Sciences.<br>');
            SMTPMail.AppendtoBody('This program is free of charge, commercial free, and consists of three courses. Each course has a pretest, the coursework, and a posttest. It is quite informative. You should allow three hours for completion of each course, for a total of nine hours. ' +
            'Do not attempt to complete the total of three courses in one sitting; rather, space the work over two weeks.');
            SMTPMail.AppendtoBody('<b><u><br><br>To access the program:</u></b><br>');
            SMTPMail.AppendtoBody('1) Go to web address: <a href="https://www.thinkculturalhealth.hhs.gov">thinkculturalhealth.hhs.gov</a><br>');
            SMTPMail.AppendtoBody('2) Click on the Education drop down and choose Physicians<br>');
            SMTPMail.AppendtoBody('3) Click on and complete the program titled: A physician''s Practical Guide to Culturally Competent Care<br><br>');
            SMTPMail.AppendtoBody('<b>Please complete this program by the end of FM1/IM1</b><br><br><br>');
            SMTPMail.AppendtoBody('Best regards,<br><br><br><br><br>');
            SMTPMail.AppendtoBody('<b>Melissa Morell</b><br>Executive Director for Clinical Sciences Administration<br>mmorell@auamed.org<br>');
            SMTPMail.AppendtoBody('p: (212) 661-8899, ext. 167<br>f: (646) 390-4947');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody(CompanyInformation.Name + ' Representative for ' + EducationSetup."Institute Name");
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(CompanyInformation.Address + ', ' + CompanyInformation."Address 2");
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(CompanyInformation."Home Page");
            SMTPMail.AppendtoBody('<br><br><br><br>');
            SMTPMail.AppendtoBody('<p style="font-size:10px">DISCLAIMER:<br></p>');
            SMTPMail.AppendtoBody('<p style="font-size:9px">This message is for the named person''s use only.  It may contain confidential, proprietary or legally privileged information.  No confidentiality or privilege is waived or lost by any mis-transmission.  ' +
            'If you receive this message in error, please immediately delete it and all copies of it from your system, destroy any hard copies of it and notify the sender.  ' +
            'You must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message if you are not the intended recipient. ' +
            'Manipal Education of Americas, LLC Agent  for American University of Antigua College of Medicine, and any of its subsidiaries each reserve the right to monitor all e-mail communications through its networks. ' +
            'Any views expressed in this message are those of the individual sender, except where the message states otherwise and the sender is authorized to state them to be the views of any such entity.</p>');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'FM1-IM1 Final Site Confirmation Email', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure DocumentUpdatesDue(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        SDA: Record "Student Document Attachment";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        //ExpiryUptoDate: Date;
        ExpiredDocuments: Text;
        I: Integer;
        Char10: Char;
        Char13: Char;
        NewLine: Text[10];
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("Clinical Coordinator");
        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        Char10 := 10;
        Char13 := 13;
        NewLine := format(Char10) + format(Char13);

        // ExpiryUptoDate := 0D;
        // ExpiryUptoDate := WorkDate() + 60 + 1;
        ExpiredDocuments := '';

        I := 0;
        SDA.Reset();
        SDA.SetCurrentKey("Student No.");
        SDA.SetCurrentKey("Student No.");
        SDA.SetRange("Student No.", StudentMaster."No.");
        SDA.SetFilter("Document Status", '<>%1', SDA."Document Status"::"On File");
        SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
        if SDA.FindSet() then
            repeat
                I += 1;
                if ExpiredDocuments = '' then
                    ExpiredDocuments := Format(I) + '. ' + SDA."Document Description"
                else
                    ExpiredDocuments := ExpiredDocuments + '<br>' + Format(I) + '. ' + SDA."Document Description";
            until SDA.Next() = 0;

        if ExpiredDocuments = '' then
            exit;

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");
        end;
        // else
        //     Error('User Setup not found for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        // WindowDialog.Open('Updates to Clinical Document Updates Due Mail..\' + Text001Lbl);
        // WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        MailSubject := 'Immediate Action Required - Document Updates Due';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Below is the list of pending documents, please submit these in an unsecured PDF format through the portal <a href="https://portal.auamed.org">https://portal.auamed.org</a> as soon as possible:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(ExpiredDocuments);
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please refer to the portal <a href="https://portal.auamed.org">https://portal.auamed.org</a> for the full list of documents that are missing, expired or scheduled to expire.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards, <br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('***Important NOTICE, please read***<br><br>');
            SMTPMail.AppendtoBody('Per, AUA requirements it is the students’ responsibility to review and keep track of their documentations expiration dates.');
            SMTPMail.AppendtoBody('Expiring documents must be on file 6 weeks prior to the rotation start date in accordance to signed Clinical Clerkship Placement Attestation form. ');
            SMTPMail.AppendtoBody('Hospitals reserve the right to request a more recent record of your health documentation. ');
            SMTPMail.AppendtoBody('Please ensure that you are reviewing the specific hospital requirements on Blackboard in comparison to your documentation expiration dates to ensure that you are AUA and Hospital compliant prior to the rotation start date.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('*Additional documentation may be requested if any document is not accepted. Be advised that some hospitals’ requirements differ from AUA’s requirements, ' +
            'if a student is scheduled for such hospital(s), the student will be sent a courtesy reminder.*');

            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Email of missing or expired required documents', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            // WindowDialog.Close();
        end;
    end;

    procedure NewElectiveRequest(ROA: Record "Rotation Offer Application")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(ROA."Student No.") then;
        StudentMaster.TestField("Clinical Coordinator");

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        if UserSetup."E-Mail" <> '' then begin
            Recipient := UserSetup."E-Mail";
            Recipients := Recipient.Split(';');
        end
        else
            Recipient := 'MMORELL@AUAMED.NET';

        WindowDialog.Open('Sending New Elective Request Mail..\' + Text001Lbl);
        WindowDialog.Update(1, ROA."Student Name" + '-' + ROA."Student No.");

        StudentMaster.TestField("E-Mail Address");
        CCRecipient := StudentMaster."E-Mail Address";
        CCRecipients := CCRecipient.Split(';');

        MailSubject := 'New Elective Request';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ' + User."Full Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please note that ' + StudentMaster."Student Name" + ' Student ID: ' + StudentMaster."No." + ' has submitted an elective request(s) through the portal.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Rotation Description: ' + ROA."Rotation Description");
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Hospital Name: ' + ROA."Hospital Name");
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Rotation Period: ' + Format(ROA."Start Date") + ' to ' + Format(ROA."End Date"));
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Duration: ' + Format(ROA."No. of Weeks") + ' Weeks.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", UserSetup."User ID", User."Full Name", MailSubject, Body, 'Notifications to coordinator when a new request is submitted/updated', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure UpdatesToClinicalDocumentsRequired(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        SDA: Record "Student Document Attachment";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        ExpiryUptoDate: Date;
        ExpiredDocuments: Text;
        I: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;
        StudentMaster.TestField("Clinical Coordinator");

        ExpiryUptoDate := WorkDate() + 60;
        ExpiredDocuments := '';

        I := 0;
        SDA.Reset();
        SDA.SetCurrentKey("Student No.");
        SDA.SetCurrentKey("Student No.");
        SDA.SetRange("Student No.", StudentMaster."No.");
        SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
        SDA.SetFilter("Expiry Date", '%1..%2', WorkDate(), ExpiryUptoDate);
        if SDA.FindSet() then
            repeat
                I += 1;
                if ExpiredDocuments = '' then
                    ExpiredDocuments := Format(I) + '. ' + SDA."Document Description"
                else
                    ExpiredDocuments := ExpiredDocuments + '<br>' + Format(I) + '. ' + SDA."Document Description";
            until SDA.Next() = 0;

        if ExpiredDocuments = '' then
            exit;

        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");
        end;
        // else
        //     Error('User Setup not found for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        // WindowDialog.Open('Updates to Clinical Documents Required Mail..\' + Text001Lbl);
        // WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        MailSubject := 'Updates to Expiring Clinical Documents Required';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please refer to the portal <a href="https://portal.auamed.org">https://portal.auamed.org</a> for the list of documents that are missing, ' +
            'expired or scheduled to expire within the next six months.<br><br> You must submit your documents in an unsecured PDF format through the portal <a href="https://portal.auamed.org">https://portal.auamed.org</a>. <br><br>');
            SMTPMail.AppendtoBody('As a courtesy, the list of your documents that are scheduled to expire within the next six months is below:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(ExpiredDocuments);
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your assigned Clinical Document Specialist will review the submission and send you a confirmation email with a status for each piece of required documentation. Documents are reviewed within 5 business days of your submission. ');
            SMTPMail.AppendtoBody('Documents that are expired or will expire must be updated and approved 6 weeks prior to the start of a scheduled rotation. Please be sure to submit your documents on time to avoid any rotation cancellations, as well as, ' +
            'potential academic and/or financial repercussions associated with the abandonment of a rotation.');
            SMTPMail.AppendtoBody('All students should become familiar with the Policy on Clinical Clerkships found in the Clinical Guidelines. All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. ');
            SMTPMail.AppendtoBody('Your Student ID number must also be present in the signature of your email. <br><br>');
            SMTPMail.AppendtoBody('For further details, kindly visit the portal <a href="https://portal.auamed.org">https://portal.auamed.org</a>.<br><br>');
            SMTPMail.AppendtoBody('Regards,<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Notification about the expiry of document - Before 60 days of expiry', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            // WindowDialog.Close();
        end;
    end;

    procedure ClinicalHOLDNotificationDocumentExpire(StudentNo: Code[20])
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        SDA: Record "Student Document Attachment";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        ExpiryUptoDate: Date;
        ExpiredDocuments: Text;
        I: Integer;
        Char10: Char;
        Char13: Char;
        NewLine: Text[10];
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        Char10 := 10;
        Char13 := 13;
        NewLine := format(Char10) + format(Char13);

        ExpiryUptoDate := WorkDate() + 90;
        ExpiredDocuments := '';

        I := 0;
        SDA.Reset();
        SDA.SetCurrentKey("Student No.");
        SDA.SetCurrentKey("Student No.");
        SDA.SetRange("Student No.", StudentMaster."No.");
        SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
        SDA.SetFilter("Expiry Date", '%1..%2', WorkDate(), ExpiryUptoDate);
        if SDA.FindSet() then
            repeat
                I += 1;
                if ExpiredDocuments = '' then
                    ExpiredDocuments := Format(I) + '. ' + SDA."Document Description"
                else
                    ExpiredDocuments := ExpiredDocuments + NewLine + Format(I) + '. ' + SDA."Document Description";
            until SDA.Next() = 0;

        if ExpiredDocuments = '' then
            exit;

        StudentMaster.TestField("Clinical Coordinator");
        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");
        end;
        // else
        //     Error('User Setup not found for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Clinical HOLD Notification Mail..\' + Text001Lbl);
        WindowDialog.Update(1, StudentMaster."Student Name" + '-' + StudentMaster."No.");

        MailSubject := 'Clinical HOLD Notification';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Be advised that there is a Clinical Hold on your account due to documents that are expired ' +
            'will expire within the next 90 days. Please contact your assigned Clinical Document Specialist ' + UserSetup."E-Mail" + ' for more information.');
            SMTPMail.AppendtoBody('For your reference, your expired documents are noted below: ');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(ExpiredDocuments);
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('As a reminder, expiring documents must be on file 6 weeks prior to the rotation start date in accordance to signed ' +
            'Clinical Clerkship Placement Attestation form. Hospitals reserve the right to request a more recent record of your health documentation. ' +
            'Please ensure that you are reviewing the specific hospital requirements on Blackboard in comparison to your documentation expiration dates to ' +
            'ensure that you are AUA and Hospital compliant prior to the rotation start date.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('Clinical Sciences Administration');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Email to student notifying of hold and reason hold was placed', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure RotationCancellation(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clerkship Coordinator %1.', StudentMaster."Clinical Coordinator");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Sending Rotation Cancellation Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        StudentMaster.TestField("Clinical Coordinator");
        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        MailSubject := 'Rotation Cancellation';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + RSL."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please be aware that your ' + RSL."Rotation Description" + ' rotation at ' +
            RSL."Hospital Name" + ' beginning on ' + Format(RSL."Start Date") + ' has been cancelled.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Please review your updated schedule available on the Student Portal <a href ="https://portal.auamed.org">https://portal.auamed.org</a> to confirm the change is reflected correctly.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Notification to students  On changing the status of rotation', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure RotationCancellationNotice(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        EducationSetupCS: Record "Education Setup-CS";
        Recipient: Text;
        Recipients: List of [Text];
        // CCRecipient: Text[100];
        // CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Clerkship Coordinator %1.', StudentMaster."Clinical Coordinator");


        Recipient := UserSetup."E-Mail";

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist %1.', StudentMaster."Clinical Coordinator");
        end;
        Recipient := Recipient + ';' + UserSetup."E-Mail";

        EducationSetupCS.Reset();
        EducationSetupCS.Setfilter("Rotation Cancellation Email", '<>%1', '');
        IF EducationSetupCS.Findfirst then begin
            Recipient := Recipient + ';' + EducationSetupCS."Rotation Cancellation Email";
        end;
        Recipients := Recipient.Split(';');

        WindowDialog.Open('Sending Rotation Cancellation Notice Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        MailSubject := 'Rotation Cancelled After Rotation Start Date';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            //SMTPMail.AddCC(CCRecipients);
            SMTPMail.AppendtoBody('Please be aware that ' + RSL."Student Name" + ' Student ID# ' + RSL."Student No." + '''s ' + RSL."Rotation Description" + ' rotation at ');
            SMTPMail.AppendtoBody(RSL."Hospital Name" + ' beginning on ' + format(RSL."Start Date") + ' has been cancelled.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Sciences Administration.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", UserSetup."User ID", User."Full Name", MailSubject, Body, 'Notification to students  On changing the status of rotation', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure SiteSelectionFormHasBeenSubmitted(ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection)
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        UserSetupDS: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        CC_1Recipient: Text[100];
        CC_1Recipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(ClerkshipSiteAndDateSelection."Student No.") then;
        // StudentMaster.TestField("E-Mail Address");
        // StudentMaster.TestField("Document Specialist");

        User.Reset();
        User.SetRange("User Name", StudentMaster."FM1/IM1 Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', StudentMaster."FM1/IM1 Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."FM1/IM1 Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");
        end;
        // else
        //     Error('User Setup not found for the FM1/IM1 Coordinator %1.', StudentMaster."FM1/IM1 Coordinator");

        Recipient := UserSetup."E-Mail";
        Recipients := Recipient.Split(';');

        WindowDialog.Open('Sending FM1/IM1 Site Selection Mail..\' + Text001Lbl);
        WindowDialog.Update(1, ClerkshipSiteAndDateSelection."Student Name" + '-' + ClerkshipSiteAndDateSelection."Student No.");

        CCRecipient := StudentMaster."E-Mail Address";
        CCRecipients := CCRecipient.Split(';');

        // UserSetupDS.Reset();
        // if UserSetupDS.Get(StudentMaster."Document Specialist") then begin
        //     if UserSetupDS."E-Mail" = '' then
        //         Error('E-Mail does not updated on User Setup for the Document Specialist %1.', StudentMaster."Document Specialist");
        // end
        // else
        //     Error('User Setup not found for the Document Specialist %1.', StudentMaster."Document Specialist");

        CC_1Recipient := UserSetupDS."E-Mail";
        CC_1Recipients := CC_1Recipient.Split(';');

        MailSubject := 'Site Selection Form has been submitted';

        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            // if CCRecipients.Count > 0 then
            //     SMTPMail.AddCC(CCRecipients);
            // if CC_1Recipients.Count > 0 then
            //     SMTPMail.AddCC(CC_1Recipients);

            SMTPMail.AppendtoBody('Dear ' + User."Full Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please note that ' + ClerkshipSiteAndDateSelection."Student Name" + ' Student ID: ' + ClerkshipSiteAndDateSelection."Student No." + ' has submitted their Site Selection Form for ' +
            Format(ClerkshipSiteAndDateSelection."Preferred Start Date") + ' at ' + ClerkshipSiteAndDateSelection."First Preferred Site Name" + ' with ' + ClerkshipSiteAndDateSelection."Second Preferred Site Name" + ' as a backup.');
            // SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody('Preference 1: ' + ClerkshipSiteAndDateSelection."First Preferred Site Name");
            // SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody('Preference 2: ' + ClerkshipSiteAndDateSelection."Second Preferred Site Name");
            // SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody('Preference 3: ' + ClerkshipSiteAndDateSelection."Third Preferred Site Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(ClerkshipSiteAndDateSelection."Student Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", UserSetup."User ID", User."Full Name", MailSubject, Body, 'Site selection notification to FM1/IM1 coordinator', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure AcceptedClinicalDocument(SDA: Record "Student Document Attachment")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(SDA."Student No.") then;
        StudentMaster.TestField("E-Mail Address");
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");
        end;
        // else
        //     Error('User Setup not found for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;
        IF (SDA."Document Description" IN ['OTH - FM1-IM1 Site Selection Form', 'OTH - FIU FM1/IM1 Attestation Form']) then begin
            CCRecipient := CCRecipient + ';' + 'Kwashington@auamed.org';
            CCRecipients := CCRecipient.Split(';');
        end;
        WindowDialog.Open('Sending Clinical Document Approval Mail..\' + Text001Lbl);
        WindowDialog.Update(1, SDA."Student Name" + '-' + SDA."Student No.");

        MailSubject := 'Accepted Clinical Document';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + SDA."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('The status of your ' + SDA."Document Description" + ' has been updated to Accepted and will expire on ' + Format(SDA."Expiry Date") + '. For further details, kindly visit the portal https://portal.auamed.org.');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Administration');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Accepted Clinical Document', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure FirstCoreRotationNotificationEmail(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Cordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Cordinator ID %1.', StudentMaster."Clinical Coordinator");
        end;
        // else
        //     Error('User Setup not found for the Cordinator ID %1.', StudentMaster."Clinical Coordinator");

        if UserSetup."E-Mail" <> '' then begin
            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        WindowDialog.Open('Sending First Rotation Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");

        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        MailSubject := 'Rotation Notification';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('ManipalUniversity', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + RSL."Student Name" + ',');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You have been scheduled for ' + RSL."Rotation Description" + ' core at ' + RSL."Hospital Name" + ' starting ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please reply to your coordinator (listed below) with your acknowledgement of this placement. Failure to respond to your coordinator, does not excuse any student from their assigned rotation.');
            SMTPMail.AppendtoBody('Please note, an evaluation and portfolio must be submitted for all completed clerkships.  Final grades will not be available for clerkships with missing evaluations and or portfolios. You should ' +
            'receive an email through DocuSign at the start of each rotation. To gain access to evaluation or portfolio information please refer to your My Courses list posted on BlackBoard. A How-To Guide can be found in the ' +
            'Portfolios & Evaluations menu item under each corresponding course. This guide can also be found within the Clinical Guidelines. If a particular course is missing from your BlackBoard My Courses List, please email ' +
            'helpdesk@auamed.net and ask to be enrolled into the particular missing course(s).');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All students who started a core rotation on or after 8/1/13 will have to pass the corresponding core Clinical Core Subject Shelf Exam. Please note that you do NOT have to take the CCSSE ' +
            'for rotations you already passed. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. The meetings are scheduled ' +
            'on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed ' +
            'entry into the U.S. for your clinical clerkships. These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that ' +
            'hospitals require a minimum of four weeks to complete and return their letters to the University. As a result of this requirement, all students who need immigration paperwork are required to submit a ' +
            'request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). Failure to comply with this requirement may result in a ' +
            'delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships. To request your immigration paperwork, please send an email to ' +
            'Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. ' +
            'Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('*   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('*   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('*   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('*   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('*   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('*   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('*   Clinical guidelines');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email: helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If this is your first rotation in New York, please confirm that your ' +
            'clinical coordinator has received a copy of your New York State Letter. All clinical students ' +
            'MUST use their AUA email address when corresponding with their coordinator or document specialist. ' +
            'Your Student ID number must also be present in the signature of your email.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('Your Clinical Coordinator is: ' + UserSetup."E-Mail");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards,');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            SMTPMail.AppendtoBody('<br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            //SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'ManipalUniversity', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Emails that will be sent for Core Scheduling', MailSubject, RSL."Rotation ID", Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure OtherCoreRotationNotificationEmail(RSL: Record "Roster Scheduling Line")
    Var
        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;
        Recipient := StudentMaster."E-Mail Address";
        Recipients := Recipient.Split(';');

        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Document Specialist ID %1.', StudentMaster."Document Specialist");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Document Specialist") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Document Specialist ID %1.', StudentMaster."Document Specialist");

            CCRecipient := UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;

        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindLast() then
            if User."Full Name" = '' then
                Error('Full Name does not updated on User for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

        UserSetup.Reset();
        if UserSetup.Get(StudentMaster."Clinical Coordinator") then begin
            if UserSetup."E-Mail" = '' then
                Error('E-Mail does not updated on User Setup for the Clerkship Coordinator ID %1.', StudentMaster."Clinical Coordinator");

            CCRecipient := CCRecipient + ';' + UserSetup."E-Mail";
            CCRecipients := CCRecipient.Split(';');
        end;


        WindowDialog.Open('Sending First Rotation Mail..\' + Text001Lbl);
        WindowDialog.Update(1, RSL."Student Name" + '-' + RSL."Student No.");


        MailSubject := 'Rotation Notification';
        clear(Body);
        if Recipient <> '' then begin
            SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
            if CCRecipients.Count > 0 then
                SMTPMail.AddCC(CCRecipients);

            SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name");
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('In an effort to ensure all students are assigned cores needed in order to graduate, you have been scheduled for ' + RSL."Rotation Description" + ' at ' + RSL."Hospital Name" + ' starting ' + Format(RSL."Start Date") + ' for ' + Format(RSL."No. of Weeks") + ' weeks.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please reply to your coordinator (listed below) with your acknowledgement of this placement. Failure to respond to your coordinator, does not excuse any student from their assigned rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('All students must pass the corresponding Clinical Core Subject Shelf Exam for each of their cores. Please refer to the Clinical Guidelines for further information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Case vignettes provided by Aquifer have been proven to increase the in-depth knowledge of core rotation subject matters and improve students’ performance on NBME core and comprehensive shelf examinations as well as on USMLE Step 2 CK.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('AUA recommends to review ALL Aquifer case vignettes as well as those provided by Wise-MD for Surgery and those provided by APGO for OB/GYN.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('In order to further enhance students’ academic performance and foster the standardization of the curriculum across clinical sites, the following Aquifer cases are mandated for clinical core rotations in Internal Medicine, Family Medicine and Pediatrics starting on or after August 31, 2020:');
            SMTPMail.AppendtoBody('•	Internal Medicine         1, 2, 3, 4, 5, 6, 9, 12, 17, 19, 21, 24');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Family Medicine           1, 2, 6, 7, 8, 10, 11, 13, 16, 18, 26, 28');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('•	Pediatrics:                   1, 8, 10, 13, 16, 19, 21, 23, 27, 28, 31, 32');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Failure to complete the above listed case vignettes <u>during</u> the core rotation will result in withholding of the grade for that rotation.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>Accessing Aquifer:</u> Your name will be loaded into the Aquifer system before the start of core rotations in IM, FAM, PEDS and SUR.  For example, before the start of PEDSs, you will gain access to Aquifer Pediatrics.  You will only have access to the case studies in that section of Aquifer while you are enrolled in the rotation.  <u>Watch for an email from Aquifer with instructions on how to access and use the system</u>. If you don’t see an email, be sure to check your Junk folder to see if it is there.  <u>If you still don’t see a message, go to</u> https://uantigua-md.meduapp.com/users/sign_in.  At the bottom where it says “Need to register?” you should enter your AUA email address and the system will send you another welcome email to walk you through the registration process. If you’re still unable to access it, please contact:  helpdesk@auamed.org');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('If you haven’t already met with your assigned Clinical Coordinator, please make sure to reach out to them to schedule an in-person, Skype or telephone meeting. The meetings are scheduled on Wednesdays and the appointment will help get you acclimated to the scheduling process and provide answers to questions that you may have regarding the clinical portion of your education.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('For students who are International or Canadian citizens, you will be required to present Hospital and University letters to immigration and/or embassy officials before you will be allowed entry into the U.S. for your clinical clerkships. These letters are essential in helping to secure the visas you will need throughout the clinical science portion of your education. Please be aware that hospitals require a minimum of four weeks to complete and return their letters to the University.' +
            ' As a result of this requirement, all students who need immigration paperwork are required to submit a request to the Office of the Registrar as soon as they are confirmed for a clinical clerkship (minimum of 4 weeks prior to clerkship start date). Failure to comply with this requirement may result in a delay in the issuance of required paperwork which may cause students to be denied entry into the U.S. for their clerkships. To request your immigration paperwork, please send an email to Mr. Darwin Gonzalez, Assistant Registrar, at dgonzalez@auamed.org. Students are prohibited from requesting immigration letters directly from hospitals.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Please discuss with your Clinical Coordinator if you plan to take a clinical leave of absence to study for your exams. All requests must be made well in advance. Once you are scheduled for a clerkship, you will not be permitted to cancel it.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('You can consult Blackboard for all hospital orientation and reporting information.');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Use Blackboard for the following:');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Hospital reporting information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Orientation information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Important announcements');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   General hospital information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Housing information');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Non-affiliate resources');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('  *   Clinical guidelines');
            SMTPMail.AppendtoBody('<br>');
            SMTPMail.AppendtoBody('If you have issues with your Blackboard password, please email:helpdesk@auamed.net');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('<u>If this is your first rotation in New York, please confirm that your clinical coordinator has received a copy of your New York State Letter.All clinical students MUST use their AUA email address when corresponding with their coordinator or document specialist. Your Student ID number must also be present in the signature of your email.</u>');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody('Clinical Phone Number is 1-888-AUA-6002<br>Clinical Call hours are: 10am-12pm and 2pm-5pm');
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Your Clinical Coordinator is: ' + UserSetup."E-Mail");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('Best Regards,');
            SMTPMail.AppendtoBody('<br><br><br>');
            SMTPMail.AppendtoBody(User."Full Name");
            SMTPMail.AppendtoBody('<br><br>');
            SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // SMTPMail.AppendtoBody('<br><br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
            Body := SmtpMail.GetBody();
            SMTPMail.Send();
            EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Emails that will be sent for Core Scheduling', MailSubject, RSL."Rotation ID", Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
            WindowDialog.Close();
        end;
    end;

    procedure UploadLGSLetterOnSchoolDocs(RLE: Record "Roster Ledger Entry"; ManuallyCalled: Boolean)
    Var
        SMTPSetup: Record "Email Account";
        RLEReport: Record "Roster Ledger Entry";
        StudentMaster: Record "Student Master-CS";
        User: Record User;
        Tempblob: Record "TempBlob Test";
        SDA: Record "Student Document Attachment";
        SubjectMaster: Record "Subject Master-CS";
        SubjectPrefix: Record "Subject Prefix";
        locOutFile: BigText;
        IStream: InStream;
        LocalPath: Text;
        FileName: Text;
        CoordinatorName: Text[100];
        DocumentSpecialist: Text[100];
        ClerkType: Text[120];
        MemoryStream: DotNet NewImageStream;
        Bytes: DotNet Bytes;
        Convert: DotNet ImageConvert;
        DocCategory: Code[2048];
        DocSubCategory: Code[2048];
        ResponseText: Text;
        TransactionNo: Text[100];
        EntryNo: Integer;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RLE."Student ID") then;

        CoordinatorName := '';
        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindFirst() then
            CoordinatorName := User."Full Name";

        DocumentSpecialist := '';
        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindFirst() then
            DocumentSpecialist := User."Full Name";

        if RLE."Clerkship Type" = RLE."Clerkship Type"::Elective then
            ClerkType := 'ELE'
        else begin
            ClerkType := 'CORE';
            SubjectMaster.Reset();
            SubjectMaster.SetRange(Code, RLE."Course Code");
            if SubjectMaster.FindFirst() then
                if SubjectMaster."Subject Prefix" <> '' then begin
                    SubjectPrefix.Reset();
                    if SubjectPrefix.Get(SubjectMaster."Subject Prefix") then
                        ClerkType := SubjectPrefix.Description;
                end;
        end;

        LocalPath := 'C:\LGSLetter\';
        FileName := RLE."Student ID" + '_OTHLGS_' + CoordinatorName + '_' + RLE."Rotation Description" + '_' + RLE."Hospital Name" + '_' +
        DocumentSpecialist + '_' + Format(RLE."Start Date", 0, '<Month,2>-<Day,2>-<Year4>') + '_' + Format(RLE."End Date", 0, '<Month,2>-<Day,2>-<Year4>') + '_' + ClerkType + '.pdf';

        FileName := DelChr(FileName, '=', '/\&');

        RLEReport.Reset();
        RLEReport.Reset();
        RLEReport.SetRange("Entry No.", RLE."Entry No.");
        Report.SaveAsPdf(Report::"LGS Letter", LocalPath + FileName, RLEReport);

        Tempblob.Reset();
        Tempblob.DeleteAll();

        TempBlob.INIT();
        TempBlob.Blob.IMPORT(LocalPath + FileName);
        TempBlob.INSERT();
        TempBlob.Blob.CREATEINSTREAM(IStream);
        MemoryStream := MemoryStream.MemoryStream();
        COPYSTREAM(MemoryStream, IStream);
        Bytes := MemoryStream.GetBuffer();
        locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));

        DocCategory := 'OTH - Letter of Good Standing';
        DocSubCategory := 'OTH - Letter of Good Standing';

        ResponseText := SDA.UploadSchoolDoc(RLE."Student ID", DocSubCategory, FileName, Format(locOutFile));

        IF StrPos(ResponseText, '1</Success>') > 0 then begin
            TransactionNo := SDA.FindStringValue(ResponseText);

            SDA.Reset();
            if SDA.FindLast() then
                EntryNo := SDA."Entry No.";

            EntryNo += 1;

            SDA.Init();
            SDA."Entry No." := EntryNo;
            SDA."Document Category" := DocCategory;
            SDA."Document Sub Category" := DocSubCategory;
            SDA."Document Description" := DocSubCategory;
            SDA.Validate("Student No.", RLE."Student ID");
            SDA."Student Name" := StudentMaster."Student Name";
            SDA."Subject Code" := 'LGS';
            SDA."SLcM Document No" := 'LGS';
            SDA."Document Specialist ID" := StudentMaster."Document Specialist";
            SDA."Transaction No." := TransactionNo;
            SDA."File Name" := FileName;
            SDA."File Type" := 'pdf';
            SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
            SDA."Document Status" := SDA."Document Status"::Submitted;
            SDA."Submission Date" := Today;
            SDA."Uploaded By" := UserId;
            SDA."Uploaded On" := Today;

            SDA.Insert(true);

            RLE."LGS SchoolDocs Trn. No." := TransactionNo;
            RLE.Modify();
            if ManuallyCalled then
                Message('LGS Letter uploaded successfully.');
        end
        else
            Error('School Docs Error\%1', ResponseText);
    end;

    procedure SaveLGSLetter(RLE: Record "Roster Ledger Entry"; PathOfFile: Text)
    Var
        SMTPSetup: Record "Email Account";
        StudentMaster: Record "Student Master-CS";
        RLEReport: Record "Roster Ledger Entry";
        User: Record User;
        SubjectMaster: Record "Subject Master-CS";
        SubjectPrefix: Record "Subject Prefix";
        FileManagement: Codeunit "File Management";
        CoordinatorName: Text[100];
        DocumentSpecialist: Text[100];
        ClerkType: Text[20];
        ServerFileName: Text;
        FileName: Text;
    begin
        SMTPSetup.Reset();
        if SMTPSetup.Get() then;

        StudentMaster.Reset();
        if StudentMaster.Get(RLE."Student ID") then;

        CoordinatorName := '';
        User.Reset();
        User.SetRange("User Name", StudentMaster."Clinical Coordinator");
        if User.FindFirst() then
            CoordinatorName := User."Full Name";

        DocumentSpecialist := '';
        User.Reset();
        User.SetRange("User Name", StudentMaster."Document Specialist");
        if User.FindFirst() then
            DocumentSpecialist := User."Full Name";

        if RLE."Clerkship Type" = RLE."Clerkship Type"::Elective then
            ClerkType := 'ELE'
        else begin
            ClerkType := 'CORE';
            SubjectMaster.Reset();
            SubjectMaster.SetRange(Code, RLE."Course Code");
            if SubjectMaster.FindFirst() then
                if SubjectMaster."Subject Prefix" <> '' then begin
                    SubjectPrefix.Reset();
                    if SubjectPrefix.Get(SubjectMaster."Subject Prefix") then
                        ClerkType := SubjectPrefix.Description;
                end;
        end;

        ServerFileName := 'C:\LGSLetter\';
        FileName := RLE."Student ID" + '_OTHLGS_' + CoordinatorName + '_' + RLE."Rotation Description" + '_' + RLE."Hospital Name" + '_' +
        DocumentSpecialist + '_' + Format(RLE."Start Date", 0, '<Month,2>-<Day,2>-<Year4>') + '_' + Format(RLE."End Date", 0, '<Month,2>-<Day,2>-<Year4>') + '_' + ClerkType + '.pdf';
        FileName := DelChr(FileName, '=', '/\&');
        //FileName := Format(RLE."Entry No.") + '.pdf';

        RLEReport.Reset();
        RLEReport.SetRange("Entry No.", RLE."Entry No.");
        Report.SaveAsPdf(Report::"LGS Letter", ServerFileName + FileName, RLEReport);
        FileManagement.CopyServerFile(ServerFileName + FileName, PathOfFile + FileName, true);
        FileManagement.DeleteServerFile(ServerFileName + FileName);
    end;

    procedure EmailNotificationSave(Type_: text[50]; SenderName: Text[100]; SenderId: text[50];
        ReceiverId: Text[50]; ReceiverName: text[100]; Subject: text[200]; Text_: text;
        Process: Text[100]; Event_: text[100]; ProcessNo: text[50]; EDate: text[40]; ReceiverEmailId: text[100];
        SendEmail: Integer; EmailSent: Integer; EmailSentDatetime: text[40]; Mailitem_id: Integer; MobileNo: Text[20];
        SmsText: text[500]; SendSms: Integer; SmsSent: Integer; SmsSentDatetime: text[40])
    Var
        StudentMaster: Record "Student Master-CS";
        EmailNotification: Record "Email Notification";
        EmailNotification_1: Record "Email Notification";
        WebServicesFunctions: Codeunit WebServicesFunctionsCSL;
        LastEntryNo: Integer;
    begin
        EmailNotification_1.reset;
        EmailNotification_1.SetCurrentKey(Id);
        if EmailNotification_1.FindLast() then
            LastEntryNo := EmailNotification_1.Id;

        LastEntryNo := LastEntryNo + 1;

        EmailNotification.Init();
        EmailNotification.Id := LastEntryNo;
        EmailNotification.Type := Type_;
        EmailNotification."Sender Name" := SenderName;
        EmailNotification.SenderId := SenderId;
        EmailNotification.ReceiverName := ReceiverName;
        EmailNotification.ReceiverId := ReceiverId;
        EmailNotification.Subject := Subject;
        EmailNotification.Text_ := CopyStr(Text_, 1, 100);
        EmailNotification.Process := Process;
        EmailNotification.Event_ := CopyStr(Event_, 1, 100);
        EmailNotification."Process No" := ProcessNo;
        Evaluate(EmailNotification.EDate, EDate);
        EmailNotification."Receiver Email Id" := ReceiverEmailId;
        EmailNotification."Send Email" := SendEmail;
        EmailNotification."Email Sent" := EmailSent;
        Evaluate(EmailNotification."Email Sent Datetime", EmailSentDatetime);
        EmailNotification."Mail Item Id" := mailitem_id;
        EmailNotification.Insert();

        if UserId <> 'X250\MICROSOFT' then begin
            WebServicesFunctions.ApiPortalinsertupdatesendNotification(
            Type_, SenderName, SenderId, ReceiverName, ReceiverId,
            Subject, Text_, Process, Event_, ProcessNo, EDate,
            ReceiverEmailId, 1, MobileNo, '', 1);
        end;
    end;
    */
}