page 50935 "Students to Update Notes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    CardPageId = "Student Detail Card-CS";
    Caption = 'View/Update Notes';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group("Option")
            {
                Caption = 'Option';
                field(AnalysisType; AnalysisType)
                {
                    Caption = 'Alpha Range Type';
                    ApplicationArea = All;
                    Style = Favorable;
                    OptionCaption = 'My Students,All Students';
                    trigger OnValidate()
                    var
                        WindowDialog: Dialog;
                        Text001Lbl: Label 'Notes Updation    ############1################\';
                    begin
                        WindowDialog.Open('Applying filters Accordingly...\' + Text001Lbl);
                        FilterRecords();
                    end;
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
                field(Status; Rec.Status)
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
            part("Notes Factbox"; "Notes Factbox")
            {
                ApplicationArea = All;
                Caption = 'Notes';
                SubPageLink = "Source No." = field("No.");
                SubPageView = where("Template Type" = filter("Clinical Clerkship"));
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Clerkship Assessment")
            {
                ApplicationArea = All;
                Caption = 'Clerkship Assessment';
                Image = AdjustItemCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Temporary;
                trigger OnAction()
                var
                    RLE: Record "Roster Ledger Entry";
                Begin
                    RLE.Reset();
                    RLE.FilterGroup(2);
                    RLE.SetRange("Student ID", Rec."No.");
                    RLE.SetRange("Rotation Grade", '');
                    RLE.SetFilter("End Date", '<=%1', Today);
                    RLE.FilterGroup(0);
                    Page.RunModal(Page::"RLE Clerkship Assessment", RLE);
                End;
            }
            action("Published Clerkship Assessment")
            {
                ApplicationArea = All;
                Caption = 'Published Clerkship Assessment';
                Image = AdjustItemCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Temporary;
                trigger OnAction()
                var
                    DocuSignAssessment: Record "DocuSign Assessment Scores";
                Begin
                    DocuSignAssessment.Reset();
                    DocuSignAssessment.FilterGroup(2);
                    DocuSignAssessment.SetRange("Student No.", Rec."No.");
                    DocuSignAssessment.FilterGroup(0);
                    Page.RunModal(Page::"DocuSign Assessment Scores+", DocuSignAssessment);
                End;
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
                    ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."No.", Rec."No.", TemplateType, GroupType);
                end;
            }
            action("Students having Notes")
            {
                ApplicationArea = All;
                Caption = 'Students having Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    EducationSetup: Record "Education Setup-CS";
                    InteractionTemplate: Record "Interaction Template";
                    InteractionGroup: Record "Interaction Group";
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                    ClinicalSemester: Code[1024];
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Checking Students having Notes..\' + Text001Lbl);

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetup.FindFirst() then;

                    if EducationSetup."FM1/IM1 Semester Filter" <> '' then
                        ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

                    if EducationSetup."Clerkship Semester Filter" <> '' then
                        ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

                    InteractionTemplate.Reset();
                    InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::"Clinical Clerkship");
                    IF not InteractionTemplate.FindLast() then
                        Error('Interaction Template not found for Clinical Type.');

                    InteractionGroup.Reset();
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Clinical Clerkship");
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Clinical Type.');

                    Rec.Reset();
                    Rec.FilterGroup(2);
                    Rec.SetFilter(Status, EducationSetup."Active Statuses");
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.FilterGroup(0);
                    IF Rec.FindSet() then
                        repeat
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + Rec."No.");
                            InterLogEntryCommentLine.Reset();
                            InterLogEntryCommentLine.SetRange("Source No.", Rec."No.");
                            InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                            InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                            InterLogEntryCommentLine.SetRange("Student No.", Rec."No.");
                            if InterLogEntryCommentLine.FindFirst() then
                                Rec.Mark(true);
                        until Rec.Next() = 0;

                    Rec.MarkedOnly(true);
                    CurrPage.Update(false);
                    WindowDialog.Close();
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
                var
                    EducationSetup: Record "Education Setup-CS";
                    UserSetup: Record "User Setup";
                    ClinicalSemester: Code[1024];
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Resuming Students..\' + Text001Lbl);

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
                    Rec.FilterGroup(2);
                    Rec.SetFilter(Status, EducationSetup."Active Statuses");
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.FilterGroup(0);
                    CurrPage.Update(true);
                    WindowDialog.Close();
                end;
            }
        }
    }

    var
        AnalysisType: Option "My Documents","All Documents";
        Temporary: Boolean;

    trigger OnOpenPage()
    begin
        FilterRecords();

        Temporary := false;
        if UserId = 'X250\MICROSOFT' then
            Temporary := true;
    end;

    procedure FilterRecords()
    var
        EducationSetup: Record "Education Setup-CS";
        ClinicalSemester: Code[1024];
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        if EducationSetup."FM1/IM1 Semester Filter" <> '' then
            ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        if EducationSetup."Clerkship Semester Filter" <> '' then
            ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        Rec.FilterGroup(2);
        Rec.SetFilter(Semester, ClinicalSemester);
        if (AnalysisType = AnalysisType::"My Documents") then
            Rec.SetRange("Clinical Coordinator", UserId);
        Rec.FilterGroup(0);
        CurrPage.Update(false);
    end;
}