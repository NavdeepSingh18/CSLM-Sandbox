table 50421 "State SLcM CS"
{
    DataClassification = CustomerContent;
    Caption = 'State List';
    // DrillDownPageId = "State SLcM List CS";
    // LookupPageId = "State SLcM List CS";
    fields
    {
        field(1; Code; code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Country/Region Code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(4; Block; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; Code, "Country/Region Code")
        {
            Clustered = true;
        }
    }
}