table 50345 "Roster Ledger Entry"
{
    DataClassification = CustomerContent;
    Caption = 'Roster Ledger Entry';
    DrillDownPageId = "Roster Ledger Entries";
    LookupPageId = "Roster Ledger Entries";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation ID';
        }
        field(3; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
        }
        field(4; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(5; "Student ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student ID';
        }
        field(6; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
        }
        field(7; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
        }
        field(8; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
        }
        field(9; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
        }
        field(10; "Enrollment No."; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
        }
        field(11; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(12; "Course Core Clinical Req."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Core Clinical Requirement';
        }
        field(13; "Student Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Course Code';
            TableRelation = "Course Master-CS";
        }
        field(14; "Student Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Course Description';
        }
        field(15; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = "Subject Master-CS".Code;
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Course Description" := '';
                //TO_DO"Subject Type" := "Subject Type"::" ";
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.FindFirst() then
                    "Course Description" := SubjectMaster.Description;
            end;
        }
        field(16; "Course Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(17; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
            Editable = false;
            TableRelation = "Subject Master-CS".Code;
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
                SubjectMaster_1: Record "Subject Master-CS";
            begin
                "Rotation Description" := '';
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.FindFirst() then;

                SubjectMaster_1.Reset();
                SubjectMaster_1.SetRange(Code, "Elective Course Code");
                if SubjectMaster_1.FindFirst() then
                    "Rotation Description" := format(SubjectMaster."Subject Prefix") + ' - ' + format(SubjectMaster_1.Description);
            end;
        }
        field(18; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            Editable = false;
        }
        field(20; "Course Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(29; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Scheduled","Published","Cancelled","Unconfirmed","Completed","In-Review","FM1/IM1 Confirmed","On Hold"; //CSPL-00307-RTP
        }
        field(30; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(31; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
        }
        field(32; "Total No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Weeks';
        }
        field(33; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(34; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(35; "Weeks Completed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Completed';
        }
        field(36; "Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            trigger OnValidate()
            begin
                "Total Estd. Rotation Cost" := "Total No. of Weeks" * "Estimated Rotation Cost";
            end;
        }
        field(37; "Total Estd. Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Estd. Rotation Cost';
            Editable = false;
        }
        field(38; "Valid Rotation"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Valid Rotation';
        }

        field(39; "Weeks Invoiced"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Invoiced';
        }
        field(40; "Weeks Paid"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Paid';
        }
        field(41; "Actual Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Rotation Cost';
            trigger OnValidate()
            begin
                "Total Actual Rotation Cost" := "Actual Rotation Cost" * "Total No. of Weeks";
            end;
        }
        field(42; "Total Actual Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Actual Rotation Cost';
            Editable = false;
        }
        field(43; "Weeks to Invoice"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks to Invoice';
            DecimalPlaces = 0;
        }
        field(44; "Invoice No."; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No.';
        }
        field(45; "Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Date';
        }
        field(46; "Invoice No. Updated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No. Updated';
        }
        field(47; "Check No."; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Check No.';
        }
        field(48; "Check Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Check Date';
        }
        field(49; "Check No. Updated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check No. Updated';
        }
        field(54; "Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(55; "Grade"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
            OptionMembers = " ",Honors,"High Pass",Pass,Fail,TC,UC,SC,X;
        }
        field(56; Credits; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credits';
        }
        field(58; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Type';
            OptionMembers = Clerkship,"FM1/IM1";
        }
        field(59; "Action of Student"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Action of Student';
            OptionMembers = " ",Pending,Confirmed,Rejected;
            Editable = false;
        }
        field(60; "Cancelled By"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled By';
            Editable = false;
        }
        field(61; "Cancelled On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled On';
            Editable = false;
        }
        field(62; "Rotation No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation No.';
            Editable = false;
        }
        field(63; "Rotation Grade"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Grade';
            Editable = false;
            TableRelation = "Grade Master-CS".Code;

            trigger OnValidate()
            var
                EducationSetup: Record "Education Setup-CS";
                RSH: Record "Roster Scheduling Header";
                RSL: Record "Roster Scheduling Line";
                MainStudentSubject: Record "Main Student Subject-CS";
                StudentMaster: Record "Student Master-CS";
                SubjectMaster: Record "Subject Master-CS";
                SubjectMaster_1: Record "Subject Master-CS";
                SubjectMaster_2: Record "Subject Master-CS";//CSPL-00307 R-Grade-BUG
                RLE: Record "Roster Ledger Entry";
                SMTPSetup: Record "Email Account";
                UserSetup: Record "User Setup";
                User: Record User;
                StudentTimeLineRec: Record "Student Time Line";
                // SMTPMail: codeunit "Email Message";
                // Mail_lCU: Codeunit Mail;
                ClinicalNotification: Codeunit "Clinical Notification";
                Recipient: Text[100];
                Recipients: List of [Text];
                CCRecipient: Text[150];
                CCRecipients: List of [Text];
                MailSubject: Text[500];
                Body: Text;
                ToName: Text;
                InReviewDate: Date;
                PartSubjectCode: Text;
                RGradeMail: Boolean;
                RegistartAssistanceEmail: Text[250];
                SubjectTotalNoofWeeks: Integer;//CSPL-00307 R-Grade-BUG
                PreviousRotationTotalNoofWeeks: Integer;//CSPL-00307 R-Grade-BUG
            begin
                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup.FindFirst() then;
                IF EducationSetup."R-Grade Registrar Email" <> '' then begin
                    CCRecipient := EducationSetup."R-Grade Registrar Email";
                    CCRecipients := CCRecipient.Split(';');
                end;
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then begin
                    UserSetup.Reset();
                    if UserSetup.Get(StudentMaster."Assistant Registrar") then
                        RegistartAssistanceEmail := UserSetup."E-Mail";
                    UserSetup.Reset();
                    if UserSetup.Get(StudentMaster."Clinical Coordinator") then;
                end;

                SubjectMaster.Reset();
                if "Clerkship Type" <> "Clerkship Type"::Elective then
                    SubjectMaster.SetRange(Code, "Course Code")
                else
                    SubjectMaster.SetRange(Code, "Elective Course Code");
                if SubjectMaster.FindFirst() then;

                PartSubjectCode := '';

                if "Clerkship Type" = "Clerkship Type"::Elective then
                    PartSubjectCode := "Elective Course Code";

                if "Clerkship Type" = "Clerkship Type"::"FM1/IM1" then
                    PartSubjectCode := "Course Code";

                if "Clerkship Type" = "Clerkship Type"::Core then begin
                    SubjectMaster_1.Reset();
                    SubjectMaster_1.SetRange("Subject Group", SubjectMaster."Subject Group");
                    SubjectMaster_1.SetRange("Level Description", SubjectMaster_1."Level Description"::"Level 2 Clinical Rotation");
                    if SubjectMaster_1.FindSet() then
                        repeat
                            if PartSubjectCode = '' then
                                PartSubjectCode := SubjectMaster_1.Code
                            else
                                PartSubjectCode := PartSubjectCode + '|' + SubjectMaster_1.Code;
                        until SubjectMaster_1.Next() = 0;
                    //CSPL-00307 R-Grade-BUG
                    Clear(SubjectTotalNoofWeeks);
                    SubjectMaster_2.Reset();
                    IF SubjectMaster_2.Get(SubjectMaster."Subject Group", StudentMaster."Course Code") then
                        Evaluate(SubjectTotalNoofWeeks, DelChr(Format(SubjectMaster_2.Duration), '=', 'DWMQY'));
                    //CSPL-00307 R-Grade-BUG
                end;

                InReviewDate := Today + 45;

                RSL.Reset();
                RSL.SetRange("Rotation ID", "Rotation ID");
                RSL.SetRange("Student No.", "Student ID");
                RSL.SetRange("Ledger Entry No.", "Entry No.");
                if RSL.FindFirst() then begin
                    RSL."Rotation Grade" := "Rotation Grade";
                    RSL.Status := RSL.Status::Completed;

                    if "Rotation Grade" = '' then
                        RSL.Status := RSL.Status::Published;
                    if "Rotation Grade" IN ['SC', 'TC', 'UC', 'X'] then
                        RSL.Status := RSL.Status::Cancelled;
                    RSL.Modify();
                end;

                IF not ("Rotation Grade" IN ['X']) then begin
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetRange("Student No.", "Student ID");
                    MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                    MainStudentSubject.SetRange("Subject Code", "Course Code");
                    MainStudentSubject.SetRange("Start Date", "Start Date");
                    if MainStudentSubject.FindFirst() then begin
                        MainStudentSubject.Grade := "Rotation Grade";
                        IF "Rotation Grade" <> 'M' then
                            MainStudentSubject."Grade Confirmed" := true;
                        MainStudentSubject.Credit := SubjectMaster.Credit;
                        MainStudentSubject."Credits Attempt" := SubjectMaster.Credit;
                        MainStudentSubject."Date Grade Posted" := Today;

                        if not ("Rotation Grade" in ['', 'F', 'M', 'R']) then begin
                            MainStudentSubject."Credit Earned" := SubjectMaster.Credit;
                            MainStudentSubject.Result := MainStudentSubject.Result::Pass;
                        end;

                        MainStudentSubject.Modify();
                    end
                    else begin
                        MainStudentSubject.Reset();
                        MainStudentSubject.SetRange("Student No.", "Student ID");
                        MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                        MainStudentSubject.SetRange("Subject Code", "Course Code");
                        MainStudentSubject.SetFilter(Grade, '');
                        if MainStudentSubject.FindFirst() then begin
                            MainStudentSubject.Grade := "Rotation Grade";
                            IF "Rotation Grade" <> 'M' then
                                MainStudentSubject."Grade Confirmed" := true;
                            MainStudentSubject.Credit := SubjectMaster.Credit;
                            MainStudentSubject."Credits Attempt" := SubjectMaster.Credit;
                            MainStudentSubject."Date Grade Posted" := Today;

                            if not ("Rotation Grade" in ['', 'F', 'M', 'R']) then begin
                                MainStudentSubject."Credit Earned" := SubjectMaster.Credit;
                                MainStudentSubject.Result := MainStudentSubject.Result::Pass;
                            end;
                            MainStudentSubject.Modify();
                        end
                        else begin
                            MainStudentSubject.INIT();
                            MainStudentSubject."Student No." := "Student ID";
                            MainStudentSubject."Student Name" := "Student Name";
                            MainStudentSubject."Enrollment No" := StudentMaster."Enrollment No.";
                            MainStudentSubject."Original Student No." := StudentMaster."Original Student No.";
                            MainStudentSubject.Term := StudentMaster.Term;
                            MainStudentSubject.Graduation := StudentMaster.Graduation;
                            MainStudentSubject.Course := StudentMaster."Course Code";
                            //MainStudentSubject.Semester := StudentMaster.Semester;
                            MainStudentSubject.Section := StudentMaster.Section;
                            MainStudentSubject."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                            MainStudentSubject."Academic Year" := StudentMaster."Academic Year";
                            MainStudentSubject.Term := StudentMaster.Term;
                            if "Clerkship Type" <> "Clerkship Type"::Elective then
                                MainStudentSubject.Validate("Subject Code", "Course Code")
                            else
                                MainStudentSubject.Validate("Subject Code", "Elective Course Code");

                            MainStudentSubject."Start Date" := "Start Date";
                            MainStudentSubject."Expected End Date" := "End Date";
                            MainStudentSubject."End Date" := "End Date";
                            MainStudentSubject.Grade := "Rotation Grade";
                            IF "Rotation Grade" <> 'M' then
                                MainStudentSubject."Grade Confirmed" := true;
                            MainStudentSubject.Credit := SubjectMaster.Credit;
                            MainStudentSubject."Credits Attempt" := SubjectMaster.Credit;
                            MainStudentSubject."Date Grade Posted" := Today;

                            if not ("Rotation Grade" in ['', 'F', 'M', 'R']) then begin
                                MainStudentSubject."Credit Earned" := SubjectMaster.Credit;
                                MainStudentSubject.Result := MainStudentSubject.Result::Pass;
                            end;

                            MainStudentSubject.Graduation := StudentMaster.Graduation;
                            MainStudentSubject."Type Of Course" := StudentMaster."Type Of Course";
                            MainStudentSubject.Year := StudentMaster.Year;
                            if StudentMaster.Term = StudentMaster.Term::FALL then
                                MainStudentSubject."Term Description" := 'Fall Session';
                            if StudentMaster.Term = StudentMaster.Term::SPRING then
                                MainStudentSubject."Term Description" := 'Spring Session';

                            SubjectMaster.Reset();
                            SubjectMaster.SetRange(Code, MainStudentSubject."Subject Code");
                            if SubjectMaster.FindFirst() then
                                MainStudentSubject."Category-Course Description" := SubjectMaster."Category Code";

                            if MainStudentSubject.INSERT(true) then;
                        end;
                    end;

                    Status := Status::Completed;
                    if "Rotation Grade" = '' then
                        Status := Status::Published;
                    Modify();
                end;

                RGradeMail := false;

                if "Clerkship Type" <> "Clerkship Type"::Elective then
                    IF not ("Rotation Grade" in ['', 'SC', 'TC', 'UC', 'X', 'R', 'M', 'F']) then begin
                        RLE.Reset();
                        RLE.SetCurrentKey("Student ID", "Start Date");
                        RLE.SetRange("Student ID", "Student ID");
                        RLE.SetFilter("Entry No.", '<>%1', "Entry No.");
                        RLE.SetFilter("Course Code", PartSubjectCode);
                        RLE.SetRange("Rotation Grade", 'F');
                        RLE.SetAscending("Start Date", false); //CSPL-00307 R-Grade-BUG
                        if RLE.FindSet(True) then begin
                            RGradeMail := true;

                            SMTPSetup.Reset();
                            if SMTPSetup.Get() then;

                            MailSubject := 'Core Rotation - "R" Grade Notification.';
                            clear(Body);

                            if UserSetup."E-Mail" = '' then
                                Recipient := EducationSetup."R-Grade Registrar Email"
                            else begin
                                Recipient := UserSetup."E-Mail";
                                User.Reset();
                                User.SetRange("User Name", UserSetup."User ID");
                                if User.FindFirst() then
                                    ToName := User."Full Name";
                            end;
                            IF RegistartAssistanceEmail <> '' then
                                Recipient := Recipient + ';' + RegistartAssistanceEmail;
                            Recipients := Recipient.Split(';');

                            // SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
                            // SMTPMail.AddCC(CCRecipients);
                            // SMTPMail.AppendtoBody('Dear All,');
                            // SMTPMail.AppendtoBody('<br><br>');
                            // SMTPMail.AppendtoBody('This is to inform you that ' + RSL."Student No." + ' - ' + RSL."Student Name" + ' has been assigned “R” Grade for: ');
                            // SMTPMail.AppendtoBody('<br><br>');

                            // SMTPMail.AppendtoBody('<Table Border="1">');
                            // SMTPMail.AppendtoBody('<tr>');
                            // SMTPMail.AppendtoBody('<td>Rotation Description</td>');
                            // SMTPMail.AppendtoBody('<td>Hospital ID</td>');
                            // SMTPMail.AppendtoBody('<td>Hospital Name</td>');
                            // SMTPMail.AppendtoBody('<td>Start Date</td>');
                            // SMTPMail.AppendtoBody('<td>End Date</td>');
                            // SMTPMail.AppendtoBody('</tr>');
                            Clear(PreviousRotationTotalNoofWeeks);
                            repeat //CSPL-00307 R-Grade-BUG
                                PreviousRotationTotalNoofWeeks += RLE."Total No. of Weeks";
                                // SMTPMail.AppendtoBody('<tr>');
                                // SMTPMail.AppendtoBody('<td>' + RLE."Rotation Description" + '</td>');
                                // SMTPMail.AppendtoBody('<td>' + RLE."Hospital ID" + '</td>');
                                // SMTPMail.AppendtoBody('<td>' + RLE."Hospital Name" + '</td>');
                                // SMTPMail.AppendtoBody('<td>' + FORMAT(RLE."Start Date") + '</td>');
                                // SMTPMail.AppendtoBody('<td>' + FORMAT(RLE."End Date") + '</td>');
                                // SMTPMail.AppendtoBody('</tr>');

                                RLE."Rotation Grade" := 'R';
                                RLE.Modify();

                                RSL.Reset();
                                RSL.SetRange("Rotation ID", RLE."Rotation ID");
                                RSL.SetRange("Rotation No.", RLE."Rotation No.");
                                if RSL.FindFirst() then begin
                                    RSL."Rotation Grade" := RLE."Rotation Grade";
                                    RSL.Modify();
                                end;

                                MainStudentSubject.Reset();
                                MainStudentSubject.SetRange("Student No.", RLE."Student ID");
                                MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                                MainStudentSubject.SetRange("Subject Code", RLE."Course Code");
                                MainStudentSubject.SetRange("Start Date", RLE."Start Date");
                                MainStudentSubject.SetFilter(Grade, 'F');
                                if MainStudentSubject.FindFirst() then begin
                                    MainStudentSubject.Grade := RLE."Rotation Grade";
                                    MainStudentSubject.Modify();
                                end
                                else begin
                                    MainStudentSubject.Reset();
                                    MainStudentSubject.SetRange("Student No.", RLE."Student ID");
                                    MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                                    MainStudentSubject.SetRange("Subject Code", RLE."Course Code");
                                    MainStudentSubject.SetFilter(Grade, 'F');
                                    if MainStudentSubject.FindFirst() then begin
                                        MainStudentSubject.Grade := RLE."Rotation Grade";
                                        MainStudentSubject.Modify();
                                    end
                                end;
                            until (SubjectTotalNoofWeeks = PreviousRotationTotalNoofWeeks) OR (RLE.Next() = 0); //CSPL-00307 R-Grade-BUG
                            if RGradeMail then begin
                                // SMTPMail.AppendtoBody('</Table>');
                                // Mail_lCU.Send();
                                // ClinicalNotification.EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'R Grade Notification to Registrar Team', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
                            end;
                        end;
                    END;

                if "Clerkship Type" = "Clerkship Type"::Elective then
                    IF not ("Rotation Grade" in ['', 'SC', 'TC', 'UC', 'X', 'R', 'M', 'F']) then begin
                        RLE.Reset();
                        RLE.SetCurrentKey("Student ID", "Start Date");
                        RLE.SetRange("Student ID", "Student ID");
                        RLE.SetFilter("Entry No.", '<>%1', "Entry No.");
                        RLE.SetRange("Total No. of Weeks", "Total No. of Weeks");
                        RLE.SetRange("Rotation Grade", 'F');
                        if RLE.FindSet() then begin
                            SMTPSetup.Reset();
                            if SMTPSetup.Get() then;

                            MailSubject := 'Elective Rotation - "R" Grade Notification.';
                            clear(Body);

                            if UserSetup."E-Mail" = '' then begin
                                Recipient := EducationSetup."R-Grade Registrar Email";
                                ToName := 'Team';
                            end
                            else
                                Recipient := UserSetup."E-Mail";
                            IF RegistartAssistanceEmail <> '' then
                                Recipient := Recipient + ';' + RegistartAssistanceEmail;
                            Recipients := Recipient.Split(';');

                            // SMTPMail.Create('MEA', SMTPSetup."User ID", Recipients, MailSubject, Body, true);
                            // SMTPMail.AddCC(CCRecipients);
                            // SMTPMail.AppendtoBody('Dear All,');
                            // SMTPMail.AppendtoBody('<br><br>');
                            // SMTPMail.AppendtoBody('This is to inform you that ' + RSL."Student No." + ' - ' + RSL."Student Name" + ' has been assigned “R” Grade for: ');
                            // SMTPMail.AppendtoBody('<br><br>');

                            // SMTPMail.AppendtoBody('<Table Border="1">');
                            // SMTPMail.AppendtoBody('<tr>');
                            // SMTPMail.AppendtoBody('<td>Rotation Description</td>');
                            // SMTPMail.AppendtoBody('<td>Hospital ID</td>');
                            // SMTPMail.AppendtoBody('<td>Hospital Name</td>');
                            // SMTPMail.AppendtoBody('<td>Start Date</td>');
                            // SMTPMail.AppendtoBody('<td>End Date</td>');
                            // SMTPMail.AppendtoBody('</tr>');

                            // repeat
                            //     RLE."Rotation Grade" := 'R';
                            //     RLE.Modify();

                            //     RGradeMail := true;

                            //     SMTPMail.AppendtoBody('<tr>');
                            //     SMTPMail.AppendtoBody('<td>' + RLE."Rotation Description" + '</td>');
                            //     SMTPMail.AppendtoBody('<td>' + RLE."Hospital ID" + '</td>');
                            //     SMTPMail.AppendtoBody('<td>' + RLE."Hospital Name" + '</td>');
                            //     SMTPMail.AppendtoBody('<td>' + FORMAT(RLE."Start Date") + '</td>');
                            //     SMTPMail.AppendtoBody('<td>' + FORMAT(RLE."End Date") + '</td>');
                            //     SMTPMail.AppendtoBody('</tr>');

                            //     RSL.Reset();
                            //     RSL.SetRange("Rotation ID", RLE."Rotation ID");
                            //     RSL.SetRange("Rotation No.", RLE."Rotation No.");
                            //     if RSL.FindFirst() then begin
                            //         RSL."Rotation Grade" := RLE."Rotation Grade";
                            //         RSL.Modify();
                            //     end;

                            //     MainStudentSubject.Reset();
                            //     MainStudentSubject.SetRange("Student No.", RLE."Student ID");
                            //     MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                            //     MainStudentSubject.SetRange("Subject Code", RLE."Course Code");
                            //     MainStudentSubject.SetRange("Start Date", RLE."Start Date");
                            //     MainStudentSubject.SetFilter(Grade, 'F');
                            //     if MainStudentSubject.FindFirst() then begin
                            //         MainStudentSubject.Grade := RLE."Rotation Grade";
                            //         MainStudentSubject.Modify();
                            //     end
                            //     else begin
                            //         MainStudentSubject.Reset();
                            //         MainStudentSubject.SetRange("Student No.", RLE."Student ID");
                            //         MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                            //         MainStudentSubject.SetRange("Subject Code", RLE."Course Code");
                            //         MainStudentSubject.SetFilter(Grade, 'F');
                            //         if MainStudentSubject.FindFirst() then begin
                            //             MainStudentSubject.Grade := RLE."Rotation Grade";
                            //             MainStudentSubject.Modify();
                            //         end
                            //     end;
                            // until RLE.Next() = 0;

                            // SMTPMail.AppendtoBody('</Table>');
                            // if RGradeMail then begin
                            //     Mail_lCU.Send();
                            //     ClinicalNotification.EmailNotificationSave('CLINICAL', 'MEA', SMTPSetup."User ID", StudentMaster."No.", StudentMaster."Student Name", MailSubject, Body, 'R Grade Notification to Registrar Team', MailSubject, '', Format(CurrentDateTime), Recipient, 1, 1, Format(CurrentDateTime), 0, '', '', 1, 1, Format(CurrentDateTime));
                            // end;
                        end;
                    END;




                IF "Rotation Grade" = 'NOT REQUIRED' then begin
                    Status := Status::Completed;
                    Modify();

                    RSL.Reset();
                    RSL.SetRange("Student No.", "Student ID");
                    RSL.SetRange(Status, RSL.Status::Published);
                    RSL.Setfilter("Start Date", '%1..%2', "End Date" + 1, InReviewDate);
                    if RSL.FindSet() then
                        repeat
                            RSL.Status := RSL.Status::"In-Review";
                            RSL.Modify();

                            RSH.Reset();
                            if RSH.Get(RSL."Rotation ID") then begin
                                RSH.Status := RSH.Status::Scheduled;
                                RSH.Modify();
                            end;

                            RLE.Reset();
                            if RLE.Get(RSL."Ledger Entry No.") then begin
                                RLE.Status := RSL.Status;
                                RLE.Modify();
                            end;
                        until RSL.Next() = 0;
                end;

                StudentTimeLineRec.InsertHiddenRecordFun("Student ID", "Student Name", 'RLE Entry No. ' + Format("Entry No.") + ' - Grade has been Changed from ' + xRec."Rotation Grade" + ' to ' + "Rotation Grade", UserId(), Today());
            end;
        }

        field(65; "LGS SchoolDocs Trn. No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'LGS SchoolDocs Transaction No.';
            Editable = false;
        }
        field(66; "Assessment Completed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Assessment Completed';
            Editable = false;
        }
        field(115; "School Docs TransactionID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'School Docs TransactionID';
            Editable = false;
        }
        field(116; "School Docs Sync"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'School Docs Sync';
            Editable = false;
        }
        field(500; "nID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'nID';
        }
        field(501; ContactID; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(502; "Subject Shelf Exam Date 1"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(503; "Subject Shelf Exam Date 2"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(504; "Subject Shelf Exam Date 3"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(505; "Subject Shelf Exam Date 4"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(506; "Preceptor Evaluation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(507; "DME Sign Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(508; "Date Signed"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(509; "Cost Per week Override"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(510; "Grade Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(511; "Link to Lead"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(512; "Link to Lead Discription"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(513; "Course Prefix"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(514; "Course Prefix Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(515; "Patient Care"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(516; "Patient Care Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(517; "Subject Shelf Exam Attempt 1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(518; "Subject Shelf Exam Attempt 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(519; "Subject Shelf Exam Attempt 3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(520; "Subject Shelf Exam Attempt 4"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(521; "Link to Hospital Listing"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(522; "Link to Listing Discription"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Link to Hospital Listing Discription';
        }
        field(524; "Letter Grade"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(525; "Medical Knowledge"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(526; "Medical Knowledge Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(527; "Learning and Improvement"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(528; "L&I Description"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Learning and Improvement Description';
        }
        field(529; "Communication"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(530; "Communication Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(531; "Professionalism"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(532; "Professionalism Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(533; "Student Portfolio"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(534; "Student Portfolio Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(535; "FIU"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(536; "Cancellation Reason"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(537; "Cancellation Reason Desc."; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(538; "Systems Based Learning"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(539; "Sys Based Learning Discription"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(540; "Payment Notes"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(541; "Student Placement ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(542; "Ad Class Sched ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(543; "Patient Care Comments"; Text[300])
        {
            DataClassification = CustomerContent;
        }
        field(544; "Medical Knowledge Comments"; Text[300])
        {
            DataClassification = CustomerContent;
        }
        field(545; "Communication Comments"; Text[300])
        {
            DataClassification = CustomerContent;
        }
        field(546; "Learning&ImprovementComments"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Learning & Improvement Comments';
        }
        field(547; "Professionalism Comments"; Text[300])
        {
            DataClassification = CustomerContent;
        }
        field(548; "Student PortFolio Comments"; Text[300])
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Student Present Mobile No."; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."Mobile Number" where("No." = field("Student ID")));
            Editable = false;
        }
        field(60001; "Student E-Mail ID"; Code[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."E-Mail Address" where("No." = field("Student ID")));
            Editable = false;
        }
        field(60002; "Paid Weeks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Clerkship Payment Ledger Entry"."Weeks Paid" where("Rotation Entry No." = field("Entry No."), "Entry Type" = filter(Payment | "Payment Reversal"), "Check Date" = field("Date Filter")));
        }
        field(60003; "Paid Total Actual Rot. Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Clerkship Payment Ledger Entry"."Total Actual Rotation Cost" where("Rotation Entry No." = field("Entry No."), "Entry Type" = filter(Payment | "Payment Reversal"), "Check Date" = field("Date Filter")));
        }
        field(60004; "Invoiced Weeks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Clerkship Payment Ledger Entry"."Weeks Invoiced" where("Rotation Entry No." = field("Entry No."), "Entry Type" = filter(Invoice | "Invoice Reversal"), "Check Date" = field("Date Filter")));
        }
        field(60005; "Inv. Total Actual Rot. Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Clerkship Payment Ledger Entry"."Total Actual Rotation Cost" where("Rotation Entry No." = field("Entry No."), "Entry Type" = filter(Invoice | "Invoice Reversal"), "Check Date" = field("Date Filter")));
        }
        field(60006; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(60007; "Prepayment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Clerkship Payment Ledger Entry"."Weeks Paid" where("Rotation Entry No." = field("Entry No."), "Entry Type" = filter(Payment | "Payment Reversal"), "Check Date" = field("Date Filter")));
        }
        field(60008; "New/Returning"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Roster Scheduling Line"."New/Returning" where("Rotation ID" = field("Rotation ID"), "Rotation No." = field("Rotation No.")));
            Caption = 'New/Returning';
            Editable = false;
            OptionMembers = " ",New,Returning;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
            SumIndexFields = Score, Credits;
        }
        key(PK_1; "Clerkship Type", "Hospital ID", "Course Code", "Start Date")
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    Procedure OnValidateRotationGrade_MGradAutomation()
    var
        EducationSetup: Record "Education Setup-CS";
        RSH: Record "Roster Scheduling Header";
        RSL: Record "Roster Scheduling Line";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentMaster: Record "Student Master-CS";
        SubjectMaster: Record "Subject Master-CS";
        SubjectMaster_1: Record "Subject Master-CS";
        RLE: Record "Roster Ledger Entry";
        SMTPSetup: Record "Email Account";
        UserSetup: Record "User Setup";
        User: Record User;
        StudentTimeline: Record "Student Time Line";
        // SMTPMail: codeunit "Email Message";
        // Mail_lCU: Codeunit Mail;
        ClinicalNotification: Codeunit "Clinical Notification";
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[150];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        ToName: Text;
        InReviewDate: Date;
        PartSubjectCode: Text;
        RGradeMail: Boolean;
        RegistartAssistanceEmail: Text[250];
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;
        IF EducationSetup."R-Grade Registrar Email" <> '' then begin
            CCRecipient := EducationSetup."R-Grade Registrar Email";
            CCRecipients := CCRecipient.Split(';');
        end;
        StudentMaster.Reset();
        if StudentMaster.Get("Student ID") then begin
            UserSetup.Reset();
            if UserSetup.Get(StudentMaster."Assistant Registrar") then
                RegistartAssistanceEmail := UserSetup."E-Mail";
            UserSetup.Reset();
            if UserSetup.Get(StudentMaster."Clinical Coordinator") then;
        end;

        SubjectMaster.Reset();
        if "Clerkship Type" <> "Clerkship Type"::Elective then
            SubjectMaster.SetRange(Code, "Course Code")
        else
            SubjectMaster.SetRange(Code, "Elective Course Code");
        if SubjectMaster.FindFirst() then;

        PartSubjectCode := '';

        if "Clerkship Type" = "Clerkship Type"::Elective then
            PartSubjectCode := "Elective Course Code";

        if "Clerkship Type" = "Clerkship Type"::"FM1/IM1" then
            PartSubjectCode := "Course Code";

        if "Clerkship Type" = "Clerkship Type"::Core then begin
            SubjectMaster_1.Reset();
            SubjectMaster_1.SetRange("Subject Group", SubjectMaster."Subject Group");
            SubjectMaster_1.SetRange("Level Description", SubjectMaster_1."Level Description"::"Level 2 Clinical Rotation");
            if SubjectMaster_1.FindSet() then
                repeat
                    if PartSubjectCode = '' then
                        PartSubjectCode := SubjectMaster_1.Code
                    else
                        PartSubjectCode := PartSubjectCode + '|' + SubjectMaster_1.Code;
                until SubjectMaster_1.Next() = 0;
        end;

        InReviewDate := Today + 45;

        RSL.Reset();
        RSL.SetRange("Rotation ID", "Rotation ID");
        RSL.SetRange("Student No.", "Student ID");
        RSL.SetRange("Ledger Entry No.", "Entry No.");
        if RSL.FindFirst() then begin
            RSL."Rotation Grade" := "Rotation Grade";

            // RSL.Status := RSL.Status::Completed;

            // if "Rotation Grade" = '' then
            //     RSL.Status := RSL.Status::Published;
            // if "Rotation Grade" IN ['SC', 'TC', 'UC', 'X'] then
            //     RSL.Status := RSL.Status::Cancelled;
            RSL.Modify();
        end;

        IF not ("Rotation Grade" IN ['X']) then begin
            MainStudentSubject.Reset();
            MainStudentSubject.SetRange("Student No.", "Student ID");
            MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
            MainStudentSubject.SetRange("Subject Code", "Course Code");
            MainStudentSubject.SetRange("Start Date", "Start Date");
            if MainStudentSubject.FindFirst() then begin
                MainStudentSubject.Grade := "Rotation Grade";
                // IF "Rotation Grade" <> 'M' Then
                //     MainStudentSubject."Grade Confirmed" := true;
                MainStudentSubject.Credit := SubjectMaster.Credit;
                MainStudentSubject."Credits Attempt" := SubjectMaster.Credit;
                MainStudentSubject."Date Grade Posted" := Today;

                // if not ("Rotation Grade" in ['', 'F', 'M', 'R']) then begin
                //     MainStudentSubject."Credit Earned" := SubjectMaster.Credit;
                //     MainStudentSubject.Result := MainStudentSubject.Result::Pass;
                // end;

                MainStudentSubject.Modify();
            end
            else begin
                MainStudentSubject.Reset();
                MainStudentSubject.SetRange("Student No.", "Student ID");
                MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
                MainStudentSubject.SetRange("Subject Code", "Course Code");
                MainStudentSubject.SetFilter(Grade, '');
                if MainStudentSubject.FindFirst() then begin
                    MainStudentSubject.Grade := "Rotation Grade";
                    // IF "Rotation Grade" <> 'M' Then
                    //     MainStudentSubject."Grade Confirmed" := true;
                    MainStudentSubject.Credit := SubjectMaster.Credit;
                    MainStudentSubject."Credits Attempt" := SubjectMaster.Credit;
                    MainStudentSubject."Date Grade Posted" := Today;

                    // if not ("Rotation Grade" in ['', 'F', 'M', 'R']) then begin
                    //     MainStudentSubject."Credit Earned" := SubjectMaster.Credit;
                    //     MainStudentSubject.Result := MainStudentSubject.Result::Pass;
                    // end;
                    MainStudentSubject.Modify();
                end
                else begin
                    MainStudentSubject.INIT();
                    MainStudentSubject."Student No." := "Student ID";
                    MainStudentSubject."Student Name" := "Student Name";
                    MainStudentSubject."Enrollment No" := StudentMaster."Enrollment No.";
                    MainStudentSubject."Original Student No." := StudentMaster."Original Student No.";
                    MainStudentSubject.Term := StudentMaster.Term;
                    MainStudentSubject.Graduation := StudentMaster.Graduation;
                    MainStudentSubject.Course := StudentMaster."Course Code";
                    //MainStudentSubject.Semester := StudentMaster.Semester;
                    MainStudentSubject.Section := StudentMaster.Section;
                    MainStudentSubject."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                    MainStudentSubject."Academic Year" := StudentMaster."Academic Year";
                    MainStudentSubject.Term := StudentMaster.Term;
                    if "Clerkship Type" <> "Clerkship Type"::Elective then
                        MainStudentSubject.Validate("Subject Code", "Course Code")
                    else
                        MainStudentSubject.Validate("Subject Code", "Elective Course Code");

                    MainStudentSubject."Start Date" := "Start Date";
                    MainStudentSubject."Expected End Date" := "End Date";
                    MainStudentSubject."End Date" := "End Date";
                    MainStudentSubject.Grade := "Rotation Grade";
                    // IF "Rotation Grade" <> 'M' Then
                    //     MainStudentSubject."Grade Confirmed" := true;
                    MainStudentSubject.Credit := SubjectMaster.Credit;
                    MainStudentSubject."Credits Attempt" := SubjectMaster.Credit;
                    MainStudentSubject."Date Grade Posted" := Today;

                    // if not ("Rotation Grade" in ['', 'F', 'M', 'R']) then begin
                    //     MainStudentSubject."Credit Earned" := SubjectMaster.Credit;
                    //     MainStudentSubject.Result := MainStudentSubject.Result::Pass;
                    // end;

                    MainStudentSubject.Graduation := StudentMaster.Graduation;
                    MainStudentSubject."Type Of Course" := StudentMaster."Type Of Course";
                    MainStudentSubject.Year := StudentMaster.Year;
                    if StudentMaster.Term = StudentMaster.Term::FALL then
                        MainStudentSubject."Term Description" := 'Fall Session';
                    if StudentMaster.Term = StudentMaster.Term::SPRING then
                        MainStudentSubject."Term Description" := 'Spring Session';

                    SubjectMaster.Reset();
                    SubjectMaster.SetRange(Code, MainStudentSubject."Subject Code");
                    if SubjectMaster.FindFirst() then
                        MainStudentSubject."Category-Course Description" := SubjectMaster."Category Code";

                    if MainStudentSubject.INSERT(true) then;
                end;
            end;
            StudentTimeline.InsertRecordFun(Rec."Student ID", Rec."Student Name", 'For ' + "Course Description" + ' Grade has been assigned to M', UserId(), Today());
            Modify();
        end;
    end;
}