Page 50688 "Withdrawal Approval Status"
{

    PageType = ListPart;
    SourceTable = "Withdrawal Approvals";
    Caption = 'Withdrawal Approval Status';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Approved for Department"; Rec."Approved for Department")
                {
                    ApplicationArea = All;
                }
                Field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Comments; Rec.Comments)
                {// CSPL-00307-T1-T1516-CR
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
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
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                }
                field("Approved In Days"; Rec."Approved In Days")
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
        IF Rec."Student No." <> '' then
            if Rec."Approved On" = 0D then begin
                IF Rec."Application Date" <> 0D then begin
                    PendingDays := Today() - Rec."Application Date";
                    Exit(PendingDays);
                end;
            End else
                Exit(0);
    end;


}