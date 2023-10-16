page 50293 "Graduation Detail-CS"
{
    // version V.001-CS

    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   29/10/09    Vandhana   Edit-OnPush()    To make the form editable.

    Caption = 'Graduation Detail';
    PageType = List;
    SourceTable = "Graduation Master-CS";
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