Page 50784 "Honors"
{
    Caption = 'Honors';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = Honors;
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;
    DelayedInsert = True;

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
                Field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Min. Range"; Rec."Min. Range")
                {
                    ApplicationArea = All;
                }
                field("Max. Range"; Rec."Max. Range")
                {
                    ApplicationArea = All;
                }
                // field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}