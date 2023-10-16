report 50064 "Detained Student ListCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Detained Student ListCS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Detained Student List';
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = WHERE(Detained = FILTER(false));
            RequestFilterFields = Course, Semester, "Academic Year", "Subject Code", Section;
            column(GETFILTERS; "External Attendance Line-CS".GETFILTERS())
            {
            }
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(Course_Line; "External Attendance Line-CS".Course)
            {
            }
            column(CourseCode; CourseCode)
            {
            }
            column(SubjectCode_Line; "External Attendance Line-CS"."Subject Code")
            {
            }
            column(RollNo_StudExternalAttendLine; "External Attendance Line-CS"."Roll No.")
            {
            }
            column(SubjectDesc; SubjectDesc)
            {
            }
            column(StudentNo_Line; "External Attendance Line-CS"."Student No.")
            {
            }
            column(EnrollmentNo_Line; "External Attendance Line-CS"."Enrollment No.")
            {
            }
            column(StudentName_Line; "External Attendance Line-CS"."Student Name")
            {
            }
            column(Semester_Line; "External Attendance Line-CS".Semester)
            {
            }
            column(AcademicYear_Line; "External Attendance Line-CS"."Academic Year")
            {
            }
            column(Detained_Line; "External Attendance Line-CS".Detained)
            {
            }
            column(Section_StudExternalAttendLine; "External Attendance Line-CS".Section)
            {
            }
            column(Attendance_StudExternalAttendLine; "External Attendance Line-CS"."Attendance %")
            {
            }
            column(EvenOdd; EvenOdd)
            {
            }
            column(Newstring; Newstring)
            {
            }
            column(AdYear; AdYear)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SrNo += 1;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "External Attendance Line-CS"."Enrollment No.");
                IF StudentMasterCS.findfirst() THEN
                    CourseCode := StudentMasterCS."Course Code";

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
                SrNo := 0;
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
        SubjectMasterCS: Record "Subject Master-CS";
        DimensionValue: Record "Dimension Value";
        StudentMasterCS: Record "Student Master-CS";
        SubjectDesc: Text[200];
        EvenOdd: Text[30];
        Newstring: Code[20];
        AdYear: Code[10];
        SrNo: Integer;
        CourseCode: Code[20];
}

