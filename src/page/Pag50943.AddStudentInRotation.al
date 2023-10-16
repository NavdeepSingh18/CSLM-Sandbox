page 50943 "Add Student in Rotation"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Roster Scheduling Header";
    Caption = 'Add Student in Rotation';
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Rotation Details")
                {
                    Editable = false;
                    field("Rotation ID"; Rec."Rotation ID")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Rotation Description"; Rec."Rotation Description")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Hospital ID"; Rec."Hospital ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
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
                    field("No. of Students"; Rec."No. of Students")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Unfavorable;
                    }
                }
                group(Input)
                {
                    field(StudentNo; StudentNo)
                    {
                        ApplicationArea = All;
                        Style = Favorable;
                        Caption = 'Student No.';
                        Editable = false;
                        trigger OnAssistEdit()
                        var
                            UserSetup: Record "User Setup";
                            EducationSetup: Record "Education Setup-CS";
                            StudentMaster: Record "Student Master-CS";
                            RotationOfferApplication: Record "Rotation Offer Application";
                            ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                            StudentStatus: Record "Student Status";
                        begin
                            UserSetup.Reset();
                            IF not UserSetup.Get(UserId) then
                                Error('User Setup not found for the User ID %1.', UserId);

                            EducationSetup.Reset();
                            EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                            if EducationSetup.FindFirst() then
                                EducationSetup.TestField("Clerkship Semester Filter");

                            if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then begin
                                StudentMaster.Reset();
                                StudentMaster.FilterGroup(2);
                                StudentMaster.SetFilter("Global Dimension 1 Code", '9000');
                                StudentMaster.SetFilter(Semester, Rec.GetFilter("Clerkship Semester Filter"));
                                StudentMaster.FilterGroup(0);
                                IF Page.RUNMODAL(0, StudentMaster) = ACTION::LookupOK THEN begin
                                    StudentNo := StudentMaster."No.";
                                    StudentName := StudentMaster."Student Name";

                                    if StudentNo <> '' then begin
                                        StudentStatus.Reset();
                                        if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                                        if (StudentStatus.Status in
                                        [StudentStatus.Status::Withdrawn]) then
                                            Error('Please check the Status of Student No. %1 (%2).', StudentNo, StudentName);
                                    end;
                                end;
                            end;

                            if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then begin
                                RotationOfferApplication.Reset();
                                RotationOfferApplication.FilterGroup(2);
                                RotationOfferApplication.SetRange("Hospital ID", Rec."Hospital ID");
                                RotationOfferApplication.SetFilter(Status, '%1', RotationOfferApplication.Status::Confirmed);
                                RotationOfferApplication.SetFilter("Rotation Status", '%1', RotationOfferApplication."Rotation Status"::" ");
                                RotationOfferApplication.SetFilter("Approval Status", '%1|%2', RotationOfferApplication."Approval Status"::Approved, RotationOfferApplication."Approval Status"::"Not Applicable");
                                RotationOfferApplication.FilterGroup(0);
                                IF Page.RUNMODAL(Page::"Rotation Offer Applications", RotationOfferApplication) = ACTION::LookupOK THEN begin
                                    StudentNo := RotationOfferApplication."Student No.";
                                    StudentName := RotationOfferApplication."Student Name";
                                    ReferenceNo := RotationOfferApplication."Application No.";
                                end;
                            end;

                            if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then begin
                                ClerkshipSiteAndDateSelection.Reset();
                                ClerkshipSiteAndDateSelection.FilterGroup(2);
                                ClerkshipSiteAndDateSelection.SetRange("Confirmed Site ID", Rec."Hospital ID");
                                ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                                ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::Approved);
                                ClerkshipSiteAndDateSelection.FilterGroup(0);
                                IF Page.RUNMODAL(Page::"Clerkship Site And Date LST", ClerkshipSiteAndDateSelection) = ACTION::LookupOK THEN begin
                                    StudentNo := ClerkshipSiteAndDateSelection."Student No.";
                                    StudentName := ClerkshipSiteAndDateSelection."Student Name";
                                    ReferenceNo := ClerkshipSiteAndDateSelection."Application No.";
                                end;
                            end;
                        end;
                    }
                    field(StudentName; StudentName)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Favorable;
                        Caption = 'Student Name';
                    }
                    field(ReferenceNo; ReferenceNo)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Favorable;
                        Caption = 'Reference No.';
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Student in Rotation")
            {
                ApplicationArea = All;
                Caption = 'Add Student in Rotation';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    LOAStart: Date;
                    LOAEnd: Date;
                begin
                    if ClinicalBaseAppSubscribe.CheckCLOAExistance(StudentNo, Rec."Start Date", Rec."End Date", LOAStart, LOAEnd) then
                        Error('Rotation for the Student No. %1 (%2) can not be scheduled as Student is on leave for the Period %3 to %4.', StudentNo, StudentName, LOAStart, LOAEnd);

                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                        AddInCoreRotation();
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
                        AddInElectiveRotation();
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
                        AddInFM1IM1Rotation();
                    Message('Student added in Rotation Successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        StudentNo: Code[20];
        StudentName: Text[200];
        ReferenceNo: Code[20];

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
    begin
        UserSetup.Reset();
        IF not UserSetup.Get(UserId) then
            Error('User Setup not found for the User ID %1.', UserId);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Clerkship Semester Filter");

        if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
            Rec.SetFilter("Clerkship Semester Filter", EducationSetup."FM1/IM1 Semester Filter")
        else
            Rec.SetFilter("Clerkship Semester Filter", EducationSetup."Clerkship Semester Filter");
    end;

    procedure AddInCoreRotation()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        StudentMaster: Record "Student Master-CS";
        RSL: Record "Roster Ledger Entry";
        SM: Record "Subject Master-CS";
        StudentGroup: Record "Student Group";
        EntryNo: Integer;
        RemediateGroupCodes: Code[2048];
    begin
        if StudentNo = '' then
            Error('You must specify Student No.');

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        RosterSchedulingLine.SetRange("Student No.", StudentNo);
        RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Cancelled);
        if RosterSchedulingLine.FindFirst() then
            Error('Student - %1 (%2 ) already exists in Rotation No. - %3.', StudentNo, StudentName, Rec."Rotation ID");

        RemediateGroupCodes := 'REMER|REMFM|REMFM1|REMIM|REMOBGYN|REMPED|REMPSY|REMSUR';
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudentNo);
        StudentGroup.SetFilter("Groups Code", RemediateGroupCodes);
        StudentGroup.SetRange(Blocked, false);
        if StudentGroup.FindFirst() then
            Error('Student No. %1 (%2) is under %3 Remediate Group, Rotation can not be published for this Student.', RosterSchedulingLine."Student No.", RosterSchedulingLine."Student Name", StudentGroup."Groups Code");

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        SM.Reset();
        SM.SetRange(Code, Rec."Course Code");
        if SM.FindFirst() then;

        RosterSchedulingLine.Init();
        RosterSchedulingLine."Rotation ID" := Rec."Rotation ID";
        RosterSchedulingLine."Clerkship Type" := Rec."Clerkship Type";
        RosterSchedulingLine."Academic Year" := StudentMaster."Academic Year";
        RosterSchedulingLine.Semester := StudentMaster.Semester;
        RosterSchedulingLine.Validate("Student No.", StudentMaster."No.");
        RosterSchedulingLine."Course Code" := Rec."Course Code";
        RosterSchedulingLine."Course Description" := Rec."Course Description";
        RosterSchedulingLine."Course Type" := Rec."Course Type";
        RosterSchedulingLine."Course Prefix Code" := SM."Subject Prefix";
        RosterSchedulingLine."Course Prefix Description" := SM."Subject Prefix";
        RosterSchedulingLine."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
        RosterSchedulingLine."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
        RosterSchedulingLine."Start Date" := Rec."Start Date";
        RosterSchedulingLine."End Date" := Rec."End Date";
        RosterSchedulingLine."No. of Weeks" := Rec."No. of Weeks";
        RosterSchedulingLine.Validate("Hospital ID", Rec."Hospital ID");
        RosterSchedulingLine."Coordinator ID" := StudentMaster."Clinical Coordinator";
        RosterSchedulingLine."Document Specialist ID" := StudentMaster."Document Specialist";
        RosterSchedulingLine."Student Status" := RosterSchedulingLine."Student Status"::" ";
        RosterSchedulingLine.Status := RosterSchedulingLine.Status::Scheduled;
        if RosterSchedulingLine.Insert(true) then;

        if Rec.Status = Rec.Status::Published then begin
            RosterSchedulingLine.Status := RosterSchedulingLine.Status::Published;
            RosterSchedulingLine.Modify();

            RSL.Reset();
            if RSL.FindLast() then
                EntryNo := RSL."Entry No.";
            EntryNo += 1;
            RosterSchedulingLine.PublishRotation(RosterSchedulingLine, EntryNo);
        end;
    end;

    procedure AddInElectiveRotation()
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        RotationOfferApplication: Record "Rotation Offer Application";
        RotationOffers: Record "Rotation Offers";
        StudentMaster: Record "Student Master-CS";
        RSL: Record "Roster Ledger Entry";
        EntryNo: Integer;
    begin
        if StudentNo = '' then
            Error('You must specify Student No.');

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        RosterSchedulingLine.SetRange("Student No.", StudentNo);
        if RosterSchedulingLine.FindFirst() then
            Error('Student - %1 (%2 ) already exists in Rotation No. - %3.', StudentNo, StudentName, Rec."Rotation ID");

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Application No.", ReferenceNo);
        RotationOfferApplication.SetRange("Student No.", StudentNo);
        if not RotationOfferApplication.FindFirst() then
            Error('Rotation Offer Application - %1 not found.', ReferenceNo);

        RotationOffers.Reset();
        RotationOffers.SetRange("Offer No.", RotationOfferApplication."Offer No.");
        if not RotationOffers.FindFirst() then
            Error('Rotation Offer - %1 not found.', RotationOfferApplication."Offer No.");

        RosterSchedulingLine.Init();
        RosterSchedulingLine."Rotation ID" := Rec."Rotation ID";
        RosterSchedulingLine.Validate("Student No.", RotationOfferApplication."Student No.");
        RosterSchedulingLine.Validate("Academic Year", RotationOffers."Academic Year");
        RosterSchedulingLine.Insert(true);

        RosterSchedulingLine."Course Code" := RotationOfferApplication."Course Code";
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

        RosterSchedulingLine.Status := Rec.Status;
        RosterSchedulingLine.Validate("Rotation Confirmed", true);
        RosterSchedulingLine."Offer No." := RotationOfferApplication."Offer No.";
        RosterSchedulingLine."Offer Application Line No." := RotationOfferApplication."Line No.";
        RosterSchedulingLine.Modify(true);

        if Rec.Status = Rec.Status::Scheduled then
            RotationOfferApplication."Rotation Status" := RotationOfferApplication."Rotation Status"::Scheduled;
        if Rec.Status = Rec.Status::Published then begin
            RotationOfferApplication."Rotation Status" := RotationOfferApplication."Rotation Status"::Published;
            RSL.Reset();
            if RSL.FindLast() then
                EntryNo := RSL."Entry No.";
            EntryNo += 1;
            RosterSchedulingLine.PublishRotation(RosterSchedulingLine, EntryNo);
        end;

        RotationOfferApplication."Rotation ID" := Rec."Rotation ID";
        RotationOfferApplication.Modify();
    end;

    procedure AddInFM1IM1Rotation()
    var
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        RosterSchedulingLine: Record "Roster Scheduling Line";
        StudentMaster: Record "Student Master-CS";
        RSL: Record "Roster Ledger Entry";
        EntryNo: Integer;
    begin
        if StudentNo = '' then
            Error('You must specify Student No.');

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetRange("Rotation ID", Rec."Rotation ID");
        RosterSchedulingLine.SetRange("Student No.", StudentNo);
        RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Cancelled);
        if RosterSchedulingLine.FindFirst() then
            Error('Student - %1 (%2 ) already exists in Rotation No. - %3.', StudentNo, StudentName, Rec."Rotation ID");

        StudentMaster.Reset();
        if StudentMaster.Get(StudentNo) then;

        ClerkshipSiteAndDateSelection.Reset();
        if not ClerkshipSiteAndDateSelection.Get(ReferenceNo) then
            Error('Clerkship Site and Date Selection Application No. - %1 not found.', ReferenceNo);

        RosterSchedulingLine.Init();
        RosterSchedulingLine."Rotation ID" := Rec."Rotation ID";
        RosterSchedulingLine."Academic Year" := Rec."Academic Year";
        RosterSchedulingLine.Validate("Student No.", ClerkshipSiteAndDateSelection."Student No.");
        RosterSchedulingLine."Entry Type" := Rec."Entry Type";
        RosterSchedulingLine."Clerkship Type" := Rec."Clerkship Type";
        RosterSchedulingLine.Validate("Course Code", Rec."Course Code");
        RosterSchedulingLine."Rotation Description" := Rec."Rotation Description";
        RosterSchedulingLine."Course Type" := Rec."Course Type";
        RosterSchedulingLine."No. of Weeks" := Rec."No. of Weeks";
        RosterSchedulingLine."Start Date" := Rec."Start Date";
        RosterSchedulingLine."End Date" := Rec."End Date";
        RosterSchedulingLine."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
        RosterSchedulingLine."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
        RosterSchedulingLine.Validate("Hospital ID", ClerkshipSiteAndDateSelection."Confirmed Site ID");
        RosterSchedulingLine."Coordinator ID" := StudentMaster."FM1/IM1 Coordinator";
        RosterSchedulingLine."Document Specialist ID" := StudentMaster."Document Specialist";
        RosterSchedulingLine.Status := Rec.Status;
        RosterSchedulingLine."FM1/IM1 Application No." := ClerkshipSiteAndDateSelection."Application No.";
        RosterSchedulingLine.Insert(true);

        ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Scheduled;

        if Rec.Status = Rec.Status::Published then begin
            ClerkshipSiteAndDateSelection.Status := ClerkshipSiteAndDateSelection.Status::Published;
            RSL.Reset();
            if RSL.FindLast() then
                EntryNo := RSL."Entry No.";
            EntryNo += 1;
            RosterSchedulingLine.PublishRotation(RosterSchedulingLine, EntryNo);
        end;
        ClerkshipSiteAndDateSelection."Rotation ID" := Rec."Rotation ID";
        ClerkshipSiteAndDateSelection.Modify();
    end;
}