page 51024 "Email Setup Lists"
{
    Caption = 'Employee Email Alert Setup';
    PageType = List;
    SourceTable = "EMail Setup";
    UsageCategory = None;
    SourceTableView = sorting("Employee No.") order(Ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Department Type"; Rec."Department Type")
                {
                    ApplicationArea = All;
                }
                field("Email Alert Type"; Rec."Email Alert Type")
                {
                    ApplicationArea = All;
                }
                field("Email Enabled"; Rec."Email Enabled")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}