report 50228 "MSPE Repeat Applicants"
{
    Caption = 'MSPE Repeat Applicants Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/MSPERepeatApplicants.rdl';

    dataset
    {
        dataitem(MSPE; MSPE)
        {
            DataItemTableView = where("Application Type" = Filter(Repeated));
            RequestFilterFields = "Application Date";

            Column(EnrollmentNo_gTxt; EnrollmentNo_gTxt)
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            Column(First_Name; "First Name")
            {

            }
            Column(Application_Date; "Application Date")
            {

            }

            Column(Logo_Image; EducationSetup_gRec."Logo Image")
            { }
            column(Institute_Name; EducationSetup_gRec."Institute Name")
            { }
            Column(Institute_Add; EducationSetup_gRec."Institute Address")
            { }
            column(Institute_Add2; EducationSetup_gRec."Institute Address 2")
            { }
            column(Institute_City; EducationSetup_gRec."Institute City")
            { }
            column(Institute_PostCode; EducationSetup_gRec."Institute Post Code")
            { }
            Column(Institute_Country; EducationSetup_gRec."Institute Country Code")
            { }
            column(Institute_PhoneNo; EducationSetup_gRec."Institute Phone No.")
            { }
            column(Institute_Email; EducationSetup_gRec.url)
            { }
            column(Document_gTxt; Document_gTxt)
            { }


            Trigger OnPreDataItem()
            begin

                UserSetup_gRec.Reset();
                if UserSetup_gRec.Get(UserId()) then;

                EducationSetup_gRec.Reset();
                EducationSetup_gRec.SetRange("Global Dimension 1 Code", UserSetup_gRec."Global Dimension 1 Code");
                If EducationSetup_gRec.FindFirst() then;

                EducationSetup_gRec.CalcFields("Logo Image");
            end;

            trigger OnAfterGetRecord()
            begin
                EnrollmentNo_gTxt := '';
                StudentMaster_gRec.Reset();
                StudentMaster_gRec.SetRange("No.", MSPE."Student No");
                IF StudentMaster_gRec.FindFirst() then
                    EnrollmentNo_gTxt := StudentMaster_gRec."Enrollment No.";

                Document_gTxt := '';
                If MSPE."Application Type" = MSPE."Application Type"::Repeated then
                    Document_gTxt := 'MSPE Request - Repeat Applicant - ' + Format(Date2DMY(MSPE."Application Date", 3));
            end;

        }
    }

    var
        StudentMaster_gRec: Record "Student Master-CS";
        UserSetup_gRec: Record "User Setup";
        EducationSetup_gRec: Record "Education Setup-CS";

        EnrollmentNo_gTxt: Code[20];

        Document_gTxt: Text[100];
}