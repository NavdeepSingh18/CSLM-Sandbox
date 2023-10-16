page 50810 "Registrar Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineRegistrar)
            {
                ApplicationArea = All;
            }
            part(Activities; RegistrarRoleCenterCuepage)
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
            //     ApplicationArea = basic, suite;
            //     Visible = true;
            // }


            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }
            part("Students"; "Student Detail")
            {
                Caption = 'Students';
                ApplicationArea = Basic, Suite;
            }
            // part(EmplyeeList; EmployeeListPart)
            // {
            //     caption = 'Employee List';
            //     ApplicationArea = Basic, Suite;
            // }


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

            group("Financial Aid")
            {
                action("Pending Financial Aid Applications")
                {
                    RunObject = Page "50652";
                    ApplicationArea = Basic, Suite;
                }
                action("Approved/Rejected Pending Financial Aid Applications")
                {
                    RunObject = Page "50653";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Withdrawal")
            {
                action("Pending Withdrawal Approvals List")
                {
                    RunObject = page "50231";
                    ApplicationArea = Basic, Suite;
                }
                action("Approved Withdrawal Approvals")
                {
                    RunObject = page "50592";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Time Table")
            {
                group("Time Table Master")
                {
                    action("Time Slot List")
                    {
                        RunObject = Page "50258";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Time Table Template List")
                    {
                        RunObject = page "50005";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Subject Group List")
                    {
                        RunObject = page "50225";
                        ApplicationArea = basic, suite;
                    }
                    action("Time Table Room List")
                    {
                        RunObject = page "50139";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("TimeTable Periodic Activites")
                {
                    action("Time Table Template")
                    {
                        RunObject = page "50259";
                        ApplicationArea = Basic, suite;
                    }
                    action("Time Table Header List")
                    {
                        RunObject = page "50262";
                        ApplicationArea = Basic, suite;
                    }
                    action("Time Table List")
                    {
                        RunObject = page "50281";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("TimeTabe Report")
                {
                    // action("Faculty Workload")
                    // {
                    //     ////RunObject = Report "";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Attendance Summary")
                    {
                        RunObject = report "50087";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Summary(<75)")
                    {
                        RunObject = report "50088";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Attendance Day Wise")
                    {
                        RunObject = report "50089";
                        ApplicationArea = Basic, Suite;
                    }
                    action("TimeTable Report")
                    {
                        RunObject = report "50015";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Details of Event")
                    {
                        RunObject = page "50405";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Student Promotion")
                {
                    action("Student Promotion List")
                    {
                        RunObject = page "50052";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group("Academics")
            {
                group("Academics Setup")
                {
                    action("Academic Setup")
                    {
                        RunObject = page "50163";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Education Setup")
                    {
                        RunObject = page "50223";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academic Master")
                {
                    action("Course List")
                    {
                        RunObject = page "50291";
                        ApplicationArea = basic, suite;
                    }
                    action("User Group")
                    {
                        RunObject = page "50267";
                        ApplicationArea = basic, suite;
                    }
                    action("Semester List")
                    {
                        RunObject = page "50166";
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Master List")
                    {
                        RunObject = page "50298";
                        ApplicationArea = basic, suite;
                    }
                    action("Year Master List")
                    {
                        RunObject = page "50055";
                        ApplicationArea = basic, suite;
                    }
                    action("Event Master")
                    {
                        RunObject = page "50119";
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Type")
                    {
                        RunObject = page "50002";
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Classification List")
                    {
                        RunObject = page "50003";
                        ApplicationArea = basic, suite;
                    }
                    action("Education Calendar List")
                    {
                        RunObject = page "50022";
                        ApplicationArea = basic, suite;
                    }
                    action("Academic Year Master")
                    {
                        RunObject = page "50033";
                        ApplicationArea = basic, suite;
                    }
                    action("Room List")
                    {
                        RunObject = page "50139";
                        ApplicationArea = basic, suite;
                    }
                    action("Employee List")
                    {
                        RunObject = page "Employee List";// To check
                        ApplicationArea = basic, suite;
                    }
                    action("Graduation List")
                    {
                        RunObject = page "50293";
                        ApplicationArea = basic, suite;
                    }
                    action("Section Master List")
                    {
                        RunObject = page "50032";
                        ApplicationArea = basic, suite;
                    }
                    action("Course Subject List")
                    {
                        RunObject = page "50174";
                        ApplicationArea = basic, suite;
                    }
                    action("Course Wise Faculty")
                    {
                        RunObject = page "50059";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Subject List")
                    {
                        RunObject = page "50001";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Optional Subject List")
                    {
                        RunObject = page "50004";
                        ApplicationArea = basic, suite;
                    }
                    action("Student List")
                    {
                        RunObject = page "50296";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Branch Transfer List")
                    {
                        RunObject = page "50270";
                        ApplicationArea = basic, suite;
                    }
                }
                group("Academic Lists")
                {
                    action("Student Section & Roll No List")
                    {
                        RunObject = page "50138";
                        ApplicationArea = basic, suite;
                    }

                    action("Guardian Teacher List")
                    {
                        RunObject = page "50112";
                        ApplicationArea = basic, suite;
                    }
                    // action("Revaluation List")
                    // {
                    //     RunObject = page "50014";
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Student Registration List")
                    // {
                    //     RunObject = page "50016";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Student Registration & Immigration List")
                    {
                        RunObject = page "50034";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Immigration Upload Document List")
                    {
                        RunObject = page "50535";
                        ApplicationArea = basic, suite;
                    }
                    action("Portal User list")
                    {
                        RunObject = page "50040";
                        ApplicationArea = basic, suite;
                    }
                    action("Attendance Student List")
                    {
                        RunObject = page "50010";
                        ApplicationArea = basic, suite;
                    }
                    action("Compilation Course Withdrawal List")
                    {
                        RunObject = page "50231";
                        ApplicationArea = basic, suite;
                    }
                    action("Event Menu Availability Mapping")
                    {
                        RunObject = page "50177";
                        ApplicationArea = basic, suite;
                    }
                    // action("Student All Subject Old Data")
                    // {
                    //     RunObject = page "50080";
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Student Rank List")
                    // {
                    //     RunObject = page "50075";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Student Withdrawal List")
                    {
                        RunObject = page "50030";
                        ApplicationArea = basic, suite;
                    }
                    action("Achievement/Incident List")
                    {
                        RunObject = page "50035";
                        ApplicationArea = basic, suite;
                    }
                    action("Attendance Request List")
                    {
                        RunObject = page "50079";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Subject batch Update")
                    {
                        RunObject = page "50187";
                        ApplicationArea = basic, suite;
                    }
                }
                group("Application Certificate List")
                {
                    action("Application Certificate")
                    {
                        RunObject = page "50081";
                        ApplicationArea = basic, suite;
                    }
                    action("Application Certificate(Applied) ")
                    {
                        RunObject = page "50072";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Academics Report")
                {
                    action("AICASA Students 06-18-20")
                    {
                        RunObject = Report "50182";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Semester 4 Students That Have Not Registered")
                    {
                        RunObject = Report "50179";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Fall 2020 Registration 06-25-20")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    action("Student Hold Status")
                    {
                        RunObject = Report "50166";
                        ApplicationArea = Basic, Suite;
                    }
                    action("AUABasicScienceIDCard.")
                    {
                        RunObject = Report "50168";
                        ApplicationArea = Basic, Suite;
                    }
                    action("AICASAIDCard")
                    {
                        RunObject = Report "50169";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("AUA5thSemesterIDCard")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA College of Medicine Official Transcript")
                    // {
                    //     RunObject = Report "50190";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA College of Medicine Official Transcript (Transfer Credit, Legacy Data)")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA College of Medicine KMCIC Official Transcript")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA School of Nursing Transcript")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA Transcript")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA BHHS Certificate")
                    // {
                    //     RunObject = Report "50187";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA Master of Health Science Degree")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AUA Doctor of Medicine Degree")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA Associate of Science in Health Science Degree")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA EMT- Basic Certificate")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("AICASA Associate of Science in Nursing Degree")
                    // {
                    //     //RunObject = Report "";
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
                group("Academic Periodic Activity")
                {
                    action("Student Promtion Process Report")
                    {
                        RunObject = report "50079";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Student Data Upload")
                    {
                        RunObject = page "50001";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Data Modification")
                    {
                        RunObject = page "50002";
                        ApplicationArea = basic, suite;
                    }
                    action("Course Wise Faculty Upload")
                    {
                        RunObject = page "50005";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Optional Subject Upload")
                    {
                        RunObject = page "50007";
                        ApplicationArea = basic, suite;
                    }
                    action("Student Subject Upload")
                    {
                        RunObject = page "50008";
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Master Upload")
                    {
                        RunObject = page "50058";
                        ApplicationArea = basic, suite;
                    }
                    // action("Teacher Guardian Upload")
                    // {
                    //     RunObject = page "50051";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Employee Upload")
                    {
                        RunObject = page "50012";
                        ApplicationArea = basic, suite;
                    }
                }
            }
            group("Evaluation")
            {
                action("Grade Allocation List")
                {
                    RunObject = page "50078";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Clinical Rotation")
            {
                action("Hospitals")
                {
                    runobject = page "50435";
                    ApplicationArea = basic, suite;
                }
                group("Core Rotation")
                {
                    action("Core Rotation History>>Confirmed Core Rotations")
                    {
                        runobject = page "50442";
                        ApplicationArea = basic, suite;
                    }
                    action("Core Rotation History>>Core Roster Ledger Entries")
                    {
                        runobject = page "50664";
                        ApplicationArea = basic, suite;
                    }
                }
                group("Elective Rotation")
                {
                    // action("Elective Rotation Transactions")
                    // {
                    //     //RunObject = page "";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Publish Elective Rotation")
                    {
                        RunObject = page "50473";
                        ApplicationArea = basic, suite;
                    }
                    // action("Elective Rotation History")
                    // {
                    //     //RunObject = page "";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Elective Rotation Ledger Entries")
                    {
                        RunObject = page "50459";
                        ApplicationArea = basic, suite;
                    }
                }
            }
            group("Examination")
            {
                group("Internal Periodic Activities")
                {
                    action("Publish Internal Marks")
                    {
                        RunObject = report "50072";
                        ApplicationArea = basic, suite;
                    }
                    action("Subject Maximum Marks Update Report")
                    {
                        RunObject = report "50008";
                        ApplicationArea = basic, suite;
                    }
                    action("Document ReTest Application List")
                    {
                        RunObject = page "50212";
                        ApplicationArea = basic, suite;
                    }
                    action("Employee Open Entry List")
                    {
                        RunObject = page "50020";
                        ApplicationArea = basic, suite;
                    }
                }
                group("External Periodic Activities")
                {
                    action("Invigilator Detail List")
                    {
                        RunObject = page "50221";
                        ApplicationArea = basic, suite;
                    }
                    action("Makeup & Special Exam List")
                    {
                        RunObject = page "50015";
                        ApplicationArea = basic, suite;
                    }
                    // action("Revaluation 1 List")
                    // {
                    //     RunObject = page "50014";
                    //     ApplicationArea = basic, suite;
                    // }
                    // action("Revaluation 2 List")
                    // {
                    //     RunObject = page "50189";
                    //     ApplicationArea = basic, suite;
                    // }
                    action("Publish External Marks Report")
                    {
                        RunObject = report "50013";
                        ApplicationArea = basic, suite;
                    }
                    action("Malpractice Level List")
                    {
                        RunObject = page "50161";
                        ApplicationArea = basic, suite;
                    }
                }
            }
            group("Housing")
            {
                group("Housing Periodic Activities")
                {
                    action("Housing Applicaton")
                    {
                        RunObject = Page "50421";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Housing List")
                {
                    action("Approved/Rejected Housing Application")
                    {
                        RunObject = Page "Posted Housing Application";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Approved/Rejected Change Request")
                    // {
                    //     RunObject = page "Approve Reject Housing Change";
                    //     RunPageLink = type = filter("Change Request");
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Approved/Rejected Vacate Request")
                    // {
                    //     RunObject = page "Approve Reject Housing Change";
                    //     RunPageLink = type = filter(Vacate);
                    //     ApplicationArea = Basic, Suite;
                    // }
                    // action("Approved/Rejected Re-Registration Request")
                    // {
                    //     RunObject = page "Approve Reject Housing Change";
                    //     RunPageLink = type = filter("Re-Registration");
                    //     ApplicationArea = Basic, Suite;
                    // }

                    action("Approved/Rejected Financial Accountability")
                    {
                        RunObject = Page "Approve/Reject Fin Account";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Housing Waiver List")
                    {
                        RunObject = Page "Housing Wavier Approved List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Immigration List")
                    {
                        RunObject = Page "Immigration Approved list";
                        ApplicationArea = Basic, Suite;
                    }
                    // action("Rejected Housing Issue List")
                    // {
                    //     RunObject = Page "Closed Housing Issue List";
                    //     RunPageLink = Status = filter(Rejected);
                    //     ApplicationArea = Basic, Suite;
                    // }
                }
            }
            group("Leave Of Absence")
            {
                group("Leave Periodic Activity")
                {
                    action("Pending SLOA Application List")
                    {
                        RunObject = Page "50719";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending ELOA Application List")
                    {
                        RunObject = Page "50719";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pending CLOA Application List")
                    {
                        RunObject = Page "50719";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Approved/Rejected Leaves")
                {
                    action("Approved SLOA Application Leave List")
                    {
                        RunObject = Page "50528";
                        RunPageLink = "Leave Types" = filter(SLOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved ELOA Application Leave List")
                    {
                        RunObject = Page "50528";
                        RunPageLink = "Leave Types" = filter(ELOA);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved CLOA Application Leave List")
                    {
                        RunObject = Page "50528";
                        RunPageLink = "Leave Types" = filter(CLOA);
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }
}