table 50419 "CLN Billing Students Summary"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            Caption = 'Student No.';
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                "Student Name" := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student No.") then
                    "Student Name" := StudentMaster."Student Name";
            end;
        }
        field(2; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
        }
        field(3; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
        }
        field(4; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
        }
        field(5; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
        }
        field(6; "Student Status"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Status';
        }
        field(7; "Student Status Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Status';
        }
        field(8; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';

            trigger OnValidate()
            var
                CourseMaster: Record "Course Master-CS";
            begin
                "Course Description" := '';
                CourseMaster.Reset();
                if CourseMaster.Get("Course Code") then
                    "Course Description" := CourseMaster.Description;
            end;
        }
        field(9; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(10; "Weeks Scheduled"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Scheduled';
            DecimalPlaces = 0;
        }
        field(11; "FIU Weeks Scheduled"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Weeks Scheduled';
            DecimalPlaces = 0;
        }
        field(12; "Total Weeks Scheduled"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Weeks Scheduled';
            DecimalPlaces = 0;
        }

        field(13; "Weeks Attended"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Attended';
            DecimalPlaces = 0;
        }
        field(14; "FIU Weeks Attended"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Weeks Attended';
            DecimalPlaces = 0;
        }
        field(15; "Total Weeks Attended"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Weeks Attended';
            DecimalPlaces = 0;
        }
        field(16; "Weeks Billed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Billed';
            DecimalPlaces = 0;
        }
        field(17; "FIU Weeks Billed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Weeks Billed';
            DecimalPlaces = 0;
        }
        field(18; "Total Weeks Billed"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Weeks Billed';
            DecimalPlaces = 0;
        }
        field(19; "Total SC Weeks"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total SC Weeks';
            DecimalPlaces = 0;
        }
        field(20; "FIU Billing Only"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Billing Only';
        }
        field(21; "Ready to Bill"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ready to Bill';
        }
        field(22; "Billing Notes"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Billing Notes';
        }
    }

    keys
    {
        key(PK; "Student No.")
        {
            Clustered = true;
        }
        key(Key_1; "Ready to Bill")
        {
            Clustered = false;
        }
    }

    procedure UpdateStudentsList()
    var
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        CLNBSS: Record "CLN Billing Students Summary";
        CLNBSS_1: Record "CLN Billing Students Summary";
        StudentStatus: Record "Student Status";
        Text001Lbl: Label 'Students in Progress      ############1################\';
        ClinicalSemester: Text[1024];
        W: Dialog;
        T: Integer;
        C: Integer;
    begin
        W.Open('Updating List of Students..\' + Text001Lbl);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        if EducationSetup."FM1/IM1 Semester Filter" <> '' then
            ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        if EducationSetup."Clerkship Semester Filter" <> '' then
            ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        StudentMaster.Reset();
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        if StudentMaster.FindSet() then begin
            T := StudentMaster.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(1, Format(C) + ' of ' + Format(T));
                StudentStatus.Reset();
                if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", StudentMaster."No.");
                //RosterLedgerEntry.SetRange("Clerkship Type", RosterLedgerEntry."Clerkship Type"::"FM1/IM1");
                if RosterLedgerEntry.FindFirst() then begin
                    CLNBSS_1.Reset();
                    if CLNBSS_1.Get(StudentMaster."No.") then begin
                        CLNBSS_1."Student Name" := StudentMaster."Student Name";
                        CLNBSS_1."Enrollment No." := StudentMaster."Enrollment No.";
                        CLNBSS_1."Academic Year" := StudentMaster."Academic Year";
                        CLNBSS_1.Semester := StudentMaster.Semester;
                        CLNBSS_1."Student Status" := StudentMaster.Status;
                        CLNBSS_1."Student Status Description" := StudentStatus.Description;
                        CLNBSS_1.Validate("Course Code", StudentMaster."Course Code");
                        CLNBSS_1.Modify();
                    end
                    else begin
                        CLNBSS.Init();
                        CLNBSS."Student No." := StudentMaster."No.";
                        CLNBSS."Student Name" := StudentMaster."Student Name";
                        CLNBSS."Enrollment No." := StudentMaster."Enrollment No.";
                        CLNBSS."Academic Year" := StudentMaster."Academic Year";
                        CLNBSS.Semester := StudentMaster.Semester;
                        CLNBSS."Student Status" := StudentMaster.Status;
                        CLNBSS."Student Status Description" := StudentStatus.Description;
                        CLNBSS.Validate("Course Code", StudentMaster."Course Code");
                        if CLNBSS.Insert(true) then;
                    end;
                end;
            until StudentMaster.Next() = 0;
        end;

        W.Close();
    end;

    procedure UpdateSummaryDetails(ToDate: Date)
    var
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        RosterSchedulingLine: Record "Roster Scheduling Line";
        CLNBSS: Record "CLN Billing Students Summary";
        CLE: Record "Cust. Ledger Entry";
        Vendor: Record Vendor;
        StudentStatus: Record "Student Status";
        CourseMaster: Record "Course Master-CS";
        WeeksSchd: Decimal;
        FIUWeeksSchd: Decimal;
        WeeksAttend: Decimal;
        FIUWeeksAttend: Decimal;
        NoOfWeeksSchd: Decimal;
        NoOfWeeksAttended: Decimal;
        NoOfWeeksBilled: Decimal;
        FIUNoOfWeeksBilled: Decimal;
        InTransitWeeks: Decimal;
        Text001Lbl: Label 'Students in Progress      ############1################\';
        ReadyToBillStatus: Boolean;
        W: Dialog;
        T: Integer;
        C: Integer;
    begin
        W.Open('Updating Weeks Calculation of Student(s).....\' + Text001Lbl);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("CLN Billing Opening Date");

        CLNBSS.Reset();
        if CLNBSS.FindSet() then begin
            T := CLNBSS.Count;
            C := 0;
            repeat
                C += 1;
                W.Update(1, Format(C) + ' of ' + Format(T));

                WeeksSchd := 0;
                FIUWeeksSchd := 0;
                NoOfWeeksSchd := 0;
                WeeksAttend := 0;
                FIUWeeksAttend := 0;
                NoOfWeeksAttended := 0;
                NoOfWeeksBilled := 0;
                FIUNoOfWeeksBilled := 0;

                StudentMaster.Reset();
                if StudentMaster.Get(CLNBSS."Student No.") then;

                StudentStatus.Reset();
                if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                CourseMaster.Reset();
                if CourseMaster.Get(CLNBSS."Course Code") then;

                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetCurrentKey("Student No.", "Start Date");
                RosterSchedulingLine.SetRange("Student No.", CLNBSS."Student No.");
                //RosterSchedulingLine.SetFilter("Start Date", '%1..%2', 0D, ToDate);
                RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                if RosterSchedulingLine.FindSet() then
                    repeat
                        NoOfWeeksSchd := 0;
                        NoOfWeeksAttended := 0;
                        NoOfWeeksBilled := 0;

                        Vendor.Reset();
                        if Vendor.Get(RosterSchedulingLine."Hospital ID") then;

                        if RosterSchedulingLine."Rotation Grade" in ['X', 'SC', 'UC', 'TC'] then begin
                            NoOfWeeksSchd := 0;
                            NoOfWeeksAttended := 0;
                        end
                        else begin
                            if (RosterSchedulingLine."Start Date" <> 0D) and (RosterSchedulingLine."End Date" <> 0D) then
                                NoOfWeeksSchd := Round((((RosterSchedulingLine."End Date" - RosterSchedulingLine."Start Date") + 1 + 2) / 7), 1, '=');

                            if RosterSchedulingLine."Start Date" < ToDate then begin
                                NoOfWeeksAttended := 0;

                                IF (ToDate >= RosterSchedulingLine."End Date") and
                                (RosterSchedulingLine."Start Date" <> 0D) and
                                (RosterSchedulingLine."End Date" <> 0D) then
                                    NoOfWeeksAttended := Round((((RosterSchedulingLine."End Date" - RosterSchedulingLine."Start Date") + 1 + 2) / 7), 1, '=');
                                IF (ToDate < RosterSchedulingLine."End Date") and (RosterSchedulingLine."Start Date" <> 0D) then
                                    NoOfWeeksAttended := Round((((ToDate - RosterSchedulingLine."Start Date") + 1 + 2) / 7), 1, '=');
                            end;

                            if Vendor."FIU Hospital" = true then begin
                                FIUWeeksSchd := FIUWeeksSchd + NoOfWeeksSchd;
                                FIUWeeksAttend := FIUWeeksAttend + NoOfWeeksAttended;
                            end
                            else begin
                                WeeksSchd := WeeksSchd + NoOfWeeksSchd;
                                WeeksAttend := WeeksAttend + NoOfWeeksAttended;
                            end;
                        end;
                    until RosterSchedulingLine.Next() = 0;

                NoOfWeeksBilled := StudentMaster."CLN Weeks Billed";
                FIUNoOfWeeksBilled := StudentMaster."FIU Weeks Billed";

                CLE.Reset();
                IF UserId = 'X250\MICROSOFT' then
                    CLE.SetRange("Customer No.", StudentMaster."No.")
                else
                    CLE.SetRange("Customer No.", StudentMaster."Original Student No.");
                CLE.SetRange("Type of Billing", CLE."Type of Billing"::"Clinical Billing");
                CLE.SetRange(Reversed, false);
                CLE.SetFilter("Posting Date", '>%1', EducationSetup."CLN Billing Opening Date");
                CLE.CalcSums("Billing Weeks", "FIU Billing Weeks");
                NoOfWeeksBilled := NoOfWeeksBilled + CLE."Billing Weeks";
                FIUNoOfWeeksBilled := FIUNoOfWeeksBilled + CLE."FIU Billing Weeks";

                CLNBSS."Enrollment No." := StudentMaster."Enrollment No.";
                CLNBSS."Academic Year" := StudentMaster."Academic Year";
                CLNBSS.Semester := StudentMaster.Semester;
                CLNBSS."Weeks Scheduled" := WeeksSchd;
                CLNBSS."FIU Weeks Scheduled" := FIUWeeksSchd;
                CLNBSS."Total Weeks Scheduled" := WeeksSchd + FIUWeeksSchd;
                CLNBSS."Weeks Attended" := WeeksAttend;
                CLNBSS."FIU Weeks Attended" := FIUWeeksAttend;
                CLNBSS."Total Weeks Attended" := WeeksAttend + FIUWeeksAttend;
                CLNBSS."Weeks Billed" := NoOfWeeksBilled;
                CLNBSS."FIU Weeks Billed" := FIUNoOfWeeksBilled;
                CLNBSS."Total Weeks Billed" := NoOfWeeksBilled + FIUNoOfWeeksBilled;

                CLNBSS."Ready to Bill" := false;
                CLNBSS."FIU Billing Only" := false;

                if (StudentMaster.Semester in ['CLN5', 'BSIC']) then
                    IF (CLNBSS."Total Weeks Scheduled" >= 6) and (CLNBSS."Total Weeks Attended" > 0) then
                        CLNBSS."Ready to Bill" := true;

                if StudentMaster.Semester = 'CLN6' then
                    IF (CLNBSS."Total Weeks Scheduled" >= 22) and (CLNBSS."Total Weeks Attended" > 17) then  //15
                        CLNBSS."Ready to Bill" := true;

                if StudentMaster.Semester = 'CLN7' then
                    IF (CLNBSS."Total Weeks Scheduled" >= 43) and (CLNBSS."Total Weeks Attended" > 39) then  //37
                        CLNBSS."Ready to Bill" := true;

                if StudentMaster.Semester = 'CLN8' then
                    IF (CLNBSS."Total Weeks Scheduled" >= 64) and (CLNBSS."Total Weeks Attended" > 59) then  //57
                        CLNBSS."Ready to Bill" := true;

                if CLNBSS."Total Weeks Billed" >= CLNBSS."Total Weeks Scheduled" then
                    CLNBSS."Ready to Bill" := false;

                InTransitWeeks := CLNBSS."Total Weeks Billed" - CLNBSS."Total Weeks Attended";

                //IF not ((InTransitWeeks > 0) AND (InTransitWeeks <= 5)) and (CLNBSS."Total Weeks Scheduled" <= 84) then
                //CLNBSS."Ready to Bill" := false;

                IF (InTransitWeeks > 3) then
                    CLNBSS."Ready to Bill" := false;

                ReadyToBillStatus := CLNBSS."Ready to Bill";

                if CLNBSS."Ready to Bill" = false then
                    if CLNBSS."FIU Weeks Scheduled" > CLNBSS."FIU Weeks Billed" then begin
                        CLNBSS."Ready to Bill" := true;
                        if CLNBSS."Total Weeks Billed" > CLNBSS."FIU Weeks Scheduled" then
                            CLNBSS."Ready to Bill" := true
                        else
                            CLNBSS."Ready to Bill" := false;

                        if (ReadyToBillStatus = false) and (CLNBSS."Ready to Bill" = true) then
                            CLNBSS."FIU Billing Only" := true;
                    end;

                if StudentStatus.Status IN [StudentStatus.Status::Declined,
                StudentStatus.Status::Deceased, StudentStatus.Status::Deferred,
                StudentStatus.Status::Dismissed, StudentStatus.Status::Graduated,
                StudentStatus.Status::Withdrawn] then
                    CLNBSS."Ready to Bill" := false;

                if CourseMaster."Clinical Clerkship Applicable" = false then
                    CLNBSS."Ready to Bill" := false;

                CLNBSS."Total SC Weeks" := 0;
                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetCurrentKey("Student No.", "Start Date");
                RosterSchedulingLine.SetRange("Student No.", CLNBSS."Student No.");
                RosterSchedulingLine.SetFilter(Status, '%1', RosterSchedulingLine.Status::Cancelled);
                if RosterSchedulingLine.FindSet() then
                    repeat
                        RosterSchedulingLine.CalcFields("Grade of Rotation");
                        if RosterSchedulingLine."Grade of Rotation" = 'SC' then
                            CLNBSS."Total SC Weeks" += RosterSchedulingLine."No. of Weeks";
                    until RosterSchedulingLine.Next() = 0;

                CLNBSS.Modify();
            until CLNBSS.Next() = 0;
        end;
    end;
}