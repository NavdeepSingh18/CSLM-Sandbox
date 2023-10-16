Page 50783 "Course Degree"
{
    Caption = 'Course Degree';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Course Degree";
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
                field("Degree Code"; Rec."Degree Code")
                {
                    ApplicationArea = All;
                }
                field("Degree Name"; Rec."Degree Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                // field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }
                field("With Expiration"; Rec."With Expiration")
                {
                    ApplicationArea = All;
                }
                field("Expiration Duration"; Rec."Expiration Duration")
                {
                    ApplicationArea = All;
                }
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
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}