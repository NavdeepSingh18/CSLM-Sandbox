codeunit 50033 "Fine Attendance Action-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   19/02/2019     GenerateSubjectsDetail()-Function      Code added for generate subject attendance fine.
    // 02    CSPL-00059   19/02/2019     PayFineAmount()-Function               Code added for pay fine amount .


    trigger OnRun()
    begin
    end;

    var
        Text000Lbl: Label 'Fine Amount is Zero';
        Text001Lbl: Label 'Fine is collected already for this Student';
        Text002Lbl: Label 'Fees Generated';
        Text003Lbl: Label 'Do you Pay the Attendance Fine ?';

    procedure GenerateSubjectsDetail(getCourse: Code[20]; getSemester: Code[10]; getSection: Code[10]; getAcademicYear: Code[20])
    var

        AcademicsSetupCS: Record "Academics Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        FineAttendanceHeadCS: Record "Fine Attendance Head-CS";
        FineAttendanceLineCS: Record "Fine Attendance Line-CS";
        FineAttendanceHeadCS1: Record "Fine Attendance Head-CS";
        FineAttendanceLineCS1: Record "Fine Attendance Line-CS";
        "No.seriesManagement": Codeunit "NoSeriesManagement";
        "DocuNo.": Code[20];
    begin
        //Code added for generate subject attendance fine::CSPL-00059::19022019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Attendance Fine Entry No.");
        "DocuNo." := '';

        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Eligible For Exam");
        AttendPercentageLineCS.SETRANGE("Course Code", getCourse);
        AttendPercentageLineCS.SETRANGE(Semester, getSemester);
        AttendPercentageLineCS.SETRANGE(Section, getSection);
        AttendPercentageLineCS.SETRANGE("Academic Year", getAcademicYear);
        AttendPercentageLineCS.SETRANGE("Eligible For Exam", FALSE);
        AttendPercentageLineCS.SETRANGE("Result Generated", FALSE);
        IF AttendPercentageLineCS.FINDFIRST() THEN BEGIN
            FineAttendanceHeadCS.Reset();
            FineAttendanceHeadCS.SETCURRENTKEY("Student No.", "Course Code", Semester, Section, "Academic year");
            FineAttendanceHeadCS.SETRANGE("Student No.", AttendPercentageLineCS."Student No.");
            FineAttendanceHeadCS.SETRANGE("Course Code", AttendPercentageLineCS."Course Code");
            FineAttendanceHeadCS.SETRANGE(Semester, AttendPercentageLineCS.Semester);
            FineAttendanceHeadCS.SETRANGE(Section, AttendPercentageLineCS.Section);
            FineAttendanceHeadCS.SETRANGE("Academic year", getAcademicYear);
            FineAttendanceHeadCS.SETRANGE("Result Generated", FALSE);
            IF FineAttendanceHeadCS.FINDFIRST() THEN BEGIN
                FineAttendanceLineCS1.Reset();
                FineAttendanceLineCS1.SETRANGE("Document No.", FineAttendanceHeadCS."No.");
                FineAttendanceLineCS1.DELETEALL();
            END;
        END;

        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Eligible For Exam");
        AttendPercentageLineCS.SETRANGE("Course Code", getCourse);
        AttendPercentageLineCS.SETRANGE(Semester, getSemester);
        AttendPercentageLineCS.SETRANGE(Section, getSection);
        AttendPercentageLineCS.SETRANGE("Academic Year", getAcademicYear);
        AttendPercentageLineCS.SETRANGE("Eligible For Exam", FALSE);
        AttendPercentageLineCS.SETRANGE("Result Generated", FALSE);
        IF AttendPercentageLineCS.FINDSET() THEN
            REPEAT
                FineAttendanceLineCS.INIT();
                FineAttendanceHeadCS.Reset();
                FineAttendanceHeadCS.SETCURRENTKEY("Student No.", "Course Code", Semester, Section, "Academic year");
                FineAttendanceHeadCS.SETRANGE("Student No.", AttendPercentageLineCS."Student No.");
                FineAttendanceHeadCS.SETRANGE("Course Code", AttendPercentageLineCS."Course Code");
                FineAttendanceHeadCS.SETRANGE(Semester, AttendPercentageLineCS.Semester);
                FineAttendanceHeadCS.SETRANGE(Section, AttendPercentageLineCS.Section);
                FineAttendanceHeadCS.SETRANGE("Academic year", getAcademicYear);
                FineAttendanceHeadCS.SETRANGE("Result Generated", FALSE);
                IF FineAttendanceHeadCS.ISEMPTY() then BEGIN
                    "DocuNo." := "No.seriesManagement".GetNextNo(AcademicsSetupCS."Attendance Fine Entry No.", 0D, TRUE);
                    FineAttendanceHeadCS1.INIT();
                    FineAttendanceHeadCS1."No." := "DocuNo.";
                    FineAttendanceHeadCS1."Student No." := AttendPercentageLineCS."Student No.";
                    IF StudentMasterCS.GET(AttendPercentageLineCS."Student No.") THEN
                        FineAttendanceHeadCS1.Name := StudentMasterCS."Student Name";
                    FineAttendanceHeadCS1."Course Code" := AttendPercentageLineCS."Course Code";
                    FineAttendanceHeadCS1.Semester := AttendPercentageLineCS.Semester;
                    FineAttendanceHeadCS1.Section := AttendPercentageLineCS.Section;
                    FineAttendanceHeadCS1."Academic year" := AttendPercentageLineCS."Academic Year";
                    FineAttendanceHeadCS1.INSERT();
                    FineAttendanceLineCS."Line No." := 10000;
                END ELSE BEGIN
                    FineAttendanceHeadCS.FINDFIRST();
                    "DocuNo." := FineAttendanceHeadCS."No.";
                    FineAttendanceLineCS1.Reset();
                    FineAttendanceLineCS1.SETRANGE("Document No.", FineAttendanceHeadCS."No.");
                    IF FineAttendanceLineCS1.FINDLAST() THEN
                        FineAttendanceLineCS."Line No." := FineAttendanceLineCS1."Line No." + 10000;
                END;

                FineAttendanceLineCS."Document No." := "DocuNo.";
                FineAttendanceLineCS."Student No." := AttendPercentageLineCS."Student No.";
                FineAttendanceLineCS."Course Code" := AttendPercentageLineCS."Course Code";
                FineAttendanceLineCS.Semester := AttendPercentageLineCS.Semester;
                FineAttendanceLineCS.Section := AttendPercentageLineCS.Section;
                FineAttendanceLineCS."Academic year" := AttendPercentageLineCS."Academic Year";
                FineAttendanceLineCS."Subject Type" := AttendPercentageLineCS."Subject Type";
                FineAttendanceLineCS."Subject Code" := AttendPercentageLineCS."Subject Code";
                FineAttendanceLineCS."Fine Amount" := AttendPercentageLineCS."Attendance Fine Amount";
                FineAttendanceLineCS.INSERT();

            UNTIL AttendPercentageLineCS.NEXT() = 0;
        //Code added for generate subject attendance fine::CSPL-00059::19022019: End
    end;

    procedure PayFineAmount("getDocNo.": Code[20])
    var
        FeeSetupCS: Record "Fee Setup-CS";
        FineAttendanceHeadCS: Record "Fine Attendance Head-CS";
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        FineAttendanceLineCS: Record "Fine Attendance Line-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        LocalFineAmount: Decimal;

    begin
        //Code added for pay fine amount::CSPL-00059::19022019: Start

        FineAttendanceHeadCS.GET("getDocNo.");
        IF NOT CONFIRM(Text003Lbl, FALSE) THEN
            EXIT;

        FineAttendanceLineCS.Reset();
        FineAttendanceLineCS.SETCURRENTKEY("Document No.", "Student No.");
        FineAttendanceLineCS.SETRANGE("Document No.", FineAttendanceHeadCS."No.");
        FineAttendanceLineCS.SETRANGE("Student No.", FineAttendanceHeadCS."Student No.");
        FineAttendanceLineCS.CALCSUMS("Fine Amount");
        LocalFineAmount := FineAttendanceLineCS."Fine Amount";

        IF LocalFineAmount = 0 THEN
            ERROR(Text000Lbl);

        IF FineAttendanceHeadCS."Receipt No." <> '' THEN
            ERROR(Text001Lbl);

        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Attendance Fine Code");
        FineAttendanceHeadCS."Receipt No." :=
          ManagementsFeeCS."Post SalesCS"(FineAttendanceHeadCS."Student No.", FeeSetupCS."Attendance Fine Code", LocalFineAmount);

        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETRANGE("Student No.", FineAttendanceHeadCS."Student No.");
        AttendPercentageLineCS.SETRANGE("Course Code", FineAttendanceHeadCS."Course Code");
        AttendPercentageLineCS.SETRANGE(Semester, FineAttendanceHeadCS.Semester);
        AttendPercentageLineCS.SETRANGE(Section, FineAttendanceHeadCS.Section);
        AttendPercentageLineCS.SETRANGE("Academic Year", FineAttendanceHeadCS."Academic year");
        AttendPercentageLineCS.SETRANGE("Eligible For Exam", FALSE);
        AttendPercentageLineCS.SETRANGE("Eligible For Exam", FALSE);
        AttendPercentageLineCS.MODIFYALL("Eligible For Exam", TRUE);
        FineAttendanceHeadCS.MODIFY();
        MESSAGE(Text002Lbl);
        //Code added for pay fine amount::CSPL-00059::19022019: End
    end;
}

