report 50199 "Student Insurance Validity"
{
    ApplicationArea = All;
    Caption = 'Student Insurance Validity Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'src\reportrdlc\StudentInsuranceValidityReport.rdl';
    UsageCategory = History;
    dataset
    {
        dataitem(StudentMasterCS; "Student Master-CS")
        {
            RequestFilterFields = "No.", "Apply For Insurance", Semester, "Course Code", "Enrollment No.", "Original Student No.", "Academic Year";
            column(OriginalStudentNo; "Original Student No.")
            {
            }
            column(CompName; Companyinform.Name)
            {
            }
            column(CompLogo; Companyinform.Picture)
            {
            }
            column(address; Companyinform.Address)
            {
            }
            column(address2; Companyinform."Address 2")
            {
            }
            column(City; Companyinform."City")
            {
            }
            column(Post_Code; Companyinform."Post Code")
            {
            }
            column(Country_Code; Companyinform."Country/Region Code")
            {
            }
            column(State; Companyinform.County)
            {
            }
            column(Filterstring; Filterstring)
            {
            }
            column(No; "No.")
            {
            }
            column(Status; Status)
            {
            }
            column(EnrollmentNo; "Enrollment No.")
            {
            }
            column(AcademicYear; "Academic Year")
            {
            }
            column(Term; Term)
            {
            }
            column(Semester; Semester)
            {
            }
            column(CurrentSemesterEndDate; "Current Semester End Date")
            {
            }
            column(CurrentSemesterStartDate; "Current Semester Start Date")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(StudentName; "Student Name")
            {
            }
            column(InsuranceValidTo; "Insurance Valid To")
            {
            }
            trigger OnPreDataItem()
            var

            begin
                Companyinform.GET();
                Companyinform.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                CourseSemMasterRec: Record "Course Sem. Master-CS";
            begin
                Filterstring := StudentMasterCS.GetFilters();

                if StudentMasterCS."Insurance Valid To" = 0D then
                    CurrReport.Skip();
                CourseSemMasterRec.reset();
                CourseSemMasterRec.SetRange("Course Code", "Course Code");
                CourseSemMasterRec.SetRange("Semester Code", Semester);
                CourseSemMasterRec.SetRange(Term, Term);
                CourseSemMasterRec.SetRange("Academic Year", "Academic Year");
                CourseSemMasterRec.SetFilter("Start Date", '<=%1', StudentMasterCS."Insurance Valid To");
                CourseSemMasterRec.SetFilter("End Date", '>=%1', StudentMasterCS."Insurance Valid To");
                if NOT CourseSemMasterRec.FindFirst() then begin
                    CurrReport.Skip();
                end;
            end;
        }
    }
    var
        Companyinform: Record "Company Information";
        Filterstring: Text;

}
