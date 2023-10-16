table 50198 "Student Subject Log Temp-CS"
{
    // version V.001-CS

    Caption = 'Student Subject Log Temp-CS';

    fields
    {
        field(1; "Sr. No."; Integer)
        {
            Caption = 'Sr. No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(5; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(6; "Document Type"; Text[30])
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(7; "Table Type"; Option)
        {
            Caption = 'Table Type';
            DataClassification = CustomerContent;
            OptionMembers = ,"Student Subject","Student Optional Subject";
        }
        field(8; "Old Value"; Code[10])
        {
            Caption = 'Old Value';
            DataClassification = CustomerContent;
        }
        field(9; "New Value"; Code[10])
        {
            Caption = 'New Value';
            DataClassification = CustomerContent;
        }
        field(10; "Modified By"; Text[100])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
        }
        field(11; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
        }
        field(12; "Grade Change Type"; Option)
        {
            Caption = 'Grade Change Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Revaluation,MakeUp';
            OptionMembers = " ",Revaluation,MakeUp;
        }
        field(13; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sr. No.")
        {
        }
    }

    fieldgroups
    {
    }
}

