page 50482 "UNVClkshpSite_DateApprovalLST"
{
    Caption = 'Clerkship Preferred Site and Date Approval List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ClerkshipSiteAndDateSelection;
    SourceTableView = sorting("Creation Date") where(Confirmed = filter(true), Status = filter("Pending for Approval"));
    CardPageId = UNVClkshpSite_DateApprovalCRD;
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
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Site ID"; Rec."Confirmed Site ID")
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Site ID';
                }
                field("Confirmed Site Name"; Rec."Confirmed Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Site Name';
                }
                field("Special Accommodation Required"; Rec."Special Accommodation Required")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Preferred Start Date"; Rec."Preferred Start Date")
                {
                    ApplicationArea = All;
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
            action("Allocate Automatically")
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Allocate;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    ClerkshipSiteAndDateSelection_1: Record ClerkshipSiteAndDateSelection;
                    HospitalInventory: Record "Hospital Inventory";
                    RSL: Record "Roster Scheduling Line";
                    ConfirmedSeats: Integer;
                    UsedSeats: Integer;
                    DocumentPending: Boolean;
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                    Text001Lbl: Label 'Application(s)      #############1#############\';
                    Text002Lbl: Label 'Application In Progress      #############2#############\';
                begin
                    if not confirm('Do you want to Allocate Preferred Site Automatically for the Selected Records?') then
                        exit;

                    W.Open('Allocating Sites.\' + Text001Lbl + Text002Lbl);
                    T := 0;
                    C := 0;

                    ClerkshipSiteAndDateSelection.Reset();
                    ClerkshipSiteAndDateSelection.SetCurrentKey("Student Type");
                    ClerkshipSiteAndDateSelection.Ascending(false);
                    CurrPage.SetSelectionFilter(ClerkshipSiteAndDateSelection);
                    ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", '');
                    ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                    if ClerkshipSiteAndDateSelection.FindSet() then begin
                        T := ClerkshipSiteAndDateSelection.Count();
                        repeat
                            C += 1;
                            W.Update(1, Format(C) + ' of ' + Format(T));
                            W.Update(2, ClerkshipSiteAndDateSelection."Application No.");

                            FM1IM1DatePresetEntry.Reset();
                            if FM1IM1DatePresetEntry.Get(ClerkshipSiteAndDateSelection."Preset Start Date ID") then;

                            // DocumentPending := CheckDocumentsApproval(ClerkshipSiteAndDateSelection."Student No.");

                            if (DocumentPending = false) and (ClerkshipSiteAndDateSelection."Confirmed Site ID" = '') then begin
                                HospitalInventory.Reset();
                                HospitalInventory.SetCurrentKey("Hospital ID", "Academic Year", "Course Code");
                                HospitalInventory.SetRange("Hospital ID", Rec."First Preferred Site ID");
                                HospitalInventory.SetRange("Start Date", Rec."Preferred Start Date");
                                HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
                                HospitalInventory.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
                                HospitalInventory.SetFilter(Status, '<>%1', HospitalInventory.Status::Blocked);
                                if HospitalInventory.FindFirst() then begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Hospital ID", "Course Code", "Start Date");
                                    RSL.SetRange("Hospital ID", Rec."First Preferred Site ID");
                                    RSL.SetRange("Start Date", Rec."Preferred Start Date");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
                                    RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
                                    UsedSeats := RSL.Count;

                                    ConfirmedSeats := 0;
                                    ClerkshipSiteAndDateSelection_1.Reset();
                                    ClerkshipSiteAndDateSelection_1.SetCurrentKey("Confirmed Site ID", "Preferred Start Date", Status);
                                    ClerkshipSiteAndDateSelection_1.SetRange("Confirmed Site ID", Rec."First Preferred Site ID");
                                    ClerkshipSiteAndDateSelection_1.SetRange("Preferred Start Date", Rec."Preferred Start Date");
                                    ClerkshipSiteAndDateSelection_1.SetFilter(Status, '%1|%2|%3',
                                    ClerkshipSiteAndDateSelection_1.Status::" ",
                                    ClerkshipSiteAndDateSelection_1.Status::"Pending for Approval",
                                    ClerkshipSiteAndDateSelection_1.Status::Approved);
                                    IF ClerkshipSiteAndDateSelection_1.FindSet() then
                                        ConfirmedSeats := ClerkshipSiteAndDateSelection_1.Count;

                                    if HospitalInventory.Seats - UsedSeats - ConfirmedSeats > 0 then begin
                                        ClerkshipSiteAndDateSelection.Validate("First Site Confirmed", true);
                                        ClerkshipSiteAndDateSelection.Modify();
                                    end;
                                end;
                            end;

                            if (DocumentPending = false) and (ClerkshipSiteAndDateSelection."Confirmed Site ID" = '') then begin
                                HospitalInventory.Reset();
                                HospitalInventory.SetCurrentKey("Hospital ID", "Academic Year", "Course Code");
                                HospitalInventory.SetRange("Hospital ID", Rec."Second Preferred Site ID");
                                HospitalInventory.SetRange("Start Date", Rec."Preferred Start Date");
                                HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
                                HospitalInventory.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
                                if HospitalInventory.FindFirst() then begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Hospital ID", "Course Code", "Start Date");
                                    RSL.SetRange("Hospital ID", Rec."Second Preferred Site ID");
                                    RSL.SetRange("Start Date", Rec."Preferred Start Date");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
                                    RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
                                    UsedSeats := RSL.Count;

                                    ConfirmedSeats := 0;
                                    ClerkshipSiteAndDateSelection_1.Reset();
                                    ClerkshipSiteAndDateSelection_1.SetCurrentKey("Confirmed Site ID", "Preferred Start Date", Status);
                                    ClerkshipSiteAndDateSelection_1.SetRange("Confirmed Site ID", Rec."Second Preferred Site ID");
                                    ClerkshipSiteAndDateSelection_1.SetRange("Preferred Start Date", Rec."Preferred Start Date");
                                    ClerkshipSiteAndDateSelection_1.SetFilter(Status, '%1|%2|%3',
                                    ClerkshipSiteAndDateSelection_1.Status::" ",
                                    ClerkshipSiteAndDateSelection_1.Status::"Pending for Approval",
                                    ClerkshipSiteAndDateSelection_1.Status::Approved);
                                    IF ClerkshipSiteAndDateSelection_1.FindSet() then
                                        ConfirmedSeats := ClerkshipSiteAndDateSelection_1.Count;

                                    if HospitalInventory.Seats - UsedSeats - ConfirmedSeats > 0 then begin
                                        ClerkshipSiteAndDateSelection.Validate("Second Site Confirmed", true);
                                        ClerkshipSiteAndDateSelection.Modify();
                                    end;
                                end;
                            end;

                            if (DocumentPending = false) and (ClerkshipSiteAndDateSelection."Confirmed Site ID" = '') then begin
                                HospitalInventory.Reset();
                                HospitalInventory.SetCurrentKey("Hospital ID", "Academic Year", "Course Code");
                                HospitalInventory.SetRange("Hospital ID", Rec."Second Preferred Site ID");
                                HospitalInventory.SetRange("Start Date", Rec."Preferred Start Date");
                                HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
                                HospitalInventory.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
                                if HospitalInventory.FindFirst() then begin
                                    RSL.Reset();
                                    RSL.SetCurrentKey("Hospital ID", "Course Code", "Start Date");
                                    RSL.SetRange("Hospital ID", Rec."Second Preferred Site ID");
                                    RSL.SetRange("Start Date", Rec."Preferred Start Date");
                                    RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
                                    RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
                                    UsedSeats := RSL.Count;

                                    ConfirmedSeats := 0;
                                    ClerkshipSiteAndDateSelection_1.Reset();
                                    ClerkshipSiteAndDateSelection_1.SetCurrentKey("Confirmed Site ID", "Preferred Start Date", Status);
                                    ClerkshipSiteAndDateSelection_1.SetRange("Confirmed Site ID", Rec."Second Preferred Site ID");
                                    ClerkshipSiteAndDateSelection_1.SetRange("Preferred Start Date", Rec."Preferred Start Date");
                                    ClerkshipSiteAndDateSelection_1.SetFilter(Status, '%1|%2|%3',
                                    ClerkshipSiteAndDateSelection_1.Status::" ",
                                    ClerkshipSiteAndDateSelection_1.Status::"Pending for Approval",
                                    ClerkshipSiteAndDateSelection_1.Status::Approved);
                                    IF ClerkshipSiteAndDateSelection_1.FindSet() then
                                        ConfirmedSeats := ClerkshipSiteAndDateSelection_1.Count;

                                    if HospitalInventory.Seats - UsedSeats - ConfirmedSeats > 0 then begin
                                        ClerkshipSiteAndDateSelection.Validate("Third Site Confirmed", true);
                                        ClerkshipSiteAndDateSelection.Modify();
                                    end;
                                end;
                            end;
                        until ClerkshipSiteAndDateSelection.Next() = 0;
                    end;

                    W.Close();
                    Message('Hospital Automatic Allocation completed successfully.');
                end;
            }

            action("Approve")
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    CALE: Record "Clerkship Activity Log Entries";
                    DocumentPending: Boolean;
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                    ApprovedCount: Integer;
                    Text001Lbl: Label 'Progress      @@@@@@@@@@1@@@@@@@@@@\';
                    Text002Lbl: Label 'Entry In Progress      #############2#############\';
                begin
                    W.Open('Approving Date & Site Selection.\' + Text001Lbl + Text002Lbl);
                    T := 0;
                    C := 0;

                    ClerkshipSiteAndDateSelection.Reset();
                    CurrPage.SetSelectionFilter(ClerkshipSiteAndDateSelection);
                    ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                    ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
                    T := ClerkshipSiteAndDateSelection.Count;

                    if not Confirm('You have Selected %1 Records.\\\Do you want to Approve?', true, T) then
                        exit;

                    ClerkshipSiteAndDateSelection.Reset();
                    CurrPage.SetSelectionFilter(ClerkshipSiteAndDateSelection);
                    ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                    ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
                    if ClerkshipSiteAndDateSelection.FindSet() then begin
                        T := ClerkshipSiteAndDateSelection.Count;
                        C := 0;
                        ApprovedCount := 0;
                        repeat
                            C += 1;
                            W.Update(1, Round(C / T * 10000, 1));
                            W.Update(2, ClerkshipSiteAndDateSelection."Application No.");

                            // DocumentPending := CheckDocumentsApproval(ClerkshipSiteAndDateSelection."Student No.");

                            if (DocumentPending = false) and (ClerkshipSiteAndDateSelection."Confirmed Site ID" <> '') then begin
                                ApprovedCount += 1;
                                ClerkshipSiteAndDateSelection.Validate(Status, ClerkshipSiteAndDateSelection.Status::Approved);
                                ClerkshipSiteAndDateSelection.Modify();
                            end;
                        until ClerkshipSiteAndDateSelection.Next() = 0;
                    end;
                    W.Close();
                    CALE.InsertLogEntry(3, 2, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', '7015', 'Family Medicine I/Internal Medicine I');
                    Message('%1 Date & Site Selection Applications Approved Successfully Out of %2.', ApprovedCount, T);
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

    trigger OnOpenPage()
    Begin
        SPLAccommodationRequired := true;
    End;

    trigger OnAfterGetRecord()
    Begin
        SPLAccommodationRequired := Rec."Special Accommodation Required";
    End;

    var
        SPLAccommodationRequired: Boolean;
}