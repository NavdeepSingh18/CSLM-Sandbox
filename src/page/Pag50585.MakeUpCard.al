page 50585 "MakeUp Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Opt Out";
    Caption = 'MakeUp Card';
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
                        If Rec.AssistEdit1(xRec) then
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
                field("ELOA/SLOA No."; Rec."ELOA/SLOA No.")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'ELOA/SLOA No.';
                    TableRelation = "Student Leave of Absence";
                }
                field("Exam Name"; Rec."Exam Name")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Exam Name';
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                    Caption = 'Exam Date';
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
                field("Subject 1"; Rec."Subject 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 1';
                    Editable = Boolean_gBool;

                }
                field("Subject Description 1"; Rec."Subject Description 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 1';
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
                    Text50001Lbl: Label 'Approval request has been send successfully.';
                begin
                    Rec.TestField("Student No.");
                    Rec.TestField("Subject 1");
                    Rec.TestField("ELOA/SLOA No.");
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
        Rec."Application Type" := Rec."Application Type"::"Make-Up";
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