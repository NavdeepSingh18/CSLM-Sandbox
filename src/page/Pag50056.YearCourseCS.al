page 50056 "Year Course-CS"
{
    // version V.001-CS

    Caption = 'Year Course';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Course Year Master-CS";

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Year Code"; Rec."Year Code")
                {
                    ApplicationArea = All;
                    Caption = 'Year Code';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Sequence No"; Rec."Sequence No")
                {
                    ApplicationArea = All;
                    Caption = 'Sequence No';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
        }
    }
}
