page 50498 "FM1_IM1 Hospital Avail FactBox"
{
    PageType = CardPart;
    UsageCategory = None;
    SourceTable = ClerkshipSiteAndDateSelection;
    Caption = 'FM1/IM1 Seats Availability';

    layout
    {
        area(Content)
        {
            group("Clinical Documents")
            {
                field(DocumentFlag; DocumentFlag)
                {
                    ApplicationArea = All;
                    Caption = 'Document Exception Flag';
                    Style = Strong;
                }
                field(TiterFlag; TiterFlag)
                {
                    ApplicationArea = All;
                    Caption = 'Titer Exception Flag';
                    Style = Strong;
                }
                field(DocumentStatus; DocumentStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Document''s Status';
                    Style = Strong;
                    OptionCaption = 'Pending,In-Progress,Completed';
                }
            }
            group("Preferred Date")
            {
                field("Preset Start Date ID"; Rec."Preset Start Date ID")
                {
                    ApplicationArea = All;
                    Caption = 'Preset ID:';
                    Style = Favorable;
                }
                field("Preferred Start Date"; format(Rec."Preferred Start Date") + ' - ' + Format(Rec."End Date"))
                {
                    ApplicationArea = All;
                    Caption = 'Period:';
                    Style = Favorable;
                }

            }
            group("FM1/IM1 Seats Availability")
            {
                field("First Preferred Site Name"; Rec."First Preferred Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Preference 1:';
                    Style = Unfavorable;
                }
                field(TotalInvtSite_1; TotalInvtSite_1)
                {
                    ApplicationArea = All;
                    Caption = 'Total Seats';
                }

                field(SeatsUnderApproval_1; SeatsUnderApproval_1)
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Seats';
                    trigger OnDrillDown()
                    var
                        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."First Preferred Site ID");
                        ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1', ClerkshipSiteAndDateSelection.Status::Published);
                        Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                    end;
                }
                field(UsedSeats_1; UsedSeats_1)
                {
                    ApplicationArea = All;
                    Caption = 'Scheduled/Published Seats';
                    trigger OnDrillDown()
                    var
                        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."First Preferred Site ID");
                        ClerkshipSiteAndDateSelection.SetFilter(Status, '%1', ClerkshipSiteAndDateSelection.Status::Published);
                        Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                    end;
                }
                field(InvtSite_1; InvtSite_1)
                {
                    ApplicationArea = All;
                    Caption = 'Available Seats';
                    Style = Strong;
                }

                field("Second Preferred Site Name"; Rec."Second Preferred Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Preference 2:';
                    Style = Unfavorable;
                }
                field(TotalInvtSite_2; TotalInvtSite_2)
                {
                    ApplicationArea = All;
                    Caption = 'Total Seats';
                }
                field(SeatsUnderApproval_2; SeatsUnderApproval_2)
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Seats';
                    trigger OnDrillDown()
                    var
                        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."Second Preferred Site ID");
                        ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1', ClerkshipSiteAndDateSelection.Status::Published);
                        Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                    end;
                }
                field(UsedSeats_2; UsedSeats_2)
                {
                    ApplicationArea = All;
                    Caption = 'Scheduled/Published Seats';
                    trigger OnDrillDown()
                    var
                        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."Second Preferred Site ID");
                        ClerkshipSiteAndDateSelection.SetFilter(Status, '%1', ClerkshipSiteAndDateSelection.Status::Published);
                        Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                    end;
                }
                field(InvtSite_2; InvtSite_2)
                {
                    ApplicationArea = All;
                    Caption = 'Available Seats';
                    Style = Strong;
                }
                field("Third Preferred Site Name"; Rec."Third Preferred Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Preference 3:';
                    Style = Unfavorable;
                }
                field(TotalInvtSite_3; TotalInvtSite_3)
                {
                    ApplicationArea = All;
                    Caption = 'Total Seats';
                }
                field(SeatsUnderApproval_3; SeatsUnderApproval_3)
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Seats';
                    trigger OnDrillDown()
                    var
                        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."Third Preferred Site ID");
                        ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1', ClerkshipSiteAndDateSelection.Status::Published);
                        Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                    end;
                }
                field(UsedSeats_3; UsedSeats_3)
                {
                    ApplicationArea = All;
                    Caption = 'Scheduled/Published Seats';
                    trigger OnDrillDown()
                    var
                        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."Third Preferred Site ID");
                        ClerkshipSiteAndDateSelection.SetFilter(Status, '%1', ClerkshipSiteAndDateSelection.Status::Published);
                        Page.RunModal(Page::"FM1/IM1 Clerkship Student List", ClerkshipSiteAndDateSelection);
                    end;
                }
                field(InvtSite_3; InvtSite_3)
                {
                    ApplicationArea = All;
                    Caption = 'Available Seats';
                    Style = Strong;
                }
                group("Confirmed Site Information")
                {
                    field("Confirmed Site ID"; Rec."Confirmed Site ID")
                    {
                        ApplicationArea = all;
                        Style = StrongAccent;
                    }
                    field("Confirmed Site Name"; Rec."Confirmed Site Name")
                    {
                        ApplicationArea = all;
                        Style = StrongAccent;
                    }
                }
            }
        }
    }

    var
        DocumentFlag: Boolean;
        TiterFlag: Boolean;
        DocumentStatus: Option " ","In-Progress",Completed;
        TotalInvtSite_1: Integer;
        SeatsUnderApproval_1: Integer;
        UsedSeats_1: Integer;
        InvtSite_1: Integer;
        TotalInvtSite_2: Integer;
        SeatsUnderApproval_2: Integer;
        UsedSeats_2: Integer;
        InvtSite_2: Integer;
        TotalInvtSite_3: Integer;
        SeatsUnderApproval_3: Integer;
        UsedSeats_3: Integer;
        InvtSite_3: Integer;

    trigger OnAfterGetRecord()
    var
        StudentMaster: Record "Student Master-CS";
    begin
        CallReturnInventory();
        TiterFlag := false;
        DocumentFlag := false;
        DocumentStatus := DocumentStatus::" ";

        StudentMaster.Reset();
        if StudentMaster.Get(Rec."Student No.") then begin
            TiterFlag := StudentMaster."Titer Exception Flag";
            DocumentFlag := StudentMaster."Document Exception Flag";
            DocumentStatus := StudentMaster."Clinical Document Status";
        end;
    end;

    procedure CallReturnInventory()
    begin
        TotalInvtSite_1 := 0;
        SeatsUnderApproval_1 := 0;
        UsedSeats_1 := 0;
        InvtSite_1 := 0;
        IF (Rec."First Site Confirmed" = true) and (Rec.Status <> Rec.Status::Published) then
            SeatsUnderApproval_1 := 1;

        IF Rec."First Preferred Site ID" <> '' then
            ReturnInventoryValues(Rec."First Preferred Site ID", TotalInvtSite_1, SeatsUnderApproval_1, UsedSeats_1, InvtSite_1);


        TotalInvtSite_2 := 0;
        SeatsUnderApproval_2 := 0;
        UsedSeats_2 := 0;
        InvtSite_2 := 0;
        IF (Rec."Second Site Confirmed" = true) and (Rec.Status <> Rec.Status::Published) then
            SeatsUnderApproval_2 := 1;

        IF Rec."Second Preferred Site ID" <> '' then
            ReturnInventoryValues(Rec."Second Preferred Site ID", TotalInvtSite_2, SeatsUnderApproval_2, UsedSeats_2, InvtSite_2);


        TotalInvtSite_3 := 0;
        SeatsUnderApproval_3 := 0;
        UsedSeats_3 := 0;
        InvtSite_3 := 0;
        IF (Rec."Third Site Confirmed" = true) and (Rec.Status <> Rec.Status::Published) then
            SeatsUnderApproval_3 := 1;

        if Rec."Third Preferred Site ID" <> '' then
            ReturnInventoryValues(Rec."Third Preferred Site ID", TotalInvtSite_3, SeatsUnderApproval_3, UsedSeats_3, InvtSite_3);
    end;

    procedure ReturnInventoryValues(SiteID: Code[20]; Var TotalInvtSite: Integer; Var SeatsUnderApproval: Integer; Var UsedSeats: Integer;
        Var InvtSite: Integer)
    var
        HospitalInventory: Record "Hospital Inventory";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
        RSL: Record "Roster Scheduling Line";
        Char10: Char;
        Char13: Char;
        NewLine: Text[10];
    begin
        Char10 := 10;
        Char13 := 13;
        NewLine := format(Char10) + format(Char13);

        FM1IM1DatePresetEntry.Reset();
        if FM1IM1DatePresetEntry.Get(Rec."Preset Start Date ID") then;

        TotalInvtSite := 0;
        UsedSeats := 0;
        SeatsUnderApproval := 0;

        HospitalInventory.Reset();
        HospitalInventory.SetCurrentKey("Hospital ID", "Academic Year", "Clerkship Type");
        HospitalInventory.SetRange("Hospital ID", SiteID);
        HospitalInventory.SetRange("Start Date", FM1IM1DatePresetEntry."Start Date");
        HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
        if HospitalInventory.FindFirst() then
            TotalInvtSite := HospitalInventory.Seats;

        RSL.Reset();
        RSL.SetCurrentKey("Hospital ID", "Course Code", "Start Date");
        RSL.SetRange("Hospital ID", SiteID);
        RSL.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
        RSL.SetRange("Start Date", Rec."Preferred Start Date");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
        RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
        UsedSeats := RSL.Count;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Confirmed Site ID", "Preferred Start Date", Status);
        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", SiteID);
        ClerkshipSiteAndDateSelection.SetRange("Preferred Start Date", Rec."Preferred Start Date");
        ClerkshipSiteAndDateSelection.SetFilter(Status, '%1|%2|%3',
        ClerkshipSiteAndDateSelection.Status::" ",
        ClerkshipSiteAndDateSelection.Status::"Pending for Approval",
        ClerkshipSiteAndDateSelection.Status::Approved);
        IF ClerkshipSiteAndDateSelection.FindSet() then
            SeatsUnderApproval := ClerkshipSiteAndDateSelection.Count;

        InvtSite := TotalInvtSite - UsedSeats - SeatsUnderApproval;
    end;
}