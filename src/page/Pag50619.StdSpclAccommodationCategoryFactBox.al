page 50619 "Std Spcl Acc. Category FactBox"
{
    Caption = 'Special Accommodation Category FactBox';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Std Spl Accommodation Category";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    //MultiLine = true;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Accommodation Category Code"; Rec."Accommodation Category Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}