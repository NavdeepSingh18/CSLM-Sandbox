report 50084 "Seat Allocation CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Seat Allocation CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Seat Allocation';
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = SORTING("Subject Code", "Room Alloted No.", Section, "Roll No.")
                                WHERE("Room Alloted No." = FILTER(<> ''),
                                      Detained = FILTER(false));
            RequestFilterFields = "Academic Year", "Subject Code", "Exam Date";
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
            column(ExamSlot_StudExternalAttendLine; "External Attendance Line-CS"."Exam Slot")
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
            column(EvenOdd; EvenOdd)
            {
            }
            column(AdYear; AdYear)
            {
            }
            column(RollNo1; RollNo1)
            {
            }
            column(RoomNum; RoomNum)
            {
            }
            column(SNo1; SNo1)
            {
            }
            column(OldRoom; OldRoom)
            {
            }
            column(ABC; ABC)
            {
            }
            column(Sem; Sem)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;

                IF OldRoom <> "External Attendance Line-CS"."Room Alloted No." THEN
                    SNo1 := 0;
                SNo1 += 1;
                OldRoom := "External Attendance Line-CS"."Room Alloted No.";

                IF ("External Attendance Line-CS"."Program" = 'UG') AND ("External Attendance Line-CS".Year = '1ST') THEN
                    ABC := 'First Year Common'
                ELSE BEGIN
                    Sem := "External Attendance Line-CS".Semester;
                    CourseMasterCS.Reset();
                    CourseMasterCS.SETRANGE(CourseMasterCS.Code, "External Attendance Line-CS".Course);
                    IF CourseMasterCS.findfirst() THEN
                        CourseDesc := CourseMasterCS.Description;
                END;


                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "External Attendance Line-CS"."Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    SubjectDesc := SubjectMasterCS.Description;

                IF ("External Attendance Line-CS".Semester = 'II') OR ("External Attendance Line-CS".Semester = 'IV') OR ("External Attendance Line-CS".Semester = 'VI') OR ("External Attendance Line-CS".Semester = 'VIII') THEN BEGIN
                    EvenOdd := 'Jan-May';
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
        CourseDesc: Text;
        SubjectDesc: Text;
        SNo: Integer;
        EvenOdd: Text[30];
        Newstring: Code[20];
        AdYear: Code[20];
        RollNo1: Integer;
        RoomNum: Code[20];
        SNo1: Integer;
        OldRoom: Code[20];
        ABC: Text[50];
        Sem: Code[10];
}

