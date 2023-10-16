page 50742 "Clerkship ADV Payment Rotation"
{
    Caption = 'Clerkship Rotations - Adavance Payment';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Ledger Entry";
    //TO_DO SourceTableView = where (Grade = filter(<>" "&<>'X'), "Invoice No. Updated" = filter(false));
    SourceTableView = where("Check No. Updated" = filter(false));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Hospital Details")
            {
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
            }
            repeater(Entries)
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
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Hospital_ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Caption = 'Hospital ID';
                }
                field("Hospital_Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Caption = 'Hospital Name';
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Caption = 'Student ID';
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
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
                    Editable = false;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                }
                field("Actual Rotation Cost"; Rec."Actual Rotation Cost")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Total Actual Rotation Cost"; Rec."Total Actual Rotation Cost")
                {
                    ApplicationArea = All;
                    Style = Strong;
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
                    ADVPaymentPopup: Page "ADV Payment Popup";
                    SelectedRosterEntries: array[500] of Integer;
                    I: Integer;
                begin
                    Clear(SelectedRosterEntries);
                    Clear(ADVPaymentPopup);

                    I := 0;
                    CurrPage.SetSelectionFilter(RosterLedgerEntry);
                    if RosterLedgerEntry.FindSet() then
                        repeat
                            I += 1;
                            SelectedRosterEntries[i] := RosterLedgerEntry."Entry No.";
                        until RosterLedgerEntry.Next() = 0;
                    ADVPaymentPopup.SetRotationNos(SelectedRosterEntries, Rec."Hospital ID", Rec."Hospital Name");
                    ADVPaymentPopup.Run();
                end;
            }

            action("Temp")
            {
                Enabled = false;
                ApplicationArea = All;
                Caption = 'Temp';
                ShortcutKey = 'Ctrl+T';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Properties;
                Visible = false;
                trigger OnAction()
                var
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    CBLE: Record "Clerkship Payment Ledger Entry";
                begin
                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.FindSet() then
                        repeat
                            RosterLedgerEntry."Invoice No." := '';
                            RosterLedgerEntry."Invoice Date" := 0D;
                            RosterLedgerEntry."Invoice No. Updated" := false;
                            RosterLedgerEntry.Modify();
                        until RosterLedgerEntry.Next() = 0;

                    CBLE.Reset();
                    if CBLE.FindSet() then
                        CBLE.DeleteAll();
                end;
            }
        }
    }
}