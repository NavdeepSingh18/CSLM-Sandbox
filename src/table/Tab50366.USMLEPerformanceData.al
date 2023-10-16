table 50366 "USMLE Performance Data"
{
    DataClassification = ToBeClassified;
    Caption = 'USMLE Performance Data';


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = True;

        }
        field(2; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Rest of Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "S/G"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "USMLE ID"; Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Unique Medical School ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Step Exam"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",CBSE,CCSE,CCSSE,"STEP 1","STEP 2 CS","STEP 2 CK";
            OptionCaption = ' ,CBSE,CCSE,CCSSE,STEP 1,STEP 2 CS,STEP 2 CK';
        }
        field(8; "Date of Exam"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "P/F"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "3 Digit Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Score Available Until"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Remarks; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Published Document No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Published; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Result Matched"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Duplicate; Boolean)
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

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
        IF (Duplicate = True) and ("Result Matched" = true) then
            Error('Entry No : %1 can not be modified', Rec."Entry No.");

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}