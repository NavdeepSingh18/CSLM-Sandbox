page 50929 "Rotation GAP Analysis"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    Caption = 'Rotation GAP Analysis';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            field(SelectedOptionTxt; SelectedOptionTxt)
            {
                ShowCaption = false;
                Style = Favorable;
                Editable = false;
            }
            repeater("Students Coordinator")
            {
                field("No."; Rec."No.")
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Rotation Count"; "Rotation Count")
            {
                ApplicationArea = All;
                Caption = 'Rotation Count';
                SubPageLink = "No." = field("No.");
            }
            part("Hold FactBox"; "Hold FactBox")
            {
                ApplicationArea = All;
                Caption = 'Student Hold(s)';
                SubPageLink = "Student No." = field("No.");
                SubPageView = sorting("Student No.", Status) order(descending);
            }
            part("Notes Factbox"; "Notes Factbox")
            {
                ApplicationArea = All;
                Caption = 'Notes';
                SubPageLink = "Student No." = field("No.");
                SubPageView = where("Template Type" = filter("Clinical Clerkship"));
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Students With GAP")
            {
                ApplicationArea = All;
                Caption = 'Students with GAP';
                Image = Absence;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Students with GAP';
                    FilterStudentsWithGAP();
                end;
            }

            action("Future Rotation not Scheduled")
            {
                ApplicationArea = All;
                Caption = 'Future Rotation not Scheduled';
                Image = GeneralPostingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                    StudentStatus: Record "Student Status";
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                    RequiredWeeks: Integer;
                    CompletedWeeks: Integer;
                begin
                    WindowDialog.Open('Checking Future Published Rotations..\' + Text001Lbl);
                    SelectedOptionTxt := 'Future Rotation not Scheduled';

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetup.FindFirst() then;

                    Rec.Reset();
                    Rec.ClearMarks();
                    Rec.FilterGroup(2);
                    Rec.SetFilter("Course Code", ClinicalCourse);
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.SetFilter(Status, EducationSetup."Active Statuses");
                    Rec.FilterGroup(0);
                    if Rec.FindSet() then
                        repeat
                            RequiredWeeks := 0;
                            CompletedWeeks := 0;
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                            StudentStatus.Reset();
                            StudentStatus.SetRange(Code, Rec.Status);
                            if StudentStatus.FindFirst() then;

                            if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
                            StudentStatus.Status::TWD,
                            StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
                            StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
                            StudentStatus.Status::"Re-Admitted",
                            StudentStatus.Status::Suspension]) then begin
                                if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"75" then
                                    RequiredWeeks := 75;
                                if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"78" then
                                    RequiredWeeks := 78;
                                if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"84" then
                                    RequiredWeeks := 84;
                                if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"88" then
                                    RequiredWeeks := 88;
                                if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"90" then
                                    RequiredWeeks := 90;
                                if Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"94" then
                                    RequiredWeeks := 94;
                                IF Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"86" then
                                    RequiredWeeks := 86;
                                If Rec."Clinical Curriculum" = Rec."Clinical Curriculum"::"96" then
                                    RequiredWeeks := 96;

                                RequiredWeeks := 1 * RequiredWeeks;
                                CompletedWeeks := 1 * CompletedWeeks;
                                // RSL.Reset();
                                // RSL.SetCurrentKey("Student No.", "Start Date");
                                // RSL.SetRange("Student No.", "No.");
                                // RSL.SetFilter(Status, '<>%1', RSL.Status::Cancelled);
                                // if RSL.FindSet() then
                                //     repeat
                                //         CompletedWeeks := CompletedWeeks + RSL."No. of Weeks";
                                //     until RSL.Next() = 0;

                                //if CompletedWeeks < RequiredWeeks then begin
                                RSL.Reset();
                                RSL.SetCurrentKey("Student No.", "Start Date");
                                RSL.SetRange("Student No.", Rec."No.");
                                RSL.SetFilter(Status, '%1', RSL.Status::Published);
                                RSL.SetFilter("End Date", '>%1', WorkDate());
                                if not RSL.FindFirst() then
                                    Rec.Mark(true);
                                //end;
                            end;
                        until Rec.Next() = 0;

                    Rec.MarkedOnly(true);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }

            action("List of Rotations")
            {
                ApplicationArea = All;
                Caption = 'List of Rotations';
                Image = ListPage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.FilterGroup(2);
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.FilterGroup(2);
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                end;
            }

            action("Clear Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear Filters';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //FilterStudentsOpenPage();
                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetup.FindFirst() then;

                    SelectedOptionTxt := 'All Students';
                    GetValues();
                    Rec.Reset();
                    Rec.ClearMarks();
                    Rec.FilterGroup(2);
                    Rec.SetFilter("Course Code", ClinicalCourse);
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.SetFilter(Status, EducationSetup."Active Statuses");
                    Rec.FilterGroup(0);
                    CurrPage.Update(false);
                end;
            }

            action("Approaching GAP Notification")
            {
                ApplicationArea = All;
                Caption = 'Approaching GAP Notification';
                Image = MailAttachment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    SendApproachingGAPMail();
                end;
            }
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("No.");
                    TemplateType := TemplateType::"Clinical Clerkship";
                    GroupType := GroupType::"Clinical Clerkship";
                    ClinicalBaseAppSubscribe.ViewEditNote(Rec."No.", Rec."No.", TemplateType, GroupType);
                end;
            }
        }
    }

    var
        EducationSetup: Record "Education Setup-CS";
        ClinicalSemester: Code[1024];
        ClinicalCourse: Code[2048];
        SelectedOptionTxt: Text;

    trigger OnOpenPage()
    begin
        SelectedOptionTxt := 'All Students';
        GetValues();
        Rec.Reset();
        Rec.ClearMarks();
        Rec.FilterGroup(2);
        Rec.SetFilter("Course Code", ClinicalCourse);
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.SetFilter(Status, EducationSetup."Active Statuses");
        Rec.FilterGroup(0);
    end;

    procedure GetValues()
    var
        CourseMaster: Record "Course Master-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindLast() then;

        ClinicalCourse := '';
        CourseMaster.Reset();
        CourseMaster.SetRange("Clinical Clerkship Applicable", true);
        if CourseMaster.FindSet() then
            repeat
                if ClinicalCourse = '' then
                    ClinicalCourse := CourseMaster.Code
                else
                    ClinicalCourse := ClinicalCourse + '|' + CourseMaster.Code;
            until CourseMaster.Next() = 0;

        if ClinicalCourse = '' then
            ClinicalCourse := 'NA';

        ClinicalSemester := 'CLN5|CLN6|CLN7|CLN8';
    end;

    procedure FilterStudentsOpenPage()   //CURRENTLY NOT CALLED ON ONOPEN PAGE 
    var
        CourseMaster: Record "Course Master-CS";
        RSL: Record "Roster Scheduling Line";
        RSL_Next: Record "Roster Scheduling Line";
        StudentStatus: Record "Student Status";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Checking GAP in Rotations..\' + Text001Lbl);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        ClinicalCourse := '';
        CourseMaster.Reset();
        CourseMaster.SetRange("Clinical Clerkship Applicable", true);
        if CourseMaster.FindSet() then
            repeat
                if ClinicalCourse = '' then
                    ClinicalCourse := CourseMaster.Code
                else
                    ClinicalCourse := ClinicalCourse + '|' + CourseMaster.Code;
            until CourseMaster.Next() = 0;

        if ClinicalCourse = '' then
            ClinicalCourse := 'NA';

        ClinicalSemester := 'CLN5|CLN6|CLN7|CLN8';

        Rec.Reset();
        Rec.ClearMarks();
        Rec.FilterGroup(2);
        Rec.SetFilter("Course Code", ClinicalCourse);
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.SetFilter(Status, EducationSetup."Active Statuses");
        Rec.FilterGroup(0);
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

                StudentStatus.Reset();
                StudentStatus.SetRange(Code, Rec.Status);
                if StudentStatus.FindFirst() then;

                if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
                StudentStatus.Status::TWD,
                StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
                StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
                StudentStatus.Status::"Re-Admitted",
                StudentStatus.Status::Suspension]) then begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
                    if RSL.FindSet() then
                        repeat
                            RSL_Next.Reset();
                            RSL_Next.SetCurrentKey("Student No.", "Start Date");
                            RSL_Next.SetRange("Student No.", RSL."Student No.");
                            RSL_Next.SetFilter(Status, '%1', RSL_Next.Status::Published);
                            RSL_Next.SetFilter("Start Date", '>%1', RSL."Start Date");
                            if RSL_Next.FindFirst() then
                                if (RSL_Next."Start Date" <> 0D) and (RSL."End Date" <> 0D) then
                                    if (RSL_Next."Start Date" - RSL."End Date" > 31) then
                                        Rec.Mark(true);
                        until RSL.Next() = 0;

                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
                    RSL.SetFilter("Start Date", '>%1', WorkDate());
                    if not RSL.FindFirst() then
                        Rec.Mark(true);
                end;
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;

    procedure FilterStudentsWithGAP()
    var
        RSL: Record "Roster Scheduling Line";
        RSL_Next: Record "Roster Scheduling Line";
        StudentStatus: Record "Student Status";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Checking GAP in Rotations..\' + Text001Lbl);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        if EducationSetup."FM1/IM1 Semester Filter" <> '' then
            ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        if EducationSetup."Clerkship Semester Filter" <> '' then
            ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        Rec.Reset();
        Rec.ClearMarks();
        Rec.FilterGroup(2);
        Rec.SetFilter("Course Code", ClinicalCourse);
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.SetFilter(Status, EducationSetup."Active Statuses");
        Rec.FilterGroup(0);
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

                StudentStatus.Reset();
                StudentStatus.SetRange(Code, Rec.Status);
                if StudentStatus.FindFirst() then;

                if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
                StudentStatus.Status::TWD,
                StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
                StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
                StudentStatus.Status::"Re-Admitted",
                StudentStatus.Status::Suspension]) then begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
                    if RSL.FindSet() then
                        repeat
                            RSL_Next.Reset();
                            RSL_Next.SetCurrentKey("Student No.", "Start Date");
                            RSL_Next.SetRange("Student No.", RSL."Student No.");
                            RSL_Next.SetFilter(Status, '%1', RSL_Next.Status::Published);
                            RSL_Next.SetFilter("Start Date", '>%1', RSL."Start Date");
                            if RSL_Next.FindFirst() then
                                IF (RSL_Next."Start Date" <> 0D) AND (RSL."End Date" <> 0D) then
                                    if RSL_Next."Start Date" - RSL."End Date" > 31 then
                                        Rec.Mark(true);
                        until RSL.Next() = 0;
                end;
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;

    procedure SendApproachingGAPMail()
    var
        RSL: Record "Roster Scheduling Line";
        RSL_Next: Record "Roster Scheduling Line";
        StudentStatus: Record "Student Status";
        ClinicalNotification: Codeunit "Clinical Notification";
        Days: Integer;
        I: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        CurrPage.SetSelectionFilter(Rec);
        I := Rec.Count;
        if Not confirm('You have Selected %1 Students.\\\\Do you want to Send Approaching GAP Notification for the Selected Studends?', true, I) then
            exit;

        WindowDialog.Open('Checking and Sending Approaching GAP Mail..\' + Text001Lbl);
        CurrPage.SetSelectionFilter(Rec);
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

                StudentStatus.Reset();
                StudentStatus.SetRange(Code, Rec.Status);
                if StudentStatus.FindFirst() then;

                if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
                StudentStatus.Status::TWD,
                StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
                StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
                StudentStatus.Status::"Re-Admitted",
                StudentStatus.Status::Suspension]) then begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
                    if RSL.FindSet() then
                        repeat
                            RSL_Next.Reset();
                            RSL_Next.SetCurrentKey("Student No.", "Start Date");
                            RSL_Next.SetRange("Student No.", RSL."Student No.");
                            RSL_Next.SetFilter(Status, '%1', RSL_Next.Status::Published);
                            RSL_Next.SetFilter("Start Date", '>%1', RSL."Start Date");
                            if RSL_Next.FindFirst() then
                                IF (RSL_Next."Start Date" <> 0D) AND (RSL."End Date" <> 0D) then
                                    if RSL_Next."Start Date" - RSL."End Date" > 31 then begin
                                        Days := RSL_Next."Start Date" - RSL."End Date";
                                        //ClinicalNotification.ApproachingGAP(Rec."No.", Days);//GMCSCOM
                                    end;
                        until RSL.Next() = 0;
                end;
            until Rec.Next() = 0;
    end;

    procedure ElectivePendingWeekMail()
    var
        StudentStatus: Record "Student Status";
        ClinicalNotification: Codeunit "Clinical Notification";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        I: Integer;
    begin
        CurrPage.SetSelectionFilter(Rec);
        I := Rec.Count;
        if Not confirm('You have Selected %1 Students.\\\\Do you want to Send Elective Pending Week Notification for the Selected Studends?', true, I) then
            exit;

        WindowDialog.Open('Sending Elective Pending Week Mail..\' + Text001Lbl);
        CurrPage.SetSelectionFilter(Rec);
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                StudentStatus.Reset();
                StudentStatus.SetRange(Code, Rec.Status);
                if StudentStatus.FindFirst() then;

                // if not (StudentStatus.Status in [StudentStatus.Status::Dismissed,
                // StudentStatus.Status::TWD,
                // StudentStatus.Status::Withdrawn, StudentStatus.Status::CLOA,
                // StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
                // StudentStatus.Status::"Re-Admitted",
                // StudentStatus.Status::Suspension]) then
                //     ClinicalNotification.RemainingElectiveWeeks(Rec."No.");
            until Rec.Next() = 0;
    end;
}