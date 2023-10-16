page 50723 "Housing Wise Categorgy List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Room Master";
    Caption = 'Housing Wise Categorgy List';
    DelayedInsert = true;

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
                field("Maximum No. of Bed"; Rec."Maximum No. of Bed")
                {
                    ApplicationArea = All;

                }
                field("Available Beds"; Rec."Available Beds")
                {
                    ApplicationArea = All;

                }

            }
        }
    }

}