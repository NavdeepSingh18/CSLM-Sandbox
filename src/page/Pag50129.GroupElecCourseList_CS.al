page 50129 "Group (Elec. Course) List_CS"
{
    // version V.001-CS

    DelayedInsert = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Elective Group Course-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Elective Group Code"; Rec."Elective Group Code")
                {
                    ApplicationArea = All;
                }
                field("Elective Group Description"; Rec."Elective Group Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

