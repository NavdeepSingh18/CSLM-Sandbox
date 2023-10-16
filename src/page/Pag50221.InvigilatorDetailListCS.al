page 50221 "Invigilator Detail List-CS"
{
    // version V.001-CS

    PageType = List;
    SourceTable = "Invigilator Summary-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Doc No."; Rec."Doc No.")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Room Alloted No."; Rec."Room Alloted No.")
                {
                    ApplicationArea = All;
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 1"; Rec."Invigilator 1")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 2"; Rec."Invigilator 2")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 3"; Rec."Invigilator 3")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 4"; Rec."Invigilator 4")
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
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Schedule No."; Rec."Exam Schedule No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

