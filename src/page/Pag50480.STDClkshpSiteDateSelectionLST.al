page 50480 "STDClkshpSite_DateSelectionLST"
{
    Caption = 'Clerkship Preferred Site and Date Selection List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ClerkshipSiteAndDateSelection;
    SourceTableView = sorting("Creation Date") order(descending);
    CardPageId = STDClkshpSite_DateSelectionCRD;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Preferred Start Date"; Rec."Preferred Start Date")
                {
                    ApplicationArea = All;
                }
                field("First Preferred Site Name"; Rec."First Preferred Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Preference';
                }
                field("Second Preferred Site Name"; Rec."Second Preferred Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Second Preference';
                }
                field("Third Preferred Site Name"; Rec."Third Preferred Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Third Preference';
                }
                field("Special Accommodation Required"; Rec."Special Accommodation Required")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Confirmed; Rec.Confirmed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Confirmed On"; Rec."Confirmed On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                {
                    ApplicationArea = All;
                }
                field("Preset Start Date ID"; Rec."Preset Start Date ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}