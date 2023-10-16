table 50255 "Discipline MalPractice-CS"
{
    // version V.001-CS

    Caption = 'Discipline MalPractice-CS';
    DrillDownPageID = "Discpl Master-Mal Practic-CS";
    LookupPageID = "Discpl Master-Mal Practic-CS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Offence Description"; Text[250])
        {
            Caption = 'Offence Description';
            DataClassification = CustomerContent;
        }
        field(3; "Discipline Classification"; Option)
        {
            Caption = 'Discipline Classification';
            DataClassification = CustomerContent;

            OptionCaption = ' ,Minor Offences,Major Offences-I, Major Offences-II';
            OptionMembers = " ","Minor Offences","Major Offences-I"," Major Offences-II";
        }
        field(4; Severity; Code[10])
        {
            Caption = 'Severity';
            DataClassification = CustomerContent;
            TableRelation = "Discipline Level-CS";
        }
        field(5; Category; Code[10])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

