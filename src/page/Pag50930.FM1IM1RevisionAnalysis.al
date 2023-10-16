page 50930 "FM1/IM1 Revision Analysis"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    Caption = 'FM1/IM1 Revision Analysis';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
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
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("FM1_IM1 Hospital Availability"; "FM1_IM1 Hospital Avail FactBox")
            {
                ApplicationArea = All;
                Caption = 'FM1/IM1 Site Selection Details';
                SubPageLink = "Student No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Open Application & Notify")
            {
                ApplicationArea = All;
                Caption = 'Open Application & Notify';
                Image = NewToDo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    StudentMaster: Record "Student Master-CS";
                    ClinicalNotification: Codeunit "Clinical Notification";
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    StudentMaster.Reset();
                    CurrPage.SetSelectionFilter(StudentMaster);
                    if not confirm('You have Selected %1 Student.\Do you want to Open the Applications and Notify to the Students?', true, StudentMaster.Count) then
                        exit;

                    WindowDialog.Open('Sending Notification..\' + Text001Lbl);
                    StudentMaster.Reset();
                    CurrPage.SetSelectionFilter(StudentMaster);
                    if StudentMaster.FindSet() then
                        repeat
                            WindowDialog.Update(1, StudentMaster."Student Name" + ' - ' + StudentMaster."No.");
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
                            ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentMaster."No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1&<>%2',
                            ClerkshipSiteAndDateSelection.Status::Scheduled, ClerkshipSiteAndDateSelection.Status::Published);
                            if ClerkshipSiteAndDateSelection.FindFirst() then begin
                                ClerkshipSiteAndDateSelection.Validate(Confirmed, false);
                                ClerkshipSiteAndDateSelection.Validate(Status, ClerkshipSiteAndDateSelection.Status::" ");
                                ClerkshipSiteAndDateSelection.Modify();
                                //ClinicalNotification.UpdatedSiteSelectionFormRequired(ClerkshipSiteAndDateSelection);//GMCSCOM
                            end;
                        until StudentMaster.Next() = 0;
                    WindowDialog.Close();
                    Commit();
                    ShowRequiredRecords();
                end;
            }
            action("Site Selection Revision Require")
            {
                ApplicationArea = All;
                Caption = 'Site Selection Revision Require';
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                var
                    EducationSetup: Record "Education Setup-CS";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    MainStudentSubject: Record "Main Student Subject-CS";
                    ClinicalSemester: Code[1024];
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Checking USMLE Step 1 Examination Results..\' + Text001Lbl);

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
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.FilterGroup(0);
                    if Rec.FindSet() then
                        repeat
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
                            ClerkshipSiteAndDateSelection.SetRange("Student No.", Rec."No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1&<>%2',
                            ClerkshipSiteAndDateSelection.Status::Scheduled, ClerkshipSiteAndDateSelection.Status::Published);
                            if ClerkshipSiteAndDateSelection.FindFirst() then begin
                                MainStudentSubject.Reset();
                                MainStudentSubject.SetRange("Student No.", Rec."No.");
                                MainStudentSubject.SetRange("Subject Code", EducationSetup."USMLE Step 1 Exam Code");
                                if not MainStudentSubject.FindLast() then
                                    Rec.Mark(true)
                                else
                                    if MainStudentSubject.Result <> MainStudentSubject.Result::Pass then
                                        Rec.Mark(true);
                            end;
                        until Rec.Next() = 0;

                    Rec.MarkedOnly(true);
                    WindowDialog.Close();
                    CurrPage.Update(false);
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
                Visible = false;
                trigger OnAction()
                var
                    EducationSetup: Record "Education Setup-CS";
                    ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
                    ClinicalSemester: Code[1024];
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Resuming Students..\' + Text001Lbl);

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
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.FilterGroup(0);
                    if Rec.FindSet() then
                        repeat
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                            ClerkshipSiteAndDateSelection.Reset();
                            ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
                            ClerkshipSiteAndDateSelection.SetRange("Student No.", Rec."No.");
                            ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                            ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1&<>%2',
                            ClerkshipSiteAndDateSelection.Status::Scheduled, ClerkshipSiteAndDateSelection.Status::Published);
                            if ClerkshipSiteAndDateSelection.FindFirst() then
                                Rec.Mark(true);
                        until Rec.Next() = 0;

                    Rec.MarkedOnly(true);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ShowRequiredRecords();
    end;

    procedure ShowRequiredRecords()
    var
        EducationSetup: Record "Education Setup-CS";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
        MainStudentSubject: Record "Main Student Subject-CS";
        ClinicalSemester: Code[1024];
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Filtering Students..\' + Text001Lbl);

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
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.FilterGroup(0);
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                ClerkshipSiteAndDateSelection.Reset();
                ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
                ClerkshipSiteAndDateSelection.SetRange("Student No.", Rec."No.");
                ClerkshipSiteAndDateSelection.SetRange(Confirmed, true);
                ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1&<>%2',
                ClerkshipSiteAndDateSelection.Status::Scheduled, ClerkshipSiteAndDateSelection.Status::Published);
                if ClerkshipSiteAndDateSelection.FindFirst() then begin
                    MainStudentSubject.Reset();
                    MainStudentSubject.SetRange("Student No.", Rec."No.");
                    MainStudentSubject.SetRange("Subject Code", EducationSetup."USMLE Step 1 Exam Code");
                    if not MainStudentSubject.FindLast() then
                        Rec.Mark(true)
                    else
                        if MainStudentSubject.Result <> MainStudentSubject.Result::Pass then
                            Rec.Mark(true);
                end;
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;
}