table 50303 "Scholarship Wise Student-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/07/2019       OnModify()                                Any Record change then upadted Boolean Mark


    fields
    {
        field(1; "Scholarship No"; Code[20])
        {
            Caption = 'Scholarship No';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Registration No"; Code[20])
        {
            Caption = 'Registration No';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(6; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(7; "Program Code"; Code[20])
        {
            Caption = 'Program Code';
            DataClassification = CustomerContent;
        }
        field(8; "Program Name"; Text[50])
        {
            Caption = 'Program Name';
            DataClassification = CustomerContent;
        }
        field(9; "Student No"; Code[20])
        {
            Caption = 'Student No"';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(10; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(11; "Pre-Qualifying Test Name"; Text[30])
        {
            Caption = 'Pre-Qualifying Test Name';
            DataClassification = CustomerContent;
        }
        field(12; "Pre-Qualifying Test Roll No"; Code[10])
        {
            Caption = 'Pre-Qualifying Test Roll No';
            DataClassification = CustomerContent;
        }

        field(13; "Pre-Qualifying Test Rank"; Code[10])
        {
            Caption = 'Pre-Qualifying Test Rank';
            DataClassification = CustomerContent;
        }
        field(14; "Pre-Qualifying Test Score"; Code[10])
        {
            Caption = 'Pre-Qualifying Test Score';
            DataClassification = CustomerContent;
        }
        field(15; "Scholarship Applied For"; Code[20])
        {
            Caption = 'Scholarship Applied For';
            DataClassification = CustomerContent;
        }
        field(16; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Applied,Approved,Rejected';
            OptionMembers = Applied,Approved,Rejected;
        }
        field(17; "Approved/Rejected By"; Text[30])
        {
            Caption = 'Approved/Rejected By';
            DataClassification = CustomerContent;
        }
        field(18; "Aprroved/Rejected Date"; Date)
        {
            Caption = 'Aprroved/Rejected Date';
            DataClassification = CustomerContent;
        }
        field(19; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(20; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Scholarship No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Any Record change then upadted Boolean Mark::CSPL-00114::16072019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Any Record change then upadted Boolean Mark::CSPL-00114::16072019: End
    end;
}

