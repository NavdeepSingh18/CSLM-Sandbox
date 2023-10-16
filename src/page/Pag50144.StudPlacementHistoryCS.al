page 50144 "Stud Placement History-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Stud Plac. History Card-CS";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Student Placement History-CS";
    SourceTableView = WHERE(Closed = FILTER(False));
    caption = 'Stud Placement History';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Registration ID"; Rec."Registration ID")
                {
                    ToolTip = 'Registration ID';
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ToolTip = 'Student ID';
                    ApplicationArea = All;
                }
                field("Company Id"; Rec."Company Id")
                {
                    ToolTip = 'Company Id';
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Company Name';
                    ApplicationArea = All;
                }
                field("Campus Date"; Rec."Campus Date")
                {
                    ToolTip = 'Campus Date';
                    ApplicationArea = All;
                }
                field("Exam Clear"; Rec."Exam Clear")
                {
                    ToolTip = 'Exam Clear';
                    ApplicationArea = All;
                }
                field("Technical Clear"; Rec."Technical Clear")
                {
                    ToolTip = 'Technical Clear';
                    ApplicationArea = All;
                }
                field("HR Clear"; Rec."HR Clear")
                {
                    ToolTip = 'HR Clear';
                    ApplicationArea = All;
                }
                field(Placed; Rec.Placed)
                {
                    ToolTip = 'Placed';
                    ApplicationArea = All;
                }
                field("Offer Letter"; Rec."Offer Letter")
                {
                    ToolTip = 'Offer Letter';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

