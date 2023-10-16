table 50237 "SMS Mail Trigger Event-CS"
{
    // version V.001-CS
    Caption = 'SMS Mail Trigger Event-CS';

    fields
    {
        field(1; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
        }
        field(2; Receiver; Text[30])
        {
            Caption = 'Receiver';
            DataClassification = CustomerContent;
        }
        field(3; "Day Before"; Code[10])
        {
            Caption = 'Day Before';
            DataClassification = CustomerContent;
        }
        field(4; "Mail SP"; Text[100])
        {
            Caption = 'Mail SP';
            DataClassification = CustomerContent;
        }
        field(5; "SMS SP"; Text[100])
        {
            Caption = '';
            DataClassification = CustomerContent;
        }
        field(6; "Mail Text"; Text[200])
        {
            Caption = 'SMS SP';
            DataClassification = CustomerContent;
        }
        field(7; "SMS Text"; Text[200])
        {
            Caption = 'SMS Text';
            DataClassification = CustomerContent;
        }
        field(8; "Alert Type"; Text[30])
        {
            Caption = 'Alert Type';
            DataClassification = CustomerContent;
        }
        field(9; "Academic Year"; Text[30])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(10; Semster; Text[30])
        {
            Caption = 'Semster';
            DataClassification = CustomerContent;
        }
        field(11; Course; Text[30])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 1 Code"; Text[30])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(13; "Global Dimension 2 Code"; Text[30])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Event Code", Receiver)
        {
        }
    }

    fieldgroups
    {
    }
}

