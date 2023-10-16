page 50187 "Sub Batch Student Up List-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Main Batch Update-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Student No.';
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ToolTip = 'Enrollment No.';
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Section';
                    ApplicationArea = All;
                }
                field("Roll No"; Rec."Roll No")
                {
                    ToolTip = 'Roll No';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ToolTip = 'Subject Code';
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ToolTip = 'Batch';
                    ApplicationArea = All;
                }
                field("Not Updated"; Rec."Not Updated")
                {
                    ToolTip = 'Not Updated';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("IMPORT/EXPORT DATA")
            {
                ToolTip = 'IMPORT/EXPORT DATA';
                Image = ImportExport;
                Promoted = true;
                promotedOnly = True;
                RunObject = XMLport 50013;
                ApplicationArea = All;
            }
            action("Update Student Subject Information")
            {
                ToolTip = 'Update Student Subject Information';
                Image = Apply;
                Promoted = true;
                PromotedOnly = true;
                RunObject = Report 50028;
                ApplicationArea = All;
            }
        }
    }
}

