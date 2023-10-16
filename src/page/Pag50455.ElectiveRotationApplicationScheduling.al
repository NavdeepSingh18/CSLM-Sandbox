page 50455 "Rotation Application Schduling"
{
    PageType = List;
    Caption = 'Elective Rotation Application Scheduling';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    SourceTableView = sorting("Offer No.", "Application No.") order(descending) where(Status = filter(Confirmed), "Approval Status" = filter(Approved | "Not Applicable"), "Rotation Status" = filter(" "));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
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
            action("Assign Rotation Alternate Date")
            {
                ApplicationArea = All;
                Caption = 'Assign Rotation Alternate Date';
                ShortcutKey = 'Ctrl+I';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = InteractionLog;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.SetRange("Line No.", Rec."Line No.");
                    Page.RunModal(Page::"Rotation Appl Alternate Date", RotationOfferApplication)
                end;
            }

            action("Schedule Rotation")
            {
                ApplicationArea = All;
                Caption = 'Schedule Rotation';
                ShortcutKey = 'Ctrl+S';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = SendConfirmation;
                trigger OnAction()
                var
                    RotationOffers: Record "Rotation Offers";
                    RotationOfferApplication: Record "Rotation Offer Application";
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterSchedulingHeaderIns: Record "Roster Scheduling Header";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    StudentMaster: Record "Student Master-CS";
                    UserSetup: Record "User Setup";
                    CALE: Record "Clerkship Activity Log Entries";
                    StudentStatus: Record "Student Status";
                    ClinicalNotification: Codeunit "Clinical Notification";
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    StatusOK: Boolean;
                    LOAStart: Date;
                    LOAEnd: date;
                    StudentOnCLOA: Boolean;
                    SelectedRecords: Integer;
                    CurrentRecord: Integer;
                    W: Dialog;
                    Text001Lbl: Label 'Total Selected Records      ############1################\';
                    Text002Lbl: Label 'Processed Record      ############2################\';
                begin
                    RotationOfferApplication.Reset();
                    CurrPage.SetSelectionFilter(RotationOfferApplication);
                    SelectedRecords := RotationOfferApplication.Count();

                    if not Confirm('You have Selected %1 Records.\\\Do you want to Schedule the Elective Rotation?', true, SelectedRecords) then
                        exit;

                    UserSetup.Reset();
                    if not UserSetup.Get(UserId) then
                        Error('User Setup for User ID %1 not found.', UserId);

                    W.Open('Scheduling Rotation..\\\' + Text001Lbl + Text002Lbl);

                    RotationOfferApplication.Reset();
                    CurrPage.SetSelectionFilter(RotationOfferApplication);
                    if RotationOfferApplication.FindFirst() then
                        repeat
                            CurrentRecord += 1;
                            W.Update(1, SelectedRecords);
                            W.Update(2, CurrentRecord);

                            RotationOffers.Reset();
                            IF RotationOffers.Get(RotationOfferApplication."Offer No.") THEN;

                            StatusOK := true;
                            StudentMaster.Reset();
                            if StudentMaster.Get(RotationOfferApplication."Student No.") then;

                            StudentStatus.Reset();
                            if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                            if (StudentStatus.Status in
                            [StudentStatus.Status::Withdrawn]) then begin
                                Message('Please check the Status of Student No. %1 (%2).', StudentMaster."No.", StudentMaster."Student Name");
                                StatusOK := false;
                            end;

                            StudentOnCLOA := false;
                            IF (RotationOfferApplication."Student No." <> '') and (RotationOfferApplication."Start Date" <> 0D) then
                                if ClinicalBaseAppSubscribe.CheckCLOAExistance(RotationOfferApplication."Student No.", RotationOfferApplication."Start Date", RotationOfferApplication."End Date", LOAStart, LOAEnd) = true then begin
                                    Message('Rotation for the Student No. %1 (%2) can not be scheduled as Student is on leave for the Period %3 to %4.', Rec."Student No.", Rec."Student Name", LOAStart, LOAEnd);
                                    StudentOnCLOA := true;
                                end;

                            if (StudentOnCLOA = false) or (StatusOK = false) then begin
                                RosterSchedulingHeader.Reset();
                                //RosterSchedulingHeader.SetRange("Course Code", RotationOfferApplication."Course Code");
                                RosterSchedulingHeader.SetRange("Clerkship Type", RosterSchedulingHeader."Clerkship Type"::Elective);
                                RosterSchedulingHeader.SetRange("Elective Course Code", RotationOfferApplication."Elective Course Code");
                                RosterSchedulingHeader.SetRange("Course Prefix", RotationOfferApplication."Course Prefix");
                                RosterSchedulingHeader.SetRange("Hospital ID", RotationOfferApplication."Hospital ID");
                                RosterSchedulingHeader.SetRange("Start Date", RotationOfferApplication."Start Date");
                                //RosterSchedulingHeader.SetRange("Academic Year", RotationOffers."Academic Year");
                                if not RosterSchedulingHeader.FindLast() then begin
                                    RosterSchedulingHeaderIns.Init();
                                    RosterSchedulingHeaderIns."Rotation ID" := '';
                                    RosterSchedulingHeaderIns."Clerkship Type" := RosterSchedulingHeaderIns."Clerkship Type"::Elective;
                                    RosterSchedulingHeaderIns."Course Type" := RosterSchedulingHeaderIns."Course Type"::Elective;
                                    RosterSchedulingHeaderIns."Entry Type" := RosterSchedulingHeaderIns."Entry Type"::Clerkship;
                                    RosterSchedulingHeaderIns."Global Dimension 1 Code" := '9000';
                                    RosterSchedulingHeaderIns.Insert(true);
                                    //RosterSchedulingHeaderIns."Course Code" := RotationOfferApplication."Course Code";
                                    RosterSchedulingHeaderIns."Course Code" := RotationOfferApplication."Elective Course Code";
                                    RosterSchedulingHeaderIns."Course Description" := RotationOfferApplication."Course Description";
                                    RosterSchedulingHeaderIns."Elective Course Code" := RotationOfferApplication."Elective Course Code";
                                    RosterSchedulingHeaderIns."Rotation Description" := RotationOfferApplication."Rotation Description";
                                    RosterSchedulingHeaderIns."Course Prefix" := RotationOfferApplication."Course Prefix";
                                    RosterSchedulingHeaderIns."Academic Year" := RotationOffers."Academic Year";
                                    RosterSchedulingHeaderIns.Validate("Hospital ID", RotationOfferApplication."Hospital ID");
                                    RosterSchedulingHeaderIns.Validate("Maximum Waitlist Students", 0);
                                    RosterSchedulingHeaderIns.Semester := RotationOfferApplication.Semester;
                                    RosterSchedulingHeaderIns."Start Date" := RotationOfferApplication."Start Date";
                                    RosterSchedulingHeaderIns."No. of Weeks" := RotationOfferApplication."No. of Weeks";
                                    RosterSchedulingHeaderIns."End Date" := RotationOfferApplication."End Date";
                                    RosterSchedulingHeaderIns.Status := RosterSchedulingHeaderIns.Status::Scheduled;
                                    RosterSchedulingHeaderIns.Validate("Rotation Confirmed", true);
                                    RosterSchedulingHeaderIns."Scheduled By" := UserId;
                                    RosterSchedulingHeaderIns."Scheduled On" := Today;
                                    RosterSchedulingHeaderIns.Modify(true);

                                    RosterSchedulingHeader.Reset();
                                    if RosterSchedulingHeader.Get(RosterSchedulingHeaderIns."Rotation ID") then;
                                end;

                                RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Scheduled;
                                RosterSchedulingHeader."Scheduled By" := UserId;
                                RosterSchedulingHeader."Scheduled On" := Today;

                                RosterSchedulingHeader.Modify();

                                StudentMaster.Reset();
                                if StudentMaster.Get(RotationOfferApplication."Student No.") then;

                                RosterSchedulingLine.Init();
                                RosterSchedulingLine."Rotation ID" := RosterSchedulingHeader."Rotation ID";
                                RosterSchedulingLine.Validate("Student No.", RotationOfferApplication."Student No.");
                                RosterSchedulingLine.Validate("Academic Year", RotationOffers."Academic Year");
                                RosterSchedulingLine.Insert(true);

                                RosterSchedulingLine."Course Code" := RotationOfferApplication."Elective Course Code";
                                RosterSchedulingLine."Course Description" := RotationOfferApplication."Course Description";
                                RosterSchedulingLine."Elective Course Code" := RotationOfferApplication."Elective Course Code";
                                RosterSchedulingLine."Rotation Description" := RotationOfferApplication."Rotation Description";
                                RosterSchedulingLine."Course Type" := RosterSchedulingLine."Course Type"::Elective;
                                RosterSchedulingLine."Global Dimension 1 Code" := RotationOfferApplication."Global Dimension 1 Code";
                                RosterSchedulingLine."Global Dimension 2 Code" := RotationOfferApplication."Global Dimension 2 Code";
                                RosterSchedulingLine."Start Date" := RotationOfferApplication."Start Date";
                                RosterSchedulingLine."End Date" := RotationOfferApplication."End Date";
                                RosterSchedulingLine."No. of Weeks" := RotationOfferApplication."No. of Weeks";
                                RosterSchedulingLine.Validate("Hospital ID", RotationOfferApplication."Hospital ID");
                                RosterSchedulingLine."Coordinator ID" := StudentMaster."Clinical Coordinator";
                                RosterSchedulingLine."Document Specialist ID" := StudentMaster."Document Specialist";
                                RosterSchedulingLine."Student Status" := RosterSchedulingLine."Student Status"::" ";
                                RosterSchedulingLine.Status := RosterSchedulingHeader.Status;
                                RosterSchedulingLine.Validate("Rotation Confirmed", true);
                                RosterSchedulingLine."Offer No." := RotationOfferApplication."Offer No.";
                                RosterSchedulingLine."Offer Application Line No." := RotationOfferApplication."Line No.";
                                RosterSchedulingLine."Elective Application No." := RotationOfferApplication."Application No.";

                                CALE.InsertLogEntry(8, 3, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', RosterSchedulingLine."Elective Course Code", RosterSchedulingLine."Rotation Description");

                                RosterSchedulingLine.Modify(true);
                                // ClinicalNotification.NewRotationOnSchedule(RosterSchedulingLine);

                                RotationOfferApplication."Rotation Status" := RotationOfferApplication."Rotation Status"::Scheduled;
                                RotationOfferApplication."Rotation ID" := RosterSchedulingHeader."Rotation ID";
                                RotationOfferApplication.Modify();
                            end;
                        until RotationOfferApplication.Next() = 0;

                    W.Close();
                    Message('%1 Application of Elective Rotation Scheduled Successfully..', SelectedRecords);
                end;
            }

            action("Reject Elective Application")
            {
                ApplicationArea = All;
                Caption = 'Reject Elective Application';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.SetRange("Student No.", Rec."Student No.");
                    RotationOfferApplication.SetRange("Application No.", Rec."Application No.");
                    RotationOfferApplication.FilterGroup(0);
                    page.RunModal(Page::"Rotation Application Rejection", RotationOfferApplication);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
    end;
}