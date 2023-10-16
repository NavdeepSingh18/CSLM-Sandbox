page 50259 "Time Templt Name-CS"
{
    // version V.001-CS
    Caption = 'Time Slot Template';
    CardPageID = "Time Templt Hdr-CS";
    PageType = List;
    SourceTable = "Time Table Template Head-CS";
    SourceTableView = sorting("No.") order(descending);
    ApplicationArea = All;
    UsageCategory = Administration;
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
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
}