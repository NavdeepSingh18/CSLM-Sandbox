page 50711 "Housing Fin Account List"
{

    PageType = List;
    SourceTable = "Financial Accountability";
    Caption = 'Pending Housing Financial Accountability List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Housing Fin Account card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    SourceTableView = sorting("Created On")
                      order(descending) where(Status = filter("Pending for Approval"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Fine Application No."; Rec."Fine Application No.")
                {
                    ApplicationArea = All;
                }
                field("Fine Date"; Rec."Fine Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Code"; Rec."Fine Category Code")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Description"; Rec."Fine Category Description")
                {
                    ApplicationArea = All;
                }
                field("Applicable Amount"; Rec."Applicable Amount")
                {
                    ApplicationArea = All;
                }

                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
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
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }

        }
    }
    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Approved On" = 0D then begin
            PendingDays := Today() - Rec."Fine Date";
            Exit(PendingDays);
        end else
            Exit(0);
    end;



}
