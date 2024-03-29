codeunit 50018 "Schedule Exam Gen-CS"
{
    // version V.001-CS

    // Sr. No.Emp Id    Date    Trigger                                      Remark
    // 1      CSPL-0006722-02-19ExamSchedule                                Code Added for Exam Schedule
    // 2      CSPL-0006722-02-19MakeupExamSchedule                          Code Added for Makeup Exam Schedule
    // 3      CSPL-0006722-02-19ExamScheduleReleased                        Code Added for Exam Schedule Released
    // 4      CSPL-0006722-02-19ExamScheduleReopen                          Code Added for Exam Schedule Reopen
    // 5      CSPL-0006722-02-19CreateExtExamAttlist                        Code Added for Create ExtExam Attlist
    // 6      CSPL-0006722-02-19GetStudentforExternalExamAttendanceLine      Code Added for Get Student for External Exam Attendance Line
    // 7      CSPL-0006722-02-19GetMakeUpStudentforExternalExamAttendanceLineCode Added for Get Make Up Student for External Exam Attendance Line
    // 8      CSPL-0006722-02-19GetWinterStudentforExternalExamAttendanceLineCode Added for Get Winter Student for External Exam Attendance Line
    // 9      CSPL-0006722-02-19GetSummerStudentforExternalExamAttendanceLineCode Added for Get Summer Student for External Exam Attendance Line
    // 10    CSPL-0006722-02-19UpdateDetainedList                          Code Added for Update Detained List
    // 11    CSPL-0006722-02-19ReleaseAll                                  Code Added for Release All
    // 12    CSPL-0006722-02-19Release                                      Code Added for Release
    // 13    CSPL-0006722-02-19Reopen                                      Code Added for Reopen
    // 14    CSPL-0006722-02-19UpdateAttendancePer                          Code Added for Update Attendance Per
    // 15    CSPL-0006722-02-19WinterExamSchedule                          Code Added for Winter Exam Schedule
    // 16    CSPL-0006722-02-19SummerExamSchedule                          Code Added for Summer Exam Schedule


    trigger OnRun()
    begin
    end;

    var

        Text0002Lbl: Label 'All Documents Are Released.Now You Can''t Update the Detained  Attendance list !!!';

    procedure ExamScheduleCS(No: Code[20]; InstituteCode: Code[20]; SubClassFication: Code[20]; AcademicYear: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        ExamTimeTableLineCS1: Record "Exam Time Table Line-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExamTimeTableLineCS2: Record "Exam Time Table Line-CS";
        // SubjectMasterCS: Record "Subject Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        Lineno: Integer;
        // SubCode: Code[20];
        Text_10001Lbl: Label 'Education Setup For Institute Code %1  Is Not Defined !!';
    begin
        //Code Added for Exam Schedule::CSPL-00067::210219:Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF SubClassFication = 'REGULAR' THEN BEGIN
                IF EducationSetupCS."Internal Marks Published" <> TRUE THEN
                    ERROR('Internal Marks Not Published !!');
                IF EducationSetupCS."Exam Schedule Generated" = TRUE THEN
                    ERROR('Exam Schedule Already Generated !!');
            END ELSE
                IF SubClassFication = 'MAKE-UP' THEN
                    IF EducationSetupCS."MakeUp Exam Schedule Generated" = TRUE THEN
                        ERROR('Makeup Exam Schedule Already Generated !!');
        END ELSE
            ERROR(Text_10001Lbl, InstituteCode);

        CourseWiseSubjectLineCS.Reset();
        // IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
        //     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        // ELSE
        //     IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
        //         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", AcademicYear);
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubClassFication);
        CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        IF CourseWiseSubjectLineCS.FINDSET() THEN
            CourseWiseSubjectLineCS.MODIFYALL("Exam Schedule Created", FALSE);



        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY(Semester, "Subject Code");
        // IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
        //     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        // ELSE
        //     IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
        //         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", AcademicYear);
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubClassFication);
        CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        IF CourseWiseSubjectLineCS.FINDSET() THEN
            REPEAT
                IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN BEGIN
                    ExamTimeTableLineCS2.Reset();
                    ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                    ExamTimeTableLineCS2.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                    ExamTimeTableLineCS2.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                    IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                        ExamTimeTableLineCS1.Reset();
                        ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                        IF ExamTimeTableLineCS1.FINDLAST() THEN
                            Lineno := ExamTimeTableLineCS1."Line No." + 10000
                        ELSE
                            Lineno := 10000;

                        ExamTimeTableLineCS.INIT();
                        ExamTimeTableLineCS."Document No." := No;
                        ExamTimeTableLineCS."Line No." := Lineno;
                        ExamTimeTableLineCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                        ExamTimeTableLineCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                        ExamTimeTableLineCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        ExamTimeTableLineCS."Semester Code" := CourseWiseSubjectLineCS.Semester;                            //SubjectWise
                        ExamTimeTableLineCS.Year := CourseWiseSubjectLineCS.Year;                                          //SubjectWise
                        ExamTimeTableLineCS."Program" := CourseWiseSubjectLineCS."Program";                                //SubjectWise
                        ExamTimeTableLineCS."Academic Year" := AcademicYear;
                        ExamTimeTableLineCS."Global Dimension 1 Code" := InstituteCode;
                        ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(CourseWiseSubjectLineCS."Subject Code", 1, 3);
                        ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                        ExamTimeTableLineCS."Created On" := TODAY();
                        ExamTimeTableLineCS."Academic Year" := AcademicYear;
                        ExamTimeTableLineCS.INSERT(TRUE);
                        IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                            ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                            ExamTimeTableHeadCS."Created On" := TODAY();
                            ExamTimeTableHeadCS.MODIFY()
                        END;
                    END;
                END ELSE
                    IF CourseWiseSubjectLineCS."Subject Type" <> 'CORE' THEN BEGIN
                        ExamTimeTableLineCS2.Reset();
                        ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                        ExamTimeTableLineCS2.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                            ExamTimeTableLineCS1.Reset();
                            ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                            IF ExamTimeTableLineCS1.FINDLAST() THEN
                                Lineno := ExamTimeTableLineCS1."Line No." + 10000
                            ELSE
                                Lineno := 10000;

                            ExamTimeTableLineCS.INIT();
                            ExamTimeTableLineCS."Document No." := No;
                            ExamTimeTableLineCS."Line No." := Lineno;
                            ExamTimeTableLineCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            ExamTimeTableLineCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            ExamTimeTableLineCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            ExamTimeTableLineCS."Program" := CourseWiseSubjectLineCS."Program";                                //SubjectWise
                            ExamTimeTableLineCS."Academic Year" := AcademicYear;
                            ExamTimeTableLineCS."Global Dimension 1 Code" := InstituteCode;
                            ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(CourseWiseSubjectLineCS."Subject Code", 1, 3);
                            ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                            ExamTimeTableLineCS."Created On" := TODAY();
                            ExamTimeTableLineCS."Academic Year" := AcademicYear;
                            ExamTimeTableLineCS.INSERT(TRUE);
                            IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                                ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                                ExamTimeTableHeadCS."Created On" := TODAY();
                                ExamTimeTableHeadCS.MODIFY()
                            END;
                        END;
                    END;
                CourseWiseSubjectLineCS."Exam Schedule Created" := TRUE;
                CourseWiseSubjectLineCS.Modify();
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Exam Schedule Generated" := TRUE;
            EducationSetupCS.Modify();
        END;

        //Code Added for Exam Schedule::CSPL-00067::210219:End
    end;

    procedure MakeupExamScheduleCS(No: Code[20]; InstiuteCode: Code[20]; SubClassFication: Code[20]; AcedemicYear: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        ExamTimeTableLineCS1: Record "Exam Time Table Line-CS";

        // CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";

        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExamTimeTableLineCS2: Record "Exam Time Table Line-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        Text_10001Lbl: Label 'Education Setup For Institute Code %1  Is Not Defined !!';
        //SubCode: Code[20];
        Lineno: Integer;

    begin
        //Code Added for Makeup Exam Schedule::CSPL-00067::210219:Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstiuteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            IF EducationSetupCS."Special Exam Sche. Generated" = TRUE THEN
                ERROR('Special Exam Schedule Already Generated !!');
        END ELSE
            ERROR(Text_10001Lbl, InstiuteCode);

        MakeUpExaminationCS.Reset();
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        MakeUpExaminationCS.SETRANGE("Academic Year", AcedemicYear);
        MakeUpExaminationCS.SETRANGE("Global Dimension 1 Code", InstiuteCode);
        MakeUpExaminationCS.SETRANGE("Subject Class", SubClassFication);
        MakeUpExaminationCS.SETRANGE("Exam Classification", 'SPECIAL');
        IF MakeUpExaminationCS.FINDSET() THEN
            MakeUpExaminationCS.MODIFYALL("Exam Schedule Created", FALSE);

        MakeUpExaminationCS.Reset();
        MakeUpExaminationCS.SETCURRENTKEY(Semester, "Subject Code");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        MakeUpExaminationCS.SETRANGE("Academic Year", AcedemicYear);
        MakeUpExaminationCS.SETRANGE("Global Dimension 1 Code", InstiuteCode);
        MakeUpExaminationCS.SETRANGE("Subject Class", SubClassFication);
        MakeUpExaminationCS.SETRANGE("Exam Classification", 'SPECIAL');
        IF MakeUpExaminationCS.FINDSET() THEN
            REPEAT
                IF MakeUpExaminationCS."Subject Type" = 'CORE' THEN BEGIN
                    ExamTimeTableLineCS2.Reset();
                    ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                    ExamTimeTableLineCS2.SETRANGE("Semester Code", MakeUpExaminationCS.Semester);                 //<< CS-SY     SubjectWise
                    ExamTimeTableLineCS2.SETRANGE("Subject Code", MakeUpExaminationCS."Subject Code");
                    IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                        ExamTimeTableLineCS1.Reset();
                        ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                        IF ExamTimeTableLineCS1.FINDLAST() THEN
                            Lineno := ExamTimeTableLineCS1."Line No." + 10000
                        ELSE
                            Lineno := 10000;

                        ExamTimeTableLineCS.INIT();
                        ExamTimeTableLineCS."Document No." := No;
                        ExamTimeTableLineCS."Line No." := Lineno;
                        ExamTimeTableLineCS."Subject Class" := MakeUpExaminationCS."Subject Class";
                        ExamTimeTableLineCS."Subject Type" := MakeUpExaminationCS."Subject Type";
                        ExamTimeTableLineCS.VALIDATE("Subject Code", MakeUpExaminationCS."Subject Code");
                        ExamTimeTableLineCS."Academic Year" := AcedemicYear;
                        ExamTimeTableLineCS.Year := MakeUpExaminationCS.Year;
                        ExamTimeTableLineCS."Semester Code" := MakeUpExaminationCS.Semester;
                        ExamTimeTableLineCS."Program" := MakeUpExaminationCS."Program";
                        ExamTimeTableLineCS."Global Dimension 1 Code" := InstiuteCode;
                        ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(MakeUpExaminationCS."Subject Code", 1, 3);
                        ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                        ExamTimeTableLineCS."Created On" := TODAY();
                        ExamTimeTableLineCS."Academic Year" := AcedemicYear;
                        ExamTimeTableLineCS.INSERT(TRUE);
                        IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                            ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                            ExamTimeTableHeadCS."Created On" := TODAY();
                            ExamTimeTableHeadCS.MODIFY()
                        END;
                    END;
                END ELSE
                    IF MakeUpExaminationCS."Subject Type" <> 'CORE' THEN BEGIN
                        ExamTimeTableLineCS2.Reset();
                        ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                        //ExamTimeTableLineCS2.SETRANGE("Semester Code",MakeUpExaminationCS.Semester);                 //<< CS-SY     SubjectWise
                        ExamTimeTableLineCS2.SETRANGE("Subject Code", MakeUpExaminationCS."Subject Code");
                        IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                            ExamTimeTableLineCS1.Reset();
                            ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                            IF ExamTimeTableLineCS1.FINDLAST() THEN
                                Lineno := ExamTimeTableLineCS1."Line No." + 10000
                            ELSE
                                Lineno := 10000;

                            ExamTimeTableLineCS.INIT();
                            ExamTimeTableLineCS."Document No." := No;
                            ExamTimeTableLineCS."Line No." := Lineno;
                            ExamTimeTableLineCS."Subject Class" := MakeUpExaminationCS."Subject Class";
                            ExamTimeTableLineCS."Subject Type" := MakeUpExaminationCS."Subject Type";
                            ExamTimeTableLineCS.VALIDATE("Subject Code", MakeUpExaminationCS."Subject Code");
                            ExamTimeTableLineCS."Academic Year" := AcedemicYear;
                            ExamTimeTableLineCS."Program" := MakeUpExaminationCS."Program";
                            ExamTimeTableLineCS."Global Dimension 1 Code" := InstiuteCode;
                            ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(MakeUpExaminationCS."Subject Code", 1, 3);
                            ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                            ExamTimeTableLineCS."Created On" := TODAY();
                            ExamTimeTableLineCS."Academic Year" := AcedemicYear;
                            ExamTimeTableLineCS.INSERT(TRUE);
                            IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                                ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                                ExamTimeTableHeadCS."Created On" := TODAY();
                                ExamTimeTableHeadCS.MODIFY()
                            END;
                        END;
                    END;
                MakeUpExaminationCS."Exam Schedule Created" := TRUE;
                MakeUpExaminationCS.Modify();
            UNTIL MakeUpExaminationCS.NEXT() = 0;

        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstiuteCode);
        IF EducationSetupCS.FINDFIRST() THEN BEGIN
            EducationSetupCS."Special Exam Sche. Generated" := TRUE;
            EducationSetupCS.Modify();
        END;

        //Code Added for Makeup Exam Schedule::CSPL-00067::210219:End
    end;

    procedure ExamScheduleReleasedCS(Docno: Code[20])
    var
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        // ExamTimeTableLineCS1: Record "Exam Time Table Line-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        Text0001Lbl: Label 'Do you want to Released Exam Schedule?';
    begin
        //Code Added for Exam Schedule Released::CSPL-00067::210219:Start
        IF NOT CONFIRM(Text0001Lbl) THEN
            EXIT;
        // ExamTimeTableLineCS.Reset();
        // ExamTimeTableLineCS.SETRANGE("Document No.", Docno);
        // IF ExamTimeTableLineCS.FINDSET() THEN
        //     REPEAT
        //         IF ExamTimeTableLineCS."Subject Class" = 'THEORY' THEN BEGIN
        //             IF ExamTimeTableLineCS."Exam Slot New" = '' THEN
        //                 ERROR('Exam Slot should not be blank');
        //             IF ExamTimeTableLineCS."Exam Date" = 0D THEN
        //                 ERROR('ExamSchedule Date should not be blank');
        //             IF ExamTimeTableLineCS."Start Time New" = 0T THEN
        //                 ERROR('Start Time should not be blank');
        //             IF ExamTimeTableLineCS."End Time New" = 0T THEN
        //                 ERROR('End Time should not be blank');
        //         END;
        //     UNTIL ExamTimeTableLineCS.NEXT() = 0
        // ELSE
        //     ERROR('Exam Schedule Should Be Generated !!!');

        IF ExamTimeTableHeadCS.GET(Docno) THEN BEGIN
            ExamTimeTableHeadCS.Status := ExamTimeTableHeadCS.Status::Released;
            ExamTimeTableHeadCS.Modify(true);
        END;
        ExamTimeTableLineCS.SETRANGE("Document No.", Docno);
        ExamTimeTableLineCS.MODIFYALL(Status, ExamTimeTableLineCS.Status::Released);
        //Code Added for Exam Schedule Released::CSPL-00067::210219:End
    end;

    procedure ExamScheduleReopenCS(DocNo: Code[20])
    var

        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        // ExamTimeTableLineCS1: Record "Exam Time Table Line-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        Text0003Lbl: Label 'Do you want to Re-Open Exam Schedule?';
    begin
        //Code Added for Exam Schedule Reopen::CSPL-00067::210219:Start
        IF NOT CONFIRM(Text0003Lbl) THEN
            EXIT;

        IF ExamTimeTableHeadCS.GET(DocNo) THEN BEGIN
            ExamTimeTableHeadCS.Status := ExamTimeTableHeadCS.Status::Open;
            ExamTimeTableHeadCS.MODIFY(true);
        END;
        ExamTimeTableLineCS.SETRANGE("Document No.", DocNo);
        ExamTimeTableLineCS.MODIFYALL(Status, ExamTimeTableLineCS.Status::Open);
        ;
        //Code Added for Exam Schedule Reopen::CSPL-00067::210219:End
    end;

    procedure CreateExtExamAttlistCS(No: Code[20]; ExamType: Option ,Internal,External; ExamDate: Date)
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        NoSeriesLine: Record "No. Series Line";
        SetupExaminationCS: Record "Setup Examination -CS";
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        // CourseMasterCS: Record "Course Master-CS";
        // SubjectMasterCS: Record "Subject Master-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        SubjectClassificationCS: Record "Subject Classification-CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        DocNO: Code[20];

        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING... #1  Out Of  @2 .';
    begin
        //Code Added for Create ExtExam Attlist::CSPL-00067::210219:Start
        SetupExaminationCS.GET();
        ExamTimeTableLineCS.Reset();
        ExamTimeTableLineCS.SETRANGE("Document No.", No);
        ExamTimeTableLineCS.SETFILTER("Ext Exam Attendance No.", '%1', '');
        IF ExamTimeTableLineCS.FINDSET() THEN BEGIN
            TotalCount := ExamTimeTableLineCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                NoSeriesLine.Reset();
                NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", SetupExaminationCS."External Exam Attd. Nos.");
                IF NoSeriesLine.FINDFIRST() THEN
                    IF NoSeriesLine."Last No. Used" <> '' THEN
                        DocNO := INCSTR(NoSeriesLine."Last No. Used")
                    ELSE
                        DocNO := INCSTR(NoSeriesLine."Starting No.");

                ExternalAttendanceHeaderCS.INIT();
                ExternalAttendanceHeaderCS."No." := DocNO;
                IF SubjectClassificationCS.GET(ExamTimeTableLineCS."Subject Class") THEN
                    ExternalAttendanceHeaderCS."Subject Class" := ExamTimeTableLineCS."Subject Class";
                ExternalAttendanceHeaderCS."Attendance Not Applicable" := SubjectClassificationCS."Attendance Not Applicable";
                ExternalAttendanceHeaderCS."Room Allocation" := SubjectClassificationCS."Room Allocation";
                ExternalAttendanceHeaderCS.Invigilator := SubjectClassificationCS.Invigilator;
                ExternalAttendanceHeaderCS."Hall Ticket" := SubjectClassificationCS."Hall Ticket";
                ExternalAttendanceHeaderCS."Exam Schedule No." := ExamTimeTableLineCS."Document No.";
                ExternalAttendanceHeaderCS.VALIDATE(Semester, ExamTimeTableLineCS."Semester Code");
                ExternalAttendanceHeaderCS.VALIDATE(Year, ExamTimeTableLineCS.Year);
                ExternalAttendanceHeaderCS.VALIDATE("Program", ExamTimeTableLineCS."Program");
                //IF CourseCOLLEGE.GET(ExamTimeTableLineCS."Course Code") THEN ;
                //ExternalAttendanceHeaderCS."Type Of Course" := ExamTimeTableLineCS."Type Of Course";
                ExternalAttendanceHeaderCS.VALIDATE("Subject Type", ExamTimeTableLineCS."Subject Type");
                ExternalAttendanceHeaderCS.VALIDATE("Subject Code", ExamTimeTableLineCS."Subject Code");
                ExternalAttendanceHeaderCS.VALIDATE("Academic Year", ExamTimeTableLineCS."Academic Year");
                ExternalAttendanceHeaderCS."Student Group" := ExamTimeTableLineCS."Student Group";
                ExternalAttendanceHeaderCS."Created By" := FORMAT(UserId());
                ExternalAttendanceHeaderCS."Created On" := TODAY();
                ExternalAttendanceHeaderCS.VALIDATE("Global Dimension 1 Code", ExamTimeTableLineCS."Global Dimension 1 Code");
                ExternalAttendanceHeaderCS.VALIDATE("Global Dimension 2 Code", ExamTimeTableLineCS."Global Dimension 2 Code");
                ExternalAttendanceHeaderCS."Document Type" := ExternalAttendanceHeaderCS."Document Type"::External;
                IF ExamTimeTableLineCS."Exam Classification" = 'REGULAR' THEN
                    ExternalAttendanceHeaderCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type"::Regular);

                IF ExamTimeTableLineCS."Exam Classification" = 'Re-Registration' THEN
                    ExternalAttendanceHeaderCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type"::"Re-Registration");

                IF ExamTimeTableLineCS."Exam Classification" = 'MAKE-UP' THEN
                    ExternalAttendanceHeaderCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type"::Makeup);

                IF ExamTimeTableLineCS."Exam Classification" = 'SPECIAL' THEN
                    ExternalAttendanceHeaderCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type"::Special);

                IF ExamTimeTableLineCS."Exam Classification" = 'WINTER' THEN
                    ExternalAttendanceHeaderCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type"::Winter);

                IF ExamTimeTableLineCS."Exam Classification" = 'SUMMER' THEN
                    ExternalAttendanceHeaderCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type"::Summer);
                ExternalAttendanceHeaderCS."Exam Classification" := ExamTimeTableLineCS."Exam Classification";
                ExternalAttendanceHeaderCS."Exam Date" := ExamTimeTableLineCS."Exam Date";
                ExternalAttendanceHeaderCS."Exam Slot" := ExamTimeTableLineCS."Exam Slot New";
                ExternalAttendanceHeaderCS."Start Time" := ExamTimeTableLineCS."Start Time New";
                ExternalAttendanceHeaderCS."End Time" := ExamTimeTableLineCS."End Time New";
                IF SubjectClassificationCS."Attendance Not Applicable" = FALSE THEN BEGIN
                    ExternalAttendanceHeaderCS."Actual Attendance Per %" := SetupExaminationCS."Min. External Exam Attd. Per.";
                    ExternalAttendanceHeaderCS."Attendance Per %" := SetupExaminationCS."Min. External Exam Attd. Per.";
                    ExternalAttendanceHeaderCS."Applicable Att Per%" := SetupExaminationCS."Min. External Exam Attd. Per.";
                END;
                ExternalAttendanceHeaderCS.INSERT();

                NoSeriesLine.Reset();
                NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", SetupExaminationCS."External Exam Attd. Nos.");
                IF NoSeriesLine.FINDFIRST() THEN BEGIN
                    NoSeriesLine."Last No. Used" := DocNO;
                    NoSeriesLine.Modify();
                END;
                ExamTimeTableLineCS."Ext Exam Attendance No." := DocNO;
                ExamTimeTableLineCS.Modify();

                IF ExternalAttendanceHeaderCS."Exam Classification" = 'REGULAR' THEN
                    GetStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS);

                IF ExternalAttendanceHeaderCS."Exam Classification" = 'MAKE-UP' THEN
                    GetMakeUpStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS);

                IF ExternalAttendanceHeaderCS."Exam Classification" = 'SPECIAL' THEN
                    GetMakeUpStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS);

                IF ExternalAttendanceHeaderCS."Exam Classification" = 'WINTER' THEN
                    GetWinterStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS);

                IF ExternalAttendanceHeaderCS."Exam Classification" = 'SUMMER' THEN
                    GetSummerStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS);

            UNTIL ExamTimeTableLineCS.NEXT() = 0;
        END;
        ExamTimeTableHeadCS.Reset();
        IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
            ExamTimeTableHeadCS."Ext Exam Attendance No." := DocNO;
            ExamTimeTableHeadCS.Modify();
        END;
        MESSAGE('Student External Attendance List has been created Successfully.');
        //Code Added for Create ExtExam Attlist::CSPL-00067::210219:End
    end;

    procedure GetStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
    var
        //InternalAttendanceLineCS: Record "Internal Attendance Line-CS";

        SetupExaminationCS: Record "Setup Examination -CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalAttendanceLineCS2: Record "External Attendance Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        //ExternalAttendanceLineCS1: Record "External Attendance Line-CS";
        //ExternalAttendanceLineCS3: Record "External Attendance Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        // ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        //ClassAttendanceLineCS1: Record "Class Attendance Line-CS";
        //ExternalExamLineCS: Record "External Exam Line-CS";
        //SubjectMasterCS1: Record "Subject Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        StudentMasterCS2: Record "Student Master-CS";
        // TotalAttendance: Integer;
        LineNo: Integer;
        //PresentAttendance: Integer;
        //CondonateAttendance: Integer;

        IntRollNo: Integer;
    begin
        //Code Added for Get Student for External Exam Attendance Line::CSPL-00067::210219:Start
        WITH ExternalAttendanceHeaderCS DO BEGIN

            TESTFIELD("Subject Class");
            TESTFIELD("Subject Type");
            TESTFIELD("Subject Code");
            TESTFIELD("Academic Year");
            TESTFIELD("Global Dimension 1 Code");
            TESTFIELD("Document Type");
            TESTFIELD("Exam Type");
            SetupExaminationCS.GET();
            // EducationSetupCS.Reset();
            // EducationSetupCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
            // IF EducationSetupCS.FINDFIRST() THEN
            //     SetupExaminationCS.GET();
            SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");
            IF ExternalAttendanceHeaderCS."Subject Type" = 'CORE' THEN BEGIN
                LineNo := 0;
                CLEAR(MainStudentSubjectCS."Attendance Percentage");
                CLEAR(MainStudentSubjectCS.Detained);
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", Year);
                MainStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                MainStudentSubjectCS.SETRANGE("Subject Class", "Subject Class");
                MainStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
                MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                MainStudentSubjectCS.SETRANGE(Semester, Semester);
                MainStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
                MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    MainStudentSubjectCS.SETFILTER("Current Session", 'JAN-MAY')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        MainStudentSubjectCS.SETFILTER("Current Session", 'JUL-NOV');
                IF MainStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS2.Reset();
                        StudentMasterCS2.SETRANGE("No.", MainStudentSubjectCS."Student No.");
                        StudentMasterCS2.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS2."Student Status"::Student,
                                  StudentMasterCS2."Student Status"::Casual, StudentMasterCS2."Student Status"::"Reject & Rejoin", StudentMasterCS2."Student Status"::"NFT-Extended");
                        IF StudentMasterCS2.FINDFIRST() THEN BEGIN
                            ExternalAttendanceLineCS2.Reset();
                            ExternalAttendanceLineCS2.SETRANGE("Document No.", "No.");
                            IF ExternalAttendanceLineCS2.FINDLAST() THEN
                                LineNo := ExternalAttendanceLineCS2."Line No." + 10000
                            ELSE
                                LineNo += 10000;
                            ExternalAttendanceLineCS2.SETRANGE("Student No.", StudentMasterCS2."No.");
                            IF NOT ExternalAttendanceLineCS2.FINDFIRST() THEN BEGIN
                                ExternalAttendanceLineCS.INIT();
                                ExternalAttendanceLineCS."Document No." := "No.";
                                ExternalAttendanceLineCS."Line No." := LineNo;
                                ExternalAttendanceLineCS.VALIDATE(Course, MainStudentSubjectCS.Course);
                                ExternalAttendanceLineCS.VALIDATE("Program", MainStudentSubjectCS.Graduation);
                                ExternalAttendanceLineCS.VALIDATE(Semester, MainStudentSubjectCS.Semester);
                                ExternalAttendanceLineCS.VALIDATE("Academic Year", MainStudentSubjectCS."Academic Year");
                                ExternalAttendanceLineCS.VALIDATE("Type Of Course", MainStudentSubjectCS."Type Of Course");
                                ExternalAttendanceLineCS.VALIDATE(Year, MainStudentSubjectCS.Year);
                                ExternalAttendanceLineCS.Batch := MainStudentSubjectCS.Batch;
                                ExternalAttendanceLineCS.VALIDATE(Section, MainStudentSubjectCS.Section);
                                ExternalAttendanceLineCS.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
                                ExternalAttendanceLineCS.VALIDATE("Exam Type", "Exam Type");
                                ExternalAttendanceLineCS.VALIDATE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
                                ExternalAttendanceLineCS.VALIDATE("Global Dimension 2 Code", ExternalAttendanceHeaderCS."Global Dimension 2 Code");
                                ExternalAttendanceLineCS.VALIDATE("Subject Class", MainStudentSubjectCS."Subject Class");
                                ExternalAttendanceLineCS.VALIDATE("Subject Code", MainStudentSubjectCS."Subject Code");
                                ExternalAttendanceLineCS.VALIDATE("Subject Type", MainStudentSubjectCS."Subject Type");
                                ExternalAttendanceLineCS.VALIDATE("Student No.", MainStudentSubjectCS."Student No.");
                                ExternalAttendanceLineCS."Exam Schedule No." := "Exam Schedule No.";
                                IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN;
                                ExternalAttendanceLineCS.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
                                ExternalAttendanceLineCS.VALIDATE("Student Name", MainStudentSubjectCS."Student Name");
                                ExternalAttendanceLineCS."Student Group" := MainStudentSubjectCS.Group;
                                IF MainStudentSubjectCS."Roll No." <> '' THEN BEGIN
                                    EVALUATE(IntRollNo, MainStudentSubjectCS."Roll No.");
                                    ExternalAttendanceLineCS."Roll No." := IntRollNo;
                                END;
                                ExternalAttendanceLineCS."Applicable Att Per%" := ExternalAttendanceHeaderCS."Applicable Att Per%";
                                ExternalAttendanceLineCS."Exam Classification" := ExternalAttendanceHeaderCS."Exam Classification";
                                ExternalAttendanceLineCS."Created By" := "User ID";
                                ExternalAttendanceLineCS."Created On" := TODAY();


                                ExternalAttendanceLineCS."Attendance %" := MainStudentSubjectCS."Attendance Percentage";
                                ExternalAttendanceLineCS.Detained := MainStudentSubjectCS.Detained;
                                IF ExternalAttendanceLineCS.Detained <> TRUE THEN
                                    ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present
                                ELSE
                                    ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Absent;
                                ExternalAttendanceLineCS."Exam Date" := ExternalAttendanceHeaderCS."Exam Date";
                                ExternalAttendanceLineCS."Exam Slot" := ExternalAttendanceHeaderCS."Exam Slot";
                                ExternalAttendanceLineCS."Start Time" := ExternalAttendanceHeaderCS."Start Time";
                                ExternalAttendanceLineCS."End Time" := ExternalAttendanceHeaderCS."End Time";
                                ExternalAttendanceLineCS."Attendance Not Applicable" := ExternalAttendanceHeaderCS."Attendance Not Applicable";
                                ExternalAttendanceLineCS.INSERT();
                            END;
                        END;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;

            END ELSE BEGIN
                CLEAR(OptionalStudentSubjectCS."Attendance Percentage");
                CLEAR(OptionalStudentSubjectCS.Detained);
                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", Year);
                OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                OptionalStudentSubjectCS.SETRANGE("Subject Class", "Subject Class");
                OptionalStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
                OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN     //<<Generating Subject Wise for Elective Subjects only
                    OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV');
                    OptionalStudentSubjectCS.SETFILTER("Current Session", 'JAN-MAY');
                END ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                        OptionalStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV');
                        OptionalStudentSubjectCS.SETFILTER("Current Session", 'JUL-NOV');
                    END;
                OptionalStudentSubjectCS.SETRANGE("Subject Drop", FALSE);
                OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");

                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        StudentMasterCS2.Reset();
                        StudentMasterCS2.SETRANGE("No.", OptionalStudentSubjectCS."Student No.");
                        StudentMasterCS2.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS2."Student Status"::Student,
                                   StudentMasterCS2."Student Status"::Casual, StudentMasterCS2."Student Status"::"Reject & Rejoin", StudentMasterCS2."Student Status"::"NFT-Extended");
                        IF StudentMasterCS2.FINDFIRST() THEN BEGIN
                            ExternalAttendanceLineCS2.Reset();
                            ExternalAttendanceLineCS2.SETRANGE("Document No.", "No.");
                            IF ExternalAttendanceLineCS2.FINDLAST() THEN
                                LineNo := ExternalAttendanceLineCS2."Line No." + 10000
                            ELSE
                                LineNo += 10000;
                            ExternalAttendanceLineCS2.SETRANGE("Student No.", StudentMasterCS2."No.");
                            IF NOT ExternalAttendanceLineCS2.FINDFIRST() THEN BEGIN
                                ExternalAttendanceLineCS.INIT();
                                ExternalAttendanceLineCS."Document No." := "No.";
                                ExternalAttendanceLineCS."Line No." := LineNo;
                                ExternalAttendanceLineCS.VALIDATE(Course, OptionalStudentSubjectCS.Course);
                                ExternalAttendanceLineCS.VALIDATE("Program", OptionalStudentSubjectCS.Graduation);
                                ExternalAttendanceLineCS."Student Group" := ExternalAttendanceHeaderCS."Student Group";
                                ExternalAttendanceLineCS.VALIDATE(Semester, OptionalStudentSubjectCS.Semester);
                                ExternalAttendanceLineCS.VALIDATE("Academic Year", OptionalStudentSubjectCS."Academic Year");
                                ExternalAttendanceLineCS.VALIDATE("Type Of Course", OptionalStudentSubjectCS."Type Of Course");
                                ExternalAttendanceLineCS.VALIDATE(Year, OptionalStudentSubjectCS.Year);
                                ExternalAttendanceLineCS.VALIDATE(Section, OptionalStudentSubjectCS.Section);
                                ExternalAttendanceLineCS.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
                                ExternalAttendanceLineCS.VALIDATE("Exam Type", "Exam Type");
                                ExternalAttendanceLineCS.VALIDATE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
                                ExternalAttendanceLineCS.VALIDATE("Global Dimension 2 Code", ExternalAttendanceHeaderCS."Global Dimension 2 Code");
                                ExternalAttendanceLineCS.VALIDATE("Subject Class", OptionalStudentSubjectCS."Subject Class");
                                ExternalAttendanceLineCS.VALIDATE("Subject Code", OptionalStudentSubjectCS."Subject Code");
                                ExternalAttendanceLineCS.VALIDATE("Subject Type", OptionalStudentSubjectCS."Subject Type");
                                ExternalAttendanceLineCS.VALIDATE("Student No.", OptionalStudentSubjectCS."Student No.");
                                IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN;
                                ExternalAttendanceLineCS."Student Group" := OptionalStudentSubjectCS.Group;
                                ExternalAttendanceLineCS."Applicable Att Per%" := ExternalAttendanceHeaderCS."Applicable Att Per%";
                                IF OptionalStudentSubjectCS."Roll No." <> '' THEN BEGIN
                                    EVALUATE(IntRollNo, OptionalStudentSubjectCS."Roll No.");
                                    ExternalAttendanceLineCS."Roll No." := IntRollNo;
                                END;
                                ExternalAttendanceLineCS.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
                                ExternalAttendanceLineCS.VALIDATE("Student Name", OptionalStudentSubjectCS."Student Name");
                                ExternalAttendanceLineCS."Exam Classification" := ExternalAttendanceHeaderCS."Exam Classification";
                                ExternalAttendanceLineCS."Exam Schedule No." := "Exam Schedule No.";
                                ExternalAttendanceLineCS."Created By" := "User ID";
                                ExternalAttendanceLineCS."Created On" := TODAY();


                                ExternalAttendanceLineCS."Attendance %" := OptionalStudentSubjectCS."Attendance Percentage";
                                ExternalAttendanceLineCS.Detained := OptionalStudentSubjectCS.Detained;
                                IF ExternalAttendanceLineCS.Detained <> TRUE THEN
                                    ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present
                                ELSE
                                    ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Absent;
                                ExternalAttendanceLineCS."Exam Date" := ExternalAttendanceHeaderCS."Exam Date";
                                ExternalAttendanceLineCS."Exam Slot" := ExternalAttendanceHeaderCS."Exam Slot";
                                ExternalAttendanceLineCS."Start Time" := ExternalAttendanceHeaderCS."Start Time";
                                ExternalAttendanceLineCS."End Time" := ExternalAttendanceHeaderCS."End Time";

                                ExternalAttendanceLineCS."Attendance Not Applicable" := ExternalAttendanceHeaderCS."Attendance Not Applicable";
                                ExternalAttendanceLineCS.INSERT();
                            END;
                        END;
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;
            END;
        END;
        //Code Added for Get Student for External Exam Attendance Line::CSPL-00067::210219:End
    end;

    procedure GetMakeUpStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
    var
        //InternalAttendanceLineCS: Record "Internal Attendance Line-CS";

        SetupExaminationCS: Record "Setup Examination -CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalAttendanceLineCS2: Record "External Attendance Line-CS";
        // ExternalAttendanceLineCS3: Record "External Attendance Line-CS";
        // MainStudentSubjectCS: Record "Main Student Subject-CS";
        // OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        // ExternalAttendanceLineCS4: Record "External Attendance Line-CS";
        // ExternalAttendanceLineCS5: Record "External Attendance Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        // ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        //ExternalExamLineCS: Record "External Exam Line-CS";
        // SubjectMasterCS1: Record "Subject Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        StudentMasterCS2: Record "Student Master-CS";
        // TotalAttendance: Integer;
        // PresentAttendance: Integer;
        LineNo: Integer;

    begin
        //Code Added for Get Make Up Student for External Exam Attendance Line::CSPL-00067::210219:Start
        WITH ExternalAttendanceHeaderCS DO BEGIN
            TESTFIELD("Subject Class");
            TESTFIELD("Subject Type");
            TESTFIELD("Subject Code");
            TESTFIELD("Academic Year");
            TESTFIELD("Global Dimension 1 Code");
            TESTFIELD("Document Type");
            TESTFIELD("Exam Type");

            SetupExaminationCS.GET();
            SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");

            EducationSetupCS.Reset();
            EducationSetupCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
            IF EducationSetupCS.FINDFIRST() THEN
                LineNo := 0;
            MakeUpExaminationCS.Reset();
            MakeUpExaminationCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Code", "Subject Type", Year);
            MakeUpExaminationCS.SETRANGE("Academic Year", "Academic Year");
            MakeUpExaminationCS.SETRANGE("Subject Class", "Subject Class");
            MakeUpExaminationCS.SETRANGE("Subject Code", "Subject Code");
            IF ExternalAttendanceHeaderCS.Semester <> '' THEN
                MakeUpExaminationCS.SETRANGE(Semester, Semester)
            ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    IF EducationSetupCS."Same Session" THEN
                        MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
                    ELSE
                        MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV')
                END ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        IF EducationSetupCS."Same Session" THEN
                            MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV')
                        ELSE
                            MakeUpExaminationCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV');


            MakeUpExaminationCS.SETRANGE("Exam Classification", ExternalAttendanceHeaderCS."Exam Classification");
            MakeUpExaminationCS.SETRANGE(Cancel, FALSE);
            MakeUpExaminationCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
            IF MakeUpExaminationCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS2.Reset();
                    StudentMasterCS2.SETRANGE("No.", MakeUpExaminationCS."Student No.");
                    StudentMasterCS2.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS2."Student Status"::Student,
                                StudentMasterCS2."Student Status"::Casual, StudentMasterCS2."Student Status"::"Reject & Rejoin", StudentMasterCS2."Student Status"::"NFT-Extended");
                    IF StudentMasterCS2.FINDFIRST() THEN BEGIN
                        ExternalAttendanceLineCS2.Reset();
                        ExternalAttendanceLineCS2.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                        IF ExternalAttendanceLineCS2.FINDLAST() THEN
                            LineNo := ExternalAttendanceLineCS2."Line No." + 10000
                        ELSE
                            LineNo += 10000;
                        ExternalAttendanceLineCS2.SETRANGE("Student No.", StudentMasterCS2."No.");
                        IF NOT ExternalAttendanceLineCS2.FINDFIRST() THEN BEGIN
                            ExternalAttendanceLineCS.INIT();
                            ExternalAttendanceLineCS."Document No." := ExternalAttendanceHeaderCS."No.";
                            ExternalAttendanceLineCS."Line No." := LineNo;
                            ExternalAttendanceLineCS.VALIDATE(Course, MakeUpExaminationCS."Course Code");
                            ExternalAttendanceLineCS.VALIDATE("Program", MakeUpExaminationCS."Program");
                            ExternalAttendanceLineCS.VALIDATE(Semester, MakeUpExaminationCS.Semester);
                            ExternalAttendanceLineCS.VALIDATE("Academic Year", MakeUpExaminationCS."Academic Year");
                            ExternalAttendanceLineCS.VALIDATE("Type Of Course", MakeUpExaminationCS."Type Of Course");
                            ExternalAttendanceLineCS.VALIDATE(Year, MakeUpExaminationCS.Year);
                            ExternalAttendanceLineCS.VALIDATE(Section, MakeUpExaminationCS.Section);
                            ExternalAttendanceLineCS.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
                            ExternalAttendanceLineCS.VALIDATE("Exam Type", ExternalAttendanceHeaderCS."Exam Type");
                            ExternalAttendanceLineCS.VALIDATE("Global Dimension 1 Code", MakeUpExaminationCS."Global Dimension 1 Code");
                            ExternalAttendanceLineCS.VALIDATE("Global Dimension 2 Code", ExternalAttendanceHeaderCS."Global Dimension 2 Code");
                            ExternalAttendanceLineCS.VALIDATE("Subject Class", MakeUpExaminationCS."Subject Class");
                            ExternalAttendanceLineCS.VALIDATE("Subject Type", MakeUpExaminationCS."Subject Type");
                            ExternalAttendanceLineCS.VALIDATE("Subject Code", MakeUpExaminationCS."Subject Code");
                            ExternalAttendanceLineCS."Student No." := MakeUpExaminationCS."Student No.";
                            ExternalAttendanceLineCS."Exam Schedule No." := ExternalAttendanceHeaderCS."Exam Schedule No.";
                            IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN;
                            ExternalAttendanceLineCS.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
                            ExternalAttendanceLineCS.VALIDATE("Student Name", StudentMasterCS."Student Name");
                            IF StudentMasterCS."Roll No." <> '' THEN
                                EVALUATE(ExternalAttendanceLineCS."Roll No.", StudentMasterCS."Roll No.");
                            ExternalAttendanceLineCS."Student Group" := MakeUpExaminationCS."Student Group";
                            ExternalAttendanceLineCS."Applicable Att Per%" := ExternalAttendanceHeaderCS."Applicable Att Per%";
                            ExternalAttendanceLineCS."Exam Classification" := ExternalAttendanceHeaderCS."Exam Classification";
                            //ExternalAttendanceLineCS."Roll No." := MakeUpExaminationCS.
                            ExternalAttendanceLineCS."Created By" := "User ID";
                            ExternalAttendanceLineCS."Created On" := TODAY();



                            ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present;
                            ExternalAttendanceLineCS."Exam Date" := ExternalAttendanceHeaderCS."Exam Date";
                            ExternalAttendanceLineCS."Exam Slot" := ExternalAttendanceHeaderCS."Exam Slot";
                            ExternalAttendanceLineCS."Start Time" := ExternalAttendanceHeaderCS."Start Time";
                            ExternalAttendanceLineCS."End Time" := ExternalAttendanceHeaderCS."End Time";
                            ExternalAttendanceLineCS.INSERT();

                        END;
                    END;
                UNTIL MakeUpExaminationCS.NEXT() = 0;
        END;

        //Code Added for Get Make Up Student for External Exam Attendance Line::CSPL-00067::210219:End
    end;

    procedure GetWinterStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
    var
        // InternalAttendanceLineCS: Record "Internal Attendance Line-CS";

        SetupExaminationCS: Record "Setup Examination -CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalAttendanceLineCS2: Record "External Attendance Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        /* ExternalAttendanceLineCS3: Record "External Attendance Line-CS";
         MainStudentSubjectCS: Record "Main Student Subject-CS";
         OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
         ExternalAttendanceLineCS4: Record "External Attendance Line-CS";
         ExternalAttendanceLineCS5: Record "External Attendance Line-CS";
         
         ClassAttendanceLineCS: Record "Class Attendance Line-CS";

         ExternalExamLineCS: Record "External Exam Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";*/
        EducationSetupCS: Record "Education Setup-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        StudentMasterCS1: Record "Student Master-CS";
        // TotalAttendance: Integer;
        //PresentAttendance: Integer;
        LineNo: Integer;
    begin
        //Code Added for Get Winter Student for External Exam Attendance Line::CSPL-00067::210219:Start
        WITH ExternalAttendanceHeaderCS DO BEGIN
            TESTFIELD("Subject Class");
            TESTFIELD("Subject Type");
            TESTFIELD("Subject Code");
            TESTFIELD("Academic Year");
            TESTFIELD("Global Dimension 1 Code");
            TESTFIELD("Document Type");
            TESTFIELD("Exam Type");

            SetupExaminationCS.GET();
            SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");

            EducationSetupCS.Reset();
            EducationSetupCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
            IF EducationSetupCS.FINDFIRST() THEN
                LineNo := 0;
            RegistrationStudentCS.Reset();
            RegistrationStudentCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Code", "Subject Type", Year);
            RegistrationStudentCS.SETRANGE("Academic Year", "Academic Year");
            RegistrationStudentCS.SETRANGE("Subject Class", "Subject Class");
            RegistrationStudentCS.SETRANGE("Subject Type", "Subject Type");
            RegistrationStudentCS.SETRANGE("Subject Code", "Subject Code");
            IF ExternalAttendanceHeaderCS.Semester <> '' THEN
                RegistrationStudentCS.SETRANGE(Semester, Semester)
            ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    IF EducationSetupCS."Same Session" THEN
                        RegistrationStudentCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
                    ELSE
                        RegistrationStudentCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        IF EducationSetupCS."Same Session" THEN
                            RegistrationStudentCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV')
                        ELSE
                            RegistrationStudentCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV');


            RegistrationStudentCS.SETRANGE(Session, 'WINTER');
            RegistrationStudentCS.SETRANGE(Cancel, FALSE);
            RegistrationStudentCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
            IF RegistrationStudentCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS1.Reset();
                    StudentMasterCS1.SETRANGE("No.", RegistrationStudentCS."Student No.");
                    StudentMasterCS1.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS1."Student Status"::Student,
                                StudentMasterCS1."Student Status"::Casual, StudentMasterCS1."Student Status"::"Reject & Rejoin", StudentMasterCS1."Student Status"::"NFT-Extended");
                    IF StudentMasterCS1.FINDFIRST() THEN BEGIN
                        ExternalAttendanceLineCS2.Reset();
                        ExternalAttendanceLineCS2.SETRANGE("Document No.", "No.");
                        IF ExternalAttendanceLineCS2.FINDLAST() THEN
                            LineNo := ExternalAttendanceLineCS2."Line No." + 10000
                        ELSE
                            LineNo += 10000;
                        ExternalAttendanceLineCS2.SETRANGE("Student No.", StudentMasterCS1."No.");
                        IF NOT ExternalAttendanceLineCS2.FINDFIRST() THEN BEGIN
                            ExternalAttendanceLineCS.INIT();
                            ExternalAttendanceLineCS."Document No." := "No.";
                            ExternalAttendanceLineCS."Line No." := LineNo;
                            ExternalAttendanceLineCS.VALIDATE(Course, RegistrationStudentCS."Course Code");
                            ExternalAttendanceLineCS.VALIDATE("Program", ExternalAttendanceHeaderCS."Program");
                            ExternalAttendanceLineCS.VALIDATE(Semester, RegistrationStudentCS.Semester);
                            ExternalAttendanceLineCS.VALIDATE("Academic Year", RegistrationStudentCS."Academic Year");
                            ExternalAttendanceLineCS.VALIDATE("Type Of Course", ExternalAttendanceHeaderCS."Type Of Course");
                            ExternalAttendanceLineCS.VALIDATE(Year, RegistrationStudentCS.Year);
                            ExternalAttendanceLineCS.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
                            ExternalAttendanceLineCS.VALIDATE("Exam Type", "Exam Type");
                            ExternalAttendanceLineCS.VALIDATE("Global Dimension 1 Code", RegistrationStudentCS."Global Dimension 1 Code");
                            ExternalAttendanceLineCS.VALIDATE("Global Dimension 2 Code", ExternalAttendanceHeaderCS."Global Dimension 2 Code");
                            ExternalAttendanceLineCS.VALIDATE("Subject Class", RegistrationStudentCS."Subject Class");
                            ExternalAttendanceLineCS.VALIDATE("Subject Type", RegistrationStudentCS."Subject Type");
                            ExternalAttendanceLineCS.VALIDATE("Subject Code", RegistrationStudentCS."Subject Code");
                            ExternalAttendanceLineCS.VALIDATE("Student No.", RegistrationStudentCS."Student No.");
                            ExternalAttendanceLineCS."Exam Schedule No." := "Exam Schedule No.";
                            IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN;
                            ExternalAttendanceLineCS.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
                            ExternalAttendanceLineCS.VALIDATE("Student Name", RegistrationStudentCS."Student Name");
                            ExternalAttendanceLineCS."Applicable Att Per%" := ExternalAttendanceHeaderCS."Applicable Att Per%";
                            ExternalAttendanceLineCS."Exam Classification" := ExternalAttendanceHeaderCS."Exam Classification";
                            ExternalAttendanceLineCS."Created By" := "User ID";
                            ExternalAttendanceLineCS."Created On" := TODAY();
                            ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present;
                            ExternalAttendanceLineCS."Exam Date" := ExternalAttendanceHeaderCS."Exam Date";
                            ExternalAttendanceLineCS."Exam Slot" := ExternalAttendanceHeaderCS."Exam Slot";
                            ExternalAttendanceLineCS."Start Time" := ExternalAttendanceHeaderCS."Start Time";
                            ExternalAttendanceLineCS."End Time" := ExternalAttendanceHeaderCS."End Time";
                            ExternalAttendanceLineCS.INSERT();
                        END;
                    END;
                UNTIL RegistrationStudentCS.NEXT() = 0;
        END;

        //Code Added for Get Winter Student for External Exam Attendance Line::CSPL-00067::210219:End
    end;

    procedure GetSummerStudentforExternalExamAttendanceLineCS(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
    var
        // InternalAttendanceLineCS: Record "Internal Attendance Line-CS";

        SetupExaminationCS: Record "Setup Examination -CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        // ExternalAttendanceLineCS1: Record "External Attendance Line-CS";
        ExternalAttendanceLineCS2: Record "External Attendance Line-CS";
        //  MainStudentSubjectCS: Record "Main Student Subject-CS";
        // OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        // ExternalAttendanceLineCS3: Record "External Attendance Line-CS";
        // ExternalAttendanceLineCS4: Record "External Attendance Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        // ClassAttendanceLineCS: Record "Class Attendance Line-CS";
        // ExternalExamLineCS: Record "External Exam Line-CS";
        // SubjectMasterCS: Record "Subject Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        StudentMasterCS1: Record "Student Master-CS";
        // TotalAttendance: Integer;
        LineNo: Integer;
    // PresentAttendance: Integer;

    begin
        //Code Added for Get Summer Student for External Exam Attendance Line::CSPL-00067::210219:Start
        WITH ExternalAttendanceHeaderCS DO BEGIN
            TESTFIELD("Subject Class");
            TESTFIELD("Subject Type");
            TESTFIELD("Subject Code");
            TESTFIELD("Academic Year");
            TESTFIELD("Global Dimension 1 Code");
            TESTFIELD("Document Type");
            TESTFIELD("Exam Type");

            SetupExaminationCS.GET();
            SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");

            EducationSetupCS.Reset();
            EducationSetupCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
            IF EducationSetupCS.FINDFIRST() THEN
                LineNo := 0;
            RegistrationStudentCS.Reset();
            RegistrationStudentCS.SETCURRENTKEY("Course Code", Semester, "Academic Year", "Subject Code", "Subject Type", Year);
            RegistrationStudentCS.SETRANGE("Academic Year", "Academic Year");
            RegistrationStudentCS.SETRANGE("Subject Class", "Subject Class");
            RegistrationStudentCS.SETRANGE("Subject Type", "Subject Type");
            RegistrationStudentCS.SETRANGE("Subject Code", "Subject Code");
            IF ExternalAttendanceHeaderCS.Semester <> '' THEN
                RegistrationStudentCS.SETRANGE(Semester, Semester)
            ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    RegistrationStudentCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'II', 'IV', 'VI', 'VIII', 'III & IV')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        RegistrationStudentCS.SETFILTER(Semester, '%1|%2|%3|%4|%5', 'I', 'III', 'V', 'VII', 'III & IV');

            RegistrationStudentCS.SETRANGE(Session, 'Summer');
            RegistrationStudentCS.SETRANGE(Cancel, FALSE);
            RegistrationStudentCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
            IF RegistrationStudentCS.FINDSET() THEN
                REPEAT
                    StudentMasterCS1.Reset();
                    StudentMasterCS1.SETRANGE("No.", RegistrationStudentCS."Student No.");
                    StudentMasterCS1.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS1."Student Status"::Student,
                                StudentMasterCS1."Student Status"::Casual, StudentMasterCS1."Student Status"::"Reject & Rejoin", StudentMasterCS1."Student Status"::"NFT-Extended");
                    IF StudentMasterCS1.FINDFIRST() THEN BEGIN
                        ExternalAttendanceLineCS2.Reset();
                        ExternalAttendanceLineCS2.SETRANGE("Document No.", "No.");
                        IF ExternalAttendanceLineCS2.FINDLAST() THEN
                            LineNo := ExternalAttendanceLineCS2."Line No." + 10000
                        ELSE
                            LineNo += 10000;
                        ExternalAttendanceLineCS2.SETRANGE("Student No.", StudentMasterCS1."No.");
                        IF NOT ExternalAttendanceLineCS2.FINDFIRST() THEN BEGIN
                            ExternalAttendanceLineCS.INIT();
                            ExternalAttendanceLineCS."Document No." := "No.";
                            ExternalAttendanceLineCS."Line No." := LineNo;
                            ExternalAttendanceLineCS.VALIDATE(Course, RegistrationStudentCS."Course Code");
                            ExternalAttendanceLineCS.VALIDATE("Program", ExternalAttendanceHeaderCS."Program");
                            ExternalAttendanceLineCS.VALIDATE(Semester, RegistrationStudentCS.Semester);
                            ExternalAttendanceLineCS.VALIDATE("Academic Year", RegistrationStudentCS."Academic Year");
                            ExternalAttendanceLineCS.VALIDATE("Type Of Course", ExternalAttendanceHeaderCS."Type Of Course");
                            ExternalAttendanceLineCS.VALIDATE(Year, RegistrationStudentCS.Year);
                            ExternalAttendanceLineCS.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
                            ExternalAttendanceLineCS.VALIDATE("Exam Type", "Exam Type");
                            ExternalAttendanceLineCS.VALIDATE("Global Dimension 1 Code", RegistrationStudentCS."Global Dimension 1 Code");
                            ExternalAttendanceLineCS.VALIDATE("Global Dimension 2 Code", ExternalAttendanceHeaderCS."Global Dimension 2 Code");
                            ExternalAttendanceLineCS.VALIDATE("Subject Class", RegistrationStudentCS."Subject Class");
                            ExternalAttendanceLineCS.VALIDATE("Subject Type", RegistrationStudentCS."Subject Type");
                            ExternalAttendanceLineCS.VALIDATE("Subject Code", RegistrationStudentCS."Subject Code");
                            ExternalAttendanceLineCS.VALIDATE("Student No.", RegistrationStudentCS."Student No.");
                            ExternalAttendanceLineCS."Exam Schedule No." := "Exam Schedule No.";
                            IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN;
                            ExternalAttendanceLineCS.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
                            ExternalAttendanceLineCS.VALIDATE("Student Name", RegistrationStudentCS."Student Name");
                            ExternalAttendanceLineCS."Applicable Att Per%" := ExternalAttendanceHeaderCS."Applicable Att Per%";
                            ExternalAttendanceLineCS."Exam Classification" := ExternalAttendanceHeaderCS."Exam Classification";
                            ExternalAttendanceLineCS."Created By" := "User ID";
                            ExternalAttendanceLineCS."Created On" := TODAY();

                            ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present;
                            ExternalAttendanceLineCS."Exam Date" := ExternalAttendanceHeaderCS."Exam Date";
                            ExternalAttendanceLineCS."Exam Slot" := ExternalAttendanceHeaderCS."Exam Slot";
                            ExternalAttendanceLineCS."Start Time" := ExternalAttendanceHeaderCS."Start Time";
                            ExternalAttendanceLineCS."End Time" := ExternalAttendanceHeaderCS."End Time";
                            ExternalAttendanceLineCS.INSERT();
                        END;
                    END;
                UNTIL RegistrationStudentCS.NEXT() = 0;
        END;

        //Code Added for Get Summer Student for External Exam Attendance Line::CSPL-00067::210219:End
    end;

    procedure UpdateDetainedListCS(Scheduleno: Code[20]; "Per%": Decimal)
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        SetupExaminationCS: Record "Setup Examination -CS";
    begin
        //Code Added for Update Detained List::CSPL-00067::210219:Start
        SetupExaminationCS.GET();

        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETRANGE("Exam Schedule No.", Scheduleno);
        IF ExternalAttendanceHeaderCS.FINDFIRST() THEN
            IF ExternalAttendanceHeaderCS.Status = ExternalAttendanceHeaderCS.Status::Released THEN
                ERROR(Text0002Lbl);
        IF ExternalAttendanceHeaderCS."Attendance Not Applicable" THEN
            ERROR(Text0002Lbl);

        IF "Per%" <> 0 THEN BEGIN
            ExternalAttendanceHeaderCS.Reset();                  //<< Modified Code
            ExternalAttendanceHeaderCS.SETCURRENTKEY("Exam Schedule No.");
            ExternalAttendanceHeaderCS.SETRANGE("Exam Schedule No.", Scheduleno);
            IF ExternalAttendanceHeaderCS.FINDSET() THEN
                REPEAT
                    ExternalAttendanceLineCS.Reset();
                    ExternalAttendanceLineCS.SETCURRENTKEY("Document No.", "Attendance %");
                    ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                    ExternalAttendanceLineCS.SETRANGE("Attendance %", "Per%", SetupExaminationCS."Min. External Exam Attd. Per.");
                    IF ExternalAttendanceLineCS.FINDSET() THEN BEGIN
                        ExternalAttendanceLineCS.MODIFYALL("Attendance %", SetupExaminationCS."Min. External Exam Attd. Per.");
                        ExternalAttendanceLineCS.MODIFYALL("Applicable Att Per%", "Per%");
                        ExternalAttendanceLineCS.MODIFYALL("Attendance Type", ExternalAttendanceLineCS."Attendance Type"::Present);
                        ExternalAttendanceLineCS.MODIFYALL(Detained, FALSE);
                    END;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETCURRENTKEY("Academic Year", "Subject Class", "Subject Type", "Subject Code", "Global Dimension 1 Code", "Attendance Percentage");
                    MainStudentSubjectCS.SETRANGE("Academic Year", ExternalAttendanceHeaderCS."Academic Year");
                    MainStudentSubjectCS.SETRANGE("Subject Class", ExternalAttendanceHeaderCS."Subject Class");
                    MainStudentSubjectCS.SETRANGE("Subject Type", ExternalAttendanceHeaderCS."Subject Type");
                    MainStudentSubjectCS.SETRANGE("Subject Code", ExternalAttendanceHeaderCS."Subject Code");
                    MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
                    MainStudentSubjectCS.SETRANGE("Attendance Percentage", "Per%", SetupExaminationCS."Min. External Exam Attd. Per.");
                    IF MainStudentSubjectCS.FINDSET() THEN BEGIN
                        MainStudentSubjectCS.MODIFYALL("Attendance Percentage", SetupExaminationCS."Min. External Exam Attd. Per.");
                        MainStudentSubjectCS.MODIFYALL("Applicable Attendance per", "Per%");
                        MainStudentSubjectCS.MODIFYALL(Detained, FALSE);
                    END;

                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SETCURRENTKEY("Academic Year", "Subject Class", "Subject Type", "Subject Code", "Global Dimension 1 Code", "Attendance Percentage");
                    OptionalStudentSubjectCS.SETRANGE("Academic Year", ExternalAttendanceHeaderCS."Academic Year");
                    OptionalStudentSubjectCS.SETRANGE("Subject Class", ExternalAttendanceHeaderCS."Subject Class");
                    OptionalStudentSubjectCS.SETRANGE("Subject Type", ExternalAttendanceHeaderCS."Subject Type");
                    OptionalStudentSubjectCS.SETRANGE("Subject Code", ExternalAttendanceHeaderCS."Subject Code");
                    OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalAttendanceHeaderCS."Global Dimension 1 Code");
                    OptionalStudentSubjectCS.SETRANGE("Attendance Percentage", "Per%", SetupExaminationCS."Min. External Exam Attd. Per.");
                    IF OptionalStudentSubjectCS.FINDSET() THEN BEGIN
                        OptionalStudentSubjectCS.MODIFYALL("Attendance Percentage", SetupExaminationCS."Min. External Exam Attd. Per.");
                        OptionalStudentSubjectCS.MODIFYALL("Applicable Attendance per", "Per%");
                        OptionalStudentSubjectCS.MODIFYALL(Detained, FALSE);
                    END;

                    ExternalAttendanceHeaderCS."Applicable Att Per%" := "Per%";
                    ExternalAttendanceHeaderCS."Attendance Per %" := "Per%";
                    ExternalAttendanceHeaderCS.Modify();
                UNTIL ExternalAttendanceHeaderCS.NEXT() = 0;

            AdmitCardLineCS.Reset();
            AdmitCardLineCS.SETCURRENTKEY("Exam Schedule No.", "Actual Per%");
            AdmitCardLineCS.SETRANGE("Exam Schedule No.", Scheduleno);
            AdmitCardLineCS.SETRANGE("Actual Per%", "Per%", SetupExaminationCS."Min. External Exam Attd. Per.");
            IF AdmitCardLineCS.FINDSET() THEN BEGIN
                AdmitCardLineCS.MODIFYALL("Actual Per%", SetupExaminationCS."Min. External Exam Attd. Per.");
                AdmitCardLineCS.MODIFYALL("Applicable Per %", "Per%");
                AdmitCardLineCS.MODIFYALL(Detained, FALSE);
            END;

            MESSAGE('Udpate Successfully')
        END;
        //Code Added for Update Detained List::CSPL-00067::210219:End
    end;

    procedure ReleaseAllCS(ExamSchduleCode: Code[20])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
    begin
        //Code Added for Release All::CSPL-00067::210219:Start
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETRANGE("Exam Schedule No.", ExamSchduleCode);
        ExternalAttendanceHeaderCS.SETRANGE(Status, ExternalAttendanceHeaderCS.Status::Open);
        IF ExternalAttendanceHeaderCS.FINDSET() THEN
            REPEAT
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        IF ExternalAttendanceHeaderCS."Subject Class" = 'THEORY' THEN
                            IF (((ExternalAttendanceLineCS."Hall Ticket No." <> '') AND (ExternalAttendanceLineCS."Room Alloted No." <> '')) AND (
                              (ExternalAttendanceLineCS."Invigilator 1" <> '') OR (ExternalAttendanceLineCS."Invigilator 2" <> '') OR
                              (ExternalAttendanceLineCS."Invigilator 3" <> '') OR (ExternalAttendanceLineCS."Invigilator 4" <> ''))) THEN BEGIN
                                ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                ExternalAttendanceLineCS.Modify();
                            END ELSE
                                IF ExternalAttendanceLineCS."Hall Ticket No." = '' THEN
                                    ERROR('Hall ticket should be generated for student %1 in Document No. %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                        IF ExternalAttendanceLineCS."Room Alloted No." = '' THEN
                            ERROR('Room should be Alloted for student %1 in Document No. %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                        IF ExternalAttendanceLineCS."Invigilator 1" = '' THEN
                            ERROR('Invigilator should be generated for Room No. %1 in Document No %2', ExternalAttendanceLineCS."Room Alloted No.", ExternalAttendanceLineCS."Document No.")


                        ELSE
                            IF ExternalAttendanceHeaderCS."Subject Class" = 'LAB' THEN BEGIN
                                IF (((ExternalAttendanceLineCS."Room Alloted No." <> '')) AND ((ExternalAttendanceLineCS."Invigilator 1" <> '')
                                  OR (ExternalAttendanceLineCS."Invigilator 2" <> '') OR (ExternalAttendanceLineCS."Invigilator 3" <> '') OR
                                   (ExternalAttendanceLineCS."Invigilator 4" <> ''))) THEN BEGIN
                                    ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                    ExternalAttendanceLineCS.Modify();
                                END ELSE BEGIN
                                    IF ExternalAttendanceLineCS."Room Alloted No." = '' THEN
                                        ERROR('Room should be Alloted for student %1 in Document No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                    IF ExternalAttendanceLineCS."Invigilator 1" = '' THEN
                                        ERROR('Invigilator should be generated for Room No. %1 in Document No %2', ExternalAttendanceLineCS."Room Alloted No.", ExternalAttendanceLineCS."Document No.");
                                END;
                            END ELSE
                                IF ExternalAttendanceHeaderCS."Subject Class" = 'SEMINAR' THEN BEGIN
                                    IF (((ExternalAttendanceLineCS."Room Alloted No." = '')) AND (ExternalAttendanceLineCS."Hall Ticket No." = '') AND (
                                      (ExternalAttendanceLineCS."Invigilator 1" = '') AND (ExternalAttendanceLineCS."Invigilator 2" = '') AND
                                      (ExternalAttendanceLineCS."Invigilator 3" = '') AND (ExternalAttendanceLineCS."Invigilator 4" = ''))) THEN BEGIN
                                        ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                        ExternalAttendanceLineCS.Modify();
                                    END ELSE BEGIN
                                        IF ExternalAttendanceLineCS."Hall Ticket No." <> '' THEN
                                            ERROR('Hall ticket should be blank  for student %1 in Document No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                        IF ExternalAttendanceLineCS."Room Alloted No." <> '' THEN
                                            ERROR('Room No. should be blank for student %1 in Document No. %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                        IF ExternalAttendanceLineCS."Invigilator 1" <> '' THEN
                                            ERROR('Invigilator should not be generated for Room No. %1 in Document No. %2', ExternalAttendanceLineCS."Room Alloted No.", ExternalAttendanceLineCS."Document No.")
                                    END;
                                END ELSE
                                    IF ExternalAttendanceHeaderCS."Subject Class" = 'PROJECT' THEN BEGIN
                                        IF (((ExternalAttendanceLineCS."Room Alloted No." = '')) AND (ExternalAttendanceLineCS."Hall Ticket No." = '') AND (
                                          (ExternalAttendanceLineCS."Invigilator 1" = '') AND (ExternalAttendanceLineCS."Invigilator 2" = '') AND
                                          (ExternalAttendanceLineCS."Invigilator 3" = '') AND (ExternalAttendanceLineCS."Invigilator 4" = ''))) THEN BEGIN
                                            ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                            ExternalAttendanceLineCS.Modify();
                                        END ELSE BEGIN
                                            IF ExternalAttendanceLineCS."Hall Ticket No." <> '' THEN
                                                ERROR('Hall ticket should be blank  for student %1 in Document No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                            IF ExternalAttendanceLineCS."Room Alloted No." <> '' THEN
                                                ERROR('Room No. should be blank for student %1 in Document No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                            IF ExternalAttendanceLineCS."Invigilator 1" <> '' THEN
                                                ERROR('Invigilator should not be generated for Room No. %1 in Document No. %2', ExternalAttendanceLineCS."Room Alloted No.", ExternalAttendanceLineCS."Document No.")
                                        END;
                                    END
                                    ELSE
                                        IF ExternalAttendanceHeaderCS."Subject Class" = 'INDUSTRAINING' THEN
                                            IF (((ExternalAttendanceLineCS."Room Alloted No." = '')) AND (ExternalAttendanceLineCS."Hall Ticket No." = '') AND (
                                              (ExternalAttendanceLineCS."Invigilator 1" = '') AND (ExternalAttendanceLineCS."Invigilator 2" = '') AND
                                              (ExternalAttendanceLineCS."Invigilator 3" = '') AND (ExternalAttendanceLineCS."Invigilator 4" = ''))) THEN BEGIN
                                                ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                                ExternalAttendanceLineCS.Modify();
                                            END ELSE BEGIN
                                                IF ExternalAttendanceLineCS."Hall Ticket No." <> '' THEN
                                                    ERROR('Hall ticket should be blank  for student %1 in Document No. %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                                IF ExternalAttendanceLineCS."Room Alloted No." <> '' THEN
                                                    ERROR('Room No. should   be blank for student %1 in Document No. %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Document No.");
                                                IF ExternalAttendanceLineCS."Invigilator 1" <> '' THEN
                                                    ERROR('Invigilator should not be generated for Room No. %1 in Document No. %2', ExternalAttendanceLineCS."Room Alloted No.", ExternalAttendanceLineCS."Document No.")
                                            END;

                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                ExternalAttendanceHeaderCS.Status := ExternalAttendanceHeaderCS.Status::Released;
                ExternalAttendanceHeaderCS.Modify();
            UNTIL ExternalAttendanceHeaderCS.NEXT() = 0
        ELSE
            ERROR('All Documents Are Released !!');
        //Code Added for Release All::CSPL-00067::210219:End
    end;

    procedure ReleaseCS(No: Code[20])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
    begin
        //Code Added for Release::CSPL-00067::210219:Start
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETRANGE("No.", No);
        ExternalAttendanceHeaderCS.SETRANGE(Status, ExternalAttendanceHeaderCS.Status::Open);
        IF ExternalAttendanceHeaderCS.FINDSET() THEN BEGIN
            REPEAT
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
                ExternalAttendanceLineCS.SETRANGE(Detained, FALSE);
                IF ExternalAttendanceLineCS.FINDSET() THEN
                    REPEAT
                        IF ExternalAttendanceHeaderCS."Subject Class" = 'THEORY' THEN BEGIN
                            IF (((ExternalAttendanceLineCS."Hall Ticket No." <> '') AND (ExternalAttendanceLineCS."Room Alloted No." <> '')) AND (
                              (ExternalAttendanceLineCS."Invigilator 1" <> '') OR (ExternalAttendanceLineCS."Invigilator 2" <> '') OR
                              (ExternalAttendanceLineCS."Invigilator 3" <> '') OR (ExternalAttendanceLineCS."Invigilator 4" <> ''))) THEN BEGIN
                                ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                ExternalAttendanceLineCS.Modify();
                            END ELSE BEGIN
                                IF ExternalAttendanceLineCS."Hall Ticket No." = '' THEN
                                    ERROR('Hall ticket should be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                IF ExternalAttendanceLineCS."Room Alloted No." = '' THEN
                                    ERROR('Room Alloted should be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                IF ExternalAttendanceLineCS."Invigilator 1" = '' THEN
                                    ERROR('Invigilator should be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.")
                            END;

                        END ELSE
                            IF ExternalAttendanceHeaderCS."Subject Class" = 'LAB' THEN BEGIN
                                IF (((ExternalAttendanceLineCS."Room Alloted No." <> '')) AND ((ExternalAttendanceLineCS."Invigilator 1" <> '')
                                  OR (ExternalAttendanceLineCS."Invigilator 2" <> '') OR (ExternalAttendanceLineCS."Invigilator 3" <> '') OR
                                   (ExternalAttendanceLineCS."Invigilator 4" <> ''))) THEN BEGIN
                                    ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                    ExternalAttendanceLineCS.Modify();
                                END ELSE BEGIN
                                    IF ExternalAttendanceLineCS."Room Alloted No." = '' THEN
                                        ERROR('Room Alloted should be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                    IF ExternalAttendanceLineCS."Invigilator 1" = '' THEN
                                        ERROR('Invigilator should be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.")
                                END;
                            END ELSE
                                IF ExternalAttendanceHeaderCS."Subject Class" = 'SEMINAR' THEN BEGIN
                                    IF (((ExternalAttendanceLineCS."Room Alloted No." = '')) AND (ExternalAttendanceLineCS."Hall Ticket No." = '') AND (
                                      (ExternalAttendanceLineCS."Invigilator 1" = '') AND (ExternalAttendanceLineCS."Invigilator 2" = '') AND
                                      (ExternalAttendanceLineCS."Invigilator 3" = '') AND (ExternalAttendanceLineCS."Invigilator 4" = ''))) THEN BEGIN
                                        ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                        ExternalAttendanceLineCS.Modify();
                                    END ELSE BEGIN
                                        IF ExternalAttendanceLineCS."Hall Ticket No." <> '' THEN
                                            ERROR('Hall ticket should be blank  for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                        IF ExternalAttendanceLineCS."Room Alloted No." <> '' THEN
                                            ERROR('Room Alloted should   be blank for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                        IF ExternalAttendanceLineCS."Invigilator 1" <> '' THEN
                                            ERROR('Invigilator should not be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.")
                                    END;
                                END ELSE
                                    IF ExternalAttendanceHeaderCS."Subject Class" = 'PROJECT' THEN BEGIN
                                        IF (((ExternalAttendanceLineCS."Room Alloted No." = '')) AND (ExternalAttendanceLineCS."Hall Ticket No." = '') AND (
                                          (ExternalAttendanceLineCS."Invigilator 1" = '') AND (ExternalAttendanceLineCS."Invigilator 2" = '') AND
                                          (ExternalAttendanceLineCS."Invigilator 3" = '') AND (ExternalAttendanceLineCS."Invigilator 4" = ''))) THEN BEGIN
                                            ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                            ExternalAttendanceLineCS.Modify();
                                        END ELSE BEGIN
                                            IF ExternalAttendanceLineCS."Hall Ticket No." <> '' THEN
                                                ERROR('Hall ticket should be blank  for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                            IF ExternalAttendanceLineCS."Room Alloted No." <> '' THEN
                                                ERROR('Room Alloted should   be blank for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                            IF ExternalAttendanceLineCS."Invigilator 1" <> '' THEN
                                                ERROR('Invigilator should not be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.")
                                        END;
                                    END
                                    ELSE
                                        IF ExternalAttendanceHeaderCS."Subject Class" = 'INDUSTRAINING' THEN BEGIN
                                            IF (((ExternalAttendanceLineCS."Room Alloted No." = '')) AND (ExternalAttendanceLineCS."Hall Ticket No." = '') AND (
                                              (ExternalAttendanceLineCS."Invigilator 1" = '') AND (ExternalAttendanceLineCS."Invigilator 2" = '') AND
                                              (ExternalAttendanceLineCS."Invigilator 3" = '') AND (ExternalAttendanceLineCS."Invigilator 4" = ''))) THEN BEGIN
                                                ExternalAttendanceLineCS.Status := ExternalAttendanceLineCS.Status::Released;
                                                ExternalAttendanceLineCS.Modify();
                                            END ELSE BEGIN
                                                IF ExternalAttendanceLineCS."Hall Ticket No." <> '' THEN
                                                    ERROR('Hall ticket should be blank  for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                                IF ExternalAttendanceLineCS."Room Alloted No." <> '' THEN
                                                    ERROR('Room Alloted should   be blank for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.");
                                                IF ExternalAttendanceLineCS."Invigilator 1" <> '' THEN
                                                    ERROR('Invigilator should not be generated for student %1 in exam schedule No %2', ExternalAttendanceLineCS."Student No.", ExternalAttendanceLineCS."Exam Schedule No.")
                                            END;
                                        END;
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
            UNTIL ExternalAttendanceHeaderCS.NEXT() = 0;
            ExternalAttendanceHeaderCS.Status := ExternalAttendanceHeaderCS.Status::Released;
            ExternalAttendanceHeaderCS.Modify();
        END ELSE
            ERROR('All Documents Are Released !!');
        //Code Added for Release::CSPL-00067::210219:End
    end;

    procedure ReopenCS(Scheduleno: Code[20])
    var
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
    begin
        //Code Added for Reopen::CSPL-00067::210219:Start
        ExternalAttendanceHeaderCS.Reset();
        ExternalAttendanceHeaderCS.SETRANGE("Exam Schedule No.", Scheduleno);
        ExternalAttendanceHeaderCS.MODIFYALL(Status, ExternalAttendanceHeaderCS.Status::Open);

        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", Scheduleno);
        ExternalAttendanceLineCS.MODIFYALL(Status, ExternalAttendanceLineCS.Status::Open);
        //Code Added for Reopen::CSPL-00067::210219:End
    end;

    procedure UpdateAttendancePerCS(HallTicketNo: Code[20])
    var
        AdmitCardLineCS: Record "Admit Card Line-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";

        SetupExaminationCS: Record "Setup Examination -CS";
    begin
        //Code Added for Update Attendance Per::CSPL-00067::210219:Start
        SetupExaminationCS.GET();


        AdmitCardLineCS.Reset();
        AdmitCardLineCS.SETCURRENTKEY("Document No.");
        AdmitCardLineCS.SETRANGE("Document No.", HallTicketNo);
        AdmitCardLineCS.SETRANGE(Detained, TRUE);
        IF AdmitCardLineCS.FINDSET() THEN
            REPEAT
                IF AdmitCardLineCS."Actual Per%" >= AdmitCardLineCS."Applicable Per %" THEN BEGIN
                    AdmitCardLineCS."Actual Per%" := SetupExaminationCS."Min. External Exam Attd. Per.";
                    AdmitCardLineCS.Detained := FALSE;
                    AdmitCardLineCS.Modify();

                    ExternalAttendanceLineCS.Reset();
                    ExternalAttendanceLineCS.SETCURRENTKEY("Hall Ticket No.", "Student No.", "Subject Code");
                    ExternalAttendanceLineCS.SETRANGE("Hall Ticket No.", AdmitCardLineCS."Document No.");
                    ExternalAttendanceLineCS.SETRANGE("Student No.", AdmitCardLineCS."Student No.");
                    ExternalAttendanceLineCS.SETRANGE("Subject Code", AdmitCardLineCS."Subject Code");
                    IF ExternalAttendanceLineCS.FINDFIRST() THEN BEGIN
                        ExternalAttendanceLineCS.VALIDATE("Applicable Att Per%", AdmitCardLineCS."Applicable Per %");
                        ExternalAttendanceLineCS."Attendance %" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        ExternalAttendanceLineCS.Detained := AdmitCardLineCS.Detained;
                        ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present;
                        ExternalAttendanceLineCS.Modify();
                    END;

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE("Academic Year", AdmitCardLineCS."Academic Year");
                    MainStudentSubjectCS.SETRANGE(Course, AdmitCardLineCS.Course);
                    MainStudentSubjectCS.SETRANGE(Section, AdmitCardLineCS.Section);
                    MainStudentSubjectCS.SETRANGE("Subject Code", AdmitCardLineCS."Subject Code");
                    MainStudentSubjectCS.SETRANGE("Student No.", AdmitCardLineCS."Student No.");
                    IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                        MainStudentSubjectCS."Applicable Attendance per" := AdmitCardLineCS."Applicable Per %";
                        MainStudentSubjectCS."Attendance Percentage" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        MainStudentSubjectCS.Detained := AdmitCardLineCS.Detained;
                        MainStudentSubjectCS.Modify();
                    END;

                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SETRANGE("Academic Year", AdmitCardLineCS."Academic Year");
                    OptionalStudentSubjectCS.SETRANGE(Course, AdmitCardLineCS.Course);
                    OptionalStudentSubjectCS.SETRANGE(Section, AdmitCardLineCS.Section);
                    OptionalStudentSubjectCS.SETRANGE("Subject Code", AdmitCardLineCS."Subject Code");
                    OptionalStudentSubjectCS.SETRANGE("Student No.", AdmitCardLineCS."Student No.");
                    IF OptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                        OptionalStudentSubjectCS."Applicable Attendance per" := AdmitCardLineCS."Applicable Per %";
                        OptionalStudentSubjectCS."Attendance Percentage" := SetupExaminationCS."Min. External Exam Attd. Per.";
                        OptionalStudentSubjectCS.Detained := AdmitCardLineCS.Detained;
                        OptionalStudentSubjectCS.Modify();
                    END;
                END;
            UNTIL AdmitCardLineCS.NEXT() = 0;

        MESSAGE('Updated Successfully');

        //Code Added for Update Attendance Per::CSPL-00067::210219:End
    end;

    procedure WinterExamScheduleCS(No: Code[20]; InstituteCode: Code[20]; AcademicYear: Code[20]; SubClassFication: Code[20])
    var
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        ExamTimeTableLineCS1: Record "Exam Time Table Line-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        CourseMasterCS: Record "Course Master-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExamTimeTableLineCS2: Record "Exam Time Table Line-CS";
        Lineno: Integer;

    begin
        //Code Added for Winter Exam Schedule::CSPL-00067::210219:Start
        RegistrationStudentCS.Reset();
        RegistrationStudentCS.SETCURRENTKEY(Semester, "Subject Code");
        RegistrationStudentCS.SETRANGE("Academic Year", AcademicYear);
        RegistrationStudentCS.SETRANGE(Session, 'WINTER');
        RegistrationStudentCS.SETRANGE("Subject Class", SubClassFication);
        RegistrationStudentCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF RegistrationStudentCS.FINDSET() THEN
            REPEAT
                IF RegistrationStudentCS."Subject Type" = 'CORE' THEN BEGIN
                    ExamTimeTableLineCS2.Reset();
                    ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                    ExamTimeTableLineCS2.SETRANGE("Semester Code", RegistrationStudentCS.Semester);
                    ExamTimeTableLineCS2.SETRANGE("Subject Code", RegistrationStudentCS."Subject Code");
                    IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                        ExamTimeTableLineCS1.Reset();
                        ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                        IF ExamTimeTableLineCS1.FINDLAST() THEN
                            Lineno := ExamTimeTableLineCS1."Line No." + 10000
                        ELSE
                            Lineno := 10000;


                        ExamTimeTableLineCS.INIT();
                        ExamTimeTableLineCS."Document No." := No;
                        ExamTimeTableLineCS."Line No." := Lineno;
                        ExamTimeTableLineCS."Subject Class" := RegistrationStudentCS."Subject Class";
                        ExamTimeTableLineCS."Subject Type" := RegistrationStudentCS."Subject Type";
                        ExamTimeTableLineCS.VALIDATE("Subject Code", RegistrationStudentCS."Subject Code");
                        ExamTimeTableLineCS."Semester Code" := RegistrationStudentCS.Semester;                            //SubjectWise
                        ExamTimeTableLineCS.Year := RegistrationStudentCS.Year;                                          //SubjectWise

                        CourseMasterCS.Reset();
                        CourseMasterCS.SETRANGE(Code, RegistrationStudentCS."Course Code");
                        IF CourseMasterCS.FINDFIRST() THEN
                            ExamTimeTableLineCS."Program" := CourseMasterCS.Graduation;                                        //SubjectWise
                        ExamTimeTableLineCS."Academic Year" := AcademicYear;
                        ExamTimeTableLineCS."Global Dimension 1 Code" := InstituteCode;
                        ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(RegistrationStudentCS."Subject Code", 1, 3);
                        ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                        ExamTimeTableLineCS."Created On" := TODAY();
                        ExamTimeTableLineCS.INSERT(TRUE);
                        IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                            ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                            ExamTimeTableHeadCS."Created On" := TODAY();
                            ExamTimeTableHeadCS.MODIFY()
                        END;
                    END;
                END ELSE
                    IF RegistrationStudentCS."Subject Type" <> 'CORE' THEN BEGIN
                        ExamTimeTableLineCS2.Reset();
                        ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                        ExamTimeTableLineCS2.SETRANGE("Subject Code", RegistrationStudentCS."Subject Code");
                        IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                            ExamTimeTableLineCS1.Reset();
                            ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                            IF ExamTimeTableLineCS1.FINDLAST() THEN
                                Lineno := ExamTimeTableLineCS1."Line No." + 10000
                            ELSE
                                Lineno := 10000;

                            ExamTimeTableLineCS.INIT();
                            ExamTimeTableLineCS."Document No." := No;
                            ExamTimeTableLineCS."Line No." := Lineno;
                            ExamTimeTableLineCS."Subject Class" := RegistrationStudentCS."Subject Class";
                            ExamTimeTableLineCS."Subject Type" := RegistrationStudentCS."Subject Type";
                            ExamTimeTableLineCS.VALIDATE("Subject Code", RegistrationStudentCS."Subject Code");
                            CourseMasterCS.Reset();
                            CourseMasterCS.SETRANGE(Code, RegistrationStudentCS."Course Code");
                            IF CourseMasterCS.FINDFIRST() THEN
                                ExamTimeTableLineCS."Program" := CourseMasterCS.Graduation;                                        //SubjectWise
                            ExamTimeTableLineCS."Semester Code" := RegistrationStudentCS.Semester;                                //SubjectWise
                            ExamTimeTableLineCS.Year := RegistrationStudentCS.Year;                                               //SubjectWise
                            ExamTimeTableLineCS."Academic Year" := AcademicYear;
                            ExamTimeTableLineCS."Global Dimension 1 Code" := InstituteCode;
                            ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(RegistrationStudentCS."Subject Code", 1, 3);
                            ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                            ExamTimeTableLineCS."Created On" := TODAY();
                            ExamTimeTableLineCS.INSERT(TRUE);
                            IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                                ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                                ExamTimeTableHeadCS."Created On" := TODAY();
                                ExamTimeTableHeadCS.MODIFY()
                            END;
                        END;
                    END;
            UNTIL RegistrationStudentCS.NEXT() = 0;

        //Code Added for Winter Exam Schedule::CSPL-00067::210219:End
    end;

    procedure SummerExamScheduleCS(No: Code[20]; InstituteCode: Code[20]; SubClassFication: Code[20]; AcademicYear: Code[20])
    var
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        ExamTimeTableLineCS1: Record "Exam Time Table Line-CS";
        RegistrationStudentCS: Record "Registration Student-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExamTimeTableLineCS2: Record "Exam Time Table Line-CS";
        CourseMasterCS: Record "Course Master-CS";
        Lineno: Integer;
    begin
        //Code Added for Summer Exam Schedule::CSPL-00067::210219:Start
        RegistrationStudentCS.Reset();
        RegistrationStudentCS.SETCURRENTKEY(Semester, "Subject Code");
        RegistrationStudentCS.SETRANGE("Academic Year", AcademicYear);
        RegistrationStudentCS.SETRANGE(Session, 'SUMMER');
        RegistrationStudentCS.SETRANGE("Subject Class", SubClassFication);
        RegistrationStudentCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF RegistrationStudentCS.FINDSET() THEN
            REPEAT
                IF RegistrationStudentCS."Subject Type" = 'CORE' THEN BEGIN
                    ExamTimeTableLineCS2.Reset();
                    ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                    ExamTimeTableLineCS2.SETRANGE("Semester Code", RegistrationStudentCS.Semester);
                    ExamTimeTableLineCS2.SETRANGE("Subject Code", RegistrationStudentCS."Subject Code");
                    IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                        ExamTimeTableLineCS1.Reset();
                        ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                        IF ExamTimeTableLineCS1.FINDLAST() THEN
                            Lineno := ExamTimeTableLineCS1."Line No." + 10000
                        ELSE
                            Lineno := 10000;


                        ExamTimeTableLineCS.INIT();
                        ExamTimeTableLineCS."Document No." := No;
                        ExamTimeTableLineCS."Line No." := Lineno;
                        ExamTimeTableLineCS."Subject Class" := RegistrationStudentCS."Subject Class";
                        ExamTimeTableLineCS."Subject Type" := RegistrationStudentCS."Subject Type";
                        ExamTimeTableLineCS.VALIDATE("Subject Code", RegistrationStudentCS."Subject Code");
                        ExamTimeTableLineCS."Semester Code" := RegistrationStudentCS.Semester;                            //SubjectWise
                        ExamTimeTableLineCS.Year := RegistrationStudentCS.Year;                                          //SubjectWise

                        CourseMasterCS.Reset();
                        CourseMasterCS.SETRANGE(Code, RegistrationStudentCS."Course Code");
                        IF CourseMasterCS.FINDFIRST() THEN
                            ExamTimeTableLineCS."Program" := CourseMasterCS.Graduation;                                        //SubjectWise
                        ExamTimeTableLineCS."Academic Year" := AcademicYear;
                        ExamTimeTableLineCS."Global Dimension 1 Code" := InstituteCode;
                        ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(RegistrationStudentCS."Subject Code", 1, 3);
                        ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                        ExamTimeTableLineCS."Created On" := TODAY();
                        ExamTimeTableLineCS.INSERT(TRUE);
                        IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                            ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                            ExamTimeTableHeadCS."Created On" := TODAY();
                            ExamTimeTableHeadCS.MODIFY()
                        END;
                    END;
                END ELSE
                    IF RegistrationStudentCS."Subject Type" <> 'CORE' THEN BEGIN
                        ExamTimeTableLineCS2.Reset();
                        ExamTimeTableLineCS2.SETRANGE("Document No.", No);
                        ExamTimeTableLineCS2.SETRANGE("Subject Code", RegistrationStudentCS."Subject Code");
                        IF NOT ExamTimeTableLineCS2.FINDFIRST() THEN BEGIN
                            ExamTimeTableLineCS1.Reset();
                            ExamTimeTableLineCS1.SETRANGE("Document No.", No);
                            IF ExamTimeTableLineCS1.FINDLAST() THEN
                                Lineno := ExamTimeTableLineCS1."Line No." + 10000
                            ELSE
                                Lineno := 10000;

                            ExamTimeTableLineCS.INIT();
                            ExamTimeTableLineCS."Document No." := No;
                            ExamTimeTableLineCS."Line No." := Lineno;
                            ExamTimeTableLineCS."Subject Class" := RegistrationStudentCS."Subject Class";
                            ExamTimeTableLineCS."Subject Type" := RegistrationStudentCS."Subject Type";
                            ExamTimeTableLineCS.VALIDATE("Subject Code", RegistrationStudentCS."Subject Code");
                            CourseMasterCS.Reset();
                            CourseMasterCS.SETRANGE(Code, RegistrationStudentCS."Course Code");
                            IF CourseMasterCS.FINDFIRST() THEN
                                ExamTimeTableLineCS."Program" := CourseMasterCS.Graduation;                                        //SubjectWise
                            ExamTimeTableLineCS."Semester Code" := RegistrationStudentCS.Semester;                                //SubjectWise
                            ExamTimeTableLineCS.Year := RegistrationStudentCS.Year;                                               //SubjectWise
                            ExamTimeTableLineCS."Academic Year" := AcademicYear;
                            ExamTimeTableLineCS."Global Dimension 1 Code" := InstituteCode;
                            ExamTimeTableLineCS."Global Dimension 2 Code" := COPYSTR(RegistrationStudentCS."Subject Code", 1, 3);
                            ExamTimeTableLineCS."Created By" := FORMAT(UserId());
                            ExamTimeTableLineCS."Created On" := TODAY();
                            ExamTimeTableLineCS.INSERT(TRUE);
                            IF ExamTimeTableHeadCS.GET(No) THEN BEGIN
                                ExamTimeTableHeadCS."Created By" := FORMAT(UserId());
                                ExamTimeTableHeadCS."Created On" := TODAY();
                                ExamTimeTableHeadCS.MODIFY()
                            END;
                        END;
                    END;
            UNTIL RegistrationStudentCS.NEXT() = 0;
        //Code Added for Summer Exam Schedule::CSPL-00067::210219:End
    end;
}

