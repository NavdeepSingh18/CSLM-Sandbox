page 50530 "Approved Rejected Leave Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Student Leave of Absence";
    Editable = true;
    DeleteAllowed = false;
    Caption = 'Approved Rejected Leave Card';
    SourceTableView = where(status = Filter(Approved | Cancelled));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = FieldEdit;
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
                field("Leave Types"; Rec."Leave Types")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Types';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Student Affairs Dept."; Rec."Student Affairs Dept.")
                {
                    ApplicationArea = All;
                    Caption = 'Student Affairs Department';
                    Visible = false;
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
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved By';
                    Editable = False;
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = All;
                    Caption = 'Approved on';
                    Editable = false;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected By';
                    Editable = False;
                }
                field("Rejected On"; Rec."Rejected On")
                {
                    ApplicationArea = All;
                    Caption = 'Rejected On';
                    Editable = False;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Style = Strong;
                    StyleExpr = TRUE;
                }

            }
            // part("Leaves Approval Status"; "Leaves Approval Status")
            // {
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
            action("&Reopen")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Reopen';
                trigger OnAction()
                Var
                    departmentmaster: Record "Withdrawal Department";
                    leavesapproval: Record "Leaves Approvals";
                    Text50000Lbl: Label 'Do you want to Reopen the Application No. %1';
                    Text50001Lbl: Label 'The Application No. %1 is Reopen Successfully.';
                begin
                    UserSetupRec.Get(UserId());
                    if not UserSetupRec."Leaves Of Absence" then
                        Error('You donot have permission to Reopen the Document.');
                    if Confirm(Text50000Lbl, false, Rec."Application No.") then begin
                        if (Rec."Leave Types" = Rec."Leave Types"::CLOA) then begin
                            Rec.Reopen := true;
                            rec.Status := rec.Status::"Pending for Approval";
                            rec.validate(Status);
                            Rec.Modify();

                            departmentmaster.Reset();
                            departmentmaster.setrange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            departmentmaster.SetRange("Document Type", Rec."Leave Types");
                            departmentmaster.SetRange("Department Code", '8006');
                            if departmentmaster.FindFirst() then begin
                                leavesapproval.Reset();
                                leavesapproval.setrange("Application No.", Rec."Application No.");
                                leavesapproval.SetRange("Approved for Department", departmentmaster."Department Code");
                                leavesapproval.SetRange("Global Dimension 1 Code", departmentmaster."Global Dimension 1 Code");
                                leavesapproval.SetRange("Type of Leaves", Rec."Leave Types");
                                if leavesapproval.findfirst() then begin
                                    leavesapproval.Status := leavesapproval.Status::"Pending for Approval";
                                    leavesapproval.Modify(true);
                                end;
                            end;
                        end else begin
                            Rec.Reopen := true;
                            Rec.Modify();
                        end;
                        CurrPage.Update();
                        Message(Text50001Lbl, Rec."Application No.");
                    end else
                        exit;
                end;
            }
            action("&Release")
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Release';
                trigger OnAction()
                Var
                    Text50000Lbl: Label 'Do you want to Release the Application No. %1';
                    Text50001Lbl: Label 'The Application No. %1 is Release Successfully.';
                begin
                    UserSetupRec.Get(UserId());
                    if not UserSetupRec."Leaves Of Absence" then
                        Error('You donot have permission to Release the Document.');

                    if Confirm(Text50000Lbl, false, Rec."Application No.") then begin
                        Rec.Reopen := false;
                        Rec.Modify();
                        CurrPage.Update();
                        Message(Text50001Lbl, Rec."Application No.");
                    end else
                        exit;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FieldEdit := false;
        if Rec.Reopen then
            FieldEdit := true;
    end;

    trigger OnAfterGetRecord()
    begin
        FieldEdit := false;
        if Rec.Reopen then
            FieldEdit := true;
    end;

    var
        UserSetupRec: Record "User Setup";
        FieldEdit: Boolean;

}