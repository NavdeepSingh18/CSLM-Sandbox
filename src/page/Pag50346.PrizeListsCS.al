page 50346 "Prize Lists-CS"
{
    // version V.001-CS

    PageType = ListPart;
    SourceTable = "Award Line-CS";
    caption='Prize Lists';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Fee Generated"; Rec."Fee Generated")
                {
                    ApplicationArea = All;
                }
                field("Generate Admit Card"; Rec."Generate Admit Card")
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

