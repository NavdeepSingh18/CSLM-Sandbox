table 50357 "Clinical Curriculum"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(3; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Created On"; Date)
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

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}