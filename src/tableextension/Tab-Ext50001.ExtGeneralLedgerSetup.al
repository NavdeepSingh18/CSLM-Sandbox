tableextension 50001 "ExtGeneralLedgerSetup" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Portal Entries Auto Post"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Payment Plan No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50002; "Financial Accountability No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50003; "Housing Change/Vacate No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50004; "Housing Opt Out No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }
        field(50005; "Housing Issue No."; code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50006; "Housing Application No."; code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50007; "Leave Of Absence No."; code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50008; "Housing Parking No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50009; "Immigration Document No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(50010; "Withdrawal No."; Code[20])
        {
            Caption = 'Withdrawal No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50011; "Degree Audit Document No."; Code[20])
        {
            Caption = 'Graduation Audit Document No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50012; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}