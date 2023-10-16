page 50454 "Offer Application Factbox"
{
    Caption = 'Rotation Offer Information';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Rotation Offers";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            group("Offer Information")
            {
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                }
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    Editable = false;
                }
            }
            group("Application Information")
            {
                Editable = false;
                group("Details")
                {
                    ShowCaption = false;
                    field("Total Applied Students"; NoOfAppliedStudents)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Total Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                    field(OpenApplications; OpenApplications)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Open Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Open);
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                    field(ConfirmedApplications; ConfirmedApplications)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Confirmed Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Confirmed);
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                    field(ApprovedApplications; ApprovedApplications)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Approved Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::Approved);
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                    field(RejectedApplications; RejectedApplications)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Rejected Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.",Rec."Offer No.");
                            RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::Rejected);
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                    field(ApprovalPending; ApprovalPending)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Pending for Approval';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::"Pending for Approval");
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                }
                group("Rotation Information")
                {
                    Caption = 'Rotation Information';
                    field(ScheduledApplications; ScheduledApplications)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Scheduled Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange("Rotation Status", RotationOfferApplication."Rotation Status"::Scheduled);
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                    field(PublishedApplications; PublishedApplications)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Published Applications';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RotationOfferApplication.Reset();
                            RotationOfferApplication.FilterGroup(2);
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange("Rotation Status", RotationOfferApplication."Rotation Status"::Published);
                            RotationOfferApplication.FilterGroup(0);
                            Page.RunModal(Page::"Rotation Offer Applied List", RotationOfferApplication);
                        end;
                    }
                }
            }
        }
    }

    var
        RotationOfferApplication: Record "Rotation Offer Application";
        NoOfAppliedStudents: Integer;
        OpenApplications: Integer;
        ConfirmedApplications: Integer;
        RejectedApplications: Integer;
        ApprovalPending: Integer;
        ApprovedApplications: Integer;
        ScheduledApplications: Integer;
        PublishedApplications: Integer;


    trigger OnAfterGetRecord()
    begin
        NoOfAppliedStudents := 0;
        OpenApplications := 0;
        ConfirmedApplications := 0;
        RejectedApplications := 0;
        ApprovalPending := 0;
        ApprovedApplications := 0;
        ScheduledApplications := 0;
        PublishedApplications := 0;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        NoOfAppliedStudents := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Open);
        OpenApplications := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Confirmed);
        ConfirmedApplications := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange(Status, RotationOfferApplication.Status::Rejected);
        RejectedApplications := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::"Pending for Approval");
        ApprovalPending := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange("Approval Status", RotationOfferApplication."Approval Status"::Approved);
        ApprovedApplications := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange("Rotation Status", RotationOfferApplication."Rotation Status"::Scheduled);
        ScheduledApplications := RotationOfferApplication.Count;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
        RotationOfferApplication.SetRange("Rotation Status", RotationOfferApplication."Rotation Status"::Published);
        PublishedApplications := RotationOfferApplication.Count;
    end;
}