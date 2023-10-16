page 50662 "Hospital Inventory Factbox"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Hospital Inventory";
    DelayedInsert = true;
    Caption = 'Hospital Inventory Entries';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater("Hospital Inventory")
            {

                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Seats; Rec.Seats)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Consumed Seats"; Rec."Consumed Seats")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Available Seats"; Rec."Available Seats")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Block Reason Code"; Rec."Block Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Block Reason"; Rec."Block Reason")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}