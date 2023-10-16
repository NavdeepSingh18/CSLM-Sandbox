page 51015 "University HC"
{ //CSPL-00307 - Insurance Waiver
    PageType = RoleCenter;
    Caption = 'University Health Center Role Center';
    layout
    {
        area(RoleCenter)
        {
            part(Part1; UinversityHCHeadline)
            {
                ApplicationArea = All;
            }
            part(Activities; UniversityHCCue)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }

            part(Chart1; "Course Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Chart2; "Semester Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            part("Students"; "Student Detail ListPart")
            {
                Caption = 'Students';
                ApplicationArea = Basic, Suite;
            }
            part(Course; "Course Detail")
            {
                Caption = 'Course';
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                Caption = 'My Notes';
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group("Student Details")
            {
                action("Student List")
                {
                    RunObject = Page "Student Details-CS"; //(50296, List)
                    ApplicationArea = Basic, Suite;
                }
            }
            Group("Insurance Waiver Documents")
            {
                action("Pending Insurance Waiver List")
                {
                    RunObject = Page "Pending Insurance Waiver List";
                    RunPageLink = Status = filter(" " | Pending);
                    ApplicationArea = Basic, Suite;
                    RunPageView = where(Status = filter(" " | Pending));
                }

                action("Approved Insurance Waiver List")
                {
                    RunObject = Page "Pending Insurance Waiver List";
                    RunPageLink = Status = filter(Approved);
                    ApplicationArea = Basic, Suite;
                    RunPageView = where(Status = filter(Approved));
                }

                action("Rejected Insurance Waiver List")
                {
                    RunObject = Page "Pending Insurance Waiver List";
                    RunPageLink = Status = filter(Rejected);
                    ApplicationArea = Basic, Suite;
                    RunPageView = where(Status = filter(Rejected));
                }
            }
        }
    }
}