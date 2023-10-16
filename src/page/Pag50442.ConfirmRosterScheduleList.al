page 50442 "Confirm Roster Schedule List"
{
    Caption = 'Confirmed Roster Scheduling List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Header";
    SourceTableView = where("Clerkship Type" = filter(Core), "Entry Type" = filter(Clerkship), Status = filter(Scheduled | Published | Cancelled), "Rotation Confirmed" = filter(true));
    CardPageId = "Confirm Roster Scheduling Card";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("List")
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Umbrella Rotation"; Rec."Umbrella Rotation")
                {
                    ApplicationArea = All;
                    Caption = 'Umbrella Rotation';
                }
                field("Elective Mandatory"; Rec."Elective Mandatory")
                {
                    ApplicationArea = All;
                    Caption = 'Elective Mandatory';
                }

                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("No. of Students Published"; Rec."No. of Students Published")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("No. of Students Schedule"; Rec."No. of Students Schedule")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("No. of Students Completed"; Rec."No. of Students Completed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("No. of Students Cancelled"; Rec."No. of Students Cancelled")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field(AvblSeats; AvblSeats)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'No. of Seats Available';
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
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
                field("Scheduled By"; Rec."Scheduled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Publish Rotation")
            {
                ApplicationArea = All;
                Caption = 'Publish Rotation';
                ShortcutKey = 'Ctrl+U';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PutAwayWorksheet;
                Visible = false;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    Text001Lbl: Label 'Total Rotations      ############1################\';
                    Text002Lbl: Label 'Rotation in Progress      ############2################\';
                    Text003Lbl: Label 'Action      ############3################\';
                    LastEntryNo: Integer;
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                begin
                    T := 0;
                    C := 0;

                    RosterSchedulingHeader.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingHeader);
                    T := RosterSchedulingHeader.Count;

                    if not Confirm('You have Selected %1 Rotations.\\\Do you want to Publish Selected Rotation(s)?', true, T) then
                        exit;

                    W.Open('Publishing Rotations..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.FindLast() then
                        LastEntryNo := RosterLedgerEntry."Entry No.";

                    RosterSchedulingHeader.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingHeader);
                    if RosterSchedulingHeader.FindSet() then begin
                        T := RosterSchedulingHeader.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.SetRange("Rotation ID", RosterSchedulingHeader."Rotation ID");
                            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                            if RosterSchedulingLine.FindSet() then
                                repeat
                                    LastEntryNo := LastEntryNo + 1;
                                    RosterSchedulingLine.PublishRotation(RosterSchedulingLine, LastEntryNo);
                                until RosterSchedulingLine.Next() = 0;

                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.SetRange("Rotation ID", RosterSchedulingHeader."Rotation ID");
                            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                            if not RosterSchedulingLine.Find('-') then begin
                                RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Published;
                                RosterSchedulingHeader.Modify();
                            end;
                        until RosterSchedulingHeader.Next() = 0;

                        W.Update(3, 'Checking and Sending the Notification to Hospital.');

                        RosterSchedulingLine.CheckNotificationToHospital(Rec);
                        W.Close();
                        Message('%1 Record(s) Published Sucessfully..', C);
                    end;
                end;
            }
        }
    }

    var
        AvblSeats: Integer;

    trigger OnAfterGetRecord()
    begin
        AvblSeats := Rec."No. of Seats" - Rec."No. of Students Published" - Rec."No. of Students Schedule" - Rec."No. of Students Completed";
    end;
}