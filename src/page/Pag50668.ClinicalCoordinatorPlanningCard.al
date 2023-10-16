page 50668 "CLN Coordinator Planning CRD"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Clinical Coordinator Planning";
    Caption = 'Clinical Coordinator Planning';

    layout
    {
        area(Content)
        {
            group(General)
            {
                label("Alpha Range")
                {
                    ApplicationArea = All;
                    Caption = '"Alpha Range will Work on First Letter of Student''s Last Name."';
                    Style = Unfavorable;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Start Alpha Range"; Rec."Start Alpha Range")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Alpha Range"; Rec."End Alpha Range")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update on Students")
            {
                Caption = 'Update on Students';
                ShortcutKey = 'Ctrl+M';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapSetup;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF not Confirm('Do you want to update %1 on Students?', true, Rec.Role) then
                        exit;

                    IF Rec.Status = Rec.Status::Inactive then
                        Error('Status must be Active.');

                    if (Rec."Start Alpha Range" <> '') and (Rec."End Alpha Range" <> '') then
                        UpdateOnStudents(false);
                end;
            }

            action("Overwrite on Students")
            {
                Caption = 'Overwrite on Students';
                ShortcutKey = 'Ctrl+W';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = OverdueEntries;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF not Confirm('Do you want to Overwrite %1 on Students?', true, Rec.Role) then
                        exit;

                    IF Rec.Status = Rec.Status::Inactive then
                        Error('Status must be Active.');

                    if (Rec."Start Alpha Range" <> '') and (Rec."End Alpha Range" <> '') then
                        UpdateOnStudentsOverwrite(false);
                end;
            }
            action("View Mapped Students")
            {
                ApplicationArea = All;
                Caption = 'View Mapped Students';
                ShortcutKey = 'Ctrl+M';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapDimensions;

                trigger OnAction()
                begin
                    //ViewStudentsWithUserList();//GMCSCOM
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ClinicalCoordinatorPlanning: Record "Clinical Coordinator Planning";
    begin
        ClinicalCoordinatorPlanning.Reset();
        if ClinicalCoordinatorPlanning.FindLast() then;

        Rec."Entry No." := ClinicalCoordinatorPlanning."Entry No." + 1;
    end;

    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // begin
    //     UpdateOnStudents(true);
    // end;

    procedure UpdateOnStudents(OnClosePage: Boolean)
    Var
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentValidity: Boolean;
        W: Dialog;
        Text001Lbl: Label 'Students     ############1################\';
        T: Integer;
        I: Integer;
    begin
        I := 0;

        IF Rec.Status = Rec.Status::Inactive then
            exit;

        if (Rec."Start Alpha Range" = '') OR (Rec."End Alpha Range" = '') then
            exit;

        GetClerkshipSemesterFilter();

        W.Open('Updating Coordinators..\' + Text001Lbl);
        StudentMaster.Reset();
        StudentMaster.SetFilter("Last Name", '%1..%2', Rec."Start Alpha Range" + '*', Rec."End Alpha Range" + '*');
        StudentMaster.SetFilter(Semester, SemesterFilter);
        if StudentMaster.FindSet() then begin
            T := StudentMaster.Count;
            repeat
                W.Update(1, Format(I) + ' of ' + Format(T));

                StudentStatus.Reset();
                if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                StudentValidity := false;
                if (StudentStatus.Status in
                [StudentStatus.Status::Graduated]) then
                    StudentValidity := false;

                if StudentValidity = true then begin
                    if (Rec.Role = Rec.Role::"Document Specialist") and (StudentMaster."Document Specialist" <> '') then
                        IF StudentMaster."Document Specialist" <> '' then begin
                            StudentMaster."Document Specialist" := Rec."User ID";
                            StudentMaster.Modify(true);
                            //UpdateDocumentSpecialist(StudentMaster);
                            I += 1;
                        end;

                    if (Rec.Role = Rec.Role::"FM1/IM1 Coordinator") and (StudentMaster."FM1/IM1 Coordinator" <> '') then
                        IF StudentMaster."FM1/IM1 Coordinator" = '' then begin
                            StudentMaster."FM1/IM1 Coordinator" := Rec."User ID";
                            StudentMaster.Modify(true);
                            //UpdateFMIMCoordinator(StudentMaster);
                            I += 1;
                        end;

                    if (Rec.Role = Rec.Role::"Clerkship Coordinator") and (StudentMaster."Clinical Coordinator" <> '') then
                        IF StudentMaster."Clinical Coordinator" <> '' then begin
                            StudentMaster."Clinical Coordinator" := Rec."User ID";
                            StudentMaster.Modify(true);
                            //UpdateClinicalCoordinator(StudentMaster);
                            I += 1;
                        end;
                end;
            until StudentMaster.Next() = 0;
        end;

        if OnClosePage = false then
            Message('%1 Mapping updated on %2 Student(s) Successfully.', Rec.Role, I);
    end;

    var
        SemesterFilter: Code[2048];

    procedure UpdateOnStudentsOverwrite(OnClosePage: Boolean)
    Var
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentValidity: Boolean;
        W: Dialog;
        Text001Lbl: Label 'Students     ############1################\';
        T: Integer;
        I: Integer;
    begin
        I := 0;

        IF Rec.Status = Rec.Status::Inactive then
            exit;

        if (Rec."Start Alpha Range" = '') OR (Rec."End Alpha Range" = '') then
            exit;

        GetClerkshipSemesterFilter();

        W.Open('Updating Coordinators..\' + Text001Lbl);
        StudentMaster.Reset();
        StudentMaster.SetFilter("Last Name", '%1..%2', Rec."Start Alpha Range" + '*', Rec."End Alpha Range" + '*');
        StudentMaster.SetFilter(Semester, SemesterFilter);
        if StudentMaster.FindSet() then begin
            T := StudentMaster.Count;
            repeat
                W.Update(1, Format(I) + ' of ' + Format(T));

                StudentStatus.Reset();
                if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                StudentValidity := true;
                if (StudentStatus.Status in
                [StudentStatus.Status::Graduated]) then
                    StudentValidity := false;

                if StudentValidity = true then begin
                    if Rec.Role = Rec.Role::"Document Specialist" then begin
                        StudentMaster."Document Specialist" := Rec."User ID";
                        StudentMaster.Modify();
                        //UpdateDocumentSpecialist(StudentMaster);
                        I += 1;
                    end;
                    if Rec.Role = Rec.Role::"FM1/IM1 Coordinator" then begin
                        StudentMaster."FM1/IM1 Coordinator" := Rec."User ID";
                        StudentMaster.Modify();
                        //UpdateFMIMCoordinator(StudentMaster);
                        I += 1;
                    end;

                    if Rec.Role = Rec.Role::"Clerkship Coordinator" then begin
                        StudentMaster."Clinical Coordinator" := Rec."User ID";
                        StudentMaster.Modify();
                        //UpdateClinicalCoordinator(StudentMaster);
                        I += 1;
                    end;
                end;
            until StudentMaster.Next() = 0;
        end;

        if OnClosePage = false then
            Message('%1 mapping Updated on %2 Student(s) successfully.', Rec.Role, I);
    end;

    procedure UpdateDocumentSpecialist(StudentMaster: Record "Student Master-CS")
    var
        StudentClinicalDocuments: Record "Student Document Attachment";
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        StudentClinicalDocuments.Reset();
        StudentClinicalDocuments.SetCurrentKey("Student No.", "Document Category");
        StudentClinicalDocuments.SetRange("Student No.", StudentMaster."No.");
        StudentClinicalDocuments.SetRange("Document Category", 'CLINICAL');
        if StudentClinicalDocuments.FindSet() then
            repeat
                StudentClinicalDocuments."Document Specialist ID" := StudentMaster."Document Specialist";
                StudentClinicalDocuments.Modify();
            until StudentClinicalDocuments.Next() = 0;

        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.");
        RosterSchedulingLine.SetRange("Student No.", StudentMaster."No.");
        RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Completed);
        if RosterSchedulingLine.FindSet() then
            repeat
                RosterSchedulingLine."Document Specialist ID" := StudentMaster."Document Specialist";
                RosterSchedulingLine.Modify();
            until RosterSchedulingLine.Next() = 0;
    end;

    procedure UpdateFMIMCoordinator(StudentMaster: Record "Student Master-CS")
    var
        RosterSchedulingLine: Record "Roster Scheduling Line";
        ClerkshipSiteAndDateSelection: Record ClerkshipSiteAndDateSelection;
    begin
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.");
        RosterSchedulingLine.SetRange("Student No.", StudentMaster."No.");
        RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type"::"FM1/IM1");
        RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Completed);
        if RosterSchedulingLine.FindSet() then
            repeat
                RosterSchedulingLine."Coordinator ID" := StudentMaster."FM1/IM1 Coordinator";
                RosterSchedulingLine.Modify();
            until RosterSchedulingLine.Next() = 0;

        ClerkshipSiteAndDateSelection.Reset();
        ClerkshipSiteAndDateSelection.SetCurrentKey("Student No.");
        ClerkshipSiteAndDateSelection.SetRange("Student No.", StudentMaster."No.");
        ClerkshipSiteAndDateSelection.SetFilter(Status, '<>%1', ClerkshipSiteAndDateSelection.Status::Completed);
        if ClerkshipSiteAndDateSelection.FindSet() then
            repeat
                ClerkshipSiteAndDateSelection."FM1/IM1 Coordinator" := StudentMaster."FM1/IM1 Coordinator";
                ClerkshipSiteAndDateSelection.Modify();
            until ClerkshipSiteAndDateSelection.Next() = 0;
    end;

    procedure UpdateClinicalCoordinator(StudentMaster: Record "Student Master-CS")
    Var
        RosterSchedulingLine: Record "Roster Scheduling Line";
    begin
        RosterSchedulingLine.Reset();
        RosterSchedulingLine.SetCurrentKey("Student No.");
        RosterSchedulingLine.SetRange("Student No.", StudentMaster."No.");
        RosterSchedulingLine.SetFilter("Clerkship Type", '<>%1', RosterSchedulingLine."Clerkship Type"::"FM1/IM1");
        RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Completed);
        if RosterSchedulingLine.FindSet() then
            repeat
                RosterSchedulingLine."Coordinator ID" := StudentMaster."Clinical Coordinator";
                RosterSchedulingLine.Modify();
            until RosterSchedulingLine.Next() = 0;
    end;

    procedure GetClerkshipSemesterFilter()
    var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then begin
            EducationSetup.TestField("FM1/IM1 Semester Filter");
            EducationSetup.TestField("Clerkship Semester Filter");
        end;

        SemesterFilter := EducationSetup."FM1/IM1 Semester Filter" + '|' + EducationSetup."Clerkship Semester Filter";
    end;
}