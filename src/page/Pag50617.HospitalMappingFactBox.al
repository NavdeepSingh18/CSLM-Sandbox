page 50617 "Hospital Mapping FactBox"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Roster Scheduling Line";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Rotation Information")
            {
                field("Coordinator ID"; Rec."Coordinator ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
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
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                }
                field("Total No. of Seats"; Rec."Total No. of Seats")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    DecimalPlaces = 0;
                }
                field(PublishedSeats; PublishedSeats)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    DecimalPlaces = 0;
                    Caption = 'Published Seats';
                }
                field(SeatsUnderScheduling; SeatsUnderScheduling)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    DecimalPlaces = 0;
                    Caption = 'Seats Under Scheduling';
                }
                field(AvblSeats; AvblSeats)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    DecimalPlaces = 0;
                    Caption = 'Available Seats';
                }
            }
        }
    }

    var
        TotalAvblSeats: Decimal;
        PublishedSeats: Decimal;
        SeatsUnderScheduling: Decimal;
        AvblSeats: Decimal;

    trigger OnAfterGetRecord()
    begin
        CheckAvblSeatsFact();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CheckAvblSeatsFact();
    end;

    /// <summary> 
    /// Description for CheckAvblSeatsFact.
    /// </summary>
    procedure CheckAvblSeatsFact()
    var
        HospitalInventory: Record "Hospital Inventory";
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        TotalAvblSeats := 0;
        PublishedSeats := 0;
        SeatsUnderScheduling := 0;
        AvblSeats := 0;
        if Rec."Hospital ID" <> '' then begin
            HospitalInventory.Reset();
            HospitalInventory.SetRange("Hospital ID", Rec."Hospital ID");
            HospitalInventory.SetRange("Academic Year", Rec."Academic Year");
            HospitalInventory.SetRange("Course Code", Rec."Course Code");
            HospitalInventory.SetRange("Clerkship Type", Rec."Clerkship Type");
            if HospitalInventory.FindFirst() then
                TotalAvblSeats := HospitalInventory.Seats;

            RosterSchedulingLine.Reset();
            RosterSchedulingLine.SetRange("Hospital ID", Rec."Hospital ID");
            RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
            RosterSchedulingLine.SetRange("Course Code", Rec."Course Code");
            RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
            PublishedSeats := RosterSchedulingLine.Count;

            RosterSchedulingLine.Reset();
            RosterSchedulingLine.SetRange("Hospital ID", Rec."Hospital ID");
            RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
            RosterSchedulingLine.SetFilter(Status, '%1|%2|%3', RosterSchedulingLine.Status::Scheduled, RosterSchedulingLine.Status::Unconfirmed, RosterSchedulingLine.Status::"In-Review");
            RosterSchedulingLine.SetRange("Course Code", Rec."Course Code");
            RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
            SeatsUnderScheduling := RosterSchedulingLine.Count;

            AvblSeats := TotalAvblSeats - PublishedSeats - SeatsUnderScheduling;
        end;
    end;
}