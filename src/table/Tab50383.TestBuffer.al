table 50383 "Test Buffer"
{
    Caption = 'Test Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        Field(2; "SLcM ID"; Code[20])
        {
            Caption = 'SLcM ID';
            DataClassification = CustomerContent;
        }
        Field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "18 Digit Test ID"; Text[18])
        {
            Caption = '18 Digit Test ID';
            DataClassification = CustomerContent;
        }
        field(5; Test; Text[50])
        {
            Caption = 'Test';
            DataClassification = CustomerContent;
        }
        field(6; "18 Digit Student ID"; Text[18])
        {
            Caption = '18 Digit Student ID';
            DataClassification = CustomerContent;
        }
        field(7; "MCAT Test Score"; Decimal)
        {
            Caption = 'MCAT Test Score';
            DataClassification = CustomerContent;
        }
        field(8; "NBME Comp Test Score"; Decimal)
        {
            Caption = 'NBME Comp Test Score';
            DataClassification = CustomerContent;
        }
        field(9; "New MCAT 2015 Test Score"; Decimal)
        {
            Caption = 'New MCAT 2015 Test Score';
            DataClassification = CustomerContent;
        }
        field(10; "Overall Score"; Decimal)
        {
            Caption = 'Overall Score';
            DataClassification = CustomerContent;
        }
        field(11; "MCAT Biological Science"; Decimal)
        {
            Caption = 'MCAT Biological Science';
            DataClassification = CustomerContent;
        }
        field(12; "MCAT Physical Science"; Decimal)
        {
            Caption = 'MCAT Physical Science';
            DataClassification = CustomerContent;
        }
        field(13; "MCAT Total Score"; Decimal)
        {
            Caption = 'MCAT Total Score';
            DataClassification = CustomerContent;
        }
        field(14; "MCAT Verbal Reasoning"; Decimal)
        {
            Caption = 'MCAT Verbal Reasoning';
            DataClassification = CustomerContent;
        }
        field(15; "MCAT Writing"; Decimal)
        {
            Caption = 'MCAT Writing';
            DataClassification = CustomerContent;
            Description = 'Not in used';        //07-09-2021
            ObsoleteState = Pending;
        }
        field(16; "Test Date"; Date)
        {
            Caption = 'Test Date';
            DataClassification = CustomerContent;
        }
        field(17; "USMLE Step 1 Score"; Decimal)
        {
            Caption = 'USMLE Step 1 Score';
            DataClassification = CustomerContent;
        }
        field(18; "USMLE Step 2 CK Score"; Decimal)
        {
            Caption = 'USMLE Step 2 CK Score';
            DataClassification = CustomerContent;
        }
        field(19; "USMLE Step 2 CS Score"; Text[2])
        {
            Caption = 'USMLE Step 2 CS Score';
            DataClassification = CustomerContent;
        }
        field(20; "USMLE Test Score"; Decimal)
        {
            Caption = 'USMLE Test Score';
            DataClassification = CustomerContent;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(23; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        field(24; "MCAT Psychological"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; "MCAT Writing 1"; Text[20])
        {
            Caption = 'MCAT Writing';
            DataClassification = CustomerContent;

        }

    }
    keys
    {
        key(Key1; "Student No.", "SLcM ID", "Line No.")
        {
            Clustered = true;
        }
    }

}
