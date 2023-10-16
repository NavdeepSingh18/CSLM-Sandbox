page 50377 "Portal Sign-In-CS"
{
    // version V.001-CS

    PageType = List;
    SourceTable = "Industrial-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Portal Sign-In';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}