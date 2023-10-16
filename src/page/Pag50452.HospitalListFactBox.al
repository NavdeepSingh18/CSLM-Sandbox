page 50452 "Hospital List FactBox"
{
    PageType = CardPart;
    //ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Hospital Inventory";
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
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Hospital Name"; Rec."Hospital Name")
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
                    MultiLine = true;
                }
                field("Total No. of Seats"; "TotalAvblSeats")
                {
                    Caption = 'Total No. of Seats';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    DecimalPlaces = 0;
                }
                field(PublishedSeats;PublishedSeats)
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
        HospitalInventory: Record "Hospital Inventory";
        RosterSchedulingLine: Record "Roster Scheduling Line";
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
    begin
        TotalAvblSeats := 0;
        PublishedSeats := 0;
        SeatsUnderScheduling := 0;
        AvblSeats := 0;
        if Rec."Hospital ID" <> '' then begin
            HospitalInventory.Reset();
            HospitalInventory.SetRange("Hospital ID", Rec."Hospital ID");
            HospitalInventory.SetRange("Start Date",Rec."Start Date");
            HospitalInventory.SetRange("Course Code", Rec."Course Code");
            HospitalInventory.SetRange("Clerkship Type", Rec."Clerkship Type");
            if HospitalInventory.Find('-') then
                TotalAvblSeats := HospitalInventory.Seats;

            if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then begin
                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Hospital ID", Rec."Hospital ID");
                RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                RosterSchedulingLine.SetRange("Course Code", Rec."Course Code");
                RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
                RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                PublishedSeats := RosterSchedulingLine.Count;

                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Hospital ID", Rec."Hospital ID");
                RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                RosterSchedulingLine.SetRange("Course Code", Rec."Course Code");
                RosterSchedulingLine.SetFilter(Status, '%1|%2|%3', RosterSchedulingLine.Status::Scheduled, RosterSchedulingLine.Status::Unconfirmed, RosterSchedulingLine.Status::"In-Review");
                RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                SeatsUnderScheduling := RosterSchedulingLine.Count;
            end;

            if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then begin
                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Hospital ID", Rec."Hospital ID");
                RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                RosterSchedulingLine.SetRange("Elective Course Code", Rec."Course Code");
                RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Published);
                PublishedSeats := RosterSchedulingLine.Count;

                RosterSchedulingLine.Reset();
                RosterSchedulingLine.SetRange("Hospital ID", Rec."Hospital ID");
                RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                RosterSchedulingLine.SetRange("Elective Course Code", Rec."Course Code");
                RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                SeatsUnderScheduling := RosterSchedulingLine.Count;
            end;

            AvblSeats := TotalAvblSeats - PublishedSeats - SeatsUnderScheduling;
        end;
    end;
}