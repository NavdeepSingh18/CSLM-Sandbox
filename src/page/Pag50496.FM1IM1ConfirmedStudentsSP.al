page 50496 "FM1_IM1 Confirmed Students SP"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    Caption = 'FM1/IM1 Roster Lines';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Coordinator ID"; Rec."Coordinator ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New/Returning"; Rec."New/Returning")
                {
                    ApplicationArea = All;
                }
                field("Rotation Grade"; Rec."Rotation Grade")
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
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                }
                field("Cancelled Date"; Rec."Cancelled Date")
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
            action("Cancel Rotation")
            {
                ApplicationArea = All;
                Caption = 'Cancel Rotation';
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Cancel;

                trigger OnAction()
                var
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    UserSetup_1: Record "User Setup";
                begin
                    if Rec.Status = Rec.Status::Cancelled then
                        Error('Rotation for the Student - %1 (%2) is already cancelled', Rec."Student No.", Rec."Student Name");

                    IF Rec."Start Date" <= WorkDate() then begin
                        UserSetup_1.Reset();
                        if UserSetup_1.Get(UserId) then
                            if UserSetup_1."Clinical Administrator" = false then
                                Error('Rotation is already started, it cannot be cancelled.')
                            else
                                if not Confirm('Rotation is already started.\Do you still want to cancel it?') then
                                    Error('Action stopped to respect the Started Rotation warning.');
                    end;

                    if Rec."Start Date" - WorkDate() <= 45 then
                        if not Confirm('Do you want to cancel the Rotation, as it is within 45 Days') then
                            exit;
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                    RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                    RosterSchedulingLine.SetRange("Rotation No.", Rec."Rotation No.");
                    page.RunModal(Page::"Student Rotation Cancellation", RosterSchedulingLine);
                end;
            }

            action("Delete Student")
            {
                ShortcutKey = 'Ctrl+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DeleteRow;
                ApplicationArea = All;
                trigger OnAction()
                var
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    RosterSchdLineLogEntry: Record "Roster Schd. Line Log Entry";
                    RosterSchdLineLogEntry_1: Record "Roster Schd. Line Log Entry";
                    CALE: Record "Clerkship Activity Log Entries";
                    StudentMaster: Record "Student Master-CS";
                    LogEntryNo: Integer;
                begin
                    if Confirm('Do you want to remove the Student No. %1 (%2) from FM1/IM1 Roster No. %3 Start Date %4?', true, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Start Date", Rec."End Date") then begin
                        StudentMaster.Reset();
                        if StudentMaster.Get(Rec."Student No.") then;

                        RosterSchedulingHeader.Reset();
                        if RosterSchedulingHeader.Get(Rec."Rotation ID") then;

                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                        RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                        if RosterSchedulingLine.FindFirst() then begin
                            if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::"FM1/IM1" then begin
                                ClerkshipSiteAndDateSelection.Reset();
                                ClerkshipSiteAndDateSelection.SetRange("Student No.", RosterSchedulingLine."Student No.");
                                if RosterSchedulingLine."FM1/IM1 Application No." <> '' then
                                    ClerkshipSiteAndDateSelection.SetRange("Application No.", RosterSchedulingLine."FM1/IM1 Application No.");
                                if ClerkshipSiteAndDateSelection.FindLast() then begin
                                    ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Approved;
                                    ClerkshipSiteAndDateSelection.Modify();
                                end;
                            end;

                            if RosterSchedulingLine.Status = RosterSchedulingLine.Status::Published then begin
                                RosterLedgerEntry.Reset();
                                if RosterLedgerEntry.Get(RosterSchedulingLine."Ledger Entry No.") then begin
                                    if RosterLedgerEntry."Invoice No." <> '' then
                                        Error('Removal of Student No. %1 (%2) is not allowed as Invoice has been raised for the Rotation.', Rec."Student No.", Rec."Student Name");
                                    if not (RosterLedgerEntry."Rotation Grade" in ['', 'X']) then
                                        Error('Removal of Student No. %1 (%2) is not allowed as Grade has been marked for the Rotation.', Rec."Student No.", Rec."Student Name");

                                    RosterLedgerEntry.Delete();
                                end;
                            end;

                            Rec.RemoveStudentSubject(Rec);

                            RosterSchdLineLogEntry_1.Reset();
                            RosterSchdLineLogEntry_1.SetRange("Rotation ID", Rec."Rotation ID");
                            RosterSchdLineLogEntry_1.SetRange("Academic Year", Rec."Academic Year");
                            RosterSchdLineLogEntry_1.SetRange("Student No.", Rec."Student No.");
                            if RosterSchdLineLogEntry_1.FindLast() then;

                            LogEntryNo := RosterSchdLineLogEntry_1."Entry No." + 1;

                            RosterSchdLineLogEntry.Init();
                            RosterSchdLineLogEntry.TransferFields(Rec);
                            RosterSchdLineLogEntry."Entry No." := LogEntryNo;
                            RosterSchdLineLogEntry."Deleted By" := UserId;
                            RosterSchdLineLogEntry."Deleted Date" := Today;
                            RosterSchdLineLogEntry."Deleted Time" := Time;
                            RosterSchdLineLogEntry.Insert();
                            CALE.InsertLogEntry(4, 9, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', '7015', 'Family Medicine I/Internal Medicine I');
                            RosterSchedulingLine.Delete();
                        end;
                    end;
                end;
            }
        }
    }
}