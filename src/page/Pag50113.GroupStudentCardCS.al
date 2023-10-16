page 50113 "Group(Student) Card-CS"
{
    // version V.001-CS

    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Group Student-CS";
Caption='Group(Student) Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Group Code Description"; Rec."Group Code Description")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
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
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("No. Of Student"; Rec."No. Of Student")
                {
                    ApplicationArea = All;
                }
                field("Available Student"; Rec."Available Student")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

