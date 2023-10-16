codeunit 50035 "Clinical Base App. Subscribe"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterDeleteEvent', '', false, false)]
    /// <summary> 
    /// Description for CheckOnDeleteHospital.
    /// </summary>
    /// <param name="Rec">Parameter of type Record Vendor.</param>
    /// <param name="RunTrigger">Parameter of type Boolean.</param>
    local procedure CheckOnDeleteHospital(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        HospitalInventory: Record "Hospital Inventory";
        HospitalCostMaster: Record "Hospital Cost Master";
    begin
        HospitalInventory.Reset();
        HospitalInventory.SetRange("Hospital ID", Rec."No.");
        if HospitalInventory.FindFirst() then
            Error('You must delete Hospital Inventory to Delete Hospital ID %1 (%2)', Rec."No.", Rec.Name);

        HospitalCostMaster.Reset();
        HospitalCostMaster.SetRange("Hospital ID", Rec."No.");
        if HospitalCostMaster.FindFirst() then
            Error('You must delete Hospital Cost to Delete Hospital ID %1 (%2)', Rec."No.", Rec.Name);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure AssignValueCustLedgerEntry(Var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        StudentMaster: Record "Student Master-CS";
        CLNBillingStudentsSummary: Record "CLN Billing Students Summary";
    begin
        CustLedgerEntry."Type of Billing" := GenJournalLine."Type of Billing";
        CustLedgerEntry."Billing Weeks" := GenJournalLine."Billing Weeks";
        CustLedgerEntry."FIU Billing Weeks" := GenJournalLine."FIU Billing Weeks";

        if CustLedgerEntry."Type of Billing" <> CustLedgerEntry."Type of Billing"::" " then
            CustLedgerEntry."Fee Code" := GenJournalLine."Fee Code";

        StudentMaster.Reset();
        if StudentMaster.Get(CustLedgerEntry."Customer No.") then begin
            if GenJournalLine.Semester = 'CLN5' then
                StudentMaster.ClnBldSem5 := true;
            if GenJournalLine.Semester = 'CLN6' then
                StudentMaster.ClnBldSem6 := true;
            if GenJournalLine.Semester = 'CLN7' then
                StudentMaster.ClnBldSem7 := true;
            if GenJournalLine.Semester = 'CLN8' then
                StudentMaster.ClnBldSem8 := true;
            if (GenJournalLine.Semester = 'CLN8') and (StudentMaster.ClnBldSem8 = true) then
                StudentMaster.ClnBldSemXtra := true;
            StudentMaster.Modify();
        end;

        CLNBillingStudentsSummary.Reset();
        CLNBillingStudentsSummary.SetRange("Enrollment No.", GenJournalLine."Enrollment No.");
        if CLNBillingStudentsSummary.FindLast() then begin
            CLNBillingStudentsSummary."Ready to Bill" := false;
            CLNBillingStudentsSummary."Weeks Billed" := CLNBillingStudentsSummary."Weeks Billed" + GenJournalLine."Billing Weeks";
            CLNBillingStudentsSummary."FIU Weeks Billed" := CLNBillingStudentsSummary."FIU Weeks Billed" + GenJournalLine."FIU Billing Weeks";
            CLNBillingStudentsSummary.Modify();
        end;
    end;

    procedure CheckCLOAExistance(StudentNo: Code[20]; StartDate: Date; EndDate: Date; Var LOAStart: Date; var LOAEnd: Date) LOAExist: Boolean
    var
        LOA: Record "Student Leave of Absence";
        LDate: Record Date;
    begin
        LOAExist := false;
        LOA.Reset();
        LOA.SetRange("Student No.", StudentNo);
        LOA.SetFilter(Status, '%1|%2|%3', LOA.Status::Open, LOA.Status::Approved, LOA.Status::"Pending for Approval");
        LOA.SetRange("Leave Types", LOA."Leave Types"::CLOA);
        if LOA.FindSet() then
            repeat
                LDate.Reset();
                LDate.SetCurrentKey("Period Type", "Period Start");
                LDate.SetRange("Period Type", LDate."Period Type"::Date);
                LDate.SetFilter("Period Start", '%1..%2', StartDate, EndDate);
                if LDate.FindSet() then
                    repeat
                        if (LDate."Period Start" >= LOA."Start Date") and (LDate."Period Start" <= LOA."End Date") then begin
                            LOAExist := true;
                            LOAStart := LOA."Start Date";
                            LOAEnd := LOA."End Date";
                        end;
                    until LDate.Next() = 0;
            until LOA.Next() = 0;

        exit(LOAExist);
    end;

    procedure ViewEditNote(SourceNo: Code[20];
        StudentNo: Code[20];
        TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other,Housing,Graduation;
        GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other,Housing,Room,"Housing Ledger",Graduation)
    var
        InteractionTemplate: Record "Interaction Template";
        InteractionGroup: Record "Interaction Group";
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        StudentMaster: Record "Student Master-CS";
    // SLcMNotesList: Page "SLcM Notes List";
    begin
        InteractionTemplate.Reset();
        InteractionTemplate.SetRange("Type", TemplateType);
        IF not InteractionTemplate.FindLast() then
            Error('Interaction Template not found for %1 Type.', TemplateType);

        InteractionGroup.Reset();
        InteractionGroup.SetRange("Type", GroupType);
        IF not InteractionGroup.FindLast() then
            Error('Interaction Group not found for %1 Type.', GroupType);

        // SLcMNotesList.SetVariables(SourceNo, StudentNo);

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        InterLogEntryCommentLine.Reset();
        InterLogEntryCommentLine.SetRange("Source No.", SourceNo);
        InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
        InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
        InterLogEntryCommentLine.SetRange("Original Student No.", StudentMaster."Original Student No.");
        InterLogEntryCommentLine.SetRange("Student No. Filter", StudentNo);
        // SLcMNotesList.SetTableView(InterLogEntryCommentLine);
        // SLcMNotesList.RunModal();
    end;

    procedure ViewEditDegreeNote(SourceNo: Code[20];
        StudentNo: Code[20];
        TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other,Housing,Graduation;
        GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other,Housing,Room,"Housing Ledger",Graduation)
    var
        InteractionTemplate: Record "Interaction Template";
        InteractionGroup: Record "Interaction Group";
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        StudentMaster: Record "Student Master-CS";
        SLcMNotesList: Page "Degree SLcM Notes List";
    begin
        InteractionTemplate.Reset();
        InteractionTemplate.SetRange("Type", TemplateType);
        IF not InteractionTemplate.FindLast() then
            Error('Interaction Template not found for %1 Type.', TemplateType);

        InteractionGroup.Reset();
        InteractionGroup.SetRange("Type", GroupType);
        IF not InteractionGroup.FindLast() then
            Error('Interaction Group not found for %1 Type.', GroupType);

        SLcMNotesList.SetVariables(SourceNo, StudentNo);

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        InterLogEntryCommentLine.Reset();
        InterLogEntryCommentLine.SetRange("Source No.", SourceNo);
        InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
        InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
        InterLogEntryCommentLine.SetRange("Original Student No.", StudentMaster."Original Student No.");
        InterLogEntryCommentLine.SetRange("Student No. Filter", StudentNo);
        SLcMNotesList.SetTableView(InterLogEntryCommentLine);
        SLcMNotesList.RunModal();
    end;

    procedure ViewEditStudentNote(SourceNo: Code[20];
        StudentNo: Code[20];
        TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other,Housing,Graduation;
        GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other,Housing,Room,"Housing Ledger",Graduation)
    var
        InteractionTemplate: Record "Interaction Template";
        InteractionGroup: Record "Interaction Group";
        InterLogEntryCommentLine: Record "Interaction Log Entry";
        StudentMaster: Record "Student Master-CS";
    // SLcMNotesList: Page "Student Notes List";
    begin
        InteractionTemplate.Reset();
        InteractionTemplate.SetRange("Type", TemplateType);
        IF not InteractionTemplate.FindLast() then
            Error('Interaction Template not found for %1 Type.', TemplateType);

        InteractionGroup.Reset();
        InteractionGroup.SetRange("Type", GroupType);
        IF not InteractionGroup.FindLast() then
            Error('Interaction Group not found for %1 Type.', GroupType);

        // SLcMNotesList.SetVariables(SourceNo, StudentNo);

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        InterLogEntryCommentLine.Reset();
        InterLogEntryCommentLine.SetCurrentKey("Created On");
        // InterLogEntryCommentLine.SetAscending("Created On", false);
        InterLogEntryCommentLine.Ascending(false);
        InterLogEntryCommentLine.SetRange("Original Student No.", StudentMaster."Original Student No.");
        InterLogEntryCommentLine.SetRange("Student No. Filter", StudentNo);
        if InterLogEntryCommentLine.FindSet() then;
        // SLcMNotesList.SetTableView(InterLogEntryCommentLine);
        // SLcMNotesList.RunModal();
        Page.Run(50990, InterLogEntryCommentLine);
    end;

    procedure SemesterProgression(Var StudentMaster: Record "Student Master-CS"; ManuallyCalled: Boolean)
    var
        RLE: Record "Roster Ledger Entry";
        RLELast: Record "Roster Ledger Entry";
        LDate: Record Date;
        //ClinicalCurriculum: Record "Clinical Curriculum";
        StudentLeaveofAbsence: Record "Student Leave of Absence";
        CourseMaster: Record "Course Master-CS";
        MainStudentSubject: Record "Main Student Subject-CS";
        StudentSubjectExam: Record "Student Subject Exam";
        CourseDuration: DateFormula;
        DateOfStart: Date;
        TotalLeaveDays: Integer;
        TempDate: Date;
        DaysCompleted: Integer;
        StartDate: Date;
        EndDate: Date;
        NextSemesterStartDate: Date;
        LastUsedRotationDate: Date;
        ClinicalCarriculam: Integer;
        PerSemesterDaysRequired: Integer;
        NoRotationTotalDays: Integer;
        NoRotationBalanceDays: Integer;
        CKExamAdditionalDays: Integer;
        CKExamDate: Date;
        RLEFound: Boolean;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student in Progress      ############1################\';
    begin
        WindowDialog.Open('Calculating Progression....\' + Text001Lbl);
        WindowDialog.UPDATE(1, StudentMaster."No.");

        CourseMaster.Reset();
        if CourseMaster.Get(StudentMaster."Course Code") then begin
            if (CourseMaster."Duration of Years" = 0) and (CourseMaster."Duration in Month" = 0) and (ManuallyCalled = true) then
                Error('Please update Duration on Course Master');
            if (CourseMaster."Duration of Years" = 0) and (CourseMaster."Duration in Month" = 0) and (ManuallyCalled = false) then
                exit;

            Evaluate(CourseDuration, format(CourseMaster."Duration of Years") + 'Y+' + format(CourseMaster."Duration in Month") + 'M');
        end;

        DateOfStart := 0D;

        MainStudentSubject.Reset();
        MainStudentSubject.SetCurrentKey("Student No.", "Start Date");
        MainStudentSubject.SetRange("Student No.", StudentMaster."No.");
        MainStudentSubject.SetFilter("Start Date", '<>%1', 0D);
        if MainStudentSubject.FindFirst() then
            DateOfStart := MainStudentSubject."Start Date";

        CKExamAdditionalDays := 180;
        CKExamDate := 0D;
        StudentSubjectExam.Reset();
        StudentSubjectExam.SetRange("Student No.", StudentMaster."No.");
        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::"STEP 2 CK");
        IF StudentSubjectExam.FindLast() then
            if StudentSubjectExam.Result = StudentSubjectExam.Result::Pass then begin
                CKExamAdditionalDays := 0;
                CKExamDate := StudentSubjectExam."Sitting Date";
            end;

        if (DateOfStart = 0D) and (ManuallyCalled = true) then
            Error('Start Date not found in Student Subjects');

        if DateOfStart = 0D then
            exit;

        TotalLeaveDays := 0;
        StudentLeaveofAbsence.Reset();
        StudentLeaveofAbsence.SetRange("Student No.", StudentMaster."No.");
        StudentLeaveofAbsence.SetRange(Status, StudentLeaveofAbsence.Status::Approved);
        StudentLeaveofAbsence.SetFilter(Semester, '<>%1&<>%2&<>%3&<>%4', 'CLN5', 'CLN6', 'CLN7', 'CLN8');
        if StudentLeaveofAbsence.FindSet() then
            repeat
                if (StudentLeaveofAbsence."End Date" <> 0D) and (StudentLeaveofAbsence."Start Date" <> 0D) then
                    TotalLeaveDays := StudentLeaveofAbsence."End Date" - StudentLeaveofAbsence."Start Date";
            until StudentLeaveofAbsence.Next() = 0;

        StudentMaster."Estimated Graduation Date" := CalcDate(CourseDuration, DateOfStart) + TotalLeaveDays;

        StudentMaster."Island Departure Date" := 0D;
        if (StudentMaster.Nationality <> 'AG') and (StudentMaster."Global Dimension 1 Code" = '9100') then
            StudentMaster."Island Departure Date" := StudentMaster."Estimated Graduation Date";

        if CourseMaster."Clinical Clerkship Applicable" = false then begin
            StudentMaster.Modify();
            exit;
        end;

        if StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"75" then
            ClinicalCarriculam := 75;
        if StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"78" then
            ClinicalCarriculam := 78;
        if StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"84" then
            ClinicalCarriculam := 84;
        if StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"88" then
            ClinicalCarriculam := 88;
        if StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"90" then
            ClinicalCarriculam := 90;
        if StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"94" then
            ClinicalCarriculam := 94;
        If StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"86" then
            ClinicalCarriculam := 86;
        If StudentMaster."Clinical Curriculum" = StudentMaster."Clinical Curriculum"::"96" then
            ClinicalCarriculam := 96;

        PerSemesterDaysRequired := Round((ClinicalCarriculam / 4) * 5, 1, '=');

        IF ClinicalCarriculam = 94 then
            PerSemesterDaysRequired := 115;
        NoRotationTotalDays := PerSemesterDaysRequired + 20;

        RLE.Reset();
        RLE.SetCurrentKey("Student ID", "Start Date");
        RLE.SetRange("Student ID", StudentMaster."No.");
        RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4', 'X', 'TC', 'UC', 'SC');
        if not RLE.FindFirst() then begin
            TempDate := DateOfStart + 730 + TotalLeaveDays;

            if StudentMaster."BSIC Opt Out" = false then
                TempDate := TempDate + 70;

            LDate.Reset();
            LDate.SetCurrentKey("Period Type", "Period Start");
            LDate.SetRange("Period Type", LDate."Period Type"::Date);
            LDate.SetFilter("Period Start", '>=%1', TempDate);
            LDate.SetRange("Period Name", 'Monday');
            if LDate.FindFirst() then
                TempDate := LDate."Period Start";

            StudentMaster."5 FA Start Date" := TempDate;
            StudentMaster."5 FA End Date" := GetEndDate(StudentMaster."5 FA Start Date", NoRotationTotalDays);

            StudentMaster."6 FA Start Date" := StudentMaster."5 FA End Date" + 3;
            StudentMaster."6 FA End Date" := GetEndDate(StudentMaster."6 FA Start Date", NoRotationTotalDays);

            StudentMaster."7 FA Start Date" := StudentMaster."6 FA End Date" + 3;
            StudentMaster."7 FA End Date" := GetEndDate(StudentMaster."7 FA Start Date", NoRotationTotalDays);

            StudentMaster."8 FA Start Date" := StudentMaster."7 FA End Date" + 3;
            StudentMaster."8 FA End Date" := GetEndDate(StudentMaster."8 FA Start Date", NoRotationTotalDays);

            if StudentMaster."Estimated Graduation Date" < StudentMaster."8 FA End Date" then
                StudentMaster."Estimated Graduation Date" := StudentMaster."8 FA End Date";

            StudentMaster.Modify();
            exit;
        end;

        DaysCompleted := 0;
        StartDate := 0D;
        EndDate := 0D;
        NextSemesterStartDate := 0D;
        LastUsedRotationDate := 0D;
        RLEFound := false;

        RLE.Reset();
        RLE.SetCurrentKey("Student ID", "Start Date");
        RLE.SetRange("Student ID", StudentMaster."No.");
        RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4', 'X', 'TC', 'UC', 'SC');
        if RLE.FindSet() then
            repeat
                RLEFound := true;
                DaysCompleted := DaysCompleted + GetDifferenceOfDays(RLE."Start Date", RLE."End Date");
                LastUsedRotationDate := RLE."Start Date";

                if StartDate = 0D then
                    StartDate := RLE."Start Date";

                if (DaysCompleted = PerSemesterDaysRequired) then begin
                    EndDate := RLE."End Date";
                    DaysCompleted := 0;
                    NextSemesterStartDate := 0D;
                end;

                if (DaysCompleted > PerSemesterDaysRequired) then begin
                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.Ascending(false);
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', RLE."Start Date", RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                                DaysCompleted := DaysCompleted - 1;
                                EndDate := LDate."Period Start";
                            end;
                        until (LDate.Next() = 0) or (DaysCompleted < PerSemesterDaysRequired);

                    DaysCompleted := 0;
                    NextSemesterStartDate := EndDate + 3;

                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', NextSemesterStartDate, RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then
                                DaysCompleted := DaysCompleted + 1;
                        until (LDate.Next() = 0);
                end;
            until (RLE.Next() = 0) OR (EndDate <> 0D);

        StudentMaster."5 FA Start Date" := StartDate;

        if (StartDate <> 0D) and (EndDate = 0D) then begin
            NoRotationBalanceDays := ABS(NoRotationTotalDays - DaysCompleted);
            DaysCompleted := 0;

            LDate.Reset();
            LDate.SetCurrentKey("Period Type", "Period Start");
            LDate.SetRange("Period Type", LDate."Period Type"::Date);
            LDate.SetFilter("Period Start", '>=%1', RLE."End Date" + 3);
            if LDate.FindSet() then
                repeat
                    if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                        NoRotationBalanceDays := NoRotationBalanceDays - 1;
                        EndDate := LDate."Period Start";
                    end;
                until (LDate.Next() = 0) or (NoRotationBalanceDays = 0);
        end;

        StudentMaster."5 FA End Date" := EndDate;

        StartDate := 0D;
        EndDate := 0D;

        if NextSemesterStartDate <> 0D then
            StartDate := NextSemesterStartDate;

        NextSemesterStartDate := 0D;
        RLEFound := false;

        RLE.Reset();
        RLE.SetCurrentKey("Student ID", "Start Date");
        RLE.SetRange("Student ID", StudentMaster."No.");
        RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4', 'X', 'TC', 'UC', 'SC');
        RLE.SetFilter("Start Date", '>%1', LastUsedRotationDate);
        if RLE.FindSet() then
            repeat
                RLEFound := true;
                DaysCompleted := DaysCompleted + GetDifferenceOfDays(RLE."Start Date", RLE."End Date");
                LastUsedRotationDate := RLE."Start Date";

                if StartDate = 0D then
                    StartDate := RLE."Start Date";

                if (DaysCompleted = PerSemesterDaysRequired) then begin
                    EndDate := RLE."End Date";
                    DaysCompleted := 0;
                    NextSemesterStartDate := 0D;
                end;

                if (DaysCompleted > PerSemesterDaysRequired) then begin
                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.Ascending(false);
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', RLE."Start Date", RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                                DaysCompleted := DaysCompleted - 1;
                                EndDate := LDate."Period Start";
                            end;
                        until (LDate.Next() = 0) or (DaysCompleted < PerSemesterDaysRequired);

                    DaysCompleted := 0;
                    NextSemesterStartDate := EndDate + 3;

                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', NextSemesterStartDate, RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then
                                DaysCompleted := DaysCompleted + 1;
                        until (LDate.Next() = 0);
                end;
            until (RLE.Next() = 0) OR (EndDate <> 0D);

        if StartDate <> 0D then
            StudentMaster."6 FA Start Date" := StartDate
        else begin
            StudentMaster."6 FA Start Date" := StudentMaster."5 FA End Date" + 3;
            StartDate := StudentMaster."6 FA Start Date";
        end;

        if (StartDate <> 0D) and (EndDate = 0D) then begin
            NoRotationBalanceDays := ABS(NoRotationTotalDays - DaysCompleted);
            DaysCompleted := 0;

            LDate.Reset();
            LDate.SetCurrentKey("Period Type", "Period Start");
            LDate.SetRange("Period Type", LDate."Period Type"::Date);
            if RLEFound = true then
                LDate.SetFilter("Period Start", '>=%1', RLE."End Date" + 3)
            else
                LDate.SetFilter("Period Start", '>=%1', StudentMaster."6 FA Start Date");
            if LDate.FindSet() then
                repeat
                    if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                        NoRotationBalanceDays := NoRotationBalanceDays - 1;
                        EndDate := LDate."Period Start";
                    end;
                until (LDate.Next() = 0) or (NoRotationBalanceDays = 0);
        end;

        StudentMaster."6 FA End Date" := EndDate;

        StartDate := 0D;
        EndDate := 0D;

        if NextSemesterStartDate <> 0D then
            StartDate := NextSemesterStartDate;

        NextSemesterStartDate := 0D;
        RLEFound := false;

        RLE.Reset();
        RLE.SetCurrentKey("Student ID", "Start Date");
        RLE.SetRange("Student ID", StudentMaster."No.");
        RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4', 'X', 'TC', 'UC', 'SC');
        RLE.SetFilter("Start Date", '>%1', LastUsedRotationDate);
        if RLE.FindSet() then
            repeat
                RLEFound := true;
                DaysCompleted := DaysCompleted + GetDifferenceOfDays(RLE."Start Date", RLE."End Date");
                LastUsedRotationDate := RLE."Start Date";

                if StartDate = 0D then
                    StartDate := RLE."Start Date";

                if (DaysCompleted = PerSemesterDaysRequired) then begin
                    EndDate := RLE."End Date";
                    DaysCompleted := 0;
                    NextSemesterStartDate := 0D;
                end;

                if (DaysCompleted > PerSemesterDaysRequired) then begin
                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.Ascending(false);
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', RLE."Start Date", RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                                DaysCompleted := DaysCompleted - 1;
                                EndDate := LDate."Period Start";
                            end;
                        until (LDate.Next() = 0) or (DaysCompleted < PerSemesterDaysRequired);

                    DaysCompleted := 0;
                    NextSemesterStartDate := EndDate + 3;

                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', NextSemesterStartDate, RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then
                                DaysCompleted := DaysCompleted + 1;
                        until (LDate.Next() = 0);
                end;
            until (RLE.Next() = 0) OR (EndDate <> 0D);

        if StartDate <> 0D then
            StudentMaster."7 FA Start Date" := StartDate
        else begin
            StudentMaster."7 FA Start Date" := StudentMaster."6 FA End Date" + 3;
            StartDate := StudentMaster."7 FA Start Date";
        end;

        if (StartDate <> 0D) and (EndDate = 0D) then begin
            NoRotationBalanceDays := ABS(NoRotationTotalDays - DaysCompleted);
            DaysCompleted := 0;

            LDate.Reset();
            LDate.SetCurrentKey("Period Type", "Period Start");
            LDate.SetRange("Period Type", LDate."Period Type"::Date);
            if RLEFound = true then
                LDate.SetFilter("Period Start", '>=%1', RLE."End Date" + 3)
            else
                LDate.SetFilter("Period Start", '>=%1', StudentMaster."7 FA Start Date");
            if LDate.FindSet() then
                repeat
                    if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                        NoRotationBalanceDays := NoRotationBalanceDays - 1;
                        EndDate := LDate."Period Start";
                    end;
                until (LDate.Next() = 0) or (NoRotationBalanceDays = 0);
        end;

        StudentMaster."7 FA End Date" := EndDate;

        StartDate := 0D;
        EndDate := 0D;

        if NextSemesterStartDate <> 0D then
            StartDate := NextSemesterStartDate;

        NextSemesterStartDate := 0D;
        RLEFound := false;

        RLE.Reset();
        RLE.SetCurrentKey("Student ID", "Start Date");
        RLE.SetRange("Student ID", StudentMaster."No.");
        RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4', 'X', 'TC', 'UC', 'SC');
        RLE.SetFilter("Start Date", '>%1', LastUsedRotationDate);
        if RLE.FindSet() then
            repeat
                RLEFound := true;
                DaysCompleted := DaysCompleted + GetDifferenceOfDays(RLE."Start Date", RLE."End Date");
                LastUsedRotationDate := RLE."Start Date";

                if StartDate = 0D then
                    StartDate := RLE."Start Date";

                if (DaysCompleted = PerSemesterDaysRequired) then begin
                    EndDate := RLE."End Date";
                    DaysCompleted := 0;
                    NextSemesterStartDate := 0D;
                end;

                if (DaysCompleted > PerSemesterDaysRequired) then begin
                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.Ascending(false);
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', RLE."Start Date", RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                                DaysCompleted := DaysCompleted - 1;
                                EndDate := LDate."Period Start";
                            end;
                        until (LDate.Next() = 0) or (DaysCompleted < PerSemesterDaysRequired);

                    DaysCompleted := 0;
                    NextSemesterStartDate := EndDate + 3;

                    LDate.Reset();
                    LDate.SetCurrentKey("Period Type", "Period Start");
                    LDate.SetRange("Period Type", LDate."Period Type"::Date);
                    LDate.SetFilter("Period Start", '%1..%2', NextSemesterStartDate, RLE."End Date");
                    if LDate.FindSet() then
                        repeat
                            if not (LDate."Period Name" in ['Saturday', 'Sunday']) then
                                DaysCompleted := DaysCompleted + 1;
                        until (LDate.Next() = 0);
                end;
            until (RLE.Next() = 0) OR (EndDate <> 0D);

        if StartDate <> 0D then
            StudentMaster."8 FA Start Date" := StartDate
        else begin
            StudentMaster."8 FA Start Date" := StudentMaster."7 FA End Date" + 3;
            StartDate := StudentMaster."8 FA Start Date";
        end;

        if (StartDate <> 0D) and (EndDate <> 0D) then begin
            RLELast.Reset();
            RLELast.SetCurrentKey("Student ID", "Start Date");
            RLELast.SetRange("Student ID", StudentMaster."No.");
            RLELast.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4', 'X', 'TC', 'UC', 'SC');
            RLELast.SetFilter("End Date", '>%1', EndDate);
            if RLELast.FindLast() then
                EndDate := RLELast."End Date";
        end;

        if (StartDate <> 0D) and (EndDate = 0D) then begin
            NoRotationBalanceDays := ABS(NoRotationTotalDays - DaysCompleted);
            DaysCompleted := 0;

            LDate.Reset();
            LDate.SetCurrentKey("Period Type", "Period Start");
            LDate.SetRange("Period Type", LDate."Period Type"::Date);
            if RLEFound = true then
                LDate.SetFilter("Period Start", '>=%1', RLE."End Date" + 3)
            else
                LDate.SetFilter("Period Start", '>=%1', StudentMaster."8 FA Start Date");
            if LDate.FindSet() then
                repeat
                    if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                        NoRotationBalanceDays := NoRotationBalanceDays - 1;
                        EndDate := LDate."Period Start";
                    end;
                until (LDate.Next() = 0) or (NoRotationBalanceDays = 0);
        end;

        StudentMaster."8 FA End Date" := EndDate;
        StudentMaster."Estimated Graduation Date" := 0D;

        if StudentMaster."Estimated Graduation Date" <= StudentMaster."8 FA End Date" + CKExamAdditionalDays then
            StudentMaster."Estimated Graduation Date" := StudentMaster."8 FA End Date" + CKExamAdditionalDays;

        if StudentMaster."Estimated Graduation Date" < CKExamDate then
            StudentMaster."Estimated Graduation Date" := CKExamDate;

        StudentMaster."Island Departure Date" := 0D;
        if (StudentMaster.Nationality <> 'AG') and (StudentMaster."Global Dimension 1 Code" = '9100') then
            StudentMaster."Island Departure Date" := StudentMaster."Estimated Graduation Date";
        StudentMaster.Modify();
    end;

    procedure GetDifferenceOfDays(LStartDate: Date; LEndDate: Date) NoOfDays: Integer
    var
        LDate: Record Date;
    begin
        NoOfDays := 0;
        LDate.Reset();
        LDate.SetCurrentKey("Period Type", "Period Start");
        LDate.SetRange("Period Type", LDate."Period Type"::Date);
        LDate.SetFilter("Period Start", '%1..%2', LStartDate, LEndDate);
        if LDate.FindSet() then
            repeat
                if not (LDate."Period Name" in ['Saturday', 'Sunday']) then
                    NoOfDays := NoOfDays + 1;
            until (LDate.Next() = 0);
    end;

    procedure GetEndDate(LStartDate: Date; NoOfDays: Integer) LEndDate: Date
    var
        LDate: Record Date;
    begin
        LDate.Reset();
        LDate.SetCurrentKey("Period Type", "Period Start");
        LDate.SetRange("Period Type", LDate."Period Type"::Date);
        LDate.SetFilter("Period Start", '>=%1', LStartDate);
        if LDate.FindSet() then
            repeat
                if not (LDate."Period Name" in ['Saturday', 'Sunday']) then begin
                    NoOfDays := NoOfDays - 1;
                    LEndDate := LDate."Period Start";
                end;
            until (LDate.Next() = 0) or (NoOfDays = 0);
    end;
}