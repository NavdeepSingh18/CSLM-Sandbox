page 50691 "Student Registration list"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    DelayedInsert = false;
    InsertAllowed = false;
    DeleteAllowed = False;
    CardPageID = "Student Registration Card";
    SourceTable = "Student Registration-CS";
    SourceTableView = sorting("Student No", "Line No.") where("Document Type" = filter(Registration));
    DataCaptionFields = "Student No", "Student Name";
    Caption = 'Student Stage Wise Registration List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = all;
                }
                Field("MOU Agreement"; Rec."MOU Agreement")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor9;
                }
                field("Basic Information Stage Status"; Rec."Stage Basic Information")
                {
                    ApplicationArea = all;
                    StyleExpr = BoolColor1;
                    Style = Strong;

                }
                field("Basic Information Stage Completion Date"; Rec."Stage Basic Info Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor1;
                }
                field("Basic Information Stage Completion Time"; Rec."Stage Basic Info Time")
                {
                    ApplicationArea = All;

                    StyleExpr = BoolColor1;
                }


                field("Housing Stage Status"; Rec."Stage Housing")
                {
                    ApplicationArea = all;
                    StyleExpr = BoolColor2;
                    Style = Strong;

                }
                field("Housing Stage Completion Date"; Rec."Stage Housing Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor2;
                }
                field("Housing Stage Completion Time"; Rec."Stage Housing Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor2;

                }

                field("Insurance Stage Status"; Rec."Stage Insurance")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor3;
                    Style = Strong;

                }
                field("Insurance Stage Completion Date"; Rec."Stage Insurance Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor3;
                }
                field("Insurance Stage Completion Time"; Rec."Stage Insurance Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor3;
                }

                field("FERPA Stage Status"; Rec."Stage FERPA")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor4;
                    Style = Strong;

                }
                Field("FERPA Release"; Rec."FERPA Release")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor4;
                    Style = Strong;
                }
                field("FERPA Stage Completion Date"; Rec."Stage FERPA Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor4;
                }

                field("FERPA Stage Completion Time"; Rec."Stage FERPA Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor4;
                }

                field("Media Release Stage Status"; Rec."Stage Media Release")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor5;
                    Style = Strong;

                }
                field("Media Release Stage Completion Date"; Rec."Stage Media Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor5;
                }
                field("Media Release Stage Completion Time"; Rec."Stage Media Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor5;
                }



                field("Agreements Stage Status"; Rec."Stage Agreements")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor6;
                    Style = Strong;

                }
                field("Agreements Stage Completion Date"; Rec."Stage Agreements Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor6;
                }
                field("Agreements Stage Completion Time"; Rec."Stage Agreements Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor6;
                }

                // field("Lease Agreement";"Lease Agreement")
                // {
                //     ApplicationArea  = all;
                // }
                field("Financial Aid Stage Status"; Rec."Stage Financial Aid")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor7;
                    Style = Strong;
                    Visible = False;

                }
                field("Financial Aid Stage Completion Date"; Rec."Stage Financial Aid Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor7;
                    Visible = False;
                }
                field("Financial Aid Stage Completion Time"; Rec."Stage Financial Aid Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor7;
                    Visible = False;
                }

                field("Bursar Stage Status"; Rec."Stage Bursar")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor8;
                    Style = Strong;

                }
                field("Bursar Stage Completion Date"; Rec."Stage Bursar Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor8;
                }
                field("Bursar Stage Completion Time"; Rec."Stage Bursar Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor8;
                }

                field("Confirmation Stage Status"; Rec."Stage Confirmation")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor9;
                    Style = Strong;

                }
                field("Confirmation Stage Completion Date"; Rec."Stage Confirmation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor9;
                }
                field("Confirmation Stage Completion Time"; Rec."Stage Confirmation Time")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor9;
                }

                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor10;
                    Style = Strong;

                }
                field("OLR Completed Date"; Rec."OLR Completed Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor10;
                }
                field("OLR Completed Time"; Rec."OLR Completed Time")
                {

                    ApplicationArea = All;
                    StyleExpr = BoolColor10;
                }

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }


            }
        }
    }
    var
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
    end;

}

