page 50792 "FA Refund Master"
{
    Caption = 'FA Refund Master';
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "FA Refund Master";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "FA Refund Master Card";

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field(FaRefundID; Rec.FaRefundID)
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(AdEnrollID; Rec.AdEnrollID)
                {
                    ApplicationArea = All;
                }
                field(AdTermID; Rec.AdTermID)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(CheckNo; Rec.CheckNo)
                {
                    ApplicationArea = All;
                }
                field(DateDue; Rec.DateDue)
                {
                    ApplicationArea = All;
                }
                field(DateSent; Rec.DateSent)
                {
                    ApplicationArea = All;
                }
                field(FaStudentAidID; Rec.FaStudentAidID)
                {
                    ApplicationArea = All;
                }
                field(ReturnMethod; Rec.ReturnMethod)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}