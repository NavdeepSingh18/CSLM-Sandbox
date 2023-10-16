report 50051 "Invigilator Regular-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Invigilator Regular-CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Invigilator Regular';
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = SORTING("Subject Code", "Room Alloted No.", "Section", "Roll No.")
                                WHERE("Room Alloted No." = FILTER(<> ''),
                                      "Exam Classification" = FILTER('REGULAR'),
                                      Detained = FILTER(false));
            RequestFilterFields = "Academic Year", "Subject Code", "Exam Date";
            column(ExamClassification_StudExternalAttendLine; "External Attendance Line-CS"."Exam Classification")
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
            column(RoomAllotedNo_StudExternalAttendLine; "External Attendance Line-CS"."Room Alloted No.")
            {
            }
            column(StudentNo_StudExternalAttendLine; "External Attendance Line-CS"."Student No.")
            {
            }
            column(EnrollmentNo_StudExternalAttendLine; "External Attendance Line-CS"."Enrollment No.")
            {
            }
            column(StudentName_StudExternalAttendLine; "External Attendance Line-CS"."Student Name")
            {
            }
            column(AcademicYear_StudExternalAttendLine; "External Attendance Line-CS"."Academic Year")
            {
            }
            column(Semester_StudExternalAttendLine; "External Attendance Line-CS".Semester)
            {
            }
            column(AttendanceType_StudExternalAttendLine; "External Attendance Line-CS"."Attendance Type")
            {
            }
            column(Invigilator1_StudExternalAttendLine; "External Attendance Line-CS"."Invigilator 1")
            {
            }
            column(Invigilator2_StudExternalAttendLine; "External Attendance Line-CS"."Invigilator 2")
            {
            }
            column(Invigilator3_StudExternalAttendLine; "External Attendance Line-CS"."Invigilator 3")
            {
            }
            column(Invigilator4_StudExternalAttendLine; "External Attendance Line-CS"."Invigilator 4")
            {
            }
            column(Course_StudExternalAttendLine; "External Attendance Line-CS".Course)
            {
            }
            column(SubjectCode_StudExternalAttendLine; "External Attendance Line-CS"."Subject Code")
            {
            }
            column(ExamSlot_StudExternalAttendLine; "External Attendance Line-CS"."Exam Slot")
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(SubjectDesc; SubjectDesc)
            {
            }
            column(TypeOfCourse_StudExternalAttendLine; "External Attendance Line-CS"."Type Of Course")
            {
            }
            column(SNo; SNo)
            {
            }
            column(Type; Type)
            {
            }
            column(Room1; Room1)
            {
            }
            column(EvenOdd; EvenOdd)
            {
            }
            column(AdYear; AdYear)
            {
            }
            column(SNo1; SNo1)
            {
            }
            column(OldRoom; OldRoom)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(EmployeeName2; EmployeeName2)
            {
            }
            column(EmployeeName3; EmployeeName3)
            {
            }
            column(EmployeeName4; EmployeeName4)
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

                CourseTypeMasterCS.Reset();
                CourseTypeMasterCS.SETRANGE(CourseTypeMasterCS."Course Code", "External Attendance Line-CS".Course);
                IF CourseTypeMasterCS.findfirst() THEN
                    Type := CourseTypeMasterCS."Course Type";

                IF ("External Attendance Line-CS".Semester = 'II') OR ("External Attendance Line-CS".Semester = 'IV') OR ("External Attendance Line-CS".Semester = 'VI') OR ("External Attendance Line-CS".Semester = 'VIII') THEN BEGIN
                    EvenOdd := 'Jan-May';
                    Newstring := "External Attendance Line-CS"."Academic Year";
                    AdYear := COPYSTR(Newstring, 6, 9);
                END ELSE BEGIN
                    EvenOdd := 'Jul-Nov';
                    Newstring := "External Attendance Line-CS"."Academic Year";
                    AdYear := COPYSTR(Newstring, 1, 4);
                END;

                Employee.Reset();
                Employee.SETRANGE("No.", "External Attendance Line-CS"."Invigilator 1");
                IF Employee.findfirst() THEN
                    EmployeeName := Employee."First Name";

                Employee.Reset();
                Employee.SETRANGE("No.", "External Attendance Line-CS"."Invigilator 2");
                IF Employee.findfirst() THEN
                    EmployeeName2 := Employee."First Name";

                Employee.Reset();
                Employee.SETRANGE("No.", "External Attendance Line-CS"."Invigilator 3");
                IF Employee.findfirst() THEN
                    EmployeeName3 := Employee."First Name";

                Employee.Reset();
                Employee.SETRANGE("No.", "External Attendance Line-CS"."Invigilator 4");
                IF Employee.findfirst() THEN
                    EmployeeName4 := Employee."First Name";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET();
                CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
                SNo := 0;
                OldRoom := '';
                Invigilator1 := '';
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
        CompanyInformation: Record "Company Information";
        CourseMasterCS: Record "Course Master-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        CourseTypeMasterCS: Record "Course Type Master-CS";
        Employee: Record "Employee";
        CourseDesc: Text;

        SubjectDesc: Text;
        SNo: Integer;

        Type: Text;

        Room1: Code[30];

        EvenOdd: Text[30];
        Newstring: Code[20];
        AdYear: Code[20];
        SNo1: Integer;
        OldRoom: Code[30];
        EmployeeName: Text[100];
        EmployeeName2: Text[100];
        EmployeeName3: Text[100];
        EmployeeName4: Text[100];
        Sem: Code[10];
        ABC: Text[50];
        Invigilator1: Code[20];
}

