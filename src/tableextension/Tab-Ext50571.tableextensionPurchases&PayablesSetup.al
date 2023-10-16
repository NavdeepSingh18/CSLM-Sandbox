tableextension 50571 "tableextension50571" extends "Purchases & Payables Setup"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778,FIN1.0-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019                          Added New Fields.
    fields
    {
        field(50000; "Indent No."; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "No. Series";
        }
        field(50002; "AMC Over 1st Notification"; DateFormula)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50003; "AMC Over 2nd Notification"; DateFormula)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50004; "Payment List Notification"; Text[80])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50005; "Material not Rcvd Notification"; Text[80])
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50006; "Requisition No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}

