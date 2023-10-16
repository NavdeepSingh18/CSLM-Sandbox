page 50458 "Elective Rotation SP"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    SourceTableView = sorting("Last Name");
    Caption = 'Rotation Scheduling Lines';
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
                    UserSetup_1: Record "User Setup";
                begin
                    if Rec.Status = Rec.Status::Cancelled then
                        Error('Status of the Rotation for the Student ID %1 (%2) has been already Cancelled', REc."Student No.", REc."Student Name");

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
                    RotationOfferApplication: Record "Rotation Offer Application";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    RosterSchdLineLogEntry: Record "Roster Schd. Line Log Entry";
                    RosterSchdLineLogEntry_1: Record "Roster Schd. Line Log Entry";
                    CALE: Record "Clerkship Activity Log Entries";
                    StudentMaster: Record "Student Master-CS";
                    LogEntryNo: Integer;
                begin
                    if not Confirm('Do you want to Delete the Student ID %1 (%2) form Elective Rotation?', true, REc."Student No.", REc."Student Name") then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student No.") then;

                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then begin
                        RotationOfferApplication.Reset();
                        if Rec."Elective Application No." <> '' then
                            RotationOfferApplication.SetRange("Application No.", Rec."Elective Application No.")
                        else begin
                            RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                            RotationOfferApplication.SetRange("Line No.", Rec."Offer Application Line No.");
                        end;
                        if RotationOfferApplication.FindFirst() then begin
                            RotationOfferApplication."Approval Status" := RotationOfferApplication."Approval Status"::"Rotation Cancelled";
                            RotationOfferApplication.Modify();
                        end;
                    end;

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.Get(Rec."Ledger Entry No.") then begin
                        if RosterLedgerEntry."Invoice No." <> '' then
                            Error('Deletion of Student No. %1 (%2) is not allowed as Invoice has been raised for the Rotation.', REc."Student No.", REc."Student Name");
                        if not (RosterLedgerEntry."Rotation Grade" in ['', 'X']) then
                            Error('Deletion of Student No. %1 (%2) is not allowed as Grade has been marked for the Rotation.', REc."Student No.", REc."Student Name");

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
                    CALE.InsertLogEntry(8, 9, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                    Rec.Delete();
                end;
            }
        }
    }
}