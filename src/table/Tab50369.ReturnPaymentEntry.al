table 50369 "SLcM Reversal Entry"
{
    Caption = 'Return Payment Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;
        }
        field(2; "Payment Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustomerLedgerEntry: Record "Cust. Ledger Entry";
            begin
                if xRec."Payment Document No." <> Rec."Payment Document No." then begin
                    "Remaning Amount" := 0;
                    "Original Amount" := 0;
                    "Reverse Applicable" := false;
                    CustomerLedgerEntry.reset();
                    CustomerLedgerEntry.Setrange("Customer No.", "Student No.");
                    CustomerLedgerEntry.Setrange("Document No.", "Payment Document No.");
                    if CustomerLedgerEntry.FindFirst() then begin
                        CustomerLedgerEntry.CalcFields("Original Amount", "Remaining Amount");
                        "Original Amount" := CustomerLedgerEntry."Original Amount";
                        "Remaning Amount" := CustomerLedgerEntry."Remaining Amount";
                        if "Original Amount" = "Remaning Amount" then
                            if "Original Amount" <> 0 then
                                "Reverse Applicable" := true;

                    end
                end;
            end;
        }
        field(3; "Payment Document Select"; Boolean)
        {
            Caption = 'Document Select';
            DataClassification = ToBeClassified;
        }
        field(4; "Reversed"; Boolean)
        {
            Caption = 'Document Reversed';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Remaning Amount"; Decimal)
        {
            Caption = 'Remaning Amount';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; "Original Amount"; Decimal)
        {
            Caption = 'Original Amount';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Reverse Applicable"; boolean)
        {
            Caption = 'Reverse Applicable';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Enrollment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Processed Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Processed Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger oninsert()
    var
        ReturnPaymentEntry: Record "SLcM Reversal Entry";
    begin
        ReturnPaymentEntry.Reset();
        if ReturnPaymentEntry.FindLast() then;
        Rec."Entry No." := ReturnPaymentEntry."Entry No." + 1;
    end;
}
