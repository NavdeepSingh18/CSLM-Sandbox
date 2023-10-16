table 50162 "MalPractice Level-CS"
{
    // version V.001-CS

    Caption = 'MalPractice Level-CS';

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2;Description;Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

