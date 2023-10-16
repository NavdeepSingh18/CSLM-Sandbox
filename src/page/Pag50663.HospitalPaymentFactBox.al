page 50663 "Hospital Payment FactBox"
{
    PageType = CardPart;
    Caption = 'Hospital Payment Facts';
    UsageCategory = None;
    SourceTable = Vendor;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Payment Information")
            {
                field("Hospital ID"; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Hospital Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Total Rotations"; TotalRotations)
                {
                    Caption = 'Total Rotations';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    trigger OnDrillDown()
                    begin
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.FilterGroup(2);
                        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
                        RosterLedgerEntry.FilterGroup(0);
                        Page.RunModal(Page::"Roster Ledger Entries", RosterLedgerEntry)
                    end;
                }
                field("Total Rotations Graded"; TotalRotationsGraded)
                {
                    Caption = 'Total Rotations Graded';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    trigger OnDrillDown()
                    begin
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.FilterGroup(2);
                        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
                        RosterLedgerEntry.SetFilter("Rotation Grade", '<>%1&<>%2', '', 'X');
                        RosterLedgerEntry.FilterGroup(0);
                        Page.RunModal(Page::"Roster Ledger Entries", RosterLedgerEntry)
                    end;
                }
                field("Invoice No. Updated"; InvoiceNoUpdated)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Caption = 'Invoice No. Updated';
                    trigger OnDrillDown()
                    begin
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.FilterGroup(2);
                        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
                        RosterLedgerEntry.SetFilter("Invoice No.", '<>%1', '');
                        RosterLedgerEntry.FilterGroup(0);
                        Page.RunModal(Page::"Roster Ledger Entries", RosterLedgerEntry)
                    end;
                }
                field("Invoice No. not Updated"; InvoiceNoNotUpdated)
                {
                    Caption = 'Invoice No. not Updated';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    trigger OnDrillDown()
                    begin
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.FilterGroup(2);
                        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
                        RosterLedgerEntry.SetRange("Invoice No.", '');
                        RosterLedgerEntry.FilterGroup(0);
                        Page.RunModal(Page::"Roster Ledger Entries", RosterLedgerEntry)
                    end;
                }
                field("Check No. Updated"; CheckNoUpdated)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Caption = 'Check No. Updated';
                    trigger OnDrillDown()
                    begin
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.FilterGroup(2);
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
                        RosterLedgerEntry.SetFilter("Check No.", '<>%1', '');
                        RosterLedgerEntry.FilterGroup(0);
                        Page.RunModal(Page::"Roster Ledger Entries", RosterLedgerEntry)
                    end;
                }

                field("Check No. not Updated"; CheckNoNotUpdated)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Caption = 'Check No. not Updated';
                    trigger OnDrillDown()
                    begin
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.FilterGroup(2);
                        RosterLedgerEntry.Reset();
                        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
                        RosterLedgerEntry.SetRange("Check No.", '');
                        RosterLedgerEntry.FilterGroup(0);
                        Page.RunModal(Page::"Roster Ledger Entries", RosterLedgerEntry)
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("List of Rotation")
            {
                ApplicationArea = All;
                Caption = 'Open List of Rotations';
                ShortcutKey = 'F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;
                trigger OnAction()
                begin
                    OpenRotationEntries();
                end;
            }
        }
    }
    var
        EducationSetup: Record "Education Setup-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        TotalRotations: Integer;
        TotalRotationsGraded: Integer;
        InvoiceNoUpdated: Integer;
        InvoiceNoNotUpdated: Integer;
        CheckNoUpdated: Integer;
        CheckNoNotUpdated: Integer;

    trigger OnOpenPage()
    begin
        EducationSetup.Reset();
        if EducationSetup.Get() then;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        //TO_DO RosterLedgerEntry.SetRange(Grade, RosterLedgerEntry.Grade::" ");
        TotalRotations := RosterLedgerEntry.Count;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        //TO_DO RosterLedgerEntry.SetFilter(Grade, '<>%1', RosterLedgerEntry.Grade::" ");
        TotalRotationsGraded := RosterLedgerEntry.Count;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        //TO_DO RosterLedgerEntry.SetFilter(Grade, '<>%1', RosterLedgerEntry.Grade::" ");
        RosterLedgerEntry.SetFilter("Invoice No.", '<>%1', '');
        InvoiceNoUpdated := RosterLedgerEntry.Count;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        //TO_DO RosterLedgerEntry.SetFilter(Grade, '<>%1', RosterLedgerEntry.Grade::" ");
        RosterLedgerEntry.SetRange("Invoice No.", '');
        InvoiceNoNotUpdated := RosterLedgerEntry.Count;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        //TO_DO RosterLedgerEntry.SetFilter(Grade, '<>%1', RosterLedgerEntry.Grade::" ");
        RosterLedgerEntry.SetFilter("Check No.", '<>%1', '');
        CheckNoUpdated := RosterLedgerEntry.Count;

        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        //TO_DO RosterLedgerEntry.SetFilter(Grade, '<>%1', RosterLedgerEntry.Grade::" ");
        RosterLedgerEntry.SetRange("Check No.", '');
        CheckNoNotUpdated := RosterLedgerEntry.Count;
    end;

    /// <summary> 
    /// Description for OpenRotationEntries.
    /// </summary>
    procedure OpenRotationEntries()
    begin
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.FilterGroup(2);
        RosterLedgerEntry.SetRange("Hospital ID", Rec."No.");
        RosterLedgerEntry.FilterGroup(0);
        page.RunModal(Page::"Clerkship Payment Rotations", RosterLedgerEntry);
    end;
}