page 50822 "Clinical Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; "Headline RC Team Member")
            {
                ApplicationArea = All;
            }
            part(Activities; "RoleCenterCuepage")
            {
                ApplicationArea = Basic, Suite;
            }
            //SD-SN-04-Dec-2020 +
            // part(Chart1; "Course Wise Student Chart")
            // {
            //     ApplicationArea = Basic, suite;
            //     Visible = true;
            // }
            // part(Chart2; "Semester Wise Student Chart")
            // {
            //     ApplicationArea = Basic, suite;
            //     Visible = true;
            // }
            //SD-SN-04-Dec-2020 -
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            systempart(Control1901377608; MyNotes)
            {
                Caption = 'My Notes';
                ApplicationArea = Basic, Suite;
            }
        }
    }
}