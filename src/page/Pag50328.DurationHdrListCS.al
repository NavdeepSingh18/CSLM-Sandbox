page 50328 "Duration Hdr List-CS"
{
    // version V.001-CS

    Caption = 'Duration Hdr List';
    CardPageID = "Duration Generation-CS";
    Editable = false;
    PageType = Card;
    SourceTable = "CBCS Student Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = all;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No.';
                    ApplicationArea = all;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = all;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = all;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ToolTip = 'Semester Code';
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = all;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'No. Series';
                    ApplicationArea = all;
                }
                field("Min Credit"; Rec."Min Credit")
                {
                    ToolTip = 'Min Credit';
                    ApplicationArea = all;
                }
            }
        }
    }
}

