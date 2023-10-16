page 50439 "Roster Scheduling List"
{
    Caption = 'Roster Scheduling List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Header";
    //SourceTableView = sorting("Created On") order(descending) where("Clerkship Type" = filter(Core), "Entry Type" = filter(Clerkship), Status = const(Scheduled), "Rotation Confirmed" = const(false));
    SourceTableView = sorting("Created On") order(descending) where("Clerkship Type" = filter(Core), "Entry Type" = filter(Clerkship), Status = const(Scheduled));
    CardPageId = "Roster Scheduling Card";
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
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
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
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital Name"; Rec."Hospital Name")
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
                field("Umbrella Rotation"; Rec."Umbrella Rotation")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Caption = 'Umbrella Rotation';
                }
                field("Elective Mandatory"; Rec."Elective Mandatory")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Caption = 'Elective Mandatory';
                }
                field("No. of Students Schedule"; Rec."No. of Students Schedule")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students UNC"; Rec."No. of Students UNC")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    Caption = 'Total No. of Students';
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}