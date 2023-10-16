page 50801 "Application Option Master"
{
    Caption = 'Application Option Master';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Application Option Master-CS";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
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