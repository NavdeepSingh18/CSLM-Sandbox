tableextension 50013 UsertTaskGroupMember extends "User Task Group Member"
{
    fields
    {
        field(50000; "Per User % Comp."; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
    }

    var
        myInt: Integer;
}