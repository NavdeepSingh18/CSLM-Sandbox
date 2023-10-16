page 50049 "Clerkship Assessment"
{
    PageType = Card;
    UsageCategory = None;
    Editable = false;
    Caption = 'Clerkship Assessment Card';
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
                    // Page.RunModal(Page::"Student Subject Exam List", StudentSubjectExam);
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
        if Vendor."Preffered for International" then
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
        if Vendor."Preffered for International" then
            FIUHospital := true;
    end;
}