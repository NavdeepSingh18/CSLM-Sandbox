report 50073 "Provisional Transcript"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Provisional Transcript.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Enrollment No.", Semester;
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(No_StudentMasterCS; "No.")
            {
            }
            column(NameasonCertificate_StudentMasterCS; "Name as on Certificate")
            {
            }
            column(EnrollmentNo_StudentMasterCS; "Enrollment No.")
            {
            }
            column(CourseName_StudentMasterCS; "Course Name")
            {
            }
            column(DateofJoining_StudentMasterCS; "Date of Joining")
            {
            }
            column(DateofLeaving_StudentMasterCS; "Date of Leaving")
            {
            }
            column(LatestGPA_StudentMasterCS; "Latest GPA")
            {
            }
            column(Graduation_StudentMasterCS; Graduation)
            {
            }
            column(TypeOfCourse_StudentMasterCS; "Type Of Course")
            {
            }
            column(Semester_StudentMasterCS; Semester)
            {
            }
            column(Year_StudentMasterCS; Year)
            {
            }
            column(SemesterIGPA_StudentMasterCS; "Semester I GPA")
            {
            }
            column(SemesterIIGPA_StudentMasterCS; "Semester II GPA")
            {
            }
            column(SemesterIIIGPA_StudentMasterCS; "Semester III GPA")
            {
            }
            column(SemesterIVGPA_StudentMasterCS; "Semester IV GPA")
            {
            }
            column(SemesterVGPA_StudentMasterCS; "Semester V GPA")
            {
            }
            column(SemesterVIGPA_StudentMasterCS; "Semester VI GPA")
            {
            }
            column(SemesterVIIGPA_StudentMasterCS; "Semester VII GPA")
            {
            }
            column(SemesterVIIIGPA_StudentMasterCS; "Semester VIII GPA")
            {
            }
            column(NetSemesterCGPA_StudentMasterCS; "Net Semester CGPA")
            {
            }
            column(SemesterICreditEarned_StudentMasterCS; "Semester I Credit Earned")
            {
            }
            column(SemesterIICreditEarned_StudentMasterCS; "Semester II Credit Earned")
            {
            }
            column(SemesterIIICreditEarned_StudentMasterCS; "Semester III Credit Earned")
            {
            }
            column(SemesterIVCreditEarned_StudentMasterCS; "Semester IV Credit Earned")
            {
            }
            column(SemesterVCreditEarned_StudentMasterCS; "Semester V Credit Earned")
            {
            }
            column(SemesterVICreditEarned_StudentMasterCS; "Semester VI Credit Earned")
            {
            }
            column(SemesterVIICreditEarned_StudentMasterCS; "Semester VII Credit Earned")
            {
            }
            column(SemesterVIIICreditEarned_StudentMasterCS; "Semester VIII Credit Earned")
            {
            }
            column(Year1; Year1)
            {
            }
            column(Year2; Year2)
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(Semest1; Semester1)
            {
            }
            column(Semest2; Semester2)
            {
            }
            column(Semest3; Semester3)
            {
            }
            column(Semest4; Semester4)
            {
            }
            column(Semest5; Semester5)
            {
            }
            column(Semest6; Semester6)
            {
            }
            column(Semest7; Semester7)
            {
            }
            column(Semest8; Semester8)
            {
            }
            dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('I'));
                PrintOnlyIfDetail = false;
                column(TypeOfCourse_MainStudentSubjectCS; "Type Of Course")
                {
                }
                column(AcademicYear_MainStudentSubjectCS; "Academic Year")
                {
                }
                column(StudentName_MainStudentSubjectCS; "Student Name")
                {
                }
                column(EnrollmentNo_MainStudentSubjectCS; "Enrollment No")
                {
                }
                column(StudentNo_MainStudentSubjectCS; "Student No.")
                {
                }
                column(SubjectCode_MainStudentSubjectCS; "Subject Code")
                {
                }
                column(SubjectType_MainStudentSubjectCS; "Subject Type")
                {
                }
                column(Description_MainStudentSubjectCS; Description)
                {
                }
                column(Grade_MainStudentSubjectCS; Grade)
                {
                }
                column(Credit_MainStudentSubjectCS; Credit)
                {
                }
                column(SubjectPassDate_MainStudentSubjectCS; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS; "Actual Subject Description")
                {
                }
                column(EvenOdd1; EvenOdd1)
                {
                }
                column(AdYear1; AdYear1)
                {
                }
                column(Attend1; Attend1)
                {
                }
                column(Count1; Count1)
                {
                }
                column(Desc1; Desc1)
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS; "Attendance Percentage")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc1 := '';
                    EvenOdd1 := '';
                    AdYear1 := '';
                    Newstring1 := '';

                    IF ("Main Student Subject-CS"."Actual Semester" = 'II') OR ("Main Student Subject-CS"."Actual Semester" = 'IV') OR ("Main Student Subject-CS"."Actual Semester" = 'VI') OR
                      ("Main Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd1 := 'JAN-MAY';
                        Newstring1 := "Main Student Subject-CS"."Academic Year";
                        AdYear1 := COPYSTR(Newstring1, 6, 9);
                    END ELSE BEGIN
                        EvenOdd1 := 'JUL-NOV';
                        Newstring1 := "Main Student Subject-CS"."Academic Year";
                        AdYear1 := COPYSTR(Newstring1, 1, 4);
                    END;


                    Attend1 += "Main Student Subject-CS"."Attendance Percentage";
                    IF SubjectCode1 <> "Main Student Subject-CS"."Actual Subject Code" THEN
                        Count1 += 1;

                    SubjectCode1 := "Main Student Subject-CS"."Actual Subject Code";
                end;

                trigger OnPreDataItem()
                begin
                    Attend1 := 0;
                    Count1 := 0;
                    SubjectCode1 := '';
                end;
            }
            dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('I')
                                    , "Program/Open Elective Temp" = FILTER(' '));
                PrintOnlyIfDetail = false;
                UseTemporary = false;
                column(StudentNo_OptionalStudentSubjectCS; "Student No.")
                {
                }
                column(SubjectCode; "Subject Code")
                {
                }
                column(SubjectType_OptionalStudentSubjectCS; "Subject Type")
                {
                }
                column(Description_OptionalStudentSubjectCS; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS; Credit)
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS; "Attendance Percentage")
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS; "Actual Subject Description")
                {
                }
                column(EEvenOdd1; EEvenOdd1)
                {
                }
                column(EAdYear1; EAdYear1)
                {
                }
                column(EAttend1; EAttend1)
                {
                }
                column(ECount1; ECount1)
                {
                }
                column(EDesc1; EDesc1)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc1 := '';
                    EEvenOdd1 := '';
                    EAdYear1 := '';
                    ENewstring1 := '';

                    IF ("Optional Student Subject-CS"."Actual Semester" = 'II') OR ("Optional Student Subject-CS"."Actual Semester" = 'IV') OR ("Optional Student Subject-CS"."Actual Semester" = 'VI') OR
                      ("Optional Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd1 := 'JAN-MAY';
                        ENewstring1 := "Optional Student Subject-CS"."Academic Year";
                        EAdYear1 := COPYSTR(ENewstring1, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd1 := 'JUL-NOV';
                        ENewstring1 := "Optional Student Subject-CS"."Academic Year";
                        EAdYear1 := COPYSTR(ENewstring1, 1, 4);
                    END;

                    EAttend1 += "Optional Student Subject-CS"."Attendance Percentage";
                    IF ESubjectCode1 <> "Optional Student Subject-CS"."Actual Subject Code" THEN
                        ECount1 += 1;

                    ESubjectCode1 := "Optional Student Subject-CS"."Actual Subject Code";
                end;

                trigger OnPreDataItem()
                begin
                    EAttend1 := 0;
                    ECount1 := 0;
                    ESubjectCode1 := '';
                end;
            }
            dataitem(MainStudentSubjectCS1; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('II'));
                PrintOnlyIfDetail = false;
                column(StudentNo1; "Student No.")
                {
                }
                column(SubjectCode1; "Subject Code")
                {
                }
                column(Semester1; Semester)
                {
                }
                column(Description1; Description)
                {
                }
                column(Grade1; Grade)
                {
                }
                column(Credit1; Credit)
                {
                    IncludeCaption = true;
                }
                column(SubjectPassDate_MainStudentSubjectCS1; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS1; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS1; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS1; "Attendance Percentage")
                {
                }
                column(EvenOdd2; EvenOdd2)
                {
                }
                column(AdYear2; AdYear2)
                {
                }
                column(Attend2; Attend2)
                {
                }
                column(Count2; Count2)
                {
                }
                column(Desc2; Desc2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc2 := '';
                    EvenOdd2 := '';
                    AdYear2 := '';
                    Newstring2 := '';

                    IF (MainStudentSubjectCS1."Actual Semester" = 'II') OR (MainStudentSubjectCS1."Actual Semester" = 'IV') OR (MainStudentSubjectCS1."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS1."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd2 := 'JAN-MAY';
                        Newstring2 := MainStudentSubjectCS1."Academic Year";
                        AdYear2 := COPYSTR(Newstring2, 6, 9);
                    END ELSE BEGIN
                        EvenOdd2 := 'JUL-NOV';
                        Newstring2 := MainStudentSubjectCS1."Academic Year";
                        AdYear2 := COPYSTR(Newstring2, 1, 4);
                    END;


                    Attend2 += MainStudentSubjectCS1."Attendance Percentage";
                    IF SubjectCode2 <> MainStudentSubjectCS1."Actual Subject Code" THEN
                        Count2 += 1;
                    SubjectCode2 := MainStudentSubjectCS1."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS1; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('II'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS1; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS1; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS1; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS1; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS1; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS1; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS1; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS1; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS1; "Actual Subject Description")
                {
                }
                column(EEvenOdd2; EEvenOdd2)
                {
                }
                column(EAdYear2; EAdYear2)
                {
                }
                column(EAttend2; EAttend2)
                {
                }
                column(ECount2; ECount2)
                {
                }
                column(EDesc2; EDesc2)
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS1; "Attendance Percentage")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc2 := '';
                    EEvenOdd2 := '';
                    EAdYear2 := '';
                    ENewstring2 := '';

                    IF (OptionalStudentSubjectCS1."Actual Semester" = 'II') OR (OptionalStudentSubjectCS1."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS1."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS1."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd2 := 'JAN-MAY';
                        ENewstring2 := OptionalStudentSubjectCS1."Academic Year";
                        EAdYear2 := COPYSTR(ENewstring2, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd2 := 'JUL-NOV';
                        ENewstring2 := OptionalStudentSubjectCS1."Academic Year";
                        EAdYear2 := COPYSTR(ENewstring2, 1, 4);
                    END;

                    EAttend2 += OptionalStudentSubjectCS1."Attendance Percentage";
                    IF ESubjectCode2 <> OptionalStudentSubjectCS1."Actual Subject Code" THEN
                        ECount2 += 1;
                    ESubjectCode2 := OptionalStudentSubjectCS1."Actual Subject Code";
                end;
            }
            dataitem(MainStudentSubjectCS2; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('III' | 'III & IV'));
                PrintOnlyIfDetail = false;
                column(StudentNo2; "Student No.")
                {
                }
                column(SubjectCode2; "Subject Code")
                {
                }
                column(Semester2; Semester)
                {
                }
                column(Description2; Description)
                {
                }
                column(Grade2; Grade)
                {
                }
                column(Credit2; Credit)
                {
                    IncludeCaption = true;
                }
                column(SubjectPassDate_MainStudentSubjectCS2; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS2; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS2; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS2; "Attendance Percentage")
                {
                }
                column(EvenOdd3; EvenOdd3)
                {
                }
                column(AdYear3; AdYear3)
                {
                }
                column(Attend3; Attend3)
                {
                }
                column(Count3; Count3)
                {
                }
                column(Desc3; Desc3)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc3 := '';
                    EvenOdd3 := '';
                    AdYear3 := '';
                    Newstring3 := '';

                    IF (MainStudentSubjectCS2."Actual Semester" = 'II') OR (MainStudentSubjectCS2."Actual Semester" = 'IV') OR (MainStudentSubjectCS2."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS2."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd3 := 'JAN-MAY';
                        Newstring3 := MainStudentSubjectCS2."Academic Year";
                        AdYear3 := COPYSTR(Newstring3, 6, 9);
                    END ELSE BEGIN
                        EvenOdd3 := 'JUL-NOV';
                        Newstring3 := MainStudentSubjectCS2."Academic Year";
                        AdYear3 := COPYSTR(Newstring3, 1, 4);
                    END;


                    Attend3 += MainStudentSubjectCS2."Attendance Percentage";
                    IF SubjectCode3 <> MainStudentSubjectCS2."Actual Subject Code" THEN
                        Count3 += 1;

                    SubjectCode3 := MainStudentSubjectCS2."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS2; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('III' | 'III & IV'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS2; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS2; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS2; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS2; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS2; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS2; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS2; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS2; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS2; "Actual Subject Description")
                {
                }
                column(EEvenOdd3; EEvenOdd3)
                {
                }
                column(EAdYear3; EAdYear3)
                {
                }
                column(EAttend3; EAttend3)
                {
                }
                column(ECount3; ECount3)
                {
                }
                column(EDesc3; EDesc3)
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS2; "Attendance Percentage")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc3 := '';
                    EEvenOdd3 := '';
                    EAdYear3 := '';
                    ENewstring3 := '';

                    IF (OptionalStudentSubjectCS2."Actual Semester" = 'II') OR (OptionalStudentSubjectCS2."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS2."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS2."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd3 := 'JAN-MAY';
                        ENewstring3 := OptionalStudentSubjectCS2."Academic Year";
                        EAdYear3 := COPYSTR(ENewstring3, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd3 := 'JUL-NOV';
                        ENewstring3 := OptionalStudentSubjectCS2."Academic Year";
                        EAdYear3 := COPYSTR(ENewstring3, 1, 4);
                    END;

                    EAttend3 += OptionalStudentSubjectCS2."Attendance Percentage";
                    IF ESubjectCode3 <> OptionalStudentSubjectCS2."Actual Subject Code" THEN
                        ECount3 += 1;
                    ESubjectCode3 := OptionalStudentSubjectCS2."Actual Subject Code";
                end;
            }
            dataitem(MainStudentSubjectCS3; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('IV'));
                PrintOnlyIfDetail = false;
                column(StudentNo3; "Student No.")
                {
                }
                column(SubjectCode3; "Subject Code")
                {
                }
                column(Semester3; Semester)
                {
                }
                column(Description3; Description)
                {
                }
                column(Grade3; Grade)
                {
                }
                column(Credit3; Credit)
                {
                    IncludeCaption = true;
                }
                column(SubjectPassDate_MainStudentSubjectCS3; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS3; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS3; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS3; "Attendance Percentage")
                {
                }
                column(EvenOdd4; EvenOdd4)
                {
                }
                column(AdYear4; AdYear4)
                {
                }
                column(Attend4; Attend4)
                {
                }
                column(Count4; Count4)
                {
                }
                column(Desc4; Desc4)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc4 := '';
                    EvenOdd4 := '';
                    AdYear4 := '';
                    Newstring4 := '';

                    IF (MainStudentSubjectCS3."Actual Semester" = 'II') OR (MainStudentSubjectCS3."Actual Semester" = 'IV') OR (MainStudentSubjectCS3."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS3."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd4 := 'JAN-MAY';
                        Newstring4 := MainStudentSubjectCS3."Academic Year";
                        AdYear4 := COPYSTR(Newstring4, 6, 9);
                    END ELSE BEGIN
                        EvenOdd4 := 'JUL-NOV';
                        Newstring4 := MainStudentSubjectCS3."Academic Year";
                        AdYear4 := COPYSTR(Newstring4, 1, 4);
                    END;

                    Attend4 += MainStudentSubjectCS3."Attendance Percentage";
                    IF SubjectCode4 <> MainStudentSubjectCS3."Actual Subject Code" THEN
                        Count4 += 1;

                    SubjectCode4 := MainStudentSubjectCS3."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS3; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('IV'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS3; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS3; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS3; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS3; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS3; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS3; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS3; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS3; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS3; "Actual Subject Description")
                {
                }
                column(EEvenOdd4; EEvenOdd4)
                {
                }
                column(EAdYear4; EAdYear4)
                {
                }
                column(EAttend4; EAttend4)
                {
                }
                column(ECount4; ECount4)
                {
                }
                column(EDesc4; EDesc4)
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS3; "Attendance Percentage")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc4 := '';
                    EEvenOdd4 := '';
                    EAdYear4 := '';
                    ENewstring4 := '';

                    IF (OptionalStudentSubjectCS3."Actual Semester" = 'II') OR (OptionalStudentSubjectCS3."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS3."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS3."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd4 := 'JAN-MAY';
                        ENewstring4 := OptionalStudentSubjectCS3."Academic Year";
                        EAdYear4 := COPYSTR(ENewstring4, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd4 := 'JUL-NOV';
                        ENewstring4 := OptionalStudentSubjectCS3."Academic Year";
                        EAdYear4 := COPYSTR(ENewstring4, 1, 4);
                    END;

                    EAttend4 += OptionalStudentSubjectCS3."Attendance Percentage";
                    IF ESubjectCode4 <> OptionalStudentSubjectCS3."Actual Subject Code" THEN
                        ECount4 += 1;

                    ESubjectCode4 := OptionalStudentSubjectCS3."Actual Subject Code";
                end;
            }
            dataitem(MainStudentSubjectCS4; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('V'));
                PrintOnlyIfDetail = false;
                column(StudentNo4; "Student No.")
                {
                }
                column(SubjectCode4; "Subject Code")
                {
                }
                column(Semester4; Semester)
                {
                }
                column(Description4; Description)
                {
                }
                column(Grade4; Grade)
                {
                }
                column(Credit4; Credit)
                {
                    IncludeCaption = true;
                }
                column(SubjectPassDate_MainStudentSubjectCS4; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS4; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS4; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS4; "Attendance Percentage")
                {
                }
                column(EvenOdd5; EvenOdd5)
                {
                }
                column(AdYear5; AdYear5)
                {
                }
                column(Attend5; Attend5)
                {
                }
                column(Count5; Count5)
                {
                }
                column(Desc5; Desc5)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc5 := '';
                    EvenOdd5 := '';
                    AdYear5 := '';
                    Newstring5 := '';

                    IF (MainStudentSubjectCS4."Actual Semester" = 'II') OR (MainStudentSubjectCS4."Actual Semester" = 'IV') OR (MainStudentSubjectCS4."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS4."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd5 := 'JAN-MAY';
                        Newstring5 := MainStudentSubjectCS4."Academic Year";
                        AdYear5 := COPYSTR(Newstring5, 6, 9);
                    END ELSE BEGIN
                        EvenOdd5 := 'JUL-NOV';
                        Newstring5 := MainStudentSubjectCS4."Academic Year";
                        AdYear5 := COPYSTR(Newstring5, 1, 4);
                    END;

                    Attend5 += MainStudentSubjectCS4."Attendance Percentage";
                    IF SubjectCode5 <> MainStudentSubjectCS4."Actual Subject Code" THEN
                        Count5 += 1;
                    SubjectCode5 := MainStudentSubjectCS4."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS4; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('V'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS4; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS4; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS4; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS4; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS4; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS4; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS4; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS4; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS4; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS4; "Attendance Percentage")
                {
                }
                column(EEvenOdd5; EEvenOdd5)
                {
                }
                column(EAdYear5; EAdYear5)
                {
                }
                column(EAttend5; EAttend5)
                {
                }
                column(ECount5; ECount5)
                {
                }
                column(EDesc5; EDesc5)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc5 := '';
                    EEvenOdd5 := '';
                    EAdYear5 := '';
                    ENewstring5 := '';

                    IF (OptionalStudentSubjectCS4."Actual Semester" = 'II') OR (OptionalStudentSubjectCS4."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS4."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS4."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd5 := 'JAN-MAY';
                        ENewstring5 := OptionalStudentSubjectCS4."Academic Year";
                        EAdYear5 := COPYSTR(ENewstring5, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd5 := 'JUL-NOV';
                        ENewstring5 := OptionalStudentSubjectCS4."Academic Year";
                        EAdYear5 := COPYSTR(ENewstring5, 1, 4);
                    END;


                    EAttend5 += OptionalStudentSubjectCS4."Attendance Percentage";
                    IF ESubjectCode5 <> OptionalStudentSubjectCS4."Actual Subject Code" THEN
                        ECount5 += 1;
                    ESubjectCode5 := OptionalStudentSubjectCS4."Actual Subject Code";
                end;
            }
            dataitem(MainStudentSubjectCS5; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VI'));
                PrintOnlyIfDetail = false;
                column(StudentNo5; "Student No.")
                {
                }
                column(SubjectCode5; "Subject Code")
                {
                }
                column(Semester5; Semester)
                {
                }
                column(Description5; Description)
                {
                }
                column(Grade5; Grade)
                {
                }
                column(Credit5; Credit)
                {
                    IncludeCaption = true;
                }
                column(SubjectPassDate_MainStudentSubjectCS5; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS5; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS5; "Actual Subject Description")
                {
                }
                column(EvenOdd6; EvenOdd6)
                {
                }
                column(AdYear6; AdYear6)
                {
                }
                column(Attend6; Attend6)
                {
                }
                column(Count6; Count6)
                {
                }
                column(Desc6; Desc6)
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS5; "Attendance Percentage")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc6 := '';
                    EvenOdd6 := '';
                    AdYear6 := '';
                    Newstring6 := '';

                    IF (MainStudentSubjectCS5."Actual Semester" = 'II') OR (MainStudentSubjectCS5."Actual Semester" = 'IV') OR (MainStudentSubjectCS5."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS5."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd6 := 'JAN-MAY';
                        Newstring6 := MainStudentSubjectCS5."Academic Year";
                        AdYear6 := COPYSTR(Newstring6, 6, 9);
                    END ELSE BEGIN
                        EvenOdd6 := 'JUL-NOV';
                        Newstring6 := MainStudentSubjectCS5."Academic Year";
                        AdYear6 := COPYSTR(Newstring6, 1, 4);
                    END;

                    Attend6 += MainStudentSubjectCS5."Attendance Percentage";
                    IF SubjectCode6 <> MainStudentSubjectCS5."Actual Subject Code" THEN
                        Count6 += 1;

                    SubjectCode6 := MainStudentSubjectCS5."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS5; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VI'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS5; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS5; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS5; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS5; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS5; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS5; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS5; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS5; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS5; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS5; "Attendance Percentage")
                {
                }
                column(EEvenOdd6; EEvenOdd6)
                {
                }
                column(EAdYear6; EAdYear6)
                {
                }
                column(EAttend6; EAttend6)
                {
                }
                column(ECount6; ECount6)
                {
                }
                column(EDesc6; EDesc6)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc6 := '';
                    EEvenOdd6 := '';
                    EAdYear6 := '';
                    ENewstring6 := '';

                    IF (OptionalStudentSubjectCS5."Actual Semester" = 'II') OR (OptionalStudentSubjectCS5."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS5."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS5."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd6 := 'JAN-MAY';
                        ENewstring6 := OptionalStudentSubjectCS5."Academic Year";
                        EAdYear6 := COPYSTR(ENewstring6, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd6 := 'JUL-NOV';
                        ENewstring6 := OptionalStudentSubjectCS5."Academic Year";
                        EAdYear6 := COPYSTR(ENewstring6, 1, 4);
                    END;

                    EAttend6 += OptionalStudentSubjectCS5."Attendance Percentage";
                    IF ESubjectCode6 <> OptionalStudentSubjectCS5."Actual Subject Code" THEN
                        ECount6 += 1;

                    ESubjectCode6 := OptionalStudentSubjectCS5."Actual Subject Code";
                end;
            }
            dataitem(MainStudentSubjectCS6; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VII'));
                PrintOnlyIfDetail = false;
                column(StudentNo6; "Student No.")
                {
                }
                column(SubjectCode6; "Subject Code")
                {
                }
                column(Semester6; Semester)
                {
                }
                column(Description6; Description)
                {
                }
                column(Grade6; Grade)
                {
                }
                column(Credit6; Credit)
                {
                    IncludeCaption = true;
                }
                column(AttendancePercentage_MainStudentSubjectCS6; "Attendance Percentage")
                {
                }
                column(SubjectPassDate_MainStudentSubjectCS6; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS6; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS6; "Actual Subject Description")
                {
                }
                column(EvenOdd7; EvenOdd7)
                {
                }
                column(AdYear7; AdYear7)
                {
                }
                column(Attend7; Attend7)
                {
                }
                column(Count7; Count7)
                {
                }
                column(Desc7; Desc7)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc7 := '';
                    EvenOdd7 := '';
                    AdYear7 := '';
                    Newstring7 := '';

                    IF (MainStudentSubjectCS6."Actual Semester" = 'II') OR (MainStudentSubjectCS6."Actual Semester" = 'IV') OR (MainStudentSubjectCS6."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS6."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd7 := 'JAN-MAY';
                        Newstring7 := MainStudentSubjectCS6."Academic Year";
                        AdYear7 := COPYSTR(Newstring7, 6, 9);
                    END ELSE BEGIN
                        EvenOdd7 := 'JUL-NOV';
                        Newstring7 := MainStudentSubjectCS6."Academic Year";
                        AdYear7 := COPYSTR(Newstring7, 1, 4);
                    END;

                    Attend7 += MainStudentSubjectCS6."Attendance Percentage";
                    IF SubjectCode7 <> MainStudentSubjectCS6."Actual Subject Code" THEN
                        Count7 += 1;

                    SubjectCode7 := MainStudentSubjectCS6."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS6; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VII'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS6; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS6; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS6; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS6; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS6; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS6; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS6; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS6; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS6; "Actual Subject Description")
                {
                }
                column(EEvenOdd7; EEvenOdd7)
                {
                }
                column(EAdYear7; EAdYear7)
                {
                }
                column(EAttend7; EAttend7)
                {
                }
                column(ECount7; ECount7)
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS6; "Attendance Percentage")
                {
                }
                column(EDesc7; EDesc7)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc7 := '';
                    EEvenOdd7 := '';
                    EAdYear7 := '';
                    ENewstring7 := '';

                    IF (OptionalStudentSubjectCS6."Actual Semester" = 'II') OR (OptionalStudentSubjectCS6."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS6."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS6."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd7 := 'JAN-MAY';
                        ENewstring7 := OptionalStudentSubjectCS6."Academic Year";
                        EAdYear7 := COPYSTR(ENewstring7, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd7 := 'JUL-NOV';
                        ENewstring7 := OptionalStudentSubjectCS6."Academic Year";
                        EAdYear7 := COPYSTR(ENewstring7, 1, 4);
                    END;

                    EAttend7 += OptionalStudentSubjectCS6."Attendance Percentage";
                    IF ESubjectCode7 <> OptionalStudentSubjectCS6."Actual Subject Code" THEN
                        ECount7 += 1;
                    ESubjectCode7 := OptionalStudentSubjectCS6."Actual Subject Code";
                end;
            }
            dataitem(MainStudentSubjectCS7; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VIII'));
                PrintOnlyIfDetail = false;
                column(StudentNo7; "Student No.")
                {
                }
                column(SubjectCode7; "Subject Code")
                {
                }
                column(Semester7; Semester)
                {
                }
                column(Description7; Description)
                {
                }
                column(Grade7; Grade)
                {
                }
                column(Credit7; Credit)
                {
                    IncludeCaption = true;
                }
                column(SubjectPassDate_MainStudentSubjectCS7; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_MainStudentSubjectCS7; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_MainStudentSubjectCS7; "Actual Subject Description")
                {
                }
                column(AttendancePercentage_MainStudentSubjectCS7; "Attendance Percentage")
                {
                }
                column(EvenOdd8; EvenOdd8)
                {
                }
                column(AdYear8; AdYear8)
                {
                }
                column(Attend8; Attend8)
                {
                }
                column(Count8; Count8)
                {
                }
                column(Desc8; Desc8)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Desc8 := '';
                    EvenOdd8 := '';
                    AdYear8 := '';
                    Newstring8 := '';

                    IF (MainStudentSubjectCS7."Actual Semester" = 'II') OR (MainStudentSubjectCS7."Actual Semester" = 'IV') OR (MainStudentSubjectCS7."Actual Semester" = 'VI') OR
                      (MainStudentSubjectCS7."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd8 := 'JAN-MAY';
                        Newstring8 := MainStudentSubjectCS7."Academic Year";
                        AdYear8 := COPYSTR(Newstring8, 6, 9);
                    END ELSE BEGIN
                        EvenOdd8 := 'JUL-NOV';
                        Newstring8 := MainStudentSubjectCS7."Academic Year";
                        AdYear8 := COPYSTR(Newstring8, 1, 4);
                    END;

                    Attend8 += MainStudentSubjectCS7."Attendance Percentage";
                    IF SubjectCode8 <> MainStudentSubjectCS7."Actual Subject Code" THEN
                        Count8 += 1;
                    SubjectCode8 := MainStudentSubjectCS7."Actual Subject Code";
                end;
            }
            dataitem(OptionalStudentSubjectCS7; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VIII'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_OptionalStudentSubjectCS7; "Student No.")
                {
                }
                column(SubjectCode_OptionalStudentSubjectCS7; "Subject Code")
                {
                }
                column(Semester_OptionalStudentSubjectCS7; Semester)
                {
                }
                column(Description_OptionalStudentSubjectCS7; Description)
                {
                }
                column(Grade_OptionalStudentSubjectCS7; Grade)
                {
                }
                column(Credit_OptionalStudentSubjectCS7; Credit)
                {
                }
                column(SubjectPassDate_OptionalStudentSubjectCS7; "Subject Pass Date")
                {
                }
                column(ActualSubjectCode_OptionalStudentSubjectCS7; "Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_OptionalStudentSubjectCS7; "Actual Subject Description")
                {
                }
                column(EEvenOdd8; EEvenOdd8)
                {
                }
                column(EAdYear8; EAdYear8)
                {
                }
                column(EAttend8; EAttend8)
                {
                }
                column(ECount8; ECount8)
                {
                }
                column(EDesc8; EDesc8)
                {
                }
                column(AttendancePercentage_OptionalStudentSubjectCS7; "Attendance Percentage")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EDesc8 := '';
                    EEvenOdd8 := '';
                    EAdYear8 := '';
                    ENewstring8 := '';

                    IF (OptionalStudentSubjectCS7."Actual Semester" = 'II') OR (OptionalStudentSubjectCS7."Actual Semester" = 'IV') OR (OptionalStudentSubjectCS7."Actual Semester" = 'VI') OR
                      (OptionalStudentSubjectCS7."Actual Semester" = 'VIII') THEN BEGIN
                        EEvenOdd8 := 'JAN-MAY';
                        ENewstring8 := OptionalStudentSubjectCS7."Academic Year";
                        EAdYear8 := COPYSTR(ENewstring8, 6, 9);
                    END ELSE BEGIN
                        EEvenOdd8 := 'JUL-NOV';
                        ENewstring8 := OptionalStudentSubjectCS7."Academic Year";
                        EAdYear8 := COPYSTR(ENewstring8, 1, 4);
                    END;

                    EAttend8 += OptionalStudentSubjectCS7."Attendance Percentage";
                    IF ESubjectCode8 <> OptionalStudentSubjectCS7."Actual Subject Code" THEN
                        ECount8 += 1;

                    ESubjectCode8 := OptionalStudentSubjectCS7."Actual Subject Code";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Type Of Course", MainStudentSubjectCS."Type Of Course"::Semester);
                IF MainStudentSubjectCS.findfirst() THEN
                    Sem := MainStudentSubjectCS."Actual Semester"
                ELSE
                    Sem := CopyStr(MainStudentSubjectCS.Year, 1, MaxStrLen(Sem));


                CourseTypeMasterCS.Reset();
                CourseTypeMasterCS.SETRANGE("Course Code", "Course Code");
                IF CourseTypeMasterCS.findfirst() THEN
                    CourseDesc := CourseTypeMasterCS."Course Type Name";


                Year1 := "Student Master-CS".Graduation;
                IF Year1 = 'PG' THEN
                    Year2 := 'Master'
                ELSE
                    Year2 := 'Bachelors';


                IF "Semester I GPA" > 0 THEN
                    Semester1 := 1;
                IF "Semester II GPA" > 0 THEN
                    Semester2 := 1;
                IF "Semester III GPA" > 0 THEN
                    Semester3 := 1;
                IF "Semester IV GPA" > 0 THEN
                    Semester4 := 1;
                IF "Semester V GPA" > 0 THEN
                    Semester5 := 1;
                IF "Semester VI GPA" > 0 THEN
                    Semester6 := 1;
                IF "Semester VII GPA" > 0 THEN
                    Semester7 := 1;
                IF "Semester VIII GPA" > 0 THEN
                    Semester8 := 1;
            end;

            trigger OnPreDataItem()
            begin
                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '09');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CourseTypeMasterCS: Record "Course Type Master-CS";

        MainStudentSubjectCS: Record "Main Student Subject-CS";

        DimensionValue: Record "Dimension Value";
        CourseDesc: Text[100];
        Year1: Code[20];
        Sem: Code[10];
        Year2: Text[150];
        Semester1: Integer;
        Semester2: Integer;
        Semester3: Integer;
        Semester4: Integer;
        Semester5: Integer;
        Semester6: Integer;
        Semester7: Integer;
        Semester8: Integer;

        EvenOdd1: Code[10];
        AdYear1: Code[10];
        Newstring1: Code[20];
        EvenOdd2: Code[10];
        AdYear2: Code[10];
        Newstring2: Code[20];
        EvenOdd3: Code[10];
        AdYear3: Code[10];
        Newstring3: Code[20];
        EvenOdd4: Code[10];
        AdYear4: Code[10];
        Newstring4: Code[20];
        EvenOdd5: Code[10];
        AdYear5: Code[10];
        Newstring5: Code[20];
        EvenOdd6: Code[10];
        AdYear6: Code[10];
        Newstring6: Code[20];
        EvenOdd7: Code[10];
        AdYear7: Code[10];
        Newstring7: Code[20];
        EvenOdd8: Code[10];
        AdYear8: Code[10];
        Newstring8: Code[20];
        EEvenOdd1: Code[10];
        EAdYear1: Code[10];
        ENewstring1: Code[20];
        EEvenOdd2: Code[10];
        EAdYear2: Code[10];
        ENewstring2: Code[20];
        EEvenOdd3: Code[10];
        EAdYear3: Code[10];
        ENewstring3: Code[20];
        EEvenOdd4: Code[10];
        EAdYear4: Code[10];
        ENewstring4: Code[20];
        EEvenOdd5: Code[10];
        EAdYear5: Code[10];
        ENewstring5: Code[20];
        EEvenOdd6: Code[10];
        EAdYear6: Code[10];
        ENewstring6: Code[20];
        EEvenOdd7: Code[10];
        EAdYear7: Code[10];
        ENewstring7: Code[20];
        EEvenOdd8: Code[10];
        EAdYear8: Code[10];
        ENewstring8: Code[20];
        Attend1: Decimal;
        SubjectCode1: Code[20];
        Count1: Integer;
        Attend2: Decimal;
        SubjectCode2: Code[20];
        Count2: Integer;
        Attend3: Decimal;
        SubjectCode3: Code[20];
        Count3: Integer;
        Attend4: Decimal;
        SubjectCode4: Code[20];
        Count4: Integer;
        Attend5: Decimal;
        SubjectCode5: Code[20];
        Count5: Integer;
        Attend6: Decimal;
        SubjectCode6: Code[20];
        Count6: Integer;
        Attend7: Decimal;
        SubjectCode7: Code[20];
        Count7: Integer;
        Attend8: Decimal;
        SubjectCode8: Code[20];
        Count8: Integer;
        EAttend1: Decimal;
        ESubjectCode1: Code[20];
        ECount1: Integer;
        EAttend2: Decimal;
        ESubjectCode2: Code[20];
        ECount2: Integer;
        EAttend3: Decimal;
        ESubjectCode3: Code[20];
        ECount3: Integer;
        EAttend4: Decimal;
        ESubjectCode4: Code[20];
        ECount4: Integer;
        EAttend5: Decimal;
        ESubjectCode5: Code[20];
        ECount5: Integer;
        EAttend6: Decimal;
        ESubjectCode6: Code[20];
        ECount6: Integer;
        EAttend7: Decimal;
        ESubjectCode7: Code[20];
        ECount7: Integer;
        EAttend8: Decimal;
        ESubjectCode8: Code[20];
        ECount8: Integer;

        Desc1: Text[100];
        Desc2: Text[100];
        Desc3: Text[100];
        Desc4: Text[100];
        Desc5: Text[100];
        Desc6: Text[100];
        Desc7: Text[100];
        Desc8: Text[100];
        EDesc1: Text[100];
        EDesc2: Text[100];
        EDesc3: Text[100];
        EDesc4: Text[100];
        EDesc5: Text[100];
        EDesc6: Text[100];
        EDesc7: Text[100];
        EDesc8: Text[100];

}

