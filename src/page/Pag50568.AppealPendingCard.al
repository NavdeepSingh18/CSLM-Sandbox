page 50568 "Appeal Pending Card"
{
    Caption = 'Appeal Pending Card';
    PageType = Card;
    SourceTable = "Opt Out";
    UsageCategory = None;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Editable = ShowButton;
                }
                field("Reason Description"; Rec."Reason Description")
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
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                Promotedonly = True;
                Visible = ShowButton;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                trigger OnAction()
                begin
                    // Rec.TestField(Status, Status::"Pending for Approval");
                    IF Rec."Reason Description" = '' then begin
                        If Confirm(Txt002Lbl, false, Rec."Application No.") then begin
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved/Rejected By" := FORMAT(UserId());
                            Rec."Approved/Rejected On" := WorkDate();
                            Rec.Updated := True;
                            Rec.Modify();
                            Message(Txt001Lbl, Rec."Application No.");
                        end;
                    end Else
                        Error('Reason Description must be blank');
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                Visible = ShowButton;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                begin
                    Rec.TestField("Reason Description");
                    Rec.TestField(Status, Rec.Status::"Pending for Approval");
                    If Confirm(Txt003Lbl, false, Rec."Application No.") then begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Updated := True;
                        Rec."Approved/Rejected By" := FORMAT(UserId());
                        Rec."Approved/Rejected On" := WorkDate();
                        Rec.Modify();
                        Message(Txt005Lbl, Rec."Application No.");
                    end;
                end;
            }
        }
    }
    var
        ShowButton: Boolean;
        Txt001Lbl: Label 'Application No. %1 has been approved.';
        Txt002Lbl: Label 'Do you want to approve Application No. %1 ?';
        Txt003Lbl: Label 'Do you want to reject Application No. %1 ?';
        Txt005Lbl: Label 'Application No. %1 has been Rejected.';

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            ShowButton := true
        else
            ShowButton := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            ShowButton := true
        else
            ShowButton := false;
    end;
}
