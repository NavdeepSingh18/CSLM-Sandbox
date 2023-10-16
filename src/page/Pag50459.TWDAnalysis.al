page 50459 "TWD Analysis"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    Caption = 'TWD Analysis';
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Clinical Curriculum"; Rec."Clinical Curriculum")
                {
                    ApplicationArea = All;
                }
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Start Date"; Rec."FM1/IM1 Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FM1/IM1 Start Date field.';
                }
            }
        }
        // area(FactBoxes)
        // {
        //     part("Rotation Count"; "Rotation Count")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Rotation Count';
        //         SubPageLink = "No." = field("No.");
        //     }
        // }
    }
    actions
    {
        area(Processing)
        {
            action("TWD Analysis")
            {
                ApplicationArea = All;
                Caption = 'TWD Analysis';
                Image = MailAttachment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    ClearFilters();
                    MarkTWDStudents();
                end;
            }
            action("Change Status to TWD")
            {
                ApplicationArea = All;
                Caption = 'Change Status to TWD';
                Image = "Invoicing-New";
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalProcessJobQueqe: Codeunit "Clinical Process Job Queqe";
                    I: Integer;
                    TWDApplicableCount: Integer;
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    I := Rec.Count;
                    if Not confirm('You have Selected %1 Students.\\\\Do you want to put change Status as TWD?', true, I) then
                        exit;

                    WindowDialog.Open('Updating Status to TWD..\' + Text001Lbl);
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");

                            ClinicalProcessJobQueqe.TWDAnalysis(Rec."No.", false, true, TWDApplicableCount);
                        until Rec.Next() = 0;

                    Message('%1 Student''s Status Changed to TWD.', TWDApplicableCount);
                end;
            }

            action("Students On TWD Status")
            {
                ApplicationArea = All;
                Caption = 'Students On TWD Status';
                Image = ShowWarning;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentStatus: Record "Student Status";
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Clearing Filters..\' + Text001Lbl);
                    Rec.Reset();
                    Rec.SetFilter("Course Code", ClinicalCourse);
                    Rec.SetFilter(Semester, ClinicalSemester);
                    if Rec.FindSet() then
                        repeat
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                            StudentStatus.Reset();
                            StudentStatus.SetRange(Code, Rec.Status);
                            if StudentStatus.FindFirst() then;

                            if StudentStatus.Status = StudentStatus.Status::TWD then
                                Rec.Mark(true);
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
                    ClearFilters();
                end;
            }
        }
    }

    var
        EducationSetup: Record "Education Setup-CS";
        ClinicalSemester: Code[1024];
        ClinicalCourse: Code[2048];

    trigger OnOpenPage()
    var
        CourseMaster: Record "Course Master-CS";
    begin
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

        MarkTWDStudents();
    end;

    procedure ClearFilters()
    var
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
    begin
        WindowDialog.Open('Clearing Filters..\' + Text001Lbl);

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
                Rec.Mark(true);
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;

    procedure MarkTWDStudents()
    var
        ClinicalProcessJobQueqe: Codeunit "Clinical Process Job Queqe";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Student Name      ############1################\';
        TWDApplicableCount: Integer;
    begin
        WindowDialog.Open('Checking for TWD Status...\' + Text001Lbl);

        Rec.Reset();
        Rec.ClearMarks();
        //SetRange("No.", '400063');
        Rec.SetFilter("Course Code", ClinicalCourse);
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.SetFilter(Status, EducationSetup."Active Statuses");
        if Rec.FindSet() then
            repeat
                WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                if ClinicalProcessJobQueqe.TWDAnalysis(Rec."No.", true, false, TWDApplicableCount) = true then
                    Rec.Mark(true);
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
        WindowDialog.Close();
        CurrPage.Update(false);
    end;
}