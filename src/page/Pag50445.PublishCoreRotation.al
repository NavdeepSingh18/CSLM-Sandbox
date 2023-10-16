page 50445 "Publish Core Rotation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Line";
    SourceTableView = sorting("Rotation ID", Semester, "Last Name") where("Clerkship Type" = filter(Core), "Entry Type" = filter(Clerkship), Status = filter(Scheduled | Unconfirmed), "Rotation Confirmed" = filter(true));
    Caption = 'Publish Core Rotation';
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
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
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
                field(Waitlisted; Rec.Waitlisted)
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
                    HospitalCostMaster: Record "Hospital Cost Master";
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

                    if not Confirm('You have selected %1 record(s).\\\Do you want to Publish the selected core rotation(s)?', true, T) then
                        Exit;
                    LastEntryNo := 0;

                    W.Open('Updating Rotation Status..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    RosterSchedulingLine.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingLine);
                    RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                    RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Unconfirmed); //CSPL-00307 As per Ajay 20-03-2023
                    if RosterSchedulingLine.Find('-') then begin
                        T := RosterSchedulingLine.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);
                            RosterSchedulingLine.TestField(Status, RosterSchedulingLine.Status::Scheduled);
                        until RosterSchedulingLine.Next() = 0;
                    end;

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.FindLast() then
                        LastEntryNo := RosterLedgerEntry."Entry No.";

                    RosterSchedulingLine.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingLine);
                    RosterSchedulingLine.SetRange("Clerkship Type", Rec."Clerkship Type");
                    RosterSchedulingLine.SetFilter(Status, '%1|%2', RosterSchedulingLine.Status::Scheduled, RosterSchedulingLine.Status::Unconfirmed);//CSPL-00307 As per Ajay 20-03-2023
                    if RosterSchedulingLine.Find('-') then begin
                        T := RosterSchedulingLine.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);

                            RosterSchedulingHeader.Reset();
                            if RosterSchedulingHeader.Get(RosterSchedulingLine."Rotation ID") then;


                            HospitalCostMaster.Reset();
                            HospitalCostMaster.SetRange("Hospital ID", RosterSchedulingLine."Hospital ID");
                            HospitalCostMaster.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type");
                            HospitalCostMaster.SetFilter("Effective Date", '<=%1', RosterSchedulingLine."Start Date");
                            IF not HospitalCostMaster.FindLast() then
                                Error('Weekly Cost for the Hospital %1 (%2) Rotation Type - %3 not found.', RosterSchedulingLine."Hospital ID", RosterSchedulingLine."Hospital Name", RosterSchedulingLine."Course Type");

                            LastEntryNo += 1;
                            Rec.PublishRotation(RosterSchedulingLine, LastEntryNo);
                            I += 1;
                            RotationIDs.Insert(I, RosterSchedulingLine."Rotation ID");
                        until RosterSchedulingLine.Next() = 0;
                    end;

                    for J := 1 to I do begin
                        RosterSchedulingHeader.Reset();
                        RosterSchedulingHeader.SetRange("Rotation ID", RotationIDs.Get(J));
                        if RosterSchedulingHeader.FindFirst() then begin
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

                    //W.Update(3, 'Checking and Sending the Notification to Hospital.');
                    //CheckNotificationToHospital(RosterSchedulingHeader);
                    W.Close();
                    Message('%1 Record(s) published sucessfully..', I);
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin

    end;
}