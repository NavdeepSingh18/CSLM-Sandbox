tableextension 50596 PurchInvHeaderExtension extends "Purch. Inv. Header"
{
    fields
    {
        field(50004; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}