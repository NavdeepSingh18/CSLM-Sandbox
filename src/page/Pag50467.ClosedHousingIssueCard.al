page 50467 "Closed Housing Issue Card"
{
    Caption = 'Housing Issue Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Housing Issue";
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Housing Address"; Rec."Housing Address")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Housing Address 2"; Rec."Housing Address 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Housing City"; Rec."Housing City")
                {
                    ApplicationArea = All;
                }
                field("Housing Country"; Rec."Housing Country")
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
                    Editable = false;
                    MultiLine = true;
                }
                field("Resolution Remarks"; Rec."Resolution Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Accepted In Days"; Rec."Accepted In Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Resolved In Days"; Rec."Resolved In Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Rejected In Days"; Rec."Rejected In Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Rejection Description"; Rec."Rejection Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
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
}