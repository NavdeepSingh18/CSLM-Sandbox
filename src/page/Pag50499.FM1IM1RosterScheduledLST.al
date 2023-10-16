page 50499 "Publish FM1/IM1 Rotation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Line";
    SourceTableView = sorting("Start Date", "Rotation ID") where("Entry Type" = filter("FM1/IM1"), Status = filter(Scheduled | Unconfirmed));
    Caption = 'Publish FM1/IM1 Rotation';
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
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    LookupPageId = "Hospital Inventory Lookup";
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
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

    actions
    {
        area(Processing)
        {
            action("Publish")
            {
                ApplicationArea = All;
                Caption = 'Publish';
                ShortcutKey = 'F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostBatch;

                trigger OnAction()
                var
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    UserSetup: Record "User Setup";
                    User: Record User;
                    RotationIDs: List of [Text];
                    LastEntryNo: Integer;
                    I: Integer;
                    J: Integer;
                    Text001Lbl: Label 'Total Rows      ############1################\';
                    Text002Lbl: Label 'Processed Rows      ############2################\';
                    Text003Lbl: Label 'Action      ############3################\';
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                begin
                    I := 0;
                    T := 0;

                    RosterSchedulingLine.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingLine);
                    RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                    T := RosterSchedulingLine.Count;

                    if not Confirm('You have Selected %1 Rotations.\\\Do you want to Publish the FM1/IM1 Rotation of the Selected Records?', true, T) then
                        Exit;
                    LastEntryNo := 0;

                    W.Open('Updating Rotation Status..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    RosterSchedulingLine.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingLine);
                    RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                    if RosterSchedulingLine.Find('-') then begin
                        T := RosterSchedulingLine.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);
                            RosterSchedulingHeader.Reset();
                            if RosterSchedulingHeader.Get(RosterSchedulingLine."Rotation ID") then;

                            RosterSchedulingLine.TestField(Status, RosterSchedulingLine.Status::Scheduled);
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
                    end;

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.FindLast() then
                        LastEntryNo := RosterLedgerEntry."Entry No.";

                    RosterSchedulingLine.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingLine);
                    RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                    RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                    if RosterSchedulingLine.Find('-') then begin
                        T := RosterSchedulingLine.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);

                            LastEntryNo += 1;
                            Rec.PublishRotation(RosterSchedulingLine, LastEntryNo);
                            I += 1;
                            RotationIDs.Insert(I, RosterSchedulingLine."Rotation ID");
                        until RosterSchedulingLine.Next() = 0;
                    end;

                    for J := 1 to I do begin
                        RosterSchedulingHeader.Reset();
                        RosterSchedulingHeader.SetRange("Rotation ID", RotationIDs.Get(J));
                        if RosterSchedulingHeader.Find(('-')) then begin
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.SetRange("Rotation ID", RosterSchedulingHeader."Rotation ID");
                            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                            if not RosterSchedulingLine.FindFirst() then begin
                                RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Published;
                                RosterSchedulingHeader."Published By" := UserId;
                                RosterSchedulingHeader."Published On" := Today;
                                RosterSchedulingHeader.Modify();
                            end;
                        end;
                    end;

                    //TO_DO W.Update(3, 'Checking and Sending the Notification to Hospital.');
                    //TO_DO CheckNotificationToHospital(RosterSchedulingHeader);
                    W.Close();
                    Message('%1 Record(s) Published Sucessfully..', I);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
    end;
}