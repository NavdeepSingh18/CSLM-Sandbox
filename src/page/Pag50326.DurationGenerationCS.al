page 50326 "Duration Generation-CS"
{
    // version V.001-CS

    Caption = 'Duration Generation';
    PageType = Card;
    SourceTable = "CBCS Student Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Total no of Elective"; Rec."Total no of Elective")
                {
                    ToolTip = 'Total no of Elective';
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
                field("Credit Acheived"; Rec."Credit Acheived")
                {
                    ToolTip = 'Credit Acheived';
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ToolTip = 'Section Code';
                    ApplicationArea = all;
                    //BlankZero = true;
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
            part("Period Generation Subform"; 50327)
            {
                ApplicationArea = All;
                ToolTip = 'Period Generation Subform';
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }





}

