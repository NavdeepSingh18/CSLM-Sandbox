page 50753 "OLR Stages FactBox"
{
    PageType = CardPart;
    Caption = ' ';
    SourceTable = "Student Registration-CS";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {

            group("OLR Stages Details")
            {
                Caption = 'OLR Stages Details:';

                field("Basic Information Stage Status"; Rec."Stage Basic Information")
                {
                    ApplicationArea = all;
                    StyleExpr = BoolColor1;
                    Editable = false;


                }
                field("Basic Information Stage Completion Date"; Rec."Stage Basic Info Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor1;
                    Editable = false;

                }

                field("Housing Stage Status"; Rec."Stage Housing")
                {
                    ApplicationArea = all;
                    StyleExpr = BoolColor2;
                    Editable = false;
                }
                field("Housing Stage Completion Date"; Rec."Stage Housing Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor2;
                    Editable = false;
                }
                field("Insurance Stage Status"; Rec."Stage Insurance")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor3;
                    Editable = false;

                }
                field("Insurance Stage Completion Date"; Rec."Stage Insurance Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor3;
                    Editable = false;

                }
                field("FERPA Stage Status"; Rec."Stage FERPA")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor4;
                    Editable = false;

                }
                field("FERPA Stage Completion Date"; Rec."Stage FERPA Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor4;
                    Editable = false;

                }
                field("Media Release Stage Status"; Rec."Stage Media Release")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor5;
                    Editable = false;

                }
                field("Media Release Stage Completion Date"; Rec."Stage Media Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor5;
                    Editable = false;

                }
                field("Agreements Stage Status"; Rec."Stage Agreements")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor6;
                    Editable = false;

                }
                field("Agreements Stage Completion Date"; Rec."Stage Agreements Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor6;
                    Editable = false;

                }
                field("Financial Aid Stage Status"; Rec."Stage Financial Aid")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor7;
                    Editable = false;
                    //Visible = CueVisible;
                    Visible = False;

                }
                field("Financial Aid Stage Completion Date"; Rec."Stage Financial Aid Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor7;
                    Editable = false;
                    //Visible = CueVisible;
                    Visible = False;

                }
                field("Bursar Stage Status"; Rec."Stage Bursar")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor8;
                    Editable = false;

                }
                field("Bursar Stage Completion Date"; Rec."Stage Bursar Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor8;
                    Editable = false;

                }
                field("Confirmation Stage Status"; Rec."Stage Confirmation")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor9;
                    Editable = false;

                }

                field("Confirmation Stage Completion Date"; Rec."Stage Confirmation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor9;
                    Editable = false;

                }

                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor10;
                    Editable = false;
                    Style = Strong;

                }
                field("OLR Completed Date"; Rec."OLR Completed Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor10;
                    Editable = false;
                }

            }

        }
    }

    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentWiseHoldPage: Page "Student Wise Hold List";
        HoldCount: Integer;
        BoolColor1: Text;
        BoolColor2: Text;
        BoolColor3: Text;
        BoolColor4: Text;
        BoolColor5: Text;
        BoolColor6: Text;
        BoolColor7: Text;
        BoolColor8: Text;
        BoolColor9: Text;
        BoolColor10: Text;


    trigger OnAfterGetRecord()
    begin
        IF Rec."Stage Basic Information" then
            BoolColor1 := 'favorable'
        else
            BoolColor1 := 'Unfavorable';

        IF Rec."Stage Housing" then
            BoolColor2 := 'favorable'
        else
            BoolColor2 := 'Unfavorable';
        IF Rec."Stage Insurance" then
            BoolColor3 := 'favorable'
        else
            BoolColor3 := 'Unfavorable';

        IF Rec."Stage FERPA" then
            BoolColor4 := 'favorable'
        else
            BoolColor4 := 'Unfavorable';

        IF Rec."Stage Media Release" then
            BoolColor5 := 'favorable'
        else
            BoolColor5 := 'Unfavorable';
        IF Rec."Stage Agreements" then
            BoolColor6 := 'favorable'
        else
            BoolColor6 := 'Unfavorable';
        IF Rec."Stage Financial Aid" then
            BoolColor7 := 'favorable'
        else
            BoolColor7 := 'Unfavorable';
        IF Rec."Stage Bursar" then
            BoolColor8 := 'favorable'
        else
            BoolColor8 := 'Unfavorable';
        IF Rec."Stage Confirmation" then
            BoolColor9 := 'favorable'
        else
            BoolColor9 := 'Unfavorable';
        IF Rec."OLR Completed" then
            BoolColor10 := 'favorable'
        else
            BoolColor10 := 'Unfavorable';

    end;

    var
        UserSetup: Record "User Setup";
        CueVisible: Boolean;

    trigger OnOpenPage()
    begin
        IF Rec."Stage Basic Information" then
            BoolColor1 := 'favorable'
        else
            BoolColor1 := 'Unfavorable';

        IF Rec."Stage Housing" then
            BoolColor2 := 'favorable'
        else
            BoolColor2 := 'Unfavorable';
        IF Rec."Stage Insurance" then
            BoolColor3 := 'favorable'
        else
            BoolColor3 := 'Unfavorable';

        IF Rec."Stage FERPA" then
            BoolColor4 := 'favorable'
        else
            BoolColor4 := 'Unfavorable';

        IF Rec."Stage Media Release" then
            BoolColor5 := 'favorable'
        else
            BoolColor5 := 'Unfavorable';
        IF Rec."Stage Agreements" then
            BoolColor6 := 'favorable'
        else
            BoolColor6 := 'Unfavorable';
        IF Rec."Stage Financial Aid" then
            BoolColor7 := 'favorable'
        else
            BoolColor7 := 'Unfavorable';
        IF Rec."Stage Bursar" then
            BoolColor8 := 'favorable'
        else
            BoolColor8 := 'Unfavorable';
        IF Rec."Stage Confirmation" then
            BoolColor9 := 'favorable'
        else
            BoolColor9 := 'Unfavorable';
        IF Rec."OLR Completed" then
            BoolColor10 := 'favorable'
        else
            BoolColor10 := 'Unfavorable';

        UserSetup.Get(UserId());

        if (UserSetup."Global Dimension 1 Code" = '9000') then
            CueVisible := true
        else
            CueVisible := false;
    end;

}