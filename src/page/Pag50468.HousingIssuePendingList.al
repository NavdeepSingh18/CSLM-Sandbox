page 50468 "Housing Issue Pending List"
{
    Caption = 'Pending Housing Issue List';
    PageType = List;
    ApplicationArea = all;
    CardPageId = "Housing Issue Pending Card";
    UsageCategory = Lists;
    SourceTable = "Housing Issue";
    SourceTableView = Sorting("Document Date") Order(descending) where(Status = const("Pending for Approval"));
    Editable = False;
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
        // area(factboxes)
        // {
        //     part("Housing Issue FactBox"; "Housing Issue FactBox")
        //     {
        //         ApplicationArea = All;
        //         SubPageLink = "Housing ID" = FIELD("Housing ID");

        //     }

        // }
    }
    actions
    {
        area(Processing)
        {

            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Housing Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Card';
                Runobject = page "Housing Master Card";
                RunPageLink = "Housing ID" = FIELD("Housing ID");
            }
        }
    }
    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if REc."Document Date" <> 0D then begin
            PendingDays := Today() - REc."Document Date";
            Exit(PendingDays);
        end;
    end;

    trigger OnAfterGetRecord()
    var
        EducationSetupRec: Record "Education Setup-CS";

    begin
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", REc."Shortcut Dimension 1 Code");
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

