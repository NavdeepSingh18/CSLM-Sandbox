page 51064 GradeBookHeaderLedgerList
{
    PageType = List;
    Caption = 'Grade Book Ledger';
    ApplicationArea = All;
    UsageCategory = Lists;

    SourceTable = "Grade Book Header Ledger";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ApplicationArea = all;
                }
                field("Rejected Reason Description"; Rec."Rejected Reason Description")
                {
                    ApplicationArea = all;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = all;
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = all;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}