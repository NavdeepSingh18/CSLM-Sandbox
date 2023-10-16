page 50446 "Roster Scheduling Lines"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Line";
    SourceTableView = sorting("Start Date") order(descending);
    Caption = 'Roster Scheduling Lines';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                }
                field("Course Prefix Description"; Rec."Course Prefix Description")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Rotation Status';
                }
                field(Waitlisted; Rec.Waitlisted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }

                field("Coordinator ID"; Rec."Coordinator ID")
                {
                    ApplicationArea = All;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(NoOfWeeksAttended; NoOfWeeksAttended)
                {
                    ApplicationArea = All;
                    Caption = 'No. of Week Attended';
                }
                field("New/Returning"; Rec."New/Returning")
                {
                    ApplicationArea = All;
                }
                field("Grade of Rotation"; Rec."Grade of Rotation")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Credits; Rec.Credits)
                {
                    ApplicationArea = All;
                }
                field("Ledger Entry No."; Rec."Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled On"; Rec."Scheduled On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason Description"; Rec."Cancel Reason Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        NoOfWeeksAttended: Integer;
        ToDate: Date;

    trigger OnOpenPage()
    var
        LDate: Record Date;
    begin
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
        NoOfWeeksAttended := 0;
        if (Rec.Status = Rec.Status::Published) and (NOT (Rec."Rotation Grade" in ['', 'X', 'SC', 'UC', 'TC'])) then
            if ToDate >= Rec."End Date" then
                NoOfWeeksAttended := Round((((Rec."End Date" - Rec."Start Date") + 1 + 2) / 7), 1, '=')
            else
                NoOfWeeksAttended := Round((((ToDate - Rec."Start Date") + 1 + 2) / 7), 1, '=');

        if Rec."Ledger Entry No." = 0 then
            if Rec.Status = Rec.Status::Cancelled then
                Rec."Grade of Rotation" := 'X';
    end;
}