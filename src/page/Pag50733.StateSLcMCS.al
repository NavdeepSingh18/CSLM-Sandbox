page 50733 "State SLcM List CS"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "State SLcM CS";
    Caption = 'State List';
    DelayedInsert = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}