page 50877 "Document Approver User List"
{
    Caption = 'Document Approver User List';
    PageType = List;
    SourceTable = "Document Approver Users";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Department Approver Type"; Rec."Department Approver Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
