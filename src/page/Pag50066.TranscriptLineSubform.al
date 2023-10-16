page 50066 "Transcript Lines"
{   //CSPL-00307-Transcript
    PageType = ListPart;
    Caption = 'Transcript Lines';
    // UsageCategory = Administration;
    // ApplicationArea = All;
    SourceTable = "Competition L-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Editable = false;
                    StyleExpr = Style_gTxt;
                }
                field("Min Age"; Rec."Min Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Editable = false;
                    StyleExpr = Style_gTxt;
                }
                field("SLcM No"; Rec."SLcM No")
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the SLcM No field.';
                }
                field("File created"; Rec."File created")
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the SLcM No field.';
                }

                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the Student ID field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the Student Name field.';
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the Enrollment No field.';
                }
                field(Print; Rec.Print)
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the Print field.';

                }
                field(Reprint; Rec.Reprint)
                {
                    ApplicationArea = All;
                    StyleExpr = Style_gTxt;
                    ToolTip = 'Specifies the value of the Reprint field.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()//GAURAV//15//02//23
    var
        myInt: Integer;
    begin
        IF Rec."File created" then
            Style_gTxt := 'favorable'
        else
            Style_gTxt := 'attention';
    end;


    trigger OnAfterGetRecord()//GAURAV//15//02//23
    var
        myInt: Integer;
    begin
        IF Rec."File created" then
            Style_gTxt := 'favorable'
        else
            Style_gTxt := 'attention';
    end;


    var
        Style_gTxt: text[20];
}