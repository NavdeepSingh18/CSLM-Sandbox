page 50361 "Branch List-CS"
{
    // version V.001-CS

    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   29/10/09    Vandhana   Edit-OnPush()    To make the form editable.

    Caption = 'Branch List-CS';
    Editable = true;
    PageType = List;
    SourceTable = "Department Head-CS";
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
                field("Head of the Department"; Rec."Head of the Department")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}