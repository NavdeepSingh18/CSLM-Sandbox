page 50501 "FM1/IM1 Roster Card+"
{
    Caption = 'FM1/IM1 Roster';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Published"; Rec."No. of Students Published")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Schedule"; Rec."No. of Students Schedule")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Completed"; Rec."No. of Students Completed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Cancelled"; Rec."No. of Students Cancelled")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students In-Review"; Rec."No. of Students In-Review")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
            }
            part(Lines; "FM1_IM1 Confirmed Students SP")
            {
                ApplicationArea = All;
                SubPageLink = "Rotation ID" = field("Rotation ID");
            }
            group("Miscellaneous Details")
            {
                field("DME Contact No."; Rec."DME Contact No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("DME Name"; Rec."DME Name")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("DME Phone No."; Rec."DME Phone No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("DME Recipient"; Rec."DME Recipient")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }

                field("Preceptor Contact No."; Rec."Preceptor Contact No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Preceptor Name"; Rec."Preceptor Name")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Preceptor Phone No."; Rec."Preceptor Phone No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Preceptor Recipient"; Rec."Preceptor Recipient")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled On"; Rec."Scheduled On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled By"; Rec."Scheduled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason Code"; Rec."Cancel Reason Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Cancel Rotation")
            {
                ApplicationArea = All;
                Caption = 'Cancel Rotation';
                ShortcutKey = 'Ctrl+T';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CancelAllLines;
                Enabled = Not CancelledRotation;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                begin
                    RosterSchedulingHeader.Reset();
                    RosterSchedulingHeader.FilterGroup(2);
                    RosterSchedulingHeader.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingHeader.FilterGroup(0);
                    Page.RunModal(Page::"Rotation Cancellation", RosterSchedulingHeader);
                end;
            }
            action("Add Student")
            {
                ApplicationArea = All;
                Caption = 'Add Student';
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = AddToHome;
                Visible = false;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                begin
                    RosterSchedulingHeader.Reset();
                    RosterSchedulingHeader.FilterGroup(2);
                    RosterSchedulingHeader.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingHeader.FilterGroup(0);
                    // Page.RunModal(Page::"Add Student in Rotation", RosterSchedulingHeader);
                end;
            }
            action("Update DME and Preceptor Details")
            {
                ApplicationArea = All;
                Caption = 'Update DME and Preceptor Details';
                ShortcutKey = 'Ctrl+T';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DefaultDimension;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                begin
                    Rec.TestField("Course Code");
                    Rec.TestField("Hospital ID");
                    Rec.TestField("Start Date");

                    RosterSchedulingHeader.Reset();
                    RosterSchedulingHeader.FilterGroup(2);
                    RosterSchedulingHeader.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingHeader.FilterGroup(0);
                    // Page.RunModal(Page::"DME and Preceptor Update", RosterSchedulingHeader);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CancelledRotation := false;
        if Rec.Status = Rec.Status::Cancelled then
            CancelledRotation := true;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
        CALE: Record "Clerkship Activity Log Entries";
    begin
        Rec.CalcFields("No. of Students", "No. of Students Cancelled");
        if Rec."No. of Students" > Rec."No. of Students Cancelled" then
            Error('Rotation deletion not allowed as (Scheduled/Published) students exists in Rotation Lines');

        UserSetup.Reset();
        if UserSetup.Get(UserId) then
            if UserSetup."Rotation Deletion Allowed" = false then
                Error('You are not allowed to Delete a Rotation.');

        CALE.InsertLogEntry(5, 9, '', '', Rec."Rotation ID", 'BFRD', 'Blank FM1/IM1 Rotation Header Delete', '', '');
    end;

    var
        CancelledRotation: Boolean;
}