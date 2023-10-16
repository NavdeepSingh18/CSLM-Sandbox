table 50484 "Residency Status"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Residency Status List";
    // LookupPageId = "Residency Status List";

    fields
    {
        field(1; "Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Residency";
            Caption = 'Type';
        }
        field(2; "Sub Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Residency Status","NRMP Status","CaRMS Status","San Francisco Status";
            Caption = 'Sub Type';
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(4; "Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }

        field(10; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
        field(11; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;
        }
        field(12; "Chart Code"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Chart Code';
        }
    }

    keys
    {
        key(PK; Type, "Sub Type", Code)
        {
            Clustered = true;
        }
        key(Search; Description)
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;
    end;
}