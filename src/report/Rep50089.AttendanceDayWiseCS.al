report 50089 "Attendance Day Wise-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Attendance Day Wise-CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Attendance Day Wise';
    dataset
    {
        dataitem("Class Attendance Line-CS"; "Class Attendance Line-CS")
        {
            DataItemTableView = WHERE("Attendance Generated" = FILTER(True));
            RequestFilterFields = "Subject Code", "Course Code", Date, "Academic Year", "Enrollment No.", Semester, Section, "Batch Code";
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(BatchCode_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Batch Code")
            {
            }
            column(SubjectType_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Subject Type")
            {
            }
            column(Section_StudentAttendanceLineCOL; "Class Attendance Line-CS".Section)
            {
            }
            column(Date_StudentAttendanceLineCOL; "Class Attendance Line-CS".Date)
            {
            }
            column(AcademicYear_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Academic Year")
            {
            }
            column(SubjectCode_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Subject Code")
            {
            }
            column(Semester_StudentAttendanceLineCOL; "Class Attendance Line-CS".Semester)
            {
            }
            column(CourseCode_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Course Code")
            {
            }
            column(StudentNo_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Student No.")
            {
            }
            column(EnrollmentNo_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Enrollment No.")
            {
            }
            column(RollNo_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Roll No.")
            {
            }
            column(StudentName_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Student Name")
            {
            }
            column(AttendanceType_StudentAttendanceLineCOL; "Class Attendance Line-CS"."Attendance Type")
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(CompInfo_City; CompInfo.City)
            {
            }
            column(CompInfo_PostCode; CompInfo."Post Code")
            {
            }
            column(CompInfo_PhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfo_FaxNo; CompInfo."Fax No.")
            {
            }
            column(CompInfo_EMail; CompInfo."E-Mail")
            {
            }
            column(CompInfo_HomePage; CompInfo."Home Page")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(GETFILTERS; "Class Attendance Line-CS".GETFILTERS())
            {
            }
            column(Day1; Day1)
            {
            }
            column(SubjectDesc; SubjectDesc)
            {
            }

            trigger OnAfterGetRecord()
            begin
                EducationCalendarEntryCS.Reset();
                EducationCalendarEntryCS.SETRANGE(EducationCalendarEntryCS.Date, "Class Attendance Line-CS".Date);
                IF EducationCalendarEntryCS.findfirst() THEN
                    Day1 := FORMAT(EducationCalendarEntryCS.Day);

                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Class Attendance Line-CS"."Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    SubjectDesc := SubjectMasterCS.Description;
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

    trigger OnPreReport()
    begin
        IF "Class Attendance Line-CS".GETFILTER("Class Attendance Line-CS"."Subject Code") = '' THEN
            ERROR('Please Mandatory a Subject Code Filter.');
    end;

    var
        CompInfo: Record "Company Information";
        EducationCalendarEntryCS: Record "Education Calendar Entry-CS";
        SubjectMasterCS: Record "Subject Master-CS";
        DimensionValue: Record "Dimension Value";
        Day1: Text[20];

        SubjectDesc: Text[100];

}

