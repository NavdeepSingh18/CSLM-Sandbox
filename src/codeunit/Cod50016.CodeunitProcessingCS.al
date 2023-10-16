codeunit 50016 "Codeunit Processing-CS"
{
    // version V.001-CS

    // Sr. No.  Emp Id    Date    Trigger                              Remark
    // 1        CSPL-0006721-02-19CreationCourseSemester              Code Added forCreation Course Semester
    // 2        CSPL-0006721-02-19StudentCreditUpdate                  Code Added forStudent Credit Update
    // 3        CSPL-0006721-02-19StudentSubjectRollNo&SectionUpdate  Code Added forStudent Subject Roll No & Section Update
    // 4        CSPL-0006721-02-19CourseSubjectLineBatchUpdate         Code Added forCourse Subject Line Batch Update
    // 5        CSPL-0006721-02-19CheckEmployeeExist                   Code Added forCheck Employee Exist
    // 6        CSPL-0006721-02-19RollNoUpdate                         Code Added forRoll No Update
    // 7        CSPL-0006721-02-19ExternalExamMarksAndAttendanceUpdate   Code Added forExternal Exam Marks And Attendance Update
    // 8        CSPL-0006721-02-19UpdateTypeofCourse                   Code Added forUpdate Type of Course
    // 9        CSPL-0006721-02-19UpdateStudentInfo                     Code Added forUpdate Student Info
    // 10      CSPL-0006721-02-19UpdateNarrasion                       Code Added forUpdate Narrasion
    // 11      CSPL-0006721-02-19UpdateStudentAcademicYear             Code Added forUpdate Student Academic Year
    // 12      CSPL-0006721-02-19UpdateExamScheduleNo                 Code Added forUpdate Exam Schedule No
    // 13      CSPL-0006721-02-19UpdateStudentRollNo                   Code Added forUpdate Student Roll No
    // 14      CSPL-0006721-02-19UpdateShortcutDimension3             Code Added forUpdate Shortcut Dimension3
    // 15      CSPL-0006721-02-19HandleExecutionError                 Code Added forHandle Execution Error
    // 16      CSPL-0006721-02-19GLEntrySyncronizationCheck/Uncheck   Code Added forGLEntry Syncronization Check/Uncheck
    // 17      CSPL-0006721-02-19UpdateAmountRecipt                   Code Added forUpdate Amount Recipt
    // 18      CSPL-0006721-02-19UnsyncGLentris                       Code Added forUnsync GLentris
    // 19      CSPL-0006721-02-19UpdateEnrollmentNumberGLEntry         Code Added forUpdate Enrollment Number GLEntry


    trigger OnRun()
    begin
    end;

    procedure CreationCourseSemesterCS()
    var
        CourseMasterCS: Record "Course Master-CS";
        SemesterMasterCS: Record "Semester Master-CS";
        CourseSemMasterCS: Record "Course Sem. Master-CS";
        CourseSemMasterCS1: Record "Course Sem. Master-CS";
    begin
        //Code Added for Creation Course Semester::CSPL-00067::210219:Start
        CourseMasterCS.Reset();
        CourseMasterCS.SETRANGE(Graduation, 'PG');
        IF CourseMasterCS.FINDSET() THEN
            REPEAT
                CourseSemMasterCS1.Reset();
                CourseSemMasterCS1.SETRANGE("Course Code", CourseMasterCS.Code);
                CourseSemMasterCS1.SETRANGE("Academic Year", '2017-2018');
                IF CourseSemMasterCS1.FINDSET() THEN
                    CourseSemMasterCS1.DELETEALL();

                SemesterMasterCS.Reset();
                SemesterMasterCS.SETRANGE(Graduation, CourseMasterCS.Graduation);
                IF SemesterMasterCS.FINDSET() THEN
                    REPEAT
                        CourseSemMasterCS.INIT();
                        CourseSemMasterCS."Course Code" := CourseMasterCS.Code;
                        CourseSemMasterCS."Semester Code" := SemesterMasterCS.Code;
                        CourseSemMasterCS."Academic Year" := '2017-2018';
                        CourseSemMasterCS."Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                        CourseSemMasterCS."Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                        CourseSemMasterCS."Type Of Course" := CourseSemMasterCS."Type Of Course"::Year;
                        CourseSemMasterCS."Sequence No" := SemesterMasterCS.Sequence;
                        CourseSemMasterCS."User ID" := FORMAT(UserId());
                        CourseSemMasterCS.Insert();
                    UNTIL SemesterMasterCS.Next() = 0;
            UNTIL CourseMasterCS.Next() = 0;

        MESSAGE('Done');
        //Code Added for Creation Course Semester::CSPL-00067::210219:END
    end;

    procedure StudentCreditUpdateCS()
    var
        StudentMasterCS: Record "Student Master-CS";
        PromotionLineCS: Record "Promotion Line-CS";
        CreditEarn: Decimal;
    begin
        //Code Added for Student Credit Update::CSPL-00067::210219:Start
        PromotionLineCS.Reset();
        IF PromotionLineCS.FINDSET() THEN
            REPEAT
                StudentMasterCS.GET(PromotionLineCS."Student No.");
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
                PromotionLineCS.Credit := CreditEarn;
                PromotionLineCS.MODIFY();
            UNTIL PromotionLineCS.NEXT() = 0;
        MESSAGE('Done');
        //Code Added for Student Credit Update::CSPL-00067::210219:End
    end;

    procedure "StudentSubjectRollNo&SectionUpdateCS"()
    var
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";

    begin
        //Code Added for Student Subject Roll No & Section Update::CSPL-00067::210219:Start
        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE("Academic Year", '2017-2018');
        StudentMasterCS.SETFILTER(Semester, '%1', 'II');
        StudentMasterCS.SETRANGE(Graduation, 'UG');
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Semester, 'I');
                MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                MainStudentSubjectCS.SETRANGE("Academic Year", '2017-2018');
                MainStudentSubjectCS.SETRANGE("Subject Type", 'CORE');
                MainStudentSubjectCS.SETFILTER("Roll No.", '<>%1', '');
                IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                    MainStudentSubjectCS1.Reset();
                    MainStudentSubjectCS1.SETRANGE(MainStudentSubjectCS1.Semester, 'II');
                    MainStudentSubjectCS1.SETRANGE("Student No.", StudentMasterCS."No.");
                    MainStudentSubjectCS1.SETRANGE("Academic Year", '2017-2018');
                    MainStudentSubjectCS1.SETRANGE("Subject Type", 'CORE');
                    IF MainStudentSubjectCS1.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS1.RENAME(MainStudentSubjectCS1."Student No.", MainStudentSubjectCS1.Course, MainStudentSubjectCS1.Semester,
                                                  MainStudentSubjectCS1."Academic Year", MainStudentSubjectCS1."Subject Code", MainStudentSubjectCS.Section);
                            MainStudentSubjectCS1."Roll No." := MainStudentSubjectCS."Roll No.";
                            MainStudentSubjectCS1.MODIFY();
                        UNTIL MainStudentSubjectCS1.NEXT() = 0;
                END;
            UNTIL StudentMasterCS.NEXT() = 0;

        MESSAGE('Done');
        //Code Added for Student Subject Roll No & Section Update::CSPL-00067::210219:End
    end;

    procedure CourseSubjectLineBatchUpdateCS()
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING... #1  Out Of  @2 .';
    begin
        //Code Added for Course Subject Line Batch Update::CSPL-00067::210219:Start
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", '2017-2018');
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
        CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", '09');
        IF CourseWiseSubjectLineCS.FINDSET() THEN BEGIN
            TotalCount := CourseWiseSubjectLineCS.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, CourseWiseSubjectLineCS."Subject Code");
                //SubjectMasterCS.SETRANGE(Course,CourseWiseSubjectLineCS."Course Code");
                IF SubjectMasterCS.FINDFIRST() THEN BEGIN
                    CourseWiseSubjectLineCS."Applicable Batch" := SubjectMasterCS."Applicable Batch";
                    CourseWiseSubjectLineCS."Number of Lab Component" := SubjectMasterCS."Number of Lab Component";
                    CourseWiseSubjectLineCS.MODIFY();
                END;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
            PROGRESS.CLOSE();
        END;
        MESSAGE('Done');
        //Code Added for Course Subject Line Batch Update::CSPL-00067::210219:End
    end;

    procedure CheckEmployeeExistCS()
    var
        MainOptionalSubArchiveCS: Record "Main&Optional Sub Archive-CS";
        Employee: Record "Employee";
    begin
        //Code Added for Check Employee Exist::CSPL-00067::210219:Start
        MainOptionalSubArchiveCS.Reset();
        IF MainOptionalSubArchiveCS.FINDSET() THEN
            REPEAT
                Employee.Reset();
                Employee.SETRANGE("No.", MainOptionalSubArchiveCS."Student No.");
                IF Employee.FINDFIRST() THEN
                    MainOptionalSubArchiveCS.DELETE();
            UNTIL MainOptionalSubArchiveCS.NEXT() = 0;
        MESSAGE('Done');
        //Code Added for Check Employee Exist::CSPL-00067::210219:End
    end;

    procedure RollNoUpdateCS()
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
    begin
        //Code Added for Roll No Update::CSPL-00067::210219:Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", '2017-2018');
        MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        IF MainStudentSubjectCS.FINDSET() THEN
            REPEAT
                MainStudentSubjectCS.VALIDATE("Roll No.");
            UNTIL MainStudentSubjectCS.NEXT() = 0;
        MESSAGE('Done');
        //Code Added for Roll No Update::CSPL-00067::210219:End
    end;

    procedure ExternalExamMarksAndAttendanceUpdateCS()
    var
        ExternalExamLineCS: Record "External Exam Line-CS";

        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    begin
        //Code Added for External Exam Marks And Attendance Update::CSPL-00067::210219:Start
        ExternalExamLineCS.Reset();
        ExternalExamLineCS.SETRANGE("Exam Classification", 'SPECIAL');
        IF ExternalExamLineCS.FINDSET() THEN
            REPEAT
                IF ExternalExamLineCS."Subject Type" = 'CORE' THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
                    MainStudentSubjectCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
                    IF MainStudentSubjectCS.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS.VALIDATE("Internal Mark", (MainStudentSubjectCS."Internal Mark" + MainStudentSubjectCS."Assignment Marks"));
                        ExternalExamLineCS.VALIDATE("Attendance %", MainStudentSubjectCS."Attendance Percentage");
                        ExternalExamLineCS.MODIFY();
                    END;
                END ELSE BEGIN
                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
                    OptionalStudentSubjectCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
                    IF OptionalStudentSubjectCS.FINDFIRST() THEN BEGIN
                        ExternalExamLineCS.VALIDATE("Internal Mark", (OptionalStudentSubjectCS."Internal Obtained" + OptionalStudentSubjectCS."Assignment Marks"));
                        ExternalExamLineCS.VALIDATE("Attendance %", OptionalStudentSubjectCS."Attendance Percentage");
                        ExternalExamLineCS.MODIFY();
                    END;
                END;
            UNTIL ExternalExamLineCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for External Exam Marks And Attendance Update::CSPL-00067::210219:End
    end;

    procedure UpdateTypeofCourseCS()
    var
        MakeUpExaminationCS: Record "MakeUp Examination-CS";
        CourseMasterCS: Record "Course Master-CS";
    begin
        //Code Added for Update Type of Course::CSPL-00067::210219:Start
        MakeUpExaminationCS.Reset();
        MakeUpExaminationCS.SETRANGE("Exam Classification", 'SPECIAL');
        MakeUpExaminationCS.SETRANGE("Global Dimension 1 Code", '09');
        IF MakeUpExaminationCS.FINDSET() THEN
            REPEAT
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(Code, MakeUpExaminationCS."Course Code");
                IF CourseMasterCS.FINDFIRST() THEN BEGIN
                    MakeUpExaminationCS."Type Of Course" := CourseMasterCS."Type Of Course";
                    MakeUpExaminationCS.Modify();
                END;
            UNTIL MakeUpExaminationCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Type of Course::CSPL-00067::210219:End
    end;

    procedure UpdateStudentInfoCS()
    var
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        IntRollNo: Integer;
    begin
        //Code Added for Update Student Info::CSPL-00067::210219:Start
        ExternalAttendanceLineCS.Reset();
        ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", 'EXSH/00006');
        IF ExternalAttendanceLineCS.FINDSET() THEN
            REPEAT
                IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN BEGIN
                    ExternalAttendanceLineCS."Student Name" := StudentMasterCS."Name as on Certificate";
                    IF StudentMasterCS."Roll No." <> '' THEN BEGIN
                        EVALUATE(IntRollNo, StudentMasterCS."Roll No.");
                        ExternalAttendanceLineCS."Roll No." := IntRollNo;
                    END;
                END ELSE
                    ExternalAttendanceLineCS."Student Name" := '';
                ExternalAttendanceLineCS."Roll No." := 0;
            UNTIL ExternalAttendanceLineCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Student Info::CSPL-00067::200219:End
    end;

    procedure UpdateNarrasionCS()
    var
        GLEntry: Record "G/L Entry";
        Student: Record "Student Master-CS";
    begin
        //Code Added for Update Student Info::CSPL-00067::210219:Start
        GLEntry.Reset();
        GLEntry.SETRANGE(Narration, '');
        IF GLEntry.FINDSET() THEN
            REPEAT
                Student.Reset();
                Student.SETRANGE("Enrollment No.", GLEntry."Enrollment No.");
                IF Student.FINDFIRST() THEN
                    GLEntry.Narration := FORMAT(GLEntry."Enrollment No.") + '' + FORMAT(Student."First Name");
                GLEntry.Modify();
            UNTIL GLEntry.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Student Info::CSPL-00067::210219:End
    end;

    procedure UpdateStudentAcademicYearCS()
    var
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
    begin
        //Code Added for Update Student Academic Year::CSPL-00067::210219:End
        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE("Degree Code", 'M.Tech.'); //- Field type change
        StudentMasterCS.SETRANGE("Academic Year", '2017-2018');
        StudentMasterCS.SETRANGE("Student Status", StudentMasterCS."Student Status"::Student);
        StudentMasterCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VII');
        IF StudentMasterCS.FINDSET() THEN
            REPEAT
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                MainStudentSubjectCS.SETRANGE(Semester, StudentMasterCS.Semester);
                IF MainStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester,
                                              StudentMasterCS."Academic Year", MainStudentSubjectCS."Subject Code", MainStudentSubjectCS.Section);
                    UNTIL MainStudentSubjectCS.Next() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE("Student No.", StudentMasterCS."No.");
                OptionalStudentSubjectCS.SETRANGE(Semester, StudentMasterCS.Semester);
                IF OptionalStudentSubjectCS.FINDSET() THEN
                    REPEAT
                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester,
                                                      StudentMasterCS."Academic Year", OptionalStudentSubjectCS."Subject Code", OptionalStudentSubjectCS.Section);
                    UNTIL OptionalStudentSubjectCS.Next() = 0;
            UNTIL StudentMasterCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Student Academic Year::CSPL-00067::210219:End
    end;

    procedure UpdateExamScheduleNoCS()
    var
        ExternalExamHeaderCS: Record "External Exam Header-CS";
        ExternalExamLineCS: Record "External Exam Line-CS";
    begin
        //Code Added for Update Exam Schedule No::CSPL-00067::210219:Start
        ExternalExamHeaderCS.Reset();
        ExternalExamHeaderCS.SETRANGE("Exam Schedule Code", 'EXSH/00005');
        IF ExternalExamHeaderCS.FINDSET() THEN
            REPEAT
                ExternalExamLineCS.Reset();
                ExternalExamLineCS.SETRANGE("Document No.", ExternalExamHeaderCS."No.");
                IF ExternalExamLineCS.FINDSET() THEN
                    REPEAT
                        ExternalExamLineCS."Exam Schedule No." := ExternalExamHeaderCS."Exam Schedule Code";
                        ExternalExamLineCS.Modify();
                    UNTIL ExternalExamLineCS.Next() = 0;
            UNTIL ExternalExamHeaderCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Exam Schedule No::CSPL-00067::210219:End
    end;

    procedure UpdateStudentRollNoCS()
    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
    begin
        //Code Added for Update Student Roll No::CSPL-00067::210219:Start
        MainStudentSubjectCS.Reset();
        MainStudentSubjectCS.SETRANGE("Academic Year", '2017-2018');
        MainStudentSubjectCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
        IF MainStudentSubjectCS.FINDSET() THEN
            REPEAT
                MainStudentSubjectCS.VALIDATE("Roll No.");
                MainStudentSubjectCS.Modify();
            UNTIL MainStudentSubjectCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Student Roll No::CSPL-00067::210219:End
    end;

    procedure UpdateShortcutDimension3CS()
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GLEntry: Record "G/L Entry";
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        //Code Added for Update Shortcut Dimension3::CSPL-00067::210219:Start
        SalesCrMemoLine.Reset();
        SalesCrMemoLine.SETFILTER("Sell-to Customer No.", '<>%1', '');
        IF SalesCrMemoLine.FINDSET() THEN
            REPEAT
                DimensionSetEntry.Reset();
                DimensionSetEntry.SETRANGE("Dimension Set ID", SalesCrMemoLine."Dimension Set ID");
                DimensionSetEntry.SETRANGE("Dimension Code", 'OPER. UNIT');
                IF DimensionSetEntry.FINDFIRST() THEN BEGIN
                    GLEntry.Reset();
                    GLEntry.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
                    GLEntry.SETRANGE("G/L Account No.", SalesCrMemoLine."No.");
                    IF GLEntry.FINDFIRST() THEN BEGIN
                        GLEntry."ShortCut Dimension Code 3" := DimensionSetEntry."Dimension Value Code";
                        GLEntry.Modify();
                    END;
                END;
            UNTIL SalesCrMemoLine.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Shortcut Dimension3::CSPL-00067::210219:End
    end;

    // procedure HandleExecutionErrorCS()
    // var
    //     // JobQueueSendNotification: Codeunit "Job Queue - Send Notification";

    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Receipient: List of [Text];

    // begin
    //     //Code Added for Handle Execution Error::CSPL-00067::210219:Start
    //     SenderName := 'ManipalUniversity';
    //     SenderAddress := 'vineet.saroha@corporateserve.com';
    //     Subject := 'Service is Stop';
    //     Receipient.Add('');
    //     SmtpMail.Create(Receipient, Subject, '', false);

    //     SmtpMail.AppendtoBody('Dear Sir/Mam,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Job Queue is Stop Please Check and Start this Job Queue.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Navision Team,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Manipal');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');

    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //SMTPmail.send();
    //     MESSAGE('Done');
    //     //Code Added for Handle Execution Error::CSPL-00067::210219:End
    // end;

    procedure "GLEntrySyncronizationCheck/UncheckCS"()
    var
        GLEntry: Record "G/L Entry";
    begin
        //Code Added for GLEntry Syncronization Check/Uncheck::CSPL-00067::210219:Start
        GLEntry.Reset();
        GLEntry.FINDSET();
        GLEntry.MODIFYALL("Synchronised with SFAS", FALSE);
        GLEntry.MODIFYALL("Actual Synch to SFAS", FALSE);
        MESSAGE('Done');
        //Code Added for GLEntry Syncronization Check/Uncheck::CSPL-00067::210219:End
    end;

    procedure UpdateAmountReciptCS()
    var
        GLEntry: Record "G/L Entry";
    begin
        //Code Added for Update Amount Recipt::CSPL-00067::210219:Start
        GLEntry.Reset();
        IF GLEntry.FINDSET() THEN
            REPEAT
                IF GLEntry."Currency Code" <> '' THEN
                    GLEntry."Amount Receipt" := GLEntry.Amount / (1 / GLEntry."Currency Factor")
                ELSE
                    GLEntry."Amount Receipt" := GLEntry.Amount;
                GLEntry.Modify();
            UNTIL GLEntry.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Amount Recipt::CSPL-00067::210219:End
    end;

    procedure UnsyncGLentrisCS()
    var
        GLEntry: Record "G/L Entry";
        NotSyncDocumentCS: Record "Not Sync Document-CS";
    begin
        //Code Added for Unsync GLentris::CSPL-00067::210219:Start
        NotSyncDocumentCS.Reset();
        IF NotSyncDocumentCS.FINDSET() THEN
            REPEAT
                GLEntry.Reset();
                GLEntry.SETRANGE("Document No.", NotSyncDocumentCS."Document No");
                IF GLEntry.FINDSET() THEN
                    REPEAT
                        GLEntry."Synchronised with SFAS" := FALSE;
                        GLEntry.Modify();
                    UNTIL GLEntry.Next() = 0;
            UNTIL NotSyncDocumentCS.Next() = 0;
        MESSAGE('Done');
        //Code Added for Unsync GLentris::CSPL-00067::210219:End
    end;

    procedure UpdateEnrollmentNumberGLEntryCS()
    var
        GLEntry: Record "G/L Entry";
        GLEntryRec: Record "G/L Entry";
    begin
        //Code Added for Update Enrollment Number GLEntry::CSPL-00067::210219:Start
        GLEntry.Reset();
        GLEntry.SETFILTER("Enrollment No.", '<>%1', '');
        IF GLEntry.FINDSET() THEN
            REPEAT
                GLEntryRec.Reset();
                GLEntryRec.SETRANGE("Document No.", GLEntry."Document No.");
                GLEntryRec.SETRANGE("Enrollment No.", '');
                IF GLEntryRec.FINDSET() THEN
                    REPEAT
                        GLEntryRec."Enrollment No." := GLEntry."Enrollment No.";
                        GLEntryRec.Modify();
                    UNTIL GLEntryRec.Next() = 0;
            UNTIL GLEntry.Next() = 0;
        MESSAGE('Done');
        //Code Added for Update Enrollment Number GLEntry::CSPL-00067::210219:End
    end;


}

