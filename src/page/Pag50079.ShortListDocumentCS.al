page 50079 "Short List Document-CS"
{
    // version V.001-CS

    PageType = List;
    SourceTable = "Short Attendance Attach-CS";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ToolTip = 'Subject Code"';
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ToolTip = 'Application No.';
                    ApplicationArea = All;
                }
                field("Document Path"; Rec."Document Path")
                {
                    ToolTip = 'Document Path';
                    ApplicationArea = All;
                }
                field("Document Name"; Rec."Document Name")
                {
                    ToolTip = 'Document Name';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Global Dimension 2 Code';
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Created By';
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Created Date';
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ToolTip = 'Updated By';
                    ApplicationArea = All;
                }
                field("Updated Date"; Rec."Updated Date")
                {
                    ToolTip = 'Updated Date';
                    ApplicationArea = All;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ToolTip = 'Document Description"';
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ToolTip = 'Subject Type';
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Section';
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ToolTip = 'Type Of Course';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line No.';
                }
            }
        }
    }
}