tableextension 50522 "tableextension50522" extends "Item Amount"
{
    // version NAVW17.00-CS

    fields
    {
        field(4; "Item No.2"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = Item;
        }
    }
}

