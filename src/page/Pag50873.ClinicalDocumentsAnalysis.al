page 50873 "Clinical Documents Analysis"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Document Attachment";
    SourceTableView = where("Document Category" = filter('CLINICAL'), "SLcM Document No" = filter('CLINICAL_DOCUMENTS'));
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Clinical Documents Analysis';

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
                    //OptionCaption = 'My Documents,All Documents';
                    trigger OnValidate()
                    var
                        WindowDialog: Dialog;
                        Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
                    begin
                        WindowDialog.Open('Applying filters Accordingly...\' + Text001Lbl);
                        Rec.Reset();
                        Rec.FilterGroup(2);
                        Rec.SetRange("Document Category", 'CLINICAL');
                        Rec.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                        if AnalysisType = AnalysisType::"My Documents" then
                            Rec.SetRange("Document Specialist ID", UserId);
                        Rec.FilterGroup(0);
                        WindowDialog.Close();
                        CurrPage.Update(true);
                    end;
                }
                field(SelectedOptionTxt; SelectedOptionTxt)
                {
                    ShowCaption = false;
                    Style = Favorable;
                    Editable = false;
                }
            }
            repeater(Rows)
            {
                Editable = false;
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Email"; Rec."Student Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Due"; Rec."Document Due")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Validity Start Date"; Rec."Validity Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Specialist ID"; Rec."Document Specialist ID")
                {
                    ApplicationArea = All;
                }
                field("Reject Reason Code"; Rec."Reject Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Verified On"; Rec."Verified On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Document")
            {
                ApplicationArea = All;
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = TRUE;
                Image = DocInBrowser;
                trigger OnAction();
                var
                    CompanyInfo: Record "Company Information";
                    StudentMaster: Record "Student Master-CS";
                    StudentNo: Code[20];
                    PostUrl: Text;
                begin
                    CompanyInfo.Reset();
                    if CompanyInfo.Get() then;

                    if Rec."Transaction No." <> '' then begin
                        CompanyInfo.TestField("SchoolDocs Download Url");
                        PostUrl := CompanyInfo."SchoolDocs Download Url";
                        PostUrl := PostUrl + Rec."Transaction No.";
                        Hyperlink(PostUrl);
                    end
                    else begin
                        StudentMaster.Reset();
                        if StudentMaster.Get(Rec."Student No.") then;

                        if StudentMaster."Creation Date" < 20210410D then begin
                            if StudentMaster."Original Student No." <> '' then
                                StudentNo := StudentMaster."Original Student No."
                            else
                                StudentNo := StudentMaster."No.";
                        end
                        else
                            StudentNo := StudentMaster."No.";

                        CompanyInfo.TestField("SchoolDocs Documents Open Url");
                        PostUrl := CompanyInfo."SchoolDocs Documents Open Url";
                        PostUrl := PostUrl + StudentNo;

                        Hyperlink(PostUrl);
                    end;
                end;
            }
            action("Clear Filter")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Restore;
                trigger OnAction();
                var
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
                begin
                    SelectedOptionTxt := 'No Filter Applied';
                    WindowDialog.Open('Restoring List of Documents...\' + Text001Lbl);

                    Rec.Reset();
                    Rec.FilterGroup(2);
                    Rec.SetRange("Document Category", 'CLINICAL');
                    Rec.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    if AnalysisType = AnalysisType::"My Documents" then
                        Rec.SetRange("Document Specialist ID", UserId);
                    Rec.FilterGroup(0);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }
            action("Verified Documents")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction();
                var
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
                begin
                    SelectedOptionTxt := 'Verified Documents';
                    WindowDialog.Open('Checking Verified Clinical Documents...\' + Text001Lbl);
                    Rec.Reset();
                    Rec.FilterGroup(2);
                    Rec.SetRange("Document Category", 'CLINICAL');
                    Rec.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    Rec.SetRange("Document Status", Rec."Document Status"::"On File");
                    if AnalysisType = AnalysisType::"My Documents" then
                        Rec.SetRange("Document Specialist ID", UserId);
                    Rec.FilterGroup(0);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }
            action("Submitted Documents")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CompleteLine;
                trigger OnAction();
                var
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
                begin
                    SelectedOptionTxt := 'Submitted Documents';
                    WindowDialog.Open('Checking Submitted Clinical Documents...\' + Text001Lbl);
                    Rec.Reset();
                    Rec.FilterGroup(2);
                    Rec.SetRange("Document Category", 'CLINICAL');
                    Rec.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    Rec.SetRange("Document Status", Rec."Document Status"::"Portal Submitted");
                    if AnalysisType = AnalysisType::"My Documents" then
                        Rec.SetRange("Document Specialist ID", UserId);
                    Rec.FilterGroup(0);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }
            action("Expiring Documents")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EndingText;
                trigger OnAction();
                var
                    ExpiringUptoDate: Date;
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
                begin
                    SelectedOptionTxt := 'Expiring Documents';
                    ExpiringUptoDate := WorkDate() + 45;
                    WindowDialog.Open('Checking Expiring Documents...\' + Text001Lbl);
                    Rec.FilterGroup(2);
                    Rec.SetRange("Document Category", 'CLINICAL');
                    Rec.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    Rec.SetFilter("Expiry Date", '%1..%2', WorkDate(), ExpiringUptoDate);
                    if AnalysisType = AnalysisType::"My Documents" then
                        Rec.SetRange("Document Specialist ID", UserId);
                    Rec.FilterGroup(0);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }
            action("Due Documents")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DueDate;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                    EducationSetup: Record "Education Setup-CS";
                    UserSetup: Record "User Setup";
                    CLNBuffer: Record "CLN Required Document Buffer";
                    ClinicalSemester: Code[1024];
                    DueUptoDate: Date;
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
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

                    DueUptoDate := WorkDate() + 45;
                    CLNBuffer.Reset();
                    CLNBuffer.SetRange("User ID", UserId);
                    if CLNBuffer.FindFirst() then
                        repeat
                            CLNBuffer.Delete();
                        until CLNBuffer.Next() = 0;

                    WindowDialog.Open('Checking Documents Due...\' + Text001Lbl);
                    StudentMaster.Reset();
                    if AnalysisType = AnalysisType::"My Documents" then
                        StudentMaster.SetFilter("Document Specialist", UserId);
                    StudentMaster.SetFilter(Semester, ClinicalSemester);
                    if StudentMaster.FindSet() then
                        repeat
                            WindowDialog.Update(1, Rec."Student Name" + ' - ' + StudentMaster."Student Name");
                            CLNBuffer.UpdateRecords(StudentMaster, DueUptoDate);
                        until StudentMaster.Next() = 0;

                    WindowDialog.Close();

                    CLNBuffer.Reset();
                    CLNBuffer.FilterGroup(2);
                    CLNBuffer.SetRange("User ID", UserId);
                    CLNBuffer.FilterGroup(0);
                    Page.Run(Page::"STD Clinical Required Document", CLNBuffer)
                end;
            }
            action("Expired Documents")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DeleteExpiredComponents;
                trigger OnAction();
                var
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Clinical Document Analysis      ############1################\';
                begin
                    SelectedOptionTxt := 'Expired Documents';
                    WindowDialog.Open('Checking Expiring Documents...\' + Text001Lbl);
                    Rec.FilterGroup(2);
                    Rec.SetRange("Document Category", 'CLINICAL');
                    Rec.SetRange("SLcM Document No", 'CLINICAL_DOCUMENTS');
                    Rec.SetFilter("Document Status", '%1', Rec."Document Status"::Expired);
                    if AnalysisType = AnalysisType::"My Documents" then
                        Rec.SetRange("Document Specialist ID", UserId);
                    Rec.FilterGroup(0);
                    WindowDialog.Close();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        AnalysisType: Option "My Documents","All Documents";
        SelectedOptionTxt: Text;

    trigger OnOpenPage()
    begin
        SelectedOptionTxt := 'No Filter Applied';
        CurrPage.Editable := true;
    end;
}