page 50159 "Course Eval. Mark Detail-CS"
{
    // version V.001-CS

    Caption = 'Course Eval. Mark Detail-CS';
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Evaluation Course Header-CS";

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
                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Stage1 Selection List No."; Rec."Stage1 Selection List No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("C&ourse Eval.")
            {
                Caption = 'C&ourse Eval.';
                action("C&ard")
                {
                    Caption = 'C&ard';
                    Image = EditLines;
                    RunObject = Page 50175;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}