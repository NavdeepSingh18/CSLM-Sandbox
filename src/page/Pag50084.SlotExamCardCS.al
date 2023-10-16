page 50084 "Slot(Exam) Card-CS"
{
    // version V.001-CS

    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Examination Time Slot-CS";
    Caption = 'Slot(Exam) Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = All;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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

