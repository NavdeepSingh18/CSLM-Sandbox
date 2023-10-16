page 50094 "View Students Group"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Student Master-CS";
    Caption = 'View Student''s Group';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Filter Students in Group")
            {
                field(GroupCode; GroupCode)
                {
                    ApplicationArea = All;
                    Caption = 'Group Code';
                    ShowMandatory = true;
                    Style = Unfavorable;
                    TableRelation = "Group".Code where("Group Type" = const(Clinical));

                    trigger OnValidate()
                    var
                        LGroup: Record "Group";
                    begin
                        GroupDescription := '';
                        LGroup.Reset();
                        if LGroup.Get(GroupCode) then
                            GroupDescription := LGroup.Description;

                        if GroupCode <> '' then
                            ViewGroupStudent()
                        else
                            ClearFilters();
                    end;
                }
                field(GroupDescription; GroupDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Group Description';
                    Style = Unfavorable;
                    Editable = false;
                    MultiLine = true;
                }
            }
            repeater("Students")
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
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
                field("Spcl Accommodation Appln"; Rec."Spcl Accommodation Appln")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part("Student Clinical Group Facbox"; "Student Clinical Group Facbox")
            {
                ApplicationArea = All;
                Caption = 'Clinical Group Details';
                SubPageLink = "Student No." = field("No.");
            }
            // part("Notes Factbox"; "Notes Factbox")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Notes';
            //     SubPageLink = "Source No." = field("No.");
            //     SubPageView = where("Template Type" = filter("Clinical Clerkship"));
            // }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View Groups")
            {
                ApplicationArea = All;
                Caption = 'View Groups';
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentGroup: Record "Student Group";
                begin
                    StudentGroup.Reset();
                    StudentGroup.FilterGroup(2);
                    StudentGroup.SetRange("Student No.", Rec."No.");
                    StudentGroup.SetRange(Blocked, false);
                    StudentGroup.FilterGroup(0);
                    Page.RunModal(Page::"Student Clinical Group List", StudentGroup);
                end;
            }
            action("Update Student Group")
            {
                ApplicationArea = All;
                Caption = 'Update Student Group';
                Image = IndustryGroups;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    UpdateStudentsGroup: Page "Update Students Group";
                begin
                    CurrPage.SetSelectionFilter(StudentMaster);
                    Clear(UpdateStudentsGroup);
                    UpdateStudentsGroup.SetTableView(StudentMaster);
                    UpdateStudentsGroup.Editable(true);
                    UpdateStudentsGroup.RunModal();
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
                    RSL.SetFilter(Status, '%1', RSL.Status::Published);
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
                    GroupCode := '';
                    GroupDescription := '';
                    ClearFilters();
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

    trigger OnOpenPage()
    begin
        ClearFilters();
    end;

    procedure ClearFilters()
    var
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        ClinicalSemester: Code[1024];
    begin
        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

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
    end;

    procedure ViewGroupStudent()
    var
        StudentGroup: Record "Student Group";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        ClearFilters();
        Rec.FindSet();
        repeat
            WindowDialog.Open('Checking Students.....\' + Text001Lbl);
            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

            StudentGroup.Reset();
            StudentGroup.SetRange("Student No.", Rec."No.");
            StudentGroup.SetRange("Groups Code", GroupCode);
            StudentGroup.SetRange(Blocked, false);
            if StudentGroup.FindFirst() then
                Rec.Mark(true)
            else
                Rec.Mark(false);
        until Rec.Next() = 0;

        WindowDialog.Close();
        Rec.MarkedOnly(true);
        CurrPage.Update(false);
    end;

    var
        GroupCode: Code[20];
        GroupDescription: Text[50];
}