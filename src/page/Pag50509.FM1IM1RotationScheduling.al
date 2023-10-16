page 50509 "FM1_IM1_RotationScheduling"
{
    Caption = 'FM1/IM1 Clerkship Rotation Scheduling';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ClerkshipSiteAndDateSelection;
    SourceTableView = sorting("Preferred Start Date") where(Confirmed = filter(true), Status = filter(Approved));
    CardPageId = "UNVClkshpSite_DateCRD+";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Confirmed Site ID"; Rec."Confirmed Site ID")
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Site ID';
                }
                field("Confirmed Site Name"; Rec."Confirmed Site Name")
                {
                    ApplicationArea = All;
                    Caption = 'Confirmed Site Name';
                }
                field("Preferred Start Date"; Rec."Preferred Start Date")
                {
                    ApplicationArea = All;
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Confirmed; Rec.Confirmed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Confirmed On"; Rec."Confirmed On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Schedule Rotation")
            {
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EducationSetup: Record "Education Setup-CS";
                    UserSetup: Record "User Setup";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
                    StudentMaster: Record "Student Master-CS";
                    StudentDocumentAttachment: Record "Student Document Attachment";
                    //HospitalCostMaster: Record "Hospital Cost Master";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    StudentSubjectExam: Record "Student Subject Exam";
                    CALE: Record "Clerkship Activity Log Entries";
                    LastEntryNo: Integer;
                    SelectedRecords: Integer;
                    ScheduledRecords: Integer;
                    PrefferedDateSetID: Code[20];
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                    Text001Lbl: Label 'Records in Process      ############1################\';
                begin
                    UserSetup.Reset();
                    if not UserSetup.Get(UserId) then
                        Error('User Setup not found for the User ID %1.', UserId);

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetup.FindFirst() then;

                    PrefferedDateSetID := '';
                    ScheduledRecords := 0;
                    ClerkshipSiteAndDateSelection.Reset();
                    ClerkshipSiteAndDateSelection.SetCurrentKey("Confirmed Site ID");
                    CurrPage.SetSelectionFilter(ClerkshipSiteAndDateSelection);
                    ClerkshipSiteAndDateSelection.SetFilter("Confirmed Site ID", '<>%1', '');
                    ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::Approved);
                    SelectedRecords := ClerkshipSiteAndDateSelection.Count;
                    C := 0;
                    T := SelectedRecords;
                    W.Open('Scheduling of FM1/IM1 Rotation in Process\' + Text001Lbl);
                    if Confirm('You have Selected %1 Records.\\\Do you want to Schedule the Rotations for Selected Records?', true, SelectedRecords) then begin
                        if ClerkshipSiteAndDateSelection.FindSet() then
                            repeat
                                C += 1;
                                W.Update(1, Format(C) + ' of ' + Format(T));

                                if ClerkshipSiteAndDateSelection."Preset Start Date ID" = '' then
                                    Error('Preset Start Date ID must not be blank for the Student No. %1 (%2)\Please check the FM1/IM1 Application No. %3',
                                    ClerkshipSiteAndDateSelection."Student No.", ClerkshipSiteAndDateSelection."Student Name", ClerkshipSiteAndDateSelection."Application No.");

                                if ClerkshipSiteAndDateSelection."Preferred Start Date" = 0D then
                                    Error('Preferred Start Date must not be blank for the Student No. %1 (%2)\Please check the FM1/IM1 Application No. %3',
                                    ClerkshipSiteAndDateSelection."Student No.", ClerkshipSiteAndDateSelection."Student Name", ClerkshipSiteAndDateSelection."Application No.");

                                if (EducationSetup."USMLE Applicable for FM1/IM1" = true) then begin
                                    StudentSubjectExam.Reset();
                                    StudentSubjectExam.SetRange("Student No.", ClerkshipSiteAndDateSelection."Student No.");
                                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::"STEP 1");
                                    if not StudentSubjectExam.FindLast() then begin
                                        if not Confirm('USMLE Step 1 Examination not found for the Student No. %1 (%2) in Student Subjects Exam.\Do you want to Continue?', true,
                                        ClerkshipSiteAndDateSelection."Student No.", ClerkshipSiteAndDateSelection."Student Name") then
                                            Error('Action Stopped to respect the "USMLE Exam not found in Student Subject warning"');
                                    end
                                    else
                                        if StudentSubjectExam.Result <> StudentSubjectExam.Result::Pass then
                                            if not Confirm('Student No. %1 (%2) has not passed USMLE Step 1 Examination.\Do you want to continue?', true,
                                            ClerkshipSiteAndDateSelection."Student No.", ClerkshipSiteAndDateSelection."Student Name") then
                                                Error('Action Stopped to respect the "Student has not passed USMLE Examination warning"');
                                end;

                                PrefferedDateSetID := ClerkshipSiteAndDateSelection."Preset Start Date ID";
                                FM1IM1DatePresetEntry.Reset();
                                if FM1IM1DatePresetEntry.Get(PrefferedDateSetID) Then;

                                RosterSchedulingHeader.Reset();
                                //RosterSchedulingHeader.SetRange("FM1/IM1 Preset No.", FM1IM1DatePresetEntry."Preset No.");
                                RosterSchedulingHeader.SetRange("Course Code", FM1IM1DatePresetEntry."Course Code");
                                RosterSchedulingHeader.SetRange("Start Date", ClerkshipSiteAndDateSelection."Preferred Start Date");
                                RosterSchedulingHeader.SetRange("Hospital ID", ClerkshipSiteAndDateSelection."Confirmed Site ID");
                                //RosterSchedulingHeader.SetRange("Global Dimension 1 Code", ClerkshipSiteAndDateSelection."Global Dimension 1 Code");
                                if not RosterSchedulingHeader.FindFirst() then begin
                                    RosterSchedulingHeader.Init();
                                    RosterSchedulingHeader."Clerkship Type" := RosterSchedulingHeader."Clerkship Type"::"FM1/IM1";
                                    RosterSchedulingHeader."Entry Type" := RosterSchedulingHeader."Entry Type"::"FM1/IM1";
                                    RosterSchedulingHeader."Course Type" := RosterSchedulingHeader."Course Type"::"FM1/IM1";
                                    RosterSchedulingHeader."Global Dimension 1 Code" := FM1IM1DatePresetEntry."Global Dimension 1 Code";

                                    RosterSchedulingHeader."Rotation ID" := '';
                                    RosterSchedulingHeader.Insert(true);
                                    RosterSchedulingHeader."Academic Year" := FM1IM1DatePresetEntry."Academic Year";
                                    RosterSchedulingHeader.Validate("Course Code", FM1IM1DatePresetEntry."Course Code");
                                    RosterSchedulingHeader."Course Type" := RosterSchedulingHeader."Course Type"::"FM1/IM1";
                                    RosterSchedulingHeader.Validate("Start Date", ClerkshipSiteAndDateSelection."Preferred Start Date");
                                    RosterSchedulingHeader."No. of Weeks" := Rec."No. of Weeks";
                                    RosterSchedulingHeader."End Date" := Rec."End Date";
                                    RosterSchedulingHeader.Validate("No. of Weeks", ClerkshipSiteAndDateSelection."No. of Weeks");
                                    RosterSchedulingHeader.Validate("Hospital ID", ClerkshipSiteAndDateSelection."Confirmed Site ID");
                                    RosterSchedulingHeader.Validate("Maximum Waitlist Students", 0);
                                    RosterSchedulingHeader."FM1/IM1 Preset No." := FM1IM1DatePresetEntry."Preset No.";
                                    RosterSchedulingHeader.Validate("Rotation Confirmed", true);
                                    RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Scheduled;
                                    RosterSchedulingHeader.Validate("Rotation Confirmed", true);
                                    RosterSchedulingHeader."Scheduled By" := UserId;
                                    RosterSchedulingHeader."Scheduled On" := Today;
                                    RosterSchedulingHeader.Modify();
                                end;

                                StudentMaster.Reset();
                                if StudentMaster.Get(ClerkshipSiteAndDateSelection."Student No.") then;

                                // if RosterSchedulingHeader.Status = RosterSchedulingHeader.Status::Published then begin
                                //     HospitalCostMaster.Reset();
                                //     HospitalCostMaster.SetRange("Hospital ID", RosterSchedulingHeader."Hospital ID");
                                //     HospitalCostMaster.SetRange("Clerkship Type", RosterSchedulingHeader."Clerkship Type");
                                //     HospitalCostMaster.SetFilter("Effective Date", '<=%1', RosterSchedulingHeader."Start Date");
                                //     IF not HospitalCostMaster.FindLast() then
                                //         Error('Hospital Cost for the Hospital ID %1 (%2) Rotation Type %3 not found.', RosterSchedulingHeader."Hospital ID",
                                //         RosterSchedulingHeader."Hospital Name", RosterSchedulingHeader."Course Type");
                                // end;

                                RosterSchedulingLine.Init();
                                RosterSchedulingLine."Rotation ID" := RosterSchedulingHeader."Rotation ID";
                                RosterSchedulingLine."Academic Year" := RosterSchedulingHeader."Academic Year";
                                RosterSchedulingLine.Validate("Student No.", ClerkshipSiteAndDateSelection."Student No.");
                                RosterSchedulingLine."Entry Type" := RosterSchedulingHeader."Entry Type";
                                RosterSchedulingLine."Clerkship Type" := RosterSchedulingHeader."Clerkship Type";
                                RosterSchedulingLine.Validate("Course Code", RosterSchedulingHeader."Course Code");
                                RosterSchedulingLine."Rotation Description" := RosterSchedulingHeader."Rotation Description";
                                RosterSchedulingLine."Course Type" := RosterSchedulingHeader."Course Type";
                                RosterSchedulingLine."No. of Weeks" := RosterSchedulingHeader."No. of Weeks";
                                RosterSchedulingLine."Start Date" := RosterSchedulingHeader."Start Date";
                                RosterSchedulingLine."End Date" := RosterSchedulingHeader."End Date";
                                RosterSchedulingLine."Global Dimension 1 Code" := RosterSchedulingHeader."Global Dimension 1 Code";
                                RosterSchedulingLine."Global Dimension 2 Code" := RosterSchedulingHeader."Global Dimension 2 Code";
                                RosterSchedulingLine.Validate("Hospital ID", ClerkshipSiteAndDateSelection."Confirmed Site ID");
                                RosterSchedulingLine."Coordinator ID" := StudentMaster."FM1/IM1 Coordinator";
                                RosterSchedulingLine."Document Specialist ID" := StudentMaster."Document Specialist";
                                RosterSchedulingLine.Status := RosterSchedulingHeader.Status;
                                RosterSchedulingLine.Validate("Rotation Confirmed", true);
                                RosterSchedulingLine."FM1/IM1 Application No." := ClerkshipSiteAndDateSelection."Application No.";
                                RosterSchedulingLine.Insert(true);

                                if RosterSchedulingHeader.Status = RosterSchedulingHeader.Status::Scheduled then
                                    CALE.InsertLogEntry(4, 3, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', RosterSchedulingLine."Course Code", RosterSchedulingLine."Course Description");

                                StudentDocumentAttachment.Reset();
                                StudentDocumentAttachment.SetRange("Document Category", 'CLERKSHIP_DOCUMENTS');
                                StudentDocumentAttachment.SetRange("Student No.", Rec."Student No.");
                                if StudentDocumentAttachment.Find('-') then
                                    repeat
                                        StudentDocumentAttachment."Document Due" := ClerkshipSiteAndDateSelection."Document Due Date";
                                        StudentDocumentAttachment.Modify();
                                    until StudentDocumentAttachment.Next() = 0;

                                ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Scheduled;

                                if RosterSchedulingHeader.Status = RosterSchedulingHeader.Status::Published then
                                    ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Published;

                                ClerkshipSiteAndDateSelection."Rotation ID" := RosterSchedulingLine."Rotation ID";
                                ClerkshipSiteAndDateSelection.Modify();

                                if RosterSchedulingHeader.Status = RosterSchedulingHeader.Status::Published then begin
                                    RosterLedgerEntry.Reset();
                                    if RosterLedgerEntry.FindLast() then
                                        LastEntryNo := RosterLedgerEntry."Entry No.";

                                    LastEntryNo := LastEntryNo + 1;
                                    RosterSchedulingLine.PublishRotation(RosterSchedulingLine, LastEntryNo);
                                end;

                                ScheduledRecords := ScheduledRecords + 1;
                            until ClerkshipSiteAndDateSelection.Next() = 0;
                        W.Close();
                        Message('%1 Records Scheduled successfully..', ScheduledRecords);
                    end;
                end;
            }

            action("Cancel Approval")
            {
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReverseLines;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not (Rec.Status in [Rec.Status::Approved]) then
                        Error('Application Status %1.Approval Canncellation is not allowed at this stage.', Rec.Status);
                    if Confirm('Do you want some Cancel the approval of the FM1/IM1 application?') then begin
                        Rec.Validate(Confirmed, false);
                        Rec.Validate(Status, Rec.Status::" ");
                        Rec.Modify();

                        CALE.InsertLogEntry(4, 10, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', 'Application Approval Cancelled', '9920', 'Family Medicine I/Internal Medicine I');
                        Message('Application Approval Cancelled.\Check the application on Site & Date Selection Entry window.');
                    end;
                end;
            }
        }
    }
}