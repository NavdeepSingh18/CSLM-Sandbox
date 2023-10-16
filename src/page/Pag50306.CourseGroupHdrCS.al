page 50306 "Course Group Hdr-CS"
{
    // version V.001-CS

    Caption = 'Course Group Hdr-CS';
    PageType = Card;
    SourceTable = "Course Group Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
            part("Course Group SubPage-CS"; 50307)
            {
                ApplicationArea = All;
                SubPageLink = "Course Code" = FIELD("Course"),
                              "Group Code" = FIELD("Group Code"),
                              "Academic Year" = FIELD("Academic Year");
            }
        }
    }

    actions
    {
    }
}

