page 50655 "Payment Plan Application"
{

    PageType = Card;
    SourceTable = "Financial AID";
    Caption = 'Payment Plan Application';
    UsageCategory = none;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                    Editable = Boolean_gBool1;
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
                    Caption = 'Application Date';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = PPlanBool1;
                    trigger OnValidate()
                    begin
                        If Rec.Type = Rec.Type::"Financial Aid" then
                            Error('You can only select Payment Plan & Self Payment');

                        PPlanBool := false;
                        If Rec.Status = Rec.Status::"Pending for Approval" then begin
                            If Rec.Type = Rec.Type::"Payment Plan" then
                                PPlanBool := true;
                        end;
                    end;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Plan Instalment';
                    Editable = PPlanBool;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool1;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Global Dimension 1 Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Global Dimension 2 Code';
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                Image = Approve;
                Visible = Boolean_gBool1;
                trigger OnAction()
                var
                    Text50000Lbl: Label 'Do you want to approve ?';
                    Text50001Lbl: Label 'Request has been Approved';
                begin
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        If Confirm(Text50000Lbl, true) then begin
                            If Rec.Type = Rec.Type::"Payment Plan" then
                                Rec.TestField("Payment Plan Instalment");
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := WorkDate();
                            Rec.Modify();
                            recStudentMaster.Reset();
                            recStudentMaster.SetRange("No.", Rec."Student No.");
                            recStudentMaster.SetRange("Academic Year", Rec."Academic Year");
                            recStudentMaster.SetRange(Semester, Rec.Semester);
                            IF recStudentMaster.FindFirst() then begin
                                IF Rec."Type" = Rec."Type"::"Self Payment" then
                                    recStudentMaster.Validate(recStudentMaster."Self Payment Applied", True);
                                IF Rec."Type" = Rec."Type"::"Payment Plan" then begin
                                    recStudentMaster.Validate(recStudentMaster."Payment Plan Applied", True);
                                    recStudentMaster.Validate(recStudentMaster."Payment Plan Instalment", Rec."Payment Plan Instalment");
                                end;
                                recStudentMaster.Modify();
                            end;
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
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := Workdate();
                            Rec.Modify();
                            CurrPage.Update();
                            // Rec.FinancialAIDRequestRejected(Rec."Application No.", Rec.Type);
                            Message(Text50001Lbl);
                            CurrPage.Close();
                        end;
                    End;
                end;
            }
        }
    }

    var
        recStudentMaster: Record "Student Master-CS";
        Boolean_gBool1: Boolean;
        PPlanBool: Boolean;
        PPlanBool1: Boolean;

    trigger OnOpenPage()
    begin

        Boolean_gBool1 := false;
        If Rec.Status = Rec.Status::"Pending for Approval" then begin
            Boolean_gBool1 := true;
        end;

        PPlanBool := false;
        If Rec.Status = Rec.Status::"Pending for Approval" then begin
            If Rec.Type = Rec.Type::"Payment Plan" then
                PPlanBool := true;
        end;

        If Rec.Status = Rec.Status::"Pending for Approval" then begin
            PPlanBool1 := true
        end Else
            PPlanBool1 := false;

    end;


    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        Rec.Type := Rec.Type::"Self Payment";
    end;

    trigger OnAfterGetRecord()
    Begin
        Boolean_gBool1 := false;
        If Rec.Status = Rec.Status::"Pending for Approval" then
            Boolean_gBool1 := true;

        PPlanBool := false;
        If Rec.Status = Rec.Status::"Pending for Approval" then begin
            If Rec.Type = Rec.Type::"Payment Plan" then
                PPlanBool := true;
        end;

        If Rec.Status = Rec.Status::"Pending for Approval" then begin
            PPlanBool1 := true
        end Else
            PPlanBool1 := false;
    End;
}
