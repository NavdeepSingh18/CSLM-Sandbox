Codeunit 50008 "StudentsInfoCSCSLM"
{
    // version V.001-CS

    // Sr.No.Emp. ID    Date      Trigger                                    Remarks
    // 1      CSPL-0009228-05-2019StudentSubjectUpdateCS                    Update Student Subject
    // 2      CSPL-0009228-05-2019ProcessPromotionCS                        Promotion Process
    // 3      CSPL-0009228-05-2019GenerateStudentPromotionCS                Generate Student Promotion
    // 4      CSPL-0009228-05-2019FeeCreationOnStudentPromotionCS            Fee Creation On Student Promotion
    // 5      CSPL-0009228-05-2019Student1styearBatchAllotmentCS            Student Batch Allotment for 1st year
    // 6      CSPL-0009228-05-2019Student2ndYearBatchAllotmentCS            Student Batch Allotment for 2nd Year
    // 7      CSPL-0009228-05-2019GenerateInternalExamGroupCS                Generate Internal Exam Group
    // 8      CSPL-0009228-05-2019GenerateInternalAssignmentDetailsCS        Generate Internal Assignment Details
    // 9      CSPL-0009228-05-2019GenerateInternalExamGroupSubjClassWiseCS  Generate Internal ClassWise Exam Group Subject
    // 10    CSPL-0009228-05-2019GenerateTimeTableCS                        Generate Time Table
    // 11    CSPL-0009228-05-2019TestCapcityCS                              Test Capcity
    // 12    CSPL-0009228-05-2019TestCapcityDocumentWiseCs                  Text Capcity Document Wise
    // 13    CSPL-0009228-05-2019GenerateSittingPlanCS                      Generate Sitting Plan
    // 14    CSPL-0009228-05-2019GenerateSittingPlanDocumentWiseCS          Generate Sitting Plan Document Wise
    // 15    CSPL-0009228-05-2019GenerateExamLogCS                          Generate Examination Log
    // 16    CSPL-0009228-05-2019GenerateStudentSubjectLogCS                Generate Student Subject Log
    // 17    CSPL-0009228-05-2019RegularExamResultPublishCS                Publish Regular Examination Result
    // 18    CSPL-0009228-05-2019MakeupExamResultPublishCS                  Publish Makeup Exam Result
    // 19    CSPL-0009228-05-2019Revaluation1stExamResultPublishCS          Publish Revaluation 1st Exam Result
    // 20    CSPL-0009228-05-2019Revaluation2stExamResultPublishCS          Publish Revaluation 2nd Exam Result
    // 21    CSPL-0009228-05-2019Revaluation3ExamRLesultPublishCS          Publish Revaluation 3rd Exam Result
    // 22    CSPL-0009228-05-2019SpacialExamResultPublishCS                Publish Spacial Exam Result
    // 23    CSPL-0009228-05-2019CalculateStudentSubAttendanceCS            Calculate Student Subject Attendance
    // 24    CSPL-0009228-05-2019CalculateStudentSubAttenForReportCS        Calculate Student Subject Attendance For Report
    // 25    CSPL-0009228-05-2019TimeSlotValidateCS                        Time Slot Validate
    // 26    CSPL-0009228-05-2019AutomaticBatchAllotmentCS                  Automatic Batch Allotment
    // 27    CSPL-0009228-05-2019SelectedBatchAllotmentCS                  Selected Batch Allotment
    // 28    CSPL-0009228-05-2019GenerateSittingPlanNew                    Create Sitting Plan New
    // 29    CSPL-0009228-05-2019GenerateSittingPlanDocumentWiseNewCS      Create Sitting Plan Document Wise New
    // 30    CSPL-0009228-05-2019ClearSittingPlanDocumentWiseCS            Clear Sitting Plan Document Wise
    // 31    CSPL-0009228-05-2019HallTicketCreationCS                      Hall Ticket Geneartion
    // 32    CSPL-0009228-05-2019DocumentWiseHallTicketCreationCS          Hall Ticket Geneartion Document Wise
    // 33    CSPL-0009228-05-2019BatchAllotmentWithoutRollNoCS              Automatic Batch Allotment Without Roll No
    // 34    CSPL-0009228-05-2019CalculateAttendanceForExamWithAddCreditCS  Calculate Attendance For Exam With Add Credit


    trigger OnRun()
    begin
    end;

    var

        UserSetupRec: Record "User Setup";
        A: Integer;


    procedure StudentSubjectUpdateCS(StudentNo: Code[20])
    var
        StudentMasterCS: Record "Student Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
    begin
        //Code added for Update Student Subject ::CSPL-00092::28-05-2019: Start
        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE("No.", StudentNo);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS1.Reset();
            MainStudentSubjectCS1.SETRANGE("Student No.", StudentMasterCS."No.");
            MainStudentSubjectCS1.SETRANGE(Course, StudentMasterCS."Course Code");
            MainStudentSubjectCS1.SETRANGE(Semester, StudentMasterCS.Semester);
            IF StudentMasterCS.Group <> '' THEN
                MainStudentSubjectCS1.SETRANGE(Group, StudentMasterCS.Group);
            MainStudentSubjectCS1.SETRANGE("Academic Year", StudentMasterCS."Academic Year");
            //IF Not MainStudentSubjectCS1.FINDSET() THEN BEGIN
            IF MainStudentSubjectCS1.ISEMPTY() then BEGIN
                CourseWiseSubjectLineCS.Reset();
                CourseWiseSubjectLineCS.SETRANGE("Course Code", StudentMasterCS."Course Code");
                CourseWiseSubjectLineCS.SETRANGE(Semester, StudentMasterCS.Semester);
                CourseWiseSubjectLineCS.SETRANGE("Academic Year", StudentMasterCS."Academic Year");
                IF StudentMasterCS.Group <> '' THEN
                    CourseWiseSubjectLineCS.SETRANGE("Student Group", StudentMasterCS.Group);
                CourseWiseSubjectLineCS.SETRANGE("Subject Type", 'CORE');
                IF CourseWiseSubjectLineCS.FINDSET() THEN
                    REPEAT
                        MainStudentSubjectCS.INIT();
                        MainStudentSubjectCS."Student No." := StudentMasterCS."No.";
                        MainStudentSubjectCS."Student Name" := StudentMasterCS."Student Name";
                        MainStudentSubjectCS.Course := StudentMasterCS."Course Code";
                        MainStudentSubjectCS.Semester := StudentMasterCS.Semester;
                        MainStudentSubjectCS.Year := StudentMasterCS.Year;
                        MainStudentSubjectCS."Enrollment No" := StudentMasterCS."Enrollment No.";
                        MainStudentSubjectCS.Section := StudentMasterCS.Section;
                        MainStudentSubjectCS.Graduation := StudentMasterCS.Graduation;
                        MainStudentSubjectCS."Academic Year" := StudentMasterCS."Academic Year";
                        MainStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                        MainStudentSubjectCS.Validate("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                        MainStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";

                        MainStudentSubjectCS.VALIDATE("Actual Academic Year", StudentMasterCS."Academic Year");
                        MainStudentSubjectCS.VALIDATE("Actual Semester", StudentMasterCS.Semester);
                        MainStudentSubjectCS.VALIDATE("Actual Year", StudentMasterCS.Year);
                        MainStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        MainStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;

                        MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                        MainStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                        MainStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                        MainStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                        MainStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                        MainStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                        MainStudentSubjectCS.Group := StudentMasterCS.Group;
                        IF StudentMasterCS.Semester = 'III & IV' THEN BEGIN
                            MainStudentSubjectCS."Current Session" := 'JUL-MAY';
                            MainStudentSubjectCS."Previous Session" := 'JUL-MAY';
                            MainStudentSubjectCS."Actual Session" := 'JUL-MAY';
                        END ELSE BEGIN
                            EducationSetupCS.Reset();
                            EducationSetupCS.SetRange("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                            If EducationSetupCS.FindFirst() Then begin
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                    MainStudentSubjectCS."Current Session" := 'JAN-MAY';
                                    MainStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                    MainStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                END ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                        MainStudentSubjectCS."Current Session" := 'JUL-NOV';
                                        MainStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                        MainStudentSubjectCS."Actual Session" := 'JUL-NOV';
                                    END;
                            end;
                        END;
                        MainStudentSubjectCS.INSERT();
                    UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
            END ELSE
                COMMIT();
        END;
        //Code added for Update Student Subject ::CSPL-00092::28-05-2019: End
    end;

    procedure ProcessPromotionCS(StudentPromotionLine: Record "Promotion Line-CS")
    var
        StudentMasterCS: Record "Student Master-CS";

        CourseMasterCS: Record "Course Master-CS";

        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        AdmissionSetupCS: Record "Admission Setup-CS";
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        CourseSemMasterCS1: Record "Course Sem. Master-CS";
        CourseSemMasterCS2: Record "Course Sem. Master-CS";
        CourseSemMasterCS3: Record "Course Sem. Master-CS";
        GroupMasterCS: Record "Group Master-CS";
        SetSemester: Code[20];

        LastSemester: Code[20];

        SetGroup: Code[20];
        SecondLastSem: Code[20];

        SetYear: Code[20];

        SQNo: Integer;

        Text_10001Lbl: Label 'Course Semester For Course(%1), Academic Year (%2) Is Not Defined !!', Comment = 'Foo', MaxLength = 999, Locked = true;


    begin
        //Code added for Promotion Process ::CSPL-00092::28-05-2019: Start
        AdmissionSetupCS.GET();
        AdmissionSetupCS.TESTFIELD("Admission Year");

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", StudentPromotionLine."Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN
            IF StudentPromotionLine."Type Of Course" <> StudentPromotionLine."Type Of Course"::Year THEN BEGIN
                SetYear := StudentPromotionLine.Year;
                SQNo := 0;
                SetSemester := '';
                LastSemester := '';
                SetYear := '';
                SetGroup := '';

                CourseSemMasterCS2.Reset();
                CourseSemMasterCS2.SETCURRENTKEY("Semester Code");
                CourseSemMasterCS2.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                CourseSemMasterCS2.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                IF CourseSemMasterCS2.FINDSET() THEN
                    CourseSemMasterCS3.Reset();
                CourseSemMasterCS3.SETCURRENTKEY("Semester Code");
                CourseSemMasterCS3.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                CourseSemMasterCS3.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                CourseSemMasterCS3.SETRANGE("Sequence No", CourseSemMasterCS2.COUNT() - 1);
                IF CourseSemMasterCS3.FINDFIRST() THEN
                    SecondLastSem := CourseSemMasterCS3."Semester Code";


                CourseSemMasterCS.Reset();
                CourseSemMasterCS.SETCURRENTKEY("Semester Code");
                CourseSemMasterCS.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                CourseSemMasterCS.SETRANGE("Semester Code", StudentPromotionLine.Semester);
                CourseSemMasterCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                IF CourseSemMasterCS.FINDFIRST() THEN
                    SQNo := CourseSemMasterCS."Sequence No" + 1
                ELSE
                    ERROR(Text_10001Lbl, StudentPromotionLine."Course Code", StudentPromotionLine."Academic Year");

                CourseSemMasterCS1.Reset();
                CourseSemMasterCS1.SETCURRENTKEY("Semester Code");
                CourseSemMasterCS1.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                CourseSemMasterCS1.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                CourseSemMasterCS1.SETRANGE("Sequence No", SQNo);
                IF CourseSemMasterCS1.FINDFIRST() THEN
                    SetSemester := CourseSemMasterCS1."Semester Code"
                ELSE
                    LastSemester := StudentPromotionLine.Semester;

                IF SetSemester = 'II' THEN
                    SetYear := '1ST';

                IF SetSemester = 'III' THEN
                    SetYear := '2ND';

                IF SetSemester = 'IV' THEN
                    SetYear := '2ND';

                IF SetSemester = 'V' THEN
                    SetYear := '3RD';

                IF SetSemester = 'VI' THEN
                    SetYear := '3RD';

                IF SetSemester = 'VII' THEN
                    SetYear := '4TH';

                IF SetSemester = 'VIII' THEN
                    SetYear := '4TH';

                IF SetSemester = 'III & IV' THEN
                    SetYear := '2ND';

                IF (StudentPromotionLine.Semester = 'I') AND (StudentPromotionLine."Graduation Code" = 'UG') THEN BEGIN
                    GroupMasterCS.Reset();
                    GroupMasterCS.SETFILTER(Code, '<>%1', StudentPromotionLine.Group);
                    IF GroupMasterCS.FINDFIRST() THEN
                        SetGroup := GroupMasterCS.Code;
                END;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                    StudentMasterCS.VALIDATE(Semester, SetSemester);
                    StudentMasterCS.VALIDATE(Year, SetYear);
                    IF SetGroup <> '' THEN
                        StudentMasterCS.VALIDATE(Group, SetGroup);
                    StudentMasterCS.VALIDATE("Academic Year", AdmissionSetupCS."Admission Year");
                    StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
                    IF (SetSemester = 'III') OR (SetSemester = 'V') OR (SetSemester = 'VII') THEN
                        StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::Student);
                    IF (SetSemester = 'III') THEN BEGIN
                        StudentMasterCS.VALIDATE(Section, '');
                        StudentMasterCS.VALIDATE("Roll No.", '');
                        StudentMasterCS.VALIDATE(Group, '');
                    END;
                    IF StudentPromotionLine.Semester = SecondLastSem THEN
                        StudentMasterCS.VALIDATE("Course Completion NOC", TRUE);
                    IF StudentPromotionLine.Semester = LastSemester THEN BEGIN
                        StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::"Course Completion");
                        StudentMasterCS.VALIDATE("Academic Year", EducationSetupCS."Academic Year");
                        StudentMasterCS.VALIDATE("Date of Leaving", TODAY());
                    END;
                    StudentMasterCS.Modify();
                END;

                StudentPromotionLine."Promoted Semester" := SetSemester;
                StudentPromotionLine."Promoted Year" := SetYear;
                StudentPromotionLine."Promoted To Group" := SetGroup;
                StudentPromotionLine."Student Promoted" := TRUE;
                StudentPromotionLine."Promoted  Academic Year" := AdmissionSetupCS."Admission Year";
                StudentPromotionLine.Modify();

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE("Student No.", StudentPromotionLine."Student No.");
                MainStudentSubjectCS.SETRANGE(Course, StudentPromotionLine."Course Code");
                MainStudentSubjectCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                MainStudentSubjectCS.SETRANGE(Semester, StudentPromotionLine.Semester);
                IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                    MainStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
                    MainStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
                    MainStudentSubjectCS.MODIFYALL(Revaluation1, FALSE);
                    MainStudentSubjectCS.MODIFYALL(Revaluation2, FALSE);
                    MainStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
                    MainStudentSubjectCS.MODIFYALL("Re-Apply", FALSE);
                END;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE("Student No.", StudentPromotionLine."Student No.");
                OptionalStudentSubjectCS.SETRANGE(Course, StudentPromotionLine."Course Code");
                OptionalStudentSubjectCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                OptionalStudentSubjectCS.SETRANGE(Semester, StudentPromotionLine.Semester);
                IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                    OptionalStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
                    OptionalStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
                    OptionalStudentSubjectCS.MODIFYALL(Revaluation1, FALSE);
                    OptionalStudentSubjectCS.MODIFYALL(Revaluation2, FALSE);
                    OptionalStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
                    OptionalStudentSubjectCS.MODIFYALL("Re-Apply", FALSE);
                END;
            END ELSE
                IF (StudentPromotionLine."Type Of Course" = StudentPromotionLine."Type Of Course"::Year) THEN BEGIN
                    CourseMasterCS.Reset();
                    CourseMasterCS.SETRANGE(Code, StudentPromotionLine."Course Code");
                    IF CourseMasterCS.FINDFIRST() THEN //- Field type change
                        IF CourseMasterCS."Degree Code" = 'M.Tech.' THEN BEGIN
                            SQNo := 0;
                            SetSemester := '';
                            LastSemester := '';
                            SetYear := '';
                            SetGroup := '';
                            CourseSemMasterCS2.Reset();
                            CourseSemMasterCS2.SETCURRENTKEY("Semester Code");
                            CourseSemMasterCS2.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                            CourseSemMasterCS2.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                            IF CourseSemMasterCS2.FINDSET() THEN
                                CourseSemMasterCS3.Reset();
                            CourseSemMasterCS3.SETCURRENTKEY("Semester Code");
                            CourseSemMasterCS3.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                            CourseSemMasterCS3.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                            CourseSemMasterCS3.SETRANGE("Sequence No", CourseSemMasterCS2.COUNT() - 1);
                            IF CourseSemMasterCS3.FINDFIRST() THEN
                                SecondLastSem := CourseSemMasterCS3."Semester Code";


                            CourseSemMasterCS.Reset();
                            CourseSemMasterCS.SETCURRENTKEY("Semester Code");
                            CourseSemMasterCS.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                            CourseSemMasterCS.SETRANGE("Semester Code", StudentPromotionLine.Semester);
                            CourseSemMasterCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                            IF CourseSemMasterCS.FINDFIRST() THEN
                                SQNo := CourseSemMasterCS."Sequence No" + 1
                            ELSE
                                ERROR(Text_10001Lbl, StudentPromotionLine."Course Code", StudentPromotionLine."Academic Year");

                            CourseSemMasterCS1.Reset();
                            CourseSemMasterCS1.SETCURRENTKEY("Semester Code");
                            CourseSemMasterCS1.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                            CourseSemMasterCS1.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                            CourseSemMasterCS1.SETRANGE("Sequence No", SQNo);
                            IF CourseSemMasterCS1.FINDFIRST() THEN
                                SetSemester := CourseSemMasterCS1."Semester Code"
                            ELSE
                                LastSemester := StudentPromotionLine.Semester;
                            IF SetSemester = 'II' THEN
                                SetYear := '1ST'
                            ELSE
                                IF SetSemester = 'III & IV' THEN
                                    SetYear := '2ND';

                            StudentMasterCS.Reset();
                            StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
                            IF StudentMasterCS.FINDFIRST() THEN BEGIN
                                StudentMasterCS.VALIDATE(Semester, SetSemester);
                                StudentMasterCS.VALIDATE(Year, SetYear);
                                StudentMasterCS.VALIDATE("Academic Year", AdmissionSetupCS."Admission Year");
                                StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
                                IF (SetSemester = 'III & IV') THEN
                                    StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::Student);
                                IF (SetSemester = 'III & IV') THEN BEGIN
                                    StudentMasterCS.VALIDATE(Section, '');
                                    StudentMasterCS.VALIDATE("Roll No.", '');
                                    StudentMasterCS.VALIDATE(Group, '');
                                END;
                                IF StudentPromotionLine.Semester = SecondLastSem THEN
                                    StudentMasterCS.VALIDATE("Course Completion NOC", TRUE);
                                IF StudentPromotionLine.Semester = LastSemester THEN BEGIN
                                    StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::"Course Completion");
                                    StudentMasterCS.VALIDATE("Academic Year", EducationSetupCS."Academic Year");
                                    StudentMasterCS.VALIDATE("Date of Leaving", TODAY());
                                END;
                                StudentMasterCS.Modify();
                            END;

                            StudentPromotionLine."Promoted Semester" := SetSemester;
                            StudentPromotionLine."Promoted Year" := SetYear;
                            StudentPromotionLine."Student Promoted" := TRUE;
                            StudentPromotionLine."Promoted  Academic Year" := AdmissionSetupCS."Admission Year";
                            StudentPromotionLine.Modify();

                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETRANGE("Student No.", StudentPromotionLine."Student No.");
                            MainStudentSubjectCS.SETRANGE(Course, StudentPromotionLine."Course Code");
                            MainStudentSubjectCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                            MainStudentSubjectCS.SETRANGE(Semester, StudentPromotionLine.Semester);
                            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                MainStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
                                MainStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
                                MainStudentSubjectCS.MODIFYALL(Revaluation1, FALSE);
                                MainStudentSubjectCS.MODIFYALL(Revaluation2, FALSE);
                                MainStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
                                MainStudentSubjectCS.MODIFYALL("Re-Apply", FALSE);
                            END;

                            OptionalStudentSubjectCS.Reset();
                            OptionalStudentSubjectCS.SETRANGE("Student No.", StudentPromotionLine."Student No.");
                            OptionalStudentSubjectCS.SETRANGE(Course, StudentPromotionLine."Course Code");
                            OptionalStudentSubjectCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                            OptionalStudentSubjectCS.SETRANGE(Semester, StudentPromotionLine.Semester);
                            IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                                OptionalStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
                                OptionalStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
                                OptionalStudentSubjectCS.MODIFYALL(Revaluation1, FALSE);
                                OptionalStudentSubjectCS.MODIFYALL(Revaluation2, FALSE);
                                OptionalStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
                                OptionalStudentSubjectCS.MODIFYALL("Re-Apply", FALSE);
                            END;
                        END ELSE
                            IF CourseMasterCS."Degree Code" = 'MCA' THEN BEGIN
                                SQNo := 0;
                                SetSemester := '';
                                LastSemester := '';
                                SetYear := '';
                                SetGroup := '';

                                CourseSemMasterCS2.Reset();
                                CourseSemMasterCS2.SETCURRENTKEY("Semester Code");
                                CourseSemMasterCS2.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                                CourseSemMasterCS2.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                                IF CourseSemMasterCS2.FINDSET() THEN
                                    CourseSemMasterCS3.Reset();
                                CourseSemMasterCS3.SETCURRENTKEY("Semester Code");
                                CourseSemMasterCS3.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                                CourseSemMasterCS3.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                                CourseSemMasterCS3.SETRANGE("Sequence No", CourseSemMasterCS2.COUNT() - 1);
                                IF CourseSemMasterCS3.FINDFIRST() THEN
                                    SecondLastSem := CourseSemMasterCS3."Semester Code";


                                CourseSemMasterCS.Reset();
                                CourseSemMasterCS.SETCURRENTKEY("Semester Code");
                                CourseSemMasterCS.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                                CourseSemMasterCS.SETRANGE("Semester Code", StudentPromotionLine.Semester);
                                CourseSemMasterCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                                IF CourseSemMasterCS.FINDFIRST() THEN
                                    SQNo := CourseSemMasterCS."Sequence No" + 1
                                ELSE
                                    ERROR(Text_10001Lbl, StudentPromotionLine."Course Code", StudentPromotionLine."Academic Year");

                                CourseSemMasterCS1.Reset();
                                CourseSemMasterCS1.SETCURRENTKEY("Semester Code");
                                CourseSemMasterCS1.SETRANGE("Course Code", StudentPromotionLine."Course Code");
                                CourseSemMasterCS1.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                                CourseSemMasterCS1.SETRANGE("Sequence No", SQNo);
                                IF CourseSemMasterCS1.FINDFIRST() THEN
                                    SetSemester := CourseSemMasterCS1."Semester Code"
                                ELSE
                                    LastSemester := StudentPromotionLine.Semester;
                                IF SetSemester = 'II' THEN
                                    SetYear := '1ST';

                                IF SetSemester = 'III' THEN
                                    SetYear := '2ND';

                                IF SetSemester = 'IV' THEN
                                    SetYear := '2ND';

                                IF SetSemester = 'V' THEN
                                    SetYear := '3RD';

                                IF SetSemester = 'VI' THEN
                                    SetYear := '3RD';

                                IF SetSemester = 'VII' THEN
                                    SetYear := '4TH';

                                IF SetSemester = 'VIII' THEN
                                    SetYear := '4TH';

                                StudentMasterCS.Reset();
                                StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentPromotionLine."Student No.");
                                IF StudentMasterCS.FINDFIRST() THEN BEGIN
                                    StudentMasterCS.VALIDATE(Semester, SetSemester);
                                    StudentMasterCS.VALIDATE(Year, SetYear);
                                    StudentMasterCS.VALIDATE("Academic Year", AdmissionSetupCS."Admission Year");
                                    StudentMasterCS.VALIDATE("Pending For Registration", TRUE);
                                    IF (SetSemester = 'III') OR (SetSemester = 'V') OR (SetSemester = 'VII') THEN
                                        StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::Student);
                                    IF StudentPromotionLine.Semester = SecondLastSem THEN
                                        StudentMasterCS.VALIDATE("Course Completion NOC", TRUE);
                                    IF StudentPromotionLine.Semester = LastSemester THEN BEGIN
                                        StudentMasterCS.VALIDATE("Student Status", StudentMasterCS."Student Status"::"Course Completion");
                                        StudentMasterCS.VALIDATE("Date of Leaving", TODAY());
                                    END;
                                    StudentMasterCS.Modify();
                                END;

                                StudentPromotionLine."Promoted Semester" := SetSemester;
                                StudentPromotionLine."Promoted Year" := SetYear;
                                StudentPromotionLine."Student Promoted" := TRUE;
                                StudentPromotionLine."Promoted  Academic Year" := AdmissionSetupCS."Admission Year";
                                StudentPromotionLine.Modify();

                                MainStudentSubjectCS.Reset();
                                MainStudentSubjectCS.SETRANGE("Student No.", StudentPromotionLine."Student No.");
                                MainStudentSubjectCS.SETRANGE(Course, StudentPromotionLine."Course Code");
                                MainStudentSubjectCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                                MainStudentSubjectCS.SETRANGE(Semester, StudentPromotionLine.Semester);
                                IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                    MainStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
                                    MainStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
                                    MainStudentSubjectCS.MODIFYALL(Revaluation1, FALSE);
                                    MainStudentSubjectCS.MODIFYALL(Revaluation2, FALSE);
                                    MainStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
                                    MainStudentSubjectCS.MODIFYALL("Re-Apply", FALSE);
                                END;

                                OptionalStudentSubjectCS.Reset();
                                OptionalStudentSubjectCS.SETRANGE("Student No.", StudentPromotionLine."Student No.");
                                OptionalStudentSubjectCS.SETRANGE(Course, StudentPromotionLine."Course Code");
                                OptionalStudentSubjectCS.SETRANGE("Academic Year", StudentPromotionLine."Academic Year");
                                OptionalStudentSubjectCS.SETRANGE(Semester, StudentPromotionLine.Semester);
                                IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                                    OptionalStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
                                    OptionalStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
                                    OptionalStudentSubjectCS.MODIFYALL(Revaluation1, FALSE);
                                    OptionalStudentSubjectCS.MODIFYALL(Revaluation2, FALSE);
                                    OptionalStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
                                    OptionalStudentSubjectCS.MODIFYALL("Re-Apply", FALSE);
                                END;
                            END;//- Field type change
                END;
        //Code added for Promotion Process ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateStudentPromotionCS(LastAcademicYear: Code[20]; InstituteCode: Code[20])
    var
        CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
        EducationSetupCS: Record "Education Setup-CS";

        AcademicsSetupCS: Record "Academics Setup-CS";
        PromotionHeaderCS: Record "Promotion Header-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        AttendanceActionCS: Codeunit "Attendance Action-CS";
        Counter: Integer;
        NextNo: Code[20];
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING PROMOTION LINE... #1  Out Of  @2 .';
    begin
        //Code added for Generate Student Promotion ::CSPL-00092::28-05-2019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");
        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS.Promoted = TRUE THEN
                ERROR('Promotion Details Already Generated !!');
        END ELSE
            ERROR('Education Setup Not Defined !!');

        CourseWiseSubjectHeadCS.Reset();
        CourseWiseSubjectHeadCS.SETRANGE("Academic Year", LastAcademicYear);
        CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF CourseWiseSubjectHeadCS.FINDSET() THEN
            CourseWiseSubjectHeadCS.MODIFYALL(Promoted, FALSE);

        CourseWiseSubjectHeadCS.Reset();
        CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, "Type Of Course", Semester, Year);
        CourseWiseSubjectHeadCS.SETRANGE("Academic Year", LastAcademicYear);
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectHeadCS.SETRANGE("Program", 'UG');
        CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF CourseWiseSubjectHeadCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectHeadCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Student Promotion No.", 0D, TRUE);

                PromotionHeaderCS.INIT();
                PromotionHeaderCS."No." := NextNo;
                PromotionHeaderCS.VALIDATE(Course, CourseWiseSubjectHeadCS.Course);
                PromotionHeaderCS."Academic Year" := CourseWiseSubjectHeadCS."Academic Year";
                PromotionHeaderCS.Semester := CourseWiseSubjectHeadCS.Semester;
                PromotionHeaderCS.Year := CourseWiseSubjectHeadCS.Year;
                PromotionHeaderCS."Created By" := FORMAT(UserId());
                PromotionHeaderCS."Created On" := TODAY();
                PromotionHeaderCS.INSERT();

                AttendanceActionCS.GetStudentsPromotionDetail(PromotionHeaderCS);

                CourseWiseSubjectHeadCS.Promoted := TRUE;
                CourseWiseSubjectHeadCS.Modify();
            UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;
            PROGRESS.Close();
        END;

        CourseWiseSubjectHeadCS.Reset();
        CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, "Type Of Course", Semester, Year);
        CourseWiseSubjectHeadCS.SETRANGE("Academic Year", LastAcademicYear);
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectHeadCS.SETRANGE("Program", 'PG');
        CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF CourseWiseSubjectHeadCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectHeadCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Student Promotion No.", 0D, TRUE);
                PromotionHeaderCS.INIT();
                PromotionHeaderCS."No." := NextNo;
                PromotionHeaderCS.VALIDATE(Course, CourseWiseSubjectHeadCS.Course);
                PromotionHeaderCS."Academic Year" := CourseWiseSubjectHeadCS."Academic Year";
                PromotionHeaderCS.Semester := CourseWiseSubjectHeadCS.Semester;
                PromotionHeaderCS.Year := CourseWiseSubjectHeadCS.Year;
                PromotionHeaderCS."Created By" := FORMAT(UserId());
                PromotionHeaderCS."Created On" := TODAY();
                PromotionHeaderCS.INSERT();
                AttendanceActionCS.GetStudentsPromotionDetail(PromotionHeaderCS);
                CourseWiseSubjectHeadCS.Promoted := TRUE;
                CourseWiseSubjectHeadCS.Modify();
            UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;
            PROGRESS.Close();
        END;

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS.Promoted := TRUE;
            EducationSetupCS.Modify();
        END;

        //Code added for Generate Student Promotion ::CSPL-00092::28-05-2019: End
    end;

    procedure FeeCreationOnStudentPromotionCS(StudentNo: Code[20]; var FeeGenerated: Boolean)
    var

        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        FeeComponentMasterCS: Record "Fee Component Master-CS";


        FeeSetupCS: Record "Fee Setup-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        FeeCourseHeadCS1: Record "Fee Course Head-CS";
        // FeeCourseLineCS1: Record "Fee Course Line-CS";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        customer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";

        // FeeAmount: Decimal;
        // VarFeeType: Code[150];
        YearPart: Option " ","1st","2nd";
        Amount: Decimal;
        //Counter: Integer;
        //Window: Dialog;
        //CounterTotal: Integer;
        //CounterOK: Integer;
        // Countno: Integer;

        DueDate: Date;
        // AcademicYear: Code[10];

        // EnrollmentNo: Code[20];
        Amount1: Decimal;
        TempDocNo: Code[20];


    begin
        //Code added for Student Batch Allotment for 1st year ::CSPL-00092::28-05-2019: Start
        CLEAR(TempDocNo);
        customer.GET(StudentNo);

        FeeSetupCS.GET();
        FeeSetupCS.TESTFIELD("Journal Template Name");
        FeeSetupCS.TESTFIELD("Journal Batch Name");

        EducationMultiEventCalCS.Reset();
        EducationMultiEventCalCS.SETRANGE("Event Code", 'FEES PAYMENT');
        EducationMultiEventCalCS.SETRANGE("Academic Year", customer."Academic Year");
        IF EducationMultiEventCalCS.FINDFIRST() THEN
            DueDate := EducationMultiEventCalCS."End Date"
        ELSE
            ERROR('Fee Payment Event Not Generated !!');

        CustLedgerEntry.Reset();
        CustLedgerEntry.SETRANGE("Customer No.", customer."No.");
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Academic Year", customer."Academic Year");
        CustLedgerEntry.SETRANGE(Year, customer.Year);
        CustLedgerEntry.SETRANGE(Reversed, FALSE);
        IF CustLedgerEntry.ISEMPTY() then BEGIN

            TempDocNo := NoSeries.GetNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);
            Amount := 0;

            FeeCourseHeadCS.Reset();
            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Course Code", customer."Course Code");
            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Fee Classification Code", customer."Fee Classification Code");
            IF customer."Lateral Student" THEN
                FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS.Category, customer.Category);
            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Academic Year", customer."Academic Year");
            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 1 Code", customer."Global Dimension 1 Code");
            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Global Dimension 2 Code", customer."Global Dimension 2 Code");
            FeeCourseHeadCS.SETRANGE(FeeCourseHeadCS."Admitted Year", customer."Admitted Year");
            FeeCourseHeadCS.SETRANGE(Year, customer.Year);
            IF FeeCourseHeadCS.FINDFIRST() THEN BEGIN
                FeeCourseLineCS.Reset();
                FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                FeeCourseLineCS.SETRANGE(FeeCourseLineCS."Fee Group Type", FeeCourseLineCS."Fee Group Type"::Admission);
                IF FeeCourseLineCS.FINDSET() THEN
                    REPEAT
                        FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                        ManagementsFeeCS.FeeProcessNewCS(customer."No.", FeeCourseLineCS."Fee Code", FeeCourseLineCS.Amount, customer, YearPart, TempDocNo, FeeCourseHeadCS."Currency Code", DueDate);
                        Amount += FeeCourseLineCS.Amount;
                    UNTIL FeeCourseLineCS.NEXT() = 0;
                ManagementsFeeCS.CustomerInsertCS(customer."No.", FeeCourseLineCS."Fee Code", Amount, customer, YearPart, TempDocNo, FeeCourseHeadCS."Late Fine %", FeeCourseHeadCS."Currency Code", DueDate);
                FeeGenerated := TRUE;
            END;


            Amount1 := 0;
            TempDocNo := NoSeries.GetNextNo(FeeSetupCS."Fee Invoice No.", 0D, TRUE);

            FeeCourseHeadCS1.Reset();
            FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Course Code", customer."Course Code");
            FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Fee Classification Code", customer."Fee Classification Code");
            IF customer."Lateral Student" THEN
                FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1.Category, customer.Category);
            FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Academic Year", customer."Academic Year");
            FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Global Dimension 1 Code", customer."Global Dimension 1 Code");
            FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Global Dimension 2 Code", customer."Global Dimension 2 Code");
            FeeCourseHeadCS1.SETRANGE(FeeCourseHeadCS1."Admitted Year", customer."Admitted Year");
            FeeCourseHeadCS1.SETRANGE(Year, customer.Year);
            IF FeeCourseHeadCS1.FINDFIRST() THEN BEGIN
                FeeCourseLineCS.Reset();
                FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
                FeeCourseLineCS.SETRANGE(FeeCourseLineCS."Fee Code", 'CAUN');
                IF FeeCourseLineCS.FINDSET() THEN BEGIN
                    REPEAT
                        FeeComponentMasterCS.GET(FeeCourseLineCS."Fee Code");
                        ManagementsFeeCS.FeeProcessNewCS(customer."No.", FeeCourseLineCS."Fee Code", FeeCourseLineCS.Amount, customer, YearPart, TempDocNo, FeeCourseHeadCS1."Currency Code", DueDate);
                        Amount1 += FeeCourseLineCS.Amount;
                    UNTIL FeeCourseLineCS.NEXT() = 0;
                    ManagementsFeeCS.CustomerCautionInsertCS(customer."No.", FeeCourseLineCS."Fee Code", Amount1, customer, YearPart, TempDocNo, FeeCourseHeadCS1."Late Fine %", FeeCourseHeadCS1."Currency Code", DueDate);
                END;
            END;
        END;
        //Code added for Student Batch Allotment for 1st year ::CSPL-00092::28-05-2019: End
    end;
    //SD-SN-17-Dec-2020 +
    procedure GetuserSetupInstitudeCode(): Text
    var
        UserSetup: Record "User Setup";
    begin
        if usersetup.get(UserId()) then
            Exit(Format(UserSetup."Global Dimension 1 Code"));

    end;
    //SD-SN-17-Dec-2020 -
    procedure Student1styearBatchAllotmentCS(YearValue: Code[10]; AcademicYear: Code[10])
    var
        SectionMasterCS: Record "Section Master-CS";
        GroupMasterCS: Record "Group Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        StudentMasterCS1: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        StudentMasterCS2: Record "Student Master-CS";
        // StudCount: Integer;
        StudCountDiv: Integer;

        RollNo: Integer;

        Text_10001Lbl: Label 'Student Section Not Alloted , First Allot Student Section !!';

        Text_10002Lbl: Label 'Student Roll No. Not Assigned !!';

        Text_10003Lbl: Label 'Student Section Not Assigned !!';

        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10004Lbl: Label 'BATCH PROCESSING #1  Out Of  @2 .';
    begin
        //Code added for Student Batch Allotment for 1st year ::CSPL-00092::28-05-2019: Start
        GroupMasterCS.Reset();
        GroupMasterCS.SETCURRENTKEY(Code);
        TotalCount := GroupMasterCS.count();
        PROGRESS.OPEN(Text_10004Lbl);
        IF GroupMasterCS.FINDSET() THEN
            REPEAT
                SectionMasterCS.Reset();
                SectionMasterCS.SETCURRENTKEY(Code);
                SectionMasterCS.SETRANGE(Group, GroupMasterCS.Code);
                IF SectionMasterCS.FINDSET() THEN
                    REPEAT

                        StudentMasterCS1.Reset();
                        StudentMasterCS1.SETRANGE(Year, YearValue);
                        StudentMasterCS1.SETRANGE(Section, SectionMasterCS.Code);
                        StudentMasterCS1.SETRANGE("Academic Year", AcademicYear);
                        StudentMasterCS1.SETRANGE("Roll No.", '');
                        IF StudentMasterCS1.FINDFIRST() THEN
                            ERROR(Text_10002Lbl);

                        StudentMasterCS2.Reset();
                        StudentMasterCS2.SETRANGE(Year, YearValue);
                        StudentMasterCS2.SETRANGE(Section, SectionMasterCS.Code);
                        StudentMasterCS2.SETRANGE("Academic Year", AcademicYear);
                        StudentMasterCS2.SETRANGE(Section, '');
                        IF StudentMasterCS2.FINDFIRST() THEN
                            ERROR(Text_10003Lbl);


                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(StudentMasterCS.Year, YearValue);
                        StudentMasterCS.SETRANGE(StudentMasterCS.Section, SectionMasterCS.Code);
                        StudentMasterCS.SETRANGE(StudentMasterCS."Academic Year", AcademicYear);
                        IF StudentMasterCS.FINDSET() THEN
                            REPEAT

                                A := StudentMasterCS.count();
                                StudCountDiv := ROUND(StudentMasterCS.COUNT() / 2, 1, '>');
                                EVALUATE(RollNo, StudentMasterCS."Roll No.");
                                IF RollNo <= StudCountDiv THEN
                                    StudentMasterCS.VALIDATE(Batch, 'BATCH-1')
                                ELSE
                                    StudentMasterCS.VALIDATE(Batch, 'BATCH-2');
                                StudentMasterCS.Modify();

                                MainStudentSubjectCS.Reset();
                                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Year, StudentMasterCS.Year);
                                MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                                IF MainStudentSubjectCS.FINDSET() THEN
                                    REPEAT
                                        MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester,
                                                              MainStudentSubjectCS."Academic Year", MainStudentSubjectCS."Subject Code", StudentMasterCS.Section);
                                        MainStudentSubjectCS."Roll No." := StudentMasterCS."Roll No.";
                                        MainStudentSubjectCS.Batch := StudentMasterCS.Batch;
                                        MainStudentSubjectCS.Modify();
                                    UNTIL MainStudentSubjectCS.NEXT() = 0;

                                OptionalStudentSubjectCS.Reset();
                                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Year, StudentMasterCS.Year);
                                OptionalStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                                IF OptionalStudentSubjectCS.FINDSET() THEN
                                    REPEAT
                                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester,
                                                                      OptionalStudentSubjectCS."Academic Year", OptionalStudentSubjectCS."Subject Code", StudentMasterCS.Section);
                                        OptionalStudentSubjectCS."Roll No." := StudentMasterCS."Roll No.";
                                        OptionalStudentSubjectCS.Batch := StudentMasterCS.Batch;
                                        OptionalStudentSubjectCS.Modify();
                                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;


                            UNTIL StudentMasterCS.NEXT() = 0
                        ELSE
                            ERROR(Text_10001Lbl);
                    UNTIL SectionMasterCS.NEXT() = 0;
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
            UNTIL GroupMasterCS.NEXT() = 0;
        PROGRESS.Close();
        //Code added for Student Batch Allotment for 1st year ::CSPL-00092::28-05-2019: End
    end;

    procedure Student2ndYearBatchAllotmentCS(YearValue: Code[10]; AcademicYear: Code[10])
    var

        CourseSectionMasterCS: Record "Course Section Master-CS";
        StudentMasterCS2: Record "Student Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        StudentMasterCS1: Record "Student Master-CS";
        RollNo: Integer;
        //StudCount: Integer;
        StudCountDiv: Integer;
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        // Text_10001Lbl: Label 'Student Section Not Alloted , First Allot Student Section !!';

        Text_10002Lbl: Label 'Student Roll No. Not Assigned !!';

        Text_10003Lbl: Label 'Student Section Not Assigned !!';


        Text_10004Lbl: Label 'BATCH PROCESSING #1  Out Of  @2 .';
    begin
        //Code added for Student Batch Allotment for 2nd Year ::CSPL-00092::28-05-2019: Start
        CourseSectionMasterCS.Reset();
        CourseSectionMasterCS.SETCURRENTKEY("Section Code");
        CourseSectionMasterCS.SETRANGE("Academic Year", AcademicYear);
        CourseSectionMasterCS.SETRANGE(Year, YearValue);
        CourseSectionMasterCS.SETRANGE(Semester, 'III');
        TotalCount := CourseSectionMasterCS.count();
        PROGRESS.OPEN(Text_10004Lbl);
        IF CourseSectionMasterCS.FINDSET() THEN
            REPEAT
                StudentMasterCS1.Reset();
                StudentMasterCS1.SETRANGE("Course Code", CourseSectionMasterCS."Course Code");
                StudentMasterCS1.SETRANGE(Year, YearValue);
                StudentMasterCS1.SETRANGE(Section, CourseSectionMasterCS."Section Code");
                StudentMasterCS1.SETRANGE("Academic Year", AcademicYear);
                StudentMasterCS1.SETRANGE("Roll No.", '');
                IF StudentMasterCS1.FINDFIRST() THEN
                    ERROR(Text_10002Lbl);
                StudentMasterCS2.Reset();
                StudentMasterCS2.SETRANGE("Course Code", CourseSectionMasterCS."Course Code");
                StudentMasterCS2.SETRANGE(Year, YearValue);
                StudentMasterCS2.SETRANGE(Section, CourseSectionMasterCS."Section Code");
                StudentMasterCS2.SETRANGE("Academic Year", AcademicYear);
                StudentMasterCS2.SETRANGE(Section, '');
                IF StudentMasterCS2.FINDFIRST() THEN
                    ERROR(Text_10003Lbl);

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("Course Code", CourseSectionMasterCS."Course Code");
                StudentMasterCS.SETRANGE(StudentMasterCS.Year, YearValue);
                StudentMasterCS.SETRANGE(StudentMasterCS.Section, CourseSectionMasterCS."Section Code");
                StudentMasterCS.SETRANGE(StudentMasterCS."Academic Year", AcademicYear);
                IF StudentMasterCS.FINDSET() THEN
                    REPEAT
                        A := StudentMasterCS.count();
                        StudCountDiv := ROUND(StudentMasterCS.COUNT() / 2, 1, '>');
                        EVALUATE(RollNo, StudentMasterCS."Roll No.");
                        IF RollNo <= StudCountDiv THEN
                            StudentMasterCS.VALIDATE(Batch, 'BATCH-1')
                        ELSE
                            StudentMasterCS.VALIDATE(Batch, 'BATCH-2');
                        StudentMasterCS.Modify();
                    UNTIL StudentMasterCS.NEXT() = 0;
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
            UNTIL CourseSectionMasterCS.NEXT() = 0;
        PROGRESS.Close();
        //Code added for Student Batch Allotment for 2nd Year ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateInternalExamGroupCS()
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        EducationSetupCS: Record "Education Setup-CS";
        CourseSectionMasterCS: Record "Course Section Master-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        ExamGroupCodeCS: Record "Exam Group Code-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        "LocLineNo.": Integer;

        NextNo: Code[20];

        Text_10001Lbl: Label 'Internal Maximum Marks  of Course %1 , Semester %2 , Academic Year  %3 , Subject Code  %4  Is Not Defined !!';
    begin
        //Code added for Generate Internal Exam Group ::CSPL-00092::28-05-2019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");

        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETRANGE("Internal Maximum", 0);
        IF CourseWiseSubjectLineCS.FINDFIRST() THEN
            ERROR(Text_10001Lbl, CourseWiseSubjectLineCS."Course Code", CourseWiseSubjectLineCS.Semester,
                   CourseWiseSubjectLineCS."Academic Year", CourseWiseSubjectLineCS."Subject Code");

        UserSetupRec.Get(UserId());
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then begin
            EducationSetupCS.TESTFIELD("Academic Year");
            EducationSetupCS.TESTFIELD("Global Dimension 1 Code");
        end;

        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE("Int. Exam Group Generated", FALSE);
        IF CourseWiseSubjectLineCS.FINDSET() THEN
            REPEAT

                NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

                "LocLineNo." := 0;
                SessionalExamGroupHeadCS.INIT();
                SessionalExamGroupHeadCS."No." := NextNo;
                SessionalExamGroupHeadCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                SessionalExamGroupHeadCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
                SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
                SessionalExamGroupHeadCS.Section := CourseSectionMasterCS."Section Code";
                SessionalExamGroupHeadCS."Academic Year" := EducationSetupCS."Academic Year";
                SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                SessionalExamGroupHeadCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                SessionalExamGroupHeadCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        SessionalExamGroupHeadCS."Exam Group" := 'ODD';
                SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
                SessionalExamGroupHeadCS."Created On" := TODAY();
                SessionalExamGroupHeadCS.INSERT();
                IF SessionalExamGroupHeadCS."Subject Class" = 'THEORY' THEN
                    SessionalExamGroupCS.Reset();
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                SessionalExamGroupCS.SETFILTER("Exam Type", '%1|%2', SessionalExamGroupCS."Exam Type"::"Internal Exam", SessionalExamGroupCS."Exam Type"::Assignment);
                IF SessionalExamGroupCS.FINDSET() THEN
                    REPEAT
                        "LocLineNo." += 10000;
                        SessionalExamGroupLineCS.INIT();
                        SessionalExamGroupLineCS."Document No." := NextNo;
                        SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                        SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
                        SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                        SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                        SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                        SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
                        SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
                        SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                        SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                        SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                        SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
                        SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                        SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCS."Global Dimension 2 Code";
                        SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                        SessionalExamGroupLineCS."Created On" := TODAY();
                        IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                            SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                        SessionalExamGroupLineCS.INSERT();
                    UNTIL SessionalExamGroupCS.NEXT() = 0
                ELSE
                    IF SessionalExamGroupHeadCS."Subject Class" = 'LAB' THEN BEGIN
                        SessionalExamGroupCS.Reset();
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                            SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                        ELSE
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                        SessionalExamGroupCS.SETFILTER("Exam Type", '%1', SessionalExamGroupCS."Exam Type"::"Internal Lab");
                        IF SessionalExamGroupCS.FINDSET() THEN
                            REPEAT
                                "LocLineNo." += 10000;
                                SessionalExamGroupLineCS.INIT();
                                SessionalExamGroupLineCS."Document No." := NextNo;
                                SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                                SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
                                SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                                SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                                SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                                SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
                                SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
                                SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                                SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                                SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
                                SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCS."Global Dimension 2 Code";
                                SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                                SessionalExamGroupLineCS."Created On" := TODAY();
                                IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                                    SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                                SessionalExamGroupLineCS.INSERT();
                            UNTIL SessionalExamGroupCS.NEXT() = 0;
                    END ELSE
                        IF SessionalExamGroupHeadCS."Subject Class" = 'PROJECT' THEN BEGIN
                            SessionalExamGroupCS.Reset();
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                            SessionalExamGroupCS.SETFILTER("Exam Type", '%1', SessionalExamGroupCS."Exam Type"::Project);
                            IF SessionalExamGroupCS.FINDSET() THEN
                                REPEAT
                                    "LocLineNo." += 10000;
                                    SessionalExamGroupLineCS.INIT();
                                    SessionalExamGroupLineCS."Document No." := NextNo;
                                    SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                                    SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
                                    SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                                    SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                                    SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                                    SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
                                    SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
                                    SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                                    SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                                    SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                    SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
                                    SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                    SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCS."Global Dimension 2 Code";
                                    SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                                    SessionalExamGroupLineCS."Created On" := TODAY();
                                    IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                                        SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                                    SessionalExamGroupLineCS.INSERT();
                                UNTIL SessionalExamGroupCS.NEXT() = 0;
                        END ELSE
                            IF SessionalExamGroupHeadCS."Subject Class" = 'INDUSTRAINING' THEN BEGIN
                                SessionalExamGroupCS.Reset();
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                        SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                SessionalExamGroupCS.SETFILTER("Exam Type", '%1', SessionalExamGroupCS."Exam Type"::"Industrial Training");
                                IF SessionalExamGroupCS.FINDSET() THEN
                                    REPEAT
                                        "LocLineNo." += 10000;
                                        SessionalExamGroupLineCS.INIT();
                                        SessionalExamGroupLineCS."Document No." := NextNo;
                                        SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                                        SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
                                        SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                                        SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                                        SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                                        SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
                                        SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
                                        SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                                        SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                                        SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                        SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
                                        SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                        SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCS."Global Dimension 2 Code";
                                        SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                                        SessionalExamGroupLineCS."Created On" := TODAY();
                                        IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                                            SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                                        SessionalExamGroupLineCS.INSERT();
                                    UNTIL SessionalExamGroupCS.NEXT() = 0;
                            END;
                CourseWiseSubjectLineCS.Modify();
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0
        ELSE
            ERROR('Internal Exam Group Already Generated !!');
        //Code added for Generate Internal Exam Group ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateInternalAssignmentDetailsCS(InstituteCode: Code[10])
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        EducationSetupCS: Record "Education Setup-CS";
        CourseSectionMasterCS: Record "Course Section Master-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        BatchCS: Record "Batch-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        FacultyCourseWiseCS1: Record "Faculty Course Wise-CS";
        FacultyCourseWiseCS2: Record "Faculty Course Wise-CS";
        GroupMasterCS: Record "Group Master-CS";
        SectionMasterCS: Record "Section Master-CS";
        SessionalExamGroupHeadCS1: Record "Sessional Exam Group Head-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        ActionMarkCS: Codeunit "Action Mark -CS";
        NextNo: Code[20];
        "Text_1001Lbl": Label 'Document No. %1  In Internal Exam Group Is Not Released. Release All Documents First !!';
        Text_1002Lbl: Label 'Internal Exam Group Is Not Created.';

    begin
        //Code added for Generate Internal Assignment Details ::CSPL-00092::28-05-2019: Start

        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");


        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year")
        ELSE
            ERROR('Education Setup Not Defined !!');

        SessionalExamGroupHeadCS1.Reset();
        IF NOT SessionalExamGroupHeadCS1.FINDFIRST() THEN
            ERROR(Text_1002Lbl);

        SessionalExamGroupHeadCS.Reset();
        SessionalExamGroupHeadCS.SETFILTER(Status, '<>%1', SessionalExamGroupHeadCS.Status::Released);
        IF NOT SessionalExamGroupHeadCS.FINDFIRST() THEN BEGIN

            FacultyCourseWiseCS2.Reset();
            IF FacultyCourseWiseCS2.ISEMPTY() then
                ERROR('Course Wise Faculty Is Not Generated !!');

            FacultyCourseWiseCS1.Reset();
            FacultyCourseWiseCS1.SETFILTER("Faculty Code", '%1', '');
            FacultyCourseWiseCS1.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            FacultyCourseWiseCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            IF FacultyCourseWiseCS1.FINDFIRST() THEN
                ERROR('Course Wise Faculty Is Not Updated.Faculty Code Is Blank !!');

            GroupMasterCS.Reset();
            GroupMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            IF GroupMasterCS.FINDSET() THEN
                REPEAT
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
                    CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
                    ELSE
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
                    CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
                    CourseWiseSubjectLineCS.SETRANGE("Student Group", GroupMasterCS.Code);
                    CourseWiseSubjectLineCS.SETRANGE("Assignment Generated", FALSE);
                    IF CourseWiseSubjectLineCS.FINDSET() THEN
                        REPEAT
                            SectionMasterCS.Reset();
                            SectionMasterCS.SETCURRENTKEY(Code);
                            SectionMasterCS.SETFILTER(Group, '<>%1', '');
                            SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                            SectionMasterCS.SETRANGE(Group, GroupMasterCS.Code);
                            IF SectionMasterCS.FINDSET() THEN
                                REPEAT
                                    IF CourseWiseSubjectLineCS."Subject Classification" = 'THEORY' THEN BEGIN
                                        SessionalExamGroupCS.Reset();
                                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                            SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                        ELSE
                                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                        SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::Assignment);
                                        IF SessionalExamGroupCS.FINDSET() THEN
                                            REPEAT
                                                FacultyCourseWiseCS.Reset();
                                                FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                                                IF CourseWiseSubjectLineCS.Year <> '' THEN
                                                    FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                                                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                                FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                                FacultyCourseWiseCS.SETRANGE("Section Code", SectionMasterCS.Code);
                                                FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                FacultyCourseWiseCS.SETFILTER("Faculty Code", '<>%1', '');
                                                IF FacultyCourseWiseCS.FINDFIRST() THEN BEGIN

                                                    NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

                                                    ClassAssignmentHeaderCS.INIT();
                                                    ClassAssignmentHeaderCS."Assignment No." := NextNo;
                                                    ClassAssignmentHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                                    ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
                                                    ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
                                                    ClassAssignmentHeaderCS.Section := SectionMasterCS.Code;
                                                    ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
                                                    ClassAssignmentHeaderCS."Student Group" := CourseWiseSubjectLineCS."Student Group";
                                                    ClassAssignmentHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                                                    ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                                                    ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                                    ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                    ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
                                                    ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
                                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                        ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
                                                    ELSE
                                                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                            ClassAssignmentHeaderCS."Exam Group" := 'ODD';
                                                    ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
                                                    ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                                                    ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
                                                    ClassAssignmentHeaderCS."Created On" := TODAY();
                                                    ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                                    ClassAssignmentHeaderCS.INSERT();

                                                    IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
                                                        ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
                                                        CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
                                                        CourseWiseSubjectLineCS.Modify();
                                                    END ELSE
                                                        ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                                                END;
                                            UNTIL SessionalExamGroupCS.NEXT() = 0
                                        ELSE
                                            ERROR('Exam Group details Not Defined');

                                    END ELSE
                                        IF CourseWiseSubjectLineCS."Subject Classification" = 'LAB' THEN BEGIN
                                            SessionalExamGroupCS.Reset();
                                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                            ELSE
                                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                    SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                            SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Lab");
                                            IF SessionalExamGroupCS.FINDSET() THEN
                                                REPEAT
                                                    BatchCS.Reset();
                                                    BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                                                    IF BatchCS.FINDSET() THEN
                                                        REPEAT
                                                            FacultyCourseWiseCS.Reset();
                                                            FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                                                            IF CourseWiseSubjectLineCS.Year <> '' THEN
                                                                FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                                                            FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                                            FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                                            FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                                                            FacultyCourseWiseCS.SETRANGE("Section Code", SectionMasterCS.Code);
                                                            FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                            FacultyCourseWiseCS.SETFILTER("Faculty Code", '<>%1', '');
                                                            IF FacultyCourseWiseCS.FINDFIRST() THEN BEGIN

                                                                NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

                                                                ClassAssignmentHeaderCS.INIT();
                                                                ClassAssignmentHeaderCS."Assignment No." := NextNo;
                                                                ClassAssignmentHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                                                ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
                                                                ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
                                                                ClassAssignmentHeaderCS.Section := SectionMasterCS.Code;
                                                                ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
                                                                ClassAssignmentHeaderCS."Student Batch" := BatchCS.Code;
                                                                ClassAssignmentHeaderCS."Student Group" := CourseWiseSubjectLineCS."Student Group";
                                                                ClassAssignmentHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                                                                ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                                                                ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                                                ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                                ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
                                                                ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
                                                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                                    ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
                                                                ELSE
                                                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                                        ClassAssignmentHeaderCS."Exam Group" := 'ODD';
                                                                ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
                                                                ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                                                                ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
                                                                ClassAssignmentHeaderCS."Created On" := TODAY();
                                                                ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                                                ClassAssignmentHeaderCS.INSERT();

                                                                IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
                                                                    ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
                                                                    CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
                                                                    CourseWiseSubjectLineCS.Modify();
                                                                END ELSE
                                                                    ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                                                            END;
                                                        UNTIL BatchCS.NEXT() = 0
                                                    ELSE
                                                        ERROR('Batch Master Details Not Defined');
                                                UNTIL SessionalExamGroupCS.NEXT() = 0
                                            ELSE
                                                ERROR('Exam Group details Not Defined');
                                        END;
                                UNTIL SectionMasterCS.NEXT() = 0
                            ELSE
                                ERROR('Course Section details Not Defined');
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                UNTIL GroupMasterCS.NEXT() = 0
            ELSE
                ERROR('Group details Not Defined');


            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
            CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
            CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
            ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
            CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
            CourseWiseSubjectLineCS.SETRANGE("Assignment Generated", FALSE);
            IF CourseWiseSubjectLineCS.FINDSET() THEN
                REPEAT
                    CourseSectionMasterCS.Reset();
                    CourseSectionMasterCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                    CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                        CourseSectionMasterCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester)
                    ELSE
                        CourseSectionMasterCS.SETRANGE(Year, CourseWiseSubjectLineCS.Year);
                    CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    IF CourseSectionMasterCS.FINDSET() THEN
                        REPEAT
                            IF CourseWiseSubjectLineCS."Subject Classification" = 'THEORY' THEN BEGIN
                                SessionalExamGroupCS.Reset();
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                        SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::Assignment);
                                IF SessionalExamGroupCS.FINDSET() THEN
                                    REPEAT
                                        FacultyCourseWiseCS.Reset();
                                        FacultyCourseWiseCS.SETRANGE("Course Code", CourseSectionMasterCS."Course Code");
                                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseSectionMasterCS.Semester);
                                        IF CourseWiseSubjectLineCS.Year <> '' THEN
                                            FacultyCourseWiseCS.SETRANGE("Year Code", CourseSectionMasterCS.Year);
                                        FacultyCourseWiseCS.SETRANGE("Academic Year", CourseSectionMasterCS."Academic Year");
                                        FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                        FacultyCourseWiseCS.SETRANGE("Section Code", CourseSectionMasterCS."Section Code");
                                        FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                        FacultyCourseWiseCS.SETFILTER("Faculty Code", '<>%1', '');
                                        IF FacultyCourseWiseCS.FINDFIRST() THEN BEGIN

                                            NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

                                            ClassAssignmentHeaderCS.INIT();
                                            ClassAssignmentHeaderCS."Assignment No." := NextNo;
                                            ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                            ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
                                            ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
                                            ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
                                            ClassAssignmentHeaderCS.Section := CourseSectionMasterCS."Section Code";
                                            ClassAssignmentHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                                            ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                                            ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                            ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                            ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
                                            ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
                                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
                                            ELSE
                                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                    ClassAssignmentHeaderCS."Exam Group" := 'ODD';
                                            ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
                                            ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
                                            ClassAssignmentHeaderCS."Created On" := TODAY();
                                            ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                            ClassAssignmentHeaderCS.INSERT();

                                            IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
                                                ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
                                                CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
                                                CourseWiseSubjectLineCS.Modify();
                                            END ELSE
                                                ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                                        END;
                                    UNTIL SessionalExamGroupCS.NEXT() = 0
                                ELSE
                                    ERROR('Exam Group details Not Defined');

                            END ELSE
                                IF CourseWiseSubjectLineCS."Subject Classification" = 'LAB' THEN BEGIN
                                    SessionalExamGroupCS.Reset();
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                        SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                    ELSE
                                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                            SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                    SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Lab");
                                    IF SessionalExamGroupCS.FINDSET() THEN
                                        REPEAT
                                            BatchCS.Reset();
                                            BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                                            IF BatchCS.FINDSET() THEN
                                                REPEAT
                                                    FacultyCourseWiseCS.Reset();
                                                    FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                                    FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                                                    IF CourseWiseSubjectLineCS.Year <> '' THEN
                                                        FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                                                    FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                                    FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                                    FacultyCourseWiseCS.SETRANGE("Section Code", SectionMasterCS.Code);
                                                    FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                    FacultyCourseWiseCS.SETFILTER("Faculty Code", '<>%1', '');
                                                    IF FacultyCourseWiseCS.FINDFIRST() THEN BEGIN

                                                        NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

                                                        ClassAssignmentHeaderCS.INIT();
                                                        ClassAssignmentHeaderCS."Assignment No." := NextNo;
                                                        ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                                        ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
                                                        ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
                                                        ClassAssignmentHeaderCS.Section := CourseSectionMasterCS."Section Code";
                                                        ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
                                                        ClassAssignmentHeaderCS."Student Batch" := BatchCS.Code;
                                                        ClassAssignmentHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                                                        ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                                                        ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                                        ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                        ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
                                                        ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
                                                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                            ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
                                                        ELSE
                                                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                                ClassAssignmentHeaderCS."Exam Group" := 'ODD';
                                                        ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
                                                        ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
                                                        ClassAssignmentHeaderCS."Created On" := TODAY();
                                                        ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                                        ClassAssignmentHeaderCS.INSERT();

                                                        IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
                                                            ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
                                                            CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
                                                            CourseWiseSubjectLineCS.Modify();
                                                        END ELSE
                                                            ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                                                    END;
                                                UNTIL BatchCS.NEXT() = 0
                                            ELSE
                                                ERROR('Batch Master Details Not Defined');
                                        UNTIL SessionalExamGroupCS.NEXT() = 0
                                    ELSE
                                        ERROR('Exam Group details Not Defined');
                                END;
                        UNTIL CourseSectionMasterCS.NEXT() = 0
                    ELSE
                        ERROR('Course Section details Not Defined');
                UNTIL CourseWiseSubjectLineCS.NEXT() = 0;

            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
            CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
            CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
            ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
            CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
            CourseWiseSubjectLineCS.SETRANGE("Assignment Generated", FALSE);
            IF CourseWiseSubjectLineCS.FINDSET() THEN
                REPEAT
                    CourseSectionMasterCS.Reset();
                    CourseSectionMasterCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                    CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                        CourseSectionMasterCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester)
                    ELSE
                        CourseSectionMasterCS.SETRANGE(Year, CourseWiseSubjectLineCS.Year);
                    CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    IF CourseSectionMasterCS.FINDSET() THEN
                        REPEAT
                            IF CourseWiseSubjectLineCS."Subject Classification" = 'THEORY' THEN BEGIN
                                SessionalExamGroupCS.Reset();
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                        SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::Assignment);
                                IF SessionalExamGroupCS.FINDSET() THEN
                                    REPEAT
                                        FacultyCourseWiseCS.Reset();
                                        FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                                        IF CourseWiseSubjectLineCS.Year <> '' THEN
                                            FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                                        FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                        FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                        FacultyCourseWiseCS.SETRANGE("Section Code", CourseSectionMasterCS."Section Code");
                                        FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                        FacultyCourseWiseCS.SETFILTER("Faculty Code", '<>%1', '');
                                        IF FacultyCourseWiseCS.FINDFIRST() THEN BEGIN

                                            NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

                                            ClassAssignmentHeaderCS.INIT();
                                            ClassAssignmentHeaderCS."Assignment No." := NextNo;
                                            ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                            ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
                                            ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
                                            ClassAssignmentHeaderCS.Section := CourseSectionMasterCS."Section Code";
                                            ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
                                            ClassAssignmentHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                                            ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                                            ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                            ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                            ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
                                            ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
                                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
                                            ELSE
                                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                    ClassAssignmentHeaderCS."Exam Group" := 'ODD';
                                            ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
                                            ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
                                            ClassAssignmentHeaderCS."Created On" := TODAY();
                                            ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                            ClassAssignmentHeaderCS.INSERT();

                                            IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
                                                ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
                                                CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
                                                CourseWiseSubjectLineCS.Modify();
                                            END ELSE
                                                ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                                        END;
                                    UNTIL SessionalExamGroupCS.NEXT() = 0
                                ELSE
                                    ERROR('Exam Group details Not Defined');
                            END ELSE
                                IF CourseWiseSubjectLineCS."Subject Classification" = 'LAB' THEN BEGIN
                                    SessionalExamGroupCS.Reset();
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                        SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                                    ELSE
                                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                            SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                                    SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Lab");
                                    IF SessionalExamGroupCS.FINDSET() THEN
                                        REPEAT
                                            BatchCS.Reset();
                                            BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                                            IF BatchCS.FINDSET() THEN
                                                REPEAT
                                                    FacultyCourseWiseCS.Reset();
                                                    FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                                    FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                                                    IF CourseWiseSubjectLineCS.Year <> '' THEN
                                                        FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                                                    FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                                    FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                                                    FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                                    FacultyCourseWiseCS.SETRANGE("Section Code", SectionMasterCS.Code);
                                                    FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                    FacultyCourseWiseCS.SETFILTER("Faculty Code", '<>%1', '');
                                                    IF FacultyCourseWiseCS.FINDFIRST() THEN BEGIN

                                                        NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

                                                        ClassAssignmentHeaderCS.INIT();
                                                        ClassAssignmentHeaderCS."Assignment No." := NextNo;
                                                        ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                                        ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
                                                        ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
                                                        ClassAssignmentHeaderCS.Section := CourseSectionMasterCS."Section Code";
                                                        ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
                                                        ClassAssignmentHeaderCS."Student Batch" := BatchCS.Code;
                                                        ClassAssignmentHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                                                        ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                                                        ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                                        ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                                        ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
                                                        ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
                                                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                                            ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
                                                        ELSE
                                                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                                                ClassAssignmentHeaderCS."Exam Group" := 'ODD';
                                                        ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
                                                        ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
                                                        ClassAssignmentHeaderCS."Created On" := TODAY();
                                                        ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
                                                        ClassAssignmentHeaderCS.INSERT();

                                                        IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
                                                            ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
                                                            CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
                                                            CourseWiseSubjectLineCS.Modify();
                                                        END ELSE
                                                            ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
                                                    END;
                                                UNTIL BatchCS.NEXT() = 0
                                            ELSE
                                                ERROR('Batch Master Details Not Defined');
                                        UNTIL SessionalExamGroupCS.NEXT() = 0
                                    ELSE
                                        ERROR('Exam Group details Not Defined');
                                END;
                        UNTIL CourseSectionMasterCS.NEXT() = 0
                    ELSE
                        ERROR('Course Section details Not Defined');
                UNTIL CourseWiseSubjectLineCS.NEXT() = 0;

        END ELSE
            ERROR(Text_1001Lbl, SessionalExamGroupHeadCS."No.");

        //Code added for Generate Internal Assignment Details ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateInternalExamGroupSubjClassWiseCS(InstituteCode: Code[10])
    var
        CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        EducationSetupCS: Record "Education Setup-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        ExamGroupCodeCS: Record "Exam Group Code-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SubjectClassificationCS: Record "Subject Classification-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

        "LocLineNo.": Integer;
        NextNo: Code[20];

    begin
        //Code added for Generate Internal ClassWise Exam Group Subject ::CSPL-00092::28-05-2019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");

        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year")
        ELSE
            ERROR('Education Setup Not Defined !!');


        CourseWiseSubjectHeadCS.Reset();
        CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, Semester, Year);
        CourseWiseSubjectHeadCS.SETRANGE(Course, EducationSetupCS."Course Code");
        CourseWiseSubjectHeadCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectHeadCS.SETRANGE("Program", 'UG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1', 'II')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1', 'I');
        CourseWiseSubjectHeadCS.SETRANGE("Int. Exam Group Generated", FALSE);
        IF CourseWiseSubjectHeadCS.FINDSET() THEN
            REPEAT
                SubjectClassificationCS.Reset();
                SubjectClassificationCS.SETRANGE("Int. Exam Not Applicable", FALSE);
                SubjectClassificationCS.SETCURRENTKEY(Code);
                IF SubjectClassificationCS.FINDSET() THEN
                    REPEAT
                        CourseWiseSubjectLineCS.Reset();
                        CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseWiseSubjectHeadCS.Course);
                        CourseWiseSubjectLineCS.SETRANGE(Semester, CourseWiseSubjectHeadCS.Semester);
                        CourseWiseSubjectLineCS.SETRANGE("Academic Year", CourseWiseSubjectHeadCS."Academic Year");
                        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectHeadCS."Global Dimension 1 Code");
                        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubjectClassificationCS.Code);
                        IF CourseWiseSubjectLineCS.FINDFIRST() THEN BEGIN

                            NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

                            "LocLineNo." := 0;
                            SessionalExamGroupHeadCS.INIT();
                            SessionalExamGroupHeadCS."No." := NextNo;
                            SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
                            SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
                            SessionalExamGroupHeadCS."Academic Year" := EducationSetupCS."Academic Year";
                            SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            SessionalExamGroupHeadCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            SessionalExamGroupHeadCS."Type Of Course" := CourseWiseSubjectHeadCS."Type Of Course";
                            SessionalExamGroupHeadCS."Program" := CourseWiseSubjectHeadCS."Program";
                            SessionalExamGroupHeadCS."Global Dimension 1 Code" := CourseWiseSubjectHeadCS."Global Dimension 1 Code";
                            SessionalExamGroupHeadCS."Global Dimension 2 Code" := CourseWiseSubjectHeadCS."Global Dimension 2 Code";
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupHeadCS."Exam Group" := 'ODD';
                            SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
                            SessionalExamGroupHeadCS."Created On" := TODAY();
                            SessionalExamGroupHeadCS.INSERT();
                            SessionalExamGroupCS.Reset();
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                            SessionalExamGroupCS.SETRANGE("Document Type", SessionalExamGroupCS."Document Type"::Internal);
                            SessionalExamGroupCS.SETRANGE("Subject Class", SessionalExamGroupHeadCS."Subject Class");
                            IF SessionalExamGroupCS.FINDSET() THEN
                                REPEAT
                                    "LocLineNo." += 10000;
                                    SessionalExamGroupLineCS.INIT();
                                    SessionalExamGroupLineCS."Document No." := NextNo;
                                    SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                                    SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                                    SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                                    SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                                    SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                                    SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                                    SessionalExamGroupLineCS."Maximum Marks" := SessionalExamGroupCS."Maximum Marks";
                                    SessionalExamGroupLineCS.Weightage := SessionalExamGroupCS."Maximum Weightage";
                                    SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                    SessionalExamGroupLineCS.Year := CourseWiseSubjectHeadCS.Year;
                                    SessionalExamGroupLineCS."Program" := SessionalExamGroupHeadCS."Program";
                                    SessionalExamGroupLineCS."Global Dimension 1 Code" := SessionalExamGroupHeadCS."Global Dimension 1 Code";
                                    SessionalExamGroupLineCS."Global Dimension 2 Code" := SessionalExamGroupHeadCS."Global Dimension 2 Code";
                                    SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                                    SessionalExamGroupLineCS."Created On" := TODAY();
                                    IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                                        SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                                    SessionalExamGroupLineCS.INSERT();
                                UNTIL SessionalExamGroupCS.NEXT() = 0;
                        END;
                    UNTIL SubjectClassificationCS.NEXT() = 0;
                CourseWiseSubjectHeadCS."Int. Exam Group Generated" := TRUE;
                CourseWiseSubjectHeadCS.Modify();
            UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;


        CourseWiseSubjectHeadCS.Reset();
        CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, Semester, Year);
        CourseWiseSubjectHeadCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectHeadCS.SETRANGE("Program", 'UG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
        CourseWiseSubjectHeadCS.SETRANGE("Int. Exam Group Generated", FALSE);
        IF CourseWiseSubjectHeadCS.FINDSET() THEN
            REPEAT
                SubjectClassificationCS.Reset();
                SubjectClassificationCS.SETRANGE("Int. Exam Not Applicable", FALSE);
                SubjectClassificationCS.SETCURRENTKEY(Code);
                IF SubjectClassificationCS.FINDSET() THEN
                    REPEAT
                        CourseWiseSubjectLineCS.Reset();
                        CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseWiseSubjectHeadCS.Course);
                        CourseWiseSubjectLineCS.SETRANGE(Semester, CourseWiseSubjectHeadCS.Semester);
                        CourseWiseSubjectLineCS.SETRANGE("Academic Year", CourseWiseSubjectHeadCS."Academic Year");
                        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectHeadCS."Global Dimension 1 Code");
                        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubjectClassificationCS.Code);
                        IF CourseWiseSubjectLineCS.FINDFIRST() THEN BEGIN

                            NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

                            "LocLineNo." := 0;
                            SessionalExamGroupHeadCS.INIT();
                            SessionalExamGroupHeadCS."No." := NextNo;
                            SessionalExamGroupHeadCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                            SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
                            SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
                            SessionalExamGroupHeadCS."Academic Year" := EducationSetupCS."Academic Year";
                            SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            SessionalExamGroupHeadCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupHeadCS."Exam Group" := 'ODD';
                            SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
                            SessionalExamGroupHeadCS."Created On" := TODAY();
                            SessionalExamGroupHeadCS.INSERT();
                            SessionalExamGroupCS.Reset();
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                            SessionalExamGroupCS.SETRANGE("Document Type", SessionalExamGroupCS."Document Type"::Internal);
                            SessionalExamGroupCS.SETRANGE("Subject Class", SessionalExamGroupHeadCS."Subject Class");
                            IF SessionalExamGroupCS.FINDSET() THEN
                                REPEAT
                                    "LocLineNo." += 10000;
                                    SessionalExamGroupLineCS.INIT();
                                    SessionalExamGroupLineCS."Document No." := NextNo;
                                    SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                                    SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
                                    SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                                    SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                                    SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                                    SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
                                    SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
                                    SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                                    SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                                    SessionalExamGroupLineCS."Maximum Marks" := SessionalExamGroupCS."Maximum Marks";
                                    SessionalExamGroupLineCS.Weightage := SessionalExamGroupCS."Maximum Weightage";
                                    SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                    SessionalExamGroupLineCS.Year := CourseWiseSubjectHeadCS.Year;
                                    SessionalExamGroupLineCS."Program" := SessionalExamGroupHeadCS."Program";
                                    SessionalExamGroupLineCS."Global Dimension 1 Code" := SessionalExamGroupHeadCS."Global Dimension 1 Code";
                                    SessionalExamGroupLineCS."Global Dimension 2 Code" := SessionalExamGroupHeadCS."Global Dimension 2 Code";
                                    SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                                    SessionalExamGroupLineCS."Created On" := TODAY();
                                    IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                                        SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                                    SessionalExamGroupLineCS.INSERT();
                                UNTIL SessionalExamGroupCS.NEXT() = 0;
                        END;
                    UNTIL SubjectClassificationCS.NEXT() = 0;
                CourseWiseSubjectHeadCS."Int. Exam Group Generated" := TRUE;
                CourseWiseSubjectHeadCS.Modify();
            UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;

        CourseWiseSubjectHeadCS.Reset();
        CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, Semester, Year);
        CourseWiseSubjectHeadCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectHeadCS.SETRANGE("Program", 'PG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectHeadCS.SETRANGE("Int. Exam Group Generated", FALSE);
        IF CourseWiseSubjectHeadCS.FINDSET() THEN
            REPEAT
                SubjectClassificationCS.Reset();
                SubjectClassificationCS.SETRANGE("Int. Exam Not Applicable", FALSE);
                SubjectClassificationCS.SETCURRENTKEY(Code);
                IF SubjectClassificationCS.FINDSET() THEN
                    REPEAT
                        CourseWiseSubjectLineCS.Reset();
                        CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseWiseSubjectHeadCS.Course);
                        CourseWiseSubjectLineCS.SETRANGE(Semester, CourseWiseSubjectHeadCS.Semester);
                        CourseWiseSubjectLineCS.SETRANGE("Academic Year", CourseWiseSubjectHeadCS."Academic Year");
                        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectHeadCS."Global Dimension 1 Code");
                        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubjectClassificationCS.Code);
                        IF CourseWiseSubjectLineCS.FINDFIRST() THEN BEGIN
                            NextNo := NoSeriesManagement.GetNextNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);
                            "LocLineNo." := 0;
                            SessionalExamGroupHeadCS.INIT();
                            SessionalExamGroupHeadCS."No." := NextNo;
                            SessionalExamGroupHeadCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
                            SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
                            SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
                            SessionalExamGroupHeadCS."Academic Year" := EducationSetupCS."Academic Year";
                            SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            SessionalExamGroupHeadCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupHeadCS."Exam Group" := 'ODD';
                            SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
                            SessionalExamGroupHeadCS."Created On" := TODAY();
                            SessionalExamGroupHeadCS.INSERT();
                            SessionalExamGroupCS.Reset();
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                                SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
                            ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                                    SessionalExamGroupCS.SETRANGE(Group, 'ODD');
                            SessionalExamGroupCS.SETRANGE("Document Type", SessionalExamGroupCS."Document Type"::Internal);
                            SessionalExamGroupCS.SETRANGE("Subject Class", SessionalExamGroupHeadCS."Subject Class");
                            IF SessionalExamGroupCS.FINDSET() THEN
                                REPEAT
                                    "LocLineNo." += 10000;
                                    SessionalExamGroupLineCS.INIT();
                                    SessionalExamGroupLineCS."Document No." := NextNo;
                                    SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                                    SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
                                    SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
                                    SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
                                    SessionalExamGroupLineCS."Academic year" := EducationSetupCS."Academic Year";
                                    SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
                                    SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
                                    SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
                                    SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                                    SessionalExamGroupLineCS."Maximum Marks" := SessionalExamGroupCS."Maximum Marks";
                                    SessionalExamGroupLineCS.Weightage := SessionalExamGroupCS."Maximum Weightage";
                                    SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                    SessionalExamGroupLineCS.Year := CourseWiseSubjectHeadCS.Year;
                                    SessionalExamGroupLineCS."Program" := SessionalExamGroupHeadCS."Program";
                                    SessionalExamGroupLineCS."Global Dimension 1 Code" := SessionalExamGroupHeadCS."Global Dimension 1 Code";
                                    SessionalExamGroupLineCS."Global Dimension 2 Code" := SessionalExamGroupHeadCS."Global Dimension 2 Code";
                                    SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
                                    SessionalExamGroupLineCS."Created On" := TODAY();
                                    IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                                        SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
                                    SessionalExamGroupLineCS.INSERT();
                                UNTIL SessionalExamGroupCS.NEXT() = 0;
                        END;
                    UNTIL SubjectClassificationCS.NEXT() = 0;
                CourseWiseSubjectHeadCS."Int. Exam Group Generated" := TRUE;
                CourseWiseSubjectHeadCS.Modify();
            UNTIL CourseWiseSubjectHeadCS.NEXT() = 0
        ELSE
            ERROR('Internal Exam Group Already Generated !!');
        //Code added for Generate Internal ClassWise Exam Group Subject ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateTimeTableCS(InstituteCode: Code[10])
    var
        EducationSetupCS: Record "Education Setup-CS";
        CourseSectionMasterCS: Record "Course Section Master-CS";
        CourseSectionMasterCS1: Record "Course Section Master-CS";
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
        SectionMasterCS: Record "Section Master-CS";
        AdmissionSetupCS: Record "Admission Setup-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        NextNo: Code[20];
        Text_10001Lbl: Label 'Time Table Already Created !! ';

    begin
        //Code added for Generate Time Table ::CSPL-00092::28-05-2019: Start
        AdmissionSetupCS.GET();
        AdmissionSetupCS.TESTFIELD("Time Table No.");

        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year")
        ELSE
            ERROR('Education Setup Not Defined !!');


        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN

            EducationMultiEventCalCS.Reset();
            EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
            EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                SectionMasterCS.Reset();
                SectionMasterCS.SETCURRENTKEY(Code);
                SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                SectionMasterCS.SETFILTER(Group, '<>%1', '');
                SectionMasterCS.SETRANGE("Time Table Generated", FALSE);
                IF SectionMasterCS.FINDSET() THEN
                    REPEAT
                        NextNo := NoSeriesManagement.GetNextNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

                        ClassTimeTableHeaderCS.INIT();
                        ClassTimeTableHeaderCS."No." := NextNo;
                        ClassTimeTableHeaderCS."Program" := 'UG';
                        ClassTimeTableHeaderCS.VALIDATE(Year, '1ST');
                        ClassTimeTableHeaderCS.VALIDATE(Semester, 'I');
                        ClassTimeTableHeaderCS.Section := SectionMasterCS.Code;
                        ClassTimeTableHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                        ClassTimeTableHeaderCS.Group := SectionMasterCS.Group;
                        ClassTimeTableHeaderCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                        ClassTimeTableHeaderCS.VALIDATE("Template Code", SectionMasterCS."Template No.");
                        ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
                        ClassTimeTableHeaderCS.INSERT();
                        SectionMasterCS.Modify();
                    UNTIL SectionMasterCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);

                CourseSectionMasterCS.Reset();
                CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
                CourseSectionMasterCS.SETRANGE("Program", 'UG');
                CourseSectionMasterCS.SETRANGE("Time Table Generated", FALSE);
                IF CourseSectionMasterCS.FINDSET() THEN
                    REPEAT
                        NextNo := NoSeriesManagement.GetNextNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

                        ClassTimeTableHeaderCS.INIT();
                        ClassTimeTableHeaderCS."No." := NextNo;
                        ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS."Program";
                        ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS.Year);
                        ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS.Semester);
                        ClassTimeTableHeaderCS.Section := CourseSectionMasterCS."Section Code";
                        ClassTimeTableHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                        ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS."Course Code");
                        ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS."Template No.");
                        ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
                        CourseSectionMasterCS.Modify();
                    UNTIL CourseSectionMasterCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);

                CourseSectionMasterCS1.Reset();
                CourseSectionMasterCS1.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCS1.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                CourseSectionMasterCS1.SETRANGE("Program", 'PG');
                CourseSectionMasterCS1.SETRANGE("Time Table Generated", FALSE);
                IF CourseSectionMasterCS1.FINDSET() THEN
                    REPEAT
                        NextNo := NoSeriesManagement.GetNextNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

                        ClassTimeTableHeaderCS.INIT();
                        ClassTimeTableHeaderCS."No." := NextNo;
                        ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS1."Program";
                        ClassTimeTableHeaderCS."Type Of Course" := CourseSectionMasterCS1."Type Of Course";
                        ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS1.Year);
                        ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS1.Semester);
                        ClassTimeTableHeaderCS.Section := CourseSectionMasterCS1."Section Code";
                        ClassTimeTableHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                        ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS1."Course Code");
                        ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS1."Template No.");
                        ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
                        ClassTimeTableHeaderCS.INSERT();
                        CourseSectionMasterCS1.Modify();
                    UNTIL CourseSectionMasterCS1.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);
            END;

        END ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                EducationMultiEventCalCS.Reset();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
                EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    SectionMasterCS.Reset();
                    SectionMasterCS.SETCURRENTKEY(Code);
                    SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    SectionMasterCS.SETFILTER(Group, '<>%1', '');
                    SectionMasterCS.SETRANGE("Time Table Generated", FALSE);
                    IF SectionMasterCS.FINDSET() THEN
                        REPEAT
                            NextNo := NoSeriesManagement.GetNextNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

                            ClassTimeTableHeaderCS.INIT();
                            ClassTimeTableHeaderCS."No." := NextNo;
                            ClassTimeTableHeaderCS."Program" := 'UG';
                            ClassTimeTableHeaderCS.VALIDATE(Year, '1ST');
                            ClassTimeTableHeaderCS.VALIDATE(Semester, 'II');
                            ClassTimeTableHeaderCS.Section := SectionMasterCS.Code;
                            ClassTimeTableHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                            ClassTimeTableHeaderCS.Group := SectionMasterCS.Group;
                            ClassTimeTableHeaderCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                            ClassTimeTableHeaderCS.VALIDATE("Template Code", SectionMasterCS."Template No.");
                            ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
                            ClassTimeTableHeaderCS.INSERT();
                            SectionMasterCS.Modify();
                        UNTIL SectionMasterCS.NEXT() = 0
                    ELSE
                        ERROR(Text_10001Lbl);

                    CourseSectionMasterCS.Reset();
                    CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                    CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII');
                    CourseSectionMasterCS.SETRANGE("Program", 'UG');
                    CourseSectionMasterCS.SETRANGE("Time Table Generated", FALSE);
                    IF CourseSectionMasterCS.FINDSET() THEN
                        REPEAT
                            NextNo := NoSeriesManagement.GetNextNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

                            ClassTimeTableHeaderCS.INIT();
                            ClassTimeTableHeaderCS."No." := NextNo;
                            ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS."Program";
                            ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS.Year);
                            ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS.Semester);
                            ClassTimeTableHeaderCS.Section := CourseSectionMasterCS."Section Code";
                            ClassTimeTableHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                            ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS."Course Code");
                            ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS."Template No.");
                            ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
                            ClassTimeTableHeaderCS.INSERT();
                            CourseSectionMasterCS.Modify();
                        UNTIL CourseSectionMasterCS.NEXT() = 0
                    ELSE
                        ERROR(Text_10001Lbl);

                    CourseSectionMasterCS1.Reset();
                    CourseSectionMasterCS1.SETCURRENTKEY("Course Code", Semester, "Section Code");
                    CourseSectionMasterCS1.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    CourseSectionMasterCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    CourseSectionMasterCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'IV', 'VIII');
                    CourseSectionMasterCS1.SETRANGE("Program", 'PG');
                    CourseSectionMasterCS1.SETRANGE("Time Table Generated", FALSE);
                    IF CourseSectionMasterCS1.FINDSET() THEN
                        REPEAT
                            NextNo := NoSeriesManagement.GetNextNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

                            ClassTimeTableHeaderCS.INIT();
                            ClassTimeTableHeaderCS."No." := NextNo;
                            ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS1."Program";
                            ClassTimeTableHeaderCS."Type Of Course" := CourseSectionMasterCS1."Type Of Course";
                            ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS1.Year);
                            ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS1.Semester);
                            ClassTimeTableHeaderCS.Section := CourseSectionMasterCS1."Section Code";
                            ClassTimeTableHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                            ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS1."Course Code");
                            ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS1."Template No.");
                            ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
                            ClassTimeTableHeaderCS.INSERT();
                            CourseSectionMasterCS1.Modify();
                        UNTIL CourseSectionMasterCS1.NEXT() = 0
                    ELSE
                        ERROR(Text_10001Lbl);
                END;
            END;
        //Code added for Generate Time Table ::CSPL-00092::28-05-2019: End
    end;

    procedure TestCapcityCS(TempStudExternalAttendLine: Record "External Attendance Line-CS")
    var
        RoomsCS: Record "Rooms-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RoomCapity: Integer;

    begin
        //Code added for Test Capcity ::CSPL-00092::28-05-2019: Start
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETCURRENTKEY("Exam Date", "Exam Slot", "Global Dimension 2 Code");
        ExternalAttendanceLineCS.SETRANGE("Exam Date", TempStudExternalAttendLine."Exam Date");
        ExternalAttendanceLineCS.SETRANGE("Exam Slot", TempStudExternalAttendLine."Exam Slot");
        ExternalAttendanceLineCS.SETRANGE("Subject Class", 'THEORY');
        ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
        ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", TempStudExternalAttendLine."Global Dimension 2 Code");
        IF ExternalAttendanceLineCS.FINDSET() THEN BEGIN
            RoomCapity := 0;
            RoomsCS.Reset();
            RoomsCS.SETCURRENTKEY("Examination Department Code", "Room No.");
            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
            RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
            IF RoomsCS.FINDSET() THEN BEGIN
                REPEAT
                    RoomCapity := RoomCapity + RoomsCS."Exam Capacity";
                UNTIL RoomsCS.NEXT() = 0;

                IF ExternalAttendanceLineCS.COUNT() > RoomCapity THEN
                    ERROR('Number of Student %1 More Then Room Capacity %2 for Department %3 on Exam Date %4 And Exam Slot %5.Please Contact To Your System Administrator',
                          ExternalAttendanceLineCS.COUNT(), RoomCapity, TempStudExternalAttendLine."Global Dimension 2 Code", TempStudExternalAttendLine."Exam Date",
                          TempStudExternalAttendLine."Exam Slot")
            END ELSE
                ERROR('Department %1 Is Not Mapped With The Rooms on Exam Date %4 And Exam Slot %5. Please Contact To Your System Administrator ',
                        ExternalAttendanceLineCS."Global Dimension 2 Code", TempStudExternalAttendLine."Exam Date", TempStudExternalAttendLine."Exam Slot");
        END;
        //Code added for Test Capcity ::CSPL-00092::28-05-2019: End
    end;

    procedure TestCapcityDocumentWiseCS(TempStudExternalAttendLine: Record "External Attendance Line-CS")
    var
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RoomsCS: Record "Rooms-CS";
        RoomCapity: Integer;
    begin
        //Code added for Text Capcity Document Wise ::CSPL-00092::28-05-2019: Start
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
        ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", '');
        ExternalAttendanceLineCS.SETRANGE("Exam Date", TempStudExternalAttendLine."Exam Date");
        ExternalAttendanceLineCS.SETRANGE("Exam Slot", TempStudExternalAttendLine."Exam Slot");
        ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", TempStudExternalAttendLine."Exam Schedule No.");
        ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", TempStudExternalAttendLine."Global Dimension 2 Code");
        IF ExternalAttendanceLineCS.FINDSET() THEN BEGIN
            A := ExternalAttendanceLineCS.count();
            RoomCapity := 0;
            RoomsCS.Reset();
            RoomsCS.SETCURRENTKEY("Examination Department Code", "Room No.");
            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
            RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
            RoomsCS.SETRANGE("Allot For Examination", FALSE);
            IF RoomsCS.FINDSET() THEN BEGIN
                REPEAT
                    RoomCapity := RoomCapity + RoomsCS."Exam Capacity";
                UNTIL RoomsCS.NEXT() = 0;
                A := ExternalAttendanceLineCS.count();
                IF ExternalAttendanceLineCS.COUNT() > RoomCapity THEN
                    ERROR('Number of Student %1 More Then Room Capacity %2 for Department %3 At Exam Date - %4 , Exam SLot - %5. Please Contact To Your System Administrator',
                   ExternalAttendanceLineCS.COUNT(), RoomCapity, TempStudExternalAttendLine."Global Dimension 2 Code", TempStudExternalAttendLine."Exam Date",
                   TempStudExternalAttendLine."Exam Slot");
            END ELSE
                ERROR('Department %1 Is Not Mapped With The Rooms At Exam Date - %2,Exam Slot - %3. Please Contact To Your System Administrator ',
                       ExternalAttendanceLineCS."Global Dimension 2 Code", ExternalAttendanceLineCS."Exam Date", ExternalAttendanceLineCS."Exam Slot");
        END;
        //Code added for Text Capcity Document Wise ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateSittingPlanCS(DocumentNo: Code[20])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        TempExamLog: Record "Examination Log Details-CS" temporary;
        RoomsCS: Record "Rooms-CS";
        RoomsCS1: Record "Rooms-CS";
        RoomsCS2: Record "Rooms-CS";
        RoomCap: Integer;
        RoomNo: Code[20];
        CNT: Integer;
        SUBCODE: Code[10];
        Text_10002Lbl: Label ' UPLOADING... #1  Out Of  @2 .';
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
    begin
        //Code added for Generate Sitting Plan ::CSPL-00092::28-05-2019: Start
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETCURRENTKEY("Exam Date", "Exam Slot");
        ExternalAttendanceHeaderCS.SETRANGE("Sitting Plan", FALSE);
        ExternalAttendanceHeaderCS.SETRANGE("Subject Class", 'THEORY');
        ExternalAttendanceHeaderCS.SETRANGE("No.", 'EEA/1718/00714');
        ExternalAttendanceHeaderCS.SETRANGE("Exam Date", TODAY());
        IF ExternalAttendanceHeaderCS.FINDSET() THEN
            REPEAT
                ExaminationLogDetailsCS.Reset();
                ExaminationLogDetailsCS.SETCURRENTKEY("Academic Year", "Exam Date", "Time Slot");
                ExaminationLogDetailsCS.SETRANGE("Academic Year", ExternalAttendanceHeaderCS."Academic Year");
                ExaminationLogDetailsCS.SETRANGE("Exam Date", ExternalAttendanceHeaderCS."Exam Date");
                ExaminationLogDetailsCS.SETRANGE("Time Slot", ExternalAttendanceHeaderCS."Exam Slot");
                IF NOT ExaminationLogDetailsCS.FINDFIRST() THEN BEGIN
                    TempExamLog.INIT();
                    TempExamLog."Entry No" += 1;
                    TempExamLog."Academic Year" := ExternalAttendanceHeaderCS."Academic Year";
                    TempExamLog."Exam Date" := ExternalAttendanceHeaderCS."Exam Date";
                    TempExamLog."Time Slot" := ExternalAttendanceHeaderCS."Exam Slot";
                    TempExamLog.INSERT();
                END;
            UNTIL ExternalAttendanceHeaderCS.NEXT() = 0;

        TempExamLog.Reset();
        TempExamLog.SETCURRENTKEY("Exam Date", "Time Slot");
        IF TempExamLog.FINDSET() THEN BEGIN
            TotalCount := TempExamLog.count();
            PROGRESS.OPEN(Text_10002Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETCURRENTKEY("Exam Date", "Exam Slot", "Subject Code", "Global Dimension 2 Code", Course, Section, "Roll No.");
                ExternalAttendanceLineCS.SETRANGE("Exam Date", TempExamLog."Exam Date");
                ExternalAttendanceLineCS.SETRANGE("Exam Slot", TempExamLog."Time Slot");
                ExternalAttendanceLineCS.SETRANGE("Subject Class", 'THEORY');
                ExternalAttendanceLineCS.SETRANGE("Subject Type", 'CORE');
                ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", '');
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        TestCapcityCS(ExternalAttendanceLineCS);
                        IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                            CNT := 0;
                            RoomNo := '';
                            RoomCap := 0;
                            RoomsCS1.Reset();
                            RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS1.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS1."Exam Capacity";
                                RoomNo := RoomsCS1."Display Room No.";
                            END;
                        END;
                        SUBCODE := ExternalAttendanceLineCS."Subject Code";

                        CNT += 1;
                        IF CNT <= RoomCap THEN BEGIN
                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETCURRENTKEY("Display Room No.");
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END ELSE BEGIN
                            CNT := 1;
                            RoomsCS2.Reset();
                            RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS2.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS2."Exam Capacity";
                                RoomNo := RoomsCS2."Display Room No.";
                            END;

                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETCURRENTKEY("Display Room No.");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END;

                        IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                            ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                            ExternalAttendanceHeaderCS.Modify();
                        END;
                        GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;

                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETCURRENTKEY("Exam Date", "Exam Slot", "Subject Code", "Global Dimension 2 Code", Section, "Roll No.");
                ExternalAttendanceLineCS.SETRANGE("Exam Date", TempExamLog."Exam Date");
                ExternalAttendanceLineCS.SETRANGE("Exam Slot", TempExamLog."Time Slot");
                ExternalAttendanceLineCS.SETRANGE("Subject Class", 'THEORY');
                ExternalAttendanceLineCS.SETRANGE("Subject Type", 'ELECTIVE');
                ExternalAttendanceLineCS.SETRANGE("Room Alloted No.", '');
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        TestCapcityCS(ExternalAttendanceLineCS);
                        IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                            CNT := 0;
                            RoomNo := '';
                            RoomCap := 0;
                            RoomsCS1.Reset();
                            RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS1.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS1."Exam Capacity";
                                RoomNo := RoomsCS1."Display Room No.";
                            END;
                        END;
                        SUBCODE := ExternalAttendanceLineCS."Subject Code";

                        CNT += 1;
                        IF CNT <= RoomCap THEN BEGIN
                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETCURRENTKEY("Display Room No.");
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END ELSE BEGIN
                            CNT := 1;
                            RoomsCS2.Reset();
                            RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS2.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS2."Exam Capacity";
                                RoomNo := RoomsCS2."Display Room No.";
                            END;

                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETCURRENTKEY("Display Room No.");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END;

                        IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                            ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                            ExternalAttendanceHeaderCS.Modify();
                        END;
                        GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;

            UNTIL TempExamLog.NEXT() = 0;
            PROGRESS.Close();
        END;
        //Code added for Generate Sitting Plan ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateSittingPlanDocumentWiseCS(DocumentNo: Code[20])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RoomsCS: Record "Rooms-CS";
        RoomsCS1: Record "Rooms-CS";
        RoomsCS2: Record "Rooms-CS";
        RoomCap: Integer;
        RoomNo: Code[20];
        CNT: Integer;
        SUBCODE: Code[10];
    begin
        //Code added for Generate Sitting Plan Document Wise ::CSPL-00092::28-05-2019: Start
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETRANGE("Sitting Plan", FALSE);
        IF ExternalAttendanceHeaderCS.FINDFIRST() THEN BEGIN
            ExternalAttendanceLineCS.Reset();
            ExternalAttendanceLineCS.SETCURRENTKEY("Global Dimension 2 Code", Course, Section, "Roll No.");
            ExternalAttendanceLineCS.SETRANGE("Document No.", DocumentNo);
            ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
            IF ExternalAttendanceLineCS.FINDSET() THEN
                REPEAT
                    TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                    IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                        CNT := 0;
                        RoomNo := '';
                        RoomCap := 0;
                        RoomsCS1.Reset();
                        RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                        RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                        RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                        RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                        RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                        IF RoomsCS1.FINDFIRST() THEN BEGIN
                            RoomCap := RoomsCS1."Exam Capacity";
                            RoomNo := RoomsCS1."Display Room No.";
                        END;
                    END;
                    SUBCODE := ExternalAttendanceLineCS."Subject Code";

                    CNT += 1;
                    IF CNT <= RoomCap THEN BEGIN
                        ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                        ExternalAttendanceLineCS.Modify();
                        RoomsCS.Reset();
                        RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                        RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                        RoomsCS.SETRANGE("Display Room No.", RoomNo);
                        IF RoomsCS.FINDFIRST() THEN BEGIN
                            RoomsCS."Allot For Examination" := TRUE;
                            RoomsCS.Modify();
                        END;
                    END ELSE BEGIN
                        CNT := 1;
                        RoomsCS2.Reset();
                        RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                        RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                        RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                        RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                        RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                        IF RoomsCS2.FINDFIRST() THEN BEGIN
                            RoomCap := RoomsCS2."Exam Capacity";
                            RoomNo := RoomsCS2."Display Room No.";
                        END;

                        ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                        ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                        ExternalAttendanceLineCS.Modify();
                        RoomsCS.Reset();
                        RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                        RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                        RoomsCS.SETRANGE("Display Room No.", RoomNo);
                        IF RoomsCS.FINDFIRST() THEN BEGIN
                            RoomsCS."Allot For Examination" := TRUE;
                            RoomsCS.Modify();
                        END;
                    END;

                    IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                        ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                        ExternalAttendanceHeaderCS.Modify();
                    END;
                    GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                UNTIL ExternalAttendanceLineCS.NEXT() = 0;

        END;
        //Code added for Generate Sitting Plan Document Wise ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateExamLogCS(TempStudExternalAttendLine: Record "External Attendance Line-CS"; RoomCapacity: Integer)
    var
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        ExaminationLogDetailsCS1: Record "Examination Log Details-CS";
        Entryno: Integer;
    begin
        //Code added for Generate Examination Log ::CSPL-00092::28-05-2019: Start
        ExaminationLogDetailsCS.Reset();
        ExaminationLogDetailsCS.SETCURRENTKEY("Exam Date", "Academic Year", "Time Slot", "Room No.");
        ExaminationLogDetailsCS.SETRANGE("Exam Date", TempStudExternalAttendLine."Exam Date");
        ExaminationLogDetailsCS.SETRANGE("Academic Year", TempStudExternalAttendLine."Academic Year");
        ExaminationLogDetailsCS.SETRANGE("Time Slot", TempStudExternalAttendLine."Exam Slot");
        ExaminationLogDetailsCS.SETRANGE("Room No.", TempStudExternalAttendLine."Room Alloted No.");
        IF NOT ExaminationLogDetailsCS.FINDFIRST() THEN BEGIN
            ExaminationLogDetailsCS1.Reset();
            IF ExaminationLogDetailsCS1.FINDLAST() THEN
                Entryno := ExaminationLogDetailsCS1."Entry No" + 1
            ELSE
                Entryno := 1;

            ExaminationLogDetailsCS.INIT();
            ExaminationLogDetailsCS."Entry No" := Entryno;
            ExaminationLogDetailsCS."Exam Date" := TempStudExternalAttendLine."Exam Date";
            ExaminationLogDetailsCS."Time Slot" := TempStudExternalAttendLine."Exam Slot";
            ExaminationLogDetailsCS."Academic Year" := TempStudExternalAttendLine."Academic Year";
            ExaminationLogDetailsCS."Room Capacity" := RoomCapacity;
            ExaminationLogDetailsCS."Global Dimension 1 Code" := TempStudExternalAttendLine."Global Dimension 1 Code";
            ExaminationLogDetailsCS."Room No." := TempStudExternalAttendLine."Room Alloted No.";
            ExaminationLogDetailsCS.INSERT();
        END;
        //Code added for Generate Examination Log ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateStudentSubjectLogCS()
    var
        StudentSubjectLogTempCS: Record "Student Subject Log Temp-CS";
        MainOptionalSubjectLogCS: Record "Main&Optional Subject Log-CS";
        LineNo: Integer;
    begin
        //Code added for Generate Student Subject Log ::CSPL-00092::28-05-2019: Start
        StudentSubjectLogTempCS.Reset();
        IF StudentSubjectLogTempCS.FINDSET() THEN
            REPEAT
                MainOptionalSubjectLogCS.INIT();

                MainOptionalSubjectLogCS.Reset();
                MainOptionalSubjectLogCS.SETCURRENTKEY("Student No.");
                MainOptionalSubjectLogCS.SETRANGE("Student No.", StudentSubjectLogTempCS."Student No.");
                IF MainOptionalSubjectLogCS.FINDLAST() THEN
                    LineNo := MainOptionalSubjectLogCS."Line No." + 10000
                ELSE
                    LineNo := 10000;

                MainOptionalSubjectLogCS."Student No." := StudentSubjectLogTempCS."Student No.";
                MainOptionalSubjectLogCS."Line No." := LineNo;
                MainOptionalSubjectLogCS."Document Type" := StudentSubjectLogTempCS."Document Type";
                MainOptionalSubjectLogCS."Table Type" := StudentSubjectLogTempCS."Table Type";
                MainOptionalSubjectLogCS."Old Value" := StudentSubjectLogTempCS."Old Value";
                MainOptionalSubjectLogCS."New Value" := StudentSubjectLogTempCS."New Value";
                MainOptionalSubjectLogCS."Grade Change Type" := StudentSubjectLogTempCS."Grade Change Type";
                MainOptionalSubjectLogCS."Subject Code" := StudentSubjectLogTempCS."Subject Code";
                MainOptionalSubjectLogCS."Modified By" := StudentSubjectLogTempCS."Modified By";
                MainOptionalSubjectLogCS."Modified On" := StudentSubjectLogTempCS."Modified On";
                MainOptionalSubjectLogCS.INSERT();
            UNTIL StudentSubjectLogTempCS.NEXT() = 0;

        StudentSubjectLogTempCS.Reset();
        IF StudentSubjectLogTempCS.FINDSET() THEN
            StudentSubjectLogTempCS.DELETEALL();
        //Code added for Generate Student Subject Log ::CSPL-00092::28-05-2019: End
    end;

    procedure RegularExamResultPublishCS(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    begin
        //Code added for Publish Regular Examination Result ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Regular Exam Grade Alloted" <> TRUE THEN
                ERROR('Regular Exam Grade Not Alloted To Student !!');
            IF EducationSetupCS."Regular Exam Grade Published" = TRUE THEN
                ERROR('Regular Exam Grade ALready Published !!');
        END;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.MODIFYALL(Publish, TRUE);
            MainStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            OptionalStudentSubjectCS.MODIFYALL(Publish, TRUE);
            OptionalStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        GenerateStudentSubjectLogCS();

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Regular Exam Grade Published" := TRUE;
            EducationSetupCS.Modify();
        END;
        MESSAGE('Grade Has Been Publish Successfully !!!');
        //Code added for Publish Regular Examination Result ::CSPL-00092::28-05-2019: End
    end;

    procedure MakeupExamResultPublishCS(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    //InformationOfStudentCS: Codeunit "CSLMInformationOfStudentCS";
    begin
        //Code added for Publish Makeup Exam Result ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Makeup Exam Grade Alloted" <> TRUE THEN
                ERROR('MakeUp Exam Grade Not Alloted To Student !!');
            IF EducationSetupCS."Makeup Exam Grade Published" = TRUE THEN
                ERROR('MakeUp Exam Grade Already Published !!');
        END;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        MainStudentSubjectCS.SETRANGE("Make Up Examination", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        OptionalStudentSubjectCS.SETRANGE("Make Up Examination", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            OptionalStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        GenerateStudentSubjectLogCS();

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Makeup Exam Grade Published" := TRUE;
            EducationSetupCS.Modify();
        END;
        MESSAGE('Grade Has Been Publish Successfully !!!');
        //Code added for Publish Makeup Exam Result ::CSPL-00092::28-05-2019: End
    end;

    procedure Revaluation1stExamResultPublishCS(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    //InformationOfStudentCS: Codeunit "CSLMInformationOfStudentCS";
    begin
        //Code added for Publish Revaluation 1st Exam Result ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Rev. 1 Exam Grade Alloted" <> TRUE THEN
                ERROR('Revaluation1 Exam Grade Not Alloted To Student !!');
            IF EducationSetupCS."Rev. 1  Exam Grade Published" = TRUE THEN
                ERROR('Revaluation1 Exam Grade Already Published !!');
        END;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        MainStudentSubjectCS.SETRANGE(Revaluation1, TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        OptionalStudentSubjectCS.SETRANGE(Revaluation1, TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            OptionalStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        GenerateStudentSubjectLogCS();

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Rev. 1  Exam Grade Published" := TRUE;
            EducationSetupCS.Modify();
        END;
        MESSAGE('Grade Has Been Publish Successfully !!!');
        //Code added for Publish Revaluation 1st Exam Result ::CSPL-00092::28-05-2019: End
    end;

    procedure Revaluation2stExamResultPublishCS(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    //InformationOfStudentCS: Codeunit "CSLMInformationOfStudentCS";
    begin
        //Code added for Publish Revaluation 2nd Exam Result ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Rev. 2  Exam Grade Alloted" <> TRUE THEN
                ERROR('Revaluation2 Exam Grade Not Alloted To Student !!');
            IF EducationSetupCS."Rev. 2  Exam Grade Published" = TRUE THEN
                ERROR('Revaluation2 Exam Grade Already Published !!');
        END;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        MainStudentSubjectCS.SETRANGE(Revaluation2, TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        OptionalStudentSubjectCS.SETRANGE(Revaluation2, TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            OptionalStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        GenerateStudentSubjectLogCS();

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Rev. 2  Exam Grade Published" := TRUE;
            EducationSetupCS.Modify();
        END;
        MESSAGE('Grade Has Been Publish Successfully !!!');
        //Code added for Publish Revaluation 2nd Exam Result ::CSPL-00092::28-05-2019: End
    end;

    procedure Revaluation3ExamRLesultPublishCS(InStitueCode: Code[20])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    //InformationOfStudentCS: Codeunit CSLMInformationOfStudentCS;
    begin
        //Code added for Publish Revaluation 3rd Exam Result ::CSPL-00092::28-05-2019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        MainStudentSubjectCS.SETRANGE(Revaluation2, TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        OptionalStudentSubjectCS.SETRANGE(Revaluation2, TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            OptionalStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        GenerateStudentSubjectLogCS();
        //Code added for Publish Revaluation 3rd Exam Result ::CSPL-00092::28-05-2019: End
    end;

    procedure SpacialExamResultPublishCS(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    //InformationOfStudentCS: Codeunit "CSLMInformationOfStudentCS";
    begin
        //Code added for Publish Spacial Exam Result ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Special Exam Grade Alloted" <> TRUE THEN
                ERROR('Spacial Exam Grade Not Alloted To Student !!');
            IF EducationSetupCS."Special Exam Grade published" = TRUE THEN
                ERROR('Spacial Exam Grade Already Published !!');
        END;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        MainStudentSubjectCS.SETRANGE("Special Exam", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MainStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        OptionalStudentSubjectCS.SETRANGE("Special Exam", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            OptionalStudentSubjectCS.MODIFYALL(Publish, TRUE);
        END;

        GenerateStudentSubjectLogCS();

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Special Exam Grade published" := TRUE;
            EducationSetupCS.Modify();
        END;
        MESSAGE('Grade Has Been Publish Successfully !!!');
        //Code added for Publish Spacial Exam Result ::CSPL-00092::28-05-2019: End
    end;

    procedure CalculateStudentSubAttendanceCS(InstituteCode: Code[20])
    var
        SetupExaminationCS: Record "Setup Examination -CS";
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        ClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        SubjectClassificationCS: Record "Subject Classification-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        TotalAttendance: Integer;
        PresentAttendance: Integer;
        CondonateAttendance: Integer;

        ClassStartDate: Date;
        ClassEndDate: Date;

        TotalClassHeld: Integer;
        TotalAttendanceTaken: Integer;
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING STUDENT SUBJECT( THEORY )... #1  ..............OUT OF................  @2 .';
        Text_10002Lbl: Label ' UPLOADING STUDENT SUBJECT ( LAB )... #1  ............OUT OF...............  @2 .';
        Text_10003Lbl: Label ' UPLOADING STUDENT SUBJECT ( SEMINAR )... #1 ........... OUT OF............  @2 .';
        Text_10004Lbl: Label ' UPLOADING STUDENT OPTIONAL SUBJECT ( THEORY )... #1  ............OUT OF............  @2 .';
        Text_10005Lbl: Label ' UPLOADING STUDENT OPTIONAL SUBJECT ( LAB )... #1  ..............OUT OF..............  @2 .';
        Text_10006Lbl: Label ' UPLOADING STUDENT OPTIONAL SUBJECT ( SEMINAR )... #1  .............OUT OF..............  @2 .';
        FilterDate: Date;
    begin
        //Code added for Calculate Student Subject Attendance ::CSPL-00092::28-05-2019: Start
        SetupExaminationCS.GET();
        SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.Reset();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
                EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    ClassStartDate := EducationMultiEventCalCS."Start Date";
                    ClassEndDate := EducationMultiEventCalCS."Revised End Date";
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.Reset();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        ClassStartDate := EducationMultiEventCalCS."Start Date";
                        ClassEndDate := EducationMultiEventCalCS."Revised End Date";
                    END;
                END;
        END ELSE
            ERROR('Education Setup For Institute "%1" Not Defined !!!', InstituteCode);


        SubjectClassificationCS.Reset();
        SubjectClassificationCS.SETRANGE("Attendance Not Applicable", FALSE);
        IF SubjectClassificationCS.FINDSET() THEN
            REPEAT
                TotalCount := 0;
                Counter := 0;
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY("Global Dimension 1 Code", "Academic Year", "Student No.", Semester, "Subject Class", "Subject Code", Year);
                MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                MainStudentSubjectCS.SETRANGE("Subject Class", SubjectClassificationCS.Code);
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII');
                MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                    TotalCount := MainStudentSubjectCS.count();
                    IF SubjectClassificationCS.Code = 'THEORY' THEN
                        PROGRESS.OPEN(Text_10001Lbl)
                    ELSE
                        IF SubjectClassificationCS.Code = 'LAB' THEN
                            PROGRESS.OPEN(Text_10002Lbl)
                        ELSE
                            IF SubjectClassificationCS.Code = 'SEMINAR' THEN
                                PROGRESS.OPEN(Text_10003Lbl);
                    REPEAT
                        FilterDate := 0D;
                        TotalAttendance := 0;
                        PresentAttendance := 0;
                        CLEAR(StudentMasterCS."Date of Joining");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            StudentMasterCS.TESTFIELD("Date of Joining");
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                Section, "Type Of Course", Year);
                        IF MainStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            MainStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := MainStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS.SETRANGE(Date, FilterDate, ClassEndDate);
                        ClassAttendanceLineCS.SETRANGE("Academic Year", MainStudentSubjectCS."Academic Year");
                        IF MainStudentSubjectCS."Type Of Course" = MainStudentSubjectCS."Type Of Course"::Semester THEN
                            ClassAttendanceLineCS.SETRANGE(Semester, MainStudentSubjectCS.Semester)
                        ELSE
                            ClassAttendanceLineCS.SETRANGE(Year, MainStudentSubjectCS.Year);
                        ClassAttendanceLineCS.SETRANGE(Section, MainStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS.SETRANGE("Batch Code", MainStudentSubjectCS.Batch);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            TotalAttendance := ClassAttendanceLineCS.count();
                        ClassAttendanceLineCS.SETRANGE("Attendance Type", ClassAttendanceLineCS."Attendance Type"::Present);
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            PresentAttendance := ClassAttendanceLineCS.count();

                        FilterDate := 0D;
                        CondonateAttendance := 0;
                        ClassAttendanceLineCS1.Reset();
                        ClassAttendanceLineCS1.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                Section, "Type Of Course", Year);
                        IF MainStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            MainStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := MainStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS1.SETRANGE(Date, FilterDate, ClassEndDate);
                        IF MainStudentSubjectCS."Type Of Course" = MainStudentSubjectCS."Type Of Course"::Semester THEN
                            ClassAttendanceLineCS1.SETRANGE(Semester, MainStudentSubjectCS.Semester)
                        ELSE
                            ClassAttendanceLineCS1.SETRANGE(Year, MainStudentSubjectCS.Year);
                        ClassAttendanceLineCS1.SETRANGE(Section, MainStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS1.SETRANGE("Batch Code", MainStudentSubjectCS.Batch);
                        ClassAttendanceLineCS1.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS1.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS1.SETRANGE("Academic Year", MainStudentSubjectCS."Academic Year");
                        ClassAttendanceLineCS1.SETRANGE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                        ClassAttendanceLineCS1.SETRANGE("Attendance Condonation", TRUE);
                        IF ClassAttendanceLineCS1.FINDSET() THEN
                            CondonateAttendance := ClassAttendanceLineCS1.count();

                        FilterDate := 0D;
                        TotalClassHeld := 0;
                        TotalAttendanceTaken := 0;
                        FinalClassTimeTableCS.Reset();
                        IF MainStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            MainStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := MainStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        FinalClassTimeTableCS.SETRANGE(Date, FilterDate, ClassEndDate);
                        FinalClassTimeTableCS.SETRANGE(Cancelled, FALSE);
                        FinalClassTimeTableCS.SETRANGE("Academic Code", MainStudentSubjectCS."Academic Year");
                        IF MainStudentSubjectCS.Semester <> 'I' THEN
                            FinalClassTimeTableCS.SETRANGE("Course code", MainStudentSubjectCS.Course);
                        FinalClassTimeTableCS.SETRANGE(Section, MainStudentSubjectCS.Section);
                        IF MainStudentSubjectCS."Type Of Course" = MainStudentSubjectCS."Type Of Course"::Semester THEN
                            FinalClassTimeTableCS.SETRANGE(Semester, MainStudentSubjectCS.Semester)
                        ELSE
                            FinalClassTimeTableCS.SETRANGE(Year, MainStudentSubjectCS.Year);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            FinalClassTimeTableCS.SETRANGE(Batch, MainStudentSubjectCS.Batch);
                        FinalClassTimeTableCS.SETRANGE("Subject Class", MainStudentSubjectCS."Subject Class");
                        FinalClassTimeTableCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                        FinalClassTimeTableCS.SETRANGE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                        IF FinalClassTimeTableCS.FINDSET() THEN
                            TotalClassHeld := FinalClassTimeTableCS.count();
                        FinalClassTimeTableCS.SETRANGE(Attendance, FinalClassTimeTableCS.Attendance::Marked);
                        TotalAttendanceTaken := FinalClassTimeTableCS.count();

                        IF TotalAttendance <> 0 THEN BEGIN
                            SubjectMasterCS.Reset();
                            SubjectMasterCS.SETRANGE(Code, MainStudentSubjectCS."Subject Code");
                            IF SubjectMasterCS.FINDFIRST() THEN
                                IF SubjectMasterCS."Subject Classification" = 'THEORY' THEN BEGIN
                                    TotalAttendance := TotalAttendance + MainStudentSubjectCS.Credit;
                                    PresentAttendance := PresentAttendance + MainStudentSubjectCS.Credit;
                                    TotalClassHeld := TotalClassHeld + SubjectMasterCS.Credit;
                                    TotalAttendanceTaken := TotalAttendanceTaken + SubjectMasterCS.Credit;
                                END ELSE BEGIN
                                    TotalAttendance := TotalAttendance + 1;
                                    PresentAttendance := PresentAttendance + 1;
                                    TotalClassHeld := TotalClassHeld + 1;
                                    TotalAttendanceTaken := TotalAttendanceTaken + 1;
                                END;
                        END;

                        MainStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        MainStudentSubjectCS."Total Class Held" := TotalClassHeld;
                        MainStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                        MainStudentSubjectCS."Present Count" := PresentAttendance + CondonateAttendance;
                        MainStudentSubjectCS."Absent Count" := TotalAttendance - (PresentAttendance + CondonateAttendance);
                        IF TotalAttendance <> 0 THEN
                            MainStudentSubjectCS."Attendance Percentage" := ROUND(((PresentAttendance + CondonateAttendance) / TotalAttendance) * 100, 1, '>');
                        MainStudentSubjectCS.Modify();
                        Counter := Counter + 1;
                        PROGRESS.UPDATE(1, Counter);
                        PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                    UNTIL MainStudentSubjectCS.NEXT() = 0;
                    PROGRESS.Close();
                END;

                TotalCount := 0;
                Counter := 0;
                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETCURRENTKEY("Global Dimension 1 Code", "Academic Year", "Student No.", Semester, "Subject Class", "Subject Code", Year);
                OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                OptionalStudentSubjectCS.SETRANGE("Subject Class", SubjectClassificationCS.Code);
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV');
                OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                    TotalCount := OptionalStudentSubjectCS.count();
                    IF SubjectClassificationCS.Code = 'THEORY' THEN
                        PROGRESS.OPEN(Text_10004Lbl)
                    ELSE
                        IF SubjectClassificationCS.Code = 'LAB' THEN
                            PROGRESS.OPEN(Text_10005Lbl)
                        ELSE
                            IF SubjectClassificationCS.Code = 'SEMINAR' THEN
                                PROGRESS.OPEN(Text_10006Lbl);
                    REPEAT
                        FilterDate := 0D;
                        TotalAttendance := 0;
                        PresentAttendance := 0;
                        CLEAR(StudentMasterCS."Date of Joining");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            StudentMasterCS.TESTFIELD("Date of Joining");
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                 Section, "Type Of Course", Year);
                        IF OptionalStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            OptionalStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := OptionalStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS.SETRANGE(Date, FilterDate, ClassEndDate);
                        ClassAttendanceLineCS.SETRANGE(Section, OptionalStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS.SETRANGE("Batch Code", OptionalStudentSubjectCS.Batch);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS.SETRANGE("Academic Year", OptionalStudentSubjectCS."Academic Year");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            TotalAttendance := ClassAttendanceLineCS.count();
                        ClassAttendanceLineCS.SETRANGE("Attendance Type", ClassAttendanceLineCS."Attendance Type"::Present);
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            PresentAttendance := ClassAttendanceLineCS.count();

                        FilterDate := 0D;
                        CondonateAttendance := 0;
                        ClassAttendanceLineCS1.Reset();
                        ClassAttendanceLineCS1.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                 Section, "Type Of Course", Year);
                        IF OptionalStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            OptionalStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := OptionalStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS1.SETRANGE(Date, FilterDate, ClassEndDate);
                        ClassAttendanceLineCS1.SETRANGE(Section, OptionalStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS1.SETRANGE("Batch Code", OptionalStudentSubjectCS.Batch);
                        ClassAttendanceLineCS1.SETRANGE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS1.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS1.SETRANGE("Academic Year", OptionalStudentSubjectCS."Academic Year");
                        ClassAttendanceLineCS1.SETRANGE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                        ClassAttendanceLineCS1.SETRANGE("Attendance Condonation", TRUE);
                        IF ClassAttendanceLineCS1.FINDSET() THEN
                            CondonateAttendance := ClassAttendanceLineCS1.count();
                        FilterDate := 0D;
                        TotalClassHeld := 0;
                        TotalAttendanceTaken := 0;
                        FinalClassTimeTableCS.Reset();
                        IF OptionalStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            OptionalStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := OptionalStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        FinalClassTimeTableCS.SETRANGE(Date, FilterDate, ClassEndDate);
                        FinalClassTimeTableCS.SETRANGE(Cancelled, FALSE);
                        FinalClassTimeTableCS.SETRANGE("Academic Code", OptionalStudentSubjectCS."Academic Year");
                        FinalClassTimeTableCS.SETRANGE(Section, OptionalStudentSubjectCS.Section);

                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            FinalClassTimeTableCS.SETRANGE(Batch, OptionalStudentSubjectCS.Batch);
                        FinalClassTimeTableCS.SETRANGE("Subject Class", OptionalStudentSubjectCS."Subject Class");
                        FinalClassTimeTableCS.SETRANGE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                        FinalClassTimeTableCS.SETRANGE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                        IF FinalClassTimeTableCS.FINDSET() THEN
                            TotalClassHeld := FinalClassTimeTableCS.count();
                        FinalClassTimeTableCS.SETRANGE(Attendance, FinalClassTimeTableCS.Attendance::Marked);
                        TotalAttendanceTaken := FinalClassTimeTableCS.count();

                        IF TotalAttendance <> 0 THEN BEGIN
                            SubjectMasterCS.Reset();
                            SubjectMasterCS.SETRANGE(Code, OptionalStudentSubjectCS."Subject Code");
                            IF SubjectMasterCS.FINDFIRST() THEN
                                IF SubjectMasterCS."Subject Classification" = 'THEORY' THEN BEGIN
                                    TotalAttendance := TotalAttendance + OptionalStudentSubjectCS.Credit;
                                    PresentAttendance := PresentAttendance + OptionalStudentSubjectCS.Credit;
                                    TotalClassHeld := TotalClassHeld + OptionalStudentSubjectCS.Credit;
                                    TotalAttendanceTaken := TotalAttendanceTaken + OptionalStudentSubjectCS.Credit;
                                END ELSE BEGIN
                                    TotalAttendance := TotalAttendance + 1;
                                    PresentAttendance := PresentAttendance + 1;
                                    TotalClassHeld := TotalClassHeld + 1;
                                    TotalAttendanceTaken := TotalAttendanceTaken + 1;
                                END;
                        END;

                        OptionalStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        OptionalStudentSubjectCS."Total Class Held" := TotalClassHeld;
                        OptionalStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                        OptionalStudentSubjectCS."Present Count" := PresentAttendance + CondonateAttendance;
                        OptionalStudentSubjectCS."Absent Count" := TotalAttendance - (PresentAttendance + CondonateAttendance);
                        IF TotalAttendance <> 0 THEN
                            OptionalStudentSubjectCS."Attendance Percentage" := ROUND(((PresentAttendance + CondonateAttendance) / TotalAttendance) * 100, 1, '>');
                        OptionalStudentSubjectCS.Modify();
                        Counter := Counter + 1;
                        PROGRESS.UPDATE(1, Counter);
                        PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;
                    PROGRESS.Close();
                END;
            UNTIL SubjectClassificationCS.NEXT() = 0;


        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Students Attendance Updated" := TRUE;
            EducationSetupCS."Detainee List Prepaired" := TRUE;
            EducationSetupCS.Modify();
        END;
        MESSAGE('Attendance Updated !!!');
        //Code added for Calculate Student Subject Attendance ::CSPL-00092::28-05-2019: End
    end;

    procedure CalculateStudentSubAttenForReportCS(InstituteCode: Code[20]; SubjectCode: Code[10]; CourseCode: Code[10]; AcademicYear: Code[10]; EnrollmentNo: Code[20]; Sem: Code[10]; Sec: Code[10]; BatchCode: Code[20]; StartDate: Date; EndDate: Date; AddCredit: Boolean)
    var
        SetupExaminationCS: Record "Setup Examination -CS";
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        SubjectClassificationCS: Record "Subject Classification-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        TotalAttendance: Integer;
        PresentAttendance: Integer;
        CondonateAttendance: Integer;

        ClassStartDate: Date;
        ClassEndDate: Date;

        TotalClassHeld: Integer;
        TotalAttendanceTaken: Integer;
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING STUDENT SUBJECT( THEORY )... #1  ..............OUT OF................  @2 .', Comment = '%1 = XML node name ; %2 = Parent XML node name';
        Text_10002Lbl: Label ' UPLOADING STUDENT SUBJECT ( LAB )... #1  ............OUT OF...............  @2 .';
        Text_10003Lbl: Label ' UPLOADING STUDENT SUBJECT ( SEMINAR )... #1 ........... OUT OF............  @2 .';
        Text_10004Lbl: Label ' UPLOADING STUDENT OPTIONAL SUBJECT ( THEORY )... #1  ............OUT OF............  @2 .';
        Text_10005Lbl: Label ' UPLOADING STUDENT OPTIONAL SUBJECT ( LAB )... #1  ..............OUT OF..............  @2 .';
        Text_10006Lbl: Label ' UPLOADING STUDENT OPTIONAL SUBJECT ( SEMINAR )... #1  .............OUT OF..............  @2 .';
        FilterDate: Date;
    begin
        //Code added for Calculate Student Subject Attendance For Report ::CSPL-00092::28-05-2019: Start
        SetupExaminationCS.GET();
        SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.Reset();
                EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
                EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    ClassStartDate := EducationMultiEventCalCS."Start Date";
                    ClassEndDate := EducationMultiEventCalCS."Revised End Date";
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.Reset();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        ClassStartDate := EducationMultiEventCalCS."Start Date";
                        ClassEndDate := EducationMultiEventCalCS."Revised End Date";
                    END;
                END;
        END ELSE
            ERROR('Education Setup For Institute "%1" Not Defined !!!', InstituteCode);


        SubjectClassificationCS.Reset();
        SubjectClassificationCS.SETRANGE("Attendance Not Applicable", FALSE);
        IF SubjectClassificationCS.FINDSET() THEN
            REPEAT
                TotalCount := 0;
                Counter := 0;
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY("Global Dimension 1 Code", "Academic Year", "Student No.", Semester, "Subject Class", "Subject Code", Year);
                IF SubjectCode <> '' THEN
                    MainStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                IF EnrollmentNo <> '' THEN
                    MainStudentSubjectCS.SETRANGE("Enrollment No", EnrollmentNo);
                IF CourseCode <> '' THEN
                    MainStudentSubjectCS.SETRANGE(Course, CourseCode);
                IF Sec <> '' THEN
                    MainStudentSubjectCS.SETRANGE(Section, Sec);
                IF BatchCode <> '' THEN
                    MainStudentSubjectCS.SETRANGE(Batch, BatchCode);
                IF AcademicYear <> '' THEN
                    MainStudentSubjectCS.SETRANGE("Academic Year", AcademicYear)
                ELSE
                    MainStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                MainStudentSubjectCS.SETRANGE("Subject Class", SubjectClassificationCS.Code);
                IF Sem <> '' THEN
                    MainStudentSubjectCS.SETRANGE(Semester, Sem)
                ELSE BEGIN
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                        MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII')
                    ELSE
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII');
                END;
                MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                    TotalCount := MainStudentSubjectCS.count();
                    IF SubjectClassificationCS.Code = 'THEORY' THEN
                        PROGRESS.OPEN(Text_10001Lbl)
                    ELSE
                        IF SubjectClassificationCS.Code = 'LAB' THEN
                            PROGRESS.OPEN(Text_10002Lbl)
                        ELSE
                            IF SubjectClassificationCS.Code = 'SEMINAR' THEN
                                PROGRESS.OPEN(Text_10003Lbl);
                    REPEAT
                        FilterDate := 0D;
                        TotalAttendance := 0;
                        PresentAttendance := 0;
                        CLEAR(StudentMasterCS."Date of Joining");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            StudentMasterCS.TESTFIELD("Date of Joining");
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                Section, "Type Of Course", Year);
                        IF MainStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            MainStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := MainStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS.SETRANGE(Date, FilterDate, TODAY());
                        ClassAttendanceLineCS.SETRANGE("Academic Year", MainStudentSubjectCS."Academic Year");
                        IF MainStudentSubjectCS."Type Of Course" = MainStudentSubjectCS."Type Of Course"::Semester THEN
                            ClassAttendanceLineCS.SETRANGE(Semester, MainStudentSubjectCS.Semester)
                        ELSE
                            ClassAttendanceLineCS.SETRANGE(Year, MainStudentSubjectCS.Year);
                        ClassAttendanceLineCS.SETRANGE(Section, MainStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS.SETRANGE("Batch Code", MainStudentSubjectCS.Batch);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            TotalAttendance := ClassAttendanceLineCS.count();
                        ClassAttendanceLineCS.SETRANGE("Attendance Type", ClassAttendanceLineCS."Attendance Type"::Present);
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            PresentAttendance := ClassAttendanceLineCS.count();

                        FilterDate := 0D;
                        CondonateAttendance := 0;
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                Section, "Type Of Course", Year);
                        IF MainStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            MainStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := MainStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS.SETRANGE(Date, FilterDate, TODAY());
                        IF MainStudentSubjectCS."Type Of Course" = MainStudentSubjectCS."Type Of Course"::Semester THEN
                            ClassAttendanceLineCS.SETRANGE(Semester, MainStudentSubjectCS.Semester)
                        ELSE
                            ClassAttendanceLineCS.SETRANGE(Year, MainStudentSubjectCS.Year);
                        ClassAttendanceLineCS.SETRANGE(Section, MainStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS.SETRANGE("Batch Code", MainStudentSubjectCS.Batch);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS.SETRANGE("Academic Year", MainStudentSubjectCS."Academic Year");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                        ClassAttendanceLineCS.SETRANGE("Attendance Condonation", TRUE);
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            CondonateAttendance := ClassAttendanceLineCS.count();

                        FilterDate := 0D;
                        TotalClassHeld := 0;
                        TotalAttendanceTaken := 0;
                        FinalClassTimeTableCS.Reset();
                        IF MainStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            MainStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := MainStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        FinalClassTimeTableCS.SETRANGE(Date, FilterDate, TODAY());
                        FinalClassTimeTableCS.SETRANGE(Cancelled, FALSE);
                        FinalClassTimeTableCS.SETRANGE("Academic Code", MainStudentSubjectCS."Academic Year");
                        IF MainStudentSubjectCS.Semester <> 'I' THEN
                            FinalClassTimeTableCS.SETRANGE("Course code", MainStudentSubjectCS.Course);
                        FinalClassTimeTableCS.SETRANGE(Section, MainStudentSubjectCS.Section);
                        IF MainStudentSubjectCS."Type Of Course" = MainStudentSubjectCS."Type Of Course"::Semester THEN
                            FinalClassTimeTableCS.SETRANGE(Semester, MainStudentSubjectCS.Semester)
                        ELSE
                            FinalClassTimeTableCS.SETRANGE(Year, MainStudentSubjectCS.Year);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            FinalClassTimeTableCS.SETRANGE(Batch, MainStudentSubjectCS.Batch);
                        FinalClassTimeTableCS.SETRANGE("Subject Class", MainStudentSubjectCS."Subject Class");
                        FinalClassTimeTableCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                        FinalClassTimeTableCS.SETRANGE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                        IF FinalClassTimeTableCS.FINDSET() THEN
                            TotalClassHeld := FinalClassTimeTableCS.count();
                        FinalClassTimeTableCS.SETRANGE(Attendance, FinalClassTimeTableCS.Attendance::Marked);
                        TotalAttendanceTaken := FinalClassTimeTableCS.count();

                        IF AddCredit = TRUE THEN BEGIN
                            IF TotalAttendance <> 0 THEN BEGIN
                                SubjectMasterCS.Reset();
                                SubjectMasterCS.SETRANGE(Code, MainStudentSubjectCS."Subject Code");
                                IF SubjectMasterCS.FINDFIRST() THEN
                                    IF SubjectMasterCS."Subject Classification" = 'THEORY' THEN BEGIN
                                        TotalAttendance := TotalAttendance + MainStudentSubjectCS.Credit;
                                        PresentAttendance := PresentAttendance + MainStudentSubjectCS.Credit;
                                        TotalClassHeld := TotalClassHeld + SubjectMasterCS.Credit;
                                        TotalAttendanceTaken := TotalAttendanceTaken + SubjectMasterCS.Credit;
                                    END ELSE BEGIN
                                        TotalAttendance := TotalAttendance + 1;
                                        PresentAttendance := PresentAttendance + 1;
                                        TotalClassHeld := TotalClassHeld + 1;
                                        TotalAttendanceTaken := TotalAttendanceTaken + 1;
                                    END;
                            END;
                        END;

                        MainStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        MainStudentSubjectCS."Total Class Held" := TotalClassHeld;
                        MainStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                        MainStudentSubjectCS."Present Count" := PresentAttendance + CondonateAttendance;
                        MainStudentSubjectCS."Absent Count" := TotalAttendance - (PresentAttendance + CondonateAttendance);
                        IF TotalAttendance <> 0 THEN
                            MainStudentSubjectCS."Attendance Percentage" := ROUND(((PresentAttendance + CondonateAttendance) / TotalAttendance) * 100, 1, '>');
                        MainStudentSubjectCS.Modify();
                        Counter := Counter + 1;
                        PROGRESS.UPDATE(1, Counter);
                        PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                    UNTIL MainStudentSubjectCS.NEXT() = 0;
                    PROGRESS.Close();
                END;

                TotalCount := 0;
                Counter := 0;
                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETCURRENTKEY("Global Dimension 1 Code", "Academic Year", "Student No.", Semester, "Subject Class", "Subject Code", Year);
                IF SubjectCode <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE("Subject Code", SubjectCode);
                IF EnrollmentNo <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE("Enrollment No", EnrollmentNo);
                IF CourseCode <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE(Course, CourseCode);
                IF Sec <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE(Section, Sec);
                IF BatchCode <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE(Batch, BatchCode);
                IF AcademicYear <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE("Academic Year", AcademicYear)
                ELSE
                    OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                OptionalStudentSubjectCS.SETRANGE("Subject Class", SubjectClassificationCS.Code);
                IF Sem <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE(Semester, Sem)
                ELSE BEGIN
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                        OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
                    ELSE
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                            OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV');
                END;
                OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
                IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                    TotalCount := OptionalStudentSubjectCS.count();
                    IF SubjectClassificationCS.Code = 'THEORY' THEN
                        PROGRESS.OPEN(Text_10004Lbl)
                    ELSE
                        IF SubjectClassificationCS.Code = 'LAB' THEN
                            PROGRESS.OPEN(Text_10005Lbl)
                        ELSE
                            IF SubjectClassificationCS.Code = 'SEMINAR' THEN
                                PROGRESS.OPEN(Text_10006Lbl);
                    REPEAT
                        FilterDate := 0D;
                        TotalAttendance := 0;
                        PresentAttendance := 0;
                        CLEAR(StudentMasterCS."Date of Joining");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            StudentMasterCS.TESTFIELD("Date of Joining");
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                 Section, "Type Of Course", Year);
                        IF OptionalStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            OptionalStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := OptionalStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS.SETRANGE(Date, FilterDate, TODAY());
                        ClassAttendanceLineCS.SETRANGE(Section, OptionalStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS.SETRANGE("Batch Code", OptionalStudentSubjectCS.Batch);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS.SETRANGE("Academic Year", OptionalStudentSubjectCS."Academic Year");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            TotalAttendance := ClassAttendanceLineCS.count();
                        ClassAttendanceLineCS.SETRANGE("Attendance Type", ClassAttendanceLineCS."Attendance Type"::Present);
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            PresentAttendance := ClassAttendanceLineCS.count();
                        FilterDate := 0D;
                        CondonateAttendance := 0;
                        ClassAttendanceLineCS.Reset();
                        ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
                                                                 Section, "Type Of Course", Year);
                        IF OptionalStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            OptionalStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := OptionalStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        ClassAttendanceLineCS.SETRANGE(Date, FilterDate, TODAY());
                        ClassAttendanceLineCS.SETRANGE(Section, OptionalStudentSubjectCS.Section);
                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            ClassAttendanceLineCS.SETRANGE("Batch Code", OptionalStudentSubjectCS.Batch);
                        ClassAttendanceLineCS.SETRANGE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                        ClassAttendanceLineCS.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                        ClassAttendanceLineCS.SETRANGE("Academic Year", OptionalStudentSubjectCS."Academic Year");
                        ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                        ClassAttendanceLineCS.SETRANGE("Attendance Condonation", TRUE);
                        IF ClassAttendanceLineCS.FINDSET() THEN
                            CondonateAttendance := ClassAttendanceLineCS.count();

                        FilterDate := 0D;
                        TotalClassHeld := 0;
                        TotalAttendanceTaken := 0;
                        FinalClassTimeTableCS.Reset();
                        IF OptionalStudentSubjectCS."Re-Registration" = TRUE THEN BEGIN
                            OptionalStudentSubjectCS.TESTFIELD("Re-Registration Date");
                            FilterDate := OptionalStudentSubjectCS."Re-Registration Date";
                        END ELSE
                            IF StudentMasterCS."Date of Joining" <> 0D THEN BEGIN
                                FilterDate := StudentMasterCS."Date of Joining";
                            END ELSE
                                FilterDate := ClassStartDate;
                        FinalClassTimeTableCS.SETRANGE(Date, FilterDate, TODAY());
                        FinalClassTimeTableCS.SETRANGE(Cancelled, FALSE);
                        FinalClassTimeTableCS.SETRANGE("Academic Code", OptionalStudentSubjectCS."Academic Year");
                        FinalClassTimeTableCS.SETRANGE(Section, OptionalStudentSubjectCS.Section);

                        IF (SubjectClassificationCS.Code = 'LAB') OR (SubjectClassificationCS.Code = 'SEMINAR') THEN
                            FinalClassTimeTableCS.SETRANGE(Batch, OptionalStudentSubjectCS.Batch);
                        FinalClassTimeTableCS.SETRANGE("Subject Class", OptionalStudentSubjectCS."Subject Class");
                        FinalClassTimeTableCS.SETRANGE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                        FinalClassTimeTableCS.SETRANGE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                        IF FinalClassTimeTableCS.FINDSET() THEN
                            TotalClassHeld := FinalClassTimeTableCS.count();
                        FinalClassTimeTableCS.SETRANGE(Attendance, FinalClassTimeTableCS.Attendance::Marked);
                        TotalAttendanceTaken := FinalClassTimeTableCS.count();

                        IF AddCredit = TRUE THEN BEGIN
                            IF TotalAttendance <> 0 THEN BEGIN
                                SubjectMasterCS.Reset();
                                SubjectMasterCS.SETRANGE(Code, OptionalStudentSubjectCS."Subject Code");
                                IF SubjectMasterCS.FINDFIRST() THEN
                                    IF SubjectMasterCS."Subject Classification" = 'THEORY' THEN BEGIN
                                        TotalAttendance := TotalAttendance + OptionalStudentSubjectCS.Credit;
                                        PresentAttendance := PresentAttendance + OptionalStudentSubjectCS.Credit;
                                        TotalClassHeld := TotalClassHeld + OptionalStudentSubjectCS.Credit;
                                        TotalAttendanceTaken := TotalAttendanceTaken + OptionalStudentSubjectCS.Credit;
                                    END ELSE BEGIN
                                        TotalAttendance := TotalAttendance + 1;
                                        PresentAttendance := PresentAttendance + 1;
                                        TotalClassHeld := TotalClassHeld + 1;
                                        TotalAttendanceTaken := TotalAttendanceTaken + 1;
                                    END;
                            END;
                        END;

                        OptionalStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        OptionalStudentSubjectCS."Total Class Held" := TotalClassHeld;
                        OptionalStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                        OptionalStudentSubjectCS."Present Count" := PresentAttendance + CondonateAttendance;
                        OptionalStudentSubjectCS."Absent Count" := TotalAttendance - (PresentAttendance + CondonateAttendance);
                        IF TotalAttendance <> 0 THEN
                            OptionalStudentSubjectCS."Attendance Percentage" := ROUND(((PresentAttendance + CondonateAttendance) / TotalAttendance) * 100, 1, '>');

                        OptionalStudentSubjectCS.Modify();
                        Counter := Counter + 1;
                        PROGRESS.UPDATE(1, Counter);
                        PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;
                    PROGRESS.Close();
                END;

            UNTIL SubjectClassificationCS.NEXT() = 0;

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Students Attendance Updated" := TRUE;
            EducationSetupCS.Modify();
        END;
        //Code added for Calculate Student Subject Attendance For Report ::CSPL-00092::28-05-2019: End
    end;

    procedure TimeSlotValidateCS()
    var
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        ExaminationTimeSlotCS: Record "Examination Time Slot-CS";
    begin
        //Code added for Time Slot Validate ::CSPL-00092::28-05-2019: Start
        ExamTimeTableLineCS.Reset();
        ExamTimeTableLineCS.SETRANGE("Start Time New", 0T);
        IF ExamTimeTableLineCS.FINDSET() THEN
            REPEAT
                ExaminationTimeSlotCS.Reset();
                ExaminationTimeSlotCS.SETRANGE(Code, ExamTimeTableLineCS."Exam Slot New");
                IF ExaminationTimeSlotCS.FINDFIRST() THEN BEGIN
                    ExamTimeTableLineCS."Start Time New" := ExaminationTimeSlotCS."From Time";
                    ExamTimeTableLineCS."End Time New" := ExaminationTimeSlotCS."To Time";
                END;
                ExamTimeTableLineCS.Modify();
            UNTIL ExamTimeTableLineCS.NEXT() = 0;
        //Code added for Time Slot Validate ::CSPL-00092::28-05-2019: End
    end;

    procedure AutomaticBatchAllotmentCS(InstituteCode: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        BatchCS: Record "Batch-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        Text_1001Lbl: Label 'Education Setup for Institute Code %1  is Not Defined !!';

        NumberofBatchs: Integer;
        CountPerBatch: Integer;
        RollNo: Integer;
        SectionCode: Code[10];
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        "Text_10001Lbl": Label ' UPLOADING... #1  Out Of  @2 .';
    begin
        //Code added for Automatic Batch Allotment ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR(Text_1001Lbl, InstituteCode);

        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
        CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
        IF CourseWiseSubjectLineCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectLineCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                BatchCS.Reset();
                IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                    BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                IF BatchCS.FINDSET() THEN
                    NumberofBatchs := BatchCS.count();

                FacultyCourseWiseCS.Reset();
                FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                    FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                ELSE
                    FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                IF FacultyCourseWiseCS.FINDSET() THEN
                    REPEAT
                        IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETCURRENTKEY(Section, "Roll No.");
                            MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                            MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                            MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                            MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                            MainStudentSubjectCS.SETFILTER("Roll No.", '<>%1', '');
                            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '=');
                                REPEAT
                                    MainStudentSubjectCS.TESTFIELD("Roll No.");
                                    EVALUATE(RollNo, MainStudentSubjectCS."Roll No.");
                                    IF RollNo <= CountPerBatch THEN
                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH')
                                    ELSE
                                        IF (RollNo > CountPerBatch) AND (RollNo <= (2 * CountPerBatch)) THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                        ELSE
                                            IF (RollNo > (2 * CountPerBatch)) AND (RollNo <= (3 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                            ELSE
                                                IF (RollNo > (3 * CountPerBatch)) AND (RollNo <= (4 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3');
                                    MainStudentSubjectCS.Modify();
                                UNTIL MainStudentSubjectCS.NEXT() = 0;
                            END;
                            SectionCode := FacultyCourseWiseCS."Section Code";
                        END;
                    UNTIL FacultyCourseWiseCS.NEXT() = 0;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
            PROGRESS.Close();
        END;
        MESSAGE('Done');
        //Code added for Automatic Batch Allotment ::CSPL-00092::28-05-2019: End
    end;

    procedure SelectedBatchAllotmentCS(SemesterValue: Code[10]; CourseCode: Code[10]; InstituteCode: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        BatchCS: Record "Batch-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        NumberofBatchs: Integer;
        CountPerBatch: Integer;
        RollNo: Integer;
        SectionCode: Code[10];
        Text_1001Lbl: Label 'Education Setup for Institute Code %1  is Not Defined !!';
    begin
        //Code added for Selected Batch Allotment ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR(Text_1001Lbl, InstituteCode);

        IF (SemesterValue = 'I') OR (SemesterValue = 'II') OR (SemesterValue = '') THEN BEGIN
            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETCURRENTKEY("Subject Code");
            CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
            CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
            IF SemesterValue <> '' THEN
                CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterValue)
            ELSE BEGIN
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
            END;
            CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
            CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
            IF CourseWiseSubjectLineCS.FINDSET() THEN
                REPEAT
                    BatchCS.Reset();
                    IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                        BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                    BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    IF BatchCS.FINDSET() THEN
                        NumberofBatchs := BatchCS.count();

                    FacultyCourseWiseCS.Reset();
                    FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                    FacultyCourseWiseCS.SETRANGE("Course Code", '');
                    IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                    ELSE
                        FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                    FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                    FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                    FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                    FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                    FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                    FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                    IF FacultyCourseWiseCS.FINDSET() THEN
                        REPEAT
                            IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
                                MainStudentSubjectCS.Reset();
                                MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                                MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                                MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                                MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                                MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                                MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                                IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                    CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '>');
                                    REPEAT
                                        MainStudentSubjectCS.TESTFIELD("Roll No.");
                                        EVALUATE(RollNo, MainStudentSubjectCS."Roll No.");
                                        IF RollNo <= CountPerBatch THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH')
                                        ELSE
                                            IF (RollNo > CountPerBatch) AND (RollNo <= (2 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                            ELSE
                                                IF (RollNo > (2 * CountPerBatch)) AND (RollNo <= (3 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                                ELSE
                                                    IF (RollNo > (3 * CountPerBatch)) AND (RollNo <= (4 * CountPerBatch)) THEN
                                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3');
                                        MainStudentSubjectCS.Modify();
                                    UNTIL MainStudentSubjectCS.NEXT() = 0;
                                END;
                                SectionCode := FacultyCourseWiseCS."Section Code";
                            END;
                        UNTIL FacultyCourseWiseCS.NEXT() = 0;
                UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        END;

        IF (SemesterValue = 'III') OR (SemesterValue = 'IV') OR (SemesterValue = 'V') OR (SemesterValue = 'VI')
            OR (SemesterValue = 'VII') OR (SemesterValue = 'VIII') OR (SemesterValue = '') THEN BEGIN
            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code");
            CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            IF CourseCode <> '' THEN
                CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseCode);
            CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
            IF SemesterValue <> '' THEN
                CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterValue)
            ELSE BEGIN
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
            END;
            CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
            CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
            IF CourseWiseSubjectLineCS.FINDSET() THEN
                REPEAT
                    BatchCS.Reset();
                    IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                        BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                    BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    IF BatchCS.FINDSET() THEN
                        NumberofBatchs := BatchCS.count();


                    FacultyCourseWiseCS.Reset();
                    FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                    IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
                        FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                    IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                    ELSE
                        FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                    FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                    FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                    FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                    FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                    FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                    FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                    IF FacultyCourseWiseCS.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                            MainStudentSubjectCS.SETRANGE(Course, CourseWiseSubjectLineCS."Course Code");
                            MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                            MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                            MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '>');
                                REPEAT
                                    MainStudentSubjectCS.TESTFIELD("Roll No.");
                                    EVALUATE(RollNo, MainStudentSubjectCS."Roll No.");
                                    IF RollNo <= CountPerBatch THEN
                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH')
                                    ELSE
                                        IF (RollNo > CountPerBatch) AND (RollNo <= (2 * CountPerBatch)) THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                        ELSE
                                            IF (RollNo > (2 * CountPerBatch)) AND (RollNo <= (3 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                            ELSE
                                                IF (RollNo > (3 * CountPerBatch)) AND (RollNo <= (4 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3');
                                    MainStudentSubjectCS.Modify();
                                UNTIL MainStudentSubjectCS.NEXT() = 0;
                            END;
                        UNTIL FacultyCourseWiseCS.NEXT() = 0;
                UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        END;

        IF (SemesterValue = 'I') OR (SemesterValue = 'II') OR (SemesterValue = 'III & IV') OR (SemesterValue = '') THEN BEGIN
            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code");
            CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            IF CourseCode <> '' THEN
                CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseCode);
            CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
            IF SemesterValue <> '' THEN
                CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterValue)
            ELSE BEGIN
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
            END;
            CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
            CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
            IF CourseWiseSubjectLineCS.FINDSET() THEN
                REPEAT
                    BatchCS.Reset();
                    IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                        BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                    BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    IF BatchCS.FINDSET() THEN
                        NumberofBatchs := BatchCS.count();


                    FacultyCourseWiseCS.Reset();
                    FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                    IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
                        FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                    IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                    ELSE
                        FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                    FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                    FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                    FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                    FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                    FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                    FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                    IF FacultyCourseWiseCS.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                            MainStudentSubjectCS.SETRANGE(Course, CourseWiseSubjectLineCS."Course Code");
                            MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                            MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                            MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '>');
                                REPEAT
                                    MainStudentSubjectCS.TESTFIELD("Roll No.");
                                    EVALUATE(RollNo, MainStudentSubjectCS."Roll No.");
                                    IF RollNo <= CountPerBatch THEN
                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH')
                                    ELSE
                                        IF (RollNo > CountPerBatch) AND (RollNo <= (2 * CountPerBatch)) THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                        ELSE
                                            IF (RollNo > (2 * CountPerBatch)) AND (RollNo <= (3 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                            ELSE
                                                IF (RollNo > (3 * CountPerBatch)) AND (RollNo <= (4 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3');
                                    MainStudentSubjectCS.Modify();
                                UNTIL MainStudentSubjectCS.NEXT() = 0;
                            END;
                        UNTIL FacultyCourseWiseCS.NEXT() = 0;
                UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        END;
        //Code added for Selected Batch Allotment ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateSittingPlanNewCS(InstituteCodeValue: Code[20]; ExamScheduleCode: Code[20])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RoomsCS: Record "Rooms-CS";
        RoomsCS1: Record "Rooms-CS";
        RoomsCS2: Record "Rooms-CS";
        EducationSetupCS: Record "Education Setup-CS";
        RoomCap: Integer;
        RoomNo: Code[20];
        CNT: Integer;
        SUBCODE: Code[10];

        Text_1001Lbl: Label 'Education Setup for Institute Code %1  is Not Defined !!';
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING... #1  Out Of  @2 .';
    begin
        //Code added for Create Sitting Plan New ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCodeValue);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR(Text_1001Lbl, InstituteCodeValue);


        SUBCODE := '';
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETCURRENTKEY(Semester, "Subject Code");
        ExternalAttendanceHeaderCS.SETRANGE("Sitting Plan", FALSE);
        ExternalAttendanceHeaderCS.SETRANGE("Exam Schedule No.", ExamScheduleCode);
        ExternalAttendanceHeaderCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        ExternalAttendanceHeaderCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF ExternalAttendanceHeaderCS.FINDSET() THEN BEGIN
            TotalCount := ExternalAttendanceHeaderCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
                IF (ExternalAttendanceHeaderCS."Subject Type" <> 'CORE') OR ((ExternalAttendanceHeaderCS."Program" = 'UG') AND
                  ((ExternalAttendanceHeaderCS.Semester = 'I') OR (ExternalAttendanceHeaderCS.Semester = 'II'))) THEN BEGIN
                    ExternalAttendanceLineCS.Reset();
                    ExternalAttendanceLineCS.SETCURRENTKEY("Global Dimension 2 Code", Section, "Roll No.");
                    ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                    ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                    IF ExternalAttendanceLineCS.FINDSET() THEN
                        REPEAT
                            IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                                TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                                CNT := 0;
                                RoomNo := '';
                                RoomCap := 0;
                                RoomsCS1.Reset();
                                RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                                RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                                RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                                IF RoomsCS1.FINDFIRST() THEN BEGIN
                                    RoomCap := RoomsCS1."Exam Capacity";
                                    RoomNo := RoomsCS1."Display Room No.";
                                END;
                            END;
                            SUBCODE := ExternalAttendanceLineCS."Subject Code";

                            CNT += 1;
                            IF CNT <= RoomCap THEN BEGIN
                                ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                                ExternalAttendanceLineCS.Modify();
                                RoomsCS.Reset();
                                RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                                RoomsCS.SETRANGE("Display Room No.", RoomNo);
                                IF RoomsCS.FINDFIRST() THEN BEGIN
                                    RoomsCS."Allot For Examination" := TRUE;
                                    RoomsCS.Modify();
                                END;
                            END ELSE BEGIN
                                TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                                CNT := 1;
                                RoomsCS2.Reset();
                                RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                                RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                                RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                                IF RoomsCS2.FINDFIRST() THEN BEGIN
                                    RoomCap := RoomsCS2."Exam Capacity";
                                    RoomNo := RoomsCS2."Display Room No.";
                                END;

                                ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                                ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                                ExternalAttendanceLineCS.Modify();
                                RoomsCS.Reset();
                                RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                                RoomsCS.SETRANGE("Display Room No.", RoomNo);
                                IF RoomsCS.FINDFIRST() THEN BEGIN
                                    RoomsCS."Allot For Examination" := TRUE;
                                    RoomsCS.Modify();
                                END;
                            END;

                            IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                                ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                                ExternalAttendanceHeaderCS.Modify();
                            END;
                            GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                        UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                END ELSE BEGIN
                    ExternalAttendanceLineCS.Reset();
                    ExternalAttendanceLineCS.SETCURRENTKEY("Global Dimension 2 Code", Course, Section, "Roll No.");
                    ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                    ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                    IF ExternalAttendanceLineCS.FINDSET() THEN
                        REPEAT
                            IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                                TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                                CNT := 0;
                                RoomNo := '';
                                RoomCap := 0;
                                RoomsCS1.Reset();
                                RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                                RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                                RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                                IF RoomsCS1.FINDFIRST() THEN BEGIN
                                    RoomCap := RoomsCS1."Exam Capacity";
                                    RoomNo := RoomsCS1."Display Room No.";
                                END;
                            END;
                            SUBCODE := ExternalAttendanceLineCS."Subject Code";

                            CNT += 1;
                            IF CNT <= RoomCap THEN BEGIN
                                ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                                ExternalAttendanceLineCS.Modify();
                                RoomsCS.Reset();
                                RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS.SETRANGE("Display Room No.", RoomNo);
                                IF RoomsCS.FINDFIRST() THEN BEGIN
                                    RoomsCS."Allot For Examination" := TRUE;
                                    RoomsCS.Modify();
                                END;
                            END ELSE BEGIN
                                TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                                CNT := 1;
                                RoomsCS2.Reset();
                                RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                                RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                                RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                                IF RoomsCS2.FINDFIRST() THEN BEGIN
                                    RoomCap := RoomsCS2."Exam Capacity";
                                    RoomNo := RoomsCS2."Display Room No.";
                                END;

                                ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                                ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                                ExternalAttendanceLineCS.Modify();
                                RoomsCS.Reset();
                                RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                                RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                                RoomsCS.SETRANGE("Display Room No.", RoomNo);
                                IF RoomsCS.FINDFIRST() THEN BEGIN
                                    RoomsCS."Allot For Examination" := TRUE;
                                    RoomsCS.Modify();
                                END;
                            END;

                            IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                                ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                                ExternalAttendanceHeaderCS.Modify();
                            END;
                            GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                        UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                END;
            UNTIL ExternalAttendanceHeaderCS.NEXT() = 0;
            PROGRESS.Close();
        END;
        //Code added for Create Sitting Plan New ::CSPL-00092::28-05-2019: End
    end;

    procedure GenerateSittingPlanDocumentWiseNewCS(DocumentNo: Code[20]; InstituteCode: Code[10])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RoomsCS: Record "Rooms-CS";
        RoomsCS1: Record "Rooms-CS";
        RoomsCS2: Record "Rooms-CS";
        EducationSetupCS: Record "Education Setup-CS";
        RoomCap: Integer;
        RoomNo: Code[20];
        CNT: Integer;
        SUBCODE: Code[10];

        Text_1001Lbl: Label 'Education Setup for Institute Code %1  is Not Defined !!';
    begin
        //Code added for Create Sitting Plan Document Wise New ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR(Text_1001Lbl, InstituteCode);

        SUBCODE := '';
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETCURRENTKEY(Semester, "Subject Code");
        ExternalAttendanceHeaderCS.SETRANGE("No.", DocumentNo);
        ExternalAttendanceHeaderCS.SETRANGE("Sitting Plan", FALSE);
        ExternalAttendanceHeaderCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        ExternalAttendanceHeaderCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF ExternalAttendanceHeaderCS.FINDFIRST() THEN BEGIN
            IF (ExternalAttendanceHeaderCS."Subject Type" <> 'CORE') OR ((ExternalAttendanceHeaderCS."Program" = 'UG') AND
              ((ExternalAttendanceHeaderCS.Semester = 'I') OR (ExternalAttendanceHeaderCS.Semester = 'II'))) THEN BEGIN
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETCURRENTKEY("Global Dimension 2 Code", Section, "Roll No.");
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                            TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                            CNT := 0;
                            RoomNo := '';
                            RoomCap := 0;
                            RoomsCS1.Reset();
                            RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS1.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS1."Exam Capacity";
                                RoomNo := RoomsCS1."Display Room No.";
                            END;
                        END;
                        SUBCODE := ExternalAttendanceLineCS."Subject Code";

                        CNT += 1;
                        IF CNT <= RoomCap THEN BEGIN
                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END ELSE BEGIN
                            TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                            CNT := 1;
                            RoomsCS2.Reset();
                            RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS2.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS2."Exam Capacity";
                                RoomNo := RoomsCS2."Display Room No.";
                            END;

                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END;

                        IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                            ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                            ExternalAttendanceHeaderCS.Modify();
                        END;
                        GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
            END ELSE BEGIN
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETCURRENTKEY("Global Dimension 2 Code", Course, Section, "Roll No.");
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        IF SUBCODE <> ExternalAttendanceLineCS."Subject Code" THEN BEGIN
                            TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                            CNT := 0;
                            RoomNo := '';
                            RoomCap := 0;
                            RoomsCS1.Reset();
                            RoomsCS1.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS1.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS1.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS1.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS1.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS1.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS1."Exam Capacity";
                                RoomNo := RoomsCS1."Display Room No.";
                            END;
                        END;
                        SUBCODE := ExternalAttendanceLineCS."Subject Code";

                        CNT += 1;
                        IF CNT <= RoomCap THEN BEGIN
                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END ELSE BEGIN
                            TestCapcityDocumentWiseCS(ExternalAttendanceLineCS);
                            CNT := 1;
                            RoomsCS2.Reset();
                            RoomsCS2.SETCURRENTKEY("Examination Department Code", "Display Room No.");
                            RoomsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS2.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS2.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS2.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS2.FINDFIRST() THEN BEGIN
                                RoomCap := RoomsCS2."Exam Capacity";
                                RoomNo := RoomsCS2."Display Room No.";
                            END;

                            ExternalAttendanceLineCS."Room Alloted No." := RoomNo;
                            ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                            ExternalAttendanceLineCS.Modify();
                            RoomsCS.Reset();
                            RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                            RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                            RoomsCS.SETRANGE("Examination Department Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                            RoomsCS.SETRANGE("Display Room No.", RoomNo);
                            IF RoomsCS.FINDFIRST() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                        END;

                        IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                            ExternalAttendanceHeaderCS."Sitting Plan" := TRUE;
                            ExternalAttendanceHeaderCS.Modify();
                        END;
                        GenerateExamLogCS(ExternalAttendanceLineCS, RoomCap);
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
            END;
        END;
        MESSAGE('Seat Alloted');
        //Code added for Create Sitting Plan Document Wise New ::CSPL-00092::28-05-2019: End
    end;

    procedure ClearSittingPlanDocumentWiseCS(DocumentNo: Code[20])
    var
        RoomsCS: Record "Rooms-CS";
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        RoomNo: Code[20];
    begin
        //Code added for Clear Sitting Plan Document Wise ::CSPL-00092::28-05-2019: Start
        RoomNo := '';
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE("Document No.", DocumentNo);
        IF ExternalAttendanceLineCS.FINDSET() THEN
            REPEAT
                IF RoomNo <> ExternalAttendanceLineCS."Room Alloted No." THEN BEGIN
                    RoomNo := ExternalAttendanceLineCS."Room Alloted No.";
                    RoomsCS.Reset();
                    RoomsCS.SETRANGE("Display Room No.", RoomNo);
                    RoomsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                    RoomsCS.SETRANGE("Exam Slot", ExternalAttendanceLineCS."Exam Slot");
                    IF RoomsCS.FINDFIRST() THEN BEGIN
                        RoomsCS."Allot For Examination" := FALSE;
                        RoomsCS.Modify();
                    END;

                    ExaminationLogDetailsCS.Reset();
                    ExaminationLogDetailsCS.SETRANGE("Room No.", RoomNo);
                    ExaminationLogDetailsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS."Exam Date");
                    ExaminationLogDetailsCS.SETRANGE("Time Slot", ExternalAttendanceLineCS."Exam Slot");
                    IF ExaminationLogDetailsCS.FINDFIRST() THEN BEGIN
                        ExaminationLogDetailsCS.DELETE();
                    END;
                END;
                ExternalAttendanceLineCS."Room Alloted No." := '';
                ExternalAttendanceLineCS."Sitting Plan" := FALSE;
                ExternalAttendanceLineCS.Modify();

                IF ExternalAttendanceHeaderCS.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                    ExternalAttendanceHeaderCS."Sitting Plan" := FALSE;
                    ExternalAttendanceHeaderCS.Modify();
                END;
            UNTIL ExternalAttendanceLineCS.NEXT() = 0;
        //Code added for Clear Sitting Plan Document Wise ::CSPL-00092::28-05-2019: End
    end;

    procedure HallTicketCreationCS(ExamScheduleNo: Code[20]; InstituteCode: Code[10])
    var
        SubjectClassificationCS: Record "Subject Classification-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        NoSeriesLine: Record "No. Series Line";
        ExternalAttendanceLineCS1: Record "External Attendance Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        AdmitCardHeaderCS1: Record "Admit Card Header-CS";
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        "Text_10001Lbl": Label ' UPLOADING... #1  Out Of  @2 .';

        Text0001Lbl: Label 'Do you want to Generate the Hall Ticket?';
        Studentno: Code[20];
        Docno: Code[20];
        Lineno: Integer;
        NoofHallTicket: Integer;

    begin
        //Code added for Hall Ticket Geneartion ::CSPL-00092::28-05-2019: Start
        IF NOT CONFIRM(Text0001Lbl) THEN
            EXIT;

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR('Education Setup For Institute Code %1 Not Defined !!');

        NoofHallTicket := 0;

        AdmitCardHeaderCS1.Reset();
        AdmitCardHeaderCS1.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        AdmitCardHeaderCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            AdmitCardHeaderCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                AdmitCardHeaderCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        AdmitCardHeaderCS1.SETRANGE("Exam Schedule No.", ExamScheduleNo);
        IF AdmitCardHeaderCS1.FINDSET() THEN
            ERROR('Hall Ticket Entry Already Generated !!');


        ExternalAttendanceLineCS1.Reset();
        ExternalAttendanceLineCS1.SETCURRENTKEY("Student No.");
        ExternalAttendanceLineCS1.SETRANGE("Exam Schedule No.", ExamScheduleNo);
        ExternalAttendanceLineCS1.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        ExternalAttendanceLineCS1.SETRANGE("Attendance Not Applicable", FALSE);
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            ExternalAttendanceLineCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                ExternalAttendanceLineCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        ExternalAttendanceLineCS1.SETFILTER("Hall Ticket No.", '%1', '');
        ExternalAttendanceLineCS1.SETRANGE("Subject Class", 'THEORY');
        IF ExternalAttendanceLineCS1.FINDSET() THEN BEGIN
            TotalCount := ExternalAttendanceLineCS1.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                SubjectClassificationCS.Reset();
                SubjectClassificationCS.SETRANGE(Code, ExternalAttendanceLineCS1."Subject Class");
                SubjectClassificationCS.SETRANGE("Hall Ticket", TRUE);
                IF SubjectClassificationCS.FINDFIRST() THEN BEGIN
                    IF Studentno <> ExternalAttendanceLineCS1."Student No." THEN BEGIN
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETCURRENTKEY("No.");
                        StudentMasterCS.SETRANGE("No.", ExternalAttendanceLineCS1."Student No.");
                        StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3', StudentMasterCS."Student Status"::Student,
                                      StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            NoSeriesLine.Reset();
                            NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", AcademicsSetupCS."Hall Ticket Entry No.");
                            IF NoSeriesLine.FINDFIRST() THEN
                                IF NoSeriesLine."Last No. Used" <> '' THEN
                                    Docno := INCSTR(NoSeriesLine."Last No. Used")
                                ELSE
                                    Docno := INCSTR(NoSeriesLine."Starting No.");

                            NoofHallTicket := NoofHallTicket + 1;
                            AdmitCardHeaderCS.INIT();
                            AdmitCardHeaderCS."No." := Docno;
                            AdmitCardHeaderCS.VALIDATE("Student No.", StudentMasterCS."No.");
                            AdmitCardHeaderCS."Course Code" := StudentMasterCS."Course Code";
                            AdmitCardHeaderCS."Type Of Course" := StudentMasterCS."Type Of Course";
                            AdmitCardHeaderCS."Program" := StudentMasterCS.Graduation;
                            AdmitCardHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                            AdmitCardHeaderCS.Semester := StudentMasterCS.Semester;
                            AdmitCardHeaderCS.Year := StudentMasterCS.Year;
                            AdmitCardHeaderCS.Section := StudentMasterCS.Section;
                            AdmitCardHeaderCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                            AdmitCardHeaderCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                            AdmitCardHeaderCS."Receipt No." := '';
                            AdmitCardHeaderCS."Result Generated" := FALSE;
                            AdmitCardHeaderCS."Exam Schedule No." := ExternalAttendanceLineCS1."Exam Schedule No.";
                            AdmitCardHeaderCS."User ID" := COPYSTR(USERID(), 1, 20);
                            AdmitCardHeaderCS."Created By" := FORMAT(UserId());
                            AdmitCardHeaderCS."Created On" := TODAY();
                            AdmitCardHeaderCS.INSERT();

                            ExternalAttendanceLineCS.Reset();
                            ExternalAttendanceLineCS.SETCURRENTKEY("Student No.");
                            ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", ExamScheduleNo);
                            ExternalAttendanceLineCS.SETRANGE("Student No.", ExternalAttendanceLineCS1."Student No.");
                            ExternalAttendanceLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                            ExternalAttendanceLineCS.SETFILTER("Hall Ticket No.", '%1', '');
                            ExternalAttendanceLineCS.SETRANGE("Subject Class", 'THEORY');
                            IF ExternalAttendanceLineCS.FINDSET() THEN
                                REPEAT
                                    AdmitCardLineCS.Reset();
                                    AdmitCardLineCS.SETCURRENTKEY("Document No.");
                                    AdmitCardLineCS.SETRANGE("Document No.", Docno);
                                    IF AdmitCardLineCS.FINDLAST() THEN
                                        Lineno := AdmitCardLineCS."Line No." + 10000
                                    ELSE
                                        Lineno := 10000;

                                    AdmitCardLineCS.INIT();
                                    AdmitCardLineCS."Document No." := Docno;
                                    AdmitCardLineCS."Line No." := Lineno;
                                    AdmitCardLineCS.VALIDATE("Student No.", ExternalAttendanceLineCS."Student No.");
                                    AdmitCardLineCS.Course := ExternalAttendanceLineCS.Course;
                                    AdmitCardLineCS."Type Of Course" := ExternalAttendanceLineCS."Type Of Course";
                                    AdmitCardLineCS."Program" := ExternalAttendanceLineCS."Program";
                                    AdmitCardLineCS."Academic Year" := ExternalAttendanceLineCS."Academic Year";
                                    AdmitCardLineCS.Semester := ExternalAttendanceLineCS.Semester;
                                    AdmitCardLineCS.Year := ExternalAttendanceLineCS.Year;
                                    AdmitCardLineCS.Section := ExternalAttendanceLineCS.Section;
                                    AdmitCardLineCS."Global Dimension 1 Code" := ExternalAttendanceLineCS."Global Dimension 1 Code";
                                    AdmitCardLineCS."Global Dimension 2 Code" := ExternalAttendanceLineCS."Global Dimension 2 Code";
                                    AdmitCardLineCS."Subject Class" := ExternalAttendanceLineCS."Subject Class";
                                    AdmitCardLineCS.VALIDATE("Subject Type", ExternalAttendanceLineCS."Subject Type");
                                    AdmitCardLineCS.VALIDATE("Subject Code", ExternalAttendanceLineCS."Subject Code");
                                    AdmitCardLineCS."Apply Type" := ExternalAttendanceLineCS."Exam Type";
                                    AdmitCardLineCS."Time Slot" := ExternalAttendanceLineCS."Exam Slot";
                                    AdmitCardLineCS.Date := ExternalAttendanceLineCS."Exam Date";
                                    AdmitCardLineCS."Actual Per%" := ExternalAttendanceLineCS."Attendance %";
                                    AdmitCardLineCS."Applicable Per %" := ExternalAttendanceLineCS."Applicable Att Per%";
                                    AdmitCardLineCS.Detained := ExternalAttendanceLineCS.Detained;
                                    AdmitCardLineCS."Exam Schedule No." := ExternalAttendanceLineCS."Exam Schedule No.";
                                    ExternalAttendanceLineCS."Hall Ticket No." := Docno;
                                    ExternalAttendanceLineCS.Modify();
                                    AdmitCardLineCS.INSERT();
                                UNTIL ExternalAttendanceLineCS.NEXT() = 0;


                            NoSeriesLine.Reset();
                            NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", AcademicsSetupCS."Hall Ticket Entry No.");
                            ;
                            IF NoSeriesLine.FINDFIRST() THEN BEGIN
                                NoSeriesLine."Last No. Used" := Docno;
                                NoSeriesLine.Modify();
                            END;
                            Studentno := ExternalAttendanceLineCS1."Student No.";
                        END;
                    END;
                END;
            UNTIL ExternalAttendanceLineCS1.NEXT() = 0
        END ELSE
            ERROR('Student Ext. Exam Attn. Line Not Exist !!');
        PROGRESS.Close();
        MESSAGE('%1 Hall ticket generated..', NoofHallTicket);
        //Code added for Hall Ticket Geneartion ::CSPL-00092::28-05-2019: End
    end;

    procedure DocumentWiseHallTicketCreationCS(HallTicketEntryHeaderCOL: Record "Admit Card Header-CS")
    var
        SubjectClassificationCS: Record "Subject Classification-CS";

        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        Text0001Lbl: Label 'Do you want to Generate the Hall Ticket?';
        Lineno: Integer;
    begin
        //Code added for Hall Ticket Geneartion Document Wise ::CSPL-00092::28-05-2019: Start
        IF NOT CONFIRM(Text0001Lbl) THEN
            EXIT;

        WITH HallTicketEntryHeaderCOL DO BEGIN
            EducationSetupCS.Reset();
            EducationSetupCS.SETRANGE("Global Dimension 1 Code", HallTicketEntryHeaderCOL."Global Dimension 1 Code");
            IF NOT EducationSetupCS.FINDFIRST() THEN
                ERROR('Education Setup For Institute Code %1 Not Defined !!');


            AdmitCardHeaderCS.Reset();
            AdmitCardHeaderCS.SETRANGE("Academic Year", HallTicketEntryHeaderCOL."Academic Year");
            AdmitCardHeaderCS.SETRANGE("Global Dimension 1 Code", HallTicketEntryHeaderCOL."Global Dimension 1 Code");
            AdmitCardHeaderCS.SETRANGE("Exam Schedule No.", HallTicketEntryHeaderCOL."Exam Schedule No.");
            AdmitCardHeaderCS.SETRANGE("Student No.", AdmitCardHeaderCS."Student No.");
            IF AdmitCardHeaderCS.FINDSET() THEN
                ERROR('Hall Ticket Entry Already Generated !!');

            StudentMasterCS.Reset();
            StudentMasterCS.SETRANGE("No.", HallTicketEntryHeaderCOL."Student No.");
            StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                          StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
            IF StudentMasterCS.FINDFIRST() THEN BEGIN
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", HallTicketEntryHeaderCOL."Exam Schedule No.");
                ExternalAttendanceLineCS.SETRANGE("Student No.", HallTicketEntryHeaderCOL."Student No.");
                ExternalAttendanceLineCS.SETRANGE("Academic Year", HallTicketEntryHeaderCOL."Academic Year");
                ExternalAttendanceLineCS.SETFILTER("Hall Ticket No.", '%1', '');
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        SubjectClassificationCS.Reset();
                        SubjectClassificationCS.SETRANGE(Code, ExternalAttendanceLineCS."Subject Class");
                        SubjectClassificationCS.SETRANGE("Hall Ticket", TRUE);
                        IF SubjectClassificationCS.FINDFIRST() THEN BEGIN
                            AdmitCardLineCS.Reset();
                            AdmitCardLineCS.SETCURRENTKEY("Document No.");
                            AdmitCardLineCS.SETRANGE("Document No.", HallTicketEntryHeaderCOL."No.");
                            IF AdmitCardLineCS.FINDLAST() THEN
                                Lineno := AdmitCardLineCS."Line No." + 10000
                            ELSE
                                Lineno := 10000;

                            AdmitCardLineCS.INIT();
                            AdmitCardLineCS."Document No." := HallTicketEntryHeaderCOL."No.";
                            AdmitCardLineCS."Line No." := Lineno;
                            AdmitCardLineCS.VALIDATE("Student No.", ExternalAttendanceLineCS."Student No.");
                            AdmitCardLineCS.Course := ExternalAttendanceLineCS.Course;
                            AdmitCardLineCS."Type Of Course" := ExternalAttendanceLineCS."Type Of Course";
                            AdmitCardLineCS."Program" := ExternalAttendanceLineCS."Program";
                            AdmitCardLineCS."Academic Year" := ExternalAttendanceLineCS."Academic Year";
                            AdmitCardLineCS.Semester := ExternalAttendanceLineCS.Semester;
                            AdmitCardLineCS.Year := ExternalAttendanceLineCS.Year;
                            AdmitCardLineCS.Section := ExternalAttendanceLineCS.Section;
                            AdmitCardLineCS."Global Dimension 1 Code" := ExternalAttendanceLineCS."Global Dimension 1 Code";
                            AdmitCardLineCS."Global Dimension 2 Code" := ExternalAttendanceLineCS."Global Dimension 2 Code";
                            AdmitCardLineCS."Subject Class" := ExternalAttendanceLineCS."Subject Class";
                            AdmitCardLineCS.VALIDATE("Subject Type", ExternalAttendanceLineCS."Subject Type");
                            AdmitCardLineCS.VALIDATE("Subject Code", ExternalAttendanceLineCS."Subject Code");
                            AdmitCardLineCS."Apply Type" := ExternalAttendanceLineCS."Exam Type";
                            AdmitCardLineCS."Exam ClassiFication" := ExternalAttendanceLineCS."Exam Classification";
                            AdmitCardLineCS."Time Slot" := ExternalAttendanceLineCS."Exam Slot";
                            AdmitCardLineCS.Date := ExternalAttendanceLineCS."Exam Date";
                            AdmitCardLineCS."Actual Per%" := ExternalAttendanceLineCS."Attendance %";
                            AdmitCardLineCS."Applicable Per %" := ExternalAttendanceLineCS."Applicable Att Per%";
                            AdmitCardLineCS.Detained := ExternalAttendanceLineCS.Detained;
                            AdmitCardLineCS."Exam Schedule No." := ExternalAttendanceLineCS."Exam Schedule No.";
                            ExternalAttendanceLineCS."Hall Ticket No." := HallTicketEntryHeaderCOL."No.";
                            ExternalAttendanceLineCS.Modify();
                            AdmitCardLineCS.INSERT();
                        END;
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
            END;
        END;
        MESSAGE('Hall ticket generated');
        //Code added for Hall Ticket Geneartion Document Wise ::CSPL-00092::28-05-2019: End
    end;

    procedure BatchAllotmentWithoutRollNoCS(InstituteCode: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        EducationSetupCS: Record "Education Setup-CS";

        BatchCS: Record "Batch-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        "Text_1001Lbl": Label 'Education Setup for Institute Code %1  is Not Defined !!';
        NumberofBatchs: Integer;
        CountPerBatch: Integer;
        SectionCode: Code[10];
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING... #1  Out Of  @2 .', Comment = '%1 = XML node name ; %2 = Parent XML node name';
        I: Integer;
    begin
        //Code added for Automatic Batch Allotment Without Roll No ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR(Text_1001Lbl, InstituteCode);

        Counter := 0;
        TotalCount := 0;
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
        CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
        IF CourseWiseSubjectLineCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectLineCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                BatchCS.Reset();
                IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                    BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                IF BatchCS.FINDSET() THEN
                    NumberofBatchs := BatchCS.count();

                FacultyCourseWiseCS.Reset();
                FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                FacultyCourseWiseCS.SETRANGE("Course Code", '');
                IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                    FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                ELSE
                    FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                FacultyCourseWiseCS.SETRANGE(Batch, BatchCS.Code);
                FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                IF FacultyCourseWiseCS.FINDSET() THEN
                    REPEAT
                        IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
                            I := 0;
                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETCURRENTKEY("Re-Appear Result");
                            MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                            MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                            MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                            MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                            MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                            MainStudentSubjectCS.SETFILTER("Roll No.", '<>%1', '');
                            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                                CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '=');
                                REPEAT
                                    IF CourseWiseSubjectLineCS."Applicable Batch" = 'BATCH' THEN BEGIN
                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH');
                                        MainStudentSubjectCS.Modify();
                                    END ELSE BEGIN
                                        I += 1;
                                        IF I <= CountPerBatch THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                        ELSE
                                            IF (I > CountPerBatch) AND (I <= (2 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                            ELSE
                                                IF (I > (2 * CountPerBatch)) AND (I <= (3 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3')
                                                ELSE
                                                    IF (I > (3 * CountPerBatch)) AND (I <= (4 * CountPerBatch)) THEN
                                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-4');
                                        MainStudentSubjectCS.Modify();
                                    END;
                                UNTIL MainStudentSubjectCS.NEXT() = 0;
                            END;
                            SectionCode := FacultyCourseWiseCS."Section Code";
                        END;
                    UNTIL FacultyCourseWiseCS.NEXT() = 0;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
            PROGRESS.Close();
        END;

        Counter := 0;
        TotalCount := 0;
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
        IF CourseWiseSubjectLineCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectLineCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                BatchCS.Reset();
                IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                    BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                IF BatchCS.FINDSET() THEN
                    NumberofBatchs := BatchCS.count();


                FacultyCourseWiseCS.Reset();
                FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
                    FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                    FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                ELSE
                    FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                IF FacultyCourseWiseCS.FINDSET() THEN
                    REPEAT
                        I := 0;
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETCURRENTKEY("Re-Appear Result");
                        MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                        MainStudentSubjectCS.SETRANGE(Course, CourseWiseSubjectLineCS."Course Code");
                        MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                        MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                        MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                        MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                        MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                        MainStudentSubjectCS.SETFILTER("Roll No.", '<>%1', '');
                        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                            CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '>');
                            REPEAT
                                IF CourseWiseSubjectLineCS."Applicable Batch" = 'BATCH' THEN BEGIN
                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH');
                                    MainStudentSubjectCS.Modify();
                                END ELSE BEGIN
                                    I += 1;
                                    IF I <= CountPerBatch THEN
                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                    ELSE
                                        IF (I > CountPerBatch) AND (I <= (2 * CountPerBatch)) THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                        ELSE
                                            IF (I > (2 * CountPerBatch)) AND (I <= (3 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3')
                                            ELSE
                                                IF (I > (3 * CountPerBatch)) AND (I <= (4 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-4');
                                    MainStudentSubjectCS.Modify();
                                END;
                            UNTIL MainStudentSubjectCS.NEXT() = 0;
                        END;
                    UNTIL FacultyCourseWiseCS.NEXT() = 0;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
            PROGRESS.Close();
        END;


        Counter := 0;
        TotalCount := 0;
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'LAB');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
        IF CourseWiseSubjectLineCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectLineCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                BatchCS.Reset();
                IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
                    BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
                BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                IF BatchCS.FINDSET() THEN
                    NumberofBatchs := BatchCS.count();
                FacultyCourseWiseCS.Reset();
                FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
                IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
                    FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
                    FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
                ELSE
                    FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
                FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                IF FacultyCourseWiseCS.FINDSET() THEN
                    REPEAT
                        I := 0;
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETCURRENTKEY("Re-Appear Result");
                        MainStudentSubjectCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                        MainStudentSubjectCS.SETRANGE(Course, CourseWiseSubjectLineCS."Course Code");
                        MainStudentSubjectCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                        MainStudentSubjectCS.SETRANGE(Section, FacultyCourseWiseCS."Section Code");
                        MainStudentSubjectCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
                        MainStudentSubjectCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        MainStudentSubjectCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
                        MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                        MainStudentSubjectCS.SETFILTER("Roll No.", '<>%1', '');
                        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                            CountPerBatch := ROUND(MainStudentSubjectCS.COUNT() / NumberofBatchs, 1, '>');
                            REPEAT
                                IF CourseWiseSubjectLineCS."Applicable Batch" = 'BATCH' THEN BEGIN
                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH');
                                    MainStudentSubjectCS.Modify();
                                END ELSE BEGIN
                                    I += 1;
                                    IF I <= CountPerBatch THEN
                                        MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-1')
                                    ELSE
                                        IF (I > CountPerBatch) AND (I <= (2 * CountPerBatch)) THEN
                                            MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-2')
                                        ELSE
                                            IF (I > (2 * CountPerBatch)) AND (I <= (3 * CountPerBatch)) THEN
                                                MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-3')
                                            ELSE
                                                IF (I > (3 * CountPerBatch)) AND (I <= (4 * CountPerBatch)) THEN
                                                    MainStudentSubjectCS.VALIDATE(Batch, 'BATCH-4');
                                    MainStudentSubjectCS.Modify();
                                END;
                            UNTIL MainStudentSubjectCS.NEXT() = 0;
                        END;
                    UNTIL FacultyCourseWiseCS.NEXT() = 0;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
            PROGRESS.Close();
        END;

        MESSAGE('Done');
        //Code added for Automatic Batch Allotment Without Roll No ::CSPL-00092::28-05-2019: End
    end;

    procedure CalculateAttendanceForExamWithAddCreditCS()
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
    begin
        //Code added for Calculate Attendance For Exam With Add Credit ::CSPL-00092::28-05-2019: Start
        EducationSetupCS.Reset();
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            END;
        END ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII');
                IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                END;
            END;
        //Code added for Calculate Attendance For Exam With Add Credit ::CSPL-00092::28-05-2019: End
    end;
}

