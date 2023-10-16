page 50684 "Stud. College Withdrawal-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       Approve - OnAction()                      Use for Approve .net function
    // 02    CSPL-00059   07/01/2019       Reject - OnAction()                       Use for Reject.net function

    PageType = Card;
    UsageCategory = None;
    SourceTable = "Withdrawal Student-CS";
    Caption = 'Student College Withdrawal List';

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = Boolean_gBool2;//GMCSCOM
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit() THEN
                            CurrPage.Update();
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
                // field(Section;Rec.Section)
                // {
                //     ApplicationArea = All;
                // }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal date"; Rec."Withdrawal date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(HelloSign_Confirmed; Rec.HelloSign_Confirmed)
                {//CSPL-00307-HelloSign_BUG
                    Editable = False;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HelloSign_Confirmed field.';
                }
            }
            part("Approval Status"; "Withdrawal Approval Status")
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
            action("Send for Approval")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Send for Approval';

                trigger OnAction()
                begin
                    //TestField("Withdrawal date");
                    IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                        Rec.TestField("Reason for Leaving");
                        // if Course = '' then
                        //     Error('Course must have a value in it');

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
        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;
        Boolean_gBool2: Boolean;
        Text001Lbl: Label 'Do you want to send Application No. %1 for approval?';
        Text002Lbl: Label 'Application No. %1 has been sent for approval.';

    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        Rec."Type of Withdrawal" := Rec."Type of Withdrawal"::"College-Withdrawal";
    end;

    trigger OnOpenPage()
    begin
        Boolean_gBool := false;
        If Rec."Withdrawal Status" = Rec."Withdrawal Status"::Open then
            Boolean_gBool := true;

        Boolean_gBool1 := false;
        Boolean_gBool2 := true;
        If (Rec."Withdrawal Status" = Rec."Withdrawal Status"::"Pending for Approval") OR (Rec."Withdrawal Status" = Rec."Withdrawal Status"::Approved) then begin
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
        If Rec."Withdrawal Status" = Rec."Withdrawal Status"::"Pending for Approval" then begin
            Boolean_gBool1 := true;
            Boolean_gBool2 := false;
        end;

    End;


}