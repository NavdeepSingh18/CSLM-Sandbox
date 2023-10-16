page 50261 "Time Templt SubPage-CS"
{
    // version V.001-CS
    Caption = 'Time Templt SubPage-CS';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Time Table Template Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Time Slot"; Rec."Time Slot")
                {
                    ApplicationArea = All;
                }
                // field("Line No."; Rec."Line No.")
                // {
                //     ApplicationArea = All;
                // }
                // field(Interval; Rec.Interval)
                // {
                //     ApplicationArea = All;
                // }
                // field("Interval Type"; Rec."Interval Type")
                // {
                //     ApplicationArea = All;
                // }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = All;
                }
                // field(Elective; Rec.Elective)
                // {
                //     ApplicationArea = All;
                // }
                field(Day; Rec.Day)
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
                // Field(Section; Rec.Section)
                // {
                //     ApplicationArea = All;
                // }
                Field("No. of Labs"; Rec."No. of Labs")
                {
                    ApplicationArea = All;
                }
                Field(Occurance; Rec.Occurance)
                {
                    ApplicationArea = All;
                }
                Field("No. of Session"; Rec."No. of Session")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}

