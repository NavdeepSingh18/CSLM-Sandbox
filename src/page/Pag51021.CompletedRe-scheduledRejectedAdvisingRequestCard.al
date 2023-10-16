page 51021 "Rej. Or Comp. Adv. Req. Card"
{
    PageType = Card;
    UsageCategory = None;
    InsertAllowed = false;
    // ModifyAllowed = false;
    DeleteAllowed = false;
    // Editable = false;
    SourceTable = "Advising Request";
    Caption = 'Completed/Rejected Advising Request Card';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Request No"; Rec."Request No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Department Type"; Rec."Department Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Student Email"; Rec."Student Email")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Status field.';
                    Editable = False;
                    visible = EEDPreClinicalVisible;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Core Topic"; Rec."Core Topic")
                // {
                //     ToolTip = 'Specifies the value of the Core Topic field';
                //     ApplicationArea = All;
                // }
                // field("Request to Chair"; Rec."Request to Chair")
                // {
                //     ToolTip = 'Specifies the value of the Request to Chair field';
                //     ApplicationArea = All;
                // }
                field("Reason Program Code"; Rec."Reason Program Code")
                {
                    ApplicationArea = All;
                    Visible = EEDPreClinicalVisible;
                    Editable = false;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Visible = EEDPreClinicalVisible;
                    Editable = false;
                }

                field("Advisor ID"; Rec."Advisor ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Advisor First Name"; Rec."Advisor First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Advisor Last Name"; Rec."Advisor Last Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Advising Topic Code"; Rec."Advising Topic Code")
                {
                    ApplicationArea = All;
                    visible = NOT EEDPreClinicalVisible;
                    Editable = false;
                }
                field("Advising Topic Description"; Rec."Advising Topic Description")
                {
                    ApplicationArea = All;
                    visible = NOT EEDPreClinicalVisible;
                    Editable = false;

                }
                // field("Requested Meeting Date1"; Rec."Requested Meeting Date1")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting Start Time1"; Rec."Requested Meeting Start Time 1")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting End Time 1"; Rec."Requested Meeting End Time1")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting Date2"; Rec."Requested Meeting Date2")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting Start Time2"; Rec."Requested Meeting Start Time 2")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting End Time 2"; Rec."Requested Meeting End Time2")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting Date3"; Rec."Requested Meeting Date3")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting Start Time3"; Rec."Requested Meeting Start Time 3")
                // {
                //     ApplicationArea = All;
                // }
                // field("Requested Meeting End Time 3"; Rec."Requested Meeting End Time3")
                // {
                //     ApplicationArea = All;
                // }
                field("Meeting Mode"; Rec."Meeting Mode")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Confirm Date"; Rec."Confirm Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meeting Start Time"; Rec."Meeting Start Time 1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meeting End Time"; Rec."Meeting End Time 1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Status"; Rec."Request Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    Caption = 'Rejection Reason';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Reason Decription"; Rec."Rejection Reason Description")
                {
                    Caption = 'Rejection Reason Description';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Next Advising Request No"; Rec."Next Advising Request No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Previous Advising Request No"; Rec."Previous Advising Request No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                // field("Rescheduled Old Req. No."; "Rescheduled Old Req. No.")
                // {
                //     ApplicationArea = All;
                //     DrillDown = true;
                //     Lookup = true;

                //     trigger OnLookup(Var myText: text): Boolean
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled Old Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                //     trigger OnDrillDown()
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled Old Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;


                // }
                // field("Rescheduled New Req. No."; "Rescheduled New Req. No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     DrillDown = true;
                //     Lookup = true;

                //     trigger OnLookup(Var myText: text): Boolean
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled New Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                //     trigger OnDrillDown()
                //     var
                //         ApprovedAdReq: page "Rej. Or Comp. Adv. Req. Card";
                //         ConfirmAdReq: Page "App. Or Res. Adv. Req. Card";
                //         PendingAdReq: Page "Advising Request Card";
                //         AdvicingReq: Record "Advising Request";
                //     begin
                //         AdvicingReq.Reset();
                //         AdvicingReq.SetRange("Request No", "Rescheduled New Req. No.");
                //         if AdvicingReq.FindFirst() then begin
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::" ", AdvicingReq."Request Status"::Pending] then begin
                //                 PendingAdReq.SetTableView(AdvicingReq);
                //                 PendingAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Rescheduled, AdvicingReq."Request Status"::Rejected, AdvicingReq."Request Status"::Completed] then begin
                //                 ApprovedAdReq.SetTableView(AdvicingReq);
                //                 ApprovedAdReq.Run();
                //             end;
                //             if AdvicingReq."Request Status" in [AdvicingReq."Request Status"::Approved] then begin
                //                 ConfirmAdReq.SetTableView(AdvicingReq);
                //                 ConfirmAdReq.Run();
                //             end;
                //         end;
                //     end;

                // }

                field("Problem Solution Id"; Rec."Problem Solution Id 1")
                {
                    ApplicationArea = All;
                    // Caption = 'Problem';
                    CaptionClass = ProblemCaption;
                    Visible = EEDPreClinicalVisible;

                }
                field("Problem solution description"; Rec."Problem solution description")
                {
                    ApplicationArea = All;
                    //caption = 'Solution';
                    CaptionClass = SolutionCaption;
                    Visible = EEDPreClinicalVisible;
                }
                field("Problem Solution Id 2"; Rec."Problem Solution Id 2")
                {
                    ToolTip = 'Specifies the value of the Problem 2 field.';
                    ApplicationArea = All;
                    Visible = EEDPreClinicalVisible;
                }
                field("Problem solution description 2"; Rec."Problem solution description 2")
                {
                    ToolTip = 'Specifies the value of the Solution 2 field.';
                    ApplicationArea = All;
                    Visible = EEDPreClinicalVisible;
                }
                field("Problem Solution Id 3"; Rec."Problem Solution Id 3")
                {
                    ToolTip = 'Specifies the value of the Problem 3 field.';
                    ApplicationArea = All;
                    Visible = EEDPreClinicalVisible;
                }
                field("Problem solution description 3"; Rec."Problem solution description 3")
                {
                    ToolTip = 'Specifies the value of the Solution 3 field.';
                    ApplicationArea = All;
                    Visible = EEDPreClinicalVisible;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Editable = EEDPreClinicalVisible;
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // group("Send Mail")
            // {
            //     Image = SendMail;
            // action("Send Mails")
            // {
            //     caption = 'Send Mail';
            //     ApplicationArea = All;
            //     Image = SendMail;
            //     trigger OnAction()
            //     begin
            //         Rec.SendMail();
            //     end;
            // }
            // }
            action("Student Card")
            {
                Caption = 'Student Card';
                ApplicationArea = all;
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Student: Record "Student Master-CS";
                    StudentCardL: Page "Student Detail Card-CS";
                begin

                    Student.reset();
                    Student.SetRange("No.", Rec."Student No.");
                    if Student.FindFirst() then;
                    StudentCardL.SetTableView(Student);
                    StudentCardL.Editable(False);
                    StudentCardL.RunModal();
                    // Student.reset();
                    // Student.SetRange("No.", "Student No.");
                    // if Student.FindFirst() then
                    //     Page.RunModal(Page::"Student Detail Card-CS", Student);
                end;
            }
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField(Rec."Student No.");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."Request No", Rec."Student No.", TemplateType, GroupType);
                end;
            }
            action("Temporary")
            {
                // Visible = false;
                trigger OnAction()
                begin
                    Rec.Validate("Request Status", Rec."Request Status"::Pending);
                    rec.Modify();
                end;
            }
            action("Add Attachment")
            {
                ApplicationArea = All;
                Caption = 'Add Attachment';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.SetRange("No.", Rec."Student No.");
                    Page.RunModal(Page::"Add Student Attachment", StudentMaster);
                end;
            }
            group("Student TranscriptsEEDPCPrint1")
            {
                Caption = 'Student Transcripts Print 1';
                Visible = EEDPreClinicalVisible;
                action("Unofficial TranscriptsEEDPCPrint1")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = EEDPreClinicalVisible;
                    trigger OnAction()
                    var

                        Student: Record "Student Master-CS";
                        StudentStatus: Record "Student Status";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Student.Reset();
                        Student.Get(Rec."Student No.");
                        StudentStatus.Get(Student.Status, Student."Global Dimension 1 Code");
                        if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                        StudentStatus.Status::Deposited] then
                            Error('Transcript cannot be pulled for %1 status students.', Student.Status);

                        Clear(StudentStatusCU);
                        StudentStatusCU.UnOfficialTranscripts(Student);
                    end;
                }
            }
            group("Student TranscriptsEEDPCPrint2")
            {
                Caption = 'Student TranscriptsPrint2';
                Visible = EEDPreClinicalVisible;
                action("Unofficial TranscriptsEEDPCPrint2")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = EEDPreClinicalVisible;
                    trigger OnAction()
                    var

                        Student: Record "Student Master-CS";
                        StudentStatus: Record "Student Status";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Student.Reset();
                        Student.Get(Rec."Student No.");
                        StudentStatus.Get(Student.Status, Student."Global Dimension 1 Code");
                        if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                        StudentStatus.Status::Deposited] then
                            Error('Transcript cannot be pulled for %1 status students.', Student.Status);

                        Clear(StudentStatusCU);
                        StudentStatusCU.UnOfficialTranscripts1(Student);
                    end;
                }
            }
            group("Student TranscriptsEEDPCPrint3")
            {
                Caption = 'Student Transcripts Print 3';
                Visible = EEDPreClinicalVisible;
                action("Unofficial TranscriptsEEDPCPrint3")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = EEDPreClinicalVisible;
                    trigger OnAction()
                    var

                        Student: Record "Student Master-CS";
                        StudentStatus: Record "Student Status";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Student.Reset();
                        Student.Get(Rec."Student No.");
                        StudentStatus.Get(Student.Status, Student."Global Dimension 1 Code");
                        if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                        StudentStatus.Status::Deposited] then
                            Error('Transcript cannot be pulled for %1 status students.', Student.Status);

                        Clear(StudentStatusCU);
                        StudentStatusCU.UnOfficialTranscripts2(Student);
                    end;
                }
            }
            group("Student TranscriptsEEDPCPrint4")
            {
                Caption = 'Student Transcripts Print 4';
                Visible = EEDPreClinicalVisible;
                action("Unofficial TranscriptsEEDPCPrint4")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = EEDPreClinicalVisible;
                    trigger OnAction()
                    var

                        Student: Record "Student Master-CS";
                        StudentStatus: Record "Student Status";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Student.Reset();
                        Student.Get(Rec."Student No.");
                        StudentStatus.Get(Student.Status, Student."Global Dimension 1 Code");
                        if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                        StudentStatus.Status::Deposited] then
                            Error('Transcript cannot be pulled for %1 status students.', Student.Status);

                        Clear(StudentStatusCU);
                        StudentStatusCU.UnOfficialTranscripts3(Student);
                    end;
                }
            }
            group("Student TranscriptsEEDPCPrint45")
            {
                Caption = 'Student Transcripts Print 5';
                Visible = EEDPreClinicalVisible;
                action("Unofficial TranscriptsEEDPCPrint5")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = EEDPreClinicalVisible;
                    trigger OnAction()
                    var

                        Student: Record "Student Master-CS";
                        StudentStatus: Record "Student Status";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Student.Reset();
                        Student.Get(Rec."Student No.");
                        StudentStatus.Get(Student.Status, Student."Global Dimension 1 Code");
                        if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                        StudentStatus.Status::Deposited] then
                            Error('Transcript cannot be pulled for %1 status students.', Student.Status);

                        Clear(StudentStatusCU);
                        StudentStatusCU.UnOfficialTranscripts4(Student);
                    end;
                }
            }
            group("Student TranscriptsEEDPCPrint6")
            {
                Caption = 'Student Transcripts Print 6';
                Visible = EEDPreClinicalVisible;
                action("Unofficial TranscriptsEEDPCPrint6")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = EEDPreClinicalVisible;
                    trigger OnAction()
                    var

                        Student: Record "Student Master-CS";
                        StudentStatus: Record "Student Status";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Student.Reset();
                        Student.Get(Rec."Student No.");
                        StudentStatus.Get(Student.Status, Student."Global Dimension 1 Code");
                        if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                        StudentStatus.Status::Deposited] then
                            Error('Transcript cannot be pulled for %1 status students.', Student.Status);

                        Clear(StudentStatusCU);
                        StudentStatusCU.UnOfficialTranscripts5(Student);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
            ProblemCaption := 'Problem 1';
            SolutionCaption := 'Solution 1';
            EEDPreClinicalVisible := true;
        end else begin
            ProblemCaption := 'Problem';
            SolutionCaption := 'Solution';
            EEDPreClinicalVisible := false;
        end;
        IF Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            CurrPage.Caption := 'Completed/Cancelled Request';
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
            ProblemCaption := 'Problem 1';
            SolutionCaption := 'Solution 1';
            EEDPreClinicalVisible := true;
        end else begin
            ProblemCaption := 'Problem';
            SolutionCaption := 'Solution';
            EEDPreClinicalVisible := false;
        end;
        IF Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            CurrPage.Caption := 'Completed/Cancelled Request';

    end;

    trigger OnAfterGetCurrRecord()
    begin
        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
            ProblemCaption := 'Problem 1';
            SolutionCaption := 'Solution 1';
            EEDPreClinicalVisible := true;
        end else begin
            ProblemCaption := 'Problem';
            SolutionCaption := 'Solution';
            EEDPreClinicalVisible := false;
        end;
        IF Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            CurrPage.Caption := 'Completed/Cancelled Request';
    end;


    var
        ProblemCaption: text;
        SolutionCaption: Text;
        EEDPreClinicalVisible: Boolean;
}
