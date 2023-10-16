page 50415 "Housing Group List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Housing Group";
    Caption = 'Housing Group';

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;

                }
                field("Group Name"; Rec."Group Name")
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

            }
        }
    }



    

}