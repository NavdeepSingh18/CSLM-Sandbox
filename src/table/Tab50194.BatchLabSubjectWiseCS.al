table 50194 "Batch&Lab Subject Wise-CS"
{
    // version V.001-CS

    Caption = 'Batch&Lab Subject Wise-CS';

    fields
    {
        field(1; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Batch; Text[100])
        {
            Caption = 'Batch';
            DataClassification = CustomerContent;
        }
        field(4; "Number of Lab"; Integer)
        {
            Caption = 'Number of Lab';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }
}

