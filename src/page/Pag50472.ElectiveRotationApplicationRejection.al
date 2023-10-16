page 50472 "Rotation Application Rejection"
{
    PageType = Card;
    Caption = 'Rotation Application Rejection';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group("Rotation Information")
            {
                group("Existing Rotation Information")
                {
                    field("Offer No."; Rec."Offer No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Hospital ID"; Rec."Hospital ID")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Application No."; Rec."Application No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Student No."; Rec."Student No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Enrollment No."; Rec."Enrollment No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Elective Course Code"; Rec."Elective Course Code")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Description"; Rec."Course Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Prefix"; Rec."Course Prefix")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Rotation Description"; Rec."Rotation Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("No. of Weeks"; Rec."No. of Weeks")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Reject Reason"; Rec."Reject Reason")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        ShowMandatory = true;
                    }
                    field("Reject Reason Description"; Rec."Reject Reason Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Confirm")
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not Confirm('Do you want to reject the Elective Rotation Application?') then begin
                        REc."Reject Reason" := '';
                        REc."Reject Reason Description" := '';
                        REc.Modify();
                        exit;
                    end;

                    REc.TestField("Reject Reason");
                    REc.TestField("Reject Reason Description");

                    // SendApplicationRejectMail();
                    REc.Validate(Status, REc.Status::Rejected);
                    REc.Validate("Approval Status", REc."Approval Status"::Rejected);
                    REc.Modify();
                    CALE.InsertLogEntry(7, 5, REc."Student No.", REc."Student Name", REc."Application No.", REc."Reject Reason", REc."Reject Reason Description", REc."Elective Course Code", REc."Rotation Description");
                    Message('Elective Rotation Application has been rejected.');
                    CurrPage.Close();
                end;
            }
            action("Future Rotation List")
            {
                ApplicationArea = All;
                Caption = 'Future Rotation List';
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetRange("Student No.", REc."Student No.");
                    RSL.SetFilter("Start Date", '>%1', REc."End Date");
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL);
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (REc."Reject Reason" <> '') and (REc.Status <> REc.Status::Rejected) then
            Error('You must Reject the Application OR Remove the Reject Reason.');
    end;
    /// <summary> 
    /// Description for SendApplicationRejectMail.
    /// </summary>
    // procedure SendApplicationRejectMail()
    // var
    //     StudentMasterCS: Record "Student Master-CS";
    //     CompanyInformation: Record "Company Information";
    //     SMTPMail: Codeunit "Email Message";
    //     Recipient: Text[100];
    //     Recipients: List of [Text];
    //     MailSubject: Text;
    //     Body: Text;
    // begin
    //     StudentMasterCS.Reset();
    //     if StudentMasterCS.Get(REc."Student No.") then;
    //     Recipient := StudentMasterCS."E-Mail Address";
    //     Recipients := Recipient.Split(';');

    //     CompanyInformation.Reset();
    //     if CompanyInformation.Get() then;

    //     MailSubject := 'Elective Rotation Application Rejected - ' + "Enrollment No." + ' ' + "Student Name";
    //     clear(Body);
    //     if Recipient <> '' then begin
    //         SMTPMail.Create('ElectiveRotationApplication', 'vikas.sharma@corporateserve.com', Recipients, MailSubject, Body, true);

    //         SMTPMail.AppendtoBody('Dear ' + "Student Name");
    //         SMTPMail.AppendtoBody('<br><br>');

    //         SMTPMail.AppendtoBody('This mail is regarding rejection of your Elective Rotation Application');
    //         SMTPMail.AppendtoBody('<br><br>');


    //         SMTPMail.AppendtoBody('<Table border="1">');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td style="font-weight:bold"> Offer No. </td>');
    //         SMTPMail.AppendtoBody('<td style="font-weight:bold">' + "Offer No." + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td style="font-weight:bold"> Clerkship Type </td>');
    //         SMTPMail.AppendtoBody('<td style="font-weight:bold">' + 'Elective Rotation' + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td style="font-weight:bold"> Entrollment No. </td>');
    //         SMTPMail.AppendtoBody('<td style="font-weight:bold"> ' + "Enrollment No." + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> Student Name </td>');
    //         SMTPMail.AppendtoBody('<td>' + "Student Name" + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> Subject Description</td>');
    //         SMTPMail.AppendtoBody('<td>' + "Course Description" + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> Rotation Description </td>');
    //         SMTPMail.AppendtoBody('<td>' + "Rotation Description" + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> Hospital Name </td>');
    //         SMTPMail.AppendtoBody('<td>' + Format("Hospital Name") + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> Start Date </td>');
    //         SMTPMail.AppendtoBody('<td>' + Format("Start Date") + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> End Date </td>');
    //         SMTPMail.AppendtoBody('<td>' + Format("End Date") + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('<tr>');
    //         SMTPMail.AppendtoBody('<td> Reject Reason </td>');
    //         SMTPMail.AppendtoBody('<td>' + Format("Reject Reason Description") + '</td>');
    //         SMTPMail.AppendtoBody('</tr>');

    //         SMTPMail.AppendtoBody('</Table border>');

    //         SMTPMail.AppendtoBody('<br><br><br>');
    //         SMTPMail.AppendtoBody('Regards');
    //         SMTPMail.AppendtoBody('<br>');
    //         SMTPMail.AppendtoBody(CompanyInformation.Name);
    //         //Mail_lCU.Send();
    //     end;
    // end;
}
