codeunit 50017 "Student Sub. Old Rec-CS"
{
    // version V.001-CS

    // Sr.NoEmp.ID       Date      Trigger                                       Remark
    // -----------------------------------------------------------------------------------------------------------------
    // 1    CSPL-00059   22-02-19CreateStudentSubjectOldData                     Code added for create student subject detail.
    // 2    CSPL-00059   22-02-19CreateStudentOptionalSubjectOldData              Code added for create student optional subject detail
    // 3    CSPL-00059   22-02-19CalculateGPAProcess                             Code added for  calculate GPA
    // 4    CSPL-00059   22-02-19CalculateCGPAProcess                           Code added for  calculate CGPA
    // 5    CSPL-00059   22-02-19CalculateCreditEarnedProcess                   Code added for  calculate earn credit
    // 6    CSPL-00059   22-02-19Re-RegistrationFieldBlankProcess               Code added for clear the field for re- registration
    // 7    CSPL-00059   22-02-19Re-RegistrationExamUnTickProcess               Code added for clear the field for re- registration set to false
    // 8    CSPL-00059   22-02-19Make-UpExamUnTickProcess                       Code added for clear the field for makeup set to false
    // 9    CSPL-00059   22-02-19Revaluation1ExamUnTickProcess                   Code added for clear the field for Revaluation set to false
    // 10  CSPL-00059   22-02-19Revaluation2ExamUnTickProcess                   Code added for clear the field for Revaluation second set to false
    // 11  CSPL-00059   22-02-19UpdateElectiveSubjectRollNo                     Code added for update roll no in elective subject
    // 12  CSPL-00059   22-02-19UpdateRe-RegistrationSubjectRollNo             Code added for update roll no in Re-Registration student
    // 13  CSPL-00059   22-02-19CalculateRankSemesterWise                       Code added for calculate rank sem wise
    // 14  CSPL-00059   22-02-19CalculateOverallRank                           Code added for calculate over all rank
    // 15  CSPL-00059   22-02-19GradeReportRegular&Repeater                     Code added for calculate grade regular and repeate
    // 16  CSPL-00059   22-02-19ElectivePre-RegistrationAllocation             Code added for elective subject pre registration
    // 17  CSPL-00059   22-02-19Re-RegistrationExamOnlyUnTickProcess           Code added for set to false on registration
    // 18  CSPL-00059   22-02-19SpecialExamUnTickProcess                       Code added for set to false on special exam
    // 19  CSPL-00059   22-02-19CalculateAttendanceForExamWithAddCredit         Code added for calculate attendance for exam with add credit


    trigger OnRun()
    begin
    end;

    var

        StudentMasterCS: Record "Student Master-CS";
        ABCD: Integer;
        ABCD1: Integer;
        Text_10001Lbl: Label 'Do You Want To Update Student GPA ?';
        Text_10002Lbl: Label 'Do You Want To Update Student CGPA ?';
        Text_10003Lbl: Label 'Do You Want To Update Student Credit Earned?';
        Sub: Code[20];
        Section1: Code[10];
        RollNum: Integer;
        Enroll: Code[20];
        Enroll1: Code[20];
        RollNum1: Integer;


    procedure CreateStudentSubjectOldData()
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainOptionalSubArchiveCS: Record "Main&Optional Sub Archive-CS";
        MainOptionalSubArchiveCS1: Record "Main&Optional Sub Archive-CS";

        LineNo: Integer;

    begin
        //Code added for create student subject detail.::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Re-Registration", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN
            REPEAT
                MainOptionalSubArchiveCS.Reset();
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS."Student No.", MainStudentSubjectCS."Student No.");
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS."Subject Code", MainStudentSubjectCS."Subject Code");
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS."Academic Year", MainStudentSubjectCS."Academic Year");
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS.Semester, MainStudentSubjectCS.Semester);
                IF NOT MainOptionalSubArchiveCS.FINDFIRST() THEN BEGIN

                    MainOptionalSubArchiveCS1.Reset();
                    MainOptionalSubArchiveCS1.SETRANGE(MainOptionalSubArchiveCS1."Student No.", MainStudentSubjectCS."Student No.");
                    MainOptionalSubArchiveCS1.SETRANGE(MainOptionalSubArchiveCS1."Academic Year", MainStudentSubjectCS."Academic Year");
                    MainOptionalSubArchiveCS1.SETRANGE(MainOptionalSubArchiveCS1.Semester, MainStudentSubjectCS.Semester);
                    IF MainOptionalSubArchiveCS1.FINDLAST() THEN
                        LineNo := MainOptionalSubArchiveCS1."Line No" + 10000
                    ELSE
                        LineNo := 10000;

                    MainOptionalSubArchiveCS.INIT();
                    MainOptionalSubArchiveCS."Student No." := MainStudentSubjectCS."Student No.";
                    MainOptionalSubArchiveCS."Line No" := LineNo;
                    MainOptionalSubArchiveCS."Enrollment No" := MainStudentSubjectCS."Enrollment No";
                    MainOptionalSubArchiveCS."Subject Code" := MainStudentSubjectCS."Subject Code";
                    MainOptionalSubArchiveCS.Description := MainStudentSubjectCS.Description;
                    MainOptionalSubArchiveCS."Actual Subject Code" := MainStudentSubjectCS."Actual Subject Code";
                    MainOptionalSubArchiveCS."Actual Subject Description" := MainStudentSubjectCS."Actual Subject Description";
                    MainOptionalSubArchiveCS.Credit := MainStudentSubjectCS.Credit;
                    MainOptionalSubArchiveCS."Credit Earned" := MainStudentSubjectCS."Credit Earned";
                    MainOptionalSubArchiveCS."Credit Grade Points Earned" := MainStudentSubjectCS."Credit Grade Points Earned";
                    MainOptionalSubArchiveCS."Attendance Percentage" := MainStudentSubjectCS."Attendance Percentage";
                    MainOptionalSubArchiveCS."Subject Type" := MainStudentSubjectCS."Subject Type";
                    MainOptionalSubArchiveCS."Subject Class" := MainStudentSubjectCS."Subject Class";
                    MainOptionalSubArchiveCS.Course := MainStudentSubjectCS.Course;
                    MainOptionalSubArchiveCS.Section := MainStudentSubjectCS.Section;
                    MainOptionalSubArchiveCS."Academic Year" := MainStudentSubjectCS."Academic Year";
                    MainOptionalSubArchiveCS.Semester := MainStudentSubjectCS.Semester;
                    MainOptionalSubArchiveCS.Grade := MainStudentSubjectCS.Grade;
                    MainOptionalSubArchiveCS."Attendance Type" := MainStudentSubjectCS."Attendance Type";
                    MainOptionalSubArchiveCS."Internal Mark" := MainStudentSubjectCS."Internal Mark";
                    MainOptionalSubArchiveCS."Total Internal" := MainStudentSubjectCS."Total Internal";
                    MainOptionalSubArchiveCS."External Mark" := MainStudentSubjectCS."External Mark";
                    MainOptionalSubArchiveCS."Re-Registration Date" := MainStudentSubjectCS."Re-Registration Date";
                    MainOptionalSubArchiveCS.Total := MainStudentSubjectCS.Total;
                    MainOptionalSubArchiveCS.INSERT();
                END;
            UNTIL MainStudentSubjectCS.NEXT() = 0;

        //Code added for create student subject detail.::CSPL-00059::22022019: End
    end;

    procedure CreateStudentOptionalSubjectOldData()
    var

        MainOptionalSubArchiveCS: Record "Main&Optional Sub Archive-CS";
        MainOptionalSubArchiveCS1: Record "Main&Optional Sub Archive-CS";
        // MainOptionalSubArchiveCS2: Record "Main&Optional Sub Archive-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        LineNo: Integer;
    begin
        //Code added for create student optional subject detail::CSPL-00059::22022019: Start
        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE("Re-Registration", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN
            REPEAT
                MainOptionalSubArchiveCS.Reset();
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS."Student No.", OptionalStudentSubjectCS."Student No.");
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS."Subject Code", OptionalStudentSubjectCS."Subject Code");
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS."Academic Year", OptionalStudentSubjectCS."Academic Year");
                MainOptionalSubArchiveCS.SETRANGE(MainOptionalSubArchiveCS.Semester, OptionalStudentSubjectCS.Semester);
                IF NOT MainOptionalSubArchiveCS.FINDFIRST() THEN BEGIN

                    MainOptionalSubArchiveCS1.Reset();
                    MainOptionalSubArchiveCS1.SETRANGE(MainOptionalSubArchiveCS1."Student No.", OptionalStudentSubjectCS."Student No.");
                    MainOptionalSubArchiveCS1.SETRANGE(MainOptionalSubArchiveCS1."Academic Year", OptionalStudentSubjectCS."Academic Year");
                    MainOptionalSubArchiveCS1.SETRANGE(MainOptionalSubArchiveCS1.Semester, OptionalStudentSubjectCS.Semester);
                    IF MainOptionalSubArchiveCS1.FINDLAST() THEN
                        LineNo := MainOptionalSubArchiveCS1."Line No" + 10000
                    ELSE
                        LineNo := 10000;

                    MainOptionalSubArchiveCS.INIT();
                    MainOptionalSubArchiveCS."Student No." := OptionalStudentSubjectCS."Student No.";
                    MainOptionalSubArchiveCS."Line No" := LineNo;
                    MainOptionalSubArchiveCS."Enrollment No" := OptionalStudentSubjectCS."Enrollment No";
                    MainOptionalSubArchiveCS.Course := OptionalStudentSubjectCS.Course;
                    MainOptionalSubArchiveCS.Section := OptionalStudentSubjectCS.Section;
                    MainOptionalSubArchiveCS."Subject Code" := OptionalStudentSubjectCS."Subject Code";
                    MainOptionalSubArchiveCS.Description := OptionalStudentSubjectCS.Description;
                    MainOptionalSubArchiveCS."Actual Subject Code" := OptionalStudentSubjectCS."Actual Subject Code";
                    MainOptionalSubArchiveCS."Actual Subject Description" := OptionalStudentSubjectCS."Actual Subject Description";
                    MainOptionalSubArchiveCS.Credit := OptionalStudentSubjectCS.Credit;
                    MainOptionalSubArchiveCS."Credit Earned" := OptionalStudentSubjectCS."Credit Earned";
                    MainOptionalSubArchiveCS."Credit Grade Points Earned" := OptionalStudentSubjectCS."Credit Grade Points Earned";
                    MainOptionalSubArchiveCS."Attendance Percentage" := OptionalStudentSubjectCS."Attendance Percentage";
                    MainOptionalSubArchiveCS."Subject Type" := OptionalStudentSubjectCS."Subject Type";
                    MainOptionalSubArchiveCS."Subject Class" := OptionalStudentSubjectCS."Subject Class";
                    MainOptionalSubArchiveCS."Academic Year" := OptionalStudentSubjectCS."Academic Year";
                    MainOptionalSubArchiveCS.Semester := OptionalStudentSubjectCS.Semester;
                    MainOptionalSubArchiveCS.Grade := OptionalStudentSubjectCS.Grade;
                    MainOptionalSubArchiveCS."Attendance Type" := OptionalStudentSubjectCS."Attendance Type";
                    MainOptionalSubArchiveCS."Internal Mark" := OptionalStudentSubjectCS."Internal Obtained";
                    MainOptionalSubArchiveCS."Total Internal" := OptionalStudentSubjectCS."Total Internal";
                    MainOptionalSubArchiveCS."External Mark" := OptionalStudentSubjectCS."External Obtained";
                    MainOptionalSubArchiveCS."Re-Registration Date" := OptionalStudentSubjectCS."Re-Registration Date";
                    MainOptionalSubArchiveCS.Total := OptionalStudentSubjectCS.Total;
                    MainOptionalSubArchiveCS.INSERT();
                END;
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

        //Code added for create student optional subject detail::CSPL-00059::22022019: End
    end;

    procedure CalculateGPAProcess(StudentNo: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        TotalCredit: Decimal;
        TotalCreditPoint: Decimal;
        TotalCredit1: Decimal;
        TotalCreditPoint1: Decimal;
        GPANEW: Decimal;
    begin
        //Code added for  calculate GPA::CSPL-00059::22022019: Start
        TotalCredit := 0;
        TotalCreditPoint := 0;
        TotalCredit1 := 0;
        TotalCreditPoint1 := 0;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", Sem);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            REPEAT
                TotalCredit := TotalCredit + MainStudentSubjectCS.Credit;
                TotalCreditPoint := TotalCreditPoint + MainStudentSubjectCS."Credit Grade Points Earned";
            UNTIL MainStudentSubjectCS.NEXT() = 0;

            OptionalStudentSubjectCS.Reset();
            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", Sem);
            OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
            IF OptionalStudentSubjectCS.FINDSET() THEN
                REPEAT
                    TotalCredit1 := TotalCredit1 + OptionalStudentSubjectCS.Credit;
                    TotalCreditPoint1 := TotalCreditPoint1 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            GPANEW := ROUND((TotalCreditPoint + TotalCreditPoint1) / (TotalCredit + TotalCredit1));
        END;
        MESSAGE('%1', GPANEW);


        IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETRANGE("No.", StudentNo);
            IF StudentMasterCS.FINDFIRST() THEN BEGIN
                IF Sem = 'I' THEN
                    StudentMasterCS."Semester I GPA" := GPANEW;
                IF Sem = 'II' THEN
                    StudentMasterCS."Semester II GPA" := GPANEW;
                IF (Sem = 'III') OR (Sem = 'III & IV') THEN
                    StudentMasterCS."Semester III GPA" := GPANEW;
                IF Sem = 'IV' THEN
                    StudentMasterCS."Semester IV GPA" := GPANEW;
                IF Sem = 'V' THEN
                    StudentMasterCS."Semester V GPA" := GPANEW;
                IF Sem = 'VI' THEN
                    StudentMasterCS."Semester VI GPA" := GPANEW;
                IF Sem = 'VII' THEN
                    StudentMasterCS."Semester VII GPA" := GPANEW;
                IF Sem = 'VIII' THEN
                    StudentMasterCS."Semester VIII GPA" := GPANEW;
                StudentMasterCS.Updated := TRUE;
                StudentMasterCS.Modify();
            END;
            MESSAGE('Student GPA Updated Successfully !!');
        END ELSE
            ERROR('Student GPA Not Updated !!');


        //Code added for  calculate GPA::CSPL-00059::22022019: End
    end;

    procedure CalculateCGPAProcess(StudentNo: Code[20])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        //AllStudentResultsCS: Record "All Student Results-CS";
        // AllStudentResultsCS1: Record "All Student Results-CS";

        //LineNo: Integer;
        TotalCredit: Decimal;
        TotalCreditPoint: Decimal;
        CGPANEW: Decimal;

        TotalCredit1: Decimal;
        TotalCreditPoint1: Decimal;
        ETotalCredit1: Decimal;
        ETotalCreditPoint1: Decimal;
        TotalCredit2: Decimal;
        TotalCreditPoint2: Decimal;
        ETotalCredit2: Decimal;
        ETotalCreditPoint2: Decimal;
        TotalCredit3: Decimal;
        TotalCreditPoint3: Decimal;
        ETotalCredit3: Decimal;
        ETotalCreditPoint3: Decimal;
        TotalCredit4: Decimal;
        TotalCreditPoint4: Decimal;
        ETotalCredit4: Decimal;
        ETotalCreditPoint4: Decimal;
        TotalCredit5: Decimal;
        TotalCreditPoint5: Decimal;
        ETotalCredit5: Decimal;
        ETotalCreditPoint5: Decimal;
        TotalCredit6: Decimal;
        TotalCreditPoint6: Decimal;
        ETotalCredit6: Decimal;
        ETotalCreditPoint6: Decimal;
        TotalCredit7: Decimal;
        TotalCreditPoint7: Decimal;
        ETotalCredit7: Decimal;
        ETotalCreditPoint7: Decimal;
        TotalCredit8: Decimal;
        TotalCreditPoint8: Decimal;
        ETotalCredit8: Decimal;
        ETotalCreditPoint8: Decimal;
    begin
        //Code added for  calculate CGPA::CSPL-00059::22022019: Start

        TotalCredit := 0;
        TotalCreditPoint := 0;
        // I Sem----
        TotalCredit1 := 0;
        TotalCreditPoint1 := 0;
        ETotalCredit1 := 0;
        ETotalCreditPoint1 := 0;
        // II Sem----
        TotalCredit2 := 0;
        TotalCreditPoint2 := 0;
        ETotalCredit2 := 0;
        ETotalCreditPoint2 := 0;
        // III Sem----
        TotalCredit3 := 0;
        TotalCreditPoint3 := 0;
        ETotalCredit3 := 0;
        ETotalCreditPoint3 := 0;
        // IV Sem----
        TotalCredit4 := 0;
        TotalCreditPoint4 := 0;
        ETotalCredit4 := 0;
        ETotalCreditPoint4 := 0;
        // V Sem----
        TotalCredit5 := 0;
        TotalCreditPoint5 := 0;
        ETotalCredit5 := 0;
        ETotalCreditPoint5 := 0;
        // VI Sem----
        TotalCredit6 := 0;
        TotalCreditPoint6 := 0;
        ETotalCredit6 := 0;
        ETotalCreditPoint6 := 0;
        // VII Sem----
        TotalCredit7 := 0;
        TotalCreditPoint7 := 0;
        ETotalCredit7 := 0;
        ETotalCreditPoint7 := 0;
        // VIII Sem----
        TotalCredit8 := 0;
        TotalCreditPoint8 := 0;
        ETotalCredit8 := 0;
        ETotalCreditPoint8 := 0;


        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester I GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'I');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit1 := TotalCredit1 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint1 := TotalCreditPoint1 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'I');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit1 := ETotalCredit1 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint1 := ETotalCreditPoint1 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester II GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'II');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit2 := TotalCredit2 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint2 := TotalCreditPoint2 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'II');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit2 := ETotalCredit2 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint2 := ETotalCreditPoint2 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester III GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS."Actual Semester", '%1|%2', 'III', 'III & IV');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit3 := TotalCredit3 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint3 := TotalCreditPoint3 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS."Actual Semester", '%1|%2', 'III', 'III & IV');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit3 := ETotalCredit3 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint3 := ETotalCreditPoint3 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester IV GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'IV');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit4 := TotalCredit4 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint4 := TotalCreditPoint4 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'IV');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit4 := ETotalCredit4 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint4 := ETotalCreditPoint4 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester V GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'V');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit5 := TotalCredit5 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint5 := TotalCreditPoint5 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'V');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit5 := ETotalCredit5 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint5 := ETotalCreditPoint5 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester VI GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'VI');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit6 := TotalCredit6 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint6 := TotalCreditPoint6 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'VI');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit6 := ETotalCredit6 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint6 := ETotalCreditPoint6 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester VII GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'VII');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit7 := TotalCredit7 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint7 := TotalCreditPoint7 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'VII');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit7 := ETotalCredit7 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint7 := ETotalCreditPoint7 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."No.", StudentNo);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester VIII GPA", '<>%1', 0);
        IF StudentMasterCS.FINDFIRST() THEN BEGIN
            MainStudentSubjectCS.Reset();
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'VIII');
            IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                REPEAT
                    TotalCredit8 := TotalCredit8 + MainStudentSubjectCS.Credit;
                    TotalCreditPoint8 := TotalCreditPoint8 + MainStudentSubjectCS."Credit Grade Points Earned";
                UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", 'VIII');
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        ETotalCredit8 := ETotalCredit8 + OptionalStudentSubjectCS.Credit;
                        ETotalCreditPoint8 := ETotalCreditPoint8 + OptionalStudentSubjectCS."Credit Grade Points Earned";
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;

            END;
        END;

        CGPANEW := ROUND(((TotalCreditPoint1 + ETotalCreditPoint1) + (TotalCreditPoint2 + ETotalCreditPoint2) + (TotalCreditPoint3 + ETotalCreditPoint3) + (TotalCreditPoint4 + ETotalCreditPoint4)
        + (TotalCreditPoint5 + ETotalCreditPoint5) + (TotalCreditPoint6 + ETotalCreditPoint6) + (TotalCreditPoint7 + ETotalCreditPoint7) + (TotalCreditPoint8 + ETotalCreditPoint8)) /
        ((TotalCredit1 + ETotalCredit1) + (TotalCredit2 + ETotalCredit2) + (TotalCredit3 + ETotalCredit3) + (TotalCredit4 + ETotalCredit4)
        + (TotalCredit5 + ETotalCredit5) + (TotalCredit6 + ETotalCredit6) + (TotalCredit7 + ETotalCredit7) + (TotalCredit8 + ETotalCredit8)));
        MESSAGE('%1', CGPANEW);

        IF CONFIRM(Text_10002Lbl, FALSE) THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETRANGE("No.", StudentNo);
            IF StudentMasterCS.FINDFIRST() THEN BEGIN
                StudentMasterCS."Net Semester CGPA" := CGPANEW;
                StudentMasterCS.Updated := TRUE;
                StudentMasterCS.Modify();
            END;
            MESSAGE('Student CGPA Updated Successfully !!');
        END ELSE
            ERROR('Student CGPA Not Updated !!');

        //Code added for  calculate GPA::CSPL-00059::22022019: End
    end;

    procedure CalculateCreditEarnedProcess(StudentNo: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        //LineNo: Integer;
        TotalCredit: Decimal;
        TotalCredit1: Decimal;
        CreditEarnedNew: Integer;
    begin
        //Code added for  calculate earn credit::CSPL-00059::22022019: Start

        TotalCredit := 0;
        TotalCredit1 := 0;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", StudentNo);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", Sem);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            REPEAT
                TotalCredit := TotalCredit + MainStudentSubjectCS."Credit Earned";
            UNTIL MainStudentSubjectCS.NEXT() = 0;

            OptionalStudentSubjectCS.Reset();
            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", StudentNo);
            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", Sem);
            OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
            IF OptionalStudentSubjectCS.FINDSET() THEN
                REPEAT
                    TotalCredit1 := TotalCredit1 + OptionalStudentSubjectCS."Credit Earned";
                UNTIL OptionalStudentSubjectCS.NEXT() = 0;
            CreditEarnedNew := TotalCredit + TotalCredit1;
        END;
        MESSAGE('%1', CreditEarnedNew);

        IF CONFIRM(Text_10003Lbl, FALSE) THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETRANGE("No.", StudentNo);
            IF StudentMasterCS.FINDFIRST() THEN BEGIN
                IF Sem = 'I' THEN
                    StudentMasterCS."Semester I Credit Earned" := CreditEarnedNew;
                IF Sem = 'II' THEN
                    StudentMasterCS."Semester II Credit Earned" := CreditEarnedNew;
                IF (Sem = 'III') OR (Sem = 'III & IV') THEN
                    StudentMasterCS."Semester III Credit Earned" := CreditEarnedNew;
                IF Sem = 'IV' THEN
                    StudentMasterCS."Semester IV Credit Earned" := CreditEarnedNew;
                IF Sem = 'V' THEN
                    StudentMasterCS."Semester V Credit Earned" := CreditEarnedNew;
                IF Sem = 'VI' THEN
                    StudentMasterCS."Semester VI Credit Earned" := CreditEarnedNew;
                IF Sem = 'VII' THEN
                    StudentMasterCS."Semester VII Credit Earned" := CreditEarnedNew;
                IF Sem = 'VIII' THEN
                    StudentMasterCS."Semester VIII Credit Earned" := CreditEarnedNew;
                StudentMasterCS.Updated := TRUE;
                StudentMasterCS.Modify();
            END;
            MESSAGE('Student Credit Earned Updated Successfully !!');
        END ELSE
            ERROR('Student Credit Earned Not Updated !!');
        //Code added for  calculate earn credit::CSPL-00059::22022019: End
    end;

    procedure "Re-RegistrationFieldBlankProcess"(AcademicYear1: Code[20]; StartDate: Date; EndDate: Date)
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    /* AllStudentResultsCS: Record "All Student Results-CS";
     AllStudentResultsCS1: Record "All Student Results-CS";
     LineNo: Integer;
     TotalCredit: Decimal;
     TotalCreditPoint: Decimal;
     TotalCredit1: Decimal;
     TotalCreditPoint1: Decimal;
     GPANEW: Decimal;*/
    begin
        //Code added for clear the field for re- registration::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS."Re-Registration Date", '%1..%2', StartDate, EndDate);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            ABCD := MainStudentSubjectCS.count();
            MESSAGE('Total Student Subject - %1', ABCD);
            REPEAT
                MainStudentSubjectCS."Assignment Marks" := 0;
                MainStudentSubjectCS."Internal Mark" := 0;
                MainStudentSubjectCS."Total Internal" := 0;
                MainStudentSubjectCS."External Mark" := 0;
                MainStudentSubjectCS."Attendance Type" := MainStudentSubjectCS."Attendance Type"::" ";
                MainStudentSubjectCS."Attendance Percentage" := 0;
                MainStudentSubjectCS.Detained := FALSE;
                MainStudentSubjectCS."Credit Earned" := 0;
                MainStudentSubjectCS."Credit Grade Points Earned" := 0;
                MainStudentSubjectCS."Total Class Held" := 0;
                MainStudentSubjectCS."Total Attendance Taken" := 0;
                MainStudentSubjectCS."Present Count" := 0;
                MainStudentSubjectCS."Absent Count" := 0;
                MainStudentSubjectCS.Total := 0;
                MainStudentSubjectCS."Grace Marks" := 0;
                MainStudentSubjectCS."Internal Marks Updated" := FALSE;
                MainStudentSubjectCS."External Marks Updated" := FALSE;
                MainStudentSubjectCS.Updated := TRUE;
                MainStudentSubjectCS.Modify();
            UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;


        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS."Re-Registration Date", '%1..%2', StartDate, EndDate);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            ABCD1 := OptionalStudentSubjectCS.count();
            MESSAGE('Total Student Optional Subject - %1', ABCD1);
            REPEAT
                OptionalStudentSubjectCS."Assignment Marks" := 0;
                OptionalStudentSubjectCS."Internal Obtained" := 0;
                OptionalStudentSubjectCS."Total Internal" := 0;
                OptionalStudentSubjectCS."External Obtained" := 0;
                OptionalStudentSubjectCS."Attendance Type" := MainStudentSubjectCS."Attendance Type"::" ";
                OptionalStudentSubjectCS."Attendance Percentage" := 0;
                OptionalStudentSubjectCS.Detained := FALSE;
                OptionalStudentSubjectCS."Credit Earned" := 0;
                OptionalStudentSubjectCS."Credit Grade Points Earned" := 0;
                OptionalStudentSubjectCS."Total Class Held" := 0;
                OptionalStudentSubjectCS."Total Attendance Taken" := 0;
                OptionalStudentSubjectCS."Present Count" := 0;
                OptionalStudentSubjectCS."Absent Count" := 0;
                OptionalStudentSubjectCS.Total := 0;
                OptionalStudentSubjectCS."Grace Marks" := 0;
                OptionalStudentSubjectCS."Internal Marks Updated" := FALSE;
                OptionalStudentSubjectCS."External Marks Updated" := FALSE;
                OptionalStudentSubjectCS.Updated := TRUE;
                OptionalStudentSubjectCS.Modify();
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        END;
        MESSAGE('Re-Registration Field Blank Successfully');
        //Code added for clear the field for re- registration::CSPL-00059::22022019: End
    end;

    procedure "Re-RegistrationExamUnTickProcess"(AcademicYear1: Code[20]; StartDate: Date; EndDate: Date)
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    /* AllStudentResultsCS: Record "All Student Results-CS";
     AllStudentResultsCS1: Record "All Student Results-CS";
     LineNo: Integer;
     TotalCredit: Decimal;
     TotalCreditPoint: Decimal;
     TotalCredit1: Decimal;
     TotalCreditPoint1: Decimal;
     GPANEW: Decimal;*/
    begin
        //Code added for clear the field for re- registration set to false::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS."Re-Registration Date", '%1..%2', StartDate, EndDate);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Re-Registration", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Subject - %1', MainStudentSubjectCS.Count());
            MainStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
            MainStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS."Re-Registration Date", '%1..%2', StartDate, EndDate);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Re-Registration", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Optional Subject - %1', OptionalStudentSubjectCS.Count());
            OptionalStudentSubjectCS.MODIFYALL("Re-Registration", FALSE);
            OptionalStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        MESSAGE('Re-Registration Exam UnTick Successfully');
        //Code added for clear the field for re- registration set to false::CSPL-00059::22022019: End
    end;

    procedure "Make-UpExamUnTickProcess"(AcademicYear1: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    /* AllStudentResultsCS: Record "All Student Results-CS";
     AllStudentResultsCS1: Record "All Student Results-CS";
     LineNo: Integer;
     TotalCredit: Decimal;
     TotalCreditPoint: Decimal;
     TotalCredit1: Decimal;
     TotalCreditPoint1: Decimal;
     GPANEW: Decimal;*/
    begin
        //Code added for clear the field for makeup set to false::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, Sem);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Make Up Examination", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Subject - %1', MainStudentSubjectCS.Count());
            MainStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
            MainStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, Sem);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Make Up Examination", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Optional Subject - %1', OptionalStudentSubjectCS.Count());
            OptionalStudentSubjectCS.MODIFYALL("Make Up Examination", FALSE);
            OptionalStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        MESSAGE('Make-Up Exam UnTick Successfully');
        //Code added for clear the field for makeup set to false::CSPL-00059::22022019: End
    end;

    procedure Revaluation1ExamUnTickProcess(AcademicYear1: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    /* AllStudentResultsCS: Record "All Student Results-CS";
     AllStudentResultsCS1: Record "All Student Results-CS";
     LineNo: Integer;
     TotalCredit: Decimal;
     TotalCreditPoint: Decimal;
     TotalCredit1: Decimal;
     TotalCreditPoint1: Decimal;
     GPANEW: Decimal;*/
    begin
        //Code added for clear the field for Revaluation set to false::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, Sem);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Revaluation1, TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Subject - %1', MainStudentSubjectCS.Count());
            REPEAT
                MainStudentSubjectCS.Revaluation1 := FALSE;
                MainStudentSubjectCS."Attendance Detail" := '';
                MainStudentSubjectCS.Updated := TRUE;
                MainStudentSubjectCS.Modify();
            UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, Sem);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Revaluation1, TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Optional Subject - %1', OptionalStudentSubjectCS.Count());
            REPEAT
                OptionalStudentSubjectCS.Revaluation1 := FALSE;
                OptionalStudentSubjectCS."Attendance Detail" := '';
                OptionalStudentSubjectCS.Updated := TRUE;
                OptionalStudentSubjectCS.Modify();
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        END;

        MESSAGE('Revaluation 1 Exam UnTick Successfully');
        //Code added for clear the field for Revaluation set to false::CSPL-00059::22022019: End
    end;

    procedure Revaluation2ExamUnTickProcess(AcademicYear1: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";

    begin
        //Code added for clear the field for Revaluation second set to false::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, Sem);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Revaluation2, TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Subject - %1', MainStudentSubjectCS.Count());
            REPEAT
                MainStudentSubjectCS.Revaluation2 := FALSE;
                MainStudentSubjectCS."Attendance Detail" := '';
                MainStudentSubjectCS.Updated := TRUE;
                MainStudentSubjectCS.Modify();
            UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, Sem);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Revaluation2, TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Optional Subject - %1', OptionalStudentSubjectCS.Count());
            REPEAT
                OptionalStudentSubjectCS.Revaluation2 := FALSE;
                OptionalStudentSubjectCS."Attendance Detail" := '';
                OptionalStudentSubjectCS.Updated := TRUE;
                OptionalStudentSubjectCS.Modify();
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        END;

        MESSAGE('Revaluation 2 Exam UnTick Successfully');
        //Code added for clear the field for Revaluation second set to false::CSPL-00059::22022019: End
    end;

    procedure UpdateElectiveSubjectRollNo(AcademicYear: Code[20]; EvenOddSemester: Option " ",FALL,SPRING)
    var
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    begin
        //Code added for update roll no in elective subject::CSPL-00059::22022019: Start
        RollNum := 0;
        Sub := '';
        Section1 := '';

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Re-Registration", FALSE);
        OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear);
        IF EvenOddSemester = EvenOddSemester::SPRING THEN
            OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV');
        IF EvenOddSemester = EvenOddSemester::FALL THEN
            OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        OptionalStudentSubjectCS.SETCURRENTKEY("Subject Code", Section, "Enrollment No");
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('%1', OptionalStudentSubjectCS.Count());
            REPEAT
                IF Sub <> OptionalStudentSubjectCS."Subject Code" THEN
                    RollNum := 1
                ELSE
                    IF Section1 <> OptionalStudentSubjectCS.Section THEN
                        RollNum := 1
                    ELSE
                        RollNum := RollNum + 1;


                Sub := OptionalStudentSubjectCS."Subject Code";
                Section1 := OptionalStudentSubjectCS.Section;
                OptionalStudentSubjectCS."Roll No." := FORMAT(RollNum);
                OptionalStudentSubjectCS.Updated := TRUE;
                OptionalStudentSubjectCS.Modify();
            // MESSAGE('Subject=%1|Section=%2|RollNo=%3',Sub,Section1,RollNum);
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
        END;
        MESSAGE('Student Optional Subject Roll No. Allocation Successfully');
        //Code added for update roll no in elective subject::CSPL-00059::22022019: End
    end;

    procedure "UpdateRe-RegistrationSubjectRollNo"(AcademicYear: Code[20])
    var
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS1: Record "Optional Student Subject-CS";
    begin
        //Code added for update roll no in Re-Registration student::CSPL-00059::22022019: Start
        RollNum := 200;
        Enroll := '';
        Enroll1 := '';
        RollNum1 := 0;

        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Re-Registration", TRUE);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear);
        MainStudentSubjectCS.SETCURRENTKEY("Enrollment No");
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('%1', MainStudentSubjectCS.Count());
            REPEAT
                IF Enroll <> MainStudentSubjectCS."Enrollment No" THEN
                    RollNum := RollNum + 1
                ELSE
                    RollNum := RollNum;

                Enroll := MainStudentSubjectCS."Enrollment No";
                MainStudentSubjectCS."Roll No." := FORMAT(RollNum);
                MainStudentSubjectCS.Updated := TRUE;
                MainStudentSubjectCS.Modify();
                RollNum1 := RollNum;
            // MESSAGE('Enrollment=%1|RollNo=%2',Enroll,RollNum);
            UNTIL MainStudentSubjectCS.NEXT() = 0;
        END;
        MESSAGE('Re-Registration Student Subject Roll No. Allocation Successfully');


        MainStudentSubjectCS1.Reset();
        MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1."Re-Registration", TRUE);
        MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1."Academic Year", AcademicYear);
        IF MainStudentSubjectCS1.FINDSET() THEN
            REPEAT
                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Re-Registration", TRUE);
                OptionalStudentSubjectCS.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS."Program/Open Elective Temp"::" ");
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear);
                OptionalStudentSubjectCS.SETRANGE("Enrollment No", MainStudentSubjectCS1."Enrollment No");
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        OptionalStudentSubjectCS."Roll No." := MainStudentSubjectCS1."Roll No.";
                        OptionalStudentSubjectCS.Updated := TRUE;
                        OptionalStudentSubjectCS.Modify();
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;
            //   MESSAGE('Enrollment=%1|RollNo=%2',OptionalStudentSubjectCS."Enrollment No",OptionalStudentSubjectCS."Roll No.");
            UNTIL MainStudentSubjectCS1.NEXT() = 0;

        MESSAGE('Re-Registration Student Optional Subject Roll No. Allocation Successfully');


        OptionalStudentSubjectCS1.Reset();
        OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Re-Registration", TRUE);
        OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Roll No.", '');
        OptionalStudentSubjectCS1.SETRANGE("Program/Open Elective Temp", OptionalStudentSubjectCS1."Program/Open Elective Temp"::" ");
        IF OptionalStudentSubjectCS1.FINDSET() THEN
            REPEAT
                IF Enroll1 <> OptionalStudentSubjectCS1."Enrollment No" THEN
                    RollNum1 := RollNum1 + 1
                ELSE
                    RollNum1 := RollNum1;
                Enroll1 := OptionalStudentSubjectCS1."Enrollment No";
                OptionalStudentSubjectCS1."Roll No." := FORMAT(RollNum1);
                OptionalStudentSubjectCS.Updated := TRUE;
                OptionalStudentSubjectCS1.Modify();
            //MESSAGE('Enrollment=%1|RollNo=%2',OptionalStudentSubjectCS."Enrollment No",RollNum1);
            UNTIL OptionalStudentSubjectCS1.NEXT() = 0;

        MESSAGE('Re-Registration Student Optional Subject Roll No. Allocation Successfully');
        //Code added for update roll no in Re-Registration student::CSPL-00059::22022019: End
    end;

    procedure CalculateRankSemesterWise(AdmittedYear1: Code[20]; CourseCode1: Code[10]; Graduation1: Code[10])
    var
        StudentExtensionNewCS: Record "Student Extension New-CS";
        SetAscending: Boolean;
        SERIALNO1: Text[20];
        Semester1: Code[10];
        GPA1: Decimal;
        Count1: Integer;
        TotalCount1: Integer;
        SERIALNO2: Text[20];
        Semester2: Code[10];
        GPA2: Decimal;
        Count2: Integer;
        TotalCount2: Integer;
        SERIALNO3: Text[20];
        Semester3: Code[10];
        GPA3: Decimal;
        Count3: Integer;
        TotalCount3: Integer;
        SERIALNO4: Text[20];
        Semester4: Code[10];
        GPA4: Decimal;
        Count4: Integer;
        TotalCount4: Integer;
        SERIALNO5: Text[20];
        Semester5: Code[10];
        GPA5: Decimal;
        Count5: Integer;
        TotalCount5: Integer;
        SERIALNO6: Text[20];
        Semester6: Code[10];
        GPA6: Decimal;
        Count6: Integer;
        TotalCount6: Integer;
        SERIALNO7: Text[20];
        Semester7: Code[10];
        GPA7: Decimal;
        Count7: Integer;
        TotalCount7: Integer;
        SERIALNO8: Text[20];
        Semester8: Code[10];
        GPA8: Decimal;
        Count8: Integer;
        TotalCount8: Integer;
    begin
        //Code added for calculate rank sem wise::CSPL-00059::22022019: Start
        //  I Semester
        SetAscending := FALSE;
        SERIALNO1 := '';
        GPA1 := 0;
        Count1 := 0;
        Semester1 := 'I';
        TotalCount1 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        IF Graduation1 = 'PG' THEN
            StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1)
        ELSE
            StudentMasterCS.SETRANGE(StudentMasterCS.Graduation, Graduation1);
        IF Semester1 = 'I' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester I GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester I GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester I GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount1 := StudentMasterCS.count();
            REPEAT
                Count1 := Count1 + 1;
                IF GPA1 <> StudentMasterCS."Semester I GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester I Rank" := FORMAT(Count1) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount1) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO1 := StudentExtensionNewCS."Semester I Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester I Rank" := SERIALNO1;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA1 := StudentMasterCS."Semester I GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;


        //  II Semester
        SetAscending := FALSE;
        SERIALNO2 := '';
        GPA2 := 0;
        Count2 := 0;
        Semester2 := 'II';
        TotalCount2 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        IF Graduation1 = 'PG' THEN
            StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1)
        ELSE
            StudentMasterCS.SETRANGE(StudentMasterCS.Graduation, Graduation1);
        IF Semester2 = 'II' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester II GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester II GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester II GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount2 := StudentMasterCS.count();
            REPEAT
                Count2 := Count2 + 1;
                IF GPA2 <> StudentMasterCS."Semester II GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester II Rank" := FORMAT(Count2) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount2) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO2 := StudentExtensionNewCS."Semester II Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester II Rank" := SERIALNO2;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA2 := StudentMasterCS."Semester II GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;


        //  III Semester
        SetAscending := FALSE;
        SERIALNO3 := '';
        GPA3 := 0;
        Count3 := 0;
        TotalCount3 := 0;
        Semester3 := 'III';

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
        IF StudentMasterCS."Degree Code" = 'M.Tech' THEN  //---- Field type change
            //Semester3 := 'III & IV'; //- Field type change
            IF (Semester3 = 'III') OR (Semester3 = 'III & IV') THEN
                StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester III GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester III GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester III GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount3 := StudentMasterCS.count();
            REPEAT
                Count3 := Count3 + 1;
                IF GPA3 <> StudentMasterCS."Semester III GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester III Rank" := FORMAT(Count3) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount3) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO3 := StudentExtensionNewCS."Semester III Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester III Rank" := SERIALNO3;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA3 := StudentMasterCS."Semester III GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;

        //  IV Semester
        SetAscending := FALSE;
        SERIALNO4 := '';
        GPA4 := 0;
        Count4 := 0;
        Semester4 := 'IV';
        TotalCount4 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        IF Semester4 = 'IV' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester IV GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester IV GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester IV GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount4 := StudentMasterCS.count();
            REPEAT
                Count4 := Count4 + 1;
                IF GPA4 <> StudentMasterCS."Semester IV GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester IV Rank" := FORMAT(Count4) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount4) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO4 := StudentExtensionNewCS."Semester IV Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester IV Rank" := SERIALNO4;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA4 := StudentMasterCS."Semester IV GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;

        //  V Semester
        SetAscending := FALSE;
        SERIALNO5 := '';
        GPA5 := 0;
        Count5 := 0;
        Semester5 := 'V';
        TotalCount5 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        IF Semester5 = 'V' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester V GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester V GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester V GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount5 := StudentMasterCS.count();
            REPEAT
                Count5 := Count5 + 1;
                IF GPA5 <> StudentMasterCS."Semester V GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester V Rank" := FORMAT(Count5) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount5) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO5 := StudentExtensionNewCS."Semester V Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester V Rank" := SERIALNO5;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA5 := StudentMasterCS."Semester V GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;

        //  VI Semester
        SetAscending := FALSE;
        SERIALNO6 := '';
        GPA6 := 0;
        Count6 := 0;
        Semester6 := 'VI';
        TotalCount6 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        IF Semester6 = 'VI' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester VI GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester VI GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester VI GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount6 := StudentMasterCS.count();
            REPEAT
                Count6 := Count6 + 1;
                IF GPA6 <> StudentMasterCS."Semester VI GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester VI Rank" := FORMAT(Count6) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount6) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO6 := StudentExtensionNewCS."Semester VI Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester VI Rank" := SERIALNO6;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA6 := StudentMasterCS."Semester VI GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;

        //  VII Semester
        SetAscending := FALSE;
        SERIALNO7 := '';
        GPA7 := 0;
        Count7 := 0;
        Semester7 := 'VII';
        TotalCount7 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        IF Semester7 = 'VII' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester VII GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester VII GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester VII GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount7 := StudentMasterCS.count();
            REPEAT
                Count7 := Count7 + 1;
                IF GPA7 <> StudentMasterCS."Semester VII GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester VII Rank" := FORMAT(Count7) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount7) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO7 := StudentExtensionNewCS."Semester VII Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester VII Rank" := SERIALNO7;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA7 := StudentMasterCS."Semester VII GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;

        //  VIII Semester
        SetAscending := FALSE;
        SERIALNO8 := '';
        GPA8 := 0;
        Count8 := 0;
        Semester8 := 'VIII';
        TotalCount8 := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        IF Semester8 = 'VIII' THEN
            StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Semester VIII GPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Semester VIII GPA", SetAscending);
        StudentMasterCS.SETFILTER(StudentMasterCS."Semester VIII GPA", '<>%1', 0);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            TotalCount8 := StudentMasterCS.count();
            REPEAT
                Count8 := Count8 + 1;
                IF GPA8 <> StudentMasterCS."Semester VIII GPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester VIII Rank" := FORMAT(Count8) + ' ' + '(' + 'Out of' + ' ' + FORMAT(TotalCount8) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        SERIALNO8 := StudentExtensionNewCS."Semester VIII Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Semester VIII Rank" := SERIALNO8;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                GPA8 := StudentMasterCS."Semester VIII GPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;
        //Code added for calculate rank sem wise::CSPL-00059::22022019: End
    end;

    procedure CalculateOverallRank(AdmittedYear1: Code[20]; CourseCode1: Code[10])
    var
        StudentExtensionNewCS: Record "Student Extension New-CS";

        SetAscending: Boolean;
        OVERALLSERIALNO: Text[30];
        OVERALLCGPA: Decimal;
        OVERALLCOUNT: Integer;

        OVERALLTOTALCOUNT: Integer;
    begin
        //Code added for calculate over all rank::CSPL-00059::22022019: Start
        SetAscending := FALSE;
        OVERALLSERIALNO := '';
        OVERALLCGPA := 0;
        OVERALLCOUNT := 0;
        OVERALLTOTALCOUNT := 0;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Admitted Year", AdmittedYear1);
        StudentMasterCS.SETRANGE(StudentMasterCS."Course Code", CourseCode1);
        StudentMasterCS.SETCURRENTKEY(StudentMasterCS."Net Semester CGPA");
        StudentMasterCS.SETASCENDING(StudentMasterCS."Net Semester CGPA", SetAscending);
        IF StudentMasterCS.FINDSET() THEN BEGIN
            OVERALLTOTALCOUNT := StudentMasterCS.count();
            REPEAT
                OVERALLCOUNT := OVERALLCOUNT + 1;
                IF OVERALLCGPA <> StudentMasterCS."Net Semester CGPA" THEN BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Final Rank" := FORMAT(OVERALLCOUNT) + ' ' + '(' + 'Out of' + ' ' + FORMAT(OVERALLTOTALCOUNT) + ')';
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                        OVERALLSERIALNO := StudentExtensionNewCS."Final Rank";
                    END;
                END ELSE BEGIN
                    StudentExtensionNewCS.Reset();
                    StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."No.", StudentMasterCS."No.");
                    IF StudentExtensionNewCS.FINDFIRST() THEN BEGIN
                        StudentExtensionNewCS."Final Rank" := OVERALLSERIALNO;
                        StudentExtensionNewCS.Updated := TRUE;
                        StudentExtensionNewCS.Modify();
                    END;
                END;
                OVERALLCGPA := StudentMasterCS."Net Semester CGPA";
            UNTIL StudentMasterCS.NEXT() = 0;
        END;
        //Code added for calculate over all rank::CSPL-00059::22022019: End
    end;

    procedure "GradeReportRegular&Repeater"(AcademicYear1: Code[20]; Semester1: Code[10]; CurrentSession1: Code[20]; CourseCode1: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS1: Record "Optional Student Subject-CS";
    begin
        //Code added for calculate grade regular and repeate::CSPL-00059::22022019: Start
        // For Student Subject
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Current Session", CurrentSession1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", Semester1);
        MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Grade, '%1|%2|%3|%4|%5|%6', 'A+', 'A', 'B', 'C', 'D', 'E');
        IF CourseCode1 <> '' THEN
            MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Course, CourseCode1);
        IF MainStudentSubjectCS.FINDSET() THEN
            REPEAT
                IF (MainStudentSubjectCS."Actual Academic Year" <> AcademicYear1) OR (MainStudentSubjectCS."Actual Session" <> CurrentSession1) THEN BEGIN
                    MainStudentSubjectCS1.Reset();
                    MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1."Enrollment No", MainStudentSubjectCS."Enrollment No");
                    MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1."Actual Semester", Semester1);
                    IF MainStudentSubjectCS1.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS1.Completed := TRUE;
                            MainStudentSubjectCS1.Modify();
                        UNTIL MainStudentSubjectCS1.NEXT() = 0;

                    OptionalStudentSubjectCS1.Reset();
                    OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Enrollment No", MainStudentSubjectCS."Enrollment No");
                    OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Actual Semester", Semester1);
                    IF OptionalStudentSubjectCS1.FINDSET() THEN
                        REPEAT
                            OptionalStudentSubjectCS1.Completed := TRUE;
                            OptionalStudentSubjectCS1.Modify();
                        UNTIL OptionalStudentSubjectCS1.NEXT() = 0;

                END;
            UNTIL MainStudentSubjectCS.NEXT() = 0;



        // For Student Optional Subject
        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Current Session", CurrentSession1);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", Semester1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Grade, '%1|%2|%3|%4|%5|%6', 'A+', 'A', 'B', 'C', 'D', 'E');
        //OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Enrollment No",'110906464');
        IF CourseCode1 <> '' THEN
            OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Course, CourseCode1);
        IF OptionalStudentSubjectCS.FINDSET() THEN
            REPEAT
                IF (OptionalStudentSubjectCS."Actual Academic Year" <> AcademicYear1) OR (OptionalStudentSubjectCS."Actual Session" <> CurrentSession1) THEN BEGIN
                    OptionalStudentSubjectCS1.Reset();
                    OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Enrollment No", OptionalStudentSubjectCS."Enrollment No");
                    OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Actual Semester", Semester1);
                    IF OptionalStudentSubjectCS1.FINDSET() THEN
                        REPEAT
                            OptionalStudentSubjectCS1.Completed := TRUE;
                            OptionalStudentSubjectCS1.Modify();
                        UNTIL OptionalStudentSubjectCS1.NEXT() = 0;

                    MainStudentSubjectCS1.Reset();
                    MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1."Enrollment No", OptionalStudentSubjectCS."Enrollment No");
                    MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1."Actual Semester", Semester1);
                    IF MainStudentSubjectCS1.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS1.Completed := TRUE;
                            MainStudentSubjectCS1.Modify();
                        UNTIL MainStudentSubjectCS1.NEXT() = 0;

                END
            UNTIL OptionalStudentSubjectCS.NEXT() = 0;

        //Code added for calculate grade regular and repeate::CSPL-00059::22022019: End
    end;

    procedure "ElectivePre-RegistrationAllocation"(AcademicYear1: Code[20]; Graduation1: Code[10]; Sem: Code[10])
    var
        OptionalStudentSubjectCS1: Record "Optional Student Subject-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        EducationSetupCS: Record "Education Setup-CS";
        SemesterMasterCS: Record "Semester Master-CS";

        SemesterMasterCS1: Record "Semester Master-CS";
        Semester1: Code[20];
        Sem1: Integer;
    begin
        //Code added for elective subject pre registration::CSPL-00059::22022019: Start
        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS.Graduation, Graduation1);
        StudentMasterCS.SETRANGE(StudentMasterCS.Semester, Sem);
        StudentMasterCS.SETFILTER(StudentMasterCS."Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                OptionalStudentSubjectCS1.Reset();
                OptionalStudentSubjectCS1.SETRANGE("Student No.", StudentMasterCS."No.");
                OptionalStudentSubjectCS1.SETRANGE(Course, StudentMasterCS."Course Code");
                SemesterMasterCS.Reset();
                SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, Sem);
                IF SemesterMasterCS.FINDFIRST() THEN BEGIN
                    Sem1 := SemesterMasterCS.Sequence + 1;
                    SemesterMasterCS1.Reset();
                    SemesterMasterCS1.SETRANGE(SemesterMasterCS1.Sequence, Sem1);
                    IF SemesterMasterCS1.FINDFIRST() THEN
                        Semester1 := SemesterMasterCS1.Code;

                END;
                OptionalStudentSubjectCS1.SETRANGE(Semester, Semester1);
                OptionalStudentSubjectCS1.SETRANGE("Academic Year", AcademicYear1);
                IF StudentMasterCS.Group <> '' THEN
                    OptionalStudentSubjectCS1.SETRANGE(Group, StudentMasterCS.Group);
                OptionalStudentSubjectCS1.SETRANGE("Subject Type", 'OPEN ELECTIVE');
                IF NOT OptionalStudentSubjectCS1.FINDSET() THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", StudentMasterCS."Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester1);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", AcademicYear1);
                    IF StudentMasterCS.Group <> '' THEN
                        CourseWiseSubjectLineCS.SETRANGE("Student Group", StudentMasterCS.Group);
                    CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::"Open Elective Common Subject");
                    IF CourseWiseSubjectLineCS.FINDSET() THEN
                        REPEAT
                            OptionalStudentSubjectCS.INIT();
                            OptionalStudentSubjectCS."Student No." := StudentMasterCS."No.";
                            OptionalStudentSubjectCS."Student Name" := StudentMasterCS."Student Name";
                            OptionalStudentSubjectCS.Course := StudentMasterCS."Course Code";
                            OptionalStudentSubjectCS.VALIDATE(Semester, Semester1);
                            OptionalStudentSubjectCS.VALIDATE(Year, CourseWiseSubjectLineCS.Year);
                            OptionalStudentSubjectCS."Enrollment No" := StudentMasterCS."Enrollment No.";
                            OptionalStudentSubjectCS.Section := '';
                            OptionalStudentSubjectCS.Graduation := StudentMasterCS.Graduation;
                            OptionalStudentSubjectCS.VALIDATE("Academic Year", AcademicYear1);
                            OptionalStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            OptionalStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            OptionalStudentSubjectCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.VALIDATE("Actual Academic Year", AcademicYear1);
                            OptionalStudentSubjectCS.VALIDATE("Actual Semester", Semester1);
                            OptionalStudentSubjectCS.VALIDATE("Actual Year", CourseWiseSubjectLineCS.Year);
                            OptionalStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            OptionalStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            OptionalStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            OptionalStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            OptionalStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            OptionalStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            OptionalStudentSubjectCS.Group := StudentMasterCS.Group;
                            OptionalStudentSubjectCS."Elective Group Code" := CourseWiseSubjectLineCS."Elective Group Code";
                            OptionalStudentSubjectCS."Program/Open Elective Temp" := OptionalStudentSubjectCS."Program/Open Elective Temp"::"Open Elective Common Subject";
                            EducationSetupCS.Reset();
                            EducationSetupCS.SetRange("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
                            if EducationSetupCS.FindFirst() then
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                    OptionalStudentSubjectCS."Current Session" := 'JUL-NOV';
                                    OptionalStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                    OptionalStudentSubjectCS."Actual Session" := 'JUL-NOV';
                                END ELSE
                                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                        OptionalStudentSubjectCS."Current Session" := 'JAN-MAY';
                                        OptionalStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                        OptionalStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                    END;
                            OptionalStudentSubjectCS.INSERT();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                END;
            UNTIL StudentMasterCS.NEXT() = 0;


        MESSAGE('%1', 'OPEN ELECTIVE SUBJECT DONE!!!!');


        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS.Graduation, Graduation1);
        StudentMasterCS.SETRANGE(StudentMasterCS.Semester, Sem);
        StudentMasterCS.SETFILTER(StudentMasterCS."Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student, StudentMasterCS."Student Status"::Casual,
                                StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                OptionalStudentSubjectCS1.Reset();
                OptionalStudentSubjectCS1.SETRANGE("Student No.", StudentMasterCS."No.");
                OptionalStudentSubjectCS1.SETRANGE(Course, StudentMasterCS."Course Code");
                SemesterMasterCS.Reset();
                SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, Sem);
                IF SemesterMasterCS.FINDFIRST() THEN BEGIN
                    Sem1 := SemesterMasterCS.Sequence + 1;
                    SemesterMasterCS1.Reset();
                    SemesterMasterCS1.SETRANGE(SemesterMasterCS1.Sequence, Sem1);
                    IF SemesterMasterCS1.FINDFIRST() THEN
                        Semester1 := SemesterMasterCS1.Code;

                END;
                OptionalStudentSubjectCS1.SETRANGE(Semester, Semester1);
                OptionalStudentSubjectCS1.SETRANGE("Academic Year", AcademicYear1);
                IF StudentMasterCS.Group <> '' THEN
                    OptionalStudentSubjectCS1.SETRANGE(Group, StudentMasterCS.Group);
                OptionalStudentSubjectCS1.SETRANGE("Subject Type", 'ELECTIVE');
                IF NOT OptionalStudentSubjectCS1.FINDSET() THEN BEGIN
                    CourseWiseSubjectLineCS.Reset();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", StudentMasterCS."Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, Semester1);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", AcademicYear1);
                    IF StudentMasterCS.Group <> '' THEN
                        CourseWiseSubjectLineCS.SETRANGE("Student Group", StudentMasterCS.Group);
                    CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::"Program Elective Common Subject");
                    IF CourseWiseSubjectLineCS.FINDSET() THEN
                        REPEAT
                            OptionalStudentSubjectCS.INIT();
                            OptionalStudentSubjectCS."Student No." := StudentMasterCS."No.";
                            OptionalStudentSubjectCS."Student Name" := StudentMasterCS."Student Name";
                            OptionalStudentSubjectCS.Course := StudentMasterCS."Course Code";
                            OptionalStudentSubjectCS.VALIDATE(Semester, Semester1);
                            OptionalStudentSubjectCS.VALIDATE(Year, CourseWiseSubjectLineCS.Year);
                            OptionalStudentSubjectCS."Enrollment No" := StudentMasterCS."Enrollment No.";
                            OptionalStudentSubjectCS.Section := '';
                            OptionalStudentSubjectCS.Graduation := StudentMasterCS.Graduation;
                            OptionalStudentSubjectCS.VALIDATE("Academic Year", AcademicYear1);
                            OptionalStudentSubjectCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            OptionalStudentSubjectCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            OptionalStudentSubjectCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.VALIDATE("Actual Academic Year", AcademicYear1);
                            OptionalStudentSubjectCS.VALIDATE("Actual Semester", Semester1);
                            OptionalStudentSubjectCS.VALIDATE("Actual Year", CourseWiseSubjectLineCS.Year);
                            OptionalStudentSubjectCS.VALIDATE("Actual Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            OptionalStudentSubjectCS."Actual Subject Description" := CourseWiseSubjectLineCS.Description;
                            OptionalStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            OptionalStudentSubjectCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
                            OptionalStudentSubjectCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
                            OptionalStudentSubjectCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
                            OptionalStudentSubjectCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
                            OptionalStudentSubjectCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
                            OptionalStudentSubjectCS.Group := StudentMasterCS.Group;
                            OptionalStudentSubjectCS."Elective Group Code" := CourseWiseSubjectLineCS."Elective Group Code";
                            OptionalStudentSubjectCS."Program/Open Elective Temp" := OptionalStudentSubjectCS."Program/Open Elective Temp"::"Program Elective Common Subject";
                            EducationSetupCS.Reset();
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                OptionalStudentSubjectCS."Current Session" := 'JUL-NOV';
                                OptionalStudentSubjectCS."Previous Session" := 'JUL-NOV';
                                OptionalStudentSubjectCS."Actual Session" := 'JUL-NOV';
                            END ELSE
                                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                                    OptionalStudentSubjectCS."Current Session" := 'JAN-MAY';
                                    OptionalStudentSubjectCS."Previous Session" := 'JAN-MAY';
                                    OptionalStudentSubjectCS."Actual Session" := 'JAN-MAY';
                                END;
                            OptionalStudentSubjectCS.INSERT();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                END;
            UNTIL StudentMasterCS.NEXT() = 0;

        MESSAGE('%1', 'ELECTIVE SUBJECT DONE!!!!');
        //Code added for elective subject pre registration::CSPL-00059::22022019: End
    end;

    procedure "Re-RegistrationExamOnlyUnTickProcess"(AcademicYear1: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    /* AllStudentResultsCS: Record "All Student Results-CS";
     AllStudentResultsCS1: Record "All Student Results-CS";
     LineNo: Integer;
     TotalCredit: Decimal;
     TotalCreditPoint: Decimal;
     TotalCredit1: Decimal;
     TotalCreditPoint1: Decimal;
     GPANEW: Decimal;*/
    begin
        //Code added for set to false on registration::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, Sem);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Re-Registration Exam Only", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Subject - %1', MainStudentSubjectCS.Count());
            MainStudentSubjectCS.MODIFYALL(MainStudentSubjectCS."Re-Registration Exam Only", FALSE);
            MainStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, Sem);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Re-Registration Exam Only", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Optional Subject - %1', OptionalStudentSubjectCS.Count());
            OptionalStudentSubjectCS.MODIFYALL("Re-Registration Exam Only", FALSE);
            OptionalStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        MESSAGE('Re-Registration Exam Only UnTick Successfully');
        //Code added for set to false on registration::CSPL-00059::22022019: End
    end;

    procedure SpecialExamUnTickProcess(AcademicYear1: Code[20]; Sem: Code[10])
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    /*AllStudentResultsCS: Record "All Student Results-CS";
    AllStudentResultsCS1: Record "All Student Results-CS";
    LineNo: Integer;
    TotalCredit: Decimal;
    TotalCreditPoint: Decimal;
    TotalCredit1: Decimal;
    TotalCreditPoint1: Decimal;
    GPANEW: Decimal;*/
    begin
        //Code added for set to false on special exam::CSPL-00059::22022019: Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", AcademicYear1);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, Sem);
        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Special Exam", TRUE);
        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Subject - %1', MainStudentSubjectCS.Count());
            MainStudentSubjectCS.MODIFYALL(MainStudentSubjectCS."Special Exam", FALSE);
            MainStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        OptionalStudentSubjectCS.Reset();
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", AcademicYear1);
        OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Semester, Sem);
        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Special Exam", TRUE);
        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
            MESSAGE('Total Student Optional Subject - %1', OptionalStudentSubjectCS.Count());
            OptionalStudentSubjectCS.MODIFYALL("Special Exam", FALSE);
            OptionalStudentSubjectCS.MODIFYALL(Updated, TRUE);
        END;

        MESSAGE('Special Exam Only UnTick Successfully');
        //Code added for set to false on special exam::CSPL-00059::22022019: End
    end;

    procedure CalculateAttendanceForExamWithAddCredit()
    var
        EducationSetupCS: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        SetupExaminationCS: Record "Setup Examination -CS";
        UserSetupRec: Record "User Setup";
        TotalClassHeld: Integer;
        TotalAttendanceTaken: Integer;
        PresentAttendance: Integer;
        AbsentAttendance: Integer;
        AttendancePer: Decimal;
        TotalClassHeld1: Integer;
        TotalAttendanceTaken1: Integer;
        PresentAttendance1: Integer;
        AbsentAttendance1: Integer;
        AttendancePer1: Decimal;
    begin
        //Code added for calculate attendance for exam with add credit::CSPL-00059::22022019: Start
        TotalClassHeld := 0;
        TotalAttendanceTaken := 0;
        PresentAttendance := 0;
        AbsentAttendance := 0;
        AttendancePer := 0;

        UserSetupRec.Get(UserId());
        SetupExaminationCS.Reset();
        IF SetupExaminationCS.FINDFIRST() THEN BEGIN
            EducationSetupCS.Reset();
            EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            IF EducationSetupCS.FINDFIRST() THEN BEGIN
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SetRange(MainStudentSubjectCS."Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", EducationSetupCS."Academic Year");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Re-Registration Exam Only", FALSE);
                    MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                    IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                        REPEAT
                            IF MainStudentSubjectCS."Subject Class" = 'THEORY' THEN BEGIN
                                TotalClassHeld := MainStudentSubjectCS."Total Class Held" + MainStudentSubjectCS.Credit;
                                TotalAttendanceTaken := MainStudentSubjectCS."Total Attendance Taken" + MainStudentSubjectCS.Credit;
                                PresentAttendance := MainStudentSubjectCS."Present Count" + MainStudentSubjectCS.Credit;
                                AbsentAttendance := MainStudentSubjectCS."Absent Count";
                                AttendancePer := ROUND((PresentAttendance / TotalAttendanceTaken) * 100, 1, '>');
                                MainStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                MainStudentSubjectCS."Total Class Held" := TotalClassHeld;
                                MainStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                                MainStudentSubjectCS."Present Count" := PresentAttendance;
                                MainStudentSubjectCS."Absent Count" := AbsentAttendance;
                                MainStudentSubjectCS."Attendance Percentage" := AttendancePer;
                                IF AttendancePer < SetupExaminationCS."Min. External Exam Attd. Per." THEN BEGIN
                                    MainStudentSubjectCS.Detained := TRUE
                                END ELSE BEGIN
                                    MainStudentSubjectCS.Detained := FALSE;
                                END;
                                MainStudentSubjectCS.Updated := TRUE;
                                MainStudentSubjectCS.Modify();
                            END ELSE BEGIN
                                TotalClassHeld := MainStudentSubjectCS."Total Class Held" + 1;
                                TotalAttendanceTaken := MainStudentSubjectCS."Total Attendance Taken" + 1;
                                PresentAttendance := MainStudentSubjectCS."Present Count" + 1;
                                AbsentAttendance := MainStudentSubjectCS."Absent Count";
                                AttendancePer := ROUND((PresentAttendance / TotalAttendanceTaken) * 100, 1, '>');
                                MainStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                MainStudentSubjectCS."Total Class Held" := TotalClassHeld;
                                MainStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                                MainStudentSubjectCS."Present Count" := PresentAttendance;
                                MainStudentSubjectCS."Absent Count" := AbsentAttendance;
                                MainStudentSubjectCS."Attendance Percentage" := AttendancePer;
                                IF AttendancePer < SetupExaminationCS."Min. External Exam Attd. Per." THEN BEGIN
                                    MainStudentSubjectCS.Detained := TRUE
                                END ELSE BEGIN
                                    MainStudentSubjectCS.Detained := FALSE;
                                END;
                                MainStudentSubjectCS.Updated := TRUE;
                                MainStudentSubjectCS.Modify();
                            END;
                        UNTIL MainStudentSubjectCS.NEXT() = 0;
                    END;
                END ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SetRange("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", EducationSetupCS."Academic Year");
                        MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Re-Registration Exam Only", FALSE);
                        MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                        IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                            REPEAT
                                IF MainStudentSubjectCS."Subject Class" = 'THEORY' THEN BEGIN
                                    TotalClassHeld := MainStudentSubjectCS."Total Class Held" + MainStudentSubjectCS.Credit;
                                    TotalAttendanceTaken := MainStudentSubjectCS."Total Attendance Taken" + MainStudentSubjectCS.Credit;
                                    PresentAttendance := MainStudentSubjectCS."Present Count" + MainStudentSubjectCS.Credit;
                                    AbsentAttendance := MainStudentSubjectCS."Absent Count";
                                    AttendancePer := ROUND((PresentAttendance / TotalAttendanceTaken) * 100, 1, '>');
                                    MainStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                    MainStudentSubjectCS."Total Class Held" := TotalClassHeld;
                                    MainStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                                    MainStudentSubjectCS."Present Count" := PresentAttendance;
                                    MainStudentSubjectCS."Absent Count" := AbsentAttendance;
                                    MainStudentSubjectCS."Attendance Percentage" := AttendancePer;
                                    IF AttendancePer < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                                        MainStudentSubjectCS.Detained := TRUE
                                    ELSE
                                        MainStudentSubjectCS.Detained := FALSE;
                                    MainStudentSubjectCS.Updated := TRUE;
                                    MainStudentSubjectCS.Modify();
                                END ELSE BEGIN
                                    TotalClassHeld := MainStudentSubjectCS."Total Class Held" + 1;
                                    TotalAttendanceTaken := MainStudentSubjectCS."Total Attendance Taken" + 1;
                                    PresentAttendance := MainStudentSubjectCS."Present Count" + 1;
                                    AbsentAttendance := MainStudentSubjectCS."Absent Count";
                                    AttendancePer := ROUND((PresentAttendance / TotalAttendanceTaken) * 100, 1, '>');
                                    MainStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                    MainStudentSubjectCS."Total Class Held" := TotalClassHeld;
                                    MainStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken;
                                    MainStudentSubjectCS."Present Count" := PresentAttendance;
                                    MainStudentSubjectCS."Absent Count" := AbsentAttendance;
                                    MainStudentSubjectCS."Attendance Percentage" := AttendancePer;
                                    IF AttendancePer < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                                        MainStudentSubjectCS.Detained := TRUE
                                    ELSE
                                        MainStudentSubjectCS.Detained := FALSE;
                                    MainStudentSubjectCS.Updated := TRUE;
                                    MainStudentSubjectCS.Modify();
                                END;
                            UNTIL MainStudentSubjectCS.NEXT() = 0;
                        END;
                    END;
            END;
        END;
        MESSAGE('Student Subject Attendance Update With Credit.');

        //Student Optional Subject
        TotalClassHeld1 := 0;
        TotalAttendanceTaken1 := 0;
        PresentAttendance1 := 0;
        AbsentAttendance1 := 0;
        AttendancePer1 := 0;

        SetupExaminationCS.Reset();
        IF SetupExaminationCS.FINDFIRST() THEN BEGIN
            EducationSetupCS.Reset();
            EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            IF EducationSetupCS.FINDFIRST() THEN BEGIN
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SetRange("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                    OptionalStudentSubjectCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Updated, FALSE);
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Re-Registration Exam Only", FALSE);
                    //    OptionalStudentSubjectCS.SETRANGE("Enrollment No",'120906746');
                    //   OptionalStudentSubjectCS.SETRANGE("Subject Code",'MAT 1201');
                    OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
                    IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                        REPEAT
                            IF OptionalStudentSubjectCS."Subject Class" = 'THEORY' THEN BEGIN
                                TotalClassHeld1 := OptionalStudentSubjectCS."Total Class Held" + OptionalStudentSubjectCS.Credit;
                                TotalAttendanceTaken1 := OptionalStudentSubjectCS."Total Attendance Taken" + OptionalStudentSubjectCS.Credit;
                                PresentAttendance1 := OptionalStudentSubjectCS."Present Count" + OptionalStudentSubjectCS.Credit;
                                AbsentAttendance1 := OptionalStudentSubjectCS."Absent Count";
                                AttendancePer1 := ROUND((PresentAttendance1 / TotalAttendanceTaken1) * 100, 1, '>');
                                OptionalStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                OptionalStudentSubjectCS."Total Class Held" := TotalClassHeld1;
                                OptionalStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken1;
                                OptionalStudentSubjectCS."Present Count" := PresentAttendance1;
                                OptionalStudentSubjectCS."Absent Count" := AbsentAttendance1;
                                OptionalStudentSubjectCS."Attendance Percentage" := AttendancePer1;
                                IF AttendancePer1 < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                                    OptionalStudentSubjectCS.Detained := TRUE
                                ELSE
                                    OptionalStudentSubjectCS.Detained := FALSE;
                                OptionalStudentSubjectCS.Updated := TRUE;
                                OptionalStudentSubjectCS.Modify();
                            END ELSE BEGIN
                                TotalClassHeld1 := OptionalStudentSubjectCS."Total Class Held" + 1;
                                TotalAttendanceTaken1 := OptionalStudentSubjectCS."Total Attendance Taken" + 1;
                                PresentAttendance1 := OptionalStudentSubjectCS."Present Count" + 1;
                                AbsentAttendance1 := OptionalStudentSubjectCS."Absent Count";
                                AttendancePer1 := ROUND((PresentAttendance1 / TotalAttendanceTaken1) * 100, 1, '>');
                                OptionalStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                OptionalStudentSubjectCS."Total Class Held" := TotalClassHeld1;
                                OptionalStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken1;
                                OptionalStudentSubjectCS."Present Count" := PresentAttendance1;
                                OptionalStudentSubjectCS."Absent Count" := AbsentAttendance1;
                                OptionalStudentSubjectCS."Attendance Percentage" := AttendancePer1;
                                IF AttendancePer1 < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                                    OptionalStudentSubjectCS.Detained := TRUE
                                ELSE
                                    OptionalStudentSubjectCS.Detained := FALSE;
                                OptionalStudentSubjectCS.Updated := TRUE;
                                OptionalStudentSubjectCS.Modify();
                            END;
                        UNTIL OptionalStudentSubjectCS.NEXT() = 0;
                    END;
                END ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SetRange("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", EducationSetupCS."Academic Year");
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Updated, FALSE);
                        OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Re-Registration Exam Only", FALSE);
                        //   MainStudentSubjectCS.SETRANGE("Enrollment No",'120906746');
                        //   MainStudentSubjectCS.SETRANGE("Subject Code",'MAT 1201');
                        OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
                        IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                            REPEAT
                                IF OptionalStudentSubjectCS."Subject Class" = 'THEORY' THEN BEGIN
                                    TotalClassHeld1 := OptionalStudentSubjectCS."Total Class Held" + OptionalStudentSubjectCS.Credit;
                                    TotalAttendanceTaken1 := OptionalStudentSubjectCS."Total Attendance Taken" + OptionalStudentSubjectCS.Credit;
                                    ;
                                    PresentAttendance1 := OptionalStudentSubjectCS."Present Count" + OptionalStudentSubjectCS.Credit;
                                    AbsentAttendance1 := OptionalStudentSubjectCS."Absent Count";
                                    AttendancePer1 := ROUND((PresentAttendance1 / TotalAttendanceTaken1) * 100, 1, '>');
                                    OptionalStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                    OptionalStudentSubjectCS."Total Class Held" := TotalClassHeld1;
                                    OptionalStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken1;
                                    OptionalStudentSubjectCS."Present Count" := PresentAttendance1;
                                    OptionalStudentSubjectCS."Absent Count" := AbsentAttendance1;
                                    OptionalStudentSubjectCS."Attendance Percentage" := AttendancePer1;
                                    IF AttendancePer1 < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                                        OptionalStudentSubjectCS.Detained := TRUE
                                    ELSE
                                        OptionalStudentSubjectCS.Detained := FALSE;
                                    OptionalStudentSubjectCS.Updated := TRUE;
                                    OptionalStudentSubjectCS.Modify();
                                END ELSE BEGIN
                                    TotalClassHeld1 := OptionalStudentSubjectCS."Total Class Held" + 1;
                                    TotalAttendanceTaken1 := OptionalStudentSubjectCS."Total Attendance Taken" + 1;
                                    PresentAttendance1 := OptionalStudentSubjectCS."Present Count" + 1;
                                    AbsentAttendance1 := OptionalStudentSubjectCS."Absent Count";
                                    AttendancePer1 := ROUND((PresentAttendance1 / TotalAttendanceTaken1) * 100, 1, '>');
                                    OptionalStudentSubjectCS."Applicable Attendance per" := SetupExaminationCS."Min. External Exam Attd. Per.";
                                    OptionalStudentSubjectCS."Total Class Held" := TotalClassHeld1;
                                    OptionalStudentSubjectCS."Total Attendance Taken" := TotalAttendanceTaken1;
                                    OptionalStudentSubjectCS."Present Count" := PresentAttendance1;
                                    OptionalStudentSubjectCS."Absent Count" := AbsentAttendance1;
                                    OptionalStudentSubjectCS."Attendance Percentage" := AttendancePer1;
                                    IF AttendancePer1 < SetupExaminationCS."Min. External Exam Attd. Per." THEN
                                        OptionalStudentSubjectCS.Detained := TRUE
                                    ELSE
                                        OptionalStudentSubjectCS.Detained := FALSE;
                                    OptionalStudentSubjectCS.Updated := TRUE;
                                    OptionalStudentSubjectCS.Modify();
                                END;
                            UNTIL OptionalStudentSubjectCS.NEXT() = 0;
                        END;
                    END;
            END;
        END;
        MESSAGE('Student Optional Subject Attendance Update With Credit.');
        //Code added for calculate attendance for exam with add credit::CSPL-00059::22022019: End
    end;
}

