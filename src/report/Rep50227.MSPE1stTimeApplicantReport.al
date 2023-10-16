report 50227 "MSPE 1st Time Applicants"
{
    Caption = 'MSPE 1st Time Applicants Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/MSPE1stTimeApplicants.rdl';

    dataset
    {

        dataitem(MSPE; MSPE)
        {
            DataItemTableView = where("Application Type" = filter(New));
            RequestFilterFields = "Application Date";
            column(EnrollmentNo_gTxt; EnrollmentNo_gTxt)
            {

            }
            Column(Last_Name; "Last Name")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Application_Date; "Application Date")
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

            Trigger OnAfterGetRecord()
            begin
                EnrollmentNo_gTxt := '';
                StudentMaster_gRec.Reset();
                StudentMaster_gRec.SetRange("No.", MSPE."Student No");
                IF StudentMaster_gRec.FindFirst() then
                    EnrollmentNo_gTxt := StudentMaster_gRec."Enrollment No.";


                Document_gTxt := '';
                If MSPE."Application Type" = MSPE."Application Type"::New then
                    Document_gTxt := 'MSPE Request - 1st Time Applicant - ' + Format(Date2DMY(MSPE."Application Date", 3));

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