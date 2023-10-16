page 50014 "Attendance Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineAttendance)
            {
                ApplicationArea = All;
            }
            part(Activities; AttendanceRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }

            // part(Chart1; "Course Wise Student Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }
            // part(Chart2; "Semester Wise Student Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }
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
        }
    }

    actions
    {
        area(Sections)
        {
            group("Registrar")
            {
                group("Student Details")
                {
                    action("Student List")
                    {
                        RunObject = Page "Student Details-CS";//50296
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Registrar Master")
            {
                action("Academic Department List")
                {
                    RunObject = Page "Academic Department List"; //(50687, List)
                    ApplicationArea = Basic, Suite;
                }
                action("User Group List")
                {
                    RunObject = Page "Workflow User Groups";
                    ApplicationArea = Basic, Suite;
                }
                action("Withdrawal Department List")
                {
                    RunObject = Page "Withdrawal Department List";//(50591,List)
                    RunPageLink = "Document Type" = filter(Withdrawal | "Withdrawal CLN");
                    ApplicationArea = Basic, Suite;
                }
                action("Leaves Department List")
                {
                    RunObject = Page "Withdrawal Department List";//(50591,List)
                    RunPageLink = "Document Type" = filter(<> Withdrawal & <> "Withdrawal CLN");
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Withdrawal")
            {
                group("Withdrawal Periodic Activities")
                {

                    // action("Pending College Withdrawal Approval List")
                    // {
                    //     RunObject = Page "Pending College Withdrawal";//50858
                    //                                                   // RunPageLink = Status = FILTER("Pending for Approval");
                    //     RunPageView = where(Status = FILTER("Pending for Approval"));
                    //     ApplicationArea = Basic, Suite;
                    // }
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
                        RunObject = page "Approved College Withdrawal";//50594
                        RunPageView = where("Withdrawal Status" = FILTER(Approved));
                        ApplicationArea = Basic, Suite;
                    }
                    action("Rejected College Withdrawal List")
                    {
                        RunObject = page "Approved College Withdrawal";//50594
                        RunPageView = where("Withdrawal Status" = FILTER(Rejected));
                        ApplicationArea = Basic, Suite;
                    }// to check

                }
            }
            group("Leave of Absence")
            {
                group("Leave Periodic Activity")
                {
                    // action("Pending ELOA Application List")
                    // {
                    //     RunObject = page "Pending Leaves Approvals";//50719
                    //     RunPageView =  WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(ELOA));
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Pending CLOA Application List")
                    // {
                    //     RunObject = page "Pending Leaves Approvals";//50719
                    //     RunPageView = WHERE(Status = FILTER("Pending for Approval"), "Type of Leaves" = filter(CLOA));
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                group("Approved/Rejected Leaves")
                {
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