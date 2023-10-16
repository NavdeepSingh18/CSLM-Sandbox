table 50373 "Rotation Offer Application"
{
    DataClassification = CustomerContent;
    Caption = 'Rotation Offer Application';
    // LookupPageId = "Rotation Offer Applications";
    // DrillDownPageId = "Rotation Offer Applications";

    fields
    {
        field(1; "Offer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Offer No.';
            TableRelation = "Rotation Offers"."Offer No.";

            trigger OnValidate()
            var
                RotationOffers: Record "Rotation Offers";
            begin
                RotationOffers.Reset();
                if RotationOffers.Get("Offer No.") then begin
                    "Course Code" := RotationOffers."Course Code";
                    "Course Description" := RotationOffers."Course Description";
                    "Course Prefix" := RotationOffers."Course Prefix";
                    "Elective Course Code" := RotationOffers."Elective Course Code";
                    "Rotation Description" := RotationOffers."Rotation Description";
                    "No. of Weeks" := RotationOffers."No. of Weeks";
                    "Start Date" := RotationOffers."Start Date";
                    "End Date" := RotationOffers."End Date";
                    "Hospital ID" := RotationOffers."Hospital ID";
                    "Hospital Name" := RotationOffers."Hospital Name";
                    "Cordination ID" := RotationOffers."Cordination ID";
                    "Global Dimension 1 Code" := RotationOffers."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := RotationOffers."Global Dimension 2 Code";
                end;
            end;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No." where(Semester = field("Clerkship Semester Filter"));

            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                RotationOfferApplication: Record "Rotation Offer Application";
                RSL: Record "Roster Scheduling Line";
                ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                LOAStart: Date;
                LOAEnd: date;
            begin
                TestField("Start Date");

                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                "Student Name" := '';
                "Enrollment No." := '';
                "Clinical Cordinator ID" := '';
                Semester := '';
                "Academic Year" := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student No.") then begin
                    //RSL.CheckFM1IM1Rotation("Student No.");
                    "First Name" := StudentMaster."First Name";
                    "Middle Name" := StudentMaster."Middle Name";
                    "Last Name" := StudentMaster."Last Name";
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    "Clinical Cordinator ID" := StudentMaster."Clinical Coordinator";
                    "Academic Year" := StudentMaster."Academic Year";
                    Semester := StudentMaster.Semester;
                end;

                //TO_DOCheckCorePassed();

                if "Student No." <> '' then begin
                    IF ("Student No." <> '') and ("Start Date" <> 0D) then
                        if ClinicalBaseAppSubscribe.CheckCLOAExistance("Student No.", "Start Date", "End Date", LOAStart, LOAEnd) = true then
                            Error('Student No. %1 (%2) is on CLOA for the Period %3 to %4.', "Student No.", "Student Name", LOAStart, LOAEnd);

                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetRange("Offer No.", "Offer No.");
                    RotationOfferApplication.SetRange("Student No.", "Student No.");
                    RotationOfferApplication.SetFilter("Approval Status", '%1|%2|%3',
                    RotationOfferApplication."Approval Status"::Approved,
                    RotationOfferApplication."Approval Status"::"Not Applicable",
                    RotationOfferApplication."Approval Status"::"Pending for Approval");
                    if RotationOfferApplication.FindLast() then
                        Message('Warning!!! Student No. %1 (%2) has already applied  for the Offer No. %3.', "Student No.", "Student Name", "Offer No.");

                    "Same Rotation Applied" := false;
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetFilter("Offer No.", '<>%1', "Offer No.");
                    RotationOfferApplication.SetRange("Student No.", "Student No.");
                    RotationOfferApplication.SetRange("Course Code", "Course Code");
                    RotationOfferApplication.SetRange("Course Prefix", "Course Prefix");
                    RotationOfferApplication.SetRange("Elective Course Code", "Elective Course Code");
                    RotationOfferApplication.SetFilter(Status, '%1', RotationOfferApplication.Status::Confirmed);
                    RotationOfferApplication.SetFilter("Approval Status", '%1|%2', RotationOfferApplication."Approval Status"::Approved, RotationOfferApplication."Approval Status"::"Not Applicable");
                    if RotationOfferApplication.FindFirst() then
                        "Same Rotation Applied" := true;

                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetFilter("Offer No.", '<>%1', "Offer No.");
                    RotationOfferApplication.SetRange("Student No.", "Student No.");
                    RotationOfferApplication.SetFilter(Status, '%1', RotationOfferApplication.Status::Confirmed);
                    RotationOfferApplication.SetFilter("Approval Status", '%1|%2', RotationOfferApplication."Approval Status"::Approved, RotationOfferApplication."Approval Status"::"Not Applicable");
                    if RotationOfferApplication.FindSet() then
                        repeat
                            if ("Start Date" >= RotationOfferApplication."Start Date") and ("Start Date" <= RotationOfferApplication."End Date") then
                                Error('Rotation period is not valid for the Student No. %1 (%2).\Already applied for a rotation %3 for the period %4 to %5.',
                                RotationOfferApplication."Student No.", RotationOfferApplication."Student Name", RotationOfferApplication."Offer No.", RotationOfferApplication."Start Date", RotationOfferApplication."End Date");
                        until RotationOfferApplication.Next() = 0;
                end;
            end;
        }
        field(5; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(6; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(7; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(8; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(9; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(10; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(11; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(12; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = "Subject Master-CS".Code where("Type of Subject" = filter(Core), "Level Description" = filter("Main Subject"));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                TestField("Student No.");
                "Course Description" := '';
                "Course Prefix" := '';
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.FindFirst() then begin
                    "Course Description" := SubjectMaster.Description;
                    "Course Prefix" := SubjectMaster."Subject Prefix";
                end;
            end;
        }
        field(13; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(14; "Course Prefix"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix';
            TableRelation = "Subject Prefix".Code;
            trigger OnValidate()
            begin
                Validate("Elective Course Code");
            end;
        }

        field(16; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
            TableRelation = IF ("Course Code" = filter('')) "Subject Master-CS".Code where("Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"))
            else
            "Subject Master-CS".Code where("Core Rotation Group" = field("Course Code"), "Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
                RotationOfferApplication: Record "Rotation Offer Application";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                TestField("Student No.");

                "Same Rotation Applied" := false;
                RotationOfferApplication.Reset();
                RotationOfferApplication.SetFilter("Offer No.", '<>%1', "Offer No.");
                RotationOfferApplication.SetRange("Student No.", "Student No.");
                RotationOfferApplication.SetRange("Academic Year", "Academic Year");
                RotationOfferApplication.SetRange("Course Code", "Course Code");
                RotationOfferApplication.SetRange("Elective Course Code", "Elective Course Code");
                if RotationOfferApplication.FindFirst() then
                    "Same Rotation Applied" := true;

                "Rotation Description" := '';
                NoOfWeeks := 0;
                Validate("No. of Weeks", NoOfWeeks);
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Elective Course Code");
                if SubjectMaster.FindFirst() then begin
                    "Rotation Description" := "Course Prefix" + ' - ' + SubjectMaster.Description;
                    TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
                    Evaluate(NoOfWeeks, TextNoofWeeks);
                    Validate("No. of Weeks", NoOfWeeks);
                end;
            end;
        }
        field(17; "Rotation Description"; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            Editable = false;
        }
        field(18; "Same Rotation Applied"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Same Rotation Applied';
            Editable = false;
        }
        field(19; "Cordination ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cordination ID';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(21; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            trigger OnValidate()
            var
                RotationOfferApplication: Record "Rotation Offer Application";
                Date_1: Record Date;
                ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                LOAStart: Date;
                LOAEnd: date;
            begin
                if "Start Date" <> 0D then begin
                    if "Start Date" < WorkDate() then
                        Error('Start Date of an Elective Rotation can not be less than %1.', WorkDate());

                    Date_1.Reset();
                    Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                    Date_1.SetRange("Period Start", "Start Date");
                    if Date_1.FindFirst() then;

                    if Date_1."Period Name" <> 'Monday' then
                        Error('Rotation Start Date must be Monday.');

                    IF ("Student No." <> '') and ("Start Date" <> 0D) then
                        if ClinicalBaseAppSubscribe.CheckCLOAExistance("Student No.", "Start Date", "End Date", LOAStart, LOAEnd) = true then
                            Error('Student No. %1 (%2) is on leave for the Period %3 to %4.', "Student No.", "Student Name", LOAStart, LOAEnd);

                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetFilter("Offer No.", '<>%1', "Offer No.");
                    RotationOfferApplication.SetRange("Student No.", "Student No.");
                    RotationOfferApplication.SetRange("Academic Year", "Academic Year");
                    RotationOfferApplication.SetFilter("Approval Status", '<>%1', RotationOfferApplication."Approval Status"::Rejected);
                    if RotationOfferApplication.FindSet() then
                        repeat
                            if ("Start Date" >= RotationOfferApplication."Start Date") and ("Start Date" <= RotationOfferApplication."End Date") then
                                Error('Start Date for the Elective Rotation is not Valid.\Already applied a Rotation %1 for the Period %2 to %3.',
                                RotationOfferApplication."Offer No.", RotationOfferApplication."Start Date", RotationOfferApplication."End Date");
                        until RotationOfferApplication.Next() = 0;
                end;
                Validate("No. of Weeks");
            end;
        }
        field(22; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            Editable = false;

            trigger OnValidate()
            var
                PeriodLength: DateFormula;
            begin
                if "Start Date" <> 0D then begin
                    EVALUATE(PeriodLength, Format("No. of Weeks") + 'W');
                    "End Date" := CALCDATE(PeriodLength, "Start Date" - 3);
                end
                else
                    "End Date" := 0D;

                Validate("Estimated Rotation Cost");
            end;
        }

        field(23; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(24; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
            TableRelation = "Hospital Inventory"."Hospital ID" where("Academic Year" = field("Academic Year"), "Clerkship Type" = filter(Elective), "Course Code" = field("Elective Course Code"), Status = filter(" " | Allowed), "Available Seats" = filter(> 0));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Hospital Name" := '';
                Vendor.Reset();
                if Vendor.Get("Hospital ID") then
                    "Hospital Name" := Vendor.Name;

                //CheckAvblSeats();
                "Estimated Rotation Cost" := 0;
            end;
        }
        field(25; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(26; "Clinical Cordinator ID"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Cordinator ID';
            TableRelation = "User Setup"."User ID";
        }
        field(28; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(29; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(30; "Alternate Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Alternate Start Date';
            trigger OnValidate()
            var
                Date_1: Record Date;
                RotationOfferApplication: Record "Rotation Offer Application";
                PeriodLength: DateFormula;
            begin
                if "Alternate Start Date" <> 0D then begin
                    if "Alternate Start Date" < WorkDate() then
                        Error('Alternate start date cannot be less than %1.', WorkDate());

                    Date_1.Reset();
                    Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                    Date_1.SetRange("Period Start", "Alternate Start Date");
                    if Date_1.FindFirst() then;

                    if Date_1."Period Name" <> 'Monday' then
                        Error('Rotation start date must be Monday.');

                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetFilter("Offer No.", '<>%1', "Offer No.");
                    RotationOfferApplication.SetRange("Student No.", "Student No.");
                    RotationOfferApplication.SetRange("Academic Year", "Academic Year");
                    if RotationOfferApplication.FindSet() then
                        repeat
                            if ("Alternate Start Date" >= RotationOfferApplication."Alternate Start Date") and ("Alternate Start Date" <= RotationOfferApplication."End Date") then
                                Error('Alternate start date is not valid.\Student has already applied for the Offer No. %1 for the period %2 to %3.',
                                RotationOfferApplication."Offer No.", RotationOfferApplication."Start Date", RotationOfferApplication."End Date");
                        until RotationOfferApplication.Next() = 0;

                    EVALUATE(PeriodLength, Format("No. of Weeks") + 'W');
                    "Alternate End Date" := CALCDATE(PeriodLength, "Alternate Start Date");
                end
                else
                    "Alternate End Date" := 0D;
            end;
        }
        field(31; "Alternate End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Alternate End Date';
            Editable = false;
        }
        field(32; "Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            Editable = false;

            trigger OnValidate()
            begin
                "Total Estimated Rotation Cost" := "Estimated Rotation Cost" * "No. of Weeks";
            end;
        }
        field(33; "Total Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            Editable = false;
        }
        field(34; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Open","Confirmed","Rejected","In-Review";
            trigger OnValidate()
            begin
                if "Application No." = '' then begin
                    GenerateApplnNo();
                    "Application Date" := Today;
                end;

                if Status = Status::Confirmed then begin
                    "Confirmed By" := UserId;
                    "Confirmed On" := Today;
                end;

                if Status = Status::"In-Review" then begin
                    "In-Review By" := UserId;
                    "In-Review On" := Today;
                end;

                if Status = Status::Rejected then begin
                    "Rejected By" := UserId;
                    "Rejected On" := Today;
                end;

                if Status = Status::Open then begin
                    "Confirmed By" := '';
                    clear("Confirmed On");
                    "Rejected By" := '';
                    Clear("Rejected On");
                    "Reject Reason" := '';
                    "Reject Reason Description" := '';
                    Validate("Approval Status", "Approval Status"::" ");
                end;
            end;
        }
        field(35; "Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(36; "Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmed On';
            Editable = false;
        }
        field(37; "Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Pending for Approval","Approved",Rejected,"Not Applicable","Rotation Cancelled";
            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Approved Status By" := UserId;
                    "Approved Status On" := Today;
                end
                Else begin
                    "Approved Status By" := '';
                    Clear("Approved Status On");
                end;
            end;
        }
        field(38; "Approved Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(39; "Approved Status On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved On';
            Editable = false;
        }
        field(40; "Rotation Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Scheduled","Published","Cancelled","Unconfirmed","Completed","In-Review";
            Editable = false;
        }
        field(41; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; "Rejected By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(43; "Rejected On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected On';
            Editable = false;
        }
        field(44; "In-Review By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'In-Review By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(45; "In-Review On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'In-Review On';
            Editable = false;
        }
        field(51; "Reject Reason"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter("Elective Offer Application Rejection"));
            Caption = 'Reject Reason';
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Reject Reason Description" := '';
                ReasonCode.Reset();
                if ReasonCode.Get("Reject Reason") then
                    "Reject Reason Description" := ReasonCode.Description;
            end;
        }
        field(52; "Reject Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason Description';
        }
        field(53; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason Description';
        }
        field(54; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Date';
            Editable = false;
        }
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
        key(PK; "Offer No.", "Line No.")
        {
            Clustered = true;
        }
        key(SortListName; Semester, "Last Name", "Middle Name", "First Name")
        {
            Clustered = false;
        }
        key(SortListII; "Elective Course Code", "Last Name", "Middle Name", "First Name")
        {
            Clustered = false;
        }
        key(SchedulingSorting; "Offer No.", "Application No.")
        {
            Clustered = false;
        }
    }

    procedure GenerateApplnNo()
    var
        EducationSetup: Record "Education Setup-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "Application No." = '' then begin
            EducationSetup.Reset();
            EducationSetup.SetRange("Global Dimension 1 Code", '9000');
            if EducationSetup.FindFirst() then
                EducationSetup.TestField("Elective Application No.");

            if "Application No." = '' then begin
                NoSeriesManagement.InitSeries(EducationSetup."Elective Application No.", xRec."No. Series", 0D, "Application No.", "No. Series");
                if "Application Date" = 0D then
                    "Application Date" := Today;
            end;
        end;
    end;

    procedure CheckCorePassed()
    var
        SubjectMaster: Record "Subject Master-CS";
        RLE: Record "Roster Ledger Entry";
        SubjectGroupCode: Code[20];
        Subjects: Code[2048];
    begin
        SubjectGroupCode := '';
        Subjects := '';
        SubjectMaster.Reset();
        SubjectMaster.SetRange(Code, "Course Code");
        if SubjectMaster.FindFirst() then
            SubjectGroupCode := SubjectMaster."Subject Group";

        SubjectMaster.Reset();
        SubjectMaster.SetRange("Subject Group", SubjectGroupCode);
        if SubjectMaster.FindSet() then
            repeat
                if Subjects = '' then
                    Subjects := SubjectMaster.Code
                else
                    Subjects := Subjects + '|' + SubjectMaster.Code;
            until SubjectMaster.Next() = 0;

        RLE.Reset();
        RLE.SetRange("Student ID", "Student No.");
        RLE.SetRange("Clerkship Type", RLE."Clerkship Type"::Core);
        RLE.SetFilter("Course Code", Subjects);
        RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5<>&%6', '', 'FAIL', 'X', 'UC', 'TC', 'SC');
        if not RLE.FindFirst() then
            Error('Student No. %1 (%2) has not completed the respective core rotation (%3 ).', "Student No.", "Student Name", "Course Description");
    end;

    // local procedure CheckAvblSeats()
    // var
    //     HospitalInventory: Record "Hospital Inventory";
    //     RosterSchedulingLine: Record "Roster Scheduling Line";
    //     TotalAvblSeats: Decimal;
    //     PublishedSeats: Decimal;
    //     BufferedSeats: Decimal;
    //     AvblSeats: Decimal;
    // begin
    //     TotalAvblSeats := 0;
    //     PublishedSeats := 0;
    //     BufferedSeats := 0;
    //     AvblSeats := 0;

    //     if "Hospital ID" <> '' then begin
    //         HospitalInventory.Reset();
    //         HospitalInventory.SetRange("Hospital ID", "Hospital ID");
    //         HospitalInventory.SetRange("Academic Year", "Academic Year");
    //         HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::Elective);
    //         HospitalInventory.SetRange("Course Code", "Elective Course Code");
    //         if HospitalInventory.FindFirst() then
    //             TotalAvblSeats := HospitalInventory.Seats;

    //         RosterSchedulingLine.Reset();
    //         RosterSchedulingLine.SetRange("Hospital ID", "Hospital ID");
    //         RosterSchedulingLine.SetRange("Academic Year", "Academic Year");
    //         RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
    //         RosterSchedulingLine.SetRange("Elective Course Code", "Elective Course Code");
    //         PublishedSeats := RosterSchedulingLine.Count;

    //         RosterSchedulingLine.Reset();
    //         RosterSchedulingLine.SetRange("Hospital ID", "Hospital ID");
    //         RosterSchedulingLine.SetRange("Academic Year", "Academic Year");
    //         RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
    //         RosterSchedulingLine.SetRange("Elective Course Code", "Elective Course Code");
    //         BufferedSeats := RosterSchedulingLine.Count + 1;

    //         AvblSeats := TotalAvblSeats - PublishedSeats - BufferedSeats;

    //         if AvblSeats < 0 then
    //             Error('"Inventory in Hospital %1 (%2) is not available."\\\Total Available Seats : %3\Published Seats : %4\Buffer Seats %5.',
    //             "Hospital ID", "Hospital Name", TotalAvblSeats, PublishedSeats, BufferedSeats);
    //     end;
    // end;
}