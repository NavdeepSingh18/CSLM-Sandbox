page 50867 "Clinical Document Updation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    Caption = 'Clinical Document Updation';
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
                    //StyleExpr = LStyle;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    //StyleExpr = LStyle;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    //StyleExpr = LStyle;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Document Specialist"; Rec."Document Specialist")
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
                    Editable = false;
                }
                field("Spcl Accommodation Appln"; Rec."Spcl Accommodation Appln")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Clinical Document Status"; Rec."Clinical Document Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Exception Flag"; Rec."Document Exception Flag")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Titer Exception Flag"; Rec."Titer Exception Flag")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Credential Date"; Rec."Credential Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Clinical Documents to Validate"; Rec."Clinical Documents to Validate")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
            }
        }
        area(FactBoxes)
        {
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
            action("Upload Document")
            {
                ApplicationArea = All;
                Caption = 'Upload Document';
                Image = ImportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Doc_CateAttachment: Record "Doc & Cate Attachment-CS";
                    CLNListofDocsforUpload: Page "CLN List of Docs for Upload";
                begin
                    Doc_CateAttachment.Reset();
                    Doc_CateAttachment.FilterGroup(2);
                    Doc_CateAttachment.SetRange("Document Type", 'CLINICAL');
                    Doc_CateAttachment.SetRange(Blocked, false);
                    Doc_CateAttachment.FilterGroup(0);
                    Clear(CLNListofDocsforUpload);
                    CLNListofDocsforUpload.SetVariables(Rec."No.", Rec."Student Name", Rec.Semester, Rec."Academic Year");
                    CLNListofDocsforUpload.SetTableView(Doc_CateAttachment);
                    CLNListofDocsforUpload.RunModal();
                end;
            }

            action("Validate Documents")
            {
                ApplicationArea = All;
                Caption = 'Validate Documents';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SDA: Record "Student Document Attachment";
                begin
                    SDA.Reset();
                    SDA.FilterGroup(2);
                    SDA.SetRange("Student No.", Rec."No.");
                    SDA.Setfilter("Document Status", '<>%1', SDA."Document Status"::"On File");
                    SDA.SetRange("Document Category", 'CLINICAL');
                    SDA.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    SDA.FilterGroup(0);
                    Page.RunModal(PAGE::"Validate Clinical Documents", SDA);
                end;
            }
            action("Enable Titer Flag")
            {
                ApplicationArea = All;
                Caption = 'Enable Titer Flag';
                Image = ExecuteAndPostBatch;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not Confirm('Do you want to Enable Titer Exeption Flag On the Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    Rec."Titer Exception Flag" := true;
                    CALE.InsertLogEntry(10, 21, Rec."No.", Rec."Student Name", 'TITER EXCEPTION ON', '', '', '', '');
                    Rec.Modify();
                end;
            }
            action("Enable Document Exception Flag")
            {
                ApplicationArea = All;
                Caption = 'Enable Document Exception Flag';
                Image = ExecuteAndPostBatch;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not Confirm('Do you want to Enable Document Exception Flag On the Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    Rec."Document Exception Flag" := true;
                    CALE.InsertLogEntry(10, 17, Rec."No.", Rec."Student Name", 'DOCUMENT EXCEPTION ON', '', '', '', '');
                    Rec.Modify();
                end;
            }
            action("Document Status Complete")
            {
                ApplicationArea = All;
                Caption = 'Document Status Complete';
                Image = Completed;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    SDA: Record "Student Document Attachment";
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                    CredentialDate: Date;
                begin
                    if not Confirm('Do you want to Complete the Document Status for the Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    //CheckDocumentOnCompletion();

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."No.") then
                        StudentMaster.CalcFields("Clinical Documents to Validate");

                    if (StudentMaster."Clinical Documents to Validate" > 0)
                    and (Rec."Document Exception Flag" = false) then
                        Error('All Document(s) are not Verified for Student No. - %1 (%2) In this case to Complete the Documents Status you must enable "Document Exeption flag".', Rec."No.", Rec."Student Name");

                    CredentialDate := 0D;
                    if Date2DMY(WorkDate(), 1) <= 15 then
                        CredentialDate := DMY2Date(15, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3))
                    else
                        if Date2DMY(WorkDate(), 2) <> 2 then
                            CredentialDate := DMY2Date(30, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3))
                        else
                            CredentialDate := DMY2Date(28, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));

                    SDA.Reset();
                    SDA.SetCurrentKey("Student No.");
                    SDA.SetRange("Student No.", Rec."No.");
                    SDA.SetFilter("Document Status", '%1|%2|%3|%4|%5|%6|%7|%8|%9',
                    SDA."Document Status"::"Portal Submitted", SDA."Document Status"::"Pending for Verification", SDA."Document Status"::Submitted,
                    SDA."Document Status"::"Under Review", SDA."Document Status"::DRNYC, SDA."Document Status"::DROC, SDA."Document Status"::RESUBMIT,
                    SDA."Document Status"::SENT, SDA."Document Status"::UREVIEW);
                    if SDA.FindSet() then
                        repeat
                            SDA."Document Status Completed" := true;
                            SDA.Modify();
                        until SDA.Next() = 0;

                    Rec."Credential Date" := CredentialDate;
                    Rec."Clinical Document Status" := Rec."Clinical Document Status"::Completed;
                    Rec.Modify();

                    CALE.InsertLogEntry(10, 19, Rec."No.", Rec."Student Name", 'DOCUMENTATION COMPLETE', '', '', '', '');

                    // if Rec."Document Exception Flag" then
                    //     ClinicalNotification.YourClinicalPacketisNowConditionallyComplete(Rec."No.");

                    Message('Document Status of Student No. %1 (%2) has Completed.', Rec."No.", Rec."Student Name");
                end;
            }
            action("Document Status Incomplete")
            {
                ApplicationArea = All;
                Caption = 'Document Status Incomplete';
                Image = PlannedOrder;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not Confirm('Do you want to Update Document Status to Incomplete for the Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    Rec."Clinical Document Status" := Rec."Clinical Document Status"::" ";
                    Rec."Titer Exception Flag" := false;
                    Rec."Document Exception Flag" := false;
                    Rec."Credential Date" := 0D;
                    CALE.InsertLogEntry(10, 18, Rec."No.", Rec."Student Name", 'DOCUMENTATION EXCEPTION OFF', '', '', '', '');
                    CALE.InsertLogEntry(10, 20, Rec."No.", Rec."Student Name", 'DOCUMENTATION INCOMPLETE', '', '', '', '');
                    Rec.Modify();
                    Message('Document Status of Student No. %1 (%2) has Updated to Incompleted.', Rec."No.", Rec."Student Name");
                end;
            }

            action("Disable Titer Flag")
            {
                ApplicationArea = All;
                Caption = 'Disable Titer Flag';
                Image = DisableAllBreakpoints;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not Confirm('Do you want to Disable Titer Exeption Flag On the Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    if Rec."Clinical Document Status" = Rec."Clinical Document Status"::Completed then
                        Error('Clinical Document Status must not be completed.');

                    Rec."Titer Exception Flag" := false;
                    CALE.InsertLogEntry(10, 22, Rec."No.", Rec."Student Name", 'TITER EXCEPTION OFF', '', '', '', '');
                    Rec.Modify();
                end;
            }
            action("Disable Document Exception Flag")
            {
                ApplicationArea = All;
                Caption = 'Disable Document Exception Flag';
                Image = ExecuteAndPostBatch;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if not Confirm('Do you want to Disable Document Exception Flag On the Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    Rec."Document Exception Flag" := false;
                    CALE.InsertLogEntry(10, 18, Rec."No.", Rec."Student Name", 'DOCUMENT EXCEPTION OFF', '', '', '', '');
                    Rec.Modify();
                end;
            }
            action("Update Document Status")
            {
                ApplicationArea = All;
                Caption = 'Update Document Status';
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentDocumentAttachment: Record "Student Document Attachment";
                begin
                    StudentDocumentAttachment.Reset();
                    StudentDocumentAttachment.FilterGroup(2);
                    StudentDocumentAttachment.SetRange("Student No.", Rec."No.");
                    StudentDocumentAttachment.FilterGroup(0);
                    Page.RunModal(Page::"Student Clinical Documents+", StudentDocumentAttachment);
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

            action("Put on Clinical Hold")
            {
                ApplicationArea = All;
                Caption = 'Put on Clinical Hold';
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."No.");
                    StudentMaster.FilterGroup(0);
                    Page.RunModal(Page::"Clinical Hold Reason Input", StudentMaster);
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
                    StudentNo: Code[20];
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    if Rec."Creation Date" < 20210410D then begin
                        if Rec."Original Student No." <> '' then
                            StudentNo := Rec."Original Student No."
                        else
                            StudentNo := Rec."No.";
                    end
                    else
                        StudentNo := Rec."No.";

                    CompanyInfo.TestField("SchoolDocs Documents Open Url");
                    PostUrl := CompanyInfo."SchoolDocs Documents Open Url";
                    PostUrl := PostUrl + StudentNo;
                    Hyperlink(PostUrl);
                end;
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Card;
                // PromotedOnly = true;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F5';
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
        }
    }

    Var
        LStyle: Text[100];

    trigger OnOpenPage()
    var
        EducationSetup: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        ClinicalSemester: Code[1024];
        ActiveStatusFilter: Text;
    begin
        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        ActiveStatusFilter := '';
        //ActiveStatusFilter := EducationSetup."Active Statuses" + '|PGR';
        ActiveStatusFilter := EducationSetup."View/Update Doc";

        if EducationSetup."FM1/IM1 Semester Filter" <> '' then
            ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        if EducationSetup."Clerkship Semester Filter" <> '' then
            ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        Rec.FilterGroup(2);
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.SetFilter(Status, ActiveStatusFilter);
        Rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    begin
        LStyle := '';
        if Rec."Clinical Documents to Validate" > 0 then
            LStyle := 'Unfavorable';
    end;

    procedure CheckDocumentOnCompletion()
    var
        DocCat: Record "Doc & Cate Attachment-CS";
        SDA: Record "Student Document Attachment";
        TiterDocumentPending: Boolean;
        NonTiterDocumentPending: Boolean;
        I: Integer;
        Char10: Char;
        Char13: Char;
        NewLine: Text[10];
        WindowDialog: Dialog;
        Text001Lbl: Label 'Document      ############1################\';
    begin
        Char10 := 10;
        Char13 := 13;
        NewLine := format(Char10) + format(Char13);

        WindowDialog.Open('Checking Documents..\' + Text001Lbl);

        I := 0;
        TiterDocumentPending := false;
        NonTiterDocumentPending := false;

        DocCat.Reset();
        DocCat.SetRange("Document Type", 'CLINICAL');
        DocCat.SetRange(Blocked, false);
        DocCat.SetFilter(Responsibility, '%1|%2', DocCat.Responsibility::Student, DocCat.Responsibility::University);
        if DocCat.FindSet() then
            repeat
                WindowDialog.Update(1, DocCat.Description);
                SDA.Reset();
                SDA.SetCurrentKey("Document Category", "Document Sub Category", "Student No.");
                SDA.SetRange("Student No.", Rec."No.");
                SDA.SetRange("Document Category", 'CLINICAL');
                SDA.SetRange("Document Sub Category", DocCat.Code);
                IF not SDA.FindFirst() then begin
                    I += 1;
                    if DocCat."Titer Flag Applicable" then
                        TiterDocumentPending := true
                    else
                        NonTiterDocumentPending := true;
                end;

                SDA.Reset();
                SDA.SetCurrentKey("Document Category", "Document Sub Category", "Student No.");
                SDA.SetRange("Document Category", 'CLINICAL');
                SDA.SetRange("Document Sub Category", DocCat.Code);
                SDA.SetRange("Student No.", Rec."No.");
                SDA.SetFilter("Document Status", '%1|%2', SDA."Document Status"::Expired, SDA."Document Status"::Rejected);
                IF SDA.FindFirst() then begin
                    I += 1;
                    if DocCat."Titer Flag Applicable" then
                        TiterDocumentPending := true
                    else
                        NonTiterDocumentPending := true;
                end;
            until DocCat.Next() = 0;

        if (I > 0) and (Rec."Titer Exception Flag" = false) and (TiterDocumentPending = true) then
            Error('Titer Document(s) are not Verified for Student No. - %1 (%2) In this case to Complete the Documents Status you must enable "Titer Exeption flag".', Rec."No.", Rec."Student Name");

        if (I > 0) and (Rec."Document Exception Flag" = false) and (NonTiterDocumentPending = true) then
            Error('All Document(s) are not Verified for Student No. - %1 (%2) In this case to Complete the Documents Status you must enable "Document Exeption flag".', Rec."No.", Rec."Student Name");
    end;
}