tableextension 50534 "tableextension50534" extends "Job Queue Entry"
{
    // version NAVW19.00.00.45778-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    HandleExecutionError          Code added for Send Mail.

    //procedure HandleExecutionError();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetStatusValue(Status::Error);
    Modify();
    COMMIT;
    IF JobQueueSendNotification.RUN(Rec) THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetStatusValue(Status::Error);
    Modify();
    //Code added for Send Mail::CSPL-00136::02-05-2019: Start
    JobQueueLogEntry.Reset();
    JobQueueLogEntry.SETRANGE(ID,ID);
    JobQueueLogEntry.SETRANGE(Status,Status::Error);
    IF JobQueueLogEntry.FINDLAST() THEN
      ErrorMess := JobQueueLogEntry."Error Message";

    IF Status = Status::Error THEN BEGIN
      SenderName := 'ManipalUniversity';
      SenderAddress := 'donotreply.slcm@manipal.edu';
      Subject := Description +' '+ 'Service is Stop';

      SmtpMail.Create(SenderName,SenderAddress,'',Subject,'',TRUE);
      SmtpMail.AppendtoBody('Dear Sir/Ma'+''+'am,');
      SmtpMail.AppendtoBody('<br><br>');
      SmtpMail.AppendtoBody('SLcM & SFAS Integration Job Queue has Stopped, find the below error details:-');
      SmtpMail.AppendtoBody('<br>');
      SmtpMail.AppendtoBody('Error-' + ''+ ErrorMess);
      SmtpMail.AppendtoBody('<br>');
      SmtpMail.AppendtoBody('Please check the same in SLcM and start this Job Queue.');
      //SmtpMail.AppendtoBody('<br>');
      //SmtpMail.AppendtoBody('Thanking You');
      SmtpMail.AppendtoBody('<br><br>');
      SmtpMail.AppendtoBody('Regards,');
      SmtpMail.AppendtoBody('<br>');
      SmtpMail.AppendtoBody('Manipal Academy of Higher Education');
      JobQueueMailIDsCS.GET();
      //SmtpMail.AddRecipients('vineet.saroha@corporateserve.com');
      SmtpMail.AddRecipients(JobQueueMailIDsCS."Email-To");
      SmtpMail.AddCC(JobQueueMailIDsCS."Email-Cc 1");
      SmtpMail.AddCC(JobQueueMailIDsCS."Email-Cc 2");
      SmtpMail.AddCC(JobQueueMailIDsCS."Email-Cc 3");
      SmtpMail.TrySend();
    END;
    //Code added for Send Mail::CSPL-00136::02-05-2019: End
    COMMIT;
    IF JobQueueSendNotification.RUN(Rec) THEN;
    */
    //end;

    var
}

