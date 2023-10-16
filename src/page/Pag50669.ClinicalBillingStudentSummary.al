page 50669 "CLN Billing Student Summary"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLN Billing Students Summary";
    Caption = 'Clinical Billing Student Summary';
    PromotedActionCategories = 'New,Process,Navigate,Fee Processing,Ledger Entries,Legacy Ledger Entries';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Date Selection")
            {
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Caption = 'To Date';
                    trigger OnValidate()
                    var
                        Date_1: Record Date;
                    begin
                        Date_1.Reset();
                        Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                        Date_1.SetRange("Period Start", ToDate);
                        if Date_1.FindFirst() then;

                        if Date_1."Period Name" <> 'Friday' then
                            Error('Day of "To Date" must be a Friday.');
                        CurrPage.Update(true);
                    end;
                }
                label(BeforeToDate)
                {
                    ApplicationArea = All;
                    Caption = 'All Entries are shown in "Red" are Ready to Bill.';
                    Style = Unfavorable;
                }
            }

            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Ready to Bill"; Rec."Ready to Bill")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("FIU Billing Only"; Rec."FIU Billing Only")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Weeks Scheduled"; Rec."Weeks Scheduled")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                        Vendor: Record Vendor;
                        RosterSchedulingLines: Page "Roster Scheduling Lines";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.FilterGroup(0);
                        RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                        if RosterSchedulingLine.FindSet() then
                            repeat
                                Vendor.Reset();
                                if Vendor.Get(RosterSchedulingLine."Hospital ID") then
                                    if Vendor."FIU Hospital" = false then
                                        RosterSchedulingLine.Mark(true);
                            until RosterSchedulingLine.Next() = 0;

                        RosterSchedulingLine.MarkedOnly(true);
                        Clear(RosterSchedulingLines);
                        RosterSchedulingLines.SetTableView(RosterSchedulingLine);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("FIU Weeks Scheduled"; Rec."FIU Weeks Scheduled")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                        Vendor: Record Vendor;
                        RosterSchedulingLines: Page "Roster Scheduling Lines";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                        RosterSchedulingLine.FilterGroup(0);
                        if RosterSchedulingLine.FindSet() then
                            repeat
                                Vendor.Reset();
                                if Vendor.Get(RosterSchedulingLine."Hospital ID") then
                                    if Vendor."FIU Hospital" = true then
                                        RosterSchedulingLine.Mark(true);
                            until RosterSchedulingLine.Next() = 0;

                        RosterSchedulingLine.MarkedOnly(true);
                        Clear(RosterSchedulingLines);
                        RosterSchedulingLines.SetTableView(RosterSchedulingLine);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("Total Weeks Scheduled"; Rec."Total Weeks Scheduled")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                        RosterSchedulingLine.FilterGroup(0);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("Weeks Attended"; Rec."Weeks Attended")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                        Vendor: Record Vendor;
                        RosterSchedulingLines: Page "Roster Scheduling Lines";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.SetFilter("Start Date", '<=%1', ToDate);
                        RosterSchedulingLine.FilterGroup(0);
                        RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                        if RosterSchedulingLine.FindSet() then
                            repeat
                                Vendor.Reset();
                                if Vendor.Get(RosterSchedulingLine."Hospital ID") then
                                    if Vendor."FIU Hospital" = false then
                                        RosterSchedulingLine.Mark(true);
                            until RosterSchedulingLine.Next() = 0;

                        RosterSchedulingLine.MarkedOnly(true);
                        Clear(RosterSchedulingLines);
                        RosterSchedulingLines.SetTableView(RosterSchedulingLine);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("FIU Weeks Attended"; Rec."FIU Weeks Attended")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                        Vendor: Record Vendor;
                        RosterSchedulingLines: Page "Roster Scheduling Lines";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.SetFilter("Start Date", '<=%1', ToDate);
                        RosterSchedulingLine.FilterGroup(0);
                        RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                        if RosterSchedulingLine.FindSet() then
                            repeat
                                Vendor.Reset();
                                if Vendor.Get(RosterSchedulingLine."Hospital ID") then
                                    if Vendor."FIU Hospital" = true then
                                        RosterSchedulingLine.Mark(true);
                            until RosterSchedulingLine.Next() = 0;

                        RosterSchedulingLine.MarkedOnly(true);
                        Clear(RosterSchedulingLines);
                        RosterSchedulingLines.SetTableView(RosterSchedulingLine);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("Total Weeks Attended"; Rec."Total Weeks Attended")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                        RosterSchedulingLines: Page "Roster Scheduling Lines";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.SetFilter("Start Date", '<=%1', ToDate);
                        RosterSchedulingLine.FilterGroup(0);
                        RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Published, RosterSchedulingLine.Status::Completed);
                        Clear(RosterSchedulingLines);
                        RosterSchedulingLines.SetTableView(RosterSchedulingLine);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("Weeks Billed"; Rec."Weeks Billed")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("FIU Weeks Billed"; Rec."FIU Weeks Billed")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Total Weeks Billed"; Rec."Total Weeks Billed")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Total SC Weeks"; Rec."Total SC Weeks")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        RosterSchedulingLine: Record "Roster Scheduling Line";
                    begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetCurrentKey("Student No.");
                        RosterSchedulingLine.FilterGroup(2);
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        RosterSchedulingLine.SetFilter(Status, '%1', RosterSchedulingLine.Status::Cancelled);
                        RosterSchedulingLine.SetRange("Grade of Rotation", 'SC');
                        RosterSchedulingLine.FilterGroup(0);
                        Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine)
                    end;
                }
                field("Billing Notes"; Rec."Billing Notes")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
            }
        }

        area(FactBoxes)
        {
            part("Billing Summary Factbox"; "Billing Summary Factbox")
            {
                SubPageLink = "No." = field("Student No.");
                ApplicationArea = All;
                Caption = 'Billing Summary';
            }
            part("Notes Factbox"; "Notes Factbox")
            {
                ApplicationArea = All;
                Caption = 'Notes';
                SubPageLink = "Source No." = field("Student No.");
                SubPageView = where("Template Type" = filter(Student), Department = filter("Bursar Department"));
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Billing Summary")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+U';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapSetup;
                Caption = 'Update Billing Summary';

                trigger OnAction();
                begin
                    Rec.UpdateStudentsList();
                    Rec.UpdateSummaryDetails(ToDate);
                end;
            }
            action("View Ready to Bill")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UseFilters;
                Caption = 'View Ready to Bill';

                trigger OnAction();
                begin
                    Rec.UpdateSummaryDetails(ToDate);
                    Rec.FilterGroup(2);
                    Rec.SetRange(Rec."Ready to Bill", true);
                    Rec.FilterGroup(0);
                end;
            }
            action("Clear Filters")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+L';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapSetup;
                Caption = 'Clear Filters';

                trigger OnAction();
                begin
                    Rec.Reset();
                end;
            }
            action("Create Fee Journal")
            {
                ApplicationArea = All;
                ShortcutKey = F9;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = Post;
                Caption = 'Create Fee Journal';

                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                    CLNBillingStudentsSummary: Record "CLN Billing Students Summary";
                    SemesterMaster: Record "Semester Master-CS";
                    FeeSetup: Record "Fee Setup-CS";
                    GJB: Record "Gen. Journal Batch";
                    GenJnlManagement: Codeunit GenJnlManagement;
                    CurrentSemSequence: Integer;
                    LSemester: Code[20];
                    AcademicYear: Code[20];
                    Text000Lbl: Label 'Students No.      ############2################\';
                    Text001Lbl: Label 'Students in Progress      ############1################\';
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                begin
                    if not Confirm('Do you want to Create Fee Journal?') then
                        exit;

                    W.Open('Generating Fee Journal.....\' + Text000Lbl + Text001Lbl);

                    CLNBillingStudentsSummary.Reset();
                    CurrPage.SetSelectionFilter(CLNBillingStudentsSummary);
                    CLNBillingStudentsSummary.SetRange("Ready to Bill", true);
                    if CLNBillingStudentsSummary.FindSet() then begin
                        T := CLNBillingStudentsSummary.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(2, CLNBillingStudentsSummary."Student No.");
                            W.Update(1, Format(C) + ' of ' + Format(T));
                            CurrentSemSequence := 0;
                            StudentMaster.Reset();
                            if StudentMaster.Get(CLNBillingStudentsSummary."Student No.") then begin
                                AcademicYear := StudentMaster."Academic Year";

                                LSemester := '';
                                if (CLNBillingStudentsSummary."Total Weeks Billed" = 0) and (CLNBillingStudentsSummary."Total Weeks Scheduled" <> 0) then
                                    if (StudentMaster.Semester IN ['BSIC', 'CLN5']) then begin
                                        AcademicYear := StudentMaster."Academic Year";
                                        LSemester := 'CLN5';
                                    end;

                                IF CLNBillingStudentsSummary."FIU Billing Only" then
                                    LSemester := StudentMaster.Semester;

                                if (LSemester = '') then begin
                                    SemesterMaster.Reset();
                                    SemesterMaster.SetRange(Code, StudentMaster.Semester);
                                    SemesterMaster.SetFilter("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                                    if SemesterMaster.FindFirst() then
                                        CurrentSemSequence := SemesterMaster.Sequence;

                                    SemesterMaster.Reset();
                                    SemesterMaster.SetCurrentKey(Sequence);
                                    SemesterMaster.SetFilter(Sequence, '>%1', CurrentSemSequence);
                                    SemesterMaster.SetFilter("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
                                    if SemesterMaster.FindFirst() then
                                        LSemester := SemesterMaster.Code;

                                    if LSemester = '' then
                                        LSemester := StudentMaster.Semester;
                                end;

                                GenerateFeeJournal(StudentMaster, CLNBillingStudentsSummary, LSemester, AcademicYear);
                            end;
                        until CLNBillingStudentsSummary.Next() = 0;

                        W.Close();
                        Message('Fee Generation Process Completed Successfully.');

                        FeeSetup.Reset();
                        FeeSetup.SetRange("Global Dimension 1 Code", '9000');
                        if FeeSetup.FindFirst() then;

                        GJB.Reset();
                        GJB.SetRange("Journal Template Name", FeeSetup."Journal Template Name");
                        GJB.SetRange(Name, FeeSetup."Journal Batch Name");
                        if GJB.FindFirst() then
                            GenJnlManagement.TemplateSelectionFromBatch(GJB);
                    end;
                end;
            }

            action("Open Fee Journal")
            {
                ApplicationArea = All;
                Caption = 'Open Fee Journal';
                Image = Journals;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F6';
                trigger OnAction()
                var
                    FeeSetup: Record "Fee Setup-CS";
                    GJB: Record "Gen. Journal Batch";
                    GenJnlManagement: Codeunit GenJnlManagement;
                begin
                    FeeSetup.Reset();
                    FeeSetup.SetRange("Global Dimension 1 Code", '9000');
                    if FeeSetup.FindFirst() then;

                    GJB.Reset();
                    GJB.SetRange("Journal Template Name", FeeSetup."Journal Template Name");
                    GJB.SetRange(Name, FeeSetup."Journal Batch Name");
                    if GJB.FindFirst() then
                        GenJnlManagement.TemplateSelectionFromBatch(GJB);
                end;
            }
            action("List of Rotations")
            {
                ApplicationArea = All;
                Caption = 'List of Rotations';
                Image = ListPage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.FilterGroup(2);
                    RSL.SetRange("Student No.", Rec."Student No.");
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
                    RSL.FilterGroup(2);
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                end;
            }
            action("Reverse Over Billing")
            {
                ApplicationArea = All;
                Caption = 'Reverse Over Billing';
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CLNBillingReversalDetail: Record "CLN Billing Reversal Detail";
                    ClinicalBillingReversal: Page "Clinical Billing Reversal";
                    WeeksToReverse: Integer;
                    FIUWeeksToReverse: Integer;
                begin
                    CLNBillingReversalDetail.Reset();
                    CLNBillingReversalDetail.SetRange("Student No.", Rec."Student No.");
                    CLNBillingReversalDetail.SetRange("Posted No.", '');
                    if CLNBillingReversalDetail.FindSet() then
                        repeat
                            CLNBillingReversalDetail.Delete();
                        until CLNBillingReversalDetail.Next() = 0;

                    Commit();

                    WeeksToReverse := (Rec."Weeks Billed" - Rec."Weeks Attended" - Rec."FIU Weeks Billed");
                    FIUWeeksToReverse := (Rec."FIU Weeks Billed" - Rec."FIU Weeks Attended");

                    if WeeksToReverse < 0 then
                        WeeksToReverse := 0;

                    if FIUWeeksToReverse < 0 then
                        FIUWeeksToReverse := 0;

                    CLNBillingReversalDetail.Reset();
                    CLNBillingReversalDetail.FilterGroup(2);
                    CLNBillingReversalDetail.SetRange("Student No.", Rec."Student No.");
                    CLNBillingReversalDetail.SetRange("Posted No.", '');
                    CLNBillingReversalDetail.FilterGroup(0);

                    Clear(ClinicalBillingReversal);
                    ClinicalBillingReversal.SetVariables(Rec."Student No.", Rec."Student Name", WeeksToReverse, FIUWeeksToReverse);
                    ClinicalBillingReversal.SetTableView(CLNBillingReversalDetail);
                    ClinicalBillingReversal.RunModal();
                end;
            }
            group("Ledger Entries")
            {
                action("Customer Ledger Entries")
                {
                    Caption = 'Customer Ledger Entries';
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = True;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetCurrentKey("Enrollment No.");
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }

                action("Tuition Ledger")
                {
                    Caption = 'Tuition Ledger';
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = True;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetCurrentKey("Enrollment No.");
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }

                action("AUA Housing Ledger")
                {
                    Caption = 'AUA Housing Ledger';
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetCurrentKey("Enrollment No.");
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9500');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }
                action("Grenville Ledger")
                {
                    Caption = 'Grenville Ledger';
                    ApplicationArea = Basic, Suite;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = True;
                    trigger OnAction()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetCurrentKey("Enrollment No.");
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9300');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }
            }

            group("Legacy Ledger Entries")
            {
                action("Legacy Ledger")
                {
                    Caption = 'Legacy Ledger';
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = True;
                    trigger OnAction()
                    var
                        StudenLegacyLedger: Record "Student Legacy Ledger";

                    begin
                        StudenLegacyLedger.FilterGroup(0);
                        StudenLegacyLedger.reset();
                        StudenLegacyLedger.SetCurrentKey("Post Date");
                        StudenLegacyLedger.SetAscending("Post Date", false);
                        StudenLegacyLedger.SetRange("Student Number", Rec."Student No.");
                        if StudenLegacyLedger.FindFirst() then begin
                            page.Run(50772, StudenLegacyLedger);
                            StudenLegacyLedger.FilterGroup(2);
                        end;
                    end;
                }

                action("Legacy Tuition Ledger")
                {
                    Caption = 'Legacy Tuition Ledger';
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        StudenLegacyLedger: Record "Student Legacy Ledger";

                    begin
                        StudenLegacyLedger.FilterGroup(0);
                        StudenLegacyLedger.reset();
                        StudenLegacyLedger.SetCurrentKey("Post Date");
                        StudenLegacyLedger.SetAscending("Post Date", false);
                        StudenLegacyLedger.SetRange("Student Number", Rec."Student No.");
                        StudenLegacyLedger.SetRange("Charge Type", StudenLegacyLedger."Charge Type"::Tuition);
                        if StudenLegacyLedger.FindFirst() then begin
                            page.Run(50772, StudenLegacyLedger);
                            StudenLegacyLedger.FilterGroup(2);
                        end;
                    end;
                }

                action("Legacy Housing Ledger")
                {
                    Caption = 'Legacy Housing Ledger';
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        StudenLegacyLedger: Record "Student Legacy Ledger";
                    begin
                        StudenLegacyLedger.FilterGroup(0);
                        StudenLegacyLedger.reset();
                        StudenLegacyLedger.SetCurrentKey("Post Date");
                        StudenLegacyLedger.SetAscending("Post Date", false);
                        StudenLegacyLedger.SetRange("Student Number", Rec."Student No.");
                        StudenLegacyLedger.SetRange("Charge Type", StudenLegacyLedger."Charge Type"::Housing);
                        if StudenLegacyLedger.FindFirst() then begin
                            page.Run(50772, StudenLegacyLedger);
                            StudenLegacyLedger.FilterGroup(2);
                        end;
                    end;
                }
            }
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("Student No.");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    ClinicalBaseAppSubscribe.ViewEditNote(Rec."Student No.", Rec."Student No.", TemplateType, GroupType);
                end;
            }

            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Card;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F5';
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    StudentDetailCard: Page "Student Detail Card-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."Student No.");
                    StudentMaster.FilterGroup(0);
                    StudentDetailCard.SetTableView(StudentMaster);
                    StudentDetailCard.Editable(false);
                    StudentDetailCard.RunModal();
                end;
            }
        }
    }

    var
        ToDate: Date;

    procedure GenerateFeeJournal(StudentMaster: Record "Student Master-CS"; CLNBillingStudentsSummary: Record "CLN Billing Students Summary"; LSemester: Code[10]; AcademicYear: Code[10])
    var
        FeeSetup: Record "Fee Setup-CS";
        GJB: Record "Gen. Journal Batch";
        GJL: Record "Gen. Journal Line";
        FeeCourse: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        FeeComponent: Record "Fee Component Master-CS";
        FinancialAid: Record "Financial Aid";
        StudentRegistration: Record "Student Registration-CS";
        HousingApplication: Record "Housing Application";
        GLEntry: Record "G/L Entry";
        RSL: Record "Roster Scheduling Line";
        Vendor: Record Vendor;
        HousingApplied: Boolean;
        DocumentNo: Code[20];
        BillingType: Option " ","Clinical Billing","FIU Surcharge";
        FeeAmount: Decimal;
        TotalFeeAmount: Decimal;
        FAApproved: Boolean;
        FAApprovedAmt: Decimal;
        FAFractionAmt: Decimal;
        FeeSetupNo: Code[20];
        FIUWeeks: Decimal;
        FM1IM1InFIU: Boolean;
        PostingDate: Date;
        TotalBilledWeeks: Integer;
    begin
        TotalFeeAmount := 0;
        DocumentNo := '';
        FAFractionAmt := 0;
        FAApprovedAmt := 0;

        StudentMaster.TestField("Course Code");

        TotalBilledWeeks := CLNBillingStudentsSummary."Weeks Billed" + CLNBillingStudentsSummary."FIU Weeks Billed";

        if (TotalBilledWeeks >= 0) and (TotalBilledWeeks < 21) then
            PostingDate := StudentMaster."5 FA Start Date";
        if (TotalBilledWeeks >= 21) and (TotalBilledWeeks < 42) then
            PostingDate := StudentMaster."6 FA Start Date";
        if (TotalBilledWeeks >= 42) and (TotalBilledWeeks < 63) then
            PostingDate := StudentMaster."7 FA Start Date";
        if (TotalBilledWeeks >= 63) then
            PostingDate := StudentMaster."8 FA Start Date";

        if CLNBillingStudentsSummary."FIU Billing Only" = true then
            PostingDate := WorkDate();

        FeeSetup.Reset();
        FeeSetup.Reset();
        FeeSetup.SetRange("Global Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        if FeeSetup.FindFirst() then begin
            FeeSetup.TestField("Journal Template Name");
            FeeSetup.TestField("Journal Batch Name");
        end;

        FM1IM1InFIU := false;
        RSL.Reset();
        RSL.SetCurrentKey("Student No.");
        RSL.SetRange("Student No.", StudentMaster."No.");
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
        if RSL.FindFirst() then begin
            Vendor.Reset();
            if Vendor.Get(RSL."Hospital ID") then
                if Vendor."FIU Hospital" then
                    FM1IM1InFIU := true;
        end;

        GJB.Reset();
        if GJB.Get(FeeSetup."Journal Template Name", FeeSetup."Journal Batch Name") then
            GJB.TestField("No. Series");

        GJL.Reset();
        GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
        GJL.SetRange("Journal Batch Name", GJB.Name);
        GJL.SetRange("Enrollment No.", StudentMaster."Enrollment No.");
        if GJL.FindFirst() then
            repeat
                GJL.Delete(true);
            until GJL.Next() = 0;

        FAApproved := false;
        FinancialAid.Reset();
        FinancialAid.SetRange("Student No.", StudentMaster."No.");
        FinancialAid.SetRange("Academic Year", StudentMaster."Academic Year");
        FinancialAid.SetRange(Semester, StudentMaster.Semester);
        if FinancialAid.FindFirst() then begin
            FAApproved := true;
            FAApprovedAmt := FinancialAid."Grad. Plus Transaction Amount" + FinancialAid."Unsubsidized Transation Amount";
        end;

        StudentRegistration.Reset();
        StudentRegistration.SetRange("Student No", StudentMaster."No.");
        StudentRegistration.SetRange("Academic Year", AcademicYear);
        StudentRegistration.SetRange(Semester, Rec.Semester);
        StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
        IF StudentRegistration.FindFirst() Then;

        FeeCourse.Reset();
        FeeCourse.SetRange("Course Code", StudentMaster."Course Code");
        FeeCourse.SetRange("Academic Year", AcademicYear);
        FeeCourse.SetRange(Semester, LSemester);
        FeeCourse.SetRange("Other Fees", false);
        if FeeCourse.FindLast() then
            FeeSetupNo := FeeCourse."No.";

        FeeCourseLine.Reset();
        FeeCourseLine.SetRange("Document No.", FeeSetupNo);
        FeeCourseLine.SetRange("Course Code", StudentMaster."Course Code");
        FeeCourseLine.SetRange("Other Fees", false);
        if FeeCourseLine.FindSet() then
            repeat
                FeeComponent.Reset();
                if FeeComponent.Get(FeeCourseLine."Fee Code") then;

                IF NOT (FeeComponent."Type Of Fee" In [FeeComponent."Type Of Fee"::RENT, FeeComponent."Type Of Fee"::DAMAGEDEP,
                FeeComponent."Type Of Fee"::"BUS-SEMESTER", FeeComponent."Type Of Fee"::"INSTALMENT FEE"]) then begin
                    FeeAmount := FeeCourseLine.Amount;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::HEALTHINS) and (StudentRegistration."Apply for Insurance" = false) then
                        FeeAmount := 0;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::REPATINS) and (StudentRegistration."Apply for Insurance" = true) then
                        FeeAmount := 0;

                    if (CLNBillingStudentsSummary."FIU Billing Only" = true) AND (FeeComponent."Type Of Fee" <> FeeComponent."Type Of Fee"::"FIU SURCHARGE") then
                        FeeAmount := 0;

                    if FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::"FIU SURCHARGE" then begin
                        FIUWeeks := 0;

                        if FM1IM1InFIU then
                            FIUWeeks := 21;

                        if CLNBillingStudentsSummary."FIU Weeks Billed" = 0 then
                            FIUWeeks := CLNBillingStudentsSummary."FIU Weeks Scheduled"
                        else
                            if (CLNBillingStudentsSummary."FIU Weeks Scheduled" - CLNBillingStudentsSummary."FIU Weeks Billed") > 0 then
                                FIUWeeks := CLNBillingStudentsSummary."FIU Weeks Scheduled" - CLNBillingStudentsSummary."FIU Weeks Billed";

                        if FIUWeeks > 0 then
                            FeeAmount := FeeAmount * FIUWeeks
                        else
                            FeeAmount := 0;
                    end;

                    if FeeComponent."Type Of Fee" <> FeeComponent."Type Of Fee"::"FIU SURCHARGE" then begin
                        GLEntry.Reset();
                        GLEntry.SETRANGE("Enrollment No.", StudentMaster."Enrollment No.");
                        GLEntry.SETRANGE("Academic Year", AcademicYear);
                        GLEntry.SETRANGE(Semester, LSemester);
                        GLEntry.SETRANGE(Reversed, false);
                        GLEntry.SETRANGE("Fee Code", FeeCourseLine."Fee Code");
                        GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
                        IF GLEntry.findfirst() THEN
                            FeeAmount := 0;
                    end;

                    if FeeAmount > 0 then begin
                        InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, LSemester, DocumentNo, FeeComponent, FAApproved, -1 * FeeAmount, 0, 0, BillingType, '', false, PostingDate);
                        TotalFeeAmount := TotalFeeAmount + FeeAmount;
                    end;
                end;
            until FeeCourseLine.Next() = 0;

        if TotalFeeAmount <> 0 then begin
            Clear(FeeComponent);
            InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, LSemester, DocumentNo, FeeComponent, FAApproved, TotalFeeAmount, 21 - FIUWeeks, FIUWeeks, BillingType, '', true, PostingDate);
        end;

        TotalFeeAmount := 0;
        DocumentNo := '';
        FeeCourseLine.Reset();
        FeeCourseLine.SetRange("Document No.", FeeSetupNo);
        FeeCourseLine.SetRange("Other Fees", false);
        if FeeCourseLine.FindSet() then
            repeat
                FeeComponent.Reset();
                if FeeComponent.Get(FeeCourseLine."Fee Code") then;
                IF (FeeComponent."Type Of Fee" In [FeeComponent."Type Of Fee"::RENT, FeeComponent."Type Of Fee"::DAMAGEDEP, FeeComponent."Type Of Fee"::"BUS-SEMESTER"]) then begin
                    HousingApplied := false;
                    HousingApplication.Reset();
                    HousingApplication.SetRange("Student No.", StudentMaster."No.");
                    HousingApplication.SetRange("Academic Year", StudentMaster."Academic Year");
                    HousingApplication.SetRange(Semester, StudentMaster.Semester);
                    HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                    HousingApplication.SetRange("Global Dimension 2 Code", FeeComponent."Global Dimension 2 Code");
                    If HousingApplication.FindLast() then
                        HousingApplied := true;

                    FeeAmount := 0;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::RENT) and (HousingApplied = true) then
                        FeeAmount := GetHousingFeeComponentAmount(HousingApplication);

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::DAMAGEDEP) and (HousingApplied = true) then
                        FeeAmount := FeeCourseLine.Amount;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::"BUS-SEMESTER") and (StudentMaster."Transport Allot" = true) then
                        FeeAmount := FeeCourseLine.Amount;

                    GLEntry.Reset();
                    GLEntry.SETRANGE("Enrollment No.", StudentMaster."Enrollment No.");
                    GLEntry.SETRANGE("Academic Year", AcademicYear);
                    GLEntry.SETRANGE(Semester, LSemester);
                    GLEntry.SETRANGE(Reversed, false);
                    GLEntry.SETRANGE("Fee Code", FeeCourseLine."Fee Code");
                    GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
                    IF GLEntry.findfirst() THEN
                        FeeAmount := 0;

                    if FeeAmount > 0 then begin
                        InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, LSemester, DocumentNo, FeeComponent, FAApproved, -1 * FeeAmount, 0, 0, BillingType, FeeCourseLine."Global Dimension 2 Code", false, PostingDate);
                        TotalFeeAmount := TotalFeeAmount + FeeAmount;
                    end;
                end;
            until FeeCourseLine.Next() = 0;

        if TotalFeeAmount <> 0 then begin
            Clear(FeeComponent);
            InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, LSemester, DocumentNo, FeeComponent, FAApproved, TotalFeeAmount, 0, 0, BillingType, FeeCourseLine."Global Dimension 2 Code", true, PostingDate);
        end;

        if FAApprovedAmt <> 0 then begin
            FAFractionAmt := 0;
            UpdateFinancialAidFraction(StudentMaster, GJB, FAApprovedAmt, FAFractionAmt);
            CreateDifferenceJournal(FeeSetup, GJB, StudentMaster, StudentRegistration, LSemester, AcademicYear, PostingDate);
        end;
    end;

    procedure GetHousingFeeComponentAmount(HousingApplication: Record "Housing Application") ComponentAmt: Decimal
    var
        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
    begin
        RoomCategoryFeeSetup.Reset();
        RoomCategoryFeeSetup.SetRange("Housing ID", HousingApplication."Housing ID");
        RoomCategoryFeeSetup.SetRange("Room Category Code", HousingApplication."Room Category Code");
        RoomCategoryFeeSetup.SetFilter("Effective From", '<=%1', WorkDate());
        IF Not RoomCategoryFeeSetup.FindLast() then
            Error('Room Category Fee Setup not found.\Please check for the Student No. %1.', HousingApplication."Student No.");

        If HousingApplication."With Spouse" = true then
            ComponentAmt := RoomCategoryFeeSetup."With Spouse Cost"
        else
            ComponentAmt := RoomCategoryFeeSetup.Cost;
    end;

    procedure InsertJournalLine(
        FeeSetup: Record "Fee Setup-CS";
        GJB: Record "Gen. Journal Batch";
        StudentMaster: Record "Student Master-CS";
        AcademicYear: Code[10];
        LSemester: Code[10];
        Var
            DocumentNo: Code[20];
            FeeComponent: Record "Fee Component Master-CS";
            FAApproved: Boolean;
            FeeAmount: Decimal;
            BillingWeeks: Decimal;
            FIUBillingWeeks: Decimal;
            BillingType: Option " ","Clinical Billing","FIU Surcharge";
            GlobalDim2Code: Code[20];
            StudentEntry: Boolean;
            PostingDate: Date)
    var
        SAPFeeCode: Record "SAP Fee Code";
        GJT: Record "Gen. Journal Template";
        GJL: Record "Gen. Journal Line";
        GJLIns: Record "Gen. Journal Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LineNo: Integer;
    begin
        BillingType := BillingType::"Clinical Billing";

        GJT.Reset();
        if GJT.Get(FeeSetup."Journal Template Name") then;

        if DocumentNo = '' then begin
            GJL.Reset();
            GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
            GJL.SetRange("Journal Batch Name", GJB.Name);
            if GJL.FindLast() then
                DocumentNo := IncStr(GJL."Document No.")
            else
                DocumentNo := NoSeriesManagement.GetNextNo(GJB."No. Series", WorkDate(), false);
        end;

        GJL.Reset();
        GJL.SetCurrentKey("Line No.");
        GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
        GJL.SetRange("Journal Batch Name", GJB.Name);
        if GJL.FindLast() then
            LineNo := GJL."Line No.";

        LineNo := LineNo + 10000;

        GJLIns.Init();
        GJLIns."Journal Template Name" := GJB."Journal Template Name";
        GJLIns."Journal Batch Name" := GJB.Name;
        GJLIns."Line No." := LineNo;
        GJLIns."Posting No. Series" := GJB."Posting No. Series";
        GJLIns.Insert(true);

        GJLIns.VALIDATE("Document No.", DocumentNo);
        GJLIns.VALIDATE("Document Type", GJLIns."Document Type"::Invoice);
        if StudentEntry = false then begin
            GJLIns.VALIDATE("Account Type", GJLIns."Account Type"::"G/L Account");
            GJLIns.VALIDATE("Account No.", FeeComponent."G/L Account");
            GJLIns.VALIDATE(Description, FeeComponent.Description);
        end
        else begin
            GJLIns.VALIDATE("Account Type", GJLIns."Account Type"::Customer);
            if UserId = 'X250\MICROSOFT' then
                GJLIns.VALIDATE("Account No.", StudentMaster."No.")
            else
                GJLIns.VALIDATE("Account No.", StudentMaster."Original Student No.");
            GJLIns.VALIDATE(Description, 'Semester Fee');
        end;

        GJLIns.VALIDATE("Posting Date", PostingDate);

        if FeeComponent."Type Of Fee" <> FeeComponent."Type Of Fee"::"FIU SURCHARGE" then
            GJLIns.VALIDATE(Amount, FeeAmount)
        else
            if FIUBillingWeeks <> 0 then
                GJLIns.VALIDATE(Amount, FeeAmount * FIUBillingWeeks)
            else
                GJLIns.VALIDATE(Amount, FeeAmount);

        GJLIns.VALIDATE("Shortcut Dimension 1 Code", StudentMaster."Global Dimension 1 Code");
        GJLIns.VALIDATE("Shortcut Dimension 2 Code", GlobalDim2Code);
        //VIKAS
        GJLIns.VALIDATE(Course, StudentMaster."Course Code");
        GJLIns."Enrollment No." := StudentMaster."Enrollment No.";
        GJLIns.VALIDATE(Year, StudentMaster.Year);
        GJLIns.VALIDATE("Academic Year", AcademicYear);
        GJLIns.Validate(Semester, LSemester);
        GJLIns.Term := StudentMaster.Term;

        GJLIns."Fee Code" := FeeComponent.Code;
        GJLIns."Source Code" := GJT."Source Code";
        GJLIns."Billing Weeks" := BillingWeeks;
        GJLIns."FIU Billing Weeks" := FIUBillingWeeks;
        GJLIns."Type of Billing" := BillingType;

        if FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::"FIU SURCHARGE" then
            GJLIns."Type of Billing" := GJLIns."Type of Billing"::"FIU Surcharge";

        SAPFeeCode.Reset();
        SAPFeeCode.SetRange("SAP Code", FeeComponent."SAP Code");
        IF SAPFeeCode.FindFirst() then begin
            GJLIns."SAP Code" := SAPFeeCode."SAP Code";
            GJLIns."SAP G/L Account" := SAPFeeCode."SAP G/L Account";
            GJLIns."SAP Assignment Code" := SAPFeeCode."SAP Assignment Code";
            GJLIns."SAP Description" := SAPFeeCode."SAP Description";
            GJLIns."SAP Cost Centre" := SAPFeeCode."SAP Cost Centre";
            GJLIns."SAP Profit Centre" := SAPFeeCode."SAP Profit Centre";
            GJLIns."SAP Company Code" := SAPFeeCode."SAP Company Code";
            GJLIns."SAP Bus. Area" := SAPFeeCode."SAP Bus. Area";
            GJLIns."Fee Group" := SAPFeeCode."Fee Group";
        end;

        //GJLIns."Auto Generated" := True;
        GJLIns."Financial Aid Approved" := FAApproved;
        GJLIns.Modify(true);
    end;

    procedure UpdateFinancialAidFraction(StudentMaster: Record "Student Master-CS"; GJB: Record "Gen. Journal Batch"; FAApprovedAmt: Decimal; Var FractionAmt: Decimal)
    var
        GJL: Record "Gen. Journal Line";
        GJL_1: Record "Gen. Journal Line";
        TotalCreditAmt: Decimal;
        Amt: Decimal;
    begin
        TotalCreditAmt := 0;
        GJL_1.Reset();
        GJL_1.SetRange("Journal Template Name", GJB."Journal Template Name");
        GJL_1.SetRange("Journal Batch Name", GJB.Name);
        if UserId = 'X250\MICROSOFT' then
            GJL_1.SetRange("Account No.", StudentMaster."No.")
        else
            GJL_1.SetRange("Account No.", StudentMaster."Original Student No.");
        if GJL_1.FindSet() then
            repeat
                GJL.Reset();
                GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                GJL.SetRange("Journal Batch Name", GJB.Name);
                GJL.SetRange("Document No.", GJL_1."Document No.");
                GJL.CalcSums("Credit Amount");
                TotalCreditAmt := TotalCreditAmt + GJL."Credit Amount";
            until GJL_1.Next() = 0;

        if TotalCreditAmt <> 0 then
            FractionAmt := FAApprovedAmt / TotalCreditAmt
        else
            FractionAmt := 1;

        GJL_1.Reset();
        GJL_1.SetRange("Journal Template Name", GJB."Journal Template Name");
        GJL_1.SetRange("Journal Batch Name", GJB.Name);
        if UserId = 'X250\MICROSOFT' then
            GJL_1.SetRange("Account No.", StudentMaster."No.")
        else
            GJL_1.SetRange("Account No.", StudentMaster."Original Student No.");
        if GJL_1.FindSet() then
            repeat
                GJL.Reset();
                GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                GJL.SetRange("Journal Batch Name", GJB.Name);
                GJL.SetRange("Document No.", GJL_1."Document No.");
                if GJL.FindFirst() then
                    repeat
                        Amt := Round(GJL.Amount * FractionAmt, 0.01, '=');
                        GJL.Validate(Amount, Amt);
                        GJL.Modify();
                    until GJL.Next() = 0;

                if GJL_1."Line No." = GJL."Line No." then begin
                    GJL.Reset();
                    GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                    GJL.SetRange("Journal Batch Name", GJB.Name);
                    GJL.SetRange("Document No.", GJL_1."Document No.");
                    GJL.CalcSums("Amount");
                    Amt := GJL.Amount;

                    if Amt <> 0 then begin
                        GJL.Reset();
                        GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                        GJL.SetRange("Journal Batch Name", GJB.Name);
                        GJL.SetRange("Document No.", GJL_1."Document No.");
                        if GJL.FindFirst() then begin
                            GJL.Validate(Amount, GJL.Amount - Amt);
                            GJL.Modify();
                        end;
                    end;
                end;
            until GJL_1.Next() = 0;
    end;

    procedure CreateDifferenceJournal(
        FeeSetup: Record "Fee Setup-CS";
        GJB: Record "Gen. Journal Batch";
        StudentMaster: Record "Student Master-CS";
        StudentRegistration: Record "Student Registration-CS";
        Semester: Code[10];
        AcademicYear: Code[10];
        PostingDate: date)
    var
        FeeCourse: Record "Fee Course Head-CS";
        FeeCourseLine: Record "Fee Course Line-CS";
        FeeComponent: Record "Fee Component Master-CS";
        GJL: Record "Gen. Journal Line";
        HousingApplication: Record "Housing Application";
        HousingApplied: Boolean;
        DocumentNo: Code[20];
        BillingType: Option " ","Clinical Billing","FIU Surcharge";
        FAApproved: Boolean;
        FeeAmount: Decimal;
        TotalFeeAmount: Decimal;
        CheckforComponent: Boolean;
        FeeSetupNo: Code[20];
    begin
        DocumentNo := '';
        FeeAmount := 0;
        TotalFeeAmount := 0;

        FeeCourse.Reset();
        FeeCourse.SetRange("Course Code", StudentMaster."Course Code");
        FeeCourse.SetRange("Academic Year", AcademicYear);
        FeeCourse.SetRange(Semester, Semester);
        FeeCourse.SetRange("Other Fees", false);
        if FeeCourse.FindLast() then
            FeeSetupNo := FeeCourse."No.";

        FeeCourseLine.Reset();
        FeeCourseLine.SetRange("Document No.", FeeSetupNo);
        FeeCourseLine.SetRange("Academic Year", AcademicYear);
        FeeCourseLine.SetRange(Semester, Semester);
        FeeCourseLine.SetRange("Other Fees", false);
        if FeeCourseLine.FindSet() then
            repeat
                FeeComponent.Reset();
                if FeeComponent.Get(FeeCourseLine."Fee Code") then;

                IF NOT (FeeComponent."Type Of Fee" In [FeeComponent."Type Of Fee"::RENT, FeeComponent."Type Of Fee"::DAMAGEDEP,
                FeeComponent."Type Of Fee"::"BUS-SEMESTER", FeeComponent."Type Of Fee"::"INSTALMENT FEE"]) then begin
                    CheckforComponent := true;
                    FeeAmount := FeeCourseLine.Amount;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::HEALTHINS) and (StudentRegistration."Apply for Insurance" = false) then
                        CheckforComponent := false;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::REPATINS) and (StudentRegistration."Apply for Insurance" = true) then
                        CheckforComponent := false;

                    if CheckforComponent = true then begin
                        GJL.Reset();
                        GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                        GJL.SetRange("Journal Batch Name", GJB.Name);
                        GJL.SetRange("Enrollment No.", StudentMaster."Enrollment No.");
                        GJL.SetRange("Fee Code", FeeCourseLine."Fee Code");
                        GJL.CalcSums("Credit Amount");

                        FeeAmount := FeeAmount - GJL."Credit Amount";
                    end;

                    if FeeAmount > 0 then begin
                        InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, Semester, DocumentNo, FeeComponent, FAApproved, -1 * FeeAmount, 0, 0, BillingType, FeeCourseLine."Global Dimension 2 Code", false, PostingDate);
                        TotalFeeAmount := TotalFeeAmount + FeeAmount;
                    end;
                end;
            until FeeCourseLine.Next() = 0;

        if TotalFeeAmount <> 0 then begin
            Clear(FeeComponent);
            InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, Semester, DocumentNo, FeeComponent, FAApproved, TotalFeeAmount, 0, 0, BillingType, '', true, PostingDate);
        end;

        DocumentNo := '';
        FeeAmount := 0;
        TotalFeeAmount := 0;
        BillingType := BillingType::"Clinical Billing";

        FeeCourseLine.Reset();
        FeeCourseLine.SetRange("Document No.", FeeSetupNo);
        FeeCourseLine.SetRange("Academic Year", AcademicYear);
        FeeCourseLine.SetRange(Semester, Semester);
        FeeCourseLine.SetRange("Other Fees", false);
        if FeeCourseLine.FindSet() then
            repeat
                FeeComponent.Reset();
                if FeeComponent.Get(FeeCourseLine."Fee Code") then;

                IF (FeeComponent."Type Of Fee" In [FeeComponent."Type Of Fee"::RENT, FeeComponent."Type Of Fee"::DAMAGEDEP,
                FeeComponent."Type Of Fee"::"BUS-SEMESTER"]) then begin
                    CheckforComponent := true;
                    FeeAmount := 0;

                    HousingApplied := false;
                    HousingApplication.Reset();
                    HousingApplication.SetRange("Student No.", StudentMaster."No.");
                    HousingApplication.SetRange("Academic Year", StudentMaster."Academic Year");
                    HousingApplication.SetRange(Semester, StudentMaster.Semester);
                    HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                    HousingApplication.SetRange("Global Dimension 2 Code", FeeComponent."Global Dimension 2 Code");
                    If HousingApplication.FindLast() then
                        HousingApplied := true;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::RENT) and (HousingApplied = true) then
                        FeeAmount := GetHousingFeeComponentAmount(HousingApplication);

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::DAMAGEDEP) and (HousingApplied = true) then
                        FeeAmount := FeeCourseLine.Amount;

                    IF (FeeComponent."Type Of Fee" = FeeComponent."Type Of Fee"::"BUS-SEMESTER") and (StudentMaster."Transport Allot" = true) then
                        FeeAmount := FeeCourseLine.Amount;

                    if CheckforComponent = true then begin
                        GJL.Reset();
                        GJL.SetRange("Journal Template Name", GJB."Journal Template Name");
                        GJL.SetRange("Journal Batch Name", GJB.Name);
                        GJL.SetRange("Enrollment No.", StudentMaster."Enrollment No.");
                        GJL.SetRange("Fee Code", FeeCourseLine."Fee Code");
                        GJL.CalcSums("Credit Amount");

                        FeeAmount := FeeAmount - GJL."Credit Amount";
                    end;

                    if FeeAmount > 0 then begin
                        InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, Semester, DocumentNo, FeeComponent, FAApproved, -1 * FeeAmount, 0, 0, BillingType, FeeCourseLine."Global Dimension 2 Code", false, PostingDate);
                        TotalFeeAmount := TotalFeeAmount + FeeAmount;
                    end;
                end;
            until FeeCourseLine.Next() = 0;

        if TotalFeeAmount <> 0 then begin
            Clear(FeeComponent);
            InsertJournalLine(FeeSetup, GJB, StudentMaster, AcademicYear, Semester, DocumentNo, FeeComponent, FAApproved, TotalFeeAmount, 0, 0, BillingType, '', true, PostingDate);
        end;
    end;

    var
        LStyle: Text[20];

    trigger OnOpenPage()
    var
        LDate: Record Date;
    begin
        ToDate := 0D;
        LDate.Reset();
        LDate.SetCurrentKey("Period Type");
        LDate.SetRange("Period Type", LDate."Period Type"::Date);
        LDate.SetRange("Period Start", WorkDate());
        if LDate.FindFirst() then
            if LDate."Period Name" = 'Friday' then
                ToDate := LDate."Period Start";

        if ToDate = 0D then begin
            LDate.Reset();
            LDate.SetCurrentKey("Period Type");
            LDate.SetRange("Period Type", LDate."Period Type"::Date);
            LDate.SetFilter("Period Start", '<=%1', WorkDate());
            LDate.SetRange("Period Name", 'Friday');
            if LDate.FindLast() then
                ToDate := LDate."Period Start";
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        LStyle := 'Strong';

        if Rec."Ready to Bill" then
            LStyle := 'Unfavorable';
    end;
}