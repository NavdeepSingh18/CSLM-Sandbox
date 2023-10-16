report 50166 "Student Hold Status"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/StudentHoldStatus.rdlc';
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")

        {
            RequestFilterFields = "Global Dimension 1 Code", "No.", "Enrollment No.";
            column(No_; "No.")
            { }
            column(Student_Name; "Student Name")
            { }
            Column(LogoImage; RecEduSetup."Logo Image")
            { }
            dataitem("Student Wise Holds"; "Student Wise Holds")
            {
                DataItemLink = "Student No." = field("No.");
                DataItemTableView = where(Status = filter(Enable));
                column(Hold_Code; "Hold Code")
                { }
                column(Hold_Description; "Hold Description")
                { }
                column(Status; Status)
                { }
                column(Created_On; "Created On")
                { }
                trigger OnPreDataItem()
                var
                begin
                    // RecEduSetup.Get();
                    // RecEduSetup.CALCFIELDS("Logo Image");
                    InstituteCode := "Student Master-CS".GetFilter("Global Dimension 1 Code");
                    IF InstituteCode = '' then
                        Error('Please select Institute Code');
                    RecEduSetup.Reset();
                    RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
                    IF RecEduSetup.FindFirst() then
                        RecEduSetup.CALCFIELDS("Logo Image");
                    // RecEduSetup.Reset();
                    // RecEduSetup.SetRange("Global Dimension 1 Code", '9000');
                    // IF RecEduSetup.FindFirst() then
                    //     RecEduSetup.CALCFIELDS("Logo Image");

                end;


            }
        }
    }
    var

        RecEduSetup: Record "Education Setup-CS";
        InstituteCode: code[20];
}