page 50768 "Faculty Wise Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Subject Faculty Category";
    Caption = 'Subject Wise Category List';
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
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Category Code';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    Caption = 'Category Description';
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