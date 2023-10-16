tableextension 50586 "tableextensionBankAccount" extends "Bank Account"
{
    fields
    {
        field(50000; "SAP G/L Account"; Code[20])
        {
            Caption = 'SAP G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(50001; "SAP Profit Centre"; Code[20])
        {
            Caption = 'SAP Profit Centre';
            DataClassification = CustomerContent;
        }
        field(50002; "SAP Company Code"; Code[20])
        {
            Caption = 'SAP Company Code';
            DataClassification = CustomerContent;
        }
        field(50003; "SAP Bus. Area"; Code[20])
        {
            Caption = 'SAP Bus. Area';
            DataClassification = CustomerContent;
        }
        field(50004; "Beneficiary ABA No."; Code[20])
        {
            Caption = 'Beneficiary ABA No.';
            DataClassification = CustomerContent;
        }
        field(50005; "Statement of Accounts"; boolean)
        {
            Caption = 'Statement of Accounts';
            DataClassification = CustomerContent;
        }
        field(50006; "Beneficiary Name"; Text[100])
        {
            Caption = 'Beneficiary Name';
            DataClassification = CustomerContent;
        }
    }
}