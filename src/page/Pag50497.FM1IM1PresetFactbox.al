page 50497 "FM1IM1 Preset Factbox"
{
    Caption = 'FM1IM1 Preset Facts';
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FM1/IM1 Date Preset Entry";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            group(Information)
            {
                group("Application Information")
                {
                    field(AppliedStudents; AppliedStudents)
                    {
                        ApplicationArea = All;
                        Caption = 'Applied Students';
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        begin
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.FilterGroup(2);
                            ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.FilterGroup(0);
                            Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection)
                        end;
                    }
                    field(PendingforApproval; PendingforApproval)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending for Approval';
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        begin
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.FilterGroup(2);
                            ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
                            ClerkshipSiteAndDateSelection.FilterGroup(0);
                            Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection)
                        end;
                    }
                    field(ApprovedApplications; ApprovedApplications)
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Applications';
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        begin
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.FilterGroup(2);
                            ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetFilter(Status, '%1|%2|%3', ClerkshipSiteAndDateSelection.Status::Approved,
                            ClerkshipSiteAndDateSelection.Status::Published, ClerkshipSiteAndDateSelection.Status::Scheduled);
                            ClerkshipSiteAndDateSelection.FilterGroup(0);
                            Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection)
                        end;
                    }
                }
                group("Rotation Information")
                {
                    field(ScheduledRotation; ScheduledRotation)
                    {
                        ApplicationArea = All;
                        Caption = 'Scheduled Rotation';
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        begin
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.FilterGroup(2);
                            ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::Scheduled);
                            ClerkshipSiteAndDateSelection.FilterGroup(0);
                            Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection)
                        end;
                    }
                    field(PublishedRotation; PublishedRotation)
                    {
                        ApplicationArea = All;
                        Caption = 'Published Rotation';
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        begin
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.FilterGroup(2);
                            ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::Published);
                            ClerkshipSiteAndDateSelection.FilterGroup(0);
                            Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection)
                        end;
                    }
                }
            }
        }
    }

    var
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        AppliedStudents: Integer;
        ApprovedApplications: Integer;
        PendingforApproval: Integer;
        ScheduledRotation: Integer;
        PublishedRotation: Integer;

    trigger OnAfterGetRecord()
    begin
        AppliedStudents := 0;
        ApprovedApplications := 0;
        PendingforApproval := 0;
        ScheduledRotation := 0;
        PublishedRotation := 0;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
        ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
        AppliedStudents := ClerkshipSiteAndDateSelection.Count;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
        ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
        ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
        PendingforApproval := ClerkshipSiteAndDateSelection.Count;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
        ClerkshipSiteAndDateSelection.SetFilter(Status, '%1|%2|%3', ClerkshipSiteAndDateSelection.Status::Approved,
        ClerkshipSiteAndDateSelection.Status::Published, ClerkshipSiteAndDateSelection.Status::Scheduled);
        ApprovedApplications := ClerkshipSiteAndDateSelection.Count;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
        ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::Scheduled);
        ScheduledRotation := ClerkshipSiteAndDateSelection.Count;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
        ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::Published);
        PublishedRotation := ClerkshipSiteAndDateSelection.Count;
    end;

    /// <summary> 
    /// Description for OpenApprovalScreen.
    /// </summary>
    procedure OpenApprovalScreen()
    begin
        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.FilterGroup(2);
        ClerkshipSiteAndDateSelection.SetRange("Preset Start Date ID", Rec."Preset No.");
        ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
        ClerkshipSiteAndDateSelection.FilterGroup(0);
        PAGE.RunModal(Page::UNVClkshpSite_DateApprovalCRD, ClerkshipSiteAndDateSelection);
    end;
}