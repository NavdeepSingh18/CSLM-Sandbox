page 51020 "App. Or Res. Adv. Req. Card"
{
    PageType = Card;
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Advising Request";
    Caption = 'Approved/ Rescheduled Advising Request Card';
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    editable = false;
                    ApplicationArea = all;
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
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Student Email"; Rec."Student Email")
                {
                    ApplicationArea = all;
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
                    // Editable = false;
                    Editable = EEDClinicalEditable;
                    Visible = EEDPreClinicalVisible;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    Editable = EEDClinicalEditable;
                    Visible = EEDPreClinicalVisible;
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
                    // Editable = false;
                    Editable = EEDClinicalEditable;
                    Visible = Not EEDPreClinicalVisible;
                }
                field("Advising Topic Description"; Rec."Advising Topic Description")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    Editable = EEDClinicalEditable;
                    Visible = Not EEDPreClinicalVisible;
                }
                // field("Requested Meeting Date1"; Rec."Requested Meeting Date1")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting Start Time1"; Rec."Requested Meeting Start Time 1")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting End Time 1"; Rec."Requested Meeting End Time1")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting Date2"; Rec."Requested Meeting Date2")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting Start Time2"; Rec."Requested Meeting Start Time 2")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting End Time 2"; Rec."Requested Meeting End Time2")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting Date3"; Rec."Requested Meeting Date3")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting Start Time3"; Rec."Requested Meeting Start Time 3")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Requested Meeting End Time 3"; Rec."Requested Meeting End Time3")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Meeting Mode"; Rec."Meeting Mode")
                {
                    ApplicationArea = All;
                    Editable = false;
                    visible = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Request Status"; Rec."Request Status")
                {
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
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    Caption = 'Rejection Reason';
                    ApplicationArea = All;
                    //Editable = false;
                }

                field("Rejected Reason Decription"; Rec."Rejection Reason Description")
                {
                    Caption = 'Rejection Reason Desciption';
                    ApplicationArea = All;
                    //Editable = false;
                }
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
                    // Caption = 'Solution';
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
                    Editable = true;
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
        area(FactBoxes)
        {
            part("Advising Request Factbox"; "Advising Request Factbox")
            {
                ApplicationArea = All;
                Caption = 'Advising Request Status FactBox';
                SubPageLink = "Request No" = Field("Request No"), "Student No." = Field("Student No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Complete)
            {
                Image = Completed;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // testfield(Rec."Problem Solution Id 1");
                    // TestField(Rec."Problem solution description");
                    //CSPL-00307- 19-10-21
                    IF Not Confirm('Do you want to Complete this Advising Request?') THEN
                        exit;
                    //CSPL-00307- 19-10-21
                    //Rec.Completed();
                    CurrPage.Close();
                end;
            }
            action(Reschedule)
            {
                Image = NewStatusChange;
                Visible = false;
                trigger OnAction()
                begin
                    Rec.Reschedule();
                    CurrPage.Update();
                end;
            }
            action(Cancel)
            {
                Image = Cancel;
                trigger OnAction()
                begin
                    Rec.TestField("Rejected Reason");
                    If not Confirm('Do you want to Cancel this Advising Request?', false) then
                        exit;
                    // Rec.CancelRequest();
                    // Rec."Request Status" := Rec."Request Status"::Cancel;
                    // Rec.Modify();
                    // WebServiceFn.AdvisingRequestAzureMeetingCancellation(Rec);
                    CurrPage.Update();
                end;
            }
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
            action("Temporary")
            {
                Visible = false;
                trigger OnAction()
                begin
                    Rec.Validate("Request Status", Rec."Request Status"::Pending);
                    rec.Modify();
                end;
            }
            // group("Send Mail")
            // {
            //     Image = SendMail;
            //     action("Send Mails")
            //     {
            //         caption = 'Send Mail';
            //         ApplicationArea = All;
            //         Image = SendMail;
            //         Visible = false;
            //         trigger OnAction()
            //         begin
            //             // Rec.SendMail();
            //         end;
            //     }
            // }
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
                    Rec.TestField("Student No.");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."Request No", Rec."Student No.", TemplateType, GroupType);
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
            action("Internal Exam List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Student Subject Exam List";//50956
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageLink = "Student No." = Field("Student No."), "Level Description" = filter("Internal Exam Component");
                RunPageMode = View;

            }
            action("External Exam List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Student Subject Exam List";//50956
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageLink = "Student No." = Field("Student No."), "Level Description" = filter("External Examination");
                RunPageMode = View;
            }
            action("Student Exam List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = page "Student Subject Exam List";//50956
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunPageLink = "Student No." = Field("Student No.");
                RunPageMode = View;
            }
            action("Student Subject List")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Subject Student-CS";//50001
                RunPageLink = "Student No." = Field("Student No.");
                RunPageMode = View;
            }
            action("Sudent Subject Grade Book List")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = EEDPreClinicalVisible;
                RunObject = Page StudentSubjectGradeBookList;
                RunPageLink = "Student No." = Field("Student No.");
                RunPageMode = View;

            }
            action("Enrollment History")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Enrollment History List";
                RunPageLink = "Student No." = field("Student No.");
            }
            action("Student Educational Qualification")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Qualifying Detail Stud List-CS";
                Runpagelink = "Student No." = Field("Student No.");

            }
            Action("Student Notes")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                visible = false;
                RunObject = Page "Student Notes List";
                RunPageLink = "Student No." = field("Student No.");
            }
            // Action("Grade Book List")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedOnly = true;
            //     // Runobject = Page GradeBookSubform;
            //     // RunPageLink = "Student No." = Field("Student No.");
            // }
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
            EEDClinicalEditable := true;
        end;
        If Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            CurrPage.Caption := 'Confirmed Advising Request';
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
            EEDClinicalEditable := true;
        end;
        If Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            CurrPage.Caption := 'Confirmed Advising Request';

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
            EEDClinicalEditable := true;
        end;
        If Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            CurrPage.Caption := 'Confirmed Advising Request';
    end;


    var
        ProblemCaption: text;
        SolutionCaption: Text;
        EEDPreClinicalVisible: Boolean;
        EEDClinicalEditable: Boolean;
}
