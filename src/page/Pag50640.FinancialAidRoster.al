page 50640 "Financial Aid Roster"
{

    PageType = List;
    SourceTable = "Financial Aid Roster";
    Caption = 'Financial Aid Roster';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Fund Type"; Rec."Fund Type")
                {
                    ApplicationArea = All;
                }
                field("Uploaded Amount"; Rec."Uploaded Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                }
                field("Applies to Doc. Type"; Rec."Applies to Doc. Type")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Applies to Doc. No."; Rec."Applies to Doc. No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Financial Aid Roster Upload")
            {
                ApplicationArea = All;
                Caption = 'Financial Aid Roster Upload';
                Image = XMLFile;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    Roster: Record "Financial Aid Roster";
                begin
                    Xmlport.Run(50065, false, true, Roster);
                    CurrPage.Update();
                end;
            }

            action("Send For Approval")
            {
                ApplicationArea = All;
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        CurrPage.SetSelectionFilter(FinancialAidRosterRec);
                        IF FinancialAidRosterRec.FindSet() Then begin
                            repeat
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Bank Account No.");
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Student No.");
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Uploaded Amount");
                                FinancialAidRosterRec.TestField(FinancialAidRosterRec."Approved Amount");

                                Stud.Get(FinancialAidRosterRec."Student No.");

                                StudentStatusMangementCod.StudentGroupWiseRestriction(Rec."Student No.", RestrictionType::"Disbursement Hold");

                                If Stud.Semester <> FinancialAidRosterRec.Semester then
                                    Error('Semester must be %1 for Student No. %2', Stud.Semester, Stud."No.");

                                if Stud."Academic Year" <> FinancialAidRosterRec."Academic Year" then
                                    Error('Academic Year must be %1 for Student No. %2', Stud."Academic Year", Stud."No.");

                                if Stud."Financial Aid Approved" then begin
                                    FinancialAidRosterRec.Status := FinancialAidRosterRec.Status::"Pending for Approval";
                                    FinancialAidRosterRec.Modify();
                                end Else
                                    Error('This entry cannot be sent for Approval as Student''s Financial Aid Application either not available or not approved');
                            until FinancialAidRosterRec.Next() = 0;
                            // FinancialAidRosterUploadedMail();
                        end;
                    end;
                end;
            }
        }
    }

    var
        FinancialAidRosterRec: Record "Financial Aid Roster";
        //RecCustomer: Record Customer;
        Stud: Record "Student Master-CS";
        StudentStatusMangementCod: Codeunit "Student Status Mangement";
        RestrictionType: Option " ","Registration Hold","Transcript Hold","Portal Schedule Hold","Disbursement Hold","Housing Hold";
        Text001Lbl: Label 'Do you want to Send for Approval Financial Aid Roster ?';

    // procedure FinancialAidRosterUploadedMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     UserSetup: Record "User Setup";
    //     usersetupapprover: Record "Document Approver Users";
    //     SmtpMail: Codeunit "Email Message";
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     usersetupapprover.reset;
    //     usersetupapprover.SetRange("Department Approver Type", usersetupapprover."Department Approver Type"::"Bursar Department");
    //     if usersetupapprover.FindFirst() then begin
    //         UserSetup.Reset();
    //         UserSetup.SetRange("User ID", usersetupapprover."User ID");
    //         usersetup.SetFilter("E-Mail", '<>%1', '');
    //         UserSetup.FindFirst()
    //     end;

    //     // UserSetup.Reset();
    //     // UserSetup.SetRange("Department Approver", UserSetup."Department Approver"::"Bursar Department");
    //     // If UserSetup.FindFirst() Then
    //     //     UserSetup.TestField(UserSetup."Department Approver");

    //     Recipient := UserSetup."E-Mail";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Financial Aid Roster Uploaded';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear Sir' + ' ' + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that financial aid roster uploaded');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('financial aid Team');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //Mail_lCU.Send();
    // end;

    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}