Page 50718 "Leaves Approval Status"
{

    PageType = ListPart;
    SourceTable = "Leaves Approvals";
    Caption = 'Leaves Approval Status';
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
                {
                    //CSPL-00307-T1-T1516-CR
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                    // MultiLine = true;
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
                field("Rejected In Days"; Rec."Rejected In Days")
                {
                    ApplicationArea = All;
                }
                field("Cancelled In Days"; Rec."Cancelled In Days")
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
        if Rec."Approved On" = 0D then begin
            PendingDays := Today() - Rec."Application Date";
            Exit(PendingDays);
        End else
            Exit(0);
    end;


}