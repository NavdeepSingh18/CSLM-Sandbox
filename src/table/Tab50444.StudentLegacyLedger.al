table 50444 "Student Legacy Ledger"
{
    Caption = 'Student Legacy Ledger';
    DataCaptionFields = "Student Number", "Student Name";
    // LookupPageId = "Studen Legacy Ledger";
    fields
    {
        field(1; "Student Number"; code[20])
        {
            Caption = 'Student Number';
            NotBlank = true;
            DataClassification = CustomerContent;

        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(3; "SyCampusID"; Code[10])
        {
            Caption = 'SyCampusID';
            DataClassification = CustomerContent;
        }
        field(4; "Enrollment"; Code[20])
        {
            Caption = 'Enrollment';
            DataClassification = CustomerContent;
        }
        field(5; "TN"; Code[10])
        {
            Caption = 'TN';
        }
        field(6; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Payment,Invoice,Charge,Debit Memo,Credit Memo,Refund';
            OptionMembers = " ",Payment,Invoice,Charge,"Debit Memo","Credit Memo",Refund;
        }
        field(7; "Bill Code"; Code[20])
        {
            Caption = 'Bill Code';
            DataClassification = CustomerContent;
        }
        field(8; "Bill Code Desc"; Text[50])
        {
            Caption = 'Bill Code Desc';
            DataClassification = CustomerContent;
        }
        field(9; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(11; "Post Date"; Date)
        {
            Caption = 'Post Date';
            DataClassification = CustomerContent;
        }
        field(12; "Reference"; Text[300])
        {
            Caption = 'Reference';
            DataClassification = CustomerContent;
        }
        field(13; "Receipt #"; Code[20])
        {
            Caption = 'Receipt #';
            DataClassification = CustomerContent;
        }

        field(14; "Check Date"; Date)
        {
            Caption = 'Check Date';
            DataClassification = CustomerContent;
        }
        field(15; "Check #"; Code[20])
        {
            Caption = 'Check #';
            DataClassification = CustomerContent;
        }
        field(16; "Charge Type"; Option)
        {
            Caption = 'Charge Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Housing,Tuition';
            OptionMembers = " ",Housing,Tuition;
        }
        field(17; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(18; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Credit Card,EFT,Check,Other,ACH,Cash,Non-Cash';
            OptionMembers = " ","Credit Card",EFT,Check,Other,ACH,Cash,"Non-Cash";
        }
        field(19; "Running Balance"; Decimal)
        {
            Caption = 'Running Balance';
            DataClassification = CustomerContent;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(22; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(23; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        Field(24; "1098-T Form"; Boolean)
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
        key(Key1; "Post Date")
        {

        }
        key(Key2; "Student Number", Enrollment, TN)
        {

        }

        key(Key3; Date)
        {
            SumIndexFields = Amount;
        }
        key(Key4; Date, Amount)
        {
            SumIndexFields = Amount;
        }

    }
}