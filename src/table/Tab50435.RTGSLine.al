table 50435 "RTGS Line"
{
    DataClassification = CustomerContent;
    Caption = 'RTGS Line';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Invoice No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice No.';
            // trigger Onvalidate()
            // begin
            //     DetailedCustLedgerRec.Reset();
            //     DetailedCustLedgerRec.Setrange("Document No.", "Invoice No.");
            //     DetailedCustLedgerRec.Setrange("Entry Type", DetailedCustLedgerRec."Entry Type"::"Initial Entry");
            //     if DetailedCustLedgerRec.FindFirst() then begin
            //         "Invoice Amount" := DetailedCustLedgerRec.Amount;
            //         Modify();
            //     end;
            // end;
        }
        field(4; "Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Date';
        }
        field(5; "Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Amount';
            Editable = false;
        }
        field(6; "Applied Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Applied Amount';
            trigger OnValidate()
            begin
                if "Invoice Amount" <> 0 then
                if "Applied Amount" > "Invoice Amount" then
                        Error('Applied Amount must be less than or equal to Invoice Amount.');
            end;
        }
        field(7; "Last Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Line';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var
        DetailedCustLedgerRec: Record "Detailed Cust. Ledg. Entry";
}