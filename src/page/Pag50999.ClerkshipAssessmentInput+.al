page 50999 "Clerkship Assessment Input+"
{
    PageType = Card;
    UsageCategory = None;
    Editable = true;
    Caption = 'Clerkship Assessment Manual Grading';
    SourceTable = "DocuSign Assessment Scores";
    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Rotation Details")
                {
                    field("Student No."; Rec."Student No.")
                    {
                        Caption = 'Student No.';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        Caption = 'Student Name';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Rotation ID"; Rec."Rotation ID")
                    {
                        Caption = 'Rotation ID';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Rotation No."; Rec."Rotation No.")
                    {
                        Caption = 'Rotation No.';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Clerkship Type"; Rec."Clerkship Type")
                    {
                        Caption = 'Clerkship Type';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        OptionCaption = ' ,Core,Elective,FM1/IM1';
                    }
                    field("Course Group Code"; Rec."Course Group Code")
                    {
                        Caption = 'Course Group Code';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Group Description"; Rec."Course Group Description")
                    {
                        Caption = 'Course Group Description';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Code"; Rec."Course Code")
                    {
                        Caption = 'Course Code';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Name"; Rec."Course Name")
                    {
                        Caption = 'Course Description';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course Start Date"; Rec."Course Start Date")
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Course End Date"; Rec."Course End Date")
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                }
                group("Assessment Inputs Entered")
                {
                    field("Patient Care"; Rec."Patient Care")
                    {
                        Caption = 'Patient Care';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = false;
                        trigger OnValidate()
                        begin
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field("Medical Knowledge"; Rec."Medical Knowledge")
                    {
                        Caption = 'Medical Knowledge';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = false;
                        trigger OnValidate()
                        begin
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field("Interpersonal and Comm. Skills"; Rec."Interpersonal and Comm. Skills")
                    {
                        Caption = 'Interpersonal and Communication Skills';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = false;
                        trigger OnValidate()
                        begin
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field("Practice Base Learn and Impro"; Rec."Practice Base Learn and Impro")
                    {
                        Caption = 'Practice Base Learning and Improvement';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = false;
                        trigger OnValidate()
                        begin
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field("System Based Learning"; Rec."System Based Learning")
                    {
                        Caption = 'System Based Learning';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = false;
                        trigger OnValidate()
                        begin
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field(Professionalism; Rec.Professionalism)
                    {
                        Caption = 'Professionalism';
                        ApplicationArea = All;
                        Style = Unfavorable;
                        OptionCaption = ' ,Outstanding,Competent,Adequate,Inadequate-Remediation required,Not Observed/Insufficient Data';
                        Editable = false;
                        trigger OnValidate()
                        begin
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field("CCSSE Score"; Rec."CCSSE Score")
                    {
                        Caption = 'CCSSE Score';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                    }
                    field("CCSSE Score II"; Rec."CCSSE Score II")
                    {
                        Caption = 'CCSSE Score II';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                    }
                    field("CCSSE Score III"; Rec."CCSSE Score III")
                    {
                        Caption = 'CCSSE Score III';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                    }
                    field("CCSSE Score IV"; Rec."CCSSE Score IV")
                    {
                        Caption = 'CCSSE Score IV';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                    }
                    field("CCSSE Score V"; Rec."CCSSE Score V")
                    {
                        Caption = 'CCSSE Score V';
                        ApplicationArea = All;
                        Style = Favorable;
                        Editable = false;
                    }
                }
                group("Calculated Values")
                {
                    field("Evaluation Count"; Rec."Evaluation Count")
                    {
                        Caption = 'Evaluation Count';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        BlankNumbers = BlankZero;
                    }
                    field("Assessment Total Score"; Rec."Assessment Total Score")
                    {
                        Caption = 'Evaluation Sum';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        DecimalPlaces = 0;
                        BlankNumbers = BlankZero;
                    }
                    field("Assessment Percentage"; Rec."Assessment Percentage")
                    {
                        Caption = 'Evaluation Percent';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        BlankNumbers = BlankZero;
                    }
                    field("CCSSE Weightage"; Rec."CCSSE Weightage")
                    {
                        Caption = 'Shelf Value';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        DecimalPlaces = 0;
                        BlankNumbers = BlankZero;
                    }
                    field("Final Percentage"; Rec."Final Percentage")
                    {
                        Caption = 'Grade Percent';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        BlankNumbers = BlankZero;
                    }
                    field(Grade; Rec.Grade)
                    {
                        Caption = 'Grade';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field(ManualGrade; ManualGrade)
                    {
                        Caption = 'Manual Grade';
                        ApplicationArea = All;
                        Style = Strong;
                        ShowMandatory = true;
                        TableRelation = "Grade Master-CS".Code;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Publish)
            {
                Caption = 'Publish';
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+P';
                trigger OnAction()
                var
                    RLE: Record "Roster Ledger Entry";
                    StudentTimelineRec: Record "Student Time Line";
                begin
                    if not Confirm('Do you want to publish the Grade of Student No. %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        exit;

                    if ManualGrade = '' then
                        Error('Manual Grade must not be blank.');

                    If Rec.Published then begin         //30Nov2022 Navdeep
                        RLE.Reset();
                        if RLE.Get(Rec."Rotation Entry No.") then begin
                            RLE."Assessment Completed" := true;
                            RLE.Validate("Rotation Grade", ManualGrade);
                            RLE.Modify();
                        end;
                    end;

                    Rec."Manual Grade" := ManualGrade;
                    Rec."Manual Grade Assigned By" := UserId;
                    Rec."Manual Grade Assigned On" := Today;
                    Rec.Modify();
                    StudentTimelineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Grade has been changed ' + Rec.Grade + ' to ' + Rec."Manual Grade", UserId(), Today());
                    Message('Manual Grade updated successfully.');
                    CurrPage.Close();
                end;
            }

            action("Shelf Exam Score")
            {
                Caption = 'Shelf Exam Score';
                ApplicationArea = All;
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentSubjectExam: Record "Student Subject Exam";
                begin
                    StudentSubjectExam.Reset();
                    StudentSubjectExam.FilterGroup(2);
                    StudentSubjectExam.SetRange("Student No.", Rec."Student No.");
                    StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                    StudentSubjectExam.SetRange("Core Clerkship Subject Code", Rec."Course Group Code");
                    StudentSubjectExam.FilterGroup(0);
                    Page.RunModal(Page::"Student Subject Exam List", StudentSubjectExam);
                end;
            }
            action("Student Subject")
            {
                Caption = 'Student Subject';
                ApplicationArea = All;
                Image = SubcontractingWorksheet;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    MainStudentSubject: Record "Main Student Subject-CS";
                begin
                    MainStudentSubject.Reset();
                    MainStudentSubject.FilterGroup(2);
                    MainStudentSubject.SetRange("Student No.", Rec."Student No.");
                    MainStudentSubject.FilterGroup(0);
                    Page.RunModal(Page::"Subject Student-CS", MainStudentSubject);
                end;
            }
        }
    }

    var
        ManualGrade: Code[20];


    trigger OnAfterGetCurrRecord()
    begin
        ManualGrade := Rec."Manual Grade";
    end;
}