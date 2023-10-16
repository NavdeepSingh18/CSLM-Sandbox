page 50048 "Published Clerkship Assessment"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DocuSign Assessment Scores";
    //SourceTableView = where(Published = filter(true));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Clerkship Assessment View';
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
                field("Student Name"; Rec."Student Name")
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                }
                field(Published; Rec.Published)
                {
                    Caption = 'Published';
                    ApplicationArea = All;
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
                    Visible = false;
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
                    Visible = false;
                }
                field("Delivered Date Time"; Rec."Delivered Date Time")
                {
                    Caption = 'Delivered Date Time';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Preceptor Signed Date Time"; Rec."Preceptor Signed Date Time")
                {
                    Caption = 'Preceptor Signed Date Time';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Preceptor Name"; Rec."Preceptor Name")
                {
                    Caption = 'Preceptor Name';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("DME Name"; Rec."DME Name")
                {
                    Caption = 'DME Name';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("DME Signed Date Time"; Rec."DME Signed Date Time")
                {
                    Caption = 'DME Signed Date Time';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Envelope ID"; Rec."Envelope ID")
                {
                    Caption = 'Envelope ID';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Form No"; Rec."Form No")
                {
                    Caption = 'Form No';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    Actions
    {
        Area(Processing)
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
            Action("Clerkship Assesment Card")
            {
                ApplicationArea = All;
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+Shift+G';
                Caption = 'Clerkship Assesment Card';
                trigger OnAction()
                var
                    DocuSign: Record "DocuSign Assessment Scores";
                begin
                    DocuSign.Reset();
                    DocuSign.SetRange("Rotation ID", Rec."Rotation ID");
                    DocuSign.SetRange("Rotation No.", Rec."Rotation No.");
                    DocuSign.SetRange("Student No.", Rec."Student No.");
                    Page.RunModal(Page::"Clerkship Assessment", DocuSign);
                end;
            }
        }
    }
}