page 50608 "Student Rotation Cancellation"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group("Rotation Information")
            {
                group("Existing Rotation Information")
                {
                    field("Rotation ID"; Rec."Rotation ID")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Clerkship Type"; Rec."Clerkship Type")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                        Caption = 'Clerkship Type';
                    }
                    field("Hospital ID"; Rec."Hospital ID")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Student No."; Rec."Student No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Enrollment No."; Rec."Enrollment No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
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
                    field("Elective Course Code"; Rec."Elective Course Code")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        Visible = ElectiveCodeVisible;
                    }
                    field("Rotation Description"; Rec."Rotation Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        //Visible = ElectiveCodeVisible;
                    }
                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("No. of Weeks"; Rec."No. of Weeks")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Cancel Reason Code"; Rec."Cancel Reason Code")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        ShowMandatory = true;
                    }
                    field("Cancel Reason Description"; Rec."Cancel Reason Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
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
                ShortcutKey = 'F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;

                trigger OnAction()
                var
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    HospitalInventory: Record "Hospital Inventory";
                    RotationOfferApplication: Record "Rotation Offer Application";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    CALE: Record "Clerkship Activity Log Entries";
                    UserSetup_1: Record "User Setup";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if CancellationType = CancellationType::" " then
                        if not Confirm('Do you want to Cancel the Rotation of Student ID %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then begin
                            Rec."Cancel Reason Code" := '';
                            Rec."Cancel Reason Description" := '';
                            Rec.Modify();
                            exit;
                        end;

                    if CancellationType <> CancellationType::" " then
                        if not Confirm('Do you want to Cancel the Rotation of Student ID %1 (%2) - %3?', true, Rec."Student No.", Rec."Student Name", CancellationType) then begin
                            Rec."Cancel Reason Code" := '';
                            Rec."Cancel Reason Description" := '';
                            Rec.Modify();
                            exit;
                        end;
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

                    Rec.TestField("Cancel Reason Code");
                    Rec.TestField("Cancel Reason Description");

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.Get(Rec."Ledger Entry No.") then begin
                        begin
                            if RosterLedgerEntry."Invoice No." <> '' then
                                Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Invoice has been raised for the Rotation.', Rec."Student No.", Rec."Student Name");

                            if RosterLedgerEntry."Check No." <> '' then
                                Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Check has been updated in the Rotation.', Rec."Student No.", Rec."Student Name");

                            if NOT (RosterLedgerEntry."Rotation Grade" IN ['', 'X', 'M']) then //CSPL-00307_M_GradeIssue
                                Error('Cancellation of Rotation for the Student No. %1 (%2) is not allowed as Grade has been marked for the Rotation.', Rec."Student No.", Rec."Student Name");

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
                        end;

                        HospitalInventory.Reset();
                        HospitalInventory.SetRange("Hospital ID", Rec."Hospital ID");
                        HospitalInventory.SetRange("Course Code", Rec."Course Code");
                        HospitalInventory.SetRange("Clerkship Type", Rec."Clerkship Type");
                        HospitalInventory.SetRange("Start Date", Rec."Start Date");
                        if HospitalInventory.FindFirst() then begin
                            HospitalInventory."Consumed Seats" := HospitalInventory."Consumed Seats" - 1;
                            HospitalInventory."Available Seats" := HospitalInventory."Available Seats" + 1;
                            HospitalInventory.Modify();
                        end;
                    end;

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
                            RotationOfferApplication."Rotation Status" := RotationOfferApplication."Rotation Status"::Cancelled;
                            RotationOfferApplication.Modify();
                        end;
                    end;

                    if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then begin
                        ClerkshipSiteAndDateSelection.Reset();
                        ClerkshipSiteAndDateSelection.SetRange("Student No.", Rec."Student No.");
                        if Rec."FM1/IM1 Application No." <> '' then
                            ClerkshipSiteAndDateSelection.SetRange("Application No.", Rec."FM1/IM1 Application No.");
                        if ClerkshipSiteAndDateSelection.FindLast() then begin
                            ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Approved;
                            ClerkshipSiteAndDateSelection.Modify();
                        end;
                    end;

                    // IF Rec.Status = Rec.Status::"Published" then begin
                    //     // ClinicalNotification.RotationCancellation(Rec);

                    //     IF "Start Date" <= WorkDate() then //CSPL-00307-RTP
                    //         ClinicalNotification.RotationCancellationNotice(Rec);
                    // end;

                    Rec.RemoveStudentSubject(Rec);

                    Rec.Validate(Status, Rec.Status::Cancelled);

                    if CancellationType = CancellationType::" " then
                        Rec."Rotation Grade" := 'X';
                    if CancellationType = CancellationType::"Student Cancel" then
                        Rec."Rotation Grade" := 'SC';
                    if CancellationType = CancellationType::"University Cancel" then
                        Rec."Rotation Grade" := 'UC';

                    Rec."Cancelled By" := UserId;
                    Rec."Cancelled Date" := Today;
                    Rec."Cancelled Time" := Time;

                    if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
                        CALE.InsertLogEntry(4, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", '7015', 'Family Medicine I/Internal Medicine I');
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                        CALE.InsertLogEntry(5, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Course Code", Rec."Rotation Description");
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
                        CALE.InsertLogEntry(8, 10, Rec."Student No.", Rec."Student Name", Rec."Rotation ID", Rec."Cancel Reason Code", Rec."Cancel Reason Description", Rec."Elective Course Code", Rec."Rotation Description");

                    Rec.Modify(true);
                    CurrPage.Close();
                end;
            }
        }
    }


    var
        ElectiveCodeVisible: Boolean;
        CancellationType: Option " ","Student Cancel","University Cancel";

    trigger OnOpenPage()
    begin
        ElectiveCodeVisible := true;
        if Rec."Clerkship Type" <> Rec."Clerkship Type"::Elective then
            ElectiveCodeVisible := false;
    end;

    trigger OnAfterGetRecord()
    begin
        ElectiveCodeVisible := true;
        if Rec."Clerkship Type" <> Rec."Clerkship Type"::Elective then
            ElectiveCodeVisible := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec."Cancel Reason Code" <> '') and (Rec.Status <> Rec.Status::Cancelled) then
            Error('You must Cancel the Rotation OR Remove the Cancel Reason.');
    end;
}
