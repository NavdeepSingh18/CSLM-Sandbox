page 50773 "Student Status Change Manually"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    // SourceTable = "Student Master-CS";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(StudNumber; Stud."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Student No.';

                }
                field("Student Name"; Stud."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Enrollment No."; Stud."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field(ReasonCode; ReasonCode)
                {
                    Caption = 'Reason Code';
                    ApplicationArea = all;
                    TableRelation = "Reason Code".Code where(Type = filter(''));
                    trigger OnValidate()
                    begin
                        ReasonCodeRec.Reset();
                        if ReasonCodeRec.Get(ReasonCode) then
                            ReasonDescription := ReasonCodeRec.Description
                        else
                            ReasonDescription := '';
                    end;
                }
                field(ReasonDescription; ReasonDescription)
                {
                    Caption = 'Reason Description';
                    ApplicationArea = all;
                }
                field(CurrStatus; CurrStatus)
                {
                    ApplicationArea = all;
                    Caption = 'Current Status';
                    Editable = false;
                }
                field(NewStatus; NewStatus)
                {
                    ApplicationArea = All;
                    Caption = 'New Status';
                    //TableRelation = "Student Status".Code where("Global Dimension 1 Code" = filter("Global Dimension 1 Code"), Blocked = CONST(FALSE));
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        StudStatus: Record "Student Status";
                    begin
                        StudStatus.RESET();
                        if GD1 = '9000' then
                            StudStatus.SetFilter("Global Dimension 1 Code", '%1', '9000')
                        else
                            if GD1 = '9100' then
                                StudStatus.SetFilter("Global Dimension 1 Code", '%1', '9100')
                            else
                                if GD1 = '8000' then
                                    StudStatus.SetFilter("Global Dimension 1 Code", '%1', '8000');
                        StudStatus.SetRange(Blocked, false);
                        StudStatus.FINDSET();
                        IF PAGE.RUNMODAL(0, StudStatus) = ACTION::LookupOK THEN
                            NewStatus := StudStatus.Code;

                    end;

                    trigger OnValidate()
                    var
                        StudStatus: Record "Student Status";
                    begin
                        if NewStatus <> '' then begin
                            StudStatus.RESET();
                            if GD1 = '9000' then
                                StudStatus.SetFilter("Global Dimension 1 Code", '%1', '9000')
                            else
                                if GD1 = '9100' then
                                    StudStatus.SetFilter("Global Dimension 1 Code", '%1', '9100')
                                else
                                    if GD1 = '8000' then
                                        StudStatus.SetFilter("Global Dimension 1 Code", '%1', '8000');
                            StudStatus.SetRange(Blocked, false);
                            StudStatus.FindFirst();
                        end;
                    end;
                }

                field("Changed by"; Stud."Status Manually Changed by")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Changed On"; Stud."Status Manually Changed on")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field(NSDLWithdrawalDate; NSDLWithdrawalDate)
                {
                    Caption = 'NSLDS Withdrawal Date';
                    ApplicationArea = all;
                }
                field(DateofDetermination; DateofDetermination)
                {
                    Caption = 'Date Of Determination';
                    ApplicationArea = all;
                }
                field(LastDateofAttendance; LastDateofAttendance)
                {
                    Caption = 'Last Date Of Attendance';
                    ApplicationArea = all;
                }
                Field(DismissalDate; DismissalDate)
                {
                    Caption = 'Dismissal Date';
                    ApplicationArea = All;

                    // Trigger Onvalidate()
                    // Begin
                    //     IF DismissalDate < Today then
                    //         Error('Dismissal Date must be equal or greater than %1', Format(Today));
                    // End;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Confirm")
            {
                Caption = 'Confirm';
                Image = Confirm;
                PromotedCategory = Process;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SemesterMaster: Record "Semester Master-CS";
                    SLcMToSaleForce: Codeunit SLcMToSalesforce;
                    CodeUnit50004: Codeunit "Hold Bulk Upload";
                    WebServiceFn: Codeunit WebServicesFunctionsCSL;
                begin
                    IF UserSetup.GET(UserId()) THEN
                        IF not UserSetup."Change Status Allowed" THEN
                            Error('You are not authorized');


                    if Confirm('Do you want to change the Status to %1?', false, NewStatus) then begin
                        // if Status = NewStatus then
                        //     Error('Current and New Statuses are same'); //Code block due to melissa's Requirment dated 12th Apr 2021
                        If ReasonDescription = '' then
                            Error('Reason Description is mandatory');

                        if NewStatus = '' then
                            Error('New Status must not be blank.');

                        If (NewStatus In ['DIS', 'WITH']) then
                            IF DismissalDate = 0D then
                                Error('Dismissal Date must not be blank');

                        StudentStatus.Get(NewStatus, GD1);
                        if StudentStatus.Status in [StudentStatus.Status::Deceased, StudentStatus.Status::Dismissed,
                        StudentStatus.Status::Withdrawn, StudentStatus.Status::TWD, StudentStatus.Status::Suspension,
                        StudentStatus.Status::ELOA, StudentStatus.Status::CLOA] then begin
                            if NSDLWithdrawalDate = 0D then
                                Error('NSDL Withdrawal Date must have a value in it.');
                            if LastDateofAttendance = 0D then
                                Error('Last date of Attendance must have a value in it.');
                            if DateofDetermination = 0D then
                                Error('Date of Determination must have a value in it.');
                        end;

                        if StudentStatus.Status in [StudentStatus.Status::Graduated, StudentStatus.Status::"Pending Graduation",
                           StudentStatus.Status::"Re-Admitted"] then begin
                            if NSDLWithdrawalDate = 0D then
                                Error('NSDL Withdrawal Date must have a value in it.');
                        end;

                        if StudentStatus.Status in [StudentStatus.Status::SLOA] then begin
                            if LastDateofAttendance = 0D then
                                Error('Last date of Attendance must have a value in it.');
                            if DateofDetermination = 0D then
                                Error('Date of Determination must have a value in it.');
                        end;


                        TotalWeeks := 0;
                        RotationCompleted := false;
                        CKPassed := false;
                        if StudentStatus.Status in [StudentStatus.Status::"Pending Graduation"] then begin
                            RosterSchedulingLineRec.Reset();
                            RosterSchedulingLineRec.SetCurrentKey("Student No.", "Start Date");
                            RosterSchedulingLineRec.SetRange("Student No.", Stud."No.");
                            RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                            if RosterSchedulingLineRec.FindSet() then
                                repeat
                                    TotalWeeks := TotalWeeks + RosterSchedulingLineRec."No. of Weeks";
                                until RosterSchedulingLineRec.Next() = 0;
                            //Message('%1', TotalWeeks);

                            ClinicalCurriculumTxt := '';
                            ClinicalCurriculumInt := 0;
                            IF Stud."Clinical Curriculum" <> Stud."Clinical Curriculum"::" " then begin
                                ClinicalCurriculumTxt := Format(Stud."Clinical Curriculum");
                                If ClinicalCurriculumTxt <> '' then
                                    Evaluate(ClinicalCurriculumInt, ClinicalCurriculumTxt);
                            end;

                            if TotalWeeks >= ClinicalCurriculumInt then
                                RotationCompleted := true
                            else
                                Error('Rotation Weeks are not completed.');

                            // StudentSubjectExamRec.Reset();
                            // StudentSubjectExamRec.SetRange("Student No.", "No.");
                            // StudentSubjectExamRec.SetRange("Score Type", StudentSubjectExamRec."Score Type"::"STEP 2 CK");
                            // StudentSubjectExamRec.SetRange(Result, StudentSubjectExamRec.Result::Pass);
                            // if StudentSubjectExamRec.FindFirst() then
                            //     CKPassed := true
                            // else
                            //     Error('CK Exam is not Passed.');
                        end;

                        Stud.Status := NewStatus;

                        if Stud.Status <> '' then begin
                            StudentMsterRec.StatusOnvalidate(Stud);
                        end;
                        Stud.Validate("Status Manually Changed by", UserId());
                        Stud.Validate("Status Manually Changed on", today());
                        If LastDateofAttendance <> 0D then
                            Stud.LDA := LastDateofAttendance;
                        If NSDLWithdrawalDate <> 0D then
                            Stud."NSLDS Withdrawal Date" := NSDLWithdrawalDate;
                        IF DateofDetermination <> 0D then
                            Stud."Date Of Determination" := DateofDetermination;

                        xDismissalDate := 0D;
                        xDismissalDate := Stud."Dismissal Date";

                        IF DismissalDate <> 0D then
                            Stud."Dismissal Date" := DismissalDate;

                        //CSPL-00307
                        IF Stud.Status IN ['WITH', 'DCL', 'DIS', 'DEF', 'DEC'] then begin
                            Stud."OLR Completed" := false;
                            Stud."OLR Completed Date" := 0D;
                            If Stud."Student Group" = Stud."Student Group"::"On-Ground Check-In" then
                                CodeUnit50004.OnGroundCheckInStudentGroupDisable(Stud."No.");
                            IF Stud."Student Group" = Stud."Student Group"::"On-Ground Check-In Completed" then
                                CodeUnit50004.OnGroundCheckInCompletedGroupDisable(Stud."No.");
                            Stud."Student Group" := Stud."Student Group"::" ";
                            Stud."On Ground Check-In By" := '';
                            Stud."On Ground Check-In On" := 0D;
                            Stud."On Ground Check-In Complete By" := '';
                            Stud."On Ground Check-In Complete On" := 0D;
                            Stud."OLR Email Sent" := false;
                            Stud."OLR Email Sent Date" := 0D;
                        end;

                        If Stud.Status = 'GRAD' then
                            WebServiceFn.ChangeUserRoleToGraduate(Stud);

                        Stud.Modify(True);

                        StatusChangeLogEntry.InsertRecordfun(Stud."No.", Stud."Student Name", CurrStatus, NewStatus, UserId(), Today(),
                        ReasonCode, ReasonDescription, Comment, NSDLWithdrawalDate, DateofDetermination, LastDateofAttendance, Today(), Today(), DismissalDate);

                        StudentTimeLine.InsertRecordFun(Stud."No.", Stud."Student Name", 'Student Status has been changed ' + CurrStatus + ' to ' + NewStatus,
                        UserId(), Today());

                        IF DismissalDate <> 0D then
                            StudentTimeLine.InsertRecordFun(Stud."No.", Stud."Student Name", 'Dismissal Date has been changed ' + Format(xDismissalDate) + ' to ' + format(DismissalDate),
                            UserId(), Today());

                        //CS:NAvdeep 05-08-2021=== Start
                        SLcMToSaleForce.StudentStatusSFInsert(Stud);
                        //CS:NAvdeep 05-08-2021=== End


                        IF NewStatus = 'ADWD' then begin  //18-Oct-2022
                            SemesterMaster.Reset();
                            SemesterMaster.Setrange(Code, Stud.Semester);
                            // IF SemesterMAster.Findfirst() then
                            //     IF SemesterMaster.Sequence <= 5 then
                            //         SendADWDMail(Stud."No.");
                        end;

                        // NoofDays := Today() - "Date Of Determination";
                        // "Estimated Graduation Date" := "Estimated Graduation Date" + NoofDays;

                        Message('Current Status has been changed to %1', NewStatus);
                        CurrPage.Close();
                    end
                    Else
                        Error('');
                end;
            }

            action("List of Rotations")
            {
                Caption = 'List of Rotation(s)';
                Image = EntriesList;
                PromotedCategory = Process;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.FilterGroup(2);
                    RSL.SetRange("Student No.", Stud."No.");
                    //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                    RSL.FilterGroup(2);
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                end;
            }

        }
    }
    var
        Stud: Record "Student Master-CS";
        StatusChangeLogEntry: Record "Status Change Log entry";
        ReasonCodeRec: Record "Reason Code";
        StudentStatus: Record "Student Status";
        UserSetup: Record "User Setup";
        StudentTimeLine: Record "Student Time Line";
        StudentMsterRec: Record "Student Master-CS";
        RosterSchedulingLineRec: Record "Roster Scheduling Line";
        StudentSubjectExamRec: Record "Student Subject Exam";
        TotalWeeks: Integer;
        RotationCompleted: Boolean;
        CKPassed: Boolean;
        NoofDays: Integer;
        ReasonCode: Code[10];
        ReasonDescription: Text[100];
        ClinicalCurriculumInt: Integer;
        ClinicalCurriculumTxt: Text;
        Comment: Text[255];
        NSDLWithdrawalDate: Date;
        LastDateofAttendance: Date;
        DateofDetermination: Date;
        NewStatus: code[20];
        CurrStatus: code[20];
        GD1: code[20];
        DismissalDate: Date;
        xDismissalDate: Date;


    trigger OnOpenPage()
    begin
        IF UserSetup.GET(UserId()) THEN
            IF not UserSetup."Change Status Allowed" THEN
                Error('You are not authorized');
    end;

    procedure GetStudent(StudNo: code[20])
    begin
        Stud.Reset();
        Stud.Get(StudNo);
        GD1 := Stud."Global Dimension 1 Code";
        CurrStatus := Stud.Status;
    end;

    // procedure SendADWDMail(StudNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     UserSetup_lRec: RECORD "User Setup";
    //     StudentStatusChangesADWD: Report StudentStatusChangesADWD;
    //     // tmpBlob: Codeunit "TempBlob Test";
    //     cnv64: Codeunit "Base64 Convert";
    //     SmtpMail: Codeunit "Email Message";
    //     WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCSL";
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     recRef: RecordRef;
    //     InStr: InStream;
    //     OutStr: OutStream;
    //     txtB64: Text;
    //     format: ReportFormat;
    //     NotifyTo: Text;
    //     BCCs: List of [Text];
    //     BCC: Text[200];

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudNo);
    //     //Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     //Recipient := Studentmaster."E-Mail Address";
    //     // Recipient := 'gaurav.kumar@corporateserve.com;stuti.khandelwal@corporateserve.com';
    //     Clear(UserSetup_lRec);
    //     UserSetup_lRec.Get(UserId);
    //     // UserSetup.TestField("E-Mail");
    //     // Recipient := UserSetup."E-Mail";
    //     Recipient := Studentmaster."E-Mail Address" + ';' + Studentmaster."Alternate Email Address";
    //     Recipients := Recipient.Split(';');
    //     BCC := 'registrar@auamed.net;registrar@auamed.org;studentaffairs@auamed.net;astevens@AUAMED.ORG';
    //     BCCs := BCC.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Student Status Update';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear ' + Studentmaster."First Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This letter is to inform you that you have been administratively withdrawn from the University. Please see attached and be guided accordingly.'); //+ Format(Studentmaster.Term) + ' ' + Studentmaster."Academic Year" + ' semester.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Sincerely,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Office of Registrar');
    //     SmtpMail.AppendtoBody('<br>');
    //     BodyText := SmtpMail.GetBody();
    //     BodyText := CopyStr(BodyText, 1, 2048);
    //     clear(StudentStatusChangesADWD);
    //     Clear(recRef);//GAURAV//18.8.22//
    //     recRef.GetTable(Studentmaster);
    //     tmpBlob.CreateOutStream(OutStr);
    //     StudentStatusChangesADWD.SetStudent_gFnc(Studentmaster."No.");
    //     StudentStatusChangesADWD.SetComment_gFnc(Comment);
    //     StudentStatusChangesADWD.SaveAs('', ReportFormat::Pdf, OutStr);
    //     tmpBlob.CreateInStream(InStr);
    //     SMTPMail.AddAttachmentStream(InStr, Studentmaster."Student Name" + ' - ' + Studentmaster."No." + '.pdf');
    //     If BCC <> '' then
    //         SmtpMail.AddBCC(BCCs);
    //     Mail_lCU.Send();
    //     WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('STUDENT STATUS', 'MEA', SenderAddress, Studentmaster."Student Name",
    //     Studentmaster."No.", Subject, BodyText, 'STATUS CHANGE TO ADWD', 'STATUS CHANGE TO ADWD', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // END;

}
