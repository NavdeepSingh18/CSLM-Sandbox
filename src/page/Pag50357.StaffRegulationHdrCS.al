page 50357 "Staff Regulation Hdr-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Staff Regulation Hdr-CS';
    PageType = Card;
    SourceTable = "Employee";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
            }
            part("Staff Course Plan Hdr-CS"; "Staff Regulation Subpage-CS")
            {
                ApplicationArea = All;
                SubPageLink = "Staff No." = FIELD("No.");
            }
        }
    }
}