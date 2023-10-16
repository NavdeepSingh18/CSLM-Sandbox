report 50063 "FCR FR Out standing listCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/FCR FR Out standing listCS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("Debit Amount" = FILTER('>0'),
                                      "UnRelazised Doc No." = FILTER(''),
                                      "Journal Batch Name" = FILTER('FCR RCPT'),
                                      Description = FILTER('UNREALISED INSTRUMENTS'));
            RequestFilterFields = "Posting Date", "Instrument Type";
            column(PostingDate_GLEntry; FORMAT("G/L Entry"."Posting Date"))
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
            column(InstrumentType_GLEntry; "G/L Entry"."Instrument Type")
            {
            }
            column(ChequeNo_GLEntry; "G/L Entry"."Cheque Nos.")
            {
            }
            column(ChequeDate_GLEntry; "G/L Entry"."Cheque Dates")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(AmountReceipt_GLEntry; "G/L Entry"."Amount Receipt")
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
            column(Name1; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(GETFILTERS; "G/L Entry".GETFILTERS())
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
                DocNo := '';

                GLEntry.Reset();
                GLEntry.SETRANGE("UnRelazised Doc No.", "G/L Entry"."Document No.");
                IF GLEntry.findfirst() THEN
                    CurrReport.Skip();

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    Name := StudentMasterCS."Name as on Certificate";
                    CourseName := StudentMasterCS."Course Name";
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
        CompInfo.GET();
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        CompInfo: Record "Company Information";
        GLEntry: Record "G/L Entry";
        Name: Text[100];
        CourseName: Text[100];
        CurrRate: Decimal;
        FCRAmount: Decimal;
        DocNo: Code[20];
}

