page 50687 "Academic Department List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Department;
    Caption = 'Academic Deparment List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department Name';
                }
                field("Department Email"; Rec."Department Email")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}