report 50272 "Student LDA Automation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = where("Course Code" = filter(<> ''));
            Trigger OnPreDataItem()
            Begin
                SetFilter("Global Dimension 1 Code", '9000');
                // TempExcelBuffer.Reset();
                // TempExcelBuffer.DeleteAll();

                // TempExcelBuffer.AddColumn('Student ID', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('SLcM No.', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Student Name', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Enrollment No.', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Course', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Semester', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Academic Year', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Term', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Status', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn('Last Date of Attendance', false, '', True, false, True, '', TempExcelBuffer."Cell Type"::Text);

                // WindowDialog.Open('Fetching Students\' + Text001Lbl);
                // CtrTot := "Student Master-CS".Count();

            End;

            Trigger OnAfterGetRecord()
            var
                SemesterMaster_lRec: Record "Semester Master-CS";
                CourseSemesterMaster_lRec: Record "Course Sem. Master-CS";
                RosterLedgerEntry_lRec: Record "Roster Ledger Entry";
                RosterLedgerEntry_lRec1: Record "Roster Ledger Entry";
                StudentSubjectExam_lRec: Record "Student Subject Exam";
                StudentSubject_lRec: Record "Main Student Subject-CS";
                StudentStatus: Record "Student Status";
                Date_lRec: Record Date;
                EndDate: Date;
                EndDate1: Date;
                FilterDate1: Date;
                FilterDate2: Date;
                AYInt: Integer;
                AYCode: Code[10];
                ClinicalNotAttending: Boolean;
            begin
                EndDate := 0D;
                EndDate1 := 0D;
                AYCode := '';
                AYInt := 0;
                StudentStatus.Reset();
                StudentStatus.SetRange(Code, "Student Master-CS".Status);
                If StudentStatus.FindFirst() then begin
                    SemesterMaster_lRec.Reset();
                    SemesterMaster_lRec.SetRange(Code, "Student Master-CS".Semester);
                    If SemesterMaster_lRec.FindFirst() then begin
                        If SemesterMaster_lRec.Sequence in [1, 2, 3, 4, 5] then begin

                            If StudentStatus.Status In [StudentStatus.Status::Active, StudentStatus.Status::Probation, StudentStatus.Status::ELOA, StudentStatus.Status::SLOA, StudentStatus.Status::TWD, StudentStatus.Status::Enrolled] then begin

                                FilterDate1 := 0D;
                                FilterDate2 := 0D;
                                Date_lRec.Reset();
                                Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                                Date_lRec.SetRange("Period Start", Today());
                                IF Date_lRec.FindFirst() then begin
                                    If Date_lRec."Period Name" in ['Sunday', 'Monday'] then begin
                                        If Date_lRec."Period Name" = 'Sunday' then
                                            EndDate := Today() - 2;
                                        If Date_lRec."Period Name" = 'Monday' then
                                            EndDate := Today() - 3;
                                    end else
                                        EndDate := Today() - 1;

                                end;
                                CourseSemesterMaster_lRec.Reset();
                                CourseSemesterMaster_lRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                                CourseSemesterMaster_lRec.SetRange("Semester Code", "Student Master-CS".Semester);
                                CourseSemesterMaster_lRec.SetRange("Academic Year", "Student Master-CS"."Academic Year");
                                CourseSemesterMaster_lRec.SetRange(Term, "Student Master-CS".Term);
                                IF CourseSemesterMaster_lRec.FindFirst() then
                                    FilterDate1 := CourseSemesterMaster_lRec."End Date";

                                Evaluate(AYInt, "Student Master-CS"."Academic Year");
                                AYCode := Format(AYInt + 1);
                                CourseSemesterMaster_lRec.Reset();
                                CourseSemesterMaster_lRec.SetRange("Course Code", "Student Master-CS"."Course Code");
                                CourseSemesterMaster_lRec.SetRange("Semester Code", "Student Master-CS".Semester);
                                IF "Student Master-CS".Term = "Student Master-CS".Term::SPRING then begin
                                    CourseSemesterMaster_lRec.SetRange("Academic Year", "Student Master-CS"."Academic Year");
                                    CourseSemesterMaster_lRec.SetRange(Term, CourseSemesterMaster_lRec.Term::FALL);
                                end;
                                IF "Student Master-CS".Term = "Student Master-CS".Term::FALL then begin
                                    CourseSemesterMaster_lRec.SetRange("Academic Year", AYCode);
                                    CourseSemesterMaster_lRec.SetRange(Term, CourseSemesterMaster_lRec.Term::SPRING);
                                end;
                                IF CourseSemesterMaster_lRec.FindFirst() then
                                    FilterDate2 := CourseSemesterMaster_lRec."Start Date";

                                IF (Today() > FilterDate1) and (Today() < FilterDate2) then
                                    EndDate := FilterDate1;

                                EndDate1 := 0D;
                                StudentSubjectExam_lRec.Reset();
                                StudentSubjectExam_lRec.SetCurrentKey("Sitting Date");
                                StudentSubjectExam_lRec.SetRange("Student No.", "Student Master-CS"."No.");
                                StudentSubjectExam_lRec.SetFilter("Score Type", '%1|%2', StudentSubjectExam_lRec."Score Type"::CBSE, StudentSubjectExam_lRec."Score Type"::"STEP 1");
                                IF StudentSubjectExam_lRec.FindLast() then begin
                                    EndDate1 := StudentSubjectExam_lRec."Sitting Date";
                                    If EndDate1 > EndDate then
                                        EndDate := EndDate1;
                                end;

                                Ctr += 1;

                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr));
                                "Student Master-CS".LDA := EndDate;
                                "Student Master-CS".Modify();
                                // TempExcelBuffer.NewRow();
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Student Name", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Enrollment No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Academic Year", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format("Student Master-CS".Term), false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format(EndDate), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date);
                            end;
                            If StudentStatus.Status in [StudentStatus.Status::Withdrawn, StudentStatus.Status::Dismissed, StudentStatus.Status::Deceased, StudentStatus.Status::ADWD, StudentStatus.Status::Declined, StudentStatus.Status::Compeleted, StudentStatus.Status::Promoted] then begin

                                Ctr += 1;

                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr));
                                IF "Student Master-CS".LDA <> 0D then
                                    "Student Master-CS".LDA := "Student Master-CS".LDA
                                Else
                                    "Student Master-CS".LDA := "Student Master-CS"."NSLDS Withdrawal Date";
                                "Student Master-CS".Modify();
                                // TempExcelBuffer.NewRow();
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Student Name", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Enrollment No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Academic Year", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format("Student Master-CS".Term), false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // IF "Student Master-CS".LDA <> 0D then
                                //     TempExcelBuffer.AddColumn(Format("Student Master-CS".LDA), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date)
                                // else
                                //     TempExcelBuffer.AddColumn(Format("Student Master-CS"."NSLDS Withdrawal Date"), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date);

                            end;
                        end;
                        If SemesterMaster_lRec.Sequence > 5 then begin
                            IF StudentStatus.Status In [StudentStatus.Status::Active, StudentStatus.Status::Suspension, StudentStatus.Status::Probation] then begin

                                // RosterLedgerEntry_lRec.Reset();
                                // //RosterLedgerEntry_lRec.SetCurrentKey("End Date");
                                // RosterLedgerEntry_lRec.SetRange("Student ID", "Student Master-CS"."No.");
                                // //RosterLedgerEntry_lRec.SetFilter(Status, '%1', RosterLedgerEntry_lRec.Status::Completed);
                                // RosterLedgerEntry_lRec.SetRange("End Date", 0D);
                                // If RosterLedgerEntry_lRec.FindLast() then begin
                                Date_lRec.Reset();
                                Date_lRec.SetRange("Period Type", Date_lRec."Period Type"::Date);
                                Date_lRec.SetRange("Period Start", Today());
                                IF Date_lRec.FindFirst() then begin
                                    If Date_lRec."Period Name" in ['Sunday', 'Monday'] then begin
                                        If Date_lRec."Period Name" = 'Sunday' then
                                            EndDate := Today() - 2;
                                        If Date_lRec."Period Name" = 'Monday' then
                                            EndDate := Today() - 3;
                                    end else
                                        EndDate := Today() - 1;

                                    Ctr += 1;
                                    //WindowDialog.Update(1, "Student Master-CS"."No." + ' ' + format(Ctr) + ' of ' + Format(CtrTot));
                                    //WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr));
                                    "Student Master-CS".LDA := EndDate;
                                    "Student Master-CS".Modify();
                                    // TempExcelBuffer.NewRow();
                                    // TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS"."Student Name", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS"."Enrollment No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS"."Academic Year", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn(Format("Student Master-CS".Term), false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                    // TempExcelBuffer.AddColumn(Format(EndDate), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date);
                                    // end;

                                end;
                            end;
                            ClinicalNotAttending := false;
                            IF StudentStatus.Status in [StudentStatus.Status::TWD, StudentStatus.Status::CLOA, StudentStatus.Status::Suspension, StudentStatus.Status::Active, StudentStatus.Status::Probation, StudentStatus.Status::"Re-Admitted", StudentStatus.Status::"Re-Entry"] then begin
                                RosterLedgerEntry_lRec.Reset();
                                RosterLedgerEntry_lRec.SetCurrentKey("End Date");
                                RosterLedgerEntry_lRec.SetRange("Student ID", "Student Master-CS"."No.");
                                RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                                RosterLedgerEntry_lRec.SetFilter("End Date", '<=%1', Today());
                                If RosterLedgerEntry_lRec.FindLast() then begin
                                    RosterLedgerEntry_lRec1.Reset();
                                    RosterLedgerEntry_lRec1.SetCurrentKey("Start Date");
                                    RosterLedgerEntry_lRec1.SetRange("Student ID", "Student Master-CS"."No.");
                                    RosterLedgerEntry_lRec1.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                                    RosterLedgerEntry_lRec1.SetFilter("Start Date", '>=%1', RosterLedgerEntry_lRec."End Date");
                                    RosterLedgerEntry_lRec1.SetFilter("Start Date", '<=%1', Today());
                                    IF not RosterLedgerEntry_lRec1.FindFirst() then begin
                                        EndDate := RosterLedgerEntry_lRec."End Date";
                                    end;
                                end;

                                EndDate1 := 0D;
                                StudentSubjectExam_lRec.Reset();
                                StudentSubjectExam_lRec.SetCurrentKey("Student No.", "Sitting Date");
                                StudentSubjectExam_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                StudentSubjectExam_lRec.SetFilter("Score Type", '%1|%2|%3', StudentSubjectExam_lRec."Score Type"::CCSE, StudentSubjectExam_lRec."Score Type"::CCSSE, StudentSubjectExam_lRec."Score Type"::"STEP 2 CK");
                                StudentSubjectExam_lRec.SetFilter("Sitting Date", '<=%1', Today());
                                IF StudentSubjectExam_lRec.FindLast() then
                                    EndDate1 := StudentSubjectExam_lRec."Sitting Date";

                                IF EndDate1 >= EndDate then
                                    EndDate := EndDate1
                                Else
                                    EndDate := EndDate;

                                If EndDate = 0D then begin
                                    EndDate1 := 0D;
                                    StudentSubjectExam_lRec.Reset();
                                    StudentSubjectExam_lRec.SetCurrentKey("Student No.", "Sitting Date");
                                    StudentSubjectExam_lRec.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                    StudentSubjectExam_lRec.Setrange("Score Type", StudentSubjectExam_lRec."Score Type"::"STEP 1");
                                    StudentSubjectExam_lRec.SetFilter("Sitting Date", '<=%1', Today());
                                    IF StudentSubjectExam_lRec.FindLast() then
                                        EndDate1 := StudentSubjectExam_lRec."Sitting Date";

                                    IF EndDate1 >= EndDate then
                                        EndDate := EndDate1
                                    Else
                                        EndDate := EndDate;
                                end;

                                Ctr += 1;
                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' ' + format(Ctr) + ' of ' + Format(CtrTot));
                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr));

                                IF EndDate <> 0D then
                                    "Student Master-CS".LDA := EndDate
                                Else begin
                                    IF "Student Master-CS".LDA <> 0D then
                                        "Student Master-CS".LDA := "Student Master-CS".LDA;
                                End;
                                "Student Master-CS".Modify();
                                // TempExcelBuffer.NewRow();
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Student Name", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Enrollment No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Academic Year", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format("Student Master-CS".Term), false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // If EndDate <> 0D then
                                //     TempExcelBuffer.AddColumn(Format(EndDate), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date)
                                // Else begin
                                //     If "Student Master-CS".LDA <> 0D then
                                //         TempExcelBuffer.AddColumn(Format("Student Master-CS".LDA), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date);
                                // end;
                            end;
                            // "Student Master-CS"."Last Date Of Attendance" := EndDate;
                            // "Student Master-CS".Modify();



                            If StudentStatus.Status in [StudentStatus.Status::Withdrawn, StudentStatus.Status::Dismissed, StudentStatus.Status::Deceased, StudentStatus.Status::ADWD, StudentStatus.Status::Declined] then begin
                                RosterLedgerEntry_lRec.Reset();
                                RosterLedgerEntry_lRec.SetCurrentKey("End Date");
                                RosterLedgerEntry_lRec.SetRange("Student ID", "Student Master-CS"."No.");
                                RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                                RosterLedgerEntry_lRec.SetFilter("End Date", '<=%1', Today);
                                If RosterLedgerEntry_lRec.FindLast() then begin

                                    EndDate := RosterLedgerEntry_lRec."End Date";

                                end;
                                EndDate1 := 0D;
                                StudentSubjectExam_lRec.Reset();
                                StudentSubjectExam_lRec.SetCurrentKey("Sitting Date");
                                StudentSubjectExam_lRec.SetRange("Student No.", "Student Master-CS"."No.");
                                StudentSubjectExam_lRec.SetFilter("Score Type", '%1|%2|%3', StudentSubjectExam_lRec."Score Type"::CCSE, StudentSubjectExam_lRec."Score Type"::CCSSE, StudentSubjectExam_lRec."Score Type"::"STEP 2 CK");
                                StudentSubjectExam_lRec.SetFilter("Sitting Date", '<=%1', Today());
                                If StudentSubjectExam_lRec.FindLast() then
                                    EndDate1 := StudentSubjectExam_lRec."Sitting Date";

                                If EndDate >= EndDate1 then
                                    EndDate := EndDate;
                                If EndDate1 > EndDate then
                                    EndDate := EndDate1;

                                Ctr += 1;
                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' ' + format(Ctr) + ' of ' + Format(CtrTot));
                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr));

                                IF EndDate <> 0D then
                                    "Student Master-CS".LDA := EndDate
                                Else begin
                                    If "Student Master-CS".LDA <> 0D then
                                        "Student Master-CS".LDA := "Student Master-CS".LDA
                                    Else
                                        "Student Master-CS".LDA := "Student Master-CS"."NSLDS Withdrawal Date";

                                end;
                                "Student Master-CS".Modify();
                                // TempExcelBuffer.NewRow();
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Student Name", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Enrollment No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Academic Year", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format("Student Master-CS".Term), false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // IF EndDate <> 0D then
                                //     TempExcelBuffer.AddColumn(Format(EndDate), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date)
                                // Else begin
                                //     IF "Student Master-CS".LDA <> 0D then
                                //         TempExcelBuffer.AddColumn(Format("Student Master-CS".LDA), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date)
                                //     Else
                                //         TempExcelBuffer.AddColumn(Format("Student Master-CS"."NSLDS Withdrawal Date"), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date)
                                // end;
                                // "Student Master-CS"."Last Date Of Attendance" := EndDate;
                                // "Student Master-CS".Modify();

                            end;

                            If StudentStatus.Status in [StudentStatus.Status::"Pending Graduation", StudentStatus.Status::Graduated] then begin
                                RosterLedgerEntry_lRec.Reset();
                                RosterLedgerEntry_lRec.SetCurrentKey("End Date");
                                RosterLedgerEntry_lRec.SetRange("Student ID", "Student Master-CS"."No.");
                                RosterLedgerEntry_lRec.SetFilter(Status, '<>%1', RosterLedgerEntry_lRec.Status::Cancelled);
                                RosterLedgerEntry_lRec.SetFilter("End Date", '<=%1', Today);
                                If RosterLedgerEntry_lRec.FindLast() then begin

                                    EndDate := RosterLedgerEntry_lRec."End Date";

                                end;
                                EndDate1 := 0D;
                                StudentSubjectExam_lRec.Reset();
                                StudentSubjectExam_lRec.SetCurrentKey("Sitting Date");
                                StudentSubjectExam_lRec.SetRange("Student No.", "Student Master-CS"."No.");
                                StudentSubjectExam_lRec.SetFilter("Score Type", '%1|%2', StudentSubjectExam_lRec."Score Type"::"STEP 2 CS", StudentSubjectExam_lRec."Score Type"::"STEP 2 CK");
                                StudentSubjectExam_lRec.SetFilter("Sitting Date", '<=%1', Today());
                                If StudentSubjectExam_lRec.FindLast() then
                                    EndDate1 := StudentSubjectExam_lRec."Sitting Date";

                                If EndDate >= EndDate1 then
                                    EndDate := EndDate;
                                If EndDate1 > EndDate then
                                    EndDate := EndDate1;

                                Ctr += 1;
                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' ' + format(Ctr) + ' of ' + Format(CtrTot));
                                //WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(Ctr));

                                "Student Master-CS".LDA := EndDate;
                                "Student Master-CS".Modify();
                                // TempExcelBuffer.NewRow();
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Original Student No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Student Name", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Enrollment No.", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Course Code", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Semester, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS"."Academic Year", false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format("Student Master-CS".Term), false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn("Student Master-CS".Status, false, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Format(EndDate), false, '', False, False, False, 'MM-dd-yyyy', TempExcelBuffer."Cell Type"::Date);
                                // "Student Master-CS"."Last Date Of Attendance" := EndDate;
                                // "Student Master-CS".Modify();

                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                // WindowDialog.Close();
                // TempExcelBuffer.CreateNewBook('Student LDA Automation');
                // TempExcelBuffer.WriteSheet('Student LDA Automation', CompanyName, UserId);
                // TempExcelBuffer.CloseBook();
                // TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Student LDA Automation', CurrentDateTime, UserId));
                // TempExcelBuffer.OpenExcel();
            end;
        }
    }





    var
        Educationsetup_gRec: Record "Education Setup-CS";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Text001Lbl: Label 'Students No/.     ############1################\';
        WindowDialog: Dialog;
        Ctr: Integer;
        CtrTot: Integer;
}