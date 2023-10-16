page 50145 "Stud Placement Card-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = Card;
    SourceTable = "Student Placement History-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Schedule ID"; Rec."Schedule ID")
                {
                    ToolTip = 'Schedule ID';
                    ApplicationArea = All;
                }
                field("Registration ID"; Rec."Registration ID")
                {
                    ToolTip = 'Schedule ID';
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ToolTip = 'Schedule ID';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
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
                field(LOI; Rec.LOI)
                {
                    ToolTip = 'LOI';
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

}

