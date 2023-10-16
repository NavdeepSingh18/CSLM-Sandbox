codeunit 50031 "Calendar Generation-CS"
{
    // version V.001-CS

    // Sr.   NoEmp.ID   Date     Trigger                                       Remark
    // -----------------------------------------------------------------------------------------------
    // 1    CSPL-00059   22-02-19CreateTimeTable                  Code added for create time table.
    // 2    CSPL-00059   22-02-19CreateProgramHours              Code added for create program hours
    // 3    CSPL-00059   22-02-19AssignPracticalHours            Code added for assingn practical hours
    // 4    CSPL-00059   22-02-19RetrivestaffDetail              Code added for get staff detail
    // 5    CSPL-00059   22-02-19CheckStaffAvailability          Code added for check staff availability.
    // 6    CSPL-00059   22-02-19ModifyTimeTable                  Code added for modify time table
    // 7    CSPL-00059   22-02-19ValidateStaffHours              Code added for validate staff hours
    // 8    CSPL-00059   22-02-19AllowTheroyHours                Code added for allow theroy hours
    // 9    CSPL-00059   22-02-19AllowPreferenceHours            Code added for allow preferance hours
    // 10  CSPL-00059   22-02-19ValidateCombClass                Code added for validate combined class


    trigger OnRun()
    begin
    end;

    var
        TimeTableSetupCS: Record "Time Table Setup-CS";
        PeriodHeaderCS: Record "Period Header-CS";
        PeriodLineCS: Record "Period Line-CS";
        "IntEntryNo.": Integer;

        ArrLabHour: array[50] of Integer;
        Text000Lbl: Label 'Select the Academic Year';
        Text001Lbl: Label 'Faculty Subject Has Not Assigned for the Course %1 Sem %2 Subject %3';
        Text002Lbl: Label 'Time Table Cannot Be Generated for the Course %1 Sem %2 Subject %3';
        Text003Lbl: Label 'Select the Semester Type';
        Text004Lbl: Label 'No Course Has Been Selected Based on The setup';
        Text005Lbl: Label 'Generation Not Completed';

    procedure CreateTimeTable(AcademicYear: Code[20]; optSemType: Option " ",Odd,Even)
    var
        GeneratedTimeTableCS: Record "Generated Time Table-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        FacultyDetailSubjWiseCS: Record "Faculty Detail Subj Wise-CS";
        CourseMasterCS: Record "Course Master-CS";
        SemesterMasterCS: Record "Semester Master-CS";

        //CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
        IntTotweekHours: Integer;
        IntPeriod: Integer;

        IntGenerated: Integer;
        IntTotCourseHours: Integer;
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start

        IF AcademicYear = '' THEN
            ERROR(Text000Lbl);
        IF optSemType = optSemType::" " THEN
            ERROR(Text003Lbl);

        TimeTableSetupCS.FINDFIRST();

        GeneratedTimeTableCS.Reset();
        IF GeneratedTimeTableCS.FINDFIRST() THEN
            GeneratedTimeTableCS.DELETEALL();

        IntTotweekHours := 0;
        IF PeriodHeaderCS.FINDFIRST() THEN BEGIN
            IF PeriodHeaderCS."No.Of Periods/Half Day" <> 0 THEN BEGIN
                IntTotweekHours := (PeriodHeaderCS."Working Days Per Week" - 1) * PeriodHeaderCS."No.Of Periods/Day";
                IntTotweekHours += PeriodHeaderCS."No.Of Periods/Half Day";
            END ELSE
                IntTotweekHours := PeriodHeaderCS."Working Days Per Week" * PeriodHeaderCS."No.Of Periods/Day";

            IntPeriod := 1;
            PeriodLineCS.Reset();
            PeriodLineCS.SETCURRENTKEY(Code, "Lab Start Hour");
            PeriodLineCS.SETRANGE(Code, PeriodHeaderCS.Code);
            PeriodLineCS.SETRANGE("Lab Start Hour", TRUE);
            IF PeriodLineCS.FINDSET() THEN
                REPEAT
                    EVALUATE(ArrLabHour[IntPeriod], PeriodLineCS.Period);
                    IntPeriod += 1;
                UNTIL PeriodLineCS.NEXT() = 0;
        END;

        IF CourseWiseSubjectLineCS.FINDFIRST() THEN
            CourseWiseSubjectLineCS.MODIFYALL(Selected, FALSE);

        IF FacultyDetailSubjWiseCS.FINDFIRST() THEN
            FacultyDetailSubjWiseCS.MODIFYALL(Available, TRUE);

        "IntEntryNo." := 1;
        IntGenerated := 0;
        IF CourseMasterCS.FINDSET() THEN
            REPEAT
                SemesterMasterCS.Reset();
                IF optSemType = optSemType::Odd THEN
                    SemesterMasterCS.SETFILTER(Code, '%1|%2|%3', 'I', 'III', 'V')
                ELSE
                    IF optSemType = optSemType::Even THEN
                        SemesterMasterCS.SETFILTER(Code, '%1|%2|%3', 'II', 'IV', 'VI');
                IF SemesterMasterCS.FINDSET() THEN
                    REPEAT
                        IntTotCourseHours := 0;
                        CourseWiseSubjectLineCS.Reset();
                        CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseMasterCS.Code);
                        CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterMasterCS.Code);
                        IF CourseWiseSubjectLineCS.FINDSET() THEN
                            REPEAT
                                IntTotCourseHours += CourseWiseSubjectLineCS."Weekly Hours";
                            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                        IF IntTotCourseHours = IntTotweekHours THEN
                            IntGenerated += 1;
                    UNTIL SemesterMasterCS.NEXT() = 0;
            UNTIL CourseMasterCS.NEXT() = 0;

        IF IntGenerated = 0 THEN
            MESSAGE(Text004Lbl)
        ELSE
            MESSAGE(Text005Lbl);
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure CreateProgramHours(CourseMasterCS: Record "Course Master-CS"; SemesterMasterCS: Record "Semester Master-CS"; AcademicYear: Code[20])
    var
        GeneratedTimeTableCS: Record "Generated Time Table-CS";
        IntRow: Integer;
        IntCol: Integer;

    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        FOR IntRow := 1 TO PeriodHeaderCS."Working Days Per Week" DO
            FOR IntCol := 1 TO PeriodHeaderCS."No.Of Periods/Day" DO BEGIN
                GeneratedTimeTableCS.INIT();
                GeneratedTimeTableCS."Entry No." := "IntEntryNo.";
                GeneratedTimeTableCS."Course Code" := CourseMasterCS.Code;
                GeneratedTimeTableCS."Semester Code" := SemesterMasterCS.Code;
                GeneratedTimeTableCS."Day No" := IntRow;
                GeneratedTimeTableCS."Hour No" := IntCol;
                GeneratedTimeTableCS."Academic Year" := AcademicYear;
                GeneratedTimeTableCS.INSERT();
                "IntEntryNo." += 1;

            END;


        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure AssignPracticalHours(CourseMasterCS: Record "Course Master-CS"; SemesterMasterCS: Record "Semester Master-CS"; IntMaxLab: Integer; IntLabLength: Integer)
    var

        GeneratedTimeTableCS: Record "Generated Time Table-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        IntLabTotHour: Integer;
        IntOldLabHour: Integer;
        IntMaxTimes: Integer;
        IntLabHour: Integer;
        IntVal: Integer;
        BlCheck: Boolean;
        IntTempHour: Integer;
        IntIterator: Integer;
        FacultyCode: Code[20];
        IntDay: Integer;

    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        IntDay := 1;
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Classification");
        CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseMasterCS.Code);
        CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterMasterCS.Code);
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", TimeTableSetupCS."Time Table Lab Code");
        IF CourseWiseSubjectLineCS.FINDSET() THEN
            REPEAT
                IntLabTotHour := CourseWiseSubjectLineCS."Weekly Hours";
                IF CourseWiseSubjectLineCS."Max Hours Per Day" <> 0 THEN
                    IntMaxLab := CourseWiseSubjectLineCS."Max Hours Per Day";

                IntOldLabHour := 0;
                IntMaxTimes := 0;
                IntLabHour := 0;
                WHILE IntLabTotHour > 0 DO BEGIN
                    IF IntOldLabHour <> IntLabHour THEN
                        IntOldLabHour := IntLabHour
                    ELSE
                        IF IntMaxTimes = 150 THEN
                            ERROR(Text002Lbl, CourseMasterCS.Code,
                              SemesterMasterCS.Code, CourseWiseSubjectLineCS."Subject Code")
                        ELSE
                            IntMaxTimes += 1;


                    IntVal := RANDOM(IntLabLength);
                    IntLabHour := ArrLabHour[IntVal];

                    IF IntLabTotHour < IntMaxLab THEN
                        IntMaxLab := IntLabTotHour;

                    BlCheck := FALSE;
                    IntTempHour := IntLabHour;
                    FOR IntIterator := 1 TO IntMaxLab DO BEGIN
                        GeneratedTimeTableCS.Reset();
                        GeneratedTimeTableCS.SETCURRENTKEY("Course Code", "Semester Code", "Day No", "Hour No", "Subject Code");
                        GeneratedTimeTableCS.SETRANGE("Course Code", CourseMasterCS.Code);
                        GeneratedTimeTableCS.SETRANGE("Semester Code", SemesterMasterCS.Code);
                        GeneratedTimeTableCS.SETRANGE("Day No", IntDay);
                        GeneratedTimeTableCS.SETRANGE("Hour No", IntTempHour);
                        GeneratedTimeTableCS.SETFILTER("Subject Code", '<>%1', '');
                        IF GeneratedTimeTableCS.COUNT() = 1 THEN
                            BlCheck := TRUE;
                        IntTempHour += 1;
                    END;

                    IF NOT BlCheck THEN BEGIN
                        FacultyCode := RetrivestaffDetail(CourseMasterCS.Code, SemesterMasterCS.Code, CourseWiseSubjectLineCS."Subject Code");
                        IF FacultyCode = '' THEN
                            ERROR(Text001Lbl, CourseMasterCS.Code, SemesterMasterCS.Code, CourseWiseSubjectLineCS."Subject Code");
                        FOR IntIterator := 1 TO IntMaxLab DO BEGIN
                            IF (FacultyCode <> '') AND
                               CheckStaffAvailability(IntDay, IntLabHour, FacultyCode)
                            THEN
                                ModifyTimeTable(CourseMasterCS.Code, SemesterMasterCS.Code, IntDay, IntLabHour, CourseWiseSubjectLineCS."Subject Code", FacultyCode);
                            IntLabHour += 1;
                        END;
                        IntLabTotHour := IntLabTotHour - IntMaxLab;
                    END;

                    IntDay += 1;
                    IF IntDay = PeriodHeaderCS."Working Days Per Week" + 1 THEN
                        IntDay := 1;
                END;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure RetrivestaffDetail(CrsCode: Code[20]; SemCode: Code[10]; SubjCode: Code[20]): Code[20]
    var
        FacultyDetailSubjWiseCS: Record "Faculty Detail Subj Wise-CS";
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        FacultyDetailSubjWiseCS.Reset();
        FacultyDetailSubjWiseCS.SETCURRENTKEY("Course Code", "Semester Code", "Subject Code", Available);
        FacultyDetailSubjWiseCS.SETRANGE("Course Code", CrsCode);
        FacultyDetailSubjWiseCS.SETRANGE("Semester Code", SemCode);
        FacultyDetailSubjWiseCS.SETRANGE("Subject Code", SubjCode);
        FacultyDetailSubjWiseCS.SETRANGE(Available, TRUE);
        IF FacultyDetailSubjWiseCS.FINDFIRST() THEN
            EXIT(FacultyDetailSubjWiseCS."Faculty Code");
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure CheckStaffAvailability(DayNum: Integer; HourNum: Integer; FacultyCode: Code[20]): Boolean
    var
        GeneratedTimeTableCS1: Record "Generated Time Table-CS";
        BlAvailable: Boolean;
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        BlAvailable := TRUE;
        GeneratedTimeTableCS1.Reset();
        GeneratedTimeTableCS1.SETCURRENTKEY("Day No", "Hour No", "Faculty Code");
        GeneratedTimeTableCS1.SETRANGE("Day No", DayNum);
        GeneratedTimeTableCS1.SETRANGE("Hour No", HourNum);
        GeneratedTimeTableCS1.SETRANGE("Faculty Code", FacultyCode);
        IF GeneratedTimeTableCS1.FINDFIRST() THEN
            BlAvailable := FALSE;
        EXIT(BlAvailable);
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure ModifyTimeTable(CrsCode: Code[20]; SemCode: Code[10]; DayNum: Integer; HourNum: Integer; SubjCode: Code[20]; FacultyCode: Code[20])
    var
        GeneratedTimeTableCS: Record "Generated Time Table-CS";
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        GeneratedTimeTableCS.Reset();
        GeneratedTimeTableCS.SETCURRENTKEY("Course Code", "Semester Code", "Day No", "Hour No", "Subject Code");
        GeneratedTimeTableCS.SETRANGE("Course Code", CrsCode);
        GeneratedTimeTableCS.SETRANGE("Semester Code", SemCode);
        GeneratedTimeTableCS.SETRANGE("Day No", DayNum);
        GeneratedTimeTableCS.SETRANGE("Hour No", HourNum);
        IF GeneratedTimeTableCS.FINDFIRST() THEN BEGIN
            GeneratedTimeTableCS."Subject Code" := SubjCode;
            GeneratedTimeTableCS."Faculty Code" := FacultyCode;
            GeneratedTimeTableCS.Modify();
            ValidateStaffHours(CrsCode, SemCode, SubjCode, FacultyCode);
        END;
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure ValidateStaffHours(CrsCode: Code[20]; SemCode: Code[10]; SubjCode: Code[20]; FacultyCode: Code[20])
    var
        GeneratedTimeTableCS: Record "Generated Time Table-CS";
        FacultyDetailSubjWiseCS: Record "Faculty Detail Subj Wise-CS";
        IntFacultyAlloted: Integer;
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        FacultyDetailSubjWiseCS.Reset();
        FacultyDetailSubjWiseCS.SETCURRENTKEY("Course Code", "Semester Code", "Subject Code", Available);
        FacultyDetailSubjWiseCS.SETRANGE("Course Code", CrsCode);
        FacultyDetailSubjWiseCS.SETRANGE("Semester Code", SemCode);
        FacultyDetailSubjWiseCS.SETRANGE("Subject Code", SubjCode);
        IF FacultyDetailSubjWiseCS.FINDFIRST() THEN BEGIN
            IntFacultyAlloted := FacultyDetailSubjWiseCS."Alloted Hours";

            GeneratedTimeTableCS.Reset();
            GeneratedTimeTableCS.SETCURRENTKEY("Course Code", "Semester Code", "Subject Code", "Faculty Code");
            GeneratedTimeTableCS.SETRANGE("Course Code", CrsCode);
            GeneratedTimeTableCS.SETRANGE("Semester Code", SemCode);
            GeneratedTimeTableCS.SETRANGE("Subject Code", SubjCode);
            GeneratedTimeTableCS.SETRANGE("Faculty Code", FacultyCode);
            IF IntFacultyAlloted >= GeneratedTimeTableCS.COUNT() THEN BEGIN
                FacultyDetailSubjWiseCS.Available := FALSE;
                FacultyDetailSubjWiseCS.Modify();
            END;
        END;
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure AllowTheroyHours(CourseMasterCS: Record "Course Master-CS"; SemesterMasterCS: Record "Semester Master-CS")
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        GeneratedTimeTableCS: Record "Generated Time Table-CS";
        // CdeSubject: Code[20];
        FacultyCode: Code[20];
        IntDay: Integer;

        IntTotTheory: Integer;
        IntOldTheoryHour: Integer;
        IntMaxTimes: Integer;
        ArrFreeHours: array[50] of Integer;
        IntFree: Integer;

        IntVal: Integer;
        IntTheory: Integer;
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        // Assigned Preference Hours Subjects
        AllowPreferenceHours(CourseMasterCS.Code, SemesterMasterCS.Code);
        ValidateCombClass(CourseMasterCS.Code, SemesterMasterCS.Code);
        IntDay := 1;

        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Classification", Selected);
        CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseMasterCS.Code);
        CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterMasterCS.Code);
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", TimeTableSetupCS."Time Table Theory Code");
        CourseWiseSubjectLineCS.SETRANGE(Selected, FALSE);
        IF CourseWiseSubjectLineCS.FINDSET() THEN
            REPEAT
                IntTotTheory := CourseWiseSubjectLineCS."Weekly Hours";
                IntOldTheoryHour := 0;
                IntMaxTimes := 0;
                WHILE IntTotTheory > 0 DO BEGIN
                    IF IntOldTheoryHour <> IntTotTheory THEN
                        IntOldTheoryHour := IntTotTheory
                    ELSE
                        IF IntMaxTimes = 150 THEN
                            ERROR(Text002Lbl, CourseMasterCS.Code, SemesterMasterCS.Code, CourseWiseSubjectLineCS."Subject Code")
                        ELSE
                            IntMaxTimes += 1;


                    CLEAR(ArrFreeHours);
                    IntFree := 1;

                    GeneratedTimeTableCS.Reset();
                    GeneratedTimeTableCS.SETCURRENTKEY("Course Code", "Semester Code", "Day No", "Hour No", "Subject Code");
                    GeneratedTimeTableCS.SETRANGE("Course Code", CourseMasterCS.Code);
                    GeneratedTimeTableCS.SETRANGE("Semester Code", SemesterMasterCS.Code);
                    GeneratedTimeTableCS.SETRANGE("Day No", IntDay);
                    GeneratedTimeTableCS.SETRANGE("Subject Code", '');
                    IF GeneratedTimeTableCS.FINDFIRST() THEN
                        REPEAT
                            ArrFreeHours[IntFree] := GeneratedTimeTableCS."Hour No";
                            IntFree += 1;
                        UNTIL GeneratedTimeTableCS.NEXT() = 0;

                    IF IntFree > 1 THEN BEGIN

                        IntVal := RANDOM(IntFree - 1);
                        IntTheory := ArrFreeHours[IntVal];

                        FacultyCode := RetrivestaffDetail(CourseMasterCS.Code, SemesterMasterCS.Code, CourseWiseSubjectLineCS."Subject Code");
                        IF (FacultyCode <> '') AND CheckStaffAvailability(IntDay, IntTheory, FacultyCode) THEN BEGIN
                            ModifyTimeTable(CourseMasterCS.Code, SemesterMasterCS.Code, IntDay, IntTheory, CourseWiseSubjectLineCS."Subject Code", FacultyCode);
                            IntTotTheory -= 1;
                        END ELSE
                            IF FacultyCode = '' THEN
                                ERROR(Text001Lbl, CourseMasterCS.Code, SemesterMasterCS.Code, CourseWiseSubjectLineCS."Subject Code");
                    END;
                    IntDay += 1;
                    IF IntDay = PeriodHeaderCS."Working Days Per Week" + 1 THEN
                        IntDay := 1;
                END;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure AllowPreferenceHours(CrsCode: Code[20]; SemCode: Code[10])
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        IntPreferHour: Integer;
        IntLoop: Integer;
        FacultyCode: Code[20];

        IntTottheory: Integer;
        IntDay: Integer;
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Classification", "Preference Hours", Selected);
        CourseWiseSubjectLineCS.SETRANGE("Course Code", CrsCode);
        CourseWiseSubjectLineCS.SETRANGE(Semester, SemCode);
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", TimeTableSetupCS."Time Table Theory Code");
        CourseWiseSubjectLineCS.SETFILTER("Preference Hours", '<>%1', '');
        CourseWiseSubjectLineCS.SETRANGE(Selected, FALSE);
        IF CourseWiseSubjectLineCS.FINDFIRST() THEN
            REPEAT
                FacultyCode := RetrivestaffDetail(CrsCode, SemCode, CourseWiseSubjectLineCS."Subject Code");
                IntTottheory := CourseWiseSubjectLineCS."Weekly Hours";
                IntDay := 1;
                IntLoop := 1;
                WHILE IntTottheory > 0 DO BEGIN
                    IF IntLoop = 1 THEN
                        EVALUATE(IntPreferHour, SELECTSTR(1, CourseWiseSubjectLineCS."Preference Hours"))
                    ELSE
                        IF IntLoop = 2 THEN
                            EVALUATE(IntPreferHour, SELECTSTR(2, CourseWiseSubjectLineCS."Preference Hours"));

                    IF (FacultyCode <> '') AND CheckStaffAvailability(IntDay, IntPreferHour, FacultyCode) THEN
                        ModifyTimeTable(CrsCode, SemCode, IntDay, IntPreferHour, CourseWiseSubjectLineCS."Subject Code", FacultyCode);

                    IntTottheory -= 1;
                    IntDay += 1;
                    IF IntDay = PeriodHeaderCS."Working Days Per Week" + 1 THEN BEGIN
                        IntDay := 1;
                        IntLoop := 2;
                    END;
                END;
                CourseWiseSubjectLineCS.Selected := TRUE;
                CourseWiseSubjectLineCS.Modify();
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        //Code added for create time table.::CSPL-00059::22022019: End
    end;

    procedure ValidateCombClass(CrsCode: Code[20]; SemCode: Code[10])
    var
    /* JobQueueMailIDsCS: Record "User Group-CS";
     JobQueueMailIDsCS1: Record "Job Queue Mail IDs-CS";
     GeneratedTimeTableCS: Record "Generated Time Table-CS";
     CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
     IntValue: Integer;
     FacultyCode: Code[20];

     IntDay: Integer;
     IntTheory: Integer;*/
    begin
        //Code added for create time table.::CSPL-00059::22022019: Start
        /*
        IntValue := 0;
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code",Semester,"Subject Classification");
        CourseWiseSubjectLineCS.SETRANGE("Course Code",CrsCode);
        CourseWiseSubjectLineCS.SETRANGE(Semester,SemCode);
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification",TimeTableSetupCS."Time Table Theory Code");
        CourseWiseSubjectLineCS.SETRANGE(Selected,FALSE);
        IF CourseWiseSubjectLineCS.FINDSET()THEN
          REPEAT
            FacultyCode := RetrivestaffDetail(CrsCode,SemCode,CourseWiseSubjectLineCS."Subject Code");
            JobQueueMailIDsCS.Reset();
            JobQueueMailIDsCS.SETCURRENTKEY(Course,Semester,"Primary Key");
            JobQueueMailIDsCS.SETRANGE(Course,CrsCode);
            JobQueueMailIDsCS.SETRANGE(Semester,SemCode);
            JobQueueMailIDsCS.SETRANGE("Primary Key",CourseWiseSubjectLineCS."Subject Code");
            IF JobQueueMailIDsCS.FINDFIRST()THEN BEGIN
              JobQueueMailIDsCS1.Reset();
              JobQueueMailIDsCS1.SETRANGE("ComClass Code",JobQueueMailIDsCS."ComClass Code");
              JobQueueMailIDsCS1.SETFILTER(Course,'<>%1',JobQueueMailIDsCS.Course);
              IF JobQueueMailIDsCS1.FINDFIRST()THEN BEGIN
                GeneratedTimeTableCS.Reset();
                GeneratedTimeTableCS.SETCURRENTKEY("Course Code","Semester Code","Subject Code","Faculty Code");
                GeneratedTimeTableCS.SETRANGE("Course Code",JobQueueMailIDsCS1.Course);
                GeneratedTimeTableCS.SETRANGE("Semester Code",JobQueueMailIDsCS1.Semester);
                GeneratedTimeTableCS.SETRANGE("Subject Code",JobQueueMailIDsCS1."Primary Key");
                IF GeneratedTimeTableCS.FINDFIRST()THEN
                  REPEAT
                    IF (FacultyCode <> '') AND CheckFacultyAvailability(IntDay,IntTheory,FacultyCode) THEN
                      UpdateTimeTable(CrsCode,SemCode,GeneratedTimeTableCS."Day No",GeneratedTimeTableCS."Hour No",
                        CourseWiseSubjectLineCS."Subject Code",FacultyCode);
                    IntValue := 1;
                  UNTIL GeneratedTimeTableCS.NEXT() = 0;
              END;
            END;
            IF IntValue = 1 THEN BEGIN
              CourseWiseSubjectLineCS.Selected := TRUE;
              CourseWiseSubjectLineCS.Modify();
            END;
          UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        //Code added for create time table.::CSPL-00059::22022019: End
        */

    end;
}

