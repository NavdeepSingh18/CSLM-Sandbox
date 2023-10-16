pageextension 50046 UserTaskListExt extends "User Task List"
{
    layout
    {

        addafter("Created DateTime")
        {
            Field(Statuss; Rec.Statuss)
            {
                ApplicationArea = All;
                StyleExpr = BoolColor;
            }
            Field("Attachment Exist"; Rec."Attachment Exist")
            {
                ApplicationArea = All;
                StyleExpr = BoolColor;

            }
            field("Per. Com. per User"; Rec."Per. Com. per User")
            {
                ApplicationArea = All;
                StyleExpr = BoolColor;
            }
            Field("Last Modified On"; Rec."Last Modified On")
            {
                ApplicationArea = All;
                StyleExpr = BoolColor;
            }
            Field("Last Modified By"; Rec."Last Modified By")
            {
                ApplicationArea = All;
                StyleExpr = BoolColor;
            }

        }
        modify(Title)
        {
            StyleExpr = BoolColor;
        }


        modify("User Task Group Assigned To")
        {
            Editable = false;
            trigger OnDrillDown()
            var
                UTGMRec: Record "User Task Group Member";
                UTGMPage: Page "User Task Group Members";
            Begin
                Clear(UTGMPage);
                If Rec."User Task Group Assigned To" <> '' then begin
                    UTGMRec.Reset();
                    UTGMRec.SetRange("User Task Group Code", Rec."User Task Group Assigned To");
                    UTGMPage.SetTableView(UTGMRec);
                    UTGMPage.Run();
                end;
            End;
        }

    }

    actions
    {
        modify("Go To Task Item")
        {
            Visible = false;
        }
        modify("Mark Complete")
        {
            Visible = False;
        }
    }

    var
        BoolColor: Text;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Last Modified On");
        Rec.SetAscending("Last Modified On", false);
        Rec.CalcFields("Attachment Exist");
        If Rec."Attachment Exist" then
            BoolColor := 'StrongAccent'
        else
            BoolColor := 'None';
    end;

    trigger OnAfterGetRecord()
    begin

        Rec.CalcFields("Attachment Exist");
        If Rec."Attachment Exist" then
            BoolColor := 'StrongAccent'
        else
            BoolColor := 'None';
    end;

}