page 50582 "Hold FactBox"
{
    PageType = CardPart;
    Caption = 'Hold FactBox';
    SourceTable = "Student Wise Holds";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    // SourceTableView = where("Sign-off" = Filter(false), "Hold Type" = FILTER(<> Registrar));
    SourceTableView = sorting("Created On") order(descending) where(Status = filter(Enable));


    layout
    {
        area(Content)
        {

            group(Hold)
            {
                Caption = 'Hold Details';
                field(HoldCount2; HoldCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Hold Count';
                    Style = Strong;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        StudentWiseHoldRec.Reset();
                        StudentWiseHoldRec.SetRange("Student No.", Rec."Student No.");
                        StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
                        StudentWiseHoldPage.SetTableView(StudentWiseHoldRec);
                        StudentWiseHoldPage.Editable := false;
                        StudentWiseHoldPage.Run();
                    end;
                }
                repeater(HoldDetails)
                {
                    field("Hold Description"; Rec."Hold Description")
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
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentWiseHoldPage: Page "Student Wise Hold List";
        HoldCount: Integer;
        BoolColor: Text;


    trigger OnAfterGetRecord()
    begin


        IF Rec.Status = Rec.Status::Enable then
            BoolColor := 'Unfavorable'
        else
            BoolColor := 'favorable';

    end;

    Trigger OnAfterGetCurrRecord()
    begin
        HoldCount := 0;
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", Rec."Student No.");
        StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
        IF StudentWiseHoldRec.FindSet() then
            HoldCount := StudentWiseHoldRec.Count();
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Status = Rec.Status::Enable then
            BoolColor := 'Unfavorable'
        else
            BoolColor := 'favorable';
    end;

}