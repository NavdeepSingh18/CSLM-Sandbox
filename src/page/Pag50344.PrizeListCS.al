page 50344 "Prize List-CS"
{
    // version V.001-CS

    CardPageID = "Prize List Hdr -CS";
    PageType = List;
    SourceTable = "Award Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Prize List';
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
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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

