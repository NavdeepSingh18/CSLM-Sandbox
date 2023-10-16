page 50527 "ELOA Card"
{

    PageType = Card;
    SourceTable = "Student Leave of Absence";
    Caption = 'ELOA Card';
    RefreshOnActivate = True;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Boolean_gBool4;
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
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
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = All;
                }
                field("Last Date Of Attendance"; Rec."Last Date Of Attendance")
                {
                    ApplicationArea = All;
                }

                Field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Types"; Rec."Leave Types")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Caption = 'Created By';
                    Editable = false;
                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                Field("SFP-LOA"; Rec."SFP-LOA")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(HelloSign_Confirmed; Rec.HelloSign_Confirmed)
                {//CSPL-00307-HelloSign_BUG
                    Editable = False;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HelloSign_Confirmed field.';
                }

            }
            // part("Leaves Approval Status"; "Leaves Approval Status")
            // {
            //     visible = Boolean_gBool3;
            //     SubPageLink = "Application No." = FIELD("Application No.");
            //     ApplicationArea = All;
            // }

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
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Boolean_gBool4;
                // trigger OnAction()
                // var
                //     LeaveofApproval_lPage: Page "Leaves Approval Card";
                //     DaysCount_lInt: Integer;
                //     Text50000Lbl: Label 'Do you want to send Application No. %1 for approval?';
                //     Text50001Lbl: Label 'Approval request has been send successfully';
                // begin
                //     Rec.TestField("Reason Description");
                //     Rec.TestField("Start Date");
                //     Rec.TestField("End Date");
                //     DaysCount_lInt := 0;
                //     DaysCount_lInt := Rec."End Date" - Rec."Start Date" + 1;
                //     IF DaysCount_lInt > 180 then
                //         Error('You can not apply leave more then 180 Days');

                //     If Confirm(Text50000Lbl, True, Rec."Application No.") then begin
                //         Rec.Status := Rec.Status::"Pending for Approval";
                //         Rec.Modify();
                //         Rec.PostStudentLeavesApprovalEntries(Rec."Leave Types");
                //         LeaveofApproval_lPage.ELOARequestSend(Rec);
                //         CurrPage.Update();
                //         Message(Text50001Lbl);
                //     end ELSE
                //         exit;
                // end;
            }

        }
    }

    var
        Boolean_gBool3: Boolean;
        Boolean_gBool4: Boolean;


    trigger OnOpenPage()
    begin

        Boolean_gBool3 := false;
        Boolean_gBool4 := true;
        if Rec.Status = Rec.Status::"Pending for Approval" then begin
            Boolean_gBool3 := true;
            Boolean_gBool4 := false;
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Leave Types" := Rec."Leave Types"::ELOA;
    end;

    trigger OnAfterGetRecord()
    Begin

        Boolean_gBool3 := false;
        Boolean_gBool4 := true;
        if Rec.Status = Rec.Status::"Pending for Approval" then begin
            Boolean_gBool3 := true;
            Boolean_gBool4 := false;
        end;
    End;

    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Application Date" <> 0D then begin
            PendingDays := Today() - Rec."Application Date";
            Exit(PendingDays);
        end;
    end;

}

