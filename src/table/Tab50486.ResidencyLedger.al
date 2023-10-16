table 50486 "Residency Ledger"
{
    DataClassification = CustomerContent;
    Caption = 'Residency Ledger';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Residency No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency No.';
        }

        field(4; "Residency Year"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency Year';
        }
        field(6; "Residency Status"; code[20])
        {
            Caption = 'Residency Status';
            DataClassification = CustomerContent;

        }
        field(7; "NRMP Status"; Code[20])
        {
            Caption = 'NRMP Status';
            DataClassification = CustomerContent;
        }
        field(8; "CaRMS Status"; Code[20])
        {
            
            DataClassification = CustomerContent;
            Caption = 'CaRMS Status';
        }
        field(9; "San Francisco Status"; Code[20])
        {
            
            DataClassification = CustomerContent;
            Caption = 'San Francisco Status';
        }

        field(12; "Hospital State"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital State';
            TableRelation = "State SLcM CS".Code;
        }
        field(13; "Hospital Country"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Country';
            TableRelation = "Country/Region".Code;
        }

        field(16; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";

        }

        field(21; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
        }
        field(22; "Hospital City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital City';
        }
        field(23; "Residency Specialty"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency Specialty';
        }
        field(54; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin

    end;

}