page 50542 "Exam Opt Out Approved List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Opt Out";
    Caption = 'Exam Opt Out Approved/Rejected  List';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = Where(Status = filter(Rejected), Status = filter(Approved), "Application Type" = filter("Bsic Opt Out"));
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
                field("Subject 1"; Rec."Subject 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 1';

                }
                field("Subject Description 1"; Rec."Subject Description 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 1';
                }
                field("Subject 2"; Rec."Subject 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 2';

                }
                field("Subject Description 2"; Rec."Subject Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 2';
                }
                field("Subject 3"; Rec."Subject 3")

                {
                    ApplicationArea = All;
                    Caption = 'Subject 3';

                }
                field("Subject Description 3"; Rec."Subject Description 3")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 3';
                }
                field("Subject 4"; Rec."Subject 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 4';

                }
                field("Subject Description 4"; Rec."Subject Description 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 4';
                }
                field("Subject 5"; Rec."Subject 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 5';

                }
                field("Subject Description 5"; Rec."Subject Description 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 5';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Approved Condition Failed"; Rec."Approved Condition Failed")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Condition Failed';
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected By';
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected On';
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
                    ExamOptionOut_lPage: Page "Exam Opt Out Card";

                begin
                    AcademicBasicOptionOut_lRec.Reset();
                    AcademicBasicOptionOut_lRec.SetRange("Application No.", Rec."Application No.");
                    IF AcademicBasicOptionOut_lRec.FindFirst() then BEGIN
                        ExamOptionOut_lPage.SetTableView(AcademicBasicOptionOut_lRec);
                        ExamOptionOut_lPage.Editable := False;
                        ExamOptionOut_lPage.Run();
                    END;


                end;
            }
        }
    }
}