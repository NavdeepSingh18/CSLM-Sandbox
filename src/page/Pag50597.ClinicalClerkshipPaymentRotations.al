page 50597 "Clerkship Payment Rotations"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Roster Ledger Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Clinical Rotations';
    layout
    {
        area(Content)
        {
            group("Hospital Details & Inputs")
            {
                field(HospitalID; HospitalID)
                {
                    Caption = 'Hospital ID';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(HospitalName; HospitalName)
                {
                    Caption = 'Hospital Name';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field(ViewOption; ViewOption)
                {
                    Caption = 'View Option';
                    ApplicationArea = All;
                    Style = Favorable;
                    OptionCaption = 'All Rotations,Ready to Pay,All Invoiced Rotations,All Paid Rotations, Missing Grade Rotations';
                    trigger OnValidate()
                    begin
                        UpdateFilters();
                    end;
                }
                field(RotationType; RotationType)
                {
                    Caption = 'Rotation Type';
                    ApplicationArea = All;
                    Style = Favorable;
                    OptionCaption = 'Including FM1/IM1,Except FM1/IM1,Only FM1/IM1';

                    trigger OnValidate()
                    begin
                        UpdateFilters();
                    end;
                }
            }
            repeater(Entries)
            {
                Editable = false;
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LStyle;
                }
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
                    Caption = 'Rotation No.';
                    StyleExpr = LStyle;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LStyle;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Caption = 'Student ID';
                    StyleExpr = LStyle;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LStyle;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LStyle;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LStyle;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Weeks Invoiced"; Rec."Weeks Invoiced")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Weeks Paid"; Rec."Weeks Paid")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                }
                field("Estimated Rotation Cost"; Rec."Estimated Rotation Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    Visible = false;
                }
                field("Total Estd. Rotation Cost"; Rec."Total Estd. Rotation Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    Visible = false;
                }
                field("Actual Rotation Cost"; Rec."Actual Rotation Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    Visible = false;
                }
                field("Total Actual Rotation Cost"; Rec."Total Actual Rotation Cost")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                    Editable = false;
                    Visible = false;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
                field("Check Date"; Rec."Check Date")
                {
                    ApplicationArea = All;
                    StyleExpr = LStyle;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Set Properties")
            {
                ApplicationArea = All;
                Caption = 'Set Properties';
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Properties;
                trigger OnAction()
                var
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    PaymentPopup: Page "Payment Popup";
                    SelectedRosterEntries: array[500] of Integer;
                    I: Integer;
                    J: Integer;
                begin
                    Clear(SelectedRosterEntries);
                    Clear(PaymentPopup);

                    I := 0;
                    J := 0;
                    CurrPage.SetSelectionFilter(RosterLedgerEntry);
                    if RosterLedgerEntry.FindSet() then
                        repeat
                            I += 1;
                            if RosterLedgerEntry."Weeks Invoiced" < RosterLedgerEntry."Total No. of Weeks" then begin
                                RosterLedgerEntry."Weeks to Invoice" := RosterLedgerEntry."Total No. of Weeks" - RosterLedgerEntry."Weeks Invoiced";
                                RosterLedgerEntry.Modify();
                                RosterLedgerEntry.Mark(true);
                                SelectedRosterEntries[i] := RosterLedgerEntry."Entry No.";
                                J += 1;
                            end;
                        until RosterLedgerEntry.Next() = 0;

                    if not Confirm('You have selected %1 Rotations, out of which %2 are yet to Invoice.\\\Do you want to continue?', true, I, J) then
                        exit;

                    RosterLedgerEntry.MarkedOnly(true);
                    PaymentPopup.SetRotationNos(SelectedRosterEntries, Rec."Hospital ID", Rec."Hospital Name");
                    PaymentPopup.SetTableView(RosterLedgerEntry);
                    PaymentPopup.Run();
                end;
            }

            action("Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Invoice/Payment Ledger Entries';
                ShortcutKey = 'Ctrl+L';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LedgerBook;

                trigger OnAction()
                Var
                    CPLE: Record "Clerkship Payment Ledger Entry";
                begin
                    CPLE.Reset();
                    CPLE.FilterGroup(2);
                    CPLE.SetRange("Rotation Entry No.", Rec."Entry No.");
                    CPLE.FilterGroup(0);
                    Page.RunModal(Page::"Clerkship Payment Ledger Entry", CPLE);
                end;
            }
        }
    }

    var
        HospitalID: Code[20];
        HospitalName: Text[100];
        RotationType: Option "Including FM1/IM1","Except FM1/IM1","Only FM1/IM1";
        ViewOption: Option "All Rotations","Ready to Pay","All Invoiced Rotations","All Paid Rotations","Missing Grade Rotations";
        LStyle: Text;

    trigger OnAfterGetRecord()
    begin
        if (Rec."Invoice No. Updated" = false) OR (Rec."Check No. Updated" = false) and (Rec."Rotation Grade" <> '') then begin
            LStyle := 'Unfavorable';
            if Rec."Rotation Grade" = 'X' then
                LStyle := 'Strong';
        end
        else
            LStyle := 'Strong';
    end;

    procedure SetVariables(LHospitalID: Code[20]; LHospitalName: Text[100])
    begin
        HospitalID := LHospitalID;
        HospitalName := LHospitalName;
    end;

    procedure UpdateFilters()
    begin
        Rec.Reset();
        Rec.FilterGroup(2);
        Rec.SetRange("Hospital ID", HospitalID);
        if RotationType = RotationType::"Except FM1/IM1" then
            Rec.SetFilter("Clerkship Type", '<>%1', Rec."Clerkship Type"::"FM1/IM1");
        if RotationType = RotationType::"Only FM1/IM1" then
            Rec.SetRange("Clerkship Type", Rec."Clerkship Type"::"FM1/IM1");

        if ViewOption = ViewOption::"Ready to Pay" then begin
            Rec.SetRange("Check No. Updated", false);
            Rec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'SC', 'UC');
        end;

        if ViewOption = ViewOption::"All Invoiced Rotations" then begin
            Rec.SetRange("Invoice No. Updated", true);
            Rec.SetFilter("Rotation Grade", '<>%1&<>%2', '', 'X');
        end;

        if ViewOption = ViewOption::"All Paid Rotations" then begin
            Rec.SetRange("Check No. Updated", true);
            Rec.SetFilter("Rotation Grade", '<>%1&<>%2', '', 'X');
        end;
        if ViewOption = ViewOption::"Missing Grade Rotations" then
            Rec.SetFilter("Rotation Grade", '%1|%2', '', 'M');

        Rec.FilterGroup(0);
        CurrPage.Update(false);
    end;
}