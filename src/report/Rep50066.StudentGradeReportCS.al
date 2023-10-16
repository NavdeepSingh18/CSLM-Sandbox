report 50066 "Student Grade Report-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Grade Report-CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Student Grade Report';
    dataset
    {
        dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
        {
            DataItemTableView = SORTING("Enrollment No")
                                ORDER(Ascending);
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Actual Semester", "Actual Academic Year", "Enrollment No", Course, Graduation, Completed;
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
            column(SubjectClass_MainStudentSubjectCS; "Main Student Subject-CS"."Subject Class")
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
            column(Newstring1; Newstring1)
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
            column(Heading1; Heading1)
            {
            }
            column(Rem1; Rem1)
            {
            }
            column(Text3; Text3)
            {
            }
            column(Text4; Text4)
            {
            }
            dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Actual Semester" = FIELD("Actual Semester"),
                               Completed = FIELD(Completed);
                DataItemTableView = WHERE("Program/Open Elective Temp" = FILTER(' '));
                PrintOnlyIfDetail = false;
                UseTemporary = false;
                column(Heading; Heading)
                {
                }
                column(Rem; Rem)
                {
                }
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
                column(SubjectCode_StudentOptionalSubjectCOL; "Optional Student Subject-CS"."Subject Code")
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

                trigger OnAfterGetRecord()
                begin
                    IF Enroll1 <> "Optional Student Subject-CS"."Enrollment No" THEN BEGIN
                        GradeNew3 := 0;
                        Attend1 := 0;
                        Heading := '';
                        Rem := '';
                        Count2 := 0;
                    END;
                    Enroll1 := "Optional Student Subject-CS"."Enrollment No";
                    GradeNew3 += "Optional Student Subject-CS".Credit;
                    Attend1 += "Optional Student Subject-CS"."Attendance Percentage";
                    IF SubjectCode1 <> "Optional Student Subject-CS"."Actual Subject Code" THEN
                        Count2 += 1;
                    SubjectCode1 := "Optional Student Subject-CS"."Actual Subject Code";

                    AdYear2 := '';
                    SubCode2 := '';
                    Newstring2 := '';

                    IF "Optional Student Subject-CS"."Academic Year" <> "Optional Student Subject-CS"."Actual Academic Year" THEN BEGIN
                        Heading := '(Revised)';
                        Rem := 'Remark';
                        IF ("Optional Student Subject-CS"."Actual Semester" = 'II') OR ("Optional Student Subject-CS"."Actual Semester" = 'IV') OR ("Optional Student Subject-CS"."Actual Semester" = 'VI') OR
                          ("Optional Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                            EvenOdd := 'Jan-Jun';
                            Newstring2 := "Optional Student Subject-CS"."Academic Year";
                            AdYear2 := COPYSTR(Newstring2, 6, 9);
                            SubCode2 := "Optional Student Subject-CS"."Actual Subject Code";
                        END ELSE BEGIN
                            EvenOdd := 'Jul-Nov';
                            Newstring2 := "Optional Student Subject-CS"."Academic Year";
                            AdYear2 := COPYSTR(Newstring2, 1, 4);
                            SubCode2 := "Optional Student Subject-CS"."Actual Subject Code";
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    GradeNew3 := 0;
                    SubjectCode1 := '';
                    Count2 := 0;
                    Attend1 := 0;
                    Enroll1 := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Main Student Subject-CS"."Student No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    Name1 := StudentMasterCS."Name as on Certificate";
                    StudentMasterCS.CALCFIELDS("Course Type");
                    IF StudentMasterCS."Degree Code" = 'M.Tech.' THEN //- Field type change
                        Year2 := 'MASTER OF TECHNOLOGY';

                    IF StudentMasterCS."Degree Code" = 'MCA' THEN
                        Year2 := 'MASTER OF COMPUTER APPLICATIONS'
                    ELSE
                        Year2 := 'BACHELOR OF TECHNOLOGY';

                    //- Field type change
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

                SemesterMasterCS.Reset();
                SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, "Main Student Subject-CS"."Actual Semester");
                IF SemesterMasterCS.findfirst() THEN
                    Sem1 := SemesterMasterCS.Description;
                CASE Sem1 OF
                    '1st Sem':
                        Sem1 := 'FIRST';
                    '2nd Sem':
                        Sem1 := 'SECOND';
                    '3rd Sem':
                        Sem1 := 'THIRD';
                    '3rd & 4th Sem':
                        Sem1 := 'THIRD';
                    '4th Sem':
                        Sem1 := 'FOURTH';
                    '5th Sem':
                        Sem1 := 'FIFTH';
                    '6th Sem':
                        Sem1 := 'SIXTH';
                    '7th Sem':
                        Sem1 := 'SEVENTH';
                    '8th Sem':
                        Sem1 := 'EIGHTH';
                    ELSE
                        Sem1 := ' ';
                END;

                IF (StudentMasterCS."Degree Code" = 'M.Tech.') AND (Sem1 = 'THIRD') THEN//- Field type change
                    Sem1 := 'THIRD AND FOURTH';

                IF (StudentMasterCS."Degree Code" = 'B.Tech.') AND (Sem1 = 'EIGHTH') AND (StudentMasterCS."Lateral Student" = TRUE) THEN
                    Text1 := 'Note: CGPA from III to VIII Semester. This student is admitted to III semester under lateral entry scheme (As per G.O.No.23,TGK.96 dated 22.09.2001, Government of karnataka)';


                IF (StudentMasterCS."Degree Code" = 'B.Tech.') AND ("Main Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                    CGPA1 := StudentMasterCS."Net Semester CGPA";
                    Text2 := 'Cumulative Grade Point Average';
                END;

                IF (StudentMasterCS."Degree Code" = 'M.Tech.') AND ("Main Student Subject-CS"."Actual Semester" = 'III & IV') THEN BEGIN
                    CGPA1 := StudentMasterCS."Net Semester CGPA";
                    Text2 := 'Cumulative Grade Point Average';
                END;

                IF (StudentMasterCS."Degree Code" = 'MCA') AND ("Main Student Subject-CS"."Actual Semester" = 'IV') THEN BEGIN
                    CGPA1 := StudentMasterCS."Net Semester CGPA";
                    Text2 := 'Cumulative Grade Point Average';
                END;

                IF ("Main Student Subject-CS"."Actual Semester" = 'II') OR ("Main Student Subject-CS"."Actual Semester" = 'IV') OR ("Main Student Subject-CS"."Actual Semester" = 'VI') OR ("Main Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                    EvenOdd := 'Jan-May';
                    Newstring := "Main Student Subject-CS"."Actual Academic Year";
                    AdYear := COPYSTR(Newstring, 6, 9);
                END ELSE BEGIN
                    EvenOdd := 'Jul-Nov';
                    Newstring := "Main Student Subject-CS"."Actual Academic Year";
                    AdYear := COPYSTR(Newstring, 1, 4);
                END;

                IF (StudentMasterCS."Degree Code" = 'B.Tech.') AND ("Main Student Subject-CS"."Actual Semester" = 'I') OR ("Main Student Subject-CS"."Actual Semester" = 'II') THEN
                    CourseDesc := 'Common TO all branches'
                ELSE BEGIN
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", "Main Student Subject-CS"."Student No.");
                    IF StudentMasterCS.findfirst() THEN
                        CourseDesc := StudentMasterCS."Course Name";
                END;//- Field type change

                IF Enroll <> "Main Student Subject-CS"."Enrollment No" THEN BEGIN
                    GradeNew2 := 0;
                    Attend := 0;
                    Heading1 := '';
                    Rem1 := '';
                    Count1 := 0;
                END;
                Enroll := "Main Student Subject-CS"."Enrollment No";
                GradeNew2 += "Main Student Subject-CS".Credit;
                Attend += "Main Student Subject-CS"."Attendance Percentage";
                IF SubjectCode <> "Main Student Subject-CS"."Actual Subject Code" THEN
                    Count1 += 1;

                SubjectCode := "Main Student Subject-CS"."Actual Subject Code";

                AdYear1 := '';
                SubCode1 := '';
                Newstring1 := '';

                IF "Main Student Subject-CS"."Academic Year" <> "Main Student Subject-CS"."Actual Academic Year" THEN BEGIN
                    IF ("Main Student Subject-CS"."Actual Semester" = 'II') OR ("Main Student Subject-CS"."Actual Semester" = 'IV') OR ("Main Student Subject-CS"."Actual Semester" = 'VI') OR ("Main Student Subject-CS"."Actual Semester" = 'VIII') THEN BEGIN
                        EvenOdd := 'Jan-May';
                        Newstring1 := "Main Student Subject-CS"."Academic Year";
                        AdYear1 := COPYSTR(Newstring1, 6, 9);
                        SubCode1 := "Main Student Subject-CS"."Actual Subject Code";
                    END ELSE BEGIN
                        EvenOdd := 'Jul-Nov';
                        Newstring1 := "Main Student Subject-CS"."Academic Year";
                        AdYear1 := COPYSTR(Newstring1, 1, 4);
                        SubCode1 := "Main Student Subject-CS"."Actual Subject Code";
                    END;
                    Heading1 := '(Revised)';
                    Rem1 := 'Remark';
                END;


                SpecilizationValue := '';
                SpecilizationCount := 0;
                SpecilizationCount1 := 0;
                TotalCount := 0;
                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETCURRENTKEY(OptionalStudentSubjectCS.Specilization);
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", "Student No.");
                OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Grade, '%1|%2|%3|%4|%5|%6', 'A+', 'A', 'B', 'C', 'D', 'E');
                OptionalStudentSubjectCS.SETFILTER(OptionalStudentSubjectCS.Specilization, '<>%1', '');
                IF OptionalStudentSubjectCS.findfirst() THEN BEGIN
                    SpecilizationValue := OptionalStudentSubjectCS.Specilization;
                    OptionalStudentSubjectCS1.Reset();
                    OptionalStudentSubjectCS1.SETCURRENTKEY(OptionalStudentSubjectCS1.Specilization);
                    OptionalStudentSubjectCS1.SETRANGE(OptionalStudentSubjectCS1."Student No.", "Student No.");
                    OptionalStudentSubjectCS1.SETFILTER(OptionalStudentSubjectCS1.Grade, '%1|%2|%3|%4|%5|%6', 'A+', 'A', 'B', 'C', 'D', 'E');
                    OptionalStudentSubjectCS1.SETFILTER(OptionalStudentSubjectCS1.Specilization, '<>%1', '');
                    IF OptionalStudentSubjectCS1.findset() THEN
                        REPEAT
                            IF TotalCount < 4 THEN
                                IF SpecilizationValue = OptionalStudentSubjectCS1.Specilization THEN BEGIN
                                    IF SpecilizationCount < 5 THEN
                                        SpecilizationCount += 1;
                                END ELSE BEGIN
                                    SpecilizationCount := 0;
                                    SpecilizationCount1 := 0;
                                    SpecilizationCount1 += 1;
                                END;
                            SpecilizationValue := OptionalStudentSubjectCS1.Specilization;
                            TotalCount := SpecilizationCount + SpecilizationCount1;
                        UNTIL OptionalStudentSubjectCS1.NEXT() = 0;
                END;

                IF ("Main Student Subject-CS"."Actual Semester" = 'VIII') AND (TotalCount = 4) THEN BEGIN
                    Text3 := 'minor specialization :';
                    Text4 := SpecilizationValue;
                END;
            end;

            trigger OnPreDataItem()
            begin
                GradeNew2 := 0;
                SubjectCode := '';
                Count1 := 0;
                Attend := 0;
                Enroll := '';

                "Main Student Subject-CS".SETCURRENTKEY("Main Student Subject-CS"."Enrollment No");
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

    trigger OnPostReport()
    begin

        MESSAGE('Student Grade Printed Successfully !!');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        SemesterMasterCS: Record "Semester Master-CS";
        OptionalStudentSubjectCS1: Record "Optional Student Subject-CS";

        CourseDesc: Text[100];
        EvenOdd: Code[10];
        Year1: Text[30];


        Sem1: Text;
        Year2: Text[150];
        AdYear: Code[10];
        Newstring: Code[20];
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

        Heading1: Text[20];
        Enroll: Code[20];
        Enroll1: Code[20];
        Rem1: Text[10];
        Rem: Text[10];
        SpecilizationCount: Integer;
        SpecilizationValue: Code[100];
        SpecilizationCount1: Integer;

        TotalCount: Integer;
        Text3: Text[100];

        Text4: Code[100];
}

