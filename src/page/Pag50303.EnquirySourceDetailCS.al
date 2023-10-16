page 50303 "Enquiry Source Detail-CS"
{
    // version V.001-CS

    //   No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    //   01   17/09/09    Kathir                      Form Created by Kathir
    //   02   29/10/09    Vandhana   Edit-OnPush()    To make the form editable.

    Caption = 'Enquiry Source Detail';
    Editable = true;
    PageType = List;
    SourceTable = "Enquiry Source-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
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
}