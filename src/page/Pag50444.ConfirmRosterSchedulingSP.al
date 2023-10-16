page 50444 "Confirm Roster Scheduling SP"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    SourceTableView = sorting("Rotation No.");
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    // myInt: Integer;
                    begin
                        IF xRec.Status = xRec.Status::Published then
                            Error('You Can Not Change a Published Rotation');
                    end;
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
                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                }
                field("New/Returning"; Rec."New/Returning")
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
                field("Ledger Entry No."; Rec."Ledger Entry No.")
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
            action("Interchange Student Rotation")
            {
                ApplicationArea = All;
                Caption = 'Interchange Student Rotation';
                ShortcutKey = 'Ctrl+I';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangeDimensions;

                trigger OnAction()
                var
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                begin
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.FilterGroup(2);
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                    RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                    RosterSchedulingLine.FilterGroup(0);
                    Page.RunModal(Page::"Student Rotation Interchange", RosterSchedulingLine)
                end;
            }

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
                begin
                    //CSPL-00307-RTP
                    if Rec.Status = Rec.Status::Cancelled then
                        Error('Status of the Rotation for the Student ID %1 (%2) has been already Cancelled', Rec."Student No.", Rec."Student Name");

                    // IF "Start Date" <= WorkDate() then
                    //     Error('Rotation can not be Cancelled.As it is a Started Rotation.');

                    // if "Start Date" - WorkDate() <= 45 then
                    //     if not Confirm('Do you want to Cancel the Rotation, as it is within 45 Days') then
                    //         exit;
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange("Rotation No.", Rec."Rotation No.");
                    RosterSchedulingLine.SetRange("Academic Year", Rec."Academic Year");
                    RosterSchedulingLine.SetRange("Student No.", Rec."Student No.");
                    page.RunModal(Page::"Student Rotation Cancellation", RosterSchedulingLine);
                end;
            }
            action("Delete Student")
            {
                ApplicationArea = All;
                Caption = 'Delete Student';
                ShortcutKey = 'Ctrl+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;

                trigger OnAction()
                var
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    RosterSchdLineLogEntry: Record "Roster Schd. Line Log Entry";
                    RosterSchdLineLogEntry_1: Record "Roster Schd. Line Log Entry";
                    CALE: Record "Clerkship Activity Log Entries";
                    UserSetup_1: Record "User Setup";
                    StudentMaster: Record "Student Master-CS";
                    LogEntryNo: Integer;
                begin
                    if not Confirm('Do you want to Delete the Student ID %1 (%2) form Core Rotation?', true, Rec."Student No.", Rec."Student Name") then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student No.") then;

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
                        if not Confirm('Do you want to Cancel the Rotation, as it is within 45 Days') then
                            exit;

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.Get(Rec."Ledger Entry No.") then begin
                        if RosterLedgerEntry."Invoice No." <> '' then
                            Error('Deletion of Student No. %1 (%2) is not allowed as Invoice has been raised for the Rotation.', Rec."Student No.", Rec."Student Name");
                        if not (RosterLedgerEntry."Rotation Grade" in ['', 'X']) then
                            Error('Deletion of Student No. %1 (%2) is not allowed as Grade has been marked for the Rotation.', Rec."Student No.", Rec."Student Name");
                        RosterLedgerEntry.Delete();
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
                    CALE.InsertLogEntry(5, 9, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", '', '', Rec."Course Code", Rec."Rotation Description");
                    Rec.Delete();
                end;
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    // var
    begin
        if Rec.Status = Rec.Status::Published then
            Error('Status Can not be changed to Published');//CSPL-00307-RTP
    end;
}