page 50616 "All Rotation Factbox"
{
    PageType = ListPart;
    Caption = 'Rotation Information';
    UsageCategory = None;
    SourceTable = "Roster Scheduling Header";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            group(Information)
            {
                Editable = false;
                group("Rotation Information")
                {
                    field("Total Students"; NoOfAppliedStudents)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Total Students';
                        Editable = false;
                    }

                    field(ScheduledRecords; ScheduledRecords)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Scheduled Records';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.FilterGroup(2);
                            RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                            RosterSchedulingLine.SetRange("Status", RosterSchedulingLine."Status"::Scheduled);
                            RosterSchedulingLine.FilterGroup(0);
                            Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine);
                        end;
                    }
                    field(PublishedRecords; PublishedRecords)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Published Records';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.FilterGroup(2);
                            RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                            RosterSchedulingLine.SetRange("Status", RosterSchedulingLine."Status"::Published);
                            RosterSchedulingLine.FilterGroup(0);
                            Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine);
                        end;
                    }

                    field(CancelledRecords; CancelledRecords)
                    {
                        ApplicationArea = all;
                        Style = Unfavorable;
                        Caption = 'Cancelled Records';
                        Editable = false;
                        trigger OnDrillDown()
                        begin
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.FilterGroup(2);
                            RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                            RosterSchedulingLine.SetRange("Status", RosterSchedulingLine."Status"::Cancelled);
                            RosterSchedulingLine.FilterGroup(0);
                            Page.RunModal(Page::"Roster Scheduling Lines", RosterSchedulingLine);
                        end;
                    }
                }
            }
        }
    }

    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        NoOfAppliedStudents: Integer;
        ScheduledRecords: Integer;
        PublishedRecords: Integer;
        CancelledRecords: Integer;

    trigger OnAfterGetRecord()
    begin
        NoOfAppliedStudents := 0;
        ScheduledRecords := 0;
        PublishedRecords := 0;
        CancelledRecords := 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        NoOfAppliedStudents := RosterSchedulingLine.Count;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        RosterSchedulingLine.SetRange("Status", RosterSchedulingLine."Status"::Scheduled);
        ScheduledRecords := RosterSchedulingLine.Count;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        RosterSchedulingLine.SetRange("Status", RosterSchedulingLine."Status"::Published);
        PublishedRecords := RosterSchedulingLine.Count;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        RosterSchedulingLine.SetRange("Status", RosterSchedulingLine."Status"::Cancelled);
        CancelledRecords := RosterSchedulingLine.Count;
    end;
}