page 50408 "Form Gen. Journal-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Insert Entry - OnAction()                    Code added for data insert.

    SaveValues = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tamplate Name1"; TamplateName1)
                {
                    Caption = 'Tamplate Name1';
                    ApplicationArea = All;
                }
                field("Batch Name1"; BatchName1)
                {
                    Caption = 'Batch Name1';
                    ApplicationArea = All;
                }
                field("Document Type1"; DocumentType1)
                {
                    Caption = 'Document Type1';
                    ApplicationArea = All;
                    OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
                }
                field("Account type1"; Accounttype1)
                {
                    Caption = 'Account Type1';
                    ApplicationArea = All;
                    OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
                }
                field("Account No1"; AccountNo1)
                {
                    Caption = 'Account No1';
                    ApplicationArea = All;
                }
                field("BalAccount Type1"; BalAccountType1)
                {
                    Caption = 'BalAccount Type1';
                    ApplicationArea = All;
                    OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
                }
                field("BalAccount No1"; BalAccountNo1)
                {
                    Caption = 'BalAccountNo1';
                    ApplicationArea = All;
                }
                field("Amount 1"; Amount1)
                {
                    Caption = 'Amount1';
                    ApplicationArea = All;
                }
                field("Student RollNo"; StudentRollNo)
                {
                    Caption = 'StudentRollNo';
                    ApplicationArea = All;
                }
                field("Transaction 1"; Transaction1)
                {
                    Caption = 'Transaction1';
                    ApplicationArea = All;
                    OptionCaption = ' ,Withdraw,Refund';
                }
                field("UTR No1"; UTRNo1)
                {
                    Caption = 'UTRNo1';
                    ApplicationArea = All;
                }
                field("UTR Date1"; UTRDate1)
                {
                    Caption = 'UTRDate1';
                    ApplicationArea = All;
                }
                field("Currency Code1"; CurrencyCode1)
                {
                    Caption = 'CurrencyCode1';
                    ApplicationArea = All;
                }
                field("Currency Factor1"; CurrencyFactor1)
                {
                    Caption = 'CurrencyFactor1';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Insert Entry")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for data insert::CSPL-00059::07022019: Start
                    GenWebJournalCS.CSInsertEntry(TamplateName1, BatchName1, DocumentType1, Accounttype1, AccountNo1, BalAccountType1, BalAccountNo1, Amount1, StudentRollNo, Transaction1, UTRNo1, UTRDate1, CurrencyCode1, CurrencyFactor1);
                    MESSAGE('Done!!');
                    //Code added for data insert::CSPL-00059::07022019: End
                end;
            }
        }
    }

    var
        GenWebJournalCS: Codeunit "Gen. Web  Journal -CS";
        DocumentType1: Option;
        Accounttype1: Option;
        AccountNo1: Code[20];
        BalAccountNo1: Code[20];
        BalAccountType1: Option;

        StudentRollNo: Code[20];
        Transaction1: Option;

        UTRNo1: Code[20];
        UTRDate1: Date;

        Amount1: Decimal;
        CurrencyCode1: Code[10];
        CurrencyFactor1: Decimal;
        TamplateName1: Code[10];
        BatchName1: Code[10];
}