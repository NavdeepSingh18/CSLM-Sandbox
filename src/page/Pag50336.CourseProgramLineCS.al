page 50336 "Course Program Line -CS"
{
    // version V.001-CS

    Caption = 'Course Program Line -CS';
    PageType = ListPart;
    SourceTable = "Syllabus Course Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = ALl;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = ALl;
                }
                field("Chapter Code"; Rec."Chapter Code")
                {
                    ApplicationArea = ALl;
                }
                field("Chapter Name"; Rec."Chapter Name")
                {
                    ApplicationArea = ALl;
                }
                field("No of Hours"; Rec."No of Hours")
                {
                    ApplicationArea = ALl;
                }
            }
        }
    }

    actions
    {
    }
}

