page 51075 StudentSemesterDecisionCard
{
    PageType = Card;
    SourceTable = StudentSemesterDecision;
    Caption = 'Student Semester Decision Card';


    layout
    {
        area(Content)
        {
            group(Decision)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = all;
                    Editable = OpenButtonShow;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = all;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }

                field("Decision Type"; Rec."Decision Type")
                {
                    ApplicationArea = all;
                    // Editable = OpenButtonShow;
                    Editable = false;
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Decision Time"; Rec."Decision Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }






                field("Previous SAP"; Rec."Previous SAP")
                {
                    ApplicationArea = all;
                }

                field("Calculated SAP"; Rec."Calculated SAP")
                {
                    ApplicationArea = all;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }

        }

    }

    actions
    {
        area(Processing)
        {
            group("Decisions")
            {
                action("Send For Approval")
                {
                    ApplicationArea = all;
                    Promoted = True;
                    PromotedOnly = true;
                    Visible = OpenButtonShow;
                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send Decision No. %1 for Approval?', false, Rec."Document No.") then
                            Rec.SendForApproval(Rec);
                        if Rec.Status = Rec.Status::"Pending For Approval" then
                            Message('Application has been sent for Approval');
                    end;
                }
                action("Approve Document")
                {
                    ApplicationArea = all;
                    Promoted = True;
                    PromotedOnly = true;
                    Visible = PendButtonShow;
                    trigger OnAction()
                    var
                        StudentTimeLineRec: Record "Student Time Line";
                    begin
                        if Confirm('Do you want to Approve Decision No. %1 ?', false, Rec."Document No.") then
                            Rec.ApproveDocs(Rec, 1);
                        StudentTimeLineRec.InsertRecordFun(Rec."Document No.", Rec."Student Name", Format(Rec."Decision Type") + ' Application approved by ' + UserId(), UserId(), Today());
                        if Rec.Status = Rec.Status::Approved then
                            Message('Application has been Approved');
                    end;
                }
                action("Reject Document")
                {
                    ApplicationArea = all;
                    Promoted = True;
                    PromotedOnly = true;
                    Visible = PendButtonShow;
                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Reject Decision No. %1 ?', false, Rec."Document No.") then
                            Rec.ApproveDocs(Rec, 2);
                        if Rec.Status = Rec.Status::Rejected then
                            Message('Application has been Rejected');
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        OpenButtonShow := false;
        PendButtonShow := false;

        if Rec.Status = Rec.Status::Open then
            OpenButtonShow := true
        else
            if Rec.Status = Rec.Status::"Pending For Approval" then
                PendButtonShow := true;

    end;

    var
        DocAppUser: Record "Document Approver Users";
        OpenButtonShow: Boolean;
        PendButtonShow: Boolean;



}