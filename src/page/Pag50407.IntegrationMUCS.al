page 50407 "Integration MU-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Calc - OnAction()                           Code added for Integration function call

    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Value_1; ValueTest1)
                {
                    Caption = 'Value Test1';
                    ApplicationArea = All;
                }
                field(Value_2; Valuetest2)
                {
                    Caption = 'Value Test2';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        ValueTest1: Text;
        Valuetest2: Text;

}