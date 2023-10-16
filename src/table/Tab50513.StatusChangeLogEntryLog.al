table 50513 "Status Change Log Entry Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Status change From"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Status change to"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Modified by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(13; "Reason Description"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Begin Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Comment"; Text[255])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "NSLDS Withdrawal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "AdEnrollStuNum"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "AdTermCode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(17; "Date Of Determination"; Date)
        {
            Caption = 'Date of Determination';
            DataClassification = ToBeClassified;
        }
        field(18; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = ToBeClassified;
        }
        field(50000; "Log Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Log Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Insertion,Modification,Rename,Deletion;
        }
        field(50002; "Log Entry Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Log Entry Created On"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {

        key(PK; "Log Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Modified On")
        {
        }
        key(Key3; "Entry No")
        {
        }
    }

}