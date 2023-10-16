table 50161 "Examination Type Master-CS"
{
    // version V.001-CS

    Caption = 'Examination Type Master-CS';
    DrillDownPageID = "Exam Classification Detail-CS";
    LookupPageID = "Exam Classification Detail-CS";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
    }

    keys
    {
        key(Key1; "Code", "Exam Type")
        {
        }
    }

    fieldgroups
    {
    }
}

