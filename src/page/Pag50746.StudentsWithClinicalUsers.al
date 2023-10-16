page 50746 "Students With Clinical Users"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    CardPageId = "Student Detail Card-CS";
    Caption = 'Students with Clinical Users';
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
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
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

                field("Document Specialist"; Rec."Document Specialist")
                {
                    ApplicationArea = All;
                    Visible = DocumentSpecialist;
                }
                field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                {
                    ApplicationArea = All;
                    Visible = FM1IM1Cordinator;
                }
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    ApplicationArea = All;
                    Visible = ClinicalCordinator;
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
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
    var
        DocumentSpecialist: Boolean;
        FM1IM1Cordinator: Boolean;
        ClinicalCordinator: Boolean;

    procedure SetVariable(LDocumentSpecialist: Boolean;
    LFM1IM1Cordinator: Boolean;
    LClinicalCordinator: Boolean)
    begin
        DocumentSpecialist := LDocumentSpecialist;
        FM1IM1Cordinator := LFM1IM1Cordinator;
        ClinicalCordinator := LClinicalCordinator;
    end;
}