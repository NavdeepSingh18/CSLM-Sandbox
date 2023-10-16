page 50883 "Housing Issue Pending Listpart"
{
    Caption = 'Pending Housing Issue Listpart';
    PageType = listpart;
    CardPageId = "Housing Issue Pending Card";
    UsageCategory = none;
    SourceTable = "Housing Issue";
    SourceTableView = where(Status = const("Pending for Approval"));
    Editable = False;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
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
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;
                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;
                }
                field("Issue Code"; Rec."Issue Code")
                {
                    ApplicationArea = All;
                }
                field("Issue Description"; Rec."Issue Description")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Rejection Description"; Rec."Rejection Description")
                {
                    ApplicationArea = All;
                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    Style = strong;
                    StyleExpr = ColorStyle;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
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
        if Rec."Document Date" <> 0D then begin
            PendingDays := Today() - Rec."Document Date";
            Exit(PendingDays);
        end;
    end;

    trigger OnAfterGetRecord()
    var
        EducationSetupRec: Record "Education Setup-CS";

    begin
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if EducationSetupRec.FindFirst() then begin
            if PendingDaysCalculation() > EducationSetupRec."Max Days Issue Pending" then
                ColorStyle := 'Unfavorable'
            else
                ColorStyle := 'favorable';
        end;
    end;

    Var
        ColorStyle: text;
}

