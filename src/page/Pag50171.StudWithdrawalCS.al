page 50171 "Stud. Withdrawal-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       Approve - OnAction()                      Use for Approve .net function
    // 02    CSPL-00059   07/01/2019       Reject - OnAction()                       Use for Reject.net function

    PageType = Document;
    UsageCategory = None;
    SourceTable = "Withdrawal Student-CS";
    Caption = 'Withdrawal Application Form Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Boolean_gBool2;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit() THEN
                            CurrPage.UPDATE();

                    end;
                }
                field("Application Date"; Rec."Application Date")
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
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                // field(Section; Rec.Section)
                // {
                //     ApplicationArea = All;
                // }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal date"; Rec."Withdrawal date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Withdrawal Status"; Rec."Withdrawal Status")
                {
                    ApplicationArea = All;
                }
                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

            }
            part("Withdrawal Approval Status"; "Withdrawal Approval Status")
            {
                visible = Boolean_gBool1;
                SubPageLink = "Withdrawal No." = FIELD("No.");
                ApplicationArea = All;
            }
            group("Bank Details")
            {
                Visible = false;

                field("Bank Acc Holder Name"; Rec."Bank Acc Holder Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No/IBAN Number"; Rec."Bank Account No/IBAN Number")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("IFSC Code Number/Swift Code"; Rec."IFSC Code Number/Swift Code")
                {
                    ApplicationArea = All;
                }
                field(Refund; Rec.Refund)
                {
                    ApplicationArea = All;
                }


            }
        }
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
            action("Student Subject")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject';
                // Runobject = page "Withdrawal Student Subject";
                // RunPageLink = "Withdrawal Request No." = field("No."), "Student No." = FIELD("Student No.");
            }
            action("Send for Approval")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Send for Approval';
                Visible = Boolean_gBool;
                trigger OnAction()
                begin
                    //TestField("Withdrawal date");
                    IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                        Rec.TestField("No.");
                        Rec.TestField("Reason for Leaving");

                        WithdrawalStudentSubjectRec.Reset();
                        WithdrawalStudentSubjectRec.Setrange("Withdrawal Request No.", Rec."No.");
                        WithdrawalStudentSubjectRec.SetFilter("Subject Code", '<>%1', '');
                        if not WithdrawalStudentSubjectRec.FindFirst() then
                            Error('Student Subject must have value in it.');

                        if Rec.Course = '' then
                            Error('Course must have a value in it');

                        Rec."Withdrawal Status" := Rec."Withdrawal Status"::"Pending for Approval";
                        Rec.Modify();
                        Rec.PostStudentWithdrawalApprovalEntries(Rec."Type of Withdrawal");
                        Message(Text002Lbl, Rec."No.");
                    END ELSE
                        exit;
                end;


            }
        }
    }

    var

        WithdrawalStudentSubjectRec: Record "Withdrawal Student Subject";
        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;
        Boolean_gBool2: Boolean;
        Text001Lbl: Label 'Do you want to send Application No. %1 for approval?';
        Text002Lbl: Label 'Application No. %1 has been sent for approval.';


    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        Rec."Type of Withdrawal" := Rec."Type of Withdrawal"::"Course-Withdrawal";
    end;

    trigger OnOpenPage()
    begin
        Boolean_gBool := false;
        If Rec."Withdrawal Status" = Rec."Withdrawal Status"::Open then
            Boolean_gBool := true;

        Boolean_gBool1 := false;
        Boolean_gBool2 := true;
        If (Rec."Withdrawal Status" = Rec."Withdrawal Status"::"Pending for Approval") or (Rec."Withdrawal Status" = Rec."Withdrawal Status"::Rejected) OR (Rec."Withdrawal Status" = Rec."Withdrawal Status"::Approved) then begin
            Boolean_gBool1 := true;
            Boolean_gBool2 := false;
        end;
    end;

    trigger OnAfterGetRecord()
    Begin
        Boolean_gBool := false;
        If Rec."Withdrawal Status" = Rec."Withdrawal Status"::Open then
            Boolean_gBool := true;

        Boolean_gBool1 := false;
        Boolean_gBool2 := true;
        If (Rec."Withdrawal Status" = Rec."Withdrawal Status"::"Pending for Approval") or (Rec."Withdrawal Status" = Rec."Withdrawal Status"::Rejected) then begin
            Boolean_gBool1 := true;
            Boolean_gBool2 := false;
        end;

    End;

}