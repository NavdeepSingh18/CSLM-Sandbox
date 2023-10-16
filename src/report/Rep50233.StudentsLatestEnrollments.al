report 50233 "Students Latest Enrollments"
{
    Caption = 'Students Latest Enrollments';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Students Latest Enrollments.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(AsOnDate; AsOnDate)
            {

            }
            column(student_id; "No.")
            {

            }
            column(CompanyName; companyinfo.Name)
            {

            }
            column(Enrollment_No_; studentmaster."Enrollment No.")
            {

            }
            column(student_name; StudentName)
            {

            }
            column(semester; studentmaster.Semester)
            {

            }
            column(Status; Stud.Status)
            {

            }
            column(PointOfTimeStatus; statuschangelog."Status change to")
            {

            }

            column(Mailing_Address; studentmaster.Addressee)
            {

            }

            column(City; studentmaster.city)
            {

            }
            column(State; studentmaster.State)
            {

            }
            column(PostCode; studentmaster."Post Code")
            {

            }
            column(Country; studentmaster."Country Code")
            {

            }
            Column(Course_Code; studentmaster."Course Code")
            {

            }
            column(Present_Mobile_Number; studentmaster."Mobile Number")
            {

            }
            column(Earlier_Mobile_Number; studentmaster."Phone Number")
            {

            }

            column(email_address; studentmaster."E-Mail Address")
            {

            }
            column(email_Alt_address; studentmaster."Alternate Email Address")
            {

            }

            column(nationality; studentmaster.Nationality)
            {

            }
            column(citizenship; studentmaster.Citizenship)
            {

            }

            column(Status_Change_Date; statuschangelog."Modified On")
            {

            }
            column(Term; studentmaster.Term)
            {

            }

            trigger OnAfterGetRecord()
            begin
                Stud.Reset();
                Stud.SetCurrentKey("Original Student No.", "Enrollment Order");
                Stud.Ascending(true);
                Stud.setrange("Original Student No.", "No.");
                if Stud.FindLast() then;

                studentaddress := '';
                Clear(StudentName);
                studentmaster.Reset();
                studentmaster.SetCurrentKey("Original Student No.", "Enrollment Order");
                studentmaster.Ascending(true);
                studentmaster.setrange("Original Student No.", "No.");
                studentmaster.SetFilter("Creation Date", '<=%1', AsOnDate);
                if studentmaster.FindLast() then begin
                    StudentName := studentmaster."Last Name" + ' ' + studentmaster."First Name";
                    studentaddress := studentmaster.Addressee;
                    if studentmaster.Address2 <> '' then
                        studentaddress += ', ' + studentmaster.Address1;
                    if studentmaster.Address3 <> '' then
                        studentaddress += ', ' + studentmaster.Address2;

                    if studentmaster.City <> '' then
                        studentaddress += ', ' + studentmaster.City;
                    if studentmaster.State <> '' then
                        studentaddress += ', ' + studentmaster.State;
                    if studentmaster."Post Code" <> '' then
                        studentaddress += ', ' + studentmaster."Post Code";
                    if studentmaster."Country Code" <> '' then
                        studentaddress += ', ' + studentmaster."Country Code";

                    statuschangelog.Reset();
                    statuschangelog.SetCurrentKey("Student No.", "Modified On");
                    statuschangelog.Ascending(true);
                    statuschangelog.SetRange("Student No.", studentmaster."No.");
                    statuschangelog.SetFilter("Modified On", '<=%1', AsOnDate);
                    IF VarPointOfTimeStatus <> '' then begin
                        statuschangelog.SetFilter("Status change to", VarPointOfTimeStatus);
                        if NOT statuschangelog.FindLast() then
                            CurrReport.Skip();
                    end else
                        if statuschangelog.FindLast() then;
                end else
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            Area(Content)
            {
                field("As On Date"; AsOnDate)
                {
                    ApplicationArea = All;
                    caption = 'As On Date';
                }
                field(PointOfTimeStatus; VarPointOfTimeStatus)
                {
                    ApplicationArea = All;
                    TableRelation = "Student Status".Code where("Global Dimension 1 Code" = const('9000'));
                    caption = 'Point of Time Status';
                }

            }
        }
    }

    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        if AsOnDate = 0D then
            Error('As On Date cannot be blank.');
        companyinfo.get();
    end;





    var
        studentmaster: Record "Student Master-CS";
        Stud: Record "Student Master-CS";
        statuschangelog: Record "Status Change Log entry";
        companyinfo: Record "Company Information";
        studentaddress: text;
        AsOnDate: Date;
        VarPointOfTimeStatus: Text;
        StudentName: Text;
}