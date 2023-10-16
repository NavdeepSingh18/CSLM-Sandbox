table 50327 "Gen Journal Copy-CS"
{
    // version V.001-CS

    Caption = 'Gen Journal Copy-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(3; "Account type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner";
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }
        field(5; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            Caption = 'Bal. Account Type';
            DataClassification = CustomerContent;
        }
        field(6; "Bal. Account No."; Code[20])
        {
            Enabled = false;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(7; "Debit Amount"; Decimal)
        {
        }
        field(8; "Credit Amount"; Decimal)
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "Student No"; Code[20])
        {
            TableRelation = Customer."No.";
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(11; Narration; Text[80])
        {
            Caption = 'Narration';
            DataClassification = CustomerContent;
        }
        field(12; Transaction; Option)
        {
            OptionCaption = ' ,Withdraw,Refund';
            OptionMembers = " ",Withdraw,Refund;
            Caption = 'Transaction';
            DataClassification = CustomerContent;
        }
        field(13; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(14; "Sync."; Boolean)
        {
            Caption = 'Sync.';
            DataClassification = CustomerContent;
        }
        field(15; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(17; "UTR No."; Code[20])
        {
            Caption = 'UTR No.';
            DataClassification = CustomerContent;
        }
        field(18; "UTR Date"; Date)
        {
            Caption = 'UTR Date';
            DataClassification = CustomerContent;
        }
        field(19; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

