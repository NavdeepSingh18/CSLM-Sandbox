page 50823 "EED Pre- Clinical Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHdlnEEDBasicScience)
            {
                ApplicationArea = All;
            }
            part(Activities; EEDBscScncRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Pending Advising Request"; "Pend. Advng. Request Listpart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part("Approved Advising Request"; "Approved Advsing Req. ListPart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }

            //SD-SN-04-Dec-2020 +
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
                Visible = true;
            }
            part(Chart4; "Compd. Rej. Monnth wise")
            {
                ApplicationArea = Basic, Suite;
                Visible = True;
            }

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
    actions
    {
        area(Sections)
        {
            group("Advising Masters")
            {
                Action("Request Reason/Program List")
                {
                    RunObject = page "Reason Program List";//50839
                    // RunPageLink = "Department Type" = filter("EED Pre-Clinical");
                    ApplicationArea = Basic, Suite;
                }
                action("Advising Topics List")
                {
                    RunObject = page "Advising Topics List";//50790
                    // RunPageLink = "Department Type" = filter("EED Pre-Clinical");
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                action("Topic List")
                {
                    RunObject = page "Topics List";
                    ApplicationArea = Basic, Suite;
                    Visible = False;
                }
                Action("Problem Solution List")
                {
                    RunObject = Page "Problem Solution List";
                    ApplicationArea = Basic, Suite;
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
            group("Advising Request")
            {
                action("Pending Advising Request List")
                {
                    RunObject = page "Advising Request List";//50846
                    // RunPageLink = "Department Type" = filter("EED Pre-Clinical"), "Request Status" = filter(Pending);
                    Caption = 'Pending / Walk-in Advising Request List';
                    ApplicationArea = Basic, Suite;
                }
                action("Approved/ Rescheduled Advising Request List")
                {
                    RunObject = page "App. Resch. Advs. Request List";//51016
                    ApplicationArea = Basic, Suite;
                    // RunPageLink = "Department Type" = filter("EED Pre-Clinical"), "Request Status" = filter(Approved);
                }
                action("Completed/Rejected Advising Request List")
                {
                    RunObject = page "Rejc. Comp. Advis. Req. List";//51017
                    ApplicationArea = Basic, Suite;
                    // RunPageLink = "Department Type" = filter("EED Pre-Clinical"), "Request Status" = filter(Completed | Rejected);
                }
            }
            group("Medical Scholars")
            {
                /* action("Medical Scholars List")
                 {
                     RunObject = page "Medical Scholars List";//51027
                     ApplicationArea = Basic, Suite;
                     RunPageLink = Status = filter("Pending for Approval");
                 }
                 action("Medical Scholars Program List")
                 {
                     RunObject = page "Medical Scholar Program List";//50847
                     ApplicationArea = Basic, Suite;
                     RunPageLink = "Application Status" = filter(Approved);
                 } */
                action("Pending Medical Scholars Program List")
                {
                    RunObject = page "Pending Medical Scholars";
                    ApplicationArea = Basic, Suite;
                }
                action("Approved Medical Scholars Program List")
                {
                    RunObject = page "Approved Medical Scholars";
                    ApplicationArea = Basic, Suite;
                    RunPageLink = "Application Status" = filter(Approved);
                }
                action("Selected/ Not Selected Medical Scholar Program List")
                {
                    RunObject = page "Selected Medical Program List";//50847
                    ApplicationArea = Basic, Suite;
                    RunPageLink = "Application Status" = filter(Selected | NotSelected);
                }
                action("Suspended/ Rejected Medical Scholar Program List")
                {
                    RunObject = page "Suspended/Rejected/Not";//50847
                    ApplicationArea = Basic, Suite;
                    RunPageLink = "Application Status" = filter(Suspended | Rejected);
                }
                action("Interview Confirmed List")
                {
                    RunObject = page "Interview Confirmed";
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    RunPageLink = "Application Status" = filter("Interview Confirmed");
                }
            }
            Group("Broadcast Email")
            {
                action("Broadcast Email Template List")
                {
                    RunObject = page IntershipCSList;//51032
                    ApplicationArea = Basic, Suite;
                    RunPageLink = "Department Type" = const("EED Pre-Clinical");
                }
                action("Broadcast Email ")
                {
                    RunObject = page "Broadcast E-Mail";//50977
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Academics")
            {
                action("Student List")
                {
                    RunObject = Page "Student Details-CS"; //50296
                    ApplicationArea = Basic, Suite;
                }
                action("Student Subject List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Subject Student-CS";//50001
                }
                action("Student Exam List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Student Subject Exam List";//50956
                }

                action("Enrollment History")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Enrollment History List";
                }
                action("Student Educational Qualification")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Qualifying Detail Stud List-CS";
                }
                action("Student Subject Grade Book List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page StudentSubjectGradeBookList;
                }
                action("Student Notes List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student Notes List";
                }
                Action("Grade Book List")
                {
                    ApplicationArea = All;
                    Runobject = Page GradeBookSubform;
                }
                action("Student Group")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Student Group";
                }
                Action("Student Group Details")
                {
                    ApplicationArea = all;
                    RunObject = Page "Student Group Detail";
                }
                action("Groups")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page Group;
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
                        Visible = False;
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

                    action("Approved/Rejected College Withdrawal List")
                    {
                        RunObject = page "Approved College Withdrawal";//50594
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Course Department Withdrawal List")
                    {
                        RunObject = page "Approved Course Department";//50974
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    action("Approved/Rejected Course Withdrawal List")
                    {
                        RunObject = page "Approved Course Withdrawal";//50593
                        ApplicationArea = Basic, Suite;
                        Visible = False;
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
                    action("Approved Departmentwise ELOA Application Leave List")
                    {
                        RunObject = Page "Approved Departmentment Leave";        //50104
                        RunPageLink = status = filter(Approved | Rejected), "Type of Leaves" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                    }
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