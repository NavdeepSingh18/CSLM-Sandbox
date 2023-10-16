report 50248 "On Ground Students AICASA"
{
    ApplicationArea = All;
    Caption = 'On Ground Check In Completed Students AICASA';
    DefaultLayout = RDLC;
    RDLCLayout = 'src\reportrdlc\OnGroundCheckInStudentsAICASA.rdl';
    UsageCategory = History;
    dataset
    {
        dataitem(StudentMasterCS; "Student Master-CS")

        {
            //DataItemTableView = WHERE("Global Dimension 1 Code" = filter(9001), "Student Group" = Filter("On-Ground Check-In Completed"));
            RequestFilterFields = "No.", Term, Semester, "Course Code", "Enrollment No.", "Original Student No.", "Academic Year";
            column(OriginalStudentNo; "Original Student No.")
            {
            }
            column(Student_Group; "Student Group")
            {

            }
            column(CompName; Companyinform.Name)
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            { }
            column(Course_Code; "Course Code")
            {
            }
            column(CompLogo; RecEduSetup."Logo Image")
            {
            }
            column(On_Ground_Check_In_Complete_By; "On Ground Check-In Complete By")
            { }
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
            column(E_Mail_Address; "E-Mail Address")
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
            column(StatusDescription; StatusDescription) { }
            column(CourseDescription; CourseDescription) { }
            Column(Counttotal; Counttotal) { }
            trigger OnPreDataItem()
            var

            begin
                Companyinform.GET();
                //Companyinform.CalcFields(Picture);
                Companyinform.CalcFields("AICASA Image");
                RecEduSetup.Reset();
                RecEduSetup.SetRange("Global Dimension 1 Code", '9100');
                IF RecEduSetup.FindFirst() then
                    RecEduSetup.CALCFIELDS("Logo Image");
            end;

            trigger OnAfterGetRecord()
            var
                RecEduSetupAUA: Record "Education Setup-CS";
            begin
                if NOT ("Global Dimension 1 Code" = '9100') then
                    CurrReport.skip();

                if NOT ("Student Group" = "Student Group"::"On-Ground Check-In Completed") then
                    CurrReport.skip();
                //Filterstring := StudentMasterCS.GetFilters();
                if StudentMasterCS.GetFilters() <> '' then
                    Filterstring := 'Filters : ' + StudentMasterCS.GetFilters();
                StatusDescription := '';
                CourseDescription := '';
                if StatusLrec.GET(StudentMasterCS.status, StudentMasterCS."Global Dimension 1 Code") then
                    StatusDescription := Statuslrec.Description;
                if Courselrec.get(StudentMasterCS."Course Code") then
                    CourseDescription := Courselrec.Description;

                Counttotal := Counttotal + 1;

            end;
        }
    }
    var
        Companyinform: Record "Company Information";
        Filterstring: Text;
        Statuslrec: Record "Student Status";
        Courselrec: Record "Course Master-CS";
        [InDataSet]
        CourseDescription: Text[100];
        StatusDescription: Text[100];
        Counttotal: Integer;
        RecEduSetup: Record "Education Setup-CS";

}
