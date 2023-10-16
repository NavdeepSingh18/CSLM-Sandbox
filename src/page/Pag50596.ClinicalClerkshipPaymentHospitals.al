page 50596 "Clerkship Payment Hospitals"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Sub Type" = filter("Hospital"));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRotationEntriesInvoicing();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRotationEntriesInvoicing();
                    end;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        // area(FactBoxes)
        // {
        //     part("Information"; "Hospital Payment FactBox")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Rotation Payment Facts';
        //         SubPageLink = "No." = field("No.");
        //     }
        // }
    }

    actions
    {
        area(Processing)
        {
            action("List of Rotations")
            {
                ApplicationArea = All;
                Caption = 'List of Rotations';
                ShortcutKey = 'F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;
                trigger OnAction()
                begin
                    OpenRotationEntriesInvoicing();
                end;
            }
            action("Rotations for Check Updation")
            {
                ApplicationArea = All;
                Caption = 'Rotations for Check Updation';
                ShortcutKey = 'Ctrl+F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangeDates;
                trigger OnAction()
                var
                    ClincalRotationCheckUpdate: Page "Clincal Rotation Check Update";
                begin
                    Clear(ClincalRotationCheckUpdate);
                    // ClincalRotationCheckUpdate.SetVariables("No.", Name);
                    ClincalRotationCheckUpdate.RunModal();
                end;
            }
            action("Rotations for Advance Payment")
            {
                ApplicationArea = All;
                Caption = 'Rotations for Advance Payment';
                ShortcutKey = 'Ctrl+F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PaymentForecast;
                trigger OnAction()
                begin
                    OpenRotationEntriesAdvPayment();
                end;
            }

        }
    }
    /// <summary> 
    /// Description for OpenRotationEntries.
    /// </summary>
    procedure OpenRotationEntriesInvoicing()
    var
        RosterLedgerEntry: Record "Roster Ledger Entry";
        ClerkshipPaymentRotations: Page "Clerkship Payment Rotations";
    begin
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.FilterGroup(2);
        // RosterLedgerEntry.SetRange("Hospital ID", "No.");
        // RosterLedgerEntry.FilterGroup(0);
        // ClerkshipPaymentRotations.SetVariables("No.", Name);
        ClerkshipPaymentRotations.SetTableView(RosterLedgerEntry);
        ClerkshipPaymentRotations.RunModal();
    end;

    procedure OpenRotationEntriesAdvPayment()
    var
        RosterLedgerEntry: Record "Roster Ledger Entry";
    begin
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Hospital ID");
        RosterLedgerEntry.FilterGroup(2);
        // RosterLedgerEntry.SetRange("Hospital ID", "No.");
        RosterLedgerEntry.FilterGroup(0);
        // page.RunModal(Page::"Clerkship ADV Payment Rotation", RosterLedgerEntry);
    end;
}