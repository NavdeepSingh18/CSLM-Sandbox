report 50053 "Transcript Report-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Transcript Report-CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Transcript Report';
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Enrollment No.";
            column(No_StudentCOLLEGE; "Student Master-CS"."No.")
            {
            }
            column(NameasonCertificate_StudentCOLLEGE; "Student Master-CS"."Name as on Certificate")
            {
            }
            column(EnrollmentNo_StudentCOLLEGE; "Student Master-CS"."Enrollment No.")
            {
            }
            column(CourseName_StudentCOLLEGE; "Student Master-CS"."Course Name")
            {
            }
            column(DateofJoining_StudentCOLLEGE; "Student Master-CS"."Date of Joining")
            {
            }
            column(DateofLeaving_StudentCOLLEGE; "Student Master-CS"."Date of Leaving")
            {
            }
            column(LatestGPA_StudentCOLLEGE; "Student Master-CS"."Latest GPA")
            {
            }
            column(Graduation_StudentCOLLEGE; "Student Master-CS".Graduation)
            {
            }
            column(TypeOfCourse_StudentCOLLEGE; "Student Master-CS"."Type Of Course")
            {
            }
            column(CourseType_StudentCOLLEGE; "Student Master-CS"."Course Type")
            {
            }
            column(StudentStatus_StudentCOLLEGE; "Student Master-CS"."Student Status")
            {
            }
            column(LateralStudent_StudentCOLLEGE; "Student Master-CS"."Lateral Student")
            {
            }
            column(Semester_StudentCOLLEGE; "Student Master-CS".Semester)
            {
            }
            column(Year_StudentCOLLEGE; "Student Master-CS".Year)
            {
            }
            column(SemesterIGPA_StudentCOLLEGE; "Student Master-CS"."Semester I GPA")
            {
            }
            column(SemesterIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester II GPA")
            {
            }
            column(SemesterIIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester III GPA")
            {
            }
            column(SemesterIVGPA_StudentCOLLEGE; "Student Master-CS"."Semester IV GPA")
            {
            }
            column(SemesterVGPA_StudentCOLLEGE; "Student Master-CS"."Semester V GPA")
            {
            }
            column(SemesterVIGPA_StudentCOLLEGE; "Student Master-CS"."Semester VI GPA")
            {
            }
            column(SemesterVIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester VII GPA")
            {
            }
            column(SemesterVIIIGPA_StudentCOLLEGE; "Student Master-CS"."Semester VIII GPA")
            {
            }
            column(NetSemesterCGPA_StudentCOLLEGE; "Student Master-CS"."Net Semester CGPA")
            {
            }
            column(SemesterICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester I Credit Earned")
            {
            }
            column(SemesterIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester II Credit Earned")
            {
            }
            column(SemesterIIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester III Credit Earned")
            {
            }
            column(SemesterIVCreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester IV Credit Earned")
            {
            }
            column(SemesterVCreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester V Credit Earned")
            {
            }
            column(SemesterVICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester VI Credit Earned")
            {
            }
            column(SemesterVIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester VII Credit Earned")
            {
            }
            column(SemesterVIIICreditEarned_StudentCOLLEGE; "Student Master-CS"."Semester VIII Credit Earned")
            {
            }
            column(DurationCourse; DurationCourse)
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
            column(Text1; Text1)
            {
            }
            column(Text2; Text2)
            {
            }
            column(SemGrade1; SemGrade1)
            {
            }
            column(SemGrade2; SemGrade2)
            {
            }
            column(SemGrade3; SemGrade3)
            {
            }
            column(SemGrade4; SemGrade4)
            {
            }
            column(SemGrade5; SemGrade5)
            {
            }
            column(SemGrade6; SemGrade6)
            {
            }
            column(SemGrade7; SemGrade7)
            {
            }
            column(SemGrade8; SemGrade8)
            {
            }
            column(GradeCount; GradeCount)
            {
            }
            dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('I'));
                PrintOnlyIfDetail = false;
                column(TypeOfCourse_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Type Of Course")
                {
                }
                column(AcademicYear_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Academic Year")
                {
                }
                column(StudentName_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Student Name")
                {
                }
                column(EnrollmentNo_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Enrollment No")
                {
                }
                column(StudentNo_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Student No.")
                {
                }
                column(SubjectType_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Subject Type")
                {
                }
                column(ActualSubjectCode_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Actual Subject Code")
                {
                }
                column(Desc1; "Main Student Subject-CS"."Actual Subject Description")
                {
                }
                column(Grade_StudentSubjectCOLLEGE; "Main Student Subject-CS".Grade)
                {
                }
                column(Credit_StudentSubjectCOLLEGE; "Main Student Subject-CS".Credit)
                {
                }
            }
            dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('I'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                PrintOnlyIfDetail = false;
                UseTemporary = false;
                column(StudentNo_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Student No.")
                {
                }
                column(SubjectCode; "Optional Student Subject-CS"."Subject Code")
                {
                }
                column(SubjectType_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Subject Type")
                {
                }
                column(ActualSubjectCode_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Actual Subject Code")
                {
                }
                column(EDesc1; "Optional Student Subject-CS"."Actual Subject Description")
                {
                }
                column(Description_StudentOptionalSubjectCOL; "Optional Student Subject-CS".Description)
                {
                }
                column(Grade_StudentOptionalSubjectCOL; "Optional Student Subject-CS".Grade)
                {
                }
                column(Credit_StudentOptionalSubjectCOL; "Optional Student Subject-CS".Credit)
                {
                }
                column(AttendancePercentage_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Attendance Percentage")
                {
                }
            }
            dataitem("<Main Student Subject-CS1>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('II'));
                PrintOnlyIfDetail = false;
                column(StudentNo1; "<Main Student Subject-CS1>"."Student No.")
                {
                }
                column(SubjectCode1; "<Main Student Subject-CS1>"."Subject Code")
                {
                }
                column(Semester1; "<Main Student Subject-CS1>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject1; "<Main Student Subject-CS1>"."Actual Subject Code")
                {
                }
                column(Desc2; "<Main Student Subject-CS1>"."Actual Subject Description")
                {
                }
                column(Description1; "<Main Student Subject-CS1>".Description)
                {
                }
                column(Grade1; "<Main Student Subject-CS1>".Grade)
                {
                }
                column(Credit1; "<Main Student Subject-CS1>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS1>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('II'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional1; "<Optional Student Subject-CS1>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional1; "<Optional Student Subject-CS1>"."Subject Code")
                {
                }
                column(Semester_StudentOptional1; "<Optional Student Subject-CS1>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional1; "<Optional Student Subject-CS1>"."Actual Subject Code")
                {
                }
                column(EDesc2; "<Optional Student Subject-CS1>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional1; "<Optional Student Subject-CS1>".Description)
                {
                }
                column(Grade_StudentOptional1; "<Optional Student Subject-CS1>".Grade)
                {
                }
                column(Credit_StudentOptional1; "<Optional Student Subject-CS1>".Credit)
                {
                }
            }
            dataitem("<Main Student Subject-CS2>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('III' | 'III & IV'));
                PrintOnlyIfDetail = false;
                column(StudentNo2; "<Main Student Subject-CS2>"."Student No.")
                {
                }
                column(SubjectCode2; "<Main Student Subject-CS2>"."Subject Code")
                {
                }
                column(Semester2; "<Main Student Subject-CS2>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject2; "<Main Student Subject-CS2>"."Actual Subject Code")
                {
                }
                column(Desc3; "<Main Student Subject-CS2>"."Actual Subject Description")
                {
                }
                column(Description2; "<Main Student Subject-CS2>".Description)
                {
                }
                column(Grade2; "<Main Student Subject-CS2>".Grade)
                {
                }
                column(Credit2; "<Main Student Subject-CS2>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS2>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('III' | 'III & IV'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional2; "<Optional Student Subject-CS2>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional2; "<Optional Student Subject-CS2>"."Subject Code")
                {
                }
                column(Semester_StudentOptional2; "<Optional Student Subject-CS2>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional2; "<Optional Student Subject-CS2>"."Actual Subject Code")
                {
                }
                column(EDesc3; "<Optional Student Subject-CS2>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional2; "<Optional Student Subject-CS2>".Description)
                {
                }
                column(Grade_StudentOptional2; "<Optional Student Subject-CS2>".Grade)
                {
                }
                column(Credit_StudentOptional2; "<Optional Student Subject-CS2>".Credit)
                {
                }
            }
            dataitem("<Main Student Subject-CS3>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('IV'));
                PrintOnlyIfDetail = false;
                column(StudentNo3; "<Main Student Subject-CS3>"."Student No.")
                {
                }
                column(SubjectCode3; "<Main Student Subject-CS3>"."Subject Code")
                {
                }
                column(Semester3; "<Main Student Subject-CS3>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject3; "<Main Student Subject-CS3>"."Actual Subject Code")
                {
                }
                column(Desc4; "<Main Student Subject-CS3>"."Actual Subject Description")
                {
                }
                column(Description3; "<Main Student Subject-CS3>".Description)
                {
                }
                column(Grade3; "<Main Student Subject-CS3>".Grade)
                {
                }
                column(Credit3; "<Main Student Subject-CS3>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS3>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('IV'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional3; "<Optional Student Subject-CS3>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional3; "<Optional Student Subject-CS3>"."Subject Code")
                {
                }
                column(Semester_StudentOptional3; "<Optional Student Subject-CS3>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional3; "<Optional Student Subject-CS3>"."Actual Subject Code")
                {
                }
                column(EDesc4; "<Optional Student Subject-CS3>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional3; "<Optional Student Subject-CS3>".Description)
                {
                }
                column(Grade_StudentOptional3; "<Optional Student Subject-CS3>".Grade)
                {
                }
                column(Credit_StudentOptional3; "<Optional Student Subject-CS3>".Credit)
                {
                }
            }
            dataitem("<Main Student Subject-CS4>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('V'));
                PrintOnlyIfDetail = false;
                column(StudentNo4; "<Main Student Subject-CS4>"."Student No.")
                {
                }
                column(SubjectCode4; "<Main Student Subject-CS4>"."Subject Code")
                {
                }
                column(Semester4; "<Main Student Subject-CS4>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject4; "<Main Student Subject-CS4>"."Actual Subject Code")
                {
                }
                column(Desc5; "<Main Student Subject-CS4>"."Actual Subject Description")
                {
                }
                column(Description4; "<Main Student Subject-CS4>".Description)
                {
                }
                column(Grade4; "<Main Student Subject-CS4>".Grade)
                {
                }
                column(Credit4; "<Main Student Subject-CS4>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS4>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('V'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional4; "<Optional Student Subject-CS4>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional4; "<Optional Student Subject-CS4>"."Subject Code")
                {
                }
                column(Semester_StudentOptional4; "<Optional Student Subject-CS4>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional4; "<Optional Student Subject-CS4>"."Actual Subject Code")
                {
                }
                column(EDesc5; "<Optional Student Subject-CS4>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional4; "<Optional Student Subject-CS4>".Description)
                {
                }
                column(Grade_StudentOptional4; "<Optional Student Subject-CS4>".Grade)
                {
                }
                column(Credit_StudentOptional4; "<Optional Student Subject-CS4>".Credit)
                {
                }
            }
            dataitem("<Main Student Subject-CS5>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VI'));
                PrintOnlyIfDetail = false;
                column(StudentNo5; "<Main Student Subject-CS5>"."Student No.")
                {
                }
                column(SubjectCode5; "<Main Student Subject-CS5>"."Subject Code")
                {
                }
                column(Semester5; "<Main Student Subject-CS5>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject5; "<Main Student Subject-CS5>"."Actual Subject Code")
                {
                }
                column(Desc6; "<Main Student Subject-CS5>"."Actual Subject Description")
                {
                }
                column(Description5; "<Main Student Subject-CS5>".Description)
                {
                }
                column(Grade5; "<Main Student Subject-CS5>".Grade)
                {
                }
                column(Credit5; "<Main Student Subject-CS5>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS5>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VI'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional5; "<Optional Student Subject-CS5>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional5; "<Optional Student Subject-CS5>"."Subject Code")
                {
                }
                column(Semester_StudentOptional5; "<Optional Student Subject-CS5>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional5; "<Optional Student Subject-CS5>"."Actual Subject Code")
                {
                }
                column(EDesc6; "<Optional Student Subject-CS5>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional5; "<Optional Student Subject-CS5>".Description)
                {
                }
                column(Grade_StudentOptional5; "<Optional Student Subject-CS5>".Grade)
                {
                }
                column(Credit_StudentOptional5; "<Optional Student Subject-CS5>".Credit)
                {
                }
            }
            dataitem("<Main Student Subject-CS6>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VII'));
                PrintOnlyIfDetail = false;
                column(StudentNo6; "<Main Student Subject-CS6>"."Student No.")
                {
                }
                column(SubjectCode6; "<Main Student Subject-CS6>"."Subject Code")
                {
                }
                column(Semester6; "<Main Student Subject-CS6>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject6; "<Main Student Subject-CS6>"."Actual Subject Code")
                {
                }
                column(Desc7; "<Main Student Subject-CS6>"."Actual Subject Description")
                {
                }
                column(Description6; "<Main Student Subject-CS6>".Description)
                {
                }
                column(Grade6; "<Main Student Subject-CS6>".Grade)
                {
                }
                column(Credit6; "<Main Student Subject-CS6>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS6>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VII'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional6; "<Optional Student Subject-CS6>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional6; "<Optional Student Subject-CS6>"."Subject Code")
                {
                }
                column(Semester_StudentOptional6; "<Optional Student Subject-CS6>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional6; "<Optional Student Subject-CS6>"."Actual Subject Code")
                {
                }
                column(EDesc7; "<Optional Student Subject-CS6>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional6; "<Optional Student Subject-CS6>".Description)
                {
                }
                column(Grade_StudentOptional6; "<Optional Student Subject-CS6>".Grade)
                {
                }
                column(Credit_StudentOptional6; "<Optional Student Subject-CS6>".Credit)
                {
                }
            }
            dataitem("<Main Student Subject-CS7>"; "Main Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VIII'));
                PrintOnlyIfDetail = false;
                column(StudentNo7; "<Main Student Subject-CS7>"."Student No.")
                {
                }
                column(SubjectCode7; "<Main Student Subject-CS7>"."Subject Code")
                {
                }
                column(Semester7; "<Main Student Subject-CS7>".Semester)
                {
                }
                column(ActualSubjectCode_StudentSubject7; "<Main Student Subject-CS7>"."Actual Subject Code")
                {
                }
                column(Desc8; "<Main Student Subject-CS7>"."Actual Subject Description")
                {
                }
                column(Description7; "<Main Student Subject-CS7>".Description)
                {
                }
                column(Grade7; "<Main Student Subject-CS7>".Grade)
                {
                }
                column(Credit7; "<Main Student Subject-CS7>".Credit)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("<Optional Student Subject-CS7>"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Actual Semester" = FILTER('VIII'),
                                          "Program/Open Elective Temp" = FILTER(' '));
                column(StudentNo_StudentOptional7; "<Optional Student Subject-CS7>"."Student No.")
                {
                }
                column(SubjectCode_StudentOptional7; "<Optional Student Subject-CS7>"."Subject Code")
                {
                }
                column(Semester_StudentOptional7; "<Optional Student Subject-CS7>".Semester)
                {
                }
                column(ActualSubjectCode_StudentOptional7; "<Optional Student Subject-CS7>"."Actual Subject Code")
                {
                }
                column(EDesc8; "<Optional Student Subject-CS7>"."Actual Subject Description")
                {
                }
                column(Description_StudentOptional7; "<Optional Student Subject-CS7>".Description)
                {
                }
                column(Grade_StudentOptional7; "<Optional Student Subject-CS7>".Grade)
                {
                }
                column(Credit_StudentOptional7; "<Optional Student Subject-CS7>".Credit)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Type Of Course", MainStudentSubjectCS."Type Of Course"::Semester);
                IF MainStudentSubjectCS.findfirst() THEN
                    Sem := MainStudentSubjectCS."Actual Semester"
                ELSE
                    Sem := MainStudentSubjectCS.Semester;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Grade, '%1|%2|%3', 'F', 'DT', 'I');
                IF MainStudentSubjectCS.findset() THEN
                    GradeCount1 := MainStudentSubjectCS.count();

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Grade, '%1|%2|%3', 'F', 'DT', 'I');
                IF OptionalStudentSubjectCS.findset() THEN
                    GradeCount2 := OptionalStudentSubjectCS.count();

                GradeCountTotal := GradeCount1 + GradeCount2;

                CourseTypeMasterCS.Reset();
                CourseTypeMasterCS.SETRANGE("Course Code", "Course Code");
                IF CourseTypeMasterCS.findfirst() THEN
                    CourseDesc := CourseTypeMasterCS."Course Type Name";

                Year1 := "Student Master-CS".Graduation;
                IF Year1 = 'PG' then
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

                DurationCourse := Semester1 + Semester2 + Semester3 + Semester4 + Semester5 + Semester6 + Semester7 + Semester8;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'I');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade1 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'II');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade2 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS."Actual Semester", '%1|%2', 'III', 'III & IV');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade3 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;



                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'IV');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade4 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'V');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade5 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;



                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'VI');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade6 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'VII');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade7 := MainStudentSubjectCS.Grade;
                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                GradeCount := 0;
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "Student Master-CS"."No.");
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", 'VIII');
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        SemGrade8 := MainStudentSubjectCS.Grade;
                        IF MainStudentSubjectCS.Grade = '' THEN
                            GradeCount := GradeCount + 1;

                    UNTIL MainStudentSubjectCS.NEXT() = 0;


                IF "Student Master-CS"."Degree Code" = 'B.Tech.' THEN//- Field type change
                    IF "Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::"Course Completion" THEN BEGIN
                        IF "Student Master-CS"."Lateral Student" = FALSE THEN
                            Text1 := 'The above student has completed all the requirements of the 8 semesters programme and eligible for Bachelors Degree.'
                        ELSE BEGIN
                            Text1 := '1. The above student has completed all the requirements of the 8 semesters programme and eligible for Bachelors Degree.';
                            Text2 := '2. CGPA is calculated from III to VIII semester. This student is admitted to III semester under lateral entry scheme (As per G.O. No. 23, TGK, 96 dated 22.09.2001, Government of Karnataka.';
                        END
                    END ELSE
                        IF GradeCountTotal = 0 THEN
                            Text1 := 'The above student has to complete ' + FORMAT(8 - DurationCourse) + ' more semester(s) of the 8 semesters programme to be awarded for his/her Bachelors Degree.'
                        ELSE
                            Text1 := 'The above student has to complete ' + FORMAT(GradeCountTotal) + ' more semester(s) of the 8 semesters programme to be awarded for his/her Bachelors Degree.';


                IF "Student Master-CS"."Degree Code" = 'M.Tech.' THEN
                    IF "Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::"Course Completion" THEN
                        Text1 := 'The above student has completed all the requirements of the 2 year programme and eligible for Masters Degree.'
                    ELSE
                        Text1 := 'The above student has to complete 1 more year of the 2 years programme to be awarded for his/her Masters Degree.';


                IF "Student Master-CS"."Degree Code" = 'MCA' THEN
                    IF "Student Master-CS"."Student Status" = "Student Master-CS"."Student Status"::"Course Completion" THEN
                        Text1 := 'The above student has completed all the requirements of the 4 semesters programme and eligible for Masters Degree.'
                    ELSE
                        IF GradeCountTotal = 0 THEN
                            Text1 := 'The above student has to complete ' + FORMAT(4 - DurationCourse) + ' more semester(s) of the 4 semesters programme to be awarded for his/her for Masters Degree'
                        ELSE
                            Text1 := 'The above student has to complete ' + FORMAT(GradeCountTotal) + ' more semester(s) of the 4 semesters programme to be awarded for his/her for Masters Degree';


            end;

            trigger OnPreDataItem()
            begin
                DurationCourse := 0;

                SemGrade1 := '';
                SemGrade2 := '';
                SemGrade3 := '';
                SemGrade4 := '';
                SemGrade5 := '';
                SemGrade6 := '';
                SemGrade7 := '';
                SemGrade8 := '';
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
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
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
        DurationCourse: Integer;
        Text1: Text[250];
        Text2: Text[250];

        SemGrade1: Code[20];
        SemGrade2: Code[20];
        SemGrade3: Code[20];
        SemGrade4: Code[20];
        SemGrade5: Code[20];
        SemGrade6: Code[20];
        SemGrade7: Code[20];
        SemGrade8: Code[20];
        GradeCount: Integer;
        GradeCount1: Integer;
        GradeCount2: Integer;
        GradeCountTotal: Integer;
}

