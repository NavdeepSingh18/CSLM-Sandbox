tableextension 50547 "tableextension50547" extends "Purch. Rcpt. Line"
{
    // version NAVW19.00.00.46621,NAVIN9.00.00.46621-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    InitFromPurchLine Function        Code added for Requisition Line CS Issued Qty Field Update.
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

    //Unsupported feature: Variable Insertion (Variable: RequisitionLineCS) (VariableCollection) on "InitFromPurchLine(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "InitFromPurchLine(PROCEDURE 12)".

    //procedure InitFromPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
   .INIT();
    TRANSFERFIELDS(PurchLine);
    IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
    #4..22
      IF Factor <> 1 THEN
        UpdateJobPrices(Factor);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..25
    //Code added for Requisition Line Issued Qty Field Update::CSPL-00136::30-04-2019: Start
    IF RequisitionLineCS.GET("Indent No" , "Indent Line No") THEN BEGIN
      RequisitionLineCS."Issued Qty" := Quantity;
      RequisitionLineCS.Modify();
    END;
    //Code added for Requisition Line Issued Qty Field Update::CSPL-00136::30-04-2019: End
    */
    //end;
}

