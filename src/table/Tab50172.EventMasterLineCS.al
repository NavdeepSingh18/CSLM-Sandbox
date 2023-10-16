table 50172 "Event Master Line-CS"
{
    // version V.001-CS

    Caption = 'Event Master Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "Education Event-CS";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; Role; Code[20])
        {
            Caption = 'Role';
            DataClassification = CustomerContent;
            TableRelation = "SLcm Portal Roles-CS";
        }
        field(4; "Reminder Days"; DateFormula)
        {
            Caption = 'Reminder Days';
            DataClassification = CustomerContent;
        }
        field(5; "Alert Type"; Option)
        {
            Caption = 'Alert Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Email,SMS,Both';
            OptionMembers = Email,SMS,Both;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

