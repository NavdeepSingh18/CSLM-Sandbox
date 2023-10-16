page 51026 "Student Wise Goal List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Wise Goal";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field("Goal Code"; Rec."Goal Code")
                {
                    ApplicationArea = All;
                }
                Field("Goal Description"; Rec."Goal Description")
                {
                    ApplicationArea = All;
                }
                Field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                Field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                Field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                Field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                Field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                Field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                }
                Field("Time Table Doc No."; Rec."Time Table Doc No.")
                {
                    ApplicationArea = All;
                }
                Field("Time Table Line No."; Rec."Time Table Line No.")
                {
                    ApplicationArea = All;
                }
                Field("Final Time Table No."; Rec."Final Time Table No.")
                {
                    ApplicationArea = All;
                }
                Field("Grouping No."; Rec."Grouping No.")
                {
                    ApplicationArea = All;
                }
                Field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}