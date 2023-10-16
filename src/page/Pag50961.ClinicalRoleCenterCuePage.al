page 50961 ClinicalRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueClinical;
    Caption = 'Role Center - Clinical';

    layout
    {
        area(Content)
        {
            cuegroup("Cue")
            {
                field("My Students DS"; Rec."My Students DS")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnDrillDown()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentsWithClinicalUsers: Page "Students With Clinical Users";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.FilterGroup(2);
                        if UserSetup."Clinical Administrator" = false then
                            StudentMaster.SetRange("Document Specialist", UserId);
                        StudentMaster.SetFilter(Semester, ClinicalSemester);
                        StudentMaster.SetFilter("Global Dimension 1 Code", '9000');
                        StudentMaster.FilterGroup(0);
                        StudentsWithClinicalUsers.SetVariable(true, false, false);
                        StudentsWithClinicalUsers.SetTableView(StudentMaster);
                        StudentsWithClinicalUsers.RunModal();
                    end;
                }
                field("My Students FMIM"; Rec."My Students FMIM")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentsWithClinicalUsers: Page "Students With Clinical Users";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.FilterGroup(2);
                        if UserSetup."Clinical Administrator" = false then
                            StudentMaster.SetRange("FM1/IM1 Coordinator", UserId);
                        StudentMaster.SetFilter("Global Dimension 1 Code", '9000');
                        StudentMaster.SetFilter(Semester, ClinicalSemester);
                        StudentMaster.FilterGroup(0);
                        StudentsWithClinicalUsers.SetVariable(false, true, false);
                        StudentsWithClinicalUsers.SetTableView(StudentMaster);
                        StudentsWithClinicalUsers.RunModal();
                    end;
                }
                field("My Students CC"; Rec."My Students CC")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentsWithClinicalUsers: Page "Students With Clinical Users";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.FilterGroup(2);
                        if UserSetup."Clinical Administrator" = false then
                            StudentMaster.SetRange("Clinical Coordinator", UserId);
                        StudentMaster.SetFilter("Global Dimension 1 Code", '9000');
                        StudentMaster.SetFilter(Semester, ClinicalSemester);
                        StudentMaster.FilterGroup(0);
                        StudentsWithClinicalUsers.SetVariable(false, false, true);
                        StudentsWithClinicalUsers.SetTableView(StudentMaster);
                        StudentsWithClinicalUsers.RunModal();
                    end;
                }

                field("Students Approching to GAP"; Rec."Students Approching to GAP")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Rotation GAP Analysis";//50925;
                    Visible = false;
                }
                field("Students on CLOA"; Rec."Students on CLOA")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentDetails: Page "Student Details-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.FilterGroup(2);
                        StudentMaster.SetFilter(Semester, ClinicalSemester);
                        StudentMaster.SetRange(Status, 'CLOA');
                        StudentMaster.FilterGroup(0);
                        StudentDetails.SetTableView(StudentMaster);
                        StudentDetails.RunModal();
                    end;
                }
                field("FIU Students"; Rec."FIU Students")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentDetails: Page "Student Details-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.FilterGroup(2);
                        StudentMaster.SetFilter(Semester, ClinicalSemester);
                        StudentMaster.SetRange("Course Code", '%1', 'AUA-GHT');
                        StudentMaster.FilterGroup(0);
                        StudentDetails.SetTableView(StudentMaster);
                        StudentDetails.RunModal();
                    end;
                }
                field("Student with Clinical Hold"; Rec."Student with Clinical Hold")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentDetails: Page "Student Details-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.FilterGroup(2);
                        StudentMaster.SetFilter(Semester, ClinicalSemester);
                        StudentMaster.SetRange("Clinical Hold Exist", true);
                        StudentMaster.FilterGroup(0);
                        StudentDetails.SetTableView(StudentMaster);
                        StudentDetails.RunModal();
                    end;
                }
                field("FM1/IM1 Rotations to Schedule"; Rec."FM1/IM1 Rotations to Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        RSH: Record "Roster Scheduling Header";
                        RotationPage: Page "FM1_IM1 Roster Publish LST";
                    begin
                        RSH.Reset();
                        RSH.FilterGroup(2);
                        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::"FM1/IM1");
                        RSH.SetRange(Status, RSH.Status::Scheduled);
                        RSH.FilterGroup(0);
                        RotationPage.SetTableView(RSH);
                        RotationPage.RunModal();
                    end;
                }
                field("Core Rotations to Schedule"; Rec."Core Rotations to Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        RSH: Record "Roster Scheduling Header";
                        RotationPage: Page "Core Roster Publish List";
                    begin
                        RSH.Reset();
                        RSH.FilterGroup(2);
                        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Core);
                        RSH.SetRange(Status, RSH.Status::Scheduled);
                        RSH.SetRange("Rotation Confirmed", true);
                        RSH.FilterGroup(0);
                        RotationPage.SetTableView(RSH);
                        RotationPage.RunModal();
                    end;
                }
                field("Elective Rotations to Schedule"; Rec."Elective Rotations to Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        RSH: Record "Roster Scheduling Header";
                        RotationPage: Page "Elective Rotation Publish";
                    begin
                        RSH.Reset();
                        RSH.FilterGroup(2);
                        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Elective);
                        RSH.SetRange(Status, RSH.Status::Scheduled);
                        RSH.FilterGroup(0);
                        RotationPage.SetTableView(RSH);
                        RotationPage.RunModal();
                    end;
                }
            }


            cuegroup("Approvals")
            {
                Caption = 'Approvals';

                // field("Document Pending for Approval";Rec."Document Pending for Approval")
                // {
                //     Caption = 'Pending Document for Approval';

                //     trigger OnDrillDown()
                //     var
                //         StudentMaster: Record "Student Master-CS";
                //         StudentStatus: Record "Student Status";
                //         ClinicalDocumentUpdation: Page "Clinical Document Updation";
                //         SDA: Record "Student Document Attachment";
                //         StudentValidity: Boolean;
                //         WindowDialog: Dialog;
                //         Text001Lbl: Label 'Student Name      ############1################\';
                //     begin
                //         WindowDialog.Open('Checking Students.....\' + Text001Lbl);
                //         StudentMaster.Reset();
                //         if UserSetup."Clinical Administrator" = false then
                //             StudentMaster.SetRange("Document Specialist", UserId);
                //         StudentMaster.SetFilter(Semester, '%1|%2|%3|%4|%5', 'BSIC', 'CLN5', 'CLN6', 'CLN7', 'CLN8');
                //         if UserSetup."Global Dimension 1 Code" <> '' then
                //             StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
                //         if StudentMaster.FindSet() then
                //             repeat
                //                 WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");
                //                 StudentValidity := true;
                //                 StudentStatus.Reset();
                //                 if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                //                 if not (StudentStatus.Status in
                //                 [StudentStatus.Status::Active,
                //                 StudentStatus.Status::CLOA,
                //                 StudentStatus.Status::PROBATION,
                //                 StudentStatus.Status::"Re-Admitted",
                //                 StudentStatus.Status::"Re-Entry",
                //                 StudentStatus.Status::Suspension,
                //                 StudentStatus.Status::TWD]) then
                //                     StudentValidity := false;

                //                 if StudentValidity then begin
                //                     SDA.Reset();
                //                     SDA.SetCurrentKey("Student No.", "Document Status", "Document Category");
                //                     SDA.SetRange("Student No.", StudentMaster."No.");
                //                     SDA.SetRange("Document Category", 'CLINICAL');
                //                     SDA.SetRange("Document Status", SDA."Document Status"::"Portal Submitted");
                //                     if SDA.FindFirst() then
                //                         StudentMaster.Mark(true);
                //                 end;
                //             until StudentMaster.Next() = 0;
                //         StudentMaster.MarkedOnly(true);
                //         Clear(ClinicalDocumentUpdation);
                //         ClinicalDocumentUpdation.SetTableView(StudentMaster);
                //         ClinicalDocumentUpdation.RunModal();
                //     end;
                // }
                field("Pending Site Selection Apps"; Rec."Pending Site Selection Apps")
                {
                    Caption = 'Pending Site Selection Application';
                    DrillDownPageId = "UNVClkshpSite_DateApprovalLST";//50482
                }
                field("Pending Special Accomo. Apps."; Rec."Pending Special Accomo. Apps.")
                {
                    Caption = 'Special Accommodation Application';
                    DrillDownPageId = "Spl Accommodation Approval";//50547
                }
                field("Pndng to Cnfrm Elcve Rotn Apps"; Rec."Pndng to Cnfrm Elcve Rotn Apps")
                {
                    Caption = 'Elective Rotation Application Confirm';
                    DrillDownPageId = "Elective Appln Confirmation";//50749
                }
                field("Pndng Elcve Rotn Apps Approval"; Rec."Pndng Elcve Rotn Apps Approval")
                {
                    Caption = 'Pending Elective Rotation Application Approval';
                    DrillDownPageId = "Rotation Appl Approval List";//50600
                }
                field("Pndg Non-Affiliated Apps"; Rec."Pndg Non-Affiliated Apps")
                {
                    Caption = 'Pending Non-Affiliated Application';
                    DrillDownPageId = "Non-Affiliated Site Apprvl LST";//50489
                }
            }

            cuegroup("Pending Documents for approval")
            {
                actions
                {
                    action("Click to Open")
                    {
                        Image = TileVideo;
                        Visible = DocumentsExist;
                        trigger OnAction()
                        var
                            StudentMaster: Record "Student Master-CS";
                            ClinicalDocumentUpdation: Page "Clinical Document Updation";
                            //SDA: Record "Student Document Attachment";
                            WindowDialog: Dialog;
                            Text001Lbl: Label 'Student Name      ############1################\';
                        begin
                            WindowDialog.Open('Checking Students.....\Please wait.....\' + Text001Lbl);
                            StudentMaster.Reset();
                            if UserSetup."Clinical Administrator" = false then
                                StudentMaster.SetRange("Document Specialist", UserId);
                            StudentMaster.SetFilter(Semester, '%1|%2|%3|%4|%5', 'BSIC', 'CLN5', 'CLN6', 'CLN7', 'CLN8');
                            //StudentMaster.SetFilter("Clinical Documents to Validate", '>%1', 0);
                            if UserSetup."Global Dimension 1 Code" <> '' then
                                StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
                            if StudentMaster.FindSet() then
                                repeat
                                    WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");
                                    // SDA.Reset();
                                    // SDA.SetCurrentKey("Student No.", "Document Status", "Document Category");
                                    // SDA.SetRange("Student No.", StudentMaster."No.");
                                    // SDA.SetRange("Document Category", 'CLINICAL');
                                    // SDA.SetRange("Document Status", SDA."Document Status"::"Portal Submitted");
                                    // if SDA.FindFirst() then

                                    StudentMaster.CalcFields("Clinical Documents to Validate");

                                    if StudentMaster."Clinical Documents to Validate" > 0 then
                                        StudentMaster.Mark(true);
                                until StudentMaster.Next() = 0;

                            StudentMaster.MarkedOnly(true);
                            Clear(ClinicalDocumentUpdation);
                            ClinicalDocumentUpdation.SetTableView(StudentMaster);
                            ClinicalDocumentUpdation.RunModal();
                        end;
                    }
                }
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        ClinicalSemester: Code[1024];

    trigger OnOpenPage();
    var
        EducationSetup: Record "Education Setup-CS";
        ClerkshipSiteAndDateSelection: record ClerkshipSiteAndDateSelection;
        StudentMaster: Record "Student Master-CS";
        SpclAccommodationApplication: record "Spcl Accommodation Application";
        RotationofferApps: Record "Rotation Offer Application";
        NonAffiliatedHospital: Record "Non-Affiliated Hospital";
        SDA: Record "Student Document Attachment";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        Rec.RESET();
        Rec.Deleteall();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;

        WindowDialog.Open('Checking Students.....\Please wait.....\' + Text001Lbl);

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        if EducationSetup."FM1/IM1 Semester Filter" <> '' then
            ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        if EducationSetup."Clerkship Semester Filter" <> '' then
            ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        //For My Students
        StudentMaster.Reset();
        StudentMaster.SetCurrentKey(Semester, "Document Specialist");
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        if UserSetup."Clinical Administrator" = false then
            StudentMaster.SetRange("Document Specialist", UserId);
        if StudentMaster.FindSet() then
            Rec."My Students DS" := StudentMaster.Count();

        StudentMaster.Reset();
        StudentMaster.SetCurrentKey(Semester, "FM1/IM1 Coordinator");
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        if UserSetup."Clinical Administrator" = false then
            StudentMaster.SetRange("FM1/IM1 Coordinator", UserId);
        if StudentMaster.FindSet() then
            Rec."My Students FMIM" := StudentMaster.Count();

        StudentMaster.Reset();
        StudentMaster.SetCurrentKey(Semester, "Clinical Coordinator");
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        if UserSetup."Clinical Administrator" = false then
            StudentMaster.SetRange("Clinical Coordinator", UserId);
        if StudentMaster.FindSet() then
            Rec."My Students CC" := StudentMaster.Count();

        Rec."Students Approching to GAP" := 0;
        //StudentsOnGapOpenPage();

        //For Students on CLOA
        StudentMaster.Reset();
        StudentMaster.SetCurrentKey(Semester, Status);
        if UserSetup."Global Dimension 1 Code" <> '' then
            StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        StudentMaster.SetFilter(Status, '%1', 'CLOA');
        if StudentMaster.FindSet() then
            Rec."Students on CLOA" := StudentMaster.Count();

        //For FIU Students
        StudentMaster.Reset();
        StudentMaster.SetCurrentKey(Semester, "Course Code");
        if UserSetup."Global Dimension 1 Code" <> '' then
            StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        StudentMaster.SetRange("Course Code", '%1', 'AUA-GHT');
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        if StudentMaster.FindSet() then
            Rec."FIU Students" := StudentMaster.Count();

        //For Student with Clinical Hold
        StudentMaster.Reset();
        StudentMaster.SetCurrentKey(Semester);
        if UserSetup."Global Dimension 1 Code" <> '' then
            StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        StudentMaster.SetRange("Clinical Hold Exist", true);
        if StudentMaster.FindSet() then
            Rec."Student with Clinical Hold" := StudentMaster.Count();

        //for Document Pending for Approval
        DocumentsExist := false;
        StudentMaster.Reset();
        if UserSetup."Clinical Administrator" = false then
            StudentMaster.SetRange("Document Specialist", UserId);
        StudentMaster.SetFilter(Semester, '%1|%2|%3|%4|%5', 'BSIC', 'CLN5', 'CLN6', 'CLN7', 'CLN8');
        if UserSetup."Global Dimension 1 Code" <> '' then
            StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
        if StudentMaster.FindSet() then
            repeat
                WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");

                if (DocumentsExist = false) then begin
                    SDA.Reset();
                    SDA.SetCurrentKey("Student No.", "Document Status", "Document Category");
                    SDA.SetRange("Student No.", StudentMaster."No.");
                    SDA.SetRange("Document Category", 'CLINICAL');
                    SDA.SetRange("Document Status", SDA."Document Status"::"Portal Submitted");
                    if SDA.FindFirst() then
                        DocumentsExist := true;
                    //"Document Pending for Approval" := "Document Pending for Approval" + 1;
                end;
            until StudentMaster.Next() = 0;

        WindowDialog.Close();

        //for Pending Site Selection Apps
        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey(Status, Confirmed);
        if UserSetup."Clinical Administrator" = false then
            ClerkshipSiteAndDateSelection.SetRange("FM1/IM1 Coordinator", UserId);
        ClerkshipSiteAndDateSelection.SetRange(Status, ClerkshipSiteAndDateSelection.Status::"Pending for Approval");
        ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
        if ClerkshipSiteAndDateSelection.FindSet() then
            Rec."Pending Site Selection Apps" := ClerkshipSiteAndDateSelection.Count();

        //for Pending Special Accomo. Apps.
        SpclAccommodationApplication.Reset();
        if UserSetup."Clinical Administrator" = false then
            SpclAccommodationApplication.SetRange("Clinical Cordinator ID", UserId);
        SpclAccommodationApplication.SetCurrentKey("Send for Approval", "Approval Status");
        SpclAccommodationApplication.SetRange("Send for Approval", true);
        SpclAccommodationApplication.SetRange("Approval Status", SpclAccommodationApplication."Approval Status"::"Pending for Approval");
        if SpclAccommodationApplication.FindSet() then
            Rec."Pending Special Accomo. Apps." := SpclAccommodationApplication.Count();

        //For Pndng to Cnfrm Elcve Rotn Apps
        RotationofferApps.Reset();
        RotationofferApps.SetCurrentKey(Status);
        if UserSetup."Clinical Administrator" = false then
            RotationofferApps.SetRange("Cordination ID", UserId);
        RotationofferApps.SetRange(Status, RotationofferApps.Status::Open);
        if RotationofferApps.FindSet() then
            Rec."Pndng to Cnfrm Elcve Rotn Apps" := RotationofferApps.Count();

        //for Pndng Elcve Rotn Apps Approval
        RotationofferApps.Reset();
        RotationofferApps.SetCurrentKey("Approval Status", "Rotation Status");
        if UserSetup."Clinical Administrator" = false then
            RotationofferApps.SetRange("Cordination ID", UserId);
        RotationofferApps.SetRange("Approval Status", RotationofferApps."Approval Status"::"Pending for Approval");
        RotationofferApps.SetRange("Rotation Status", RotationofferApps."Rotation Status"::" ");
        if RotationofferApps.FindSet() then
            Rec."Pndng Elcve Rotn Apps Approval" := RotationofferApps.Count();

        //for Pndg Non-Affiliated Apps
        NonAffiliatedHospital.Reset();
        NonAffiliatedHospital.SetCurrentKey(Status, Confirmed);
        if UserSetup."Clinical Administrator" = false then
            NonAffiliatedHospital.SetRange("Clinical Cordinator ID", UserId);
        NonAffiliatedHospital.SetRange("Status", NonAffiliatedHospital."Status"::"Pending for Approval");
        NonAffiliatedHospital.SetRange(Confirmed, true);
        if NonAffiliatedHospital.FindSet() then
            Rec."Pndg Non-Affiliated Apps" := NonAffiliatedHospital.Count();

        Rec.Modify();
    end;

    var
        DocumentsExist: Boolean;

    procedure StudentsOnGapOpenPage()
    var
        EducationSetup: Record "Education Setup-CS";
        StudentMaster: Record "Student Master-CS";
        RSL: Record "Roster Scheduling Line";
        RSL_Next: Record "Roster Scheduling Line";
        RSH: Record "Roster Scheduling Header";
        StudentConsidered: Boolean;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Checking GAP in Rotations..\' + Text001Lbl);
        Rec."Students Approching to GAP" := 0;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then;

        if EducationSetup."FM1/IM1 Semester Filter" <> '' then
            ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        if EducationSetup."Clerkship Semester Filter" <> '' then
            ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        StudentMaster.Reset();
        StudentMaster.ClearMarks();
        StudentMaster.SetFilter(Semester, ClinicalSemester);
        if UserSetup."Clinical Administrator" = false then
            StudentMaster.SetRange("Clinical Coordinator", UserId);
        if StudentMaster.FindSet() then
            repeat
                WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");
                StudentConsidered := false;
                RSL.Reset();
                RSL.SetCurrentKey("Student No.", "Start Date");
                RSL.SetRange("Student No.", StudentMaster."No.");
                RSL.SetFilter("Clerkship Type", '%1|%2', RSL."Clerkship Type"::Core, RSL."Clerkship Type"::Elective);
                RSL.SetFilter(Status, '%1', RSL.Status::Published);
                if RSL.FindSet() then
                    repeat
                        RSL_Next.Reset();
                        RSL_Next.SetCurrentKey("Student No.", "Start Date");
                        RSL_Next.SetRange("Student No.", RSL."Student No.");
                        RSL_Next.SetFilter("Clerkship Type", '%1|%2', RSL."Clerkship Type"::Core, RSL."Clerkship Type"::Elective);
                        RSL_Next.SetFilter(Status, '%1', RSL_Next.Status::Published);
                        RSL_Next.SetFilter("Start Date", '>%1', RSL."Start Date");
                        if RSL_Next.FindFirst() then
                            if (RSL_Next."Start Date" <> 0D) and (RSL."End Date" <> 0D) and (StudentConsidered = false) then
                                if (RSL_Next."Start Date" - RSL."End Date" > 14) then begin
                                    Rec."Students Approching to GAP" := Rec."Students Approching to GAP" + 1;
                                    StudentConsidered := true;
                                end;
                    until RSL.Next() = 0;

                if StudentConsidered = false then begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", StudentMaster."No.");
                    RSL.SetFilter("Clerkship Type", '%1|%2', RSL."Clerkship Type"::Core, RSL."Clerkship Type"::Elective);
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
                    RSL.SetFilter("Start Date", '>%1', WorkDate());
                    if not RSL.FindFirst() then
                        Rec."Students Approching to GAP" := Rec."Students Approching to GAP" + 1;
                end;
            until StudentMaster.Next() = 0;

        RSH.Reset();
        RSH.SetCurrentKey("Clerkship Type", Status);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::"FM1/IM1");
        RSH.SetRange(Status, RSH.Status::Scheduled);
        Rec."FM1/IM1 Rotations to Schedule" := RSH.Count();

        RSH.Reset();
        RSH.SetCurrentKey("Clerkship Type", Status);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Core);
        RSH.SetRange(Status, RSH.Status::Scheduled);
        RSH.SetRange("Rotation Confirmed", true);
        Rec."Core Rotations to Schedule" := RSH.Count();

        RSH.Reset();
        RSH.SetCurrentKey("Clerkship Type", Status);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Elective);
        RSH.SetRange(Status, RSH.Status::Scheduled);
        Rec."Elective Rotations to Schedule" := RSH.Count();
    end;
}