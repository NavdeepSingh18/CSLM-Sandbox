report 50148 "Seat Allot SecWise(Make-Up)1CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Seat Allot SecWise(Make-Up)1CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = WHERE(Detained = FILTER(false));
            RequestFilterFields = "Subject Code", Section, Course, Semester, "Exam Classification";
            column(RoomAllotedNo_StudExternalAttendLine; "Room Alloted No.")
            {
            }
            column(EnrollmentNo_StudExternalAttendLine; "Enrollment No.")
            {
            }
            column(AcademicYear_StudExternalAttendLine; "Academic Year")
            {
            }
            column(ExamClassification_StudExternalAttendLine; "Exam Classification")
            {
            }
            column(Semester_StudExternalAttendLine; Semester)
            {
            }
            column(Section_StudExternalAttendLine; Section)
            {
            }
            column(SNo; SNo)
            {
            }
            column(ExamDate_StudExternalAttendLine; "Exam Date")
            {
            }
            column(StartTime_StudExternalAttendLine; "Start Time")
            {
            }
            column(EndTime_StudExternalAttendLine; "End Time")
            {
            }
            column(SubjectCode_StudExternalAttendLine; "Subject Code")
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(SubjectDesc; SubjectDesc)
            {
            }
            column(StudentName_StudExternalAttendLine; "Student Name")
            {
            }
            column(RollNo_StudExternalAttendLine; "Roll No.")
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

                /*
                
                  IF "Student - COLLEGE"."Roll No."<>'' THEN BEGIN
                    EVALUATE(VarInteger,"Student - COLLEGE"."Roll No.");
                    RollNo1:=VarInteger;
                END;
                */

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