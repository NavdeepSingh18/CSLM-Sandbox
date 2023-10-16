
report 50178 "Mike Burtch Daily Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Mike Burtch Daily Report.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Enrollment No.", Semester, "Academic Year";

            column(AUALogo; RecEduSetup."Logo Image")
            { }
            column(AICASALogo; RecEduSetup1."Logo Image")
            { }
            Column("Institute_Name"; RecEduSetup."Institute Name")
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }

            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup."Institute E-Mail")
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(StudentNumber; "No.")
            { }
            column(Last_Name; "Last Name")
            { }
            column(First_Name; "First Name")
            { }
            column(Student_Email; "E-Mail Address")
            { }
            column(School_Status; "Student Status")
            { }
            column(Current_Semester; Semester)
            { }
            column(Program; Graduation)
            { }
            column(Campus; "Global Dimension 1 Code")
            { }
            column(OLR_Completed; "OLR Completed")
            { }//OLR_Completed Date Field Need to be Added
            column(AR_Balance; ArAmount)
            { }
            column(Grenville; GrenvilleAmount)
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
            column(In_Person_Registration; "Pending For Registration")
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

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", '9000');
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");

        RecEduSetup1.Reset();
        RecEduSetup1.SetRange("Global Dimension 1 Code", '9100');
        IF RecEduSetup1.FindFirst() then
            RecEduSetup1.CALCFIELDS("Logo Image");
    end;

    var
        CompInfo: Record "Company Information";
        RecEduSetup: Record "Education Setup-CS";
        RecEduSetup1: Record "Education Setup-CS";
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