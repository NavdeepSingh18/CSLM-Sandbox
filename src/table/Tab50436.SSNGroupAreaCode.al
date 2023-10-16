table 50436 "SSN Group Area Code"
{
    DataClassification = CustomerContent;
    Caption = 'SSN Group Area Code';

    fields
    {
        field(1; "Group Code"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Group Code';
        }
        field(2; "Area Code"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Area Code';
        }

        field(3; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(4; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(PK; "Group Code", "Area Code")
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
        if xRec.Updated = Updated then
            Updated := True;

    end;

}