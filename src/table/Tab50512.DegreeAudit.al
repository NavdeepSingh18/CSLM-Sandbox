table 50512 "Degree Audit"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Application No.", "Student Name";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GeneralLedgerSetupRec: Record "General Ledger Setup";
            begin
                GeneralLedgerSetupRec.Get();
                //GetEducationSetup(EducationSetup);
                GeneralLedgerSetupRec.TestField("Degree Audit Document No.");
                NoSeriesMgmt_lCU.TestManual(GeneralLedgerSetupRec."Degree Audit Document No.");
                "No. Series" := '';
            end;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                StudentStatus: Record "Student Status";
            begin
                StudentmasterRec.Reset();
                StudentmasterRec.SetRange("No.", "Student No.");
                IF StudentmasterRec.FindFirst() then begin
                    // StudentStatus.Get(StudentmasterRec.Status, StudentmasterRec."Global Dimension 1 Code");
                    // if not (StudentStatus.Status in [StudentStatus.Status::"Pending Graduation"]) then
                    //     Error('Please check the student status it must be Pending Graduation');

                    "Enrollment No" := StudentmasterRec."Enrollment No.";
                    Semester := StudentmasterRec.Semester;
                    "Academic Year" := StudentmasterRec."Academic Year";
                    "Global Dimension 1 Code" := StudentmasterRec."Global Dimension 1 Code";
                    "Student Name" := StudentmasterRec."Student Name";
                    Term := StudentmasterRec.Term;
                    Validate("Course Code", StudentMasterRec."Course Code");
                    //"Course Name" := StudentmasterRec."Course Name";
                    Validate("Estimated Graduation Date", StudentMasterRec."Estimated Graduation Date");
                    //"Last Date of Attendance" := StudentmasterRec.LDA;
                    "BSIC Opt-Out" := StudentmasterRec."BSIC Opt Out";
                    "Clinical Curriculum" := StudentmasterRec."Clinical Curriculum";

                    RosterSchedulingLineRec.Reset();
                    RosterSchedulingLineRec.SetCurrentKey("Student No.", "Start Date");
                    RosterSchedulingLineRec.SetRange("Student No.", "Student No.");
                    RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'F', 'R');
                    if RosterSchedulingLineRec.FindSet() then
                        repeat
                            "Total Clerkship Weeks" := "Total Clerkship Weeks" + RosterSchedulingLineRec."No. of Weeks";
                        until RosterSchedulingLineRec.Next() = 0;

                    // RecClassAttendanceLine.Reset();
                    // RecClassAttendanceLine.SetRange("Student No.", "Student No.");
                    // recClassAttendanceLine.SetRange("Course Code", "Course Code");
                    // RecClassAttendanceLine.SetRange(Semester, Semester);
                    // RecClassAttendanceLine.SetRange("Academic Year", "Academic Year");
                    // RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                    // IF recClassAttendanceLine.FindLast() then
                    //     "Last Date of Attendance" := recClassAttendanceLine.Date;

                    StudentSubjectExamRec.Reset();
                    StudentSubjectExamRec.SetRange("Student No.", "Student No.");
                    StudentSubjectExamRec.SetRange("Score Type", StudentSubjectExamRec."Score Type"::"STEP 2 CK");
                    StudentSubjectExamRec.SetRange(Result, StudentSubjectExamRec.Result::Pass);
                    if StudentSubjectExamRec.FindFirst() then;

                    if StudentmasterRec."8 FA End Date" <> 0D then begin
                        if StudentmasterRec."8 FA End Date" > StudentSubjectExamRec."Sitting Date" then
                            "Effective Date" := StudentmasterRec."8 FA End Date"
                        else
                            "Effective Date" := StudentSubjectExamRec."Sitting Date";

                    end else
                        if StudentmasterRec."7 FA End Date" <> 0D then begin
                            if StudentmasterRec."7 FA End Date" > StudentSubjectExamRec."Sitting Date" then
                                "Effective Date" := StudentmasterRec."7 FA End Date"
                            else
                                "Effective Date" := StudentSubjectExamRec."Sitting Date";

                        end else
                            if StudentmasterRec."6 FA End Date" <> 0D then begin
                                if StudentmasterRec."6 FA End Date" > StudentSubjectExamRec."Sitting Date" then
                                    "Effective Date" := StudentmasterRec."6 FA End Date"
                                else
                                    "Effective Date" := StudentSubjectExamRec."Sitting Date";

                            end else
                                if StudentmasterRec."5 FA End Date" <> 0D then
                                    if StudentmasterRec."5 FA End Date" > StudentSubjectExamRec."Sitting Date" then
                                        "Effective Date" := StudentmasterRec."5 FA End Date"
                                    else
                                        "Effective Date" := StudentSubjectExamRec."Sitting Date";

                    if "Effective Date" = 0D then
                        "Effective Date" := StudentSubjectExamRec."Sitting Date";

                end Else begin
                    "Enrollment No" := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Student Name" := '';
                    //"Last Date of Attendance" := 0D;
                    "Effective Date" := 0D;
                end;
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Enrollment No"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
            Editable = false;
        }
        field(6; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            Editable = false;
        }
        field(7; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                If "Course Code" <> '' then begin
                    CourseMasterRec.Reset();
                    CourseMasterRec.SetRange(Code, "Course Code");
                    if CourseMasterRec.FindFirst() then begin
                        "Course Name" := CourseMasterRec.Description;
                    end;
                end else
                    "Course Name" := '';

                // CourseDegreeRec.Reset();
                // CourseDegreeRec.SetRange("Course Code");
                // if CourseDegreeRec.FindFirst() then begin
                //     "Degree Code" := CourseDegreeRec."Degree Code";
                //     "Degree Name" := CourseDegreeRec."Degree Name";
                // end;


            end;
        }
        field(8; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Degree Code"; Code[20])
        {
            Caption = 'Degree Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Degree Name"; Text[100])
        {
            Caption = 'Degree Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Last Date of Attendance"; Date)
        {
            Caption = 'Last Date of Attendance';
            DataClassification = CustomerContent;
            Editable = false;
            ObsoleteState = Pending;
            Description = 'Marked for Removal';
        }
        field(13; "Transfer Credit"; Decimal)
        {
            Caption = 'Transfer Credit';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(14; "Transfer School"; Decimal)
        {
            Caption = 'Transfer School';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Permanent Phone No."; Text[30])
        {
            Caption = 'Permanent Phone No.';
            DataClassification = CustomerContent;
        }

        field(18; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(15; "Total Clinical Weeks"; Integer)
        {
            Caption = 'Total Clinical Weeks';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Total Elective Weeks"; Integer)
        {
            Caption = 'Total Elective Weeks';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(20; "Document Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending for Verification,Verified,Rejected';
            OptionMembers = "Pending for Verification",Verified,Rejected;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(23; "Current Address"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Current Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(25; "Current State"; Code[10])
        {
            Caption = 'Current State';
            DataClassification = CustomerContent;
            TableRelation = if ("Current Country Code" = const()) "State SLcM CS"
            else
            if ("Current Country Code" = FILTER(<> '')) "State SLcM CS" WHERE("Country/Region Code" = field("Current Country Code"));
        }
        field(26; "Current Zip Code"; Code[20])
        {
            // TableRelation = if ("Current Country Code" = const()) "Post Code"
            // else
            // if ("Current Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Current Country Code"));
            // Caption = 'Current Zip Code';
            // DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Current Zip Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         "Current Country Code" := PostCodeRec."Country/Region Code";
            //         "Current city" := PostCodeRec.City;
            //         "Current State" := PostCodeRec."State Code";
            //     END ELSE BEGIN
            //         "Current Country Code" := '';
            //         "Current city" := '';
            //         "Current State" := '';
            //     END;
            // end;
        }
        field(27; "Current City"; Text[30])
        {
            Caption = 'Current City';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(28; "Permanent Address"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Permanent Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(30; "Permanent State"; Code[10])
        {
            Caption = 'Permanent State';
            DataClassification = CustomerContent;
            TableRelation = if ("Current Country Code" = const()) "State SLcM CS"
            else
            if ("Permanent Country Code" = FILTER(<> '')) "State SLcM CS" WHERE("Country/Region Code" = field("Permanent Country Code"));
        }
        field(31; "Permanent Zip Code"; Code[20])
        {
            // TableRelation = if ("Permanent Country Code" = const()) "Post Code"
            // else
            // if ("Current Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Permanent Country Code"));
            // Caption = 'Permanent Zip Code';
            // DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Permanent Zip Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         "Permanent Country Code" := PostCodeRec."Country/Region Code";
            //         "Permanent city" := PostCodeRec.City;
            //         "Permanent State" := PostCodeRec."State Code";
            //     END ELSE BEGIN
            //         "Current Country Code" := '';
            //         "Current city" := '';
            //         "Current State" := '';
            //     END;
            // end;
        }
        field(32; "Permanent City"; Text[30])
        {
            Caption = 'Permanent City';
            DataClassification = CustomerContent;
            //    TableRelation = "Post Code".City;
        }

        field(33; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(34; "Rejection Remark"; Text[500])
        {
            DataClassification = CustomerContent;

        }
        field(35; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(36; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(37; "Approved/Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected By';
            Editable = false;

        }
        Field(38; "Approved/Rejected On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected On';
            Editable = False;

        }
        field(40; "Degree Printed On"; Date)
        {
            Caption = 'Degree Printed On';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(41; "Degree Printed By"; Code[50])
        {
            Caption = 'Degree Printed By';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(42; "Degree Re-Printed On"; Date)
        {
            Caption = 'Degree Re-Printed On';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(43; "Degree Re-Printed By"; Code[50])
        {
            Caption = 'Degree Re-Printed By';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(44; "BSIC Opt-Out"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(45; "Personal E-Mail Address"; Text[80])
        {
            Caption = 'Personal E-Mail Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;

        }
        field(46; "Reason Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Description';
            Editable = false;
        }
        field(47; "Graduation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Graduation Date';
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                StudentDegree: Record "Student Degree";
            begin
                StudentDegree.Reset();
                StudentDegree.SetRange("Student No.", "Student No.");
                if StudentDegree.FindFirst() then begin
                    StudentDegree."Graduation Date" := "Graduation Date";
                    StudentDegree.Modify();
                end;

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Graduation Date" := "Graduation Date";
                    StudentMaster.Modify();
                end;

            end;
            //Editable = false;
        }
        field(48; "Date Awarded"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Awarded';
            Editable = false;
        }
        field(49; "Date Cleared"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Cleared';
            Editable = false;
        }
        field(50; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';
            Editable = false;
        }

        field(51; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(52; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(53; "Estimated Graduation Date"; Date)
        {
            Caption = 'Estimated Graduation Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                RecStudentDegree: Record "Student Degree";
            begin
                RecStudentDegree.Reset();
                RecStudentDegree.SetRange("Student No.", "Student No.");
                IF RecStudentDegree.FindFirst() then
                    Validate("Graduation Date", CalculationofGraduationDate("Estimated Graduation Date", RecStudentDegree."Degree Code"));
            end;
        }
        field(54; "Total Clerkship Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55; "Clinical Curriculum"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Curriculum';
            OptionCaption = ' ,84,94,75,90,78,88,86,96';
            OptionMembers = " ","84","94","75","90","78","88","86","96";
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        Field(1500; LDA; Date)
        {
            Caption = 'Last Date of Attandance';
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".LDA where("No." = Field("Student No.")));
        }

    }
    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        GeneralLedgerSetupRec: Record "General Ledger Setup";
    begin
        IF "Application No." = '' then begin
            GeneralLedgerSetupRec.Get();
            GeneralLedgerSetupRec.TestField("Degree Audit Document No.");
            NoSeriesMgmt_lCU.InitSeries(GeneralLedgerSetupRec."Degree Audit Document No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
        end;
        "Created By" := FORMAT(UserId());
        "Created On" := Today();
        "Application Date" := Today();

        Inserted := true;
    end;

    Trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    procedure AssistEdit(OldDegreeAudit: Record "Degree Audit"): Boolean
    var
        GeneralLedgerSetupRec: Record "General Ledger Setup";
        DegreeAuditRec: Record "Degree Audit";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        with DegreeAuditRec do begin
            DegreeAuditRec := Rec;
            GeneralLedgerSetupRec.Get();
            GeneralLedgerSetupRec.TestField("Degree Audit Document No.");

            if NoSeriesMgt.SelectSeries(GeneralLedgerSetupRec."Degree Audit Document No.", OldDegreeAudit."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Application No.");
                Rec := DegreeAuditRec;
                exit(true);
            end
        end;
    end;

    procedure GetEducationSetup(var EducationSetup: Record "Education Setup-CS")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        UserSetup.FindFirst();

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        EducationSetup.FindFirst();
    end;

    // procedure MailSendforDegreeAuditDocumentApproved(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ("Application No." + ' ' + 'Degree Audit Application');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that your Degree Audit Application' + ' ' + "Application No." + ' ' + 'has been received.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Office of the Registrar');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Degree Audit', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Degree Audit', 'Degree Audit', "Application No.", Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MailSendforDegreeAuditRejection(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ("Application No." + ' ' + 'Degree Audit Application Rejection');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that Degree Audit Application' + ' ' + "Application No." + ' ' + 'is Rejected.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please submit your documents again from your SLcM student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Degree Audit', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Degree Audit', 'Degree Audit', "Application No.", Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    procedure CalculationofGraduationDate(EstDate: Date; Degree: Code[20]): Date
    var
        GraduationDateSetup: Record "Graduation Date Setup";
        PostingDate: Text;
        PostingDate1: Date;
        Month: Integer;
        Year: Integer;
        Day1: Integer;
        Month1: Integer;
        Year1: Integer;
        GraduationDate: Text;
        GraduationDate1: Date;


        EDay: Integer;
    begin
        //   PostingDate := Format(Today(), 0, '<Day,2>/<Month,2>/<Year4>');
        // Evaluate(PostingDate1, PostingDate);
        if EstDate <> 0D then begin
            PostingDate1 := EstDate;
            Month := Date2DMY(PostingDate1, 2);
            Year := Date2DMY(PostingDate1, 3);
            EDay := Date2DMY(PostingDate1, 1);
            /*----Old Code Cmnt --- CSPL-00307  14-10-21
            if Month IN [7, 8, 9] then begin
                GraduationDate := '';
                Day1 := 30;
                Month1 := 09;
                Year1 := Year;
                GraduationDate1 := DMY2Date(Day1, Month1, Year1);
                //GraduationDate := Format(DMY2Date(Day1, Month1, Year1), 0, '<Day,2>/<Month,2>/<Year4>');
                // Evaluate(GraduationDate1, GraduationDate);
                exit(GraduationDate1);
            end;


            if Month IN [10, 11, 12] then begin
                GraduationDate := '';
                Day1 := 31;
                Month1 := 12;
                Year1 := Year;
                GraduationDate1 := DMY2Date(Day1, Month1, Year1);
                // GraduationDate := Format(DMY2Date(Day1, Month1, Year1), 0, '<Day,2>/<Month,2>/<Year4>');
                // Evaluate(GraduationDate1, GraduationDate);
                exit(GraduationDate1);
            end;

            if Month IN [1, 2, 3] then begin
                GraduationDate := '';
                Day1 := 31;
                Month1 := 03;
                Year1 := Year;
                GraduationDate1 := DMY2Date(Day1, Month1, Year1);
                // GraduationDate := Format(DMY2Date(Day1, Month1, Year1), 0, '<Day,2>/<Month,2>/<Year4>');
                // Evaluate(GraduationDate1, GraduationDate);
                exit(GraduationDate1);
            end;

            if Month IN [4] then begin
                GraduationDate := '';
                Day1 := 30;
                Month1 := 04;
                Year1 := Year;
                GraduationDate1 := DMY2Date(Day1, Month1, Year1);
                // GraduationDate := Format(DMY2Date(Day1, Month1, Year1), 0, '<Day,2>/<Month,2>/<Year4>');
                // Evaluate(GraduationDate1, GraduationDate);
                exit(GraduationDate1);
            end;

            if Month IN [5, 6] then begin
                GraduationDate := '';
                Day1 := 30;
                Month1 := 06;
                Year1 := Year;
                GraduationDate1 := DMY2Date(Day1, Month1, Year1);
                // GraduationDate := Format(DMY2Date(Day1, Month1, Year1), 0, '<Day,2>/<Month,2>/<Year4>');
                // Evaluate(GraduationDate1, GraduationDate);
                exit(GraduationDate1);
            end;
           //--Old Code Cmnt --- CSPL-00307  14-10-21 */

            ////New Code ****CSPL-00307 Start 14-10-21
            GraduationDateSetup.Reset();
            GraduationDateSetup.SetCurrentKey(DegreeCode, Day_StartDate, Month_StartDate, Day_EndDate, Month_EndDate);
            GraduationDateSetup.SetRange(DegreeCode, Degree);
            IF GraduationDateSetup.FindSet() then begin
                repeat
                    IF ((EDay >= GraduationDateSetup.Day_StartDate) AND (Month >= GraduationDateSetup.Month_StartDate)) AND
                        ((EDay <= GraduationDateSetup.Day_EndDate) And (Month <= GraduationDateSetup.Month_EndDate)) then begin
                        GraduationDate := '';
                        Day1 := GraduationDateSetup.Day_GraduationDate;
                        Month1 := GraduationDateSetup.Month_GraduationDate;
                        Year1 := Year;
                        GraduationDate1 := DMY2Date(Day1, Month1, Year1);
                        exit(GraduationDate1);
                    end;
                until GraduationDateSetup.Next = 0;
            end;//Else
                //Error('Graduation Date Setup Does Not Exist for Estimated Range');

            /// New Code ****CSPL-00307 Ends 14-10-21
        end;
    end;

    var
        StudentmasterRec: Record "Student Master-CS";
        //StudentStatus: Record "Student Status";
        OptOutRec: Record "Opt Out";
        PostCodeRec: Record "Post Code";
        CourseMasterRec: Record "Course Master-CS";
        recClassAttendanceLine: Record "Class Attendance Line-CS";
        CourseDegreeRec: Record "Course Degree";
        RosterSchedulingLineRec: Record "Roster Scheduling Line";
        StudentSubjectExamRec: Record "Student Subject Exam";
        NoSeriesMgmt_lCU: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];


}