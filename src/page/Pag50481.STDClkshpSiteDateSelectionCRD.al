page 50481 "STDClkshpSite_DateSelectionCRD"
{
    PageType = Card;
    UsageCategory = None;
    Caption = 'Clerkship Preferred Site and Date Selection';
    SourceTable = ClerkshipSiteAndDateSelection;

    layout
    {
        area(Content)
        {
            group("Preferred Site & Date Selection")
            {
                Editable = not REc.Confirmed;
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        StudentMaster: Record "Student Master-CS";
                    begin
                        IF REc."Student No." <> '' then begin
                            StudentMaster.Reset();
                            if StudentMaster.Get(REc."Student No.") then;
                            REc.CheckRequiredExamOnApplication(StudentMaster);
                            SiteEdit_GHT();
                            CurrPage.Update(false);
                        end;
                    end;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                group("FM1/IM1 Date Preference")
                {
                    field("Preset Start Date ID"; Rec."Preset Start Date ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Preset Start Date ID';
                        Style = Unfavorable;
                        ShowMandatory = true;
                    }
                    field("Preferred Start Date"; Rec."Preferred Start Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Start Date';
                        Style = Unfavorable;
                        ShowMandatory = true;
                    }
                    field("No. of Weeks"; Rec."No. of Weeks")
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Weeks';
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Document Due Date"; Rec."Document Due Date")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                        Caption = 'Document Due Date';
                    }
                }

                group("First Preference")
                {
                    field("First Preferred Site ID"; Rec."First Preferred Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Site ID';
                        Style = Unfavorable;
                        Editable = NR_GHT;
                        ShowMandatory = true;
                    }
                    field("First Preferred Site Name"; Rec."First Preferred Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Name';
                        Style = Unfavorable;
                        Editable = false;
                    }
                }
                group("Second Preference")
                {
                    field("Second Preferred Site ID"; Rec."Second Preferred Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Site ID';
                        Style = Unfavorable;
                        trigger OnValidate()
                        begin
                            REc.TestField("First Preferred Site ID");
                        end;
                    }
                    field("Second Preferred Site Name"; Rec."Second Preferred Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Name';
                        Style = Unfavorable;
                    }
                }
                group("Third Preference")
                {
                    field("Third Preferred Site ID"; Rec."Third Preferred Site ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Site ID';
                        Style = Unfavorable;
                        trigger OnValidate()
                        begin
                            REc.TestField("Second Preferred Site ID");
                        end;
                    }
                    field("Third Preferred Site Name"; Rec."Third Preferred Site Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Site Name';
                        Style = Unfavorable;
                    }
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Special Accommodation Required"; Rec."Special Accommodation Required")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SPLAccommodationRequired := REc."Special Accommodation Required";
                        if REc."Special Accommodation Required" then
                            OpenSPLAccommodationApp();
                    end;
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

                group("Approved Site")
                {
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                    }
                    field("Confirmed Site ID"; Rec."Confirmed Site ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                    }
                    field("Confirmed Site Name"; Rec."Confirmed Site Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Confirm)
            {
                ShortcutKey = 'F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;
                ApplicationArea = All;
                Enabled = VarConfirm;
                trigger OnAction()
                var
                    SpclAccommodationApplication: Record "Spcl Accommodation Application";
                    StudentMaster: record "Student Master-CS";
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if Confirm('Do you want to Confirm the Preferred Sites and Start Date?') then begin
                        REc.TestField("Preset Start Date ID");
                        REc.TestField("Student No.");
                        REc.TestField("First Preferred Site ID");
                        // if "Student Type" in ["Student Type"::"International Student", "Student Type"::"General Student"] then
                        //     TestField("Second Preferred Site ID");
                        // if "Student Type" in ["Student Type"::"General Student"] then
                        //     TestField("Third Preferred Site ID");

                        REc.TestField("Preferred Start Date");

                        StudentMaster.Reset();
                        if StudentMaster.Get(REc."Student No.") then;

                        SpclAccommodationApplication.Reset();
                        SpclAccommodationApplication.SetRange("Clinical Reference No.", REc."Application No.");
                        SpclAccommodationApplication.SetRange("Student No.", REc."Student No.");
                        SpclAccommodationApplication.SetRange("Send for Approval", false);
                        if SpclAccommodationApplication.FindFirst() then
                            Error('You have a Special Accommodation Application. You must Send it for Approval before confirming the Site Selection.');

                        REc."Reject Reason Code" := '';
                        REc."Reject Reason Description" := '';
                        REc.Validate(Confirmed, true);
                        REc.Validate(Status, REc.Status::"Pending for Approval");
                        // ClinicalNotification.SiteSelectionFormHasBeenSubmitted(Rec);
                        //StudentClinicalDocuments.InitStudents(StudentMaster);
                        VarConfirm := false;
                        REc.Modify();
                        CALE.InsertLogEntry(3, 1, REc."Student No.", REc."Student Name", REc."Application No.", '', '', '9022', 'Family Medicine I/Internal Medicine I');
                        CurrPage.Editable(false);
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
                Visible = SPLAccommodationRequired;
                trigger OnAction()
                begin
                    REc.TestField("Special Accommodation Required");
                    OpenSPLAccommodationApp();
                end;
            }
        }
    }

    var
        EducationSetup: Record "Education Setup-CS";
        VarConfirm: Boolean;
        NR_GHT: Boolean;
        SPLAccommodationRequired: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        VarConfirm := not REc.Confirmed;

        REc."Global Dimension 1 Code" := '9000';
        GetFM1IM1Semester();
    end;

    trigger OnOpenPage()
    begin
        GetFM1IM1Semester();
    end;

    trigger OnAfterGetRecord()
    begin
        GetFM1IM1Semester();

        VarConfirm := not REc.Confirmed;
        SPLAccommodationRequired := REc."Special Accommodation Required";
        SiteEdit_GHT();

        CurrPage.Editable(true);
        if REc.Confirmed then
            CurrPage.Editable(false);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if REc.Confirmed = true then
            Error('Confirmed application is not allowed to delete.');
    end;

    procedure GetFM1IM1Semester()
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("FM1/IM1 Semester Filter");

        REc.SetFilter("Clerkship Semester Filter", EducationSetup."FM1/IM1 Semester Filter");
    end;

    procedure SiteEdit_GHT()
    begin
        NR_GHT := true;

        if (REc."Student Type" = REc."Student Type"::"GHT Student") and (REc."First Preferred Site ID" <> '') then
            NR_GHT := false;
    end;

    procedure OpenSPLAccommodationApp()
    var
        SpclAccommodationApplication: Record "Spcl Accommodation Application";
        SplAccommodationEntryCard: Page "Spl Accommodation Entry Card";
    begin
        REc.TestField("Special Accommodation Required");


        SpclAccommodationApplication.Reset();
        SpclAccommodationApplication.SetRange("Clinical Reference No.", REc."Application No.");
        SpclAccommodationApplication.SetRange("Student No.", REc."Student No.");
        if not SpclAccommodationApplication.FindFirst() then begin
            if not Confirm('Do you want to Apply for Special Accommodation Application?') then begin
                REc."Special Accommodation Required" := false;
                REc.Modify();
                exit;
            end;
            SpclAccommodationApplication.Init();
            SpclAccommodationApplication."Application No." := REc."Application No.";
            SpclAccommodationApplication."Application Type" := SpclAccommodationApplication."Application Type"::"Clinical Rotation";
            SpclAccommodationApplication."Created By" := UserId;
            SpclAccommodationApplication."Created On" := Today;
            SpclAccommodationApplication.Insert();
            SpclAccommodationApplication."Global Dimension 1 Code" := REc."Global Dimension 1 Code";
            SpclAccommodationApplication.Validate("Student No.", REc."Student No.");
            SpclAccommodationApplication."Clinical Reference No." := REc."Application No.";
            SpclAccommodationApplication.Modify();
        end;

        Clear(SplAccommodationEntryCard);
        SplAccommodationEntryCard.SetVariables(REc."Application No.");
        SplAccommodationEntryCard.SetTableView(SpclAccommodationApplication);
        SplAccommodationEntryCard.SetRecord(SpclAccommodationApplication);
        SplAccommodationEntryCard.Editable := true;
        SplAccommodationEntryCard.Run();
    end;
}