codeunit 50054 BatchProcess
{
    trigger OnRun()
    var
        Date_lRec: Record Date;
    begin
        //Every Month 1 to 5 Date Academic Year & Term updated to Clinical Students
        Date_lRec.Reset();
        Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
        Date_lRec.SetRange("Period Start", Today());
        IF Date_lRec.FindFirst() then
            If (Date2DMY(Date_lRec."Period Start", 1) in [1 .. 5]) then
                UpdateClinicalStudentAcademicYearTerm();
        //Every Month 1 to 5 Date Academic Year & Term updated to Clinical Students

        //TWD Automation for Clinical Students runs every Monday
        Date_lRec.Reset();
        Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
        Date_lRec.SetRange("Period Name", 'Monday');
        Date_lRec.SetRange("Period Start", Today());
        If Date_lRec.FindFirst() then begin
            TWDStatusClinicalStudent();
            TWDStatusChangeBSIC();
        end;
        //TWD Automation for Clinical Students runs every Monday

    end;

    procedure UpdateClinicalStudentAcademicYearTerm()
    var
        StudentMaster_lRec: Record "Student Master-CS";
    Begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetFilter(Semester, '%1', 'CLN*');
        StudentMaster_lRec.SetFilter(Status, '%1|%2|%3|%4|%5|%6', 'ATT', 'PROB', 'CLOA', 'SLOA', 'TWD', 'SUS');
        IF StudentMaster_lRec.FindSet() then begin
            repeat
                IF (Date2DMY(Today(), 2) in [1 .. 6]) then begin
                    StudentMaster_lRec."Academic Year" := Format(Date2DMY(Today(), 3));
                    StudentMaster_lRec.Term := StudentMaster_lRec.Term::SPRING;
                    StudentMaster_lRec.Modify();
                end;
                IF (Date2DMY(Today(), 2) in [7 .. 12]) then begin
                    StudentMaster_lRec."Academic Year" := Format(Date2DMY(Today(), 3));
                    StudentMaster_lRec.Term := StudentMaster_lRec.Term::FALL;
                    StudentMaster_lRec.Modify();
                end;
            until StudentMaster_lRec.Next() = 0;

        end;
    End;

    procedure TWDStatusClinicalStudent()
    var
        TempRecord: Record "Temp Record";
    Begin
        MarkTWDStudents();
        MArkedStudent();

        TempRecord.Reset();
        TempRecord.SetRange("Unique ID", UserId());
        TempRecord.SetRange(Select, true);
        TempRecord.DeleteAll();
    End;

    procedure MarkTWDStudents()
    Var
        StudentMaster_lRec: Record "Student Master-CS";
        CourseMaster: Record "Course Master-CS";
        EducationSetup: Record "Education Setup-CS";
        TempREcord: Record "Temp Record";
        ClinicalCourse: Text;
        ClinicalSemester: Text;
        TWDApplicableCount: Integer;
    begin
        TempREcord.Reset();
        TempREcord.DeleteAll();

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        ClinicalCourse := '';
        CourseMaster.Reset();
        CourseMaster.SetRange("Clinical Clerkship Applicable", true);
        if CourseMaster.FindSet() then
            repeat
                if ClinicalCourse = '' then
                    ClinicalCourse := CourseMaster.Code
                else
                    ClinicalCourse := ClinicalCourse + '|' + CourseMaster.Code;
            until CourseMaster.Next() = 0;

        if ClinicalCourse = '' then
            ClinicalCourse := 'NA';

        ClinicalSemester := 'CLN5|CLN6|CLN7|CLN8';

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetFilter("Course Code", ClinicalCourse);
        StudentMaster_lRec.SetFilter(Semester, ClinicalSemester);
        StudentMaster_lRec.SetFilter(Status, EducationSetup."Active Statuses");
        IF StudentMaster_lRec.FindSet() then begin
            repeat
                If TWDAnalysis(StudentMaster_lRec."No.", true, false, TWDApplicableCount) = true then
                    TempTWDStudentList(StudentMaster_lRec);
            until StudentMaster_lRec.Next() = 0;

        end

    End;

    procedure TempTWDStudentList(StudentMaster: Record "Student Master-CS")
    var
        TempREcord: Record "Temp Record";
        EntryNo: Integer;
    Begin
        TempREcord.Reset();
        If TempREcord.FindLast() then
            EntryNo := TempREcord."Entry No" + 1
        Else
            EntryNo := 1;

        TempREcord.Init();
        TempREcord."Entry No" := EntryNo;
        TempREcord."Student ID" := StudentMaster."Original Student No.";
        TempREcord.Field2 := StudentMaster."No.";
        TempREcord."Enrollment No." := StudentMaster."Enrollment No.";
        TempREcord."Unique ID" := USerID();
        TempREcord.Select := true;
        TempREcord.Insert();
    End;

    procedure MArkedStudent()
    var
        TempREcord: Record "Temp Record";
        TWDApplicableCount: Integer;
    Begin
        TempREcord.Reset();
        TempREcord.SetRange("Unique ID", USerID());
        TempRecord.SetRange(Select, true);
        IF TempREcord.FindSet() then begin
            repeat
                TWDAnalysis(TempREcord.Field2, false, true, TWDApplicableCount);
            until TempREcord.Next() = 0;
        end;
    End;

    // procedure SendTWDEmail(StudentNo: Code[20])
    // var
    //     SMTPSetup: Record "Email Account";
    //     StudentMaster: Record "Student Master-CS";
    //     CompanyInformation: Record "Company Information";
    //     User: Record User;
    //     RSL: Record "Roster Scheduling Line";
    //     LDate: Record Date;
    //     StudentSubject: Record "Main Student Subject-CS";
    //     StudentSubject1: Record "Main Student Subject-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text[100];
    //     Recipients: List of [Text];
    //     MailSubject: Text;
    //     Body: Text;
    //     WindowDialog: Dialog;
    //     Text001Lbl: Label 'Student Name      ############1################\';
    //     LastDateOfAttendance: Date;
    //     FirstMondayDate: Date;
    //     bcc: Text[100];
    //     bccs: List of [Text];
    //     SixMonthDate: Date;

    // begin
    //     //WindowDialog.Open('Sending TWD Mail..\' + Text001Lbl);

    //     SMTPSetup.Reset();
    //     if SMTPSetup.Get() then;
    //     SixMonthDate := 0D;

    //     User.Reset();
    //     User.SetRange("User Name", UserId);
    //     if User.FindLast() then;

    //     StudentMaster.Reset();
    //     if StudentMaster.Get(StudentNo) then;

    //     RSL.Reset();
    //     RSL.SetCurrentKey("Student No.", "Start Date");
    //     RSL.SetRange("Student No.", StudentMaster."No.");
    //     RSL.SetFilter("Start Date", '<=%1&<>%2', Today, 0D);
    //     RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
    //     if RSL.FindLast() then
    //         if RSL."End Date" < Today then begin
    //             LastDateOfAttendance := RSL."End Date";
    //             LDate.Reset();
    //             LDate.SetRange("Period Type", LDate."Period Type"::Date);
    //             LDate.SetFilter("Period Start", '>%1', Today);
    //             LDate.SetFilter("Period Name", 'Monday');
    //             if LDate.FindFirst() then
    //                 FirstMondayDate := LDate."Period Start";
    //         end;

    //     IF RSL.IsEmpty then
    //         If LastDateOfAttendance = 0D then begin
    //             StudentSubject.Reset();
    //             StudentSubject.SetCurrentKey("End Date");
    //             StudentSubject.SetRange("Original Student No.", StudentMaster."Original Student No.");
    //             StudentSubject.SetRange(Semester, 'BSIC');
    //             StudentSubject.SetRange(TC, false);
    //             IF StudentSubject.FindLast() then begin
    //                 LastDateOfAttendance := StudentSubject."End Date";
    //                 LDate.Reset();
    //                 LDate.SetRange("Period Type", LDate."Period Type"::Date);
    //                 LDate.SetFilter("Period Start", '>%1', Today);
    //                 LDate.SetFilter("Period Name", 'Monday');
    //                 if LDate.FindFirst() then
    //                     FirstMondayDate := LDate."Period Start";
    //             end;
    //             IF StudentSubject.IsEmpty then begin
    //                 StudentSubject1.Reset();
    //                 StudentSubject1.SetCurrentKey("End Date");
    //                 StudentSubject1.SetRange("Original Student No.", StudentMaster."Original Student No.");
    //                 StudentSubject1.SetRange(Semester, 'MED4');
    //                 StudentSubject1.SetRange(TC, false);
    //                 IF StudentSubject1.FindLast() then begin
    //                     LastDateOfAttendance := StudentSubject1."End Date";
    //                     LDate.Reset();
    //                     LDate.SetRange("Period Type", LDate."Period Type"::Date);
    //                     LDate.SetFilter("Period Start", '>%1', Today);
    //                     LDate.SetFilter("Period Name", 'Monday');
    //                     if LDate.FindFirst() then
    //                         FirstMondayDate := LDate."Period Start";
    //                 end;
    //             end;
    //         end;

    //     SixMonthDate := CalcDate('<6M>', LastDateOfAttendance);

    //     //Recipient := StudentMaster."E-Mail Address";
    //     //Recipient := 'vikas.sharma@corporateserve.com';
    //     bcc := 'stuti.khandelwal@corporateserve.com;navdeep.singh@corporateserve.com';
    //     bccs := bcc.Split(';');

    //     Recipient := 'astevens@AUAMED.ORG';
    //     //Recipient := StudentMaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');

    //     //WindowDialog.Update(1, StudentMaster."No." + ' - ' + StudentMaster."Student Name");

    //     CompanyInformation.Reset();
    //     if CompanyInformation.Get() then;

    //     MailSubject := 'Student Status Update';
    //     clear(Body);
    //     if Recipient <> '' then begin
    //         SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);

    //         SMTPMail.AppendtoBody('Dear ' + StudentMaster."Student Name");
    //         SMTPMail.AppendtoBody('<br><br><br>');

    //         SMTPMail.AppendtoBody('The Office of the Registrar is responsible for tracking clinical enrollment, and informing students of extended breaks in their clinical schedule. This email is to confirm that your enrollment status has been changed to Temporarily Withdrawn (TWD) effective Friday, ' + format(LastDateOfAttendance) + ' (your last date of attendance) due to one of the following reasons:');
    //         SMTPMail.AppendtoBody('<ul>');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('<li>Your clinical schedule reflects that you have completed all scheduled clinical rotations but have no future rotations confirmed by your AUA Clinical Coordinator');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>Confirmation emails from hospitals does not equate to confirmation from your AUA Clinical Coordinator');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>You must contact your AUA Clinical Coordinator to receive official confirmation');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>Your status will be updated to Active (full-time) if you can schedule/adjust a rotation with your AUA Clinical Coordinator to start no later than ' + Format(SixMonthDate));
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>Please reach out to your AUA Clinical Coordinator to begin the scheduling process');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>Any rotations that start after Monday, ' + format(LastDateOfAttendance + 31) + ' will update your status to Active when you start that rotation');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>You have a break in your clinical schedule of more than 4 weeks, or you have not been approved for a Clinical Leave of Absence (CLOA)');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>CLOA applications must be submitted and approved before your last date of attendance:  Friday, ' + Format(LastDateOfAttendance) + ' but not after your last date of attendance');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li><b><u>Students on Academic Probation, Non-Academic Probation, or Professional Probation are ineligible to participate in the CLOA</u></b>');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody('<li>The TWD status will not impede your eligibility to register, schedule, or participate in any clinical comprehensive examinations or USMLE Step 2 examination');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('</ul>');
    //         SMTPMail.AppendtoBody('Please note the following policy regarding TWD status:');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('Students who enter a TWD status are not eligible for a Clinical Leave of Absence (CLOA) and are considered Withdrawn for Financial Aid purposes. Students reported to the National Student Loan Data System (NSLDS) as Withdrawn may enter repayment until they return to an approved clinical rotation. A TWD status, regardless of the reason, will also adversely impact federal aid eligibility. <b><u>Please contact the Office of Student Financial Services, studentfinancialservices@auamed.org, for more information on how a TWD status may impact your federal/private loans.</u></b>');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('Students on a TWD status are not eligible for an in-school deferment or an enrollment verification letter. Students who enter repayment while on this status should contact the Office of Student Financial Services and/or the federal servicer of their loans to discuss postponement of repayment options that may be available to them. Breaks of more than 4 weeks between scheduled rotations must also be disclosed and explained in residency interviews.');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('If you have no future rotations scheduled, please work with your clinical coordinator to schedule a clinical rotation as soon as possible. Please be aware that last minute schedule additions cannot be guaranteed and is at the discretion of the hospital. Per AUA policy, if you remain on a TWD status for more than 180 days you will be subject to administrative withdrawal from the University.');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('Upon returning from a TWD status into an approved clinical rotation, your enrollment status will be updated to Active (full-time). If you entered repayment and need to place your loans back on an in-school deferment, please submit a request to the Office of the Registrar at registrar@auamed.org.');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         SMTPMail.AppendtoBody('If you have any further questions or concerns regarding your enrollment status, you can reference the Student Handbook on the University’s website, http://auamed.org/student-life/guides/student-handbook/, or you can email me directly, for this is the best way to reach me. ');
    //         SMTPMail.AppendtoBody('<br><br><br>');
    //         SMTPMail.AppendtoBody('Sincerely,');
    //         SMTPMail.AppendtoBody('<br><br><br>');
    //         SMTPMail.AppendtoBody('_______________________');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         //SMTPMail.AppendtoBody('Office of the Registrar<br>Manipal Education Americas, LLC Representative for<br>American University of Antigua College of Medicine<br>40 Wall Street, 10th floor<br>New York, NY 10005<br>www.auamed.org');
    //         SMTPMail.AppendtoBody('Office of the Registrar<br>');
    //         SMTPMail.AppendtoBody('<br><br>');
    //         // SMTPMail.AppendtoBody('<p style="font-size:10px color:blue">DISCLAIMER:<br></p>');
    //         // SMTPMail.AppendtoBody('<p style="font-size:9px">This message is for the named person''s use only.  It may contain confidential, proprietary or legally privileged information.  No confidentiality or privilege is waived or lost by any mis-transmission.  ' +
    //         // 'If you receive this message in error, please immediately delete it and all copies of it from your system, destroy any hard copies of it and notify the sender.  ' +
    //         // 'You must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message if you are not the intended recipient. ' +
    //         // 'Manipal Education of Americas, LLC Agent  for American University of Antigua College of Medicine, and any of its subsidiaries each reserve the right to monitor all e-mail communications through its networks. ' +
    //         // 'Any views expressed in this message are those of the individual sender, except where the message states otherwise and the sender is authorized to state them to be the views of any such entity.</p>');
    //         // SMTPMail.AppendtoBody('<br><br>');
    //         // SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //         // SMTPMail.AppendtoBody('<br><br>THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //         If bcc <> '' then
    //             SMTPMail.AddBCC(bccs);
    //         Body := SmtpMail.GetBody();
    //         SMTPMail.Send();
    //         EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'Status Changed to TWD', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
    //         //WindowDialog.Close();
    //     end;
    // end;

    procedure EmailNotificationSave(Type_: text[50]; SenderName: Text[100]; SenderId: text[50];
        ReceiverId: Text[50]; ReceiverName: text[100]; Subject: text[200]; Text_: text;
        Process: Text[100]; Event_: text[100]; ProcessNo: text[50]; EDate: text[40]; ReceiverEmailId: text[100];
        SendEmail: Integer; EmailSent: Integer; EmailSentDatetime: text[40]; Mailitem_id: Integer; MobileNo: Text[20];
        SmsText: text[500]; SendSms: Integer; SmsSent: Integer; SmsSentDatetime: text[40])
    Var
        EmailNotification: Record "Email Notification";
        EmailNotification_1: Record "Email Notification";
        WebServicesFunctions: Codeunit WebServicesFunctionsCSL;
        LastEntryNo: Integer;
    begin
        EmailNotification_1.reset();
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

    procedure TWDAnalysis(StudentNo: Code[20]; ViewOnly: Boolean; TWDAction: Boolean; Var TWDApplicableCount: Integer) TWDApplicable: Boolean;
    var
        RSL: Record "Roster Scheduling Line";
        RSL_Next: Record "Roster Scheduling Line";
        RSL_Future: Record "Roster Scheduling Line";
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentSubject_lRec: Record "Main Student Subject-CS";
        StudentSubjectExam_lRec: Record "Student Subject Exam";
        RosterLedgerEntry_lRec: Record "Roster Ledger Entry";
        RosterLedgerEntry_lRec1: Record "Roster Ledger Entry";
        Date_lRec: Record Date;
        WeekStartDate: Date;
        BSICFound: Boolean;
        CBSEExamDate: Date;
        ToDateCheck: Date;
        WindowDialog: Dialog;
        TempStartDate: Date;
        TempEndDate: Date;
        Text001Lbl: Label 'Student Name      ############1################\';
        ClinicalCurriculum: Integer;
        TotalWeeks: Integer;
    begin
        WindowDialog.Open('Checking for TWD Status...\' + Text001Lbl);

        TWDApplicable := false;

        ClinicalCurriculum := 0;
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", StudentNo);
        if StudentMaster.FindFirst() then begin
            WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

            StudentStatus.Reset();
            StudentStatus.SetRange(Code, StudentMaster.Status);
            if StudentStatus.FindFirst() then;

            if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
            StudentStatus.Status::TWD,
            StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
            StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
            StudentStatus.Status::"Re-Entry", StudentStatus.Status::"Re-Admitted",
            StudentStatus.Status::Suspension]) then begin

                IF StudentMaster."Clinical Curriculum" <> StudentMaster."Clinical Curriculum"::" " then
                    Evaluate(ClinicalCurriculum, Format(StudentMaster."Clinical Curriculum"))
                Else
                    ClinicalCurriculum := 0;

                TotalWeeks := 0;
                RSL.Reset();
                RSL.SetCurrentKey("Student No.", "End Date");
                RSL.SetRange("Student No.", StudentMaster."No.");
                RSL.SetFilter("End Date", '<%1', Today());
                RSL.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                if RSL.FindSet() then
                    repeat
                        TotalWeeks := TotalWeeks + RSL."No. of Weeks";
                    until RSL.Next() = 0;

                If TotalWeeks >= ClinicalCurriculum then
                    exit(TWDApplicable);




                RSL.Reset();
                RSL.SetCurrentKey("Student No.", "Start Date");
                RSL.SetRange("Student No.", StudentMaster."No.");
                RSL.SetFilter("Start Date", '<=%1&<>%2', Today, 0D);
                RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                if RSL.FindLast() then
                    if RSL."End Date" < Today then begin
                        ToDateCheck := RSL."End Date" + 31;
                        RSL_Next.Reset();
                        RSL_Next.SetCurrentKey("Student No.", "Start Date");
                        RSL_Next.SetRange("Student No.", RSL."Student No.");
                        RSL_Next.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                        RSL_Next.SetFilter("Start Date", '%1..%2', RSL."End Date", ToDateCheck);
                        if not RSL_Next.FindFirst() then
                            TWDApplicable := true;
                    end;

                RSL_Future.Reset();
                RSL_Future.SetCurrentKey("Student No.", "Start Date");
                RSL_Future.SetRange("Student No.", RSL."Student No.");
                RSL_Future.SetFilter(Status, '%1', RSL.Status::Published);
                RSL_Future.SetFilter("End Date", '>%1', Today);
                if not RSL_Future.FindFirst() then
                    TWDApplicable := true;

                If StudentMaster.Semester = 'CLN5' then begin
                    RosterLedgerEntry_lRec.Reset();
                    RosterLedgerEntry_lRec.SetCurrentKey("Student ID", "Start Date");
                    RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                    RosterLedgerEntry_lRec.Setfilter("Start Date", '<=%1', Today());
                    RosterLedgerEntry_lRec.SetFilter("End Date", '>=%1', Today());
                    IF RosterLedgerEntry_lRec.FindLast() then begin
                        TWDApplicable := false;
                        Exit(TWDApplicable);
                    end;

                    RosterLedgerEntry_lRec.Reset();
                    RosterLedgerEntry_lRec.SetCurrentKey("Student ID", "Start Date");
                    RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                    RosterLedgerEntry_lRec.SetFilter("End Date", '<=%1', Today());
                    IF RosterLedgerEntry_lRec.FindLast() then begin
                        TempStartDate := RosterLedgerEntry_lRec."End Date";
                        IF TempStartDate <> 0D then
                            TempStartDate := CalcDate('31D', TempStartDate);

                        RosterLedgerEntry_lRec1.Reset();
                        RosterLedgerEntry_lRec1.SetCurrentKey("Student ID", "Start Date");
                        RosterLedgerEntry_lRec1.SetRange("Student ID", StudentMaster."No.");
                        RosterLedgerEntry_lRec1.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec1.Status::Cancelled);
                        RosterLedgerEntry_lRec1.Setfilter("Start Date", '<=%1', TempStartDate);
                        RosterLedgerEntry_lRec1.SetFilter("End Date", '>=%1', TempStartDate);
                        If RosterLedgerEntry_lRec1.FindLast() then begin
                            TWDApplicable := false;
                            TempStartDate := 0D;
                            exit(TWDApplicable);

                        end;
                    end;


                    BSICFound := false;
                    StudentSubject_lRec.Reset();
                    StudentSubject_lRec.SetCurrentKey("End Date");
                    StudentSubject_lRec.Ascending(false);
                    StudentSubject_lRec.SetRange("Original Student No.", StudentMaster."Original Student No.");
                    //StudentSubject_lRec.SetRange(Course, StudentMaster."Course Code");
                    StudentSubject_lRec.SetRange(Semester, 'BSIC');
                    // StudentSubject_lRec.SetRange("Academic Year", StudentMaster."Academic Year");
                    // StudentSubject_lRec.SetRange(Term, StudentMaster.Term);
                    If StudentSubject_lRec.FindFirst() then begin
                        BSICFound := true;
                        TempStartDate := StudentSubject_lRec."End Date";
                    end;

                    If not BSICFound then begin
                        StudentSubject_lRec.Reset();
                        StudentSubject_lRec.SetCurrentKey("End Date");
                        StudentSubject_lRec.Ascending(false);
                        StudentSubject_lRec.SetRange("Original Student No.", StudentMaster."Original Student No.");
                        //StudentSubject_lRec.SetRange(Course, StudentMaster."Course Code");
                        StudentSubject_lRec.SetRange(Semester, 'MED4');
                        // StudentSubject_lRec.SetRange("Academic Year", StudentMaster."Academic Year");
                        // StudentSubject_lRec.SetRange(Term, StudentMaster.Term);
                        If StudentSubject_lRec.FindFirst() then
                            TempStartDate := StudentSubject_lRec."End Date";
                    end;

                    IF TempStartDate <> 0D then
                        TempEndDate := CalcDate('<3W>', TempStartDate);


                    WeekStartDate := 0D;
                    StudentSubjectExam_lRec.Reset();
                    StudentSubjectExam_lRec.SetCurrentKey("Sitting Date");
                    StudentSubjectExam_lRec.SetRange("Student No.", StudentMaster."No.");
                    StudentSubjectExam_lRec.SetRange("Score Type", StudentSubjectExam_lRec."Score Type"::CBSE);
                    StudentSubjectExam_lRec.SetRange("Sitting Date", TempStartDate, TempEndDate);
                    IF StudentSubjectExam_lRec.FindLast() then begin
                        CBSEExamDate := StudentSubjectExam_lRec."Sitting Date";
                        RosterLedgerEntry_lRec.Reset();
                        RosterLedgerEntry_lRec.SetRange("Clerkship Type", RosterLedgerEntry_lRec."Clerkship Type"::"FM1/IM1");
                        RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                        If RosterLedgerEntry_lRec.FindLast() then begin
                            CBSEExamDate := CalcDate('<180D>', CBSEExamDate);
                            If (CBSEExamDate >= RosterLedgerEntry_lRec."Start Date") or (CBSEExamDate <= RosterLedgerEntry_lRec."End Date") then begin
                                Date_lRec.Reset();
                                Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                                Date_lRec.SetRange("Period Start", CBSEExamDate);
                                If Date_lRec.FindFirst() then begin
                                    IF Date_lRec."Period Name" in ['Monday', 'Tuesday', 'Wednesday'] then begin
                                        IF Date_lRec."Period Name" = 'Monday' then
                                            WeekStartDate := CBSEExamDate;
                                        If Date_lRec."Period Name" = 'Tuesday' then
                                            WeekStartDate := CBSEExamDate - 1;
                                        If Date_lRec."Period Name" = 'Wednesday' then
                                            WeekStartDate := CBSEExamDate - 2;
                                    end;
                                    IF Date_lRec."Period Name" in ['Thursday', 'Friday', 'Saturday', 'Sunday'] then begin
                                        IF Date_lRec."Period Name" = 'Thursday' then
                                            WeekStartDate := CBSEExamDate + 4;
                                        If Date_lRec."Period Name" = 'Friday' then
                                            WeekStartDate := CBSEExamDate + 3;
                                        If Date_lRec."Period Name" = 'Saturday' then
                                            WeekStartDate := CBSEExamDate + 2;
                                        If Date_lRec."Period Name" = 'Sunday' then
                                            WeekStartDate := CBSEExamDate + 1;
                                    end;

                                end;

                            end;
                        end;

                        RosterLedgerEntry_lRec1.Reset();
                        RosterLedgerEntry_lRec1.SetRange("Student ID", StudentMaster."No.");
                        RosterLedgerEntry_lRec1.SetRange("Clerkship Type", RosterLedgerEntry_lRec1."Clerkship Type"::"FM1/IM1");
                        RosterLedgerEntry_lRec.SetRange("Start Date", WeekStartDate);
                        If RosterLedgerEntry_lRec1.FindLast() then begin
                            If RosterLedgerEntry_lRec1."Start Date" < Today() then
                                TWDApplicable := true;
                        end;
                    end;
                end;

                if TWDApplicable then
                    TWDApplicableCount := TWDApplicableCount + 1;

                if (TWDAction = true) and (TWDApplicable = true) then
                    StudentStatusChangeToTWD(StudentMaster."No.");

                if (ViewOnly = true) then
                    exit(TWDApplicable)
            end;
        end;
    end;

    procedure StudentStatusChangeToTWD(StudentNo: Code[20])
    var
        StudentMaster: Record "Student Master-CS";
        TWDStudentStatus: Record "Student Status";
    begin
        TWDStudentStatus.Reset();
        TWDStudentStatus.SetRange(Status, TWDStudentStatus.Status::TWD);
        if TWDStudentStatus.FindLast() then begin
            StudentMaster.Reset();
            StudentMaster.SetRange("No.", StudentNo);
            if StudentMaster.FindFirst() then begin
                StudentMaster.Validate(Status, TWDStudentStatus.Code);
                StudentMaster.Modify();
                //SendTWDEmail(StudentMaster."No.");
            end;
        end;
    end;

    Procedure TWDStatusChangeBSIC()
    var
        StudentMaster: Record "Student Master-CS";
        StudentSubject_lRec: Record "Main Student Subject-CS";
        StudentSubjectExam_lRec: Record "Student Subject Exam";
        RosterLedgerEntry_lRec: Record "Roster Ledger Entry";
        RosterLedgerEntry_lRec1: Record "Roster Ledger Entry";
        Date_lRec: Record Date;
        Date_lRec1: Record Date;
        TempStartDate: Date;
        TempEndDate: Date;
        CBSEExamDate: Date;
        WeekStartDate: Date;
        BSICFound: Boolean;
        StatusFilter: Text;
    begin
        StatusFilter := 'ATT|ENR|EXTLOA|LOA|PROB|SLOA';
        StudentMaster.Reset();
        StudentMaster.SetCurrentKey("Original Student No.");
        StudentMaster.SetRange(Semester, 'BSIC');
        StudentMaster.SetFilter(Status, StatusFilter);
        IF StudentMaster.FindSet() then begin
            repeat


                StudentSubject_lRec.Reset();
                StudentSubject_lRec.SetCurrentKey("End Date");
                StudentSubject_lRec.Ascending(false);
                StudentSubject_lRec.SetRange("Original Student No.", StudentMaster."Original Student No.");
                StudentSubject_lRec.SetRange(Course, StudentMaster."Course Code");
                StudentSubject_lRec.SetRange(Semester, StudentMaster.Semester);
                StudentSubject_lRec.SetRange("Academic Year", StudentMaster."Academic Year");
                StudentSubject_lRec.SetRange(Term, StudentMaster.Term);
                If StudentSubject_lRec.FindLast() then
                    TempStartDate := StudentSubject_lRec."End Date";

                IF TempStartDate <> 0D then
                    TempEndDate := CalcDate('<3W>', TempStartDate);


                WeekStartDate := 0D;
                StudentSubjectExam_lRec.Reset();
                StudentSubjectExam_lRec.SetCurrentKey("Sitting Date");
                StudentSubjectExam_lRec.SetRange("Student No.", StudentMaster."No.");
                StudentSubjectExam_lRec.SetRange("Score Type", StudentSubjectExam_lRec."Score Type"::CBSE);
                StudentSubjectExam_lRec.SetRange("Sitting Date", TempStartDate, TempEndDate);
                IF StudentSubjectExam_lRec.FindLast() then begin
                    CBSEExamDate := StudentSubjectExam_lRec."Sitting Date";
                    CBSEExamDate := CalcDate('<180D>', CBSEExamDate);
                    RosterLedgerEntry_lRec.Reset();
                    RosterLedgerEntry_lRec.SetRange("Clerkship Type", RosterLedgerEntry_lRec."Clerkship Type"::"FM1/IM1");
                    RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec.SetFilter("End Date", '<=%1', Today());
                    RosterLedgerEntry_lRec.SetRange(Status, RosterLedgerEntry_lRec.Status::Completed);
                    IF RosterLedgerEntry_lRec.FindLast() then
                        exit;

                    RosterLedgerEntry_lRec.Reset();
                    RosterLedgerEntry_lRec.SetRange("Clerkship Type", RosterLedgerEntry_lRec."Clerkship Type"::"FM1/IM1");
                    RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec.SetFilter("Start Date", '<=%1', CBSEExamDate);
                    RosterLedgerEntry_lRec.SetFilter("End Date", '>=%1', CBSEExamDate);
                    If RosterLedgerEntry_lRec.FindLast() then begin
                        Date_lRec.Reset();
                        Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                        Date_lRec.SetRange("Period Start", CBSEExamDate);
                        If Date_lRec.FindFirst() then begin
                            IF Date_lRec."Period Name" in ['Monday', 'Tuesday', 'Wednesday'] then begin
                                IF Date_lRec."Period Name" = 'Monday' then
                                    WeekStartDate := CBSEExamDate;
                                If Date_lRec."Period Name" = 'Tuesday' then
                                    WeekStartDate := CBSEExamDate - 1;
                                If Date_lRec."Period Name" = 'Wednesday' then
                                    WeekStartDate := CBSEExamDate - 2;
                            end;
                            IF Date_lRec."Period Name" in ['Thursday', 'Friday', 'Saturday', 'Sunday'] then begin
                                IF Date_lRec."Period Name" = 'Thursday' then
                                    WeekStartDate := CBSEExamDate + 4;
                                If Date_lRec."Period Name" = 'Friday' then
                                    WeekStartDate := CBSEExamDate + 3;
                                If Date_lRec."Period Name" = 'Saturday' then
                                    WeekStartDate := CBSEExamDate + 2;
                                If Date_lRec."Period Name" = 'Sunday' then
                                    WeekStartDate := CBSEExamDate + 1;
                            end;

                        end;


                    end;
                    IF RosterLedgerEntry_lRec.IsEmpty then begin
                        Date_lRec.Reset();
                        Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                        Date_lRec.SetRange("Period Start", CBSEExamDate);
                        If Date_lRec.FindFirst() then begin
                            IF Date_lRec."Period Name" in ['Monday', 'Tuesday', 'Wednesday'] then begin
                                IF Date_lRec."Period Name" = 'Monday' then
                                    WeekStartDate := CBSEExamDate;
                                If Date_lRec."Period Name" = 'Tuesday' then
                                    WeekStartDate := CBSEExamDate - 1;
                                If Date_lRec."Period Name" = 'Wednesday' then
                                    WeekStartDate := CBSEExamDate - 2;
                            end;
                            IF Date_lRec."Period Name" in ['Thursday', 'Friday', 'Saturday', 'Sunday'] then begin
                                IF Date_lRec."Period Name" = 'Thursday' then
                                    WeekStartDate := CBSEExamDate + 4;
                                If Date_lRec."Period Name" = 'Friday' then
                                    WeekStartDate := CBSEExamDate + 3;
                                If Date_lRec."Period Name" = 'Saturday' then
                                    WeekStartDate := CBSEExamDate + 2;
                                If Date_lRec."Period Name" = 'Sunday' then
                                    WeekStartDate := CBSEExamDate + 1;
                            end;

                        end;
                    end;

                    RosterLedgerEntry_lRec1.Reset();
                    RosterLedgerEntry_lRec1.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec1.SetRange("Clerkship Type", RosterLedgerEntry_lRec1."Clerkship Type"::"FM1/IM1");
                    RosterLedgerEntry_lRec.SetRange("Start Date", WeekStartDate);
                    If RosterLedgerEntry_lRec1.FindLast() then begin
                        // If RosterLedgerEntry_lRec1."Start Date" < Today() then
                        //     SendTWDMailBSIC(StudentMaster."No.");
                    end;
                    If RosterLedgerEntry_lRec1.IsEmpty then begin
                        // If CBSEExamDate < Today() then
                        //     SendTWDMailBSIC(StudentMaster."No.");
                    end;
                end;
                If not StudentSubjectExam_lRec.FindFirst() then
                    Exit;
            until StudentMaster.Next() = 0;
        end;

    End;

