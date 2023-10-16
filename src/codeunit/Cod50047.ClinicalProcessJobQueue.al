codeunit 50047 "Clinical Process Job Queqe"
{
    trigger OnRun()
    begin

    end;


    procedure TWDAnalysis(StudentNo: Code[20]; ViewOnly: Boolean; TWDAction: Boolean; Var TWDApplicableCount: Integer) TWDApplicable: Boolean;
    var
        RSL: Record "Roster Scheduling Line";
        RSL_Next: Record "Roster Scheduling Line";
        RSL_Future: Record "Roster Scheduling Line";
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentSubject_lRec: Record "Main Student Subject-CS";
        StudentSubjectExam_lRec: Record "Student Subject Exam";
        RosterLedgerEntry_lRec: Record "Roster Ledger Entry";
        RosterLedgerEntry_lRec1: Record "Roster Ledger Entry";
        Date_lRec: Record Date;
        WeekStartDate: Date;
        BSICFound: Boolean;
        CBSEExamDate: Date;
        ToDateCheck: Date;
        WindowDialog: Dialog;
        TempStartDate: Date;
        TempEndDate: Date;
        Text001Lbl: Label 'Student Name      ############1################\';
        ClinicalCurriculum: Integer;
        TotalWeeks: Integer;
    begin
        WindowDialog.Open('Checking for TWD Status...\' + Text001Lbl);

        TWDApplicable := false;

        ClinicalCurriculum := 0;
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", StudentNo);
        if StudentMaster.FindFirst() then begin
            WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

            StudentStatus.Reset();
            StudentStatus.SetRange(Code, StudentMaster.Status);
            if StudentStatus.FindFirst() then;

            if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
            StudentStatus.Status::TWD,
            StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
            StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
            StudentStatus.Status::"Re-Entry", StudentStatus.Status::"Re-Admitted",
            StudentStatus.Status::Suspension]) then begin
                // StudentMaster.CalcFields("Step 2 CK Exam Pass");
                // If StudentMaster."Step 2 CK Exam Pass" then begin

                IF StudentMaster."Clinical Curriculum" <> StudentMaster."Clinical Curriculum"::" " then
                    Evaluate(ClinicalCurriculum, Format(StudentMaster."Clinical Curriculum"))
                Else
                    ClinicalCurriculum := 0;

                TotalWeeks := 0;
                RSL.Reset();
                RSL.SetCurrentKey("Student No.", "End Date");
                RSL.SetRange("Student No.", StudentMaster."No.");
                RSL.SetFilter("End Date", '<%1', Today());
                RSL.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                if RSL.FindSet() then
                    repeat
                        TotalWeeks := TotalWeeks + RSL."No. of Weeks";
                    until RSL.Next() = 0;

                If TotalWeeks >= ClinicalCurriculum then
                    exit(TWDApplicable);
                // end;


                RSL.Reset();
                RSL.SetCurrentKey("Student No.", "Start Date");
                RSL.SetRange("Student No.", StudentMaster."No.");
                RSL.SetFilter("Start Date", '<=%1&<>%2', Today, 0D);
                RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                if RSL.FindLast() then
                    if RSL."End Date" < Today then begin
                        ToDateCheck := RSL."End Date" + 31;
                        RSL_Next.Reset();
                        RSL_Next.SetCurrentKey("Student No.", "Start Date");
                        RSL_Next.SetRange("Student No.", RSL."Student No.");
                        RSL_Next.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                        RSL_Next.SetFilter("Start Date", '%1..%2', RSL."End Date", ToDateCheck);
                        if not RSL_Next.FindFirst() then
                            TWDApplicable := true;
                    end;

                RSL_Future.Reset();
                RSL_Future.SetCurrentKey("Student No.", "Start Date");
                RSL_Future.SetRange("Student No.", RSL."Student No.");
                RSL_Future.SetFilter(Status, '%1', RSL.Status::Published);
                RSL_Future.SetFilter("End Date", '>%1', Today);
                if not RSL_Future.FindFirst() then
                    TWDApplicable := true;

                If StudentMaster.Semester = 'CLN5' then begin
                    RosterLedgerEntry_lRec.Reset();
                    RosterLedgerEntry_lRec.SetCurrentKey("Student ID", "Start Date");
                    RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                    RosterLedgerEntry_lRec.Setfilter("Start Date", '<=%1', Today());
                    RosterLedgerEntry_lRec.SetFilter("End Date", '>=%1', Today());
                    IF RosterLedgerEntry_lRec.FindLast() then begin
                        TWDApplicable := false;
                        Exit(TWDApplicable);
                    end;

                    RosterLedgerEntry_lRec.Reset();
                    RosterLedgerEntry_lRec.SetCurrentKey("Student ID", "Start Date");
                    RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                    RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                    RosterLedgerEntry_lRec.SetFilter("End Date", '<=%1', Today());
                    IF RosterLedgerEntry_lRec.FindLast() then begin
                        TempStartDate := RosterLedgerEntry_lRec."End Date";
                        IF TempStartDate <> 0D then
                            TempStartDate := CalcDate('31D', TempStartDate);

                        RosterLedgerEntry_lRec1.Reset();
                        RosterLedgerEntry_lRec1.SetCurrentKey("Student ID", "Start Date");
                        RosterLedgerEntry_lRec1.SetRange("Student ID", StudentMaster."No.");
                        RosterLedgerEntry_lRec1.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec1.Status::Cancelled);
                        RosterLedgerEntry_lRec1.Setfilter("Start Date", '<=%1', TempStartDate);
                        RosterLedgerEntry_lRec1.SetFilter("End Date", '>=%1', TempStartDate);
                        If RosterLedgerEntry_lRec1.FindLast() then begin
                            TWDApplicable := false;
                            TempStartDate := 0D;
                            exit(TWDApplicable);

                        end;
                    end;


                    BSICFound := false;
                    StudentSubject_lRec.Reset();
                    StudentSubject_lRec.SetCurrentKey("End Date");
                    StudentSubject_lRec.Ascending(false);
                    StudentSubject_lRec.SetRange("Original Student No.", StudentMaster."Original Student No.");
                    //StudentSubject_lRec.SetRange(Course, StudentMaster."Course Code");
                    StudentSubject_lRec.SetRange(Semester, 'BSIC');
                    // StudentSubject_lRec.SetRange("Academic Year", StudentMaster."Academic Year");
                    // StudentSubject_lRec.SetRange(Term, StudentMaster.Term);
                    If StudentSubject_lRec.FindFirst() then begin
                        BSICFound := true;
                        TempStartDate := StudentSubject_lRec."End Date";
                    end;

                    If not BSICFound then begin
                        StudentSubject_lRec.Reset();
                        StudentSubject_lRec.SetCurrentKey("End Date");
                        StudentSubject_lRec.Ascending(false);
                        StudentSubject_lRec.SetRange("Original Student No.", StudentMaster."Original Student No.");
                        //StudentSubject_lRec.SetRange(Course, StudentMaster."Course Code");
                        StudentSubject_lRec.SetRange(Semester, 'MED4');
                        // StudentSubject_lRec.SetRange("Academic Year", StudentMaster."Academic Year");
                        // StudentSubject_lRec.SetRange(Term, StudentMaster.Term);
                        If StudentSubject_lRec.FindFirst() then
                            TempStartDate := StudentSubject_lRec."End Date";
                    end;

                    IF TempStartDate <> 0D then
                        TempEndDate := CalcDate('<3W>', TempStartDate);


                    WeekStartDate := 0D;
                    StudentSubjectExam_lRec.Reset();
                    StudentSubjectExam_lRec.SetCurrentKey("Sitting Date");
                    StudentSubjectExam_lRec.SetRange("Student No.", StudentMaster."No.");
                    StudentSubjectExam_lRec.SetRange("Score Type", StudentSubjectExam_lRec."Score Type"::CBSE);
                    StudentSubjectExam_lRec.SetRange("Sitting Date", TempStartDate, TempEndDate);
                    IF StudentSubjectExam_lRec.FindLast() then begin
                        CBSEExamDate := StudentSubjectExam_lRec."Sitting Date";
                        RosterLedgerEntry_lRec.Reset();
                        RosterLedgerEntry_lRec.SetRange("Clerkship Type", RosterLedgerEntry_lRec."Clerkship Type"::"FM1/IM1");
                        RosterLedgerEntry_lRec.SetRange("Student ID", StudentMaster."No.");
                        If RosterLedgerEntry_lRec.FindLast() then begin
                            CBSEExamDate := CalcDate('<180D>', CBSEExamDate);
                            If (CBSEExamDate >= RosterLedgerEntry_lRec."Start Date") or (CBSEExamDate <= RosterLedgerEntry_lRec."End Date") then begin
                                Date_lRec.Reset();
                                Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                                Date_lRec.SetRange("Period Start", CBSEExamDate);
                                If Date_lRec.FindFirst() then begin
                                    IF Date_lRec."Period Name" in ['Monday', 'Tuesday', 'Wednesday'] then begin
                                        IF Date_lRec."Period Name" = 'Monday' then
                                            WeekStartDate := CBSEExamDate;
                                        If Date_lRec."Period Name" = 'Tuesday' then
                                            WeekStartDate := CBSEExamDate - 1;
                                        If Date_lRec."Period Name" = 'Wednesday' then
                                            WeekStartDate := CBSEExamDate - 2;
                                    end;
                                    IF Date_lRec."Period Name" in ['Thursday', 'Friday', 'Saturday', 'Sunday'] then begin
                                        IF Date_lRec."Period Name" = 'Thursday' then
                                            WeekStartDate := CBSEExamDate + 4;
                                        If Date_lRec."Period Name" = 'Friday' then
                                            WeekStartDate := CBSEExamDate + 3;
                                        If Date_lRec."Period Name" = 'Saturday' then
                                            WeekStartDate := CBSEExamDate + 2;
                                        If Date_lRec."Period Name" = 'Sunday' then
                                            WeekStartDate := CBSEExamDate + 1;
                                    end;

                                end;

                            end;
                        end;

                        RosterLedgerEntry_lRec1.Reset();
                        RosterLedgerEntry_lRec1.SetRange("Student ID", StudentMaster."No.");
                        RosterLedgerEntry_lRec1.SetRange("Clerkship Type", RosterLedgerEntry_lRec1."Clerkship Type"::"FM1/IM1");
                        RosterLedgerEntry_lRec.SetRange("Start Date", WeekStartDate);
                        If RosterLedgerEntry_lRec1.FindLast() then begin
                            If RosterLedgerEntry_lRec1."Start Date" < Today() then
                                TWDApplicable := true;
                        end;
                    end;
                end;

                if TWDApplicable then
                    TWDApplicableCount := TWDApplicableCount + 1;

                // if (TWDAction = true) and (TWDApplicable = true) then
                //     StudentStatusChangeToTWD(StudentMaster."No.");

                if (ViewOnly = true) then
                    exit(TWDApplicable)
            end;
        end;
    end;

    procedure StudentStatusChangeToTWD(StudentNo: Code[20])
    var
        StudentMaster: Record "Student Master-CS";
        TWDStudentStatus: Record "Student Status";
        ClinicalNotification: Codeunit "Clinical Notification";
    begin
        TWDStudentStatus.Reset();
        TWDStudentStatus.SetRange(Status, TWDStudentStatus.Status::TWD);
        if TWDStudentStatus.FindLast() then begin
            StudentMaster.Reset();
            StudentMaster.SetRange("No.", StudentNo);
            if StudentMaster.FindFirst() then begin
                //ClinicalNotification.SendTWDEmail(StudentMaster."No.");
                StudentMaster.Validate(Status, TWDStudentStatus.Code);
                StudentMaster.Modify();
            end;
        end;
    end;
}