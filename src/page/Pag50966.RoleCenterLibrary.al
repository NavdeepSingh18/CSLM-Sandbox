page 50966 "Library Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineLibrary)
            {
                ApplicationArea = All;
            }
            part(Activities; LibraryRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
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
            part(Chart; "Leave Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            // part("Students"; "Student Detail ListPart")
            // {
            //     Caption = 'Students';
            //     ApplicationArea = Basic, Suite;
            // }
            // part(Course; "Course Detail")
            // {
            //     Caption = 'Course';
            //     ApplicationArea = Basic, Suite;
            // }
            // systempart(Control1901377608; MyNotes)
            // {
            //     Caption = 'My Notes';
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }

    actions
    {
        area(Sections)
        {
            group("Academics")
            {
                group("Student Details")
                {
                    action("Student List")
                    {
                        RunObject = Page "Student Details-CS"; //(50296, List)
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Withdrawal")
            {
                group("Withdrawal Periodic Activities")
                {
                    action("College Withdrawal Application Form")
                    {
                        RunObject = Page "Stud. College Withdrawal List";
                        ApplicationArea = Basic, Suite;
                        visible = false;
                    }
                    action("Course Withdrawal Application Form")
                    {
                        RunObject = Page "Stud. Course Withdrawal List";
                        ApplicationArea = Basic, Suite;
                        visible = false;
                    }

                    action("Pending College Withdrawal Approval List")
                    {
                        RunObject = Page "Pending College Withdrawal";//50858
                        RunPageLink = Status = FILTER("Pending for Approval");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Course Withdrawal Approval List")
                    {
                        RunObject = Page "Pending Withdrawal Approvals"; // 50592
                                                                         // RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal");
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Withdrawal Approved Reject Applications")
                {
                    action("Approved College Withdrawal List")
                    {
                        RunObject = Page "Approved College Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Approved);
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    action("Rejected College Withdrawal List")
                    {
                        RunObject = Page "Approved College Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                        visible = false;
                    }
                    action("Approved Course Withdrawal List")
                    {
                        RunObject = Page "Approved Course Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Approved);
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    action("Rejected Course Withdrawal List")
                    {
                        RunObject = Page "Approved Course Withdrawal";
                        RunPageLink = "Withdrawal Status" = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                    }
                    action("Approved College Department Withdrawal List")
                    {
                        RunObject = page "Approved College Department";//50975
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Course Department Withdrawal List")
                    {
                        RunObject = page "Approved Course Department";//50974
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected College Withdrawal List")
                    {
                        RunObject = page "Approved College Withdrawal";//50594
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Course Withdrawal List")
                    {
                        RunObject = page "Approved Course Withdrawal";//50593
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Leaves of Absence")
            {
                group("Leave Periodic Activities")
                {
                    action("Pending ELOA Application List")
                    {
                        RunObject = page "Pending Leaves Approvals";//50719
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(ELOA));
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Leaves")
                {
                    action("Approved ELOA Application")
                    {
                        RunObject = Page "Approved Rejected Leave List";//50528
                        RunPageView = where(status = filter(Approved), "Leave Types" = filter(ELOA));
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }
}