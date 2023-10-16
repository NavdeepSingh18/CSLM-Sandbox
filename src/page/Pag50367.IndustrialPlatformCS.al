page 50367 "Industrial Platform-CS"
{
    // version V.001-CS

    CardPageID = "Stud. Course Prequalify-CS";
    PageType = List;
    SourceTable = "Industrial-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption='Industrial Platform';
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
            }
        }
    }
}