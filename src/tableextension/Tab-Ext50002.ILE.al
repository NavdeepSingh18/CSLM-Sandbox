tableextension 50002 ILEExt extends "Item Ledger Entry"
{
    fields
    {
        Field(50000; "Purchase Budget"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}