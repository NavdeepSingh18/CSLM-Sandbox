table 50239 "Examination Log Details-CS"
{
    // version V.001-CS

    Caption = 'Examination Log Details-CS';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = CustomerContent;
        }
        field(2; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;

        }
        field(3; "Time Slot"; Code[20])
        {
            Caption = 'Time Slot';
            DataClassification = CustomerContent;
        }
        field(4; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
        }
        field(5; "Room Capacity"; Integer)
        {
            Caption = 'Room Capacity';
            DataClassification = CustomerContent;
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS".Code;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12092019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12092019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

