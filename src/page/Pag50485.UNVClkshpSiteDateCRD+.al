page 50485 "UNVClkshpSite_DateCRD+"
{
    PageType = Card;
    UsageCategory = None;
    Caption = 'Clerkship Preferred Site and Date Confirmed/Rejected';
    SourceTable = ClerkshipSiteAndDateSelection;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group("Preferred Date & Sites")
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
                field("Special Accommodation Required"; Rec."Special Accommodation Required")
                {
                    ApplicationArea = All;
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
                            SiteStyle_1 := 'None';
                            SiteStyle_2 := 'None';
                            SiteStyle_3 := 'None';

                            if Rec."First Site Confirmed" then
                                SiteStyle_1 := 'Unfavorable';
                        end;
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
                            SiteStyle_1 := 'None';
                            SiteStyle_2 := 'None';
                            SiteStyle_3 := 'None';

                            if Rec."Second Site Confirmed" then
                                SiteStyle_2 := 'Unfavorable';
                        end;
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
                            SiteStyle_1 := 'None';
                            SiteStyle_2 := 'None';
                            SiteStyle_3 := 'None';

                            if Rec."First Site Confirmed" then
                                SiteStyle_3 := 'Unfavorable';
                        end;
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

                group("Selected Values")
                {
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
                        Editable = false;
                        Style = Unfavorable;
                        ShowMandatory = true;
                    }
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
                Visible = SPLAccommodationRequired;
                trigger OnAction()
                var
                    SpclAccommodationApplication: Record "Spcl Accommodation Application";
                    SplAccommodationEntryCard: Page "Spl Accommodation Entry Card";
                begin
                    Rec.TestField("Special Accommodation Required");
                    SpclAccommodationApplication.Reset();
                    SpclAccommodationApplication.SetRange("Clinical Reference No.", Rec."Application No.");
                    SpclAccommodationApplication.SetRange("Student No.", Rec."Student No.");
                    if SpclAccommodationApplication.FindFirst() then begin
                        Clear(SplAccommodationEntryCard);
                        SplAccommodationEntryCard.SetVariables(Rec."Application No.");
                        SplAccommodationEntryCard.SetTableView(SpclAccommodationApplication);
                        SplAccommodationEntryCard.SetRecord(SpclAccommodationApplication);
                        SplAccommodationEntryCard.Editable := true;
                        SplAccommodationEntryCard.Run();
                    end;
                end;
            }

            action("Cancel Approval")
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReverseLines;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not (Rec.Status in [Rec.Status::Approved]) then
                        Error('Application Status %1.Approval Canncellation is not allowed at this stage.', Rec.Status);
                    if Confirm('Do you want some Cancel the approval of the FM1/IM1 application?') then begin
                        Rec.Validate(Confirmed, false);
                        Rec.Validate(Status, Rec.Status::" ");
                        Rec.Modify();

                        CALE.InsertLogEntry(4, 10, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', 'Application Approval Cancelled', '9920', 'Family Medicine I/Internal Medicine I');
                        Message('Application Approval Cancelled.\Check the application on Site & Date Selection Entry window.');
                    end;
                end;
            }
        }
    }

    var
        SiteStyle_1: Text[30];
        SiteStyle_2: Text[30];
        SiteStyle_3: Text[30];
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
    end;
}