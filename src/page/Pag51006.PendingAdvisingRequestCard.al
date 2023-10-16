page 51006 "Advising Request Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Advising Request";
    Caption = 'Pending Advising Request Card';
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
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Department Type"; Rec."Department Type")
                {
                    ApplicationArea = all;
                    Editable = DepEditable;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
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
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Status field.';
                    Editable = False;
                    visible = NOT Hide_For_PreClinical;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
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
                    visible = NOT Hide_For_PreClinical;
                    ApplicationArea = All;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Visible = NOT Hide_For_PreClinical;
                    ApplicationArea = All;
                }
                field("Advisor ID"; Rec."Advisor ID")
                {
                    ApplicationArea = All;
                }
                field("Advisor First Name"; Rec."Advisor First Name")
                {
                    ApplicationArea = All;
                }
                field("Advisor Last Name"; Rec."Advisor Last Name")
                {
                    ApplicationArea = All;
                }
                field("Advising Topic Code"; Rec."Advising Topic Code")
                {
                    ApplicationArea = All;
                    visible = Hide_For_PreClinical;

                }
                field("Advising Topic Description"; Rec."Advising Topic Description")
                {
                    ApplicationArea = All;
                    Visible = Hide_For_PreClinical;
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
                }
                // field("Confirm Date"; Rec."Confirm Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Meeting Start Time"; Rec."Meeting Start Time 1")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Meeting End Time"; Rec."Meeting End Time 1")
                {
                    ApplicationArea = All;
                    Editable = true;
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
                    Visible = false;
                }
                field("Rejected Reason Decription"; Rec."Rejection Reason Description")
                {
                    Caption = 'Rejection Reason Description';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Next Advising Request No"; Rec."Next Advising Request No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Previous Advising Request No"; Rec."Previous Advising Request No")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = All;
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
            action("Confirm Requests")
            {
                Caption = 'Confirm';
                ApplicationArea = All;
                Image = Confirm;
                Visible = false;
                trigger OnAction()
                begin
                    //Rec.ConfirmRequest();GMCSCOM
                    CurrPage.Update();
                end;
            }
            action(Complete)
            {
                Image = Completed;
                ApplicationArea = All;
                // Visible = Hide_For_PreClinical;
                trigger OnAction()
                begin
                    // testfield(Rec."Problem Solution Id 1");
                    // TestField(Rec."Problem solution description");
                    //CSPL-00307- 19-10-21
                    IF Not Confirm('Do you want to Complete this Advising Request?') THEN
                        exit;
                    //CSPL-00307- 19-10-21
                    //Rec.Completed();//GMCSCOM
                    CurrPage.Close();
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
                    // if Student.FindFirst() then
                    //     Page.RunModal(Page::"Student Detail Card-CS", Student);
                end;
            }

            action("Rejects Request")
            {
                Caption = 'Reject Request';
                ApplicationArea = all;
                Image = Reject;
                Visible = False;

                trigger OnAction()
                begin
                    // Rec.RejectRequest();//GMCSCOM
                    CurrPage.Update();

                end;
            }
            // group("Reject Request")
            // {
            //     Image = Reject;
            //     action("Rejects Request")
            //     {
            //         Caption = 'Reject Request';
            //         ApplicationArea = all;
            //         trigger OnAction()
            //         begin
            //             Rec.RejectRequest();
            //         end;
            //     }
            // }            
            action("Send Mails")
            {
                caption = 'Create Request Mail';
                ApplicationArea = All;
                Image = SendMail;
                Visible = true;
                trigger OnAction()
                begin
                    //Rec.CreateRequest();//GMCSCOM
                    CurrPage.Update();
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
            action("Sudent Subject Grade Book List")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page StudentSubjectGradeBookList;
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
            action("Enrollment History")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Enrollment History List";
                RunPageLink = "Student No." = field("Student No.");
                RunPageMode = View;
            }
            action("Student Educational Qualification")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Qualifying Detail Stud List-CS";
                Runpagelink = "Student No." = Field("Student No.");
                RunPageMode = View;

            }
            Action("Student Notes")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = False;
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
                Visible = NOT Hide_For_PreClinical;
                action("Unofficial TranscriptsEEDPCPrint1")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = NOT Hide_For_PreClinical;
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
                Visible = NOT Hide_For_PreClinical;
                action("Unofficial TranscriptsEEDPCPrint2")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = NOT Hide_For_PreClinical;
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
                Visible = NOT Hide_For_PreClinical;
                action("Unofficial TranscriptsEEDPCPrint3")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = NOT Hide_For_PreClinical;
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
                Visible = NOT Hide_For_PreClinical;
                action("Unofficial TranscriptsEEDPCPrint4")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = NOT Hide_For_PreClinical;
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
                Visible = NOT Hide_For_PreClinical;
                action("Unofficial TranscriptsEEDPCPrint5")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = NOT Hide_For_PreClinical;
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
                Visible = NOT Hide_For_PreClinical;
                action("Unofficial TranscriptsEEDPCPrint6")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = NOT Hide_For_PreClinical;
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
    trigger OnAfterGetRecord()
    begin
        if Rec.ChecDocumentAppDepartment() = 3 then
            DepEditable := true else
            DepEditable := false;
        //CurrPage.Update();
        if Not (Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical") then
            Hide_For_PreClinical := true
        else
            Hide_For_PreClinical := false;

        If Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            Currpage.Caption := 'Walk-In Request';
        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then
            Currpage.Caption := 'Pending / Walk-in Advising Request Card';

        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
            ProblemCaption := 'Problem 1';
            SolutionCaption := 'Solution 1';
            EEDPreClinicalVisible := true;
        end else begin
            ProblemCaption := 'Problem';
            SolutionCaption := 'Solution';
            EEDPreClinicalVisible := false;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
    // myInt: Integer;
    begin
        if Not (Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical") then
            Hide_For_PreClinical := true
        else
            Hide_For_PreClinical := false;
        If Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            Currpage.Caption := 'Walk-In Request';
        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then
            Currpage.Caption := 'Pending / Walk-in Advising Request Card';

        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
            ProblemCaption := 'Problem 1';
            SolutionCaption := 'Solution 1';
            EEDPreClinicalVisible := true;
        end else begin
            ProblemCaption := 'Problem';
            SolutionCaption := 'Solution';
            EEDPreClinicalVisible := false;
        end;
    end;

    trigger OnOpenPage()
    var
    // myInt: Integer;
    begin
        if Not (Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical") then
            Hide_For_PreClinical := true
        else
            Hide_For_PreClinical := false;
        If Rec."Department Type" = Rec."Department Type"::"EED Clinical" then
            Currpage.Caption := 'Walk-In Request';
        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then
            Currpage.Caption := 'Pending / Walk-in Advising Request Card';

        IF Rec."Department Type" = Rec."Department Type"::"EED Pre-Clinical" then begin
            ProblemCaption := 'Problem 1';
            SolutionCaption := 'Solution 1';
            EEDPreClinicalVisible := true;
        end else begin
            ProblemCaption := 'Problem';
            SolutionCaption := 'Solution';
            EEDPreClinicalVisible := false;
        end;
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    Begin
        Rec.Requestor := Rec.Requestor::"By Faculty";
    End;

    var
        DepEditable: Boolean;
        Hide_For_PreClinical: Boolean;
        ProblemCaption: text;
        SolutionCaption: Text;
        EEDPreClinicalVisible: Boolean;
}
