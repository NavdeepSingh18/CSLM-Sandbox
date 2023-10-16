page 50471 "Housing Issue Pending Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Housing Issue";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Pending Housing Issue Card';
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
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

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
                    MultiLine = true;

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
                    MultiLine = true;

                }

                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Remarks By Student"; Rec."Remarks By Student")
                {
                    ApplicationArea = All;
                    Caption = 'Remarks';
                    MultiLine = true;
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
            action(Accept)
            {
                ApplicationArea = All;
                Caption = 'Accept';
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                begin
                    REc.TestField(Status, REc.Status::"Pending for Approval");
                    REc.TestField("Application No.");
                    REc.TestField("Issue Description");
                    REc.TestField("Student No.");
                    IF REc."Rejection Description" = '' then begin
                        If Confirm(Txt002Lbl, false, REc."Document No.") then begin
                            // MailDocumentforAcception();
                            REc.Status := REc.Status::Accepted;
                            REc."Accepted By" := FORMAT(UserId());
                            REc."Accepted Date" := WorkDate();
                            REc.Updated := True;
                            REc."Accepted In Days" := REc."Accepted Date" - REc."Document Date";
                            REc.Modify();
                            Message(Txt001Lbl, REc."Document No.");
                        end;
                    end Else
                        Error('Rejection Description must be blank');
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                begin
                    REc.TestField("Rejection Description");
                    REc.TestField(Status, REc.Status::"Pending for Approval");
                    If Confirm(Txt003Lbl, false, REc."Document No.") then begin
                        REc.Status := REc.Status::Rejected;
                        REc.Updated := True;
                        REc."Rejected By" := FORMAT(UserId());
                        REc."Posting Date" := Today();
                        REc."Rejection Date" := WorkDate();
                        REc."Rejected In Days" := REc."Rejection Date" - REc."Document Date";
                        REc.Modify();
                        // MailDocumentforRejection();
                        Message(Txt005Lbl, REc."Document No.");
                    end;
                end;
            }
        }
    }
    var
        Txt001Lbl: Label 'Issue Application No. %1 has been accepted.';
        Txt002Lbl: Label 'Do you want to Accept Issue Application No. %1 ?';
        Txt003Lbl: Label 'Do you want to Reject Issue Application No. %1 ?';
        Txt005Lbl: Label 'Issue Application No. %1 has been Rejected.';

    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if REc."Document Date" <> 0D then begin
            PendingDays := Today() - REc."Document Date";
            Exit(PendingDays);
        end;
    end;

}