//     procedure SendTWDMailBSIC(StudNo: Code[20])
//     var
//         SmtpMailRec: Record "Email Account";
//         Studentmaster: Record "Student Master-CS";
//         SMTPMail: codeunit "Email Message";
//         Mail_lCU: Codeunit Mail;
//         WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCS";
//         BodyText: text;
//         SenderName: Text[100];
//         SenderAddress: Text[250];
//         Subject: Text[100];
//         Recipients: List of [Text];
//         Recipient: Text[100];
//         StudentStatusChangesADWD: Report StudentStatusChangesADWD;
//         BCC: Text[100];
//         BCCs: List of [Text];
//     begin
//         SmtpMailRec.Get();
//         Studentmaster.GET(StudNo);
//         Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
//         //Recipient := Studentmaster."E-Mail Address";
//         Recipient := 'wroberts@auamed.net';
//         Recipients := Recipient.Split(';');
//         BCC := 'stuti.khandelwal@corporateserve.com;navdeep.singh@corporateserve.com';
//         BCCs := BCC.Split(';');
//         SenderName := 'MEA';
//         SenderAddress := SmtpMailRec."Email Address";
//         Subject := 'Student Status Update';

//         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
//         IF not (Studentmaster.Semester IN ['BSIC']) then
//             exit;
//         SmtpMail.AppendtoBody('Dear Student,');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Based on the below mentioned AUA policy, which can be found in the AUA Student HandbookHandbook, this ' +
//                             'email is an official notification that your enrollment status at American University of Antigua has been ' +
//                             'updated to a status of “Temporary Withdrawn” (TWD):');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('<i>“Upon completion of BSIC Intersession (Basic Science Integration Course) students may need to take time ' +
// 'off to study USMLE Step 1 exam. Once students pass Step 1, they will be required to begin the next ' +
// 'available FM1/IM1 rotation. Students are allowed 6 months from the completion of the BSIC to take and ' +
// 'pass and pass the USMLE Step 1 exam and return to FM1/IM1. This is an approved break between BSIC ' +
// 'Intersession and FM1/IM1 in which students will remain enrolled full time.</i> <b>Students who do not return to FM1/IM1 within 6 months from the conclusion of BSIC will be subject to temporary withdrawal from the university.”</b>');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Your enrollment status has been updated to Temporary Withdrawal (TWD) effective your last date of attendance (' + Format(Studentmaster.LDA) + ')');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Please note the following policy regarding TWD status:');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Students who enter a TWD status are not eligible for a Clinical Leave of Absence (CLOA) and are considered Withdrawn for Financial Aid purposes. Students reported to the National Student Loan Data System (NSLDS) as Withdrawn may enter repayment until they return to an approved clinical rotation. A TWD status, regardless of the reason, will also adversely impact federal aid eligibility. <b>Please contact the Office of Student Financial Services, studentfinancialservices@auamed.org, for more information on how a TWD status may impact your federal/private loans.</b>');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Students on a TWD status are not eligible for an in-school deferment or an enrollment verification letter. Students who enter repayment while on this status should contact the Office of Student Financial Services and/or the federal servicer of their loans to discuss postponement of repayment options that may be available to them.');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Once you pass USMLE Step 1 and start the next available FM1/IM1, your enrollment status will be updated to Enrolled (full-time) when you start the FM1/IM1 course. Once you return- if you entered repayment and need to place your loans back on an in-school deferment, please submit a request to the Office of the Registrar at registrar@auamed.org.');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('For full coverage on these policies, please review the AUA Student Handbook, ');
//         SmtpMail.AppendtoBody('<br>');
//         SmtpMail.AppendtoBody('https://www.auamed.org/student-life/guides/student-handbook.');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Sincerely,');
//         SmtpMail.AppendtoBody('<br><br>');
//         SmtpMail.AppendtoBody('Office Of Registrar');
//         BodyText := SmtpMail.GetBody();
//         BodyText := DelChr(BodyText, '=', '<br><br>');
//         BodyText := CopyStr(BodyText, 1, 2048);
//         SmtpMail.AddBCC(BCCs);
//         SMTPmail.send();
//         WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('STUDENT STATUS', 'MEA', SenderAddress, Studentmaster."Student Name",
//         Studentmaster."No.", Subject, BodyText, 'STATUS CHANGE TO TWD', 'STATUS CHANGE TO TWD', '', '',
//         Recipient, 1, Studentmaster."Mobile Number", '', 1);
//     END;


}