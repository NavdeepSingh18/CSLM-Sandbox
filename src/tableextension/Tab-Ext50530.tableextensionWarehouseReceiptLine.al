tableextension 50530 "tableextension50530" extends "Warehouse Receipt Line" 
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS

    fields
    {
        field(50000;"Requisition No.";Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50001;"Requisition Line No.";Integer)
        {
            Description = 'CS Field Added 02-05-2019';
        }
    }
}

