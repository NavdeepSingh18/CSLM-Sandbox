tableextension 50597 PurchRecptHeaderExtension extends "Purch. Rcpt. Header"
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
}