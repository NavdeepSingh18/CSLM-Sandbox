table 50534 "Roster Ledger Documents"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Invoice Nos."; text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Cheque Nos."; text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cheque Dates"; text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Invoice,Payment;
        }
        field(6; "Rotation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}