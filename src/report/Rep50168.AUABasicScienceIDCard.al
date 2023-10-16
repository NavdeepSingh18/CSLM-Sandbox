report 50168 "AUA Basic Science IDCard"
{

    DefaultLayout = RDLC;
    UseSystemPrinter = true;
    ShowPrintStatus = true;
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Name; "First Name")
            {
            }
            column(Last_Name; "Last Name")
            {

            }
            column(Image; RecEduSetup."Logo Image")
            {
            }
            column(QRCode; "Student Master-CS"."Student QRCode")
            {
            }
            column(StudentImage; "Student Image")
            {
            }
            trigger OnAfterGetRecord()
            var
                RecStudentMaster: Record "Student Master-CS";
            begin
                RecStudentMaster.Reset();
                RecStudentMaster.SetRange("No.", "No.");
                RecStudentMaster.SetRange("Global Dimension 1 Code", '9100');
                IF RecStudentMaster.FindFirst() then
                    Error('ID Card Print is for AUA Student');

                RecEduSetup.Reset();
                RecEduSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF RecEduSetup.FindFirst() then
                    RecEduSetup.CALCFIELDS("Logo Image");

                "Student Master-CS".CALCFIELDS("Student Master-CS"."Student Image", "Student Master-CS"."Student QRCode");

                IF not "Student Master-CS"."Student QRCode".HasValue then
                    Error('Please generate QR code for the Student %', "Student Master-CS"."Student Name");
            end;
        }
    }

    var
        RecEduSetup: Record "Education Setup-CS";


}

