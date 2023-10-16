page 50634 "Subject Goal List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Subject Goal";
    Caption = 'Subject Goal List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Code';
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description';
                }
                field("Goal Code"; Rec."Goal Code")
                {
                    ApplicationArea = All;
                    Caption = 'Goal Code';
                }
                field("Goal Description"; Rec."Goal Description")
                {
                    ApplicationArea = All;
                    Caption = 'Goal Description';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }


            }
        }
    }


}