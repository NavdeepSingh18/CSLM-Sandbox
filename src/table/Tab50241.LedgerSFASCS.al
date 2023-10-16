table 50241 "Ledger SFAS-CS"
{
    // version V.001-CS

    Caption = 'Ledger SFAS-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Roll No."; Code[20])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; "Class Code"; Code[10])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
        }
        field(5; InstID; Code[10])
        {
            Caption = 'InstID';
            DataClassification = CustomerContent;
        }
        field(6; "Batch Code"; Code[10])
        {
            Caption = 'Batch Code';
            DataClassification = CustomerContent;
        }
        field(7; "Inst ID"; Code[10])
        {
            Caption = 'Inst ID';
            DataClassification = CustomerContent;
        }
        field(8; CatgCode; Code[10])
        {
            Caption = 'CatgCode';
            DataClassification = CustomerContent;
        }
        field(9; Rsdl; Code[10])
        {
            Caption = 'Rsdl';
            DataClassification = CustomerContent;
        }
        field(10; "Journal ID"; Code[20])
        {
            Caption = 'Journal ID';
            DataClassification = CustomerContent;
        }
        field(11; "Journal Line"; Code[10])
        {
            Caption = 'Journal Line';
            DataClassification = CustomerContent;
        }
        field(12; "Journal Date"; DateTime)
        {
            Caption = 'Journal Date';
            DataClassification = CustomerContent;
        }
        field(13; Narration; Text[100])
        {
            Caption = 'Narration';
            DataClassification = CustomerContent;
        }
        field(14; DebitCredit; Text[10])
        {
            Caption = 'DebitCredit';
            DataClassification = CustomerContent;
        }
        field(15; "Amount Dollar"; Decimal)
        {
            Caption = 'Amount Dollar';
            DataClassification = CustomerContent;
        }
        field(16; "Amount Rs"; Decimal)
        {
            Caption = 'Amount Rs';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

