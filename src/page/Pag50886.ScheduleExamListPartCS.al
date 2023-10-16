page 50886 "Schedule(Exam) List Part-CS"
{
    // version V.001-CS

    CardPageID = "Schedule(Exam) Hdr-CS";
    Editable = false;
    PageType = ListPart;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Exam Time Table Head-CS";

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
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
                field("Exam Method"; Rec."Exam Method")
                {
                    ApplicationArea = All;
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ApplicationArea = All;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field("Exam Classification"; Rec."Exam Classification")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}