table 50344 "Roster Scheduling Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Roster Scheduling Line';
    LookupPageId = "Roster Scheduling Lines";
    DrillDownPageId = "Roster Scheduling Lines";
    fields
    {
        field(1; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation ID';
        }
        field(2; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(3; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            var
                EducationSetup: Record "Education Setup-CS";
                StudentMasterCS: Record "Student Master-CS";
                RosterSchedulingHeader: Record "Roster Scheduling Header";
                CompanyInformationrmation: Record "Company Information";
            begin
                CompanyInformationrmation.Reset();
                if CompanyInformationrmation.Get() then;

                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup.FindFirst() then;

                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                "Student Name" := '';
                "Enrollment No." := '';
                "Coordinator ID" := '';
                Semester := '';
                StudentMasterCS.Reset();
                if StudentMasterCS.Get("Student No.") then begin

                    // if RosterSchedulingHeader."Clerkship Type" <> RosterSchedulingHeader."Clerkship Type"::"FM1/IM1" then
                    //     CheckFM1IM1Rotation("Student No.");

                    "First Name" := StudentMasterCS."First Name";
                    "Middle Name" := StudentMasterCS."Middle Name";
                    "Last Name" := StudentMasterCS."Last Name";
                    "Student Name" := StudentMasterCS."Student Name";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Coordinator ID" := StudentMasterCS."Clinical Coordinator";
                    Semester := StudentMasterCS.Semester;
                    if StudentMasterCS."Course Code" = 'GHT' then
                        "Student Type" := "Student Type"::"GHT Student";
                    if CompanyInformationrmation."Country/Region Code" <> StudentMasterCS."Cor Country Code" then
                        "Student Type" := "Student Type"::"International Student";
                end;

                "Course Code" := '';
                "Course Description" := '';
                "Rotation Description" := '';
                "Academic Year" := '';
                "Course Type" := "Course Type"::" ";
                "Start Date" := 0D;
                "No. of Weeks" := 0;
                "End Date" := 0D;
                "Global Dimension 1 Code" := '';
                "Global Dimension 2 Code" := '';

                RosterSchedulingHeader.Reset();
                if RosterSchedulingHeader.Get("Rotation ID") then begin
                    "Entry Type" := RosterSchedulingHeader."Entry Type";
                    "Clerkship Type" := RosterSchedulingHeader."Clerkship Type";
                    "Course Code" := RosterSchedulingHeader."Course Code";
                    "Course Description" := RosterSchedulingHeader."Course Description";
                    "Elective Course Code" := RosterSchedulingHeader."Elective Course Code";
                    "Rotation Description" := RosterSchedulingHeader."Rotation Description";
                    Validate("Course Prefix Code", RosterSchedulingHeader."Course Prefix");
                    "Course Type" := RosterSchedulingHeader."Course Type";
                    Validate("Hospital ID", RosterSchedulingHeader."Hospital ID");
                    "Academic Year" := RosterSchedulingHeader."Academic Year";
                    "Start Date" := RosterSchedulingHeader."Start Date";
                    "No. of Weeks" := RosterSchedulingHeader."No. of Weeks";
                    "End Date" := RosterSchedulingHeader."End Date";
                    "Global Dimension 1 Code" := "Global Dimension 1 Code";
                    "Global Dimension 2 Code" := "Global Dimension 2 Code";
                end;
                OverLapingRotation(Rec);//CSPL-00307-04-10-2022
                Update_New_Returning();
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
        field(10; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Type';
            OptionMembers = Clerkship,"FM1/IM1";
        }

        field(11; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(12; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = if ("Course Type" = filter(Core)) "Subject Master-CS".Code where("Type of Subject" = filter(Core), "Subject Classification" = const('INDUSTRAINING'))
            else
            "Subject Master-CS".Code;
            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
            begin
                "Course Description" := '';
                "Course Type" := "Course Type"::" ";
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.findfirst() then begin
                    "Course Description" := SubjectMaster.Description;
                    "Rotation Description" := SubjectMaster.Description
                end;
            end;
        }
        field(17; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(18; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
        }
        field(19; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
        }

        field(20; "Course Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(21; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            Editable = false;

            trigger OnValidate()
            begin
                Validate("Estimated Rotation Cost");
            end;
        }

        field(22; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;

            trigger OnValidate()
            begin
                Update_New_Returning();
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
            //TableRelation = "Hospital Inventory"."Hospital ID" where("Academic Year" = field("Academic Year"), "Clerkship Type" = field("Clerkship Type"), "Course Code" = field("Course Code"), Status = filter(" " | Started), "Available Seats" = filter(> 0));
            TableRelation = if ("Non-Affiliated Application No." = filter('')) Vendor."No." where("Vendor Sub Type" = filter(Hospital), "Non-Affiliated Hospital" = filter(false))
            else
            Vendor."No." where("Vendor Sub Type" = filter(Hospital), "Non-Affiliated Hospital" = filter(true));

            trigger OnValidate()
            var
                Vendor: Record Vendor;
                HospitalInventory: Record "Hospital Inventory";
                HospitalCostMaster: Record "Hospital Cost Master";
            begin
                "Hospital Name" := '';
                Vendor.Reset();
                if Vendor.Get("Hospital ID") then
                    "Hospital Name" := Vendor.Name;

                "Total No. of Seats" := 0;

                HospitalInventory.Reset();
                IF HospitalInventory.Get("Hospital ID", "Academic Year", "Start Date", "Clerkship Type", "Course Code") then
                    "Total No. of Seats" := HospitalInventory.Seats;

                "Estimated Rotation Cost" := 0;
                if "Hospital ID" <> '' then begin
                    HospitalCostMaster.Reset();
                    HospitalCostMaster.SetRange("Hospital ID", "Hospital ID");
                    HospitalCostMaster.SetRange("Clerkship Type", "Clerkship Type");
                    HospitalCostMaster.SetFilter("Effective Date", '<=%1', "Start Date");
                    HospitalCostMaster.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF HospitalCostMaster.FindLast() then
                        Validate("Estimated Rotation Cost", HospitalCostMaster."Weekly Cost");
                end;

                Update_New_Returning();
            end;
        }
        field(25; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(26; "Coordinator ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Coordinator ID';
            TableRelation = "User Setup"."User ID";
        }
        field(27; "Document Specialist ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Specialist ID';
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
        field(30; "Total No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Seats';
            DecimalPlaces = 0;
            Editable = false;
        }
        field(31; "Student Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Scheduled","Confirmed","Unconfirmed","In-Progress","Completed";
            Editable = false;
        }
        field(32; "Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            Editable = false;

            trigger OnValidate()
            begin
                "Total Estimated Rotation Cost" := "Estimated Rotation Cost" * "Total No. of Seats" * "No. of Weeks";
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
            OptionMembers = "Scheduled","Published","Cancelled","Unconfirmed","Completed","In-Review","FM1/IM1 Confirmed","On Hold";
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
                //CSPL-00307-RTP
                IF Status = Status::Unconfirmed then begin
                    Waitlisted := true;
                end else
                    Waitlisted := false;
                //CSPL-00307-RTP
            end;
        }
        field(35; "Published By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Published By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(36; "Published On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Published On';
            Editable = false;
        }
        field(37; "Scheduled By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduled By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(38; "Scheduled On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduled On';
            Editable = false;
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

        field(42; "Student Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","GHT Student","International Student";
            Caption = 'Student Type';
        }
        field(43; "Waitlisted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Waitlisted';
        }
        field(44; "Rotation Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed';
            Editable = false;
            trigger OnValidate()
            begin
                "Rotation Confirmed By" := '';
                "Rotation Confirmed On" := 0D;
                if "Rotation Confirmed" then begin
                    "Rotation Confirmed By" := UserId;
                    "Rotation Confirmed On" := Today;
                end;
            end;
        }
        field(45; "Rotation Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed By';
            Editable = false;
        }
        field(46; "Rotation Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed On';
            Editable = false;
        }
        field(47; "Cancel Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter("Rotation Cancellation"));

            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Cancel Reason Description" := '';
                ReasonCode.Reset();
                if ReasonCode.Get("Cancel Reason Code") then
                    "Cancel Reason Description" := ReasonCode.Description;
            end;
        }
        field(48; "Cancel Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason Description';
        }
        field(49; "Offer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Offer No.';
            Editable = false;
        }
        field(50; "Offer Application Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Offer Application Line No.';
            Editable = false;
        }
        field(51; "FM1/IM1 Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Application No.';
            Editable = false;
        }
        field(52; "Non-Affiliated Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Non-Affiliated Application No.';
            Editable = false;
        }
        field(53; "Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ledger Entry No.';
            Editable = false;
        }
        field(54; "Action of Student"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Action of Student';
            OptionMembers = " ",Pending,Confirmed,Rejected;
            Editable = false;
        }
        field(55; "Course Prefix Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix Code';
            trigger OnValidate()
            var
                SubjectPrefix: Record "Subject Prefix";
            begin
                "Course Prefix Description" := '';
                SubjectPrefix.Reset();
                IF SubjectPrefix.Get("Course Prefix Code") then
                    "Course Prefix Description" := SubjectPrefix.Description;
            end;
        }
        field(56; "Course Prefix Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix Description';
        }
        field(57; "Elective Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Application No.';
        }
        field(62; "Notified to Hospital"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Notified to Hospital';
            Editable = false;
        }
        field(63; "CLOA Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'CLOA Application No.';
            Editable = false;
        }
        field(64; "New/Returning"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'New/Returning';
            Editable = false;
            OptionMembers = " ",New,Returning;
        }
        field(65; "Rotation No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation No.';
            Editable = false;
        }
        field(66; "Rotation Grade"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Grade';
            TableRelation = "Grade Master-CS".Code;
        }
        field(67; Interchange; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Interchange';
        }
        field(100; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created Date';
            Editable = false;
        }
        field(101; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }

        field(109; "ITPortal_Tobe_Inserted"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'ITPortal_Tobe_Inserted';
            Editable = false;
            OptionMembers = "No Action","Tobe Insert",Synchronised,Failed;
        }
        field(110; "ITPortal_Tobe_Updated"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'ITPortal_Tobe_Updated';
            Editable = false;
            OptionMembers = "No Action","Tobe Insert",Synchronised,Failed;
        }
        field(111; "EnvelopeID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'EnvelopeID';
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
        field(60000; "Score"; Decimal)
        {
            Caption = 'Score';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Roster Ledger Entry".Score where("Entry No." = field("Ledger Entry No.")));
        }
        field(60002; Credits; Decimal)
        {
            Caption = 'Credits';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Roster Ledger Entry".Credits where("Entry No." = field("Ledger Entry No.")));
        }
        field(60003; "Rotations Avbl Date"; Date)
        {
            Caption = 'Rotations Avbl Date';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(60004; "Grade of Rotation"; Code[20])
        {
            Caption = 'Rotation Grade';
            FieldClass = FlowField;
            CalcFormula = lookup("Roster Ledger Entry"."Rotation Grade" where("Rotation ID" = field("Rotation ID"), "Rotation No." = field("Rotation No.")));
            Editable = false;
        }
        field(60005; CCSSE1stFail; Boolean)
        {
            Caption = 'CCSSE 1st Attempt Fail';
            Editable = false;
        }
        field(60006; AutoPublishHoldRemoval; Boolean)//CSPL-00307-RTP
        {
            Caption = 'Auto Publish Hold Removal';
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Rotation ID", "Academic Year", "Student No.", "Rotation No.")
        {
            Clustered = true;
            SumIndexFields = "No. of Weeks";
        }
        key(SortListName; Semester, "Last Name", "Middle Name", "First Name")
        {
            Clustered = false;
        }
        key(SortStartDate; "Start Date", "Rotation ID")
        {
            Clustered = false;
        }
        key(Key_1; "Student No.", "Course Code", "Rotation Grade")
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    var
        RSL: Record "Roster Scheduling Line";
        RotationNo: Integer;
    begin
        "Created By" := UserId;
        "Created On" := Today;
        RSL.Reset();
        RSL.SetCurrentKey("Rotation No.");
        if RSL.FindLast() then
            RotationNo := RSL."Rotation No.";

        RotationNo := RotationNo + 1;
        "Rotation No." := RotationNo;
    end;

    trigger OnDelete()
    var
        RotationOfferApplication: Record "Rotation Offer Application";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
    begin
        RotationOfferApplication.Reset();
        if RotationOfferApplication.Get("Offer No.", "Offer Application Line No.") then begin
            RotationOfferApplication."Rotation Status" := RotationOfferApplication."Rotation Status"::" ";
            RotationOfferApplication."Rotation ID" := '';
            RotationOfferApplication.Modify();
        end;

        if "FM1/IM1 Application No." <> '' then begin
            ClerkshipSiteAndDateSelection.Reset();
            if ClerkshipSiteAndDateSelection.Get("FM1/IM1 Application No.") then begin
                ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Approved;
                ClerkshipSiteAndDateSelection.Modify();
            end;
        end;

    end;

    /// <summary> 
    /// Description for CheckAvblSeats.
    /// </summary>

    procedure PublishRotation(RosterSchedulingLine: Record "Roster Scheduling Line"; LastEntryNo: Integer)
    var
        RosterSchedulingHeader: Record "Roster Scheduling Header";
        RosterSchedulingLine_1: Record "Roster Scheduling Line";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        RotationOfferApplication: Record "Rotation Offer Application";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        NonAffiliatedHospital: Record "Non-Affiliated Hospital";
        StudentMaster: Record "Student Master-CS";
        StudentGroup: Record "Student Group";
        CALE: Record "Clerkship Activity Log Entries";
        ClinicalNotification: Codeunit "Clinical Notification";
        Success: Boolean;
        RemediateGroupCodes: Code[2048];
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(RosterSchedulingLine."Student No.") then begin
            //CSPL-00307-RTP
            IF RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::"FM1/IM1" Then begin
                StudentMaster."FM1/IM1 Start Date New" := RosterSchedulingLine."Start Date";
                StudentMaster.Modify();
            end;
            //CSPL-00307-RTP
            StudentMaster.CalcFields("Clinical Hold Exist");

            if StudentMaster."Clinical Hold Exist" then begin
                // if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Core then
                //     ClinicalNotification.HOLDRotationNotificationCore(RosterSchedulingLine);
                Message('Student No. %1 (%2) is under Hold, Rotation can not be published for this Student.', RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name");
                exit;
            end;
        end;

        RemediateGroupCodes := 'REMER|REMFM|REMFM1|REMIM|REMOBGYN|REMPED|REMPSY|REMSUR';
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", RosterSchedulingLine."Student No.");
        StudentGroup.SetFilter("Groups Code", RemediateGroupCodes);
        StudentGroup.SetRange(Blocked, false);
        if StudentGroup.FindFirst() then begin
            Message('Student No. %1 (%2) is under %3 Remediate Group, Rotation can not be published for this Student.', RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", StudentGroup."Groups Code");
            exit;
        end;

        RosterSchedulingHeader.Reset();
        if RosterSchedulingHeader.Get(RosterSchedulingLine."Rotation ID") then;

        RosterLedgerEntry.Init();
        RosterLedgerEntry."Entry No." := LastEntryNo;
        RosterLedgerEntry."Rotation ID" := RosterSchedulingLine."Rotation ID";
        RosterLedgerEntry."Clerkship Type" := RosterSchedulingLine."Clerkship Type";
        RosterLedgerEntry."Entry Type" := RosterSchedulingLine."Entry Type";
        RosterLedgerEntry."Hospital ID" := RosterSchedulingLine."Hospital ID";
        RosterLedgerEntry."Hospital Name" := RosterSchedulingLine."Hospital Name";
        RosterLedgerEntry."Student ID" := RosterSchedulingLine."Student No.";
        RosterLedgerEntry."First Name" := RosterSchedulingLine."First Name";
        RosterLedgerEntry."Middle Name" := RosterSchedulingLine."Middle Name";
        RosterLedgerEntry."Last Name" := RosterSchedulingLine."Last Name";
        RosterLedgerEntry."Student Name" := RosterSchedulingLine."Student Name";
        RosterLedgerEntry."Enrollment No." := RosterSchedulingLine."Enrollment No.";
        RosterLedgerEntry."Course Code" := RosterSchedulingLine."Course Code";
        RosterLedgerEntry."Course Description" := RosterSchedulingLine."Course Description";
        RosterLedgerEntry."Elective Course Code" := RosterSchedulingLine."Elective Course Code";
        RosterLedgerEntry."Rotation Description" := RosterSchedulingLine."Rotation Description";
        RosterLedgerEntry."Course Prefix" := RosterSchedulingHeader."Course Prefix";
        RosterLedgerEntry."Course Type" := RosterSchedulingLine."Course Type";
        RosterLedgerEntry."Academic Year" := RosterSchedulingLine."Academic Year";
        RosterLedgerEntry."Semester" := RosterSchedulingLine.Semester;
        RosterLedgerEntry.Validate("Student Course Code", StudentMaster."Course Code");
        RosterLedgerEntry."Total No. of Weeks" := RosterSchedulingLine."No. of Weeks";
        RosterLedgerEntry."Start Date" := RosterSchedulingLine."Start Date";
        RosterLedgerEntry."End Date" := RosterSchedulingLine."End Date";
        RosterLedgerEntry.Status := RosterLedgerEntry.Status::Published;
        RosterLedgerEntry."Rotation No." := RosterSchedulingLine."Rotation No.";
        RosterLedgerEntry.Validate("Estimated Rotation Cost", RosterSchedulingLine."Estimated Rotation Cost");
        RosterLedgerEntry."Valid Rotation" := 0;
        RosterLedgerEntry.Validate("Actual Rotation Cost", RosterSchedulingLine."Estimated Rotation Cost");

        RosterLedgerEntry."Action of Student" := RosterLedgerEntry."Action of Student"::Confirmed;

        RosterLedgerEntry."School Docs TransactionID" := UploadToSchoolDoc(RosterLedgerEntry, RosterSchedulingHeader."Course Prefix", Success);
        if Success then
            RosterLedgerEntry."School Docs Sync" := 'SUCCESS'
        else
            RosterLedgerEntry."School Docs Sync" := 'FAILED';

        RosterSchedulingLine."School Docs TransactionID" := RosterLedgerEntry."School Docs TransactionID";
        RosterSchedulingLine."School Docs Sync" := RosterLedgerEntry."School Docs Sync";
        RosterSchedulingLine."Action of Student" := RosterSchedulingLine."Action of Student"::Confirmed;

        RosterLedgerEntry.Insert();

        if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::"FM1/IM1" then begin
            // ClinicalNotification.FM1IM1SitePlacementEmail(RosterSchedulingLine);
            ClerkshipSiteAndDateSelection.Reset();
            if ClerkshipSiteAndDateSelection.Get(RosterSchedulingLine."FM1/IM1 Application No.") then begin
                ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Published;
                ClerkshipSiteAndDateSelection.Modify();
            end;
        end;

        if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Core then begin
            RosterSchedulingLine_1.Reset();
            RosterSchedulingLine_1.SetCurrentKey("Student No.");
            RosterSchedulingLine_1.SetRange("Student No.", RosterSchedulingLine."Student No.");
            RosterSchedulingLine_1.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type");
            RosterSchedulingLine_1.SetRange(Status, RosterSchedulingLine_1.Status::Published);

            // if RosterSchedulingHeader."Umbrella Rotation" = false then
            //     if not RosterSchedulingLine_1.FindFirst() then
            //         ClinicalNotification.FirstCoreRotationNotificationEmail(RosterSchedulingLine)
            //     else
            //         ClinicalNotification.OtherCoreRotationNotificationEmail(RosterSchedulingLine);

            // if RosterSchedulingHeader."Umbrella Rotation" = true then
            //     if not RosterSchedulingLine_1.FindFirst() then
            //         ClinicalNotification.FirstUmbrellaNotificationEmail(RosterSchedulingLine)
            //     else
            //         ClinicalNotification.OtherUmbrellaNotificationEmail(RosterSchedulingLine);

            // if RosterSchedulingHeader."Elective Mandatory" then
            //     ClinicalNotification.RotationNotificationCoreSurgery(RosterSchedulingLine);
        end;

        if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Elective then begin
            if RosterSchedulingLine."Offer No." <> '' then begin
                RotationOfferApplication.Reset();
                if RotationOfferApplication.Get(RosterSchedulingLine."Offer No.", RosterSchedulingLine."Offer Application Line No.") then begin
                    RotationOfferApplication."Rotation Status" := RotationOfferApplication."Rotation Status"::Published;
                    RotationOfferApplication.Modify();
                end;
            end;

            if RosterSchedulingLine."Non-Affiliated Application No." <> '' then begin
                NonAffiliatedHospital.Reset();
                if NonAffiliatedHospital.Get(RosterSchedulingLine."Non-Affiliated Application No.") then begin
                    NonAffiliatedHospital."Rotation Status" := RotationOfferApplication."Rotation Status"::Published;
                    NonAffiliatedHospital.Modify();
                end;
            end;
        end;

        RosterSchedulingLine.Validate(Status, RosterSchedulingLine.Status::Published);
        RosterSchedulingLine.ITPortal_Tobe_Inserted := RosterSchedulingLine.ITPortal_Tobe_Inserted::"Tobe Insert";
        RosterSchedulingLine."Ledger Entry No." := RosterLedgerEntry."Entry No.";
        // ClinicalNotification.NewRotationonScheduleDocumentsInNeedOfUpdate(RosterSchedulingLine);
        UpdateStudentSubject(RosterSchedulingLine, StudentMaster);

        if RosterSchedulingLine."Rotation Confirmed" = false then
            RosterSchedulingLine.Validate("Rotation Confirmed", true);
        if RosterSchedulingLine."Scheduled By" = '' then
            RosterSchedulingLine."Scheduled By" := UserId;
        if RosterSchedulingLine."Scheduled On" = 0D then
            RosterSchedulingLine."Scheduled On" := Today;
        RosterSchedulingLine.Modify();

        if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::"FM1/IM1" then
            CALE.InsertLogEntry(4, 4, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', RosterSchedulingLine."Course Code", RosterSchedulingLine."Rotation Description");
        if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Elective then
            CALE.InsertLogEntry(8, 4, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', RosterSchedulingLine."Elective Course Code", RosterSchedulingLine."Rotation Description");
        if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Core then
            CALE.InsertLogEntry(5, 4, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', RosterSchedulingLine."Course Code", RosterSchedulingLine."Rotation Description");
    end;

    procedure UpdateStudentSubject(RSL: Record "Roster Scheduling Line"; StudentMaster: Record "Student Master-CS")
    var
        RSH: Record "Roster Scheduling Header";
        MainStudentSubject: Record "Main Student Subject-CS";
        SubjectMaster: Record "Subject Master-CS";
    begin
        RSH.Reset();
        if RSH.Get(RSL."Rotation ID") then;

        MainStudentSubject.INIT();
        MainStudentSubject."Student No." := RSL."Student No.";
        MainStudentSubject."Original Student No." := StudentMaster."Original Student No.";
        MainStudentSubject."Enrollment No" := StudentMaster."Enrollment No.";
        MainStudentSubject."Student Name" := RSL."Student Name";
        MainStudentSubject.Validate(Course, StudentMaster."Course Code");
        //MainStudentSubject.Semester := StudentMaster.Semester;
        MainStudentSubject.Section := StudentMaster.Section;
        MainStudentSubject."Academic Year" := StudentMaster."Academic Year";
        MainStudentSubject.Validate(Term, StudentMaster.Term);
        if RSL."Clerkship Type" <> RSL."Clerkship Type"::Elective then
            MainStudentSubject.Validate("Subject Code", RSL."Course Code")
        else
            MainStudentSubject.Validate("Subject Code", RSL."Elective Course Code");
        MainStudentSubject."Rotation ID" := RSL."Rotation ID";
        MainStudentSubject."Course Prefix" := RSH."Course Prefix";
        MainStudentSubject."Rotation Description" := RSL."Rotation Description";
        MainStudentSubject.Credit := RSL."No. of Weeks";
        MainStudentSubject."Start Date" := RSL."Start Date";
        MainStudentSubject."Expected End Date" := RSL."End Date";
        MainStudentSubject."End Date" := RSL."End Date";
        MainStudentSubject."Global Dimension 1 Code" := RSL."Global Dimension 1 Code";
        MainStudentSubject."Global Dimension 2 Code" := RSL."Global Dimension 2 Code";
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

    procedure RemoveStudentSubject(RSL: Record "Roster Scheduling Line")
    var
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentMaster: Record "Student Master-CS";
    begin
        StudentMaster.Reset();
        if StudentMaster.Get(RSL."Student No.") then;

        MainStudentSubject.Reset();
        MainStudentSubject.SetRange("Student No.", RSL."Student No.");
        MainStudentSubject.SetRange(Course, StudentMaster."Course Code");
        MainStudentSubject.SetFilter(Grade, '%1|%2|%3|%4|%5|%6', '', 'X', 'M', 'SC', 'UC', 'SC');
        if RSL."Clerkship Type" <> RSL."Clerkship Type"::Elective then
            MainStudentSubject.SetRange("Subject Code", RSL."Course Code")
        else
            MainStudentSubject.SetRange("Subject Code", RSL."Elective Course Code");
        //CSPL-00307-BUG 31-03-23
        MainStudentSubject.SetRange("Start Date", RSL."Start Date");
        MainStudentSubject.SetRange("End Date", RSL."End Date");
        //CSPL-00307-BUG 31-03-23
        if MainStudentSubject.FindFirst() then
            MainStudentSubject.Delete()
    end;

    procedure CheckNotificationToHospital(RosterSchedulingHeader: Record "Roster Scheduling Header")
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        RecRosterSchedulingLine: Record "Roster Scheduling Line";
        UnNotifiedRotationsChk: List of [Code[20]];
        TempRosterNo: Code[20];
        I: Integer;
        J: Integer;
    begin
        TempRosterNo := '';
        I := 0;
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Rotation ID");
        RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingHeader."Clerkship Type");
        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
        RosterSchedulingLine.SetRange("Notified to Hospital", false);
        if RosterSchedulingLine.Find('-') then
            repeat
                if TempRosterNo <> RosterSchedulingLine."Rotation ID" then begin
                    TempRosterNo := RosterSchedulingLine."Rotation ID";
                    RecRosterSchedulingLine.Reset();
                    RecRosterSchedulingLine.SetCurrentKey("Rotation ID");
                    RecRosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingHeader."Clerkship Type");
                    RecRosterSchedulingLine.SetFilter(Status, '%1', RosterSchedulingLine.Status::Scheduled);
                    RecRosterSchedulingLine.SetRange("Notified to Hospital", false);
                    if not RecRosterSchedulingLine.FindFirst() then
                        UnNotifiedRotationsChk.Add(TempRosterNo);
                end;
            until RosterSchedulingLine.Next() = 0;

        J := UnNotifiedRotationsChk.Count;

        // if J > 0 then
        //     for I := 1 to J do
        //         SendNotificationToHospital(UnNotifiedRotationsChk.Get(I));

        I := UnNotifiedRotationsChk.Count;
    end;

    /// <summary> 
    /// Description for SendNotificationToHospital.
    /// </summary>
    /// <param name="RotationID">Parameter of type Code[20].</param>
    // procedure SendNotificationToHospital(RotationID: Code[20])
    // var
    //     Vendor: Record Vendor;
    //     StudentMasterCS: Record "Student Master-CS";
    //     CompanyInformation: Record "Company Information";
    //     RosterSchedulingLine: Record "Roster Scheduling Line";
    //     RecRosterSchedulingLine: Record "Roster Scheduling Line";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text[100];
    //     Recipients: List of [Text];
    //     MailSubject: Text[100];
    //     Body: Text[100000];
    //     TempHospitalID: Code[20];
    // begin
    //     CompanyInformation.Reset();
    //     if CompanyInformation.Get() then;

    //     TempHospitalID := '';

    //     RecRosterSchedulingLine.Reset();
    //     RecRosterSchedulingLine.SetCurrentKey("Hospital ID");
    //     RecRosterSchedulingLine.SetRange("Notified to Hospital", false);
    //     RecRosterSchedulingLine.SetRange("Rotation ID", RotationID);
    //     if RecRosterSchedulingLine.FindSet() then
    //         repeat
    //             if TempHospitalID <> RecRosterSchedulingLine."Hospital ID" then begin
    //                 TempHospitalID := RecRosterSchedulingLine."Hospital ID";

    //                 StudentMasterCS.Reset();
    //                 if StudentMasterCS.Get(RecRosterSchedulingLine."Student No.") then;

    //                 Vendor.Reset();
    //                 if Vendor.Get(RecRosterSchedulingLine."Hospital ID") then begin
    //                     Recipient := Vendor."E-Mail";
    //                     Recipients := Recipient.Split(';');
    //                 end;

    //                 MailSubject := 'Rotation Schedule Information';
    //                 clear(Body);
    //                 if Recipient <> '' then begin
    //                     SMTPMail.Create('RotationInformation', 'vikas.sharma@corporateserve.com', Recipients, MailSubject, Body, true);

    //                     SMTPMail.AppendtoBody('Dear ' + Vendor.Name);
    //                     SMTPMail.AppendtoBody('<br><br>');

    //                     SMTPMail.AppendtoBody('Please check following List of Students for the Rotation.');
    //                     SMTPMail.AppendtoBody('<br><br>');
    //                     SMTPMail.AppendtoBody('<Table border="1">');

    //                     SMTPMail.AppendtoBody('<tr>');
    //                     SMTPMail.AppendtoBody('<td style="font-weight:bold"> Student Entrollment No. </td>');
    //                     SMTPMail.AppendtoBody('<td style="font-weight:bold"> Student Name </td>');
    //                     SMTPMail.AppendtoBody('<td style="font-weight:bold"> Period </td>');
    //                     SMTPMail.AppendtoBody('<td style="font-weight:bold"> Subject Name </td>');
    //                     SMTPMail.AppendtoBody('</tr>');

    //                     RosterSchedulingLine.Reset();
    //                     RosterSchedulingLine.SetCurrentKey("Hospital ID");
    //                     RosterSchedulingLine.SetRange("Notified to Hospital", false);
    //                     RosterSchedulingLine.SetRange("Rotation ID", RotationID);
    //                     RosterSchedulingLine.SetRange("Hospital ID", RecRosterSchedulingLine."Hospital ID");
    //                     if RosterSchedulingLine.Find('-') then
    //                         repeat
    //                             SMTPMail.AppendtoBody('<tr>');
    //                             SMTPMail.AppendtoBody('<td>' + RosterSchedulingLine."Enrollment No." + '</td>');
    //                             SMTPMail.AppendtoBody('<td>' + RosterSchedulingLine."Student Name" + '</td>');
    //                             SMTPMail.AppendtoBody('<td>' + Format(RosterSchedulingLine."Start Date") + ' to ' + Format(RosterSchedulingLine."End Date") + '</td>');
    //                             SMTPMail.AppendtoBody('<td>' + RosterSchedulingLine."Course Description" + '</td>');
    //                             SMTPMail.AppendtoBody('</tr>');
    //                             RosterSchedulingLine."Notified to Hospital" := true;
    //                             RosterSchedulingLine.Modify();
    //                         Until RosterSchedulingLine.Next() = 0;

    //                     SMTPMail.AppendtoBody('</Table border>');
    //                     SMTPMail.AppendtoBody('<br><br><br>');
    //                     SMTPMail.AppendtoBody('Regards');
    //                     SMTPMail.AppendtoBody('<br>');
    //                     SMTPMail.AppendtoBody(CompanyInformation.Name);
    //                     //Mail_lCU.Send();
    //                 end;
    //             end;
    //         until RecRosterSchedulingLine.Next() = 0;
    // end;

    procedure UploadToSchoolDoc(RosterLedgerEntry: Record "Roster Ledger Entry";
    SubjectPrefix: Code[20];
    var Success: Boolean)
    TransactionID: Text[30]
    var
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        api_url: text;
        StartDate: Text[30];
        EndDate: Text[30];
        Text001Lbl: Label 'https://schooldocsconnect.com/connect/4fa76f7578a574e23112bec092625fb4/clerkship';
        New_Ret: Text[10];
        Responsetext: Text;
    begin
        if "New/Returning" = "New/Returning"::New then
            New_Ret := 'N';
        if "New/Returning" = "New/Returning"::Returning then
            New_Ret := 'R';

        StartDate := FORMAT(RosterLedgerEntry."Start Date", 0, '<Month>/<Day>/<Year4>');
        EndDate := FORMAT(RosterLedgerEntry."End Date", 0, '<Month>/<Day>/<Year4>');

        api_url := StrSubstNo(Text001Lbl);
        http_content.clear();
        http_content.WriteFrom(
        '<SchoolDocs>' +
        '<Student>' +
        '<ID>' + RosterLedgerEntry."Student ID" + '</ID>' +
        '<ClerkshipTitle>' + RosterLedgerEntry."Rotation Description" + '</ClerkshipTitle>' +
        '<ClerkshipPrefix>' + SubjectPrefix + '</ClerkshipPrefix>' +
        '<ClerkshipType>' + 'Medical' + '</ClerkshipType>' +
        '<ClerkshipStartDate>' + StartDate + '</ClerkshipStartDate>' +
        '<ClerkshipEndDate>' + EndDate + '</ClerkshipEndDate>' +
        '<ClerkshipNewReturning>' + New_Ret + '</ClerkshipNewReturning>' +
        '<AccountNameHospital>' + RosterLedgerEntry."Hospital Name" + '</AccountNameHospital>' +
        '</Student>' +
        '</SchoolDocs>'
        );

        http_content.GetHeaders(http_Headers);
        http_Headers.Clear();
        http_Headers.Add('Content-type', 'application/xml');
        http_request.Content := http_content;
        http_request.GetHeaders(http_Headers);
        http_request.SetRequestUri(api_url);
        http_request.Method('POST');
        http_client.Send(http_request, http_response);
        http_response.Content().ReadAs(responseText);

        TransactionID := '';
        Success := true;
        IF StrPos(ResponseText, '1</Success>') > 0 then
            TransactionID := FindStringValue(Responsetext)
        else
            Success := false;
    end;

    Procedure FindStringValue(ResponsesString: Text[2048]) TransactionNo: Text[100];
    var
        StringFind1: Text[2048];
        TransactionNo1: Text[500];
        Pos: Integer;
        Pos1: Integer;
        Pos2: Integer;
    begin
        StringFind1 := ResponsesString;
        Pos := STRPOS(StringFind1, '<TransactionID>');
        Pos1 := STRPOS(StringFind1, '</TransactionID>');
        Pos2 := Pos1 - Pos;

        TransactionNo1 := COPYSTR(StringFind1, Pos, Pos2);
        TransactionNo := COPYSTR(TransactionNo1, 16, StrLen(TransactionNo1));
    End;

    procedure Update_New_Returning()
    var
        RSL: Record "Roster Scheduling Line";
    begin
        "New/Returning" := "New/Returning"::" ";
        RSL.Reset();
        RSL.SetCurrentKey("Student No.", "Hospital ID", "Start Date");
        RSL.SetFilter("Start Date", '<%1', "Start Date");
        RSL.SetRange("Student No.", "Student No.");
        RSL.SetRange("Hospital ID", "Hospital ID");
        RSL.SetRange("Rotation Confirmed", true);
        RSL.SetFilter(Status, '<>%1&<>%2', RSL.Status::Cancelled, RSL.Status::Unconfirmed);
        if RSL.FindFirst() then
            "New/Returning" := "New/Returning"::Returning
        else
            "New/Returning" := "New/Returning"::New;
    end;

    procedure CheckFM1IM1Rotation(StudentNo: Code[20])
    var
        StudentMaster: Record "Student Master-CS";
        RLE: Record "Roster Ledger Entry";
    begin
        if StudentNo = '' then
            exit;

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        RLE.Reset();
        RLE.SetRange("Student ID", StudentNo);
        RLE.SetRange("Clerkship Type", RLE."Clerkship Type"::"FM1/IM1");
        if not RLE.FindFirst() then
            Error('Please check Student No. %1 (%2) have still not scheduled for FM1/IM1 Rotation.', StudentNo, StudentMaster."Student Name"); //as per ajay 25-05-2022
    end;

    //CSPL-00307-RTP
    procedure AutoPublishedRotation_On_CLN_Hold_Removed(StudentMaster: Record "Student Master-CS")
    var
        RLE: Record "Roster Ledger Entry";
        RSL: Record "Roster Scheduling Line";
        LastEntryNo: Integer;
        // Page50391: Page AddingStudentInRotation;
    begin
        StudentMaster.CalcFields("Clinical Hold Exist", "Bursar Hold");
        IF CheckStatusOnHOLD(StudentMaster) = false then begin
            RSL.Reset();
            RSL.SetRange("Student No.", StudentMaster."No.");
            RSL.SetRange(AutoPublishHoldRemoval, true);
            RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Unconfirmed, RSL.Status::"On Hold");
            IF RSL.FindSet() then
                repeat
                    RLE.Reset();
                    if RLE.FindLast() then
                        LastEntryNo := RLE."Entry No.";

                    LastEntryNo += 1;
                    PublishRotation(RSL, LastEntryNo);
                until RSL.Next() = 0;
        end;
    end;
    //CSPL-00307-RTP

    //CSPL-00307-RTP
    procedure RemoveBursarHoldfromRotation(StudentMaster: Record "Student Master-CS")
    var
        RSL: Record "Roster Scheduling Line";
    begin
        IF CheckStatusOnHOLD(StudentMaster) = false then begin
            RSL.Reset();
            RSL.SetRange("Student No.", StudentMaster."No.");
            RSL.SetFilter(Status, '%1', RSL.Status::"On Hold");
            IF RSL.FindSet() then
                repeat
                    RSL.Status := RSL.Status::Scheduled;
                    RSL.Modify();
                until RSL.Next() = 0;
        end;
    end;
    //CSPL-00307-RTP

    procedure CheckStatusOnHOLD(StudentMaster: Record "Student Master-CS"): Boolean
    var
        StudentGroup: record "Student Group";
        RemediateGroupCodes: text;
    begin
        //CSPL-00307-RTP
        StudentMaster.CalcFields("Clinical Hold Exist", "Bursar Hold");
        if StudentMaster."Clinical Hold Exist" OR StudentMaster."Bursar Hold" then begin
            exit(true);
        end;

        RemediateGroupCodes := 'REMFM|REMFM1|REMIM|REMOBGYN|REMPED|REMPSY|REMSUR';
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudentMaster."No.");
        StudentGroup.SetFilter("Groups Code", RemediateGroupCodes);
        StudentGroup.SetRange(Blocked, false);
        if StudentGroup.FindFirst() then begin
            exit(true);
        end;
    end;

    procedure OverLapingRotation(Var RSL: Record "Roster Scheduling Line")
    var
        RSL2: Record "Roster Scheduling Line";
    begin
        //CSPL-00307 04-10-2022 as per Ajay
        IF (RSL."Start Date" <> 0D) AND (RSL."End Date" <> 0D) then begin
            RSL2.Reset();
            RSL2.SetRange("Student No.", RSL."Student No.");
            RSL2.SetFilter("Start Date", '<=%1', RSL."Start Date");
            RSL2.SetFilter("End Date", '>=%1', RSL."Start Date");
            RSL2.SetFilter(Status, '<>%1', RSL2.Status::Cancelled);
            IF RSL2.FindFirst() then begin
                Error('Student %1 already exist in Rotation %2 Date Range %3 To %4', RSL2."Student No.", RSL2."Rotation ID", RSL2."Start Date", RSL2."End Date");
            end;
        end;
    end;
}