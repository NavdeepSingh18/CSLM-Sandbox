page 50920 "CBSE Scores"
{
    Caption = 'CBSE Scores';
    Editable = true;
    PageType = ListPart;
    PromotedActionCategories = 'New,Process,Navigate';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "CBSE CCSE Scores";
    DeleteAllowed = false;
    // SourceTableView = sorting("Entry No.")
    //                   order(ascending)
    //                   where(Type = filter(CBSE));

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Institution ID"; Rec."Institution ID")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Test Date"; Rec."Test Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Order Number"; Rec."Order Number")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                    Visible = SubjectCodeVisible;
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(Examinee; Rec.Examinee)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Total Test"; Rec."Total Test")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Result Matched"; Rec."Result Matched")
                {
                    Editable = False;
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Published Document No."; Rec."Published Document No.")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field(Published; Rec.Published)
                {
                    Editable = False;
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(Duplicate; Rec.Duplicate)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                    Editable = False;
                }
            }

        }

    }
    actions
    {
        area(Processing)
        {
            group("Action")
            {

                Caption = 'Action';
                action("Student Card")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Image = Card;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Caption = 'Student Card';
                    Runobject = page "Student Detail Card-CS";
                    RunPageLink = "Original Student No." = FIELD(ID);
                }
                action("Upload CBSE Scores")
                {
                    ApplicationArea = All;
                    Caption = 'Upload CBSE Scores';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Type1 := 1;
                        CBSECCSEPort.GetType(Type1);
                        CBSECCSEPort.Run();
                        //Xmlport.Run(Xmlport::"CBSC Scores", false, true, Rec);

                    end;
                }

                action("Publish")
                {
                    ApplicationArea = All;
                    Caption = 'Publish';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    Visible = False;
                    trigger OnAction()
                    begin
                        RecCBSECCSE.Reset();
                        RecCBSECCSE.SetRange(Published, false);
                        RecCBSECCSE.SetRange(Type, RecCBSECCSE.Type::CBSE);
                        if RecCBSECCSE.FindFirst() then begin
                            repeat
                                RecCBSECCSE1.Reset();
                                RecCBSECCSE1.SetRange(ID, RecCBSECCSE.ID);
                                RecCBSECCSE1.SetRange("Test Date", RecCBSECCSE."Test Date");
                                RecCBSECCSE1.SetRange(Type, RecCBSECCSE1.Type::CBSE);
                                RecCBSECCSE1.SetRange(Published, true);
                                if RecCBSECCSE1.FindFirst() then begin
                                    Error('Data is already published for Student %1.', RecCBSECCSE.ID);
                                end;
                                RecCBSECCSE.Published := true;
                                RecCBSECCSE.Modify();
                            until RecCBSECCSE.Next() = 0;
                        end else begin
                            Message('Data already Published');
                        end;
                    end;
                }

                action("Delete")
                {
                    ApplicationArea = All;
                    Caption = 'Delete';
                    Visible = true;
                    Promoted = true;
                    Promotedonly = True;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Process;
                    trigger OnAction()
                    var
                        CBSECCSEScoresRec: Record "CBSE CCSE Scores";
                        StudentSubjectExamRec: Record "Student Subject Exam";
                        StudentTimeLine_lRec: Record "Student Time Line";
                        UserSetupRec: Record "User Setup";
                        SubjectMaster: Record "Subject Master-CS";
                        DocuSign: Record "DocuSign Assessment Scores";
                        RLE: Record "Roster Ledger Entry";
                        SubjectCode: Text;
                        Txt0001Lbl: Label 'Do you want to delete the Selected Lines ?';
                    begin
                        IF UserSetupRec.GET(UserId()) THEN
                            IF not UserSetupRec."Published Score Delete Allowed" THEN
                                Error('You do not have permission to delete the document.');

                        if Confirm(Txt0001Lbl, false) then begin
                            CBSECCSEScoresRec.Reset();
                            CurrPage.SetSelectionFilter(CBSECCSEScoresRec);
                            if CBSECCSEScoresRec.FindSet() then begin
                                repeat
                                    SubjectCode := '';
                                    SubjectMaster.Reset();
                                    SubjectMaster.SetRange("Level Description", SubjectMaster."Level Description"::"Level 2 Clinical Rotation");
                                    SubjectMaster.SetRange(Code, CBSECCSEScoresRec."Subject Code");
                                    if SubjectMaster.FindSet() then
                                        repeat
                                            if SubjectCode = '' then
                                                SubjectCode := SubjectMaster.Code
                                            else
                                                SubjectCode := SubjectCode + '|' + SubjectMaster.Code;
                                        until SubjectMaster.Next() = 0;

                                    StudentSubjectExamRec.Reset();
                                    StudentSubjectExamRec.SetRange("Score Type", CBSECCSEScoresRec.Type);
                                    StudentSubjectExamRec.SetRange("Published Entry No.", CBSECCSEScoresRec."Entry No.");
                                    if StudentSubjectExamRec.FindFirst() then begin
                                        If StudentSubjectExamRec."Score Type" <> StudentSubjectExamRec."Score Type"::CCSSE then
                                            StudentTimeLine_lRec.InsertRecordFun(StudentSubjectExamRec."Student No.", StudentSubjectExamRec."Student Name", 'Delete %1 Exam ' + Format(StudentSubjectExamRec."Subject Code"), UserId, Today)
                                        Else
                                            StudentTimeLine_lRec.InsertRecordFun(StudentSubjectExamRec."Student No.", StudentSubjectExamRec."Student Name", 'Delete %1 Exam ' + StudentSubjectExamRec."Core Clerkship Subject Desc", UserId, Today);

                                        DocuSign.Reset();
                                        DocuSign.SetRange("Student No.", StudentSubjectExamRec."Student No.");
                                        DocuSign.SetRange("Course Group Code", StudentSubjectExamRec."Core Clerkship Subject Code");
                                        DocuSign.SetFilter("Course Code", SubjectCode);
                                        if DocuSign.FindSet() then
                                            repeat
                                                if DocuSign."Used CCSSE Exam Date" = StudentSubjectExamRec."Sitting Date" then begin
                                                    DocuSign."Used CCSSE Exam Date" := 0D;
                                                    DocuSign."CCSSE Score" := 0;
                                                    DocuSign.Published := false;
                                                    DocuSign."Published By" := '';
                                                    DocuSign."Published On" := 0D;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign."Final Percentage" := 0;
                                                    DocuSign.Grade := '';
                                                    DocuSign."CCSSE Weightage" := 0;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign.Modify();
                                                end;
                                                if DocuSign."Used CCSSE Exam II Date" = StudentSubjectExamRec."Sitting Date" then begin
                                                    DocuSign."Used CCSSE Exam II Date" := 0D;
                                                    DocuSign."CCSSE Score II" := 0;
                                                    DocuSign.Published := false;
                                                    DocuSign."Published By" := '';
                                                    DocuSign."Published On" := 0D;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign."Final Percentage" := 0;
                                                    DocuSign.Grade := '';
                                                    DocuSign."CCSSE Weightage" := 0;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign.Modify();
                                                end;
                                                if DocuSign."Used CCSSE Exam III Date" = StudentSubjectExamRec."Sitting Date" then begin
                                                    DocuSign."Used CCSSE Exam III Date" := 0D;
                                                    DocuSign."CCSSE Score III" := 0;
                                                    DocuSign.Published := false;
                                                    DocuSign."Published By" := '';
                                                    DocuSign."Published On" := 0D;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign."Final Percentage" := 0;
                                                    DocuSign.Grade := '';
                                                    DocuSign."CCSSE Weightage" := 0;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign.Modify();
                                                end;
                                                if DocuSign."Used CCSSE Exam IV Date" = StudentSubjectExamRec."Sitting Date" then begin
                                                    DocuSign."Used CCSSE Exam IV Date" := 0D;
                                                    DocuSign."CCSSE Score IV" := 0;
                                                    DocuSign.Published := false;
                                                    DocuSign."Published By" := '';
                                                    DocuSign."Published On" := 0D;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign."Final Percentage" := 0;
                                                    DocuSign.Grade := '';
                                                    DocuSign."CCSSE Weightage" := 0;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign.Modify();
                                                end;
                                                if DocuSign."Used CCSSE Exam V Date" = StudentSubjectExamRec."Sitting Date" then begin
                                                    DocuSign."Used CCSSE Exam V Date" := 0D;
                                                    DocuSign."CCSSE Score V" := 0;
                                                    DocuSign.Published := false;
                                                    DocuSign."Published By" := '';
                                                    DocuSign."Published On" := 0D;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign."Final Percentage" := 0;
                                                    DocuSign.Grade := '';
                                                    DocuSign."CCSSE Weightage" := 0;
                                                    //CSPL-00307 - 23-01-23  as per Ajay
                                                    DocuSign.Modify();
                                                end;
                                                //CSPL-00307 - 23-01-23  as per Ajay
                                                RLE.Reset();
                                                if RLE.Get(DocuSign."Rotation Entry No.") then begin
                                                    RLE.Validate("Rotation Grade", '');
                                                    RLE.Modify();
                                                end;
                                            //CSPL-00307 - 23-01-23  as per Ajay
                                            Until DocuSign.Next() = 0;

                                        StudentSubjectExamRec.Delete(true);
                                    end;

                                    CBSECCSEScoresRec.Delete();
                                Until CBSECCSEScoresRec.Next() = 0;
                            end;
                        end else
                            exit;
                    end;
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    begin

        IF Rec."Result Matched" = true then
            BoolColor := 'favorable'
        else
            BoolColor := 'Unfavorable';

        SubjectCodeVisible := false;
        if Rec.Type = Rec.Type::CCSSE then
            SubjectCodeVisible := true;

        //GetCoreSubjectGroup();

        CurrPage.Caption := Format(Rec.Type) + ' ' + 'Exam';
    end;

    trigger OnOpenPage()
    begin
        IF Rec."Result Matched" = true then
            BoolColor := 'favorable'
        else
            BoolColor := 'Unfavorable';

        SubjectCodeVisible := false;
        if Rec.Type = Rec.Type::CCSSE then
            SubjectCodeVisible := true;
        // GetCoreSubjectGroup();

        CurrPage.Caption := Format(Rec.Type) + ' ' + 'Exam';

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // GetCoreSubjectGroup();
    end;

    procedure GetCoreSubjectGroup()
    Var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Core Subject Group Code");
        Rec.SetFilter("Core Subject Groups", EducationSetup."Core Subject Group Code");
    end;

    var
        RecCBSECCSE: Record "CBSE CCSE Scores";
        RecCBSECCSE1: Record "CBSE CCSE Scores";
        CBSECCSEPort: XmlPort "CBSC CCSE Scores";
        Type1: Integer;
        BoolColor: text;
        SubjectCodeVisible: Boolean;

}