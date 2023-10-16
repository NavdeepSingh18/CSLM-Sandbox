page 50502 "CLOA List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Leave of Absence";
    Caption = 'CLOA List';
    SourceTableView = where("Leave Types" = filter(CLOA), status = Filter(Open | "Pending for Approval"));
    CardPageId = "CLOA Card";
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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field("Leave Types"; Rec."Leave Types")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                Field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Caption = 'Created By';
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Clinical Rotation Scheduled")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Runobject = page "Roster Scheduling Lines";
                RunPageLink = "Student No." = FIELD("Student No.");
            }
        }

    }
    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Application Date" <> 0D then begin
            PendingDays := Today() - Rec."Application Date";
            Exit(PendingDays);
        end;
    end;
}