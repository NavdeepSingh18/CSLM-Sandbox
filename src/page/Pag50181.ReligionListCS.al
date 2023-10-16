page 50181 "Religion List-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID     Date      Trigger              Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  03-02-19  E&dit - OnAction()   code added to make the form editable.

    Caption = 'Religion List-CS';
    Editable = false;
    PageType = Card;

    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Religion Master-CS";

    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(" E&dit")
            {
                ApplicationArea = All;
                Caption = ' E&dit';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Code added to make the form editable::CSPL-00174::030219: Start
                    CurrPage.EDITABLE := TRUE;
                    //Code added to make the form editable::CSPL-00174::030219: End
                end;
            }
        }
    }
}