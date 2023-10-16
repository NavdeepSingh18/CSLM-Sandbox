report 50077 "Provisional Pass Certificate"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Provisional Pass Certificate.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            RequestFilterFields = "Enrollment No.", "Course Code", Semester;
            column(NameasonCertificate_StudentMasterCS; "Name as on Certificate")
            {
            }
            column(EnrollmentNo_StudentMasterCS; "Enrollment No.")
            {
            }
            column(CourseType_StudentMasterCS; "Course Type")
            {
            }
            column(CourseName_StudentMasterCS; "Course Name")
            {
            }
            column(DateofLeaving_StudentMasterCS; FORMAT("Date of Leaving"))
            {
            }
            column(NetSemesterCGPA_StudentMasterCS; "Net Semester CGPA")
            {
            }
            column(OutputDate; OutputDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Student Master-CS"."Date of Leaving" <> 0D THEN BEGIN
                    InputDate := "Student Master-CS"."Date of Leaving";
                    Day1 := DATE2DMY(InputDate, 1);
                    Month1 := DATE2DMY(InputDate, 2);
                    Year1 := DATE2DMY(InputDate, 3);

                    IF Month1 = 1 THEN
                        OutputDate := 'January' + ' ' + FORMAT(Year1);
                    IF Month1 = 2 THEN
                        OutputDate := 'February ' + ' ' + FORMAT(Year1);
                    IF Month1 = 3 THEN
                        OutputDate := 'March' + ' ' + FORMAT(Year1);
                    IF Month1 = 4 THEN
                        OutputDate := 'April' + ' ' + FORMAT(Year1);
                    IF Month1 = 5 THEN
                        OutputDate := 'May' + ' ' + FORMAT(Year1);
                    IF Month1 = 6 THEN
                        OutputDate := 'June' + ' ' + FORMAT(Year1);
                    IF Month1 = 7 THEN
                        OutputDate := 'July' + ' ' + FORMAT(Year1);
                    IF Month1 = 8 THEN
                        OutputDate := 'August' + ' ' + FORMAT(Year1);
                    IF Month1 = 9 THEN
                        OutputDate := 'September' + ' ' + FORMAT(Year1);
                    IF Month1 = 10 THEN
                        OutputDate := 'October' + ' ' + FORMAT(Year1);
                    IF Month1 = 11 THEN
                        OutputDate := 'November' + ' ' + FORMAT(Year1);
                    IF Month1 = 12 THEN
                        OutputDate := 'December' + ' ' + FORMAT(Year1);
                END;
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
        InputDate: Date;
        Day1: Integer;
        Month1: Integer;
        Year1: Integer;
        OutputDate: Code[50];
}

