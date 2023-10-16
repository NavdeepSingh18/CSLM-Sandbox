codeunit 50005 "Event Of Academics -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   15/02/2019     EduCalendarMultiEventEntryINIT()-Function       Code added for insert multi event .
    // 02    CSPL-00059   15/02/2019     EduCalendarMultiEventEntryDEL()-Function        Code added for delete multi event.


    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 50301, 'OnAfterInsertEvent', '', false, false)]
    local procedure EduCalendarMultiEventEntryINIT(var Rec: Record "Education Multi Event Cal-CS"; RunTrigger: Boolean)
    var
        EduCalendarEntry: Record "Education Calendar Entry-CS";
    begin
        //Code added for insert multi event::CSPL-00059::15022019: Start

        EduCalendarEntry.Reset();
        EduCalendarEntry.SETRANGE(Code, Rec.Code);
        EduCalendarEntry.SETRANGE(Date, Rec.Date);
        IF EduCalendarEntry.FINDFIRST() THEN BEGIN
            EduCalendarEntry."Multi Event Exist" := TRUE;
            EduCalendarEntry.MODIFY();
        END;
        //Code added for insert multi event::CSPL-00059::15022019: End
    end;


    [EventSubscriber(ObjectType::Table, 50301, 'OnAfterDeleteEvent', '', false, false)]
    local procedure EduCalendarMultiEventEntryDEL(var Rec: Record "Education Multi Event Cal-CS"; RunTrigger: Boolean)
    var
        EduCalendarEntry: Record "Education Multi Event Cal-CS";
        EduCalendarEntry1: Record "Education Calendar Entry-CS";

    begin
        //Code added for delete multi event::CSPL-00059::15022019: Start
        EduCalendarEntry.Reset();
        EduCalendarEntry.SETRANGE(Code, Rec.Code);
        EduCalendarEntry.SETRANGE(Date, Rec.Date);
        IF EduCalendarEntry.COUNT() = 0 THEN BEGIN
            EduCalendarEntry1.Reset();
            EduCalendarEntry1.SETRANGE(Code, Rec.Code);
            EduCalendarEntry1.SETRANGE(Date, Rec.Date);
            IF EduCalendarEntry1.FINDFIRST() THEN BEGIN
                EduCalendarEntry1."Multi Event Exist" := FALSE;
                EduCalendarEntry1.MODIFY();
            END;
        END;
        //Code added for delete multi event::CSPL-00059::15022019: End
    end;


    [EventSubscriber(ObjectType::Table, 50365, 'OnAfterValidateEvent', 'Status', false, false)]
    Local procedure StudentWiseHoldsOnValidateStatus(VAR Rec: Record "Student Wise Holds"; VAR xRec: Record "Student Wise Holds"; CurrFieldNo: Integer)
    var
        StudentGroup: Record "Student Group";
    begin
        Rec."Modified By" := FORMAT(UserId());
        Rec."Modified On" := TODAY();
        Rec.Updated := true;
        //        if xRec.Status <> Rec.Status then begin
        if Rec.Status = Rec.Status::Enable then begin
            StudentGroup.AddStudentGroupCodeHoldWise(Rec);
            StudentGroup.EnableDisableGroupCodeHold(Rec, 1);
        end;
        if Rec.Status = Rec.Status::Disable then begin
            StudentGroup.EnableDisableGroupCodeHold(Rec, 2);
            StudentGroup.DeleteStudentGroupCodeHoldWise(Rec);
        end;
        //        end;
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    local procedure StudentSubOnAfterMod(var Rec: Record "Main Student Subject-CS"; var xRec: Record "Main Student Subject-CS"; RunTrigger: Boolean)
    begin
        Rec."Modified By" := Userid();
        Rec."Modified On" := today();

    end;

    // [EventSubscriber(ObjectType::Table, 472, 'OnAfterModifyEvent', '', false, false)]
    // Local procedure SendJobQueueErrorEmail(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry")
    // begin
    //     If (Rec.Status = Rec.Status::Error) or (xRec.Status = xRec.Status::Error) then
    //         SendJobQueueMail(Rec);
    // end;

    [EventSubscriber(ObjectType::Table, 50153, 'OnAfterModifyEvent', '', false, false)]
    Local procedure CheckAttendanceType(var Rec: Record "Internal Exam Line-CS"; var xRec: Record "Internal Exam Line-CS")
    begin
        If Rec."Attendance Type" = Rec."Attendance Type"::Absent then
            Rec."Obtained Internal Marks" := 0;
    end;

    // Local PRocedure SendJobQueueMail(Rec: Record "Job Queue Entry")
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInfo: Record "Company Information";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     CCs: List of [Text];
    //     CC: Text[100];
    // Begin
    //     SmtpMailRec.Get();
    //     CompanyInfo.Get();
    //     Rec.CalcFields("Object Caption to Run");
    //     Recipient := 'navdeep.singh@corporateserve.com;gaurav.kumar@corporateserve.com';
    //     //Recipient := 'navdeep.singh@corporateserve.com';
    //     Recipients := Recipient.Split(';');
    //     //CC := 'arvind.saini@corporateserve.com;kanchan.bhattacharya@corporateserve.com;dushyant.sharma@corporateserve.com;vikas.sharma@corporateserve.com';
    //     //cc := 'stuti.khandelwal@corporateserve.com;lucky.kumar@corporateserve.com;kanchan.bhattacharya@corporateserve.com';
    //     //CCs := CC.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";

    //     Subject := Format(Rec."Object Type to Run") + ' ' + Format(Rec."Object ID to Run") + ' Job Queue has been stopped.';

    //     SmtpMail.Create(Recipients, Subject, '', true);
    //     SmtpMail.AppendtoBody('Dear Team,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Environment : ' + Format(CompanyInfo."Custom System Indicator Text"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Object Type : ' + Format(Rec."Object Type to Run"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Object ID : ' + Format(Rec."Object ID to Run"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     //SmtpMail.AppendtoBody('Object Caption : ' + Format(Rec."Object Caption to Run"));
    //     SmtpMail.AppendtoBody('Start Date/Time : ' + Format(Rec."Earliest Start Date/Time"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Status : ' + Format(Rec.Status));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Error Message : ' + Format(Rec."Error Message"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Description : ' + Format(Rec.Description));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Business Central Administrator.');
    //     SmtpMail.Send();

    // End;
}

