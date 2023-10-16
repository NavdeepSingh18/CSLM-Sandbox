table 50445 Ethnicity
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Ethnicity List";
    LookupPageId = "Ethnicity List";
    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Ethnicity Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(4; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(5; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

}