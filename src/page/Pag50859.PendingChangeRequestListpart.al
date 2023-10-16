page 50859 "Housing Change Request Lstpart"
{
    PageType = ListPart;
    Caption = 'Pending Housing Change Request Listpart';
    UsageCategory = None;
    SourceTable = "Housing Change Request";
    CardPageId = "Housing Change Request Card";
    SourceTableView = sorting("Application No.")
                      order(ascending)
                      where(Status = filter("Pending for Approval"), Type = filter("Change Request"));
    Editable = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;

                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;

                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;

                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;

                }
                field("Original Application No."; Rec."Original Application No.")
                {
                    ApplicationArea = All;

                }
                field("New Application No."; Rec."New Application No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Room Keys Returned"; Rec."Room Keys Returned")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
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