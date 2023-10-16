page 50484 "UNVClkshpSite_DateLST+"
{
    Caption = 'Clerkship Preferred Site and Date Approved/Rejected List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ClerkshipSiteAndDateSelection;
    SourceTableView = where(Confirmed = filter(true), Status = filter(Approved | Reject | Scheduled | Published));
    CardPageId = "UNVClkshpSite_DateCRD+";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Special Accommodation Required"; Rec."Special Accommodation Required")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Site ID"; Rec."Confirmed Site ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Confirmed Site Name"; Rec."Confirmed Site Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Preferred Start Date"; Rec."Preferred Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                }
                field("Status On"; Rec."Status On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;
}