table 50477 "Grade Level"
{
    Caption = 'Grade Level';

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[60])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Code)
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

}