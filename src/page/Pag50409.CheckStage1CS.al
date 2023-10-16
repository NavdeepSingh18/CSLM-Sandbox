page 50409 "Check Stage1-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    SaveValues = true;

    layout
    {
        area(content)
        {
            group(Test001)
            {
                field(TamplateName; TamplateNCS)
                {
                    Caption = 'Tamplate Name';
                    ApplicationArea = All;
                }
                field(BatchName; BatchNCS)
                {
                    Caption = 'Batch NCS';
                    ApplicationArea = All;
                }
                field("Student No."; StnoCS)
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                }
                field("Fee Code"; CSFeeCode)
                {
                    Caption = 'Fee Code';
                    ApplicationArea = All;

                }
                field("Currency Code"; CurrencyCS)
                {
                    Caption = 'Currency Code"';
                    ApplicationArea = All;
                }
                field(Amount; AmountCS)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field("Bal Account No"; BalAcco)
                {
                    Caption = 'Bal Account No';
                    ApplicationArea = All;
                }
                field("Document No"; DocNo)
                {
                    Caption = 'Document No';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        TamplateNCS: Code[10];
        BatchNCS: Code[10];
        StnoCS: Code[20];
        CSFeeCode: Code[10];
        CurrencyCS: Code[10];
        AmountCS: Decimal;
        BalAcco: Code[20];
        DocNo: Code[20];
}