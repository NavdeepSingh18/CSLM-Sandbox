page 50648 "DocuSign Assessment Scores"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DocuSign Assessment Scores";
    SourceTableView = where(Published = filter(False));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    Caption = 'Rotation ID';
                    ApplicationArea = All;

                }
                field("Rotation No."; Rec."Rotation No.")
                {
                    Caption = 'Rotation No.';
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    Caption = 'Course Code';
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    Caption = 'Course Name';
                    ApplicationArea = All;
                }
                field("Course Start Date"; Rec."Course Start Date")
                {
                    Caption = 'Course Start Date';
                    ApplicationArea = All;
                }
                field("Course End Date"; Rec."Course End Date")
                {
                    Caption = 'Course End Date';
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    Caption = 'Hospital Name';
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Student No.';
                    ApplicationArea = All;
                }
                Field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                Field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                }
                field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Status field.';
                }
                field("Patient Care"; Rec."Patient Care")
                {
                    Caption = 'Patient Care';
                    ApplicationArea = All;
                }
                field("Medical Knowledge"; Rec."Medical Knowledge")
                {
                    Caption = 'Medical Knowledge';
                    ApplicationArea = All;
                }
                field("Interpersonal and Comm. Skills"; Rec."Interpersonal and Comm. Skills")
                {
                    Caption = 'Interpersonal and Communication Skills';
                    ApplicationArea = All;
                }
                field("Practice Base Learn and Impro"; Rec."Practice Base Learn and Impro")
                {
                    Caption = 'Practice Base Learning and Improvement';
                    ApplicationArea = All;
                }
                field("System Based Learning"; Rec."System Based Learning")
                {
                    Caption = 'System Based Learning';
                    ApplicationArea = All;
                }
                field("Student Portfolio"; Rec."Student Portfolio")
                {
                    Caption = 'Student Portfolio';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Professionalism; Rec.Professionalism)
                {
                    Caption = 'Professionalism';
                    ApplicationArea = All;
                }
                field("MPSE Comment"; Rec."MPSE Comment")
                {
                    Caption = 'MPSE Comment';
                    ApplicationArea = All;
                }
                field("Assessment Total Score"; Rec."Assessment Total Score")
                {
                    Caption = 'Assessment Total Score';
                    ApplicationArea = All;
                }
                field("Assessment Percentage"; Rec."Assessment Percentage")
                {
                    Caption = 'Assessment Percentage';
                    ApplicationArea = All;
                }
                field("CCSSE Score"; Rec."CCSSE Score")
                {
                    Caption = 'CCSSE Score';
                    ApplicationArea = All;
                }
                field("CCSSE Score II"; Rec."CCSSE Score II")
                {
                    ApplicationArea = All;
                }
                field("CCSSE Score III"; Rec."CCSSE Score III")
                {
                    ApplicationArea = All;
                }
                field("CCSSE Score IV"; Rec."CCSSE Score IV")
                {
                    ApplicationArea = All;
                }
                field("CCSSE Score V"; Rec."CCSSE Score V")
                {
                    ApplicationArea = All;
                }
                field("CCSSE Weightage"; Rec."CCSSE Weightage")
                {
                    Caption = 'CCSSE Score Value';
                    ApplicationArea = All;
                }
                field("Final Percentage"; Rec."Final Percentage")
                {
                    Caption = 'Final Percentage';
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    Caption = 'Grade';
                    ApplicationArea = All;
                }
                field("Manual Grade"; Rec."Manual Grade")
                {
                    Caption = 'Manual Grade';
                    ApplicationArea = All;
                }
                field("Manual Grade Assigned By"; Rec."Manual Grade Assigned By")
                {
                    Caption = 'Manual Grade Assigned By';
                    ApplicationArea = All;
                }
                field("Sent Date Time"; Rec."Sent Date Time")
                {
                    Caption = 'Sent Date Time';
                    ApplicationArea = All;
                }
                field("Delivered Date Time"; Rec."Delivered Date Time")
                {
                    Caption = 'Delivered Date Time';
                    ApplicationArea = All;
                }
                field("Preceptor Signed Date Time"; Rec."Preceptor Signed Date Time")
                {
                    Caption = 'Preceptor Signed Date Time';
                    ApplicationArea = All;
                }
                field("Preceptor Name"; Rec."Preceptor Name")
                {
                    Caption = 'Preceptor Name';
                    ApplicationArea = All;
                }
                field("DME Name"; Rec."DME Name")
                {
                    Caption = 'DME Name';
                    ApplicationArea = All;
                }
                field("DME Signed Date Time"; Rec."DME Signed Date Time")
                {
                    Caption = 'DME Signed Date Time';
                    ApplicationArea = All;
                }
                field("Envelope ID"; Rec."Envelope ID")
                {
                    Caption = 'Envelope ID';
                    ApplicationArea = All;
                }
                field("Form No"; Rec."Form No")
                {
                    Caption = 'Form No';
                    ApplicationArea = All;
                }
            }
        }
    }

    Actions
    {
        Area(Processing)
        {
            Action("Update CCSSE Score & Grade")
            {
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+G';

                Trigger OnAction()
                Var
                    DocuSign: Record "DocuSign Assessment Scores";
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student in Progress      ############1################\';
                    T: Integer;
                begin
                    DocuSign.Reset();
                    CurrPage.SetSelectionFilter(DocuSign);
                    T := DocuSign.Count;

                    if not Confirm('You have selected %1 record for the grade calculation.\Do you want to continue?', true, T) then
                        exit;

                    WindowDialog.Open('Calculating Grades....\' + Text001Lbl);

                    if DocuSign.FindSet() then
                        repeat
                            WindowDialog.Update(1, DocuSign."Student No." + ' - ' + DocuSign."Student Name");
                            DocuSign.CalculateEvalCount_Sum();
                        until DocuSign.Next() = 0;

                    WindowDialog.Close();
                    Message('Grade calculation process completed.');
                end;
            }

            Action(Publish)
            {
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+P';

                trigger OnAction()
                var
                    RLE: Record "Roster Ledger Entry";
                    DocuSign: Record "DocuSign Assessment Scores";
                    StudentTimeLineRec: Record "Student Time Line";
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student in Progress      ############1################\';
                    T: Integer;
                begin
                    DocuSign.Reset();
                    CurrPage.SetSelectionFilter(DocuSign);
                    T := DocuSign.Count;

                    if not Confirm('You have selected %1 record to the publish grade.\Do you want to continue?', true, T) then
                        exit;

                    WindowDialog.Open('Publishing Grades....\' + Text001Lbl);
                    if DocuSign.FindSet() then
                        repeat
                            WindowDialog.Update(1, DocuSign."Student No." + ' - ' + DocuSign."Student Name");
                            if DocuSign.Grade <> '' then begin
                                RLE.Reset();
                                if RLE.Get(DocuSign."Rotation Entry No.") then begin
                                    If DocuSign."Manual Grade" = '' then            //30Nov2022 Navdeep
                                        RLE.Validate("Rotation Grade", DocuSign.Grade)
                                    Else
                                        RLE.Validate("Rotation Grade", Docusign."Manual Grade");
                                    RLE.Modify();
                                    //Timeline Insert Added === 01-09-2021
                                    StudentTimeLineRec.InsertRecordFun(RLE."Student ID", RLE."Student Name", 'For ' + RLE."Course Description" + ' Grade has been assigned to ' + RLE."Rotation Grade", UserId(), Today());
                                    //Timeline Insert Added === 01-09-2021
                                    DocuSign.Published := true;
                                    DocuSign."Published By" := UserId;
                                    DocuSign."Published On" := Today;
                                    DocuSign.Modify();
                                end;
                            end;
                        until DocuSign.Next() = 0;

                    WindowDialog.Close();
                    Message('Grade publish process completed.');
                end;
            }
            Action("Clerkship Grade Revision")
            {
                ApplicationArea = All;
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+G';
                Caption = 'Clerkship Grade Revision';
                trigger OnAction()
                var
                    DocuSign: Record "DocuSign Assessment Scores";
                begin
                    if Rec."Clerkship Type" <> Rec."Clerkship Type"::Core then
                        Error('Revision is only applicable in case of Core Rotation.');

                    if not Confirm('Do you want to Revise Grade of the Student No. %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        Exit;

                    DocuSign.Reset();
                    DocuSign.SetRange("Rotation ID", Rec."Rotation ID");
                    DocuSign.SetRange("Rotation No.", Rec."Rotation No.");
                    DocuSign.SetRange("Student No.", Rec."Student No.");
                    // Page.RunModal(Page::"Clerkship Assessment Revision", DocuSign);
                end;
            }
            Action("Assign Manual Grade")
            {
                ApplicationArea = All;
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+G';

                trigger OnAction()
                var
                    DocuSign: Record "DocuSign Assessment Scores";
                begin
                    if not Confirm('Do you want to assign Manual Grade to the Student No. %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        Exit;

                    DocuSign.Reset();
                    DocuSign.SetRange("Rotation ID", Rec."Rotation ID");
                    DocuSign.SetRange("Rotation No.", Rec."Rotation No.");
                    DocuSign.SetRange("Student No.", Rec."Student No.");
                    // Page.RunModal(Page::"Clerkship Assessment Input+", DocuSign);
                end;
            }
            action("Get Score from DocuSign")
            {
                Caption = 'Get Score from DocuSign';
                ApplicationArea = All;
                Image = SendConfirmation;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RecCompanyInformation: Record "Company Information";
                    // WebServiceFn: Codeunit WebServicesFunctionsCSL;
                    HttpClnt: HttpClient;
                    HttpResponse: HttpResponseMessage;
                    ResponseText: Text;
                    URL: Text;

                Begin
                    RecCompanyInformation.get();
                    If RecCompanyInformation."Portal Sync Enabled" = TRUE then begin
                        RecCompanyInformation.TestField("Portal Api URL");
                        URL := StrSubstNo('' + RecCompanyInformation."Portal Api URL" + '/FetchClinicalRotationScorefromDocuSign?');
                        If HttpClnt.Get(URL, HttpResponse) then
                            HttpResponse.Content().ReadAs(ResponseText);

                        // WebServiceFn.SaveApiLogDetails(Rec.TableName(), ResponseText, 'Get Score from DocuSign');

                        CurrPage.Update();
                    end;
                End;
            }
            Action("Delete Selected Entries")
            {
                ApplicationArea = All;
                Image = SendConfirmation;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = False;
                Trigger OnAction()
                var
                    DocAssessmentScore: Record "DocuSign Assessment Scores";
                    RLE: Record "Roster Ledger Entry";
                Begin
                    DocAssessmentScore.Reset();
                    CurrPage.SetSelectionFilter(DocAssessmentScore);
                    IF DocAssessmentScore.FindSet() then
                        repeat
                            RLE.Reset();
                            if RLE.Get(DocAssessmentScore."Rotation Entry No.") then begin
                                RLE."Assessment Completed" := false;
                                RLE.Modify();
                            end;
                            DocAssessmentScore.Delete();
                        until DocAssessmentScore.Next() = 0;
                End;
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;
}