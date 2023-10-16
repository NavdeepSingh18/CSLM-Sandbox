page 50925 "License Tracking"
{
    Caption = 'License Tracking';
    Editable = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "License Tracking";
    SourceTableView = sorting("Student No.");

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("SLcM No."; Rec."SLcM No.")
                {
                    ApplicationArea = All;
                }
                field("License ID"; Rec."License ID")
                {
                    ApplicationArea = All;

                }
                field("License Type"; Rec."License Type")
                {
                    ApplicationArea = All;

                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;

                }
                field(Expiration; Rec.Expiration)
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }

            }

        }
    }
    actions
    {
        area(Processing)
        {
            group("Action")
            {

                Caption = 'Action';
                action("License Tracking Ledger")
                {
                    ApplicationArea = All;
                    Caption = 'License Tracking Ledger';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = List;
                    RunObject = page "License Tracking Ledger";
                    RunPageLink = "Student No." = field("SLcM No.");
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        InsertLicenceTrackingLedger(Rec);
    end;

    procedure InsertLicenceTrackingLedger(LicenceTracking: Record "License Tracking")
    var
        LicenceLedger: Record "License Tracking Ledger";
        LicenceLedger1: Record "License Tracking Ledger";
        LastNo: Integer;

    Begin
        LicenceLedger1.Reset();
        if LicenceLedger1.FINDLAST() then
            LastNo := LicenceLedger1."Entry No." + 1
        else
            LastNo := 1;

        LicenceLedger.Init();
        LicenceLedger."Entry No." := LastNo;
        LicenceLedger."Student No." := LicenceTracking."SLcM No.";
        LicenceLedger."License ID" := LicenceTracking."License ID";
        LicenceLedger."License Type" := LicenceTracking."License Type";
        LicenceLedger.State := LicenceTracking.State;
        LicenceLedger.Expiration := LicenceTracking.Expiration;
        LicenceLedger."Modified By" := UserId();
        LicenceLedger."Modified On" := Today();
        LicenceLedger."Document No." := LicenceTracking."Student No.";
        LicenceLedger.Insert(true);
    End;
}