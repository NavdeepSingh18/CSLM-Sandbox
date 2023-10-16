page 50371 "Disciplinery Student List-CS"
{
    // version V.001-CS

    PageType = List;
    SourceTable = "Student Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Disciplinery Student List';
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
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
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
}