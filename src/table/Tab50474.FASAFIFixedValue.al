table 50474 "FA SAFI Fied Value"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; FA_ID; Integer)
        {
            DataClassification = CustomerContent;

        }
        Field(2; FieldValue; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; FA_ID)
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