page 50343 "Staff Usual Record List -CS"
{
    // version V.001-CS

    Caption = 'Staff Usual Record List';
    CardPageID = "Staff Usual Rec Hdr-CS";
    Editable = true;
    PageType = List;
    SourceTable = "Course Plan Head Faculty-CS";
    SourceTableView = WHERE("Plan Status" = FILTER(Approved));
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
                field("Course Code"; Rec."Course Code")
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Plan Status"; Rec."Plan Status")
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

