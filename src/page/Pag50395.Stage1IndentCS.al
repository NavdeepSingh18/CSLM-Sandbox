page 50395 "Stage1 Indent-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      Send A&pproval Request - OnAction()         Code added for send for approval.
    // 02    CSPL-00059   07/02/2019      Issue For - OnValidate()                    Code added for field editble non editble.
    // 03    CSPL-00059   07/02/2019      Same Item - OnValidate()                    Code added for field editble non editble.

    Caption = 'Stage1 Indent-CS';
    PageType = Card;
    SourceTable = "Indent H-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Indent No';
                }
                field("Issue For"; Rec."Issue For")
                {

                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Code added for field editble non editble::CSPL-00059::07022019: Start
                        IF Rec."Issue For" = Rec."Issue For"::"Employee" THEN
                            GVar_Edit := TRUE
                        ELSE
                            GVar_Edit := FALSE;
                        //Code added for field editble non editble::CSPL-00059::07022019: End
                    end;
                }
                field("Issue Id"; Rec."Issue Id")
                {
                    ApplicationArea = All;
                }
                field("Issue Name"; Rec."Issue Name")
                {
                    ApplicationArea = All;
                }
                field("Same Item"; Rec."Same Item")
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit;
                    Enabled = true;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //Code added for field editble non editble::CSPL-00059::07022019: Start
                        IF (Rec."Issue For" = Rec."Issue For"::"Employee") AND (Rec."Same Item" = TRUE) THEN
                            GVar_Edit_Item := TRUE
                        ELSE
                            GVar_Edit_Item := FALSE;
                        //Code added for field editble non editble::CSPL-00059::07022019: End
                    end;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit;
                    Visible = false;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit;
                    Visible = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit;
                    Visible = false;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Code added for send for approval::CSPL-00059::07022019: Start
                    IF Rec.Status = Rec.Status::"Processed for Approval" THEN
                        ERROR(Text0003Lbl);
                    IF CONFIRM(Text0001Lbl, TRUE) THEN BEGIN
                        Rec.Status := Rec.Status::"Processed for Approval";
                        IndentLCS.Reset();
                        IndentLCS.SETRANGE(IndentLCS."Document No", Rec."No.");
                        IF IndentLCS.FindFirst() THEN
                            REPEAT
                                IndentLCS."Indent Status" := IndentLCS."Indent Status"::Indent;
                                IndentLCS.Release := TRUE;
                                IndentLCS.Modify();

                            UNTIL IndentLCS.NEXT() = 0;
                    END;
                    //Code added for send for approval::CSPL-00059::07022019: End
                end;
            }
        }
    }

    var
        IndentLCS: Record "Indent L-CS";
        GVar_Edit: Boolean;
        GVar_Edit_Item: Boolean;
        Text0001Lbl: Label 'Do you want to send  indents for approval?';
        Text0003Lbl: Label 'The indent has already gone for approval';

}