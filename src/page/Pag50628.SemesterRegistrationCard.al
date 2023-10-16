page 50628 "Semester Registration Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Opt Out";
    Caption = 'Semester Registration Card';
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
                        If Rec.AssistEdit(xRec) then
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

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                }
                field("Semester End Date"; Rec."Semester End Date")
                {
                    ApplicationArea = All;
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
                    EducationSetupCS: Record "Education Setup-CS";
                    Text50000Lbl: Label 'Do you want to send Application No. %1 for approval?';
                    Text50001Lbl: Label 'Application No. %1 has been sent for approval.';
                begin
                    Rec.TestField("Application Date");
                    Rec.TestField("Semester Start Date");
                    Rec.TestField("Semester End Date");
                    EducationSetupCS.Reset();
                    EducationSetupCS.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    If EducationSetupCS.FindFirst() Then
                        if Rec."Application Date" <= CALCDATE(EducationSetupCS."Semester Registration Terms", Rec."Semester End Date") then begin
                            If Confirm(Text50000Lbl, FALSE, Rec."Application No.") then begin
                                Rec.Status := Rec.Status::"Pending for Approval";
                                Rec.Modify();
                                CurrPage.Update();
                                Message(Text50001Lbl, Rec."Application No.");
                            end else
                                exit;
                        end else
                            Error('Registration Days are closed')
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
                    Text50000Lbl: Label 'Do you want to approve Application No. %1?';
                    Text50001Lbl: Label 'Application No. %1 has been approved.';
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
                    Text50000Lbl: Label 'Do you want to reject Application No. %1?';
                    Text50001Lbl: Label 'Application No. %1 has been rejected.';
                begin
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        Rec.TestField("Reason Description");
                        If Confirm(Text50000Lbl, true) then begin
                            Rec.Status := Rec.Status::Rejected;
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
        Rec."Application Type" := Rec."Application Type"::"Semester Registration";
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