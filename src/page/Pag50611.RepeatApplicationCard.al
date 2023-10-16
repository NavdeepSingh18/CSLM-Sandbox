page 50611 "Repeat Application Card"
{
    Caption = 'Repeat Application Card';
    PageType = Card;
    SourceTable = "Opt Out";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Type Of Repeat"; Rec."Type Of Repeat")
                {
                    ApplicationArea = All;
                }
                field("Application Used"; Rec."Application Used")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Application Submit")
            {
                ApplicationArea = All;
                Caption = 'Application Submit';
                Visible = ShowButton;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Completed;

                trigger OnAction()
                begin
                    Rec.TestField("Student No.");
                    if Rec.Status = Rec.Status::Open then begin
                        If Confirm(Txt002Lbl, false, Rec."Application No.") then begin
                            Rec.Status := Rec.Status::Submit;
                            Rec.Modify();
                            Message(Txt001Lbl, Rec."Application No.");
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
        }
    }
    var
        ShowButton: Boolean;
        Txt001Lbl: Label 'Application No. %1 has been submit.';
        Txt002Lbl: Label 'Do you want to submit Application No. %1 ?';

    trigger OnNewRecord(BelowxRec: Boolean)
    Begin
        Rec."Application Type" := Rec."Application Type"::"Repeat";
    End;

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::Open then
            ShowButton := true
        else
            ShowButton := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Open then
            ShowButton := true
        else
            ShowButton := false;

    end;
}
