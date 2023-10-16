page 50537 "Financial Accountability Card"
{

    PageType = Card;
    SourceTable = "Financial Accountability";
    Caption = 'Financial Accountability Card';
    RefreshOnActivate = true;
    DeleteAllowed = false;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Fine Application No."; Rec."Fine Application No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                Field("Fine Date"; Rec."Fine Date")
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Code"; Rec."Fine Category Code")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Description"; Rec."Fine Category Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Applicable Amount"; Rec."Applicable Amount")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
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
            action("Send For Approval")
            {
                ApplicationArea = All;
                Caption = 'Send For Approval';
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Completed;
                trigger OnAction()
                begin
                    Rec.TestField("Student No.");
                    Rec.Testfield("Fine Category Code");
                    IF Rec."Applicable Amount" <> 0 then begin
                        If Confirm(Text001Lbl, false, Rec."Fine Application No.") then begin
                            Rec.Status := Rec.Status::"Pending for Approval";
                            Rec.Modify();
                            // ApprovalRequestMail();
                            Message(Text002Lbl, Rec."Fine Application No.");
                            CurrPage.Close();
                        end;
                    end else
                        Error('Applicable Amount must have a value');
                end;
            }
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
        }

    }
    var
        Text001Lbl: Label 'Do you want to send Application No. %1 for approval?';
        Text002Lbl: Label 'Application No. %1 has been sent for approval.';

}

