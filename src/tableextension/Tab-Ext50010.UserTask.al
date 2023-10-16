tableextension 50010 UserTaskTabExt extends "User Task"
{

    fields
    {
        modify("Assigned To")
        {
            Trigger OnAfterValidate()
            var
                EducationSetup: Record "Education Setup-CS";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                IF EducationSetup.FindFirst() then begin
                    EducationSetup.TestField("User Task No.");
                    If "Document No." = '' then
                        "Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."User Task No.", Today, true);
                end;

            end;
        }
        modify("User Task Group Assigned To")
        {
            trigger OnAfterValidate()
            var
                EducationSetup: Record "Education Setup-CS";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                IF EducationSetup.FindFirst() then begin
                    EducationSetup.TestField("User Task No.");
                    If "Document No." = '' then
                        "Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."User Task No.", Today, true);
                end;
            end;
        }
        modify("Percent Complete")
        {
            trigger OnAfterValidate()
            var
                EducationSetup: Record "Education Setup-CS";
                NoSeriesMgmt: Codeunit NoSeriesManagement;

            begin
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                IF EducationSetup.FindFirst() then begin
                    EducationSetup.TestField("User Task No.");
                    If "Document No." = '' then
                        "Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."User Task No.", Today, true);
                end;
                If "Percent Complete" <> 0 then begin
                    // If Rec."Percent Complete" <> Rec."Per. Com. per User" then
                    //     Error('Assigned Task percentage is : %1%.', Rec."Per. Com. per User");
                    IF xRec."Percent Complete" <> Rec."Percent Complete" then begin
                        //UserTaskPerCompletionMail(UserId());
                        "Last Modified By" := UserId();
                        "Last Modified On" := Today();
                        IF Rec."Percent Complete" = 100 then begin
                            Validate(Statuss, 'COMPLETED');
                            // "Percent Complete" := 100;
                            "Completed By" := UserSecurityId();
                            "Completed DateTime" := CurrentDateTime();
                        end;
                        Message('%1% Task has been completed ', "Percent Complete");
                    end;
                end;

            end;
        }
        modify("Completed By")
        {
            trigger OnAfterValidate()
            var
                EducationSetup: Record "Education Setup-CS";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                IF EducationSetup.FindFirst() then begin
                    EducationSetup.TestField("User Task No.");
                    If "Document No." = '' then
                        "Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."User Task No.", Today, true);
                end;

            end;
        }
        field(50000; Statuss; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            TableRelation = "Reason Code" where(Type = filter("User Task"));
        }
        Field(50001; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        Field(50002; "Last Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50003; "Last Modified By"; Code[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "Per. Com. per User"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage Completion per User';
        }
        Field(50500; "Attachment Exist"; Boolean)
        {
            FieldClass = Flowfield;
            CalcFormula = Exist("Student Document Attachment" where("SLcM Document No" = field("Document No.")));
            Editable = false;
        }
        field(50501; "No. of Attachment"; Integer)
        {
            FieldClass = Flowfield;
            CalcFormula = Count("Student Document Attachment" where("SLcM Document No" = field("Document No.")));
            Editable = false;
        }



    }
    keys
    {
        key(Key2; "Last Modified On")
        {

        }
    }

    trigger OnAfterInsert()
    var
        EducationSetup: Record "Education Setup-CS";
        USerSetup: Record "User Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin

        USerSetup.Reset();
        USerSetup.SetRange("User ID", UserId());
        IF USerSetup.FindFirst() then
            IF Not USerSetup."User Task Permission" then
                Error('You are not authorised to access this process!');

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        IF EducationSetup.FindFirst() then begin
            EducationSetup.TestField("User Task No.");
            If "Document No." = '' then
                "Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."User Task No.", Today, true);
        end;

    end;

    trigger OnAfterModify()
    begin
        "Last Modified By" := UserId();
        "Last Modified On" := Today();
    end;



    // procedure PendingUserTaskEmail()
    // Var
    //     SmtpMailRec: Record "Email Account";
    //     Users_lRec: Record User;
    //     UserTaskGroup: Record "User Task Group Member";
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[250];
    //     GroupName: Text;
    //     USerTaskPersonName: Text;
    // begin
    //     SmtpMailRec.Get();
    //     USerTaskPersonName := '';
    //     GroupName := '';
    //     IF Rec."User Task Group Assigned To" <> '' then begin
    //         UserTaskGroup.Reset();
    //         UserTaskGroup.SetRange("User Task Group Code", Rec."User Task Group Assigned To");
    //         If UserTaskGroup.FindSet() then begin
    //             repeat
    //                 UserTaskGroup.CalcFields("User Name");
    //                 If Recipient = '' then begin
    //                     UserSetup.Reset();
    //                     UserSetup.SetRange("User ID", UserTaskGroup."User Name");
    //                     IF UserSetup.FindFirst() then begin
    //                         Recipient := UserSetup."E-Mail";
    //                         Users_lRec.Reset();
    //                         Users_lRec.SetRange("User Name", UserSetup."User ID");
    //                         If Users_lRec.FindFirst() then
    //                             GroupName := Users_lRec."Full Name";
    //                     end;
    //                 end Else begin
    //                     UserSetup.Reset();
    //                     UserSetup.SetRange("User ID", UserTaskGroup."User Name");
    //                     IF UserSetup.FindFirst() then begin
    //                         Recipient += ';' + UserSetup."E-Mail";
    //                         Users_lRec.Reset();
    //                         Users_lRec.SetRange("User Name", UserSetup."User ID");
    //                         If Users_lRec.FindFirst() then
    //                             GroupName += ', ' + Users_lRec."Full Name";
    //                     end;
    //                 end;
    //             until UserTaskGroup.next() = 0;
    //         end;

    //     end Else begin
    //         CalcFields("Assigned To User Name");
    //         UserSetup.Reset();
    //         UserSetup.SetRange("User ID", Rec."Assigned To User Name");
    //         IF UserSetup.FindFirst() then begin
    //             Recipient := UserSetup."E-Mail";
    //             Users_lRec.Reset();
    //             Users_lRec.SetRange("User Name", UserSetup."User ID");
    //             If Users_lRec.FindFirst() then
    //                 GroupName := Users_lRec."Full Name";
    //         end;
    //     end;

    //     CalcFields("Created By User Name");
    //     UserSetup.Reset();
    //     UserSetup.SetRange("User ID", Rec."Created By User Name");
    //     IF UserSetup.FindFirst() then begin
    //         Users_lRec.Reset();
    //         Users_lRec.SetRange("User Name", UserSetup."User ID");
    //         If Users_lRec.FindFirst() then
    //             USerTaskPersonName := Users_lRec."Full Name";
    //     end;

    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'User Task ' + Rec.Title + ' has been Assigned';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear ' + GroupName + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(USerTaskPersonName + ' has assigned you the following new task:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Subject : ' + Rec.Title);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Due Date : ' + Format(Rec."Due DateTime"));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Priority : ' + Format(Rec.Priority));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('SLCM System Administrator');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('User Task Assignment', 'MEA', SenderAddress, '',
    //     '', Subject, BodyText, 'User Task Assignment', 'User Task Assignment', '', '',
    //     Recipient, 1, '', '', 1);
    // end;

    // procedure CompleteUserTaskEmail(UserIDTxt: Text)
    // Var
    //     SmtpMailRec: Record "Email Account";
    //     Users_lRec: Record User;
    //     UserTaskGroup: Record "User Task Group Member";
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[250];
    //     GroupName: Text;
    //     USerTaskPersonName: Text;
    // begin
    //     SmtpMailRec.Get();
    //     USerTaskPersonName := '';
    //     GroupName := '';
    //     CalcFields("Completed By User Name", "Created By User Name");
    //     UserSetup.Reset();
    //     UserSetup.SetRange("User ID", Rec."Created By User Name");
    //     IF UserSetup.FindFirst() then begin
    //         Recipient := UserSetup."E-Mail";
    //         Users_lRec.Reset();
    //         Users_lRec.SetRange("User Name", UserSetup."User ID");
    //         If Users_lRec.FindFirst() then
    //             USerTaskPersonName := Users_lRec."Full Name";
    //     end;

    //     Users_lRec.Reset();
    //     Users_lRec.SetRange("User Name", UserIDTxt);
    //     If Users_lRec.FindFirst() then
    //         GroupName := Users_lRec."Full Name";


    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'User Task ' + Rec.Title + ' has been Completed';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear ' + USerTaskPersonName + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(GroupName + ' has completed the below task.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Subject: ' + Rec.Title);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Status: ' + Rec.Statuss);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Completed Date : ' + Format(Rec."Completed DateTime"));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('MEA Administrator');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('User Task Completed', 'MEA', SenderAddress, '',
    //     '', Subject, BodyText, 'User Task Completed', 'User Task Completed', '', '',
    //     Recipient, 1, '', '', 1);
    // end;

    // procedure UserTaskPerCompletionMail(UserIDTxt: Text)
    // Var
    //     SmtpMailRec: Record "Email Account";
    //     Users_lRec: Record User;
    //     UserTaskGroup: Record "User Task Group Member";
    //     UserSetup: Record "User Setup";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[250];
    //     GroupName: Text;
    //     USerTaskPersonName: Text;
    // begin
    //     SmtpMailRec.Get();
    //     USerTaskPersonName := '';
    //     GroupName := '';
    //     CalcFields("Created By User Name");
    //     UserSetup.Reset();
    //     UserSetup.SetRange("User ID", Rec."Created By User Name");
    //     IF UserSetup.FindFirst() then begin
    //         Recipient := UserSetup."E-Mail";
    //         Users_lRec.Reset();
    //         Users_lRec.SetRange("User Name", UserSetup."User ID");
    //         If Users_lRec.FindFirst() then
    //             USerTaskPersonName := Users_lRec."Full Name";
    //     end;

    //     Users_lRec.Reset();
    //     Users_lRec.SetRange("User Name", UserIDTxt);
    //     If Users_lRec.FindFirst() then
    //         GroupName := Users_lRec."Full Name";


    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'User Task ' + Rec.Title + ' Completion Status';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear ' + USerTaskPersonName + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(GroupName + ' has updated the % completion for below task:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Subject: ' + Rec.Title);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Percentage Completion: ' + Format(Rec."Percent Complete"));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Status: ' + Rec.Statuss);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('MEA Administrator');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('User Task Assignment', 'MEA', SenderAddress, '',
    //     '', Subject, BodyText, 'User Task Assignment', 'User Task Assignment', '', '',
    //     Recipient, 1, '', '', 1);
    // end;

}