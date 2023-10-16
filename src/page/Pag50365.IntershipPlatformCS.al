page 50365 "Intership Platform-CS"
{
    // version V.001-CS

    PageType = List;
    SourceTable = "Student Intership Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Intership Platform';
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
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Industrial Program"; Rec."Industrial Program")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}