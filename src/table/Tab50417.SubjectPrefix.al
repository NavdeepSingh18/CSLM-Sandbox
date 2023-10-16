table 50417 "Subject Prefix"
{
    DataClassification = CustomerContent;
    LookupPageId = "Subject Prefix";
    DrillDownPageId = "Subject Prefix";
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}