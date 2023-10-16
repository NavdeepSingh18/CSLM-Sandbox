report 50043 "Rank Generation-CollegeCS"
{
    // version V.001-CS

    Caption = 'Rank Generation - College';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("Course Code", Semester, "Academic Year")
                                WHERE("Student Status" = FILTER('Student'));
            dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section);

                trigger OnAfterGetRecord()
                begin
                    TotalMarksScored := TotalMarksScored + Total;
                    SetAttendancePer := SetAttendancePer + "Attendance Percentage";

                    AcademicsSetupCS.GET();
                    AcademicsSetupCS.TESTFIELD("Common Subject Type");
                    ExternalExamHeaderCS.Reset();
                    ExternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                    IF "Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                        ExternalExamHeaderCS.SETRANGE(Semester, GetSemester);
                        ExternalExamHeaderCS.SETRANGE(Section, GetSection);
                    END;
                    ExternalExamHeaderCS.SETRANGE("Academic Year", GetAcademicYear);
                    ExternalExamHeaderCS.SETRANGE("Subject Type", "Subject Type");
                    ExternalExamHeaderCS.SETRANGE("Subject Code", "Subject Code");
                    ExternalExamHeaderCS.SETRANGE("External Generated", TRUE);
                    IF ExternalExamHeaderCS.findfirst() THEN
                        TotalMarksConducted += ExternalExamHeaderCS."Total Maximum";
                    TotalPoints += Points;

                    TotalSubjects := TotalSubjects + 1;
                    IF Result = Result::Fail THEN
                        TotalSubjectsFailed += 1;
                end;

                trigger OnPostDataItem()
                begin
                    StudentHeaderMarksCS.Reset();
                    StudentHeaderMarksCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                    StudentHeaderMarksCS.SETRANGE(Course, GetCourse);
                    StudentHeaderMarksCS.SETRANGE(Semester, GetSemester);
                    StudentHeaderMarksCS.SETRANGE("Academic Year", GetAcademicYear);
                    StudentHeaderMarksCS.SETRANGE(Section, GetSection);
                    IF StudentHeaderMarksCS.findfirst() THEN BEGIN
                        StudentHeaderMarksCS."Total Marks Scored" := TotalMarksScored;
                        StudentHeaderMarksCS."Total Marks Conducted" := TotalMarksConducted;
                        IF (TotalMarksScored <> 0) AND (TotalSubjects <> 0) THEN
                            StudentHeaderMarksCS.Average := TotalMarksScored / TotalSubjects;
                        IF (SetAttendancePer <> 0) AND (TotalSubjects <> 0) THEN
                            StudentHeaderMarksCS."Average Attendance %" := SetAttendancePer / TotalSubjects;
                        IF (TotalMarksScored <> 0) AND (TotalMarksConducted <> 0) THEN
                            StudentHeaderMarksCS."Percentage Scored" := (TotalMarksScored / TotalMarksConducted) * 100;
                        StudentHeaderMarksCS."Total No of Subject Failed" := TotalSubjectsFailed;
                        IF TotalSubjectsFailed > 0 THEN
                            StudentHeaderMarksCS.Result := StudentHeaderMarksCS.Result::Fail
                        ELSE
                            StudentHeaderMarksCS.Result := StudentHeaderMarksCS.Result::Pass;
                        IF (TotalPoints <> 0) AND (TotalSubjects <> 0) THEN
                            StudentHeaderMarksCS."GPA Points" := ROUND(TotalPoints / TotalSubjects, 1, '=');
                        StudentMasterCS1.GET(StudentHeaderMarksCS."Student No.");
                        StudentMasterCS1."Latest GPA" := StudentHeaderMarksCS."GPA Points";
                        GradeCourseCS.SETRANGE(Course, GetCourse);
                        IF GradeCourseCS.findset() THEN
                            GradeCourseCS.SETCURRENTKEY(Points);
                        GradeCourseCS.SETRANGE(Points, StudentHeaderMarksCS."GPA Points");
                        IF GradeCourseCS.findfirst() THEN BEGIN
                            StudentHeaderMarksCS."GPA Grade" := GradeCourseCS.Code;
                            StudentMasterCS1."Latest Grade" := StudentHeaderMarksCS."GPA Grade";
                        END ELSE
                            StudentHeaderMarksCS."GPA Grade" := '';
                        StudentMasterCS1.Modify();
                        StudentHeaderMarksCS.Modify();
                    END ELSE BEGIN
                        StudentHeaderMarksCS.init();
                        StudentHeaderMarksCS."Student No." := "Student No.";
                        StudentHeaderMarksCS.Course := GetCourse;
                        StudentHeaderMarksCS.Semester := GetSemester;
                        StudentHeaderMarksCS."Academic Year" := GetAcademicYear;
                        StudentHeaderMarksCS.Name := "Student Name";
                        StudentHeaderMarksCS.Section := GetSection;
                        StudentHeaderMarksCS."Total Marks Scored" := TotalMarksScored;
                        StudentHeaderMarksCS."Total Marks Conducted" := TotalMarksConducted;
                        IF (TotalMarksScored <> 0) AND (TotalSubjects <> 0) THEN
                            StudentHeaderMarksCS.Average := TotalMarksScored / TotalSubjects;
                        IF (SetAttendancePer <> 0) AND (TotalSubjects <> 0) THEN
                            StudentHeaderMarksCS."Average Attendance %" := SetAttendancePer / TotalSubjects;
                        IF (TotalMarksScored <> 0) AND (TotalMarksConducted <> 0) THEN
                            StudentHeaderMarksCS."Percentage Scored" := (TotalMarksScored / TotalMarksConducted) * 100;
                        StudentHeaderMarksCS."Total No of Subject Failed" := TotalSubjectsFailed;

                        IF TotalSubjectsFailed > 0 THEN
                            StudentHeaderMarksCS.Result := StudentHeaderMarksCS.Result::Fail
                        ELSE
                            StudentHeaderMarksCS.Result := StudentHeaderMarksCS.Result::Pass;

                        IF (TotalPoints <> 0) AND (TotalSubjects <> 0) THEN
                            StudentHeaderMarksCS."GPA Points" := ROUND(TotalPoints / TotalSubjects, 1, '=');
                        StudentMasterCS1.GET(StudentHeaderMarksCS."Student No.");
                        StudentMasterCS1."Latest GPA" := StudentHeaderMarksCS."GPA Points";
                        GradeCourseCS.SETRANGE(Course, GetCourse);
                        IF GradeCourseCS.findset() THEN
                            GradeCourseCS.SETCURRENTKEY(Points);
                        GradeCourseCS.SETRANGE(Points, StudentHeaderMarksCS."GPA Points");
                        IF GradeCourseCS.findfirst() THEN BEGIN
                            StudentHeaderMarksCS."GPA Grade" := GradeCourseCS.Code;
                            StudentMasterCS1."Latest Grade" := StudentHeaderMarksCS."GPA Grade";
                        END ELSE
                            StudentHeaderMarksCS."GPA Grade" := '';
                        StudentMasterCS1.Modify();
                        StudentHeaderMarksCS.Insert();
                    END;

                    StudentRankCS.init();
                    StudentRankCS."No." := "Student No.";
                    IF (TotalMarksScored <> 0) AND (TotalMarksConducted <> 0) THEN
                        StudentRankCS.Average := (TotalMarksScored / TotalMarksConducted) * 100;
                    StudentRankCS.Insert();
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Course, GetCourse);
                    SETRANGE(Semester, GetSemester);
                    SETRANGE("Academic Year", GetAcademicYear);
                    SETRANGE(Section, GetSection);

                    CLEAR(TotalMarksScored);
                    CLEAR(TotalMarksConducted);
                    CLEAR(TotalSubjects);
                    CLEAR(TotalSubjectsFailed);
                    CLEAR(SetAttendancePer);
                    CLEAR(TotalPoints);

                    StudentHeaderMarksCS.Reset();
                    StudentHeaderMarksCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                    StudentHeaderMarksCS.SETRANGE(Course, GetCourse);
                    StudentHeaderMarksCS.SETRANGE(Semester, GetSemester);
                    StudentHeaderMarksCS.SETRANGE("Academic Year", GetAcademicYear);
                    StudentHeaderMarksCS.SETRANGE(Section, GetSection);
                    IF StudentHeaderMarksCS.findfirst() THEN BEGIN
                        StudentHeaderMarksCS."Total Marks Scored" := 0;
                        StudentHeaderMarksCS."Total Marks Conducted" := 0;
                        StudentHeaderMarksCS.Average := 0;
                        StudentHeaderMarksCS."Percentage Scored" := 0;
                        StudentHeaderMarksCS.Rank := 0;
                        StudentHeaderMarksCS."GPA Grade" := '';
                        StudentHeaderMarksCS."Total No of Subject Failed" := 0;
                        StudentHeaderMarksCS.Result := 0;
                    END;
                end;
            }

            trigger OnPreDataItem()
            begin
                SETCURRENTKEY("Course Code", Semester, "Academic Year");
                SETRANGE("Course Code", GetCourse);
                SETRANGE(Semester, GetSemester);
                SETRANGE("Academic Year", GetAcademicYear);
                SETRANGE(Section, GetSection);

                AcademicsSetupCS.GET();
                AcademicsSetupCS.TESTFIELD("Common Subject Type");
                AcademicsSetupCS.TESTFIELD("CBCS Batch");

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, Section, "Academic Year");
                MainStudentSubjectCS.SETRANGE(Course, GetCourse);
                MainStudentSubjectCS.SETRANGE(Semester, GetSemester);
                MainStudentSubjectCS.SETRANGE(Section, GetSection);
                MainStudentSubjectCS.SETRANGE("Academic Year", GetAcademicYear);
                IF MainStudentSubjectCS.ISEMPTY() then
                    ERROR(Text002Lbl);
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        StudentMasterCS.GET(MainStudentSubjectCS."Student No.");
                        IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Student THEN BEGIN
                            ExternalExamHeaderCS.Reset();
                            ExternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                            ExternalExamHeaderCS.SETRANGE("Course Code", GetCourse);
                            IF MainStudentSubjectCS."Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                                ExternalExamHeaderCS.SETRANGE(Semester, GetSemester);
                                ExternalExamHeaderCS.SETRANGE(Section, GetSection);
                            END;
                            ExternalExamHeaderCS.SETRANGE("Academic Year", GetAcademicYear);
                            ExternalExamHeaderCS.SETRANGE("Subject Type", MainStudentSubjectCS."Subject Type");
                            ExternalExamHeaderCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
                            ExternalExamHeaderCS.SETRANGE("External Generated", TRUE);
                            IF ExternalExamHeaderCS.ISEMPTY() then
                                IF MainStudentSubjectCS."Subject Type" = AcademicsSetupCS."Common Subject Type" THEN
                                    ERROR(Text003Lbl, GetCourse, GetSemester, MainStudentSubjectCS."Subject Code")
                                ELSE
                                    ERROR(Text004Lbl, MainStudentSubjectCS."Subject Type", MainStudentSubjectCS."Subject Code");

                        END;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;
                StudentRankCS.Reset();
                StudentRankCS.LockTable();
                StudentRankCS.deleteall();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Course"; GetCourse)
                {
                    Caption = 'Course';
                    TableRelation = "Course Master-CS".Code;
                    ToolTip = 'Course may have a value';
                    ApplicationArea = All;
                }
                field("Semester"; GetSemester)
                {
                    Caption = 'Semester';
                    TableRelation = "Semester Master-CS".Code;
                    ToolTip = 'Semester may have a value';
                    ApplicationArea = All;
                }
                field("Section"; GetSection)
                {
                    Caption = 'Section';
                    TableRelation = "Section Master-CS".Code;
                    ToolTip = 'Section may have a value';
                    ApplicationArea = All;
                }
                field("Academic Year"; GetAcademicYear)
                {
                    Caption = 'AcademicYear';
                    TableRelation = "Academic Year Master-CS".Code;
                    ToolTip = 'Academic Year may have a value';
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        StudentRankCS.Reset();
        IF StudentRankCS.findfirst() THEN
            StartNo := StudentRankCS."Entry No.";

        StudentRankCS.Reset();
        IF StudentRankCS.Findlast() THEN
            EndNo := StudentRankCS."Entry No.";

        VerticalEducationCS.RankCreation(StartNo, EndNo);

        StudentRankCS.Reset();
        IF StudentRankCS.findset() THEN
            REPEAT
                StudentHeaderMarksCS.Reset();
                StudentHeaderMarksCS.SETRANGE("Student No.", StudentRankCS."No.");
                StudentHeaderMarksCS.SETRANGE(Course, GetCourse);
                StudentHeaderMarksCS.SETRANGE(Semester, GetSemester);
                StudentHeaderMarksCS.SETRANGE("Academic Year", GetAcademicYear);
                StudentHeaderMarksCS.SETRANGE(Section, GetSection);
                IF StudentHeaderMarksCS.findfirst() THEN BEGIN
                    StudentHeaderMarksCS.Rank := StudentRankCS.Rank;
                    StudentMasterCS1.GET(StudentHeaderMarksCS."Student No.");
                    StudentMasterCS1."Latest Rank" := StudentHeaderMarksCS.Rank;
                    StudentMasterCS1.Modify();
                    StudentHeaderMarksCS.Modify();
                END;
            UNTIL StudentRankCS.NEXT() = 0;

        StudentRankCS.Reset();
        StudentRankCS.deleteall();
        MESSAGE(Text001Lbl);
    end;

    trigger OnPreReport()
    begin
        IF (GetCourse = '') OR (GetSemester = '') OR (GetAcademicYear = '') THEN
            ERROR(Text000Lbl);
    end;

    var
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        StudentHeaderMarksCS: Record "Student Header Marks-CS";
        StudentRankCS: Record "Student Rank-CS";
        GradeCourseCS: Record "Grade Course-CS";
        StudentMasterCS1: Record "Student Master-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

        GetCourse: Code[20];
        GetSemester: Code[10];
        GetSection: Code[10];
        GetAcademicYear: Code[10];

        TotalMarksScored: Decimal;
        TotalMarksConducted: Decimal;
        TotalSubjects: Integer;
        TotalSubjectsFailed: Integer;

        StartNo: Code[20];
        EndNo: Code[20];
        SetAttendancePer: Decimal;
        TotalPoints: Decimal;

        Text000Lbl: Label 'Please Select Course,Semester & Academic Year';
        Text001Lbl: Label 'Rank Generation Completed';
        Text002Lbl: Label 'Student Subjects is not Created';
        Text003Lbl: Label 'External Exam for Course %1. Semester %2 & Subject %3 is not generated''', Comment = '%1 = Course,%2 = Semester,%3 = Subject';
        Text004Lbl: Label 'External Exam for Subject Type %1, Subject %2 is not generated''', Comment = '%1 = Subject Type,%2 = Subject';
}

