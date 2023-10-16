report 50045 "Provisional Transcript Sem CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Provisional Transcript Sem CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Provisional Transcript Semester';
    dataset
    {
        dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
        {
            DataItemTableView = SORTING("Subject Class")
                                ORDER(Descending);
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Student No.", "Actual Semester", "Enrollment No";
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(Name1; Name1)
            {
            }
            column(Sem1; Sem1)
            {
            }
            column(Year2; Year2)
            {
            }
            column(Year1; Year1)
            {
            }
            column(AdYear; AdYear)
            {
            }
            column(SubjectClass_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Subject Class")
            {
            }
            column(Semester_StudentSubjectCOLLEGE; "Main Student Subject-CS".Semester)
            {
            }
            column(TypeOfCourse_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Type Of Course")
            {
            }
            column(AcademicYear_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Academic Year")
            {
            }
            column(ActualAcademicYear_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Actual Academic Year")
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
            column(SubjectCode_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Subject Code")
            {
            }
            column(ActualSubjectCode_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Actual Subject Code")
            {
            }
            column(ActualSubjectDescription_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Actual Subject Description")
            {
            }
            column(SubjectType_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Subject Type")
            {
            }
            column(Description_StudentSubjectCOLLEGE; "Main Student Subject-CS".Description)
            {
            }
            column(Grade_StudentSubjectCOLLEGE; "Main Student Subject-CS".Grade)
            {
            }
            column(Credit_StudentSubjectCOLLEGE; "Main Student Subject-CS".Credit)
            {
            }
            column(AttendancePercentage_StudentSubjectCOLLEGE; "Main Student Subject-CS"."Attendance Percentage")
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(EvenOdd; EvenOdd)
            {
            }
            column(Heading; Heading)
            {
            }
            column(Newstring1; Newstring1)
            {
            }
            column(EvenOdd1; EvenOdd1)
            {
            }
            column(AdYear1; AdYear1)
            {
            }
            column(SubCode1; SubCode1)
            {
            }
            column(GPA; GPA)
            {
            }
            column(GradeNew; GradeNew)
            {
            }
            column(GradeNew2; GradeNew2)
            {
            }
            column(Count1; Count1)
            {
            }
            column(Attend; Attend)
            {
            }
            column(Text1; Text1)
            {
            }
            column(CGPA1; CGPA1)
            {
            }
            column(Text2; Text2)
            {
            }
            column(Desc1; Desc1)
            {
            }
            dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
            {
                DataItemLink = "Actual Semester" = FIELD("Actual Semester"),
                               "Student No." = FIELD("Student No.");
                DataItemTableView = SORTING("Student No.", Course, Semester, "Academic Year", "Subject Code", Section)
                                    WHERE("Program/Open Elective Temp" = FILTER(' '));
                PrintOnlyIfDetail = false;
                UseTemporary = false;
                column(Count2; Count2)
                {
                }
                column(Attend1; Attend1)
                {
                }
                column(SubjectClass_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Subject Class")
                {
                }
                column(StudentNo_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Student No.")
                {
                }
                column(SubjectCode; "Optional Student Subject-CS"."Actual Subject Code")
                {
                }
                column(ActualSubjectDescription_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Actual Subject Description")
                {
                }
                column(SubjectType_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Subject Type")
                {
                }
                column(Description_StudentOptionalSubjectCOL; "Optional Student Subject-CS".Description)
                {
                }
                column(ActualAcademicYear_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Actual Academic Year")
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
                column(AcademicYear_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Academic Year")
                {
                }
                column(Newstring2; Newstring2)
                {
                }
                column(AdYear2; AdYear2)
                {
                }
                column(SubCode2; SubCode2)
                {
                }
                column(GradeNew1; GradeNew1)
                {
                }
                column(GradeNew3; GradeNew3)
                {
                }
                column(EDesc1; EDesc1)
                {
                }
                column(EEvenOdd1; EEvenOdd1)
                {
                }
                column(EAdYear1; EAdYear1)
                {
                }

                trigger OnAfterGetRecord()
                begin
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

                    GradeNew3 += "Optional Student Subject-CS".Credit;
                    Attend1 += "Optional Student Subject-CS"."Attendance Percentage";
                    IF SubjectCode1 <> "Optional Student Subject-CS"."Subject Code" THEN
                        Count2 += 1;
                    SubjectCode1 := "Optional Student Subject-CS"."Subject Code";
                end;

                trigger OnPreDataItem()
                begin
                    GradeNew3 := 0;
                    SubjectCode1 := '';
                    Count2 := 0;
                    Attend1 := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Main Student Subject-CS"."Student No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    Name1 := StudentMasterCS."Name as on Certificate";
                    StudentMasterCS.CALCFIELDS("Course Type");
                    IF StudentMasterCS."Degree Code" = 'M.Tech.' THEN
                        Year2 := 'MASTER OF TECHNOLOGY';

                    IF StudentMasterCS."Degree Code" = 'MCA' THEN
                        Year2 := 'MASTER OF COMPUTER APPLICATIONS'
                    ELSE
                        Year2 := 'BACHELOR OF TECHNOLOGY';


                    IF "Main Student Subject-CS"."Actual Semester" = 'I' THEN BEGIN
                        GPA := StudentMasterCS."Semester I GPA";
                        GradeNew := StudentMasterCS."Semester I Credit Earned";
                    END;

                    IF "Main Student Subject-CS"."Actual Semester" = 'II' THEN BEGIN
                        GPA := StudentMasterCS."Semester II GPA";
                        GradeNew := StudentMasterCS."Semester II Credit Earned";
                    END;

                    IF ("Main Student Subject-CS"."Actual Semester" = 'III') OR ("Main Student Subject-CS"."Actual Semester" = 'III & IV') THEN BEGIN
                        GPA := StudentMasterCS."Semester III GPA";
                        GradeNew := StudentMasterCS."Semester III Credit Earned";
                    END;

                    IF "Main Student Subject-CS"."Actual Semester" = 'IV' THEN BEGIN
                        GPA := StudentMasterCS."Semester IV GPA";
                        GradeNew := StudentMasterCS."Semester IV Credit Earned";
                    END;

                    IF "Main Student Subject-CS"."Actual Semester" = 'V' THEN BEGIN
                        GPA := StudentMasterCS."Semester V GPA";
                        GradeNew := StudentMasterCS."Semester V Credit Earned";
                    END;

                    IF "Main Student Subject-CS"."Actual Semester" = 'VI' THEN BEGIN
                        GPA := StudentMasterCS."Semester VI GPA";
                        GradeNew := StudentMasterCS."Semester VI Credit Earned";
                    END;

                    IF "Main Student Subject-CS"."Actual Semester" = 'VII' THEN BEGIN
                        GPA := StudentMasterCS."Semester VII GPA";
                        GradeNew := StudentMasterCS."Semester VII Credit Earned";
                    END;

                    IF "Main Student Subject-CS"."Actual Semester" = 'VIII' THEN BEGIN
                        GPA := StudentMasterCS."Semester VIII GPA";
                        GradeNew := StudentMasterCS."Semester VIII Credit Earned";
                    END;
                END;

                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.findfirst() THEN
                    CourseDesc := CourseMasterCS.Description;

                AdYear1 := '';
                SubCode1 := '';
                Newstring1 := '';

                IF ("Main Student Subject-CS"."Actual Semester" = 'II') OR ("Main Student Subject-CS"."Actual Semester" = 'IV') OR ("Main Student Subject-CS"."Actual Semester" = 'VI') OR ("Main Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                    EvenOdd1 := 'JAN-MAY';
                    Newstring1 := "Main Student Subject-CS"."Academic Year";
                    AdYear1 := COPYSTR(Newstring1, 6, 9);
                END ELSE BEGIN
                    EvenOdd1 := 'JUL-NOV';
                    Newstring1 := "Main Student Subject-CS"."Academic Year";
                    AdYear1 := COPYSTR(Newstring1, 1, 4);
                END;

                GradeNew2 += "Main Student Subject-CS".Credit;
                Attend += "Main Student Subject-CS"."Attendance Percentage";
                IF SubjectCode <> "Main Student Subject-CS"."Actual Subject Code" THEN
                    Count1 += 1;
                SubjectCode := "Main Student Subject-CS"."Actual Subject Code";
            end;

            trigger OnPreDataItem()
            begin
                GradeNew2 := 0;
                SubjectCode := '';
                Count1 := 0;
                Attend := 0;


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
        CourseMasterCS: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        DimensionValue: Record "Dimension Value";
        CourseDesc: Text[100];
        EvenOdd: Code[10];
        Year1: Text[30];
        Sem1: Text;
        Year2: Text[150];
        AdYear: Code[10];
        Heading: Text[20];
        Newstring1: Code[20];
        AdYear1: Code[10];
        SubCode1: Code[20];
        Newstring2: Code[20];
        AdYear2: Code[10];
        SubCode2: Code[20];
        Name1: Text[100];
        GPA: Decimal;
        GradeNew: Decimal;
        GradeNew1: Decimal;
        GradeNew2: Decimal;
        GradeNew3: Decimal;
        Count1: Integer;
        Count2: Integer;
        SubjectCode: Code[20];
        SubjectCode1: Code[20];
        Attend: Decimal;
        Attend1: Decimal;
        Text1: Text[250];
        CGPA1: Decimal;
        Text2: Text[50];
        Desc1: Text[100];
        EDesc1: Text[100];

        EEvenOdd1: Code[20];
        EAdYear1: Code[20];
        ENewstring1: Code[20];
        EvenOdd1: Code[20];
}