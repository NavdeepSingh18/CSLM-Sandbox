page 50483 "UNVClkshpSite_DateApprovalCRD"
{
    PageType = Card;
    UsageCategory = None;
    Caption = 'Clerkship Preferred Site and Date Approval';
    SourceTable = ClerkshipSiteAndDateSelection;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            group("Preferred Site & Date Approval")
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group("First Preference")
                {
                    field("First Site Confirmed"; Rec."First Site Confirmed")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Confirmed';
                        Style = Unfavorable;

                        trigger OnValidate()
                        begin
                            CallReturnInventory();
                            if (InvtSite_1 <= 0) AND (Rec."First Site Confirmed" = true) then
                                Error('Inventory not available. Please check Inventory breakup for the site %1 (%2)', Rec."First Preferred Site ID", Rec."First Preferred Site Name");
                            SiteStyle_1 := 'None';
                            SiteStyle_2 := 'None';
                            SiteStyle_3 := 'None';

                            if Rec."First Site Confirmed" then
                                SiteStyle_1 := 'Unfavorable';
                        end;
                    }
                    field("Control002"; InvtSiteText_1)
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Breakup';
                        Style = Strong;
                        Editable = false;
                        MultiLine = true;
                        Visible = false;
                    }

                    field("First Preferred Site Type"; Rec."First Preferred Site Type")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Type';
                        StyleExpr = SiteStyle_1;
                        Editable = false;
                    }
                    field("First Preferred Site ID"; Rec."First Preferred Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Site ID';
                        StyleExpr = SiteStyle_1;
                        Editable = false;
                    }
                    field("First Preferred Site Name"; Rec."First Preferred Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Name';
                        StyleExpr = SiteStyle_1;
                        Editable = false;
                    }
                }
                group("Second Preference")
                {
                    field("Second Site Confirmed"; Rec."Second Site Confirmed")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Confirmed';
                        Style = Unfavorable;
                        trigger OnValidate()
                        begin
                            CallReturnInventory();

                            if (InvtSite_2 <= 0) AND (Rec."Second Site Confirmed" = true) then
                                Error('Inventory not available. Please check Inventory breakup for the site %1 (%2)', Rec."Second Preferred Site ID", Rec."Second Preferred Site Name");
                            SiteStyle_1 := 'None';
                            SiteStyle_2 := 'None';
                            SiteStyle_3 := 'None';

                            if Rec."Second Site Confirmed" then
                                SiteStyle_2 := 'Unfavorable';
                        end;
                    }
                    field(Contro2002; InvtSiteText_2)
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Breakup';
                        Style = Strong;
                        Editable = false;
                        MultiLine = true;
                        Visible = false;
                    }

                    field("Second Preferred Site Type"; Rec."Second Preferred Site Type")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Type';
                        StyleExpr = SiteStyle_2;
                        Editable = false;
                    }
                    field("Second Preferred Site ID"; Rec."Second Preferred Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Site ID';
                        ShowMandatory = true;
                        StyleExpr = SiteStyle_2;
                        Editable = false;
                    }
                    field("Second Preferred Site Name"; Rec."Second Preferred Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Name';
                        StyleExpr = SiteStyle_2;
                    }
                }
                group("Third Preference")
                {
                    field("Third Site Confirmed"; Rec."Third Site Confirmed")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Confirmed';
                        Style = Unfavorable;
                        trigger OnValidate()
                        begin
                            CallReturnInventory();

                            if (InvtSite_3 <= 0) AND (Rec."Third Site Confirmed" = true) then
                                Error('Inventory not available. Please check Inventory breakup for the site %1 (%2)', Rec."Third Preferred Site ID", Rec."Third Preferred Site Name");
                            SiteStyle_1 := 'None';
                            SiteStyle_2 := 'None';
                            SiteStyle_3 := 'None';

                            if Rec."First Site Confirmed" then
                                SiteStyle_3 := 'Unfavorable';
                        end;
                    }
                    field("Contro3002"; InvtSiteText_3)
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Breakup';
                        Style = Strong;
                        Editable = false;
                        MultiLine = true;
                        Visible = false;
                    }

                    field("Third Preferred Site Type"; Rec."Third Preferred Site Type")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Type';
                        StyleExpr = SiteStyle_3;
                        Editable = false;
                    }
                    field("Third Preferred Site ID"; Rec."Third Preferred Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Site ID';
                        ShowMandatory = true;
                        StyleExpr = SiteStyle_3;
                        Editable = false;
                    }
                    field("Third Preferred Site Name"; Rec."Third Preferred Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Name';
                        StyleExpr = SiteStyle_3;
                    }
                }

                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group("Reject Reason")
                {
                    field("Reject Reason Code"; Rec."Reject Reason Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Reject Reason Description"; Rec."Reject Reason Description")
                    {
                        ApplicationArea = All;
                    }
                }

                group("Selected Values")
                {
                    Editable = false;
                    field("Special Accommodation Required"; Rec."Special Accommodation Required")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                    }

                    field("Preset Start Date ID"; Rec."Preset Start Date ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Preset Start Date ID';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Preferred Start Date"; Rec."Preferred Start Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Start Date';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Document Due Date"; Rec."Document Due Date")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }

                    field("Confirmed Site ID"; Rec."Confirmed Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Confirmed Site ID';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Confirmed Site Name"; Rec."Confirmed Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Confirmed Site Name';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Editable = false;
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Style = Unfavorable;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("FM1_IM1 Hospital Availability"; "FM1_IM1 Hospital Avail FactBox")
            {
                ApplicationArea = All;
                Caption = 'FM1/IM1 Hospital Seats Availability';
                SubPageLink = "Application No." = field("Application No.");
            }
            part("Accommodation Categories"; "Std Spcl Acc. Category FactBox")
            {
                Visible = SPLAccommodationRequired;
                ApplicationArea = All;
                Caption = 'Accommodation Categories';
                SubPageLink = "Clinical Reference No." = field("Application No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if Confirm('Do you want to approve the Preferred Sites and Start Date of Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then begin
                        Rec.TestField("Preset Start Date ID");
                        Rec.TestField("Confirmed Site ID");
                        Rec.Validate(Status, Rec.Status::Approved);
                        Rec.Modify();

                        CALE.InsertLogEntry(3, 2, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', '7015', 'Family Medicine I/Internal Medicine I');
                        // ClinicalNotification.FM1IM1PreferredStartDateConfirmation("Student No.");
                        Message('FM1/IM1 Application No. %1 for the Student No. %2 (%3) has Approved.', Rec."Application No.", Rec."Student No.", Rec."Student Name");
                    end;
                end;
            }

            action(Reject)
            {
                ShortcutKey = 'Ctrl+J';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNoti: Codeunit "Clinical Notification";
                begin
                    if Confirm('Do you want to reject the Preferred Sites and Start Date of Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then begin
                        Rec.TestField("Reject Reason Code");
                        Rec.Validate(Confirmed, false);
                        Rec.Validate(Status, Rec.Status::Reject);
                        CALE.InsertLogEntry(3, 5, Rec."Student No.", Rec."Student Name", Rec."Application No.", Rec."Reject Reason Code", Rec."Reject Reason Description", '7015', 'Family Medicine I/Internal Medicine I');
                        Rec.Modify();
                        // ClinicalNoti.UpdatedSiteSelectionFormPending(Rec."Student No.", Rec);
                        Message('FM1/IM1 Application No. %1 has Rejected.', Rec."Application No.");
                    end;
                end;
            }
            action("Special Accommodation Application")
            {
                ShortcutKey = 'Ctrl+M';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ExciseApplyToLine;
                ApplicationArea = All;
                Enabled = SPLAccommodationRequired;
                trigger OnAction()
                var
                    SpclAccommodationApplication: Record "Spcl Accommodation Application";
                    SplAccommodationApprovalCRD: Page "Spl Accommodation Approval CRD";
                begin
                    Rec.TestField("Special Accommodation Required");
                    SpclAccommodationApplication.Reset();
                    SpclAccommodationApplication.SetRange("Clinical Reference No.", Rec."Application No.");
                    SpclAccommodationApplication.SetRange("Student No.", Rec."Student No.");
                    if SpclAccommodationApplication.FindFirst() then begin
                        Clear(SplAccommodationApprovalCRD);
                        SplAccommodationApprovalCRD.SetTableView(SpclAccommodationApplication);
                        SplAccommodationApprovalCRD.SetRecord(SpclAccommodationApplication);
                        SplAccommodationApprovalCRD.Editable := false;
                        SplAccommodationApprovalCRD.Run();
                    end;
                end;
            }
        }
    }

    var
        SiteStyle_1: Text[30];
        SiteStyle_2: Text[30];
        SiteStyle_3: Text[30];
        TotalInvtSite_1: Integer;
        BufferedSeats_1: Integer;
        UsedSeats_1: Integer;
        InvtSite_1: Integer;
        InvtSiteText_1: Text[250];
        TotalInvtSite_2: Integer;
        BufferedSeats_2: Integer;
        UsedSeats_2: Integer;
        InvtSite_2: Integer;
        InvtSiteText_2: Text[250];
        TotalInvtSite_3: Integer;
        BufferedSeats_3: Integer;
        UsedSeats_3: Integer;
        InvtSite_3: Integer;
        InvtSiteText_3: Text[250];
        SPLAccommodationRequired: Boolean;

    trigger OnAfterGetRecord()
    begin
        SPLAccommodationRequired := Rec."Special Accommodation Required";

        SiteStyle_1 := 'None';
        SiteStyle_2 := 'None';
        SiteStyle_3 := 'None';

        if Rec."First Site Confirmed" then
            SiteStyle_1 := 'Unfavorable';

        if Rec."Second Site Confirmed" then
            SiteStyle_2 := 'Unfavorable';

        if Rec."Third Site Confirmed" then
            SiteStyle_3 := 'Unfavorable';

        //CallReturnInventory();
    end;

    /// <summary> 
    /// Description for CallReturnInventory.
    /// </summary>
    procedure CallReturnInventory()
    begin
        TotalInvtSite_1 := 0;
        BufferedSeats_1 := 0;
        UsedSeats_1 := 0;
        InvtSite_1 := 0;
        InvtSiteText_1 := '';
        IF Rec."First Site Confirmed" then begin
            BufferedSeats_1 := 1;
            ReturnInventoryValues(Rec."First Preferred Site ID", TotalInvtSite_1, BufferedSeats_1, UsedSeats_1, InvtSite_1, InvtSiteText_1);
        end;

        TotalInvtSite_2 := 0;
        BufferedSeats_2 := 0;
        UsedSeats_2 := 0;
        InvtSite_2 := 0;
        InvtSiteText_2 := '';
        IF Rec."Second Site Confirmed" then begin
            BufferedSeats_2 := 1;
            ReturnInventoryValues(Rec."Second Preferred Site ID", TotalInvtSite_2, BufferedSeats_2, UsedSeats_2, InvtSite_2, InvtSiteText_2);
        end;

        TotalInvtSite_3 := 0;
        BufferedSeats_3 := 0;
        UsedSeats_3 := 0;
        InvtSite_3 := 0;
        InvtSiteText_3 := '';
        IF Rec."Third Site Confirmed" then begin
            BufferedSeats_3 := 1;
            ReturnInventoryValues(Rec."Third Preferred Site ID", TotalInvtSite_3, BufferedSeats_3, UsedSeats_3, InvtSite_3, InvtSiteText_3);
        end;

        CurrPage.Update(true);
    end;

    procedure ReturnInventoryValues(SiteID: Code[20]; Var TotalInvtSite: Integer; Var BufferedSeats: Integer; Var UsedSeats: Integer;
        Var InvtSite: Integer; Var InvtSiteText: Text[250])
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

        HospitalInventory.Reset();
        HospitalInventory.SetCurrentKey("Hospital ID", "Academic Year", "Course Code");
        HospitalInventory.SetRange("Hospital ID", SiteID);
        HospitalInventory.SetRange("Start Date", Rec."Preferred Start Date");
        HospitalInventory.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
        HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
        if HospitalInventory.FindFirst() then
            TotalInvtSite := HospitalInventory.Seats;

        RSL.Reset();
        RSL.SetCurrentKey("Hospital ID", "Course Code", "Start Date");
        RSL.SetRange("Hospital ID", SiteID);
        RSL.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
        RSL.SetRange("Start Date", Rec."Preferred Start Date");
        RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
        UsedSeats := RSL.Count;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Confirmed Site ID", "Preferred Start Date", Status);
        ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", SiteID);
        ClerkshipSiteAndDateSelection.Setrange("Preferred Start Date", Rec."Preferred Start Date");
        ClerkshipSiteAndDateSelection.SetFilter(Status, '%1|%2|%3',
        ClerkshipSiteAndDateSelection.Status::" ",
        ClerkshipSiteAndDateSelection.Status::"Pending for Approval",
        ClerkshipSiteAndDateSelection.Status::Approved);
        BufferedSeats := ClerkshipSiteAndDateSelection.Count;

        InvtSite := TotalInvtSite - UsedSeats - BufferedSeats;
        InvtSiteText := 'Total Seats:: ' + Format(TotalInvtSite) + '||Used Seats:: ' + Format(UsedSeats) +
        NewLine + 'Buffered Seats:: ' + Format(BufferedSeats) + '||Available Seats:: ' + Format(InvtSite);
    end;
}