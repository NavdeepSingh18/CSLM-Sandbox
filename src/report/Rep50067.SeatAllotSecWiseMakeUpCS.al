report 50067 "Seat Allot Sec Wise MakeUp CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Seat Allot Sec Wise MakeUp CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    PreviewMode = PrintLayout;
    Caption='Seat Allot Sec Wise MakeUp';

    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = SORTING("Enrollment No.")
                                WHERE(Detained = FILTER(false));
            RequestFilterFields = "Subject Code", Section, Course, Semester, "Exam Classification";
            column(RoomAllotedNo_StudExternalAttendLine; "External Attendance Line-CS"."Room Alloted No.")
            {
            }
            column(EnrollmentNo_StudExternalAttendLine; "External Attendance Line-CS"."Enrollment No.")
            {
            }
            column(AcademicYear_StudExternalAttendLine; "External Attendance Line-CS"."Academic Year")
            {
            }
            column(ExamClassification_StudExternalAttendLine; "External Attendance Line-CS"."Exam Classification")
            {
            }
            column(Semester_StudExternalAttendLine; "External Attendance Line-CS".Semester)
            {
            }
            column(Section_StudExternalAttendLine; "External Attendance Line-CS".Section)
            {
            }
            column(SNo; SNo)
            {
            }
            column(ExamDate_StudExternalAttendLine; "External Attendance Line-CS"."Exam Date")
            {
            }
            column(StartTime_StudExternalAttendLine; "External Attendance Line-CS"."Start Time")
            {
            }
            column(EndTime_StudExternalAttendLine; "External Attendance Line-CS"."End Time")
            {
            }
            column(SubjectCode_StudExternalAttendLine; "External Attendance Line-CS"."Subject Code")
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(SubjectDesc; SubjectDesc)
            {
            }
            column(StudentName_StudExternalAttendLine; "External Attendance Line-CS"."Student Name")
            {
            }
            column(RollNo_StudExternalAttendLine; "External Attendance Line-CS"."Roll No.")
            {
            }
            column(RollNo1; RollNo1)
            {
            }
            column(EvenOdd; EvenOdd)
            {
            }
            column(AdYear; AdYear)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;

                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "External Attendance Line-CS".Course);
                IF CourseMasterCS.findfirst() THEN
                    CourseDesc := CourseMasterCS.Description;

                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "External Attendance Line-CS"."Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    SubjectDesc := SubjectMasterCS.Description;

                IF ("External Attendance Line-CS".Semester = 'II') OR ("External Attendance Line-CS".Semester = 'IV') OR ("External Attendance Line-CS".Semester = 'VI') OR ("External Attendance Line-CS".Semester = 'VIII') THEN BEGIN
                    EvenOdd := 'Jan-Jun';
                    Newstring := "External Attendance Line-CS"."Academic Year";
                    AdYear := COPYSTR(Newstring, 6, 9);
                END ELSE BEGIN
                    EvenOdd := 'Jul-Nov';
                    Newstring := "External Attendance Line-CS"."Academic Year";
                    AdYear := COPYSTR(Newstring, 1, 4);
                END;
            end;

            trigger OnPreDataItem()
            begin
                SNo := 0;
                OldRoom := '';
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
        SubjectMasterCS: Record "Subject Master-CS";
        SNo: Integer;
        CourseDesc: Text;

        SubjectDesc: Text;
        EvenOdd: Text[30];
        Newstring: Code[20];
        AdYear: Code[20];
        RollNo1: Integer;
        OldRoom: Code[20];
}

