page 50440 "Roster Scheduling Card"
{
    Caption = 'Roster Scheduling';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = HeaderEditAllowed;
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CheckRotationExistance();
                    end;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CheckRotationExistance();
                    end;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Style = Strong;
                    ShowMandatory = true;
                    BlankNumbers = BlankZero;
                }
                field("Maximum Waitlist Students"; Rec."Maximum Waitlist Students")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Total No. of Seats"; Rec."Total No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'Total No. of Seats';
                    DecimalPlaces = 0;
                }
                field("Umbrella Rotation"; Rec."Umbrella Rotation")
                {
                    ApplicationArea = All;
                    Caption = 'Umbrella Rotation';
                }
                field("Elective Mandatory"; Rec."Elective Mandatory")
                {
                    ApplicationArea = All;
                    Caption = 'Elective Mandatory';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;
                    trigger OnValidate()
                    begin
                        CheckRotationExistance();
                    end;
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
                field("No. of Students Schedule"; Rec."No. of Students Schedule")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students UNC"; Rec."No. of Students UNC")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    Caption = 'Total No. of Students';
                }
            }
            part(Lines; "Roster Scheduling Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Rotation ID" = field("Rotation ID");
            }
            group("Miscellaneous Details")
            {
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled On"; Rec."Scheduled On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled By"; Rec."Scheduled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason Code"; Rec."Cancel Reason Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
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
            action("Get Students")
            {
                ApplicationArea = All;
                Caption = 'Get Students';
                ShortcutKey = 'Ctrl+F6';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Customer;
                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    Rec.TestField("Course Code");
                    Rec.TestField("Hospital ID");
                    Rec.TestField("Start Date");
                    Rec.TestField("No. of Seats");

                    Vendor.Reset();
                    if Vendor.Get(Rec."Hospital ID") then;

                    if Vendor."Preffered for GHT Students" then begin
                        Rec.GetStudentsGHT();
                        Rec.GetStudentsInternational();
                    end;

                    if Vendor."Preffered for International" then begin
                        Rec.GetStudentsInternational();
                        Rec.GetStudentsGHT();
                    end;

                    Rec.GetStudents();

                    Rec.CalcFields("No. of Students");
                    if Rec."No. of Students" > 0 then
                        HeaderEditAllowed := false;
                end;
            }
            action("Confirm Rotation")
            {
                ApplicationArea = All;
                Caption = 'Confirm Rotation';
                ShortcutKey = 'Ctrl+F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Status;
                trigger OnAction()
                var
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    StudentMaster: Record "Student Master-CS";
                    UserSetup: Record "User Setup";
                    User: Record User;
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    Rec.TestField("No. of Seats");
                    Rec.CalcFields("No. of Students");
                    IF Rec."No. of Students" = 0 then
                        if not Confirm('There is no student in line to schedule the rotation. Do you want to continue') then
                            exit;

                    if Confirm('Do you want to confirm the %1 rotation %2', True, Rec."Clerkship Type", Rec."Rotation ID") then begin
                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Unconfirmed);
                        if RosterSchedulingLine.Findfirst() then begin
                            if not Confirm('%1 Unconfirmed student(s) are exist in the Roster Line.\\If You Confirm the Rotation System will delete these line(s).\\Do you want to Confirm the Rotation?', true, RosterSchedulingLine.Count) then
                                exit;
                            repeat
                                RosterSchedulingLine.Delete(true);
                            until RosterSchedulingLine.Next() = 0;
                        end;

                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                        RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                        RosterSchedulingLine.SetRange("Rotation Confirmed", false);
                        if RosterSchedulingLine.FindSet() then
                            repeat
                                RosterSchedulingLine.TestField("Coordinator ID");
                                StudentMaster.Reset();
                                if StudentMaster.Get(RosterSchedulingLine."Student No.") then;
                                StudentMaster.TestField("E-Mail Address");
                                StudentMaster.TestField("Clinical Coordinator");

                                User.Reset();
                                User.SetRange("User Name", StudentMaster."Clinical Coordinator");
                                if User.FindLast() then
                                    if User."Full Name" = '' then
                                        Error('Full Name does not updated on User for the Clinical Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");

                                UserSetup.Reset();
                                if UserSetup.Get(RosterSchedulingLine."Coordinator ID") then begin
                                    if UserSetup."E-Mail" = '' then
                                        Error('E-Mail does not updated on User Setup for the Clinical Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");
                                end
                                else
                                    Error('User Setup not found for the Clinical Coordinator ID %1.', RosterSchedulingLine."Coordinator ID");
                            until RosterSchedulingLine.Next() = 0;


                        RosterSchedulingLine.Reset();
                        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                        RosterSchedulingLine.SetRange("Rotation Confirmed", false);
                        if RosterSchedulingLine.Find('-') then
                            repeat
                                StudentMaster.Reset();
                                if StudentMaster.Get(RosterSchedulingLine."Student No.") then begin
                                    StudentMaster.CalcFields("Clinical Hold Exist");
                                    if StudentMaster."Clinical Hold Exist" then begin
                                        // ClinicalNotification.HOLDRotationNotificationCore(RosterSchedulingLine);//As per ajay disable from manual process

                                        // if Rec."Elective Mandatory" = true then
                                        // ClinicalNotification.HOLDRotationNotificationCoreSurgery(RosterSchedulingLine);
                                    end;
                                end;

                                RosterSchedulingLine.Validate("Rotation Confirmed", true);
                                RosterSchedulingLine."Scheduled By" := UserId;
                                RosterSchedulingLine."Scheduled On" := Today;
                                RosterSchedulingLine.Modify();
                                // ClinicalNotification.NewRotationOnSchedule(RosterSchedulingLine);
                                CALE.InsertLogEntry(5, 3, RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", RosterSchedulingLine."Rotation ID", '', '', RosterSchedulingLine."Course Code", RosterSchedulingLine."Rotation Description");
                            until RosterSchedulingLine.Next() = 0;

                        Rec.Validate("Rotation Confirmed", true);
                        Rec."Scheduled By" := UserId;
                        Rec."Scheduled On" := Today;
                        Rec.Modify();

                        Message('Roster ID %1 is confirmed.', Rec."Rotation ID");
                    end;
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
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    StudentMaster: Record "Student Master-CS";
                    UserSetup: Record "User Setup";
                    User: Record User;
                    UserIDFilter: Text[50];
                    Text001Lbl: Label 'Total Rotations      ############1################\';
                    Text002Lbl: Label 'Rotation in Progress      ############2################\';
                    Text003Lbl: Label 'Action      ############3################\';
                    LastEntryNo: Integer;
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                begin
                    UserIDFilter := '';
                    UserSetup.Reset();
                    if not UserSetup.Get(UserId) then
                        Error('User Setup not found for the USERID %1.', UserId);

                    Rec.TestField("No. of Seats");

                    W.Open('Checking Rotation Details..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    T := 0;
                    C := 0;


                    C += 1;
                    W.Update(1, T);
                    W.Update(2, C);
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                    if RosterSchedulingLine.FindSet() then
                        repeat
                            StudentMaster.Reset();
                            if StudentMaster.Get(RosterSchedulingLine."Student No.") then;

                            User.Reset();
                            User.SetRange("User Name", StudentMaster."Clinical Coordinator");
                            if User.FindLast() then
                                if User."Full Name" = '' then
                                    Error('Full Name does not updated on User for the Cordinator ID %1.', StudentMaster."Clinical Coordinator");

                            UserSetup.Reset();
                            if UserSetup.Get(StudentMaster."Clinical Coordinator") then
                                if UserSetup."E-Mail" = '' then
                                    Error('E-Mail does not updated on User Setup for the Cordinator ID %1.', StudentMaster."Clinical Coordinator");
                        until RosterSchedulingLine.Next() = 0;
                    W.Close();

                    T := 1;

                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Unconfirmed);
                    if RosterSchedulingLine.Findfirst() then begin
                        if not Confirm('%1 Unconfirmed student(s) are exist in the Roster Line.\\If You Confirm the Rotation System will delete these line(s).\\Do you want to Confirm the Rotation?', true, RosterSchedulingLine.Count) then
                            exit;
                        repeat
                            RosterSchedulingLine.Delete(true);
                        until RosterSchedulingLine.Next() = 0;
                    end;

                    if not Confirm('Do you want to Publish %1 Selected Rotation?', true, Rec."Rotation ID") then
                        exit;

                    W.Open('Publishing Rotation..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.FindLast() then
                        LastEntryNo := RosterLedgerEntry."Entry No.";


                    T := 1;
                    C := 0;
                    C += 1;
                    W.Update(1, T);
                    W.Update(2, C);
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                    if RosterSchedulingLine.FindSet() then
                        repeat
                            LastEntryNo := LastEntryNo + 1;
                            RosterSchedulingLine.PublishRotation(RosterSchedulingLine, LastEntryNo);
                        until RosterSchedulingLine.Next() = 0;

                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                    if not RosterSchedulingLine.FindFirst() then begin
                        Rec.Validate(Status, Rec.Status::Published);
                        Rec."Published By" := UserId;
                        Rec."Published On" := Today;

                        if Rec."Rotation Confirmed" = false then
                            Rec.Validate("Rotation Confirmed", true);
                        if Rec."Scheduled By" = '' then
                            Rec."Scheduled By" := UserId;
                        if Rec."Scheduled On" = 0D then
                            Rec."Scheduled On" := Today;

                        Rec.Modify();
                    end
                    else begin
                        if Rec."Rotation Confirmed" = false then
                            Rec.Validate("Rotation Confirmed", true);
                        if Rec."Scheduled By" = '' then
                            Rec."Scheduled By" := UserId;
                        if Rec."Scheduled On" = 0D then
                            Rec."Scheduled On" := Today;
                        Rec.Modify();
                    end;

                    W.Close();
                    Message('Rotation ID %1 Published Sucessfully..', Rec."Rotation ID");
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
        EducationSetupCS: Record "Education Setup-CS";
    begin
        HeaderEditAllowed := true;
        UserSetup.Reset();
        if not UserSetup.Get(UserId) then
            Error('User Setup for User ID %1 not found.', UserId);

        Rec."Global Dimension 1 Code" := '9000';
        Rec."Clerkship Type" := Rec."Clerkship Type"::Core;
        Rec."Entry Type" := Rec."Entry Type"::Clerkship;
        Rec."Course Type" := Rec."Course Type"::Core;
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if EducationSetupCS.FindFirst() then
            Rec."Academic Year" := EducationSetupCS."Academic Year";
    end;

    trigger OnAfterGetRecord()
    begin
        HeaderEditAllowed := true;
        Rec.CalcFields("No. of Students");
        if Rec."No. of Students" > 0 then
            HeaderEditAllowed := false;
    end;

    var
        HeaderEditAllowed: Boolean;

    procedure CheckRotationExistance()
    var
        RSH: Record "Roster Scheduling Header";
    begin
        if (Rec."Course Code" <> '') and (Rec."Hospital ID" <> '') and (Rec."Start Date" <> 0D) then begin
            RSH.Reset();
            RSH.SetFilter("Rotation ID", '<>%1', Rec."Rotation ID");
            RSH.SetRange("Course Code", Rec."Course Code");
            RSH.SetRange("Hospital ID", Rec."Hospital ID");
            RSH.SetRange("Start Date", Rec."Start Date");
            if RSH.FindLast() then
                Message('Warning!\Rotation ID for the selected Course Code: %1, Hospital ID: %2, Start Date: %3 already Exist i.e. %4.\You can add student in that Rotation ID.', Rec."Course Code", Rec."Hospital ID", Rec."Start Date", RSH."Rotation ID");
        end;
    end;
}