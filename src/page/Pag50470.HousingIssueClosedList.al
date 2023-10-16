page 50470 "Closed Housing Issue List"
{
    Caption = 'Resolved Housing Issue List';
    PageType = List;
    CardPageId = "Closed Housing Issue Card";
    ApplicationArea = all;
    Editable = false;
    InsertAllowed = false;
    DelayedInsert = false;
    UsageCategory = Lists;
    SourceTable = "Housing Issue";
    SourceTableView = sorting("Document Date") order(descending);
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
                field("Posting Date"; Rec."Posting Date")
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
                field("Accepted In Days"; Rec."Accepted In Days")
                {
                    ApplicationArea = All;
                    StyleExpr = ColorStyle1;
                    Style = strong;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Resolved In Days"; Rec."Resolved In Days")
                {
                    ApplicationArea = All;
                    StyleExpr = ColorStyle;
                    Style = strong;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Rejected In Days"; Rec."Rejected In Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Accepted By"; Rec."Accepted By")
                {
                    ApplicationArea = All;
                }
                field("Accepted Date"; Rec."Accepted Date")
                {
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                }
                field("Rejection Date"; Rec."Rejection Date")
                {
                    ApplicationArea = All;
                }
                field("Resolved By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Resolved Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Remarks By Student"; Rec."Remarks By Student")
                {
                    ApplicationArea = All;
                    Caption = 'Remarks';
                    Editable = False;
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
            Action("Email Notification List")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "E-Mail Notification List";
                RunPageLink = ReceiverId = Field("Student No."), Subject = filter('*Housing*');

            }

        }
    }
    trigger OnAfterGetRecord()
    var
        EducationSetupRec: Record "Education Setup-CS";

    begin
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", REc."Shortcut Dimension 1 Code");
        if EducationSetupRec.FindFirst() then begin
            if REc."Accepted In Days" > EducationSetupRec."Max Days Issue Accepted" then
                ColorStyle1 := 'Unfavorable'
            else
                ColorStyle1 := 'favorable';

            if REc."Resolved In Days" > EducationSetupRec."Max Days Issue Resolved" then
                ColorStyle := 'Unfavorable'
            else
                ColorStyle := 'favorable';

        end;

    end;

    var
        ColorStyle: Text;
        ColorStyle1: Text;
}