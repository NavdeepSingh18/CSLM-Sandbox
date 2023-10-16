codeunit 50026 "Attendance Action-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------------------
    // 1    CSPL-00059   19-02-19CalculateAttendancePerc                       Code added for attendance calculation.
    // 2    CSPL-00059   19-02-19GetStudentsPromotionDetail                   Code added for student promotion
    // 3    CSPL-00059   19-02-19PromoteCourseWiseStudents                     Code added for student course wise promotion
    // 4    CSPL-00059   19-02-19ModifyStudentStatus                           Code added for modify student status
    // 5    CSPL-00059   19-02-19ApplyndValidateAttendancePer                 Code added for apply and validate attendance.
    // 6    CSPL-00059   19-02-19AttendancePerAsOnDate                         Code added for as on date attendance
    // 7    CSPL-00059   19-02-19ApplicationApprovedOrRejcet                   Code added for application approval.
    // 8    CSPL-00059   19-02-19StudentsPromotionYear                         Code added for student promotion
    // 9    CSPL-00059   19-02-19AttendanceofStudent                           Code added for attendance of student
    // 10  CSPL-00059   19-02-19GetStudentsForAttendYear                     Code added for Student attendance year
    // 11  CSPL-00059   19-02-19StudentsForExternalAttendanceAndSessionalMarksCode added for student attendance external and sessional
    // 12  CSPL-00059   19-02-19GetStudentsForMakeUpExternalAttendanceAndSessionalMarksCode added for makup student attendance external
    // 13  CSPL-00059   19-02-19GetStudentsForWinterExternalAttendanceAndSessionalMarksCode added for winter student attendance external
    // 14  CSPL-00059   19-02-19GetStudentsForSummerExternalAttendanceAndSessionalMarksCode added for Summer student attendance external


    trigger OnRun()
    begin
    end;

    var
        Text000Lbl: Label 'You cannnot Regenerate attendance fine is Generated';

        Text002Lbl: Label 'Please Select Either Graduation Or Collage Or Course Or Semester Or Acadmic Year & Session';
        Text003Lbl: Label 'There are Some Sudents who are Inactive';
        Text004Lbl: Label 'Do you want promote the Students ?';
        Text005Lbl: Label 'Please Set Next Academic Year';

        Text007Lbl: Label 'Please Generate Students before Promoting';

    procedure CalculateAttendancePerc("GetDocNo.": Code[20])
    var
        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        AttendPercentageSetupCS: Record "Attend Percentage Setup-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";

        MainStudentSubjectCS: Record "Main Student Subject-CS";

        StudentMasterCS: Record "Student Master-CS";
        AttendPercentageLineCS1: Record "Attend Percentage Line-CS";
        // ExternalExamHeaderCS: Record "External Exam Header-CS";
        FineAttendanceHeadCS: Record "Fine Attendance Head-CS";
        TotalHours: Integer;
        "LocalLineNo.": Integer;
    begin
        //Code added for attendance calculation.::CSPL-00059::19022019: Start
        AttendPercentageHeadCS.GET("GetDocNo.");
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");

        FineAttendanceHeadCS.Reset();
        FineAttendanceHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic year");
        FineAttendanceHeadCS.SETRANGE("Course Code", AttendPercentageHeadCS."Course Code");
        FineAttendanceHeadCS.SETRANGE(Semester, AttendPercentageHeadCS.Semester);
        FineAttendanceHeadCS.SETRANGE(Section, AttendPercentageHeadCS.Section);
        FineAttendanceHeadCS.SETRANGE("Academic year", AttendPercentageHeadCS."Academic Year");
        FineAttendanceHeadCS.SETFILTER("Receipt No.", '<>%1', '');
        FineAttendanceHeadCS.SETRANGE("Result Generated", FALSE);
        IF FineAttendanceHeadCS.FINDFIRST() THEN
            ERROR(Text000Lbl);


        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETRANGE("Document No.", "GetDocNo.");
        AttendPercentageLineCS.SETRANGE("Result Generated", FALSE);
        IF AttendPercentageLineCS.FINDLAST() THEN
            IF CONFIRM(Text000Lbl, TRUE) THEN
                AttendPercentageLineCS.DELETEALL()
            ELSE
                EXIT;
        "LocalLineNo." := 0;
        TotalHours := 0;
        AttendPercentageHeadCS.TESTFIELD("Subject Type");
        AttendPercentageHeadCS.TESTFIELD("Subject Code");
        AttendPercentageHeadCS.TESTFIELD("Academic Year");
        AttendPercentageHeadCS.TESTFIELD("Course Code");
        IF AcademicsSetupCS."Common Subject Type" = AttendPercentageHeadCS."Subject Type" THEN
            AttendPercentageHeadCS.TESTFIELD(Semester);

        IF AcademicsSetupCS."Common Subject Type" <> AttendPercentageHeadCS."Subject Type" THEN
            AttendPercentageHeadCS.TESTFIELD("CBCS Batch");

        ClassAttendanceHeaderCS.Reset();
        ClassAttendanceHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        ClassAttendanceHeaderCS.SETRANGE("Course Code", AttendPercentageHeadCS."Course Code");
        IF AcademicsSetupCS."Common Subject Type" = AttendPercentageHeadCS."Subject Type" THEN BEGIN
            ClassAttendanceHeaderCS.SETRANGE(Semester, AttendPercentageHeadCS.Semester);
            ClassAttendanceHeaderCS.SETRANGE(Section, AttendPercentageHeadCS.Section);
        END;

        ClassAttendanceHeaderCS.SETRANGE("Academic Year", AttendPercentageHeadCS."Academic Year");
        ClassAttendanceHeaderCS.SETRANGE("Subject Type", AttendPercentageHeadCS."Subject Type");
        ClassAttendanceHeaderCS.SETRANGE("Subject Code", AttendPercentageHeadCS."Subject Code");
        IF AcademicsSetupCS."Common Subject Type" <> AttendPercentageHeadCS."Subject Type" THEN
            ClassAttendanceHeaderCS.SETRANGE("CBCS Batch", AcademicsSetupCS."CBCS Batch");

        ClassAttendanceHeaderCS.SETRANGE("Result Generated", FALSE);

        TotalHours := ClassAttendanceHeaderCS.count();

        IF ClassAttendanceHeaderCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code");
            MainStudentSubjectCS.SETRANGE(Course, AttendPercentageHeadCS."Course Code");
            IF AcademicsSetupCS."Common Subject Type" = AttendPercentageHeadCS."Subject Type" THEN BEGIN
                MainStudentSubjectCS.SETRANGE(Semester, AttendPercentageHeadCS.Semester);
                MainStudentSubjectCS.SETRANGE(Section, AttendPercentageHeadCS.Section);
            END ELSE
                IF AcademicsSetupCS."Common Subject Type" <> AttendPercentageHeadCS."Subject Type" THEN
                    MainStudentSubjectCS.SETRANGE(Completed, FALSE);

            MainStudentSubjectCS.SETRANGE("Academic Year", AttendPercentageHeadCS."Academic Year");
            MainStudentSubjectCS.SETRANGE("Subject Type", AttendPercentageHeadCS."Subject Type");
            MainStudentSubjectCS.SETRANGE("Subject Code", AttendPercentageHeadCS."Subject Code");
            IF AcademicsSetupCS."Common Subject Type" <> AttendPercentageHeadCS."Subject Type" THEN
                MainStudentSubjectCS.SETRANGE("CBCS Batch", AttendPercentageHeadCS."CBCS Batch");

            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    "LocalLineNo." += 10000;
                    AttendPercentageLineCS.Reset();
                    AttendPercentageLineCS.INIT();
                    AttendPercentageLineCS."Document No." := AttendPercentageHeadCS."No.";
                    AttendPercentageLineCS."Line No." := "LocalLineNo.";
                    AttendPercentageLineCS."Course Code" := MainStudentSubjectCS.Course;
                    AttendPercentageLineCS.Semester := MainStudentSubjectCS.Semester;
                    AttendPercentageLineCS.Section := MainStudentSubjectCS.Section;
                    AttendPercentageLineCS."Subject Code" := AttendPercentageHeadCS."Subject Code";
                    AttendPercentageLineCS."Academic Year" := AttendPercentageHeadCS."Academic Year";
                    AttendPercentageLineCS."Student No." := MainStudentSubjectCS."Student No.";
                    AttendPercentageLineCS."Subject Type" := AttendPercentageHeadCS."Subject Type";
                    AttendPercentageLineCS.Percentage := 100;
                    AttendPercentageLineCS."Date Till" := TODAY();
                    AttendPercentageLineCS."Maximum Hours" := TotalHours;
                    AttendPercentageLineCS."Attended Hours" := TotalHours;
                    IF StudentMasterCS.GET(MainStudentSubjectCS."Student No.") THEN
                        AttendPercentageLineCS."Student Name" := StudentMasterCS."Student Name";
                    AttendPercentageLineCS.INSERT();
                UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;

        REPEAT
            ClassAttendanceLineCS.Reset();
            ClassAttendanceLineCS.SETRANGE("Document No.", ClassAttendanceHeaderCS."No.");
            ClassAttendanceLineCS.SETFILTER("Attendance Type", '<>%1', ClassAttendanceLineCS."Attendance Type"::"Present");
            AttendPercentageLineCS.SETRANGE("Result Generated", FALSE);
            IF ClassAttendanceLineCS.FINDSET() THEN
                REPEAT
                    AttendPercentageLineCS1.Reset();
                    AttendPercentageLineCS1.SETCURRENTKEY("Document No.", "Student No.");
                    AttendPercentageLineCS1.SETRANGE("Document No.", AttendPercentageHeadCS."No.");
                    AttendPercentageLineCS1.SETRANGE("Student No.", ClassAttendanceLineCS."Student No.");
                    AttendPercentageLineCS1.SETRANGE("Result Generated", FALSE);
                    IF AttendPercentageLineCS1.FINDFIRST() THEN BEGIN
                        AttendPercentageLineCS1.Percentage := ((AttendPercentageLineCS1."Attended Hours" - 1) / TotalHours) * 100;
                        AttendPercentageLineCS1."Attended Hours" := AttendPercentageLineCS1."Attended Hours" - 1;
                        AttendPercentageLineCS1.Modify();
                    END;
                UNTIL ClassAttendanceLineCS.NEXT() = 0;
        UNTIL ClassAttendanceHeaderCS.NEXT() = 0;

        AttendPercentageLineCS1.Reset();
        AttendPercentageLineCS1.SETRANGE("Document No.", "GetDocNo.");
        AttendPercentageLineCS1.SETRANGE("Result Generated", FALSE);
        IF AttendPercentageLineCS1.FINDSET() THEN
            REPEAT
                AttendPercentageSetupCS.Reset();
                IF AttendPercentageSetupCS.ISEMPTY() then
                    AttendPercentageLineCS1."Eligible For Exam" := TRUE;

                AttendPercentageSetupCS.Reset();
                AttendPercentageSetupCS.SETRANGE(Eligible, TRUE);
                IF AttendPercentageSetupCS.FINDSET() THEN
                    REPEAT
                        IF (AttendPercentageSetupCS."Minimum Attendance %" <= AttendPercentageLineCS1.Percentage) AND
                           (AttendPercentageSetupCS."Maximum Attendance %" >= AttendPercentageLineCS1.Percentage)
                        THEN
                            AttendPercentageLineCS1."Eligible For Exam" := TRUE;
                    UNTIL AttendPercentageSetupCS.NEXT() = 0;

                AttendPercentageSetupCS.Reset();
                AttendPercentageSetupCS.SETRANGE(Eligible, FALSE);
                AttendPercentageSetupCS.SETRANGE("Repeat Exam", FALSE);
                AttendPercentageSetupCS.SETFILTER("Minimum Attendance %", '<=%1', AttendPercentageLineCS1.Percentage);
                AttendPercentageSetupCS.SETFILTER("Maximum Attendance %", '>=%1', AttendPercentageLineCS1.Percentage);
                IF AttendPercentageSetupCS.FINDFIRST() THEN
                    EVALUATE(AttendPercentageLineCS1."Attendance Fine Amount", AttendPercentageSetupCS.Code);

                AttendPercentageLineCS1.Modify();
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                MainStudentSubjectCS.SETRANGE("Student No.", AttendPercentageLineCS1."Student No.");
                MainStudentSubjectCS.SETRANGE(Course, AttendPercentageLineCS1."Course Code");
                IF AcademicsSetupCS."Common Subject Type" = AttendPercentageHeadCS."Subject Type" THEN BEGIN
                    MainStudentSubjectCS.SETRANGE(Semester, AttendPercentageLineCS1.Semester);
                    MainStudentSubjectCS.SETRANGE(Section, AttendPercentageLineCS1.Section);
                END;
                MainStudentSubjectCS.SETRANGE("Academic Year", AttendPercentageLineCS1."Academic Year");
                MainStudentSubjectCS.SETRANGE("Subject Type", AttendPercentageLineCS1."Subject Type");
                MainStudentSubjectCS.SETRANGE("Subject Code", AttendPercentageLineCS1."Subject Code");
                IF AcademicsSetupCS."Common Subject Type" <> AttendPercentageHeadCS."Subject Type" THEN
                    MainStudentSubjectCS.SETRANGE("CBCS Batch", AttendPercentageHeadCS."CBCS Batch");

                IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                    MainStudentSubjectCS."Attendance Percentage" := AttendPercentageLineCS1.Percentage;
                    MainStudentSubjectCS.Modify();
                END;
            UNTIL AttendPercentageLineCS1.NEXT() = 0;
        AttendPercentageHeadCS."Attendance % Generated" := TRUE;
        AttendPercentageHeadCS.Modify();
        //Code added for attendance calculation.::CSPL-00059::19022019: End
    end;

    procedure GetStudentsPromotionDetail(PromotionHeaderCS: Record "Promotion Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        PromotionLineCS: Record "Promotion Line-CS";

        EducationSetupCS: Record "Education Setup-CS";
        PromotionLineCS1: Record "Promotion Line-CS";
        //MainStudentSubjectCS: Record "Main Student Subject-CS";
        "LocalLineNo.": Integer;
        ShowMessage: Boolean;
        CreditEarn: Decimal;

    begin
        //Code added for student promotion::CSPL-00059::19022019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", PromotionHeaderCS."Global Dimension 1 Code");
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR('Education Setup For Institute Code %1 Not Defined !!', PromotionHeaderCS."Global Dimension 1 Code");

        ShowMessage := FALSE;
        "LocalLineNo." := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", Year, Section);
        StudentMasterCS.SETRANGE(Graduation, PromotionHeaderCS.Graduation);
        StudentMasterCS.SETRANGE("Global Dimension 1 Code", PromotionHeaderCS."Global Dimension 1 Code");
        StudentMasterCS.SETRANGE("Academic Year", PromotionHeaderCS."Academic Year");
        StudentMasterCS.SETRANGE("Course Code", PromotionHeaderCS.Course);
        IF PromotionHeaderCS."Type Of Course" = PromotionHeaderCS."Type Of Course"::Semester THEN
            StudentMasterCS.SETRANGE(Semester, PromotionHeaderCS.Semester)
        ELSE
            StudentMasterCS.SETRANGE(Year, PromotionHeaderCS.Year);
        IF PromotionHeaderCS.Section <> '' THEN
            StudentMasterCS.SETRANGE(Section, PromotionHeaderCS.Section);
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            StudentMasterCS.SETFILTER("Student Status", '%1|%2', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::"Reject & Rejoin")
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::"Reject & Rejoin",
                                  StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"NFT-Extended");
        StudentMasterCS.SETRANGE("Pending For Registration", FALSE);
        IF StudentMasterCS.FINDSET() THEN
            REPEAT

                CreditEarn := 0;
                IF StudentMasterCS.Semester = 'I' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned";
                IF StudentMasterCS.Semester = 'II' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned";
                IF StudentMasterCS.Semester = 'III' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned";

                IF StudentMasterCS.Semester = 'IV' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned" +
                                  StudentMasterCS."Semester IV Credit Earned";

                IF StudentMasterCS.Semester = 'V' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned" +
                                  StudentMasterCS."Semester IV Credit Earned" + StudentMasterCS."Semester V Credit Earned";

                IF StudentMasterCS.Semester = 'VI' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned" +
                                  StudentMasterCS."Semester IV Credit Earned" + StudentMasterCS."Semester V Credit Earned" + StudentMasterCS."Semester VI Credit Earned";

                IF StudentMasterCS.Semester = 'VII' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned" +
                                  StudentMasterCS."Semester IV Credit Earned" + StudentMasterCS."Semester V Credit Earned" + StudentMasterCS."Semester VI Credit Earned" +
                                  StudentMasterCS."Semester VII Credit Earned";

                IF StudentMasterCS.Semester = 'VIII' THEN
                    CreditEarn := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned" +
                                  StudentMasterCS."Semester IV Credit Earned" + StudentMasterCS."Semester V Credit Earned" + StudentMasterCS."Semester VI Credit Earned" +
                                  StudentMasterCS."Semester VII Credit Earned" + StudentMasterCS."Semester VIII Credit Earned";

                PromotionLineCS1.Reset();
                PromotionLineCS1.SETRANGE("Document No.", PromotionHeaderCS."No.");
                PromotionLineCS1.SETRANGE("Student Promoted", FALSE);
                PromotionLineCS1.SETRANGE("Student No.", StudentMasterCS."No.");
                IF PromotionLineCS1.FINDFIRST() THEN BEGIN
                    PromotionLineCS1.Credit := CreditEarn;
                    PromotionLineCS1."Not Eligible" := FALSE;
                    PromotionLineCS1.Modify();
                END ELSE BEGIN
                    "LocalLineNo." += 10000;
                    PromotionLineCS.INIT();
                    PromotionLineCS."Document No." := PromotionHeaderCS."No.";
                    PromotionLineCS."Line No." := "LocalLineNo.";
                    PromotionLineCS."Student No." := StudentMasterCS."No.";
                    PromotionLineCS."Enrollment No." := StudentMasterCS."Enrollment No.";
                    PromotionLineCS."Student Name" := StudentMasterCS."Student Name";
                    PromotionLineCS."Type Of Course" := PromotionHeaderCS."Type Of Course";
                    PromotionLineCS."Course Code" := StudentMasterCS."Course Code";
                    PromotionLineCS.Semester := StudentMasterCS.Semester;
                    PromotionLineCS.Section := StudentMasterCS.Section;
                    PromotionLineCS."Graduation Code" := StudentMasterCS.Graduation;
                    PromotionLineCS."Department Code" := StudentMasterCS.Department;
                    PromotionLineCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    PromotionLineCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                    PromotionLineCS."Academic Year" := StudentMasterCS."Academic Year";
                    PromotionLineCS."Promoted Semester" := StudentMasterCS.Semester;
                    PromotionLineCS."Promoted Year" := StudentMasterCS.Year;
                    IF (StudentMasterCS.Semester = 'I') OR (StudentMasterCS.Semester = 'II') THEN
                        PromotionLineCS.Group := StudentMasterCS.Group;
                    PromotionLineCS."Promoted  Academic Year" := StudentMasterCS."Academic Year";
                    PromotionLineCS."Lateral Student" := StudentMasterCS."Lateral Student";
                    PromotionLineCS.Credit := CreditEarn;
                    PromotionLineCS."Created By" := FORMAT(UserId());
                    PromotionLineCS."Created On" := TODAY();
                    IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Inactive THEN BEGIN
                        PromotionLineCS."In Active" := TRUE;
                        ShowMessage := TRUE;
                    END ELSE
                        PromotionLineCS."In Active" := FALSE;

                    PromotionLineCS.INSERT();
                END;
            UNTIL StudentMasterCS.NEXT() = 0;

        IF ShowMessage THEN
            MESSAGE(Text003Lbl);

        //Code added for student promotion::CSPL-00059::19022019: End
    end;

    procedure PromoteCourseWiseStudents(getGraduation: Code[20]; getDepartment: Code[20]; getCourse: Code[20]; getSemester: Code[10]; getSection: Code[10]; getAcademicyear: Code[10])
    var
        StudentMasterCS: Record "Student Master-CS";
        PromotionLineCS: Record "Promotion Line-CS";
        SemesterMasterCS: Record "Semester Master-CS";
        SemesterMasterCS1: Record "Semester Master-CS";

        // PromotionLineCS1: Record "Promotion Line-CS";
        Course: Record "Course Master-CS";

        // PromotionHeaderCS: Record "Promotion Header-CS";
        EducationSetupCS: Record "Education Setup-CS";
        AcademicYearMasterCS: Record "Academic Year Master-CS";
        AcademicYearMasterCS1: Record "Academic Year Master-CS";
        StudentMasterCS1: Record "Student Master-CS";
        /* OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
         MainStudentSubjectCS: Record "Main Student Subject-CS";

         CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
         CourseWiseSubjectHeadCS1: Record "Course Wise Subject Head-CS";
         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
         CourseWiseSubjectLineCS1: Record "Course Wise Subject Line-CS";
         CourseSectionMasterCS: Record "Course Section Master-CS";
         CourseSectionMasterCS1: Record "Course Section Master-CS";*/
        PromotionDetailsCS: Record "Promotion Details-CS";
        LocalAcademicYear: Code[10];
        SetYear: Integer;
        SetSemester: Code[10];
    begin
        //Code added for student course wise promotion::CSPL-00059::19022019: Start

        SetSemester := '';
        IF CONFIRM(Text004Lbl, TRUE) THEN BEGIN

            PromotionLineCS.Reset();
            PromotionLineCS.SETRANGE("Course Code", getCourse);
            PromotionLineCS.SETRANGE(Semester, getSemester);
            PromotionLineCS.SETRANGE(Section, getSection);
            IF PromotionLineCS.FINDFIRST() THEN BEGIN
                //MESSAGE('%1',PromotionLineCS."Course Code");
                SemesterMasterCS.GET(PromotionLineCS.Semester);
                // MESSAGE('%1',PromotionLineCS.Semester);
                Course.GET(PromotionLineCS."Course Code");
                Course.TESTFIELD("Duration of Years");
                Course.TESTFIELD("Number of Semesters");
                SemesterMasterCS1.Reset();
                SemesterMasterCS1.SETCURRENTKEY(Order);
                SemesterMasterCS1.SETFILTER(Order, '>%1', SemesterMasterCS.Order);
                SemesterMasterCS1.ASCENDING(TRUE);
                IF SemesterMasterCS1.FINDFIRST() AND (SemesterMasterCS1.Order <= Course."Number of Semesters") THEN
                    SetSemester := SemesterMasterCS1.Code
                ELSE
                    SetSemester := '';
                AcademicYearMasterCS.Reset();
                AcademicYearMasterCS.SETCURRENTKEY(Sequence);
                AcademicYearMasterCS.SETRANGE(Code, EducationSetupCS."Academic Year");
                IF AcademicYearMasterCS.FINDFIRST() THEN BEGIN
                    AcademicYearMasterCS1.Reset();
                    AcademicYearMasterCS1.SETCURRENTKEY(Sequence);
                    AcademicYearMasterCS1.SETRANGE(Sequence, AcademicYearMasterCS.Sequence + 1);
                    IF AcademicYearMasterCS1.FINDFIRST() THEN
                        LocalAcademicYear := AcademicYearMasterCS1.Code
                    ELSE
                        ERROR(Text005Lbl);
                END;


                StudentMasterCS.Reset();
                StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");
                StudentMasterCS.SETRANGE("Course Code", PromotionLineCS."Course Code");
                StudentMasterCS.SETRANGE(Semester, PromotionLineCS.Semester);
                StudentMasterCS.SETRANGE(Section, getSection);
                StudentMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                StudentMasterCS.SETRANGE("Student Status", StudentMasterCS."Student Status"::" ", StudentMasterCS."Student Status"::Student);
                IF StudentMasterCS.FINDSET() THEN
                    REPEAT
                        IF StudentMasterCS1.GET(StudentMasterCS."No.") THEN BEGIN
                            StudentMasterCS1.Semester := SetSemester;
                            StudentMasterCS1."New Student" := FALSE;
                            IF (SemesterMasterCS.Order MOD 2 = 0) AND (SetSemester <> '') THEN BEGIN
                                SetYear := SemesterMasterCS.Order / 2 + 1;
                                StudentMasterCS1."Academic Year" := LocalAcademicYear;
                            END ELSE
                                IF SetSemester = '' THEN
                                    StudentMasterCS1."Student Status" := StudentMasterCS."Student Status"::"Provisional Student";
                            StudentMasterCS1.Modify();


                            PromotionDetailsCS.INIT();
                            PromotionDetailsCS."Student No." := StudentMasterCS."No.";
                            PromotionDetailsCS."Student Name" := StudentMasterCS."Student Name";
                            PromotionDetailsCS."Course Code" := StudentMasterCS."Course Code";
                            PromotionDetailsCS.Semester := StudentMasterCS.Semester;
                            PromotionDetailsCS.Section := StudentMasterCS.Section;
                            PromotionDetailsCS."Academic Year" := getAcademicyear;
                            PromotionDetailsCS."Promoted Course" := StudentMasterCS."Course Code";
                            PromotionDetailsCS."Promoted Semester" := SetSemester;
                            PromotionDetailsCS."Promoted Section" := StudentMasterCS.Section;
                            PromotionDetailsCS."Promoted Academic Year" := LocalAcademicYear;
                            PromotionDetailsCS.Result := PromotionDetailsCS.Result::Promoted;
                            PromotionDetailsCS.INSERT();
                        END;
                    UNTIL StudentMasterCS.NEXT() = 0;

            END ELSE
                ERROR(Text007Lbl);
        END;
        //Code added for student course wise promotion::CSPL-00059::19022019: End
    end;

    procedure ModifyStudentStatus("getStudentNo.": Code[20]; getStatus: Boolean)
    var
        StudentMasterCS: Record "Student Master-CS";
    // PromotionLineCS: Record "Promotion Line-CS";
    begin
        //Code added for modify student status::CSPL-00059::19022019: Start

        StudentMasterCS.GET("getStudentNo.");
        IF getStatus THEN
            StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::Inactive
        ELSE
            StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::Student;
        StudentMasterCS.Modify();
        //Code added for modify student status::CSPL-00059::19022019: End
    end;

    procedure ApplyndValidateAttendancePer(getCourse: Code[20]; getSemester: Code[20]; getSection: Code[20]; getSubjectType: Code[20]; getSubject: Code[20]): Boolean
    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
        EducationSetupCS: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
    begin
        //Code added for apply and validate attendance.::CSPL-00059::19022019: Start

        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        UserSetupRec.Get(UserId());
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TESTFIELD("Academic Year");

        AttendPercentageHeadCS.Reset();
        AttendPercentageHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");

        AttendPercentageHeadCS.SETRANGE("Course Code", getCourse);
        AttendPercentageHeadCS.SETRANGE(Semester, getSemester);
        AttendPercentageHeadCS.SETRANGE(Section, getSection);
        AttendPercentageHeadCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        AttendPercentageHeadCS.SETRANGE("Subject Type", getSubjectType);
        AttendPercentageHeadCS.SETRANGE("Subject Code", getSubject);
        AttendPercentageHeadCS.SETRANGE("Attendance % Generated", TRUE);
        AttendPercentageHeadCS.SETRANGE("Result Generated", FALSE);
        IF AttendPercentageHeadCS.FINDFIRST() THEN
            EXIT(TRUE);
        //Code added for apply and validate attendance.::CSPL-00059::19022019: End
    end;

    procedure AttendancePerAsOnDate("getStudentNo.": Code[20])
    var
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        TotalHours: Integer;
        TotalAbsent: Integer;
    begin
        //Code added for as on date attendance::CSPL-00059::19022019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        StudentMasterCS.GET("getStudentNo.");

        MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
        MainStudentSubjectCS.SETRANGE(Course, StudentMasterCS."Course Code");
        MainStudentSubjectCS.SETRANGE(Semester, StudentMasterCS.Semester);
        MainStudentSubjectCS.SETRANGE("Academic Year", StudentMasterCS."Academic Year");
        MainStudentSubjectCS.SETRANGE(Section, StudentMasterCS.Section);
        MainStudentSubjectCS.SETRANGE(Completed, FALSE);
        IF MainStudentSubjectCS.FINDSET() THEN
            REPEAT
                TotalHours := 0;
                TotalAbsent := 0;
                ClassAttendanceHeaderCS.Reset();
                ClassAttendanceHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                IF AcademicsSetupCS."Common Subject Type" = MainStudentSubjectCS."Subject Type" THEN BEGIN
                    ClassAttendanceHeaderCS.SETRANGE("Course Code", MainStudentSubjectCS.Course);
                    ClassAttendanceHeaderCS.SETRANGE(Semester, MainStudentSubjectCS.Semester);
                    ClassAttendanceHeaderCS.SETRANGE(Section, MainStudentSubjectCS.Section);
                END;
                ClassAttendanceHeaderCS.SETRANGE("Academic Year", MainStudentSubjectCS."Academic Year");
                ClassAttendanceHeaderCS.SETRANGE("Subject Type", MainStudentSubjectCS."Subject Type");
                ClassAttendanceHeaderCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                ClassAttendanceHeaderCS.SETRANGE("Result Generated", FALSE);
                TotalHours := ClassAttendanceHeaderCS.count();

                IF ClassAttendanceHeaderCS.FINDSET() THEN
                    REPEAT
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETRANGE("Document No.", ClassAttendanceHeaderCS."No.");
                        ClassAttendanceLineCS.SETRANGE("Student No.", "getStudentNo.");
                        ClassAttendanceLineCS.SETFILTER("Attendance Type", '<>%1', ClassAttendanceLineCS."Attendance Type"::"Present");
                        IF ClassAttendanceLineCS.FINDFIRST() THEN
                            TotalAbsent := TotalAbsent + 1;
                    UNTIL ClassAttendanceHeaderCS.NEXT() = 0;
                IF TotalHours <> 0 THEN
                    MainStudentSubjectCS."Attendance Percentage" := ((TotalHours - TotalAbsent) / TotalHours) * 100;
                MainStudentSubjectCS."Attendance % as on Date" := TODAY();
                MainStudentSubjectCS.Modify();
            UNTIL MainStudentSubjectCS.NEXT() = 0;
        //Code added for as on date attendance::CSPL-00059::19022019: End
    end;

    procedure ApplicationApprovedOrRejcet(Check: Boolean; "No.": Code[20])
    var
        LeaveApplicationCS: Record "Leave Application-CS";
    begin
        //Code added for application approval.::CSPL-00059::19022019: Start
        LeaveApplicationCS.Reset();
        IF LeaveApplicationCS.GET("No.") THEN
            IF Check THEN BEGIN
                LeaveApplicationCS."Leave Status" := LeaveApplicationCS."Leave Status"::Sanctioned;
                LeaveApplicationCS.Modify();
            END ELSE BEGIN
                LeaveApplicationCS."Leave Status" := LeaveApplicationCS."Leave Status"::Cancelled;
                LeaveApplicationCS.Modify();
            END;
        //Code added for application approval.::CSPL-00059::19022019: End
    end;

    procedure StudentsPromotionYear(getGraduation: Code[20]; getCourse: Code[20]; getYear: Code[10]; getSection: Code[10]; getCollage: Code[20]; getAcdemicYear: Code[20]; getSession: Code[20]; getOrder: Integer; getDocumentNo: Code[20]; getTypeOfCourse: Option)
    var
        StudentMasterCS: Record "Student Master-CS";
        PromotionLineCS: Record "Promotion Line-CS";
        //PromotionHeaderCS: Record "Promotion Header-CS";
        //EducationSetupCS: Record "Education Setup-CS";
        ShowMessage: Boolean;

        "LocalLineNo.": Integer;
    begin
        //Code added for student promotion::CSPL-00059::19022019: Start
        IF ((getGraduation = '') OR (getCourse = '') OR (getYear = '') OR (getCollage = '') OR (getAcdemicYear = '')) THEN   // OR (getSession='')
            ERROR(Text002Lbl);

        PromotionLineCS.Reset();
        ShowMessage := FALSE;

        "LocalLineNo." := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Year, "Academic Year");

        IF getCollage <> '' THEN
            StudentMasterCS.SETRANGE("Global Dimension 1 Code", getCollage);

        IF getAcdemicYear <> '' THEN
            StudentMasterCS.SETRANGE("Academic Year", getAcdemicYear);


        IF (getCourse <> '') AND (getYear <> '') THEN BEGIN
            StudentMasterCS.SETRANGE("Course Code", getCourse);
            StudentMasterCS.SETRANGE(Year, getYear);
        END;
        IF getSection <> '' THEN
            StudentMasterCS.SETRANGE(Section, getSection);


        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                "LocalLineNo." += 10000;
                PromotionLineCS.INIT();
                PromotionLineCS."Document No." := getDocumentNo;
                PromotionLineCS."Line No." := "LocalLineNo.";
                PromotionLineCS."Student No." := StudentMasterCS."No.";
                PromotionLineCS.Order := getOrder;
                PromotionLineCS."Type Of Course" := getTypeOfCourse;
                PromotionLineCS."Course Code" := StudentMasterCS."Course Code";
                PromotionLineCS.Year := StudentMasterCS.Year;
                PromotionLineCS."Student Name" := StudentMasterCS."Student Name";
                PromotionLineCS.Section := StudentMasterCS.Section;
                PromotionLineCS."Graduation Code" := StudentMasterCS."Global Dimension 1 Code";
                PromotionLineCS."Department Code" := StudentMasterCS.Department;
                PromotionLineCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 2 Code";
                PromotionLineCS."Academic Year" := StudentMasterCS."Academic Year";
                PromotionLineCS.Session := StudentMasterCS.Session;
                IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Inactive THEN BEGIN
                    PromotionLineCS."In Active" := TRUE;
                    ShowMessage := TRUE;
                END ELSE
                    PromotionLineCS."In Active" := FALSE;

                PromotionLineCS.INSERT();
            UNTIL StudentMasterCS.NEXT() = 0;

        IF ShowMessage THEN
            MESSAGE(Text003Lbl);

        //Code added for student promotion::CSPL-00059::19022019: End
    end;

    procedure AttendanceofStudent(ClassAttendanceHeaderCS: Record "Class Attendance Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        ClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        // ClassAttendanceHeaderCS1: Record "Class Attendance Header-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";

        EducationSetupCS: Record "Education Setup-CS";
        "LocalLineNo.": Integer;
    // ShowMessage: Boolean;

    begin
        //Code added for attendance of student::CSPL-00059::19022019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TESTFIELD("Academic Year");

        "LocalLineNo." := 0;
        IF ClassAttendanceHeaderCS."Subject Type" = 'CORE' THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
            IF ClassAttendanceHeaderCS."Course Code" <> '' THEN
                MainStudentSubjectCS.SETRANGE(Course, ClassAttendanceHeaderCS."Course Code");
            IF ClassAttendanceHeaderCS."Type Of Course" = ClassAttendanceHeaderCS."Type Of Course"::Semester THEN
                MainStudentSubjectCS.SETRANGE(Semester, ClassAttendanceHeaderCS.Semester)
            ELSE
                MainStudentSubjectCS.SETRANGE(Year, ClassAttendanceHeaderCS.Year);
            MainStudentSubjectCS.SETRANGE(Graduation, ClassAttendanceHeaderCS.Graduation);
            MainStudentSubjectCS.SETRANGE("Academic Year", ClassAttendanceHeaderCS."Academic Year");
            IF ClassAttendanceHeaderCS.Section <> '' THEN
                MainStudentSubjectCS.SETRANGE(Section, ClassAttendanceHeaderCS.Section);
            MainStudentSubjectCS.SETRANGE("Subject Class", ClassAttendanceHeaderCS."Subject Class");
            MainStudentSubjectCS.SETRANGE("Subject Type", ClassAttendanceHeaderCS."Subject Type");
            MainStudentSubjectCS.SETRANGE("Subject Code", ClassAttendanceHeaderCS."Subject Code");
            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
            // MainStudentSubjectCS.SETRANGE("Global Dimension 2 Code",ClassAttendanceHeaderCS."Global Dimension 2 Code");
            IF ClassAttendanceHeaderCS."Batch Code" <> '' THEN
                MainStudentSubjectCS.SETRANGE(Batch, ClassAttendanceHeaderCS."Batch Code");
            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                    StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                        StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                    IF StudentMasterCS.FINDFIRST() THEN BEGIN
                        ClassAttendanceLineCS1.Reset();
                        ClassAttendanceLineCS1.SETRANGE("Document No.", ClassAttendanceHeaderCS."No.");
                        ClassAttendanceLineCS1.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                        IF NOT ClassAttendanceLineCS1.FINDFIRST() THEN BEGIN
                            "LocalLineNo." += 10000;
                            ClassAttendanceLineCS.Reset();
                            ClassAttendanceLineCS.INIT();
                            ClassAttendanceLineCS."Document No." := ClassAttendanceHeaderCS."No.";
                            ClassAttendanceLineCS."Line No." := "LocalLineNo.";
                            ClassAttendanceLineCS."Student No." := MainStudentSubjectCS."Student No.";
                            ClassAttendanceLineCS."Enrollment No." := MainStudentSubjectCS."Enrollment No";
                            ClassAttendanceLineCS."Type Of Course" := ClassAttendanceHeaderCS."Type Of Course";
                            ClassAttendanceLineCS."Course Code" := ClassAttendanceHeaderCS."Course Code";
                            ClassAttendanceLineCS.Hour := ClassAttendanceHeaderCS.Hour;
                            ClassAttendanceLineCS.Semester := ClassAttendanceHeaderCS.Semester;
                            ClassAttendanceLineCS."Student Name" := MainStudentSubjectCS."Student Name";
                            ClassAttendanceLineCS."Subject Code" := ClassAttendanceHeaderCS."Subject Code";
                            ClassAttendanceLineCS."Subject Type" := ClassAttendanceHeaderCS."Subject Type";
                            ClassAttendanceLineCS.Section := MainStudentSubjectCS.Section;
                            ClassAttendanceLineCS.Date := ClassAttendanceHeaderCS."Attendance Date";
                            //ClassAttendanceLineCS.Type:=getType;
                            ClassAttendanceLineCS."Batch Code" := ClassAttendanceHeaderCS."Batch Code";
                            ClassAttendanceLineCS."Group Code" := MainStudentSubjectCS.Group;
                            ClassAttendanceLineCS.Graduation := MainStudentSubjectCS.Graduation;
                            ClassAttendanceLineCS."Staff Code" := ClassAttendanceHeaderCS."Attendance By";
                            ClassAttendanceLineCS."Global Dimension 1 Code" := ClassAttendanceHeaderCS."Global Dimension 1 Code";
                            ClassAttendanceLineCS."Global Dimension 2 Code" := ClassAttendanceHeaderCS."Global Dimension 2 Code";
                            ClassAttendanceLineCS."Academic Year" := ClassAttendanceHeaderCS."Academic Year";
                            ClassAttendanceLineCS.Session := ClassAttendanceHeaderCS.Session;
                            ClassAttendanceLineCS.INSERT();
                        END;
                    END;
                UNTIL MainStudentSubjectCS.NEXT() = 0;
        END ELSE BEGIN
            OptionalStudentSubjectCS.Reset();
            OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
            IF OptionalStudentSubjectCS.Course <> '' THEN
                OptionalStudentSubjectCS.SETRANGE(Course, ClassAttendanceHeaderCS."Course Code");
            IF ClassAttendanceHeaderCS."Type Of Course" = ClassAttendanceHeaderCS."Type Of Course"::Semester THEN
                OptionalStudentSubjectCS.SETRANGE(Semester, ClassAttendanceHeaderCS.Semester)
            ELSE
                OptionalStudentSubjectCS.SETRANGE(Year, ClassAttendanceHeaderCS.Year);
            OptionalStudentSubjectCS.SETRANGE(Graduation, ClassAttendanceHeaderCS.Graduation);
            OptionalStudentSubjectCS.SETRANGE("Academic Year", ClassAttendanceHeaderCS."Academic Year");
            OptionalStudentSubjectCS.SETRANGE(Section, ClassAttendanceHeaderCS.Section);
            OptionalStudentSubjectCS.SETRANGE("Subject Class", ClassAttendanceHeaderCS."Subject Class");
            OptionalStudentSubjectCS.SETRANGE("Subject Type", ClassAttendanceHeaderCS."Subject Type");
            OptionalStudentSubjectCS.SETRANGE("Subject Code", ClassAttendanceHeaderCS."Subject Code");
            OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
            //OptionalStudentSubjectCS.SETRANGE("Global Dimension 2 Code",ClassAttendanceHeaderCS."Global Dimension 2 Code");
            IF OptionalStudentSubjectCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                    StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                        StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                    IF StudentMasterCS.FINDFIRST() THEN BEGIN
                        ClassAttendanceLineCS1.Reset();
                        ClassAttendanceLineCS1.SETRANGE("Document No.", ClassAttendanceHeaderCS."No.");
                        ClassAttendanceLineCS1.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                        IF NOT ClassAttendanceLineCS1.FINDFIRST() THEN BEGIN
                            "LocalLineNo." += 10000;
                            ClassAttendanceLineCS.Reset();
                            ClassAttendanceLineCS.INIT();
                            ClassAttendanceLineCS."Document No." := ClassAttendanceHeaderCS."No.";
                            ClassAttendanceLineCS."Line No." := "LocalLineNo.";
                            ClassAttendanceLineCS."Student No." := OptionalStudentSubjectCS."Student No.";
                            ClassAttendanceLineCS."Enrollment No." := OptionalStudentSubjectCS."Enrollment No";
                            ClassAttendanceLineCS."Type Of Course" := ClassAttendanceHeaderCS."Type Of Course";
                            ClassAttendanceLineCS."Course Code" := ClassAttendanceHeaderCS."Course Code";
                            ClassAttendanceLineCS.Hour := ClassAttendanceHeaderCS.Hour;
                            ClassAttendanceLineCS.Semester := ClassAttendanceHeaderCS.Semester;
                            ClassAttendanceLineCS."Student Name" := OptionalStudentSubjectCS."Student Name";
                            ClassAttendanceLineCS."Subject Code" := ClassAttendanceHeaderCS."Subject Code";
                            ClassAttendanceLineCS."Subject Type" := ClassAttendanceHeaderCS."Subject Type";
                            ClassAttendanceLineCS.Section := OptionalStudentSubjectCS.Section;
                            ClassAttendanceLineCS."Group Code" := OptionalStudentSubjectCS.Group;
                            ClassAttendanceLineCS.Graduation := OptionalStudentSubjectCS.Graduation;
                            ClassAttendanceLineCS.Date := ClassAttendanceHeaderCS."Attendance Date";
                            ClassAttendanceLineCS."Staff Code" := CopyStr(ClassAttendanceHeaderCS."Attendance By Name", 1, MaxStrLen(ClassAttendanceLineCS."Staff Code"));
                            ClassAttendanceLineCS."Global Dimension 1 Code" := ClassAttendanceHeaderCS."Global Dimension 1 Code";
                            ClassAttendanceLineCS."Global Dimension 2 Code" := ClassAttendanceHeaderCS."Global Dimension 2 Code";
                            ClassAttendanceLineCS."Academic Year" := ClassAttendanceHeaderCS."Academic Year";
                            ClassAttendanceLineCS.Session := ClassAttendanceHeaderCS.Session;
                            ClassAttendanceLineCS.INSERT();
                        END;
                    END;
                UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        END;
        //Code added for attendance of student::CSPL-00059::19022019: End
    end;

    procedure GetStudentsForAttendYear(getGraduation: Code[20]; getCourse: Code[20]; getYear: Code[10]; getSection: Code[10]; getCollage: Code[20]; getAcdemicYear: Code[20]; getSession: Code[20]; getDocumentNo: Code[20]; getTypeOfCourse: Option; getSubject: Code[20]; getDate: Date; getType: Option; getGroup: Code[20]; getBatch: Code[20]; getStaff: Code[20]; ClassAttendanceHeaderCS: Record "Class Attendance Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";

        EducationSetupCS: Record "Education Setup-CS";

        "LocalLineNo.": Integer;

    begin
        //Code added for Student attendance year::CSPL-00059::19022019: Start
        IF ((getGraduation = '') OR (getCourse = '') OR (getYear = '') OR (getCollage = '') OR (getAcdemicYear = '')) THEN   //OR (getSession='')
            ERROR(Text002Lbl);

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", getCollage);
        if EducationSetupCS.FindFirst() then
            EducationSetupCS.TESTFIELD("Academic Year");

        ClassAttendanceLineCS.Reset();

        "LocalLineNo." := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETCURRENTKEY("Course Code", Year, "Academic Year");
        IF getGraduation <> '' THEN
            StudentMasterCS.SETRANGE("Global Dimension 1 Code", getGraduation);

        IF getCollage <> '' THEN
            StudentMasterCS.SETRANGE("Global Dimension 2 Code", getCollage);

        IF getAcdemicYear <> '' THEN
            StudentMasterCS.SETRANGE("Academic Year", getAcdemicYear);


        IF (getCourse <> '') AND (getYear <> '') THEN BEGIN
            StudentMasterCS.SETRANGE("Course Code", getCourse);
            StudentMasterCS.SETRANGE(Year, getYear);
        END;
        IF getSection <> '' THEN
            StudentMasterCS.SETRANGE(Section, getSection);

        IF getGroup <> '' THEN
            StudentMasterCS.SETRANGE("Cor State", getGroup);

        IF getBatch <> '' THEN
            StudentMasterCS.SETRANGE("Cor Country Code", getBatch);

        StudentMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                "LocalLineNo." += 1000;
                ClassAttendanceLineCS.INIT();
                ClassAttendanceLineCS."Document No." := getDocumentNo;
                ClassAttendanceLineCS."Line No." := "LocalLineNo.";
                ClassAttendanceLineCS."Student No." := StudentMasterCS."No.";
                ClassAttendanceLineCS."Type Of Course" := getTypeOfCourse;
                ClassAttendanceLineCS."Course Code" := ClassAttendanceHeaderCS."Course Code";
                ClassAttendanceLineCS.Year := StudentMasterCS.Year;
                ClassAttendanceLineCS."Subject Code" := getSubject;
                ClassAttendanceLineCS.Date := getDate;
                ClassAttendanceLineCS.Type := getType;
                ClassAttendanceLineCS."Group Code" := getGroup;
                ClassAttendanceLineCS."Batch Code" := getBatch;
                ClassAttendanceLineCS."Student Name" := StudentMasterCS."Student Name";
                ClassAttendanceLineCS.Section := ClassAttendanceHeaderCS.Section;
                ClassAttendanceLineCS."Staff Code" := getStaff;
                ClassAttendanceLineCS."Global Dimension 1 Code" := ClassAttendanceHeaderCS."Global Dimension 1 Code";
                ClassAttendanceLineCS."Global Dimension 2 Code" := ClassAttendanceHeaderCS."Global Dimension 2 Code";
                ClassAttendanceLineCS."Academic Year" := StudentMasterCS."Academic Year";
                ClassAttendanceLineCS.Session := ClassAttendanceHeaderCS.Session;
                ClassAttendanceLineCS.INSERT();
            UNTIL StudentMasterCS.NEXT() = 0;
        //Code added for Student attendance year::CSPL-00059::19022019: End
    end;

    procedure StudentsForExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS: Record "External Exam Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalExamLineCS2: Record "External Exam Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        // ShowMessage: Boolean;

        "LocalLineNo.": Integer;

    begin
        //Code added for student attendance external and sessional::CSPL-00059::19022019: Start
        ExternalExamHeaderCS.TESTFIELD("Exam Schedule Code");
        ExternalExamHeaderCS.TESTFIELD("Exam Classification");
        ExternalExamHeaderCS.TESTFIELD("Academic Year");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            ExternalExamHeaderCS.TESTFIELD(Semester)
        ELSE
            ExternalExamHeaderCS.TESTFIELD(Year);
        ExternalExamHeaderCS.TESTFIELD("Subject Class");
        ExternalExamHeaderCS.TESTFIELD("Subject Type");
        ExternalExamHeaderCS.TESTFIELD("Subject Code");
        //ExternalExamHeaderCS.TESTFIELD("Staff Code");


        "LocalLineNo." := 0;
        IF ExternalExamHeaderCS."Subject Type" = 'CORE' THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
            IF ExternalExamHeaderCS."Course Code" <> '' THEN
                MainStudentSubjectCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
            //ELSE
            MainStudentSubjectCS.SETRANGE(Graduation, ExternalExamHeaderCS."Program");
            IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
                MainStudentSubjectCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
            ELSE
                MainStudentSubjectCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
            MainStudentSubjectCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
            MainStudentSubjectCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
            MainStudentSubjectCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
            MainStudentSubjectCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
            MainStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
            EducationSetupCS.GET();
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                MainStudentSubjectCS.SETFILTER("Current Session", 'JAN-MAY')
            ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                    MainStudentSubjectCS.SETFILTER("Current Session", 'JUL-NOV');
            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                    StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                      StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                    IF StudentMasterCS.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS2.Reset();
                        ExternalExamLineCS2.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
                        IF ExternalExamLineCS2.FINDLAST() THEN
                            "LocalLineNo." := ExternalExamLineCS2."Line No." + 10000
                        ELSE
                            "LocalLineNo." += 10000;
                        ExternalExamLineCS2.SETRANGE("Student No.", StudentMasterCS."No.");
                        IF NOT ExternalExamLineCS2.FINDFIRST() THEN BEGIN
                            "LocalLineNo." += 10000;
                            ExternalExamLineCS.Reset();
                            ExternalExamLineCS.INIT();
                            ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                            ExternalExamLineCS."Line No." := "LocalLineNo.";
                            ExternalExamLineCS."Student No." := MainStudentSubjectCS."Student No.";
                            ExternalExamLineCS."Enrollment No." := MainStudentSubjectCS."Enrollment No";
                            ExternalExamLineCS."Type Of Course" := ExternalExamHeaderCS."Type Of Course";
                            ExternalExamLineCS.Course := ExternalExamHeaderCS."Course Code";
                            ExternalExamLineCS."Program" := ExternalExamHeaderCS."Program";
                            ExternalExamLineCS."Exam Classification" := ExternalExamHeaderCS."Exam Classification";
                            ExternalExamLineCS.Semester := ExternalExamHeaderCS.Semester;
                            ExternalExamLineCS."Student Name" := MainStudentSubjectCS."Student Name";
                            ExternalExamLineCS."Subject Class" := MainStudentSubjectCS."Subject Class";
                            ExternalExamLineCS."Subject Type" := ExternalExamHeaderCS."Subject Type";
                            ExternalExamLineCS."Subject Code" := ExternalExamHeaderCS."Subject Code";
                            ExternalExamLineCS.Section := MainStudentSubjectCS.Section;
                            ExternalExamLineCS."Staff Code" := ExternalExamHeaderCS."Staff Code";
                            ExternalExamLineCS."Global Dimension 1 Code" := ExternalExamHeaderCS."Global Dimension 1 Code";
                            ExternalExamLineCS."Global Dimension 2 Code" := ExternalExamHeaderCS."Global Dimension 2 Code";
                            ExternalExamLineCS."Academic year" := ExternalExamHeaderCS."Academic Year";
                            ExternalExamLineCS."Internal Mark" := MainStudentSubjectCS."Total Internal";
                            ExternalExamLineCS."External Maximum" := ExternalExamHeaderCS."External Maximum";
                            ExternalExamLineCS."Total Maximum" := ExternalExamHeaderCS."Total Maximum";
                            ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                            ExternalExamLineCS.Batch := MainStudentSubjectCS.Batch;
                            ExternalExamLineCS."Attendance %" := MainStudentSubjectCS."Attendance Percentage";
                            ExternalExamLineCS.Detained := MainStudentSubjectCS.Detained;
                            ExternalExamLineCS."Created By" := FORMAT(UserId());
                            ExternalExamLineCS."Created On" := TODAY();
                            ExternalExamLineCS.INSERT();

                            ExternalAttendanceLineCS.Reset();
                            IF ExternalExamHeaderCS."Course Code" <> '' THEN
                                ExternalAttendanceLineCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
                            ExternalAttendanceLineCS.SETRANGE("Program", ExternalExamHeaderCS."Program");
                            IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
                                ExternalAttendanceLineCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
                            ELSE
                                ExternalAttendanceLineCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
                            ExternalAttendanceLineCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
                            ExternalAttendanceLineCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
                            ExternalAttendanceLineCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
                            ExternalAttendanceLineCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
                            ExternalAttendanceLineCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
                            IF ExternalExamHeaderCS."Global Dimension 2 Code" <> '' THEN
                                ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalExamHeaderCS."Global Dimension 2 Code");
                            ExternalAttendanceLineCS.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                            IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                                ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
                                ExternalExamLineCS.Modify();
                            END;
                        END;
                    END;
                UNTIL MainStudentSubjectCS.NEXT() = 0;
        END ELSE BEGIN
            OptionalStudentSubjectCS.Reset();
            OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
            IF OptionalStudentSubjectCS.Course <> '' THEN
                OptionalStudentSubjectCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
            OptionalStudentSubjectCS.SETRANGE(Graduation, ExternalExamHeaderCS."Program");
            IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
                OptionalStudentSubjectCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
            ELSE
                OptionalStudentSubjectCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
            OptionalStudentSubjectCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
            OptionalStudentSubjectCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
            OptionalStudentSubjectCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
            OptionalStudentSubjectCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
            OptionalStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
            OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV');
                OptionalStudentSubjectCS.SETFILTER("Current Session", 'JAN-MAY');
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                    OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV');
                    OptionalStudentSubjectCS.SETFILTER("Current Session", 'JUL-NOV');
                END;
            IF OptionalStudentSubjectCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                    StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                      StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                    IF StudentMasterCS.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS2.Reset();
                        ExternalExamLineCS2.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
                        IF ExternalExamLineCS2.FINDLAST() THEN
                            "LocalLineNo." := ExternalExamLineCS2."Line No." + 10000
                        ELSE
                            "LocalLineNo." += 10000;
                        ExternalExamLineCS2.SETRANGE("Student No.", StudentMasterCS."No.");
                        IF NOT ExternalExamLineCS2.FINDFIRST() THEN BEGIN
                            ExternalExamLineCS.Reset();
                            ExternalExamLineCS.INIT();
                            ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                            ExternalExamLineCS."Line No." := "LocalLineNo.";
                            ExternalExamLineCS."Student No." := OptionalStudentSubjectCS."Student No.";
                            ExternalExamLineCS."Enrollment No." := OptionalStudentSubjectCS."Enrollment No";
                            ExternalExamLineCS."Type Of Course" := ExternalExamHeaderCS."Type Of Course";
                            ExternalExamLineCS.Course := ExternalExamHeaderCS."Course Code";
                            ExternalExamLineCS."Program" := ExternalExamHeaderCS."Program";
                            ExternalExamLineCS."Exam Classification" := ExternalExamHeaderCS."Exam Classification";
                            ExternalExamLineCS.Semester := ExternalExamHeaderCS.Semester;
                            ExternalExamLineCS."Student Name" := OptionalStudentSubjectCS."Student Name";
                            ExternalExamLineCS."Subject Class" := OptionalStudentSubjectCS."Subject Class";
                            ExternalExamLineCS."Subject Type" := ExternalExamHeaderCS."Subject Type";
                            ExternalExamLineCS."Subject Code" := ExternalExamHeaderCS."Subject Code";
                            ExternalExamLineCS.Section := OptionalStudentSubjectCS.Section;
                            ExternalExamLineCS."Staff Code" := ExternalExamHeaderCS."Staff Code";
                            ExternalExamLineCS."Global Dimension 1 Code" := ExternalExamHeaderCS."Global Dimension 1 Code";
                            ExternalExamLineCS."Global Dimension 2 Code" := ExternalExamHeaderCS."Global Dimension 2 Code";
                            ExternalExamLineCS."Academic year" := ExternalExamHeaderCS."Academic Year";
                            ExternalExamLineCS."Internal Mark" := OptionalStudentSubjectCS."Total Internal";
                            ExternalExamLineCS."External Maximum" := ExternalExamHeaderCS."External Maximum";
                            ExternalExamLineCS."Total Maximum" := ExternalExamHeaderCS."Total Maximum";
                            ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                            ExternalExamLineCS.Batch := MainStudentSubjectCS.Batch;
                            ExternalExamLineCS."Attendance %" := OptionalStudentSubjectCS."Attendance Percentage";
                            ExternalExamLineCS.Detained := OptionalStudentSubjectCS.Detained;
                            ExternalExamLineCS."Created By" := FORMAT(UserId());
                            ExternalExamLineCS."Created On" := TODAY();
                            ExternalExamLineCS.INSERT();

                            ExternalAttendanceLineCS.Reset();
                            IF ExternalExamHeaderCS."Course Code" <> '' THEN
                                ExternalAttendanceLineCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
                            ExternalAttendanceLineCS.SETRANGE("Program", ExternalExamHeaderCS."Program");
                            IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
                                ExternalAttendanceLineCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
                            ELSE
                                ExternalAttendanceLineCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
                            ExternalAttendanceLineCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
                            ExternalAttendanceLineCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
                            ExternalAttendanceLineCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
                            ExternalAttendanceLineCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
                            ExternalAttendanceLineCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
                            IF ExternalExamHeaderCS."Global Dimension 2 Code" <> '' THEN
                                ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalExamHeaderCS."Global Dimension 2 Code");
                            ExternalAttendanceLineCS.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                            IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                                ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
                                ExternalExamLineCS.Modify();
                            END;
                        END;
                    END;
                UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        END;
        //Code added for student attendance external and sessional::CSPL-00059::19022019: End
    end;

    procedure GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS: Record "External Exam Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        ExternalExamLineCS2: Record "External Exam Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        "LocalLineNo.": Integer;
    begin
        //Code added for makup student attendance external::CSPL-00059::19022019: Start

        ExternalExamHeaderCS.TESTFIELD("Exam Schedule Code");
        ExternalExamHeaderCS.TESTFIELD("Exam Classification");
        //ExternalExamHeaderCS.TESTFIELD("Course Code");
        ExternalExamHeaderCS.TESTFIELD("Academic Year");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            ExternalExamHeaderCS.TESTFIELD(Semester)
        ELSE
            ExternalExamHeaderCS.TESTFIELD(Year);
        ExternalExamHeaderCS.TESTFIELD("Subject Class");
        ExternalExamHeaderCS.TESTFIELD("Subject Type");
        ExternalExamHeaderCS.TESTFIELD("Subject Code");
        //ExternalExamHeaderCS.TESTFIELD("Staff Code");


        "LocalLineNo." := 0;
        MakeUpExaminationCS.Reset();
        MakeUpExaminationCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");
        IF ExternalExamHeaderCS."Course Code" <> '' THEN
            MakeUpExaminationCS.SETRANGE("Course Code", ExternalExamHeaderCS."Course Code");
        MakeUpExaminationCS.SETRANGE("Program", ExternalExamHeaderCS."Program");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            MakeUpExaminationCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
        ELSE
            MakeUpExaminationCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
        MakeUpExaminationCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
        //MainStudentSubjectCS.SETRANGE(Section,ExternalExamHeaderCS.Section);
        MakeUpExaminationCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
        MakeUpExaminationCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
        MakeUpExaminationCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
        MakeUpExaminationCS.SETRANGE("Exam Classification", ExternalExamHeaderCS."Exam Classification");
        MakeUpExaminationCS.SETRANGE(Cancel, FALSE);
        MakeUpExaminationCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
        IF MakeUpExaminationCS.FINDSET() THEN
            REPEAT
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("No.", MakeUpExaminationCS."Student No.");
                StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                    StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    ExternalExamLineCS2.Reset();
                    ExternalExamLineCS2.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
                    IF ExternalExamLineCS2.FINDLAST() THEN
                        "LocalLineNo." := ExternalExamLineCS2."Line No." + 10000
                    ELSE
                        "LocalLineNo." += 10000;
                    ExternalExamLineCS2.SETRANGE("Student No.", StudentMasterCS."No.");
                    IF NOT ExternalExamLineCS2.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS.Reset();
                        ExternalExamLineCS.INIT();
                        ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                        ExternalExamLineCS."Line No." := "LocalLineNo.";
                        ExternalExamLineCS."Student No." := MakeUpExaminationCS."Student No.";
                        ExternalExamLineCS."Enrollment No." := MakeUpExaminationCS."Enrollment No.";
                        ExternalExamLineCS."Type Of Course" := ExternalExamHeaderCS."Type Of Course";
                        ExternalExamLineCS.Course := ExternalExamHeaderCS."Course Code";
                        ExternalExamLineCS."Program" := ExternalExamHeaderCS."Program";
                        ExternalExamLineCS."Exam Classification" := ExternalExamHeaderCS."Exam Classification";
                        ExternalExamLineCS.Semester := ExternalExamHeaderCS.Semester;
                        ExternalExamLineCS."Student Name" := MakeUpExaminationCS."Student Name";
                        ExternalExamLineCS."Subject Class" := MakeUpExaminationCS."Subject Class";
                        ExternalExamLineCS."Subject Type" := ExternalExamHeaderCS."Subject Type";
                        ExternalExamLineCS."Subject Code" := ExternalExamHeaderCS."Subject Code";
                        ExternalExamLineCS.Section := MakeUpExaminationCS.Section;
                        ExternalExamLineCS."Staff Code" := ExternalExamHeaderCS."Staff Code";
                        ExternalExamLineCS."Global Dimension 1 Code" := ExternalExamHeaderCS."Global Dimension 1 Code";
                        ExternalExamLineCS."Global Dimension 2 Code" := ExternalExamHeaderCS."Global Dimension 2 Code";
                        ExternalExamLineCS."Academic year" := ExternalExamHeaderCS."Academic Year";
                        //ExternalExamLineCS."Internal Mark" := MainStudentSubjectCS."Total Internal";
                        ExternalExamLineCS."External Maximum" := ExternalExamHeaderCS."External Maximum";
                        ExternalExamLineCS."Total Maximum" := ExternalExamHeaderCS."Total Maximum";
                        ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                        ExternalExamLineCS.Batch := MainStudentSubjectCS.Batch;
                        ExternalExamLineCS."Created By" := FORMAT(UserId());
                        ExternalExamLineCS."Created On" := TODAY();
                        ExternalExamLineCS.INSERT();

                        IF ExternalExamLineCS."Subject Type" = 'CORE' THEN BEGIN
                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
                            MainStudentSubjectCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
                            IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                                ExternalExamLineCS.VALIDATE("Internal Mark", (MainStudentSubjectCS."Internal Mark" + MainStudentSubjectCS."Assignment Marks"));
                                ExternalExamLineCS.Modify();
                            END;
                        END ELSE BEGIN
                            OptionalStudentSubjectCS.Reset();
                            OptionalStudentSubjectCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
                            OptionalStudentSubjectCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
                            IF OptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                                ExternalExamLineCS.VALIDATE("Internal Mark", (OptionalStudentSubjectCS."Internal Obtained" + OptionalStudentSubjectCS."Assignment Marks"));
                                ExternalExamLineCS.Modify();
                            END;
                        END;

                        ExternalAttendanceLineCS.Reset();
                        ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", ExternalExamHeaderCS."Exam Schedule Code");
                        ExternalAttendanceLineCS.SETRANGE("Student No.", MakeUpExaminationCS."Student No.");
                        ExternalAttendanceLineCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
                        ExternalAttendanceLineCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
                        IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                            ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
                            ExternalExamLineCS."Attendance %" := ExternalAttendanceLineCS."Attendance %";
                            ExternalExamLineCS.Detained := ExternalAttendanceLineCS.Detained;
                            ExternalExamLineCS.Modify();
                        END;


                    END;
                END;
            UNTIL MakeUpExaminationCS.NEXT() = 0;
        //Code added for makup student attendance external::CSPL-00059::19022019: End
    end;

    procedure GetStudentsForWinterExternalAttendanceAndSessionaMarks(ExternalExamHeaderCS: Record "External Exam Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        ExternalExamLineCS2: Record "External Exam Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        "LocalLineNo.": Integer;
    begin
        //Code added for winter student attendance external::CSPL-00059::19022019: Start

        ExternalExamHeaderCS.TESTFIELD("Exam Schedule Code");
        ExternalExamHeaderCS.TESTFIELD("Exam Classification");
        ExternalExamHeaderCS.TESTFIELD("Academic Year");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            ExternalExamHeaderCS.TESTFIELD(Semester)
        ELSE
            ExternalExamHeaderCS.TESTFIELD(Year);
        ExternalExamHeaderCS.TESTFIELD("Subject Class");
        ExternalExamHeaderCS.TESTFIELD("Subject Type");
        ExternalExamHeaderCS.TESTFIELD("Subject Code");


        "LocalLineNo." := 0;
        RegistrationStudentCS.Reset();
        RegistrationStudentCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");
        IF ExternalExamHeaderCS."Course Code" <> '' THEN
            RegistrationStudentCS.SETRANGE("Course Code", ExternalExamHeaderCS."Course Code");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            RegistrationStudentCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
        ELSE
            RegistrationStudentCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
        RegistrationStudentCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
        RegistrationStudentCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
        RegistrationStudentCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
        RegistrationStudentCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
        RegistrationStudentCS.SETRANGE(Session, 'Winter');
        RegistrationStudentCS.SETRANGE(Cancel, FALSE);
        RegistrationStudentCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
        IF RegistrationStudentCS.FINDSET() THEN
            REPEAT
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("No.", RegistrationStudentCS."Student No.");
                StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                    StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    ExternalExamLineCS2.Reset();
                    ExternalExamLineCS2.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
                    IF ExternalExamLineCS2.FINDLAST() THEN
                        "LocalLineNo." := ExternalExamLineCS2."Line No." + 10000
                    ELSE
                        "LocalLineNo." += 10000;
                    ExternalExamLineCS2.SETRANGE("Student No.", StudentMasterCS."No.");
                    IF NOT ExternalExamLineCS2.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS.Reset();
                        ExternalExamLineCS.INIT();
                        ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                        ExternalExamLineCS."Line No." := "LocalLineNo.";
                        ExternalExamLineCS."Student No." := RegistrationStudentCS."Student No.";
                        RegistrationStudentCS.CALCFIELDS(RegistrationStudentCS."Enrollment No.");
                        ExternalExamLineCS."Enrollment No." := RegistrationStudentCS."Enrollment No.";
                        ExternalExamLineCS."Type Of Course" := ExternalExamHeaderCS."Type Of Course";
                        ExternalExamLineCS.Course := ExternalExamHeaderCS."Course Code";
                        ExternalExamLineCS."Program" := ExternalExamHeaderCS."Program";
                        ExternalExamLineCS."Exam Classification" := ExternalExamHeaderCS."Exam Classification";
                        ExternalExamLineCS.Semester := ExternalExamHeaderCS.Semester;
                        RegistrationStudentCS.CALCFIELDS(RegistrationStudentCS."Student Name");
                        ExternalExamLineCS."Student Name" := RegistrationStudentCS."Student Name";
                        RegistrationStudentCS.CALCFIELDS(RegistrationStudentCS."Subject Class");
                        ExternalExamLineCS."Subject Class" := RegistrationStudentCS."Subject Class";
                        ExternalExamLineCS."Subject Type" := ExternalExamHeaderCS."Subject Type";
                        ExternalExamLineCS."Subject Code" := ExternalExamHeaderCS."Subject Code";
                        //ExternalExamLineCS.Section := RegistrationStudentCS.Section;
                        ExternalExamLineCS."Staff Code" := ExternalExamHeaderCS."Staff Code";
                        ExternalExamLineCS."Global Dimension 1 Code" := ExternalExamHeaderCS."Global Dimension 1 Code";
                        ExternalExamLineCS."Global Dimension 2 Code" := ExternalExamHeaderCS."Global Dimension 2 Code";
                        ExternalExamLineCS."Academic year" := ExternalExamHeaderCS."Academic Year";
                        //ExternalExamLineCS."Internal Mark" := MainStudentSubjectCS."Total Internal";
                        ExternalExamLineCS."External Maximum" := ExternalExamHeaderCS."External Maximum";
                        ExternalExamLineCS."Total Maximum" := ExternalExamHeaderCS."Total Maximum";
                        ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                        ExternalExamLineCS.Batch := MainStudentSubjectCS.Batch;
                        ExternalExamLineCS."Created By" := FORMAT(UserId());
                        ExternalExamLineCS."Created On" := TODAY();
                        ExternalExamLineCS.INSERT();


                        ExternalAttendanceLineCS.Reset();
                        ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", ExternalExamHeaderCS."Exam Schedule Code");
                        ExternalAttendanceLineCS.SETRANGE("Student No.", RegistrationStudentCS."Student No.");
                        ExternalAttendanceLineCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
                        ExternalAttendanceLineCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
                        IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                            ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
                            ExternalExamLineCS."Attendance %" := ExternalAttendanceLineCS."Attendance %";
                            ExternalExamLineCS.Detained := ExternalAttendanceLineCS.Detained;
                            ExternalExamLineCS.Modify();
                        END;
                    END;
                END;
            UNTIL RegistrationStudentCS.NEXT() = 0;
        //Code added for winter student attendance external::CSPL-00059::19022019: End
    end;

    procedure GetStudentsForSummerExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS: Record "External Exam Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        ExternalExamLineCS2: Record "External Exam Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        "LocalLineNo.": Integer;
    begin
        //Code added for Summer student attendance external::CSPL-00059::19022019: Start
        ExternalExamHeaderCS.TESTFIELD("Exam Schedule Code");
        ExternalExamHeaderCS.TESTFIELD("Exam Classification");
        ExternalExamHeaderCS.TESTFIELD("Academic Year");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            ExternalExamHeaderCS.TESTFIELD(Semester)
        ELSE
            ExternalExamHeaderCS.TESTFIELD(Year);
        ExternalExamHeaderCS.TESTFIELD("Subject Class");
        ExternalExamHeaderCS.TESTFIELD("Subject Type");
        ExternalExamHeaderCS.TESTFIELD("Subject Code");


        "LocalLineNo." := 0;
        RegistrationStudentCS.Reset();
        RegistrationStudentCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");
        IF ExternalExamHeaderCS."Course Code" <> '' THEN
            RegistrationStudentCS.SETRANGE("Course Code", ExternalExamHeaderCS."Course Code");
        IF ExternalExamHeaderCS."Type Of Course" = ExternalExamHeaderCS."Type Of Course"::Semester THEN
            RegistrationStudentCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
        ELSE
            RegistrationStudentCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
        RegistrationStudentCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
        RegistrationStudentCS.SETRANGE("Subject Class", ExternalExamHeaderCS."Subject Class");
        RegistrationStudentCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
        RegistrationStudentCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
        RegistrationStudentCS.SETRANGE(Session, 'SUMMER');
        RegistrationStudentCS.SETRANGE(Cancel, FALSE);
        RegistrationStudentCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
        IF RegistrationStudentCS.FINDSET() THEN
            REPEAT
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("No.", RegistrationStudentCS."Student No.");
                StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                    StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    ExternalExamLineCS2.Reset();
                    ExternalExamLineCS2.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
                    IF ExternalExamLineCS2.FINDLAST() THEN
                        "LocalLineNo." := ExternalExamLineCS2."Line No." + 10000
                    ELSE
                        "LocalLineNo." += 10000;
                    ExternalExamLineCS2.SETRANGE("Student No.", StudentMasterCS."No.");
                    IF NOT ExternalExamLineCS2.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS.Reset();
                        ExternalExamLineCS.INIT();
                        ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                        ExternalExamLineCS."Line No." := "LocalLineNo.";
                        ExternalExamLineCS."Student No." := RegistrationStudentCS."Student No.";
                        RegistrationStudentCS.CALCFIELDS(RegistrationStudentCS."Enrollment No.");
                        ExternalExamLineCS."Enrollment No." := RegistrationStudentCS."Enrollment No.";
                        ExternalExamLineCS."Type Of Course" := ExternalExamHeaderCS."Type Of Course";
                        ExternalExamLineCS.Course := ExternalExamHeaderCS."Course Code";
                        ExternalExamLineCS."Program" := ExternalExamHeaderCS."Program";
                        ExternalExamLineCS."Exam Classification" := ExternalExamHeaderCS."Exam Classification";
                        ExternalExamLineCS.Semester := ExternalExamHeaderCS.Semester;
                        RegistrationStudentCS.CALCFIELDS(RegistrationStudentCS."Student Name");
                        ExternalExamLineCS."Student Name" := RegistrationStudentCS."Student Name";
                        RegistrationStudentCS.CALCFIELDS(RegistrationStudentCS."Subject Class");
                        ExternalExamLineCS."Subject Class" := RegistrationStudentCS."Subject Class";
                        ExternalExamLineCS."Subject Type" := ExternalExamHeaderCS."Subject Type";
                        ExternalExamLineCS."Subject Code" := ExternalExamHeaderCS."Subject Code";
                        ExternalExamLineCS."Staff Code" := ExternalExamHeaderCS."Staff Code";
                        ExternalExamLineCS."Global Dimension 1 Code" := ExternalExamHeaderCS."Global Dimension 1 Code";
                        ExternalExamLineCS."Global Dimension 2 Code" := ExternalExamHeaderCS."Global Dimension 2 Code";
                        ExternalExamLineCS."Academic year" := ExternalExamHeaderCS."Academic Year";
                        ExternalExamLineCS."External Maximum" := ExternalExamHeaderCS."External Maximum";
                        ExternalExamLineCS."Total Maximum" := ExternalExamHeaderCS."Total Maximum";
                        ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                        ExternalExamLineCS.Batch := MainStudentSubjectCS.Batch;
                        ExternalExamLineCS."Created By" := FORMAT(UserId());
                        ExternalExamLineCS."Created On" := TODAY();
                        ExternalExamLineCS.INSERT();


                        ExternalAttendanceLineCS.Reset();
                        ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", ExternalExamHeaderCS."Exam Schedule Code");
                        ExternalAttendanceLineCS.SETRANGE("Student No.", RegistrationStudentCS."Student No.");
                        ExternalAttendanceLineCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
                        ExternalAttendanceLineCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
                        IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                            ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
                            ExternalExamLineCS."Attendance %" := ExternalAttendanceLineCS."Attendance %";
                            ExternalExamLineCS.Detained := ExternalAttendanceLineCS.Detained;
                            ExternalExamLineCS.Modify();
                        END;
                    END;
                END;
            UNTIL RegistrationStudentCS.NEXT() = 0;

        //Code added for Summer student attendance external::CSPL-00059::19022019: END
    end;


    //For Students Auto Generated 
    procedure AttendanceofStudentUpdated(ClassAttendanceHeaderCS: Record "Class Attendance Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        ClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        FinalTimeTableRec: Record "Final Class Time Table-CS";
        SubjectMaster_lRec: Record "Subject Master-CS";
        SubjectMaster_lRec1: Record "Subject Master-CS";
        SubjectMaster_lRec2: Record "Subject Master-CS";
        "LocalLineNo.": Integer;
        SubjectCode: Code[20];

    begin
        //Code added for attendance of student::CSPL-00059::19022019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TESTFIELD("Academic Year");

        SubjectCode := '';
        SubjectMaster_lRec.Reset();
        SubjectMaster_lRec.SetRange(Code, ClassAttendanceHeaderCS."Subject Code");
        If SubjectMaster_lRec.FindFirst() then begin
            If SubjectMaster_lRec."Subject Group" <> '' then begin
                SubjectMaster_lRec1.Reset();
                SubjectMaster_lRec1.SetRange(Code, SubjectMaster_lRec."Subject Group");
                If SubjectMaster_lRec1.FindFirst() then begin
                    If SubjectMaster_lRec1."Subject Group" <> '' then begin
                        SubjectMaster_lRec2.Reset();
                        SubjectMaster_lRec2.SetRange(Code, SubjectMaster_lRec1."Subject Group");
                        If SubjectMaster_lRec2.FindFirst() then begin
                            If SubjectMaster_lRec2."Subject Group" = '' then
                                SubjectCode := SubjectMaster_lRec2.Code;
                        end;
                    end Else
                        SubjectCode := SubjectMaster_lRec1.Code;
                end;
            end Else
                SubjectCode := SubjectMaster_lRec.Code;
        end;


        "LocalLineNo." := 0;

        FinalTimeTableRec.Reset();
        FinalTimeTableRec.SetRange("S.No.", ClassAttendanceHeaderCS."Time Table No");
        FinalTimeTableRec.SetRange("Time Table  Document No.", ClassAttendanceHeaderCS."Time Table Doc. No.");
        If FinalTimeTableRec.FindFirst() then begin
            StudentMasterCS.Reset();
            StudentMasterCS.SetFilter(Status, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'DCL', 'GRAD', 'WITH', 'DEC', 'ADWD', 'DEF', 'BP');
            StudentMasterCS.SetRange("Course Code", ClassAttendanceHeaderCS."Course Code");
            StudentMasterCS.SetRange(Semester, ClassAttendanceHeaderCS.Semester);
            StudentMasterCS.SetRange("Academic Year", ClassAttendanceHeaderCS."Academic Year");
            StudentMasterCS.SetRange(Term, ClassAttendanceHeaderCS.Term);
            StudentMasterCS.SetRange("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
            IF StudentMasterCS.FindSet() THEN BEGIN
                repeat
                    ClassAttendanceLineCS1.Reset();
                    ClassAttendanceLineCS1.SETRANGE("Document No.", ClassAttendanceHeaderCS."No.");
                    ClassAttendanceLineCS1.SETRANGE("Student No.", StudentMasterCS."No.");
                    IF NOT ClassAttendanceLineCS1.FINDFIRST() THEN BEGIN
                        "LocalLineNo." += 10000;
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.INIT();
                        ClassAttendanceLineCS."Document No." := ClassAttendanceHeaderCS."No.";
                        ClassAttendanceLineCS."Line No." := "LocalLineNo.";
                        ClassAttendanceLineCS."Student No." := StudentMasterCS."No.";
                        ClassAttendanceLineCS."Enrollment No." := StudentMasterCS."Enrollment No.";
                        ClassAttendanceLineCS."Type Of Course" := ClassAttendanceHeaderCS."Type Of Course";
                        ClassAttendanceLineCS."Course Code" := ClassAttendanceHeaderCS."Course Code";
                        ClassAttendanceLineCS.Hour := ClassAttendanceHeaderCS.Hour;
                        ClassAttendanceLineCS.Semester := ClassAttendanceHeaderCS.Semester;
                        ClassAttendanceLineCS."Student Name" := StudentMasterCS."Student Name";
                        ClassAttendanceLineCS."Subject Code" := ClassAttendanceHeaderCS."Subject Code";
                        ClassAttendanceLineCS."Subject Type" := ClassAttendanceHeaderCS."Subject Type";
                        ClassAttendanceLineCS.Section := ClassAttendanceHeaderCS.Section;
                        ClassAttendanceLineCS.Date := ClassAttendanceHeaderCS."Attendance Date";
                        //ClassAttendanceLineCS.Type:=getType;
                        ClassAttendanceLineCS."Batch Code" := ClassAttendanceHeaderCS."Batch Code";
                        //ClassAttendanceLineCS."Group Code" := MainStudentSubjectCS.Group;
                        //ClassAttendanceLineCS.Graduation := MainStudentSubjectCS.Graduation;
                        ClassAttendanceLineCS."Staff Code" := ClassAttendanceHeaderCS."Attendance By";
                        ClassAttendanceLineCS."Global Dimension 1 Code" := ClassAttendanceHeaderCS."Global Dimension 1 Code";
                        ClassAttendanceLineCS."Global Dimension 2 Code" := ClassAttendanceHeaderCS."Global Dimension 2 Code";
                        ClassAttendanceLineCS."Academic Year" := ClassAttendanceHeaderCS."Academic Year";
                        ClassAttendanceLineCS.Session := ClassAttendanceHeaderCS.Session;
                        ClassAttendanceLineCS."Final Time Table No." := ClassAttendanceHeaderCS."Time Table No";
                        ClassAttendanceLineCS."Time Table Doc No." := ClassAttendanceHeaderCS."Time Table Doc. No.";
                        ClassAttendanceLineCS.Term := StudentMasterCS.Term;
                        ClassAttendanceLineCS.INSERT();
                        InsertStudentWiseGoal(ClassAttendanceLineCS);

                        FinalTimeTableRec.Attendance := FinalTimeTableRec.Attendance::Marked;
                        FinalTimeTableRec.Modify();
                    end;
                until StudentMasterCS.Next() = 0;
            end;

        END;


    end;

    procedure InsertStudentWiseGoal(ClassAttendanceLineCS: Record "Class Attendance Line-CS")
    Var
        StudentWiseGoal_lRec: Record "Student Wise Goal";
        FinalTimeTable_lRec: Record "Final Class Time Table-CS";
        SubjectWiseGoal_lRec: Record "Subject Goal";
        EntryNo: Integer;
    Begin
        FinalTimeTable_lRec.Reset();
        FinalTimeTable_lRec.SetRange("S.No.", ClassAttendanceLineCS."Final Time Table No.");
        If FinalTimeTable_lRec.FindSet() then begin
            repeat

                SubjectWiseGoal_lRec.Reset();
                SubjectWiseGoal_lRec.SetRange("Subject Code", FinalTimeTable_lRec."Subject Code");
                If SubjectWiseGoal_lRec.FindSet() then begin
                    repeat
                        StudentWiseGoal_lRec.Reset();
                        IF StudentWiseGoal_lRec.FindLast() then
                            EntryNo := StudentWiseGoal_lRec."Entry No." + 1
                        Else
                            EntryNo := 1;

                        StudentWiseGoal_lRec.Reset();
                        StudentWiseGoal_lRec.SetRange("Student No.", ClassAttendanceLineCS."Student No.");
                        StudentWiseGoal_lRec.SetRange("Subject Code", FinalTimeTable_lRec."Subject Code");
                        StudentWiseGoal_lRec.SetRange("Goal Code", SubjectWiseGoal_lRec."Goal Code");
                        IF Not StudentWiseGoal_lRec.FindFirst() then Begin
                            StudentWiseGoal_lRec.Init();
                            StudentWiseGoal_lRec."Entry No." := EntryNo;
                            StudentWiseGoal_lRec.Validate("Student No.", ClassAttendanceLineCS."Student No.");
                            StudentWiseGoal_lRec."Goal Code" := SubjectWiseGoal_lRec."Goal Code";
                            StudentWiseGoal_lRec."Goal Description" := SubjectWiseGoal_lRec."Goal Description";
                            StudentWiseGoal_lRec."Final Time Table No." := FinalTimeTable_lRec."S.No.";
                            StudentWiseGoal_lRec."Time Table Doc No." := FinalTimeTable_lRec."Time Table  Document No.";
                            StudentWiseGoal_lRec."Time Table Line No." := FinalTimeTable_lRec."Time Table Line No.";
                            StudentWiseGoal_lRec."Grouping No." := FinalTimeTable_lRec."S.No. Grouping";
                            StudentWiseGoal_lRec."Subject Code" := FinalTimeTable_lRec."Subject Code";
                            StudentWiseGoal_lRec."Subject Description" := FinalTimeTable_lRec."Subject Name";
                            StudentWiseGoal_lRec."Attendance Date" := FinalTimeTable_lRec.Date;
                            StudentWiseGoal_lRec.Insert(true);
                        end;

                    until SubjectWiseGoal_lRec.Next() = 0;
                end;

                SubjectWiseGoal_lRec.Reset();
                SubjectWiseGoal_lRec.SetRange("Subject Code", FinalTimeTable_lRec."Topic Code");
                If SubjectWiseGoal_lRec.FindSet() then begin
                    repeat
                        StudentWiseGoal_lRec.Reset();
                        IF StudentWiseGoal_lRec.FindLast() then
                            EntryNo := StudentWiseGoal_lRec."Entry No." + 1
                        Else
                            EntryNo := 1;

                        StudentWiseGoal_lRec.Reset();
                        StudentWiseGoal_lRec.SetRange("Student No.", ClassAttendanceLineCS."Student No.");
                        StudentWiseGoal_lRec.SetRange("Subject Code", FinalTimeTable_lRec."Topic Code");
                        StudentWiseGoal_lRec.SetRange("Goal Code", SubjectWiseGoal_lRec."Goal Code");
                        IF Not StudentWiseGoal_lRec.FindFirst() then Begin
                            StudentWiseGoal_lRec.Init();
                            StudentWiseGoal_lRec."Entry No." := EntryNo;
                            StudentWiseGoal_lRec.Validate("Student No.", ClassAttendanceLineCS."Student No.");
                            StudentWiseGoal_lRec."Goal Code" := SubjectWiseGoal_lRec."Goal Code";
                            StudentWiseGoal_lRec."Goal Description" := SubjectWiseGoal_lRec."Goal Description";
                            StudentWiseGoal_lRec."Final Time Table No." := FinalTimeTable_lRec."S.No.";
                            StudentWiseGoal_lRec."Time Table Doc No." := FinalTimeTable_lRec."Time Table  Document No.";
                            StudentWiseGoal_lRec."Time Table Line No." := FinalTimeTable_lRec."Time Table Line No.";
                            StudentWiseGoal_lRec."Grouping No." := FinalTimeTable_lRec."S.No. Grouping";
                            StudentWiseGoal_lRec."Subject Code" := FinalTimeTable_lRec."Topic Code";
                            StudentWiseGoal_lRec."Subject Description" := FinalTimeTable_lRec."Topic Description";
                            StudentWiseGoal_lRec."Attendance Date" := FinalTimeTable_lRec.Date;
                            StudentWiseGoal_lRec.Insert(true);
                        end;

                    until SubjectWiseGoal_lRec.Next() = 0;
                end;

            until FinalTimeTable_lRec.Next() = 0;
        end;
    End;

    procedure GetStudentNo(ClassAttendanceHeaderCS: Record "Class Attendance Header-CS"): Text
    var
        StudentMasterCS: Record "Student Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        ClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        FinalTimeTableRec: Record "Final Class Time Table-CS";
        SubjectMaster_lRec: Record "Subject Master-CS";
        SubjectMaster_lRec1: Record "Subject Master-CS";
        SubjectMaster_lRec2: Record "Subject Master-CS";
        "LocalLineNo.": Integer;
        SubjectCode: Code[20];
        StudentNo: Text;

    begin
        //Code added for attendance of student::CSPL-00059::19022019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TESTFIELD("Academic Year");

        SubjectCode := '';
        StudentNo := '';
        SubjectMaster_lRec.Reset();
        SubjectMaster_lRec.SetRange(Code, ClassAttendanceHeaderCS."Subject Code");
        If SubjectMaster_lRec.FindFirst() then begin
            If SubjectMaster_lRec."Subject Group" <> '' then begin
                SubjectMaster_lRec1.Reset();
                SubjectMaster_lRec1.SetRange(Code, SubjectMaster_lRec."Subject Group");
                If SubjectMaster_lRec1.FindFirst() then begin
                    If SubjectMaster_lRec1."Subject Group" <> '' then begin
                        SubjectMaster_lRec2.Reset();
                        SubjectMaster_lRec2.SetRange(Code, SubjectMaster_lRec1."Subject Group");
                        If SubjectMaster_lRec2.FindFirst() then begin
                            If SubjectMaster_lRec2."Subject Group" = '' then
                                SubjectCode := SubjectMaster_lRec2.Code;
                        end;
                    end Else
                        SubjectCode := SubjectMaster_lRec1.Code;
                end;
            end Else
                SubjectCode := SubjectMaster_lRec.Code;
        end;


        "LocalLineNo." := 0;
        FinalTimeTableRec.Reset();
        FinalTimeTableRec.SetRange("S.No.", ClassAttendanceHeaderCS."Time Table No");
        FinalTimeTableRec.SetRange("Time Table  Document No.", ClassAttendanceHeaderCS."Time Table Doc. No.");
        If FinalTimeTableRec.FindFirst() then begin
            StudentMasterCS.Reset();
            StudentMasterCS.SetFilter(Status, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'DCL', 'GRAD', 'WITH', 'DEC', 'ADWD', 'DEF', 'BP');
            StudentMasterCS.SetRange("Course Code", ClassAttendanceHeaderCS."Course Code");
            StudentMasterCS.SetRange(Semester, ClassAttendanceHeaderCS.Semester);
            StudentMasterCS.SetRange("Academic Year", ClassAttendanceHeaderCS."Academic Year");
            StudentMasterCS.SetRange(Term, ClassAttendanceHeaderCS.Term);
            StudentMasterCS.SetRange("Global Dimension 1 Code", ClassAttendanceHeaderCS."Global Dimension 1 Code");
            IF StudentMasterCS.FindSet() THEN BEGIN
                repeat
                    IF StudentNo = '' then
                        StudentNo := StudentMasterCS."No."
                    Else
                        StudentNo += '|' + StudentMasterCS."No.";
                until StudentMasterCS.Next() = 0;
            end;
        end;
        exit(StudentNo);

    end;


}

