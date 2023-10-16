page 50135 "Allocation(Room) List-CS"
{
    caption = 'FA SAFI Fied Value';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "FA SAFI Fied Value";
    DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(FA_ID; Rec.FA_ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA_ID field.';
                }
                field(FieldValue; Rec.FieldValue)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FieldValue field.';
                }
            }


        }
    }
}

