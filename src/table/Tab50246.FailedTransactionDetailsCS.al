table 50246 "Failed Transaction Details-CS"
{
    // version V.001-CS

    Caption = 'Failed Transaction Details-CS';
    DrillDownPageID = 50378;
    LookupPageID = 50378;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Reciept No."; Code[20])
        {
            Caption = 'Reciept No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Documnet No."; Code[20])
        {
            Caption = 'Documnet No.';
            DataClassification = CustomerContent;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Invoice,Payment';
            OptionMembers = " ",Invoice,Payment;
        }
        field(6; "Template Name"; Code[10])
        {
            Caption = 'Template Name';
            DataClassification = CustomerContent;
        }
        field(7; "Batch Name"; Code[10])
        {
            Caption = 'Batch Name';
            DataClassification = CustomerContent;
        }
        field(8; "Enrollment No."; Code[10])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(12; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(13; "Apply To Doc No."; Code[20])
        {
            Caption = 'Apply To Doc No.';
            DataClassification = CustomerContent;
        }
        field(14; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
        }
        field(15; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(16; "Transaction No."; Code[20])
        {
            Caption = 'Transaction No.';
            DataClassification = CustomerContent;
        }
        field(17; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = CustomerContent;
        }
        field(18; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = CustomerContent;
        }
        field(19; "Success/Fail"; Option)
        {
            Caption = 'Success/Fail';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Success,Failed';
            OptionMembers = " ",Success,Failed;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(21; "Post Status"; Text[250])
        {
            Caption = 'Post Status';
            DataClassification = CustomerContent;
        }
        field(22; "Apply Remarks"; Text[250])
        {
            Caption = 'Apply Remarks';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Reciept No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

