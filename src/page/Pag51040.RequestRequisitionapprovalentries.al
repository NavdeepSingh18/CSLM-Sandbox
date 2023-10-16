page 51040 "Request Req. Approval Entries"
{

    ApplicationArea = All;
    Caption = 'Request Requisition approval entries';
    PageType = List;
    SourceTable = "Requisition Approval entries";
    UsageCategory = History;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Status = filter(Open));
    RefreshOnActivate = true;
    // Editable = False;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Approval User ID"; Rec."Approval User ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Item code"; Rec."Item code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ToolTip = 'Specifies the value of the Stock In Hand field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requested Qty."; Rec."Requested Qty.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Unit of Meassure Code"; Rec."Unit of Meassure Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Budget Code"; Rec."Budget Code")
                {
                    ApplicationArea = All;
                    // Editable = "Budget Edit";
                    //Editable = false;
                }
                Field("Budget Description"; Rec."Budget Description")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Requested User"; Rec."Requested User")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    //CSPL-00307
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                }
                field(Preferences; Rec.Preferences)
                {
                    ToolTip = 'Specifies the value of the Preferences field.';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';

                trigger OnAction()
                begin
                    if Confirm('Do you want to approve ?', false) then begin
                        CurrPage.SetSelectionFilter(rec);
                        if rec.findset() then
                            repeat
                                Rec.RequestApproveEntry(Rec);
                            until rec.Next() = 0;
                        Rec.Reset();
                        Rec.FilterGroup(4);
                        rec.SetRange(Status, Rec.Status::Open);
                        rec.SetFilter("Approval User ID", UserId());//
                        Rec.FilterGroup(5);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Requisition Approval Mgnt";
                begin
                    if Confirm('Do you want to reject ?', false) then begin
                        CurrPage.SetSelectionFilter(rec);
                        if rec.findset() then
                            repeat
                                // ApprovalsMgmt.ApproveRejectRequest(Rec, False, True);
                            until rec.Next() = 0;
                        Rec.Reset();
                        Rec.FilterGroup(4);
                        rec.SetRange(Status, Rec.Status::Open);
                        rec.SetFilter("Approval User ID", UserId());//
                        Rec.FilterGroup(5);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(4);
        Rec.SetFilter(Rec."Approval User ID", UserId());
        Rec.FilterGroup(5);
    end;


}