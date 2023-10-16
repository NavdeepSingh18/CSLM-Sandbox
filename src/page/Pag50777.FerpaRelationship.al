page 50777 "Ferpa Relationship"
{
    Caption = 'Ferpa Relationship';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Ferpa Relationship";
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Relationship Code"; Rec."Relationship Code")
                {
                    ApplicationArea = All;
                }
                field("Relationship Name"; Rec."Relationship Name")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
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
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}