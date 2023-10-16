page 50747 "FM1_IM1 Roster Publish LST"
{
    Caption = 'Publish FM1/IM1 Roster';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Header";
    SourceTableView = sorting("Start Date", "Rotation ID") where("Clerkship Type" = filter("FM1/IM1"), "Entry Type" = filter("FM1/IM1"), Status = filter(Scheduled));
    CardPageId = "FM1/IM1 Roster Card+";
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
                    Style = Strong;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Style = Strong;
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
                    User: Record User;
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

                    if not Confirm('Do you want to Publish %1 Selected Rotation(s)?', true, T) then
                        exit;

                    W.Open('Publishing Rotations..\' + Text001Lbl + Text002Lbl + Text003Lbl);

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
                                    RosterSchedulingLine.TestField("Coordinator ID");
                                    User.Reset();
                                    User.SetRange("User Name", RosterSchedulingLine."Coordinator ID");
                                    if User.FindLast() then
                                        if User."Full Name" = '' then
                                            Error('Full Name does not updated on User for the FM1/IM1 Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");

                                    UserSetup.Reset();
                                    if UserSetup.Get(RosterSchedulingLine."Coordinator ID") then
                                        if UserSetup."E-Mail" = '' then
                                            Error('E-Mail does not updated on User Setup for the FM1/IM1 Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");
                                until RosterSchedulingLine.Next() = 0;
                        until RosterSchedulingHeader.Next() = 0;
                    end;

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
                            if not RosterSchedulingLine.FindFirst() then begin
                                RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Published;
                                RosterSchedulingHeader."Published By" := UserId;
                                RosterSchedulingHeader."Published On" := Today;
                                RosterSchedulingHeader.Modify();
                            end;
                        until RosterSchedulingHeader.Next() = 0;

                        W.Close();
                        Message('%1 Rotation(s) Published Sucessfully.', C);
                    end;
                end;
            }
        }
    }
}