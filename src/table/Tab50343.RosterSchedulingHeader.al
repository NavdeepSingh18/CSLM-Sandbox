table 50343 "Roster Scheduling Header"
{
    DataClassification = CustomerContent;
    Caption = 'Roster Scheduling Header';
    // DrillDownPageId = "Roster List";
    // LookupPageId = "Roster List";
    fields
    {
        field(1; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation ID';
            trigger OnValidate()
            begin
                NoSeriesManagement.TestManual(GetNoSeriesCode());
                "No. Series" := '';
            end;
        }
        field(2; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;

            trigger OnValidate()
            begin
                LineExistError()
            end;
        }

        field(3; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
        }
        field(4; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Type';
            OptionMembers = Clerkship,"FM1/IM1";
        }

        field(5; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(6; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = if ("Course Type" = filter(Core)) "Subject Master-CS".Code where("Type of Subject" = filter(Core), "Level Description" = filter("Level 2 Clinical Rotation"))
            else
            "Subject Master-CS".Code;

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                "Course Description" := '';
                NoOfWeeks := 0;
                Validate("No. of Weeks", NoOfWeeks);
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.findfirst() then begin
                    SubjectMaster.TestField(Duration);
                    "Course Description" := SubjectMaster.Description;
                    "Rotation Description" := SubjectMaster.Description;
                    if "Clerkship Type" = "Clerkship Type"::Core then begin
                        TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
                        Evaluate(NoOfWeeks, TextNoofWeeks);
                        Validate("No. of Weeks", NoOfWeeks);
                        "Course Prefix" := SubjectMaster."Subject Prefix";
                    end;
                end;
                UpdateLines();
            end;
        }
        field(7; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(8; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
        }
        field(9; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }
        field(10; "Course Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";

            trigger OnValidate()
            begin
                UpdateLines();
            end;
        }
        field(11; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            trigger OnValidate()
            var
                Date_1: Record Date;
            begin
                if "Start Date" <> 0D then begin
                    if "Start Date" < WorkDate() then
                        Error('Start date of a rotation cannot be less than %1.', WorkDate());

                    Date_1.Reset();
                    Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                    Date_1.SetRange("Period Start", "Start Date");
                    if Date_1.FindFirst() then;

                    if Date_1."Period Name" <> 'Monday' then
                        Error('Rotation Start Date must be Monday.');
                end;
                Validate("No. of Weeks");
            end;
        }
        field(12; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(13; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            BlankZero = true;
            trigger OnValidate()
            var
                PeriodLength: DateFormula;
            begin
                if "Start Date" <> 0D then begin
                    EVALUATE(PeriodLength, Format("No. of Weeks") + 'W-3D');
                    "End Date" := CALCDATE(PeriodLength, "Start Date");
                end
                else
                    "End Date" := 0D;
            end;
        }

        field(14; "No. of Students"; Integer)
        {
            Caption = 'No. of Students';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID")));
            Editable = false;
        }
        field(60004; "No. of Students Schedule"; Integer)
        {
            Caption = 'No. of Students (Schedule)';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), Status = filter(Scheduled)));
            Editable = false;
        }
        field(60005; "No. of Students UNC"; Integer)
        {
            Caption = 'No. of Students (Unconfirmed)';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), Status = filter(Unconfirmed)));
            Editable = false;
        }
        field(60006; "No. of Students Published"; Integer)
        {
            Caption = 'No. of Students Published';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), Status = filter(Published)));
            Editable = false;
        }
        field(60007; "No. of Students In-Review"; Integer)
        {
            Caption = 'No. of Students In-Review';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), Status = filter("In-Review")));
            Editable = false;
        }
        field(60008; "No. of Students Cancelled"; Integer)
        {
            Caption = 'No. of Students Cancelled';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), Status = filter(Cancelled)));
            Editable = false;
        }
        field(60009; "No. of Students Completed"; Integer)
        {
            Caption = 'No. of Students Completed';
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), Status = filter(Completed)));
            Editable = false;
        }

        field(15; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }

        field(16; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(17; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Scheduled","Published","Cancelled";
            trigger OnValidate()
            begin
                if Status = Status::Scheduled then begin
                    "Scheduled By" := UserId;
                    "Scheduled On" := Today;
                end;
                if Status = Status::Published then begin
                    "Published By" := UserId;
                    "Published On" := Today;
                end;
                if Status = Status::Cancelled then begin
                    "Cancelled By" := UserId;
                    "Cancelled Date" := Today;
                    "Cancelled Time" := Time;
                end;

                "Status By" := UserId;
                "Status On" := Today;
            end;
        }

        field(18; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status By';
            Editable = false;
        }
        field(20; "Status On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Status By';
            Editable = false;
        }
        field(21; "Rotation Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed';
            Editable = false;
            trigger OnValidate()
            var
                RosterSchedulingLine: Record "Roster Scheduling Line";
            begin
                "Rotation Confirmed By" := '';
                "Rotation Confirmed On" := 0D;
                if "Rotation Confirmed" then begin
                    "Rotation Confirmed By" := UserId;
                    "Rotation Confirmed On" := Today;
                end;
                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
                if RosterSchedulingLine.FindFirst() then
                    repeat
                        RosterSchedulingLine."Rotation Confirmed" := "Rotation Confirmed";
                        RosterSchedulingLine."Rotation Confirmed By" := "Rotation Confirmed By";
                        RosterSchedulingLine."Rotation Confirmed On" := "Rotation Confirmed On";
                        RosterSchedulingLine.Modify();
                    until RosterSchedulingLine.Next() = 0;
            end;
        }
        field(22; "Rotation Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed By';
            Editable = false;
        }
        field(23; "Rotation Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed On';
            Editable = false;
        }
        field(24; "Cancel Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter("Rotation Cancellation"));

            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Cancel Reason" := '';
                if ReasonCode.Get("Cancel Reason Code") then
                    "Cancel Reason" := ReasonCode.Description;
            end;
        }
        field(25; "Cancel Reason"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Reason';
        }
        field(28; "Elective Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Mandatory';

            trigger OnValidate()
            var
                POS: Integer;
            begin
                if StrPos("Course Description", 'Sur') > 0 then
                    POS := StrPos("Course Description", 'Sur');
                if StrPos("Course Description", 'SUR') > 0 then
                    POS := StrPos("Course Description", 'SUR');

                if POS = 0 then
                    Error('Elective Mandatory can be marked only in case of Core Surgery.');
            end;
        }
        field(29; "Course Prefix"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix';
            TableRelation = "Subject Prefix".Code;
            trigger OnValidate()
            begin
                Validate("Elective Course Code");
            end;
        }
        field(30; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';

            TableRelation = if ("Clerkship Type" = filter(Core)) Vendor."No." where("Vendor Sub Type" = const(Hospital), Blocked = filter(" "))
            else
            if ("Clerkship Type" = filter("FM1/IM1")) Vendor."No." where("Vendor Sub Type" = const(Hospital))
            else
            if ("Clerkship Type" = filter(Elective)) Vendor."No." where("Vendor Sub Type" = const(Hospital));


            // TableRelation = if ("Clerkship Type" = filter(Core | "FM1/IM1")) "Hospital Inventory"."Hospital ID" where("Academic Year" = field("Academic Year"), "Clerkship Type" = field("Clerkship Type"), "Course Code" = field("Course Code"), Status = filter(" " | Allowed))
            // else
            // if ("Clerkship Type" = filter(Elective), "Non-Affiliated Application No." = filter('')) "Hospital Inventory"."Hospital ID" where("Academic Year" = field("Academic Year"), "Clerkship Type" = field("Clerkship Type"), "Course Code" = field("Elective Course Code"), Status = filter(" " | Allowed), "Non-Affiliated Hospital" = filter(false))
            // else
            // "Hospital Inventory"."Hospital ID" where("Academic Year" = field("Academic Year"), "Clerkship Type" = field("Clerkship Type"), "Course Code" = field("Elective Course Code"), Status = filter(" " | Allowed), "Non-Affiliated Hospital" = filter(true));

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Hospital Name" := '';
                "DME Name" := '';
                "DME Phone No." := '';
                "DME Recipient" := '';
                "Elective Mandatory" := false;

                Vendor.Reset();
                if Vendor.Get("Hospital ID") then begin
                    "Hospital Name" := Vendor.Name;
                    "DME Name" := Vendor."DME Name";
                    "DME Phone No." := Vendor."DME Phone No.";
                    "DME Recipient" := Vendor."DME Email";

                    if Vendor.Blocked <> Vendor.Blocked::" " then
                        Error('Hospital No. %1 (%2) is blocked.', "Hospital ID", "Hospital Name");
                end;

                "Maximum Waitlist Students" := 0;
                Validate("No. of Seats", 0);

                if ("Hospital ID" <> '') and ("Clerkship Type" = "Clerkship Type"::Core) then
                    "Maximum Waitlist Students" := 5;
            end;
        }
        field(31; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(32; "FM1/IM1 Preset No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Preset No.';
            Editable = false;
        }
        field(33; "Non-Affiliated Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Non-Affiliated Application No.';
            Editable = false;
        }
        field(35; "No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Seats';
            Editable = false;
            DecimalPlaces = 0;
            MinValue = 0;
            trigger OnValidate()
            begin
                Validate("Total No. of Seats");
            end;
        }
        field(36; "Maximum Waitlist Students"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Waitlist Students';
            DecimalPlaces = 0;
            trigger OnValidate()
            begin
                Validate("Total No. of Seats");
            end;
        }
        field(37; "Total No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Seats';
            Editable = false;
            DecimalPlaces = 0;
            trigger OnValidate()
            begin
                "Total No. of Seats" := "No. of Seats" + "Maximum Waitlist Students";
            end;
        }
        field(39; "Cancelled By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(40; "Cancelled Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled Date';
            Editable = false;
        }
        field(41; "Cancelled Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled Time';
            Editable = false;
        }
        field(42; "Umbrella Rotation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Umbrella Rotation';
        }
        field(100; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;
        }
        field(101; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
        field(102; "Published By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Published By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(103; "Published On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Published On';
            Editable = false;
        }
        field(104; "Scheduled By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduled By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(105; "Scheduled On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduled On';
            Editable = false;
        }
        field(119; "DME Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Business Contact Relation"."Contact No." where("No." = field("Hospital ID"));
            trigger OnValidate()
            var
                BusinessContactRelation: Record "Business Contact Relation";
            begin
                "DME Name" := '';
                "DME Phone No." := '';
                "DME Recipient" := '';
                BusinessContactRelation.Reset();
                if BusinessContactRelation.Get("Hospital ID", "DME Contact No.") then begin
                    "DME Name" := BusinessContactRelation.Name;
                    "DME Phone No." := BusinessContactRelation."Phone No.";
                    "DME Recipient" := BusinessContactRelation."E-Mail";
                end;
            end;
        }
        field(120; "DME Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(121; "DME Phone No."; Text[20])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(122; "DME Recipient"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("DME Recipient");
            end;
        }
        field(125; "Preceptor Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Business Contact Relation"."Contact No." where("No." = field("Hospital ID"), Preceptor = const(true));
            trigger OnValidate()
            var
                BusinessContactRelation: Record "Business Contact Relation";
            begin
                "Preceptor Name" := '';
                "Preceptor Phone No." := '';
                "Preceptor Recipient" := '';
                BusinessContactRelation.Reset();
                if BusinessContactRelation.Get("Hospital ID", "Preceptor Contact No.") then begin
                    "Preceptor Name" := BusinessContactRelation.Name;
                    "Preceptor Phone No." := BusinessContactRelation."Phone No.";
                    "Preceptor Recipient" := BusinessContactRelation."E-Mail";
                end;
            end;
        }
        field(126; "Preceptor Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(127; "Preceptor Phone No."; Text[20])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(128; "Preceptor Recipient"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Preceptor Recipient");
            end;
        }

        field(500; "nID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'nID';
        }
        field(59999; "Duplicate Roster"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Duplicate Roster';
        }
        field(60000; "Total Student Applied"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Line" where("Rotation ID" = field("Rotation ID"), "Action of Student" = filter(Confirmed)));
            Editable = false;
        }
        field(60003; "Clerkship Semester Filter"; Code[50])
        {
            Caption = 'Clerkship Semester Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }

        field(60010; "Core Same Roster Count"; Integer)
        {
            Caption = 'Core Same Roster Count';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Header" where("Hospital ID" = field("Hospital ID"), "Course Code" = field("Course Code"), "Start Date" = field("Start Date")));
        }
        field(60011; "Elective Same Roster Count"; Integer)
        {
            Caption = 'Elective Same Roster Count';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Roster Scheduling Header" where("Hospital ID" = field("Hospital ID"), "Elective Course Code" = field("Elective Course Code"), "Start Date" = field("Start Date")));
        }
    }

    keys
    {
        key(PK; "Rotation ID")
        {
            Clustered = true;
        }
        key(StartDate; "Start Date", "Rotation ID")
        {
            Clustered = false;
        }
        key(CreatedOn; "Created On")
        {
            Clustered = false;
        }
        key(Key_1; "Clerkship Type", "Start Date", Status)
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Rotation ID", "Clerkship Type", "Academic Year", "Start Date", "No. of Weeks", "Rotation Description")
        {
        }
    }

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        NoSeriesManagement.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "Rotation ID", "No. Series");
        "Status By" := UserId;
        "Status On" := Today;
        "Created By" := UserId;
        "Created On" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        //LineExistError();
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        if RosterSchedulingLine.FindFirst() then
            repeat
                RosterSchedulingLine.Delete(true);
            until RosterSchedulingLine.Next() = 0;
    end;

    trigger OnRename()
    begin
        LineExistError()
    end;

    /// <summary> 
    /// Description for GetNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "SeriesCode" of type Code[20].</returns>
    local procedure GetNoSeriesCode() SeriesCode: Code[20];
    var
        EducationSetupCS: Record "Education Setup-CS";
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        if EducationSetupCS.Find('-') then begin
            if "Clerkship Type" = "Clerkship Type"::Core then begin
                EducationSetupCS.TestField("Core Clinical Roster Nos.");
                SeriesCode := EducationSetupCS."Core Clinical Roster Nos.";
            end;

            if "Clerkship Type" = "Clerkship Type"::Elective then begin
                EducationSetupCS.TestField("Elective Clinical Roster Nos.");
                SeriesCode := EducationSetupCS."Elective Clinical Roster Nos.";
            end;

            if "Clerkship Type" = "Clerkship Type"::"FM1/IM1" then begin
                EducationSetupCS.TestField("FM1_IM1 Clerkship Nos.");
                SeriesCode := EducationSetupCS."FM1_IM1 Clerkship Nos.";
            end;
            exit(SeriesCode);
        end;
    end;

    /// <summary> 
    /// Description for UpdateLines.
    /// </summary>
    procedure UpdateLines()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        IF RosterSchedulingLine.Find('-') then
            repeat
                RosterSchedulingLine."Entry Type" := "Entry Type";
                RosterSchedulingLine."Clerkship Type" := "Clerkship Type";
                RosterSchedulingLine."Course Code" := "Course Code";
                RosterSchedulingLine."Course Description" := "Course Description";
                RosterSchedulingLine."Rotation Description" := "Rotation Description";
                RosterSchedulingLine.Validate("Course Type", "Course Type");
                RosterSchedulingLine."Start Date" := "Start Date";
                RosterSchedulingLine."End Date" := "End Date";
                RosterSchedulingLine.Validate("No. of Weeks", "No. of Weeks");
                RosterSchedulingLine.Modify();
            until RosterSchedulingLine.Next() = 0;
    end;

    /// <summary> 
    /// Description for GetStudents.
    /// </summary>
    procedure GetStudents()
    var
        EducationSetup: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        RosterSchedulingLine: Record "Roster Scheduling Line";
        Text001Lbl: Label 'Total Students      ############1################\';
        Text002Lbl: Label 'Processed Students      ############2################\';
        WindowDialog: Dialog;
        T: Integer;
        C: Integer;
        PendingStudentsforRotation: Integer;
        InsertedStudents: Integer;
        ValidStudent: Boolean;
    begin
        TestField("Academic Year");
        TestField("Course Code");
        TestField("Course Type");
        TestField("Hospital ID");
        TestField("Start Date");
        TestField("End Date");

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Clerkship Semester Filter");

        InsertedStudents := 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        InsertedStudents := RosterSchedulingLine.Count();

        PendingStudentsforRotation := ("No. of Seats" + "Maximum Waitlist Students") - InsertedStudents;

        WindowDialog.Open('Inserting Students..\' + Text001Lbl + Text002Lbl);
        StudentMasterCS.Reset();
        StudentMasterCS.SetCurrentKey(Semester, "Last Name");
        StudentMasterCS.SetRange("Global Dimension 1 Code", '9000');
        StudentMasterCS.SetFilter(Semester, EducationSetup."Clerkship Semester Filter");
        StudentMasterCS.SetAscending(Semester, false);//CSPL-00307-RTP
        if StudentMasterCS.Find('-') then begin
            T := StudentMasterCS.Count;
            C := 0;
            repeat
                C += 1;
                WindowDialog.Update(1, T);
                WindowDialog.Update(2, C);
                ValidStudent := false;

                ValidStudent := CheckValidStudentForRotation(StudentMasterCS);

                if ValidStudent then begin
                    InsertedStudents := InsertedStudents + 1;
                    PendingStudentsforRotation := PendingStudentsforRotation - 1;
                    InsertRotationLine(StudentMasterCS, InsertedStudents);
                end;
            until (StudentMasterCS.Next() = 0) OR (PendingStudentsforRotation = 0);
            WindowDialog.Close();
        end;
    end;

    procedure AutoAllotSeat()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        RosterSchedulingLine2: Record "Roster Scheduling Line";
        VarFound: Boolean;
        VarCounter: integer;
    begin
        //CSPL-00307-RTP
        //When a Student is Fail in CCSSE 1st Attempt it is Priority to auto allot a seat to that student as compared to other students who have not Failed to their first attempt
        VarFound := false;
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey(Semester, Waitlisted);
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        RosterSchedulingLine.SetRange(Waitlisted, true);
        RosterSchedulingLine.SetRange(CCSSE1stFail, true);
        RosterSchedulingLine.SetAscending(Semester, false);
        if RosterSchedulingLine.FindFirst() then begin
            repeat
                RosterSchedulingLine.Status := RosterSchedulingLine.Status::Scheduled;
                RosterSchedulingLine.Waitlisted := false;
                RosterSchedulingLine2.Reset();
                RosterSchedulingLine2.SetCurrentKey(Semester, Waitlisted);
                RosterSchedulingLine2.SetRange("Rotation ID", "Rotation ID");
                RosterSchedulingLine2.SetRange(Waitlisted, false);
                RosterSchedulingLine2.SetAscending(Semester, true);
                RosterSchedulingLine2.SetFilter("Student No.", '<>%1', RosterSchedulingLine."Student No.");
                RosterSchedulingLine2.SetRange(CCSSE1stFail, false);
                if RosterSchedulingLine2.FindFirst() then begin
                    RosterSchedulingLine.Modify();
                    RosterSchedulingLine2.Status := RosterSchedulingLine2.Status::Unconfirmed;
                    RosterSchedulingLine2.Waitlisted := true;
                    RosterSchedulingLine2.Modify();
                    VarFound := true;
                end;
            until RosterSchedulingLine.Next() = 0;
        end;
        IF VarFound then begin
            RosterSchedulingLine.Reset();
            RosterSchedulingLine.SetCurrentKey(CCSSE1stFail, Semester);
            RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
            RosterSchedulingLine.SetAscending(CCSSE1stFail, true);
            RosterSchedulingLine.SetAscending(Semester, false);
            IF RosterSchedulingLine.FindSet() then begin
                repeat
                    VarCounter += 1;
                    IF VarCounter > "No. of Seats" then begin
                        RosterSchedulingLine.Status := RosterSchedulingLine.Status::Unconfirmed;
                        RosterSchedulingLine.Waitlisted := true;
                        RosterSchedulingLine.Modify();
                    end;
                until RosterSchedulingLine.Next() = 0;
            end;
        end;
        //CSPL-00307-RTP
    end;

    /// <summary> 
    /// Description for GetStudentsGHT.
    /// </summary>
    procedure GetStudentsGHT()
    var
        EducationSetup: Record "Education Setup-CS";
        CourseMaster: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        RosterSchedulingLine: Record "Roster Scheduling Line";

        Text001Lbl: Label 'Total Students      ############1################\';
        Text002Lbl: Label 'Processed Students      ############2################\';
        WindowDialog: Dialog;
        T: Integer;
        C: Integer;
        PendingStudentsforRotation: Integer;
        InsertedStudents: Integer;
        ValidStudent: Boolean;
    begin
        TestField("Academic Year");
        TestField("Course Code");
        TestField("Course Type");
        TestField("Hospital ID");
        TestField("Start Date");
        TestField("End Date");

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Clerkship Semester Filter");

        InsertedStudents := 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        InsertedStudents := RosterSchedulingLine.Count();
        PendingStudentsforRotation := ("No. of Seats" + "Maximum Waitlist Students") - InsertedStudents;

        WindowDialog.Open('Inserting GHT Students..\' + Text001Lbl + Text002Lbl);
        StudentMasterCS.Reset();
        StudentMasterCS.SetCurrentKey(Semester, "Last Name");
        StudentMasterCS.SetRange("Global Dimension 1 Code", '9000');
        StudentMasterCS.SetFilter(Semester, EducationSetup."Clerkship Semester Filter");
        StudentMasterCS.SetAscending(Semester, false);//CSPL-00307-RTP
        if StudentMasterCS.Find('-') then begin
            T := StudentMasterCS.Count;
            C := 0;
            repeat
                C += 1;
                WindowDialog.Update(1, T);
                WindowDialog.Update(2, C);
                ValidStudent := false;

                StudentMasterCS.TestField("Course Code");

                CourseMaster.Reset();
                if CourseMaster.Get(StudentMasterCS."Course Code") then;

                ValidStudent := CheckValidStudentForRotation(StudentMasterCS);

                if CourseMaster."Course Category" <> CourseMaster."Course Category"::GHT then
                    ValidStudent := false;

                if ValidStudent then begin
                    InsertedStudents := InsertedStudents + 1;
                    PendingStudentsforRotation := PendingStudentsforRotation - 1;
                    InsertRotationLine(StudentMasterCS, InsertedStudents);
                end;
            until (StudentMasterCS.Next() = 0) OR (PendingStudentsforRotation = 0);
            WindowDialog.Close();
        end;
    end;


    /// <summary> 
    /// Description for GetStudentsInternational.
    /// </summary>
    procedure GetStudentsInternational()
    var
        EducationSetup: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        RosterSchedulingLine: Record "Roster Scheduling Line";
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        Text001Lbl: Label 'Total Students      ############1################\';
        Text002Lbl: Label 'Processed Students      ############2################\';
        WindowDialog: Dialog;
        T: Integer;
        C: Integer;
        PendingStudentsforRotation: Integer;
        InsertedStudents: Integer;
        ValidStudent: Boolean;
    begin
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;

        TestField("Academic Year");
        TestField("Course Code");
        TestField("Course Type");
        TestField("Hospital ID");
        TestField("Start Date");
        TestField("End Date");

        UserSetup.Reset();
        if UserSetup.Get(UserId) then
            UserSetup.TestField("Global Dimension 1 Code");

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Clerkship Semester Filter");

        InsertedStudents := 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        InsertedStudents := RosterSchedulingLine.Count();
        PendingStudentsforRotation := ("No. of Seats" + "Maximum Waitlist Students") - InsertedStudents;

        WindowDialog.Open('Inserting GHT Students..\' + Text001Lbl + Text002Lbl);
        StudentMasterCS.Reset();
        StudentMasterCS.SetCurrentKey(Semester, "Last Name");
        StudentMasterCS.SetRange("Global Dimension 1 Code", '9000');
        StudentMasterCS.SetFilter(Citizenship, '<>%1', StudentMasterCS.Citizenship::"US Citizen");
        StudentMasterCS.SetFilter(Semester, EducationSetup."Clerkship Semester Filter");
        StudentMasterCS.SetAscending(Semester, false);//CSPL-00307-RTP
        if StudentMasterCS.Find('-') then begin
            T := StudentMasterCS.Count;
            C := 0;

            repeat
                C += 1;
                WindowDialog.Update(1, T);
                WindowDialog.Update(2, C);
                ValidStudent := false;

                ValidStudent := CheckValidStudentForRotation(StudentMasterCS);


                if ValidStudent then begin
                    InsertedStudents := InsertedStudents + 1;
                    PendingStudentsforRotation := PendingStudentsforRotation - 1;
                    InsertRotationLine(StudentMasterCS, InsertedStudents);
                end;
            until (StudentMasterCS.Next() = 0) OR (PendingStudentsforRotation = 0);
            WindowDialog.Close();
        end;
    end;

    /// <summary> 
    /// Description for InsertRotationLine.
    /// </summary>
    /// <param name="StudentMasterCS">Parameter of type Record "Student Master-CS".</param>
    /// <param name="InsertedStudents">Parameter of type Integer, AvailableNoofSeats.</param>
    procedure InsertRotationLine(StudentMasterCS: Record "Student Master-CS"; InsertedStudents: Integer)
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        SM: Record "Subject Master-CS";
        StudentSubjectExam: Record "Student Subject Exam";
    begin
        SM.Reset();
        SM.SetRange(Code, "Course Code");
        if SM.FindFirst() then;

        RosterSchedulingLine.Init();
        RosterSchedulingLine."Rotation ID" := "Rotation ID";
        RosterSchedulingLine."Clerkship Type" := "Clerkship Type";
        RosterSchedulingLine."Academic Year" := "Academic Year";
        RosterSchedulingLine.Validate("Student No.", StudentMasterCS."No.");
        RosterSchedulingLine."Course Code" := "Course Code";
        RosterSchedulingLine."Course Description" := "Course Description";
        RosterSchedulingLine."Course Prefix Code" := SM."Subject Prefix";
        RosterSchedulingLine."Course Prefix Description" := SM."Subject Prefix";
        RosterSchedulingLine."Course Type" := "Course Type";
        RosterSchedulingLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
        RosterSchedulingLine."Global Dimension 2 Code" := "Global Dimension 2 Code";
        RosterSchedulingLine."Start Date" := "Start Date";
        RosterSchedulingLine."End Date" := "End Date";
        RosterSchedulingLine."No. of Weeks" := "No. of Weeks";
        RosterSchedulingLine.Validate("Hospital ID", "Hospital ID");
        RosterSchedulingLine."Coordinator ID" := StudentMasterCS."Clinical Coordinator";
        RosterSchedulingLine."Document Specialist ID" := StudentMasterCS."Document Specialist";
        RosterSchedulingLine."Student Status" := RosterSchedulingLine."Student Status"::" ";
        RosterSchedulingLine.Status := Status;

        if InsertedStudents > "No. of Seats" then begin
            RosterSchedulingLine.Status := RosterSchedulingLine.Status::Unconfirmed;
            RosterSchedulingLine.Waitlisted := true;
        end;
        //CSPL-00307-RTP
        StudentSubjectExam.Reset();
        StudentSubjectExam.SetRange("Student No.", RosterSchedulingLine."Student No.");
        StudentSubjectExam.SetRange(Published, false);
        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
        StudentSubjectExam.SetRange("Exam Sequence", 2);
        StudentSubjectExam.SetRange(Grade, 'F');
        IF StudentSubjectExam.FindFirst() then begin
            RosterSchedulingLine.Status := RosterSchedulingLine.Status::Unconfirmed;
            RosterSchedulingLine.Waitlisted := true;
        end else begin
            StudentSubjectExam.Reset();
            StudentSubjectExam.SetRange("Student No.", RosterSchedulingLine."Student No.");
            StudentSubjectExam.SetRange(Published, false);
            StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
            StudentSubjectExam.SetRange("Exam Sequence", 1);
            StudentSubjectExam.SetRange(Grade, 'F');
            IF StudentSubjectExam.FindFirst() then begin
                RosterSchedulingLine.CCSSE1stFail := true;
            end;
        end;
        //CSPL-00307-RTP
        if RosterSchedulingLine.Insert(true) then;
    end;

    /// <summary> 
    /// Description for CheckValidStudentForRotation.
    /// </summary>
    /// <param name="StudentMasterCS">Parameter of type Record "Student Master-CS".</param>
    /// <returns>Return variable "StudentValidity" of type Boolean.</returns>
    procedure CheckValidStudentForRotation(StudentMasterCS: Record "Student Master-CS") StudentValidity: Boolean;
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        StudentStatus: Record "Student Status";
        SubjectMaster: Record "Subject Master-CS";
        LeaveofAbsence: Record "Student Leave of Absence";
        ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
        LOAStart: Date;
        LOAEnd: date;
        SubjectGroupCode: Code[20];
        Subjects: Code[2048];
        TextNoofWeeks: Text[20];
        RotationWeeks: Integer;
        ScheduledWeek: Integer;
    begin
        StudentValidity := true;

        StudentStatus.Reset();
        if StudentStatus.Get(StudentMasterCS.Status, StudentMasterCS."Global Dimension 1 Code") then;

        if not (StudentStatus.Status in
        [StudentStatus.Status::Active,
        StudentStatus.Status::CLOA,
        StudentStatus.Status::PROBATION,
        StudentStatus.Status::"Re-Admitted",
        StudentStatus.Status::"Re-Entry",
        StudentStatus.Status::Suspension,
        StudentStatus.Status::TWD]) then
            StudentValidity := false;

        // RosterSchedulingLine.Reset();
        // RosterSchedulingLine.SetCurrentKey("Student No.", "Academic Year", "Course Code", "Course Type");
        // RosterSchedulingLine.SetRange("Student No.", StudentMasterCS."No.");
        // RosterSchedulingLine.SetRange("Academic Year", "Academic Year");
        // RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type"::Core);
        // RosterSchedulingLine.SetRange("Course Code", "Course Code");
        // RosterSchedulingLine.SetRange("Course Type", "Course Type");
        // RosterSchedulingLine.SetFilter(Status, '%1|%2|%3|%4|%5',
        // RosterSchedulingLine.Status::Scheduled,
        // RosterSchedulingLine.Status::Published,
        // RosterSchedulingLine.Status::Unconfirmed,
        // RosterSchedulingLine.Status::"In-Review",
        // RosterSchedulingLine.Status::Completed);
        // if RosterSchedulingLine.FindFirst() then
        //     StudentValidity := false;

        IF (StudentMasterCS."No." <> '') and ("Start Date" <> 0D) then
            if ClinicalBaseAppSubscribe.CheckCLOAExistance(StudentMasterCS."No.", "Start Date", "End Date", LOAStart, LOAEnd) = true then
                StudentValidity := false;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.", "Academic Year", "Course Code", "Course Type");
        RosterSchedulingLine.SetRange("Student No.", StudentMasterCS."No.");
        if RosterSchedulingLine.FindSet() then
            repeat
                if ("Start Date" >= RosterSchedulingLine."Start Date") and ("Start Date" <= RosterSchedulingLine."End Date") then
                    StudentValidity := false;
            until RosterSchedulingLine.Next() = 0;

        SubjectGroupCode := '';
        Subjects := '';
        SubjectMaster.Reset();
        SubjectMaster.SetRange(Code, "Course Code");
        if SubjectMaster.FindFirst() then
            SubjectGroupCode := SubjectMaster."Subject Group";

        SubjectMaster.Reset();
        SubjectMaster.SetRange(Code, SubjectGroupCode);
        if SubjectMaster.FindFirst() then begin
            TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
            Evaluate(RotationWeeks, TextNoofWeeks);
        end;

        SubjectMaster.Reset();
        SubjectMaster.SetRange("Subject Group", SubjectGroupCode);
        if SubjectMaster.FindSet() then
            repeat
                if Subjects = '' then
                    Subjects := SubjectMaster.Code
                else
                    Subjects := Subjects + '|' + SubjectMaster.Code;
            until SubjectMaster.Next() = 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.", "Academic Year", "Course Code", "Course Type");
        RosterSchedulingLine.SetRange("Student No.", StudentMasterCS."No.");
        RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type"::Core);
        RosterSchedulingLine.SetFilter("Course Code", Subjects);
        RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Cancelled);
        RosterSchedulingLine.CalcSums("No. of Weeks");
        ScheduledWeek := RosterSchedulingLine."No. of Weeks";
        if ScheduledWeek >= RotationWeeks then
            StudentValidity := false;

        LeaveofAbsence.Reset();
        LeaveofAbsence.SetCurrentKey("Student No.");
        LeaveofAbsence.SetRange("Student No.", StudentMasterCS."No.");
        if LeaveofAbsence.FindSet() then
            repeat
                if ("Start Date" >= LeaveofAbsence."Start Date") and ("Start Date" <= LeaveofAbsence."End Date") then
                    StudentValidity := false;
            until LeaveofAbsence.Next() = 0;
        /*TO_DO
        StudentClinicalDcouments.Reset();
        StudentClinicalDcouments.SetRange("Student No.", StudentMasterCS."No.");
        StudentClinicalDcouments.SetRange("Documents Status", StudentClinicalDcouments."Documents Status"::"Verification Completed");
        if StudentClinicalDcouments.Find('-') then
            StudentValidity := false; */

        exit(StudentValidity);
    end;

    /// <summary> 
    /// Description for LineExistError.
    /// </summary>
    local procedure LineExistError()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", "Rotation ID");
        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
        if RosterSchedulingLine.Count > 0 then
            Error('%1 Published Lines Exist.\Please Check.', RosterSchedulingLine.Count);
    end;

    // var
    // TempRosterSchedulingLine: Record "Roster Scheduling Line" temporary;

    procedure OverLapingRotation(Var RSL: Record "Roster Scheduling Line")
    var
        RSL2: Record "Roster Scheduling Line";
    begin
        //CSPL-00307 03-10-2022 as per Ajay
        IF (RSL."Start Date" <> 0D) AND (RSL."End Date" <> 0D) then begin
            RSL2.Reset();
            RSL2.SetRange("Student No.", RSL."Student No.");
            RSL2.SetFilter("Start Date", '<=%1', RSL."Start Date");
            RSL2.SetFilter("End Date", '>=%1', RSL."End Date");
            RSL2.SetFilter(Status, '<>%1', RSL2.Status::Cancelled);
            IF RSL2.FindFirst() then begin
                Error('Student %1 already exist in Rotation %2 Date Range %3 To %4', RSL2."Student No.", RSL2."Rotation ID", RSL2."Start Date", RSL2."End Date");
            end;
        end;
    end;

}