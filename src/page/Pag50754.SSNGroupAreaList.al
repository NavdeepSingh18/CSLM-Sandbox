page 50754 "SSN Group Area List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SSN Group Area Code";
    Caption = 'SSN Group Area List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Area Code"; Rec."Area Code")
                {
                    ApplicationArea = All;
                }

            }
        }
    }


}