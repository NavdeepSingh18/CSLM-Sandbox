report 50062 "FCR FR ListCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/FCR FR ListCS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("Journal Batch Name" = FILTER('FCR RCPT'),
                                      "Debit Amount" = FILTER('>0'),
                                      "G/L Account No." = FILTER('<>4901013'));
            RequestFilterFields = "Posting Date";
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(EnrollmentNo_GLEntry; "G/L Entry"."Enrollment No.")
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(CurrencyCode_GLEntry; "G/L Entry"."Currency Code")
            {
            }
            column(Name; Name)
            {
            }
            column(CourseName; CourseName)
            {
            }
            column(CurrRate; CurrRate)
            {
            }
            column(FCRAmount; FCRAmount)
            {
            }
            column(Name1; CompanyInformation.Name)
            {
            }
            column(CompInfoAddress; CompanyInformation.Address)
            {
            }
            column(CompInfoAddress2; CompanyInformation."Address 2")
            {
            }
            column(GETFILTERS; "G/L Entry".GETFILTERS())
            {
            }
            column(InstrumentType_GLEntry; "G/L Entry"."Instrument Type")
            {
            }
            column(ChequeDate_GLEntry; FORMAT("G/L Entry"."Cheque Dates"))
            {
            }
            column(ChequeNo_GLEntry; "G/L Entry"."Cheque Nos.")
            {
            }
            column(CustomerBankCode_GLEntry; "G/L Entry"."Customer Bank Code")
            {
            }
            column(CustomerBankBranchCode_GLEntry; "G/L Entry"."Customer Bank Branch Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    Name := StudentMasterCS."Name as on Certificate";
                    CourseName := StudentMasterCS."Course Name";
                END;

                CurrRate := 0;
                FCRAmount := 0;
                IF "G/L Entry"."Currency Code" = 'USD' THEN BEGIN
                    CurrRate := 1 / "G/L Entry"."Currency Factor";
                    FCRAmount := "G/L Entry".Amount / CurrRate;
                END;
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

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        CompanyInformation: Record "Company Information";
        Name: Text[100];
        CourseName: Text[100];
        CurrRate: Decimal;
        FCRAmount: Decimal;

}

