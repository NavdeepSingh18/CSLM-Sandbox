page 50972 "SAP Requirement Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SAP Requirement Setup";
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                field(GPA; Rec.GPA)
                {
                    ApplicationArea = All;

                }
                field("Pace of Progression"; Rec."Pace of Progression")
                {
                    ApplicationArea = All;

                }
                field("Maximum Timeframe"; Rec."Maximum Timeframe")
                {
                    ApplicationArea = All;

                }

            }
        }
        area(Factboxes)
        {

        }
    }

}