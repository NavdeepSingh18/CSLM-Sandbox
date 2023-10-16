table 50005 "Withdrawal Student-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    22-04-2019    OnInsert                    No. Series and  Assign Value in Fields
    // 2         CSPL-00092    22-04-2019    Student No. - OnValidate    Assign Value in Fields

    Caption = 'Withdrawal Student';
    DrillDownPageID = "Stud. College Withdrawal List";
    LookupPageID = "Stud. College Withdrawal List";
    DataCaptionFields = "Student No.", "Student Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if UserSetup.Get(UserId()) then;
                UserSetup.TestField("Global Dimension 1 Code");
                IF "No." <> xRec."No." THEN BEGIN
                    GeneralLedgerSetupRec.Get();
                    GeneralLedgerSetupRec.TestField("Withdrawal No.");
                    NoSeriesManagement.TestManual(GeneralLedgerSetupRec."Withdrawal No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    StudentStatus.Get(StudentMasterCS.Status, StudentMasterCS."Global Dimension 1 Code");
                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                    StudentStatus.Status::Suspension, StudentStatus.Status::Withdrawn, StudentStatus.Status::Dismissed,
                    StudentStatus.Status::Deceased] then
                        Error('Please check the student status.')
                    else begin
                        "Student Name" := StudentMasterCS."Student Name";
                        Course := StudentMasterCS."Course Code";
                        "Enrolment No." := StudentMasterCS."Enrollment No.";
                        Semester := StudentMasterCS.Semester;
                        Section := StudentMasterCS.Section;
                        "Course Name" := StudentMasterCS."Course Name";
                        "Academic Year" := StudentMasterCS."Academic Year";
                        Term := StudentMasterCS.Term;
                        "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";

                        RecClassAttendanceLine.Reset();
                        RecClassAttendanceLine.SetRange("Student No.", "Student No.");
                        RecClassAttendanceLine.SetRange(Semester, StudentMasterCS.Semester);
                        RecClassAttendanceLine.SetRange("Academic Year", StudentMasterCS."Academic Year");
                        RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                        IF recClassAttendanceLine.FindLast() then
                            "Last Date Of Attendance" := recClassAttendanceLine.Date;

                        CourseSemesterRec.Reset();
                        CourseSemesterRec.SetRange("Course Code", StudentMasterCS."Course Code");
                        CourseSemesterRec.SetRange(Term, StudentMasterCS.Term);
                        CourseSemesterRec.SetRange("Semester Code", StudentMasterCS.Semester);
                        CourseSemesterRec.SetRange("Academic Year", "Academic Year");
                        CourseSemesterRec.SetRange("Start Date Not Applicable", false);
                        CourseSemesterRec.FindFirst();
                        "Semester Start Date" := CourseSemesterRec."Start Date";

                        if "Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal" then begin
                            if StudentMasterCS."Global Dimension 1 Code" = '9000' then
                                Error('Course Withdrawal is not Applicable for the selected student');
                        end;

                    end;
                end else begin
                    "Student Name" := '';
                    Course := '';
                    "Enrolment No." := '';
                    Semester := '';
                    Section := '';
                    "Course Name" := '';
                    "Academic Year" := '';
                    //  "Global Dimension 1 Code" := '';
                    //  "Global Dimension 2 Code" := '';
                end;

                // if ("Student No." <> '') AND ("Type of Withdrawal" = "Type of Withdrawal"::"College-Withdrawal") then begin
                //     WithdrawalStudentCS.SETRANGE("Student No.", "Student No.");
                //     WithdrawalStudentCS.SETRANGE(WithdrawalStudentCS."Type of Withdrawal", WithdrawalStudentCS."Type of Withdrawal"::"College-Withdrawal");
                //     IF WithdrawalStudentCS.FINDFIRST() THEN
                //         ERROR(Text000Lbl);
                // end;
            end;

        }
        field(3; Course; Code[20])
        {
            Caption = 'Course';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                if CourseMasterRec.Get(Course) then
                    "Course Name" := CourseMasterRec.Description
                else
                    "Course Name" := '';
            end;
        }
        field(4; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(5; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = false;
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(7; "Withdrawal Date"; Date)
        {
            Caption = 'Withdrawal date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Withdrawal date" < WorkDate() then
                    Error('Withdrawal Date cannot be smaller than workdate');
            end;
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(9; "TC Issued"; Boolean)
        {
            Caption = 'TC Issued';
            DataClassification = CustomerContent;
        }
        field(10; "HelloSign_Confirmed"; Boolean)
        {   //CSPL-00307-HelloSign_BUG
            DataClassification = ToBeClassified;
        }
        field(26; "Reason for Leaving"; Text[500])
        {
            Caption = 'Reason for Leaving';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Reason Description" := "Reason for Leaving";
                    StudentMaster.Modify();
                end;
            end;

        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50013; "Type Of Course"; Option)
        {
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
        }
        field(50019; "Withdrawal Status"; Option)
        {
            Description = 'CS Field Added 28-04-2019';
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            Caption = 'Withdrawal Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50020; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 28-04-2019';
            Editable = false;
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(50021; Updated; Boolean)
        {
            Description = 'CS Field Added 28-04-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50022; "Bank Acc Holder Name"; Text[100])
        {
            Description = 'CS Field Added 28-04-2019';
            Caption = 'Bank Account Holder Name';
            DataClassification = CustomerContent;
        }
        field(50023; "Bank Account No/IBAN Number"; Text[50])
        {
            Description = 'CS Field Added 28-04-2019';
            Caption = 'Bank Account No./IBAN Number';
            DataClassification = CustomerContent;
        }
        field(50026; "Bank Name"; Text[100])
        {
            Description = 'CS Field Added 28-04-2019';
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(50027; "IFSC Code Number/Swift Code"; Text[30])
        {
            Description = 'CS Field Added 28-04-2019';
            Caption = 'IFSC Code Number/Swift Code';
            DataClassification = CustomerContent;
        }
        field(50028; Refund; Boolean)
        {
            Description = 'CS Field Added 28-04-2019';
            Caption = 'Refund';
            DataClassification = CustomerContent;
        }
        field(50029; "Type of Withdrawal"; Option)
        {
            Description = 'CS Field Added 28-04-2019';
            OptionCaption = ' ,Course-Withdrawal,College-Withdrawal';
            OptionMembers = " ","Course-Withdrawal","College-Withdrawal";
            Caption = 'Type of Withdrawal';
            Editable = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal" then begin
                    if "Global Dimension 1 Code" = '9000' then
                        Error('Course Withdrawal is not Applicable for the selected student');
                    // EducationSetupRec.Reset();
                    // EducationSetupRec.Setrange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    // if EducationSetupRec.Findfirst() then
                    //     if not EducationSetupRec."Course Withdrawal Applicable" then
                    //         Error('Course Withdrawal is not Applicable for the selected student');
                end;

            end;
        }
        field(50030; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50032; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50036; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(50038; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code" WHERE(Type = FILTER(Withdrawal));
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                if ReasonCodeRec.Get("Reason Code") then
                    Validate("Reason for Leaving", ReasonCodeRec.Description)
                else
                    "Reason for Leaving" := '';

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster.Reason := "Reason Code";
                    StudentMaster.Modify();
                end;
            end;
        }
        field(50039; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50040; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50044; "Semester Start Date"; Date)
        {
            Caption = 'Semester Start Dates';
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(50045; "NSLDS Withdrawal Date"; Date)
        {
            Caption = 'NSLDS Withdrawal Date';
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     if "NSLDS Withdrawal Date" < "Application Date" then
            //         Error('NSLDS Withdrawal Date must be greater then Application Date.');
            // end;
        }
        field(50046; "Date Of Determination"; Date)
        {
            Caption = 'Date of Determination';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                // if "Date of Determination" < "Application Date" then
                //     Error('Date of Determination must be greater then Application Date.');
            end;
        }
        field(50047; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = CustomerContent;
            //Editable = false;
            trigger OnValidate()
            begin
                // if "Last Date Of Attendance" < "Application Date" then
                //     Error('Last Date Of Attendance must be greater then Application Date.');
            end;
        }
        field(50048; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 28-04-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 28-04-2019';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::22-041-2019: Start
        UserSetup.Get(UserId());
        GeneralLedgerSetupRec.Get();
        GeneralLedgerSetupRec.TESTFIELD("Withdrawal No.");
        NoSeriesManagement.InitSeries(GeneralLedgerSetupRec."Withdrawal No.", xRec."No. Series", 0D, "No.", "No. Series");
        "Application Date" := WORKDATE();
        if "Global Dimension 1 Code" = '' then
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "User ID" := FORMAT(UserId());

        Inserted := true;
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::22-04-2019: End
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    trigger OnDelete()
    begin
        if "Withdrawal Status" <> "Withdrawal Status"::Open then
            Error('Withdrawal Status must be open.');
    end;

    var
        GeneralLedgerSetupRec: Record "General Ledger Setup";
        EducationSetupRec: Record "Education Setup-CS";
        CourseMasterRec: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        UserSetup: Record "User Setup";
        ReasonCodeRec: Record "Reason Code";
        StudentStatus: Record "Student Status";
        DepartmentMasterRec: Record "Withdrawal Department";
        recClassAttendanceLine: Record "Class Attendance Line-CS";
        CourseSemesterRec: Record "Course Sem. Master-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    procedure Assistedit(): Boolean
    var
    begin

        UserSetup.Get(UserId());
        GeneralLedgerSetupRec.Get();
        GeneralLedgerSetupRec.TESTFIELD("Withdrawal No.");
        IF NoSeriesManagement.SelectSeries(GeneralLedgerSetupRec."Withdrawal No.", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesManagement.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    procedure PostStudentWithdrawalApprovalEntries(WithdwaralType: Option " ","Course-Withdrawal","College-Withdrawal");
    var
        WithdrawalApprovalsRec: Record "Withdrawal Approvals";
        StudentMaster: Record "Student Master-CS";
        RecSemester: Record "Semester Master-CS";
    begin
        RecSemester.Reset();
        RecSemester.SetRange(Code, Rec.Semester);
        if RecSemester.FindFirst() then;
        DepartmentMasterRec.Reset();
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType("Student No."));//CSPL-00307-T1-T1516-CR
        If (WithdwaralType = WithdwaralType::"Course-Withdrawal") then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Type of Withdrawal", '<>%1', DepartmentMasterRec."Type of Withdrawal"::"College-Withdrawal")
        Else
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Type of Withdrawal", '<>%1', DepartmentMasterRec."Type of Withdrawal"::"Course-Withdrawal");
        DepartmentMasterRec.SetRange("Final Approval", true);
        if not DepartmentMasterRec.FindFirst() then
            Error('There is no Final Approver in the Withdrawal Approver list.');

        // DepartmentMasterRec.Reset();
        // DepartmentMasterRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        // DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType("Student No."));//CSPL-00307-T1-T1516-CR
        // DepartmentMasterRec.SetFilter("Type of Withdrawal", '%1', DepartmentMasterRec."Type of Withdrawal"::"College-Withdrawal");
        // DepartmentMasterRec.SetRange("Waiver Calculation Allowed", true);
        // if not DepartmentMasterRec.FindFirst() then
        //     Error('There is no Waiver Approver in the Withdrawal Approver list.');

        DepartmentMasterRec.Reset();
        DepartmentMasterRec.SetCurrentKey(Sequence);
        DepartmentMasterRec.Ascending(true);
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        DepartmentMasterRec.SetRange("Document Type", DepartmentMasterRec.GetDocumentType("Student No."));//CSPL-00307-T1-T1516-CR
        If (WithdwaralType = WithdwaralType::"Course-Withdrawal") then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Type of Withdrawal", '<>%1', DepartmentMasterRec."Type of Withdrawal"::"College-Withdrawal")
        Else
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Type of Withdrawal", '<>%1', DepartmentMasterRec."Type of Withdrawal"::"Course-Withdrawal");
        if DepartmentMasterRec.findfirst() then
            repeat
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", Rec."Student No.");
                IF StudentMaster.FindFirst() then begin
                    If (DepartmentMasterRec."Department Code" = '8007') and (StudentMaster."FAFSA Received") then begin
                        WithdrawalApprovalsRec.Init();
                        WithdrawalApprovalsRec."Student No." := "Student No.";
                        WithdrawalApprovalsRec."Student Name" := "Student Name";
                        WithdrawalApprovalsRec."Enrolment No." := "Enrolment No.";
                        WithdrawalApprovalsRec."Application Date" := "Application date";
                        WithdrawalApprovalsRec."Withdrawal Date" := "Withdrawal date";
                        WithdrawalApprovalsRec."Approved for Department" := DepartmentMasterRec."Department Code";
                        WithdrawalApprovalsRec."Department Name" := DepartmentMasterRec."Department Name";
                        WithdrawalApprovalsRec.Status := WithdrawalApprovalsRec.Status::"Pending for Approval";
                        WithdrawalApprovalsRec.Course := Course;
                        WithdrawalApprovalsRec."Course Name" := "Course Name";
                        WithdrawalApprovalsRec."Final Approval" := DepartmentMasterRec."Final Approval";
                        WithdrawalApprovalsRec."Waiver Calculation Allowed" := DepartmentMasterRec."Waiver Calculation Allowed";
                        WithdrawalApprovalsRec."Reason Code" := "Reason Code";
                        WithdrawalApprovalsRec."Reason for Leaving" := "Reason for Leaving";
                        WithdrawalApprovalsRec."Type of Withdrawal" := "Type of Withdrawal";
                        WithdrawalApprovalsRec.Semester := Semester;
                        WithdrawalApprovalsRec."Academic Year" := "Academic Year";
                        WithdrawalApprovalsRec."Withdrawal No." := "No.";
                        WithdrawalApprovalsRec."NSLDS Withdrawal Date" := "NSLDS Withdrawal Date";
                        WithdrawalApprovalsRec."Date Of Determination" := "Date Of Determination";
                        WithdrawalApprovalsRec."Last Date Of Attendance" := "Last Date Of Attendance";
                        WithdrawalApprovalsRec."Semester Start Date" := "Semester Start Date";
                        WithdrawalApprovalsRec."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        WithdrawalApprovalsRec."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        WithdrawalApprovalsRec.Insert(true);
                        // if DepartmentMasterRec."Final Approval" = false then
                        //     WithdrawalRequestMailtoDepartment("Student No.", DepartmentMasterRec."Department Code", "Global Dimension 1 Code");//, DocumentType);
                    end;
                    If (DepartmentMasterRec."Department Code" <> '8007') then begin
                        WithdrawalApprovalsRec.Init();
                        WithdrawalApprovalsRec."Student No." := "Student No.";
                        WithdrawalApprovalsRec."Student Name" := "Student Name";
                        WithdrawalApprovalsRec."Enrolment No." := "Enrolment No.";
                        WithdrawalApprovalsRec."Application Date" := "Application date";
                        WithdrawalApprovalsRec."Withdrawal Date" := "Withdrawal date";
                        WithdrawalApprovalsRec."Approved for Department" := DepartmentMasterRec."Department Code";
                        WithdrawalApprovalsRec."Department Name" := DepartmentMasterRec."Department Name";
                        WithdrawalApprovalsRec.Status := WithdrawalApprovalsRec.Status::"Pending for Approval";
                        WithdrawalApprovalsRec.Course := Course;
                        WithdrawalApprovalsRec."Course Name" := "Course Name";
                        WithdrawalApprovalsRec."Final Approval" := DepartmentMasterRec."Final Approval";
                        WithdrawalApprovalsRec."Waiver Calculation Allowed" := DepartmentMasterRec."Waiver Calculation Allowed";
                        WithdrawalApprovalsRec."Reason Code" := "Reason Code";
                        WithdrawalApprovalsRec."Reason for Leaving" := "Reason for Leaving";
                        WithdrawalApprovalsRec."Type of Withdrawal" := "Type of Withdrawal";
                        WithdrawalApprovalsRec.Semester := Semester;
                        WithdrawalApprovalsRec."Academic Year" := "Academic Year";
                        WithdrawalApprovalsRec."Withdrawal No." := "No.";
                        WithdrawalApprovalsRec."NSLDS Withdrawal Date" := "NSLDS Withdrawal Date";
                        WithdrawalApprovalsRec."Date Of Determination" := "Date Of Determination";
                        WithdrawalApprovalsRec."Last Date Of Attendance" := "Last Date Of Attendance";
                        WithdrawalApprovalsRec."Semester Start Date" := "Semester Start Date";
                        WithdrawalApprovalsRec."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        WithdrawalApprovalsRec."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        WithdrawalApprovalsRec.Insert(true);
                        // if DepartmentMasterRec."Final Approval" = false then
                        //     WithdrawalRequestMailtoDepartment("Student No.", DepartmentMasterRec."Department Code", "Global Dimension 1 Code");//, DocumentType);
                    end;
                end;
            Until DepartmentMasterRec.NEXT() = 0;

    end;

    // procedure WithdrawalRequestMailtoDepartment(StudentNo: Code[20]; Department: Code[20]; GD1: Code[20])//; DocumentType: Option " ",Withdrawal,SLOA,ELOA,CLOA)
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     WithdrawalDepartmentRec: Record "Withdrawal Department";

    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     WithdrawalDepartmentRec.Reset();
    //     WithdrawalDepartmentRec.SetRange("Department Code", Department);
    //     WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", GD1);
    //     WithdrawalDepartmentRec.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
    //     //If (DocumentType = DocumentType::Withdrawal) then
    //     WithdrawalDepartmentRec.SetRange("Document Type", WithdrawalDepartmentRec."Document Type"::Withdrawal);
    //     if WithdrawalDepartmentRec.FindFirst() then;
    //     Recipient := WithdrawalDepartmentRec.GetUsersEmailid(WithdrawalDepartmentRec."Department Code");
    //     CCRecipient := WithdrawalDepartmentRec."CC E-Mail";
    //     CCRecipients := CCRecipient.Split(';');

    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("No.") + ' ' + 'Withdrawal Request:' + ' ' + Format(StudentNo) + ',' + ' ' +
    //                 Format("Student Name") + ',' + ' ' + Format("Enrolment No.") + ',' + ' ' + Format(Semester));

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     If CCRecipient <> '' then
    //         SmtpMail.AddCC(CCRecipients);
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartmentRec."Department Name") + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that I would like to withdraw from' + ' ' +
    //                          Format("Course Name") + ' ' + 'Program' + ',' + ' ' + 'Semester'
    //                         + ' ' + Format(Semester) + ' ' + 'due to' + ' ' + Format("Reason for Leaving"));
    //     // + ' ' + 'effective' + ' ' + Format("Application Date") + '.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Kindly approve my withdrawal request.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody("Student Name" + ',' + ' ' + "Student No." + ',' + ' ' + Semester);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail ID.');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();
    // end;


}