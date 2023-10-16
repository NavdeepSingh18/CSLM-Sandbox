tableextension 50575 "tableextension50575" extends "Item Journal Line"
{
    // version NAVW19.00.00.46773,NAVIN9.00.00.46773-CS

    fields
    {
        modify("Document Type")
        {
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly,Item Indent';

        }
        field(50000; "Indent For"; Option)
        {
            Description = 'CS Field Added 03-05-2019';
            OptionCaption = ',Department,Employee,Student';
            OptionMembers = ,Department,Employee,Student;
        }
        field(50001; Remarks; Text[60])
        {
            Description = 'CS Field Added 03-05-2019';
        }
        Field(50002; "Purchase Budget"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}

