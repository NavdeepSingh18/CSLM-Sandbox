tableextension 50515 "tableextension50515" extends "Vendor Amount"
{
    // version NAVW17.00-CS

    fields
    {
        field(4; Semester; Code[10])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
    }
}

