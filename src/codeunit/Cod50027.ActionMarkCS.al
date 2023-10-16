codeunit 50027 "Action Mark -CS"
{
    // version V.001-CS

    // -----------------------------------------------------------------------------------------------
    // Sr. No.   Emp Id        Date    Trigger                        Remark
    // 1         CSPL-00067    20-02-19GetStudentsForInternalsCS      Code Added for Get Students For Internals
    // 2         CSPL-00067    20-02-19StudentsCommonSubjectsCS      Code Added for Students Common Subjects
    // 3         CSPL-00067    20-02-19StudentsOptionalSubjectsCS    Code Added for Students Optional Subjects
    // 4         CSPL-00067    20-02-19StudentInternalMarksCS        Code Added for Student Internal Marks
    // 5         CSPL-00067    20-02-19UpdateStudentMarksCS          Code Added for Update Student Marks
    // 6         CSPL-00067    20-02-19SetAttendanceMarkCS            Code Added for Set Attendance Mark
    // 7         CSPL-00067    20-02-19getStudentsforExternalCS      Code Added for get Students for External
    // 8         CSPL-00067    20-02-19UpdateInternalMarksCS          Code Added for Update Internal Marks
    // 9         CSPL-00067    20-02-19GenerateResultCS              Code Added for Generate Result
    // 10       CSPL-00067    20-02-19getGroupCodeCS                Code Added for get Group Code
    // 11       CSPL-00067    20-02-19Calculate GroupsCS            Code Added for Calculate Groups
    // 12       CSPL-00067    20-02-19Calculate AverageCS            Code Added for Calculate Average
    // 13       CSPL-00067    20-02-19GetExamMethodCS                Code Added for Get Exam Method
    // 14       CSPL-00067    20-02-19GetDocumentNoCS                 Code Added for Get Document No.
    // 15       CSPL-00067    20-02-19GetStudentsforRevaluationCS     Code Added for Get Students for Revaluation
    // 16       CSPL-00067    20-02-19CheckRevaluationCS             Code Added for Check Revaluation
    // 17       CSPL-00067    20-02-19UpdateRevMarkCS                 Code Added for Update Rev Mark
    // 18       CSPL-00067    20-02-19PostRevaluationFeeCS           Code Added for Post Revaluation Fee
    // 19       CSPL-00067    20-02-19UpdateInternalRankCS           Code Added for Update Internal Rank
    // 20       CSPL-00067    20-02-19PublishStudentsInternalMarksCS Code Added for Publish Students Internal Marks
    // 21       CSPL-00067    20-02-19PublishStudentsAssignmentMarksCS Code Added for Publish Students Assignment Marks
    // 22       CSPL-00067    20-02-19GetStudentsCS                   Code Added for Get Students
    // 


    trigger OnRun()
    begin
    end;

    var
        CourseMasterCS: Record "Course Master-CS";
        Text000Lbl: Label 'Course Subject Exam Group is not set for the subjcet %1';

        Text002Lbl: Label '%1 Internal Marks is not entered for Students';
        Text003Lbl: Label 'Internal Marks is not Generatod for Subject %1 and Exam Group %2';
        Text004Lbl: Label 'Attendance Percentage is not calculated';

        Text006Lbl: Label 'Please enter the Maximum Mark for the Code %2 for Group %1';
        Text007Lbl: Label ' Please generate Internal Marks before generating External';
        Text008Lbl: Label 'Please enter the Attendance mark in Attendance Percentage Setup';
        Text009Lbl: Label 'Attendance % Setup is not completed';
        Text010Lbl: Label 'No External Mark header for this Course and subject';
        Text011Lbl: Label 'No Revaluation requests';
        Text012Lbl: Label 'Process Completed';

        Text014Lbl: Label 'Do you want to delete the students & update';
        Text015Lbl: Label 'Do you want to delete the exam method & update';
        Text016Lbl: Label 'Do you want to delete the students & update';



    procedure GetStudentsForInternalsCS(InternalExamHeaderCS: Record "Internal Exam Header-CS")
    var
        AcademicsSetupCS: Record "Academics Setup-CS";
    //  InternalExamHeaderCS1: Record "Internal Exam Header-CS";
    begin
        //Code added for GetStudents For Internals::CSPL-00067::200219:Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");

        InternalExamHeaderCS.TESTFIELD("No.");
        InternalExamHeaderCS.TESTFIELD("Subject Type");
        IF InternalExamHeaderCS."Subject Type" = AcademicsSetupCS."Common Subject Type" THEN
            InternalExamHeaderCS.TESTFIELD(Semester);
        InternalExamHeaderCS.TESTFIELD("Subject Class");
        InternalExamHeaderCS.TESTFIELD("Subject Code");
        InternalExamHeaderCS.TESTFIELD("Global Dimension 1 Code");
        InternalExamHeaderCS.TESTFIELD("Exam Group");
        InternalExamHeaderCS.TESTFIELD("Academic Year");
        InternalExamHeaderCS.TESTFIELD("Exam Type");
        StudentsCommonSubjectsCS(InternalExamHeaderCS."No.", InternalExamHeaderCS."Course Code", InternalExamHeaderCS.Semester,
            InternalExamHeaderCS."Academic Year", InternalExamHeaderCS."Subject Type", InternalExamHeaderCS."Subject Code",
            InternalExamHeaderCS.Section, InternalExamHeaderCS."Exam Method Code", InternalExamHeaderCS."Exam Group", InternalExamHeaderCS.Year,
            InternalExamHeaderCS."Global Dimension 1 Code", InternalExamHeaderCS."Global Dimension 2 Code", InternalExamHeaderCS,
            InternalExamHeaderCS."Maximum Weightage", InternalExamHeaderCS."Maximum Mark");
        //Code added for Get Students For Internals::CSPL-00067::200219:END
    end;

    procedure StudentsCommonSubjectsCS("getDocumentNo.": Code[20]; getCourse: Code[20]; getSemester: Code[10]; getAcademicYear: Code[20]; getSubjectType: Code[20]; getSubjectCode: Code[20]; getSection: Code[10]; getExamMethodCode: Code[20]; getExamGroup: Code[20]; getYear: Code[20]; GetGlobalDim1: Code[20]; GetGlobalDim2: Code[20]; InternalExamHeaderCS: Record "Internal Exam Header-CS"; GetWeightage: Decimal; GetMaximumMarks: Decimal)
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        EducationSetupCS: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        //InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
        // ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        "LocLineNo.": Integer;

    // AssignmentMarks: Decimal;

    begin
        //Code Added for Students Common Subjects::CSPL-00067::200219:Start
        "LocLineNo." := 0;
        InternalExamLineCS.Reset();
        InternalExamLineCS.SETRANGE("Document No.", "getDocumentNo.");
        IF InternalExamLineCS.FINDFIRST() THEN
            EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", GetGlobalDim1);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year");


        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");

        SubjectMasterCS.Reset();
        SubjectMasterCS.SETRANGE(Code, getSubjectCode);
        IF SubjectMasterCS.FINDFIRST() THEN
            IF InternalExamHeaderCS."Subject Type" = 'CORE' THEN BEGIN
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Type", "Subject Code");
                IF SubjectMasterCS."Subject Wise Examination" = FALSE THEN //In Some Subject Student Will Come Subject,Secton wise
                    IF getCourse <> '' THEN
                        MainStudentSubjectCS.SETRANGE(Course, getCourse);
                IF InternalExamHeaderCS."Type Of Course" = InternalExamHeaderCS."Type Of Course"::Semester THEN
                    MainStudentSubjectCS.SETRANGE(Semester, getSemester)
                ELSE
                    MainStudentSubjectCS.SETRANGE(Year, getYear);
                MainStudentSubjectCS.SETRANGE(Section, InternalExamHeaderCS.Section);
                MainStudentSubjectCS.SETRANGE("Academic Year", getAcademicYear);
                MainStudentSubjectCS.SETRANGE("Subject Class", InternalExamHeaderCS."Subject Class");
                MainStudentSubjectCS.SETRANGE("Subject Type", getSubjectType);
                MainStudentSubjectCS.SETRANGE("Subject Code", getSubjectCode);
                MainStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
                MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", GetGlobalDim1);
                IF MainStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                        StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                           StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            InternalExamLineCS.Reset();
                            InternalExamLineCS.SETRANGE("Document No.", "getDocumentNo.");
                            InternalExamLineCS.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                            IF InternalExamLineCS.ISEMPTY() then BEGIN
                                StudentMasterCS.GET(MainStudentSubjectCS."Student No.");
                                InternalExamLineCS.Reset();
                                InternalExamLineCS.SETRANGE("Document No.", "getDocumentNo.");
                                IF InternalExamLineCS.FINDLAST() THEN
                                    "LocLineNo." := InternalExamLineCS."Line No." + 10000
                                ELSE
                                    "LocLineNo." := 10000;

                                InternalExamLineCS.INIT();
                                InternalExamLineCS."Document No." := "getDocumentNo.";
                                InternalExamLineCS."Line No." := "LocLineNo.";
                                IF getCourse <> '' THEN
                                    InternalExamLineCS.Course := MainStudentSubjectCS.Course
                                ELSE
                                    InternalExamLineCS.Course := '';
                                InternalExamLineCS.Semester := MainStudentSubjectCS.Semester;
                                InternalExamLineCS."Type Of Course" := MainStudentSubjectCS."Type Of Course";
                                InternalExamLineCS.Section := MainStudentSubjectCS.Section;
                                InternalExamLineCS."Attendance Type" := InternalExamLineCS."Attendance Type"::Present;
                                InternalExamLineCS."Academic Year" := InternalExamHeaderCS."Academic Year";
                                InternalExamLineCS."Subject Class" := InternalExamHeaderCS."Subject Class";
                                InternalExamLineCS."Subject Type" := getSubjectType;
                                InternalExamLineCS."Subject Code" := getSubjectCode;
                                InternalExamLineCS.VALIDATE("Student No.", MainStudentSubjectCS."Student No.");
                                InternalExamLineCS."Enrollment No." := MainStudentSubjectCS."Enrollment No";
                                InternalExamLineCS.VALIDATE("Exam Type", InternalExamHeaderCS."Exam Type");
                                InternalExamLineCS.VALIDATE("Document Type", InternalExamHeaderCS."Document Type");
                                InternalExamLineCS.VALIDATE(Status, InternalExamHeaderCS.Status);
                                InternalExamLineCS.VALIDATE("Global Dimension 1 Code", GetGlobalDim1);
                                IF (InternalExamHeaderCS.Semester <> 'I') OR (InternalExamHeaderCS.Semester <> 'II') THEN
                                    InternalExamLineCS.VALIDATE("Global Dimension 2 Code", GetGlobalDim2);
                                InternalExamLineCS.Year := getYear;
                                InternalExamLineCS."Exam Group" := getExamGroup;
                                InternalExamLineCS."Exam Method Code" := getExamMethodCode;
                                InternalExamLineCS."Program" := InternalExamHeaderCS."Program";
                                InternalExamLineCS."Student Group" := InternalExamHeaderCS."Student Group";
                                InternalExamLineCS."Maximum Weightage" := GetWeightage;
                                InternalExamLineCS."Maximum Internal  Marks" := GetMaximumMarks;
                                InternalExamLineCS."Created By" := FORMAT(UserId());
                                InternalExamLineCS."Created On" := TODAY();
                                InternalExamLineCS.INSERT();

                            END;
                        END;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;
            END ELSE BEGIN
                OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Type", "Subject Code");
                IF InternalExamHeaderCS."Type Of Course" = InternalExamHeaderCS."Type Of Course"::Semester THEN
                    OptionalStudentSubjectCS.SETRANGE(Semester, getSemester)
                ELSE
                    OptionalStudentSubjectCS.SETRANGE(Year, getYear);
                OptionalStudentSubjectCS.SETRANGE("Academic Year", getAcademicYear);
                OptionalStudentSubjectCS.SETRANGE(Section, InternalExamHeaderCS.Section);
                OptionalStudentSubjectCS.SETRANGE("Subject Class", InternalExamHeaderCS."Subject Class");
                OptionalStudentSubjectCS.SETRANGE("Subject Type", getSubjectType);
                OptionalStudentSubjectCS.SETRANGE("Subject Code", getSubjectCode);
                OptionalStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
                OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", GetGlobalDim1);
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                        StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                           StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            InternalExamLineCS.Reset();
                            InternalExamLineCS.SETRANGE("Document No.", "getDocumentNo.");
                            InternalExamLineCS.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                            IF InternalExamLineCS.ISEMPTY() then BEGIN
                                StudentMasterCS.GET(OptionalStudentSubjectCS."Student No.");
                                InternalExamLineCS.Reset();
                                InternalExamLineCS.SETRANGE("Document No.", "getDocumentNo.");
                                IF InternalExamLineCS.FINDLAST() THEN
                                    "LocLineNo." := InternalExamLineCS."Line No." + 10000
                                ELSE
                                    "LocLineNo." := 10000;
                                InternalExamLineCS.INIT();
                                InternalExamLineCS."Document No." := "getDocumentNo.";
                                InternalExamLineCS."Line No." := "LocLineNo.";
                                IF getCourse <> '' THEN
                                    InternalExamLineCS.Course := OptionalStudentSubjectCS.Course
                                ELSE
                                    InternalExamLineCS.Course := '';
                                InternalExamLineCS.Semester := OptionalStudentSubjectCS.Semester;
                                InternalExamLineCS.Section := OptionalStudentSubjectCS.Section;
                                InternalExamLineCS."Type Of Course" := OptionalStudentSubjectCS."Type Of Course";
                                InternalExamLineCS."Academic Year" := InternalExamHeaderCS."Academic Year";
                                ;
                                InternalExamLineCS."Subject Type" := getSubjectType;
                                InternalExamLineCS."Subject Code" := getSubjectCode;
                                InternalExamLineCS."Student No." := OptionalStudentSubjectCS."Student No.";
                                InternalExamLineCS.VALIDATE("Student No.");
                                InternalExamLineCS.VALIDATE("Exam Type", InternalExamHeaderCS."Exam Type");
                                InternalExamLineCS.VALIDATE("Document Type", InternalExamHeaderCS."Document Type");
                                InternalExamLineCS.VALIDATE(Status, InternalExamHeaderCS.Status);
                                InternalExamLineCS.VALIDATE("Global Dimension 1 Code", GetGlobalDim1);
                                InternalExamLineCS.VALIDATE("Global Dimension 2 Code", GetGlobalDim2);
                                InternalExamLineCS."Program" := InternalExamHeaderCS."Program";
                                InternalExamLineCS."Student Group" := InternalExamHeaderCS."Student Group";
                                InternalExamLineCS.Year := getYear;
                                InternalExamLineCS."Exam Group" := getExamGroup;
                                InternalExamLineCS."Exam Method Code" := getExamMethodCode;
                                InternalExamLineCS."Maximum Weightage" := GetWeightage;
                                InternalExamLineCS."Maximum Internal  Marks" := GetMaximumMarks;
                                InternalExamLineCS."Created By" := FORMAT(UserId());
                                InternalExamLineCS."Created On" := TODAY();
                                InternalExamLineCS.INSERT();
                            END;
                        END;
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0
            END;
        //Code Added for Students Common Subjects::CSPL-00067::200219:END
    end;

    procedure StudentsOptionalSubjectsCS("getDocumentNo.": Code[20]; getCourse: Code[20]; getSemester: Code[10]; getAcademicYear: Code[20]; getSubjectType: Code[20]; getSubjectCode: Code[20]; getSection: Code[10])
    var
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        InternalExamHeader: Record "Internal Exam Header-CS";
        "LocLineNo.": Integer;

    begin
        //Code Added for Students Optional Subjects::CSPL-00067::200219:Start
        "LocLineNo." := 0;
        InternalExamLineCS.Reset();
        InternalExamLineCS.SETRANGE("Document No.", "getDocumentNo.");
        IF InternalExamLineCS.FINDFIRST() THEN
            IF CONFIRM(Text014Lbl, FALSE) THEN
                InternalExamLineCS.DELETEALL()
            ELSE
                EXIT;
        InternalExamHeader.Get("getDocumentNo.");
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", InternalExamHeader."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TESTFIELD("Academic Year");

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Type", "Subject Code");
        OptionalStudentSubjectCS.SETRANGE(Course, getCourse);
        OptionalStudentSubjectCS.SETRANGE(Semester, getSemester);
        OptionalStudentSubjectCS.SETRANGE(Section, getSection);
        OptionalStudentSubjectCS.SETRANGE("Academic Year", getAcademicYear);
        OptionalStudentSubjectCS.SETRANGE("Subject Type", getSubjectType);
        OptionalStudentSubjectCS.SETRANGE("Subject Code", getSubjectCode);
        IF OptionalStudentSubjectCS.FINDSET() THEN
            REPEAT
                "LocLineNo." += 10000;
                InternalExamLineCS.INIT();
                InternalExamLineCS."Document No." := "getDocumentNo.";
                InternalExamLineCS."Line No." += "LocLineNo.";
                InternalExamLineCS.Course := getCourse;
                InternalExamLineCS.Semester := getSemester;
                InternalExamLineCS.Section := getSection;
                InternalExamLineCS."Academic Year" := EducationSetupCS."Academic Year";
                InternalExamLineCS."Subject Type" := getSubjectType;
                InternalExamLineCS."Subject Code" := getSubjectCode;
                InternalExamLineCS."Student No." := OptionalStudentSubjectCS."Student No.";
                InternalExamLineCS.VALIDATE("Student No.");
                InternalExamLineCS.INSERT();
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        //Code Added for Students Optional Subjects::CSPL-00067::200219:END
    end;

    procedure StudentInternalMarksCS(getCourse: Code[20]; getSemester: Code[10]; getAcademicYear: Code[20]; getSubject: Code[20]; getType: Code[20]; getSection: Code[10]; getYear: Code[20]; ExternalExamHeaderCS: Record "External Exam Header-CS")
    var
        // CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        //OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        InternalMarkTempCS: Record "Internal Mark Temp-CS";
        // SubjectMasterCS: Record "Subject Master-CS";
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        // LocalOrder: Integer;

        ConsiderWeightage: Boolean;
        SetWeightage: Decimal;
        LocalWeightageOrder: Integer;
        TotalWeightage: Decimal;
        "SetDocumentNo.": Code[20];

    begin
        //Code Added for Student Internal Marks::CSPL-00067::200219:Start
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");

        InternalMarkTempCS.Reset();
        InternalMarkTempCS.DELETEALL();
        "SetDocumentNo." := GetDocumentNoCS(getCourse, getSemester, getSection, getSubject, getType, getYear, getAcademicYear);
        IF "SetDocumentNo." = '' THEN
            ERROR(Text000Lbl, getSubject);

        LocalWeightageOrder := 0;
        TotalWeightage := 0;

        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETRANGE("Document No.", "SetDocumentNo.");
        IF SessionalExamGroupLineCS.FINDFIRST() THEN
            REPEAT
                IF LocalWeightageOrder <> SessionalExamGroupLineCS.Order THEN BEGIN
                    TotalWeightage += SessionalExamGroupLineCS.Weightage;
                    LocalWeightageOrder := SessionalExamGroupLineCS.Order;
                END;
            UNTIL SessionalExamGroupLineCS.NEXT() = 0;

        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETRANGE("Document No.", "SetDocumentNo.");
        IF SessionalExamGroupLineCS.FINDSET() THEN
            REPEAT
                IF SessionalExamGroupLineCS."Exam Method" <> AcademicsSetupCS."Attendance Code" THEN BEGIN
                    InternalExamHeaderCS.Reset();
                    InternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester,
                      Section, "Academic Year", "Subject Type", "Subject Code", "Exam Method Code");
                    InternalExamHeaderCS.SETRANGE("Course Code", getCourse);
                    IF getType = AcademicsSetupCS."Common Subject Type" THEN
                        InternalExamHeaderCS.SETRANGE(Semester, getSemester)
                    ELSE
                        InternalExamHeaderCS.SETRANGE(Year, getYear);
                    InternalExamHeaderCS.SETRANGE("Academic Year", getAcademicYear);
                    InternalExamHeaderCS.SETRANGE("Subject Type", getType);
                    InternalExamHeaderCS.SETRANGE("Subject Code", getSubject);
                    InternalExamHeaderCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");    // CORP
                    InternalExamHeaderCS.SETRANGE("Global Dimension 2 Code", ExternalExamHeaderCS."Global Dimension 2 Code");    // CORP
                    InternalExamHeaderCS.SETRANGE("Result Generated", FALSE);
                    IF InternalExamHeaderCS.FINDFIRST() THEN BEGIN
                        InternalExamLineCS.Reset();
                        InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
                        IF InternalExamLineCS.ISEMPTY() then
                            ERROR(Text002Lbl, SessionalExamGroupLineCS."Exam Method");
                    END ELSE
                        IF InternalExamHeaderCS.ISEMPTY() then
                            ERROR(Text003Lbl, getSubject, SessionalExamGroupLineCS."Exam Method");
                END ELSE BEGIN
                    AttendPercentageHeadCS.Reset();
                    AttendPercentageHeadCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
                    AttendPercentageHeadCS.SETRANGE("Course Code", getCourse);
                    AttendPercentageHeadCS.SETRANGE(Semester, getSemester);
                    AttendPercentageHeadCS.SETRANGE("Academic Year", getAcademicYear);
                    AttendPercentageHeadCS.SETRANGE("Subject Type", getType);
                    AttendPercentageHeadCS.SETRANGE("Subject Code", getSubject);
                    AttendPercentageHeadCS.SETRANGE("Result Generated", FALSE);
                    IF AttendPercentageHeadCS.FINDFIRST() THEN BEGIN
                        AttendPercentageLineCS.Reset();
                        AttendPercentageLineCS.SETRANGE("Document No.", AttendPercentageHeadCS."No.");
                        IF AttendPercentageLineCS.ISEMPTY() then
                            ERROR(Text004Lbl);
                    END ELSE
                        ERROR(Text004Lbl);
                END;
            UNTIL SessionalExamGroupLineCS.NEXT() = 0;

        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETRANGE("Document No.", "SetDocumentNo.");
        SessionalExamGroupLineCS.SETRANGE(Weightage, 0);
        IF SessionalExamGroupLineCS.FINDFIRST() THEN
            ConsiderWeightage := FALSE
        ELSE
            ConsiderWeightage := TRUE;

        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETRANGE("Document No.", "SetDocumentNo.");
        IF SessionalExamGroupLineCS.FINDFIRST() THEN BEGIN
            SessionalExamGroupHeadCS.Reset();
            IF SessionalExamGroupHeadCS.GET(SessionalExamGroupLineCS."Document No.") THEN;
            IF ConsiderWeightage THEN
                SetWeightage := SessionalExamGroupLineCS.Weightage
            ELSE
                SetWeightage := 0;

            UpdateStudentMarksCS(getCourse, getSemester, getType, getSubject, SessionalExamGroupLineCS."Exam Method", SetWeightage,
                              SessionalExamGroupLineCS.Order, getSection, SessionalExamGroupHeadCS."Internal Evaluation Method",
                              SessionalExamGroupLineCS.Year, ExternalExamHeaderCS);
        END;

        //Code Added for Student Internal Marks::CSPL-00067::200219:End
    end;

    procedure UpdateStudentMarksCS(getCourse: Code[20]; getSemester: Code[10]; getSubjectType: Code[20]; getSubjectCode: Code[20]; getGroupCode: Code[20]; getweightage: Decimal; getOrder: Integer; getSection: Code[10]; getInternalEvaluation: Option " ","Best of Two","Average of Two","Best of Three","Average of Three","Average of Best Two"; getYear: Code[20]; ExternalExamHeaderCS: Record "External Exam Header-CS")
    var
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";
        InternalMarkTempCS: Record "Internal Mark Temp-CS";
        EducationSetupCS: Record "Education Setup-CS";
        CalculateMark: Decimal;
    begin
        //Code Added for Update Student Marks::CSPL-00067::200219:Start
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
        If EducationSetupCS.FindFirst() Then
            EducationSetupCS.TESTFIELD("Academic Year");
        CourseMasterCS.GET(getCourse);
        InternalMarkTempCS.LOCKTABLE(TRUE);
        InternalExamHeaderCS.Reset();
        InternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester,
          Section, "Academic Year", "Subject Type", "Subject Code", "Exam Method Code");
        InternalExamHeaderCS.SETRANGE("Course Code", getCourse);
        IF CourseMasterCS."Type Of Course" = CourseMasterCS."Type Of Course"::Semester THEN
            InternalExamHeaderCS.SETRANGE(Semester, getSemester)
        ELSE
            InternalExamHeaderCS.SETRANGE(Year, getYear);
        InternalExamHeaderCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
        InternalExamHeaderCS.SETRANGE("Subject Type", getSubjectType);
        InternalExamHeaderCS.SETRANGE("Subject Code", getSubjectCode);
        InternalExamHeaderCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
        InternalExamHeaderCS.SETRANGE("Global Dimension 2 Code", ExternalExamHeaderCS."Global Dimension 2 Code");
        InternalExamHeaderCS.SETRANGE("Result Generated", FALSE);
        InternalExamHeaderCS.SETRANGE(Status, InternalExamHeaderCS.Status::Released);
        IF InternalExamHeaderCS.FINDFIRST() THEN BEGIN
            InternalExamLineCS.Reset();
            InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
            IF InternalExamLineCS.FINDSET() THEN
                REPEAT
                    CalculateMark := 0;
                    InternalMarkTempCS.INIT();
                    InternalMarkTempCS."Student No." := InternalExamLineCS."Student No.";
                    InternalMarkTempCS."Course Code" := getCourse;
                    InternalMarkTempCS.Semester := getSemester;
                    InternalMarkTempCS.Section := getSection;
                    InternalMarkTempCS."Subject Code" := getSubjectCode;
                    InternalMarkTempCS."Group Code" := InternalExamHeaderCS."Exam Group";
                    InternalMarkTempCS.Order := getOrder;
                    InternalMarkTempCS."Internal Evaluation Method" := getInternalEvaluation;
                    IF InternalExamHeaderCS."Maximum Mark" <> 0 THEN
                        InternalMarkTempCS."Marks Obtained" := InternalExamLineCS."Marks Obtained"
                    ELSE
                        ERROR(Text006Lbl, getGroupCode, InternalExamHeaderCS."Exam Method Code");
                    InternalMarkTempCS.INSERT();
                UNTIL InternalExamLineCS.NEXT() = 0;
        END;
        //Code Added for Update Student Marks::CSPL-00067::200219:End
    end;

    procedure SetAttendanceMarkCS(getCourse: Code[20]; getSemester: Code[10]; getSubjectCode: Code[20]; getSubjectType: Code[20]; getGroupCode: Code[20]; getOrder: Integer; getSection: Code[10]; getweightage: Decimal; getMaxMark: Decimal)
    var
        //SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        InternalMarkTempCS: Record "Internal Mark Temp-CS";
        AttendPercentageLineCS: Record "Attend Percentage Line-CS";
        EducationSetupCS: Record "Education Setup-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        AttendPercentageSetupCS: Record "Attend Percentage Setup-CS";
    //AcademicsSetupCS1: Record "Academics Setup-CS";
    begin
        //Code Added for Set Attendance Mark::CSPL-00067::200219:Start
        EducationSetupCS.GET();
        EducationSetupCS.TESTFIELD("Academic Year");
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");
        AttendPercentageLineCS.Reset();
        AttendPercentageLineCS.SETCURRENTKEY("Course Code", Semester, Section, "Academic Year", "Subject Type", "Subject Code");
        AttendPercentageLineCS.SETRANGE("Course Code", getCourse);
        IF AcademicsSetupCS."Common Subject Type" = getSubjectType THEN BEGIN
            AttendPercentageLineCS.SETRANGE(Semester, getSemester);
            AttendPercentageLineCS.SETRANGE(Section, getSection);
        END;
        AttendPercentageLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        AttendPercentageLineCS.SETRANGE("Subject Type", getSubjectType);
        AttendPercentageLineCS.SETRANGE("Subject Code", getSubjectCode);
        AttendPercentageLineCS.SETRANGE("Result Generated", FALSE);
        IF AttendPercentageLineCS.FINDSET() THEN
            REPEAT
                InternalMarkTempCS.INIT();
                InternalMarkTempCS."Student No." := AttendPercentageLineCS."Student No.";
                InternalMarkTempCS."Course Code" := AttendPercentageLineCS."Course Code";
                InternalMarkTempCS.Semester := AttendPercentageLineCS.Semester;
                InternalMarkTempCS.Section := AttendPercentageLineCS.Section;
                InternalMarkTempCS."Subject Code" := AttendPercentageLineCS."Subject Code";
                InternalMarkTempCS."Group Code" := getGroupCode;
                InternalMarkTempCS.Order := getOrder;

                AttendPercentageSetupCS.Reset();
                AttendPercentageSetupCS.SETFILTER("Minimum Attendance %", '<=%1', AttendPercentageLineCS.Percentage);
                AttendPercentageSetupCS.SETFILTER("Maximum Attendance %", '>=%1', AttendPercentageLineCS.Percentage);
                IF AttendPercentageSetupCS.FINDFIRST() THEN
                    IF AttendPercentageSetupCS.Mark <> 0 THEN BEGIN
                        IF (getweightage <> 0) AND (getMaxMark <> 0) THEN BEGIN
                            InternalMarkTempCS."Marks Obtained" := (AttendPercentageSetupCS.Mark / getMaxMark) * getweightage;
                            InternalMarkTempCS.Weightage := getweightage;
                        END ELSE BEGIN
                            InternalMarkTempCS."Marks Obtained" := (AttendPercentageSetupCS.Mark / getMaxMark) * 100;
                            InternalMarkTempCS.Weightage := getMaxMark;
                        END;
                    END ELSE BEGIN
                        InternalMarkTempCS."Marks Obtained" := 0;
                        InternalMarkTempCS.Weightage := 0;
                    END;
                InternalMarkTempCS.INSERT();
            UNTIL AttendPercentageLineCS.NEXT() = 0;
        //Code Added for Set Attendance Mark::CSPL-00067::200219:End
    end;

    procedure getStudentsforExternalCS("getDocNo.": Code[20])
    var
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        //MainStudentSubjectCS1: Record "Main Student Subject-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        // AdmitCardHeaderCS: Record "Admit Card Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        SetupExaminationCS: Record "Setup Examination -CS";

        ExternalExamLineCS: Record "External Exam Line-CS";
        ConsiderWeightage: Boolean;
        "SetDocumentNo.": Code[20];
        "LocLineNo.": Integer;

    begin
        //Code Added for Update Internal Marks::CSPL-00067::200219:Start
        ExternalExamLineCS.Reset();
        ExternalExamLineCS.SETRANGE("Document No.", "getDocNo.");
        IF ExternalExamLineCS.FINDFIRST() THEN
            IF GUIALLOWED() THEN
                IF CONFIRM(Text016Lbl, FALSE) THEN
                    ExternalExamLineCS.DELETEALL()
                ELSE
                    EXIT;

        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");


        ExternalExamHeaderCS.GET("getDocNo.");
        ExternalExamHeaderCS.TESTFIELD("Subject Class");
        ExternalExamHeaderCS.TESTFIELD("Subject Code");
        ExternalExamHeaderCS.TESTFIELD("Subject Type");
        ExternalExamHeaderCS.TESTFIELD("Exam Type");
        ExternalExamHeaderCS.TESTFIELD("Course Code");
        IF ExternalExamHeaderCS."Subject Type" = AcademicsSetupCS."Common Subject Type" THEN
            ExternalExamHeaderCS.TESTFIELD(Semester)
        ELSE
            ExternalExamHeaderCS.TESTFIELD(Year);
        ExternalExamHeaderCS.TESTFIELD("Academic Year");
        ExternalExamHeaderCS.TESTFIELD("Document Type");
        ExternalExamHeaderCS.TESTFIELD("External Maximum");
        ExternalExamHeaderCS.TESTFIELD("Total Maximum");

        CourseMasterCS.GET(ExternalExamHeaderCS."Course Code");

        IF ExternalExamHeaderCS."Subject Type" <> AcademicsSetupCS."Common Subject Type" THEN
            ExternalExamHeaderCS.TESTFIELD("CBCS Batch");

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Type", "Subject Code");
        MainStudentSubjectCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
        IF CourseMasterCS."Type Of Course" = CourseMasterCS."Type Of Course"::Semester THEN
            MainStudentSubjectCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
        ELSE
            MainStudentSubjectCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
        MainStudentSubjectCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
        MainStudentSubjectCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
        MainStudentSubjectCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
        MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");  // CORP
        MainStudentSubjectCS.SETRANGE("Global Dimension 2 Code", ExternalExamHeaderCS."Global Dimension 2 Code");  // CORP
        MainStudentSubjectCS.SETRANGE(Completed, FALSE);
        IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
            "SetDocumentNo." := GetDocumentNoCS(ExternalExamHeaderCS."Course Code", ExternalExamHeaderCS.Semester,
                                ExternalExamHeaderCS.Section, ExternalExamHeaderCS."Subject Code", ExternalExamHeaderCS."Subject Type",
                                ExternalExamHeaderCS.Year, ExternalExamHeaderCS."Academic Year");

            SessionalExamGroupLineCS.Reset();
            SessionalExamGroupLineCS.SETRANGE("Document No.", "SetDocumentNo.");
            SessionalExamGroupLineCS.SETRANGE(Weightage, 0);
            IF SessionalExamGroupLineCS.FINDFIRST() THEN
                ConsiderWeightage := FALSE
            ELSE
                ConsiderWeightage := TRUE;

            StudentInternalMarksCS(ExternalExamHeaderCS."Course Code", ExternalExamHeaderCS.Semester,
              ExternalExamHeaderCS."Academic Year", ExternalExamHeaderCS."Subject Code",
              ExternalExamHeaderCS."Subject Type", ExternalExamHeaderCS.Section, ExternalExamHeaderCS.Year, ExternalExamHeaderCS);

            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Type", "Subject Code");
            MainStudentSubjectCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
            IF CourseMasterCS."Type Of Course" = CourseMasterCS."Type Of Course"::Semester THEN
                MainStudentSubjectCS.SETRANGE(Semester, ExternalExamHeaderCS.Semester)
            ELSE
                MainStudentSubjectCS.SETRANGE(Year, ExternalExamHeaderCS.Year);
            MainStudentSubjectCS.SETRANGE(Section, ExternalExamHeaderCS.Section);
            IF ExternalExamHeaderCS."Subject Type" <> AcademicsSetupCS."Common Subject Type" THEN
                MainStudentSubjectCS.SETRANGE(Completed, FALSE);
            MainStudentSubjectCS.SETRANGE("Subject Type", ExternalExamHeaderCS."Subject Type");
            MainStudentSubjectCS.SETRANGE("Subject Code", ExternalExamHeaderCS."Subject Code");
            MainStudentSubjectCS.SETRANGE("Academic Year", ExternalExamHeaderCS."Academic Year");
            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalExamHeaderCS."Global Dimension 1 Code");
            MainStudentSubjectCS.SETRANGE("Global Dimension 2 Code", ExternalExamHeaderCS."Global Dimension 2 Code");
            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    MainStudentSubjectCS.GET(MainStudentSubjectCS."Student No.");
                    IF MainStudentSubjectCS."Student Status" = MainStudentSubjectCS."Student Status"::Student THEN BEGIN
                        "LocLineNo." += 10000;
                        ExternalExamLineCS.INIT();
                        ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                        ExternalExamLineCS."Line No." := "LocLineNo.";
                        ExternalExamLineCS.Course := ExternalExamHeaderCS."Course Code";
                        ExternalExamLineCS.Semester := ExternalExamHeaderCS.Semester;
                        ExternalExamLineCS."Academic year" := ExternalExamLineCS."Academic year";
                        ExternalExamLineCS."Exam Type" := ExternalExamLineCS."Exam Type";  // CORP
                        ExternalExamLineCS.VALIDATE("Global Dimension 1 Code", ExternalExamLineCS."Global Dimension 1 Code");   // CORP
                        ExternalExamLineCS.VALIDATE("Global Dimension 2 Code", ExternalExamLineCS."Global Dimension 2 Code");   // CORP
                        ExternalExamLineCS.VALIDATE("Document Type", ExternalExamLineCS."Document Type");  // CORP
                        ExternalExamLineCS.VALIDATE(Status, ExternalExamLineCS.Status);  // CORP
                        ExternalExamLineCS."Subject Type" := ExternalExamLineCS."Subject Type";
                        ExternalExamLineCS."Subject Code" := ExternalExamLineCS."Subject Code";
                        ExternalExamLineCS."Type Of Course" := ExternalExamLineCS."Type Of Course";
                        ExternalExamLineCS.Year := ExternalExamLineCS.Year;
                        ExternalExamLineCS."Apply Type" := ExternalExamLineCS."Apply Type"::Regular;
                        ExternalExamLineCS.VALIDATE("Student No.", MainStudentSubjectCS."Student No.");

                        ExternalAttendanceLineCS.Reset();
                        ExternalAttendanceLineCS.SETCURRENTKEY(Course, Semester, "Subject Type", "Subject Code", "Student No.", Section, "Academic Year", "Global Dimension 1 Code",
                          "Global Dimension 2 Code", "Type Of Course", Year, "Document Type", Status);
                        ExternalAttendanceLineCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
                        ExternalAttendanceLineCS.SETRANGE(Semester, ExternalExamLineCS.Semester);
                        ExternalAttendanceLineCS.SETRANGE("Subject Type", ExternalExamLineCS."Subject Type");
                        ExternalAttendanceLineCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
                        ExternalAttendanceLineCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
                        ExternalAttendanceLineCS.SETRANGE(Section, ExternalExamLineCS.Section);
                        ExternalAttendanceLineCS.SETRANGE("Academic Year", ExternalExamLineCS."Academic year");
                        ExternalAttendanceLineCS.SETRANGE("Global Dimension 1 Code", ExternalExamLineCS."Global Dimension 1 Code");
                        ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalExamLineCS."Global Dimension 2 Code");
                        ExternalAttendanceLineCS.SETRANGE("Type Of Course", ExternalExamLineCS."Type Of Course");
                        ExternalAttendanceLineCS.SETRANGE(Year, ExternalExamLineCS.Year);
                        ExternalAttendanceLineCS.SETRANGE("Document Type", ExternalExamLineCS."Document Type");
                        ExternalAttendanceLineCS.SETRANGE(Status, ExternalAttendanceLineCS.Status::Released);
                        IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                            ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
                            ExternalExamLineCS."Attendance %" := ExternalAttendanceLineCS."Attendance %";
                        END;
                        SetupExaminationCS.GET();
                        IF ExternalExamLineCS."Attendance %" < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                            ExternalExamLineCS.Detained := TRUE;
                        ExternalExamLineCS.Section := StudentMasterCS.Section;
                        ExternalExamLineCS.VALIDATE("Internal Mark",
                          UpdateInternalMarksCS(MainStudentSubjectCS."Student No.", ExternalExamHeaderCS."Course Code", ExternalExamLineCS.Semester,
                            ExternalExamLineCS.Section, ExternalExamLineCS."Subject Code", ConsiderWeightage, ExternalExamLineCS.Year));
                        ExternalExamLineCS."Total Maximum" := ExternalExamLineCS."Total Maximum";
                        ExternalExamLineCS.INSERT();
                    END;
                UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;

        // update arrears Subjects
        AdmitCardLineCS.Reset();
        IF AcademicsSetupCS."Common Subject Type" = ExternalExamLineCS."Subject Type" THEN BEGIN
            AdmitCardLineCS.SETRANGE(Course, ExternalExamHeaderCS."Course Code");
            AdmitCardLineCS.SETRANGE(Semester, ExternalExamLineCS.Semester);
            AdmitCardLineCS.SETRANGE(Section, ExternalExamLineCS.Section);
        END;
        AdmitCardLineCS.SETRANGE("Academic Year", ExternalExamLineCS."Academic year");
        AdmitCardLineCS.SETRANGE("Subject Type", ExternalExamLineCS."Subject Type");
        AdmitCardLineCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
        AdmitCardLineCS.SETRANGE("Apply Type", AdmitCardLineCS."Apply Type"::"Re-Registration");
        AdmitCardLineCS.SETRANGE("Result Generated", FALSE);
        IF AdmitCardLineCS.FINDSET() THEN
            REPEAT
                "LocLineNo." += 10000;
                ExternalExamLineCS.INIT();
                ExternalExamLineCS."Document No." := ExternalExamHeaderCS."No.";
                ExternalExamLineCS."Line No." := "LocLineNo.";
                ExternalExamLineCS."Attendance Type" := ExternalExamLineCS."Attendance Type"::Present;
                ExternalExamLineCS.Course := AdmitCardLineCS.Course;
                ExternalExamLineCS.Semester := AdmitCardLineCS.Semester;
                ExternalExamLineCS."Academic year" := ExternalExamLineCS."Academic year";
                ExternalExamLineCS."Subject Type" := AdmitCardLineCS."Subject Type";
                ExternalExamLineCS."Subject Code" := AdmitCardLineCS."Subject Code";
                ExternalExamLineCS."Apply Type" := ExternalExamLineCS."Apply Type"::Arrears;
                ExternalExamLineCS."Student No." := AdmitCardLineCS."Student No.";
                ExternalExamLineCS.VALIDATE("Student No.");
                ExternalExamLineCS.Section := AdmitCardLineCS.Section;

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE("Student No.", AdmitCardLineCS."Student No.");
                MainStudentSubjectCS.SETRANGE(Course, AdmitCardLineCS.Course);
                MainStudentSubjectCS.SETRANGE(Semester, AdmitCardLineCS.Semester);
                MainStudentSubjectCS.SETRANGE(Section, AdmitCardLineCS.Section);
                MainStudentSubjectCS.SETRANGE("Subject Type", AdmitCardLineCS."Subject Type");
                MainStudentSubjectCS.SETRANGE("Subject Code", AdmitCardLineCS."Subject Code");
                MainStudentSubjectCS.SETRANGE(Completed, TRUE);
                IF MainStudentSubjectCS.FINDFIRST() THEN
                    ExternalExamLineCS."Internal Mark" := MainStudentSubjectCS."Internal Mark";
                ExternalExamLineCS.INSERT();
            UNTIL AdmitCardLineCS.NEXT() = 0;

        ExternalExamHeaderCS."Internal Generated" := TRUE;
        ExternalExamLineCS.Modify();
        //Code Added for Update Internal Marks::CSPL-00067::200219:End
    end;

    procedure UpdateInternalMarksCS("getStudentNo.": Code[20]; getCourse: Code[20]; getSemester: Code[10]; getSection: Code[10]; getSubject: Code[20]; getConsiderWeightage: Boolean; getYear: Code[20]): Decimal
    var
        InternalMarkTempCS: Record "Internal Mark Temp-CS";

        //SubjectMasterCS: Record "Subject Master-CS";
        //SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        TotalMarks: Decimal;
        TotalWeightage: Decimal;
    begin
        //Code Added for Generate Result::CSPL-00067::200219:Start
        TotalMarks := 0;
        TotalWeightage := 0;
        InternalMarkTempCS.Reset();
        InternalMarkTempCS.SETCURRENTKEY("Course Code", Semester, Section, "Subject Code", "Student No.");
        InternalMarkTempCS.SETRANGE("Course Code", getCourse);
        InternalMarkTempCS.SETRANGE(Semester, getSemester);
        InternalMarkTempCS.SETRANGE(Year, getYear);
        InternalMarkTempCS.SETRANGE(Section, getSection);
        InternalMarkTempCS.SETRANGE("Subject Code", getSubject);
        InternalMarkTempCS.SETRANGE("Student No.", "getStudentNo.");
        InternalMarkTempCS.CALCSUMS("Marks Obtained");
        TotalMarks := InternalMarkTempCS."Marks Obtained";
        InternalMarkTempCS.SETFILTER(Weightage, '<>0');
        TotalWeightage := InternalMarkTempCS.count();

        EXIT(TotalMarks);
        //Code Added for Generate Result::CSPL-00067::200219:End
    end;

    procedure GenerateResultCS("getDocNo.": Code[20])
    var
        ExternalExamLineCS: Record "External Exam Line-CS";
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        //: Record "Main Student Subject-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
    /*ClassAttendanceHeaderCS: Record "Class Attendance Header-CS";
    InternalExamHeaderCS: Record "Internal Exam Header-CS";
    AttendPercentageHeadCS: Record "Attend Percentage Head-CS";
    AttendPercentageLineCS: Record "Attend Percentage Line-CS";
    AdmitCardHeaderCS: Record "Admit Card Header-CS";
    FineAttendanceHeadCS: Record "Fine Attendance Head-CS";
    SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
    Rank: Report "Student Subject UpdateNew CS";*/
    begin
        //Code Added for Generate Result::CSPL-00067::200219:Start
        ExternalExamHeaderCS.GET("getDocNo.");

        IF NOT ExternalExamHeaderCS."Internal Generated" THEN
            ERROR(Text007Lbl);

        ExternalExamHeaderCS.TESTFIELD("Subject Type");

        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        AcademicsSetupCS.TESTFIELD("CBCS Batch");
        ExternalExamHeaderCS.TESTFIELD("Course Code");
        IF ExternalExamHeaderCS."Subject Type" = AcademicsSetupCS."Common Subject Type" THEN
            ExternalExamHeaderCS.TESTFIELD(Semester);
        ExternalExamHeaderCS.TESTFIELD("Subject Code");
        ExternalExamHeaderCS.TESTFIELD("External Maximum");
        ExternalExamHeaderCS.TESTFIELD("Total Maximum");
        ExternalExamHeaderCS.TESTFIELD("Academic Year");
        IF SubjectMasterCS.GET(ExternalExamHeaderCS."Subject Code", ExternalExamHeaderCS."Course Code", ExternalExamHeaderCS."Academic Year") THEN
            IF SubjectMasterCS."Total Pass" = 0 THEN
                SubjectMasterCS.TESTFIELD("External Pass");


        ExternalExamLineCS.Reset();
        ExternalExamLineCS.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
        IF ExternalExamLineCS.FINDSET() THEN
            REPEAT
                ExternalExamLineCS.TESTFIELD("Grade Generated");
                IF ((ExternalExamLineCS.Total + ExternalExamLineCS."Grace Marks") >= SubjectMasterCS."Total Pass") THEN
                    IF ExternalExamLineCS.UFM THEN
                        ExternalExamLineCS.Result := ExternalExamLineCS.Result::"On Hold"
                    ELSE
                        IF ExternalExamLineCS."Cr Points" >= ExternalExamHeaderCS."Minimum Credit Points Required" THEN   // CORP
                            ExternalExamLineCS.Result := ExternalExamLineCS.Result::Pass
                        ELSE
                            ExternalExamLineCS.Result := ExternalExamLineCS.Result::Fail;
                ExternalExamLineCS.Modify();
            UNTIL ExternalExamHeaderCS.NEXT() = 0;

        ExternalExamHeaderCS."Result Generated" := TRUE;
        ExternalExamHeaderCS."External Generated" := TRUE;
        ExternalExamHeaderCS.Modify();
        //Code Added for Generate Result::CSPL-00067::200219:END
    end;

    procedure getGroupCodeCS(getCourse: Code[20]; getSemester: Code[20]; getSubject: Code[20]; getType: Code[20]): Code[20]
    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";
    begin
        //Code Added for get Group Code::CSPL-00067::200219:Start
        AcademicsSetupCS.GET();
        IF getType = AcademicsSetupCS."Common Subject Type" THEN BEGIN
            CourseWiseSubjectLineCS.Reset();
            CourseWiseSubjectLineCS.SETRANGE("Course Code", getCourse);
            CourseWiseSubjectLineCS.SETRANGE(Semester, getSemester);
            CourseWiseSubjectLineCS.SETRANGE("Subject Code", getSubject);
            CourseWiseSubjectLineCS.SETRANGE("Subject Type", getType);
            IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                EXIT(CourseWiseSubjectLineCS."Group Code");
        END ELSE BEGIN
            SubjectMasterCS.Reset();
            SubjectMasterCS.SETRANGE(Code, getSubject);
            SubjectMasterCS.SETRANGE("Subject Type", getType);
            IF SubjectMasterCS.FINDFIRST() THEN
                EXIT(SubjectMasterCS."Group Code");
        END;
        //Code Added for get Group Code::CSPL-00067::200219:END
    end;

    procedure "Calculate GroupsCS"(getCourse: Code[20]; getSemester: Code[10]; getSubjectCode: Code[20]; getGroupCode: Code[20]; getOrder: Integer; getSection: Code[10]; getInternalEvaluation: Option " ","Best of Two","Average of Two","Best of Three","Average of Three","Average of Best Two")
    var
        InternalMarkTempCS2: Record "Internal Mark Temp-CS";
        // SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        // SessionalExamGroupCS1: Record "Sessional Exam Group-CS";
        InternalMarkTempCS: Record "Internal Mark Temp-CS";
        InternalMarkTempCS1: Record "Internal Mark Temp-CS";
        CheckCount: Integer;
        "LocalStudentNo.": Code[20];

    begin
        //Code Added for Calculate Groups::CSPL-00067::200219:Start

        IF (getInternalEvaluation = getInternalEvaluation::"Best of Two") OR
           (getInternalEvaluation = getInternalEvaluation::"Best of Three")
        THEN BEGIN
            "LocalStudentNo." := '';
            InternalMarkTempCS.Reset();
            InternalMarkTempCS.SETCURRENTKEY("Student No.", Order);
            InternalMarkTempCS.SETRANGE("Course Code", getCourse);
            InternalMarkTempCS.SETRANGE(Semester, getSemester);
            InternalMarkTempCS.SETRANGE(Section, getSection);
            InternalMarkTempCS.SETRANGE("Subject Code", getSubjectCode);
            InternalMarkTempCS.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
            InternalMarkTempCS.SETRANGE(Order, getOrder);
            IF InternalMarkTempCS.FINDSET() THEN
                REPEAT
                    IF "LocalStudentNo." <> InternalMarkTempCS."Student No." THEN BEGIN
                        "LocalStudentNo." := InternalMarkTempCS."Student No.";
                        CheckCount := 0;
                        InternalMarkTempCS1.Reset();
                        InternalMarkTempCS1.SETCURRENTKEY("Student No.", "Marks Obtained");
                        InternalMarkTempCS1.SETRANGE("Student No.", "LocalStudentNo.");
                        InternalMarkTempCS1.SETRANGE("Course Code", InternalMarkTempCS."Course Code");
                        InternalMarkTempCS1.SETRANGE(Semester, InternalMarkTempCS.Semester);
                        InternalMarkTempCS1.SETRANGE(Section, InternalMarkTempCS.Section);
                        InternalMarkTempCS1.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
                        InternalMarkTempCS1.SETRANGE(Order, InternalMarkTempCS.Order);
                        InternalMarkTempCS1.ASCENDING(FALSE);
                        IF InternalMarkTempCS1.FINDFIRST() THEN
                            REPEAT
                                IF CheckCount <> 0 THEN BEGIN
                                    InternalMarkTempCS2.Reset();
                                    InternalMarkTempCS2.SETCURRENTKEY("Student No.", Order);
                                    InternalMarkTempCS2.SETRANGE("Student No.", InternalMarkTempCS1."Student No.");
                                    InternalMarkTempCS2.SETRANGE("Course Code", InternalMarkTempCS1."Course Code");
                                    InternalMarkTempCS2.SETRANGE(Semester, InternalMarkTempCS1.Semester);
                                    InternalMarkTempCS2.SETRANGE(Section, InternalMarkTempCS1.Section);
                                    InternalMarkTempCS2.SETRANGE("Subject Code", InternalMarkTempCS1."Subject Code");
                                    InternalMarkTempCS2.SETRANGE("Group Code", InternalMarkTempCS1."Group Code");
                                    InternalMarkTempCS2.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
                                    InternalMarkTempCS2.SETRANGE(Order, InternalMarkTempCS1.Order);
                                    IF InternalMarkTempCS2.FINDFIRST() THEN BEGIN
                                        InternalMarkTempCS2."Marks Obtained" := 0;
                                        InternalMarkTempCS2.Modify();
                                    END;
                                END;
                                CheckCount := 1;
                            UNTIL InternalMarkTempCS1.NEXT() = 0;
                    END;
                UNTIL InternalMarkTempCS.NEXT() = 0;
        END ELSE
            IF getInternalEvaluation = getInternalEvaluation::"Average of Best Two" THEN BEGIN
                "LocalStudentNo." := '';
                InternalMarkTempCS.Reset();
                InternalMarkTempCS.SETCURRENTKEY("Student No.", Order);
                InternalMarkTempCS.SETRANGE("Course Code", getCourse);
                InternalMarkTempCS.SETRANGE(Semester, getSemester);
                InternalMarkTempCS.SETRANGE(Section, getSection);
                InternalMarkTempCS.SETRANGE("Subject Code", getSubjectCode);
                InternalMarkTempCS.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
                InternalMarkTempCS.SETRANGE(Order, getOrder);
                IF InternalMarkTempCS.FINDSET() THEN
                    REPEAT
                        IF "LocalStudentNo." <> InternalMarkTempCS."Student No." THEN BEGIN
                            "LocalStudentNo." := InternalMarkTempCS."Student No.";
                            CheckCount := 1;
                            InternalMarkTempCS1.Reset();
                            InternalMarkTempCS1.SETCURRENTKEY("Student No.", "Marks Obtained");
                            InternalMarkTempCS1.SETRANGE("Student No.", "LocalStudentNo.");
                            InternalMarkTempCS1.SETRANGE("Course Code", InternalMarkTempCS."Course Code");
                            InternalMarkTempCS1.SETRANGE(Semester, InternalMarkTempCS.Semester);
                            InternalMarkTempCS1.SETRANGE(Section, InternalMarkTempCS.Section);
                            InternalMarkTempCS1.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
                            InternalMarkTempCS1.SETRANGE(Order, getOrder);
                            InternalMarkTempCS1.ASCENDING(FALSE);
                            IF InternalMarkTempCS1.FINDFIRST() THEN
                                REPEAT
                                    IF CheckCount > 2 THEN BEGIN
                                        InternalMarkTempCS2.Reset();
                                        InternalMarkTempCS2.SETCURRENTKEY("Student No.", Order);
                                        InternalMarkTempCS2.SETRANGE("Student No.", InternalMarkTempCS1."Student No.");
                                        InternalMarkTempCS2.SETRANGE("Course Code", InternalMarkTempCS1."Course Code");
                                        InternalMarkTempCS2.SETRANGE(Semester, InternalMarkTempCS1.Semester);
                                        InternalMarkTempCS2.SETRANGE(Section, InternalMarkTempCS1.Section);
                                        InternalMarkTempCS2.SETRANGE("Subject Code", InternalMarkTempCS1."Subject Code");
                                        InternalMarkTempCS2.SETRANGE("Group Code", InternalMarkTempCS1."Group Code");
                                        InternalMarkTempCS2.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
                                        InternalMarkTempCS2.SETRANGE(Order, InternalMarkTempCS1.Order);
                                        IF InternalMarkTempCS2.FINDFIRST() THEN BEGIN
                                            InternalMarkTempCS2."Marks Obtained" := 0;
                                            InternalMarkTempCS2.Modify();
                                        END;
                                    END;
                                    CheckCount += 1;
                                UNTIL InternalMarkTempCS1.NEXT() = 0;
                        END;
                    UNTIL InternalMarkTempCS.NEXT() = 0;
            END;
        //Code Added for Calculate Groups::CSPL-00067::200219:End
    end;

    procedure "Calculate AverageCS"(getCourse: Code[20]; getSemester: Code[10]; getSubjectCode: Code[20]; getGroupCode: Code[20]; getOrder: Integer; getSection: Code[10]; getInternalEvaluation: Option " ","Best of Two","Average of Two","Best of Three","Average of Three","Average of Best Two")
    var
        // SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        InternalMarkTempCS: Record "Internal Mark Temp-CS";
        InternalMarkTempCS1: Record "Internal Mark Temp-CS";
        CheckCount: Integer;
        "LocalStudentNo.": Code[20];
        StudentTotalMarks: Decimal;
    begin
        //Code Added for Calculate Average::CSPL-00067::200219:Start
        "LocalStudentNo." := '';
        InternalMarkTempCS.Reset();
        InternalMarkTempCS.SETCURRENTKEY("Student No.", Order);
        InternalMarkTempCS.SETRANGE("Course Code", getCourse);
        InternalMarkTempCS.SETRANGE(Semester, getSemester);
        InternalMarkTempCS.SETRANGE(Section, getSection);
        InternalMarkTempCS.SETRANGE("Subject Code", getSubjectCode);
        InternalMarkTempCS.SETRANGE("Internal Evaluation Method", getInternalEvaluation);
        InternalMarkTempCS.SETRANGE(Order, getOrder);
        IF InternalMarkTempCS.FINDSET() THEN
            REPEAT
                IF "LocalStudentNo." <> InternalMarkTempCS."Student No." THEN BEGIN
                    "LocalStudentNo." := InternalMarkTempCS."Student No.";
                    CheckCount := 0;
                    StudentTotalMarks := 0;
                    InternalMarkTempCS1.Reset();
                    InternalMarkTempCS1.SETCURRENTKEY("Student No.", Order);
                    InternalMarkTempCS1.SETRANGE("Student No.", "LocalStudentNo.");
                    InternalMarkTempCS1.SETRANGE("Course Code", InternalMarkTempCS."Course Code");
                    InternalMarkTempCS1.SETRANGE(Semester, InternalMarkTempCS.Semester);
                    InternalMarkTempCS1.SETRANGE(Section, InternalMarkTempCS.Section);
                    InternalMarkTempCS1.SETRANGE(Order, getOrder);
                    InternalMarkTempCS1.CALCSUMS("Marks Obtained");
                    StudentTotalMarks := InternalMarkTempCS1."Marks Obtained";
                    IF InternalMarkTempCS1.FINDSET() THEN
                        REPEAT
                            IF CheckCount = 0 THEN BEGIN
                                IF ((getInternalEvaluation = getInternalEvaluation::"Average of Two") OR
                                   (getInternalEvaluation = getInternalEvaluation::"Average of Best Two"))
                                   AND (StudentTotalMarks <> 0)
                                THEN
                                    InternalMarkTempCS1."Marks Obtained" := StudentTotalMarks / 2
                                ELSE
                                    IF (getInternalEvaluation = getInternalEvaluation::"Average of Three") AND (StudentTotalMarks <> 0) THEN
                                        InternalMarkTempCS1."Marks Obtained" := StudentTotalMarks / 3
                                    ELSE
                                        IF getInternalEvaluation = getInternalEvaluation::" " THEN
                                            InternalMarkTempCS1."Marks Obtained" := StudentTotalMarks;
                            END ELSE BEGIN
                                InternalMarkTempCS1."Marks Obtained" := 0;
                                InternalMarkTempCS1.Weightage := 0;
                            END;
                            InternalMarkTempCS1.Modify();
                            CheckCount := 1;
                        UNTIL InternalMarkTempCS1.NEXT() = 0;
                END;
            UNTIL InternalMarkTempCS.NEXT() = 0;
        //Code Added for Calculate Average::CSPL-00067::200219:End
    end;

    procedure GetExamMethodCS("getDocumentNo.": Code[20]; getCourse: Code[20]; getSemester: Code[10]; getAcademicYear: Code[20]; getSubjectType: Code[20]; getSubjectCode: Code[20]; getSection: Code[10]; getGroupCode: Code[20])
    var
        // MainStudentSubjectCS: Record "Main Student Subject-CS";
        // InternalExamLineCS: Record "Internal Exam Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        GradeMasterCS: Record "Grade Master-CS";
        SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        SessionalExamGroupCS: Record "Sessional Exam Group-CS";
        ExamGroupCodeCS: Record "Exam Group Code-CS";
        AttendPercentageSetupCS: Record "Attend Percentage Setup-CS";
        "LocLineNo.": Integer;

    begin
        //Code Added for Get Exam Method::CSPL-00067::200219:Start

        "LocLineNo." := 0;
        SessionalExamGroupLineCS.Reset();
        SessionalExamGroupLineCS.SETRANGE("Document No.", "getDocumentNo.");
        IF SessionalExamGroupLineCS.FINDFIRST() THEN
            IF GUIALLOWED() THEN
                IF CONFIRM(Text015Lbl, FALSE) THEN
                    SessionalExamGroupLineCS.DELETEALL()
                ELSE
                    EXIT;

        SessionalExamGroupCS.Reset();
        SessionalExamGroupCS.SETRANGE(Group, getGroupCode);
        IF SessionalExamGroupCS.FINDSET() THEN
            REPEAT
                "LocLineNo." += 10000;
                SessionalExamGroupLineCS.INIT();
                SessionalExamGroupLineCS."Document No." := "getDocumentNo.";
                SessionalExamGroupLineCS."Line No." += "LocLineNo.";
                SessionalExamGroupLineCS.Course := getCourse;
                SessionalExamGroupLineCS.Semester := getSemester;
                SessionalExamGroupLineCS.Section := getSection;
                SessionalExamGroupLineCS."Academic year" := GradeMasterCS."Academic Year";
                SessionalExamGroupLineCS."Subject Type" := getSubjectType;
                SessionalExamGroupLineCS."Subject Code" := getSubjectCode;
                SessionalExamGroupLineCS."Exam Group" := getGroupCode;
                SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
                IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
                    SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;

                AcademicsSetupCS.GET();
                IF (AcademicsSetupCS."Attendance Code" <> '') AND (SessionalExamGroupCS."Exam Method Code" = AcademicsSetupCS."Attendance Code") THEN BEGIN
                    AttendPercentageSetupCS.Reset();
                    AttendPercentageSetupCS.SETCURRENTKEY(Mark);
                    AttendPercentageSetupCS.ASCENDING(FALSE);
                    IF AttendPercentageSetupCS.FINDFIRST() THEN BEGIN
                        IF AttendPercentageSetupCS.Mark <> 0 THEN
                            SessionalExamGroupLineCS."Maximum Marks" := AttendPercentageSetupCS.Mark
                        ELSE
                            ERROR(Text008Lbl);
                    END ELSE
                        ERROR(Text009Lbl);
                END;
                SessionalExamGroupLineCS.INSERT();
            UNTIL SessionalExamGroupCS.NEXT() = 0;
        //Code Added for Get Exam Method::CSPL-00067::200219:END
    end;

    procedure GetDocumentNoCS(getCourse: Code[20]; getSemester: Code[10]; getSection: Code[10]; getSubject: Code[20]; getType: Code[20]; getYear: Code[20]; getAcademicYear: Code[20]): Code[20]
    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        // CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        // SubjectMasterCS: Record "Subject Master-CS";
        // SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
        SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
        EducationSetupCS: Record "Education Setup-CS";
    begin
        AcademicsSetupCS.GET();
        CourseMasterCS.GET(getCourse);
        EducationSetupCS.GET();
        EducationSetupCS.TESTFIELD("Academic Year");

        SessionalExamGroupHeadCS.Reset();
        SessionalExamGroupHeadCS.SETRANGE("Course Code", getCourse);
        IF CourseMasterCS."Type Of Course" = CourseMasterCS."Type Of Course"::Semester THEN
            SessionalExamGroupHeadCS.SETRANGE(Semester, getSemester)
        ELSE
            SessionalExamGroupHeadCS.SETRANGE(Year, getYear);
        SessionalExamGroupHeadCS.SETRANGE("Subject Type", getType);
        SessionalExamGroupHeadCS.SETRANGE("Subject Code", getSubject);
        SessionalExamGroupHeadCS.SETRANGE("Academic Year", getAcademicYear);
        SessionalExamGroupHeadCS.SETRANGE("Result Generated", FALSE);
        IF SessionalExamGroupHeadCS.FINDLAST() THEN
            EXIT(SessionalExamGroupHeadCS."No.");
    end;

    procedure GetStudentsforRevaluationCS(RevNo: Code[20])
    var
        RevaluationHeadCS: Record "Revaluation Head-CS";
        RevaluationLineCS: Record "Revaluation Line-CS";
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
    begin
        //Code Added for Get Students for Revaluation::CSPL-00067::200219:Start
        RevaluationHeadCS.GET(RevNo);
        RevaluationHeadCS.TESTFIELD("Subject Type");
        AcademicsSetupCS.GET();
        AcademicsSetupCS.TESTFIELD("Common Subject Type");
        IF AcademicsSetupCS."Common Subject Type" = RevaluationHeadCS."Subject Type" THEN BEGIN
            RevaluationHeadCS.TESTFIELD("Course Code");
            RevaluationHeadCS.TESTFIELD(Semester);
            RevaluationHeadCS.TESTFIELD("Subject Code");
        END;
        RevaluationHeadCS.TESTFIELD("External Maximum");
        RevaluationHeadCS.TESTFIELD("Total Maximum");
        RevaluationHeadCS.TESTFIELD("Academic Year");
        ExternalExamHeaderCS.Reset();
        ExternalExamHeaderCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Academic Year");
        ExternalExamHeaderCS.SETRANGE("Course Code", RevaluationHeadCS."Course Code");
        ExternalExamHeaderCS.SETRANGE(Semester, RevaluationHeadCS.Semester);
        ExternalExamHeaderCS.SETRANGE("Subject Code", RevaluationHeadCS."Subject Code");
        ExternalExamHeaderCS.SETRANGE("Academic Year", RevaluationHeadCS."Academic Year");
        IF NOT ExternalExamHeaderCS.FINDLAST() THEN
            ERROR(Text010Lbl)
        ELSE BEGIN
            ExternalExamLineCS.Reset();
            ExternalExamLineCS.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
            IF ExternalExamLineCS.FINDSET() THEN
                REPEAT
                    IF CheckRevaluationCS(ExternalExamLineCS) THEN
                        ExternalExamLineCS.MARK(TRUE);
                UNTIL ExternalExamLineCS.NEXT() = 0;
            IF ExternalExamLineCS.MARKEDONLY(TRUE) THEN;
            IF ExternalExamLineCS.FINDSET() THEN
                REPEAT
                    RevaluationLineCS.INIT();
                    RevaluationLineCS.TRANSFERFIELDS(ExternalExamLineCS);
                    RevaluationLineCS."Document No." := RevaluationHeadCS."No.";
                    RevaluationLineCS."Base Doc No." := ExternalExamLineCS."Document No.";
                    RevaluationLineCS."Base Line No." := ExternalExamLineCS."Line No.";
                    RevaluationLineCS.INSERT();
                UNTIL ExternalExamLineCS.NEXT() = 0
            ELSE
                MESSAGE(Text011Lbl);
        END;
        //Code Added for Get Students for Revaluation::CSPL-00067::200219:End
    end;

    procedure CheckRevaluationCS(var ExternalExamLineCS: Record "External Exam Line-CS") Ret: Boolean
    var
        RevaluationStatusCS: Record "Revaluation Status-CS";
    begin
        //Code Added for Check Revaluation::CSPL-00067::200219:Start
        RevaluationStatusCS.Reset();
        RevaluationStatusCS.SETCURRENTKEY("Student No.", "Course Code", Semester, "Academic Year", "Subject Code", "Revaluation Status");
        RevaluationStatusCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
        RevaluationStatusCS.SETRANGE("Course Code", ExternalExamLineCS.Course);
        RevaluationStatusCS.SETRANGE(Semester, ExternalExamLineCS.Semester);
        RevaluationStatusCS.SETRANGE("Academic Year", ExternalExamLineCS."Academic year");
        RevaluationStatusCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
        RevaluationStatusCS.SETRANGE("Revaluation Status", RevaluationStatusCS."Revaluation Status"::Approved);
        IF RevaluationStatusCS.FINDFIRST() THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
        //Code Added for Check Revaluation::CSPL-00067::200219:End
    end;

    procedure UpdateRevMarkCS(RevNo: Code[20])
    var
        //RevaluationHeadCS: Record "Revaluation Head-CS";
        RevaluationLineCS: Record "Revaluation Line-CS";
        // ExternalExamHeaderCS: Record "External Exam Header-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
    begin
        //Code Added for Update Rev Mark::CSPL-00067::200219:Start
        RevaluationLineCS.SETRANGE("Document No.", RevNo);
        IF RevaluationLineCS.FINDSET() THEN
            REPEAT
                ExternalExamLineCS.SETRANGE("Document No.", RevaluationLineCS."Base Doc No.");
                ExternalExamLineCS.SETRANGE("Line No.", RevaluationLineCS."Base Line No.");
                IF ExternalExamLineCS.FINDFIRST() THEN BEGIN
                    ExternalExamLineCS."External Mark" := RevaluationLineCS."External Revaluation Mark";
                    ExternalExamLineCS."Internal Mark" := RevaluationLineCS."Internal Revaluation Mark";
                    ExternalExamLineCS.Total := RevaluationLineCS.Total;
                    ExternalExamLineCS."Std. Grade" := RevaluationLineCS.Grade;
                    SubjectMasterCS.GET(RevaluationLineCS."Subject Code");
                    SubjectMasterCS.TESTFIELD("External Pass");
                    SubjectMasterCS.TESTFIELD("Total Pass");
                    IF RevaluationLineCS.Total >= SubjectMasterCS."Total Pass" THEN BEGIN
                        ExternalExamLineCS.Result := ExternalExamLineCS.Result::Pass;
                        RevaluationLineCS.Result := RevaluationLineCS.Result::Pass;
                    END ELSE BEGIN
                        ExternalExamLineCS.Result := ExternalExamLineCS.Result::Fail;
                        RevaluationLineCS.Result := RevaluationLineCS.Result::Fail;
                    END;

                    IF MainStudentSubjectCS.GET(RevaluationLineCS."Student No.", RevaluationLineCS.Course, RevaluationLineCS.Semester,
                       RevaluationLineCS."Academic year", RevaluationLineCS."Subject Code", RevaluationLineCS.Section)
                    THEN BEGIN
                        MainStudentSubjectCS."Internal Mark" := RevaluationLineCS."Internal Revaluation Mark";
                        MainStudentSubjectCS."External Mark" := RevaluationLineCS."External Revaluation Mark";
                        MainStudentSubjectCS.Total := RevaluationLineCS.Total;
                        MainStudentSubjectCS.Result := RevaluationLineCS.Result;
                        MainStudentSubjectCS."Attendance Type" := RevaluationLineCS."Attendance Type";
                        MainStudentSubjectCS.Grade := RevaluationLineCS.Grade;
                        MainStudentSubjectCS.Points := RevaluationLineCS.Points;
                        MainStudentSubjectCS.Modify();
                    END;
                    ExternalExamLineCS.Modify();
                    RevaluationLineCS.Modify();
                END;
            UNTIL RevaluationLineCS.NEXT() = 0;
        MESSAGE(Text012Lbl);
        // Code Added for Update Rev Mark::CSPL-00067::200219:End
    end;

    procedure PostRevaluationFeeCS(RevNo: Code[20])
    var
        RevaluationStatusCS: Record "Revaluation Status-CS";
        ManagementFeeCS: Codeunit "Management Fee -CS";
    begin
        //Code Added for Post Revaluation Fee::CSPL-00067::200219:Start
        RevaluationStatusCS.GET(RevNo);
        RevaluationStatusCS.TESTFIELD("Revaluation Status", RevaluationStatusCS."Revaluation Status"::Requested);
        ManagementFeeCS.PostSalesProcess(RevaluationStatusCS."Student No.", 'REVAL', RevaluationStatusCS."Fee Amount");
        //Code Added for Post Revaluation Fee::CSPL-00067::200219:End
    end;

    procedure UpdateInternalRankCS("getDocNo.": Code[20])
    var
        InternalExamLineCS: Record "Internal Exam Line-CS";
        StudentRankCS: Record "Student Rank-CS";
        InternalExamHeaderCS: Record "Internal Exam Header-CS";
        GradeCourseCS: Record "Grade Course-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        FirstRec: Code[20];
        LastRec: Code[20];


        InternalPercentage: Decimal;
    begin
        //Code Added for Update Internal Rank::CSPL-00067::200219:Start
        InternalExamHeaderCS.GET("getDocNo.");
        InternalExamHeaderCS.TESTFIELD("Course Code");
        InternalExamHeaderCS.TESTFIELD("Exam Group");

        StudentRankCS.Reset();
        StudentRankCS.DELETEALL();
        InternalExamLineCS.Reset();
        InternalExamLineCS.SETRANGE("Document No.", "getDocNo.");
        IF InternalExamLineCS.FINDSET() THEN
            REPEAT
                StudentRankCS.INIT();
                StudentRankCS."No." := InternalExamLineCS."Student No.";
                StudentRankCS.Average := InternalExamLineCS."Marks Obtained";
                StudentRankCS.INSERT(TRUE);
            UNTIL InternalExamLineCS.NEXT() = 0;

        StudentRankCS.Reset();
        StudentRankCS.FINDFIRST();
        FirstRec := StudentRankCS."Entry No.";
        StudentRankCS.Reset();
        StudentRankCS.FINDLAST();
        LastRec := StudentRankCS."Entry No.";

        VerticalEducationCS.RankCreation(FirstRec, LastRec);
        StudentRankCS.Reset();
        InternalExamLineCS.Reset();
        InternalExamLineCS.SETRANGE("Document No.", "getDocNo.");
        IF InternalExamLineCS.FINDSET() THEN
            REPEAT
                InternalPercentage := 0;
                IF InternalExamLineCS."Marks Obtained" <> 0 THEN BEGIN
                    InternalPercentage := (InternalExamLineCS."Marks Obtained" / InternalExamHeaderCS."Maximum Mark") * 100;
                    InternalExamLineCS.Rank := 0;
                    GradeCourseCS.Reset();
                    GradeCourseCS.SETRANGE(Course, InternalExamLineCS.Course);
                    GradeCourseCS.SETRANGE("Academic Year", InternalExamLineCS."Academic Year");
                    GradeCourseCS.SETFILTER("Max Percentage", '>=%1', InternalPercentage);
                    GradeCourseCS.SETFILTER("Min Percentage", '<=%1', InternalPercentage);
                    IF GradeCourseCS.FINDFIRST() THEN
                        InternalExamLineCS.Grade := GradeCourseCS.Code
                    ELSE
                        InternalExamLineCS.Grade := '';
                    IF StudentRankCS.GET(InternalExamLineCS."Student No.") THEN
                        InternalExamLineCS.Rank := StudentRankCS.Rank;
                    InternalExamLineCS.Modify();
                END;
            UNTIL InternalExamLineCS.NEXT() = 0;
        //Code Added for Update Internal Rank::CSPL-00067::200219:End
    end;

    procedure PublishStudentsInternalMarksCS(InternalExamHeaderCS: Record "Internal Exam Header-CS")
    var
        // MainStudentSubjectCS: Record "Main Student Subject-CS";
        // OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        InternalExamLineCS: Record "Internal Exam Line-CS";

    begin
        //Code Added for Publish Students Internal Marks::CSPL-00067::200219:Start
        IF InternalExamHeaderCS."Subject Type" = 'CORE' THEN BEGIN
            InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Published;
            InternalExamHeaderCS.Modify();

            InternalExamLineCS.Reset();
            InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
            InternalExamLineCS.SETRANGE("Marks Published", FALSE);
            IF InternalExamLineCS.FINDFIRST() THEN
                REPEAT

                    InternalExamLineCS."Marks Published" := TRUE;
                    InternalExamLineCS.Status := InternalExamLineCS.Status::"Published";
                    InternalExamLineCS.Modify();
                UNTIL InternalExamLineCS.NEXT() = 0
            ELSE
                ERROR('Marks Already Published !!');
        END ELSE BEGIN
            InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::"Published";
            InternalExamHeaderCS.Modify();

            InternalExamLineCS.Reset();
            InternalExamLineCS.SETRANGE("Document No.", InternalExamHeaderCS."No.");
            InternalExamLineCS.SETRANGE("Marks Published", FALSE);
            IF InternalExamLineCS.FINDFIRST() THEN
                REPEAT
                    InternalExamLineCS."Marks Published" := TRUE;
                    InternalExamLineCS.Status := InternalExamLineCS.Status::"Published";
                    InternalExamLineCS.Modify();
                UNTIL InternalExamLineCS.NEXT() = 0
            ELSE
                ERROR('Marks Already Published !!');
        END;

        //Code Added for Publish Students Internal Marks::CSPL-00067::200219:End
    end;

    procedure PublishStudentsAssignmentMarksCS(AssignmentHeader: Record "Class Assignment Header-CS")
    var
        // StudentSubject: Record "Main Student Subject-CS";
        // StudentOptionalSubject: Record "Optional Student Subject-CS";
        AssignmentLine: Record "Class Assignment Line-CS";
    // CourseCOLLEGE: Record "Course Master-CS";
    begin
        //Code Added for Publish Students Assignment Marks::CSPL-00067::200219:Start
        IF AssignmentHeader."Subject Type" = 'CORE' THEN BEGIN
            AssignmentHeader."Assignment Status" := AssignmentHeader."Assignment Status"::Published;
            AssignmentHeader.Modify();

            AssignmentLine.Reset();
            AssignmentLine.SETRANGE("Assignment No.", AssignmentHeader."Assignment No.");
            AssignmentLine.SETRANGE("Marks Published", FALSE);
            IF AssignmentLine.FINDFIRST() THEN
                REPEAT
                    AssignmentLine."Marks Published" := TRUE;
                    AssignmentLine.Modify();
                UNTIL AssignmentLine.NEXT() = 0
            ELSE
                ERROR('Marks Already Published !!');
        END ELSE BEGIN
            AssignmentHeader."Assignment Status" := AssignmentHeader."Assignment Status"::Published;
            AssignmentHeader.Modify();

            AssignmentLine.Reset();
            AssignmentLine.SETRANGE("Assignment No.", AssignmentHeader."Assignment No.");
            AssignmentLine.SETRANGE("Marks Published", FALSE);
            IF AssignmentLine.FINDFIRST() THEN
                REPEAT
                    AssignmentLine."Marks Published" := TRUE;
                    AssignmentLine.Modify();
                UNTIL AssignmentLine.NEXT() = 0
            ELSE
                ERROR('Marks Already Published !!');
        END;

        //Code Added for Publish Students Assignment Marks::CSPL-00067::200219:End
    end;

    procedure GetStudentsCS(ClassAssignmentHeaderCS: Record "Class Assignment Header-CS")
    var
        StudentMasterCS: Record "Student Master-CS";
        ClassAssignmentLineCS: Record "Class Assignment Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        ClassAssignmentLineCS1: Record "Class Assignment Line-CS";
        "LocalLineNo.": Integer;


    begin
        //Code Added for Get Students::CSPL-00067::200219:Start
        IF ClassAssignmentHeaderCS."Type Of Course" = ClassAssignmentHeaderCS."Type Of Course"::Semester THEN
            ClassAssignmentHeaderCS.TESTFIELD(Semester)
        ELSE
            ClassAssignmentHeaderCS.TESTFIELD(Year);
        ClassAssignmentHeaderCS.TESTFIELD("Program");
        ClassAssignmentHeaderCS.TESTFIELD("Academic Year");
        ClassAssignmentHeaderCS.TESTFIELD(Section);
        ClassAssignmentHeaderCS.TESTFIELD("Subject Class");
        ClassAssignmentHeaderCS.TESTFIELD("Subject Type");
        ClassAssignmentHeaderCS.TESTFIELD("Subject Code");
        ClassAssignmentHeaderCS.TESTFIELD("Global Dimension 1 Code");

        SubjectMasterCS.Reset();
        SubjectMasterCS.SETRANGE(Code, ClassAssignmentHeaderCS."Subject Code");
        IF SubjectMasterCS.FINDFIRST() THEN
            "LocalLineNo." := 0;
        IF ClassAssignmentHeaderCS."Subject Class" = 'THEORY' THEN BEGIN
            IF ClassAssignmentHeaderCS."Subject Type" = 'CORE' THEN BEGIN

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
                IF SubjectMasterCS."Subject Wise Examination" = FALSE THEN  //In Some Subject Student Will Come Subject,Secton wise
                    IF ClassAssignmentHeaderCS."Course Code" <> '' THEN
                        MainStudentSubjectCS.SETRANGE(Course, ClassAssignmentHeaderCS."Course Code");

                IF ClassAssignmentHeaderCS."Type Of Course" = ClassAssignmentHeaderCS."Type Of Course"::Semester THEN
                    MainStudentSubjectCS.SETRANGE(Semester, ClassAssignmentHeaderCS.Semester)
                ELSE
                    MainStudentSubjectCS.SETRANGE(Year, ClassAssignmentHeaderCS.Year);
                MainStudentSubjectCS.SETRANGE("Academic Year", ClassAssignmentHeaderCS."Academic Year");
                MainStudentSubjectCS.SETRANGE(Section, ClassAssignmentHeaderCS.Section);
                MainStudentSubjectCS.SETRANGE("Subject Class", ClassAssignmentHeaderCS."Subject Class");
                MainStudentSubjectCS.SETRANGE("Subject Type", ClassAssignmentHeaderCS."Subject Type");
                MainStudentSubjectCS.SETRANGE("Subject Code", ClassAssignmentHeaderCS."Subject Code");
                MainStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
                MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ClassAssignmentHeaderCS."Global Dimension 1 Code");
                IF MainStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                        StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                           StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            ClassAssignmentLineCS1.Reset();
                            ClassAssignmentLineCS1.SETRANGE("Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                            ClassAssignmentLineCS1.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                            IF ClassAssignmentLineCS1.ISEMPTY() then BEGIN
                                ClassAssignmentLineCS1.Reset();
                                ClassAssignmentLineCS1.SETRANGE("Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                                IF ClassAssignmentLineCS1.FINDLAST() THEN
                                    "LocalLineNo." := ClassAssignmentLineCS1."Line No." + 10000
                                ELSE
                                    "LocalLineNo." := 10000;

                                ClassAssignmentLineCS.INIT();
                                ClassAssignmentLineCS."Assignment No." := ClassAssignmentHeaderCS."Assignment No.";
                                ClassAssignmentLineCS."Line No." := "LocalLineNo.";
                                ClassAssignmentLineCS."Student No." := MainStudentSubjectCS."Student No.";
                                ClassAssignmentLineCS."Enrollment No." := MainStudentSubjectCS."Enrollment No";
                                ClassAssignmentLineCS."Type Of Course" := MainStudentSubjectCS."Type Of Course";
                                ClassAssignmentLineCS."Course Code" := MainStudentSubjectCS.Course;
                                ClassAssignmentLineCS.Semester := MainStudentSubjectCS.Semester;
                                ClassAssignmentLineCS."Student Name" := MainStudentSubjectCS."Student Name";
                                ClassAssignmentLineCS."Program" := MainStudentSubjectCS.Graduation;
                                ClassAssignmentLineCS."Student Group" := MainStudentSubjectCS.Group;
                                ClassAssignmentLineCS."Faculty Code" := ClassAssignmentHeaderCS."Faculty Code";
                                ClassAssignmentLineCS."Faculty Name" := ClassAssignmentHeaderCS."Faculty Name";
                                ClassAssignmentLineCS.Section := MainStudentSubjectCS.Section;
                                ClassAssignmentLineCS."Global Dimension 1 Code" := MainStudentSubjectCS."Global Dimension 1 Code";
                                ClassAssignmentLineCS."Global Dimension 2 Code" := MainStudentSubjectCS."Global Dimension 2 Code";
                                ClassAssignmentLineCS."Academic Year" := MainStudentSubjectCS."Academic Year";
                                ClassAssignmentLineCS."Maximum Mark" := ClassAssignmentHeaderCS."Maximum Mark";
                                ClassAssignmentLineCS."Maximum Weightage" := ClassAssignmentHeaderCS."Maximum Weightage";
                                ClassAssignmentLineCS."Subject Class" := MainStudentSubjectCS."Subject Class";
                                ClassAssignmentLineCS."Subject Type" := MainStudentSubjectCS."Subject Type";
                                ClassAssignmentLineCS."Subject Code" := MainStudentSubjectCS."Subject Code";
                                ClassAssignmentLineCS."Exam Group" := ClassAssignmentHeaderCS."Exam Group";
                                ClassAssignmentLineCS."Exam Method Code" := ClassAssignmentHeaderCS."Exam Method Code";
                                ClassAssignmentLineCS."Created By" := FORMAT(UserId());
                                ClassAssignmentLineCS."Created On" := TODAY();
                                ClassAssignmentLineCS.INSERT();
                            END;
                        END;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;

            END ELSE BEGIN
                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
                IF ClassAssignmentHeaderCS."Course Code" <> '' THEN
                    OptionalStudentSubjectCS.SETRANGE(Course, ClassAssignmentHeaderCS."Course Code");
                IF ClassAssignmentHeaderCS."Type Of Course" = ClassAssignmentHeaderCS."Type Of Course"::Semester THEN
                    OptionalStudentSubjectCS.SETRANGE(Semester, ClassAssignmentHeaderCS.Semester)
                ELSE
                    OptionalStudentSubjectCS.SETRANGE(Year, ClassAssignmentHeaderCS.Year);
                OptionalStudentSubjectCS.SETRANGE("Academic Year", ClassAssignmentHeaderCS."Academic Year");
                OptionalStudentSubjectCS.SETRANGE(Section, ClassAssignmentHeaderCS.Section);
                OptionalStudentSubjectCS.SETRANGE("Subject Class", ClassAssignmentHeaderCS."Subject Class");
                OptionalStudentSubjectCS.SETRANGE("Subject Type", ClassAssignmentHeaderCS."Subject Type");
                OptionalStudentSubjectCS.SETRANGE("Subject Code", ClassAssignmentHeaderCS."Subject Code");
                OptionalStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
                OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ClassAssignmentHeaderCS."Global Dimension 1 Code");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                        StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                          StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            ClassAssignmentLineCS1.Reset();
                            ClassAssignmentLineCS1.SETRANGE("Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                            ClassAssignmentLineCS1.SETRANGE("Student No.", OptionalStudentSubjectCS."Student No.");
                            IF ClassAssignmentLineCS1.ISEMPTY() then BEGIN
                                ClassAssignmentLineCS1.Reset();
                                ClassAssignmentLineCS1.SETRANGE("Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                                IF ClassAssignmentLineCS1.FINDLAST() THEN
                                    "LocalLineNo." := ClassAssignmentLineCS1."Line No." + 10000
                                ELSE
                                    "LocalLineNo." := 10000;

                                ClassAssignmentLineCS.INIT();
                                ClassAssignmentLineCS."Assignment No." := ClassAssignmentHeaderCS."Assignment No.";
                                ClassAssignmentLineCS."Line No." := "LocalLineNo.";
                                ClassAssignmentLineCS."Student No." := OptionalStudentSubjectCS."Student No.";
                                ClassAssignmentLineCS."Enrollment No." := OptionalStudentSubjectCS."Enrollment No";
                                ClassAssignmentLineCS."Type Of Course" := OptionalStudentSubjectCS."Type Of Course";
                                ClassAssignmentLineCS."Course Code" := OptionalStudentSubjectCS.Course;
                                ClassAssignmentLineCS.Semester := OptionalStudentSubjectCS.Semester;
                                ClassAssignmentLineCS."Student Name" := OptionalStudentSubjectCS."Student Name";
                                ClassAssignmentLineCS.Section := OptionalStudentSubjectCS.Section;
                                ClassAssignmentLineCS."Program" := OptionalStudentSubjectCS.Graduation;
                                ClassAssignmentLineCS."Student Group" := OptionalStudentSubjectCS.Group;
                                ClassAssignmentLineCS."Faculty Code" := ClassAssignmentHeaderCS."Faculty Code";
                                ClassAssignmentLineCS."Faculty Name" := ClassAssignmentHeaderCS."Faculty Name";
                                ClassAssignmentLineCS."Global Dimension 1 Code" := OptionalStudentSubjectCS."Global Dimension 1 Code";
                                ClassAssignmentLineCS."Global Dimension 2 Code" := OptionalStudentSubjectCS."Global Dimension 2 Code";
                                ClassAssignmentLineCS."Academic Year" := OptionalStudentSubjectCS."Academic Year";
                                ClassAssignmentLineCS."Maximum Mark" := ClassAssignmentHeaderCS."Maximum Mark";
                                ClassAssignmentLineCS."Maximum Weightage" := ClassAssignmentHeaderCS."Maximum Weightage";
                                ClassAssignmentLineCS."Subject Class" := OptionalStudentSubjectCS."Subject Class";
                                ClassAssignmentLineCS."Subject Type" := OptionalStudentSubjectCS."Subject Type";
                                ClassAssignmentLineCS."Subject Code" := OptionalStudentSubjectCS."Subject Code";
                                ClassAssignmentLineCS."Exam Group" := ClassAssignmentHeaderCS."Exam Group";
                                ClassAssignmentLineCS."Exam Method Code" := ClassAssignmentHeaderCS."Exam Method Code";
                                ClassAssignmentLineCS."Created By" := FORMAT(UserId());
                                ClassAssignmentLineCS."Created On" := TODAY();
                                ClassAssignmentLineCS.INSERT();
                            END;
                        END;
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;
            END;
        END ELSE BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year");
            IF SubjectMasterCS."Subject Wise Examination" = FALSE THEN //In Some Subject Student Will Come Subject,Secton wise
                IF ClassAssignmentHeaderCS."Course Code" <> '' THEN
                    MainStudentSubjectCS.SETRANGE(Course, ClassAssignmentHeaderCS."Course Code");
            IF ClassAssignmentHeaderCS."Type Of Course" = ClassAssignmentHeaderCS."Type Of Course"::Semester THEN
                MainStudentSubjectCS.SETRANGE(Semester, ClassAssignmentHeaderCS.Semester)
            ELSE
                MainStudentSubjectCS.SETRANGE(Year, ClassAssignmentHeaderCS.Year);
            MainStudentSubjectCS.SETRANGE("Academic Year", ClassAssignmentHeaderCS."Academic Year");
            MainStudentSubjectCS.SETRANGE(Section, ClassAssignmentHeaderCS.Section);
            MainStudentSubjectCS.SETRANGE(Batch, ClassAssignmentHeaderCS."Student Batch");
            MainStudentSubjectCS.SETRANGE("Subject Class", ClassAssignmentHeaderCS."Subject Class");
            MainStudentSubjectCS.SETRANGE("Subject Type", ClassAssignmentHeaderCS."Subject Type");
            MainStudentSubjectCS.SETRANGE("Subject Code", ClassAssignmentHeaderCS."Subject Code");
            MainStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
            MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ClassAssignmentHeaderCS."Global Dimension 1 Code");
            IF MainStudentSubjectCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                    StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                       StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                    IF StudentMasterCS.FINDFIRST() THEN BEGIN
                        ClassAssignmentLineCS1.Reset();
                        ClassAssignmentLineCS1.SETRANGE("Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                        ClassAssignmentLineCS1.SETRANGE("Student No.", MainStudentSubjectCS."Student No.");
                        IF ClassAssignmentLineCS1.ISEMPTY() then BEGIN
                            ClassAssignmentLineCS1.Reset();
                            ClassAssignmentLineCS1.SETRANGE("Assignment No.", ClassAssignmentHeaderCS."Assignment No.");
                            IF ClassAssignmentLineCS1.FINDLAST() THEN
                                "LocalLineNo." := ClassAssignmentLineCS1."Line No." + 10000
                            ELSE
                                "LocalLineNo." := 10000;

                            ClassAssignmentLineCS.INIT();
                            ClassAssignmentLineCS."Assignment No." := ClassAssignmentHeaderCS."Assignment No.";
                            ClassAssignmentLineCS."Line No." := "LocalLineNo.";
                            ClassAssignmentLineCS."Student No." := MainStudentSubjectCS."Student No.";
                            ClassAssignmentLineCS."Enrollment No." := MainStudentSubjectCS."Enrollment No";
                            ClassAssignmentLineCS."Type Of Course" := MainStudentSubjectCS."Type Of Course";
                            ClassAssignmentLineCS."Course Code" := MainStudentSubjectCS.Course;
                            ClassAssignmentLineCS.Semester := MainStudentSubjectCS.Semester;
                            ClassAssignmentLineCS."Student Name" := MainStudentSubjectCS."Student Name";
                            ClassAssignmentLineCS.Section := MainStudentSubjectCS.Section;
                            ClassAssignmentLineCS."Faculty Code" := ClassAssignmentHeaderCS."Faculty Code";
                            ClassAssignmentLineCS."Faculty Name" := ClassAssignmentHeaderCS."Faculty Name";
                            ClassAssignmentLineCS."Program" := MainStudentSubjectCS.Graduation;
                            ClassAssignmentLineCS."Student Group" := MainStudentSubjectCS.Group;
                            ClassAssignmentLineCS."Student Batch" := MainStudentSubjectCS.Batch;
                            ClassAssignmentLineCS."Global Dimension 1 Code" := MainStudentSubjectCS."Global Dimension 1 Code";
                            ClassAssignmentLineCS."Global Dimension 2 Code" := MainStudentSubjectCS."Global Dimension 2 Code";
                            ClassAssignmentLineCS."Academic Year" := MainStudentSubjectCS."Academic Year";
                            ClassAssignmentLineCS."Maximum Mark" := ClassAssignmentHeaderCS."Maximum Mark";
                            ClassAssignmentLineCS."Maximum Weightage" := ClassAssignmentHeaderCS."Maximum Weightage";
                            ClassAssignmentLineCS."Subject Class" := MainStudentSubjectCS."Subject Class";
                            ClassAssignmentLineCS."Subject Type" := MainStudentSubjectCS."Subject Type";
                            ClassAssignmentLineCS."Subject Code" := MainStudentSubjectCS."Subject Code";
                            ClassAssignmentLineCS."Exam Group" := ClassAssignmentHeaderCS."Exam Group";
                            ClassAssignmentLineCS."Exam Method Code" := ClassAssignmentHeaderCS."Exam Method Code";
                            ClassAssignmentLineCS."Created By" := FORMAT(UserId());
                            ClassAssignmentLineCS."Created On" := TODAY();
                            ClassAssignmentLineCS.INSERT();
                        END;
                    END;
                UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;
        //Code Added for Get Students::CSPL-00067::200219:End
    end;
}

