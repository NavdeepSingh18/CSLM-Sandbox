page 50827 EmployeeListPart
{
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = Employee;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {

                }
                field("First Name"; Rec."First Name")
                {

                }
            }
        }

    }
}