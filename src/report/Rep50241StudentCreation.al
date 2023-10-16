report 50241 "Student Creation"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './src/reportrdlc/Student Creation.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            column(Last_Name;
            "Last Name")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(School_Email; "E-Mail Address")
            {

            }
            column(Student_ID; "Original Student No.")
            {

            }
            column(Enrollment_No_; "Enrollment No.")
            {

            }
            column(Personal_Email_Address; "Alternate Email Address")
            {

            }
            column(Account_Creation_Date; "Creation Date")
            {

            }
            column(Logo; EduSetup."Logo Image")
            {

            }
            column(instututename; EduSetup."Institute Name")
            {

            }
            trigger OnPreDataItem()
            var
            begin
                // if (FromDate = 0D) or (ToDate = 0D) then
                //     Error('Please fill the date');

                SetFilter("Creation Date", '%1..%2', FromDate, ToDate);

                EduSetup.Reset();
                EduSetup.SetRange("Global Dimension 1 Code", '9000');
                if EduSetup.FindFirst() then
                    EduSetup.CalcFields("Logo Image");
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field(FromDate; FromDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = All;

                    }
                    field(ToDate; ToDate)
                    {
                        Caption = 'To Date';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(ActionName)
                // {
                //     ApplicationArea = All;

                // }
            }
        }
    }

    var
        EduSetup: Record "Education Setup-CS";
        FromDate: Date;
        ToDate: Date;
}