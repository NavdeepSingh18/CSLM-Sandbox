page 50398 "Issues Stage1-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Issues Stage1-CS';
    CardPageID = "Issues Header Stage1-CS";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    Permissions =;
    SourceTable = "Indent H-CS";
    SourceTableView = WHERE(Status = FILTER(Approved));

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
                field("Issue For"; Rec."Issue For")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var

}