page 50213 "Certificates Appl Card-CS"
{
    // version V.001-CS

    // Sr.No Emp.ID       Date       Trigger                        Remarks
    // ------------------------------------------------------------ ------------------------------------------------
    // 01.   CSPL-00174   05-04-19   Rejected - OnAction()          Code added for confirmattion message with update status.
    // 02.   CSPL-00174   05-04-19   Approved/Printed - OnAction()  Code added for approval and Printed with mail.

    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Certificates Application-CS";
    caption = 'Pending Transcript/Degree Request Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Certificate; Rec.Certificate)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
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
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }

                field("Organization Name "; Rec."Organization Name ")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Courier Address"; Rec."Courier Address")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
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
                field(Statement; Rec.Statement)
                {
                    ApplicationArea = All;
                    Caption = 'Statement';
                    Visible = false;
                }
                field("Mode of Collection"; Rec."Mode of Collection")
                {
                    ApplicationArea = All;
                }
                Field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Courier Type"; Rec."Courier Type")
                {
                    ApplicationArea = All;
                }
                field("Courier No."; Rec."Courier No.")
                {
                    ApplicationArea = All;
                }
                field("Courier Charges"; Rec."Courier Charges")
                {
                    ApplicationArea = All;
                }
                Field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = all;
                }



                field("Approved or Printed"; Rec."Approved/Printed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Last Print Date/Time"; Rec."Last Print Date/Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No of Prints"; Rec."No of Prints")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Payment; Rec.Payment)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Bursar Hold Exist"; Rec."Bursar Hold Exist")
                {
                    ToolTip = 'Specifies the value of the Bursar Hold Exist field.';
                    ApplicationArea = All;
                }
                Field("Digital Signature Status"; Rec."Digital Signature Status")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";


                action(Complete)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = Completed;
                    ToolTip = 'Complete';
                    trigger OnAction()
                    begin
                        Rec.CalcFields("Bursar Hold Exist");
                        IF Rec."Bursar Hold Exist" then
                            Error('Student is on Bursar Hold');

                        //Code added for confirmattion message with update status::CSPL-00174::050419: Start
                        IF CONFIRM('Do you want to Complete the Application?', FALSE) THEN BEGIN
                            Rec.Status := Rec.Status::Completed;
                            Rec.Updated := TRUE;
                            Rec."Completed By" := UserId();
                            Rec."Application Completed Date" := Today();
                            Rec.Modify();
                            // if Rec."Mode of Collection" <> Rec."Mode of Collection"::"BHHS Degree" then
                            //     // Rec.SendTranscriptMail();
                            // if Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
                            //     Rec.SendDegreeMail();

                            // IF Rec."Mode of Collection" = Rec."Mode of Collection"::"Mail Official Transcript" then
                            //     Rec.CreateNotes('Mailed OT to: ' + Rec."Student Name" + ', ' + Rec."Courier Address");

                            // IF Rec."Mode of Collection" = Rec."Mode of Collection"::"E-Mail Transcript" then
                            //     Rec.CreateNotes('Unofficial Transcript emailed');

                            // If Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
                            //     Rec.CreateNotes('BHHS Degree Request Completed');

                            CurrPage.Close();
                        END;
                        //Code added for confirmation message with update status::CSPL-00174::050419: End
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = Reject;
                    ToolTip = 'Reject';
                    trigger OnAction()
                    begin
                        //Code added for confirmattion message with update status::CSPL-00174::050419: Start
                        IF CONFIRM(' Do you want to Reject this Application Request?', FALSE) THEN BEGIN
                            Rec.Status := Rec.Status::Rejected;
                            Rec.Updated := TRUE;
                            Rec."Rejected By" := UserId();
                            Rec."Rejected On" := Today();
                            Rec.Modify();

                            // IF Rec."Mode of Collection" <> Rec."Mode of Collection"::"BHHS Degree" then
                            //     Rec.TranscriptRejectionMail();
                            // IF Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
                            //     Rec.DegreeRejectionMail();

                            // IF Rec."Mode of Collection" = Rec."Mode of Collection"::"Mail Official Transcript" then
                            //     Rec.CreateNotes('Official Transcript Request Rejected');

                            // IF Rec."Mode of Collection" = Rec."Mode of Collection"::"E-Mail Transcript" then
                            //     Rec.CreateNotes('Unofficial Transcript Request Rejected');

                            // If Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
                            //     Rec.CreateNotes('BHHS Degree Request Rejected');
                            CurrPage.Update();
                            CurrPage.Close();
                        END;
                        //Code added for confirmation message with update status::CSPL-00174::050419: End
                    end;
                }
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
                    // RunPageLink = "No." = FIELD("Student No.");
                }
                action("Official Transcript ReportPrint1")
                {
                    Caption = 'Official Transcript Report Print 1';
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Visible = TranscriptButton;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        OfficialTranscripts(StudentMaster, False);
                    end;
                }

                action("Official Transcript ReportPrint2")
                {
                    Caption = 'Official Transcript Report Print 2';
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Visible = TranscriptButton;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        OfficialTranscripts1(StudentMaster, False);
                    end;
                }

                action("Official Transcript ReportPrint3")
                {
                    Caption = 'Official Transcript Report Print 3';
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Visible = TranscriptButton;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        OfficialTranscripts2(StudentMaster, False);
                    end;
                }
                action("UnOfficial Transcript Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Visible = TranscriptButton;
                    trigger OnAction()
                    var
                        StudentMaster: REcord "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.Get(Rec."Student No.");
                        UnOfficialTranscripts(StudentMaster, False);
                    end;
                }
                action("E-Mail Transcript")
                {
                    Visible = HideMailButton;
                    Image = "Report";
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StudentMaster: Record "Student Master-CS";
                    begin
                        if confirm('Please confirm if you have reviewed Unofficial Transcript? If yes, do you want to send the Unofficial Transcript for the Student No. %1 through E-Mail?', false, Rec."Student No.") then begin
                            StudentMaster.Reset();
                            StudentMaster.Get(Rec."Student No.");
                            UnOfficialTranscripts(StudentMaster, true);
                            Message('Email Sent!');
                        end else
                            exit;
                    end;
                }
                action("Print Degree")
                {
                    Caption = 'Print Degree';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = HideDegreeButton;
                    trigger OnAction()
                    Var
                        StudentDegree: Record "Student Degree";
                        AUABHHSCertificate: Report "AUA BHHS Certificate";
                    //   AUAMasterofHealthScience: Report "AUA Master of Health Science";
                    //   AUADoctorofMedicineDegree: Report "AUA Doctor of Medicine Degree";
                    //   AICASAASHSDegree: Report "AICASA ASHS Degree";
                    //   AICASAEMTBasicAdvanced: Report "AICASA EMT-Basic & Advanced";
                    //   AICASAASNursingDegree: Report "AICASA AS Nursing Degree";
                    begin
                        StudentDegree.Reset();
                        StudentDegree.SetRange("Student No.", Rec."Student No.");
                        StudentDegree.SetRange("Degree Code", 'BAS');
                        if StudentDegree.FindFirst() then begin
                            AUABHHSCertificate.StudentDegreevariable(StudentDegree."Student No.", 'BAS');
                            AUABHHSCertificate.SETTABLEVIEW(StudentDegree);
                            AUABHHSCertificate.RUNMODAL();
                        end;
                    end;

                    // end;
                    // IF "Degree Code" = 'MSHHS' then begin
                    //     AUAMasterofHealthScience.StudentDegreevariable("Student No.", "Degree Code");
                    //     AUAMasterofHealthScience.SETTABLEVIEW(Rec);
                    //     AUAMasterofHealthScience.RUNMODAL()
                    // end;

                    // IF ("Degree Code" IN ['DOC', 'HDOC']) then begin
                    //     AUADoctorofMedicineDegree.StudentDegreevariable("Student No.", "Degree Code");
                    //     AUADoctorofMedicineDegree.SETTABLEVIEW(Rec);
                    //     AUADoctorofMedicineDegree.RUNMODAL()
                    // end;
                    // IF "Degree Code" = 'PM' then begin
                    //     AICASAASHSDegree.StudentDegreevariable("Student No.", "Degree Code");
                    //     AICASAASHSDegree.SETTABLEVIEW(Rec);
                    //     AICASAASHSDegree.RUNMODAL()
                    // end;

                    // IF ("Degree Code" IN ['EMTAL', 'EMTALREC', 'EMTBL', 'EMTFR', 'EMTPA', 'EMTPD']) then begin
                    //     AICASAEMTBasicAdvanced.StudentDegreevariable("Student No.", "Degree Code");
                    //     AICASAEMTBasicAdvanced.SETTABLEVIEW(Rec);
                    //     AICASAEMTBasicAdvanced.RUNMODAL()
                    // end;
                    // IF "Degree Code" = 'NUR' then begin
                    //     AICASAASNursingDegree.StudentDegreevariable("Student No.", "Degree Code");
                    //     AICASAASNursingDegree.SETTABLEVIEW(Rec);
                    //     AICASAASNursingDegree.RUNMODAL()
                    //    end;

                }
                action("E-mail Degree")
                {
                    Caption = 'E-mail Degree';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = False;
                    trigger OnAction()
                    Var
                        StudentDegree: Record "Student Degree";
                        AUABHHSCertificate: Report "AUA BHHS Certificate";
                    //   AUAMasterofHealthScience: Report "AUA Master of Health Science";
                    //   AUADoctorofMedicineDegree: Report "AUA Doctor of Medicine Degree";
                    //  AICASAASHSDegree: Report "AICASA ASHS Degree";
                    //  AICASAEMTBasicAdvanced: Report "AICASA EMT-Basic & Advanced";
                    //  AICASAASNursingDegree: Report "AICASA AS Nursing Degree";
                    begin
                        if confirm('Please confirm if you have accessed BHHS Degree? If yes, do you want to send the BHHS Degree for the Student No. %1 through E-Mail?', false, Rec."Student No.") then begin
                            StudentDegree.Reset();
                            StudentDegree.SetRange("Student No.", Rec."Student No.");
                            StudentDegree.SetRange("Degree Code", 'BAS');
                            if StudentDegree.FindFirst() then begin
                                AUABHHSCertificate.StudentDegreevariable(StudentDegree."Student No.", 'BAS');
                                AUABHHSCertificate.SETTABLEVIEW(StudentDegree);
                                // FileName := TEMPORARYPATH + DELCHR(StudentDegree."Student No.", '=', '/') + '.pdf';
                                // AUABHHSCertificate.SAVEASPDF(FileName);
                                SendmailwithBHHSAttachement(FileName);
                            end;
                        end else
                            exit;
                        Message('Email Sent!');
                    end;
                }
            }
        }
    }

    var
        StudentMasterRec: Record "Student Master-CS";
        // WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        FileName: text;
        i: integer;
        HideMailButton: Boolean;
        HideDegreeButton: Boolean;
        TranscriptButton: Boolean;

    Procedure OfficialTranscript(Email: Boolean; GD1: Code[20])
    var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        StudentMasterRec1: Record "Student Master-CS";
        TranscriptTable: Record Transcript;
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
    begin
        StudentMasterRec1.Get(Rec."Student No.");

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", False);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // MedicineOfficialTranscriptNew.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    MedicineOfficialTranscriptNew.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", False);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // AICASAEMTTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AICASAEMTTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", False);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // SendmailwithAttachement(FileName);
                end else
                    AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;




        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", False);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // StandardTranCreTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    StandardTranCreTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", False);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // AUAMedicineMasterScienceReport.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAMedicineMasterScienceReport.RUNMODAL();
                // end;
            end;
        end;

    end;

    Procedure UnOfficialTranscript(Email: Boolean; GD1: Code[20]);
    var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        StudentMasterRec1: Record "Student Master-CS";
        TranscriptTable: Record Transcript;
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
    begin
        StudentMasterRec1.Get(Rec."Student No.");

        TCFound := false;

        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", True);

                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // MedicineOfficialTranscriptNew.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    MedicineOfficialTranscriptNew.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", True);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // AICASAEMTTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AICASAEMTTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", True);

                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // AUAColOfMedicineVeterinary.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;





        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", StudentMasterRec1."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", True);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // StandardTranCreTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    StandardTranCreTranscript.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", GD1);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", StudentMasterRec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable(GD1, StudentMasterRec1."Original Student No.", True);

                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(StudentMasterRec1."No.", '=', '/') + '.pdf';
                    // AUAMedicineMasterScienceReport.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAMedicineMasterScienceReport.RUNMODAL();
                // end;
            end;
        end;

    end;

    Procedure SendmailwithAttachement(FileName1: Text)
    var

        SmtpMailRec: Record "Email Account";
        DimensionValuesRec: Record "Dimension Value";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";

        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];

    begin
        SLEEP(500);


        //GENERATE MAIL TO STUDENT WITH ATTACHMENT
        SmtpMailRec.Get();
        CompanyInformation.Get();
        Studentmaster.GET(Rec."Student No.");
        Rec.TestField(Rec."E-Mail Address");

        DimensionValuesRec.Reset();
        DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
        DimensionValuesRec.SetRange(Code, Rec."Global Dimension 1 Code");
        if DimensionValuesRec.FindFirst() then;

        Recipient := Rec."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        Subject := (Format(Rec."Application No.") + ' ' + 'Unofficial Transcript Request Application');

        // // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        // SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('With reference to Transcript Request Application' + ' ' +
        //                      Format("Application No.") + ' ' + 'raised by you, please find the Transcript attached.');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody('Regards,');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Registrar Office');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
        // SmtpMail.AddAttachment(FileName1, Rec."Student Name" + ' - ' + Rec."Student No." + '.pdf');
        // // SmtpMail.AddAttachment(FileName1, Rec."Student Name" + ' - ' + Rec."Student No." + '2.pdf');
        // // SmtpMail.AddAttachment(FileName1, Rec."Student Name" + ' - ' + Rec."Student No." + '3.pdf');
        // // SmtpMail.AddAttachment(FileName1, Rec."Student Name" + ' - ' + Rec."Student No." + '4.pdf');
        // // SmtpMail.AddAttachment(FileName1, Rec."Student Name" + ' - ' + Rec."Student No." + '5.pdf');
        // BodyText := SmtpMail.GetBody();
        // BodyText := BodyText.Replace('<br><br>', ' ');
        // if CompanyInformation."Send Email On/Off" then
        //     Mail_lCU.Send();

        // WebServicesFunctionsCod.EmailNotificationForTranscriptDegree('Transcript', 'MEA', SenderAddress, Format("Student Name"),
        // "Student No.", Subject, BodyText, 'Transcript', 'Transcript', "Application No.", Format("Application Date", 0, 9),
        // Recipient, 1, Studentmaster."Mobile Number", '', 1, FileName1, Rec."Courier Address");

        AddAttachmentatNotes(FileName1, CopyStr(BodyText, 1, 2048));

        //ERASE FILE
        // IF EXISTS(FileName1) THEN
        // ERASE(FileName1);
    end;
    //end;
    Procedure SendmailwithBHHSAttachement(FileName1: Text)
    var

        SmtpMailRec: Record "Email Account";
        DimensionValuesRec: Record "Dimension Value";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];


    begin
        SLEEP(500);

        //GENERATE MAIL TO STUDENT WITH ATTACHMENT
        SmtpMailRec.Get();
        CompanyInformation.Get();
        Studentmaster.GET(Rec."Student No.");
        Rec.TESTFIELD(Rec."E-Mail Address");

        DimensionValuesRec.Reset();
        DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
        DimensionValuesRec.SetRange(Code, Rec."Global Dimension 1 Code");
        if DimensionValuesRec.FindFirst() then;

        Recipient := Rec."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        // Subject := (Format("Application No.") + ' ' + 'BHHS Degree');

        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        // SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('With reference to BHHS Degree Request Application' + ' ' +
        //                      Format("Application No.") + ' ' + 'raised by you, please find the Degree attached.');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody('Regards,');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Registrar Office');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('<br>');
        // SmtpMail.AppendtoBody('This is system generated mail, Please do not reply on this E-mail ID.');
        // SmtpMail.AddAttachment(FileName1, FileName1);
        // BodyText := SmtpMail.GetBody();
        // if CompanyInformation."Send Email On/Off" then
        //     Mail_lCU.Send();

        // WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('BHHS Degree', 'MEA', SenderAddress, Format("Student Name"),
        // "Student No.", Subject, BodyText, 'BHHS Degree', 'BHHS Degree', "Application No.", Format("Application Date", 0, 9),
        // Recipient, 1, Studentmaster."Mobile Number", '', 1);

        AddAttachmentatNotes(FileName1, CopyStr(BodyText, 1, 2048));
        //ERASE FILE
        // IF EXISTS(FileName1) THEN
        //     ERASE(FileName1);
    end;

    procedure OfficialTranscripts(Rec: Record "Student Master-CS"; Email: Boolean)
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report "Standard Tran Cre Transcript";
        MedicineOfficialTranscriptNew: Report "Standard Transcript";
        AICASAEMTTranscript: Report "AICASA EMT Transcript";
        AUAColOfMedicineVeterinary: Report "AUA Col Of Medicine Veterinary";
        AUAMedicineMasterScienceReport: Report "AUA Col Of Medicine MS";
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // MedicineOfficialTranscriptNew.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    MedicineOfficialTranscriptNew.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AICASAEMTTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AICASAEMTTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAColOfMedicineVeterinary.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // StandardTranCreTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    StandardTranCreTranscript.RUNMODAL();
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAMedicineMasterScienceReport.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAMedicineMasterScienceReport.RUNMODAL();
            end;
        end;

    End;

    procedure UnOfficialTranscripts(Rec: Record "Student Master-CS"; Email: Boolean)
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        // Tempblob: Record TempBlob temporary;
        StandardTranCreTranscript: Report STansferCreditTransciptMail;
        MedicineOfficialTranscriptNew: Report StandardTranscriptMail;
        AICASAEMTTranscript: Report AICASAEMTMail;
        AUAColOfMedicineVeterinary: Report AUAMVeterinaryTranscriptMail;
        AUAMedicineMasterScienceReport: Report AUACOMMasterScienceTMail;

        TCFound: Boolean;
        TransciptDataFilter: Boolean;
        OStream: OutStream;
        IStream: InStream;
    // FileMngt: Codeunit "File Management";
    // Tempblob: Codeunit "TempBlob Test";
    Begin
        // Tempblob.Reset();
        // Tempblob.DeleteAll();

        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // MedicineOfficialTranscriptNew.SaveAsPdf(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    MedicineOfficialTranscriptNew.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AICASAEMTTranscript.SaveAsPdf(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AICASAEMTTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAColOfMedicineVeterinary.SaveAsPdf(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // StandardTranCreTranscript.SaveAsPdf(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    StandardTranCreTranscript.RUNMODAL();
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", True, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAMedicineMasterScienceReport.SaveAsPdf(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAMedicineMasterScienceReport.RUNMODAL();
            end;
        end;

    End;

    Procedure AddAttachmentatNotes(FileName: Text[2048]; Notes: Text[2048])
    Var
        SDA: Record "Student Document Attachment";
        StudentMaster: Record "Student Master-CS";
        TempBlob: Record "TempBlob Test";
        StudentDocumentAttachment: Record "Student Document Attachment";
        InteractionLogEntry: Record "Interaction Log Entry";
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        UserSetup: Record "User Setup";
        // FileMgmt: Codeunit "File Management";
        EntryNo: Integer;
        locOutFile: BigText;
        //ClinicalNotification: Codeunit "Clinical Notification"; Rec. //TO_DO
        ResponseText: Text;
        IStream: InStream;
        TransactionNo: Text[100];
        WindowDialog: Dialog;
        PDFFile: Boolean;
        DocumentSubCategory: Text;
        DocumentCategory: Text;
        SLCMDocNo: Text;
        SubCode: Text;
        NoteEntryNo: Integer;
    Begin
        StudentMaster.Reset();
        if StudentMaster.Get(Rec."Student No.") then;

        DocumentSubCategory := 'STUNDENTNOTES';
        DocumentCategory := 'NOTES';
        SLCMDocNo := 'STUNDENTNOTES';
        SubCode := 'STUNDENTNOTES';

        EntryNo := 0;
        InterLogEntryCommentLine.Reset();
        if InterLogEntryCommentLine.FindLast() then
            EntryNo := InterLogEntryCommentLine."Entry No."
        else
            EntryNo := 0;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        InterLogEntryCommentLine.Init();
        InterLogEntryCommentLine."Entry No." := EntryNo + 1;
        InterLogEntryCommentLine."Source No." := Rec."Student No.";
        InterLogEntryCommentLine.Validate("Interaction Template Code", 'Student');
        InterLogEntryCommentLine.Validate("Interaction Group Code", 'Student');
        InterLogEntryCommentLine.Validate("Student No.", Rec."Student No.");
        InterLogEntryCommentLine.Validate("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        InterLogEntryCommentLine.Department := InterLogEntryCommentLine.Department::Graduation;
        InterLogEntryCommentLine.Notes := Notes;
        InterLogEntryCommentLine."Student Notes" := true;
        InterLogEntryCommentLine."Created By" := UserId;
        InterLogEntryCommentLine."Created On" := Today;
        InterLogEntryCommentLine.Insert(true);
        NoteEntryNo := 0;
        NoteEntryNo := EntryNo + 1;
        Commit();

        EntryNo := 0;
        StudentDocumentAttachment.Reset();
        if StudentDocumentAttachment.FindLast() then
            EntryNo := StudentDocumentAttachment."Entry No.";
        EntryNo := EntryNo + 1;



        // TempBlob.Reset();
        // TempBlob.DeleteAll();

        // TempBlob.INIT();
        // TempBlob.Blob.IMPORT(FileName);
        // TempBlob.INSERT();
        // TempBlob.Blob.CREATEINSTREAM(IStream);
        // MemoryStream := MemoryStream.MemoryStream();
        // COPYSTREAM(MemoryStream, IStream);
        // Bytes := MemoryStream.GetBuffer();
        // locOutFile.ADDTEXT(Convert.ToBase64String(Bytes));
        // ResponseText := SDA.UploadSchoolDoc(StudentMaster."Original Student No.", DocumentSubCategory, FileName, Format(locOutFile));

        IF StrPos(ResponseText, '1</Success>') > 0 then begin
            TransactionNo := SDA.FindStringValue(ResponseText);

            SDA.Init();
            SDA."Entry No." := EntryNo;
            SDA."Document Category" := 'NOTES';
            SDA."Document Sub Category" := 'STUNDENTNOTES';
            SDA."Document Description" := 'STUNDENTNOTES';
            SDA.Validate("Student No.", Rec."Student No.");
            SDA."Student Name" := StudentMaster."Student Name";
            SDA."Subject Code" := 'DOCUMENTATION';
            SDA."SLcM Document No" := 'STUNDENTNOTES';
            SDA."Document Specialist ID" := StudentMaster."Document Specialist";
            SDA."Transaction No." := TransactionNo;
            SDA."Note Entry No" := NoteEntryNo;
            SDA."File Name" := FileName;
            //SDA."File Type" := '.pdf';
            SDA."Uploaded Source" := SDA."Uploaded Source"::SLcMBC;
            SDA."Document Status" := SDA."Document Status"::"Submitted";
            SDA."Submission Date" := Today;
            SDA."Uploaded By" := UserId;
            SDA."Uploaded On" := Today;
            SDA.Insert(true);
        end

    End;


    trigger OnOpenPage()
    begin
        HideMailButton := false;
        if (Rec."Mode of Collection" = Rec."Mode of Collection"::"E-Mail Transcript") and (Not Rec."Bursar Hold Exist") then
            HideMailButton := true;

        HideDegreeButton := false;
        if Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
            HideDegreeButton := true;

        TranscriptButton := false;
        Rec.CalcFields("Bursar Hold Exist");
        if (Rec."Mode of Collection" <> Rec."Mode of Collection"::"BHHS Degree") and (Not Rec."Bursar Hold Exist") then
            TranscriptButton := true;

    end;

    trigger OnAfterGetRecord()
    begin
        HideMailButton := false;
        if (Rec."Mode of Collection" = Rec."Mode of Collection"::"E-Mail Transcript") and (Not Rec."Bursar Hold Exist") then
            HideMailButton := true;

        HideDegreeButton := false;
        if Rec."Mode of Collection" = Rec."Mode of Collection"::"BHHS Degree" then
            HideDegreeButton := true;

        TranscriptButton := false;
        Rec.CalcFields("Bursar Hold Exist");
        if (Rec."Mode of Collection" <> Rec."Mode of Collection"::"BHHS Degree") and (Not Rec."Bursar Hold Exist") then
            TranscriptButton := true;
    end;


    var


    procedure TranscriptRejectionMail()
    var

        SmtpMailRec: Record "Email Account";
        DimensionValuesRec: Record "Dimension Value";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];

    begin
        SLEEP(500);

        //GENERATE MAIL TO STUDENT WITH ATTACHMENT
        SmtpMailRec.Get();
        CompanyInformation.Get();
        Studentmaster.GET(Rec."Student No.");
        Rec.TestField(Rec."E-Mail Address");

        DimensionValuesRec.Reset();
        DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
        DimensionValuesRec.SetRange(Code, Rec."Global Dimension 1 Code");
        if DimensionValuesRec.FindFirst() then;

        Recipient := Rec."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        // Subject := (Format("Application No.") + ' ' + 'Transcript Request Application Rejection');

        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        // SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Your Transcript Request Application No. ' + Format("Application No.") + ' ' + 'has been Rejected.');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('For more information, please contact the Registrar department at registrar@auamed.org.');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Regards,');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Office of the Registrar');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE � PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        // BodyText := SmtpMail.GetBody();
        // if CompanyInformation."Send Email On/Off" then
        //     Mail_lCU.Send();

        // WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Transcript Request Rejection', 'MEA', SenderAddress, Format("Student Name"),
        // "Student No.", Subject, BodyText, 'Transcript Request Rejection', 'Transcript Request Rejection', "Application No.", Format("Application Date", 0, 9),
        // Recipient, 1, Studentmaster."Mobile Number", '', 1);

        //AddAttachmentatNotes(FileName1, CopyStr(BodyText, 1, 2048));

        //ERASE FILE

    end;

    procedure DegreeRejectionMail()
    var

        SmtpMailRec: Record "Email Account";
        DimensionValuesRec: Record "Dimension Value";
        StudentMaster: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        SenderName: Text[100];
        SenderAddress: Text[250];
        Subject: Text[100];
        Recipients: List of [Text];
        Recipient: Text[100];

    begin
        SLEEP(500);

        //GENERATE MAIL TO STUDENT WITH ATTACHMENT
        SmtpMailRec.Get();
        CompanyInformation.Get();
        Studentmaster.GET(Rec."Student No.");
        Rec.TestField(Rec."E-Mail Address");

        DimensionValuesRec.Reset();
        DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
        DimensionValuesRec.SetRange(Code, Rec."Global Dimension 1 Code");
        if DimensionValuesRec.FindFirst() then;

        Recipient := Rec."E-Mail Address";
        Recipients := Recipient.Split(';');
        SenderName := 'MEA';
        SenderAddress := SmtpMailRec."Email Address";
        // Subject := (Format("Application No.") + ' ' + 'BHHS Degree Request Application Rejection');

        // SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

        // SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name");
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Your BHHS Degree Request Application No. ' + Format("Application No.") + ' ' + 'has been Rejected.');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('For more information, please contact the Registrar department at registrar@auamed.org.');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Regards,');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('Office of the Registrar');
        // SmtpMail.AppendtoBody('<br><br>');
        // SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE � PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
        // BodyText := SmtpMail.GetBody();
        // if CompanyInformation."Send Email On/Off" then
        //     Mail_lCU.Send();

        // WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('BHHS Degree Request Rejection', 'MEA', SenderAddress, Format("Student Name"),
        // "Student No.", Subject, BodyText, 'BHHS Degree Request Rejection', 'BHHS Degree Request Rejection', "Application No.", Format("Application Date", 0, 9),
        // Recipient, 1, Studentmaster."Mobile Number", '', 1);

        //AddAttachmentatNotes(FileName1, CopyStr(BodyText, 1, 2048));

        //ERASE FILE

    end;

    procedure OfficialTranscripts1(Rec: Record "Student Master-CS"; Email: Boolean)
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript1;
        MedicineOfficialTranscriptNew: Report StandardTranscript1;
        AICASAEMTTranscript: Report AICASAEMTTranscript1;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript1;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript1;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // MedicineOfficialTranscriptNew.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    MedicineOfficialTranscriptNew.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AICASAEMTTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AICASAEMTTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAColOfMedicineVeterinary.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // StandardTranCreTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    StandardTranCreTranscript.RUNMODAL();
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAMedicineMasterScienceReport.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAMedicineMasterScienceReport.RUNMODAL();
            end;
        end;

    End;


    procedure OfficialTranscripts2(Rec: Record "Student Master-CS"; Email: Boolean)
    Var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        TranscriptTable: Record Transcript;
        CourseMasterRec: Record "Course Master-CS";
        StandardTranCreTranscript: Report TCStandardTranscript2;
        MedicineOfficialTranscriptNew: Report StandardTranscript2;
        AICASAEMTTranscript: Report AICASAEMTTranscript2;
        AUAColOfMedicineVeterinary: Report VeterinaryTranscript2;
        AUAMedicineMasterScienceReport: Report MSHHSTranscript2;
        TCFound: Boolean;
        TransciptDataFilter: Boolean;
    Begin
        TransciptDataFilter := false;
        CourseMasterRec.Reset();
        CourseMasterRec.SetRange(Code, Rec."Course Code");
        IF CourseMasterRec.FindFirst() then
            IF CourseMasterRec."Transcript Data Filter" then
                TransciptDataFilter := true;

        TCFound := false;
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.FindSet() then
            repeat
                if RecMainStudentSubject.TC then
                    TCFound := true;
            until RecMainStudentSubject.Next() = 0;
        if not TCFound then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50109);
            TranscriptTable.setRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                MedicineOfficialTranscriptNew.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // MedicineOfficialTranscriptNew.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    MedicineOfficialTranscriptNew.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50118);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AICASAEMTTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AICASAEMTTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AICASAEMTTranscript.RUNMODAL();
            end;
        end;


        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50123);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAColOfMedicineVeterinary.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAColOfMedicineVeterinary.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAColOfMedicineVeterinary.RUNMODAL();
            end;
        end;



        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.SetRange(TC, true);
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50129);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                StandardTranCreTranscript.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // StandardTranCreTranscript.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    StandardTranCreTranscript.RUNMODAL();
            end;
        end;

        Clear(AUAMedicineMasterScienceReport);
        RecMainStudentSubject.RESET();
        RecMainStudentSubject.SetRange("Original Student No.", Rec."Original Student No.");
        IF not TransciptDataFilter then
            RecMainStudentSubject.SetRange("Enrollment No", Rec."Enrollment No.");
        RecMainStudentSubject.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        IF RecMainStudentSubject.Findfirst() then begin
            TranscriptTable.Reset();
            TranscriptTable.Setrange("Object Id", 50192);
            TranscriptTable.SetRange("Course Code", Rec."Course Code");
            if TranscriptTable.FindFirst() then begin
                AUAMedicineMasterScienceReport.Unofficialvariable1(Rec."Enrollment No.", Rec."Original Student No.", Rec."Global Dimension 1 Code", Rec."Course Code", false, TransciptDataFilter);
                if Email then begin
                    // FileName := TEMPORARYPATH + DELCHR(Rec."No.", '=', '/') + '.pdf';
                    // AUAMedicineMasterScienceReport.SAVEASPDF(FileName);
                    SendmailwithAttachement(FileName);
                end else
                    AUAMedicineMasterScienceReport.RUNMODAL();
            end;
        end;
    End;

}
