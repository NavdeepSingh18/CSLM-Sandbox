page 50630 "Sem Registration Approved List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Opt Out";
    Caption = 'Semester Registration Approved/Rejected  List';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = Where(Status = filter(Rejected | Approved), "Application Type" = filter("Semester Registration"));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Caption = 'Application Date';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Caption = 'Application Type';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Semester Start Date';
                }
                field("Semester End Date"; Rec."Semester End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Semester End Date';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Document")
            {
                ApplicationArea = All;
                Caption = 'Show Document';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                Var
                    AcademicBasicOptionOut_lRec: Record "Opt Out";
                    SemRegistration_lPage: Page "Semester Registration Card";

                begin
                    AcademicBasicOptionOut_lRec.Reset();
                    AcademicBasicOptionOut_lRec.SetRange("Application No.", Rec."Application No.");
                    IF AcademicBasicOptionOut_lRec.FindFirst() then BEGIN
                        SemRegistration_lPage.SetTableView(AcademicBasicOptionOut_lRec);
                        SemRegistration_lPage.Editable := False;
                        SemRegistration_lPage.Run();
                    END;


                end;
            }
        }
    }
}