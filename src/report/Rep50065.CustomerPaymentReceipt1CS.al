report 50065 "Customer - Payment Receipt 1CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Customer - Payment Receipt 1CS.rdlc';
    Caption = 'Customer - Payment Receipt';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date", "Currency Code")
                                WHERE("Document Type" = FILTER('Payment'),
                                      "Remaining Amount" = FILTER('<0'));
            RequestFilterFields = "Customer No.", "Posting Date", "Document No.";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Add; CompanyInformation.Address)
            {
            }
            column(Add2; CompanyInformation."Address 2")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Postcode; CompanyInformation."Post Code")
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(EntryNo_CustLedgEntry; "Entry No.")
            {
            }
            column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(Amount1; Amount1)
            {
            }
            column(RemainAmt1; RemainAmt1)
            {
            }
            dataitem(DetailedCustLedgEntry1; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Applied Cust. Ledger Entry No." = FIELD("Entry No.");
                DataItemLinkReference = "Cust. Ledger Entry";
                DataItemTableView = SORTING("Applied Cust. Ledger Entry No.", "Entry Type")
                                    WHERE("Unapplied" = CONST(false));
                dataitem(CustLedgEntry1; "Cust. Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Cust. Ledger Entry No.");
                    DataItemLinkReference = DetailedCustLedgEntry1;
                    DataItemTableView = SORTING("Entry No.");
                    column(PostDate_CustLedgEntry1; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_CustLedgEntry1; "Document Type")
                    {
                        IncludeCaption = true;
                    }
                    column(DocumentNo_CustLedgEntry1; "Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Desc_CustLedgEntry1; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(ShowAmount; ShowAmount)
                    {
                    }
                    column(PmtDiscInvCurr; PmtDiscInvCurr)
                    {
                    }
                    column(PmtTolInvCurr; PmtTolInvCurr)
                    {
                    }
                    column(CurrencyCodeCaption; FIELDCAPTION("Currency Code"))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ShowAmount := -DetailedCustLedgEntry1.Amount;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SETFILTER("Cust. Ledger Entry No.", '<>%1', "Applied Cust. Ledger Entry No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Cust.GET("Customer No.");
                FormatAddr.Customer(CustAddr, Cust);

                IF NOT Currency.GET("Currency Code") THEN
                    Currency.InitRoundingPrecision();

                IF Custno <> "Customer No." THEN
                    Amount1 := 0;
                Custno := "Customer No.";
                Amount1 := Amount1 + ABS(Amount);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET();
                CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
                FormatAddr.Company(CompanyAddr, CompanyInformation);
                GLSetup.GET();
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
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Cust: Record "Customer";
        Currency: Record "Currency";
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        PmtDiscInvCurr: Decimal;
        PmtTolInvCurr: Decimal;
        ShowAmount: Decimal;
        Amount1: Decimal;
        RemainAmt1: Decimal;
        Custno: Code[20];
}

