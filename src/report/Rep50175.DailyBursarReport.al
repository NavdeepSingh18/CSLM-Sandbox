
report 50175 "Daily Bursar Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Daily Bursar Report.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Enrollment No.", Semester, "Academic Year";
            Column(Original_Student_No_; "Original Student No.")
            { }
            column(StudentNumber; "No.")
            { }

            Column(Enrollment_No_; "Enrollment No.")
            { }
            column(Last_Name; "Last Name")
            { }
            column(First_Name; "First Name")
            { }
            column(Student_Email; "E-Mail Address")
            { }
            column(School_Status; Status)
            { }
            column(Current_Semester; Semester)
            { }
            column(Program; "Course Code")
            { }
            column(Campus; "Global Dimension 1 Code")
            { }
            column(OLR_Completed; "OLR Completed Date")
            { }//OLR_Completed Date Field Need to be Added
            column(AR_Balance; "Tuition Balance")
            { }
            column(Grenville; "Grenville Balance")
            { }
            column(AUA_Housing_Balance; "AUA Housing Balance")
            { }
            column(OLR_Bursar_Hold; "Bursar Hold")
            { }
            column(OLR_FA_Hold; "Financial Aid Hold")
            { }
            column(Transportation_Requirements; TransportAllotReq)
            { }
            column(Intent_To_Pay; IntentToPay)
            { }
            column(Received_FAFSA; "FAFSA Received")
            { }
            column(T4_Authorization; "T4 Authorization")
            { }
            column(In_Person_Registration; "On Ground Check-In Complete On")
            { }//In-Person Registration Date Need to be Added
            column(Filter_Caption; GETFILTERS())
            { }
            column(CompInfo; CompInfo.Name)
            { }

            trigger OnAfterGetRecord()
            begin

                PaymentPlanCaption := '';
                SelfPaymentPlanCaption := '';
                ScholarshipCodeCaption := '';
                FSAIDCaption := '';
                IntentToPay := '';
                IF "Financial Aid Approved" then
                    FSAIDCaption := 'Federal Student Aid;';
                IF "Payment Plan Applied" then
                    PaymentPlanCaption := 'Payment Plan;';
                IF "Self Payment Applied" then
                    SelfPaymentPlanCaption := 'Self-Pay;';
                IF "Scholarship Source" <> '' then
                    ScholarshipCodeCaption := 'Scholarship;';

                IF "Transport Allot" then
                    TransportAllotReq := 'Required'
                Else
                    TransportAllotReq := 'Not Required';

                IntentToPay := FSAIDCaption + PaymentPlanCaption + ScholarshipCodeCaption + SelfPaymentPlanCaption;

                //For Grenville 
                GrenvilleAmount := 0;
                RecGlEntry.Reset();
                RecGlEntry.SetRange("Enrollment No.", "Enrollment No.");
                RecGlEntry.SetFilter("Global Dimension 2 Code", '%1|%2', '9300', '9500');
                RecGlEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                IF RecGlEntry.FindSet() then begin
                    repeat
                        RecCustPostGroup.Reset();
                        RecCustPostGroup.SetRange("Receivables Account", RecGlEntry."G/L Account No.");
                        IF NOT RecCustPostGroup.FindFirst() then
                            GrenvilleAmount += RecGlEntry.Amount;
                    until RecGlEntry.Next() = 0;
                end;

                //For AR Balance Amount
                ArAmount := 0;
                RecGlEntryArBalance.Reset();
                RecGlEntryArBalance.SetRange("Enrollment No.", "Enrollment No.");
                RecGlEntryArBalance.SetRange("Global Dimension 2 Code", '');
                RecGlEntryArBalance.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                IF RecGlEntryArBalance.FindSet() then begin
                    repeat
                        RecCustPostGroup.Reset();
                        RecCustPostGroup.SetRange("Receivables Account", RecGlEntryArBalance."G/L Account No.");
                        IF NOT RecCustPostGroup.FindFirst() then
                            ArAmount += RecGlEntryArBalance.Amount;
                    until RecGlEntryArBalance.Next() = 0;
                end;

                "Student Master-CS".CalcFields("AUA Housing Balance", "Tuition Balance", "Grenville Balance");


            end;

        }

    }
    requestpage
    {
        // SaveValues = true;

        layout
        {

            area(content)
            {
                group(Option)
                {

                    field("Start Date"; StartDate)
                    {

                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start Date may have a value';
                    }
                    field("End Date"; EndDate)
                    {

                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End Date may have a value';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompInfo.GET();
    end;

    trigger OnPreReport()
    begin
        if StartDate = 0D then
            ERROR('Start Date must have a value');
        if EndDate = 0D then
            ERROR('End Date must have a value');
    end;

    var
        CompInfo: Record "Company Information";
        RecGlEntry: Record "G/L Entry";
        RecGlEntryArBalance: Record "G/L Entry";
        RecCustPostGroup: Record "Customer Posting Group";
        StartDate: Date;
        EndDate: Date;
        PaymentPlanCaption: Text[100];
        SelfPaymentPlanCaption: Text[100];
        ScholarshipCodeCaption: Text[100];
        FSAIDCaption: Text[100];
        IntentToPay: Text[2048];
        TransportAllotReq: Text[100];
        GrenvilleAmount: Decimal;
        ArAmount: Decimal;


}