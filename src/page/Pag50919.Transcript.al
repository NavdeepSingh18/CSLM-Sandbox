page 50919 "Transcript"
{
    Caption = 'Transcript';
    Editable = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = Transcript;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Object Id"; Rec."Object Id")
                {
                    ApplicationArea = All;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
