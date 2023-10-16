table 50299 "License Tracking Ledger"
{
    DataClassification = CustomerContent;
    Caption = 'License Tracking Ledger';


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
        }
        field(3; "License ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'License ID';
        }
        field(4; "License Type"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'License Type';

        }
        field(5; "State"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'State';

        }
        field(6; "Expiration"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration';

        }
        field(7; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';

        }
        field(8; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified by';

        }
        field(9; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
