page 50894 "Degree Audit Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Degree Audit";
    Caption = 'Pending Degree Audit Card';
    DataCaptionFields = "Application No.", "Student Name";
    DeleteAllowed = false;
    SourceTableView = sorting("Application No.") where("Document Status" = filter("Pending for Verification"));

    layout
    {
        area(content)
        {

            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Importance = Standard;

                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }

                field("Personal E-Mail Address"; Rec."Personal E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Permanent Phone No."; Rec."Permanent Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                    Visible = false;
                }
                field("Current Zip Code"; Rec."Current Zip Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Current City"; Rec."Current City")
                {
                    ApplicationArea = All;
                }
                field("Current State"; Rec."Current State")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Current Country Code"; Rec."Current Country Code")

                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Permanent Address"; Rec."Permanent Address")
                {
                    Caption = 'Permanent Address';
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Permanent Zip Code"; Rec."Permanent Zip Code")
                {
                    ApplicationArea = All;
                }
                field("Permanent City"; Rec."Permanent City")
                {
                    ApplicationArea = All;
                }
                field("Permanent State"; Rec."Permanent State")
                {
                    ApplicationArea = All;
                }
                field("Permanent Country Code"; Rec."Permanent Country Code")

                {
                    ApplicationArea = All;
                }

                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
            }
            group("Academic Details")
            {
                field("Last Date of Attendance"; Rec.LDA)
                {
                    ApplicationArea = All;
                }
                field("Estimated Graduation Date"; Rec."Estimated Graduation Date")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Graduation Date"; Rec."Graduation Date")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Date Awarded"; Rec."Date Awarded")
                {
                    ApplicationArea = All;
                }
                field("Date Cleared"; Rec."Date Cleared")
                {
                    ApplicationArea = All;
                }
                field("BSIC Opt-Out"; Rec."BSIC Opt-Out")
                {
                    ApplicationArea = All;
                }
                field("Total Clerkship Weeks"; Rec."Total Clerkship Weeks")
                {
                    ApplicationArea = All;
                }
                field("Clinical Curriculum"; Rec."Clinical Curriculum")
                {
                    ApplicationArea = All;
                }

            }
            part(DegreeAuditSubPage; "Degree Audit Documents")
            {
                SubPageLink = "SLcM Document No" = FIELD("Application No.");
                ApplicationArea = All;
                Visible = false;
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
                //Runobject = page "Student Detail Card-CS";
                //RunPageLink = "No." = FIELD("Student No.");
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
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other,Housing,Graduation;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other,Housing,Room,"Housing Ledger",Graduation;
                begin
                    Rec.TestField("Student No.");
                    TemplateType := TemplateType::Graduation;
                    GroupType := GroupType::Graduation;
                    ClinicalBaseAppSubscribe.ViewEditDegreeNote(Rec."Application No.", Rec."Student No.", TemplateType, GroupType);
                end;
            }

            action("Student GPA")
            {
                Caption = 'Student GPA';
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = PageView;
                RunObject = Page StudentGPACalculation;
                RunPageLink = "No." = FIELD("Student No.");
            }
            group(Scores)
            {


                action("CCSE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter(CCSE);
                }
                action("CCSSE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter(CCSSE);
                }
                action("CBSE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter(CBSE);
                }
                action("USMLE Score")
                {
                    ApplicationArea = All;
                    Image = List;
                    RunObject = page "Student Subject Exam List";
                    RunPageLink = "Student No." = FIELD("Student No."), "Score Type" = filter("STEP 1" | "STEP 2 CK" | "STEP 2 CS");
                }
            }


            action("Rotation Audit")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Rotation Audit';
                Runobject = page "Students Rotation Audit";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Student Subject Exam")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject Exam';
                Runobject = page "Student Subject Exam List";
                RunPageLink = "Student No." = FIELD("Student No.");
            }
            action("Student Subject")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject List';
                Runobject = page "Subject Student-CS";
                RunPageLink = "Student No." = FIELD("Student No.");
            }

            action("Student Degree")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Degree List';
                Runobject = page "Student Degree";
                RunPageLink = "Student No." = FIELD("Student No.");
            }
            action("&Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = PageView;
                trigger OnAction()
                var
                    StudentDocAttachment: Record "Student Document Attachment";
                    StudentMasterRec: Record "Student Master-CS";
                    StudentDegreeRec: Record "Student Degree";
                    StudentHold: Record "Student Wise Holds";
                begin
                    StudentHold.Reset();//26//09//22//GAURAV
                    StudentHold.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    StudentHold.Setrange("Student No.", Rec."Student No.");
                    StudentHold.SetfilteR("Hold Code", '%1|%2|%3|%4', 'BURHOLD', 'CLNHOLD', 'CLNMISSING', 'REGHOLD');
                    StudentHold.SetRange(Status, StudentHold.Status::Enable);
                    If StudentHold.FindFirst() Then
                        Error('%1 has been applicable for the Student.', StudentHold."Hold Code");


                    //Message('hi');
                    SendApproveMail(Rec."Student No.");
                    StudentMasterRec.Get(Rec."Student No.");
                    if StudentMasterRec.CGPA = 0 then
                        Error('Please calculate the GPA first.');

                    StudentDegreeRec.Reset();
                    StudentDegreeRec.Setrange("Student No.", Rec."Student No.");
                    if StudentDegreeRec.FindFirst() then begin
                        StudentDegreeRec.Testfield(StudentDegreeRec."Enrollment No.");
                        StudentDegreeRec.Testfield(StudentDegreeRec."Degree Code");
                    end else
                        error('There must be atleast one Degree mapped against this student in Student Degree List.');

                    IF not CONFIRM(Text005Lbl, false, Rec."Student No.") THEN BEGIN

                        IF CONFIRM(Text001Lbl, FALSE, Rec."Application No.") THEN BEGIN
                            // StudentDocAttachment.Reset();
                            // StudentDocAttachment.SetRange("SLcM Document No", "Document No.");
                            // If NOT StudentDocAttachment.FindFirst() Then
                            //     Error('Please attach at least one Document.');

                            // StudentDocAttachment.Reset();
                            // StudentDocAttachment.SetRange("SLcM Document No", "Application No.");
                            // StudentDocAttachment.SetFilter("Document Status", '<>%1', StudentDocAttachment."Document Status"::Verified);
                            // If StudentDocAttachment.FindFirst() Then begin
                            //     Error('All Uploaded Document Not Verified');
                            // end Else begin
                            // TestField("Document Status", "Document Status"::"Pending for Verification");



                            StudentMasterRec.Reset();
                            StudentMasterRec.SetRange("No.", Rec."Student No.");
                            IF StudentMasterRec.FindFirst() then begin
                                //StudentMasterRec."Graduation Date" := CalculationofGraduationDate("Estimated Graduation Date");//CSPL-00307 16-10-21---Comnt--- According to mishma it can be manual entry also so do not change manual Entry by Approval button.
                                StudentMasterRec."Graduation Date" := Rec."Graduation Date";
                                //CSPL-00307 16-10-21---Graduation Date of Degree Audit--- According to mishma it can be manual entry also so do not change manual Entry by Approval button.
                                StudentMasterRec."Date Cleared" := Today();
                                //StudentMasterRec.Validate(StudentMasterRec.Status, StudentStatusMangementCod.StudentGraduated(Rec."Student No.", StudentMasterRec.Status, Rec."Global Dimension 1 Code"));//GMCSCOM
                                StudentMasterRec.Modify();
                            end;

                            // CourseDegreeRec.Reset();
                            // CourseDegreeRec.SetRange("Course Code", "Course Code");
                            // CourseDegreeRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                            // if CourseDegreeRec.FindSet() then
                            //     Repeat
                            //         StudentDegreeRec.Reset();
                            //         StudentDegreeRec.Setrange("Student No.", "Student No.");
                            //         StudentDegreeRec.SetRange("Degree Code", CourseDegreeRec."Degree Code");
                            //         if not StudentDegreeRec.FindFirst() then begin
                            //             StudentDegreeRec.Init();
                            //             StudentDegreeRec."Student No." := "Student No.";
                            //             StudentDegreeRec."Student Name" := "Student Name";
                            //             StudentDegreeRec."Enrollment No." := "Enrollment No";
                            //             StudentDegreeRec."Degree Code" := CourseDegreeRec."Degree Code";
                            //             StudentDegreeRec."Degree Name" := CourseDegreeRec."Degree Name";
                            //             StudentDegreeRec.DateAwarded := Today();
                            //             StudentDegreeRec.DateCleared := Today();
                            //             StudentDegreeRec."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            //             StudentDegreeRec."Graduation Date" := CalculationofGraduationDate("Estimated Graduation Date");
                            //             StudentDegreeRec.Insert(true);
                            //         end;
                            //     until CourseDegreeRec.Next() = 0;

                            //     StudentHonors(Rec."Student No.");

                            // MailSendforDegreeAuditDocumentApproved("Student No.");


                            Rec."Document Status" := Rec."Document Status"::Verified;
                            Rec."Approved/Rejected By" := UserId();
                            Rec."Approved/Rejected On" := Today();
                            //"Date Awarded" := Today();
                            Rec."Date Cleared" := Today();
                            Rec."Reason Description" := 'Completed Degree Requirements';
                            //  "Graduation Date" := CalculationofGraduationDate(StudentMasterRec."Estimated Graduation Date");
                            //"Effective Date" := CalculationofGraduationDate(StudentMasterRec."Estimated Graduation Date");

                            Rec.Modify();

                            StudentDegreeRec.Reset();
                            StudentDegreeRec.SetRange("Student No.", Rec."Student No.");
                            StudentDegreeRec.SetRange("Degree Code", 'DOC');
                            IF StudentDegreeRec.FindFirst() then begin
                                StudentDegreeRec.DateCleared := Today();
                                StudentDegreeRec.Modify();
                            end;
                            Message(Text002Lbl, Rec."Application No.");
                            SendApproveMail(Rec."Student No.");

                            CurrPage.Close();
                        End Else
                            exit;
                    end else
                        exit;
                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = PageView;
                trigger OnAction()
                begin
                    IF CONFIRM(Text003Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        Rec.TestField("Document Status", Rec."Document Status"::"Pending for Verification");
                        Rec.TestField("Rejection Remark");
                        Rec."Document Status" := Rec."Document Status"::Rejected;
                        Rec."Approved/Rejected By" := UserId();
                        Rec."Approved/Rejected On" := Today();
                        Rec.Modify();
                        //MailSendforDegreeAuditRejection("Student No.");
                        Message(Text004Lbl, Rec."Application No.");
                        SendRejectMail(Rec."Student No.");
                    End;
                    CurrPage.Close();
                end;
            }
            group("Student TranscriptsR1 Print1")
            {
                Caption = 'Student Transcripts Print 1';
                action("Official TranscriptsPrint1")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint1")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts(StudentMaster);
                    end;
                }
            }
            group("Student TranscriptsR1 Print2")
            {
                Caption = 'Student Transcripts Print 2';
                action("Official TranscriptsPrint2")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts1(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint2")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts1(StudentMaster);
                    end;
                }
            }

            group("Student TranscriptsR1 Print3")
            {
                Caption = 'Student Transcripts Print 3';
                action("Official TranscriptsPrint3")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts2(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint3")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts2(StudentMaster);
                    end;
                }
            }
            group("Student TranscriptsR1 Print4")
            {
                Caption = 'Student Transcripts Print 4';
                action("Official TranscriptsPrint4")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts3(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint4")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts3(StudentMaster);
                    end;
                }
            }
            group("Student TranscriptsR1 Print5")
            {
                Caption = 'Student Transcripts Print 5';
                action("Official TranscriptsPrint5")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts4(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint5")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts4(StudentMaster);
                    end;
                }
            }

            group("Student TranscriptsR1 Print6")
            {
                Caption = 'Student Transcripts Print 6';
                action("Official TranscriptsPrint6")
                {
                    Caption = 'Official Transcript';
                    Image = PrintReport;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";

                    Begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.OfficialTranscripts5(StudentMaster);
                    End;
                }
                action("Unofficial TranscriptsRPrint6")
                {
                    Caption = 'Unofficial Transcript';
                    Image = PrintReport;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                        StudentStatusCU: Codeunit "Student Status Mangement";
                    begin
                        Clear(StudentStatusCU);
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        StudentStatusCU.UnOfficialTranscripts5(StudentMaster);
                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    Begin
    End;

    trigger OnAfterGetRecord()
    Var
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
    begin
        // VisibleBoolean := true;
        // if ("Document Status" = "Document Status"::Verified) or ("Document Status" = "Document Status"::Rejected) then
        //     VisibleBoolean := false;
        PageView := True;
        // StudentMaster.Reset();
        // StudentMaster.Setrange("No.",Rec."Student No.");
        // If StudentMaster.Findfirst() then begin
        //     StudentStatus.Reset();
        //     StudentStatus.Setrange(Code,StudentMaster.Status);
        //     StudentStatus.Setrange(Status,StudentStatus.Status::"Pending Graduation");
        //     IF StudentStatus.Findfirst() then begin
        //         Currpage.Editable := False;
        //         PageView := False;
        //     end;

        // end;

    end;

    var
        StudentDegreeRec: Record "Student Degree";
        CourseDegreeRec: Record "Course Degree";
        //StudentStatusMangementCod: Codeunit "Student Status Mangement";
        // VisibleBoolean: Boolean;
        Text001Lbl: Label 'Do you want to Approve Graduation Audit Application No. %1?';
        Text002Lbl: Label 'Graduation Audit Application No. %1 has been Approved.';
        Text003Lbl: Label 'Do you want to Reject Graduation Audit Application No. %1?';
        Text004Lbl: Label 'Graduation Audit Application No. %1 has been Rejected.';
        Text005Lbl: Label 'Do you want to add another degree for the Student No. %1?';
        PageView: Boolean;

    Procedure StudentHonors(StudentNo: Code[20])
    Var

        StudentMasterRec: Record "Student Master-CS";
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.Get(StudentNo);
        If StudentMasterRec.CGPA > 0 then begin
            StudentMasterRec.StudentHonorsInsert(StudentMasterRec."No.", StudentMasterRec.CGPA);

        end;// Else
        //Error('CGPA is 0 for this Student No. : %1', StudentNo);


    end;


    procedure SendApproveMail(StudNo: Code[20])//GAURAV26/09//22
    var
        SmtpMailRec: Record "Email Account";
        // SmtpMail: Codeunit "Email Message";
        //  WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCS";
        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        Studentmaster: Record "Student Master-CS";
    begin
        // SmtpMailRec.Get();
        // Studentmaster.GET(StudNo);
        // Recipient := Studentmaster."E-Mail Address";
        // Recipients := Recipient.Split(';');
        // SenderName := 'MEA';
        // SenderAddress := SmtpMailRec."Email Address";
        // Subject := Rec."Application No." + ' Degree Audit Application Approval';

        // //Message('%1', Recipient);
        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
        // SmtpMail.AppendtoBody('Dear ' + Studentmaster."Student Name" + ',');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Your Graduate Contact Information Application No. ' + Rec."Application No." + ' has been Approved.');
        // SmtpMail.AppendtoBody('<br><br>');
        // // SmtpMail.AppendtoBody('You can track your Application status under �Graduate Contact Information Form Status� page on student portal.');
        // // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Regards,');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Office of the Registrar');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        // SmtpMail.AppendtoBody('<br><br>');
        // BodyText := SmtpMail.GetBody();
        // Mail_lCU.Send();
        // WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('Approve', 'MEA', SenderAddress, Studentmaster."Student Name",
        //  Studentmaster."No.", Subject, BodyText, 'Approve', 'Approve', '', '',
        //  Recipient, 1, Studentmaster."Mobile Number", '', 1);

    END;

    procedure SendRejectMail(StudNo: Code[20])//GAURAV26/09//22
    var
        SmtpMailRec: Record "Email Account";
        SmtpMail: Codeunit "Email Message";
        WebServicesFunctionsCSCod: Codeunit "WebServicesFunctionsCSL";
        BodyText: text;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];
        Studentmaster: Record "Student Master-CS";
    begin
        SmtpMailRec.Get();
        Studentmaster.GET(StudNo);
        Recipient := Studentmaster."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := Rec."Application No." + ' Degree Audit Application Rejection';

        // Message('%1', Recipient);
        //SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');//GMCSCOM
        SmtpMail.AppendtoBody('Dear ' + Studentmaster."Student Name" + ', ');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Your Graduate Contact Information Application No. ' + Rec."Application No." + ' has been Rejected.');
        SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('For more information, please contact the Registrar department at registrar@auamed.org.');
        // SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Regards,');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('Office of the Registrar');
        SmtpMail.AppendtoBody('<br><br>');
        SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        BodyText := SmtpMail.GetBody();
        // Mail_lCU.Send();//GMCSCOM
        WebServicesFunctionsCSCod.ApiPortalinsertupdatesendNotification('Reject', 'MEA', SenderAddress, Studentmaster."Student Name",
        Studentmaster."No.", Subject, BodyText, 'Reject', 'Reject', '', '',
        Recipient, 1, Studentmaster."Mobile Number", '', 1);

    end;
}

