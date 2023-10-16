page 50615 "FM1/IM1 Clerkship Student List"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = ClerkshipSiteAndDateSelection;
    Caption = 'Clerkship Student List';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Preferred Start Date"; Rec."Preferred Start Date")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Site ID"; Rec."Confirmed Site ID")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Site Name"; Rec."Confirmed Site Name")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}