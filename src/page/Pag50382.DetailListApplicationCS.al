page 50382 "Detail List Application-CS"
{
    // version V.001-CS

    PageType = List;
    SourceTable = "Application-CS";
    SourceTableView = WHERE("Application Status" = FILTER(Received));
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Detail List Application';
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
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }
                field("Date of Sale"; Rec."Date of Sale")
                {
                    ApplicationArea = All;
                }
                field("Date of Receive"; Rec."Date of Receive")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}