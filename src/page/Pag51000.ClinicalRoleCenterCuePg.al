page 51000 ClinicalRoleCenterCuepg
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
                field("Students Apprchng to GAP"; Rec."Students Apprchng to GAP")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Rotation GAP Analysis";//50929;
                }
                field("Studs. on CLOA"; Rec."Studs. on CLOA")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";//50296
                    /*  trigger OnDrillDown()
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
                      end;*/
                }
                field("FIU Stud."; Rec."FIU Stud.")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";//50296
                    // ApplicationArea = Basic, Suite;
                    // trigger OnDrillDown()
                    // var
                    //     StudentMaster: Record "Student Master-CS";
                    //     StudentDetails: Page "Student Details-CS";
                    // begin
                    //     StudentMaster.Reset();
                    //     StudentMaster.FilterGroup(2);
                    //     StudentMaster.SetFilter(Semester, ClinicalSemester);
                    //     StudentMaster.SetRange("Course Code", '%1', 'AUA-GHT');
                    //     StudentMaster.FilterGroup(0);
                    //     StudentDetails.SetTableView(StudentMaster);
                    //     StudentDetails.RunModal();
                    // end;
                }
                field("Stud. with Clinical Hold"; Rec."Stud. with Clinical Hold")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";//50296
                    // ApplicationArea = Basic, Suite;
                    // trigger OnDrillDown()
                    // var
                    //     StudentMaster: Record "Student Master-CS";
                    //     StudentDetails: Page "Student Details-CS";
                    // begin
                    //     StudentMaster.Reset();
                    //     StudentMaster.FilterGroup(2);
                    //     StudentMaster.SetFilter(Semester, ClinicalSemester);
                    //     StudentMaster.SetRange("Clinical Hold Exist", true);
                    //     StudentMaster.FilterGroup(0);
                    //     StudentDetails.SetTableView(StudentMaster);
                    //     StudentDetails.RunModal();
                    // end;
                }
            }

            cuegroup("Admission Master")
            {
                field("Group Master"; Rec."Group Master")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Group Detail-CS";//50227
                }
                field("Student Group"; Rec."Student Group")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Group(Student)-CS";//50111
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        RoleCenterEduCueTable1: Record "RoleCenterEduCueTable";
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        UserSetup.Get(UserId());
        RoleCenterEduCueTable1.Get();
        RoleCenterEduCueTable1."Institute Code" := UserSetup."Global Dimension 1 Code";
        RoleCenterEduCueTable1.Modify();
        if UserSetup."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup."Global Dimension 1 Code") < 6 then
                Rec.SetFilter("Global Dimension 1 Filter", '%1', Format(UserSetup."Global Dimension 1 Code"));
    end;

    // var
    //     UserSetup: Record "User Setup";
    //     ClinicalSemester: Code[1024];

    /* trigger OnOpenPage();
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
         RESET();
         Deleteall();
         if not get() then begin
             INIT();
             INSERT();
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
             "My Students DS" := StudentMaster.Count();

         StudentMaster.Reset();
         StudentMaster.SetCurrentKey(Semester, "FM1/IM1 Coordinator");
         StudentMaster.SetFilter(Semester, ClinicalSemester);
         if UserSetup."Clinical Administrator" = false then
             StudentMaster.SetRange("FM1/IM1 Coordinator", UserId);
         if StudentMaster.FindSet() then
             "My Students FMIM" := StudentMaster.Count();

         StudentMaster.Reset();
         StudentMaster.SetCurrentKey(Semester, "Clinical Coordinator");
         StudentMaster.SetFilter(Semester, ClinicalSemester);
         if UserSetup."Clinical Administrator" = false then
             StudentMaster.SetRange("Clinical Coordinator", UserId);
         if StudentMaster.FindSet() then
             "My Students CC" := StudentMaster.Count();

         "Students Approching to GAP" := 0;
         //StudentsOnGapOpenPage();

         //For Students on CLOA
         StudentMaster.Reset();
         StudentMaster.SetCurrentKey(Semester, Status);
         if UserSetup."Global Dimension 1 Code" <> '' then
             StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
         StudentMaster.SetFilter(Status, '%1', 'CLOA');
         if StudentMaster.FindSet() then
             "Students on CLOA" := StudentMaster.Count();

         //For FIU Students
         StudentMaster.Reset();
         StudentMaster.SetCurrentKey(Semester, "Course Code");
         if UserSetup."Global Dimension 1 Code" <> '' then
             StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
         StudentMaster.SetRange("Course Code", '%1', 'AUA-GHT');
         StudentMaster.SetFilter(Semester, ClinicalSemester);
         if StudentMaster.FindSet() then
             "FIU Students" := StudentMaster.Count();

         //For Student with Clinical Hold
         StudentMaster.Reset();
         StudentMaster.SetCurrentKey(Semester);
         if UserSetup."Global Dimension 1 Code" <> '' then
             StudentMaster.SetFilter("Global Dimension 1 Code", Format(UserSetup."Global Dimension 1 Code"));
         StudentMaster.SetFilter(Semester, ClinicalSemester);
         StudentMaster.SetRange("Clinical Hold Exist", true);
         if StudentMaster.FindSet() then
             "Student with Clinical Hold" := StudentMaster.Count();

         Modify();
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
         "Students Approching to GAP" := 0;

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
                                     "Students Approching to GAP" := "Students Approching to GAP" + 1;
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
                         "Students Approching to GAP" := "Students Approching to GAP" + 1;
                 end;
             until StudentMaster.Next() = 0;

         RSH.Reset();
         RSH.SetCurrentKey("Clerkship Type", Status);
         RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::"FM1/IM1");
         RSH.SetRange(Status, RSH.Status::Scheduled);
         "FM1/IM1 Rotations to Schedule" := RSH.Count();

         RSH.Reset();
         RSH.SetCurrentKey("Clerkship Type", Status);
         RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Core);
         RSH.SetRange(Status, RSH.Status::Scheduled);
         RSH.SetRange("Rotation Confirmed", true);
         "Core Rotations to Schedule" := RSH.Count();

         RSH.Reset();
         RSH.SetCurrentKey("Clerkship Type", Status);
         RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Elective);
         RSH.SetRange(Status, RSH.Status::Scheduled);
         "Elective Rotations to Schedule" := RSH.Count();
     end;*/
}