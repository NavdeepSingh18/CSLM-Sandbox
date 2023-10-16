pageextension 50521 "pageextension50521" extends "Apply Customer Entries"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CalcType = CalcType::Direct THEN BEGIN
      Cust.GET("Customer No.");
      ApplnCurrencyCode := Cust."Currency Code";
    #4..7

    GLSetup.GET();

    IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
      CalcApplnAmount;
    PostingDone := FALSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..10

    #11..13
    */
    //end;
}

