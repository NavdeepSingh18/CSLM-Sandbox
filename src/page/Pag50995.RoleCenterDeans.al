page 50995 "Deans Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineDeans)
            {
                ApplicationArea = All;
            }
            part(Activities; DeansRoleCenterCuepage)
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
            part(Chart3; "Leave Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
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
            group("Registrar")
            {
                group("Registrar Master")
                {
                    action("Academic Department List")
                    {
                        RunObject = Page "Academic Department List";//50687
                        ApplicationArea = Basic, Suite;
                    }
                    action("User Group List")
                    {
                        RunObject = Page "Workflow User Groups";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Withdrawal Department List")
                    {
                        RunObject = Page "Withdrawal Department List";//50591
                        ApplicationArea = Basic, Suite;
                    }
                    action("Leaves Department List")
                    {
                        RunObject = Page "Withdrawal Department List";//50591
                        ApplicationArea = Basic, Suite;
                    }
                    action("Course Degree")
                    {
                        RunObject = Page "Temp Course Degree List";//50750
                        ApplicationArea = Basic, Suite;
                    }
                    action("Honors")
                    {
                        RunObject = Page "Honors";//50784
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Student Details")
                {
                    action("Student List")
                    {
                        RunObject = Page "Student Details-CS";//50296
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Honors")
                    {
                        RunObject = Page "Student Honors";//50785
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Degree")
                    {
                        RunObject = Page "Student Degree";//50782
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
                                                                      // RunPageLink = Status = FILTER("Pending for Approval");
                        RunPageView = where(Status = FILTER("Pending for Approval"));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending Course Withdrawal Approval List")
                    {
                        RunObject = Page "Pending Withdrawal Approvals"; // 50592
                                                                         // RunPageLink = "Type of Withdrawal" = filter("Course-Withdrawal");
                        ApplicationArea = Basic, Suite;
                        Visible = false;
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
                        Visible = false;
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
                        Visible = false;
                    }

                }
            }
            group("Leave of Absence")
            {
                group("Leave Periodic Activities")
                {
                    action("Pending SLOA Application List")
                    {
                        RunObject = page "Pending Leaves Approvals";//50719
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(SLOA));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending ELOA Application List")
                    {
                        RunObject = page "Pending Leaves Approvals";//50719
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(ELOA));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending CLOA Application List")
                    {
                        RunObject = page "Pending Leaves Approvals";//50719
                        RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(CLOA));
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Leaves")
                {
                    action("Approved Departmentwise SLOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(SLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Departmentwise ELOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Departmentwise CLOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(CLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected SLOA Application")
                    {
                        RunObject = Page "Approved Rejected Leave List";//50528
                        RunPageView = where("Leave Types" = filter(SLOA));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected ELOA Application")
                    {
                        RunObject = Page "Approved Rejected Leave List";//50528
                        RunPageView = where("Leave Types" = filter(ELOA));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected CLOA Application")
                    {
                        RunObject = Page "Approved Rejected Leave List";//50528
                        RunPageView = where("Leave Types" = filter(CLOA));
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }
}