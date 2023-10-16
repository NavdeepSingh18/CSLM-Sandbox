table 50348 "ClerkshipSiteAndDateSelection"
{
    DataClassification = CustomerContent;
    Caption = 'Clerkship Preferred Site and Date Selection';
    DataCaptionFields = "Application No.", "Student Name", "Enrollment No.";
    // LookupPageId = "Clerkship Site And Date LST";
    // DrillDownPageId = "Clerkship Site And Date LST";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                EducationSetupCS: Record "Education Setup-CS";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                EducationSetupCS.Reset();
                EducationSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                if EducationSetupCS.FindFirst() then
                    EducationSetupCS.TestField("FM1/IM1 Application Nos.");

                NoSeriesMgt.TestManual(EducationSetupCS."FM1/IM1 Application Nos.");
            end;
        }
        field(2; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';

            TableRelation = "Student Master-CS"."No." where(Semester = field("Clerkship Semester Filter"));

            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                CourseMaster: Record "Course Master-CS";
                ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                CompanyInformation: Record "Company Information";
            begin
                IF "Student No." <> '' then begin
                    ClerkshipSiteAndDateSelection.Reset();
                    ClerkshipSiteAndDateSelection.SetRange("Student No.", "Student No.");
                    ClerkshipSiteAndDateSelection.SetFilter("Application No.", '<>%1', "Application No.");
                    ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1', ClerkshipSiteAndDateSelection.Status::Reject);
                    if ClerkshipSiteAndDateSelection.FindFirst() then
                        IF not Confirm('Student No. %1 (%2) has already already submitted the Site Selection Form..\\Please check Entry No. %3. \\Do You Still Want to Continue ?', False, "Student No.", "Student Name", ClerkshipSiteAndDateSelection."Application No.") then begin
                            "Student No." := '';
                            exit;
                        end;
                end;
                CompanyInformation.Reset();
                if CompanyInformation.Get() then;
                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                "Student Name" := '';
                "Enrollment No." := '';
                "FM1/IM1 Coordinator" := '';
                "Student Type" := "Student Type"::"General Student";
                InitializeOnStudentValidate();
                StudentMaster.Reset();
                if StudentMaster.Get("Student No.") then begin
                    StudentMaster.TestField("FM1/IM1 Coordinator");
                    StudentMaster.TestField("Course Code");


                    CourseMaster.Reset();
                    if CourseMaster.Get(StudentMaster."Course Code") then;

                    "First Name" := StudentMaster."First Name";
                    "Middle Name" := StudentMaster."Middle Name";
                    "Last Name" := StudentMaster."Last Name";
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    "FM1/IM1 Coordinator" := StudentMaster."FM1/IM1 Coordinator";

                    if StudentMaster.Citizenship <> StudentMaster.Citizenship::"US Citizen" then
                        "Student Type" := "Student Type"::"International Student";

                    if CourseMaster."Course Category" = CourseMaster."Course Category"::GHT then
                        "Student Type" := "Student Type"::"GHT Student";
                end;

                IF "Student No." <> '' then begin
                    // ClerkshipSiteAndDateSelection.Reset();
                    // ClerkshipSiteAndDateSelection.SetRange("Student No.", "Student No.");
                    // ClerkshipSiteAndDateSelection.SetFilter("Application No.", '<>%1', "Application No.");
                    // if ClerkshipSiteAndDateSelection.FindFirst() then
                    //     Error('Student No. %1 (%2) has already already submitted the Site Selection Form..\\Please check Entry No. %3.', "Student No.", "Student Name", ClerkshipSiteAndDateSelection."Application No.");

                    AutoUpdateSiteGHTStudent();
                end;
            end;
        }
        field(6; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(7; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(8; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(9; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(10; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(11; "FM1/IM1 Coordinator"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Coordinator';
            Editable = false;
        }


        field(17; "Preset Start Date ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preset Start Date ID';

            trigger OnLookup()
            var
                FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
            begin
                FM1IM1DatePresetEntry.Reset();
                FM1IM1DatePresetEntry.SetRange(Status, FM1IM1DatePresetEntry.Status::Confirmed);
                FM1IM1DatePresetEntry.SetFilter("Start Date", '>=%1', WorkDate());
                FM1IM1DatePresetEntry.SetFilter("Global Dimension 1 Code", "Global Dimension 1 Code");
                if FM1IM1DatePresetEntry.FindSet() then
                    repeat
                        if FM1IM1DatePresetEntry."Start Date" - 31 > WorkDate() then
                            FM1IM1DatePresetEntry.Mark(true);
                    until FM1IM1DatePresetEntry.Next() = 0;

                FM1IM1DatePresetEntry.MarkedOnly(true);

                IF Page.RUNMODAL(Page::"FM1_IM1 Date Preset List", FM1IM1DatePresetEntry) = ACTION::LookupOK THEN
                    Validate("Preset Start Date ID", FM1IM1DatePresetEntry."Preset No.");
            end;

            trigger OnValidate()
            var
                FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
            begin
                "Preferred Start Date" := 0D;
                "No. of Weeks" := 0;
                "End Date" := 0D;
                "Document Due Date" := 0D;
                FM1IM1DatePresetEntry.Reset();
                if FM1IM1DatePresetEntry.Get("Preset Start Date ID") then begin
                    "Document Due Date" := FM1IM1DatePresetEntry."Document Due Date";
                    Validate("Preferred Start Date", FM1IM1DatePresetEntry."Start Date");
                    "No. of Weeks" := FM1IM1DatePresetEntry."No. of Weeks";
                    "End Date" := FM1IM1DatePresetEntry."End Date";
                end;
            end;
        }

        field(18; "Preferred Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Preferred Start Date';
            Editable = false;

            trigger OnValidate()
            var
                PeriodLength: DateFormula;
            begin
                "Approx. Scheduling Date" := 0D;
                "Approx. Publishing Date" := 0D;

                if "Preferred Start Date" <> 0D then begin
                    Evaluate(PeriodLength, '-6W');
                    "Approx. Scheduling Date" := CalcDate(PeriodLength, "Preferred Start Date");
                    Evaluate(PeriodLength, '-4W');
                    "Approx. Publishing Date" := CalcDate(PeriodLength, "Preferred Start Date");
                end;
            end;
        }

        field(19; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            Editable = false;
        }
        field(20; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }
        field(21; "Document Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Due Date';
            Editable = false;
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }

        field(23; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(24; "Approx. Scheduling Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approx. Scheduling Date';
        }
        field(25; "Approx. Publishing Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approx. Publishing Date';
        }
        field(30; "First Preferred Site Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'First Preferred Site Type';
            OptionMembers = "Affilated Hospital","Non-Affilated Hospital";

            trigger OnValidate()
            begin
                Validate("First Preferred Site ID", '');
            end;
        }
        field(31; "First Preferred Site ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'First Preferred Site ID';

            TableRelation = IF ("Student Type" = FILTER("International Student")) Vendor."No." WHERE("Preffered for International" = const(true), "Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "))
            ELSE
            IF ("Student Type" = FILTER("GHT Student")) Vendor."No." WHERE("Preffered for GHT Students" = const(true), "Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "))
            ELSE
            IF ("Student Type" = FILTER("General Student")) Vendor."No." where("Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "));

            trigger OnValidate()
            var
                Vendor: Record Vendor;
                NonAffiliatedHospital: Record "Non-Affiliated Hospital";
            begin
                if ("First Preferred Site ID" <> '') then begin
                    if ("First Preferred Site ID" = "Second Preferred Site ID") then
                        Error('%1 has already selected in Second Preferred Site ID.', "First Preferred Site ID");
                    if ("First Preferred Site ID" = "Third Preferred Site ID") then
                        Error('%1 has already selected in Third Preferred Site ID.', "First Preferred Site ID");
                end;

                "First Preferred Site Name" := '';

                if "First Preferred Site Type" = "First Preferred Site Type"::"Affilated Hospital" then begin
                    Vendor.Reset();
                    if Vendor.Get("First Preferred Site ID") then
                        "First Preferred Site Name" := Vendor.Name;
                end
                else
                    if "First Preferred Site Type" = "First Preferred Site Type"::"Non-Affilated Hospital" then begin
                        NonAffiliatedHospital.Reset();
                        if NonAffiliatedHospital.Get("First Preferred Site ID") then
                            "First Preferred Site Name" := NonAffiliatedHospital.Name;
                    end;
            end;
        }
        field(32; "First Preferred Site Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'First Preferred Site Name';
            Editable = false;
        }
        field(33; "Second Preferred Site Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Preferred Site Type';
            OptionMembers = "Affilated Hospital","Non-Affilated Hospital";

            trigger OnValidate()
            begin
                Validate("Second Preferred Site ID", '');
            end;
        }
        field(34; "Second Preferred Site ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Preferred Site ID';
            TableRelation = IF ("Student Type" = FILTER("International Student")) Vendor."No." WHERE("Preffered for International" = const(true), "Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "))
            ELSE
            IF ("Student Type" = FILTER("GHT Student" | "General Student")) Vendor."No." where("Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "));

            trigger OnValidate()
            var
                Vendor: Record Vendor;
                NonAffiliatedHospital: Record "Non-Affiliated Hospital";
            begin
                if "Second Preferred Site ID" <> '' then begin
                    if ("Second Preferred Site ID" = "First Preferred Site ID") then
                        Error('%1 has already selected in First Preferred Site ID.', "Second Preferred Site ID");
                    if ("Second Preferred Site ID" = "Third Preferred Site ID") then
                        Error('%1 has already selected in Third Preferred Site ID.', "Second Preferred Site ID");
                end;

                "Second Preferred Site Name" := '';

                if "Second Preferred Site Type" = "Second Preferred Site Type"::"Affilated Hospital" then begin
                    Vendor.Reset();
                    if Vendor.Get("Second Preferred Site ID") then
                        "Second Preferred Site Name" := Vendor.Name;
                end
                else
                    if "Second Preferred Site Type" = "Second Preferred Site Type"::"Non-Affilated Hospital" then begin
                        NonAffiliatedHospital.Reset();
                        if NonAffiliatedHospital.Get("Second Preferred Site ID") then
                            "Second Preferred Site Name" := NonAffiliatedHospital.Name;
                    end;
            end;
        }
        field(35; "Second Preferred Site Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Preferred Site Name';
            Editable = false;
        }
        field(36; "Third Preferred Site Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Third Preferred Site Type';
            OptionMembers = "Affilated Hospital","Non-Affilated Hospital";

            trigger OnValidate()
            begin
                Validate("Third Preferred Site ID", '');
            end;
        }
        field(37; "Third Preferred Site ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Third Preferred Site ID';
            TableRelation = IF ("Student Type" = FILTER("International Student")) Vendor."No." WHERE("Preffered for International" = const(true), "Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "))
            ELSE
            IF ("Student Type" = FILTER("GHT Student" | "General Student")) Vendor."No." where("Vendor Sub Type" = filter(Hospital), "FM1/IM1 Rotation Applicable" = const(true), Blocked = filter(" "));

            trigger OnValidate()
            var
                Vendor: Record Vendor;
                NonAffiliatedHospital: Record "Non-Affiliated Hospital";
            begin
                if ("Third Preferred Site ID" <> '') then begin
                    if ("Third Preferred Site ID" = "First Preferred Site ID") then
                        Error('%1 has already selected in First Preferred Site ID.', "Third Preferred Site ID");
                    if ("Third Preferred Site ID" = "Second Preferred Site ID") then
                        Error('%1 has already selected in Second Preferred Site ID.', "Third Preferred Site ID");
                end;

                "Third Preferred Site Name" := '';

                if "Third Preferred Site Type" = "Third Preferred Site Type"::"Affilated Hospital" then begin
                    Vendor.Reset();
                    if Vendor.Get("Third Preferred Site ID") then
                        "Third Preferred Site Name" := Vendor.Name;
                end
                else
                    if "Third Preferred Site Type" = "Third Preferred Site Type"::"Non-Affilated Hospital" then begin
                        NonAffiliatedHospital.Reset();
                        if NonAffiliatedHospital.Get("Third Preferred Site ID") then
                            "Third Preferred Site Name" := NonAffiliatedHospital.Name;
                    end;
            end;
        }
        field(38; "Third Preferred Site Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Third Preferred Site Name';
            Editable = false;
        }

        field(39; "Student Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Type';
            OptionMembers = "General Student","GHT Student","International Student";
        }

        field(40; "Special Accommodation Required"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Special Accommodation Required';
        }

        field(45; "Comments"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        field(46; "Reject Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter("FM1/IM1 Application Rejection"));
            Caption = 'Reject Reason Code';
            trigger OnValidate()
            var
                ReasonCodes: Record "Reason Code";
            begin
                "Reject Reason Description" := '';
                ReasonCodes.Reset();
                if ReasonCodes.Get("Reject Reason Code") then
                    "Reject Reason Description" := ReasonCodes.Description;
            end;
        }
        field(47; "Reject Reason Description"; Code[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason Description';
        }
        field(50; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed';
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
        field(51; "Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed On';
            Editable = false;
        }
        field(53; "Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed By';
            Editable = false;
        }
        field(54; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Pending for Approval",Approved,Scheduled,Published,Reject,Completed;
            Editable = false;
            Caption = 'Status';

            trigger OnValidate()
            begin
                "Status By" := '';
                "Status On" := 0D;

                if Status = Status::Approved then begin
                    if CheckDocumentsApproval("Student No.") = true then
                        Error('Clinical Document(s) are not approved for the Student No. - %1 (%2)', "Student No.", "Student Name");

                    CheckSPCLAccommodationApplApproval();
                end;
                if Status <> Status::" " then begin
                    "Status By" := UserId;
                    "Status On" := Today;
                end;

                if Status = Status::Reject then begin
                    Confirmed := false;
                    "Confirmed By" := '';
                    "Confirmed On" := 0D;
                    "First Site Confirmed" := false;
                    "Second Site Confirmed" := false;
                    "Third Site Confirmed" := false;
                    Validate("Confirmed Site ID", '');
                end;
            end;
        }
        field(55; "Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Status By';
        }
        field(56; "Status On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Status On';
        }
        field(57; "Rotation ID"; Text[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Rotation ID';
        }
        field(60; "First Site Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if CheckDocumentsApproval("Student No.") = true then
                    Error('Clinical Document(s) are not approved for the Student No. - %1 (%2)', "Student No.", "Student Name");

                "Second Site Confirmed" := false;
                "Third Site Confirmed" := false;

                "Confirmed Site ID" := '';
                "Confirmed Site Name" := '';
                if "First Preferred Site Type" = "First Preferred Site Type"::"Non-Affilated Hospital" then
                    Error('First Preference Site Type must be Affilated Hospital.\You must Create Affilated Hospital using the Informations of Non-Affilated Hospital Application.');

                if "First Site Confirmed" then
                    Validate("Confirmed Site ID", "First Preferred Site ID");
            end;
        }
        field(61; "Second Site Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if CheckDocumentsApproval("Student No.") = true then
                    Error('Clinical Document(s) are not approved for the Student No. - %1 (%2)', "Student No.", "Student Name");

                "First Site Confirmed" := false;
                "Third Site Confirmed" := false;
                "Confirmed Site ID" := '';
                "Confirmed Site Name" := '';

                if "Second Preferred Site Type" = "Second Preferred Site Type"::"Non-Affilated Hospital" then
                    Error('Second Preference Site Type must be Affilated Hospital.\You must Create Affilated Hospital using the Informations of Non-Affilated Hospital Application.');

                if "Second Site Confirmed" then
                    Validate("Confirmed Site ID", "Second Preferred Site ID");
            end;
        }
        field(63; "Third Site Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if CheckDocumentsApproval("Student No.") = true then
                    Error('Clinical Document(s) are not approved for the Student No. - %1 (%2)', "Student No.", "Student Name");

                "First Site Confirmed" := false;
                "Second Site Confirmed" := false;
                "Confirmed Site ID" := '';
                "Confirmed Site Name" := '';

                if "Third Preferred Site Type" = "Third Preferred Site Type"::"Non-Affilated Hospital" then
                    Error('Third Preference Site Type must be Affilated Hospital.\You must Create Affilated Hospital using the Informations of Non-Affilated Hospital Application.');

                if "Third Site Confirmed" then
                    Validate("Confirmed Site ID", "Third Preferred Site ID");
            end;
        }
        field(64; "Confirmed Site ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed Site ID';
            Editable = false;

            TableRelation = Vendor."No." where("Vendor Sub Type" = filter(Hospital));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Confirmed Site Name" := '';

                Vendor.Reset();
                if Vendor.Get("Confirmed Site ID") then
                    "Confirmed Site Name" := Vendor.Name;
            end;
        }
        field(65; "Confirmed Site Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed Site Name';
            Editable = false;
        }
        field(80; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(500; "Credential Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(501; "Welcome Meeting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(502; "Welcome Meeting Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",IP,Phone,Skype;
        }
        field(503; "Desired Match Year"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(504; "State/Pro hope to practice"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'State/Province hope to practice';
        }
        field(505; "Country in hope to practice"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country in hope to practice';
        }
        field(506; "Link to Contact"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(507; "Link to Contact Disciption"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(508; "Site/Geo Preference"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(509; "Specialty of Interest"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(510; "Mid-Point Meeting Notes"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        // field(511; Blocked; Boolean)
        // {
        //     DataClassification = CustomerContent;
        // }
        field(60000; "Clerkship Semester Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(60001; "Filtering ID"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(StartDateSorting; "Preferred Start Date")
        {
            Clustered = false;
        }
        key(CreationDateSorting; "Creation Date")
        {
            Clustered = false;
        }
    }


    trigger OnInsert()
    var
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        if EducationSetupCS.FindFirst() then begin
            EducationSetupCS.TestField("FM1/IM1 Application Nos.");
            EducationSetupCS.TestField("FM1/IM1 Semester Filter");
        end;

        NoSeriesManagement.InitSeries(EducationSetupCS."FM1/IM1 Application Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
        "Creation Date" := Today;
        "Clerkship Semester Filter" := EducationSetupCS."FM1/IM1 Semester Filter";
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
    /// Description for InitializeOnStudentValidate.
    /// </summary>
    procedure InitializeOnStudentValidate()
    begin
        Validate("Preset Start Date ID", '');
        "First Preferred Site Type" := "First Preferred Site Type"::"Affilated Hospital";
        Validate("First Preferred Site ID", '');
        "Second Preferred Site Type" := "Second Preferred Site Type"::"Affilated Hospital";
        Validate("Second Preferred Site ID", '');
        "Third Preferred Site Type" := "Third Preferred Site Type"::"Affilated Hospital";
        Validate("Third Preferred Site ID", '');
        Validate("Confirmed Site ID", '');
    end;

    procedure CheckSPCLAccommodationApplApproval()
    var
        SpclAccommodationApplication: Record "Spcl Accommodation Application";
    begin
        SpclAccommodationApplication.Reset();
        SpclAccommodationApplication.SetRange("Application No.", "Application No.");
        if SpclAccommodationApplication.FindLast() then
            if SpclAccommodationApplication."Approval Status" IN [SpclAccommodationApplication."Approval Status"::" ", SpclAccommodationApplication."Approval Status"::"Pending for Approval"] then
                Error('Special Accommodation Application No. %1 is still pending for approval.', SpclAccommodationApplication."Application No.");
    end;

    procedure AutoUpdateSiteGHTStudent()
    var
        Vendor: Record Vendor;
    begin
        if "Student Type" = "Student Type"::"GHT Student" then begin
            Vendor.Reset();
            Vendor.SetRange("Vendor Sub Type", Vendor."Vendor Sub Type"::Hospital);
            Vendor.SetRange("FM1/IM1 Rotation Applicable", true);
            Vendor.SetRange("Preffered for GHT Students", true);
            Vendor.SetRange(Blocked, Vendor.Blocked::" ");
            if Vendor.FindFirst() then
                if Vendor.Count = 1 then begin
                    "First Preferred Site Type" := "First Preferred Site Type"::"Affilated Hospital";
                    Validate("First Preferred Site ID", Vendor."No.");
                end;
        end;
    end;

    procedure CheckRequiredExamOnApplication(StudentMaster: Record "Student Master-CS")
    var
        EducationSetup: Record "Education Setup-CS";
        StudentSubjectExam: Record "Student Subject Exam";
        CBSEPassed: Boolean;
        I: Integer;
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("CBSE Exam Code for FM1/IM1");

        I := 0;
        CBSEPassed := false;
        StudentSubjectExam.Reset();
        StudentSubjectExam.SetRange("Student No.", "Student No.");
        StudentSubjectExam.SetFilter("Subject Code", EducationSetup."CBSE Exam Code for FM1/IM1");
        if StudentSubjectExam.FindSet() then begin
            I += 1;
            repeat
                if StudentSubjectExam.Total >= EducationSetup."CBSE Certifying Score" then
                    CBSEPassed := true;
            until StudentSubjectExam.Next() = 0;
        end
        else
            Error('CBSE Exam required for FM1/IM1 Application is not found in Student Subjects.');

        if CBSEPassed = false then
            Error('Student No. %1 (%2) has not passed CBSE Exam.', "Student No.", "Student Name");
        I := I * 1;
    end;

    procedure CheckDocumentsApproval(StudentNo: Code[20]) PendingStatus: Boolean
    var
        StudentMaster: Record "Student Master-CS";
        ClinicalDocument: Record "Doc & Cate Attachment-CS";
        SDA: Record "Student Document Attachment";
    begin
        PendingStatus := false;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        if (StudentMaster."Document Exception Flag" = true) or (StudentMaster."Clinical Document Status" = StudentMaster."Clinical Document Status"::Completed) then
            exit(PendingStatus);

        ClinicalDocument.Reset();
        ClinicalDocument.SetRange("Document Type", 'CLINICAL');
        ClinicalDocument.SetRange(Blocked, false);
        ClinicalDocument.SetFilter(Responsibility, '<>%1', ClinicalDocument.Responsibility::" ");
        IF ClinicalDocument.FindSet() then
            repeat
                SDA.Reset();
                SDA.SetCurrentKey("Student No.");
                SDA.SetRange("Student No.", StudentNo);
                SDA.SetRange("Document Category", ClinicalDocument."Document Type");
                SDA.SetRange("Document Sub Category", ClinicalDocument.Code);
                if not SDA.FindFirst() then
                    PendingStatus := true;

                exit(PendingStatus);
            until ClinicalDocument.Next() = 0;
    end;
}