tableextension 50591 "tableextension50591" extends "Purch. Inv. Line"
{
    // version NAVW19.00.00.46621,NAVIN9.00.00.46621-CS

    fields
    {
        field(50000; "Indent No"; Code[20])
        {
            Description = 'CS Field Added 03-05-2019';
        }
        field(50001; "Indent Line No"; Integer)
        {
            Description = 'CS Field Added 03-05-2019';
        }
        field(50002; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; "Requisition Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5004; "Quantity Bool"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        Field(50005; "Final Quotation"; Boolean)
        {
            DataClassification = CustomerContent;

        }
        field(50006; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Item Budget Name";
        }
        field(50007; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
                field(50008; Remark; Text[250])
        {
            //CSPL-00307
            DataClassification = ToBeClassified;
        }
    }
}

