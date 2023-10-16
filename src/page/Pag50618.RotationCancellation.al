page 50618 "Rotation Cancellation"
{
    Caption = 'Rotation Cancellation';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Rotation Information")
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
                    }
                    field("Course Code"; Rec."Course Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Course Description"; Rec."Course Description")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                    }
                    field("Elective Course Code"; Rec."Elective Course Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Visible = Elective;
                    }
                    field("Rotation Description"; Rec."Rotation Description")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                    }
                    field("Academic Year"; Rec."Academic Year")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Hospital ID"; Rec."Hospital ID")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        ShowMandatory = true;
                        LookupPageId = "Hospital Inventory Lookup";
                    }
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        MultiLine = true;
                        Editable = false;
                    }

                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Style = Strong;
                        Editable = false;
                    }
                    field("No. of Weeks"; Rec."No. of Weeks")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Editable = false;
                        Style = Strong;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Editable = false;
                        Style = Strong;
                    }
                    field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Editable = false;
                        Style = Unfavorable;
                    }
                    field("No. of Students"; Rec."No. of Students")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                    }
                }
                group("Input")
                {
                    field("Cancel Reason Code"; Rec."Cancel Reason Code")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        ShowMandatory = true;
                    }
                    field("Cancel Reason"; Rec."Cancel Reason")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        ShowMandatory = true;
                        MultiLine = true;
                    }
                    field(CancellationType; CancellationType)
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Caption = 'Cancellation Type';
                        OptionCaption = ' ,Student Cancel,University Cancel';
                        Visible = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Confirm")
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'Ctrl+F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    HospitalInventory: Record "Hospital Inventory";
                    UserSetup: Record "User Setup";
                    UserSetup_1: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                    RotationOfferApplication: Record "Rotation Offer Application";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    if RosterSchedulingLine.FindSet() then
                        repeat
                            StudentMaster.Reset();
                            if StudentMaster.Get(RosterSchedulingLine."Student No.") then
                                StudentMaster.TestField("E-Mail Address");

                            UserSetup.Reset();
                            if UserSetup.Get(RosterSchedulingLine."Coordinator ID") then begin
                                if UserSetup."E-Mail" = '' then
                                    Error('E-Mail does not updated on User Setup for the Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");
                            end
                            else
                                Error('User Setup not found for the Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");
                        until RosterSchedulingLine.Next() = 0;

                    if CancellationType = CancellationType::" " then
                        if not Confirm('Do you want to Cancel the Rotation?', true) then begin
                            Rec."Cancel Reason Code" := '';
                            Rec."Cancel Reason" := '';
                            Rec.Modify();
                            exit;
                        end;

                    if CancellationType <> CancellationType::" " then
                        if not Confirm('Do you want to Cancel the Rotation - %1?', true, CancellationType) then begin
                            Rec."Cancel Reason Code" := '';
                            Rec."Cancel Reason" := '';
                            Rec.Modify();
                            exit;
                        end;

                    Rec.TestField("Cancel Reason Code");
                    Rec.TestField("Cancel Reason");

                    //CSPL-00307-RTP
                    IF WorkDate() > Rec."End Date" then
                        Error('You Can Not Cancelled this rotation as it is ended');

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
                    if RosterSchedulingLine.FindSet() then
                        repeat
                            RosterLedgerEntry.Reset();
                            if RosterLedgerEntry.Get(RosterSchedulingLine."Ledger Entry No.") then begin
                                if RosterLedgerEntry."Invoice No." <> '' then
                                    Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Invoice has been raised for the Rotation.', RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name");

                                if RosterLedgerEntry."Check No." <> '' then
                                    Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Check has been updated in the Rotation.', RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name");

                                if NOT (RosterLedgerEntry."Rotation Grade" IN ['', 'X', 'M']) then //CSPL-00307_M_GradeIssue
                                    Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Grade has been marked for the Rotation.', RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name");

                                if CancellationType = CancellationType::" " then
                                    RosterLedgerEntry."Rotation Grade" := 'X';
                                if CancellationType = CancellationType::"Student Cancel" then
                                    RosterLedgerEntry."Rotation Grade" := 'SC';
                                if CancellationType = CancellationType::"University Cancel" then
                                    RosterLedgerEntry."Rotation Grade" := 'UC';

                                RosterLedgerEntry."Cancelled By" := UserId;
                                RosterLedgerEntry."Cancelled On" := Today;
                                RosterLedgerEntry.Status := RosterLedgerEntry.Status::Cancelled;
                                RosterLedgerEntry.Modify();

                                HospitalInventory.Reset();
                                HospitalInventory.SetRange("Hospital ID", RosterSchedulingLine."Hospital ID");
                                HospitalInventory.SetRange("Course Code", RosterSchedulingLine."Course Code");
                                HospitalInventory.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type");
                                HospitalInventory.SetRange("Start Date", RosterSchedulingLine."Start Date");
                                if HospitalInventory.FindFirst() then begin
                                    HospitalInventory."Consumed Seats" := HospitalInventory."Consumed Seats" - 1;
                                    HospitalInventory."Available Seats" := HospitalInventory."Available Seats" + 1;
                                    HospitalInventory.Modify();
                                end;
                            end;

                            if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Elective then begin
                                RotationOfferApplication.Reset();
                                if RosterSchedulingLine."Elective Application No." <> '' then
                                    RotationOfferApplication.SetRange("Application No.", RosterSchedulingLine."Elective Application No.")
                                else begin
                                    RotationOfferApplication.SetRange("Offer No.", RosterSchedulingLine."Offer No.");
                                    RotationOfferApplication.SetRange("Line No.", RosterSchedulingLine."Offer Application Line No.");
                                end;
                                if RotationOfferApplication.FindFirst() then begin
                                    RotationOfferApplication."Approval Status" := RotationOfferApplication."Approval Status"::"Rotation Cancelled";
                                    RotationOfferApplication.Modify();
                                end;
                            end;

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

                            // IF RosterSchedulingLine.Status = RosterSchedulingLine.Status::"Published" then begin
                            //     ClinicalNotification.RotationCancellation(RosterSchedulingLine);

                            //     IF "Start Date" <= WorkDate() then //CSPL-00307-RTP
                            //         ClinicalNotification.RotationCancellationNotice(RosterSchedulingLine);
                            // end;
                            RosterSchedulingLine.Validate(Status, RosterSchedulingLine.Status::Cancelled);

                            if CancellationType = CancellationType::" " then
                                RosterSchedulingLine."Rotation Grade" := 'X';
                            if CancellationType = CancellationType::"Student Cancel" then
                                RosterSchedulingLine."Rotation Grade" := 'SC';
                            if CancellationType = CancellationType::"University Cancel" then
                                RosterSchedulingLine."Rotation Grade" := 'UC';

                            RosterSchedulingLine."Cancelled By" := UserId;
                            RosterSchedulingLine."Cancelled Date" := Today;
                            RosterSchedulingLine."Cancelled Time" := Time;
                            if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::"FM1/IM1" then
                                CALE.InsertLogEntry(4, 10, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason", '7015', 'Family Medicine I/Internal Medicine I');
                            if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Core then
                                CALE.InsertLogEntry(5, 10, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason", RosterSchedulingLine."Course Code", RosterSchedulingLine."Rotation Description");
                            if RosterSchedulingLine."Clerkship Type" = RosterSchedulingLine."Clerkship Type"::Elective then
                                CALE.InsertLogEntry(8, 10, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason", RosterSchedulingLine."Elective Course Code", RosterSchedulingLine."Rotation Description");

                            RosterSchedulingLine.RemoveStudentSubject(RosterSchedulingLine);

                            RosterSchedulingLine.Modify();
                        until RosterSchedulingLine.Next() = 0;

                    Rec.Validate(Status, Rec.Status::Cancelled);
                    Rec.Modify();
                    Message('Rotation Status changed to Cancelled.');
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Elective := false;
        if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
            Elective := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Elective := false;
        if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
            Elective := true;
    end;

    var
        Elective: Boolean;
        CancellationType: Option " ","Student Cancel","University Cancel";
}