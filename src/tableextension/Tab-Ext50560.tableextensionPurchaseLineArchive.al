tableextension 50560 "tableextension50560" extends "Purchase Line Archive" 
{
    // version NAVW19.00.00.46621,NAVIN9.00.00.46621-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    Dimension Value Code - OnLookup   Added New Fields
    fields
    {
        field(50000;"Indent No";Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50001;"Indent Line No";Integer)
        {
            Description = 'CS Field Added 02-05-2019';
        }
    }
}

