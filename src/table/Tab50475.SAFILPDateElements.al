table 50475 "SAFI LP Date Elements"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = CustomerContent;

        }
        Field(3; Term; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(4; "LP Start"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(5; "LP End"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(6; "EST Disbursement"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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