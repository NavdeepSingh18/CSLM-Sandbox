page 50936 "Notes Factbox"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Interaction Log Entry";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    //MultiLine = true;
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}