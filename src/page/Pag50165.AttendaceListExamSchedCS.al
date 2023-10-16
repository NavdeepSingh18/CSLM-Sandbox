page 50165 "Attendace List Exam Sched-CS"
{
    // version V.001-CS

    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Exam Time Table Head-CS";
    SourceTableView = WHERE("Ext Exam Attendance No." = FILTER(<> ''));

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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Ext Exam Attendance No."; Rec."Ext Exam Attendance No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

