page 50739 "Clerkship Assessment Revision"
{
    PageType = Card;
    UsageCategory = None;
    Editable = true;
    Caption = 'Clerkship Assessment Revision';
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
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        Caption = 'Hospital Name';
                        ApplicationArea = All;
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
                        Editable = Not FIUHospital;
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
                        Editable = Not FIUHospital;
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
                        Editable = Not FIUHospital;
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
                        Editable = Not FIUHospital;
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
                        Editable = Not FIUHospital;
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
                        Editable = Not FIUHospital;
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
                        Visible = false;
                    }
                    field("Assessment Total Score"; Rec."Assessment Total Score")
                    {
                        Caption = 'Evaluation Sum';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        DecimalPlaces = 0;
                        BlankNumbers = BlankZero;
                        MaxValue = 24;
                        trigger OnValidate()
                        begin
                            Rec."Assessment Percentage" := 0;
                            if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                                Rec."Assessment Percentage" := Round(((Rec."Assessment Total Score" / 24 * 100) * (70 / 100)), 0.01, '=')
                            else
                                Rec."Assessment Percentage" := Round((Rec."Assessment Total Score" / 24 * 100), 0.01, '=');
                            Rec.CalculateEvalCount_Sum();
                        end;
                    }
                    field("Assessment Percentage"; Rec."Assessment Percentage")
                    {
                        Caption = 'Evaluation Percent';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = FIUHospital;
                        BlankNumbers = BlankZero;
                        MaxValue = 100;
                        trigger OnValidate()
                        begin
                            Rec."Final Percentage" := Rec."Assessment Percentage";
                            Rec.CalculateEvalCount_Sum();
                        end;
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
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate Grade")
            {
                Caption = 'Calculate Grade';
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+C';
                trigger OnAction()
                var
                    RLE: Record "Roster Ledger Entry";
                begin
                    Rec.CalculateEvalCount_Sum();

                    RLE.Reset();
                    if RLE.Get(Rec."Rotation Entry No.") then begin
                        RLE."Assessment Completed" := true;
                        RLE.Validate("Rotation Grade", Rec.Grade);
                        RLE.Modify();
                        StudentTimeLineRec.InsertRecordFun(RLE."Student ID", RLE."Student Name", 'For ' + RLE."Course Description" + ' Grade has been assigned to ' + RLE."Rotation Grade", UserId(), Today());
                    end;

                    Rec."Published By" := UserId;
                    Rec."Published On" := Today;
                    Rec.Modify();
                end;
            }
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
                    OldGrade: Code[10];
                begin
                    if not Confirm('Do you want to publish the Grade of Student No. %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
                        exit;

                    RLE.Reset();
                    if RLE.Get(Rec."Rotation Entry No.") then begin
                        RLE."Assessment Completed" := true;
                        OldGrade := RLE."Rotation Grade";
                        RLE.Validate("Rotation Grade", Rec.Grade);
                        RLE.Modify();
                    end;


                    Rec."Published By" := UserId;
                    Rec."Published On" := Today;
                    Rec.Modify();
                    //TimeLine insert Added == 01-09-2021
                    StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'For ' + Rec."Course Name" + ' Grade has been changed ' + OldGrade + ' to ' + Rec.Grade, UserId(), Today());
                    //TimeLine insert Added == 01-09-2021
                    Message('Grade published successfully.');
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
        StudentTimeLineRec: Record "Student Time Line";
        FIUHospital: Boolean;

    trigger OnOpenPage()
    var
        RLE: Record "Roster Ledger Entry";
        Vendor: Record Vendor;
    begin
        RLE.Reset();
        if RLE.Get(Rec."Rotation Entry No.") then;

        Vendor.Reset();
        if not Vendor.Get(RLE."Hospital ID") then
            exit;

        FIUHospital := false;
        if Vendor."FIU Hospital" then
            FIUHospital := true;
    end;

    trigger OnAfterGetRecord()
    var
        RLE: Record "Roster Ledger Entry";
        Vendor: Record Vendor;
    begin
        RLE.Reset();
        if RLE.Get(Rec."Rotation Entry No.") then;

        Vendor.Reset();
        if not Vendor.Get(RLE."Hospital ID") then
            exit;

        FIUHospital := false;
        if (Vendor."FIU Hospital" = true) and (RLE."Clerkship Type" = RLE."Clerkship Type"::Core) then
            FIUHospital := true;

        IF (StrPos(Rec."Course Name", 'General Surgery') > 0) and (Rec."Clerkship Type" = Rec."Clerkship Type"::Elective)
        and (Vendor."FIU Hospital" = true) then
            FIUHospital := true;
    end;
}