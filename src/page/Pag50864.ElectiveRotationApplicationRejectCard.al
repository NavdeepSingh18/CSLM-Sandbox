page 50864 "Offer Appl Reject Card"
{
    PageType = Card;
    Caption = 'Elective Rotation Application Rejection';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Same Rotation Applied"; Rec."Same Rotation Applied")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Reject Reason Description"; Rec."Reject Reason Description")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Confirm")
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'Ctrl+M';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    Rec.TestField("Reject Reason");
                    Rec.TestField("Reject Reason Description");
                    if not Confirm('Do you want to reject Elective Rotation Offer Application for the Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        exit;
                    Rec.Validate("Approval Status", "Approval Status"::Rejected);
                    Rec.Modify();
                    CALE.InsertLogEntry(7, 5, Rec."Student No.", Rec."Student Name", Rec."Application No.", Rec."Reject Reason", Rec."Reject Reason Description", Rec."Elective Course Code", Rec."Rotation Description");
                    Message('Elective Rotation Offer Application %1 for the Student %2 (%3) has Rejected.', Rec."Application No.", Rec."Student No.", Rec."Student Name");
                    CurrPage.Close();
                end;
            }
        }
    }
}