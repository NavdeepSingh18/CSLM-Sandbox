page 50476 "FM1_IM1 Date Preset List"
{
    Caption = 'FM1/IM1 Date Presets';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FM1/IM1 Date Preset Entry";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Preset No."; Rec."Preset No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
        area(factboxes)
        {
            part("FM1/IM1 Preset Information"; "FM1IM1 Preset Factbox")
            {
                ApplicationArea = All;
                Caption = 'FM1/IM1 Preset Information';
                SubPageLink = "Preset No." = field("Preset No.");
            }
        }
    }
}