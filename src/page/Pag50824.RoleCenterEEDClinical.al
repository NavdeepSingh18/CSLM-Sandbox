page 50824 "EED Clinical Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineClinical)
            {
                ApplicationArea = All;
            }
            part(Activities; ClinicalRoleCenterCuepg)
            {
                ApplicationArea = Basic, Suite;
            }
            //SD-SN-04-Dec-2020 +
            part(Chart1; "Semester Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Chart2; "Course Wise Student Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Chart3; "Core Rotation Wise Stud Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
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

            group("Academics Information")
            {
                action("Student List")
                {
                    RunObject = page "Student Details-CS";//50296
                    ApplicationArea = Basic, Suite;
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
            }
            group(Documentation)
            {
                action("Document Category")
                {
                    RunObject = page "Doc. Attachment-CS";//50024
                    ApplicationArea = Basic, Suite;
                }
                action("Documents Upload Section")
                {
                    RunObject = page "Attachment(Other)-CS";//50027
                    ApplicationArea = Basic, Suite;
                }
                group("Document Received")
                {
                    action("Pending Documents")
                    {
                        RunObject = page "Attachment Stud Wise-CS";//50026
                        RunPageLink = Status = Filter(Pending);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Documents")
                    {
                        RunObject = page "Attachment Stud Wise-CS";//50026
                        RunPageLink = Status = Filter(Approved | Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Advising Module")
            {
                Group(Masters)
                {
                    action("Advising Topic List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Advising Topic List';
                        RunObject = page "Advising Topics List";// 50790
                        // RunPageLink = "Department Type" = filter("EED Clinical");
                    }
                    action("Reason Program List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reason Program List';
                        RunObject = page "Reason Program List";// 50839
                        // RunPageLink = "Department Type" = filter("EED Clinical");
                        Visible = false;
                    }
                    action("Topic List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Topic List';
                        RunObject = page "Topics List";// 51019
                        Visible = false;
                    }
                    action("Problem Solution List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Problem Solution List';
                        RunObject = page "Problem Solution List";//50800
                        Visible = false;
                    }
                }
                group("Advising Request")
                {
                    action("Pending Advising Request")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Walk-In Request';
                        RunObject = page "Advising Request List";//50846
                    }
                    action("Approved/ Rescheduled Advising Request List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Confirmed Advising Request';
                        RunObject = page "App. Resch. Advs. Request List";//51016
                    }
                    action("Completed/Rejected Advising Request List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Completed/Cancelled Request';
                        RunObject = page "Rejc. Comp. Advis. Req. List";//51017
                    }
                }

            }
            group("Site Visit ")
            {
                Group("Site Visit")
                {
                    action("Site Visit List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Site Visit List';
                        RunObject = page "Site Visit List";// 51014
                    }
                }
            }
            group("FM1/IM1")
            {
                // group("Scheduling")
                // {
                //     action("FM1/IM1 Rotation Publishing")
                //     {
                //         // Runobject = page ;
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
                // group("Approvals")
                // {
                //     // action("Site Selection Approval")
                //     // {
                //     //     // Runobject = page ;
                //     //     ApplicationArea = Basic, Suite;
                //     // }
                //     // action("Special Accommodation Approval")
                //     // {
                //     //     // Runobject = page ;
                //     //     ApplicationArea = Basic, Suite;
                //     // }
                // }
                group("History")
                {
                    action("Confirmed Preset Date List")
                    {
                        Runobject = page "FM1_IM1 Date Preset LST+";//50495
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Approved Site Selection Application")
                    // {
                    //     // Runobject = page ;
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("FM1/IM1 Rosters")
                    {
                        Runobject = page "FM1_IM1 Roster LST+";//50500
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Core Rotation")
            {
                group("Hist.")
                {
                    Caption = 'History';
                    action("Confirmed Core Rotation List")
                    {
                        Runobject = page "Confirm Roster Schedule List";//50442
                        ApplicationArea = Basic, Suite;
                    }
                    action("Core Rotation Ledger")
                    {
                        Runobject = page "FM1_IM1 Hospital Inventory";//50447
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Elective Rotation")
            {
                group("Sched.")
                {
                    Caption = 'Scheduling';
                    action("Elective Rotation Offers")
                    {
                        ApplicationArea = Basic, Suite;
                        Runobject = page "Rotation Offer List";//50602
                    }
                }
                group("Apprvls")
                {
                    Caption = 'Approvals';
                    action("Elective Rotation Application Approvals")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Rotation Appl Approval List";//50600
                    }
                    action("Non-Affiliated Application Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Non-Affiliated Site Apprvl LST";//50489
                    }
                }
                group("Histo.")
                {
                    Caption = 'History';
                    action("Elective Rotation Offer list")
                    {
                        RunObject = page "Rotation Offer List+";//50606
                        ApplicationArea = Basic, Suite;
                    }
                    action("Confirmed Elective Rotation List")
                    {
                        RunObject = page "Elective Rotation List";//50456
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved Non-Affiliated Applications")
                    {
                        RunObject = page "Non-Affiliated Site Aprved LST";//50491
                        ApplicationArea = Basic, Suite;
                    }
                    action("Elective Rotation Ledger")
                    {
                        RunObject = page "TWD Analysis";//50459
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Setup & Master")
            {
                action("Hospital")
                {
                    RunObject = page "Hospital List";//50435
                    ApplicationArea = Basic, Suite;
                }
                action("Rotation Inventory")
                {
                    RunObject = page "Hospital Inventory";//50438
                    ApplicationArea = Basic, Suite;
                }
                action("Contact")
                {
                    RunObject = page "Contact List";//5052
                    ApplicationArea = Basic, Suite;
                }
            }
            Group("Broadcast Email")
            {
                action("Broadcast Email Template List")
                {
                    RunObject = page IntershipCSList;//51032
                    ApplicationArea = Basic, Suite;
                    RunPageLink = "Department Type" = const("EED Clinical");
                }
                action("Broadcast Email ")
                {
                    RunObject = page "Broadcast E-Mail";//50977
                    ApplicationArea = Basic, Suite;
                }
            }
            // group("Reports")
            // {
            // action("Clinical Hospital Rosters")
            // {
            //     // RunObject = page;
            //     ApplicationArea = Basic, Suite;
            // }
            // action("Clinical Hospital Roster Delta")
            // {
            //     // RunObject = page;
            //     ApplicationArea = Basic, Suite;
            // }
            // action("Clinical Student On Registration Holds")
            // {
            //     // RunObject = page;
            //     ApplicationArea = Basic, Suite;
            // }
            // action("Missing Cores")
            // {
            //     // RunObject = page;
            //     ApplicationArea = Basic, Suite;
            // }
            // action("Total Weeks Less Than Curriculum")
            // {
            //     // RunObject = page;
            //     ApplicationArea = Basic, Suite
            // }
            // }
        }
    }
}