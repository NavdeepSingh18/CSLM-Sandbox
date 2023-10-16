table 50350 "Non-Affiliated Hospital"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Non-Affiliated Rotation Appl";
    LookupPageId = "Non-Affiliated Rotation Appl";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                NoSeriesManagement.TestManual(GetNoSeriesCode());
                "No. Series" := '';
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(8; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = CustomerContent;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
            DataClassification = CustomerContent;
        }
        field(11; "Title"; Option)
        {
            Caption = 'Title';
            OptionMembers = " ","Mr.","Mrs.","Miss","Ms.","Dr.","Prof.";
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            // TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            // ELSE
            // IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            // trigger OnLookup()
            // var
            //     PostCode: Record "Post Code";
            // begin
            //     PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            // end;

            // trigger OnValidate()
            // var
            //     PostCode: Record "Post Code";
            // begin
            //     PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            // end;
        }
        field(92; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(93; "Program ID"; Text[50])
        {
            Caption = 'Program ID';
        }

        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(104; "Contact Title"; Option)
        {
            Caption = 'Title';
            OptionMembers = " ","Mr.","Mrs.","Miss","Ms.","Dr.","Prof.";
        }
        field(105; "Contact Phone No."; Text[30])
        {
            Caption = 'Contact Phone No.';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(106; "Contact E-Mail"; Text[80])
        {
            Caption = 'Contact Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Contact E-Mail");
            end;
        }

        field(50003; "ACGME No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ACGME #';
        }
        field(50004; "Residency"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Residency';
        }
        field(50005; "System Ref. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'System Ref. No.';
        }
        field(50011; Accreditation; Option)
        {
            OptionMembers = " ",ACGME,AOA,"None";
            DataClassification = CustomerContent;
        }
        field(50012; "Sponsoring Institution"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Sponsored Programs"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50014; "DME Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50015; "DME Phone No."; Text[20])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(50016; "DME Email"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("DME Email");
            end;
        }
        field(50017; "Supervising Physician Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Superviser Phone No."; Text[20])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(50019; "Superviser Email"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Superviser Email");
            end;
        }
        field(50079; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Pending for Approval",Approved,Rejected,"In-Review";
            Editable = false;

            trigger OnValidate()
            begin
                "Status By" := '';
                "Status On" := 0D;

                if Status <> Status::" " then begin
                    "Status By" := UserId;
                    "Status On" := Today;
                end;
            end;
        }
        field(50080; "Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50081; "Status On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50082; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                "Confirmed On" := 0D;
                "Confirmed By" := '';

                if Confirmed then begin
                    "Confirmed On" := Today;
                    "Confirmed By" := UserId;
                    Validate(Status, Status::" ");
                end;
            end;
        }
        field(50083; "Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50084; "Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50085; "Reject Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter("Non Affiliated Application Rejection"));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Reject Reason" := '';
                if ReasonCode.Get("Reject Reason Code") then
                    "Reject Reason" := ReasonCode.Description;
            end;
        }
        field(25; "Reject Reason"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason';
        }
        field(50088; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No." where(Semester = field("Clerkship Semester Filter"));
            trigger OnValidate()
            var
                StudentMasterCS: Record "Student Master-CS";
                CompanyInformation: Record "Company Information";
            begin
                CompanyInformation.Reset();
                if CompanyInformation.Get() then;

                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                "Student Name" := '';
                "Enrollment No." := '';
                "Clinical Cordinator ID" := '';
                Semester := '';
                "Academic Year" := '';
                StudentMasterCS.Reset();
                if StudentMasterCS.Get("Student No.") then begin
                    "First Name" := StudentMasterCS."First Name";
                    "Middle Name" := StudentMasterCS."Middle Name";
                    "Last Name" := StudentMasterCS."Last Name";
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Clinical Cordinator ID" := StudentMasterCS."Clinical Coordinator";
                    Semester := StudentMasterCS.Semester;
                    "Academic Year" := StudentMasterCS."Academic Year";
                end;
            end;
        }
        field(50089; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(50090; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(50091; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(50092; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(50093; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(50094; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(50095; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(50096; "Clinical Cordinator ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Cordinator ID';
            TableRelation = "User Setup"."User ID";
        }

        field(50110; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = "Subject Master-CS".Code where("Type of Subject" = filter(Core), "Level Description" = filter("Level 2 Clinical Rotation"));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Course Description" := '';

                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.findfirst() then begin
                    SubjectMaster.TestField(Duration);
                    "Course Description" := SubjectMaster.Description;
                end;
            end;
        }
        field(50111; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(50112; "Course Prefix"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix';
            TableRelation = "Subject Prefix".Code;
            trigger OnValidate()
            begin
                Validate("Elective Course Code");
            end;
        }

        field(50113; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
            // TableRelation = IF ("Course Code" = filter('')) "Subject Master-CS".Code where("Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"))
            // else
            // "Subject Master-CS".Code where("Core Rotation Group" = field("Course Code"), "Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"));
            TableRelation = "Subject Master-CS".Code where("Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                "Rotation Description" := '';
                "Course Description" := '';
                NoOfWeeks := 0;
                Validate("No. of Weeks", NoOfWeeks);
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Elective Course Code");
                if SubjectMaster.FindFirst() then begin
                    "Course Description" := SubjectMaster.Description;
                    if "Course Prefix" <> '' then
                        "Rotation Description" := "Course Prefix" + ' - ' + SubjectMaster.Description
                    else
                        "Rotation Description" := SubjectMaster.Description;

                    TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
                    Evaluate(NoOfWeeks, TextNoofWeeks);
                    Validate("No. of Weeks", NoOfWeeks);
                end;
            end;
        }
        field(50114; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            Editable = false;
        }

        field(50120; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            trigger OnValidate()
            var
                Date_1: Record Date;
            begin
                "End Date" := 0D;
                if "Start Date" <> 0D then begin
                    if "Start Date" < WorkDate() then
                        Error('Start Date of a rotation cannot be less than %1.', WorkDate());

                    Date_1.Reset();
                    Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                    Date_1.SetRange("Period Start", "Start Date");
                    if Date_1.FindFirst() then;

                    if Date_1."Period Name" <> 'Monday' then
                        Error('Rotation Start Date must be Monday.');
                    Validate("No. of Weeks");
                end;
            end;
        }
        field(50121; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(50122; "No. of Weeks"; Integer)
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
        field(50130; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50131; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50132; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation ID';
        }
        field(50133; "Rotation Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Status';
            OptionMembers = " ","Scheduled","Published";
        }
        field(60000; "Clerkship Semester Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(Sorting; Status)
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application No.", Name, City, "Phone No.", Contact)
        {
        }
    }

    var
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        NoSeriesManagement.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "Application No.", "No. Series");
        "Application Date" := Today;
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

    /// <summary> 
    /// Description for GetNoSeriesCode.
    /// </summary>
    local procedure GetNoSeriesCode() SeriesCode: Code[20];
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        if EducationSetupCS.Find('-') then
            EducationSetupCS.TestField("Non-Affiliated Appl. Nos.");

        SeriesCode := EducationSetupCS."Non-Affiliated Appl. Nos.";
        exit(SeriesCode);
    end;

    /// <summary> 
    /// Description for CreateRotation.
    /// </summary>
    /// <param name="NonAffiliatedHospital">Parameter of type Record "Non-Affiliated Hospital".</param>
    procedure CreateRotation(NonAffiliatedHospital: Record "Non-Affiliated Hospital")
    var
        RosterSchedulingHeader: Record "Roster Scheduling Header";
        RosterSchedulingHeader_1: Record "Roster Scheduling Header";
        RosterSchedulingLine: Record "Roster Scheduling Line";
        StudentMasterCS: Record "Student Master-CS";
        SubjectMaster: Record "Subject Master-CS";
    begin
        RosterSchedulingHeader_1.Reset();
        RosterSchedulingHeader_1.SetRange("Clerkship Type", RosterSchedulingHeader."Clerkship Type"::Elective);
        RosterSchedulingHeader_1.SetRange("Elective Course Code", "Elective Course Code");
        RosterSchedulingHeader_1.SetRange("Course Prefix", "Course Prefix");
        RosterSchedulingHeader_1.SetRange("Hospital ID", "System Ref. No.");
        RosterSchedulingHeader_1.SetRange("Start Date", "Start Date");
        if not RosterSchedulingHeader_1.FindLast() then begin
            RosterSchedulingHeader.Init();
            RosterSchedulingHeader."Global Dimension 1 Code" := NonAffiliatedHospital."Global Dimension 1 Code";
            RosterSchedulingHeader."Rotation ID" := '';
            RosterSchedulingHeader."Clerkship Type" := RosterSchedulingHeader."Clerkship Type"::Elective;
            RosterSchedulingHeader."Course Type" := RosterSchedulingHeader."Course Type"::Elective;
            RosterSchedulingHeader."Entry Type" := RosterSchedulingHeader."Entry Type"::Clerkship;
            RosterSchedulingHeader."Global Dimension 1 Code" := NonAffiliatedHospital."Global Dimension 1 Code";
            RosterSchedulingHeader.Insert(true);

            RosterSchedulingHeader.Validate("Course Code", NonAffiliatedHospital."Elective Course Code");
            RosterSchedulingHeader."Elective Course Code" := NonAffiliatedHospital."Elective Course Code";
            RosterSchedulingHeader."Rotation Description" := NonAffiliatedHospital."Rotation Description";
            RosterSchedulingHeader."Academic Year" := NonAffiliatedHospital."Academic Year";
            RosterSchedulingHeader."Non-Affiliated Application No." := NonAffiliatedHospital."Application No.";
            RosterSchedulingHeader.Validate("Hospital ID", NonAffiliatedHospital."System Ref. No.");
            RosterSchedulingHeader.Validate("Maximum Waitlist Students", 0);
            RosterSchedulingHeader.Semester := NonAffiliatedHospital.Semester;
            RosterSchedulingHeader."Start Date" := NonAffiliatedHospital."Start Date";
            RosterSchedulingHeader."No. of Weeks" := NonAffiliatedHospital."No. of Weeks";
            RosterSchedulingHeader."End Date" := NonAffiliatedHospital."End Date";
            RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Scheduled;
            RosterSchedulingHeader.Validate("Rotation Confirmed", true);
            RosterSchedulingHeader."Non-Affiliated Application No." := NonAffiliatedHospital."Application No.";

            RosterSchedulingHeader.Modify(true);
        end
        else begin
            RosterSchedulingHeader.Reset();
            if RosterSchedulingHeader.Get(RosterSchedulingHeader_1."Rotation ID") then;
        end;

        StudentMasterCS.Reset();
        if StudentMasterCS.Get(NonAffiliatedHospital."Student No.") then;

        RosterSchedulingLine.Init();
        RosterSchedulingLine."Rotation ID" := RosterSchedulingHeader."Rotation ID";
        RosterSchedulingLine."Non-Affiliated Application No." := NonAffiliatedHospital."Application No.";
        RosterSchedulingLine.Validate("Student No.", NonAffiliatedHospital."Student No.");
        RosterSchedulingLine.Validate("Academic Year", NonAffiliatedHospital."Academic Year");
        RosterSchedulingLine.Insert(true);

        RosterSchedulingLine."Course Code" := NonAffiliatedHospital."Elective Course Code";
        RosterSchedulingLine."Course Description" := NonAffiliatedHospital."Course Description";
        RosterSchedulingLine."Elective Course Code" := NonAffiliatedHospital."Elective Course Code";
        RosterSchedulingLine."Rotation Description" := NonAffiliatedHospital."Rotation Description";
        if RosterSchedulingLine."Course Description" = '' then begin
            SubjectMaster.Reset();
            SubjectMaster.SetRange(Code, "Course Code");
            if SubjectMaster.findfirst() then
                RosterSchedulingLine."Course Description" := SubjectMaster.Description;
        end;
        RosterSchedulingLine."Course Type" := RosterSchedulingLine."Course Type"::Elective;
        RosterSchedulingLine."Global Dimension 1 Code" := NonAffiliatedHospital."Global Dimension 1 Code";
        RosterSchedulingLine."Global Dimension 2 Code" := NonAffiliatedHospital."Global Dimension 2 Code";
        RosterSchedulingLine."Start Date" := NonAffiliatedHospital."Start Date";
        RosterSchedulingLine."End Date" := NonAffiliatedHospital."End Date";
        RosterSchedulingLine."No. of Weeks" := NonAffiliatedHospital."No. of Weeks";
        RosterSchedulingLine."Non-Affiliated Application No." := NonAffiliatedHospital."Application No.";
        RosterSchedulingLine.Validate("Hospital ID", NonAffiliatedHospital."System Ref. No.");
        RosterSchedulingLine."Coordinator ID" := StudentMasterCS."Clinical Coordinator";
        RosterSchedulingLine."Document Specialist ID" := StudentMasterCS."Document Specialist";
        RosterSchedulingLine."Student Status" := RosterSchedulingLine."Student Status"::" ";
        RosterSchedulingLine.Status := RosterSchedulingHeader.Status;
        RosterSchedulingLine.Validate("Rotation Confirmed", true);
        RosterSchedulingLine."Non-Affiliated Application No." := NonAffiliatedHospital."Application No.";
        RosterSchedulingLine.Modify(true);

        NonAffiliatedHospital."Rotation ID" := RosterSchedulingHeader."Rotation ID";
        NonAffiliatedHospital."Rotation Status" := NonAffiliatedHospital."Rotation Status"::Scheduled;
        NonAffiliatedHospital.Modify();
    end;
}