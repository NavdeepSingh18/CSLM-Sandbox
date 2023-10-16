page 50539 "Exam Opt Out Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Opt Out";
    Caption = 'Exam Opt Out Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                    Editable = Boolean_gBool;
                    Importance = Standard;

                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit2(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Application Date';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Application Type';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Student No.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Student Name';
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Semester';
                }
                field("Subject 1"; Rec."Subject 1")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Subject 1';

                }
                field("Subject Description 1"; Rec."Subject Description 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 1';
                }
                field("Subject 2"; Rec."Subject 2")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Subject 2';

                }
                field("Subject Description 2"; Rec."Subject Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 2';
                }
                field("Subject 3"; Rec."Subject 3")

                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Subject 3';

                }
                field("Subject Description 3"; Rec."Subject Description 3")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 3';
                }
                field("Subject 4"; Rec."Subject 4")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Subject 4';

                }
                field("Subject Description 4"; Rec."Subject Description 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 4';
                }
                field("Subject 5"; Rec."Subject 5")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Subject 5';

                }
                field("Subject Description 5"; Rec."Subject Description 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 5';
                }

                field("Approved Condition Failed"; Rec."Approved Condition Failed")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Approved Condition Failed';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                    Editable = Boolean_gBool1;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';
                    Editable = Boolean_gBool1;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected By';
                    Editable = False;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected On';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Visible = Boolean_gBool;
                trigger OnAction()
                var
                    Text50000Lbl: Label 'Do you want to Send Approval Request ?';
                    Text50001Lbl: Label 'Approval request has been send successfully';
                    Text60001Lbl: Label 'At least one subject must be filled out';
                begin
                    If Rec."Application Type" = Rec."Application Type"::"Bsic Opt Out" then
                        IF (Rec."Subject 1" = '') and (Rec."Subject 2" = '') and (Rec."Subject 3" = '') and (Rec."Subject 4" = '') and (Rec."Subject 5" = '') THEN
                            Error(Text60001Lbl);

                    If Confirm(Text50000Lbl, True) then begin
                        Rec.Status := Rec.Status::"Pending for Approval";
                        Rec.Modify();
                        CurrPage.Update();
                        Message(Text50001Lbl);
                    end ELSE
                        exit;
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Visible = Boolean_gBool1;
                trigger OnAction()
                var
                    Text50000Lbl: Label 'Do you want to approve ?';
                    Text50001Lbl: Label 'Request has been Approved';
                begin
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        If Confirm(Text50000Lbl, true) then begin
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := WorkDate();
                            Rec.Modify();
                            CurrPage.Update();
                            Message(Text50001Lbl);
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Visible = Boolean_gBool1;
                trigger OnAction()
                var
                    Text50000Lbl: Label 'Do you want to reject ?';
                    Text50001Lbl: Label 'Request has been Rejected';
                begin
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        Rec.TestField("Reason Description");
                        If Confirm(Text50000Lbl, true) then begin
                            Rec.Status := Rec.Status::Rejected;
                            // RejectMail(Rec);
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := Workdate();
                            Rec.Modify();
                            CurrPage.Update();
                            Message(Text50001Lbl);
                            CurrPage.Close();
                        end;
                    End;
                end;
            }
        }
    }

    var
        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;

    trigger OnOpenPage()
    begin
        Boolean_gBool := false;
        If Rec.Status = Rec.Status::Open then
            Boolean_gBool := true;

        Boolean_gBool1 := false;
        If Rec.Status = Rec.Status::"Pending for Approval" then begin
            Boolean_gBool1 := true;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    Begin
        Rec."Application Type" := Rec."Application Type"::"Bsic Opt Out";
    End;

    trigger OnAfterGetRecord()
    Begin
        Boolean_gBool := false;
        If Rec.Status = Rec.Status::Open then
            Boolean_gBool := true;

        Boolean_gBool1 := false;
        If Rec.Status = Rec.Status::"Pending for Approval" then
            Boolean_gBool1 := true;
    End;

}