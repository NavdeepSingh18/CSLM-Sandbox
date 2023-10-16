page 50533 "Hold User Mapping List"
{

    PageType = List;
    SourceTable = "Holds User Mapping";
    Caption = 'Hold User Mapping List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hold Code"; Rec."Hold Code")
                {
                    ApplicationArea = All;
                }
                field("Hold Description"; Rec."Hold Description")
                {
                    ApplicationArea = All;
                }
                field("Hold Type"; Rec."Hold Type")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
