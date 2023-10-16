table 50518 "Transcript"
{
    DataClassification = CustomerContent;
    Caption = 'Transcript';


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Object Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Object Id';
        }
        field(3; "Object Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Object Name';
        }
        field(4; "Course Code 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code 1';

        }
        field(5; "Course Code 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code 2';

        }
        field(6; "Course Code 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code 3';

        }
        field(7; "Course Code 4"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code 4';

        }
        field(8; "Course Code 5"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code 5';

        }
        field(9; "Course Code 6"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code 6';

        }
        field(10; "Course Code"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }


    }

    keys
    {
        key(PK; "Object Id", "Course Code")
        {
            Clustered = true;
        }
    }

}
