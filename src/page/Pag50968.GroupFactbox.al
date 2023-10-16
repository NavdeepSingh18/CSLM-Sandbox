page 50968 "Group FactBox"
{
    PageType = CardPart;
    Caption = 'Group FactBox';
    SourceTable = "Student Group";
    SourceTableView = Sorting("Creation Date") order(Descending) WHERE("Hold Exists" = CONST(false), Blocked = CONST(false));
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    // 
    layout
    {
        area(Content)
        {

            group(Group)
            {
                Caption = 'Group Details';
                field(GroupCount2; GroupCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Group Count';
                    Style = Strong;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        StudentGroupRec.Reset();
                        StudentGroupRec.SetRange("Student No.", Rec."Student No.");
                        StudentGroupRec.SetRange(Blocked, False);
                        StudentGroupRec.SEtrange("Hold Exists", False);
                        StudentGroupCodePage.SetTableView(StudentGroupRec);
                        StudentGroupCodePage.Editable := false;
                        StudentGroupCodePage.Run();
                    end;
                }
                repeater(GroupDetails)
                {
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        StyleExpr = BoolColor;
                        Editable = false;
                    }
                }
            }

        }
    }

    var
        StudentGroupRec: Record "Student Group";
        StudentGroupCodePage: Page "Student Group Code";
        GroupCount: Integer;
        BoolColor: Text;


    trigger OnAfterGetCurrRecord()
    begin
        GroupCount := 0;
        StudentGroupRec.Reset();
        StudentGroupRec.SetRange("Student No.", Rec."Student No.");
        StudentGroupRec.SetRange("Hold Exists", false);
        StudentGroupRec.SetRange(Blocked, false);
        GroupCount := StudentGroupRec.Count();

        // IF Status = Status::Enable then
        //     BoolColor := 'Unfavorable'
        // else
        //     BoolColor := 'favorable';

    end;

    trigger OnOpenPage()
    begin
        // IF Status = Status::Enable then
        //     BoolColor := 'Unfavorable'
        // else
        //     BoolColor := 'favorable';
        GroupCount := 0;
        StudentGroupRec.Reset();
        StudentGroupRec.SetRange("Student No.", Rec."Student No.");
        StudentGroupRec.SetRange("Hold Exists", false);
        StudentGroupRec.SetRange(Blocked, false);
        GroupCount := StudentGroupRec.Count();
    end;

}