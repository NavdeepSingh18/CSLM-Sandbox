page 50902 "Room Listpart"
{
    PageType = listpart;
    UsageCategory = Administration;
    SourceTable = "Room Category Master";
    Caption = 'Apartment Category';

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Room Category Name"; Rec."Room Category Name")
                {
                    ApplicationArea = All;

                }
                field("Maximum No. of Bed"; Rec."Maximum No. of Bed")
                {
                    ApplicationArea = All;

                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Normal Capacity"; Rec."Normal Capacity")
                {
                    ApplicationArea = All;
                    Visible = false;

                }

            }
        }
    }

}
