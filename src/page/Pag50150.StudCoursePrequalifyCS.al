page 50150 "Stud. Course Prequalify-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Course Prequalification-COL';
    PageType = List;
    SourceTable = "Education Setup-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Key"; Rec."Primary Key")
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

