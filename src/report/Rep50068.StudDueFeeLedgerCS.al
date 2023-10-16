report 50068 "Stud Due Fee Ledger CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './src/reportrdlc/Stud Due Fee Ledger CS.rdlc';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Remaining Amount" = FILTER('>0'));
            RequestFilterFields = "Posting Date", "Enrollment No.";
            column(EnrollmentNo_CustLedgerEntry; "Cust. Ledger Entry"."Enrollment No.")
            {
            }
            column(AcademicYear_CustLedgerEntry; "Cust. Ledger Entry"."Academic Year")
            {
            }
            column(Year_CustLedgerEntry; "Cust. Ledger Entry".Year)
            {
            }
            column(CurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Currency Code")
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(FeeClassificationCode_CustLedgerEntry; "Cust. Ledger Entry"."Fee Classification Code")
            {
            }
            column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
            {
            }
            column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(GlobalDimension1Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(StudentName; StudentName)
            {
            }
            column(CourseName; CourseName)
            {
            }
            column(DimName; DimName)
            {
            }
            column(Year1Rem; Year1Rem)
            {
            }
            column(Year2Rem; Year2Rem)
            {
            }
            column(Year3Rem; Year3Rem)
            {
            }
            column(Year4Rem; Year4Rem)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(GETFILTERS; "Cust. Ledger Entry".GETFILTERS())
            {
            }

            trigger OnAfterGetRecord()
            begin
                Year1Rem := 0;
                Year2Rem := 0;
                Year3Rem := 0;
                Year4Rem := 0;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE("Enrollment No.", "Enrollment No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    StudentName := StudentMasterCS."Name as on Certificate";
                    CourseName := StudentMasterCS."Course Name";
                END;

                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, "Cust. Ledger Entry"."Global Dimension 1 Code");
                IF DimensionValue.findfirst() THEN
                    DimName := DimensionValue.Name;


                "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amount");
                IF "Cust. Ledger Entry".Year = '1ST' THEN
                    Year1Rem := "Cust. Ledger Entry"."Remaining Amount";

                IF "Cust. Ledger Entry".Year = '2ND' THEN
                    Year2Rem := "Cust. Ledger Entry"."Remaining Amount";

                IF "Cust. Ledger Entry".Year = '3RD' THEN
                    Year3Rem := "Cust. Ledger Entry"."Remaining Amount";

                IF "Cust. Ledger Entry".Year = '4TH' THEN
                    Year4Rem := "Cust. Ledger Entry"."Remaining Amount";

            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        DimensionValue: Record "Dimension Value";
        CompInfo: Record "Company Information";

        StudentName: Text[100];
        CourseName: Text[100];

        DimName: Text[50];
        Year1Rem: Decimal;
        Year2Rem: Decimal;
        Year3Rem: Decimal;
        Year4Rem: Decimal;

}

