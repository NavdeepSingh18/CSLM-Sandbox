page 50390 "Clinical Notification Info"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Email Notification";
    SourceTableView = where(Type = filter('CLINICAL'));
    Caption = 'Clinical Notification Information';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }
                field(ReceiverName; Rec.ReceiverName)
                {
                    ApplicationArea = All;
                }
                field(ReceiverId; Rec.ReceiverId)
                {
                    ApplicationArea = All;
                }
                field("Receiver Email Id"; Rec."Receiver Email Id")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field("Process No"; Rec."Process No")
                {
                    ApplicationArea = All;
                }
                field("Email Sent Datetime"; Rec."Email Sent Datetime")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}