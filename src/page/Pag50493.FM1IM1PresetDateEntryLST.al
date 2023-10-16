page 50493 "FM1/IM1 Preset Date Entry LST"
{
    Caption = 'FM1/IM1 Preset Date Entry';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FM1/IM1 Date Preset Entry";
    SourceTableView = where(Status = const(Open));
    CardPageId = "FM1/IM1 Preset Date Entry Card";
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
            }
        }
    }
}