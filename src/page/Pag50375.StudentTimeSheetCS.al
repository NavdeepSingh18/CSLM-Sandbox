page 50375 "Student Time Sheet-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = Card;
    SourceTable = "Generated Time Table-CS";
    Caption='Student Time Sheet';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                }
                field("Day No"; Rec."Day No")
                {
                    ApplicationArea = All;
                }
                field("Hour No"; Rec."Hour No")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Room Allocation"; Rec."Room Allocation")
                {
                    ApplicationArea = All;
                }
                field("Time Duration"; Rec."Time Duration")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}