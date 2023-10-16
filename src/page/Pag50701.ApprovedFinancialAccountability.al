page 50701 "Approve/Reject Fin Account"
{

    PageType = List;
    SourceTable = "Financial Accountability";
    Caption = 'Approved/Rejected Financial Accountability List';
    ApplicationArea = All;
    UsageCategory = Lists;
    // CardPageId = "Approved/Rejected Fin Account";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    SourceTableView = sorting("Fine Application No.")
                      order(descending) where(Status = filter(Approved | Rejected));

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
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }

                field("Approved In Days"; Rec."Approved In Days")
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
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                }
                field("Rejected On"; Rec."Rejected On")
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
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Show Posted Entry")
            {
                ApplicationArea = All;
                Image = Ledger;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Show Posted Entry';
                Runobject = page "Customer Ledger Entries";
                RunPageLink = "External Document No." = FIELD("Fine Application No.");
            }
        }
    }

}
