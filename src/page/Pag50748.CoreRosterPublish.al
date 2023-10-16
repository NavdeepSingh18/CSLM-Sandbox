page 50748 "Core Roster Publish List"
{
    Caption = 'Publish Core Roster';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Header";
    SourceTableView = sorting("Created On") order(descending) where("Clerkship Type" = filter(Core), "Entry Type" = filter(Clerkship), Status = filter(Scheduled), "Rotation Confirmed" = filter(true));
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
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update DME and Preceptor Details")
            {
                ApplicationArea = All;
                Caption = 'Update DME and Preceptor Details';
                ShortcutKey = 'Ctrl+T';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DefaultDimension;
                Visible = false;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                begin
                    Rec.TestField("Course Code");
                    Rec.TestField("Hospital ID");
                    Rec.TestField("Start Date");

                    RosterSchedulingHeader.Reset();
                    RosterSchedulingHeader.FilterGroup(2);
                    RosterSchedulingHeader.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingHeader.FilterGroup(0);
                    Page.RunModal(Page::"DME and Preceptor Update", RosterSchedulingHeader);
                end;
            }
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
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    UserSetup: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                    User: Record User;
                    Text001Lbl: Label 'Total Rotations      ############1################\';
                    Text002Lbl: Label 'Rotation in Progress      ############2################\';
                    Text003Lbl: Label 'Action      ############3################\';
                    LastEntryNo: Integer;
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                begin
                    W.Open('Checking Rotation Details..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    T := 0;
                    C := 0;

                    RosterSchedulingHeader.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingHeader);
                    if RosterSchedulingHeader.FindSet() then begin
                        T := RosterSchedulingHeader.Count;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.SetRange("Rotation ID", RosterSchedulingHeader."Rotation ID");
                            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                            if RosterSchedulingLine.FindSet() then
                                repeat
                                    User.Reset();
                                    User.SetRange("User Name", RosterSchedulingLine."Coordinator ID");
                                    if User.FindLast() then
                                        if User."Full Name" = '' then
                                            Error('Full Name does not updated on User for the Cordinator ID %1.', RosterSchedulingLine."Coordinator ID");

                                    UserSetup.Reset();
                                    if UserSetup.Get(RosterSchedulingLine."Coordinator ID") then
                                        if UserSetup."E-Mail" = '' then
                                            Error('E-Mail does not updated on User Setup for the Cordinator ID %1.', RosterSchedulingLine."Coordinator ID");
                                until RosterSchedulingLine.Next() = 0;
                        until RosterSchedulingHeader.Next() = 0;
                        W.Close();
                    end;

                    RosterSchedulingHeader.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingHeader);
                    T := RosterSchedulingHeader.Count;

                    if not Confirm('Do you want to Publish %1 Selected Rotation(s)?', true, T) then
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
                            RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Published);//CSPL-00307-RTP
                            if not RosterSchedulingLine.FindFirst() then begin
                                RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Published;
                                RosterSchedulingHeader."Published By" := UserId;
                                RosterSchedulingHeader."Published On" := Today;
                                CALE.InsertLogEntry(5, 4, 'NA', 'NA', RosterSchedulingHeader."Rotation ID", '', '', RosterSchedulingHeader."Course Code", RosterSchedulingHeader."Course Description");
                                RosterSchedulingHeader.Modify();
                            end;
                        until RosterSchedulingHeader.Next() = 0;

                        //W.Update(3, 'Checking and Sending the Notification to Hospital.');

                        //RosterSchedulingLine.CheckNotificationToHospital(Rec);
                        W.Close();
                        Message('%1 Rotation(s) Published Sucessfully..', C);
                    end;
                end;
            }
        }
    }
}