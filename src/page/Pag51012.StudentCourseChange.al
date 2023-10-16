page 51012 "Student Course Change"
{
    PageType = Card;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Student Master-CS";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                Field(CourseCode; CourseCode)
                {
                    Caption = 'New Course Code';
                    ApplicationArea = All;
                    TableRelation = "Course Master-CS" where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Reset Student")
            {
                ApplicationArea = All;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    StatucChangeLog_lRec: Record "Status Change Log entry";
                    StudentSubject_lRec: Record "Main Student Subject-CS";
                    EducationSetup_lRec: Record "Education Setup-CS";
                    UserSetup_lRec: Record "User Setup";
                    HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
                begin
                    UserSetup_lRec.Reset();
                    IF UserSetup_lRec.Get(UserId()) then
                        IF not UserSetup_lRec."Course Change Permission" then
                            Error('You do not have permission to perform this activity.');

                    EducationSetup_lRec.Reset();
                    EducationSetup_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    If EducationSetup_lRec.FindFirst() then begin
                        StudentSubject_lRec.Reset();
                        StudentSubject_lRec.SetRange("Student No.", Rec."No.");
                        StudentSubject_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
                        StudentSubject_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
                        If StudentSubject_lRec.FindFirst() then
                            Error('Please delete Student Subject for Academic Year %1 and Term %2.', EducationSetup_lRec."Returning OLR Academic Year", Format(EducationSetup_lRec."Returning OLR Term"));
                    end;

                    If not Confirm('Do you want to move student at previous stage?', false) then
                        exit;

                    Rec.Validate("Student Group", Rec."Student Group"::"On-Ground Check-In");
                    Rec."On Ground Check-In Complete By" := '';
                    Rec."On Ground Check-In Complete On" := 0D;
                    Rec."Registrar Signoff" := False;
                    StatucChangeLog_lRec.Reset();
                    StatucChangeLog_lRec.SetRange("Student No.", Rec."No.");
                    StatucChangeLog_lRec.SetRange("Status change to", 'ATT');
                    If StatucChangeLog_lRec.Findlast() then
                        If not (Rec.Status in ['PROB', 'REENTRY']) then
                            Rec.Validate(Status, StatucChangeLog_lRec."Status change From");
                    Rec.Modify();
                    HoldBulkUpload_lCU.OnGroundCheckInCompletedGroupDisable(Rec."No.");
                    Message('Student has been ready to course change.');

                end;

            }
            action("Course Change")
            {
                ApplicationArea = All;
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Enable;//GAURAV//5.12.22//
                trigger OnAction();
                var
                    StudentSubject_lRec: Record "Main Student Subject-CS";
                    EducationSetup_lRec: Record "Education Setup-CS";
                    UserSetup_lRec: Record "User Setup";
                    HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";
                begin
                    UserSetup_lRec.Reset();
                    IF UserSetup_lRec.Get(UserId()) then
                        IF not UserSetup_lRec."Course Change Permission" then
                            Error('You do not have permission to perform this activity.');

                    If CourseCode = '' then
                        Error('New Course Code must have a value.');

                    If Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In Completed" then
                        Error('On Ground Check in Completed for the Student %1.', Rec."No.");

                    EducationSetup_lRec.Reset();
                    EducationSetup_lRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    If EducationSetup_lRec.FindFirst() then begin
                        StudentSubject_lRec.Reset();
                        StudentSubject_lRec.SetRange("Student No.", Rec."No.");
                        StudentSubject_lRec.SetRange("Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
                        StudentSubject_lRec.SetRange(Term, EducationSetup_lRec."Returning OLR Term");
                        If StudentSubject_lRec.FindFirst() then
                            Error('Please delete Student Subject for Academic Year %1 and Term %2.', EducationSetup_lRec."Returning OLR Academic Year", Format(EducationSetup_lRec."Returning OLR Term"));
                    end;

                    If not Confirm('Do you want to change course %1 to %2 ?', false, Rec."Course Code", CourseCode) then
                        exit;

                    HoldBulkUpload_lCU.CourseChangeManually(Rec."No.", CourseCode, Rec);
                    SendEmail(Rec);
                    Message('Course has been change successfully.');
                end;
            }

            action("Course Change Clinical")//GAURAV//5.12.22//
            {
                ApplicationArea = All;
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = EnableCln;
                trigger OnAction()
                var
                    HoldBulkUpload_lCU: Codeunit "Hold Bulk Upload";

                begin
                    If not Confirm('Do you want to change course %1 to %2 ?', false, Rec."Course Code", CourseCode) then
                        exit;
                    HoldBulkUpload_lCU.CourseChangeClinicalManually(Rec."No.", CourseCode, Rec);
                    Message('Course has been change successfully.');

                end;//GAURAV END//5.12.22//
            }
        }
    }

    trigger OnAfterGetCurrRecord()//GAURAV//5.12.22//
    var
    begin
        SemesterMasterCS.Reset();
        SemesterMasterCS.SetRange(Code, Rec.Semester);
        IF SemesterMasterCS.FindFirst() then begin
            IF (SemesterMasterCS.Sequence = 1) OR (SemesterMasterCS.Sequence = 2) OR (SemesterMasterCS.Sequence = 3) OR (SemesterMasterCS.Sequence = 4) Or (SemesterMasterCS.Sequence = 5) Then
                Enable := true
            Else
                Enable := false;


            IF (SemesterMasterCS.Sequence = 6) OR (SemesterMasterCS.Sequence = 7) OR (SemesterMasterCS.Sequence = 8) OR (SemesterMasterCS.Sequence = 9) Or (SemesterMasterCS.Sequence = 10) or (SemesterMasterCS.Sequence = 11) or (SemesterMasterCS.Sequence = 12) Then
                EnableCln := true
            Else
                EnableCln := false;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SemesterMasterCS.Reset();
        SemesterMasterCS.SetRange(Code, Rec.Semester);
        IF SemesterMasterCS.FindFirst() then begin
            IF (SemesterMasterCS.Sequence = 1) OR (SemesterMasterCS.Sequence = 2) OR (SemesterMasterCS.Sequence = 3) OR (SemesterMasterCS.Sequence = 4) Or (SemesterMasterCS.Sequence = 5) Then
                Enable := true
            Else
                Enable := false;


            IF (SemesterMasterCS.Sequence = 6) OR (SemesterMasterCS.Sequence = 7) OR (SemesterMasterCS.Sequence = 8) OR (SemesterMasterCS.Sequence = 9) Or (SemesterMasterCS.Sequence = 10) or (SemesterMasterCS.Sequence = 11) or (SemesterMasterCS.Sequence = 12) Then
                EnableCln := true
            Else
                EnableCln := false;

        end;

    end;

    var
        SemesterMasterCS: Record "Semester Master-CS";
        Enable: Boolean;
        EnableCln: Boolean;//GAURAV END//5.12.22//
        CourseCode: Code[20];

    procedure SendEmail(StudentMasterRec: Record "Student Master-CS")
    Var
        SMTPSetup_lRec: Record "Email Account";
        AcademicsSetup_lRec: Record "Academics Setup-CS";
        EducationSetup_lRec: Record "Education Setup-CS";
        SMTP_lCU: Codeunit "Email Message";
        Subject_lTxt: Text;
        Body_lTxt: Text;
        EmailId_lTxt: Text;
        Recipients: List of [Text];
        CCEmailId_lTxt: Text;
        CCRecipients: List of [Text];
    begin
        SMTPSetup_lRec.Reset();
        AcademicsSetup_lRec.Reset();
        Clear(Recipients);
        EmailId_lTxt := '';
        Clear(SMTP_lCU);
        Clear(CCRecipients);
        CCEmailId_lTxt := '';

        SMTPSetup_lRec.Get();
        AcademicsSetup_lRec.Get();

        EducationSetup_lRec.Reset();
        EducationSetup_lRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
        IF EducationSetup_lRec.FindFirst() then;
        EducationSetup_lRec.TestField("To Bursar E-mail ID");


        //EmailId_lTxt := StudentMasterRec."E-Mail Address";
        IF EducationSetup_lRec."To Bursar E-mail ID" <> '' then begin
            EmailId_lTxt := EducationSetup_lRec."To Bursar E-mail ID";
            Recipients := EmailId_lTxt.Split(';');
        end;

        IF EducationSetup_lRec."CC Bursar E-mail ID" <> '' then begin
            CCEmailId_lTxt := EducationSetup_lRec."CC Bursar E-mail ID";
            CCRecipients := CCEmailId_lTxt.Split(';')
        end;

        Subject_lTxt := '';
        Body_lTxt := '';

        Subject_lTxt := 'Program Change Alert for ' + StudentMasterRec."No." + ' ' + StudentMasterRec."Student Name";

        // SMTP_lCU.Create('MEA', SMTPSetup_lRec."User ID", Recipients, Subject_lTxt, '', true);//GMCSCOM
        SMTP_lCU.AppendtoBody('Bursar,');
        SMTP_lCU.AppendtoBody('<br><br>');
        SMTP_lCU.AppendtoBody('Please note that ' + StudentMasterRec."Student Name" + ' Student No. ' + StudentMasterRec."No." + ' has been placed into the ' + StudentMasterRec."Course Name" + '. Please review their account to see if any transactions need to be added or reversed.');
        SMTP_lCU.AppendtoBody('<br><br>');
        // SMTP_lCU.AppendtoBody('You may also track status updates under "MSPE Application Status" page on your student portal.');
        // SMTP_lCU.AppendtoBody('<br><br>');
        SMTP_lCU.AppendtoBody('Thank you for your attention to this matter.');
        // IF CCEmailId_lTxt <> '' then
        //    SMTP_lCU.AddCC(CCRecipients);////GMCSCOM
        //    // SMTP_lCU.AppendtoBody('<br><br>');
        //    // SMTP_lCU.AppendtoBody('Regards');
        //    // SMTP_lCU.AppendtoBody('<br><br>');
        //    // SMTP_lCU.AppendtoBody('System Administrator');
        //    // SMTP_lCU.AppendtoBody('<br><br>');
        //    // SMTP_lCU.AppendtoBody('THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL');
        // SMTP_lCU.Send();//GMCSCOM

    end;

}
