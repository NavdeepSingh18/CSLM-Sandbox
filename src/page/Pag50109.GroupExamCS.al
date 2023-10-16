page 50109 "Group(Exam)-CS"
{
    // version V.001-CS

    Caption = 'Group(Exam)-CS';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Sessional Exam Group-CS";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field("Exam Method Code"; Rec."Exam Method Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Maximum Marks"; Rec."Maximum Marks")
                {
                    ApplicationArea = All;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = All;
                }
                field("Applicable Exam"; Rec."Applicable Exam")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

