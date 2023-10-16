codeunit 50020 "Academics Stage-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   15/02/2019     StudentSubjectsDetails()-Function       Code added for insert data main student subject table.
    // 02    CSPL-00059   15/02/2019     CopyGradesCreate()-Function             Code added for create grades.
    // 03    CSPL-00059   15/02/2019     GetDataCBCSBatch()-Function             Code added for Get Session.
    // 04    CSPL-00059   15/02/2019     FinalYear_SemEval()-Function            Code added for get %.
    // 05    CSPL-00059   15/02/2019     UpdateStudentwiseCPGA()-Function        Code added for student CPGA.
    // 06    CSPL-00059   15/02/2019     MainStudentSubjectsYR()-Function        Code added for insert data main student subject year wise .


    trigger OnRun()
    begin
    end;

    var

        Text000Lbl: Label 'Student Subject Updated';
        Text001Lbl: Label 'Course Grade Updated';


        Text007Lbl: Label 'Do you want to update these subjects to all the Students ?';
        Text008Lbl: Label 'Grades Already Assigned. Do you want to reasssign ?';

    procedure StudentSubjectsDetails(getProgrm: Code[20]; getSemester: Code[10]; getSession: Code[20])
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
    begin
        //Code added for insert data main student subject table::CSPL-00059::15022019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");
        IF CONFIRM(Text007Lbl, TRUE) THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETCURRENTKEY("Course Code", Semester, "Academic Year");
            StudentMasterCS.SETRANGE("Course Code", getProgrm);
            StudentMasterCS.SETRANGE(Semester, getSemester);
            StudentMasterCS.SETRANGE("Academic Year", getSession);
            IF StudentMasterCS.FINDSET() THEN
                REPEAT
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", getProgrm);
                    CourseWiseSubjectLineCS.SETRANGE(Semester, getSemester);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", getSession);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", 'MAJOR');
                    IF CourseWiseSubjectLineCS.FINDSET() THEN
                        REPEAT
                            IF NOT
                               (MainStudentSubjectCS.GET(
                                StudentMasterCS."No.", getProgrm, getSemester, getSession, CourseWiseSubjectLineCS."Subject Code", StudentMasterCS.Section))
                            THEN BEGIN
                                MainStudentSubjectCS.INIT();
                                MainStudentSubjectCS."Student No." := StudentMasterCS."No.";
                                MainStudentSubjectCS."Student Name" := StudentMasterCS."Student Name";
                                MainStudentSubjectCS.Course := StudentMasterCS."Course Code";
                                MainStudentSubjectCS.Semester := getSemester;
                                MainStudentSubjectCS.Section := StudentMasterCS.Section;
                                MainStudentSubjectCS."Academic Year" := getSession;
                                MainStudentSubjectCS."Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                                MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                                MainStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                                MainStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                                MainStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                                MainStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                                MainStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                                MainStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                MainStudentSubjectCS.INSERT();
                            END;
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                UNTIL StudentMasterCS.NEXT() = 0;
            MESSAGE(Text000Lbl);
        END;
        //Code added for insert data main student subject table::CSPL-00059::15022019: End
    end;

    procedure CopyGradesCreate()
    var
        GradeMasterCS: Record "Grade Master-CS";
        GradeMasterCS1: Record "Grade Master-CS";
        GradeCourseCS: Record "Grade Course-CS";
        CourseMasterCS: Record "Course Master-CS";
    begin
        //Code added for create grades::CSPL-00059::15022019: Start
        GradeMasterCS1.Reset();
        IF GradeMasterCS1.FINDFIRST() THEN BEGIN
            GradeCourseCS.Reset();
            IF GradeCourseCS.FINDFIRST() THEN
                IF CONFIRM(Text008Lbl, TRUE) THEN BEGIN
                    GradeCourseCS.Reset();
                    GradeCourseCS.DELETEALL();
                    CourseMasterCS.Reset();
                    IF CourseMasterCS.FINDSET() THEN
                        REPEAT
                            GradeMasterCS.Reset();
                            IF GradeMasterCS.FINDSET() THEN
                                REPEAT
                                    GradeCourseCS.INIT();
                                    GradeCourseCS.TRANSFERFIELDS(GradeMasterCS);
                                    GradeCourseCS.Course := CourseMasterCS.Code;
                                    GradeCourseCS.INSERT();
                                UNTIL GradeMasterCS.NEXT() = 0;
                        UNTIL CourseMasterCS.NEXT() = 0;
                    MESSAGE(Text001Lbl);
                END;
        END;
        //Code added for create grades::CSPL-00059::15022019: End
    end;

    procedure GetDataCBCSBatch(): Code[20]
    var
        AcademicsSetupCS: Record "Academics Setup-CS";
    begin
        //Code added for get session::CSPL-00059::15022019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("CBCS Batch");
        EXIT(AcademicsSetupCS."CBCS Batch")
        //Code added for get session::CSPL-00059::15022019: Start
    end;

    procedure FinalYear_SemEval()
    var
        CourseMasterCS: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        DecPercentage: Decimal;
        DecMarkObtained: Decimal;
        DecMarkMax: Decimal;

    begin
        //Code added for get %::CSPL-00059::15022019: Start
        CourseMasterCS.Reset();
        IF CourseMasterCS.FINDSET() THEN
            REPEAT
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("Course Code", CourseMasterCS.Code);
                StudentMasterCS.SETRANGE(Semester, CourseMasterCS."Final Semester Code");
                IF StudentMasterCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS.CALCFIELDS("Total Credits");
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                        MainStudentSubjectCS.SETRANGE(Result, MainStudentSubjectCS.Result::Fail);
                        IF NOT MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                            MainStudentSubjectCS.Reset();
                            MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                            IF MainStudentSubjectCS.FINDSET() THEN
                                REPEAT
                                    DecMarkObtained += MainStudentSubjectCS.Total;
                                    CourseWiseSubjectLineCS.Reset();
                                    CourseWiseSubjectLineCS.SETRANGE("Course Code", MainStudentSubjectCS.Course);
                                    CourseWiseSubjectLineCS.SETRANGE(Semester, MainStudentSubjectCS.Semester);
                                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", MainStudentSubjectCS."Academic Year");
                                    CourseWiseSubjectLineCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                                    IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                                        DecMarkMax += CourseWiseSubjectLineCS."Total Maximum";
                                UNTIL MainStudentSubjectCS.NEXT() = 0;
                        END;
                        IF StudentMasterCS."Total Credits" >= CourseMasterCS."Total Credit" THEN;
                        DecPercentage := (DecMarkObtained / DecMarkMax) * 100;
                    UNTIL StudentMasterCS.NEXT() = 0;
            UNTIL CourseMasterCS.NEXT() = 0;
        //Code added for get %::CSPL-00059::15022019: End
    end;

    procedure UpdateStudentwiseCPGA(StudentMasterCS: Record "Student Master-CS")
    var
        GradeCourseCS: Record "Grade Course-CS";
        Point: Decimal;
    begin
        //Code added for student CPGA::CSPL-00059::15022019: Start
        GradeCourseCS.Reset();
        GradeCourseCS.SETCURRENTKEY(Points);
        GradeCourseCS.SETRANGE(Course, StudentMasterCS."Course Code");
        StudentMasterCS.CALCFIELDS(CGPA);
        Point := ROUND(StudentMasterCS.CGPA, 1, '=');
        GradeCourseCS.SETRANGE(Points, Point);
        REPEAT
            IF GradeCourseCS.Course <> '' THEN BEGIN
                StudentMasterCS."CGPA Grade" := GradeCourseCS.Code;
                StudentMasterCS.Modify();
            END;
        UNTIL GradeCourseCS.NEXT() = 0;
        //Code added for student CPGA::CSPL-00059::15022019: End
    end;

    procedure MainStudentSubjectsYR(getProgrm: Code[20]; ForYr: Code[20]; getSession: Code[20])
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";

        AcademicsSetupCS: Record "Academics Setup-CS";
    begin
        //Code added for insert data main student subject year wise ::CSPL-00059::15022019: Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");
        IF CONFIRM(Text007Lbl, TRUE) THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETCURRENTKEY("Course Code", Year, "Academic Year");
            StudentMasterCS.SETRANGE("Course Code", getProgrm);
            StudentMasterCS.SETRANGE(Year, ForYr);
            StudentMasterCS.SETRANGE("Academic Year", getSession);
            IF StudentMasterCS.FINDSET() THEN
                REPEAT
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", getProgrm);
                    CourseWiseSubjectLineCS.SETRANGE(Year, ForYr);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", getSession);
                    CourseWiseSubjectLineCS.SETRANGE("Subject Type", 'MAJOR');
                    IF CourseWiseSubjectLineCS.FINDSET() THEN
                        REPEAT
                            IF NOT
                               (MainStudentSubjectCS.GET(
                                StudentMasterCS."No.", getProgrm, ForYr, getSession, CourseWiseSubjectLineCS."Subject Code", StudentMasterCS.Section))
                            THEN BEGIN
                                MainStudentSubjectCS.INIT();
                                MainStudentSubjectCS."Student No." := StudentMasterCS."No.";
                                MainStudentSubjectCS."Student Name" := StudentMasterCS."Student Name";
                                MainStudentSubjectCS.Course := StudentMasterCS."Course Code";
                                MainStudentSubjectCS.Year := ForYr;
                                MainStudentSubjectCS.Section := StudentMasterCS.Section;
                                MainStudentSubjectCS."Academic Year" := getSession;
                                MainStudentSubjectCS."Subject Code" := CourseWiseSubjectLineCS."Subject Code";
                                MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                                MainStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                                MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                                MainStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                                MainStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                                MainStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                                MainStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                                MainStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                                MainStudentSubjectCS.INSERT();
                            END;
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                UNTIL StudentMasterCS.NEXT() = 0;
            MESSAGE(Text000Lbl);
        END;
        //Code added for insert data main student subject year wise ::CSPL-00059::15022019: End
    end;
}

