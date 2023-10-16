Page 50719 "Pending Leaves Approvals"
{

    PageType = List;
    SourceTable = "Leaves Approvals";
    Caption = 'Pending Leaves Approval Card';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTableView = Sorting("Application No.", "Line No.") order(descending) WHERE(Status = FILTER("Pending for Approval" | Rejected));
    Editable = false;
    CardPageId = "Leaves Approval Card";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
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

                field("Type of Leaves"; Rec."Type of Leaves")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Reason for Leave"; Rec."Reason for Leave")
                {
                    ApplicationArea = All;
                }
                field("Approved for Department"; Rec."Approved for Department")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Final Approval"; Rec."Final Approval")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Leave Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Leave Details';
                trigger OnAction()
                var
                    StudentLeaveAbsenceRec: Record "Student Leave of Absence";
                    SLOACardPag: Page "SLOA Card";
                    CLOACardPag: Page "CLOA Card";
                    ELOACardPag: Page "ELOA Card";
                begin
                    StudentLeaveAbsenceRec.Reset();
                    StudentLeaveAbsenceRec.SetRange("Application No.", Rec."Application No.");
                    IF StudentLeaveAbsenceRec.FindFirst() then begin
                        Case Rec."Type of Leaves" of
                            Rec."Type of Leaves"::SLOA:
                                begin
                                    SLOACardPag.SetTableView(StudentLeaveAbsenceRec);
                                    SLOACardPag.Editable := False;
                                    SLOACardPag.Run();
                                end;
                            Rec."Type of Leaves"::ELOA:
                                begin
                                    ELOACardPag.SetTableView(StudentLeaveAbsenceRec);
                                    ELOACardPag.Editable := False;
                                    ELOACardPag.Run();
                                end;
                            Rec."Type of Leaves"::CLOA:
                                begin
                                    CLOACardPag.SetTableView(StudentLeaveAbsenceRec);
                                    CLOACardPag.Editable := False;
                                    CLOACardPag.Run();
                                end;
                        end;

                    end;
                end;
            }
            action("Uploaded Document")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Uploaded Document';
                Runobject = page "Student Document Attachment";
                RunPageLink = "SLcM Document No" = FIELD("Application No.");
            }

        }
    }
    trigger OnOpenPage()
    var
        WithdrawalDepartmentRec: Record "Withdrawal Department";
        UserSetupRec: Record "User Setup";
        DepartmentName: Text;
        PrevDepart: Text;
    begin
        UserSetupRec.Get(UserId());
        //CSPL-00307-T1-T1516-CR Starts
        Clear(DepartmentName);
        WithdrawalDepartmentRec.Reset();
        WithdrawalDepartmentRec.SetCurrentKey("Department Code");
        IF Rec."Type of Leaves" = Rec."Type of Leaves"::ELOA then
            WithdrawalDepartmentRec.Setrange("Document Type", WithdrawalDepartmentRec."Document Type"::ELOA);
        IF Rec."Type of Leaves" = Rec."Type of Leaves"::SLOA then
            WithdrawalDepartmentRec.Setrange("Document Type", WithdrawalDepartmentRec."Document Type"::SLOA);
        IF Rec."Type of Leaves" = Rec."Type of Leaves"::CLOA then
            WithdrawalDepartmentRec.Setrange("Document Type", WithdrawalDepartmentRec."Document Type"::CLOA);
        // WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        IF WithdrawalDepartmentRec.GetUserGroup() <> '' then
            WithdrawalDepartmentRec.SetFilter("User Name", WithdrawalDepartmentRec.GetUserGroup())
        else
            WithdrawalDepartmentRec.SetFilter("User Name", '%1', '');
        WithdrawalDepartmentRec.SetAscending("Department Code", true);
        IF WithdrawalDepartmentRec.FindSet() then begin
            repeat
                IF PrevDepart <> WithdrawalDepartmentRec."Department Code" then begin
                    PrevDepart := WithdrawalDepartmentRec."Department Code";
                    IF DepartmentName = '' then
                        DepartmentName := WithdrawalDepartmentRec."Department Code"
                    ELSE
                        DepartmentName += '|' + WithdrawalDepartmentRec."Department Code";
                end;
            Until WithdrawalDepartmentRec.Next() = 0;
        end;

        Rec.FILTERGROUP(2);
        IF DepartmentName = '' then
            Rec.SetFilter("Approved for Department", '%1', '')
        else
            Rec.SetFilter("Approved for Department", DepartmentName);
        Rec.FILTERGROUP(0);
        //CSPL-00307-T1-T1516-CR Ends

        //SD-SN-17-Dec-2020 +
        // FilterGroup(3);
        // SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        // FilterGroup(5);
        //SD-SN-17-Dec-2020 -
    end;



    var

    // procedure PendingLeavesApprovals()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CourseDegreeRec: Record "Course Degree";
    //     SmtpMail: Codeunit "Email Message";
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     DegreeName: text[2048];
    //     WithDepartment: Record "Withdrawal Department";
    // begin
    //     WithDepartment.Reset();
    //     WithDepartment.SetRange("Department Code", Rec."Global Dimension 1 Code");
    //     IF WithDepartment.FindFirst() then;
    //     SmtpMailRec.Get();
    //     Recipient := WithDepartment."User E-Mail";
    //     Recipients := Recipient.Split(';');
    //     SenderName := '';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (' ');
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('�THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD�');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Dear' + '' + WithDepartment."Department Code");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that the following student has requested an Extended Leave of Absence (ELOA) from' + Rec.Course + 'program' + Rec.Semester + 'Semester <CLN5>  due to <testing> effective from' + Format(Today));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<John Rublaitus>');
    //     SmtpMail.AppendtoBody('<2000295>');
    //     SmtpMail.AppendtoBody('<CLN5>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<Previous Department>');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     Mail_lCU.Send();
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('ELOA process', 'MEA', SenderAddress, Format(Rec."Department Name"),
    //   WithDepartment."Department Code", Subject, BodyText, 'ELOA process', 'ELOA process', '', '',
    //  Recipient, 1, '', '', 1);
    // end;


}
