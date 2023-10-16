page 50956 "Student Subject Exam List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Subject Exam";
    Caption = 'Student Subject Exam List';
    // Editable = false;
    //DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;


    layout
    {
        area(Content)
        {
            repeater("Student Subject Exam")
            {
                Field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                Field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Published; Rec.Published)
                {
                    ApplicationArea = All;
                }
                field("Published Document No."; Rec."Published Document No.")
                {
                    ApplicationArea = All;
                    //Visible = False;
                }

                Field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Internal Mark"; Rec."Internal Mark")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shelf Exam Value"; Rec."Shelf Exam Value")
                {
                    ApplicationArea = All;
                }
                field("External Mark"; Rec."External Mark")
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                }
                field("Sitting Date"; Rec."Sitting Date")
                {
                    ApplicationArea = All;
                }

                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                }
                Field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Credit Earned"; Rec."Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Credit Grade Points Earned"; Rec."Credit Grade Points Earned")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Total Internal"; Rec."Total Internal")
                {
                    ApplicationArea = All;
                    Visible = false;
                }


                field("Score Type"; Rec."Score Type")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("CBSE Version"; Rec."CBSE Version")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Grade Book No."; Rec."Grade Book No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        GradeBookHdr: Record "Grade Book Header";
                    begin
                        GradeBookHdr.Reset();
                        GradeBookHdr.Get(Rec."Grade Book No.");
                        if Page.RunModal(0, GradeBookHdr) = Action::LookupOK then;
                    end;
                }
                Field(Remakrs; Rec.Remakrs)
                {
                    ApplicationArea = All;
                }

                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Exam Sequence"; Rec."Exam Sequence")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Category-Course Description"; Rec."Category-Course Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Core Clerkship Subject Code"; Rec."Core Clerkship Subject Code")
                {
                    ApplicationArea = all;

                }
                field("Core Clerkship Subject Desc"; Rec."Core Clerkship Subject Desc")
                {
                    ApplicationArea = all;
                }
                field("School ID"; Rec."School ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field(TC; Rec.TC)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;

                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Date Certified"; Rec."Date Certified")
                {
                    ApplicationArea = All;
                }

                field("Exam Window"; Rec."Exam Window")
                {
                    ApplicationArea = All;

                }

                field("Exam. Location"; Rec."Exam. Location")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                Field("Published Entry No."; Rec."Published Entry No.")
                {
                    ApplicationArea = All;
                    Visible = False;
                }

            }
        }
    }



    actions
    {
        area(Processing)
        {
            action("Templete Send")
            {
                ApplicationArea = All;
                Image = Mail;
                Caption = 'Templete Send';
                trigger OnAction()
                var
                    CCSSEScoreConversion: Record "CCSSE Score Conversion";
                begin
                    // If Rec.Result = Rec.Result::Fail then
                    //     ExamFailure();

                    //    CCSSEScoreConversion.Reset();
                    //    CCSSEScoreConversion/
                    //    CCSSEScoreConversion.SetRange("Course Code",Rec."Core Clerkship Subject Code");
                    //    IF CCSSEScoreConversion.FindFirst() then
                    // If Rec.Result = Rec.Result::pass then begin

                    //     IF Rec."Core Clerkship Subject Code" = 'FMCCSSE' then
                    //         FMCCSECongratulations(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'IMCCSSE' then
                    //         IMCCSECongratulations(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'OBGCCSSE' then
                    //         OBGCCSSE(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'PEDCCSSE' then
                    //         PediatricsCCSE(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'PSYCCSSE' then
                    //         PsychCCSE(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'CK' then
                    //         Step2CK(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'SURCCSSE' then
                    //         SurgeryCCSE(Rec."Student No.");

                    //     IF Rec."Core Clerkship Subject Code" = 'CCSE' then
                    //         CCSE(Rec."Student No.");
                    // end;
                end;

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    // myInt: Integer;
    begin
        RecUserSetup.Reset();
        RecUserSetup.Get(UserId);
        if Not RecUserSetup."Insert Student Subject Exam" then
            Error('You do not have permission to create new record');
    end;

    trigger OnModifyRecord(): Boolean
    var
    // myInt: Integer;
    begin
        RecUserSetup.Reset();
        RecUserSetup.Get(UserId);
        if Not RecUserSetup."Modify Student Subject Exam" then
            Error('You do not have permission to modify');
    end;

    var
        RecUserSetup: Record "User Setup";
    //     //
    //     procedure ExamFailure()//Nitin
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //         StudentMasterCS: Record "Student Master-CS";
    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //     begin
    //         SmtpMailRec.Get();
    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';// StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'Exam Failure';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('We hope that this message finds you well. The Clinical EED Faculty is sorry to hear that you' +
    //                          'were unsuccessful on your recent examination. We want you to know that we are available to ' +
    //                          'you for academic advising. We can provide you with cognitive restructuring guidance, study ' +
    //                          'strategies and resources to improve your outcomes. The Clinical EED faculty encourage you to' +
    //                          'make an appointment using Microsoft Bookings. You can schedule with Dr. Nelda Ephraim,' +
    //                          'Professor Qunoot Almecci or Dr. JR Ratliff. Please use the link below to access our Bookings' +
    //                          'link and select a topic(s) that you would like to cover during our appointment.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Thank you for scheduling an appointment. We look forward to meeting with you.');
    //         SmtpMail.AppendtoBody('<br><br><br>');
    //         SmtpMail.AppendtoBody('Sincerely,');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Manipal EducatiFailureon Americas, LLC');
    //         SmtpMail.AppendtoBody('40 Wall Street, 10th Floor');
    //         SmtpMail.AppendtoBody('New York, NY 10005');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('www.auamed.org');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Exam Failure', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'Exam Failure', 'Exam Failure', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     /////////////2            
    //     procedure FMCCSECongratulations(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();
    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';//StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'FM CCSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the Family Medicine CCCSE examination! Over the past six weeks of your ' +
    //                             'Family Medicine rotation, your exposure to common facets of this specialty and sincere efforts at ' +
    //                             'success have been fruitful. Completing this core rotation is a significant milestone in your medical ' + 'education. Devote some time to commend yourself for a job well done and engage in some self-care. It ' +
    //                             'certainly is a positive way to continue forward along the path to write your next examination.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + 'program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
    //                             'taking skills and content mastery. There is a QP Shelf Prep for each subject core');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in the Question Partners Program if you are preparing for the CCSSE.' + 'Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and' +
    //                             'prepare you for writing your exams. These new question sets will further enhance the efficacy of the' + 'Question Partners Program, which already has proven to improve outcomes for those who have' + 'enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The sign-up area for the QP Shelf Prep Program and the Question Partners Program is located in the' + 'AUA Clinical Pulse. If you attempt to sign up and there is no group available, that is an indication that all' +
    //                             'groups are full. Please contact Dr. Ephraim @ nephraim@auamed.org for more information.');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('FM CCSE Congratulations', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'FM CCSE Congratulations', 'FM CCSE Congratulations', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;

    //     ///3
    //     procedure IMCCSECongratulations(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();
    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';// StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'IM CCSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the Internal Medicine CCCSE examination! In the field of medicine, Internal' +
    //                          'Medicine is the largest sub-discipline and has the most subspecialties. Successful completion of this core' +
    //                          'rotation is a huge milestone in your medical education. Take some time to celebrate your success and ' + 'engage in some self-care. It will be a great way to reset yourself as you forge forth on the path to write' +
    //                          'your next examination.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This' + 'program is specifically tailored for students who are taking core rotations and focuses on improving test' +
    //                             'taking skills and content mastery. There is a QP Shelf Prep for each subject core');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in the Question Partners Program if you are preparing for the CCSSE.' + 'Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and' +
    //                              'prepare you for writing your exams. These new question sets will further enhance the efficacy of the ' + 'Question Partners Program, which already has proven to improve outcomes for those who have ' + 'enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The sign-up area for the QP Shelf Prep Program and the Question Partners Program is located in the' + 'AUA Clinical Pulse. If you attempt to sign up and there is no group available, that is an indication that all' +
    //                             'groups are full. Please contact Dr. Ephraim @ nephraim@auamed.org for more information.');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Best of Regards from the Clinical Education Enhancement Team! ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('IM CCSE Congratulations', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'IM CCSE Congratulations', 'IM CCSE Congratulations', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     //4
    //     procedure OBGCCSSE(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();

    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';//StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'OBG CCSSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the Ob/GYN CCCSE examination! OB/GYN Chair Dr. John Riggs says that' +
    //                             '�OB/GYN is a specialty that incorporates almost all other services being that many female patients only' +
    //                             'see their OB/GYN as their primary care provider�. Your success at the OB/GYN CCSSE demonstrates your' + 'ability to cover all aspects of womens health as designated by this specialty practice. Do carve out time' +
    //                             'to celebrate your success while you continue to complete the milestones in your medical education. We' + 'also suggest you partake in self-care along your journey. Self-care is an important part of continued' +
    //                             'success as you advance toward writing your next examination.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This' + 'program is specifically tailored for students who are taking core rotations and focuses on improving test' +
    //                             'taking skills and content mastery. There is a QP Shelf Prep for each subject core');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in the Question Partners Program if you are preparing for the CCSSE.' + 'Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and' +
    //                              'prepare you for writing your exams. These new question sets will further enhance the efficacy of' + 'Question Partners Program, which already has proven to improve outcomes for those who have' + 'enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The sign-up area for the QP Shelf Prep Program and the Question Partners Program is located in the' + 'AUA Clinical Pulse. If you attempt to sign up and there is no group available, that is an indication that all' +
    //                             'groups are full. Please contact Dr. Ephraim @ nephraim@auamed.org for more information.');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Best of Regards from the Clinical EducationEnhancement Team!');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('OBG CCSSE', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'OBG CCSSE', 'OBG CCSSE', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     //5
    //     procedure PediatricsCCSE(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();

    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';//StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'Pediatrics CCSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the Pediatrics CCCSE examination! Pediatrics has many intricacies that' +
    //                          'require the aspiring physician to be attentive to. Your attention to these details �will go a long way' +
    //                          'toward making you a good doctor, which is what it�s all about� as Pediatrics Chair, Dr. Eden says. As you' + 'continue to complete the milestones in your medical education, we suggest you take time to celebrate' +
    //                          'your success and engage in some self-care. Self-care is an important part of continued success as you' + 'progress along your path to write your next examination.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This' + 'program is specifically tailored for students who are taking core rotations and focuses on improving test' +
    //                             'taking skills and content mastery. There is a QP Shelf Prep for each subject core');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in the Question Partners Program if you are preparing for the CCSSE.' + 'Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and' +
    //                              'prepare you for writing your exams. These new question sets will further enhance the efficacy of the' + 'Question Partners Program, which already has proven to improve outcomes for those who have' + 'enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The sign-up area for the QP Shelf Prep Program and the Question Partners Program is located in the' + 'AUA Clinical Pulse. If you attempt to sign up and there is no group available, that is an indication that all' +
    //                             'groups are full. Please contact Dr. Ephraim @ nephraim@auamed.org for more information.');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Best of Regards from the Clinical Education Enhancement Team!');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Pediatrics CCSE', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'Pediatrics CCSE', 'Pediatrics CCSE', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     //6
    //     procedure PsychCCSE(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();

    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';//StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'Psych CCSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the Psychiatry CCSSE examination! Take pride in your successful completion' +
    //                           'of this core rotation. Be sure to reserve some time to celebrate your achievement while you progress to' +
    //                           'your next milestone in your medical education. Do not forget to engage in some self-care as it is a vital' +
    //                           'part of your success in writing your next examination.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This' + 'program is specifically tailored for students who are taking core rotations and focuses on improving test' +
    //                             'taking skills and content mastery. There is a QP Shelf Prep for each subject core.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in the Question Partners Program if you are preparing for the CCSSE.' + 'Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and' +
    //                              'prepare you for writing your exams. These new question sets will further enhance the efficacy of the' + 'Question Partners Program, which already has proven to improve outcomes for those who have' + 'enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The sign-up area for the QP Shelf Prep Program and the Question Partners Program is located in the' + 'AUA Clinical Pulse. If you attempt to sign up and there is no group available, that is an indication that all' +
    //                             'groups are full. Please contact Dr. Ephraim @ nephraim@auamed.org for more information. ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Best of Regards from the Clinical EducationEnhancement Team!');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Psych CCSE', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'Psych CCSE', 'Psych CCSE', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     //7
    //     procedure Step2CK(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();

    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';//StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'Step 2 CK';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('A Hearty Congratulations to you on passing Step 2 CK! The Step 2 CK exam represents your ability to' +
    //                            'apply your medical knowledge, skills and understanding of the clinical sciences that are essential in' +
    //                            'providing care essential for health promotion and disease prevention. Words cannot express how happy' +
    //                            'we are for you as you celebrate this milestone, which is one of the requirements toward the completion' + 'of your medical degree. YOU DID IT!!!');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Take a bow, be proud and stand tall. You deserve all the praise for a job well done.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Cheers and Best of Regards from the Clinical Education Enhancement Team!');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Manipal Education Americas, LLC');
    //         SmtpMail.AppendtoBody('40 Wall Street, 10th Floor');
    //         SmtpMail.AppendtoBody('New York, NY 10005');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('www.auamed.org');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Step 2 CK', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'Step 2 CK', 'Step 2 CK', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     //8
    //     procedure SurgeryCCSE(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();

    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';// StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'Surgery CCSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the Surgery CCSSE examination! Surgery is an extensive field of practice and' +
    //                          'includes all specialties from pediatric cardiac surgery to neurosurgery. Take pride in your successful ' +
    //                          'completion of this core rotation. It is essential that you reserve some time to celebrate your ' +
    //                          'achievement while you progress to your next milestone in your medical education. Do not forget to ' + 'engage in some self-care as it is a vital part of your success in writing your next examination. ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you are entering another core rotation, the QP Shelf Prep Program may be of interest to you. This ' + 'program is specifically tailored for students who are taking core rotations and focuses on improving test ' +
    //                             'taking skills and content mastery. There is a QP Shelf Prep for each subject core');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in the Question Partners Program if you are preparing for the CCSSE.' +
    //                              'Our Clinical Scholars Team has prepared new question sets to challenge your knowledge base and ' +
    //                              'prepare you for writing your exams. These new question sets will further enhance the efficacy of the ' +
    //                              'Question Partners Program, which already has proven to improve outcomes for those who have ' + 'enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('The sign-up area for the QP Shelf Prep Program and the Question Partners Program is located in the ' +
    //                              'AUA Clinical Pulse. If you attempt to sign up and there is no group available, that is an indication that all  ' +
    //                              'groups are full. Please contact Dr. Ephraim @ nephraim@auamed.org for more information. ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Best of Regards from the Clinical EducationEnhancement Team! ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Surgery CCSE', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'Surgery CCSE', 'Surgery CCSE', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;
    //     //9
    //     procedure CCSE(StudentNo: Code[20])
    //     var
    //         SmtpMailRec: Record "Email Account";

    //         SmtpMail: Codeunit "Email Message";
    //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;

    //         BodyText: text[2048];
    //         SenderName: Text[100];
    //         SenderAddress: Text[250];
    //         Subject: Text[100];
    //         Recipients: List of [Text];
    //         Recipient: Text[100];
    //         StudentMasterCS: Record "Student Master-CS";
    //     begin
    //         SmtpMailRec.Get();

    //         clear(StudentMasterCS);
    //         IF StudentMasterCS.Get("Student No.") Then;
    //         StudentMasterCS.TESTFIELD(StudentMasterCS."E-Mail Address");
    //         Recipient := 'stuti.khandelwal@corporateserve.com';// StudentMasterCS."E-Mail Address";
    //         Message('Mail');
    //         Recipients := Recipient.Split(';');
    //         SenderName := 'CCSE';
    //         SenderAddress := SmtpMailRec."Email Address";
    //         Subject := 'Common Loan Notification';

    //         SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //         SmtpMail.AppendtoBody('Dear Student' + ' ' + StudentSubjectExam."Student Name");
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Congratulations on passing the CCSE examination! This is a huge milestone in your medical education. ' +
    //                             'Take some time to celebrate your success and engage in some self-care. It will be a great way to reset ' +
    //                             'yourself as you forge forth on the path to write your Step 2 CK examination. ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('You may want to consider enrolling in Question Partners 3 prior to taking Step 2 CK. Our Clinical Scholars' + 'Team prepared new question sets for our Question Partners Program. These new question sets further ' +
    //                             'enhanced the efficacy of the program, which already has proven to improve outcomes for those who ' + 'have enrolled.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Question Partners Part 3 sessions meet weekly for four weeks;  Rec.sessions are one hour in length. Our ' +
    //                             'Clinical Scholars have worked diligently on each question used in the program to ensure your experience ' +
    //                             'will best prepare you for writing your Step 2 CK examination. Instructions to sign up for the Question  ' +
    //                             'Partners Program are located in the AUA Clinical Pulse Clinical Community.');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('If you attempt to sign up and there is no group available, that is an indication that all groups are full. ' +
    //                              'Please contact Dr. Ephraim @ nephraim@auamed.org for more information. ');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Best of Regards from the Clinical Education  Enhancement Team!');
    //         SmtpMail.AppendtoBody('<br><br>');
    //         SmtpMail.AppendtoBody('Dr. Nelda Ephraim, RN');
    //         SmtpMail.AppendtoBody('nephraim@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Professor Qunoot Almecci');
    //         SmtpMail.AppendtoBody('qalmecci@auamed.org');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Dr. JR. Ratliff');
    //         SmtpMail.AppendtoBody('jratliff@auamed.org ');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Clinical Education Department Faculty');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('Manipal Education Americas, LLC');
    //         SmtpMail.AppendtoBody('40 Wall Street, 10th Floor');
    //         SmtpMail.AppendtoBody('New York, NY 10005');
    //         SmtpMail.AppendtoBody('<br>');
    //         SmtpMail.AppendtoBody('www.auamed.org');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('CCSE', '', SenderAddress, StudentSubjectExam."Student Name",
    //         StudentSubjectExam."Student No.", Subject, BodyText, 'CCSE', 'CCSE', '', '',
    //         Recipient, 1, '', '', 1);
    //     end;

    //     var
    //         StudentSubjectExam: Record "Student Subject Exam";


}