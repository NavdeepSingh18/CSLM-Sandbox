tableextension 50529 "tableextension50529" extends "Approval Entry" 
{
    // version NAVW19.00.00.46621-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    GetCustVendorDetails Function     Code added for Assign Value in CustVendorNo Variable Field.

    //Unsupported feature: Variable Insertion (Variable: RequisitionHeaderCS) (VariableCollection) on "GetCustVendorDetails(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "GetCustVendorDetails(PROCEDURE 6)".

    //procedure GetCustVendorDetails();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT RecRef.GET("Record ID to Approve") THEN
          EXIT;

        #4..19
              CustVendorNo := Customer."No.";
              CustVendorName := Customer.Name;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..22
        //Code added for Assign Value in CustVendorNo Variable Field::CSPL-00136::02-05-2019: Start
          DATABASE::"Requisition Header-CS":
          BEGIN
            RecRef.SETTABLE(RequisitionHeaderCS);
            CustVendorNo := RequisitionHeaderCS."No.";
          END;
        //Code added for Assign Value in CustVendorNo Variable Field::CSPL-00136::02-05-2019: End
        END;
        */
    //end;
}

