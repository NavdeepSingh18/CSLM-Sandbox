report 50169 "AICASA IDCard"
{

    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
            }
            column(Name; "Student Name")
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
            Var
                RecStudentMaster: Record "Student Master-CS";
            begin
                RecStudentMaster.Reset();
                RecStudentMaster.SetRange("No.", "No.");
                RecStudentMaster.SetRange("Global Dimension 1 Code", '9000');
                IF RecStudentMaster.FindFirst() then
                    Error('ID Card Print is for AICASA Student');

                RecEduSetup.Reset();
                RecEduSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                IF RecEduSetup.FindFirst() then
                    RecEduSetup.CALCFIELDS("Logo Image");

                "Student Master-CS".CALCFIELDS("Student Master-CS"."Student Image", "Student Master-CS"."Student QRCode");
            end;
        }
    }

    var
        RecEduSetup: Record "Education Setup-CS";

}

