page 50402 "Approvals Indent -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       Approve Indent - OnAction()                 Code added for indent approval.
    // 02    CSPL-00059   07/02/2019       Cancel Indent Request - OnAction()          Code added for indent cancel.
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Indent H-CS";
    SourceTableView = WHERE(Status = FILTER("Processed for Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Issue For"; Rec."Issue For")
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
            group(Group1)
            {
                action("Approve Indent")
                {
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for indent approval::CSPL-00059::07022019: Start
                        CurrPage.SETSELECTIONFILTER(IndentHCS);
                        IF IndentHCS.FindSet() THEN
                            REPEAT
                                IndentHCS.Status := IndentHCS.Status::Approved;
                                IndentHCS.Modify();
                            UNTIL IndentHCS.NEXT() = 0;
                        //Code added for indent approval::CSPL-00059::07022019: End
                    end;
                }
                separator(Separator)
                {
                }
                action("Cancel Indent Request")
                {
                    Caption = 'Cancel Indent';
                    Image = Cancel;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for indent cancel::CSPL-00059::07022019: Start
                        CurrPage.SETSELECTIONFILTER(IndentHCS1);
                        IF IndentHCS1.FindSet() THEN
                            REPEAT
                                IndentHCS1.Status := IndentHCS1.Status::Rejected;
                                IndentHCS1.Modify();
                                IndentLCS.Reset();
                                IF IndentLCS.FINDSET() THEN
                                    REPEAT
                                        IF IndentLCS."Indent Status" = IndentLCS."Indent Status"::Indent THEN BEGIN
                                            IndentLCS.Cancel := TRUE;
                                            IndentLCS."Posting Date" := WORKDATE();
                                            IndentLCS.Modify();
                                        END;
                                    UNTIL IndentLCS.NEXT() = 0;
                            UNTIL IndentHCS1.NEXT() = 0;
                        //Code added for indent cancel::CSPL-00059::07022019: End
                    end;
                }
            }
        }
    }

    var
        IndentHCS: Record "Indent H-CS";

        IndentHCS1: Record "Indent H-CS";
        IndentLCS: Record "Indent L-CS";
}