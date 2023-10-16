page 50938 "Students Rotation Audit"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    SourceTableView = sorting(Semester) order(descending);
    Caption = 'Student''s Rotation Audit';
    PromotedActionCategories = 'New,Process,Navigate,FM1/IM1 Rotation,Pediatrics,Obstetrics/Gynecology,Surgery,Family Medicine,Internal Medicine,Psychiatry';
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
                    trigger OnDrillDown()
                    var
                        StudentCard: Page "Student Detail Card-CS";
                    begin
                        Clear(StudentCard);
                        StudentCard.SetRecord(Rec);
                        StudentCard.RunModal();
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Start Date New"; Rec."FM1/IM1 Start Date New")
                {
                    ApplicationArea = all;
                    Caption = 'FM1/IM1 Start Date';
                    Editable = false;
                }
            }
            part(Lines; "Roster Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = field("No.");
                SubPageView = sorting("Start Date") order(ascending);
                Caption = 'Rotation Details';
            }
        }
        area(FactBoxes)
        {
            part("Rotation Audit Factbox"; "Rotation Audit Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Caption = 'Other Details';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("All Students")
            {
                ApplicationArea = All;
                Caption = 'All Students';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    ClearStudentMarks();
                    SelectedOptionTxt := 'No filter applied';
                end;
            }
            action("FM1/IM1 Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    SelectedOptionTxt := 'FM1/IM1 Incompleted Students';
                    CurrPage.Update(false);
                    MarkFM1IM1Students(EducationSetup."FM1/IM1 Subject Code", false);
                end;
            }
            action("FM1/IM1 Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Complete Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'FM1/IM1 Completed Students';
                    CurrPage.Update(false);
                    MarkFM1IM1Students(EducationSetup."FM1/IM1 Subject Code", true);
                end;
            }
            action("Pediatrics Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Pediatrics Incompleted Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(PediatricsSubjects, false, PediatricsWeeks);
                end;
            }
            action("Pediatrics Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Completed Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Pediatrics Completed Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(PediatricsSubjects, true, PediatricsWeeks);
                end;
            }
            action("Add in Rotation PED")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = CreateElectronicReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    OpenAddingStudentInRotation('PED');
                end;
            }

            action("OBG Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'OBG Incompleted Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(OBGSubjects, false, OBGWeeks);
                end;
            }
            action("OBG Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Completed Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'OBG Completed Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(OBGSubjects, true, OBGWeeks);
                end;
            }
            action("Add in Rotation OBG")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = CreateElectronicReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    OpenAddingStudentInRotation('OBG');
                end;
            }
            action("Surgery Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category7;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Surgery Incompleted Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(SurgerySubjects, false, OBGWeeks);
                end;
            }
            action("Surgery Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Completed Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category7;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Surgery Completed Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(SurgerySubjects, true, SurgeryWeeks);
                end;
            }
            action("Add in Rotation SUR")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = CreateElectronicReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    OpenAddingStudentInRotation('SUR');
                end;
            }
            action("Family Medicine Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category8;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Family Medicine Incompleted Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(FamilyMedicineSubjects, false, FamilyMedicineWeeks);
                end;
            }
            action("Family Medicine Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Completed Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category8;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Family Medicine Completed Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(FamilyMedicineSubjects, true, FamilyMedicineWeeks);
                end;
            }
            action("Add in Rotation FM")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = CreateElectronicReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category8;
                trigger OnAction()
                begin
                    OpenAddingStudentInRotation('FM');
                end;
            }
            action("Internal Medicine Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category9;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Internal Medicine Incompleted Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(InternalMedicineSubjects, false, InternalMedicineWeeks);
                end;
            }
            action("Internal Medicine Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Completed Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category9;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Internal Medicine Completed Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(InternalMedicineSubjects, true, InternalMedicineWeeks);
                end;
            }
            action("Add in Rotation IM")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = CreateElectronicReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category9;
                trigger OnAction()
                begin
                    OpenAddingStudentInRotation('IM');
                end;
            }
            action("Psychiatry Incomplete Students")
            {
                ApplicationArea = All;
                Caption = 'Incomplete Students';
                Image = CollapseAll;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category10;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Psychiatry Incompleted Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(PsychiatricSubjects, false, PsychiatricWeeks);
                end;
            }
            action("Psychiatry Completed Students")
            {
                ApplicationArea = All;
                Caption = 'Completed Students';
                Image = Completed;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category10;

                trigger OnAction()
                begin
                    SelectedOptionTxt := 'Psychiatry Completed Students';
                    CurrPage.Update(false);
                    MarkStudentsComplete_InComplete(PsychiatricSubjects, true, PsychiatricWeeks);
                end;
            }
            action("Add in Rotation PSY")
            {
                ApplicationArea = All;
                Caption = 'Add in Rotation';
                Image = CreateElectronicReminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category10;
                trigger OnAction()
                begin
                    OpenAddingStudentInRotation('PSY');
                end;
            }
            action("Clinical Documents")
            {
                ApplicationArea = All;
                Caption = 'Clinical Documents';
                Image = Documents;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentDocumentAttachment: Record "Student Document Attachment";
                begin
                    StudentDocumentAttachment.Reset();
                    StudentDocumentAttachment.FilterGroup(2);
                    StudentDocumentAttachment.SetRange("Student No.", Rec."No.");
                    StudentDocumentAttachment.FilterGroup(0);
                    Page.RunModal(Page::"Audit Clinical Documents", StudentDocumentAttachment);
                end;
            }
            action("Clincal Cordinators")
            {
                ApplicationArea = All;
                Caption = 'Clincal Cordinators';
                Image = CopyRouteVersion;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."No.");
                    StudentMaster.FilterGroup(0);
                    Page.RunModal(Page::"Student Clinical Details", StudentMaster);
                end;
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Documents;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    StudentDetailCard: Page "Student Detail Card-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."No.");
                    StudentMaster.FilterGroup(0);
                    StudentDetailCard.SetTableView(StudentMaster);
                    StudentDetailCard.Editable(false);
                    StudentDetailCard.RunModal();
                end;
            }
            action("All Documents")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+D';
                Caption = 'All SchoolDocs Documents';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = DocInBrowser;
                trigger OnAction();
                var
                    CompanyInfo: Record "Company Information";
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    CompanyInfo.TestField("SchoolDocs Documents Open Url");
                    PostUrl := CompanyInfo."SchoolDocs Documents Open Url";
                    PostUrl := PostUrl + Rec."No.";
                    Hyperlink(PostUrl);
                end;
            }
        }
    }

    var
        EducationSetup: Record "Education Setup-CS";
        ClinicalSemester: Code[2048];
        ClinicalCourse: Code[2048];
        PediatricsSubjects: Code[2048];
        OBGSubjects: Code[2048];
        SurgerySubjects: Code[2048];
        FamilyMedicineSubjects: Code[2048];
        InternalMedicineSubjects: Code[2048];
        PsychiatricSubjects: Code[2048];

        PediatricsWeeks: Integer;
        OBGWeeks: Integer;
        SurgeryWeeks: Integer;
        FamilyMedicineWeeks: Integer;
        InternalMedicineWeeks: Integer;
        PsychiatricWeeks: Integer;
        StudentFiltered: Boolean;

    trigger OnOpenPage()
    begin
        SelectedOptionTxt := 'No filter applied';
        ClearStudentMarks();

        PediatricsSubjects := '';
        OBGSubjects := '';
        SurgerySubjects := '';
        FamilyMedicineSubjects := '';
        InternalMedicineSubjects := '';
        PsychiatricSubjects := '';

        PediatricsWeeks := 0;
        OBGWeeks := 0;
        SurgeryWeeks := 0;
        FamilyMedicineWeeks := 0;
        InternalMedicineWeeks := 0;
        PsychiatricWeeks := 0;

        GetSubjectAndWeeks(EducationSetup."Pediatrics Subject Group", PediatricsSubjects, PediatricsWeeks);
        GetSubjectAndWeeks(EducationSetup."OBG Subject Group", OBGSubjects, OBGWeeks);
        GetSubjectAndWeeks(EducationSetup."Surgery Subject Group", SurgerySubjects, SurgeryWeeks);
        GetSubjectAndWeeks(EducationSetup."Family Medicine Subject Group", FamilyMedicineSubjects, FamilyMedicineWeeks);
        GetSubjectAndWeeks(EducationSetup."IM Subject Group", InternalMedicineSubjects, InternalMedicineWeeks);
        GetSubjectAndWeeks(EducationSetup."Psychiatric Subject Group", PsychiatricSubjects, PsychiatricWeeks);
    end;

    procedure Setvariables(LStudentFiltered: Boolean)
    begin
        StudentFiltered := LStudentFiltered;
    end;

    procedure GetSubjectAndWeeks(GroupCode: Code[20]; Var SubjectCode: Code[2048]; Var Weeks: Integer)
    var
        SubjectMaster: Record "Subject Master-CS";
        TextNoofWeeks: Text;
    begin
        SubjectCode := '';
        Weeks := 0;

        SubjectMaster.Reset();
        SubjectMaster.SetRange(Code, GroupCode);
        if SubjectMaster.Findfirst() then begin
            TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
            Evaluate(Weeks, TextNoofWeeks);
        end;

        SubjectMaster.Reset();
        SubjectMaster.SetRange("Subject Group", GroupCode);
        SubjectMaster.SetRange("Level Description", SubjectMaster."Level Description"::"Level 2 Clinical Rotation");
        if SubjectMaster.FindSet() then
            repeat
                if SubjectCode = '' then
                    SubjectCode := SubjectMaster.Code + '|' + GroupCode//Lucky --11-05-2022 Adding Group code due to wrong data on PROD, Group code is also defined as level 2 in Subject Master
                else
                    SubjectCode := SubjectCode + '|' + SubjectMaster.Code;
            until SubjectMaster.Next() = 0;
    end;

    procedure MarkStudentsComplete_InComplete(SubjectCode: Code[2048]; RotationType: Boolean; NoOfWeeks: Integer)
    var
        RSL: Record "Roster Scheduling Line";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        CompletedWeeks: Integer;
    begin
        WindowDialog.Open('Checking Student Rotations..\' + Text001Lbl);
        CompletedWeeks := 0;

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
                CompletedWeeks := 0;

                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

                if RotationType = true then begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.SetFilter("Course Code", SubjectCode);
                    RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
                    //RSL.SetFilter("Rotation Grade", '%1|%2|%3|%4', '', 'High Pass', 'Honors', 'Pass');
                    RSL.SetFilter("Rotation Grade", '<>F');//Lucky - as per stuti
                    if RSL.FindSet() then
                        repeat
                            CompletedWeeks := CompletedWeeks + RSL."No. of Weeks";
                        until RSL.Next() = 0;

                    if CompletedWeeks >= NoOfWeeks then
                        Rec.Mark(true);
                end;

                if RotationType = false then begin
                    RSL.Reset();
                    RSL.SetCurrentKey("Student No.", "Start Date");
                    RSL.SetRange("Student No.", Rec."No.");
                    RSL.SetFilter("Course Code", SubjectCode);
                    RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Published, RSL.Status::Completed);
                    //RSL.SetFilter("Rotation Grade", '%1|%2|%3|%4', '', 'High Pass', 'Honors', 'Pass');
                    RSL.SetFilter("Rotation Grade", '<>F');//Lucky - as per stuti
                    if RSL.FindSet() then
                        repeat
                            CompletedWeeks := CompletedWeeks + RSL."No. of Weeks";
                        until RSL.Next() = 0;

                    if CompletedWeeks < NoOfWeeks then
                        Rec.Mark(true);
                end;
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;

    procedure MarkFM1IM1Students(SubjectCode: Code[2048]; RotationType: Boolean)
    var
        RSL: Record "Roster Scheduling Line";
        StudentStatus: Record "Student Status";
        WindowDialog: Dialog;
        CompletedWeeks: Integer;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Checking Student Rotations..\' + Text001Lbl);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        Rec.Reset();
        Rec.ClearMarks();
        Rec.FilterGroup(2);
        Rec.SetFilter(Rec."Course Code", ClinicalCourse);
        Rec.SetFilter(Rec.Semester, ClinicalSemester);
        Rec.SetFilter(Rec.Status, EducationSetup."Active Statuses");
        Rec.FilterGroup(0);
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

                if StudentStatus.Status in [StudentStatus.Status::Active, StudentStatus.Status::Probation, StudentStatus.Status::"Re-Entry",
                StudentStatus.Status::"Re-Admitted", StudentStatus.Status::TWD, StudentStatus.Status::Suspension, StudentStatus.Status::CLOA, StudentStatus.Status::ELOA, StudentStatus.Status::SLOA,
                StudentStatus.Status::Deposited, StudentStatus.Status::Deferred] then begin
                    if RotationType = true then begin
                        RSL.Reset();
                        RSL.SetCurrentKey("Student No.", "Start Date");
                        RSL.SetRange("Student No.", Rec."No.");
                        RSL.SetFilter("Course Code", SubjectCode);
                        RSL.SetFilter(Status, '%1|%2', RSL.Status::Scheduled, RSL.Status::Published);
                        //RSL.SetFilter("Rotation Grade", '%1|%2|%3|%4', '', 'High Pass', 'Honors', 'Pass');
                        RSL.SetFilter("Rotation Grade", '<>F');//Lucky - as per stuti
                        if RSL.FindSet() then
                            repeat
                                CompletedWeeks := CompletedWeeks + RSL."No. of Weeks";
                            until RSL.Next() = 0;

                        if CompletedWeeks >= 6 then
                            Rec.Mark(true);
                    end;

                    if RotationType = false then begin
                        RSL.Reset();
                        RSL.SetCurrentKey("Student No.", "Start Date");
                        RSL.SetRange("Student No.", Rec."No.");
                        RSL.SetFilter("Course Code", SubjectCode);
                        RSL.SetFilter(Status, '%1|%2', RSL.Status::Scheduled, RSL.Status::Published);
                        //RSL.SetFilter("Rotation Grade", '%1|%2|%3|%4', '', 'High Pass', 'Honors', 'Pass');
                        RSL.SetFilter("Rotation Grade", '<>F');//Lucky - as per stuti
                        if RSL.FindSet() then
                            repeat
                                CompletedWeeks := CompletedWeeks + RSL."No. of Weeks";
                            until RSL.Next() = 0;

                        if CompletedWeeks < 6 then
                            Rec.Mark(true);
                    end;
                end;
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;

    procedure ClearStudentMarks()
    var
        CourseMaster: Record "Course Master-CS";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;
        begin
            EducationSetup.TestField("Pediatrics Subject Group");
            EducationSetup.TestField("OBG Subject Group");
            EducationSetup.TestField("Surgery Subject Group");
            EducationSetup.TestField("Family Medicine Subject Group");
            EducationSetup.TestField("IM Subject Group");
            EducationSetup.TestField("Psychiatric Subject Group");
        end;

        // if EducationSetup."FM1/IM1 Semester Filter" <> '' then
        //     ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        // if EducationSetup."Clerkship Semester Filter" <> '' then
        //     ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

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

        WindowDialog.Open('Filtering Students..\' + Text001Lbl);

        if StudentFiltered = false then begin
            Rec.ClearMarks();
            Rec.Reset();
            Rec.SetCurrentKey(Semester);
            Rec.SetAscending(Semester, false);
            Rec.SetFilter("Course Code", ClinicalCourse);
            Rec.SetFilter(Semester, ClinicalSemester);
            Rec.SetFilter(Status, EducationSetup."Active Statuses");
            if Rec.FindSet() then
                repeat
                    WindowDialog.Update(1, Rec."No." + ' - ' + Rec."Student Name");
                    Rec.Mark(True);
                until Rec.Next() = 0;

            Rec.MarkedOnly(true);
        end;
        WindowDialog.Close();
        CurrPage.Update(false);
    end;

    procedure OpenAddingStudentInRotation(Prefix: Code[20])
    var
        SubjectMaster: Record "Subject Master-CS";
        RSH: Record "Roster Scheduling Header";
        RSL: Record "Roster Scheduling Line";
        AddingStudentInRotation: Page AddingStudentInRotation;
        LGroupCode: Code[20];
        LSubjectCode: Code[2048];
        WeekScheduled: Integer;
        NoOfWeeks: Integer;
        TextNoofWeeks: Text;
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;
        begin
            EducationSetup.TestField("Pediatrics Subject Group");
            EducationSetup.TestField("OBG Subject Group");
            EducationSetup.TestField("Surgery Subject Group");
            EducationSetup.TestField("Family Medicine Subject Group");
            EducationSetup.TestField("IM Subject Group");
            EducationSetup.TestField("Psychiatric Subject Group");
        end;

        if Prefix = 'PED' then begin
            LGroupCode := EducationSetup."Pediatrics Subject Group";
            LSubjectCode := PediatricsSubjects;
        end;
        if Prefix = 'OBG' then begin
            LGroupCode := EducationSetup."OBG Subject Group";
            LSubjectCode := OBGSubjects;
        end;
        if Prefix = 'SUR' then begin
            LGroupCode := EducationSetup."Surgery Subject Group";
            LSubjectCode := SurgerySubjects;
        end;
        if Prefix = 'FM' then begin
            LGroupCode := EducationSetup."Family Medicine Subject Group";
            LSubjectCode := FamilyMedicineSubjects;
        end;
        if Prefix = 'IM' then begin
            LGroupCode := EducationSetup."IM Subject Group";
            LSubjectCode := InternalMedicineSubjects;
        end;
        if Prefix = 'PSY' then begin
            LGroupCode := EducationSetup."Psychiatric Subject Group";
            LSubjectCode := PsychiatricSubjects;
        end;

        WeekScheduled := 0;

        RSL.Reset();
        RSL.SetCurrentKey("Student No.", "Course Code");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetFilter("Course Code", LSubjectCode);
        RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::Core);
        RSL.SetFilter(Status, '%1|%2|%3', RSL.Status::Scheduled, RSL.Status::Completed, RSL.Status::Published);//CSPL-00307-RTP
        RSL.SetFilter("Rotation Grade", '<>F');//CSPL-00307-RTP
        if RSL.FindSet() then
            repeat
                WeekScheduled := WeekScheduled + RSL."No. of Weeks";
            until RSL.Next() = 0;

        SubjectMaster.Reset();
        SubjectMaster.SetRange(Code, LGroupCode);
        if SubjectMaster.FindFirst() then begin
            TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
            Evaluate(NoOfWeeks, TextNoofWeeks);
        end;

        if WeekScheduled >= NoOfWeeks then
            Error('Student No. %1 (%2) has completed %3 weeks Rotation for the Subject %4.', Rec."No.", Rec."Student Name", WeekScheduled, SubjectMaster.Description);
        RSL.Reset();
        RSL.SetCurrentKey("End Date");
        RSL.SetRange("Student No.", Rec."No.");
        RSL.SetFilter(Status, '%1|%2|%3|%4', RSL.Status::Scheduled, RSL.Status::Completed, RSL.Status::Published, RSL.Status::Unconfirmed);
        RSL.SetAscending("End Date", true);
        IF RSL.FindLast() then;

        RSH.Reset();
        RSH.FilterGroup(2);
        RSH.SetRange("Clerkship Type", RSH."Clerkship Type"::Core);
        RSH.SetFilter("Course Code", LSubjectCode);
        // RSH.SetFilter("Start Date", '>=%1', WorkDate());//CSPL-00307-RTP 31-05-23 comment as per ajay
        RSH.SetFilter("Start Date", '>%1', RSL."End Date");//CSPL-00307-RTP
        RSH.FilterGroup(2);

        Clear(AddingStudentInRotation);
        AddingStudentInRotation.SetVariables(LGroupCode, SubjectMaster.Description, Rec."No.", Rec."Student Name", Rec."Enrollment No.", Rec."Academic Year", Rec.Semester, WeekScheduled, NoOfWeeks - WeekScheduled);
        AddingStudentInRotation.SetTableView(RSH);
        AddingStudentInRotation.RunModal();
    end;

    trigger OnAfterGetRecord()
    var
        RosterLedgerEntry: Record "Roster Ledger Entry";
    begin
        FMIMStartDate := 0D;
        RosterLedgerEntry.Reset();
        RosterLedgerEntry.SetCurrentKey("Student ID");
        RosterLedgerEntry.SetRange("Student ID", Rec."No.");
        RosterLedgerEntry.Setfilter("Clerkship Type", '%1', RosterLedgerEntry."Clerkship Type"::"FM1/IM1");
        RosterLedgerEntry.SetFilter(Status, '<>%1', RosterLedgerEntry.Status::Cancelled);
        if RosterLedgerEntry.FindFirst() then
            FMIMStartDate := RosterLedgerEntry."Start Date";

        Rec.SetCurrentKey(Semester, Rec."FM1/IM1 Start Date New");
        Rec.SetAscending(Semester, false);
        Rec.SetAscending("FM1/IM1 Start Date New", True);
    end;

    var
        SelectedOptionTxt: Text;
        FMIMStartDate: Date;
}